Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C204FB464
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiDKHNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 03:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiDKHNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 03:13:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF8338A5
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rBuxwzxQIbthZlKAcn8KUpHgWMDCkmQwbU2oEHBu130=; b=xAAjE8mUqsV4Dh4AImo1zAxiuw
        KFcysolygvbOpWZf8j36QMPVK8AM75Pn4YwzAZldX+LqXt+FgjUXQ6rOqX6xQ/7LNXDK/4WLrQf+h
        0qcv5T613rOe38moyxmS9MnHMM+ostPX+YPXjELmjUZz0Hw/vqJYkoaTnYv1X+r+TT8ktsZmeNolP
        cfSBubOZsrPqdxzOab3vOe1W0fIpQgj9KIxC7MU7Si/2xznNx8VO34xJ/seQU4gt6wydv3royi9WA
        uQXAM/9iL1OawoF6PR24lrpYsjJvtsz46u0DRo2KpwFgayYRYHaJGWaDKbkqTwLeRVLbuWWqUM2u9
        4HwLTqVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndoCB-0077bx-AJ; Mon, 11 Apr 2022 07:10:43 +0000
Date:   Mon, 11 Apr 2022 00:10:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Message-ID: <YlPUc5qzqu4wcxX0@infradead.org>
References: <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
 <YkR7G/V8E+NKBA2h@infradead.org>
 <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
 <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
 <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p5>
 <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 03:59:05PM +0900, Wangseok Lee wrote:
> driver_init() ->
> -> platform_dma_configure() / platform.c
>   |-> of_dma_configure() 
>      |-> of_dma_configure_id()
>         :Here, set dma of 33+ address.
>          dma_set_mask(0xf`ffff`ffff), bus_dma_limit(0xf`ffff`ffff)

Where do we set a large than 32-bit dma mask here?  I can't find the
code, and if there is we need to fix it.  In Linux devices to come
up with 32-bit DMA masks for historical reasons (they really should
with a zero dma mask, but it is probably to lte to fix it).

> -> artpec8_pcie_probe() / artpec-8 pcie driver code
>   |-> dw_pcie_host_init() / pcie-designware-host.c
>      |-> dma_set_mask(32)
>          : Here, set the dma mask of 32 addresses.
>      |-> dma_map_single_attrs() 
>         |-> dma_map_page_attrs()
>            |-> dma_direct_map_page()
>               : Error return occurs here.
>                 dma address has 33+ address and 
>                 dma bus limit is 33+. 
>                 However, this is because the mask value 
>                 has 32 addresses.

If the dma_mask is set to 32-bits, we should never generate a
large dma address, but bounce if it would othewise generate a
larger address.

That being said I think this code would be much better off using
dma_alloc_coherent anyway.

> Therefore, the dma_set_mask(32)(in dw_pcie_host_init())
> was modified to be performed only when
> the dev-dma_mask is not set larger than 32 bits.

So what sets dev->dma_mask to a larger than 32-bit value here?
We need to find and fix that.
