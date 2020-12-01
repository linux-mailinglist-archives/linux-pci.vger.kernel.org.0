Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04C2CAA76
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgLASFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 13:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbgLASFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 13:05:45 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0CD206E0;
        Tue,  1 Dec 2020 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606845905;
        bh=NDbqdi1dY0jePUs1m+Df4GZMk8/N7wk7RMYH342WSRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q+QSLRrNGaqVdwqvELVyoAGnIEyYdBsPIpCjKV1IQIOkHkOWQDY/Y3YmIWVeCAEx7
         4VxxBgWm+Vzx1qb04KtqjZ53ccfD++0XYOKCZNaQLsAd77DRr6bht1zzgNRrgaqbxr
         MwtPmSrB6KHkZNJ43lj7RDMTubHcIbz+xueWOiSQ=
Date:   Tue, 1 Dec 2020 12:05:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
Message-ID: <20201201180503.GA1321042@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130211145.3012-6-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 04:11:42PM -0500, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  This simple
> handler determines if the PCIe controller was the cause of the abort and if
> so, prints out diagnostic info.

What happens during enumeration?  pci_bus_generic_read_dev_vendor_id()
assumes a read of Vendor ID returns 0xffffffff if the device doesn't
exist.

I assume this case doesn't cause the abort you're referring to here,
or nothing would work.  I think this enumeration case results in PCIe
Unsupported Request errors (PCIe r5.0, sec 2.3.2 implementation note).

Bjorn
