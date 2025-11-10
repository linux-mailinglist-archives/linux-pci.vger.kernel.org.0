Return-Path: <linux-pci+bounces-40726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B1C485EE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B219A4EEB3F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD412D9ED1;
	Mon, 10 Nov 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gliQu3sa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E62D94BB
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796023; cv=none; b=BUBAlt9eWUuy5JeIEjTQEP5K9ki4Fzlhu7qjHbbJd5ApWPK1OW6aEgf17rdmbB+3gsZ/EerTC/W9hCU0LnshPcA/YLp8c6PUEe43b/9IG245wO/o28TATIN234715OtpaacworDQpy6pjbCUpNxEukxveL8vAbcs43rBO7KCVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796023; c=relaxed/simple;
	bh=YDmC2z63xnyncBVrO7Ltif8kw4rumvv6Ka6aN/+Z8sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cj+DBMf1zcVBdJL6Yxs8/mg8ysn5Ejd7WaHVl1C0/G3hAEIDINXfF5Ex9Iwsaz+XAe2qxGSSS4MPcQx8Pg5wC1FPzIFZBfsFyB47JeThu8c+FAh6eDd1oB7vgtfdFuFrLI1jR29HTD1NgTAoc1/gvPYjDPKetHdcp8HnDW0W8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gliQu3sa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477775d3728so17036635e9.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796019; x=1763400819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=gliQu3sa8yGB3v/TAxbbYwCsKBqYIwGaFRneHdHLwFyQvBPOVPt5Lq9FBglAe+8Le1
         iZoGNkarecctKcocfAVHmnvizpOseWu3WJ3Hh3OllhXWZY83EEVHdLY6IcCr7cE1lVV0
         HVK6BoQcKZm5Oba1G1Pj8iTvSCc5xFlqK7ivGeP4HSYbLFQjdKMg+hUJVIjN42OvBbzv
         6TvKDRG6TrlABZBgWn/m/m3OIdR6X2Jrs06ara/eZD4wuDt9ardbrq4natqOCHnTwPne
         c3eQUlKbDai7nZGsKDHNPpNjHlaoL+B5HPTTx80HLbw9qHrYh54GkJQsokx5kxDS7gH1
         YY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796019; x=1763400819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=ltpr0ESOw/Y3WsyCcUbDoOcWBy40E27OHBIaw7MDkyx7cYtTwRcnZGL3EisF0y+WSv
         1qNnRZxcy8phJkexwXUJiSV48DzRUwJooD1m+61Eto3g9I4b7bYeQiMExtwQJPAWGu84
         P8OfhmBIz2NdB5PTH/3HQJbWt80Dn8Msm5q7e/d75R1f6sY/j9P5XYVdPrG6/yy9RN9q
         M3dJAWz9CqMd92H8ZrKbcswkwCTnBenUY9gtkUWWxWJIWOuZlxzYEKTV+bXSlmNobNV1
         NdLSRqFcMRul1MbTXjIMjZ8HaLufvVsUComeC2i7cQI3qA3jpdUjUnmCLRDwIl1bCQum
         crpg==
X-Forwarded-Encrypted: i=1; AJvYcCUGuysnrBhgH4OkbvnmWTjQNdODQ9553DIYoZB9BvbAEzlhT8WVN1ZbHQC7i25DsmAZ4znVgM1OyBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsN+nDxHp/sqsHHJheQsqUXSUlv9dXu4/fZxhNr6ULFY+8Yemq
	NupPrjT+dluu6TyF8Feu0t9yBotqLJ87uQvV6oHIuYk+tPb2Yqzziun8BSkNCiouZiY=
X-Gm-Gg: ASbGncsHAooc99Ft9sO2GX9x89qGYkqLo0uNK9PvHgtyGD6bq6j8P8s5raTZQrt73iO
	GStm01KjWXlaanwJ6zDaIFzsmPINp1jHgq7OTVluVv+xObXkdkWU2qjmTD8tpIIZkxvBG16WT1X
	w4a5vngSfHvOTgkpB9K2K48nSLED+p06qT9KTHNwWJ/x8lWoStTDfPr7akC00yG2xSGjtLmeapJ
	+g5g5m6LWsfybmPm3R3K5sY6ANGrPlKTWCOG39nA5G0FsHcGgE4cfszaZXETLTmae0bwKOYI4EU
	Sl5cEbP8Yu9/KawxuiRQCbeZojhQApnIgTztRJLFeIzS7zm0io52oS/7PP93qFcEDNtT35I5D02
	28wxOsXF7b8DuIU/fSNNE/pshYKCNxyLJBdZYtiDPEYApkrd2khaR/A06U2XxY2Hv/Xv7+A8wIo
	0Mwk0ELyOjxZSZIWBHb28=
X-Google-Smtp-Source: AGHT+IF4B3dSxsq/6aCmBGqen4lFZOQM6R9kmpQqCIpNgVB5XME58ogi9bfcWf65NAevay4coklcXg==
X-Received: by 2002:a05:600c:840f:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-47773271943mr83366585e9.21.1762796018775;
        Mon, 10 Nov 2025 09:33:38 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d5ec:666a:8d59:87fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm140111375e9.14.2025.11.10.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:33:37 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 2/4 v4] PCI: dw: Add more registers and bitfield definition
Date: Mon, 10 Nov 2025 18:33:32 +0100
Message-ID: <20251110173334.234303-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110173334.234303-1-vincent.guittot@linaro.org>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new registers and bitfield definition:
- GEN3_RELATED_OFF_EQ_PHASE_2_3 field of GEN3_RELATED_OFF
- 3 Coherency control registers

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..e60b77f1b5e6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -121,6 +121,7 @@
 
 #define GEN3_RELATED_OFF			0x890
 #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
 #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
@@ -138,6 +139,13 @@
 #define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
 #define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)
 
+#define COHERENCY_CONTROL_1_OFF			0x8E0
+#define CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK	GENMASK(31, 2)
+#define CFG_MEMTYPE_VALUE			BIT(0)
+
+#define COHERENCY_CONTROL_2_OFF			0x8E4
+#define COHERENCY_CONTROL_3_OFF			0x8E8
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
-- 
2.43.0


