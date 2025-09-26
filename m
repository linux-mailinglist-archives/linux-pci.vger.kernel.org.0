Return-Path: <linux-pci+bounces-37091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F4BA3981
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943FC3AE293
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720912E8DFD;
	Fri, 26 Sep 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1mtqx/7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51910E3;
	Fri, 26 Sep 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889374; cv=none; b=c/Kp26vYFI6UX47QPvPCJKEyqbhHL+YJUlKr8LhFeV+7MAge0sQ9adDb1u/WXLq57trYabi8wXZy/5++rnkj5mLY4IcZ3UMi0kPu6PULnQTM+gLE8KrM7H8iHf4hZgkh6asC7d0DaPtBV2kU1jJCvgM+zEpaqyMhsbdjWi2oFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889374; c=relaxed/simple;
	bh=vY3Zo/cpi4kqXIXBIk9WWdex9nSAmUjz3u2MkA/Z4sU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L6p9FrGt4wVUnwA9zgNk4D9Aa3R/skpdBwwmGfjDcSGjgjG3Z3ZkGQClfHFkvv7YjIQgPkRU0UfxSTg/Us2/v55cp050EH2T2e1NRAKk3J7lp1MbWWNKjmXU9mAoa+9eTn7YZYJUi7ThqbPschF6tONOuLk96wgIRiSRkdLx594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1mtqx/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E2CC4CEF4;
	Fri, 26 Sep 2025 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758889373;
	bh=vY3Zo/cpi4kqXIXBIk9WWdex9nSAmUjz3u2MkA/Z4sU=;
	h=From:Date:Subject:To:Cc:From;
	b=O1mtqx/7i4Z2EcQRBJcOTzuBKOBVRQV9pmWxwQTFCXk/NJvLHzonmFJPS+RraKyGj
	 zqngLGyJmTl2xkRLw97GaR7MOgKuhY9DEyrei41WlJj3Df1i0eaDHHMdA0L0oF0Q4J
	 2hqBQ1jCfjJshL2MJRtqAdeElh/GV8TqeWTFSFm1PYKIJxzuwNgOcT9qdUmltYC3AG
	 Txb7LdtyJ45B02UCuI3NaYipIW5P7Wltf6FEzSc+F7lzIrz7w8zoCZnTZohpfe6LMR
	 ahLqgmrJNM6c0vBjX1tm4f7D+m7fzl97xSZXOzj+krUe8yuBFktqUt6gNJx1pf/TkI
	 ycB0q9ccJn2iA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Sep 2025 14:22:45 +0200
Subject: [PATCH] PCI: dwc: Support 16-lane operation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-topic-pcie_16ln-v1-1-c249acc18790@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJSF1mgC/x3MQQqAIBBA0avIrBNMsrKrRETaVAOhohFBePek5
 Vv8/0LCSJhgYC9EvCmRdwV1xcAei9uR01oMUkgltGz55QNZHizhXLen471RQplOC701UKoQcaP
 nP45Tzh+mODBBYQAAAA==
X-Change-ID: 20250926-topic-pcie_16ln-8b505b7909f4
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758889370; l=1721;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=vGOCxKPjYPmMvFeew3L4g2tgIKxD1UCJfc3AVqJTArA=;
 b=IEC+zlX8nnRQAjSfN8L9nH8koH4uBV+FWPMHZ8VBpQhBUgPVrwdQG5uMOO8CRMMJT4JYNsiHo
 a5Zk/zA4CQxAF9I1bGwDXWSLZleu2DSkj+6xpyTH93tsbwNPjc0ii5I
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Some hosts support 16 lanes of PCIe. Make num-lanes accept that number.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 3 +++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index fce15582c22a93167c6f03c0e3ae74f3d0e68b1a..1d7c2b27005f757d272fe78c4df48daa6628f0a3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -774,6 +774,9 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	case 8:
 		plc |= PORT_LINK_MODE_8_LANES;
 		break;
+	case 16:
+		plc |= PORT_LINK_MODE_16_LANES;
+		break;
 	default:
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
 		return;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a333ab0b0bbd8c2fc0ee32a5619696178c6b7aa2..ae11a78cc5b9a4202794cfa515e1ee496a4f47c2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -90,6 +90,7 @@
 #define PORT_LINK_MODE_2_LANES		PORT_LINK_MODE(0x3)
 #define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
 #define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
+#define PORT_LINK_MODE_16_LANES		PORT_LINK_MODE(0x1f)
 
 #define PCIE_PORT_LANE_SKEW		0x714
 #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)

---
base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
change-id: 20250926-topic-pcie_16ln-8b505b7909f4

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


