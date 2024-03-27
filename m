Return-Path: <linux-pci+bounces-5258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA988E350
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5574E1F21810
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDB181493;
	Wed, 27 Mar 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwr1lYv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F818148F;
	Wed, 27 Mar 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542314; cv=none; b=NannlXB46Tx+Kywwx60Zmc6f6MwAL2o70MZnBuwcolJeXGXDc6zXQ9IJAjFZ8XPkfjD4GtpiC/eKA1PwUTnKgMLVdpf8j7La+cUuftA/oVKUHFYDOH2Y8kPu/1ikZweO0KGwWfHrudbra8S6LRL0M9xt7TOZ7KTDye4K1qNqdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542314; c=relaxed/simple;
	bh=038VBIDo7wOXasBPUdMTZ8PLRSWfD0Ugbh34YKcaqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii19KBDOEH7YAYN2vV+X0tWKB8Jqr/aaBuqcOXNrcnDMDA9s9z24vvP3/YVDFs5S3NQ41KYm5NGDiXsdRO/2QUJ+RKXIMTg56k2vyqcgYFu7O2yPtK31yJBNubtwcpqMmXny6hUSozQfEjz4mgH6A+5OjIXkTuoHnyBxeqt+Qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwr1lYv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23145C43399;
	Wed, 27 Mar 2024 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542313;
	bh=038VBIDo7wOXasBPUdMTZ8PLRSWfD0Ugbh34YKcaqAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kwr1lYv2X1QC6vcz5l+zu2KW28jKDMcUCckfHzTia2WHhQHNUkkqzcxlIhuH8bH0V
	 oHRouwHNl91AZtFpfS8uSq4B8BjUJgT486AJqQp4NaDGbAoH+TEFEEZWT4AZusOaye
	 ZNM0LetAPWIAXXHZHwqm7me/VV/2c/Mrj3fM3pvBRJkG7thwftZ8ovy/oN874gGMNa
	 Ya4K0P3ZAtuGs68/oELfhLaGSxxvqRF3HHkpASq14EzDDMcOoNNu2QpGaPK3yNH8+q
	 gZl+bRFZmz7AaPGs47pDBXEfvJz7WJebsBOGGgbXxhsynKneIAdK3NkdTNVFQ4ijgr
	 at8b6J9qN8j7w==
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
Subject: [PATCH v1 3/5] dt-bindings: gpio: mpfs: allow gpio-line-names
Date: Wed, 27 Mar 2024 12:24:38 +0000
Message-ID: <20240327-overrate-overuse-1e32abccd001@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327-parkway-dodgy-f0fe1fa20892@spud>
References: <20240327-parkway-dodgy-f0fe1fa20892@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DQ/xOk1TKoK84RFxAr9nUQRMqrU2scD4cxuVi4j2DRs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGksAqyTq1tfxFl23mh4eOftRUHLExaKZ7ubjEPOpDEK3 2X0bLvVUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIk08TEyXHq56IBz2p6VonO0 3HTV9HW9zr01q1DPEmzO9hK6UpOUxcjwbcfUFsHNTqqXMqcvmMXHE3Zk3bklDh+7eJ8t2SI0c4Y FPwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Jamie Gibbons <jamie.gibbons@microchip.com>

The BeagleV Fire devicetree will make use of gpio-line-names, allow it
in the binding.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
index 6884dacb2865..d61569b3f15b 100644
--- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
@@ -44,6 +44,7 @@ properties:
     default: 32
 
   gpio-controller: true
+  gpio-line-names: true
 
 patternProperties:
   "^.+-hog(-[0-9]+)?$":
-- 
2.43.0


