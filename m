Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4E27C25A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgI2K0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2K0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 06:26:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F1C061755;
        Tue, 29 Sep 2020 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Py+BtTgmwpizBkPoGiwyUBbUQyfIoE3qVOLjRjYUuCA=; b=QgnRmmKF5X6ZqImHotQPAD/RCI
        QTP/amuv2GKZBuCOkmu4ZV9qv2n2Am9BHH6yzPvLqfDuhvCsT9PSolhqFdbfhyRlUCHdGgL9R/tpP
        4zaYA6gFuW1I14N0KCn1x+qoj8Ohd34TUA0uqsDfg/1SqtvI1pUM2BVFO5qY5ReTfkjnJ5b8fm9mq
        ip5bfQ42TNTvciOy2qnRWSzs992keqPVQRuPpbt5i3PuE8NLp1PqUxAUMnV96l73E9ebHePwGBkAp
        I5nD/H0RGAtIRahhsMFUss/FyyBbS+8GGG61jjW2pBkvut4gcPYmjNW4cjFz5NtF7mhVu8I6M22BF
        +ohDyDyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNCqJ-0002WK-3X; Tue, 29 Sep 2020 10:26:43 +0000
Date:   Tue, 29 Sep 2020 11:26:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 3/4] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Message-ID: <20200929102643.GC7784@infradead.org>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-4-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084425.24052-4-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 04:44:24PM +0800, Sherry Sun wrote:
> The device page and vring should use consistent memory which are
> allocated by dma_alloc_coherent api, when user space wants to get its
> physical address, virt_to_phys cannot be used, should simply return the
> saved device page dma address by get_dp_dma callback and the vring dma
> address saved in mic_vqconfig.

More importantly you can't just all virt_to_phys on a return value
from dma_alloc_coherent, so this needs to be folded into patch 1.

>  	if (!offset) {
> -		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> +		if (vpdev->hw_ops->get_dp_dma)
> +			*pa = vpdev->hw_ops->get_dp_dma(vpdev);
> +		else {
> +			dev_err(vop_dev(vdev), "can't get device page physical address\n");
> +			return -EINVAL;
> +		}

I don't think we need the NULL check here.  Wouldn't it also make sense
to return the virtual and DMA address from ->get_dp instead of adding
another method?

