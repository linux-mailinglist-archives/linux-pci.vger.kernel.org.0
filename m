Return-Path: <linux-pci+bounces-39051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102ACBFDAA4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCE53B1CDC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F42D9ECD;
	Wed, 22 Oct 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSn0QDBM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBF2D8DB7
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154998; cv=none; b=nvFVzPvSlBEL5PfgFQAcMUNIrfr7A+sUrMrT0TM+Wy2VJzwmuyixP/J6Wz+rxcWTTsT2rjk1FnUOwgSsQ+6HbVsdQcBk2Tbi1oRPZX8m9eY1e9n5TCd6tfso68NQsPo9hl8qYfGHDHwuyg8r/2Tt85W7jagMtORK1bZ0NBLbCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154998; c=relaxed/simple;
	bh=YDmC2z63xnyncBVrO7Ltif8kw4rumvv6Ka6aN/+Z8sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWkzE4fLaBfqwWr61/DNUUT5Nw25La95fCHST9dTakV1GTGgy7TqmgMK0AoulQoBFEHox0SagTz5nCgx1g37PYtb9Rru2s1PiLGVEjNiLuFlAM4RVjaTYFOrc7OvUDz26uUeL8augnZ1QWcKw5aktrURtljDGKyL/BFLVDJwVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSn0QDBM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so19143985e9.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154995; x=1761759795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=dSn0QDBMpd78CHfafrYHCXypX3+cTcFGcfGWgO26ZPe9FOws69Kg+Sio0Tz+0v60/e
         KkE2O2wZMz52fVMUcPdJG/Akyf8yZ5CmHEw28ydLcjdjJ7YHfbafpvSd3EBi5ziPv4O/
         c4ERXqC8UdbfrsIEpDMBN9d3B6aXpXb2d5zW8fzMrDK4KeC2E0NX52c7f7pJsuQUw7CM
         H0uMxJ+ch/lIscYPa2Q7RNBIuBMcyuzyHkZmiGzdcxkuEIrxOTJ41NWuRamm7hcpBGun
         knZ3oOHFl5dK7w0OeIQSuqid9XNa/xnpizi+YdgD0E/M747TytWNfL5nb2B5yraH6qbP
         nsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154995; x=1761759795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSJqWy4wfSXZhaQaKW322RhPmT1j8xGKth4T2OfqmIA=;
        b=GmJixKmS6pDBgo5L4/jCZPzKzB3wYEO9uQnTBQMGjgveZ3e8WFS/FXzfGLxXF/4ijA
         85lCacnPG0m7IR/YtRZozqPObeg+NJQjgQ01qRguARNPQ6cEuxMQ5Z0vP5JM9+EKcoPA
         J1PdfNAgws5HPIUDus78dP4V+oA///LFAk7WRpXawb9628/nVRlh1tqGZjQcIwKtEqq2
         SrXSnY4a7vOz8mREKlVsstQXenwF9U/k6SrOM4bvL6FitElMzP/wjYAn+DhwNcjaDAtW
         /uUNZZWNx16k2YyYLLH1aCHsGSPtYvTnRLp4WMbLEYI48+lRH6fHJeK07VJSnZoRoqIn
         G/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXOSN3GkZkqyE1clQqSUdOFDWHvM6PaISWYp4AK+AvCjQjav5JMLK3uVJqUS2/MrK1VLTqLWN+lsx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxIvOSnIW6v8G4DFAbv945hNIcLceP6wIvG+1HczVhqt6b0Le
	3z9dI29rTKRW1QW1GPO+LkpEjihdIweOaNywIh5c3lqIijNdRDa65/Z5DefS4RztkQw=
X-Gm-Gg: ASbGncul7zjjwrk9OS4l6WpCstexbBfRoC5jY3rPNWK73jwMK2EsbjUFrRsYHblqN+Z
	QxGS83BNXcuppmE6s+MW9CYvrHL2jdfUWn20V8o3o5NgjHuX0zCS2zr9184nDrN316XUy4ytLDR
	C62PBGt0wJqC8g6kmPmXcy3GoBM559zEF0qhcUhdTTKWebN/EQnpWK5xjAg5AYsZR41RMJLQa8g
	bkkL3j3sABVKsODTdQv5DnQ0Cex4Gf4VIwN2bQm2f6RkUI9CHfcjB94BWFb/V4kZCDRMJY3+DYD
	NdidXDD6JNcy0UTzMUCGO84cCj/2IvRrHytqY4exBnMLEuRmYEA52IFILLPgkSQoraVkhbChho8
	4u947wEgTKyqAXagvajnZbLMVaer1FdRnQF2dHtLCMZqRVBDXr3oPcDb4mYH/+49y6HLIGOuwwx
	hG3dmhn3q1
X-Google-Smtp-Source: AGHT+IFA9ek93FErYNmJh5LdN2QDJprClDXAFVaAVFgE+OTKe5HXqKKsARiJ6YdVC5ACPC1UbPa9Gg==
X-Received: by 2002:a05:600c:6095:b0:471:95a:60c9 with SMTP id 5b1f17b1804b1-4711786d054mr173817175e9.8.1761154994747;
        Wed, 22 Oct 2025 10:43:14 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:edfc:89e3:4805:d8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm43434755e9.2.2025.10.22.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:43:13 -0700 (PDT)
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
Subject: [PATCH 2/4 v3] PCI: dw: Add more registers and bitfield definition
Date: Wed, 22 Oct 2025 19:43:07 +0200
Message-ID: <20251022174309.1180931-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022174309.1180931-1-vincent.guittot@linaro.org>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
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


