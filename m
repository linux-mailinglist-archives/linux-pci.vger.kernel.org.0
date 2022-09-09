Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5A5B3B08
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiIIOrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiIIOr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 10:47:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519711282C5;
        Fri,  9 Sep 2022 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MKCJGQImC5rNFm8xlhIZtRyfnfFLIWT7YCm6bd8rOy4=; b=V7t/u3J6Ot1dGFxPwqjtFrioG5
        aUDXOgBEA02JPaFLQCHpjqxuZAGyjvQkosJgcg5ACNNRnoUFC/Fga9SOrlzxWVduOtTEZSBA4r7Mc
        /HpVXTbhmPdCFKOIFGSPxxwPC48OmjgvkqVwpNBpsumxcWpvdG93Borp8oTaN+i0TOgBMG0/FNIgC
        LZQRe83Je4zqxMmJxL4UNrI4tVdw2NIWOTkw2RsHgkL0PGWHu+VNm8forptW6CQPEuNhznIwNF4uQ
        g1ijujJNiwIJkz/Nba/NjyfkYvoFOrrmC4zJ8+EyBWtCzPscUliqQbvynCmtrGuPeGq5WPthzMuBk
        AotoV87Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWfHo-00GqRQ-01; Fri, 09 Sep 2022 14:47:16 +0000
Date:   Fri, 9 Sep 2022 07:47:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will McVicker <willmcvicker@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <YxtR8/X4fb9wSYEo@infradead.org>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
 <Yxs/zguOb52tY2C0@infradead.org>
 <5bfd7d4d-d431-6321-89bc-663dcd36e930@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfd7d4d-d431-6321-89bc-663dcd36e930@arm.com>
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

On Fri, Sep 09, 2022 at 02:47:19PM +0100, Robin Murphy wrote:
> On 2022-09-09 14:29, Christoph Hellwig wrote:
> > On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:
> > > Since not all devices require a 32-bit MSI address, add support to the
> > > PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
> > > allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
> > > buffering (swiotlb) without risking not being able to get a 32-bit address
> > > during DMA allocation.
> > 
> > Umm.  You can't just disable ZONE_DMA32.  Linux absolutely requires a
> > 32-bit dma mask to work, it is in fact the implicit default.
> 
> Eh, it's behind CONFIG_EXPERT, which makes it enough of a "I think I know
> what I'm doing and accept responsibility for picking up the pieces if it
> breaks" thing.

Seem like indeed on arm64 there is a way to disable it.  The x86 model
is to just select it unconditionally, which I think is the right way
if we don't want to get into completely random failures.
