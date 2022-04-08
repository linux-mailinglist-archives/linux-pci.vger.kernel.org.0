Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55234F8ED8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiDHFlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 01:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiDHFlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 01:41:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74E1959C4
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 22:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KAP/9ITtFs4KgD/dudqs/9a8C7lGPL84lkaUfwn/9+w=; b=L+I3eIdRhDgI9JYyHwfQpKqCUL
        iV9E2Q9Fls3xkj5gpZg+u0DCwqjmen3I78crDFZ77dQbTaUM68Ro4rVyDnmDOt6VxYmmY+hwHibPw
        pkKfCYcFuyuGcaGWWfzvoCWy1b+X2ZoP85uNc+32ari+XtfiUJSt7D1XECsLwFTvneLxSmpfQC1T/
        /Eo5chwte0VEkObUVFzR+71kaHSXNZ8squqRddK4y9cN5UuJNVXTR6/7oiqniOEbu8v3GbCxvweBb
        OmkAcpZcYVXeTu2tsZM35uvlKsIqhSrLql0S+OQAmDdJ35C8wQ82o0zCQ3kHx1lV0AIaDMpyz3Ery
        ZvefAb0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchL6-00FAw4-Sl; Fri, 08 Apr 2022 05:39:20 +0000
Date:   Thu, 7 Apr 2022 22:39:20 -0700
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
Message-ID: <Yk/KiGgj3/8Se525@infradead.org>
References: <Yk/CxUxR/iRb9j8l@infradead.org>
 <20220331053422epcms2p7baddf4e5c80b6ebbd5e6aa9447fa221f@epcms2p7>
 <YkR7G/V8E+NKBA2h@infradead.org>
 <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
 <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p7>
 <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
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

On Fri, Apr 08, 2022 at 02:32:46PM +0900, Wangseok Lee wrote:
> I would like to continue reviewing the pcie-designware-host.c patch below.
> https://lore.kernel.org/all/20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3/

The only new comment that I have is that the existing code also looks
completely broken.  Why did the DMA_ATTR_SKIP_CPU_SYNC magically appear
in commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
and what is is tƦying to do except for completely breaking non-coherent
plaforms?
