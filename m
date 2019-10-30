Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D15EA5AC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfJ3Vq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 17:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfJ3VqZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 17:46:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F5F20862;
        Wed, 30 Oct 2019 21:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572471985;
        bh=tul9G/l7oEq7DjuuWrHdlkxE9hMNRejXgxOVts2mk8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jaRpvqIMi991TIcZXEQyzF7YRHL9iXJUIgR3sM3Wo93AqZxd5xC3r55CtQFqbpcO4
         ljRtlF7QFdO4ofQjimn9JySEf22M9jxbjlwDUmLusyGhPOCsA5Aoj9/y6gKesmeVlI
         tHdiVnTLOqREjxEDBMut5RR4croVQFCamjKmm0r4=
Date:   Wed, 30 Oct 2019 16:46:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, kgene@kernel.org, krzk@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] pci: controller: dwc: Remove dev_err use after
 platform_get_irq
Message-ID: <20191030214621.GA256263@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028202144.GA29158@saurav>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please run "git log --oneline drivers/pci/controller/dwc/pci-exynos.c"
and make your subject line match, e.g.,

  PCI: exynos: Remove dev_err() usage after platform_get_irq()

The body of that was copied from similar commits like:

  fb5a35dbee8d pwm: Remove dev_err() usage after platform_get_irq()
  9a7957d0c955 mmc: Remove dev_err() usage after platform_get_irq()
  1df217868178 tty: Remove dev_err() usage after platform_get_irq()

It's nice when similar commits have similar subject lines.

In fact, this whole thing has been approached before:

  https://lore.kernel.org/lkml/20190730181557.90391-32-swboyd@chromium.org/

That patch would have fixed many similar issues in PCI, but I don't
know what happened to it.  Would you mind resurrecting that and fixing
the minor issues so we can do everything in PCI at once?

On Tue, Oct 29, 2019 at 01:51:44AM +0530, Saurav Girepunje wrote:
> Don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 14a6ba4067fb..2293b346d96a 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -403,7 +403,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  
>  	pp->irq = platform_get_irq(pdev, 1);
>  	if (pp->irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
>  		return pp->irq;
>  	}
>  	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
> @@ -416,7 +415,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq(pdev, 0);
>  		if (pp->msi_irq < 0) {
> -			dev_err(dev, "failed to get msi irq\n");
>  			return pp->msi_irq;
>  		}
>  	}
> -- 
> 2.20.1
> 
