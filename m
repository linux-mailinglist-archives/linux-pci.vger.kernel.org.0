Return-Path: <linux-pci+bounces-40002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E663C27835
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 06:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78631B211F0
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0923E340;
	Sat,  1 Nov 2025 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma/A3kRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402A1B142D;
	Sat,  1 Nov 2025 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973654; cv=none; b=nVmUeIj38kVzb87fKBS7nt///GwCFqbrolMACCVaDoBq2nqGU+qHRHdu2eYyJHuXoiP02v51nPguTct7vBMaDsr/Cwxvog+zZkkRdvfo0Hy4Jgr2abXq3chH8rFImc9a0sQjtTmKsBEa5BO+7y7R7mi2jsLS6EsnH3y+hgJmQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973654; c=relaxed/simple;
	bh=vh1IH/J6OM8KcA8D4ugLF4dbyu34YdRqv94rrFNZ0Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu2J9fMhqcewkMrHgbrqTCNqFvZOrvNv1Oe1eUzGRFSGBJkWsXVmJnX8Yj106vuAIL2iPU6U3RZIErYIDTGLXZfb8VFPv/9E5VcjG2Lk2CnoLeII2B51kI8vhFZZ1LDv/B3hn1GcE4FcuqM0wlAEWV9b/TdFEm7RGdS3YFXloaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma/A3kRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EB0C4CEF1;
	Sat,  1 Nov 2025 05:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761973652;
	bh=vh1IH/J6OM8KcA8D4ugLF4dbyu34YdRqv94rrFNZ0Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ma/A3kRc9DgB4x3Uu2gzWmPOWnX2J1ge7nN2RkTUz9KxreMr6LN2d4eKlYc+7B+Wh
	 rfNFOcM8QlxROtg0SnjxL08CUNj7j/EBdmc6Hysbo7eDDuY6tSNimMpmYWFwRS83ZA
	 HcCvUwaZiS88bLSN4Qdk1ac0Y5p0ZYldaUAMOUq36OMmpPZsjQhcRzaDWB7H9W8+oN
	 Z5jMkmUSe7bbKt3uP3MnHMtsOYXKqCn4XXXwDslvCMV2QjshS10uByh42VGjX7HPm3
	 DuNNEV2L/Np1bJaKkXqKpl/V5gpPzz/vxWmcSE8WJBA85dZbyE7MyUz5Taf7rhqnnU
	 vKZ6JLIXc9IXw==
Date: Sat, 1 Nov 2025 10:37:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 5/7] PCI: qcom: Add support for assert_perst()
Message-ID: <7tr5drcuxmd4la63xjg2nesykjekxmffpc2m2adfjbttvtsflg@gr73iyhhqvmw>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
 <20251101-tc9563-v9-5-de3429f7787a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251101-tc9563-v9-5-de3429f7787a@oss.qualcomm.com>

On Sat, Nov 01, 2025 at 09:29:36AM +0530, Krishna Chaitanya Chundru wrote:
> Add support for assert_perst() for switches like TC9563, which require
> configuration before the PCIe link is established. Such devices use
> this function op to assert the PERST# before configuring the device
> and once the configuration is done they de-assert the PERST#.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eba496bc99ca82051dee43d240f359..cdc605b44e19e17319c39933f22d0b7710c5e9ef 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -696,6 +696,18 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_assert_perst(struct dw_pcie *pci, bool assert)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (assert)
> +		qcom_ep_reset_assert(pcie);
> +	else
> +		qcom_ep_reset_deassert(pcie);
> +
> +	return 0;
> +}
> +
>  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -1516,6 +1528,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> +	.assert_perst = qcom_pcie_assert_perst,
>  };
>  
>  static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

