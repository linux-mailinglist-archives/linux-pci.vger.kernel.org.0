Return-Path: <linux-pci+bounces-38728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE2BF0C2C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05D1189FD27
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A32FD1B1;
	Mon, 20 Oct 2025 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMZmj06c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAD2FBE02
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958709; cv=none; b=a9H4QC/kcqUN7ZxRnmoNSP+djDVAI9E/qmy9tBVZJm1RAsLSY3Fj4UOkxENpAFCgWRWU16PHc0ljqiIXXC2cgEoEbvX7O1sAAI6kV25ZLM3Sqx2aKlyQLsUjRFH87KjZ7x5XNk45rzView/+z/c5zec9nrOt9x2zd3YjZ6Wv2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958709; c=relaxed/simple;
	bh=u3O5/Vnm1zd6rOBSlXUrvnWCu5VwPjHgeRbcIJf/UzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuYaT7/WIPA0xg5/jAdynBJmTPQwbLnHu50oTdtOaG2YXxkfqAfgvPofrgbCcTL9+T5tFg2qGv9Wdu9vum865xaiOzQbvb7M/ZsLo2uQOmG+ZbetHE0sLm5pLCL9NzTOZ/8BruE+zNZ6xcM/3ow6cyafYQyxvqlAypGn49oks0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMZmj06c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f755aso43947725e9.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958704; x=1761563504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mh4C9N1Ju5JAAtnjcdgue8CazsWnd2rnlhBAUlc6beo=;
        b=cMZmj06cksMOVk/z5IiLs7k6X6gUa1PwL82OjpUT4xRT9f7hXVUhyQb+KUdjiUCBLM
         PfyaSbR3sDBf8tyZSE2/4q6ETeG3acjfG7Luc+ETjZ+fNVSRrWTIxiv33zNzRzZJl0v3
         pX2o+YBEfb5QHUFImR98O56uNIzYWnCZxZc9DEgpW+C/ecrzOVn2W87Xx41+fk3Di5Fy
         2wJSp7SX8VePaTQBkTU4IARiMgBIG5VO4aUpw1QbVCt7tg3DXolG6cYMyJXIdx8rVD4M
         FBJXBjBE8od+hFEOA+c48qN/MklgtUxqP8lA2hR+98PYG2b/ESewvObGTh/WKKGtoNWe
         +3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958704; x=1761563504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh4C9N1Ju5JAAtnjcdgue8CazsWnd2rnlhBAUlc6beo=;
        b=R8r8xQeylN8S59BObnGMMGFeQoWe4YmDQxE1qgPYV2WTuNj9hCncf4/lhgziJCGW53
         iPnyD0UvZq3kRmlFMlyymrAqh/ULSsDX0JO/oo9YUyYzrKnCDbWLxpuxr2xmTQqwxVJ/
         CEd9ohXZKnut/10jW6Ar3Ug1E4h5H8Y9pUSd+fSj06CsMUV5VqCLn4mMvGoO0XcCEs/M
         010zkGMIhi1OipcouXZ8PPzYUt26WRoKIZ2MvmFj84DvkvWXA+aldL7X2IL3/uOPCMKy
         74jHJL+oAVnAYQkIMOsB8D4sxvD/w/sbPQt71vrY3x3Cd7JaAOnnMN9omLs07Auuxl4f
         oAdA==
X-Forwarded-Encrypted: i=1; AJvYcCXlxuyWOsbR8wjMdjvLUEKuibBc7tfa0OpmFoLEdIA5kzOXWSZ8J9J8ArG2DaOs9qX5kvUvW6HoEGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+6DUvlmo76y3svcomew8dEzAd4fX2CZh6l8hZOPygzdXfA+s
	efhe9p3M6Q4R8/ZPONJs6RBqewdsPTpHUmAaJKPg2lepPBeWSTlDWsyG
X-Gm-Gg: ASbGncuCfRlCWgHbZE9xnu4/owKfBbn5zLat9QdUEc886ig/LK5mVVW/qrc8n9KqIwX
	oe1zrRjuhPO2fdJcX6Etn42zy8f/Q18KGagtoiRx84NEh45EEH+mbCx9IC81VrLNkOIuw/9p6B0
	c3piCR9PvumF+OGck4PBN5qtITkYRLN6B2E9PSpGKDltWi0RoSexXBViNEvR2B9lTI+LM1ESZxH
	om2hczQuc2WtWwX6uFdzHp2QdjVkKYlObUc1AZ2kLiRD3fRJolSu3/Ij1WuvyjPtjEcOFENp4B7
	c0HyMUW7BAklXrhknG9MpXKw8bt9FuGE9P2TqGOhKMhvARtQ+bCcUkMwXxi2f3VR7cujG7kJk2L
	9RGaqeR8ETznxxk02Szc1ycEeT7UsGyUP3x/+bn6XCgDirkVefPIa1jySMmHKTM6HEKcHkGoi9w
	j8i+r/eZvNEe4opU/3E9yfSTIXirE0hyIxdB+EIGRZ0g0=
X-Google-Smtp-Source: AGHT+IEC/EgoEzWLSutjjbvP1mXzMKOilW3J4zLO71+sEvQNi3rD9SLIUZ1bssHJ/V0ea3felgXDhA==
X-Received: by 2002:a05:600c:1e06:b0:46f:b43a:aeee with SMTP id 5b1f17b1804b1-4711792089emr93643585e9.39.1760958704255;
        Mon, 20 Oct 2025 04:11:44 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 4/5] PCI: mediatek: Use generic MACRO for TPVPERL delay
Date: Mon, 20 Oct 2025 13:11:08 +0200
Message-ID: <20251020111121.31779-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic PCIe MACRO for TPVPERL delay to wait for clock and power
stabilization after PERST# Signal instead of the raw value of 100 ms.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cbffa3156da1..313da61a0b8a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -697,12 +697,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	 */
 	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
 
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
-	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
-	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
-	 */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 
 	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
 	val = readl(port->base + PCIE_RST_CTRL);
-- 
2.51.0


