Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7E27D586
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgI2SMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2SMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 14:12:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D964C061755;
        Tue, 29 Sep 2020 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kKuFgIMHQLymhIGJfdBnN4wchNjf3ZHyGsYgV56ZYWc=; b=ADeTkLTgeref0mmQLdfO0194Of
        bG9x+IaW5kPSYNfGXVes/ecKvgg0JcFkRTmAORScLPOM0GJs48fncPUKk3TfT9f2dRZId5JgvAg85
        KI5Z7cWTV4IeJ5mtPXkjBaQKOBoxd5W57e37y2XcCAhaSL5muSxsPNap+DhZ/cah8V8zGiX77y4fZ
        aWmnTVKtoS2soBsjj06Chw3/KOL1pEeWddGIijThkZUAMe9prOZNnmYVAtY9u+KEToW8H3CGxn+ER
        fqnkJznTcNA9OHbmSKx2dzPb5sKGYkKGgzAnwjTwhtecC9ZyC8v0BpR23+vjRGEVjQfsXAuZEg0C0
        fM4Ld4jQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNK6W-0001zr-IN; Tue, 29 Sep 2020 18:11:56 +0000
Date:   Tue, 29 Sep 2020 19:11:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 3/4] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Message-ID: <20200929181156.GA7516@infradead.org>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-4-sherry.sun@nxp.com>
 <20200929102643.GC7784@infradead.org>
 <VI1PR04MB4960A4E7D6A72C2CDEAC47CE92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960A4E7D6A72C2CDEAC47CE92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 01:10:12PM +0000, Sherry Sun wrote:
> > >  	if (!offset) {
> > > -		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> > > +		if (vpdev->hw_ops->get_dp_dma)
> > > +			*pa = vpdev->hw_ops->get_dp_dma(vpdev);
> > > +		else {
> > > +			dev_err(vop_dev(vdev), "can't get device page
> > physical address\n");
> > > +			return -EINVAL;
> > > +		}
> > 
> > I don't think we need the NULL check here.  Wouldn't it also make sense to
> > return the virtual and DMA address from ->get_dp instead of adding another
> > method?
> 
> Do you mean that we should only change the original ->get_dp callback to return virtual
> and DMA address at the same time, instead of adding the ->get_dp_dma callback?

That was my intention when writing it, yes.  But it seems like most
other callers don't care.  Maybe move the invocation of
dma_mmap_coherent into a new ->mmap helper, that way it seems like
the calling code doesn't need to know about the dma_addr_t at all.

That being said the layering in the code keeps puzzling me.  As far as
I can tell only a single instance of struct vop_driver even exists, so
we might be able to kill all the indirections entirely.
