Return-Path: <linux-pci+bounces-12834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077496DAB5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069FD1F23BEF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1319DF43;
	Thu,  5 Sep 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic4Ek1ZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA019D8B2;
	Thu,  5 Sep 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544064; cv=none; b=OAoIUjFlDTshlmo3Te0WRJGzJLfQ8LiwSrB8pPkF69hAkqjsYCDhLrMwH6qJM/wk9HoW8ChkkSsbDqAtcpu0fhKSP8cfUVj35VkK0flvgJYwCpyunxI6QKde9SzuJkbr1VfOvlAYZ44Ibas0P5Oomz7/tgtqtqjR5n7OxYjfvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544064; c=relaxed/simple;
	bh=71k1Ochv2FC5okt+9RprHRdYfaZu9bLcTVyeNCoL8r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KOoLhUkrH9YS4RQ9Z+xE3ZUQcP0JdJEf2YOTMMeJnqjiHXB6l5MmNPtGYz/BYVCWUQemepY2UA3wtHpxFai4Pu8XLUlPJrpLfb1pjfINTdjvzgBojffIwMY4vjXHmZpMIYisg/yBjBnmyUNP+bWkoGqicp+OLOAgvAjMod4MLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic4Ek1ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9B8C4CEC3;
	Thu,  5 Sep 2024 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544063;
	bh=71k1Ochv2FC5okt+9RprHRdYfaZu9bLcTVyeNCoL8r0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ic4Ek1ZWVl2lJ8st6GLtIkODrTBG+tf6NAuQKe0HntNEZtlPOU3NhnbxBEqQsxEeO
	 lojnuwiLsh4fDvhuRdQ3RNPP9n0j1LUmqXE9Qa5p94Dl7aVI1DUSU/eb+VD2kiVKDR
	 nqLceoTE0a2E4rrvsOVxdOF1xtjNfyAoYv2fQ5owncvVeq56Jyi50hLnUSBUkAb+8D
	 9bJub1/7+0vLx17fpJxoJ2twc9u/YJ3tcXmpR1afOUaUni6SYKwcglEg9B6h+F/cVB
	 lFKYgWngayZyCwCJzcHx+jea01T583hMuwAhVq4qsqkyCt9fHmnYmYZKZZpV26P54B
	 sArasEpU95tMA==
Message-ID: <bf114807-c56c-4209-ab26-9e90ac00cedf@kernel.org>
Date: Thu, 5 Sep 2024 15:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
To: Sricharan R <quic_srichara@quicinc.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org,
 quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 robimarko@gmail.com
References: <20240830081132.4016860-1-quic_srichara@quicinc.com>
 <20240830081132.4016860-4-quic_srichara@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240830081132.4016860-4-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.08.2024 10:11 AM, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add Qualcomm PCIe UNIPHY 28LP driver support present
> in Qualcomm IPQ5018 SoC and the phy init sequence.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---

[...]

> +static const struct qcom_uniphy_pcie_data ipq5018_2x1_data = {
> +	.lanes		= 1,
> +	.lane_offset	= 0x800,
> +	.phy_type	= PHY_TYPE_PCIE_GEN2,
> +	.init_seq	= ipq5018_regs,
> +	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
> +};
> +
> +static const struct qcom_uniphy_pcie_data ipq5018_2x2_data = {
> +	.lanes		= 2,
> +	.lane_offset	= 0x800,
> +	.phy_type	= PHY_TYPE_PCIE_GEN2,
> +	.init_seq	= ipq5018_regs,
> +	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
> +};

As krzk suggested, the difference is just num-lanes

[...]

> +static int qcom_uniphy_pcie_power_off(struct phy *x)
> +{
> +	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> +	
> +	reset_control_assert(phy->resets);

Is the reset line supposed to be kept asserted?

[...]

> +MODULE_LICENSE("Dual BSD/GPL");

Was that intended?

Konrad

