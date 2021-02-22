Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1F320F69
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 03:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhBVC3m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 21:29:42 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:33556 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBVC3k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2021 21:29:40 -0500
Received: by mail-wr1-f41.google.com with SMTP id 7so17471138wrz.0;
        Sun, 21 Feb 2021 18:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuSXhHVkvdpvKkmvEHEbBP8ABWSLjzYRJOtjdQKRU14=;
        b=aB7e+LFOc50DTj2misfyZJ5PjHZkqMS0lhA1EgE0dmtoj+ZmaQi/KNclsBnhtBuAk+
         O4ShelMRUD9N6ZFjH2Y6eQbog7nntFuSp7kaFStGRBHHUcECPhHTPhTm5ipw9Voizvun
         9bkDxXaUMfLYFG5mWUqeee2sj3+b90dUWIRVFu4I2HGHzMJtlnucsKHxHWBIyLpdov6Z
         7mRtU0OGi7hSGtXSKAHb4G05NmbwRcvY3S5SnxM8oVLJvkv9j/v+eNUttp535UonayVn
         W9kOa03HiesV/I0vCvW9ryiA4yoAixhBCO4dAR08nWXQmKSjhUWaZj1JJ/EagoIFUz+g
         Tx6g==
X-Gm-Message-State: AOAM530fO1sMXtOGSmbf48SCDjbkH/xyJYSWgHy6X9HM84HC1ykx8OBg
        6zvjBn31n0syly5wOaqDotQ=
X-Google-Smtp-Source: ABdhPJzjkMmOUD3BxfW4ijeEEW5ctadh2zzf9bje2PH+jq4NNLhgJ+ZUZ+b3mX/y8o+Xqi+FhyiN3Q==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr19479969wra.204.1613960938470;
        Sun, 21 Feb 2021 18:28:58 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o14sm25602426wri.48.2021.02.21.18.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 18:28:57 -0800 (PST)
Date:   Mon, 22 Feb 2021 03:28:56 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 2/2] PCI: rockchip: add DesignWare based PCIe
 controller
Message-ID: <YDMW6OmnnrIgt1RR@rocinante>
References: <20210127022406.820975-1-xxm@rock-chips.com>
 <20210127022519.821025-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127022519.821025-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Simon,

The subject should start with a capital letter.

[...]
> pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
> is Rockchip designed IP which is only used for RK3399. So all the following
> non-RK3399 SoCs should use this driver.

You might need to wrap the long line in the above.

The commit message above could use some polish in terms of wording and
adding more context - what are you adding, what is this driver going to
support.  For example, what are the "all the following" SoCs?  Should
there be a list?  Or did you mean "all the other (...)", etc.

[...]
> +config PCIE_ROCKCHIP_DW_HOST
> +	bool "Rockchip DesignWare PCIe controller"
> +	select PCIE_DW
> +	select PCIE_DW_HOST
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Enables support for the DW PCIe controller in the Rockchip SoC.

Perhaps replacing "DW" with "DesignWare" would be better.  Also, do you
want to mention here - for the sake of the future user - that this not
intended to support RK3399 as per the commit message.

[...]
> +/*
> + * PCIe host controller driver for Rockchip SoCs

A nitpick.  Missing period at the end of the sentence.

[...]
> +static int rockchip_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +
> +	if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) == 0x30000 &&
[...]

A suggestion.  Would it make sense to add a definition for this
open-coded value of 0x30000 above?

> +static void rockchip_pcie_fast_link_setup(struct rockchip_pcie *rockchip)
> +{
> +	u32 val;
> +
> +	/* LTSSM EN ctrl mode */
[...]

Does this comment above stands for "LTSSM enable control mode"?

> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> +{
> +	int ret;
> +	struct device *dev = rockchip->pci.dev;

These two variables should swap place to keep order of use, and to match
how it has been done everywhere else in this drivers.

> +
> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(rockchip->phy))
> +		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> +				     "missing phy\n");

I would be "PHY" here.

> +	ret = phy_init(rockchip->phy);
> +	if (ret < 0)
> +		return ret;
> +
> +	phy_power_on(rockchip->phy);
[...]

We should probably check phy_power_on() for a possible failure.  Some
platforms also clean up on a failure from phy_init() and phy_power_on(),
but I am not sure if this particular platform would require anything.

[...]
> +	/* DON'T MOVE ME: must be enable before phy init */

It would be "PHY" here.

> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(rockchip->vpcie3v3))
> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +				     "failed to get vpcie3v3 regulator\n");
> +
> +	if (rockchip->vpcie3v3) {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret) {
> +			dev_err(dev, "fail to enable vpcie3v3 regulator\n");

It would be "failed" here.

[...]
> +static const struct of_device_id rockchip_pcie_of_match[] = {
> +	{ .compatible = "rockchip,rk3568-pcie", },
> +	{ /* sentinel */ },
> +};

We could probably drop the comment about the "sentinel" from the above.

Krzysztof
