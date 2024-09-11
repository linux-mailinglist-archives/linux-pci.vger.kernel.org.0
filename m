Return-Path: <linux-pci+bounces-13049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE6975715
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF0F1C21DA4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC991AC89C;
	Wed, 11 Sep 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f24PDyL+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B41AB6FC;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068391; cv=none; b=Yrebt/BSfRiVkxXOghIzUpl5g0X5D/yjgQ8c5TvQFdFz6Q9shWwUrngEYLNoszT37+E5jwd5ofo3fjAPAOGxAow4DQG5haC5hE5sz0BroIolF2fQsjz69FR+wQZ6/dE6dIIQldmwJL5XDYztZ2GOpEK/UxfGzvWswz0Ho0o3Ucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068391; c=relaxed/simple;
	bh=Fs0tboqjW+PVHnmBXKKyJdbjGTmxaZZIL6+StRrdsRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bI6AC3iDyxwaXdP8m4RJBPTXMS4n9MJLsOrBj86/hLrgUMAZWoHcLOcodr2D7LUuESLCNLayzrFQgOfTxUnJPnc48fpSmfdG2ABAl2bbE0n7vdEX4rHJI9URQaQnrjSoWGcAkKs9fMXYVIUAKlWFr2wUXiNrUxINaz/xdVYw2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f24PDyL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FFBEC4CED4;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068390;
	bh=Fs0tboqjW+PVHnmBXKKyJdbjGTmxaZZIL6+StRrdsRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f24PDyL+zk9rQlLKThjjyQPvssGwnv3+9oCw/KlEAt8DauIOUh3l/CLTcfTnFZrw8
	 8Gn6VLX3Axial3Cw6vDRjq1mQpaNNdaz65X2Jkmkv//2ej/0P1yN4QlpngkL9F/NSe
	 ijvVKnMA9J6AcJloeRufKf/my+5LuGQyk6O4DX7vD2Cpwq2pNsxjuZGiQhQtFM3i+2
	 apV4RXSTVQbHVDCTKJybIfFeq73o+9nteSwQq0qx7GXuf8xBKf0AwA4+DpX6UX5dB5
	 W0Cu0murF5Wy8JNVqEAqhlp0qwKyPcibMLvXfaJFWRmT97hiWXmcd9qVHMont9ML/1
	 g5BAiySUUr0tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ABBEE57C1;
	Wed, 11 Sep 2024 15:26:30 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 11 Sep 2024 20:56:29 +0530
Subject: [PATCH v7 4/4] PCI: qcom: Add RX lane margining settings for 16.0
 GT/s
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-pci-qcom-gen4-stability-v7-4-743f5c1fd027@linaro.org>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Pratyush Anand <pratyush.anand@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 abel.vesa@linaro.org, johan+linaro@kernel.org, 
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=uwqmrdhg0JidfcFTkMSZUh/KB9Ztn0wyucNCKAvoYRU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBm4bajR3CQi0dab9hbLx+zgTmNgaDe6uJXdKNhw
 IW7Gv+EqZuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZuG2owAKCRBVnxHm/pHO
 9S1GCACMX0WRpxGuWrzRU7hQrxgiBbElSht9W4cnKwkh5ro1yf2JvEfO4PtA5fsNsh8SMi/u/Os
 l4aiB40uUcMWsWpHegjSJKp+T05js5x6Nx5nkWhJNE4Gq6WmrDZxNVlIyQ89EVIJ3OVjX2Bc53z
 MdkKa9H5p7jMl2xK1fYbi2/QWsHpOfRJCaFq8fUjkRzrb/oDmG+N05W6nlTGJ1UKvjh0a5QWBjt
 juu/TcLAknZyivCnOGXXeZywT9Ix6lI6MsepCr5FjhjMsHZbzycGbH5+04dHLkVGzVWVqb0qyoa
 0eWz5wg/cPsBy82ICOZzTDT+dY5Kc1ZAaOhSfx7ZPz1yMdRR
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

Add RX lane margining settings for 16.0 GT/s (GEN 4) data rate. These
settings improve link stability while operating at high date rates and
helps to improve signal quality.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: dropped the code refactoring and minor changes]
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 31 +++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7e3a9632fbe8..da9b8f26636c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -210,6 +210,24 @@
 
 #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
 
+/*
+ * 16.0 GT/s (Gen 4) lane margining register definitions
+ */
+#define GEN4_LANE_MARGINING_1_OFF		0xB80
+#define MARGINING_MAX_VOLTAGE_OFFSET		GENMASK(29, 24)
+#define MARGINING_NUM_VOLTAGE_STEPS		GENMASK(22, 16)
+#define MARGINING_MAX_TIMING_OFFSET		GENMASK(13, 8)
+#define MARGINING_NUM_TIMING_STEPS		GENMASK(5, 0)
+
+#define GEN4_LANE_MARGINING_2_OFF		0xB84
+#define MARGINING_IND_ERROR_SAMPLER		BIT(28)
+#define MARGINING_SAMPLE_REPORTING_METHOD	BIT(27)
+#define MARGINING_IND_LEFT_RIGHT_TIMING		BIT(26)
+#define MARGINING_IND_UP_DOWN_VOLTAGE		BIT(25)
+#define MARGINING_VOLTAGE_SUPPORTED		BIT(24)
+#define MARGINING_MAXLANES			GENMASK(20, 16)
+#define MARGINING_SAMPLE_RATE_TIMING		GENMASK(13, 8)
+#define MARGINING_SAMPLE_RATE_VOLTAGE		GENMASK(5, 0)
 /*
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index 596a35449de1..3aad19b56da8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -45,3 +45,34 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
+
+void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
+	reg &= ~(MARGINING_MAX_VOLTAGE_OFFSET |
+		MARGINING_NUM_VOLTAGE_STEPS |
+		MARGINING_MAX_TIMING_OFFSET |
+		MARGINING_NUM_TIMING_STEPS);
+	reg |= FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
+		FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
+		FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
+		FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
+	reg |= MARGINING_IND_ERROR_SAMPLER |
+		MARGINING_SAMPLE_REPORTING_METHOD |
+		MARGINING_IND_LEFT_RIGHT_TIMING |
+		MARGINING_VOLTAGE_SUPPORTED;
+	reg &= ~(MARGINING_IND_UP_DOWN_VOLTAGE |
+		MARGINING_MAXLANES |
+		MARGINING_SAMPLE_RATE_TIMING |
+		MARGINING_SAMPLE_RATE_VOLTAGE);
+	reg |= FIELD_PREP(MARGINING_MAXLANES, pci->num_lanes) |
+		FIELD_PREP(MARGINING_SAMPLE_RATE_TIMING, 0x3f) |
+		FIELD_PREP(MARGINING_SAMPLE_RATE_VOLTAGE, 0x3f);
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_lane_margining);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index 536387e02e29..7d88d29e4766 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -9,5 +9,6 @@
 struct dw_pcie;
 
 void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci);
+void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci);
 
 #endif
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index b091432d9f90..0df84e3e481c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -487,8 +487,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
-	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_equalization(pci);
+		qcom_pcie_common_set_16gt_lane_margining(pci);
+	}
 
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6f7957c4adcc..068aa559ebd8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -284,8 +284,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_equalization(pci);
+		qcom_pcie_common_set_16gt_lane_margining(pci);
+	}
 
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)

-- 
2.25.1



