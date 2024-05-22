Return-Path: <linux-pci+bounces-7738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03FE8CBA64
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 06:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174B7B21906
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 04:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B76626CB;
	Wed, 22 May 2024 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7g07fsQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C737144;
	Wed, 22 May 2024 04:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716353008; cv=none; b=scCt3F0bSNguTjMBWkOdkhTevQv8kvxzf5ZBcIVvwUWsnQxJfYJZMqhnz/zRUx3QUNtjFNbNm6AAQdQ7ioyU4vS+vPmBdFa3J3hmZX3W0VdPgqCysbOVM7SQ8+KpiZDfSZD0PHBTVGYaPfiLtzS0Eq28vOadzxaffImotmuu0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716353008; c=relaxed/simple;
	bh=rOjGBGJlpqLBibSals7NQDD+aW+xnPnJbgEyujc2IxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IzNx67rXad3Jv5Ck4bUBTywKv4Vwvohu2etq4iPdqyZudOdlrFttMDEE7xI6tDFUJSQ+p0nIismJlsgQBR7SPPgDFIXroMu6DjyVx+izWeOKKtMPYEnFU8QeUUEwpBCGBNLLwSu0ODo+YHUTyGd5SgqdJtUear67K5ZFmxLxKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7g07fsQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so3404566f8f.1;
        Tue, 21 May 2024 21:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716353004; x=1716957804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmHrqywSLIqSjg1vJV1MQvzffoeBek4ngmT0+/XAH2s=;
        b=T7g07fsQSBG21rtc6TgBz/57zSZ6nVH/6DBlAyiAdgqv51foi8w/zKGjQsEp4JwRWf
         Epy2E/8tZVpWl+YOhruM4oeXWv+t6yZ9wIL2ge/xaMrHHEu1b/PnHzSZ1zhzMvNdLNMP
         qOgoEmqO3+eLginj879ldk3tAaiGIGO0vEekuyS9DElAWmAxysKQfh9F50YGkBMfL6Q+
         RYfrF7ZA90+DyPHBZbF9bBkOjHKoaup9pDBfrFVCeDEsbVJCTZbD3GCjzowvoFb43sb2
         lHNdRTWSgRDVnsS8VGx+lWDiZYkQGdTlwcpxZ09lCVcSdoB97wWaPkSCqD+0DwE+PbZc
         OE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716353004; x=1716957804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmHrqywSLIqSjg1vJV1MQvzffoeBek4ngmT0+/XAH2s=;
        b=mT7blln1H/n6mm27jcqCATNHkX42Dpn5EOxH7SsNhKP00iFrh1BVJozMW4UjNDumym
         JzB8py6Bbon60MEInbNBgIwOamKa0uGJYUEfCjNEqJCV8KbMMR5l7sLEWxdxD5j6R2mu
         YZJDFJDhfVLHT8WHhZXrYIff/yKda8NjFHkfBm9lGR/i7fc7Rlh2EwdACDLO/0D18xrs
         QfOgvXov6smVRtwClKWXokVPioybPjGLxeHMNFKBRQApsQZEcmZUcXjGtl0PT/fwPi9B
         mHwsoc/eW8p9Tko9iKLdm6rtLNtDKsYZBGEmxGE+mTaLLw2BLvw/DU+nBfBjfLIf5vv1
         t66Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5eiKdrYBlX8AXMd6lbwyF4dw+osOOerPwkR24IEFxCIO9p/dwy/xS9sVEHEKlPnKotth++MAVFmGIZl41m7A6CHb6G5x8wvkltRAT
X-Gm-Message-State: AOJu0YzCS4m4tOfgo1nTEzWe2gFSCv7eGSGn/IJi7TbOL06+AHwFc5jT
	RHHs7WQ9VqVmjltZZVJVezeeDPOAYlwKh7YluP+rokZUQanapMHdfDAWoA==
X-Google-Smtp-Source: AGHT+IH9ikW4E4tHEicpzfvYHbvquTNq7PRR5DdZGtiEVgQbOy5637MdDZfAFOGp3f8I34KHrLqW4Q==
X-Received: by 2002:adf:eeca:0:b0:34d:9e54:11ec with SMTP id ffacd0b85a97d-354d8c73f2cmr490258f8f.5.1716353004206;
        Tue, 21 May 2024 21:43:24 -0700 (PDT)
Received: from localhost.localdomain (249.red-88-10-56.dynamicip.rima-tde.net. [88.10.56.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b89573csm33222744f8f.29.2024.05.21.21.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 21:43:23 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kw@linux.com,
	lpieralisi@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: PCI: mediatek,mt7621-pcie: add PCIe host topology ascii graph
Date: Wed, 22 May 2024 06:43:21 +0200
Message-Id: <20240522044321.3205160-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek MT7621 PCIe subsys supports a single Root Complex (RC) with 3 Root
Ports. Add PCIe host topology ascii graph to the binding for completeness.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/pci/mediatek,mt7621-pcie.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
index 6fba42156db6..c41608863d6c 100644
--- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
@@ -13,6 +13,35 @@ description: |+
   MediaTek MT7621 PCIe subsys supports a single Root Complex (RC)
   with 3 Root Ports. Each Root Port supports a Gen1 1-lane Link
 
+                          MT7621 PCIe HOST Topology
+
+                                   .-------.
+                                   |       |
+                                   |  CPU  |
+                                   |       |
+                                   '-------'
+                                       |
+                                       |
+                                       |
+                                       v
+                              .------------------.
+                  .-----------|  HOST/PCI Bridge |------------.
+                  |           '------------------'            | Type1
+             BUS0 |                     |                     | Access
+                  v                     v                     v On Bus0
+          .-------------.        .-------------.       .-------------.
+          | VIRTUAL P2P |        | VIRTUAL P2P |       | VIRTUAL P2P |
+          |    BUS0     |        |    BUS0     |       |    BUS0     |
+          |    DEV0     |        |    DEV1     |       |    DEV2     |
+          '-------------'        '-------------'       '-------------'
+    Type0        |          Type0       |         Type0       |
+   Access   BUS1 |         Access   BUS2|        Access   BUS3|
+   On Bus1       v         On Bus2      v        On Bus3      v
+           .----------.           .----------.          .----------.
+           | Device 0 |           | Device 0 |          | Device 0 |
+           |  Func 0  |           |  Func 0  |          |  Func 0  |
+           '----------'           '----------'          '----------'
+
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 
-- 
2.25.1


