Return-Path: <linux-pci+bounces-43557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFA8CD84AD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 07:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10BE3010AA8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2E2F1FEA;
	Tue, 23 Dec 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPVULLXg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3212D1F69;
	Tue, 23 Dec 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472528; cv=none; b=X7Df78g716mw5iCNmha3hDSErHf0xXQa08naIbbgh6D3MOGeQIxtGHJ09IPSZvUS2KZfAwbSFqNJmp73bGXdoBKDtB00MdEiQf0KugfWzTT2HDTDTc7yd/5tePBvPl4SNSpIaMkaTMRJwxWQQgk5KY5OWv1ayCwOq3/S9hJWCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472528; c=relaxed/simple;
	bh=1nvB1sWFtMXqleN7CoaA6md3o+PvQ6PHZiSWVmS8yiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0X3wJLDPAOqyWASYUSLCimZXVLos2jGRTx7F+7/Ag6gJr4hfc9Rvn1B2WwbtOSqDBThAighwmSVLTlgUi+bAzVQRAeckmeo2gVajR8/Xo5K71Xb//4qNxUsEtGijVmAP5j7VFbfgT18WAMVRp/Gyz7ZThEn2KvYDzANNWcdH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPVULLXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF87DC113D0;
	Tue, 23 Dec 2025 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766472528;
	bh=1nvB1sWFtMXqleN7CoaA6md3o+PvQ6PHZiSWVmS8yiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPVULLXgLMB8NxrCOvC6UmgdSpG6i87TkIReasmD96QtTlsosCAP+PvXj61QWlv2z
	 p/uWqLwjUcBr6Izyw6bEa1DWumyGxPOF6kmzJQtnQ6aHn77DYKXVf7RZvEnWJyQGp3
	 Zk9FB1+5hypY2Lhmh9FH844X59nF84kXh7Xhrm+FnZ5vj1hRkxCiGu5A7Oyr0sU82j
	 yeZqVDBgO2wofrEOUMuSvJEboIh8LL6J+XDIbMcIQs5Ce8cTsNCP+gXgKpAd4gbB5h
	 /8UoBaHBrIGEDfCCtFonmcXViGKgFijx/zimtE+J+4X7+venqq0AVWQFk1lUNSLR7P
	 2HBMnkwg0OrnQ==
Date: Tue, 23 Dec 2025 12:18:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, vkoul@kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH v15 0/6] pci: qcom: Add QCS8300 PCIe support
Message-ID: <5nlyry3yqloruyblcrjufalsu7yccgq5cq2el3lbfpjekepcha@b5zjen3u2xmf>
References: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128104928.4070050-1-ziyue.zhang@oss.qualcomm.com>

On Fri, Nov 28, 2025 at 06:49:22PM +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
> 
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> 

Vinod, ping on the bindings patch!

- Mani

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Changes in v15:
> - rebase patches
> - fix incorrect indentation (Dmitry)
> - Add patches for monaco-evk enablement
> - Link to v14: https://lore.kernel.org/all/20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v14:
> - rebase patches
> - Link to v13: https://lore.kernel.org/all/20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v13:
> - Fix dtb error
> - Link to v12: https://lore.kernel.org/all/20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v12:
> - rebased pcie phy bindings
> - Link to v11: https://lore.kernel.org/all/20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v11:
> - move phy/perst/wake to pcie bridge node (Mani)
> - Link to v10: https://lore.kernel.org/all/20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v10:
> - Update PHY max_items (Johan)
> - Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v9:
> - Fix DTB error (Vinod)
> - Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/
> 
> Changes in v8:
> - rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
> - Add Fixes tag to phy change (Johan)
> - Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v7:
> - rebase qcs8300-ride.dtsi change to solve conflicts.
> - Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v6:
> - move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
> - Update QCS8300 and sa8775p phy dt, remove aux clock.
> - Fixed compile error found by kernel test robot
> - Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v5:
> - Add QCOM PCIe controller version in commit msg (Mani)
> - Modify platform dts change subject (Dmitry)
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
> Sushrut Shree Trivedi (1):
>   arm64: dts: qcom: monaco-evk: Enable PCIe0 and PCIe1.
> 
> Ziyue Zhang (5):
>   dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>     for qcs8300
>   arm64: dts: qcom: qcs8300: enable pcie0
>   arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>   arm64: dts: qcom: qcs8300: enable pcie1
>   arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
> 
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
>  arch/arm64/boot/dts/qcom/monaco-evk.dts       |  85 ++++
>  arch/arm64/boot/dts/qcom/monaco.dtsi          | 374 +++++++++++++++++-
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  84 ++++
>  4 files changed, 543 insertions(+), 17 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

