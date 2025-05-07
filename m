Return-Path: <linux-pci+bounces-27386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16020AAE515
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3901BC65F7
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F428B40B;
	Wed,  7 May 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuLC7MCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE228B405;
	Wed,  7 May 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632517; cv=none; b=Balof32V0dBogBacxLih1zaf5IueyHmdE3FpsnMOIBRT637kbIoyWVeLcPX8nxuf69eSVg3WF6Ca/H6jUpDC7/jXDTwCbF62qms1HDX6JOUc+l9kqusnYx99PDk65mlutbMdn1IAccobZUMT9yu4marhemHZiYSSKP2CfyC8KAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632517; c=relaxed/simple;
	bh=ldA8r2aeb/fFWFw6fBUtA81qiav2AaAcQ+SLAQOixjI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=j/if+4Yo6YvZwhj7GK0yW1LjDcAQyB6xJwogi7OTs6obY0uHBhdXtsdOEThOnrNTUrlsgoHiskUrjgxG3ZSLjVRRxp8TJFmw/tj5nsdPFxfqftgkzqXmJ/iiHOqv6u2BFKrDcYLkMxTyevRmGfDiyUVpneOI9fnBHd5OoYVqPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuLC7MCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3330BC4CEE2;
	Wed,  7 May 2025 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632517;
	bh=ldA8r2aeb/fFWFw6fBUtA81qiav2AaAcQ+SLAQOixjI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QuLC7MCQc5sHxyfd5kBx784WfApjtRBZHTvpHe/9zOZeM+8Mw8goD8GedZ3lYcpVD
	 1M2777lTptg5UatoyTFbVufiuWHCQ0es3RV1vvDVRRqpYxBN0p2x6PGjMhpj9iAQ28
	 Sv1Ctkzfm7CJjTFKBX+jhaeGlAmW2tQKfwMLny4yGa5uZxIR8VOUmqx22ANzZ+9O3/
	 KgS22TO596zh92Yy6Cf6w4/2ESg6KRGtQ6wMrTY6nSs+9ZXIiLJqnDQbXK1tYSL1s5
	 APSKzoWzcMXI5VU6td8qTZV6Btv/Evg7j02H5M62HQjPY3pgqn9ISzmmFcNdOCZpe2
	 o6TDtgxceybdA==
Date: Wed, 07 May 2025 10:41:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org, 
 kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 andersson@kernel.org, devicetree@vger.kernel.org, konradybcio@kernel.org, 
 quic_qianyu@quicinc.com, kw@linux.com, linux-phy@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com, 
 manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, vkoul@kernel.org, 
 bhelgaas@google.com, quic_krichai@quicinc.com
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
In-Reply-To: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
Message-Id: <174663232869.1557279.17959008688697969533.robh@kernel.org>
Subject: Re: [PATCH v4 0/5] pci: qcom: Add QCS615 PCIe support


On Wed, 07 May 2025 11:15:54 +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS615.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Have following changes:
> 	- Add a new Document the QCS615 PCIe Controller
> 	- Add configurations in devicetree for PCIe, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe, platform related gpios, PMIC regulators, etc.
> 
> Changes in v4:
> - Fixed compile error found by kernel test robot(Krzysztof)
> - Update DT format (Konrad & Krzysztof)
> - Remove QCS8550 compatible use QCS615 compatible only (Konrad)
> - Update phy dt bindings to fix the dtb check errors.
> - Link to v3: https://lore.kernel.org/all/20250310065613.151598-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v3:
> - Update qcs615 dt-bindings to fit the qcom-soc.yaml (Krzysztof & Dmitry)
> - Removed the driver patch and using fallback method (Mani)
> - Update DT format, keep it same with the x1e801000.dtsi (Konrad)
> - Update DT commit message (Bojor)
> - Link to v2: https://lore.kernel.org/all/20241122023314.1616353-1-quic_ziyuzhan@quicinc.com/
> 
> Changes in v2:
> - Update commit message for qcs615 phy
> - Update qcs615 phy, using lowercase hex
> - Removed redundant function
> - split the soc dtsi and the platform dts into two changes
> - Link to v1: https://lore.kernel.org/all/20241118082619.177201-1-quic_ziyuzhan@quicinc.com/
> 
> Krishna chaitanya chundru (3):
>   dt-bindings: PCI: qcom: Document the QCS615 PCIe Controller
>   arm64: dts: qcom: qcs615: enable pcie
>   arm64: dts: qcom: qcs615-ride: Enable PCIe interface
> 
> Ziyue Zhang (2):
>   dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>     for QCS615
>   PCI: qcom: Add support for QCS615 SoC
> 
>  .../bindings/pci/qcom,qcs615-pcie.yaml        | 165 ++++++++++++++++++
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +-
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts      |  42 +++++
>  arch/arm64/boot/dts/qcom/qcs615.dtsi          | 146 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
>  5 files changed, 355 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,qcs615-pcie.yaml
> 
> 
> base-commit: 8fd51b270d58f8b05aa58841ec38c8a6b4ab09ca
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
 Base: base-commit 8fd51b270d58f8b05aa58841ec38c8a6b4ab09ca not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/next-20250507 (best guess, 3/4 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250507031559.4085159-1-quic_ziyuzhan@quicinc.com:

arch/arm64/boot/dts/qcom/qcs615.dtsi:1062.4-1065.34: Warning (interrupt_map): /soc@0/pcie@1c08000:interrupt-map: Cell 12 is not a phandle(0)






