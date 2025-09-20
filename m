Return-Path: <linux-pci+bounces-36582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC6B8C470
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 11:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690DC7A3FF9
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A72BE64D;
	Sat, 20 Sep 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI7iaOMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2629A31D
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360388; cv=none; b=qLs94RClfoGjMqaX8WWPxhxElSN+3PJ4l2rIO7zkenTSjE5FjidUhowu1cmaL3mSEUwrd9poh7VA+693Wc7N/LvJS+be8UuPv6rHdeiLL+LfzdXLsgGV6siPEkvKu5fRtCE3TyjM82DORHUfqya3MkkLvessRK82vEfAMwkCbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360388; c=relaxed/simple;
	bh=3BbqoSmJ0NDplQL4bxeVCOWydY8wpQLkEvYPPE0msBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xj0EQbmzti03gAuzz6PeiAIvaUDgPczNN6gKfputW/rdu0Mfw7PcJmN/feY26Tv1PVFAaldxGJX/hH/QxPY8BpViVNWBOySPg60ihFz+f2w1bMK0rao0akOKeFRnbQlHsqRXmy6J7TfuNvDQSN0Y1aG91Gxn32L+8k9eVr9Keko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI7iaOMq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so26084465e9.0
        for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758360384; x=1758965184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xEwCQ2kLx4wO4jHEqwEMPS8Qvt2FpFOtZT1uSLzl+Q=;
        b=KI7iaOMqe+xxTX6AyO+chI2Bxg2X8bt8spl//ofkjdJlQhAXKc9kWh+u9hO+haSDln
         ct2PM/s6DYbh+1eAFrZELJ0oc8DH/vv1vN0/ZJb8WOib6YRmCn1db+2ze0V6BWvoqpch
         2VLv46/blZO4vlWx3FOiT65e/1BjbWJtFo8me+Z+FgiDK6P2KfRI0+JF/wDT5nzlpGRy
         qsG5BVIUna5h2u8O069dX2Jkh6zftqk3+nocfdF+PG9pOYpDhOs7qJeX7KNYwe2Qrhoc
         5R0ifLRgXMLyrGhRK2zR2s1vfQ8SydZ4TQZBULpmV1fRKhNdQ5wssA/MjyaBTSvTstzP
         7+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758360384; x=1758965184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xEwCQ2kLx4wO4jHEqwEMPS8Qvt2FpFOtZT1uSLzl+Q=;
        b=me4eEu/RFxYXy7bGYeH/Bll2D6GJM0ZHOBwZoQ0Vrp9FH0kDueHj5hUUUuPPgtgC2B
         k15fWzc/bQMac14uaaibBZBmToi4k/KlQQadV2+1zXWZKVjhYy+xk9KVmbtH4LaWI+MR
         KyP82Wd9fW58PnJQx30wpQTTocZ2fLniWtV/GQsxynfrxxOxFQEmVNMSccIo2v2gH24D
         VvdBRoVqR4Hr8wKJU0H30HZwO3y7Sman7wGWlhXbCo65InWJwbN9YLgHLgjAVOk9zqWV
         9L/sZpb+o/gtEEnqzJDo+1mPIo33kNIaqozQfE4AttRHtuhqybU0lmJnB3Wu7QNikbD6
         WITg==
X-Forwarded-Encrypted: i=1; AJvYcCWUq+lZwthTtoLsEmn8NcVzCXXR9NplktS/K0flqRfWJK7slhe+GWaIcnHi97KfXVnmD502Bx8faY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9N8VVVG+dT5eED8qUGSVw5KSI3FAXllQlSXlT9qmL4SmOJMr
	I/HW3igulEfOAsdTYl3fvRx7CCcxMdLvQ2VBF7ixFF25c32IW0OMDz0IANOlPg==
X-Gm-Gg: ASbGnct6SXTEtpf5Qlvrd22ZzQ1HsW9yFjn4SwJI0yxGRQPEuxvMmp/xQT/+rEuNcpe
	MfD+MNydh7y5jR0sJyoUy5QAKGArIZ4WFfDvjBBjCQPr1uh1qQjzd2qnCiia2VHIR3IKG6ta9ru
	4WlDU1q9eg0bfQn4NRRWc8tuMKEDukdhunTwXgPFDx6y8ECoEZiGfV286oIflJZbASMJVxIt768
	5RcmbmhL6KVrhlrR3c+uztjxeZ/PS7C9TN+KdFeHXImOYyzYvT0sRXARHg+UUm23YMWUbslY5F3
	FnvYOP/85U0YBUT10HJS697VhTMNyBv7jDqTCNWxb4d1CtkrSCSTs+RJahqki4YksAou88ZFovI
	3XpZCiHoY3Szg/c2N0x3+vOI1Ha62yGqcmr0WR8VHepzMkuGJSjn5ECIkehRsmjeP1KrM278=
X-Google-Smtp-Source: AGHT+IFxlAXSV4W5++7XWnPzZ12JWvBKJO7xkpt1cyOakCo8rv+0InqQQYz6OthfTBtMJczwkWlkVQ==
X-Received: by 2002:a05:600c:43c5:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-464f7027ee6mr62778095e9.4.1758360383862;
        Sat, 20 Sep 2025 02:26:23 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm73648535e9.0.2025.09.20.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:26:23 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for Airoha AN7583
Date: Sat, 20 Sep 2025 11:25:34 +0200
Message-ID: <20250920092612.21464-1-ansuelsmth@gmail.com>
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
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 0278845701ce..3f556d1327a6 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -59,6 +59,7 @@ properties:
       - const: mediatek,mt8192-pcie
       - const: mediatek,mt8196-pcie
       - const: airoha,en7581-pcie
+      - const: airoha,an7583-pcie-gen3
 
   reg:
     maxItems: 1
@@ -298,6 +299,26 @@ allOf:
             - const: phy-lane1
             - const: phy-lane2
 
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
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0


