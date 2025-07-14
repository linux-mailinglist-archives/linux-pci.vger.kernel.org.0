Return-Path: <linux-pci+bounces-32075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC61B043D8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A6317305F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7012652BF;
	Mon, 14 Jul 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK8SGKLr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A362265293;
	Mon, 14 Jul 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506674; cv=none; b=NwpJpqEK7qVktSM6QwKuP8L+yeQmTNsc+8vfORxXtqYnTjR0kTu1avmJ/zzGeGqnilyinGXx6QOiI9P5zWslZFnjGu37Kiu4AW8XJCEtNN/ZYn2hOYHGeb/nm4zkNxTS78OavLloodtkCRlwHIlDyI6KqlmBdlngQrgHyc2fMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506674; c=relaxed/simple;
	bh=0cN73o2yYiCiXCp/p9M0zuVbz++37qgqTvQ6ZjDqtEY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bZBZv4dnIuxLq1RDBqERxHp7QOoVRZDycYTpjV7jfxulewz0cbHQOiPFxZ9O4je+Ws/6PEsWpb+IvVSO73d3doaEzFGIBU+cSr5e2DhaEBtxTTegq3L+Ai9NYb5FvIr/vC4b63f87xEjD3OME3UH3rbCQ5/0b5RdSPRAKp9DxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK8SGKLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC20EC4CEF0;
	Mon, 14 Jul 2025 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506673;
	bh=0cN73o2yYiCiXCp/p9M0zuVbz++37qgqTvQ6ZjDqtEY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LK8SGKLrKtSedVixTGKOrpesyxF/Rur6+7jCC5sJ+VQayZVxMRGVgZGMDc61XfpxU
	 n8xpgFfxNMrUXXwc9VMh+zWtxhBusZcYtxC+nxka5WUluk87JLYpyYvsljxZlQ74MO
	 6kulwGTS5eXbTST0sTGe26OriyP/AqJBrgnUspJn3P7xAcLtDV9tDlszE94+lKM6Hc
	 UlnIATFpiY8Dw69pfRrzf0mABKoHTHbMxZLM0VPWjacZXe4/Ynajr37cQKfXipz3GQ
	 IlWu+qnaraklF5X9Ol9lh+0luFw7xgRjj/iKQXM/N+vfzd2hyyMVXvVCHWJ/eyMuz7
	 E6bOZu8miiQyQ==
Date: Mon, 14 Jul 2025 10:24:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jingoohan1@gmail.com, Ziyue Zhang <quic_ziyuzhan@quicinc.com>, 
 quic_vbadigan@quicinc.com, abel.vesa@linaro.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, kw@linux.com, 
 konradybcio@kernel.org, kwilczynski@kernel.org, linux-pci@vger.kernel.org, 
 andersson@kernel.org, krzk+dt@kernel.org, kishon@kernel.org, 
 linux-phy@lists.infradead.org, johan+linaro@kernel.org, bhelgaas@google.com, 
 quic_krichai@quicinc.com, devicetree@vger.kernel.org, lpieralisi@kernel.org, 
 mani@kernel.org, vkoul@kernel.org, qiang.yu@oss.qualcomm.com, 
 neil.armstrong@linaro.org, conor+dt@kernel.org
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
References: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
Message-Id: <175250104197.2052778.9197055030236211122.robh@kernel.org>
Subject: Re: [PATCH v8 0/5] pci: qcom: Add QCS8300 PCIe support


On Mon, 14 Jul 2025 16:15:24 +0800, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250529035416.4159963-1-quic_ziyuzhan@quicinc.com/
> 
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
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
> 
> 
> Ziyue Zhang (5):
>   dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>     for qcs8300
>   arm64: dts: qcom: qcs8300: enable pcie0
>   arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>   arm64: dts: qcom: qcs8300: enable pcie1
>   arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
> 
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
>  3 files changed, 375 insertions(+), 3 deletions(-)
> 
> 
> base-commit: b551c4e2a98a177a06148cf16505643cd2108386
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit b551c4e2a98a177a06148cf16505643cd2108386

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com:

arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: pci@1c00000 (qcom,pcie-qcs8300): reset-names: ['pci', 'link_down'] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: pci@1c00000 (qcom,pcie-qcs8300): resets: [[50, 1], [50, 2]] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: pci@1c10000 (qcom,pcie-qcs8300): reset-names: ['pci', 'link_down'] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: pci@1c10000 (qcom,pcie-qcs8300): resets: [[50, 6], [50, 7]] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sa8775p.yaml#
arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: phy@1c14000 (qcom,sa8775p-qmp-gen4x4-pcie-phy): clock-names: ['aux', 'cfg_ahb', 'ref', 'rchng', 'pipe', 'pipediv2'] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: phy@1c14000 (qcom,sa8775p-qmp-gen4x4-pcie-phy): clocks: [[50, 70], [50, 68], [50, 80], [50, 72], [50, 74], [50, 77]] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#






