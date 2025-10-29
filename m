Return-Path: <linux-pci+bounces-39705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF7C1CA57
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 576F94E8667
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCEC355020;
	Wed, 29 Oct 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XXCp5+I6"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2384355808;
	Wed, 29 Oct 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760631; cv=none; b=QOntilnT48eNACfNhuzRORp2kGDWcfmtlFTTITWYrEaCJ4U6tLrYeMB+C8+R/JIy6K4D7YV3RecCJ8RDj8p4tMam2l/dPkd+x4p/nkezBOYcBsr+BH6SUO89tg2BjMFzOKlPZ6ub6z5UWkOApzl3acq2d3jj6UNuqrgt/0TE55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760631; c=relaxed/simple;
	bh=Sj6E9l8ggRXtG2Em+VZdI5iellF1+7sNiM1RAQmaPTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWFwciSCdptjg7g2EKfcQh4mQaPOUi0bisUi7awpKLx4vFSUYis0ZGHTqeu0mZYRX+QiSAFTX9nPHjhS0Tl9Ocaz2Nbj3d1weWQUupt74/rw0Kh3UGBM1v3CyWnB7nkn1x8yWrqA7ZiAICwZLrEraTBMP49yjDTMp82cPgHwO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XXCp5+I6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760622;
	bh=Sj6E9l8ggRXtG2Em+VZdI5iellF1+7sNiM1RAQmaPTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XXCp5+I6PXF4UVAUKLsMdNqcDlX1Y15pmfCL4di/rtjDZlv5Dbp4AauBsU8yxCjC+
	 k9G/WFLSf90azkG49GoXxatTaGS963C945VzxHA8ry9zA1TezMWiQ43GhxjbjTQBZG
	 AJp/n+Sj52yICZAXMLOlHufy0ZRN1IeUz0xQQK4hXjuS76PxOe5UXz0Gdl6uE7Avs8
	 wvgR+MTatQBS6x5jy7LFum+z3mt5ZmU8V5zT2+/7+srIBDj6eHgYodNbvjdJ3F58Uu
	 45LKI4TKuoh/sH9wiit/sfvVEWn1faXI6JbLEI037gp835voYPYESNK6R98l46aNUa
	 qBVIeX4Tamhlg==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D038F17E1401;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 224B9480064; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:45 +0100
Subject: [PATCH v4 6/9] PCI: dw-rockchip: Add helper function for DDL
 indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-6-ce2e1b0692d2@collabora.com>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Sj6E9l8ggRXtG2Em+VZdI5iellF1+7sNiM1RAQmaPTw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW3TDDufaRZdJk/Q58o08XBna7UtrtwRR
 SE76w4VeZ5F+okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVtAAoJENju1/PI
 O/qagAsQAIK6NH5MptM9KBuwDSeqPv9FdjgzARsqdAkGLqCux/j+bGSn5LmFVsiJNezB50uwcxJ
 iWWAA705BQzSKiIv7fJpqIYfwDt/HOazgHj9j1F2V9Ifo+ao52E9CkVFBsdfXU3FYn6ufPTY+74
 4lBZga2mHUfxYaK4A7ToaBsE6wrkdqung1doh+pD9azftJPSECuTZjr+1D9Ao4AtE2asq3HpKoN
 JpeWEsLTQv4IjdYSwmPudGqarYNoJ0UbSKRnGjkL49RoyomFwch8SrknDfWzgYgikLbxDzCL5KD
 lvJeiJcIOWVWQ1XEyEEen7B/IH2sdvcAoRyATfFPjgsC7MeeJj1AJhIwYkuUP1zxtRKd6y3pE/P
 PMtUhzW99oLrz22c3t0pSU67WlN2YtFSGIU1gw4mTcP2PTNaQEpmjcedsuGYJl6qK3Q5VV93Pif
 674ZJTXQXjIfKP1JjuwD4E8M/F4R5Zlyemvs3vw6hWf4E9nS0C87PY8q3FdpOb60ln14YhuU0k1
 AJAawp1skreZBzGSUCnln9LU20Lz5Yhl7Zla6rdFE2YG2mRLbb/edvY/ZqIXl9B9AAPk7fg6TXv
 JCeInZZNujmq5rAqseL7+vJFTW3LTtBysf453e3OG8qiAdNQ3QTDPDZp3hCTItDsdIEmQmZ/pxn
 UeALkEB3zjjLil2WAfmYm7Q==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the DLL indicator.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5c8d30e15a44..ad4a907c991f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -528,6 +528,15 @@ static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u3
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
 }
 
+static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *rockchip)
+{
+	u32 val;
+
+	/* unmask DLL up/down indicator */
+	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -563,9 +572,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* unmask DLL up/down indicator */
-	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+	rockchip_pcie_unmask_dll_indicator(rockchip);
 
 	return ret;
 }

-- 
2.51.0


