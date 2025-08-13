Return-Path: <linux-pci+bounces-33977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E4AB25339
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 20:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40DF1B6870C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5A2C3260;
	Wed, 13 Aug 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FWMSK2Cy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEF2BEFF1
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110833; cv=none; b=oXV/9CF3uOWeK9xDl6rk7pKkdrARdPLYNJpWQtPPpfKW18tnkWSD1YO9vgLCInJoCugsvOrbsma1PF1WIIvGO5YbcvbvMAmuAEq39RWAj3tqilH7+O7Xv7CStVl8r0E3IaeDZll9BJ5l0q3gnrtvurO3k6htyxK7Vjd8HKrV0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110833; c=relaxed/simple;
	bh=ObVTQfTP6WmVdXDTlQq2ihRv1LL2FrZFdRYiGHsi+L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kpu+OCIp2DhMjB1RU0CPnUYgtvkRXH1pztrzVV20SZ2ZpAcfIEfNdzYBid5rTATm1s3lZmmj8fBoC1CbSSoJOWdMkYd+5ozgj0OeNGka0NL/aLOBO2/DQYd9MevNobqqu/7lOpoRvPvhh4gCRV8iykPTRNT4Y1TsDgVHFXiPv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FWMSK2Cy; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e5700401b6so755955ab.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755110831; x=1755715631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3anfg9B6GDnUStv+H7P2Qqm8t3EB0LsOUKal4iU9hMY=;
        b=FWMSK2Cy5PZFYKRIX2oqmv8HveuMcFC+oKPObv24ikXTycDT8WC8k2XDkMco/yWOwF
         z24G/LCormMuwIosa5eoWni2yvj/dp+uXkvpjcjXtr8C3Nl69L1U1pe8jPlsvKKrDMSs
         VQBvItUTC1p1biZa2Ef9Y+ZeM5zAtKKzceYFmdzM0COWzZXmvD/1saTIIHOm5+Ujubmh
         VNmJqIpRZ3X4HgiVt3wDtF9MNAsc9RbdxJhhX+ssdKFbyqhZQpnz4Tm69n5tpzZabJvR
         NXt9A+XplZgWt+kqRLiLOcNK3kLbLoRGH7omBFe4BtjE0E2liu5F5A86IWATzA92XyS1
         Nm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110831; x=1755715631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3anfg9B6GDnUStv+H7P2Qqm8t3EB0LsOUKal4iU9hMY=;
        b=DdAsnh2J1je5fwh7R5hm4DDUN9bKuQhb4aoRsVS4HbTfThEsSyvLc8scEAvk2LNkV1
         lIEZxoBY3+MAm49hscsChfFfQoYKfTXdMZTJLwadfg35IbmajwLvKK/7To99+5WmNyhR
         ozrGjaVQKyeIwFJGPGRgeHcewasdZou1oia8SnMmpdrRDPeJy6eIXPhzk4EmOIGjK9Er
         tPuqh9wzFV2xrl8XvYZpm2qWw6YslilP2tdnPCmFJ26s2za9v5PHQQ2MTdbIV6ORSfZO
         oIxZ3dG9Ysd7yNk8wjZ8yy/STThpVjvXDsw5y7mkdM22Li2SVAC6zWbWEG8nvy8doju2
         ja5A==
X-Forwarded-Encrypted: i=1; AJvYcCWxvneh/XZTmphuRIrt396FpV0q0Q8jiHXBOTviZ2APffPQaKgZ+L2JfxkioCAfZ6tOfCWYnOctCzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzxLgmek5wpUDCO1q6gYM2lH8z7BvFRHcJ/5CVsxrstyYl1iG
	keCN1zAXAuYQY3A943wBysTP5i4607AtVo61uwjCzA+jsefRxDG2MmgraXDHTT4tDvY=
X-Gm-Gg: ASbGncsuy1ZCxR6VpXRfcXxtX97BN+PmktzTekZlodOA84JmAltMPibfdTu3v31eRsR
	JQIryyWZxzOuVI+ypjtCKew8mdFdTa/qy7HEJCnVbUmBtTkIz6DNypCF4uihyN5BLChsCY9DPry
	Xamnc7d9kLR95qA/pVDWbx1g3MDbPIdlzcryMmO5OAAYfP36/mYwSngdQIib4kR64k4SOJEvY5Z
	7VmutrmSSd9cG03Y8h77BkK+0avN6ryGg1wfnHR8bPynmzUrdKErcAD98XrkzxVYdcEVcHJCS6V
	eTzEwbF5XRwqgvw+kB03pqKul7T5zUdxgPE9ywUWiYr/xcniL99fc6sYP/NgI9f6IBuSOAsGwNk
	qhobqNKG3z7Xooj++z9Nrjt7qyAMEATPz/yjnFy+BFsGBGlRFnlcv8PHh2ofYWQc5eP5f5lVcQe
	w4
X-Google-Smtp-Source: AGHT+IHqcfmnRrUjdAlNWmje55A9T53WMKx9lEOXpWePQCsQDSmAhiGvxZUCa4A2bLPkAxx42qtLRg==
X-Received: by 2002:a92:c24e:0:b0:3e5:4a4c:2ed0 with SMTP id e9e14a558f8ab-3e570964fa7mr4127025ab.24.1755110830847;
        Wed, 13 Aug 2025 11:47:10 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd89d7sm3933104173.59.2025.08.13.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:47:10 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	tglx@linutronix.de,
	johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com,
	namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	quic_schintav@quicinc.com,
	fan.ni@samsung.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: phy: spacemit: introduce PCIe PHY
Date: Wed, 13 Aug 2025 13:46:56 -0500
Message-ID: <20250813184701.2444372-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813184701.2444372-1-elder@riscstar.com>
References: <20250813184701.2444372-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding for two PCIe PHYs present on the SpacemiT
K1 SoC.  These PHYs are dependent on a separate combo PHY, which
determines at probe time the calibration values used by the PCIe-only
PHYs.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
new file mode 100644
index 0000000000000..b0cbd231d9378
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k1-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCIe PHY
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description:
+  There are two PHYs on the SpacemiT K1 SoC used for PCIe (only).
+  These PHYs must be configured using calibration values that are
+  determined by a third "combo PHY".  The combo PHY determines
+  these calibration values during probe so they can be used for
+  the two PCIe-only PHYs.
+
+  During normal operation, the PCIe port driver is responsible for
+  ensuring all clocks needed by a PHY are enabled, and all resets
+  affecting the PHY are deasserted.
+
+properties:
+  compatible:
+    const: spacemit,k1-pcie-phy
+
+  reg:
+    items:
+      - description: PHY control registers
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    pcie1_phy: phy@c0c10000 {
+        compatible = "spacemit,k1-pcie-phy";
+        reg = <0xc0c10000 0x1000>;
+        #phy-cells = <0>;
+        status = "disabled";
+    };
-- 
2.48.1


