Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F12836C4
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJENmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJENmw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 09:42:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036BC0613CE;
        Mon,  5 Oct 2020 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MTMw+L2i3D5BNjyZLWldGPszy57qRHHkoDvDaYGS+y8=; b=oG0sKyyX8Uqn2dwcktK1pP8YEt
        wpGnAODMjjoAj9aDpQGxP2+zXo2u8EUVwww9iu7UxoHSaN2e2wNFZgRjPDYx8rSzwo/vrNRTQN7+m
        C3sZ7vGuJCE3G7+1VGPhaRMnK+UW038pFq8SwX8KYSr501qGDiCZsApfZpX0Ba52T+qnGLqrcWkpk
        x4rInPhj/EJ/bcs0ls/5bmtgNAYk+lNWa4H2B48z1waBPMv/c0q0gPQQWiFdHMorXuk9t/TyfJkJV
        k/Y8LhTGZx0kN9GJcuELOfJotKbgCAsx9mkLAEcFiIX61vsaE5/KK4TmKgFFn07vlcDUKO1q9OITz
        J4KVRCYg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPQlE-000301-N0; Mon, 05 Oct 2020 13:42:40 +0000
Date:   Mon, 5 Oct 2020 14:42:40 +0100
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
Message-ID: <20201005134240.GA11178@infradead.org>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-4-sherry.sun@nxp.com>
 <20200929102643.GC7784@infradead.org>
 <VI1PR04MB4960A4E7D6A72C2CDEAC47CE92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200929181156.GA7516@infradead.org>
 <VI1PR04MB4960288477F1DA7AB56D4ECC92330@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960288477F1DA7AB56D4ECC92330@VI1PR04MB4960.eurprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 07:30:21AM +0000, Sherry Sun wrote:
> There may be some misunderstandings here.
> For ->get_dp_dma callback, it is used to get the device page dma address,
> which is allocated by MIC layer instead of vop layer. 
> For Intel mic, it still use kzalloc and dma_map_single apis, although we
> recommended and we did use dma_alloc_coherent to get consistent device
> page memory on our i.MX platform, but we didn't change the original implementation
> method of Intel mic till now, as our main goal is to change the vop code to make it
> more generic.

Given how the memory is used everyone should use dma_alloc_coherent.
Note that for x86 the ony difference is that dma_alloc_coherent also
dips into the CMA pools where available, which eases allocator pressure,
and that it properly deals with the AMD SEV memory encryption, which
does't matter for Intel platforms.

> Which is means that the device page may use different allocate methods for
> different platform, and now it is transparent to the vop layer.
> So I think here use ->get_dp_dma callback to get device page dma address
> is the most simple and convenient way.
> 
> We change to use dma_alloc_coherent in patch 1 to allocate vrings memory, as it is
> the main job that the vop layer is responsible for.
> So I still suggest to use ->get_dp or ->get_dp_dma callback for device page here, what do you think?

As mentioned you need to move the code to mmap the buffers to the
same layer as the one doing the allocation.  If that is taken care of
we're fine, and I think a ->mmap callback might be the best way to
archive that, but this is not code I know intimately.
