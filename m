Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E057E4F8DBC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 08:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiDHFIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 01:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiDHFI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 01:08:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5823ACAB
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cXUBuSdF16Cxg0z/JVxUXrcFxI8IVJk9GQSpNi9s5kE=; b=FibP+p3MFxZX3XCvwsDeNTnnjC
        vwet8FGSy2xv6IKibBziSIdnASssREA6BAxFWVH/WCm2GhIINhtBslqAwfQQqquFKGPCjm7IH50G4
        FDZWJNSQc1+f1Q+aOgtCdeyBn1psN5CQ/tndA0xpSF5tNaMlFb3qz4EcT9v7YLCIi1WTzsWFm+sUW
        uiW4tEY+I4yEQDCFxE5fAKfU9NYFw5Mc5POF3MPPY1pag7+Q8fqnJS1/aeLt1FzkUGtg/Vsg01al7
        273ON7tRUYAuV2dnjTTC5YuXuZ0ShOei3TsMndjYUCPR0jkkYcy/KMgTtLIO9nan6VX0NjI7l4mgR
        z+1oQTUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgp3-00F0ia-Pb; Fri, 08 Apr 2022 05:06:13 +0000
Date:   Thu, 7 Apr 2022 22:06:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Message-ID: <Yk/CxUxR/iRb9j8l@infradead.org>
References: <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
 <YkR7G/V8E+NKBA2h@infradead.org>
 <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p4>
 <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 08, 2022 at 11:34:01AM +0900, Wangseok Lee wrote:
> Hi,
> 
> Could you please review this patch in the context of the following patch?
> 
> https://patchwork.ozlabs.org/project/linux-pci/patch/20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p

Isn't that the same (broken) patch?
