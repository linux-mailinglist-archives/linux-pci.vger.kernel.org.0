Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0B44BC2B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 08:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhKJHjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 02:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhKJHjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 02:39:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65463C061764;
        Tue,  9 Nov 2021 23:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Sl35YyP2vcKk8Xcy9vsgJAsaWV0tvjJ1YKLZctmqo0=; b=XyRKsg8WgZtFBMshL9AhAPUzEH
        BMVFb12qPQsmu1PUcBgI1X7KKrfIJrpgtIp4gJtzKSkBTxwAs+5pG2pL1AyCTxYP/ucFxUa/RMwaf
        8aN7VK6h2ySQK8cW/ZZ4WuHDjG1dkbxIswWf6ePVpnPdTgTOI3+ZexpN9DrfTgov5ie80MsA5Q72v
        73JW3WkJp0azwRpGulITHrVBzOLS2xUXOYCzJhDmUhX3x78361sAnRQpC9TpD8ejm7fQJ0Usm68d9
        tCTmu4wqnuQIi9pRnlmjiMO6XgmE2bEDxrLQXu04kZg5sIilQOz2bPrJe+l/G1U19CFjB8KmfUF9g
        wQaoziWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mki9Z-004hAZ-Dk; Wed, 10 Nov 2021 07:36:17 +0000
Date:   Tue, 9 Nov 2021 23:36:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: keystone: Set DMA mask and coherent DMA mask
Message-ID: <YYt2cTEn4MKLuvdk@infradead.org>
References: <20211110073343.12396-1-kishon@ti.com>
 <20211110073343.12396-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110073343.12396-4-kishon@ti.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 10, 2021 at 01:03:43PM +0530, Kishon Vijay Abraham I wrote:
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) &&
> +	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {

There is no need to fall back to a smaller mask, the core DMA code
just cares about the addressability of the device.
