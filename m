Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB0D4A7A93
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 22:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbiBBVk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbiBBVk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 16:40:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB2C061714;
        Wed,  2 Feb 2022 13:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01443B8311C;
        Wed,  2 Feb 2022 21:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBB0C004E1;
        Wed,  2 Feb 2022 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643838023;
        bh=GuDXLGQ/oxQP3LBWFQeiAeFDRFTpzwtSlAdW9rBxAZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BxVlBoNlAd/1QwOySLlIOF048COMTC52y4Ko7SJ9Y3SZ0Ua6a1fNAPf+8Co5lxDKC
         rZi79aYXEJkHOFLRG5/42hlGVoGmaNYk7w0gHSm8oYhYxewBI6KnJrkjbSliK/jf/B
         yFZuFkWZa3PGS+AjzcqpyLBqAWytlwv7FBrvGwgcSuY9SdeegsIceTCsEq3JYLC4o3
         EvaUp7pNXpwOUH/U8xbJ5HL6wc/MOhHbSZioj/iL98t8VbXbVD5JkCqKjYN5z26fvC
         +xYn34IORxKO5UMZDAxg6eal9Z8F7F3WJfCsdpHKVEtvIz9ghRd2OUAFRXIqDL9E93
         G4WvlMcmj4mYQ==
Date:   Wed, 2 Feb 2022 15:40:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Subject: Re: [PATCH] PCI: kirin: Fix kirin960-pcie probe failure issue
Message-ID: <20220202214021.GA46212@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202162659.GA12603@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 02, 2022 at 10:26:59AM -0600, Bjorn Helgaas wrote:
> [+cc Fan]
> 
> If you're fixing a previous commit, please cc the author of that
> commit.
> 
> I'd prefer the patch below because it avoids the casts of .data and
> the of_device_get_match_data() result, it doesn't silently default to
> PCIE_KIRIN_INTERNAL_PHY if a device without a .data is added, and it's 
> the most common design pattern in drivers/pci/.
> 
> What do you think?
> ...

> commit 3e21687be135 ("PCI: kirin: Add dev struct for of_device_get_match_data()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Feb 2 09:52:41 2022 -0600
> 
>     PCI: kirin: Add dev struct for of_device_get_match_data()
>     
>     a622435fbe1a ("PCI: kirin: Prefer of_device_get_match_data()") broke
>     kirin_pcie_probe() because it assumed match data of 0 was a failure when in
>     fact, it meant the match data was "(void *)PCIE_KIRIN_INTERNAL_PHY".
>     
>     Therefore, probing of "hisilicon,kirin960-pcie" devices failed with -EINVAL
>     and an "OF data missing" message.
>     
>     Add a struct kirin_pcie_data to encode the PHY type.  Then the result of
>     of_device_get_match_data() should always be a non-NULL pointer to a struct
>     kirin_pcie_data that contains the PHY type.
>     
>     Fixes: a622435fbe1a ("PCI: kirin: Prefer of_device_get_match_data()")
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this (with the obvious syntax fixes) to for-linus for v5.17.

> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index fa6886d66488..0dc4e3395b37 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -756,21 +756,27 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +struct kirin_pcie_data {
> +	enum pcie_kirin_phy_type	phy_type;
> +};
> +
> +static const struct kirin_pcie_data kirin_960_data = {
> +	.phy_type = PCIE_KIRIN_INTERNAL_PHY;
> +};
> +
> +static const struct kirin_pcie_data kirin_970_data = {
> +	.phy_type = PCIE_KIRIN_EXTERNAL_PHY;
> +};
> +
>  static const struct of_device_id kirin_pcie_match[] = {
> -	{
> -		.compatible = "hisilicon,kirin960-pcie",
> -		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
> -	},
> -	{
> -		.compatible = "hisilicon,kirin970-pcie",
> -		.data = (void *)PCIE_KIRIN_EXTERNAL_PHY
> -	},
> +	{ .compatible = "hisilicon,kirin960-pcie", .data = &kirin_960_data },
> +	{ .compatible = "hisilicon,kirin970-pcie", .data = &kirin_970_data },
>  	{},
>  };
>  
>  static int kirin_pcie_probe(struct platform_device *pdev)
>  {
> -	enum pcie_kirin_phy_type phy_type;
> +	struct kirin_pcie_data *data;
>  	struct device *dev = &pdev->dev;
>  	struct kirin_pcie *kirin_pcie;
>  	struct dw_pcie *pci;
> @@ -781,13 +787,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	phy_type = (long)of_device_get_match_data(dev);
> -	if (!phy_type) {
> +	data = of_device_get_match_data(dev);
> +	if (!data) {
>  		dev_err(dev, "OF data missing\n");
>  		return -EINVAL;
>  	}
>  
> -
>  	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
>  	if (!kirin_pcie)
>  		return -ENOMEM;
> @@ -800,7 +805,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &kirin_dw_pcie_ops;
>  	pci->pp.ops = &kirin_pcie_host_ops;
>  	kirin_pcie->pci = pci;
> -	kirin_pcie->type = phy_type;
> +	kirin_pcie->type = data->phy_type;
>  
>  	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
>  	if (ret)
