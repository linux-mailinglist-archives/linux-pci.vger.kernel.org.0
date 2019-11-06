Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE1F1FDA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 21:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKFU1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 15:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfKFU1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 15:27:19 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B9F217D7;
        Wed,  6 Nov 2019 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573072038;
        bh=hlukqPbW46sxK1MBNcLzsk0WR8/hD6lWRkAmAjeMH8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+5CoD6ijQj7HQD0kh3Ge1/9sZA+4Ow1Kfq9z/WbXME1FY05Yorw6NJJyD4+Z2SZn
         XXfplemVRpcIkXOQMIT/wPOEm1v1+imS1jGl7Vs1gW9hXnTYR9juuH/KTPb0np7lc7
         puu3rdrS18kEs9853HSRyXMv8UKjUxbQBjwukrQk=
Date:   Thu, 7 Nov 2019 05:27:12 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Message-ID: <20191106202712.GA32215@redsun51.ssa.fujisawa.hgst.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
 <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
 <0a4a4151b56567f3c8ca71a29a2e39add6e3bf77.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4a4151b56567f3c8ca71a29a2e39add6e3bf77.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 08:14:41PM +0000, Derrick, Jonathan wrote:
> Yes that problem exists today 

Not really, because we're currently using unamanged interrupts which
migrate to online CPUs. It's only the managed ones that don't migrate
because they have a unchangeable affinity.

> and this set limits the exposure as it's
> a rare case where you have a child NVMe device with fewer than 32
> vectors.

I'm deeply skeptical that is the case. Even the P3700 has only 31 IO
queues, yielding 31 vectors for IO services, so that already won't work
with this scheme.

But assuming you wanted to only use devices that have at least 32 IRQ
vectors, the nvme driver also allows users to carve those vectors up
into fully affinitized sets for different services (read vs. write is
the one the block stack supports), which would also break if alignment
to the parent device's IRQ setup is required.
