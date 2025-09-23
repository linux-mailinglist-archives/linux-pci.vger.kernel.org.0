Return-Path: <linux-pci+bounces-36800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B318B97489
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD41725AD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB13019D6;
	Tue, 23 Sep 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqfmJOOK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0D302749
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654442; cv=none; b=IsvEfV8wEJQfoZ1m2YmkYQYyyY92h1ll/E7+JdipQBM5kRB+0bcAf7xenNiSylzmol5t3WkM0IXM/EbwHUOAt/FzeZAoKHPRmFpBbB0WDfTkZeiBtJC/3u2Y1uf69wVK8vqdAq/dr5RYKKQZzoPtmYDWB1n9+Ab3ugxSRGhuWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654442; c=relaxed/simple;
	bh=QgVgbq4g9r3DsKzKpUEjKl9QE2+bdP8si2aMkXfho5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5KyzTWyJiOq+6YDffgVOLn9mv02hYNxmHo6sDnql2LCvY8AvzM7AgWAX0sjK4LogbSSiPjDNTTCDeaS1tdzbADmhr1WhW65P5rKy3hpyu3UGcNT9KRqcgYF4Y3CidgpiXsRvcclGqBSkTAdR1O3UYl8HJwzxGdEquSVKp6U1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqfmJOOK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so4381009f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 12:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758654439; x=1759259239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iIzcezubwlq0RFm/fy2Wz7m1elEGd+5wrncON0Sn1iM=;
        b=RqfmJOOKyAdZWFBWvEk01sIkCGVdRj+oqpn+amAuciY6dICRvStUkyb7ejPfI/NpKq
         rPVJOXM9n9dOO+DR6T9voctkYUzWoSMMUppU5IyUqimcxZXbJ4MRLR9o2yYNxfBKeUvF
         ZZ+aUxYG8GYaTnLI0Bry0qxoFRR23xMmyrr5tQpJDE6znuDcqwXmGy7vh8iHn9iZ2D6c
         hrIJKiAVpMjf5DqCUP26DvEt/9d5UrLZJrxt3ojIP+Ioq0GHThIUZkyd8I1ovaabDcCt
         qFhNpoWyFYxoMHS7I9C7hfEQ7V1syy44TGNybg4LaUNZCPXqzyA7+HoqvOg399GCdI9j
         6vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654439; x=1759259239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIzcezubwlq0RFm/fy2Wz7m1elEGd+5wrncON0Sn1iM=;
        b=Ch8WpwPi6121zfKhZeaR4PUMvty7ufsPH+OJWkJljpKnWr+E3WwEAV6SCFZMD/sUcT
         ZE3lrcLl1TgDs+PLRzsB6eGcRa4zvkhEEhNiymKOnDlsEFrAO6ryWlWj60VeSUJVW5+d
         j2XmVeVlobxuutghhuQ05lWkRKmMtE4kiQIISiR0bO8CK9siVKf6rdxIPknOFtcA46GS
         rI+DDskQ9HXydAnX6bFc9R43aC+KjENBHsSkheymEQbh13e/G5CYoexGZ8wB5ZXMOSvw
         /td6f7RNxg/PpCWpQgSpua28kUGGLTjZ/sKo6KGHAxnRRfd7FdxXWNHwY10FpmIntwx/
         lpjA==
X-Forwarded-Encrypted: i=1; AJvYcCUMfPrNq2XjGSozcMKLNmc44sRAYIFJbKf/kTMOOA7g4cIFv8X6vG4ejq2D8yYPs8P0+KlqwKcPCIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/0FB4KUkLm1nWxOqPpotE65oDmdL86cypwd8OcZM5Ps2uGlz
	wrchPirJZSGrBreF+9yH4lbZlbPBw0alIraJcujhplCEpYgtB4qSDBbs
X-Gm-Gg: ASbGncvaIssy8vquJLn7ht5LFMcX39Ej4WdFL/cZTyUOLzEPOTdlWuDpSYhLdDM4CEI
	xJQfI94HjK++0bGncI9i0d7xIJPpKwrd4KgWwYAFFTfDAY8FdbHkU5ywcW53prW9EN40aTsPYJ1
	DYW42GID87pVVhwnHDqH0KECJVXjOB8ZNyKUXOIzyRcVsBJbV3e+W+ozLMXeue42L4YHq7TAZ4j
	DAPdxTqNqB2W2K/DH/o35emP+TH6Tp09AGKoe/AM9daQBT5FqIkr9mpaXAFOiWE/YYTHmkBnMSr
	AJF5eRq0JDzdTrjKa8rMVZ7wagqm12/tDrbtWh1UOwfmuyJ4zr+hynIt9nqDtzQbuqn7sNi+Q9c
	xvROHPHcP9UPvFkK5RlX2VG6lqJaf/ufxP0bX7L1JQnI7HV/nmdzmjXH6j+u4zeSvP6RKrbU=
X-Google-Smtp-Source: AGHT+IFMC5WZipXFwAc0jOhdCUt9YzXLNEh2M6BwA3JZ+CheIOjLK/BQJ1BA+7EBMR0NC+aWeWWvaA==
X-Received: by 2002:a5d:588e:0:b0:3fb:7afc:c17 with SMTP id ffacd0b85a97d-405c7c5e8d2mr3394096f8f.28.1758654438709;
        Tue, 23 Sep 2025 12:07:18 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm265240915e9.2.2025.09.23.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:07:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add support for Airoha AN7583
Date: Tue, 23 Sep 2025 21:06:59 +0200
Message-ID: <20250923190711.23304-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
binding.

This differ from the Airoha EN7581 SoC by the fact that only one Gen3
PCIe controller is present on the SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix alphabetical order

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 0278845701ce..1ca9594a9739 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -58,6 +58,7 @@ properties:
           - const: mediatek,mt8196-pcie
       - const: mediatek,mt8192-pcie
       - const: mediatek,mt8196-pcie
+      - const: airoha,an7583-pcie-gen3
       - const: airoha,en7581-pcie
 
   reg:
@@ -276,6 +277,26 @@ allOf:
 
         mediatek,pbus-csr: false
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie-gen3
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          items:
+            - const: sys-ck
+
+        resets:
+          minItems: 1
+
+        reset-names:
+          items:
+            - const: phy-lane0
+
   - if:
       properties:
         compatible:
-- 
2.51.0


