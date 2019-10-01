Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC93C3435
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfJAM12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 08:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfJAM11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 08:27:27 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B196E205C9;
        Tue,  1 Oct 2019 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569932846;
        bh=mY7r6LAvTV9vLQ4H6IYUCqJQHFE0f5OS7vFMkDz27Hc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sCuUau3DU7rD8T8GQxXtt8Rbu/Ao1TIOZoKmZp+wwEX4chkBGBEuaO3/0/LtweXqg
         qkiSpTIKZbQ8BJq8o7Vu+XoHTYufFZpxKa7wh8dDNM+IZ1G4k9EC4hFSrkzUWOlrh+
         oSLMhinlGcDZJwP7TaGzVcvvnXcriMRMXKzZg+BA=
Date:   Tue, 1 Oct 2019 07:27:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] OF/PCI: Export inbound memory interface to PCI RC
 drivers.
Message-ID: <20191001122725.GA38028@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe084be-48ee-3005-e9e1-7fe03d4f406c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[-cc Oza, bounced]

On Mon, Sep 30, 2019 at 11:46:18PM +0200, Marek Vasut wrote:
> On 9/30/19 11:40 PM, Bjorn Helgaas wrote:
> > This would follow the convention for subject lines:
> > 
> >   PCI: OF: Add of_pci_get_dma_ranges() for inbound DMA restrictions
> > 
> > On Fri, Aug 09, 2019 at 07:34:48PM +0200 wrote:
> >> From: Oza Pawandeep
> >>
> >> The patch exports interface to PCIe RC drivers so that,
> >> Drivers can get their inbound memory configuration.
> > 
> > IIUC this interface (of_pci_get_dma_ranges()) is not used directly by
> > *drivers*; it is used by of_bus_pci_get_dma_ranges() in the next
> > patch, and it's called by the driver core via this path:
> > 
> >   really_probe
> >     pci_dma_configure                     # pci_bus_type.dma_configure
> >       of_dma_configure
> > 	of_dma_get_range
> > 	  bus->get_dma_ranges
> > 	    of_bus_pci_get_dma_ranges     # of_busses[0].get_dma_ranges
> > 	      of_pci_get_dma_ranges
> > 
> >> It provides basis for IOVA reservations for inbound memory
> >> holes, if RC is not capable of addressing all the host memory,
> >> Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
> >> could be allocated.
> >>
> >> It handles multiple inbound windows, and returns resources,
> >> and is left to the caller, how it wants to use them.
> > 
> > This should say exactly what the problem is, maybe even with a link to
> > a problem report.  I assume it is something like "RC <X> cannot
> > address all of host memory, and if we happen to allocate a buffer
> > that's not addressable, DMA to the buffer fails".  It'd be nice to
> > know what the failure looks like (SERR# asserted, panic, reboot, etc).
> 
> [...]
> 
> While it's good that someone finally looked at these patches, these were
> since superseded by the following series:
> https://patchwork.ozlabs.org/cover/1168166/

Good to know, thanks :)
