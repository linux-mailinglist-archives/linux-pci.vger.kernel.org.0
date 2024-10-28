Return-Path: <linux-pci+bounces-15450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F69B32A8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 15:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF8C1C216FB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12851DE2D8;
	Mon, 28 Oct 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cKW6f0KG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5A1DD86C
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124444; cv=none; b=SNqOFIU4M2LiLT7TsMo1YuGZ4r/5dLV3sbSl5mPKvjz9HNikBU1jmFL79eeT2OsYA8TcHJrcCugPYfLh8dF0yU0e+KyhRESXGtz4+omXiOYCmKoxa/TRV0fkxXBtd0WqdJENYf7NTcBtvDNj/Rwy8RmTlghHZalAnPvP21/nfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124444; c=relaxed/simple;
	bh=37BIVVxAvp06DoclbS8nrf/h7HI7daZAV/SbOYBjkus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtnxEJB01gXdLrShbeoS1nR2zlGcYMDutJrdySxMCTHG039TyC8Non3uo1JlybVTAuRRo8ZIWxz1SVZHKYGddjt9S5JcMp01zwlmpgkAbkue3cOVCfTXOtlThiUCqRsJ7PWmcbefnvu/blLkqdeu7cjs72b9P5MhweniY+0a7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cKW6f0KG; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso6743294a12.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124438; x=1730729238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI9eKYh0F26+LR3GPe1sodJ7zzCtCgj8qtPEzcqglJE=;
        b=cKW6f0KGXDvrHC7G7k/BAaAJ3jvEXC7fyAodzN1DHl64lDld9JPbwHheE4xMRuU/be
         BfCjTNjMi6GwuxqG/yY4b8ALrVa12tOP0zucc5A2lU3vba9TaIBLicuKLKAx8lUJKSEC
         PX/gZzdsI9cP6y84OYl6oODL8B69QnqF+tam8IYXDEia+kpCj/XSgGAedTIlgoXgK+kg
         l0AG0LGsMLZjPJanlobKS0U7SrssbvVRUb9P7KLZGWqT2YpJ+Qg3oYw9G4VhCHv3LX35
         HhY3JJx4gSnB2pSuMACuiMJ92IqetqXXbfDEdMosY+8lCz6PZJhyJ+CUiNos4Zqj0+LT
         2WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124438; x=1730729238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI9eKYh0F26+LR3GPe1sodJ7zzCtCgj8qtPEzcqglJE=;
        b=d7NwVRkgfLLpr2KWxsfXV54yG+r5G9alzyV8p9NdPzavkGHGcINB232saM/gxegQLD
         F5iaue3dQ8CWKocnkX94cYKyd4r7AVQtm7BGKaauSF7gluxCLnHSVwHKjx8oe2bZWVcx
         WOCBfpG7kRZ/PR6i3UQO0VvnC7vQ0CfeLedQzDeF3uqfRU/AXYZHCtWXQ7uK345hQmBo
         FKaZXQLGrOOK2eT6ioApQLWPAkaLPR5b//ztzeoDkF6qZWOILxP6RFwi13YWrLwhMvjX
         G2LjD8x8bKqNwPoSTuzrl4MSn+YyqQhDfIwpH/Z6jOaFOFrhVEl1LFeRVCAmmvuXYrYt
         bHCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQYCiiW1/+Gn83HBboljbyN60OfRFM+E+zvknudMrOOgCUtkeFuHYbprPm45I697tBY5neb0OxfKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybk2B204ZpFMvMpETX1aVRNhnDXDNnAfP0CKmYe1hwWGTadI06
	bbCKmqA0FR3MCngx2CrxoVR5tIOADmnER0kjvb4jl31miGxxIcHb1uanRgwPr/k=
X-Google-Smtp-Source: AGHT+IF5qNRgzKfi4MHhOJRZ8tqZIPrE0osHzwKattDyJF+pEfAMuUnEueh0yzfRuzZGt6IlIDK4Xg==
X-Received: by 2002:a05:6402:1ed2:b0:5c8:df99:a6ec with SMTP id 4fb4d7f45d1cf-5cbbf20f089mr7633425a12.14.1730124438052;
        Mon, 28 Oct 2024 07:07:18 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631a24dsm3186275a12.74.2024.10.28.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:17 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3 03/12] dt-bindings: pci: Add common schema for devices accessible through PCI BARs
Date: Mon, 28 Oct 2024 15:07:20 +0100
Message-ID: <2948fdf8ccf8d83f59814d0b2a85ce8dac938764.1730123575.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Common YAML schema for devices that exports internal peripherals through
PCI BARs. The BARs are exposed as simple-buses through which the
peripherals can be accessed.

This is not intended to be used as a standalone binding, but should be
included by device specific bindings.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../devicetree/bindings/pci/pci-ep-bus.yaml   | 58 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
new file mode 100644
index 000000000000..e532621f226b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for PCI MFD Endpoints with Peripherals Addressable from BARs
+
+maintainers:
+  - Andrea della Porta  <andrea.porta@suse.com>
+
+description:
+  Define a generic node representing a PCI endpoint which contains several sub-
+  peripherals. The peripherals can be accessed through one or more BARs.
+  This common schema is intended to be referenced from device tree bindings, and
+  does not represent a device tree binding by itself.
+
+properties:
+  '#address-cells':
+    const: 3
+
+  '#size-cells':
+    const: 2
+
+  ranges:
+    minItems: 1
+    maxItems: 6
+    items:
+      maxItems: 8
+      additionalItems: true
+      items:
+        - maximum: 5  # The BAR number
+        - const: 0
+        - const: 0
+
+patternProperties:
+  '^pci-ep-bus@[0-5]$':
+    type: object
+    description:
+      One node for each BAR used by peripherals contained in the PCI endpoint.
+      Each node represent a bus on which peripherals are connected.
+      This allows for some segmentation, e.g. one peripheral is accessible
+      through BAR0 and another through BAR1, and you don't want the two
+      peripherals to be able to act on the other BAR. Alternatively, when
+      different peripherals need to share BARs, you can define only one node
+      and use 'ranges' property to map all the used BARs.
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: simple-bus
+
+    required:
+      - compatible
+
+additionalProperties: true
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c55d12550246..ccf123b805c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
 F:	include/dt-bindings/misc/rp1.h
-- 
2.35.3


