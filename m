Return-Path: <linux-pci+bounces-40621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC7C42D2F
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8DE4E1B53
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00119005E;
	Sat,  8 Nov 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dV9AIGO5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005F34D3A9;
	Sat,  8 Nov 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762607399; cv=none; b=QBvwxbJL7bDSoVzcJitOYqbtcwRRjPBgb4ZgWy0cO+IptdOl9s2NRld9m1xptmy/W1FYa2Fjpdr4mpEIK6qEYfQ5snWhJJFj+yBEuvdM+GIYEi9dehSIwQTCE6ZkPbUJ4Hlt3rtS9nHCxhfJBzYR1XjXtmLFOIN/vONr65f8ezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762607399; c=relaxed/simple;
	bh=eDlMDq1XI0QJzQ19YXeN2G+kTl1DYm/+RWUFzDzitbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOkq/2rRoSy/ow5LqaTl+IGZn6R12PSzGVwEh9N220Lir0GvJ/ZOXYjyJ2Fh6BkQ7o1V0DKrGAi1zHWPZEI5Y968eCaE0XP4NABhjN41DSwtLRHPAHncT6U03Xv4U7MMEcXSrXuHIbHW4HU6mmw1yLtbRQ5YeFCMICDaUhbP6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dV9AIGO5; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id HiYOvhfDuznX9HiYOvZaHP; Sat, 08 Nov 2025 14:00:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762606833;
	bh=aRGRFm8nQr5WAaRrinpk9KWjIa54yU+4iQS0RwjiVHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dV9AIGO5VvC+elQurmqsLtlcfKPFa9KJWs8T1UvJRBZI65JlxwrheFUYsvpgm+6ts
	 1hHHejsRTLicDpc+yCdmFZ4BG0PM6zrEZT4MCL5zjANBryR2NUeCcGQ/v/zFbq2kTQ
	 nSnB/51xKINEALpZ9sHEvOJatXQlMyqLoKMI/2TH63GNAW83WRTEA8sDY+JgTZGcEu
	 uX14hXVl/IMt+Umpij8cvguLgma1IcTPbhUSU+K2m9/BdkGXzP8fP3lSjDd08ImQTQ
	 Aoa3r8nYM23m/XdHeVqP3R05IsLFaV2dKJYIo0kQ0bxShUNL9CY5nBc03QDNgEJkuw
	 wX6SPDTFC2dyQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Nov 2025 14:00:33 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <120b2f62-25e6-4ea3-9907-230080c61f70@wanadoo.fr>
Date: Sat, 8 Nov 2025 14:00:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] PCI: spacemit: Add SpacemiT PCIe host driver
To: Alex Elder <elder@riscstar.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: dlan@gentoo.org, aurelien@aurel32.net, johannes@erdfelt.com,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, guodong@riscstar.com,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251107191557.1827677-1-elder@riscstar.com>
 <20251107191557.1827677-6-elder@riscstar.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251107191557.1827677-6-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/11/2025 à 20:15, Alex Elder a écrit :
> Introduce a driver for the PCIe host controller found in the SpacemiT
> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
> The driver supports three PCIe ports that operate at PCIe gen2 transfer
> rates (5 GT/sec).  The first port uses a combo PHY, which may be
> configured for use for USB 3 instead.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---

...

> +static int k1_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct k1_pcie *k1;
> +	int ret;
> +
> +	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
> +	if (!k1)
> +		return -ENOMEM;
> +
> +	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
> +						       SYSCON_APMU, 1,
> +						       &k1->pmu_off);
> +	if (IS_ERR(k1->pmu))
> +		return dev_err_probe(dev, PTR_ERR(k1->pmu),
> +				     "failed to lookup PMU registers\n");
> +
> +	k1->link = devm_platform_ioremap_resource_byname(pdev, "link");
> +	if (!k1->link)

if (IS_ERR(k1->link)) ?

> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to map \"link\" registers\n");

Message with -ENOMEM are ignored, so a direct return -ENOMEM is less 
verbose and will bhave the same. See [1].

But in this case, I think it should be PTR_ERR(k1->link).

[1]: 
https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/base/core.c#L5015

> +
> +	k1->pci.dev = dev;
> +	k1->pci.ops = &k1_pcie_ops;
> +	dw_pcie_cap_set(&k1->pci, REQ_RES);
> +
> +	k1->pci.pp.ops = &k1_pcie_host_ops;
> +
> +	/* Hold the PHY in reset until we start the link */
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
> +			APP_HOLD_PHY_RST);
> +
> +	ret = devm_regulator_get_enable(dev, "vpcie3v3");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get \"vpcie3v3\" supply\n");
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_no_callbacks(dev);
> +	devm_pm_runtime_enable(dev);
> +
> +	platform_set_drvdata(pdev, k1);
> +
> +	ret = k1_pcie_parse_port(k1);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse root port\n");
> +
> +	ret = dw_pcie_host_init(&k1->pci.pp);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize host\n");
> +
> +	return 0;
> +}

...

> +static const struct of_device_id k1_pcie_of_match_table[] = {
> +	{ .compatible = "spacemit,k1-pcie", },
> +	{ },

Unneeded trainling comma after a terminator.

> +};
> +
> +static struct platform_driver k1_pcie_driver = {
> +	.probe	= k1_pcie_probe,
> +	.remove	= k1_pcie_remove,
> +	.driver = {
> +		.name			= "spacemit-k1-pcie",
> +		.of_match_table		= k1_pcie_of_match_table,
> +		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_platform_driver(k1_pcie_driver);


