Return-Path: <linux-pci+bounces-12281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D2F960A72
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DE61C22CA5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF71BFDFC;
	Tue, 27 Aug 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNMjNWho"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFE1BF812;
	Tue, 27 Aug 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761904; cv=none; b=MaAx87LBx4bIOO7Nf026fm85ELGnpifhmxNvTdWEh1m2i4vWPwBUCDMN3I0RbS2qIP3EfK6wfUEKHaVZAeBYC0KVB5CcynZrMMq3Wb1NDSOGOml1wTWIEicbeaDU2bgIDlCCi1zZfeUOzFz3Ip1F8Jcoo15EoK0jzGvg4k+tD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761904; c=relaxed/simple;
	bh=qmMzGnC28ZCDh31+2GefMmB0QMXAHDZVokWKSX+jKyU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=amyFdVdDVROEhtwJtqlTOlBEnGDFhHdmbBjlnApfyFQj701o/R8ijFGnQT3EDUR0qJ9Wy5TE0GF2bLQBEQ9h40N1pcnhne9HD/vKSvYWqeRrrFreoi2YYDyf08teUpsBb5+uawZBNyrYe23wgbGUUYoOnzt70OkA4XK4YtVo8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNMjNWho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCAAC6104D;
	Tue, 27 Aug 2024 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724761903;
	bh=qmMzGnC28ZCDh31+2GefMmB0QMXAHDZVokWKSX+jKyU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gNMjNWhoZffSOv1un8ggYbJD221iCDLPRhGXySnV4I9D0LpvMrLudiopVGiQHN41h
	 sIBQFWvONGMXeFUFsvTLZ4Ug1Jk986Qn8V/R0P6HPX4mCfVarAnDYwW0/qkFeI52C5
	 01CzjlyjSbdqLE57f0Z7YxxcQUqPP+SMMfHtgYmXU+gqDJ+wswLxRVol2yYOpC351t
	 qK2N/HKBi6FJkb2HVNv6vR1SOwo3hokVVhnBRqlcjvuQSR4QX+OeVvg7kT6TdWJvpy
	 1+b9n3YM4Im9LXRIM2j4UWAmCnOVb797kw4jDDohWQHpwNRuMGm0w7oCdc+o7+8r3l
	 FWDFBNRa0Xctw==
Date: Tue, 27 Aug 2024 07:31:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: devicetree@vger.kernel.org, mturquette@baylibre.com, vkoul@kernel.org, 
 dmitry.baryshkov@linaro.org, sboyd@kernel.org, neil.armstrong@linaro.org, 
 linux-clk@vger.kernel.org, conor+dt@kernel.org, 
 linux-arm-msm@vger.kernel.org, andersson@kernel.org, kw@linux.com, 
 manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
 konradybcio@kernel.org, abel.vesa@linaro.org, quic_devipriy@quicinc.com, 
 linux-pci@vger.kernel.org, quic_msarkar@quicinc.com, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kishon@kernel.org, krzk+dt@kernel.org
In-Reply-To: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
Message-Id: <172476183902.3553327.3757950028426438486.robh@kernel.org>
Subject: Re: [PATCH 0/8] Add support for PCIe3 on x1e80100


On Mon, 26 Aug 2024 23:36:23 -0700, Qiang Yu wrote:
> This series add support for PCIe3 on x1e80100.
> 
> PCIe3 needs additional set of clocks, regulators and new set of PCIe QMP
> PHY configuration compare other PCIe instances on x1e80100. Hence add
> required resource configuration and usage for PCIe3.
> 
> Qiang Yu (8):
>   phy: qcom-qmp: pcs-pcie: Add v6.30 register offsets
>   phy: qcom-qmp: pcs: Add v6.30 register offsets
>   phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3
>   arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100
>   dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100
>     QMP PCIe PHY Gen4 x8
>   clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks
>   arm64: dts: qcom: x1e80100-qcp: Add power supply and sideband signal
>     for pcie3
>   PCI: qcom: Add support to PCIe slot power supplies
> 
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  18 +-
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     | 116 +++++++++
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 205 +++++++++++++++-
>  drivers/clk/qcom/gcc-x1e80100.c               |  10 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  52 +++-
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 222 +++++++++++++++++-
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
>  8 files changed, 657 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> 
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


New warnings running 'make CHECK_DTBS=y qcom/x1e80100-qcp.dtb' for 20240827063631.3932971-1-quic_qianyu@quicinc.com:

arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: reg: [[0, 29163520, 0, 12288], [0, 2013265920, 0, 3869], [0, 2013269824, 0, 168], [0, 2013270016, 0, 4096], [0, 2014314496, 0, 1048576]] is too short
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: reg-names: ['parf', 'dbi', 'elbi', 'atu', 'config'] is too short
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clocks: [[53, 348], [53, 84], [53, 86], [53, 87], [53, 94], [53, 95], [53, 22], [53, 33]] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:0: 'aux' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:1: 'cfg' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:2: 'bus_master' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:3: 'bus_slave' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:4: 'slave_q2a' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:5: 'noc_aggr' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names:6: 'cnoc_sf_axi' was expected
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: clock-names: ['pipe_clk_src', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr', 'cnoc_sf_axi'] is too long
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pci@1bd0000: Unevaluated properties are not allowed ('operating-points-v2', 'opp-table' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@1be0000: clock-names:4: 'pipe' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@1be0000: clock-names:5: 'pipediv2' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: phy@1be0000: clock-names:6: 'phy_aux' was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@3: gpio@8800: 'pm_sde7_aux_3p3', 'pm_sde7_main_3p3' do not match any of the regexes: '-hog(-[0-9]+)?$', '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: gpio@8800: 'pm_sde7_aux_3p3', 'pm_sde7_main_3p3' do not match any of the regexes: '-hog(-[0-9]+)?$', '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-gpio.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: pmic@8: gpio@8800: 'pcie_x8_12v_on' does not match any of the regexes: '-hog(-[0-9]+)?$', '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
arch/arm64/boot/dts/qcom/x1e80100-qcp.dtb: gpio@8800: 'pcie_x8_12v_on' does not match any of the regexes: '-hog(-[0-9]+)?$', '-state$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-gpio.yaml#






