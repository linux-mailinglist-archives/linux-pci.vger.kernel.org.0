Return-Path: <linux-pci+bounces-5257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D588E345
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5261F2E08C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6A181310;
	Wed, 27 Mar 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW0wI5Tc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACC1304A6;
	Wed, 27 Mar 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542309; cv=none; b=D1lZjuHNfHqIChXzbVXJVNcN7IdnTYKN44BoljArMMomZddzOONr49NK0qzUS7JxJZ1IUenytnYioOKmj5TDdKi4BHQ7eLlpxS1Xd50rNH9daGbX9g5Q5UA+QOyEpYZYGEdjGgYVW/kz1g85JY2+qWfUuul4PqSJBvC7UxpQ9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542309; c=relaxed/simple;
	bh=gPsBJl3+lGsrZ281LklEHOtcSRqfcnJMec/DLgQQb8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVxD+Ps+HcTqAWErD6OlFUULNDjRe2t8URgpxPASIoSxvw0YeXt5Ug+fBkM2A9ceQPfJT8whbJ6ezPVp07hG/KhcQj3SPk+06HLhHSAoiVuGkTSUIct9YysW46kEwBJpxxarKbMJwRIBjzRuW3zh4k+85P+5O4lCHt+kLgrmDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW0wI5Tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C66DC43394;
	Wed, 27 Mar 2024 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542309;
	bh=gPsBJl3+lGsrZ281LklEHOtcSRqfcnJMec/DLgQQb8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW0wI5TcjqElnMJHmeOioieZAl/zxdpw5U71hNTwAiAOmdOqr5q57K4xXpMTNQlBJ
	 6e+ut/LCN1zr7rhWDODQTIhyaGsz/yh0n0UwnqPd2EMLtSGSTH2JBnm0p8kF8FTUWF
	 F/3Gvz8GPQ+FkMlTLULmuhkOMb4LUvPzx++1I+ojrCBvOAX1do3NRcymbivSJA7D2H
	 OX+QqBB06vYQxtVrF3KHwgrhGaxnrPU3HS6SK11uiB0QF3caMzPMbuu+pVKBYNfTzz
	 pvSOT4kzC3+TfCifJDNMaRLnoaXfWC2tpSig0c7hZlBJfYf3zUa7w20oWjayF8El8t
	 MOnvJgJ3IHZ8g==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 2/5] dt-bindings: gpio: mpfs: add coreGPIO support
Date: Wed, 27 Mar 2024 12:24:37 +0000
Message-ID: <20240327-procurer-rascal-33bca7d5d14b@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IMTT4E9wFHswzy76N6YWQpUY7X5/7P9UPRxEwIXGGcY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGksAqwlMoeOTjkgsrLk+pXsCh2fyQc/lKY92M0gOH2W/ 432/QYKHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI/XdGhuN8d3y0a4TunTev fNci3W7XI797eZTd4m2zI8QWsjrJPWdkmBsmwLN97pkHCSZ/pzQrpjxmr73q8vSSXd9OEc71i/1 k2AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Jamie Gibbons <jamie.gibbons@microchip.com>

The GPIO controllers on PolarFire SoC were based on the "soft" IP
CoreGPIO, but the inp/outp registers are at different offsets. Add
compatible to allow for support of both sets of offsets. The soft
core will not always have interrupts wired up, so only enforce them for
the "hard" core on PolarFire SoC.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/gpio/microchip,mpfs-gpio.yaml       | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
index d481e78958a7..6884dacb2865 100644
--- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - microchip,mpfs-gpio
+          - microchip,coregpio-rtl-v3
 
   reg:
     maxItems: 1
@@ -62,12 +63,21 @@ patternProperties:
       - gpio-hog
       - gpios
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,mpfs-gpio
+    then:
+      required:
+        - interrupts
+        - "#interrupt-cells"
+        - interrupt-controller
+
 required:
   - compatible
   - reg
-  - interrupts
-  - "#interrupt-cells"
-  - interrupt-controller
   - "#gpio-cells"
   - gpio-controller
   - clocks
-- 
2.43.0


