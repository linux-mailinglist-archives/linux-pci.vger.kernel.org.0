Return-Path: <linux-pci+bounces-17472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B39DEC71
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7FB161D47
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759281A255A;
	Fri, 29 Nov 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKAMReOg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD32C18C;
	Fri, 29 Nov 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908660; cv=none; b=cJuNjGSK8aaykLVRpRcRFekIGtsD1q1pXadbMJ7g2DezDVA/BhQJoYZl368CqZ/lzuWr0APEWAIBYAm8a51nH7RQe6d6DjqnAX4VNsU4Nh6EA0jkbGWS6XvTmjVMzjvwtWWi9nkkA7hyCATYyE/DXoSdRMjHEqaQ4dx/X65GsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908660; c=relaxed/simple;
	bh=KpVMTGiqief/k7ZDZ3M0pog58b/xHD5DS4kjzxjN+5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d7wpdCUf4VFnDiKNPqCuGYjgVS4tN5r7d/jQuEw9NanlwVdZEDPQ4TM/K3+e1n+uSInorczdGWpgu7+htwik20uwh127JS8jnaYxE+RnkIwOThOkoCS25+FNR/rXWAEkWJvXwl76IuvOoPfU1jr/sOjns4UWv2qJ2c60V9dOBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKAMReOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD23EC4CECF;
	Fri, 29 Nov 2024 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732908660;
	bh=KpVMTGiqief/k7ZDZ3M0pog58b/xHD5DS4kjzxjN+5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LKAMReOgI8FkfVSHqQEHRd5ukAcj9KPJGb1lIrhRN76LtdJDqfkdmOJAifHWYAXBW
	 oY8LxhrSCUwEBXVbJomxUeM+jksTuNAkV03ktliSPwM3cof+xWgQQWaWfAvzKFg9am
	 hNyIwI2X0bov+pDmsyVu16RvAhofdF0BOPEKimbeF2UB1jjzhR91L9roPTA5eBSICt
	 +4H4t6QVJ5nh7x3kofJATGTPDVm0qaTcvHSmMVfJ2Y1L1ZX9LgwBdclvao+boq8Fgo
	 Eue5n5Yw6fqnMyJvw0phr/umA4yoAEBvlTv1u4zzY+3c+G+GJa6atJFXLl1OGS3glZ
	 CYFfL0pkMe+8w==
Date: Fri, 29 Nov 2024 13:30:58 -0600
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
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/8] pci: qcom: Add QCS8300 PCIe support
Message-ID: <20241129193058.GA2769178@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128081056.1361739-1-quic_ziyuzhan@quicinc.com>

[+cc linux-pci; odd to have a series labeled "pci: ..." but without
copying linux-pci]
 
On Thu, Nov 28, 2024 at 04:10:48PM +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> The series depend on the following devicetree.
> 
> Base DT:
> https://lore.kernel.org/all/20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com/
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Have follwing changes:
> 	- Document the QMP PCIe PHY on the QCS8300 platform.
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> Changes in v2:
> - Fix some format comments
> - Add global interrupt for PCIe0 and PCIe1
> - split the soc dtsi and the platform dts into two changes
> - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
> 
> Ziyue Zhang (8):
>   dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP
>     PCIe PHY Gen4 x2
>   phy: qcom-qmp-pcie: add dual lane PHY support for QCS8300
>   dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
>   PCI: qcom: Add QCS8300 PCIe support
>   arm64: dts: qcom: qcs8300: enable pcie0 for qcs8300 platform
>   arm64: dts: qcom: qcs8300: enable pcie0 for qcs8300 soc
>   arm64: dts: qcom: qcs8300: enable pcie1 for qcs8300 soc
>   arm64: dts: qcom: qcs8300: enable pcie1 for qcs8300 platform
> 
>  .../bindings/pci/qcom,pcie-sa8775p.yaml       |   7 +-
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  86 ++++-
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 352 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  89 +++++
>  6 files changed, 534 insertions(+), 3 deletions(-)
> 
> 
> base-commit: eb6a0b56032c62351a59a12915a89428bce68d1d
> -- 
> 2.34.1
> 

