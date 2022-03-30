Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10584EC8B2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiC3Pre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 11:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245570AbiC3Prc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 11:47:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636C33E3E
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKqwDY00H2Se/3uZbtkbiprIJT1B3mEXEoBiCuFfdcU=; b=rMM6QT92K1eLBj7or3nJiUYJ5S
        ykddd1hyrPBAV+Wuss5ZvoPOuktRKxVaYlIQ7GtL2KkSS4wn766CLCUYDW7r6pUDcQLiTG7SZX/wg
        NcoOV0WqgHIITwZ0j+Jf8kGivpDpp98jhRbkJ5vSmFAZO6yASxQ76R72J0T0fkOuw3FbsDBnseEbQ
        edb5o4Hbo+2LE/CSi2x3UJtVH9fheRaBiA+tufZZ0f0a1meMR7PhDwmKAqtQgXu9A9hr5OfU/yYS5
        F4SVrIeMrsnadHFx9D7UW4C94iQkBLgGEXlmiayoZopZEoNxnVNQEOuM1GGQjhrMJz4DLBdJT6kbo
        RBNtDPpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZaVn-00GcyX-Vg; Wed, 30 Mar 2022 15:45:31 +0000
Date:   Wed, 30 Mar 2022 08:45:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     =?utf-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>,
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
        =?utf-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Message-ID: <YkR7G/V8E+NKBA2h@infradead.org>
References: <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p8>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330093526.2728238-1-alexandr.lobakin@intel.com>
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

On Wed, Mar 30, 2022 at 11:35:26AM +0200, Alexander Lobakin wrote:
> I'm not super familiar with the DMA internals, so adding Chris here,
> maybe he'd like to comment, but anyway, the lower/arch layer must
> not give the DMA addresses wider than the number of bits passed to
> dma_set_mask() if that call returned 0.

So, the basic assumption in the kernel is that 32-bit DMA is always
supported, and dma_set_maks for that should not fail.  If the
system (or root port, internal interconnect) supports less than that
we'll bounce buffer.  But how and why would you hand out addresses
larger than that?  It really is not valid, but I can't even see how
it could happen.
