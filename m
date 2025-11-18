Return-Path: <linux-pci+bounces-41513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C19C6A852
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAA094F8037
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598B736CDE7;
	Tue, 18 Nov 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8w4Yd+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148C36B07D
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481780; cv=none; b=k2bfytnfM7EaRKgXW2WKz5k/axmWw2rXTm+m2A/9CjVuuMQ6P+7BT35aN8BdIMk5hH9Ajvo40hYlh2Hj99zgF+XviLgOxice4ljai+JYr//xdl/pgaLR9vBPCjI7WhE9ve+pfP2O6zOa+IVUZaKu1/BlJah9nHtSIxQb7bRmulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481780; c=relaxed/simple;
	bh=YDmC2z63xnyncBVrO7Ltif8kw4rumvv6Ka6aN/+Z8sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnX2sxQnNLq0ooQ9r9EiiFPKarmUnuVoQ58z4y3QMeURVPIfPK5Vkp7YFeZWLVVhMOk81NMKyrjl2DfXSHjZeIrEAKCi6hdeepTmxtxiNMRdw/v0xivpNCkXl6BFqkT/gKQZcmiFVzT6uTKlKKwPIpvSh7rEsWSDFY0U9dbplJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8w4Yd+F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso22142615e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 08:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763481776; x=1764086576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=m8w4Yd+FBl7uxkV9TfR9iVZ73Z+KcDaO1V3eBhPD8mRrJgiMauuD6DzqAN9GJj7/1f
         w68teIeaSzTB9h9omE0nSLW9800ItuX3ZoHWwEmjPwWnxTWSBFYfLlIxxbQmZGC39IOX
         LKeW5aZZaE56AKG5QZSQNVCHG7GggPnBKOhB2zjH97IwMlQw4Ivxk2fOvsbHFfWaRmcr
         RHhu0MsrT//HE1AadVC9clJLCcOgtePXhzScJAjyarlBR5GH7RAEt2g+72+7/k2oSkDv
         XHI4diMNlfqScPDp17WtZWJYHwHFYmI4AUoth1LdQHvLpI1M/EBR/nWnKbmfa9dPFeV1
         qh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481776; x=1764086576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=L9wx3kjz207yywTgoHkWl64RB4yYv96JQhH1qU9a+qfbuNHmMdix2FfHRplcifZHVk
         1+tx3+hDPiY7aph7bEfKoUPGOyoQNkMN2bzEYCcDvcYHmg6iad50eDmkKrb/PpHueq9h
         FlvTlSXZK8FjrQr1/UyzpDIILWX99ADCA/BbqkAPTbXxWcc5FAnIAfNlVuCcGaeFgFJk
         TgdRuNw0lfndZk5TdQ4nNvhRfEvBJKo4AyHsGmSUHgmGn4riYA3uFjuNkEH8vgLpHuEX
         /yxBjXf9xvIVjZIBGLZqme7r77K3FJTVk4OxDjfPGgVs0jEaS1vrLbZIXlJ6scxmDDKg
         aIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDisYn0fegWGrwligXX/gyEAZqxeuMmFPxmkoD3/eH/JHytveEeM/T3bGrKHJrfgUFAgEf3yRIk1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7JnuMo0zSPuRv4xy9xjw+AdWPSG2hoMMJVQlhvlpvLoAbWba
	rGSK2Zj+GnenUFMNX4qeBTcxpF/3VyJsTAlOJMTNfTVUVTFt+efjMDiZNhSzcbU0yac=
X-Gm-Gg: ASbGncs14ggzrxTlRBfo10mRzxpVai0EYpf90ypZR5wHtd0ZKlJQ0RzNnXH+pNfEvAP
	CD9fpYvW68BopRAb5V6do44zSFT2CZhsfDlzriArFFFkAdcyRnUJVfAjmoSRalGvs586l7jB1wp
	/B6xriTZMonvUHcD5Q6F8u0DoZbYEhS2Nxtv7h6ILFIJmgjBUGkeObZbMSnD3D51ULmWhyMOxdM
	4xZF7NQXigAmbBilRJqB2k+31G3/rQ4Tz6endjhKmlHZ8Rgh3tSbel7QxebZu5hvk6QOjEfdI2R
	tnJ7xbRIbZZRmNYQAHFWtJWKOFlswGdHtfieYkiwu6leuN08KNKfmi+V4H0ZwIuKvZ32RUyW1m3
	9ECYsFX6A9fxUKuTOD1UUQnjU22+mGALxMsWoOwtEOzKC65Bz5T7gsH5SH9bxNo7o0oZ+42Hx+F
	JJtqnfYdyPXG/28A0m46U=
X-Google-Smtp-Source: AGHT+IG+BDNHdoKr+nmoBcJhjAG/ZnTb/B28SkxQADb4sfx6Pq139Gu1ATJ4y3Mlt9Ib3CscQR65Pg==
X-Received: by 2002:a05:600c:1f12:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-4778fe9b44dmr169442525e9.21.1763481776169;
        Tue, 18 Nov 2025 08:02:56 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:76db:cf5c:2806:ec0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm171954575e9.6.2025.11.18.08.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:02:52 -0800 (PST)
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
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 2/4 v5] PCI: dw: Add more registers and bitfield definition
Date: Tue, 18 Nov 2025 17:02:36 +0100
Message-ID: <20251118160238.26265-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118160238.26265-1-vincent.guittot@linaro.org>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
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


