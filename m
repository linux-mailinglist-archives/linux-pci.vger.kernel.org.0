Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA8267740
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 04:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgILC0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 22:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgILC0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 22:26:39 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39AFD221E5;
        Sat, 12 Sep 2020 02:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599877598;
        bh=r3wFX0LpY7ZVAQON3+nFwKWcc3XAWGyYlzMfqBrFylE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYIgCk0phdJ/66k6YsCtZ0OtmJQe7FUgte0K8X94gKoatRdmfAa9+yQBHVsL0DF/f
         CVMhdA09a6b22kgbZZeC6I5F5XROOAOdAEX1AyOFeDYKvvl0yVb+tqOwWqC7N8g6jO
         a2ye0+os/mXjo47HTxbeSmNIcQwR6Crxc1rLfhrk=
Date:   Fri, 11 Sep 2020 19:26:36 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
Message-ID: <20200912022636.GB3655346@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200904171325.64959-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904171325.64959-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 11:13:25AM -0600, Jon Derrick wrote:
> Some platforms have an AHCI controller behind VMD. These platforms are
> working correctly except for a case when the AHCI MSI is programmed with
> VMD IRQ vector 0 (0xfee00000). When programmed with any other interrupt
> (0xfeeNN000), the MSI is routed correctly and is handled by VMD. Placing
> the AHCI MSI(s) in the fast-interrupt allow list solves the issue.

The only reason we have the fast vs. slow is because of the non-posted
transactions from slow driver's interrupt handlers tanking performance
of the nvme devices sharing the same vector. The microsemi switchtec was
one of the first such devices identified that led to the current
split in the VMD domain. AHCI's driver also has non-posted transactions
in their interrupt handling, so you probably don't want those devices
sharing vectors with your fast nvme devices.
