Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF64EBDC5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbiC3JkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiC3JkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 05:40:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFD2315D
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648633103; x=1680169103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0RkEbo3AoM17ChmBAplIanJgUVkrUEWMdXhFSjPEqUE=;
  b=XX7Oi1xGbh3OPueYnPc60mq00PTc7C1aObPkZbw6/q1MvDodfyYg/bwU
   N7+E5bNaPrK3K5wx2eV2tn9suiy1ybrVxbZLGVSykaZFPAm2aUBgbg2MW
   xQK7ZUZCUixXx+lqG+5kd5omGGeSExLWj9xfOB/pvREwqoik7V1drHM23
   tOC0fsv6Q6vSWkZFPoGrUkBv/o3r8vY62MKzQx4bJjzC8hcT0RInmRXpS
   X9PSVEWEJOxw32Tzxt3fBeM5xg2tlxtxG+9pllwnJVkv4s3NDXQ88+xjM
   pzPcF9Xu5YnSej9Zf6EhGbQRCwvaJbp07KcrKiiNwHdg4SrL2CxAfn0ux
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239430806"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="239430806"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="605364396"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2022 02:38:20 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 22U9cJta010240;
        Wed, 30 Mar 2022 10:38:19 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Date:   Wed, 30 Mar 2022 11:35:26 +0200
Message-Id: <20220330093526.2728238-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
References: <20220328143228.1902883-1-alexandr.lobakin@intel.com> <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3> <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p8> <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: 이왕석 <wangseok.lee@samsung.com>
Date: Wed, 30 Mar 2022 12:52:03 +0900

> > --------- Original Message ---------
> > Sender : Alexander Lobakin <alexandr.lobakin@intel.com>
> > Date : 2022-03-28 23:34 (GMT+9)
> > Title : Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
> >
> > From: 이왕석 <wangseok.lee@samsung.com>
> > Date: Mon, 28 Mar 2022 11:30:09 +0900
> >
> >>  If dma_mask is more than 32 bits this will trigger an error occurs when
> >>  dma_map_single_attrs() is performed.
> >>  
> >>  dma_map_single_attrs() -> dma_map_page_attrs()->
> >>  error return in dma_direct_map_page().
> >>  
> >>  On ARTPEC-8, this fails with:
> >>  artpec8-pcie 17200000.pcie: DMA addr 0x0000000106b052c8+2 overflow
> >>  (mask ffffffff, bus limit 27fffffff)
> >
> > Isn't it a bug in the platform DMA code? dma_set_mask(32)
> > explicitly says that the system *must not* give DMA addresses wider
> > than 32 bits. If the system can't satisfy this requirement, then it
> > should return failure on dma_set_mask(32) -- this way you will only
> > get the corresponding warning, but there'll be no overflows (as the
> > mask will not be changed).
> > The idea of this call is to try to avoid getting 33+ bit mappings
> > so that PCI controllers which support only 32-bit masks could still
> > work correctly on the 64-bit systems. If the call fails, then this
> > message gets printed that you've been warned and it's your
> > responsibility to make sure that the controller won't get truncated
> > addresses. Having the call succeeded and then 33+ bit DMA addresses
> > is wrong.
> >
> > Please correct me if I'm wrong.
> >
> 
> Hello, Alexander Lobakin
> Thanks for your review.
> 
> You are right.
> My concern is that case of trying to use 33+bit dma mappings on 
> 64bit system.
> It is about the call sequence of the functions related to dma 
> setting, not the operation of the dma_set_mask() function.
> If dma_set_mask(33+) is performed before dw_pcie_host_init()
> for using 33+bit dma mapping, following error occurs 
> in dma_map_single_attrs()
> ex) DMA addr 0x0000000106b052c8+2 overflow 
>    (mask ffffffff, bus limit 27fffffff)
> dma_set_mask(33+) -> dw_pcie_host_init(): dma_set_mask(32) ->
> dma_map_single_attrs() -> 
> error return in dma_direct_map_page(): 
> because dma addr is 33+ but masking value is 32
> 
> So if the user has already set dma_mask to 33+ in order to use 33+,
> i suggested to modify dma_set_mask(32) not to be called.
> 
> Please let me know your opinion.

I'm not super familiar with the DMA internals, so adding Chris here,
maybe he'd like to comment, but anyway, the lower/arch layer must
not give the DMA addresses wider than the number of bits passed to
dma_set_mask() if that call returned 0.

> 
> Thank you.

--- 8< ---

> >>  -- 
> >>  2.9.5
> >
> > Thanks,
> > Al

Thanks,
Al
