Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379F33FCCFB
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhHaSbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 14:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbhHaSbT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 14:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B68AD6103D;
        Tue, 31 Aug 2021 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630434624;
        bh=SkqXMQamgRCoEPdaEMQczTpsfjKyfyqiZUqYd3pqmGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=daeKtIgxioFFhmdkjNA44T638KaBT0Kq+nyUwmpWbxBJ9Kk/VpSDFjHoPupul7CEK
         lpTdFs7BTTzy6uh0bJQBQLQ48tA68LgZS3k/79Zd5kl1WM+KnbcDj04GbRnIpsnkfq
         7GRZosccxUpc/dsyaK5q3fFhMkIzJpA4Xq0a92vpm3asIfV5dOjz0mYhrtZwLl/mRZ
         C67hvJoqeA/ejWyYgVQTank50vM3QBayLrYptzdGL822M6iLzmMkGjNRgDd1RWSblc
         2XEbj9de7t7DxnD0WEqYPLJQYQfwkwqKoKiQGwX2JBgVVqwpd/bkC1IKP45hqXUHY9
         O3sXvUR5lhJRQ==
Date:   Tue, 31 Aug 2021 13:30:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     robh+dt@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
        lorenzo.pieralisi@arm.com, ryder.lee@mediatek.com,
        jianjun.wang@mediatek.com, yong.wu@mediatek.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/6] PCI: mediatek: Add new method to get irq number
Message-ID: <20210831183022.GA120514@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823032800.1660-4-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 23, 2021 at 11:27:57AM +0800, Chuanjia Liu wrote:
> Use platform_get_irq_byname() to get the irq number
> if the property of "interrupt-names" is defined.

From patch 1/6, I have the impression that this patch is part of
fixing an MSI issue.  If so, this commit log should mention that as
well.

> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 4296d9e04240..19e35ac62d43 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -654,7 +654,11 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>  		return err;
>  	}
>  
> -	port->irq = platform_get_irq(pdev, port->slot);
> +	if (of_find_property(dev->of_node, "interrupt-names", NULL))
> +		port->irq = platform_get_irq_byname(pdev, "pcie_irq");
> +	else
> +		port->irq = platform_get_irq(pdev, port->slot);

This would be the only instance of this pattern, where we look for a
property and use the result to decide how to look for the IRQ.

dw_pcie_host_init() does something like this:

  port->irq = platform_get_irq_byname_optional(pdev, "pcie_irq");
  if (port->irq < 0) {
    port->irq = platform_get_irq(pdev, port->slot);
    if (port->irq < 0)
      return port->irq;
  }

Would that work for you?  If not, the commit log should explain why
you can't use the standard pattern.

If you do things differently than other drivers, it makes things
harder to review and slows things down.  If you *have* to do something
differently and it adds real value to be different, that's fine.  But
we should avoid unnecessary differences.

>  	if (port->irq < 0)
>  		return port->irq;
>  
> -- 
> 2.18.0
> 
