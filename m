Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55562D9BF4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 17:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439386AbgLNQJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 11:09:38 -0500
Received: from foss.arm.com ([217.140.110.172]:49502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439348AbgLNQJ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 11:09:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459D130E;
        Mon, 14 Dec 2020 08:08:38 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A893F66B;
        Mon, 14 Dec 2020 08:08:37 -0800 (PST)
Date:   Mon, 14 Dec 2020 16:08:29 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Message-ID: <20201214160829.GA3623@e121166-lin.cambridge.arm.com>
References: <20201016120431.7062-1-marek.vasut@gmail.com>
 <20201210181133.GA3766@e121166-lin.cambridge.arm.com>
 <83135f6f-8a98-4537-0df5-91a06af07955@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83135f6f-8a98-4537-0df5-91a06af07955@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 12, 2020 at 08:13:54PM +0100, Marek Vasut wrote:
> On 12/10/20 7:11 PM, Lorenzo Pieralisi wrote:
> 
> [...]
> 
> > > diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> > > index 1194d5f3341b..ac5c7d7573a6 100644
> > > --- a/drivers/pci/controller/pcie-rcar-host.c
> > > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > > @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
> > >   	}
> > >   	/* setup MSI data target */
> > > -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> > > +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
> > 
> > This does not do what you want on !CONFIG_ZONE_DMA32 (ie arm LPAE).
> 
> How come? I would expect GFP_DMA32 allocates a buffer below 4 GiB in any
> case.

For ARM LPAE allocation falls back to ZONE_NORMAL that happens to work
because if there is memory > 4GB it ends up in ZONE_HIGHMEM, so this
patch should still work on ARM LPAE too.

Regardless, thoughts above the alternative approach (that saves you
a page allocation) ?

Lorenzo
