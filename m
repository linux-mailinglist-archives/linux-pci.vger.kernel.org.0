Return-Path: <linux-pci+bounces-33985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66727B253C5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA51C8113C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0E23B63F;
	Wed, 13 Aug 2025 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYjpt2o4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40A1DA61B;
	Wed, 13 Aug 2025 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112581; cv=none; b=oFHC2tLwr0AkFXHqZKWC2lgwi5sBfSWzPQ0yzjd8eiuh/T20vGybzWoq33q+ucyJ3QAyXa3i30Yiv79i4jDBHDtM2ThBIJj8HbGFcslvp0gknbaZGihmylAEyzzmNxRebkob3bFlayRY3mKgWjnUK0Y7qL7ZvimOQ3y14ukYGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112581; c=relaxed/simple;
	bh=SrD7w4wNZc71J2evr6YFzbwB0L5seN4I2VncGYN8LX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK5gkGN+KDHbIrbvg/5pQFb5T1B11whPhLzNkcTZfwD/9iPPQ1FgFCbnXxRiV5bDBbaux/OM1h75LqUdNRp53Nvf0GMtmaNUgQotMbvcfLb83lkg296ACVA0IBgzVI+7KdeHCrG9wHN2M4WBesNcMA4TGOg4p1hKYWrcMPjN1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYjpt2o4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC0C4CEEB;
	Wed, 13 Aug 2025 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755112580;
	bh=SrD7w4wNZc71J2evr6YFzbwB0L5seN4I2VncGYN8LX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GYjpt2o4qCbBWFY3ZOXdIeuqaUF2+X41Jx4IL0FkPmwGsbYTIOm6GygE/0hpmLz2u
	 bKsOWiO/i/EV0jg3kupQj/8UsETyx3IjublE7dBokT+2IEtBgzLZRiXH9n0UfdTJxt
	 IZ3sT4CATuC/Xf5O02ufFp1YtkOQ4Vmc28XhkBLyiomnPA02Dyi67J0/dYi9VLZUYh
	 ZqnL57SIYcpnzkuGO5KbicLaGwwp8HK5oISfBgIDJ/+HKF+MXAQKSVYvhgjW+cUN33
	 gbP5iS5pdmy7mwQBESX+fbPKi9EucrNjcHp+d4QdgMxn8t2tlJ1Qeb8f9T4D2Gex9/
	 tFPNgCuBtGmMw==
Message-ID: <beaa6802-8abe-4cc7-a852-8ecbd60a536c@kernel.org>
Date: Wed, 13 Aug 2025 21:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/13] PCI: sky1: Add PCIe host support for CIX Sky1
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
 kw@linux.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
 peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-11-hans.zhang@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250813042331.1258272-11-hans.zhang@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 06:23, hans.zhang@cixtech.com wrote:
> +static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret = 0;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "reg");
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "Parse \"reg\" resource err\n");

Syntax is return dev_err_probe, and without \" so grepping works
correctly (see coding style).

> +		return PTR_ERR(base);
> +	}
> +	pcie->reg_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!res) {
> +		dev_err(dev, "Parse \"cfg\" resource err\n");
> +		return -ENXIO;
> +	}
> +	pcie->cfg_res = res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
> +	if (!res) {
> +		dev_err(dev, "Parse \"rcsu\" resource err\n");
> +		return -ENXIO;
> +	}
> +	pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));

Why aren't you using wrapper over get_resource and ioremap? Isn't
devm_platform_ioremap_resource_byname exactly what you want?

And if argument from previous versions was - you need to backport it for
ancient 3.10 kernel - then it would be a no go.

> +	if (!pcie->rcsu_base) {
> +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
> +	if (!res) {
> +		dev_err(dev, "Parse \"msg\" resource err\n");
> +		return -ENXIO;
> +	}
> +	pcie->msg_res = res;
> +	pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!pcie->msg_base) {
> +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> +		return -ENOMEM;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sky1_pcie_parse_property(struct platform_device *pdev,
> +				    struct sky1_pcie *pcie)
> +{
> +	int ret = 0;
> +
> +	ret = sky1_pcie_parse_mem(pcie);
> +	if (ret < 0)
> +		return ret;
> +
> +	sky1_pcie_init_bases(pcie);
> +
> +	return ret;
> +}
> +
> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +
> +	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
> +				      0, LINK_TRAINING_ENABLE);
> +
> +	return 0;
> +}
> +
> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +
> +	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
> +				      LINK_TRAINING_ENABLE, 0);
> +}
> +
> +
> +static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
> +{
> +	u32 val;
> +
> +	val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
> +				  IP_REG_I_DBG_STS_0);
> +	return val & LINK_COMPLETE;
> +}
> +
> +static const struct cdns_pcie_ops sky1_pcie_ops = {
> +	.start_link = sky1_pcie_start_link,
> +	.stop_link = sky1_pcie_stop_link,
> +	.link_up = sky1_pcie_link_up,
> +};
> +
> +static int sky1_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct sky1_pcie_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *cdns_pcie;
> +	struct resource_entry *bus;
> +	struct cdns_pcie_rc *rc;
> +	struct sky1_pcie *pcie;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	pcie->data = data;
> +	pcie->dev = dev;
> +	dev_set_drvdata(dev, pcie);
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	ret = sky1_pcie_parse_property(pdev, pcie);
> +	if (ret < 0)
> +		return -ENXIO;
> +
> +	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
> +				    &pci_generic_ecam_ops);
> +	if (IS_ERR(pcie->cfg))
> +		return PTR_ERR(pcie->cfg);
> +
> +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	rc = pci_host_bridge_priv(bridge);
> +	rc->ecam_support_flag = 1;
> +	rc->cfg_base = pcie->cfg->win;
> +	rc->cfg_res = &pcie->cfg->res;
> +
> +	cdns_pcie = &rc->pcie;
> +	cdns_pcie->dev = dev;
> +	cdns_pcie->ops = &sky1_pcie_ops;
> +	cdns_pcie->reg_base = pcie->reg_base;
> +	cdns_pcie->msg_res = pcie->msg_res;
> +	cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
> +	cdns_pcie->is_rc = data->reg_off.is_rc;
> +
> +	pcie->cdns_pcie = cdns_pcie;
> +	pcie->cdns_pcie_rc = rc;
> +	pcie->cfg_base = rc->cfg_base;
> +	bridge->sysdata = pcie->cfg;
> +
> +	if (data->soc_type == CIX_SKY1) {


Dead code or rather if (true) code. Don't do it, it's more difficult to
read.

> +		rc->vendor_id = PCI_VENDOR_ID_CIX;
> +		rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
> +		rc->no_inbound_flag = 1;
> +	}
> +
> +	ret = cdns_pcie_hpa_host_setup(rc);
> +	if (ret < 0) {
> +		pci_ecam_free(pcie->cfg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct sky1_pcie_data sky1_pcie_rc_data = {
> +	.reg_off = {
> +		.is_rc = true,
> +		.ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
> +		.ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
> +		.axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
> +		.axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
> +		.axi_master_offset = SKY1_AXI_MASTER_OFFSET,
> +		.axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
> +		.axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
> +		.axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
> +	},
> +	.soc_type = CIX_SKY1,

You have only one device variant, so this entire pcie_data feels redundant.

> +};
> +
> +static const struct of_device_id of_sky1_pcie_match[] = {
> +	{
> +		.compatible = "cix,sky1-pcie-host",
> +		.data = &sky1_pcie_rc_data,
> +	},
> +	{},



Best regards,
Krzysztof

