Return-Path: <linux-pci+bounces-23493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD85A5DD61
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44E23B6615
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8B24503A;
	Wed, 12 Mar 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb4HamWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392824501B;
	Wed, 12 Mar 2025 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784855; cv=none; b=qKAYiL+fRqzIGvbZPDE0b21NJPrXM36fq8SKrTKP1wBGUY5I6KcvCmM9FUXJFYMtjJ+PDF0BenGFllca3NaNj/Mp8eg3GGT6ZbebBrs+HxJSTaVrlJArO3YKpGrrwGdUdPqn7ZsZASj/QdugC9gKIwp+a2+bbHm1s5vaalcNlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784855; c=relaxed/simple;
	bh=zt0CCCq6A3ivEI2Ux/rska1P6Ejp+DeUw05Xy7GfCfc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Kos24a34XhK+rSdYVOuqi2ckwIO/9PnblzKO4NPEq2SwVGDMOWiLAf5dcOYRDrfNfmlgbOVEAI5mLVsup9gPI/gkmSdRA5KoyNC/nzLs3i2rV4uICBnQZ52n/8LzJMspCdkUdI6Q5XDKTeWhU2g+oBTktoKJhHpek7/mxTYQIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb4HamWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B239BC4CEE3;
	Wed, 12 Mar 2025 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741784853;
	bh=zt0CCCq6A3ivEI2Ux/rska1P6Ejp+DeUw05Xy7GfCfc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Nb4HamWiaXhghNLktflxNBwiCgU75/TmcHpwLgZ1FLmJcwNAhYJRmwvYKz8QZ4JzT
	 gNs07BbK0fe5wBOh7RS4E0dVOyRVNEI9eFT9mssCbeE2fJxLIyR7+iK/pcQNr0S3r7
	 TVxt9t3DPUMGhqWf5RKr5v8rVP6H8YRaz5TuiwQiwoUfvwQ1qCrACwd4KqPROnzVCO
	 BUwV0F7lDAJDLZ5V6kt6ptwltaaQGDWU0RaarFtlaR7OugXH2r5om+w2deG/H/bsF1
	 HmRo6qTBMShLWStBbKIc+HFdi05YKBmJ0EZ1cBQUXJiGhnJ1sCdR8ZLn2u0vkyM67u
	 7V2bD5GM9dMGw==
Date: Wed, 12 Mar 2025 08:07:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, lpieralisi@kernel.org, 
 konradybcio@kernel.org, manivannan.sadhasivam@linaro.org, 
 quic_devipriy@quicinc.com, krzk+dt@kernel.org, bhelgaas@google.com, 
 conor+dt@kernel.org, quic_srichara@quicinc.com, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 andersson@kernel.org, kw@linux.com, linux-kernel@vger.kernel.org
To: Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250312084330.873994-1-quic_varada@quicinc.com>
References: <20250312084330.873994-1-quic_varada@quicinc.com>
Message-Id: <174178473556.434326.10219966709558408088.robh@kernel.org>
Subject: Re: [PATCH v12 0/4] Add PCIe support for Qualcomm IPQ5332


