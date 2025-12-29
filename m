Return-Path: <linux-pci+bounces-43796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E1FCE6AF9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 13:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C60203000DD1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152630FC0F;
	Mon, 29 Dec 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EEAyNpqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11361946C8;
	Mon, 29 Dec 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011423; cv=none; b=ZAVxC5jdOyMP7//jNpkYoVOu8shVnk96AFXmo/vdfuHweEVxUQRbpygC8pFV4sau7Rem8Lb0AMPea5T8a6La7+6FKdZeuK1ctFjkR5ZLLD2ZfNWb0mKt6jwtotjcprxSg+dPTUXfBWzu/Vr1WVM9/jac8hKqVYTrLAH7QTolrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011423; c=relaxed/simple;
	bh=8SqAamIhKPcweeDRupgsAJpevZj1OrLnixFWIuYKX4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWnM0zx59galVMvPbZn43qVwcT0FiNMZUhH/efM8BqQa4sRSGS6nktHXzRp05Gt87f0avu4MT2rvvHCixXnNf83rERD5JICjbQvjHvPMmJ1DQ3JkSS3Ak8+AND9eqg74U7eYlCeh5nQ0h1lLsop5ILzn9FUwD5vhr2LOuac4PWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EEAyNpqP; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id aCMvvMVMYjSZXaCMvvsf9B; Mon, 29 Dec 2025 13:29:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1767011346;
	bh=fSTbBzZnMi5ZmX6dfCrTLQPupOlRFVbrKDWxqD9sUZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EEAyNpqPCs8gLEK/CoU8lCVTUnmZne/tUclR1S++jDjlJQTL6L6Qe/gPlfDt/vJA6
	 F7fel6HYCEFjXD1cU/Pm0sARlzAwaCTBgp0l5u1X9ORvNNac/zjgNSr80nDUG95Lk4
	 u3dxHVWWIuubiwYW7GVmeYKYA3BEfDD5ODeSEwfpYmPL0WDNVydwSUf50ZEuIJmffi
	 +lcWbn1vITXNu/oYwRHiT9XzPlkWFXtyfzer2Uj3mZAW8kevgb+yRJsxcGdyO+nwHy
	 hR8X1vQvM3LNAcI5QH8U+MvDA5AnZJDbF5i7ueBeNE8BObUseu8IO0wP9/kmCue0yH
	 hM1It1jzYKiwQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Dec 2025 13:29:06 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <37ef98c2-b13f-4292-8db7-df90237c7ce1@wanadoo.fr>
Date: Mon, 29 Dec 2025 13:28:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, mani@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
 jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
 inochiama@gmail.com, Frank.li@nxp.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
References: <20251229113021.1859-1-zhangsenchuan@eswincomputing.com>
 <20251229113208.1893-1-zhangsenchuan@eswincomputing.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20251229113208.1893-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/12/2025 à 12:32, zhangsenchuan@eswincomputing.com a écrit :
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.
> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---

Hi,

> +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> +	struct eic7700_pcie_port *port;
> +	u32 val;
> +	int ret;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);

Is this the correct place to call this function?

eic7700_pcie_host_init() is called from eic7700_pcie_resume_noirq() and 
calling a devm function from a resume function is really unusual and is 
likely to leak memory.

> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(pci->dev, pcie->num_clks,
> +				     "Failed to get pcie clocks\n");
> +
> +	/*
> +	 * The PWR and DBI reset signals are respectively used to reset the
> +	 * PCIe controller and the DBI register.
> +	 *
> +	 * The PERST# signal is a reset signal that simultaneously controls the
> +	 * PCIe controller, PHY, and Endpoint. Before configuring the PHY, the
> +	 * PERST# signal must first be deasserted.
> +	 *
> +	 * The external reference clock is supplied simultaneously to the PHY
> +	 * and EP. When the PHY is configurable, the entire chip already has
> +	 * stable power and reference clock. The PHY will be ready within 20ms
> +	 * after writing app_hold_phy_rst register bit of ELBI register space.
> +	 */
> +	ret = reset_control_bulk_deassert(EIC7700_NUM_RSTS, pcie->resets);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert resets\n");
> +		return ret;
> +	}
> +
> +	/* Configure Root Port type */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
> +	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		ret = eic7700_pcie_perst_reset(port, pcie);
> +		if (ret)
> +			goto err_perst;
> +	}
> +
> +	/* Configure app_hold_phy_rst */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val &= ~PCIEELBI_APP_HOLD_PHY_RST;
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	/* The maximum waiting time for the clock switch lock is 20ms */
> +	ret = readl_poll_timeout(pci->elbi_base + PCIEELBI_STATUS0_OFFSET, val,
> +				 !(val & PCIEELBI_PM_SEL_AUX_CLK), 1000,
> +				 20000);
> +	if (ret) {
> +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
> +		goto err_phy_init;
> +	}
> +
> +	/*
> +	 * Configure ESWIN VID:DID for Root Port as the default values are
> +	 * invalid.
> +	 */
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_ESWIN);
> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_ESWIN);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +
> +err_phy_init:
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_assert(port->perst);
> +err_perst:
> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> +
> +	return ret;
> +}

...

> +DEFINE_NOIRQ_DEV_PM_OPS(eic7700_pcie_pm, eic7700_pcie_suspend_noirq,
> +			eic7700_pcie_resume_noirq);
> +
> +static const struct of_device_id eic7700_pcie_of_match[] = {
> +	{ .compatible = "eswin,eic7700-pcie" },
> +	{},

Nitpick: No need for trailing comma after a terminator.

> +};

CJ


