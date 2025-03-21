Return-Path: <linux-pci+bounces-24310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12FA6B6B8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A7819C4E8B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1801F1315;
	Fri, 21 Mar 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmxH67jl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414331EEA39;
	Fri, 21 Mar 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548196; cv=none; b=H8RDAAVVIeU9tyv0MlpxbkF07x2goa24MOBn3FxFCxFC2xJfBpMqV3qG5y7qFiD/OSNTFiHHvJxQVOyG6y9UY0sB8Ofkh+fGZOuhGL2DeKbdLlM6OOsjBAy4heUFJLdPjJ7xA2R2JVez6HBlq+fRVk6T6n81olTq1/uoLC08/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548196; c=relaxed/simple;
	bh=g1aNlT6mR+0lzBikCDDy3QE+nBuvGIYwMOVapKIIDCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnWghG48atZP5fnKLzYzdMTUuapsmx28Z4AXGiRiUszAsPpCLd2Tti+/SkyKz71bc811gYMD9RQJ7us9C1JoBGhmuMRyDzH5jraxMOfPdsjdq7VNOroFQMaq4Ou52Iz1qWkarabV1czkVfFtVcSxAJmvz9Fsl4h8I9L8+h276jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmxH67jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE253C4AF0B;
	Fri, 21 Mar 2025 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742548195;
	bh=g1aNlT6mR+0lzBikCDDy3QE+nBuvGIYwMOVapKIIDCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EmxH67jlGJIyfF1xXnhsUapE9zd0Er8KaxLCOjiOC1lIEts93AqHOHlJl8VZXWWUa
	 6jJ/68l1tb7hvb7qP8oXcpvBEQKttY2JemzUprM7HBhz1lp26jd3iDe4UTcYO0UNMf
	 8bJ/IUO9H5GCzomNUqrm49tJLtgMMx6dctw7BC8jI2Nw70/C0qfJYhW8kaIcGmIUUE
	 VUFSy6hwVU7URIDVEHJI9eEHVT2heD00oCust6zddskKG4EF4ResxSWnzdIPPOC8uS
	 4+Au5OwlJCoowO6LOY0WzP9Ox5jyl8OBFOIeYuWop4qkLbCrYYhJUR81ZR22CQW2K6
	 NUJyJ+QH2CyWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15AC36007;
	Fri, 21 Mar 2025 09:09:55 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 21 Mar 2025 13:09:51 +0400
Subject: [PATCH v5 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-ipq5018-pcie-v5-2-aae2caa1f418@outlook.com>
References: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
In-Reply-To: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742548192; l=2412;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=J/nwlaH52lH5Y8C/GSWQOuJkQODLSqbcJAs7EDLQiiU=;
 b=R6Zl6pAclhQCXyhr+LItTzoUQAMzUvm2uEThRsLCc6clZCi7+JqO4rW0SZuJaZUXD9i1yrXeY
 Wph9d3R1QhjCF2GVcW1OBczTuBOtWyBvfw8TtmWuPN/8pJxhY/QPCOu
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

The Qualcomm UNIPHY PCIe PHY 28LP is found on both IPQ5332 and IPQ5018.
Adding the PHY init sequence, pipe clock rate, and compatible for IPQ5018.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
index c8b2a3818880..324c0a5d658e 100644
--- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
@@ -75,6 +75,40 @@ struct qcom_uniphy_pcie {
 
 #define phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)
 
+static const struct qcom_uniphy_pcie_regs ipq5018_regs[] = {
+	{
+		.offset = SSCG_CTRL_REG_4,
+		.val = 0x1cb9,
+	}, {
+		.offset = SSCG_CTRL_REG_5,
+		.val = 0x023a,
+	}, {
+		.offset = SSCG_CTRL_REG_3,
+		.val = 0xd360,
+	}, {
+		.offset = SSCG_CTRL_REG_1,
+		.val = 0x1,
+	}, {
+		.offset = SSCG_CTRL_REG_2,
+		.val = 0xeb,
+	}, {
+		.offset = CDR_CTRL_REG_4,
+		.val = 0x3f9,
+	}, {
+		.offset = CDR_CTRL_REG_5,
+		.val = 0x1c9,
+	}, {
+		.offset = CDR_CTRL_REG_2,
+		.val = 0x419,
+	}, {
+		.offset = CDR_CTRL_REG_1,
+		.val = 0x200,
+	}, {
+		.offset = PCS_INTERNAL_CONTROL_2,
+		.val = 0xf101,
+	},
+};
+
 static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
 	{
 		.offset = PHY_CFG_PLLCFG,
@@ -88,6 +122,14 @@ static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
 	},
 };
 
+static const struct qcom_uniphy_pcie_data ipq5018_data = {
+	.lane_offset	= 0x800,
+	.phy_type	= PHY_TYPE_PCIE_GEN2,
+	.init_seq	= ipq5018_regs,
+	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
+	.pipe_clk_rate	= 125 * MEGA,
+};
+
 static const struct qcom_uniphy_pcie_data ipq5332_data = {
 	.lane_offset	= 0x800,
 	.phy_type	= PHY_TYPE_PCIE_GEN3,
@@ -212,6 +254,9 @@ static inline int phy_pipe_clk_register(struct qcom_uniphy_pcie *phy, int id)
 
 static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
 	{
+		.compatible = "qcom,ipq5018-uniphy-pcie-phy",
+		.data = &ipq5018_data,
+	}, {
 		.compatible = "qcom,ipq5332-uniphy-pcie-phy",
 		.data = &ipq5332_data,
 	}, {

-- 
2.48.1



