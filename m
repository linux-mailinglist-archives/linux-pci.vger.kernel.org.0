Return-Path: <linux-pci+bounces-23298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D025AA58FC8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CDE168D04
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EEA225403;
	Mon, 10 Mar 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEwdJoSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144422253F9;
	Mon, 10 Mar 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599262; cv=none; b=ow2pFQ5Z84qgj7giytWh9qIe48cswv3trv2g2cKl6Ij3yuLw4ZR562eZB/4nb1JvfWAvZ1OYI0cqkEuOL9X2h8RdSASMtZ/Y5CtgsfoO68UF7qSGOhcGJZ9dSdCqJjDhXTjdx2KzrZNOUAXCMFt2zB3pl3lPJtNDpA3H4J0aY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599262; c=relaxed/simple;
	bh=/RO65Us3aUePCDzJjFv6pTBzrmy25HRV/dlF9bzWUhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orAJsm0Bo1imgtxxLjk4alWECFvdHDVzqQeUCDQS68Uac8Y0cycJwspg/vd1uEH5RpV4TSJXLqFtQ2ofy4w1t1cuLjEE3ehwmFbGEB99Dvvhs0ufvFmC/7ETbUxjzgAqpcJmTNLq+ei+r8JxACnXu6uSmaJychRLaNXkkD8ff2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEwdJoSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51427C4CEE5;
	Mon, 10 Mar 2025 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741599261;
	bh=/RO65Us3aUePCDzJjFv6pTBzrmy25HRV/dlF9bzWUhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEwdJoSN5kVFlS8qOFzL/NXH0fKKMd9Uu1S4oA94SI7SzxNhF7DrvPFjFn1trEcXe
	 mfgm7Ft77ekSsTA1oA2OTdAyIhfGIrqtLNSdHI6Qej+Ztl4FqDBQYjRuNNEGm3/c9w
	 vly4kOCTeZyWU8yaTpgkZGxUtageiDaafCb0nKxFLMYCmc25IUImK0CTOtlBZSY9ai
	 3inxrKhMBPuy0NsyQ6ovG6zLWKH0xo80cunkuGgZwgIjUASCMAU02GXbIes5qejSCa
	 UGcL/DaGxwNl01tiYD57qzJFrvviuIuwIpNssL2PFiN1Momqgtok/ZkpxfjXT8qA+1
	 T4M/JmYywfr5Q==
Date: Mon, 10 Mar 2025 10:34:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, quic_vpernami@quicinc.com, 
	mmareddy@quicinc.com
Subject: Re: [PATCH v5 1/7] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Message-ID: <20250310-dainty-coyote-of-infinity-bfc7e4@krzk-bin>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
 <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>

On Sun, Mar 09, 2025 at 11:15:23AM +0530, Krishna Chaitanya Chundru wrote:
> PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
> maximum of 256MB configuration space.
> 
> To enable this feature increase configuration space size to 256MB. If
> the config space is increased, the BAR space needs to be truncated as
> it resides in the same location. To avoid the bar space truncation move
> config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
> iregion entirely for BAR region.
> 
> This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
> of DBI and iATU register space in BAR region")'
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b..64c46221d8bf 100644
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

This makes no sense - you change in next patch. Either this is correct
or not. If this is correct, then next patch is wrong. If this is not
correct, then you send us known wrong code.

Best regards,
Krzysztof


