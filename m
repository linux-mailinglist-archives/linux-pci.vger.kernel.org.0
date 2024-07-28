Return-Path: <linux-pci+bounces-10889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885093E7BC
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397741C2148B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A813DB99;
	Sun, 28 Jul 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUT0F6/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046313D8B8;
	Sun, 28 Jul 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182805; cv=none; b=sTH4qbCEG8SFRxDP7/C5mizQBqjJs8KbLeOXSh5nz0xPnl9ZRpC1Guk0oRob+z7+laMjfd9XgON9lRlT0aLTlcpSDQ4tVcZWorBl3+YsL/X+dyAcAQuU9WDbkvfFPhPZLy5SLRDdpiJ7UutpMnTHhn6UEC5voswcGYOL+9TfcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182805; c=relaxed/simple;
	bh=Ws5Q04YOAjNwQASF43MKlxvsOsBeMJr+riONtpHxQo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xke9ZQppuS6BxnUdjwMhobdYUhCOTkNylSbqxHCYe9wRLN+53nBYNGNJLsvK5mDRNSHM69BV/XQkyLsSCSMia6f/ez//T8ds2XReSXGXsooUlvKOUoO+xK1fYliYrbekE1aWwHNjT9igsZS+pvrGF2jlEP4tM3cwa5ApIwQgkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUT0F6/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8479AC4AF0E;
	Sun, 28 Jul 2024 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182805;
	bh=Ws5Q04YOAjNwQASF43MKlxvsOsBeMJr+riONtpHxQo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUT0F6/oGa5Br/cn6Zb5ZMze+xLOIhrOoTRedewTfzt+eJG76IH/UpfJmejQVN+wF
	 k+X3fGXoXm/6sKWhq1hhzRNcq2CAjbgQrwsgOoDj5ilv967fayhQSzCvaFbQGjIbmQ
	 NS3ODWo8dZ7rViZ6ef5SHO4fMailjjyxrCHQ//qdltv48swNScPSslN38oq1gXWg9v
	 oDzlz4GjNTK+jmdY0lH8ylMAyIgCrHU+sYALbvv1YS0lvmLFzvLd3dsJzBGklMtbm3
	 kp21MUZHSzl+OWW3gdyZ2vALp/AOk61oApOsro9hdk8k68Y8asLFg7uCv3XUh7lZvE
	 sWAG+wARhUh4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 20/23] PCI: qcom: Override NO_SNOOP attribute for SA8775P RC
Date: Sun, 28 Jul 2024 12:05:01 -0400
Message-ID: <20240728160538.2051879-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

[ Upstream commit 1d648bf79d4dca909f242b1a0cdc458e4f9d0253 ]

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that no cache coherency issue exist for
the addressed memory on the endpoint i.e., memory is not cached. But
in reality, requester cannot assume this unless there is a complete
control/visibility over the addressed memory on the endpoint.

And worst case, if the memory is cached on the endpoint, it may lead to
memory corruption issues. It should be noted that the caching of memory
on the endpoint is not solely dependent on the NO_SNOOP attribute in TLP.

So to avoid the corruption, this patch overrides the NO_SNOOP attribute
by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
needed for other upstream supported platforms since they do not set
NO_SNOOP attribute by default.

8775 has IP version 1.34.0 so introduce a new cfg(cfg_1_34_0) for this
platform. Assign override_no_snoop flag into struct qcom_pcie_cfg and
set it true in cfg_1_34_0 and enable cache snooping if this particular
flag is true.

Link: https://lore.kernel.org/linux-pci/1710166298-27144-2-git-send-email-quic_msarkar@quicinc.com
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: wrap comments to fit in 80 columns]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d34..7fa1fe5a29e3d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -51,6 +51,7 @@
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_NO_SNOOP_OVERIDE			0x3d4
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
@@ -118,6 +119,10 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
+/* PARF_NO_SNOOP_OVERIDE register fields */
+#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
+#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
+
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
@@ -231,8 +236,15 @@ struct qcom_pcie_ops {
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
+ /**
+  * struct qcom_pcie_cfg - Per SoC config struct
+  * @ops: qcom PCIe ops structure
+  * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
+  * snooping
+  */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	bool override_no_snoop;
 	bool no_l0s;
 };
 
@@ -986,6 +998,12 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
+	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
+
+	if (pcie_cfg->override_no_snoop)
+		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
+				pcie->parf + PARF_NO_SNOOP_OVERIDE);
+
 	qcom_pcie_clear_aspm_l0s(pcie->pci);
 	qcom_pcie_clear_hpc(pcie->pci);
 
@@ -1366,6 +1384,11 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
 	.ops = &ops_1_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_1_34_0 = {
+	.ops = &ops_1_9_0,
+	.override_no_snoop = true,
+};
+
 static const struct qcom_pcie_cfg cfg_2_1_0 = {
 	.ops = &ops_2_1_0,
 };
@@ -1667,7 +1690,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
+	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_sc8280xp },
-- 
2.43.0


