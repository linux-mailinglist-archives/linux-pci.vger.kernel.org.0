Return-Path: <linux-pci+bounces-18034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77839EB546
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D03161EA6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ECB206F27;
	Tue, 10 Dec 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9OvaSGd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FD2063F0;
	Tue, 10 Dec 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845378; cv=none; b=u3yu4/0Huj4OgSC9g1viJ82XFCIJiOvewfZZJSmfZcG1lJqW+HpgXl2McRFluvWPPiiiW1+yNIqRsYE+3WIj5gWcY1hcGEgp5PDlG+nQ/h4ZNiPLHxEMdk0W1Ftw9pdVf5UFCIHRTYAgCfVxo/yoZKjn3lUvD1O5fQNUP6cQC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845378; c=relaxed/simple;
	bh=2/nMlbfdV4p9tEV8SRlLwSHuMSVq76uOgvT6G4bvhkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PeFDlD0nuAWQltWVUAwSNEZzxedzGhqEvIPgOeaLbv8DA1ZbFqYI0lVXslXG+AMlqUWASQIu6hU3K+7mYzEXO9WFqdxdIZzZtTl3BxV12xHtSPZs9HWn7Z4hIuAQZY4efSCOs0mGZDdFf2ieIszya66Q078KDqNeUghUon3/H0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9OvaSGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C7AC4CEDE;
	Tue, 10 Dec 2024 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733845377;
	bh=2/nMlbfdV4p9tEV8SRlLwSHuMSVq76uOgvT6G4bvhkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p9OvaSGdsBHtBV+u6BMqLQg4dMbrtbKVJGCnioNPNAuewZc8+7HQk+R74m9X4MvfB
	 KD2f4yCuarwPFBGav5WHxBjeLOiS7OHKrtlD64OlUWrftIBudKTt4b5qSaK1SOcDya
	 IA4iq8mpI/HlFA46RuGqoFwtKfKmmwQWrNYurWl1OykRNy23YoBR1lDs+1IrWrQ15k
	 lGVKn3n+btx67K1JzeXMssQ1t/Fv6Y6Ka34/qD5CrOGre+1tNtlzHQO7Zrvlt7jku6
	 ZID91j5zqUbo0szVXIzmYzzDqciORW8WKbcPEyj0LDUf1RKnlHD03UAuEOQ7dq/bKh
	 Ws7L1Jg4gdIiA==
Date: Tue, 10 Dec 2024 09:42:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: vigneshr@ti.com, s-vadapalli@ti.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, theo.lebrun@bootlin.com,
	thomas.petazzoni@bootlin.com, kwilczynski@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check
 reset_gpio before to use it
Message-ID: <20241210154256.GA3242512@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209112321.65320-1-thomas.richard@bootlin.com>

On Mon, Dec 09, 2024 at 12:23:21PM +0100, Thomas Richard wrote:
> The reset_gpio is optional, so in j721e_pcie_suspend_noirq() check if it is
> not NULL before to use it.

If you have occasion to post a v2, update subject to:

  PCI: j721e: Check reset_gpio for NULL before using it

s/before to use it/before using it/

Did you trip over a NULL pointer dereference here?  Or maybe found via
inspection?

It looks like gpiod_set_value_cansleep(desc) *should* be a no-op if
desc is NULL, based on this comment [1]:

 * This descriptor validation needs to be inserted verbatim into each
 * function taking a descriptor, so we need to use a preprocessor
 * macro to avoid endless duplication. If the desc is NULL it is an
 * optional GPIO and calls should just bail out.

and the fact that the VALIDATE_DESC_VOID() macro looks like it would
return early in that case.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?id=v6.12#n2316

> Fixes: c538d40f365b ("PCI: j721e: Add suspend and resume support")
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 0341d51d6aed..5bc14dd70811 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -644,7 +644,9 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>  	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>  
>  	if (pcie->mode == PCI_MODE_RC) {
> -		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +		if (pcie->reset_gpio)
> +			gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +
>  		clk_disable_unprepare(pcie->refclk);
>  	}
>  
> -- 
> 2.39.5
> 

