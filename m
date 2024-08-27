Return-Path: <linux-pci+bounces-12267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A39960818
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42061C223E7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541319E7FF;
	Tue, 27 Aug 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWnmJFwM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7323158D9C;
	Tue, 27 Aug 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756559; cv=none; b=hHdn0mYO9yuuTzOlOyltszUKRT/NApAOnGxqa+cyVmnvBDKsozdeAEb5LOWvBX0rQ0/XMjWSP0cbKd7oc8yeZJMVe/tM9j3JKlgD9Lyx2hyXkINvK6RHwK5EkhHCCxwPTWPjLW5JMhpt3jqp3MB1xDgMf88xKBZF84x2ujRd4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756559; c=relaxed/simple;
	bh=AdxxyU7osmJMtOozW5BsXf+2/zQypAfNNaF3yzunBVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/UA9w5MpZ2UHP7yfayW+/19xibTZAlfLAKaL1prOIYsF3TxIzu7RYatDkC1V4kAnt6lfawT7pUWcYp2FOAFzP9Rd2TDgRRwM6B/zZQAIQC+kyKsgZq6T1IJ+/zPI6YYArPF9ycbUvxLx877UoZ77R8rMq1x2jpEBALD77CrnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWnmJFwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCA7C8B7A0;
	Tue, 27 Aug 2024 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724756559;
	bh=AdxxyU7osmJMtOozW5BsXf+2/zQypAfNNaF3yzunBVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fWnmJFwMfvSprxmKFgXSpRKb2p6ZxhMsPV+1W75GynZLR7cYyCHoF2/5c6NKrBLug
	 oQjbcA0JCpLRSQXh/SwKhW4UuOrUP0GaMChkPVPom7YSoL4889apIwavlckTM8kTQD
	 PQqGO3HegTX9dcaqzYmXKnbO5pG0xwwdnDVpySOBfjskKyvbBeU2emKSkS+SzIL5N+
	 V5iN9YtvertY+9qj7EI/r+Abt0WlFwupNDvTM/Fhvn17A/XAwOSSYCcrrunMAjXxLv
	 q/8xla2Cl1AxeIsSZ5ySnt0+vNGU1vuZf9D/UmQvvgYTvCWkqlXTqewQMFnekfvl/I
	 u2wB68YFyTwPA==
Message-ID: <52b32254-8468-4fba-8357-0edc54dee129@kernel.org>
Date: Tue, 27 Aug 2024 13:02:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
To: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240827063631.3932971-9-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.08.2024 8:36 AM, Qiang Yu wrote:
> On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
> support to use 3.3v, 3.3v aux and 12v regulators.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6f953e32d990..59fb415dfeeb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
>  	bool no_l0s;
>  };
>  
> +#define QCOM_PCIE_SLOT_MAX_SUPPLIES			3
> +
>  struct qcom_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
> @@ -260,6 +262,7 @@ struct qcom_pcie {
>  	struct icc_path *icc_cpu;
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
> +	struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
>  	bool suspended;
>  	bool use_pm_opp;
>  };
> @@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> +static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
> +				    pcie->slot_supplies);
> +	if (ret < 0)
> +		dev_err(pci->dev, "Failed to enable slot regulators\n");

return dev_err_probe would be a good call.. probably more so below,
but won't hurt to use here too

> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
> +{
> +	regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
> +			       pcie->slot_supplies);
> +}

This I feel like is overly abstracted

Konrad

