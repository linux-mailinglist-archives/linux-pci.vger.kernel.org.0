Return-Path: <linux-pci+bounces-10011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6492C11D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6207288B6D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519851A4F07;
	Tue,  9 Jul 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGCb+20a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5F19A86E;
	Tue,  9 Jul 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542383; cv=none; b=ASntNNheEu9Ziz/SmdlzOdTM1OCjo9Lt1h+mxgkopQSFpvtLEW7YBPC+ZSVo4mm37zmHNy+hQ+EwK9qWBscwDladQpjMIakWLW7Lv3603P6BzYYzL4++6XnU296GsaCsQHHhK2bRQEJXYgsifphGNO0QLadhy0iA8GAFOfgzVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542383; c=relaxed/simple;
	bh=9LvZ/VKou4FmKLWBcdKcpGHtv7xBlcn4z4HXRAwZyhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KyyQbehREAQ3GP4fQC/22XlhgQobneS/kl5HCMMjmT3GnMnx+jILzMw2flPY6dCoWURzTNWetPynS12EUAqNwNzzIw8OCrbu1tXCCdOMaBKjonviUHEA4A3J+Q1Jvf8XdCNs+pPJNafDkdSnv1m/iR7ceziKcLMLzR7k6VrYFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGCb+20a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF199C3277B;
	Tue,  9 Jul 2024 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542383;
	bh=9LvZ/VKou4FmKLWBcdKcpGHtv7xBlcn4z4HXRAwZyhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aGCb+20aGOoaL23EBtm/kEXkY2NUQakENOVw3rJLSQHVugpNqzGFu2ENhy9gHOD4A
	 mqDDj7BAmOh5va/DLjP9EM8LlJFBk5VfvwDcsmC8VI0YpcFybjy9ZD83qD5VwPI+KP
	 x5FXerm2/Dky43YYqzG13DyQ66KoaEFVA/Vck0sd03sQZt+hEt18l0hYPxuVoHJLrD
	 llb5w1f7M6cTCkYz4fN63YfVsNksePrJq4/LXbXTJrKbX/6xaR2ylI1gbFfeiaYu6A
	 cj6u+Jg1noOyKY6N8cr+iIs5+axnfqqJrie9+0dIwQDaztCBsbhEZWMGtW/FU+OqRc
	 Peb5tDF8ezMvg==
Date: Tue, 9 Jul 2024 11:26:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom-ep: Add HDMA support for QCS9100 SoC
Message-ID: <20240709162621.GA175973@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-add_qcs9100_pcie_ep_compatible-v2-2-217742eac32b@quicinc.com>

On Tue, Jul 09, 2024 at 10:53:44PM +0800, Tengfei Fan wrote:
> QCS9100 SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP,
> so add support for it by passing the mapping format and the number of
> read/write channels count.
> 
> The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
> config struct is introduced for the sake of enabling HDMA conditionally.

This patch doesn't add a new config struct.

> It should be noted that for the eDMA support (predecessor of HDMA), there
> are no mapping format and channels count specified. That is because eDMA
> supports auto detection of both parameters, whereas HDMA doesn't.
> 
> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to the PCIe device
> match table.

This series doesn't add the new SCMI stuff you mention.  It sounds
like this should be deferred and added when you actually move to using
SCMI resources.

> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 236229f66c80..e2775f4ca7ee 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -904,6 +904,7 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>  };
>  
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> +	{ .compatible = "qcom,qcs9100-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>  	{ .compatible = "qcom,sm8450-pcie-ep", },
> 
> -- 
> 2.25.1
> 

