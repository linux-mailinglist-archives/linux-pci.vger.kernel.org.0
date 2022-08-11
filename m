Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B520558F9F8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 11:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiHKJUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiHKJUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 05:20:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE613DD1;
        Thu, 11 Aug 2022 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dWyKzLz2TcBn3/083wwRTF/UnryUhfL0gYj8zALd0ew=; b=gJjJuFdV+xGUVXS9tK7y5/p+a6
        hCBZZ71HXTryrtZ7L4LdpCl8vmnq9R0LSCWOMaj37+tjXCqHrdununHIhZtorepox5aacsMeesbIz
        cV6+SgkNH9J0ZOoL5eGhzyuI6PsdzaMJrhBHtjtWv73ucLmXVILWSKTxU8VoEFYMJGIINkGEqGPkD
        Kz7cFX6Lii3B9XpIkpa9gLH8Q7XN4UBRen4n94S+psprhPXiYev1F+qVt8/COvMbvofTp+nEjF+U9
        qS+qjCkkvxmy05oNA/iUjlxSFuRchSsjwK1aq18+/5fsW8mubfQy1gg1r5LHude8qGyboGz0cXN4U
        WSXx94GA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM4MP-00AhVE-AU; Thu, 11 Aug 2022 09:20:13 +0000
Date:   Thu, 11 Aug 2022 02:20:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: dwc: drop dependency on ZONE_DMA32
Message-ID: <YvTJzTpsWlEizEX3@infradead.org>
References: <20220809180051.1063653-1-willmcvicker@google.com>
 <20220809180051.1063653-2-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809180051.1063653-2-willmcvicker@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 09, 2022 at 06:00:49PM +0000, Will McVicker wrote:
> Re-work the msi_msg DMA allocation logic to use dma_alloc_coherent()
> which uses the coherent DMA mask to try and return an allocation within
> the DMA mask limits. This allows kernel configurations that disable
> ZONE_DMA32 to continue supporting a 32-bit DMA mask. Without this patch,
> the PCIe host device will fail to probe when ZONE_DMA32 is disabled.

> +		dma_free_coherent(dev, PAGE_SIZE, pp->msi_page, pp->msi_data);

Isn't msi_page a struct page * which should become a void * now?

Otherwise this looks good and is what the driver should have done
from the very beginning.
