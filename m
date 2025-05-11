Return-Path: <linux-pci+bounces-27561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5425AB2BF2
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 00:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A49175806
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A91262D0B;
	Sun, 11 May 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H19xtvdw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8F64D;
	Sun, 11 May 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002808; cv=none; b=Rw98nVszPCsN3oD8l0iFj+tusq0T4zIhqO81XCrJ/nAoHq3XB1d1e4h6b4xZwL8ROG6qFkwV/idXmWteYp8A4VGJBadNnDXOhvVZBTkt8vzFdLyPb3CUThdeXtXy7bK+chY2R2gp+tGRgXPtr2CiVm6HmiF/k2pO2YqlNw258nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002808; c=relaxed/simple;
	bh=tyYEPPNu6sfrAJok3EZ0IVFCHm0s9MKh4uJtJBRQACI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAk8h0ViOh9t7ZYrbtjQJQHO5dkxYlmlv4OGTAdpCAPR3Hin5hkPkOw0Hcs99ErAjveUtsixK63BpwbXybyNwfNi0SZUX4SFwC7gBEPjCAmt2hRONPORKPv541YgOPce+mgUN+SgZ5bxRfpcPBBr+r+27ekeBDPIYGVCfBdoobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H19xtvdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1904C4CEE4;
	Sun, 11 May 2025 22:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747002807;
	bh=tyYEPPNu6sfrAJok3EZ0IVFCHm0s9MKh4uJtJBRQACI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H19xtvdw0TQcWQvEBfrPgIeKS8/AmsCdm0HbK3E41dS5+kbg8sr5urTCh3SVZEioN
	 gpRsbfo0G2FS/psALkNgb8CQsFaDtU4Q4pkfi6mAtWaxgyTP7ERgI8D7l6/6SCMaUw
	 B7VfwXwAZHBSswC/MP7+wLd5mBAjQ17xANGKf6IG1uXuTmka5qxwd9IWxZsw97mXP3
	 rwo2vJRfkhJ4NMQ2U/I/p546AjGJ6csbjNbENJCNTdfFP40MOwaOjYVcNXDqvZ4mfH
	 UXUc2ka4QoGWtqYH9gcAzAtK8ZbdIGoeNgbTLh+VTeunkJTD75LO4aGpoK+0vWGzO7
	 vEkb2lVdFApAg==
Date: Sun, 11 May 2025 17:33:21 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, konradybcio@kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, quic_qianyu@quicinc.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v5 0/6] pci: qcom: Add QCS8300 PCIe support
Message-ID: <cyapaa36fotqxoyhc554m74uw4nah52j3ymaay24k3bfjd2fgw@o57nbyo3wyaq>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>

On Wed, May 07, 2025 at 11:10:13AM +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> The series depend on the following devicetree.
> 
> This series depends on PCIe SMMU for QCS8300:
> https://lore.kernel.org/all/dc535643-235d-46e9-b241-7d7b0e75e6ac@oss.qualcomm.com/

I've picked this dependency now, but please in the future include such
dependent patches into a single series (keep original author and
signed-off-by, add your signed-off-by last).

Regards,
Bjorn

> 
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Changes in v5:
> - Add QCOM PCIe controller version in commit msg (Mani)
> - Modify platform dts change subject (Dmitry)
> - Update bindings to fix the dtb check errors.
> - Remove qcs8300 compatible in driver, do not need it (Dmitry)
> - Fixed compile error found by kernel test robot
> - Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v4:
> - Add received tag
> - Fixed compile error found by kernel test robot
> - Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7
> 
> Changes in v3:
> - Add received tag(Rob & Dmitry)
> - Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
> - remove pcieprot0 node(Konrad & Mani)
> - Fix format comments(Konrad)
> - Update base-commit to tag: next-20241213(Bjorn)
> - Corrected of_device_id.data from 1.9.0 to 1.34.0.
> - Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v2:
> - Fix some format comments and match the style in x1e80100(Konrad)
> - Add global interrupt for PCIe0 and PCIe1(Konrad)
> - split the soc dtsi and the platform dts into two changes(Konrad)
> - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
> 
> Ziyue Zhang (6):
>   dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>     for sa8775p
>   dt-bindings: PCI: qcom,pcie-sa8775p: document qcs8300
>   arm64: dts: qcom: qcs8300: enable pcie0
>   arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>   arm64: dts: qcom: qcs8300: enable pcie1
>   arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
> 
>  .../bindings/pci/qcom,pcie-sa8775p.yaml       |  26 +-
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   4 +-
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 297 +++++++++++++++++-
>  4 files changed, 396 insertions(+), 11 deletions(-)
> 
> 
> base-commit: a269b93a67d815c8215fbfadeb857ae5d5f519d3
> -- 
> 2.34.1
> 

