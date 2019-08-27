Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4840E9F6A9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH0XLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfH0XLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:11:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EECF20856;
        Tue, 27 Aug 2019 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566947494;
        bh=aNlA/MApouOcwf72/8GMSwuzsBqyO6Sp9x6HCpSXgGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRFwTS1rqTxwj2gvps8jYXhfiuL5Eq3hUd/q4PyouqcIke/YpvR0yEqCnHJpG0oBG
         q+uh2ZEibfyAH/G5ndZQGkinr8VnwC95MliB678A5+UIXUovp7a4j0ytcyqog3dgIl
         8jeD5gpDNVsUfsxolJbYrmZuu7z9XbuEg9x+Ts0Y=
Date:   Tue, 27 Aug 2019 18:11:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Remove surplus return from a void function
Message-ID: <20190827231133.GG9987@google.com>
References: <20190825221039.6977-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825221039.6977-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 12:10:39AM +0200, Krzysztof Wilczynski wrote:
> Remove unnecessary empty return statement at the
> end of a void function mtk_pcie_intr_handler() in
> the drivers/pci/controller/pcie-mediatek.c.
> 
> The surplus return statement was added as part of
> the work in commit 42fe2f91b4eb ("PCI: mediatek:
> Implement chained IRQ handling setup").
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

I squashed this together with the other patch doing the same thing.
If it causes any conflict with Lorenzo's branches, I'll resolve it
when merging.

> ---
>  drivers/pci/controller/pcie-mediatek.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 3eaa7081ab2a..626a7c352dfd 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -635,8 +635,6 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
>  	}
>  
>  	chained_irq_exit(irqchip, desc);
> -
> -	return;
>  }
>  
>  static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
> -- 
> 2.22.1
> 
