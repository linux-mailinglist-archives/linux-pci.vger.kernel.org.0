Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA75B38FF
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIINaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 09:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIINaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 09:30:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F440E3A;
        Fri,  9 Sep 2022 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kx+TNaYecUJWjiUooddG+MRPNpg5v1JBSWuk9TvbMJo=; b=E8naW1LQ2i+cPCRyY9+a+NGZTu
        vGU4YhnCwg8ifoC4YYYDrmYe0yxjnAhR/O8HGe+HFf6QoSTilolUF1E++joJxGfDshNITZiOUGzB7
        VC80cMSt/xdfsqyZ5fqsiPqqz/jBC0fL28FrEq6yhQoR1x7xOO/iXl0K/Qu8yLIAUMeNVhnzCyiK5
        E6+CuN5TSQglIo13urnrFgz7420AKV2DvgUo4dbGI+XhIT06Jutwj2GajNF3iwWQqSeLutN+ZAcyY
        wrF/6pPmljzEBH3K7fiNsB5uLdL5BRGlozyw2wQUY4TgDeKvNou1y0FTiGDwCfOCcC3mx2kuAXp3J
        /5AzBSpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWe4s-00GKZY-Jh; Fri, 09 Sep 2022 13:29:50 +0000
Date:   Fri, 9 Sep 2022 06:29:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <Yxs/zguOb52tY2C0@infradead.org>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825185026.3816331-3-willmcvicker@google.com>
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

On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:
> Since not all devices require a 32-bit MSI address, add support to the
> PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
> allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
> buffering (swiotlb) without risking not being able to get a 32-bit address
> during DMA allocation.

Umm.  You can't just disable ZONE_DMA32.  Linux absolutely requires a
32-bit dma mask to work, it is in fact the implicit default.
