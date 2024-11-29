Return-Path: <linux-pci+bounces-17470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B139DEC48
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377D5281DFB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13363156649;
	Fri, 29 Nov 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAKh8Ysw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8B3224;
	Fri, 29 Nov 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732907337; cv=none; b=bvSjqUNTITgRwZO1kgkXVw+DwBx4skehELCgZ6xxEj9Ju88uqLp7a8ojbnu8qoCs4wtANOy8AI6JsFvGOR0Yest4jaZ/IIC9HOXfbtd5hknPZRXZULrw27RrHGlljPnefsfhE5gU0Lama8U7dqmNBSZKZHUMjRGXLgAq20s07o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732907337; c=relaxed/simple;
	bh=W7Vm0c37DPHmUeeFB1k3BNHaU33p3uZ42pyukGFCFXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ED8s2xRZz//pw4gcZsW63uVIZu4XnD7Wl873H9RE4sbTdfmhUh7VC8JH3PUYkuSGkKb6WzYm61lQAnpMVs0TfLgUr09TYfDc4yQ5JisedZbL0bvq1rFuGS/6kdkqcwDGt794m6ZR8H5vV+fDGoYEA/dxgmz5oyKta4EVYJBDb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAKh8Ysw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19EDC4CECF;
	Fri, 29 Nov 2024 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732907336;
	bh=W7Vm0c37DPHmUeeFB1k3BNHaU33p3uZ42pyukGFCFXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rAKh8YswPbE2+n1dh1WvdhRxb1FNWEpo1HfViFmvqPNcwxyIUGLG18AJEL1WaNkxh
	 b4B1ACVZPMY8Zn9BIrw1NfHK2tzbG7Xf5FKc39/9GAz9DdEZZ6tsuG4OH7YZsThAwe
	 3r+rIsGleh6dWlWL+1sB5gcfRcSktRcNNEBgvg/oWpZtg2squMHReRMERSa+5AuXRw
	 WI3LTldvfQ/aqotz/54vcPmLicGf8CFz+k2eGEzG8FtEiV5jqqwHf/LEZB3l4qLuXz
	 dzQ+tsDmV0jVPFI/dRGy1b8Rnvx8gzxcX7wCVGo4Fo5G43YumJ8XzQIaL+KmA9UD8a
	 jw71Yaf5sQuIA==
Date: Fri, 29 Nov 2024 13:08:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
	lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
	neil.armstrong@linaro.org, andersson@kernel.org,
	konradybcio@kernel.org, quic_tsoni@quicinc.com,
	quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
	quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
	quic_aiquny@quicinc.com, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/8] PCI: qcom: Add QCS8300 PCIe support
Message-ID: <20241129190854.GA2768465@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128081056.1361739-5-quic_ziyuzhan@quicinc.com>

[+cc linux-pci]

On Thu, Nov 28, 2024 at 04:10:52PM +0800, Ziyue Zhang wrote:
> Add support for QCS8300 SoC that uses controller version 5.90
> reusing the 1.9.0 config.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..5932b228aa17 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1830,6 +1830,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-qcs8300", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>  	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> -- 
> 2.34.1
> 
> 

