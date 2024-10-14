Return-Path: <linux-pci+bounces-14494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CDD99D57C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60387284E57
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29951BFE10;
	Mon, 14 Oct 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jspzCD3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC01B85E4;
	Mon, 14 Oct 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926402; cv=none; b=ILPuuHFLFGmyhtKOlRCY8WNA4LoJiW5w6xu1emQkI53EbO3pR48pbFdUbNdjE/fQJDkldgDfRC85CQiK9PeXfR0xbFKbtOI9JAqiSIBKHgFft2BT0h1fBV92J/83Ni98d+HiIJZo937TxM9qkN0RQB5QPSNlOtMT8NuE27HR8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926402; c=relaxed/simple;
	bh=Np62Up9il5vG205tNL0IREXGDm1XoBvQ7ES3tBuqiSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hrpSJ2XNhuUyaTSmyieAIO5iD4/WBdvB7ON5IZA1XV8WdozLxF/Wgow7KUamNTfc8BOuuISpKJWHS9zyYZDbCZoOYPUMgWFN3r8C4NbMauk216bBRI1GLUSj0vJLJLB4zR903XyMFYWFL3AQI0vSyd1Z4tyfIHUGoFH4Fo75Q/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jspzCD3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD114C4CEC3;
	Mon, 14 Oct 2024 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728926402;
	bh=Np62Up9il5vG205tNL0IREXGDm1XoBvQ7ES3tBuqiSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jspzCD3Aw3An6B7xeaJtD5Ud6xL8ZrkU8JKHagUm6ZeV/tFf4S2LVwyIhekC5k01B
	 3PKDIXVihcupi6fa5Q4sslzbf1jWHiGD3lms0g4ZJ7GwTpZ8RjResdB6UG8EJ557VU
	 jih+np1a8BCduiGQU21NjIDWK36NB7KJafvW8k5iKQdpznPNS5O6Na6C2YBppYlEiq
	 lRVaduMQTW0etlOIzZgPvXngyx92wk+fCCIBya9A6XrRJqJZ0i9amqI6T63aCg0wwr
	 sVQW0WK1os1tKPuOH68F7rA3u3lJIYn+GBoLxMprNKuDK0PjdoOS1TtTYikv/WGrAM
	 YVu2VdGp9CRZg==
Date: Mon, 14 Oct 2024 12:20:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 7/8] PCI: qcom: Fix the cfg for X1E80100 SoC
Message-ID: <20241014172000.GA612658@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011104142.1181773-8-quic_qianyu@quicinc.com>

On Fri, Oct 11, 2024 at 03:41:41AM -0700, Qiang Yu wrote:
> Currently, the cfg_1_9_0 which is being used for X1E80100 has config_sid
> callback in its ops and doesn't disable ASPM L0s. However, as same as
> SC8280X, PCIe controllers on X1E80100 are connected to SMMUv3 and it is
> recommended to disable ASPM L0s. Hence reuse cfg_sc8280xp for X1E80100.

Say something specific in the subject line.  Apparently you need to
disable ASPM L0s for this SoC, which is important to know and much
more useful than "Fix the cfg".

> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 468bd4242e61..c533e6024ba2 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1847,7 +1847,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 