On Wed, 12 Mar 2025 14:13:26 +0530, Varadarajan Narayanan wrote:
> Patch series adds support for enabling the PCIe controller and
> UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
> PCIe1 is Gen3 X2 are added.
> 
> This series combines [1] and [2]. [1] introduces IPQ5018 PCIe
> support and [2] depends on [1] to introduce IPQ5332 PCIe support.
> Since the community was interested in [2] (please see [3]), tried
> to revive IPQ5332's PCIe support with v2 of this patch series.
> 
> v2 of this series pulled in the phy driver from [1] tried to
> address comments/feedback given in both [1] and [2].
> 
> 1. Enable IPQ5018 PCI support (Nitheesh Sekar) - https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
> 2. Add PCIe support for Qualcomm IPQ5332 (Praveenkumar I) - https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/
> 3. Community interest - https://lore.kernel.org/linux-arm-msm/20240310132915.GE3390@thinkpad/
> 
> v12: * Skipped the following (Vinod Koul has picked them)
> 		dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
> 		phy: qcom: Introduce PCIe UNIPHY 28LP driver
> 
>      * Skipped this (merged)
> 		dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
> 
>      * Undo combining sdx55 & ipq9574. Discard the following
> 		dt-bindings: PCI: qcom: Use sdx55 reg description for ipq9574
> 		arm64: dts: qcom: ipq9574: Reorder reg and reg-names
> 
>      * Append MHI registers to ipq9574 dt-bindings and dts
> 		dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
> 		arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
> 
>      * ipq5332.dtsi:
> 		Align reg-names order with ipq9574
> 		Dropped R-b tag per feedback
> 
>      * No new warnings/errors with dt_binding_check and dtbs_check
> 
> v11: * phy-qcom-uniphy-pcie-28lp.c
> 	 * Remove unused #define
> 	 * Use "250 * MEGA" instead of 250000000
> 
> v10: * ipq5332.dtsi: Trim down the list of assigned clocks
> 
>      * ipq9574 and ipq5332 DT
> 	 * Fix 'simple-bus unit address format error' in ipq9574 and
> 	   ipq5332 DTS
>          * Rearrange nodes w.r.t. address sort order
> 
>      * Have spoken with 'Manikanta Mylavarapu' [1] for omitting similar
>        changes in qcom,pcie.yaml that are handled in this series.
> 
>      * Reformat commit messages to 75 character limit
> 
>      * controller bindings:
>        Fix maxItems for interrupts constraint of sdm845
> 
>      1 - https://lore.kernel.org/linux-arm-msm/20250125035920.2651972-2-quic_mmanikan@quicinc.com/
> 
> v9: Dont have fallback for num-lanes in driver and return error
>     Remove superfluous ipq5332 constraint as the fallback is present
> 
> v8: Add reviewed by
>     Remove duplication in bindings due to ipq5424 code getting merged
> 
> v7: phy bindings:
>     * Include data type definition to 'num-lanes'
> 
>     controller bindings:
>     * Split the ipq9574 and ipq5332 changes into separate patches
> 
>     dtsi:
>     * Add root port definitions
> 
> v6: phy bindings:
>     * Fix num-lanes definition
> 
>     phy driver:
>     * Fix num-lanes handling in probe to use generally followed pattern
> 
>     controller bindings:
>     * Give more info in commit log
> 
>     dtsi:
>     * Add assigned-clocks & assigned-clock-rates to controller nodes
>     * Add num-lanes to pcie0_phy
> 
> v5: phy bindings:
>     * Drop '3x1' & '3x2' from compatible string
>     * Use 'num-lanes' to differentiate instead of '3x1' or '3x2'
>       in compatible string
>     * Describe clocks and resets instead of just maxItems
> 
>     phy driver:
>     * Get num-lanes from DTS
>     * Drop compatible specific init data as there is only one
>       compatible string
> 
>     controller bindings:
>     * Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
> 
>     dtsi:
>     * Add 'num-lanes' to "pcie1_phy: phy@4b1000"
>     * Make ipq5332 as main and ipq9574 as fallback compatible
>     * Sort controller nodes per address
> 
>     misc:
>     Add R-B tag from Konrad to dts and dtsi patches
> 
> v4: * phy bindings - Create ipq5332 compatible instead of reusing ipq9574 for bindings
>     * phy bindings - Remove reset-names as the resets are handled with bulk APIs
>     * phy bindings - Fix order in the 'required' section
>     * phy bindings - Remove clock-output-names
>     * dtsi - Add missing reset for pcie1_phy
>     * dtsi - Convert 'reg-names' to a vertical list
>     * dts - Fix nodes sort order
>     * dts - Use property-n followed by property-names
> 
> v3: * Update the cover letter with the sources of the patches
>     * Rename the dt-bindings yaml file similar to other phys
>     * Drop ipq5332 specific pcie controllor bindings and reuse
>       ipq9574 pcie controller bindings for ipq5332
>     * Please see patches for specific changes
>     * Set GPL license for phy-qcom-uniphy-pcie-28lp.c
> 
> v2: Address review comments from V1
>     Drop the 'required clocks' change that would break ABI (in dt-binding, dts, gcc-ipq5332.c)
>     Include phy driver from the dependent series
> 
> v1: https://lore.kernel.org/linux-arm-msm/20231214062847.2215542-1-quic_ipkumar@quicinc.com/
> 
> 
> Praveenkumar I (2):
>   arm64: dts: qcom: ipq5332: Add PCIe related nodes
>   arm64: dts: qcom: ipq5332-rdp441: Enable PCIe phys and controllers
> 
> Varadarajan Narayanan (2):
>   dt-bindings: PCI: qcom: Add MHI registers for IPQ9574
>   arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |   3 +-
>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  76 ++++++
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 252 +++++++++++++++++-
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  40 ++-
>  4 files changed, 360 insertions(+), 11 deletions(-)
> 
> 
> base-commit: eea255893718268e1ab852fb52f70c613d109b99
> prerequisite-patch-id: 56fe29d9207ac31ab08ca54712adc2a865b7be89
> prerequisite-patch-id: f50f4b13ea072aea4beae5d5ecaf62336d9d2a31
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250312084330.873994-1-quic_varada@quicinc.com:

arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: pcie@20000000: reg-names: ['dbi', 'elbi', 'atu', 'parf', 'config'] is too short
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: pcie@20000000: reg-names: ['dbi', 'elbi', 'atu', 'parf', 'config'] is too short
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb: pcie@20000000: reg-names: ['dbi', 'elbi', 'atu', 'parf', 'config'] is too short
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb: pcie@20000000: reg-names: ['dbi', 'elbi', 'atu', 'parf', 'config'] is too short
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#






