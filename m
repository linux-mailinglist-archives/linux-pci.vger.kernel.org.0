Return-Path: <linux-pci+bounces-34958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74138B39191
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D316D671
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32814199931;
	Thu, 28 Aug 2025 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAmTaQs3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C530CD8E;
	Thu, 28 Aug 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347426; cv=none; b=LM0ZISwJDq6CfoShTPZiEy9a299Z6pgiK+haI57pyQH2fOtclyKvxsz+ZSjE2wWpOYmBkNtGDvPUlXXg3+Y5WS75ZTn/APheaT5aIBVbJXIXCg9F6zJyjejB3ltWmicjB5zNSf0xFZUAgFiA5OWVxQXxCegXD1OL5SiWkV027fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347426; c=relaxed/simple;
	bh=Vb4oqaAF4AAxL3ENJorO5f5xQALMvDpa1QKstivrv7o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmOt4GzfeVcrPVKr8nOJMVSrU9AYj9eFVUk/iMn3Io15grGULyJg0hPW2E6yFi0NJnpfQoukJPZWw4uel5QesRy6zo6fhBZiAu9jWcAhnNG2QEQava0QXDlJcER/2G39i+QNUFpHfkLd2fQCxHCU49T4yQS8GnrJ5Gde2/JvEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAmTaQs3; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61e06547f73so420270eaf.2;
        Wed, 27 Aug 2025 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756347424; x=1756952224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGcfuQl3yrFvMTXn2qxpt2B+zvl/KTrt/bi1+ryxB9w=;
        b=AAmTaQs3s/2BzP+H6ZS56xdR+v8uaNd9/wXfMUNqV7ypX397P8Yf40n7I61lmRu3Cb
         tXhKRgtHpyY5EoOtbdYTha7UrC1f853ZX7dO+uvMLLBqfRrUsgBXBsHvjOW4lFV0TiBc
         UkZxTWO8craedvO0oBZTkFKj21pB9Rk2xD4OIuZ76UHE8f/WIiovMCXkCcqaYW6HHBCg
         Or5nWKm925/GesONlnMmc77z85i68VPaiNtw2nf8RV2ocOwa1byERgp0f9/s3iZmXfxO
         Cgs+A3DIeBgSrS3keWc/Zr/7GW3HM0w/i65Ssp1M6V+pk4Ka8oVFq9NQIB2T+65av9Eg
         6X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347424; x=1756952224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGcfuQl3yrFvMTXn2qxpt2B+zvl/KTrt/bi1+ryxB9w=;
        b=Kzy7Ev/4NCUnMFPm7A4hswT846J0dUJmmpwhHAtntrc7LcBjLtHLoUS+8Cqiq/xqIq
         bLjBCtUv9XDnzF6dCLOx560/q79zt4dHF7tgF8Yjt2A7iyz/qrd+QGKMcxXw5Ix5WCPX
         dLw2ZVIdCbJ+4Y6XwWfcn1eTLE3HqhmBbbegK5cGrFwoaeEPIeANDZlStbqllz+SyPto
         OJRW/bQh5KBratuCpNS2SOSDeyQIo4mP64dUV/5neVK6w4FJkqDX+DyvgWQriGTZjrrq
         D6dJbr+NzLxBTB4mIVeqECpRIMvIdqh+imgcE/6tABULez3CfkgFsLpuhcXgfu8yrwDZ
         GBSA==
X-Forwarded-Encrypted: i=1; AJvYcCVTMuGHsBc9xHJSRYOC7MQQXC9RV/FpcOONp43/tzaBLgwmZNxGWbrpTOQmxrl5e+cHA3MPwS1BMLD6@vger.kernel.org, AJvYcCWSMtQqjCXYNVM23NAApOAdutQgwkQYA+ZsaK6wKCBbZTzoUSs55gptLSGg4Ew70YuIrkoAkwkMGATSwJ6i@vger.kernel.org, AJvYcCWb3TTbxT4YxC3suqUQ9udB4zKS5+QhGcsNZsw3JnbERW7AbjyXiVaGNPotXHHwUT/nCXmQKvSYLpc3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qeTQB6XiLHCjiX5oZP1GWLSLBzkhmabQaXHFsddetaLiaaYh
	GZUAfhWMR63SIeGtecODwIk2SDUTS+foAie6NwDmZnjyUjlmhSdcrPCP
X-Gm-Gg: ASbGnctg3cdTFshclb6xPKnH8Pjgf+hjUj/Hfh/VTGn+fsaev64bES7RNgV13TqwbmP
	Uw1uE2xPlHQ9mC2xGu655syiTtILTAwXBehjh84mnippQpFvZbTcNerB6n9pVqVA506tXoWnrri
	PoI+dC1Lzrlp8YJY0RNjwX2QiVSFGQNZJ0iU6Ohnt1XyeU/EpCY5DAi3k41M5FZjhjCNwrJ+3my
	MlRGjCFnZDh5OUW8c8US5ZMgbZHOSJFW0TxTMv4uJ2mfNrt6AKbGJqpkdQ9oJfj8cD824Rehukp
	s05zd7Zb//n7yD1Ee+bYFLSSY8dqqJ5/pTke1y8ZHeBJQ0IYsesM6EvNgqUjQ2KIbyr5mYOWvpm
	c63Ny3eKmsj8ozhU32MJKl7tn0syAwyrbtM7hkYcDaVI=
X-Google-Smtp-Source: AGHT+IH2Q5rRfVSJUWNf+uE6eBwAzJ9xOs26TnCu8U9MzwRkPuvLFqxwmj/xUnRfEFrOQCUo3+by3A==
X-Received: by 2002:a05:6808:4f50:b0:435:774c:c443 with SMTP id 5614622812f47-4378516a635mr10246498b6e.8.1756347423714;
        Wed, 27 Aug 2025 19:17:03 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967dbedasm2276940b6e.13.2025.08.27.19.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 19:17:02 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Thu, 28 Aug 2025 10:16:54 +0800
Message-Id: <c9362bb49e4d48647db85d85c06040de8f38cb83.1756344464.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756344464.git.unicorn_wang@outlook.com>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add binding for Sophgo SG2042 PCIe host controller.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
new file mode 100644
index 000000000000..2cca3d113d11
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
+
+description:
+  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pcie-host
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+
+  vendor-id:
+    const: 0x1f1c
+
+  device-id:
+    const: 0x2042
+
+  msi-parent: true
+
+allOf:
+  - $ref: cdns-pcie-host.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - vendor-id
+  - device-id
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pcie@62000000 {
+      compatible = "sophgo,sg2042-pcie-host";
+      device_type = "pci";
+      reg = <0x62000000  0x00800000>,
+            <0x48000000  0x00001000>;
+      reg-names = "reg", "cfg";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
+               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+      bus-range = <0x00 0xff>;
+      vendor-id = <0x1f1c>;
+      device-id = <0x2042>;
+      cdns,no-bar-match-nbits = <48>;
+      msi-parent = <&msi>;
+    };
-- 
2.34.1


