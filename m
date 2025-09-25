Return-Path: <linux-pci+bounces-36988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F7BA07A8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540F84E7803
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA0C305077;
	Thu, 25 Sep 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON6CbBYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C83043CA
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815627; cv=none; b=Lwj8MKlB6f7oix6nAvHZq3UIem6sb4HxIwVdoxqno1HX9qSgXoxTkFur5rXzFPyWyt1hkdMoz9tgg/KFMOKEfJKMv1/Pynw6rH5IoVwOUVNbY4HeiAKK3ghnoBrVEAsfzdhfQikouQl7Ymfu5TFMxkLrRxCVkT3Mhra8k2sGH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815627; c=relaxed/simple;
	bh=vqa5P6oczfhyljtf37ARWG4nhCr1jF20jEq+N4qGoAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrIRMo+OWf4QfRwfe51UeXW1g1HVqYgHFB2Ws/ou2+2VN17NSQn60v4zshemTnQUBs7B+pMIh716ASAJ5pI87LVn2EtmUvi1m15exk6w0t8pamB0fRi/t5Olj7NczuaoP11T+XiVBz7ThBMWfylERh6FaCAEFq5kQ01AYVOPTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON6CbBYB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so12669335e9.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758815622; x=1759420422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJqNYQ4cdfTFLv2z2ldssPg3Z08F+8b/OmsBnqjGcYc=;
        b=ON6CbBYBY7xb6rmXno9lxNNU8smXMHCG5OeWILtLySOFg3YO5xiwSBbcG4wbbyHM6U
         L17X7WGwbD8tQR9a9Y41mjivYaPohcQoqaiqXa6hJ5arT8brd6T+pQp+/U3gCtAJ1hmI
         x0m1Ni+NqgAbXRPVnf7c7M1jerBxgsuLHpdvaI0hazrPO72m7o4A1HLDryubSggB8SOi
         8XEqTnHhc3AFUN71CWhFnTi2EtDLHDkssiGDNLL3CQdEOgRTWq3nlJ9zrBPqua4kqAXo
         qfoFIzRa8hZcOz0gwLe8v6hu+PyOAzRk1Wv1rU2QO9krSCLB5h7fXpv1NIpN982znRnM
         nsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815622; x=1759420422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJqNYQ4cdfTFLv2z2ldssPg3Z08F+8b/OmsBnqjGcYc=;
        b=L2vb2usUVMIODVHqzonyvUINLZfv4ErLpQLanTTdeRBpC69MgGdrVNO4l9V22hLkl1
         ghoOuZLrr80bNJcj5LXVE/pNWzRGJu4d1J4iFx7A9Wz1nQ5NOYyoEDSlirVoDInP4mVO
         4DKfzO0ugK/EF50YBVGAD/5oUmskac0hd7h/o4VKzDlyIxEM9TBRnEWq08305UWWgF5x
         J4r7N2EiDyuT5RZEXDpkySjmmk4U8bA4jeo75eeZWv0McvrzsvYxXlBh4H0go2Cu/AsK
         Qu3OKBZ3q9pukkzy9B/GuTceQzwLxJTnbSRzi8Oo2/bewsQO7XXP+jcB9gsTHpERLjqs
         ljVw==
X-Forwarded-Encrypted: i=1; AJvYcCWvxktbmGxpApU3FljS/kfVUP2DpD1DZcfP488z314hcIkZfh2JcZJrdQXfekdsfhgDZyDXUH+XXDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ0Y010+4HAR8PY/iv3AzPaF02soCVX6LcxewU/SIb86K2FlU
	9IPH++L2Q4JAaIdhFGLJ0DAxiVIyHcR7Qo+GRZMI2735NfxNagJ2CqOo
X-Gm-Gg: ASbGnct9AdL6xdYmSBgrCwquEX2X2haZVefDcfLe+ucDTOyrG51aQvHma4TjZ7aNkmz
	BurnSqHJSUm/SlJCQ3JuW39XG1gw52JlrLY8yM9mMChfed55ZozqTJLnMhmfj1UTn2qNWGzI0T+
	ftbiOCOcKWEWOvVCOGj1wZhkkLN3oEfn6WSUXT4pXSvjYyh6pCMQJ7afk9QrlrwfLREH97wvd0m
	eVi8kSnY82n6rREQT2ls3zO7MWCCumsKpOgu7FYAjPfxkkOyPQyccxxVze6J4R4KHbXmWWf/d9d
	evafqI1Szqk+2DPvhME5e5O0CnoUSudkloiB1HxaA+29kWZJkX3ZP1HWu+OSPxF58VXCmMRXIMS
	E1FyiOjBUjrGKSSzl8BeGf9btC5Tp6NT9zVM0tDDQQTakgAkfbHLJZBkVgyimxQrTpwqvdIAGSO
	cbNZPWxQ==
X-Google-Smtp-Source: AGHT+IFdx6Jo6h2Zlp0z9KNqZKsNTsBYY7KcgSjHFZWdKQaN+BPd2cWlPTLOF0WlCzxaWRiRR5GgVg==
X-Received: by 2002:a05:600c:8b16:b0:45f:2bc1:22d0 with SMTP id 5b1f17b1804b1-46e32aff787mr40556945e9.33.1758815622333;
        Thu, 25 Sep 2025 08:53:42 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm98449995e9.7.2025.09.25.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:53:41 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for Airoha AN7583
Date: Thu, 25 Sep 2025 17:53:08 +0200
Message-ID: <20250925155330.6779-1-ansuelsmth@gmail.com>
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

The compatible have -gen3 tag as the Airoha AN7583 SoC have both GEN2
and GEN3 PCIe controller and it's required to differentiate them as
different schema are required for the 2 PCIe Controller variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes v3:
- Add review tag
- Add comments for compatible inconsistency
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


