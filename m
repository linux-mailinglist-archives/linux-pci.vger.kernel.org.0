Return-Path: <linux-pci+bounces-31099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15844AEE6B1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 20:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0E03ACBC6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED81D7E41;
	Mon, 30 Jun 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haeEScmh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4F72613;
	Mon, 30 Jun 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307700; cv=none; b=pdbIg2h/Vb51lZ8erN74jW2J4KxATm1Jv1Iom7q8rBs3kezhzKHdflVgm5SYYbEaTsbQtOUUMJKK0/lAuKS73XBT+/O5MwAIFCwEjOpFKYsuDugxIigHXUDdpBkm/z7nHb3XoY8N/Pms18oc0ppa6njaMZZqLemBVUMQQiL9gH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307700; c=relaxed/simple;
	bh=tpbE2FvztANs2/izJnOECYoMP2X5oOScRQHxOIydI1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/Ta5DgVLaSt4dCNTFwN4clmXKKt1RRRSrQ8WmZWJVyw6E14vZL7uW3LL7UaAg/Tqlg6o/IZlOB9aJXGGxpsF1I7bxH2Oc1ZpAD+ITdgoi2jjJh7LPbaDV1hvLOq+N82mBArN+2XKjrp0veNO1mDH3BwdJQ2jRBRGKU7lF9spq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haeEScmh; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso55627516d6.3;
        Mon, 30 Jun 2025 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307697; x=1751912497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mt5O7/7JEumjsAyKxjvlFipcH+4/5yB2S8im+OQhNPo=;
        b=haeEScmhx3fr373xFvjSOJeOmxFhG3ZDl9mo5+fQVCBOl/b7Amj1nboZZfx26dq0S2
         6Y4WOxQkT5fRyL4l1uk8AsHk0jpZoFhglXStKAtlIanJ5b+bvksaiTfCArx1D+uHGSq+
         X1ADfz/wr6O4QLQM+sJDWyIzx0AiN2nJVvnEFWfl1mIQdcAZM+oH/ZwUIxWEhng0ksSU
         /hZp6xC9OFM220vdnpP9JwiyYPbawVMqRLbyEsvJADYG/T+sNwKVptO9KXTmnKqTZxsg
         81DoRsnJ4YmPYh4JHqrh7eCGof325kNIyuyUPjmcTWblVD/aEP6XhVT36MA7BFode9Bz
         +0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307697; x=1751912497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt5O7/7JEumjsAyKxjvlFipcH+4/5yB2S8im+OQhNPo=;
        b=dXP1/VT+E3msBOajRz7hs9gCSoJHK8zb6ECdUzo0m2ZjEqLCJlNKetFtBBqyOrzdht
         x2DyNPQdAOyw+f0ebroDxcu4beS6OTcHn6ymSaG5NxBzqYkXrR5gyrW1V9pHJR7ndqsU
         Q3kk+yt48DO7nDLCOr/ExhRWl3uNNUgjOQvv8s9qJqZmswXD2oW8qiCidzInWPmj8Xjt
         6sPc8rTfaEXcyZsksrih8hhNx9IE1HchtDVqxqNzAcBdcIbgXT3fIcDrRc6sXyS2vS8z
         kVp0NDI59Mg2uMxGiy5UEOc7ehh9FQKw/yGyieL6dTvVc2sb+/eVsXlHgnlxQKFbHqUO
         YJ7w==
X-Forwarded-Encrypted: i=1; AJvYcCV47NsyRoqLe0tgMhbGFSJtB1HhH4AL95HmemZazw3tVCnO8IUB4PeDAIQNQJASHUNJWbrNTGrd4TxcJrM=@vger.kernel.org, AJvYcCW7g9V3Yldrhxi+wJMXI5RC7OG5cEs33dJsHjNLZ/R+p0BVvczngYKlW+hvP71/YhIZm2yhxsniJkY1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2wpK9zCpFZLMBQb2YrCWhtRKqcP+swHRaARPWC12XRDdoWl8
	isFGHyeaeI5HFeB9iw4xOKEnAdj8unG5+NB4q1ZqhUk0KOZZkivDeFTy
X-Gm-Gg: ASbGncsKQM1Xs+iiRV0iTRBD6i9UYT6UM2unPvuLHi36kpVc93EEHW2LpHpQJ4d51Ro
	BmCYnOpkbHrYdYw8ItuxPbhOSZsfvlVNl20xseuGAokul9oejiQgKKSJ+5VN/nZ47GEhmCbUHqc
	R1+Kwix+/DX/42Br8JnZoy/XYT8uxKb/dfaDJTavQYXky0hvbr5eX2k0TLszeqodp2zQVAt5Tej
	ZJAJAXH7lf1cjcmlw2dNgO5qU4oO0+xCVtlpx94b/1gCE5CQGxyaJP6u+LoAvyazxntVXmvbjn+
	8issEcvEEaKIWuYDFXz5Mjq72pgmid9OulX24weN89zSGcs5RsHezXkK4XAV
X-Google-Smtp-Source: AGHT+IFqsmBLHnSOIjXduuu6Gtg+JRUwYRfr6dqhcQB+Kjp/XASyizyvYC3WINP5R9Ajnd7huyBUVA==
X-Received: by 2002:a0c:f093:0:b0:700:bc46:5355 with SMTP id 6a1803df08f44-700bc46546cmr135954696d6.28.1751307697397;
        Mon, 30 Jun 2025 11:21:37 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772ff09csm71481116d6.95.2025.06.30.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:21:36 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:21:30 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] PCI: rockchip: Use standard PCIe defines
Message-ID: <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751307390.git.geraldogabriel@gmail.com>
References: <cover.1751307390.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751307390.git.geraldogabriel@gmail.com>

Current code uses custom-defined register offsets and bitfields for
standard PCIe registers. Change to using standard PCIe defines. Since
we are now using standard PCIe defines, drop unused custom-defined ones,
which are now referenced from offset at added Capabilities Register.

Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c   |  4 +-
 drivers/pci/controller/pcie-rockchip-host.c | 44 ++++++++++-----------
 drivers/pci/controller/pcie-rockchip.h      | 12 +-----
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 55416b8311dd..300cd85fa035 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -518,9 +518,9 @@ static void rockchip_pcie_ep_retrain_link(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RL;
-	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_BASE + PCI_EXP_LNKCTL);
 }
 
 static bool rockchip_pcie_ep_link_up(struct rockchip_pcie *rockchip)
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index b9e7a8710cf0..65653218b9ab 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -40,18 +40,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -269,7 +269,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	scale = 3; /* 0.001x */
 	curr = curr / 1000; /* convert to mA */
 	power = (curr * 3300) / 1000; /* milliwatt */
-	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
 		if (!scale) {
 			dev_warn(rockchip->dev, "invalid power supply\n");
 			return;
@@ -278,10 +278,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 		power = power / 10;
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
-	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
-		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
 }
 
 /**
@@ -309,14 +309,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_set_power_limit(rockchip);
 
 	/* Set RC's clock architecture as common clock */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKSTA_SLC << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Set RC's RCB to 128 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RCB;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
@@ -341,9 +341,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
@@ -380,15 +380,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 	/* Clear L0s from RC's link cap */
 	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
-		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
+		status &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
-	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
-	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
 
 	return 0;
 err_power_off_phy:
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 5864a20323f2..f5cbf3c9d2d9 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -155,17 +155,7 @@
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
-#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
-#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
-#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
-#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
-#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
-#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
-#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
-#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
-#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
-#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
-- 
2.49.0


