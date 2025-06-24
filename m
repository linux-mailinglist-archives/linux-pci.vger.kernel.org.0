Return-Path: <linux-pci+bounces-30550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BEAE710E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378F01BC04B6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541412580E1;
	Tue, 24 Jun 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9ff+ZYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353C2405E8;
	Tue, 24 Jun 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798257; cv=none; b=libW00dCK+A7iTHvill9KKHY+IsJGRMvtBv3VJVFFqByYxZLvkLQtECIZE9z+qpGNf3r+QdckqM9NeWb/Zi0O+PIPGb5C3G3NpUdhiypwYlyVcY4wlcLNMEBiqASilJtHWSKKgy25SAlzou5qA9+IQIHb9XMHuZ4Vuri5KiIgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798257; c=relaxed/simple;
	bh=dIyciIdppZO/lATFkkLW4FQgxW1XqDcUdQSgW8wIwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLC35NfLIoOh616y2r8+h3UEh1+ku2+dzFHVUHytLaHl7ypCxugYudcKSbk9TJWT7BG1MhNbYg9IUP2AdpiQD3+Xr3Qmo2vC2BFCxoD0PhkpBK+1PDsvx9jcnjI6la/dlPA2fvA9G6NdhoU+ZkKG+ArsxxYlb93Sgl/+DXOX8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9ff+ZYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26642C4CEE3;
	Tue, 24 Jun 2025 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750798256;
	bh=dIyciIdppZO/lATFkkLW4FQgxW1XqDcUdQSgW8wIwBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9ff+ZYu3HCmJszJ0fVbEAYKgrOcCkOxE3sNeSowW8D7QJfaiHUVCm8FLLn7grBpp
	 OY2W8gY1MhReKjO0cjsCoRZ1EWY4/PyxgVJVOgVES/YFmNgu40q2fpyNimoW6ZpcsD
	 5pEBEMnumhmmw1nSaQf6KtyKi0Zcn2qV7CTqEe1bLtQDhkAD/NEBNyq99lxqzWCPbi
	 zNciBPlqrPGDXZXtoEWbhQFZEwfQXiqeIz2+A3582aDANo86oFjJFhHqVZxMxSlHG4
	 czcW4EaDi7UR+ySo+l6GVeVeeJaAh1FiAKgtbEzCOnl9F6J1u6IU/bAA8lE2XmgehS
	 Rv/97bAKWFOGA==
Date: Tue, 24 Jun 2025 14:50:53 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, dmitry.baryshkov@linaro.org, manivannan.sadhasivam@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8775p: Add PCIe lane
 equalization preset properties
Message-ID: <wfrmm3vj55w2rwxrkme7fy53zj5o7ubcfyqtggeiy6iu6mm4wf@odq6kdvkcnrv>
References: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
 <20250611100319.464803-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611100319.464803-3-quic_ziyuzhan@quicinc.com>

On Wed, Jun 11, 2025 at 06:03:19PM +0800, Ziyue Zhang wrote:
> Add PCIe lane equalization preset properties with all values set to 5 for
> 8.0 GT/s and 16.0 GT/s data rates to enhance link stability.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 45f536633f64..16caf1da0708 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -7159,6 +7159,9 @@ pcie0: pcie@1c00000 {
>  		phys = <&pcie0_phy>;
>  		phy-names = "pciephy";
>  
> +		eq-presets-8gts = /bits/ 16 <0x5555 0x5555>;
> +		eq-presets-16gts = /bits/ 8 <0x55 0x55>;
> +
>  		status = "disabled";
>  
>  		pcieport0: pcie@0 {
> @@ -7317,6 +7320,9 @@ pcie1: pcie@1c10000 {
>  		phys = <&pcie1_phy>;
>  		phy-names = "pciephy";
>  
> +		eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
> +		eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
> +
>  		status = "disabled";
>  
>  		pcie@0 {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

