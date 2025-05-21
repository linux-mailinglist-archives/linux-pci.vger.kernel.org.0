Return-Path: <linux-pci+bounces-28213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E01ABF64B
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5884E3B28
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107027CCE4;
	Wed, 21 May 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqYCxOqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDA27C875;
	Wed, 21 May 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834737; cv=none; b=Qkvzc/4OSONtzq1WuW3rvU83HC9KMhpHjuKAZjweaG4eCtd3CFON4APTv6jd3c+4/aILl7cDPwhE0u3aDFOS7BakkoJcyxhRZzmBsZDgThQ1UuidOilhVrSwWNEy6vfmqqotF5/ag/a/zuUv9lYXw5y5oSZYaAz/QkEuYRKCfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834737; c=relaxed/simple;
	bh=1+QzCuOqllZpR2M2g5vpAg8VG9l9Srm2BHPfriaKwPo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TjF4UYwvxCM0mFC/OTizMAni2np9AA5oZC4wjCwAUwB343dQFrZnRAV2gXFTZBuzMzgsE2d8YUiU8t5Ab9FdJzIWwYNAMwFChMGBLS6s72dbsVI4NVSOwBSTNtbtkfj5zqK1MI3t7UAMUXa6Zx+2413mlT+TPdyA7+erlUpt+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqYCxOqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5E1C4CEE4;
	Wed, 21 May 2025 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834736;
	bh=1+QzCuOqllZpR2M2g5vpAg8VG9l9Srm2BHPfriaKwPo=;
	h=From:Subject:Date:To:Cc:From;
	b=KqYCxOqL1FbYfzcLf3jIZ/E/gAkCYTWkWKFFiC0VihTejeFk8QvypqRkXbhtVDuYQ
	 /oxS3Bbui7PUeCCe4bk5ELzrgo79N6FRMakaMjx9j/UqCdzoMBN8klYFVAxXy2rr+O
	 iJfsSrqb7gQ64P8IPoblo6gR2NCXRmiTZk6K2CpaA+nwgvY14BWcl4kC5xiEIvZVN1
	 07Y123NquizwGF2B71crsl1jAb+LeH1FgCSQ6HtX44M5DXrRaWil23/qmPy6geUIB5
	 Rk0Vd8jpcEBFuz7lseNDpLhJtRIamHMg+ZZj4wt8ci3jNRozpj/8k6fvTerj58ncfb
	 w0kndaOZ61Kvw==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/4] Drop unrelated clocks from SM8150/SC8180X PCIe RCs
Date: Wed, 21 May 2025 15:38:09 +0200
Message-Id: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHXLWgC/x3MSwqAIBAA0KvErBPUkD5XiRAZpxqKFI0IorsnL
 d/mPZApMWUYqgcSXZw5HAWqrgBXdywk2BeDltpIo5U4Q2QUnTLSRmSyPoVocQ+4ZTGb1vWyIex
 8A2WIiWa+/32c3vcDBuWns20AAAA=
X-Change-ID: 20250521-topic-8150_pcie_drop_clocks-f57a903ec8d3
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747834731; l=983;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=1+QzCuOqllZpR2M2g5vpAg8VG9l9Srm2BHPfriaKwPo=;
 b=sDuEZUlODpLMpvGWu7/L0wo/2AauzZd0u6bL2FdnUI+fi0wwEGUbKAJf90/De7eDIaA5CjuQ3
 qqQw45HSFKCD2FIl8fkUsKvuiMRajGfMUdx9+xYSgROhtgh0UWcGDki
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Smoke tested on both, but more is always welcome.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (4):
      dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated clocks from PCIe hosts
      dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated clocks from PCIe hosts
      arm64: dts: qcom: sc8180x: Drop unrelated clocks from PCIe hosts
      arm64: dts: qcom: sm8150: Drop unrelated clocks from PCIe hosts

 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 14 +++-------
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 14 +++-------
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 32 ++++++----------------
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 16 +++--------
 4 files changed, 20 insertions(+), 56 deletions(-)
---
base-commit: edef457004774e598fc4c1b7d1d4f0bcd9d0bb30
change-id: 20250521-topic-8150_pcie_drop_clocks-f57a903ec8d3

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


