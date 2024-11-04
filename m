Return-Path: <linux-pci+bounces-15969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA39BB7F1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A771C231D4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3551BE841;
	Mon,  4 Nov 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8U5cxqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563B1B3F3D;
	Mon,  4 Nov 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730928; cv=none; b=kEtDjaMuly/n8ftQrEXu5NmcuffF1Xdw9SYfeTh6nArZXdm/Gej5ZzdbARs7rB1FPnK2T6F8fZ3h5DylDZ31rNxFUxZhy1d3p7V57UeHMbL94El+44HlbW9o3QfAdA5QTHIKqbCgRVq7QgQi0vlmIgQXSa4JuGY1dLjDDgkZGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730928; c=relaxed/simple;
	bh=eXPI8qxXkARRJv6XlO2w7vOxmVFZ4CQ/UGlKNBeaFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7I5zAAVbny3KUBykSPf/L/TkEyVzp6b68T8TZ/BHbMUxCWHDxToEpgOA9qdRlAsBtLJUMjOp9Uv5HsMg4DEFE0pf/BRJhErrRBcCysk09QV5+CYw9zWQoS1uy1JZuy/yPCfme8UYzAs5Ci/oReJ/DGyOG9B/uJQ0mj3735bzRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8U5cxqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF07C4CECE;
	Mon,  4 Nov 2024 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730926;
	bh=eXPI8qxXkARRJv6XlO2w7vOxmVFZ4CQ/UGlKNBeaFLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8U5cxqKgBeidDWvBqbZfYkcFafSMpOczE+HNoD2bqT3hSp7UMnGBt8X0yIKFflXI
	 PBDDSHxD8STQoB3gDLCgH2gGSZsUUbv4Zgj/px9xSXRU5XKYqcRCmdKyNNYHI9CoO/
	 DrW6pbmwYf5LfA7FL0KGAvYPSiOkgF+wBcn/Wjh3z3j/yerMwP2tTSDo53lPc1khtN
	 +DmwKWPfnM055gQqegq3VNdigIGf/WRgaY+DOibRZR0syX9P+ZAx9y4egmqsYgepWe
	 fFeem8xZkRkedmH75K+6KyzQEmaApbRe3sWIJYCkZNgSLb/Ozgqi+lQgy/ZGixQRqa
	 tm71nlPo+M2Aw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t7yAu-000000008HJ-1mv2;
	Mon, 04 Nov 2024 15:35:24 +0100
Date: Mon, 4 Nov 2024 15:35:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <ZyjbrLEn8oSJjaZN@hovoldconsulting.com>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101030902.579789-6-quic_qianyu@quicinc.com>

On Thu, Oct 31, 2024 at 08:09:02PM -0700, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
 
> +		pcie3: pcie@1bd0000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-x1e80100";
> +			reg = <0x0 0x01bd0000 0x0 0x3000>,
> +			      <0x0 0x78000000 0x0 0xf1d>,
> +			      <0x0 0x78000f40 0x0 0xa8>,
> +			      <0x0 0x78001000 0x0 0x1000>,
> +			      <0x0 0x78100000 0x0 0x100000>,
> +			      <0x0 0x01bd3000 0x0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 0x3d00000>,

Can you double check the size here so that it is indeed correct and not
just copied from the other nodes which initially got it wrong:

	https://lore.kernel.org/lkml/20240710-topic-barman-v1-1-5f63fca8d0fc@linaro.org/

> +				 <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
> +			bus-range = <0x00 0xff>;

> +			clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
> +				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "noc_aggr",
> +				      "cnoc_sf_axi";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&pcie_south_anoc MASTER_PCIE_3 QCOM_ICC_TAG_ALWAYS

This should be &pcie_north_anoc

> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";

With the above addressed, feel free to keep my Reviewed-by tag.

Johan

