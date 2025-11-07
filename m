Return-Path: <linux-pci+bounces-40574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B4C3FC49
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 12:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A94E55FF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3C31BCBD;
	Fri,  7 Nov 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAsxCuXa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA131A541;
	Fri,  7 Nov 2025 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515864; cv=none; b=Tr2YVsd971vB/ls1I3GtKRzOwhpbIq2I6S0XOUPoFvs/0t0gDQYK+Sau1AQOCT3OSDZaILRzt8AOI51H8/ZPnu18lacGMvyWV66CS/CcJ9uG0AXv9fCQ7BVniDnW5OJy39ZVJw+wx6v42j1Md7GTHKl+C7yMCPMfwToidLAmm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515864; c=relaxed/simple;
	bh=r8/pj/KN/8+FilylEfrnzaY5pwZnIr6KxYsofkXqxZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8QbvdETjVraBV3D6rFcK4B3qIM8UPqxoCcuf4+yGM5KLcgYbYeCV4VHnD0xtw7od7SPpfWcvPLIZinac6fkzDEe6HFQl71RF7TKIsTkOk7NIdQWpl28TSNz4U5VGNXuXhCIyo8F1w9GZvk5LyIkdsEGBVP3OcqE6gbAyE8cnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAsxCuXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D327C116C6;
	Fri,  7 Nov 2025 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762515863;
	bh=r8/pj/KN/8+FilylEfrnzaY5pwZnIr6KxYsofkXqxZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAsxCuXaRteTRWHGbVHTxWsDXv1YsNKTjT28AknYUqskWJp++FB1hmHft5i2H4kZw
	 M6GQ8SA0os6BdcnNYZk9d/CHsNuYOnIDM3Jwei63V4KEdCQ5vtDZ798ek+OrNJuW2c
	 yQTTsa/LboKiUjFtjZz4o0CC6nGbtIEfZq1UhIRp7Sz1ClDCQOzE6bPgnEzebfNvWr
	 CHM12WlRgAm1nXUICtioOs5hbIxV45pLB6rYOJlNFQ5KOoJMcF8PatgRSTXTx8Nwce
	 JhZdHaXQlbZrZhGjrVB7BcozKEJrZCvyvZQNeqoBZxsU0MN4rOWEecHc+y9VK/J33P
	 IcTxjUJAslwcg==
Date: Fri, 7 Nov 2025 17:14:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: vkoul@kernel.org
Cc: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH v14 0/5] pci: qcom: Add QCS8300 PCIe support
Message-ID: <mmzrkh7nyjnrmymvtionsiv54nv7wgqx4l5d42g4yt6rjhtq4f@wnztvnzccv3n>
References: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>

On Fri, Oct 24, 2025 at 05:56:04PM +0800, Ziyue Zhang wrote:
> This series depend on this patch
> https://lore.kernel.org/all/20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com/
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

Hi Vinod,

Could you please pick up the PHY DT binding patch?

- Mani

> ---
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
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  84 +++++
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 310 +++++++++++++++++-
>  3 files changed, 394 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

