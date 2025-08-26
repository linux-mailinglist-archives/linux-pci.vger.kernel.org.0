Return-Path: <linux-pci+bounces-34758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF75B367A0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B88E772E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0267352FC6;
	Tue, 26 Aug 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVuy7TuI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4C35209D;
	Tue, 26 Aug 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216606; cv=none; b=Su94pPr4wg7E58m6D5qN+8kyCsAgDlfKAvX77gbZmtqDYhbfd/zNubawONSg37KjCeANXa4L+mbyFUzoy1uzDbYiBHvUmVQ1dFuu0ENF5E/yxkZ7NvhLN3uUmnFQCGNywe8upCnl3OJxythqb9rsCMMX3viasuobsvpW7XBhteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216606; c=relaxed/simple;
	bh=nd3CQ34Xe56IKG456UFoWEYOWYvtYcS68YFfQ7k9gS4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HTUzxl6+jMo2PfTujejVFTm8pL5jdNX0HexBEGcRS6R9MleqtQPkYvuseRgqtKkyikidnCZKR/hLNr1Bh2DXi9M4KWyKmbjClgYp0ai8FdtEKglWOYvGjZukwm25W9T3cwCa8hEQxs7jLZvUVQQIXCT0gdHiRaQaA8v/FyP/sT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVuy7TuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EC4C116D0;
	Tue, 26 Aug 2025 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216606;
	bh=nd3CQ34Xe56IKG456UFoWEYOWYvtYcS68YFfQ7k9gS4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qVuy7TuI+FdrXztlovmBpOGsaAom9wXQu6e5lKGHnE8ZgzN/haS5Lo/w42R29V0R8
	 pUDqSzC1vxWsTOiUEkD5axNIEyd/Akx7tK+/UT6sHor2e7wSX9Vq2+/qRsSTJSg0pj
	 gsnpiRwfF6X5i69r8FWY7Bt/FCBYAJ1lO8xqXjD50GY7TYQkXdGBK4NFS/r6200MYY
	 L9YLxZxf6cR4yT/WMwThvUEKkJHp6lhi5pxkKT3V03d7RmEb4lBpG9Z1kg3u93dam0
	 R9Gaw+9+2VvaNH7V0AsVWH8WNZWh85RtA1gY6tKRVF8ssanZbiYavvyidubDPOCxI6
	 Z49zDNDEbMpkw==
Date: Tue, 26 Aug 2025 08:56:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 linux-phy@lists.infradead.org, quic_mrana@quicinc.com, 
 quic_vbadigan@quicinc.com, linux-kernel@vger.kernel.org, 
 Bjorn Helgaas <bhelgaas@google.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
Message-Id: <175621649862.159548.14099860400165270689.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: Add PCIe Support for sm8750


On Tue, 26 Aug 2025 16:32:52 +0530, Krishna Chaitanya Chundru wrote:
> Describe PCIe controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe.
> 
> The qcom_pcie_parse_ports() function currently iterates over all available
> child nodes of the PCIe controller's device tree node. This includes
> unrelated nodes such as OPP (Operating Performance Points) nodes, which do
> not contain the expected 'reset' and 'phy' properties. As a result, parsing
> fails and the driver falls back to the legacy method of parsing the
> controller node directly. However, this fallback also fails when properties
> are shifted to the root port, leading to probe failure.
> 
> Fix this by restricting the parsing logic to only consider child nodes with
> device_type = "pci", which is the expected and required property for PCIe
> ports as defined in pci-bus-common.yaml.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v3:
> - Use device_type to find pci node or not instead of node name.
> - Link to v2: https://lore.kernel.org/r/20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com
> 
> Changes in v2:
> - Follow the x1e80100.dtsi pcie node description (Konrad).
> - define phy & perst, wake in port node as per latest bindings.
> - Add check in the driver to parse only pcie child nodes.
> - Added acked by tag(Rob).
> - Removed dtbinding and phy driver patches as they got applied.
> - Link to v1: https://lore.kernel.org/r/20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (3):
>       dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible
>       arm64: dts: qcom: sm8750: Add PCIe PHY and controller node
>       PCI: qcom: Restrict port parsing only to pci child nodes
> 
>  .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
>  arch/arm64/boot/dts/qcom/sm8750.dtsi               | 180 ++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-qcom.c             |   2 +
>  3 files changed, 182 insertions(+), 1 deletion(-)
> ---
> base-commit: b6add54ba61890450fa54fd9327d10fdfd653439
> change-id: 20250809-pakala-25a7c1ddba85
> 
> Best regards,
> --
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
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
 Base: using specified base-commit b6add54ba61890450fa54fd9327d10fdfd653439

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com:

arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: /soc@0/phy@1c06000: failed to match any schema with compatible: ['qcom,sm8750-qmp-gen3x2-pcie-phy']
arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: /soc@0/phy@1c06000: failed to match any schema with compatible: ['qcom,sm8750-qmp-gen3x2-pcie-phy']






