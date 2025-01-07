Return-Path: <linux-pci+bounces-19362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD2A033BE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 01:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A99416481F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3792582;
	Tue,  7 Jan 2025 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+zczdMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561615A8;
	Tue,  7 Jan 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208287; cv=none; b=Q/nc78Ee9JEzkyN6zcPkVYA5+cOa8ng7aW832OgGuMVERydFnoLMwvWQeNL3XX7sIek9Umwr4elh0IFs22g31rmrVCDfc7QVUuFlnd0axTyFqzSopeHLq6/SXiws5o/rcJDTM2IFGbvXunwFITPz0zk3VbIb6X+krmHq1Po8VCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208287; c=relaxed/simple;
	bh=nneDGW0N0cum5hpmpOoBmp7zkSGHFjVOpASa6IpSOgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwspkbrY7IkUSPUkM1RBBPxjD+yiFWWcSYLB1kd/2pCemRPohwTim+t0TH5keTBYZDMrIcwo54ptwMShvHE1vV1h33hoQpfOGz2MSslJuefJRek15J+7wSdB6RJ8kLzK3SMAUtXoqFtJyIRSxfYmFVVJVgYDBV5LnbsVARiIvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+zczdMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B15AC4CED2;
	Tue,  7 Jan 2025 00:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736208286;
	bh=nneDGW0N0cum5hpmpOoBmp7zkSGHFjVOpASa6IpSOgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+zczdMKciUCWmpHyQXHNVJgSFI08P3LbyrRkpR0PyI2Fl0+NS8WevJr+qN5Pd2vF
	 EGUkeD/tdZKM2OzB0LHqZBko6mkgQPLCYY8yMCUlMQlfqs4yRBViCp/fwdC21PDU+3
	 a5a73+O97ELO6VUyEGbrI7iLrUCf29zzD3wTSq+pW4N1B+8SCcVhDX2EvxMfXhOV6w
	 Ff/18zMeeI1MVJUlqmlvSMS65cZek3es/CKR2Mz2eC5iqHvlVMkH7XMvqEWC0Cu+s3
	 R5rAOKfZYWDjDpy67u7bzkGCfYeSXUXW6CcpKW+DgwCQ7PYJvW+2x+jxn3jTvyS+xK
	 ZguOLQSDHBVaw==
Date: Mon, 6 Jan 2025 18:04:43 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, mmareddy@quicinc.com, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Message-ID: <kxgscw5jm34ynejy6kg3at6i4kmgbq6jxmcrigtq2lpo5ga2pm@yu5hvicac5g2>
References: <20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com>
 <20241224-enable_ecam-v2-1-43daef68a901@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224-enable_ecam-v2-1-43daef68a901@oss.qualcomm.com>

On Tue, Dec 24, 2024 at 07:40:15PM +0530, Krishna Chaitanya Chundru wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Increase the configuration size to 256MB as required by the ECAM feature.
> And also move config space, DBI, ELBI, iATU to upper PCIe region and use
> lower PCIe region entierly for BAR region.

This problem description seems to assume that the reader is familiar
with some recent discussion elsewhere. Please ensure that what we enter
into the git history can be understood by uninitiated readers.

Also please follow the flow described in
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
(i.e. first describe your problem, then describe the solution)

> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

S-o-b doesn't match patch author.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 55db1c83ef55..bece859aee31 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2201,10 +2201,10 @@ wifi: wifi@17a10040 {
>  		pcie1: pcie@1c08000 {
>  			compatible = "qcom,pcie-sc7280";
>  			reg = <0 0x01c08000 0 0x3000>,
> -			      <0 0x40000000 0 0xf1d>,
> -			      <0 0x40000f20 0 0xa8>,
> -			      <0 0x40001000 0 0x1000>,
> -			      <0 0x40100000 0 0x100000>;
> +			      <4 0x00000000 0 0xf1d>,
> +			      <4 0x00000f20 0 0xa8>,
> +			      <4 0x10000000 0 0x1000>,
> +			      <4 0x00000000 0 0x10000000>;
>  
>  			reg-names = "parf", "dbi", "elbi", "atu", "config";
>  			device_type = "pci";
> @@ -2215,8 +2215,8 @@ pcie1: pcie@1c08000 {
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  
> -			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> -				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40000000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>;
>  
>  			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> 
> -- 
> 2.34.1
> 

