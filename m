Return-Path: <linux-pci+bounces-36438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD1EB86DDB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553582A0352
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62227306B04;
	Thu, 18 Sep 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLIp2Jvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037C2BDC3F;
	Thu, 18 Sep 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226472; cv=none; b=IhJS/+AgQBb0H95yKOCvdui73HGuVLm33ja/OrHGV0Ev/W/be8u1kZOdvBc9uyaWHTajA48+KqWAsXNjb56yQmNubqISFE9RycSgps+909XVQjy2VPEtgyFWJe5eTx/eZGHK/zXG9q2+lEubGVW0fiv+o+60F/HvPqGoluEgihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226472; c=relaxed/simple;
	bh=O5wQLmWrqsWflWIq1hbTefCtmSzwhyOY86w/cK+ayWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=meDHbsHiocEv4s6b4C91gPYVpt2qMY/B16P82tf8Bhhd8FK0fwsr5euPuNoQqZsij7GqA9I2nZIqYEGui+8DfSS1ViXtnlmHgkoq8JZsqXf6VwCL5d+C5ShBlzRakQ2xkNfdv+FIQ3vQK0GfOfmJYR5VxIlSwqCuLwsCUQfn3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLIp2Jvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68955C4CEF0;
	Thu, 18 Sep 2025 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226471;
	bh=O5wQLmWrqsWflWIq1hbTefCtmSzwhyOY86w/cK+ayWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vLIp2JviNDdoeJs5bzgcw9toagt6JcspQdZSI2/VUGY4b2P2T/XPi7jNDi7Ob3ixu
	 wtW5/TiXPX8Y6C4WgRQ/Ao7SZmG3oWkR0gzgrW5hq2+h9JX0h8BIjE/J8fWsEiVRGF
	 9wZX3a1sZO6huUr8iHt4d5HpQbJTGMLS1fiBwekPSyD5705VQTDoIHPg7/clJ9mYaP
	 QYuRQolbLD+8lRS19zwwMBN4CWd1nqIFzZxNNGQpDf6hy8zNmZ3D47gdJkgLo65yfe
	 0SUA8ReXk1iO2pnIL1HeAqCnfBS44SpCxBZaJZcq3WQkeBshG0T9DdpT/UP2Uh+1NL
	 SJfSIWqbQ/YNg==
Date: Thu, 18 Sep 2025 15:14:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH v13 0/5] pci: qcom: Add QCS8300 PCIe support
Message-ID: <20250918201430.GA1919478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16f14ab-ff11-42a2-b63b-ed28e85d620b@oss.qualcomm.com>

On Thu, Sep 18, 2025 at 10:51:22AM +0800, Ziyue Zhang wrote:
> On 9/8/2025 3:38 PM, Ziyue Zhang wrote:
> > This series depend on this patch
> > https://lore.kernel.org/all/20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com/

That patch ("PCI: qcom: Restrict port parsing only to pci child
nodes") is currently in the pci/controller/qcom branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/qcom

and won't be merged upstream until the v6.18 merge window.  This will
probably be between Sep 28 and Oct 12.

I don't know what that means for the dt-binding and arm64 dts changes
in this series, but typically changes like this series are merged via
a different tree than the PCI changes, so the ordering isn't
guaranteed until one of them is pulled by Linus.

> > This series adds document, phy, configs support for PCIe in QCS8300.
> > It also adds 'link_down' reset for sa8775p.
> > 
> > Have follwing changes:
> > 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> > 	- Add compatible for qcs8300 platform.
> > 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> > 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> > ---
> > Changes in v13:
> > - Fix dtb error
> > - Link to v12: https://lore.kernel.org/all/20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com/
> > 
> > Changes in v12:
> > - rebased pcie phy bindings
> > - Link to v11: https://lore.kernel.org/all/20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com/
> > 
> > Changes in v11:
> > - move phy/perst/wake to pcie bridge node (Mani)
> > - Link to v10: https://lore.kernel.org/all/20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com/
> > 
> > Changes in v10:
> > - Update PHY max_items (Johan)
> > - Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/
> > 
> > Changes in v9:
> > - Fix DTB error (Vinod)
> > - Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/
> > 
> > Changes in v8:
> > - rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
> > - Add Fixes tag to phy change (Johan)
> > - Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v7:
> > - rebase qcs8300-ride.dtsi change to solve conflicts.
> > - Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v6:
> > - move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
> > - Update QCS8300 and sa8775p phy dt, remove aux clock.
> > - Fixed compile error found by kernel test robot
> > - Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v5:
> > - Add QCOM PCIe controller version in commit msg (Mani)
> > - Modify platform dts change subject (Dmitry)
> > - Fixed compile error found by kernel test robot
> > - Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v4:
> > - Add received tag
> > - Fixed compile error found by kernel test robot
> > - Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7
> > 
> > Changes in v3:
> > - Add received tag(Rob & Dmitry)
> > - Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
> > - remove pcieprot0 node(Konrad & Mani)
> > - Fix format comments(Konrad)
> > - Update base-commit to tag: next-20241213(Bjorn)
> > - Corrected of_device_id.data from 1.9.0 to 1.34.0.
> > - Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/
> > 
> > Changes in v2:
> > - Fix some format comments and match the style in x1e80100(Konrad)
> > - Add global interrupt for PCIe0 and PCIe1(Konrad)
> > - split the soc dtsi and the platform dts into two changes(Konrad)
> > - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
> > 
> > Ziyue Zhang (5):
> >    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
> >      for qcs8300
> >    arm64: dts: qcom: qcs8300: enable pcie0
> >    arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
> >    arm64: dts: qcom: qcs8300: enable pcie1
> >    arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
> > 
> >   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
> >   arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  84 +++++
> >   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 310 +++++++++++++++++-
> >   3 files changed, 394 insertions(+), 17 deletions(-)
> > 
> > 
> > base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
> Hi Maintainers,
> 
> It seems the patches get reviewed tag for a long time, can you give this
> 
> series further comment or help me to merge them ?
> Thanks very much.
> 
> BRs
> Ziyue
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

