Return-Path: <linux-pci+bounces-33988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB841B253FD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AEE568516
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF12F99B7;
	Wed, 13 Aug 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRboU3La"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7E15A87C;
	Wed, 13 Aug 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113712; cv=none; b=b1PnGM/GLI6HA/0NuyIFwVrWh1TEfcgCONlvvOmHnXD1adIMMpLwgVdh+1WMF1gTf7zqf5AXUKXwTBJ5Mdb8fsygUP7Qpwyea0T5SdFu6jsNnfjweV6M33a/GctSAB8E+Jh1rizSFI5f/Auu2XlPP1S7ysVk8/Zqn4cerbfA12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113712; c=relaxed/simple;
	bh=UqocbTcw5EDwtib0jYrghJffrDmxf3zJ7rq/CvASetg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jO7u0oQkH2HADsAUu/AtrWFhrG2urq2HT41nlPoAU+PXsoihvSjduHGxLyway83z7M81/9r9v//a9yfU1j4ixTMRtIERtRqrRdZC66MGBdpbDIfeywyIucXDZ5UM1dQpzP5bLPvTYoUbdBk7gAaGgEI7Pj1h5NSVIUGKquX8iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRboU3La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F09C4CEEB;
	Wed, 13 Aug 2025 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755113711;
	bh=UqocbTcw5EDwtib0jYrghJffrDmxf3zJ7rq/CvASetg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tRboU3LajjYr7ecWWsCZW4QpYioFi4ept65n2reoXnivoH05RRaVJgS94TB/TDshj
	 r69eSKB5y94BDHLWDNpcolPSDNXbDkgf3PykLD8SRBgEvEEZgR1XkAMJLryp9XEQCn
	 A2uqdvusjehlEmrv5zIRUrzuJEJzZXkpHGitui5Kb4puC1bgYfGdMyuN4Wbd9v1MBe
	 84/2+hCCFH3Qw2kOZ5g8+fz6TsTt9SWMZ4h1hTevQj6smyLBqzZ/dA+A9gNTg/Zpq4
	 8Nn2EhRnSF1Fk9lNHw5cZwv0PrthUWYWXqMMvYuBSw+OeQ6i1OcpH6VdZzCm1MSsOp
	 hIHvN4iljYMwg==
Date: Wed, 13 Aug 2025 14:35:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Fix double cleanup on
 devm_add_action_or_reset() failure
Message-ID: <20250813193510.GA287916@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b1386e6162e70e6d631c87f6323d2ab971bc1c5.1755100324.git.geert+renesas@glider.be>

On Wed, Aug 13, 2025 at 05:56:25PM +0200, Geert Uytterhoeven wrote:
> When devm_add_action_or_reset() fails, it calls the passed cleanup
> function.  Hence the caller must not repeat that cleanup.
> 
> Replace the "goto err_regulator_free" by the actual freeing, as there
> will never be a need again for a second user of this label.
> 
> Fixes: 75996c92f4de309f ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # V4H Sparrow Hawk
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to pci/pwrctrl for v6.18, thanks!

> ---
> Compile-tested only.
> 
> v2:
>   - Add Reviewed-by, Tested-by, Acked-by.
> ---
>  drivers/pci/pwrctrl/slot.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 6e138310b45b9f7e..3320494b62d890ff 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -49,13 +49,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
>  	if (ret < 0) {
>  		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> -		goto err_regulator_free;
> +		regulator_bulk_free(slot->num_supplies, slot->supplies);
> +		return ret;
>  	}
>  
>  	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>  				       slot);
>  	if (ret)
> -		goto err_regulator_disable;
> +		return ret;
>  
>  	clk = devm_clk_get_optional_enabled(dev, NULL);
>  	if (IS_ERR(clk)) {
> @@ -70,13 +71,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
>  
>  	return 0;
> -
> -err_regulator_disable:
> -	regulator_bulk_disable(slot->num_supplies, slot->supplies);
> -err_regulator_free:
> -	regulator_bulk_free(slot->num_supplies, slot->supplies);
> -
> -	return ret;
>  }
>  
>  static const struct of_device_id pci_pwrctrl_slot_of_match[] = {
> -- 
> 2.43.0
> 

