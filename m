Return-Path: <linux-pci+bounces-17901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F0F9E8C05
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48B8188587C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C52214A93;
	Mon,  9 Dec 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN+e72b6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814622C6E8;
	Mon,  9 Dec 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728800; cv=none; b=aXClWaNhBgaARpmKNW3XutOhQ11BnXuq9Qu1IydyywVeGN2I/eCuiUDW/cecOn8jPPaxLmi1ovn7+3lzZJUKVa9ECnstzofmt9adgJbX+PJkX0+4i1O99tj34mLg2Ub7TYedp/8G+KA8k0UOgrCf9Zjn2Y0IXfyyval+DcwqG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728800; c=relaxed/simple;
	bh=cHJfwOz6SE70EfLI4BsWXItyRAe+eKtShLfZNU7eGSM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eqx3TJH7WQSHha/F9dF2DyTc6s/fImuvD2MU7AstiupDZCgUPoJQcHaT3Bbd8FuR2QDU6G5ZxczRgIjMX17KkyAqt4zFrEa8kx1Tf9RbUwTPznDppzH1m0N73y1PUrzaRvwLe9MqJWETGtO2UBM7Cu7AxEG7SA7j65mJIuXnzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN+e72b6; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e585968a8so2467890fac.3;
        Sun, 08 Dec 2024 23:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728798; x=1734333598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DukJAPZCrQobp9vqG6nmbeWCxatZIx1mt+QBoi3MQKQ=;
        b=UN+e72b6mymLyn9sjXtt8s6YIOSSB+wW1NjYtEPnuzp2YWatleqqE3fW7MEJoLF9Mo
         Rt8BtTILy3xmNTRJfadJqjZnHsL3c82Kyw3H+r+i8mryCpyqYnSenNhB+Ef7QA2D+uoN
         RqmJYY1awWoUf3NE7AQOQ0c27pGA8d9qMeMhxIdF6YSl35bfDItZT4E9B9Kn2egZZ46n
         0L54FazCf53G1vKcBgHxJ9zuYVXhGQINYxGpjOtVC6tLp4P0tEvWCYF0QE2e2/4ikR0Y
         kL773dGhiR7ZCTFVZS2zavsWBk3IQPYOMYJGeLroy92rI+SMf/JVw2LjYiiMejLPx4hS
         tvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728798; x=1734333598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DukJAPZCrQobp9vqG6nmbeWCxatZIx1mt+QBoi3MQKQ=;
        b=A67AsyHsw3xKIwuIcTisuEKFuPiXDDmB9BiO0CH8Y+JIaPdob9aczMQN3u1d9Y13sb
         rpnzFcMKuwV56Efz3GtnFVfJ+v5XfCR2OCNQZLX5qY4mnWUUEdgIGAWl/5pYv3P0MYqU
         SAXgyIPny/3aLgBfmjr/S0As2XhyhOOroyu3pcpisFROWAjNzI9+JKd8BdoKiZpAXCBf
         mfKLlauqk/7AVQ141wkBgGQ+TeHec48022HCpLpcaw031A/PRYMo3Yg0vUxbzXGvGweu
         FDGmCI3mNJ7HZP0+IhCPsDYRp+YWxMVzMIUEwzaX1abWpodrGqEtdU6PvAcJ/ToNTmjP
         62lA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Kt9HqXmyBqe34kpwulMvNp4tXRvZa8Vlxub1GV82cYkdCg+n6mcjxO/9upItSXjPddfEEjqL17U1@vger.kernel.org, AJvYcCXLu9Jek0iz0UpkHMreUJbM8LIMDSKCVK1P2c3SMn6VLRsDSfBr7DfD9CK47zWiiaG5C2umXuSLnBJ4E8g0@vger.kernel.org, AJvYcCXapSt6IoClhwLL2pfj8FZLSim1KgOjzFF+Oy3sZaPCUpedwXXmorWMbMXCuNhnm/XJj5zrpb8rdqOd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yr0j+h5UaTVXvX5+7glkGKxut4e5YqAvOGX6McHssNABg+/V
	OVX6ZF843+BBx5zCKCmH0tmZ854qTG7uPZftwIQ9SjIy4MC9L49Kb0h/jeZd
X-Gm-Gg: ASbGncv2j/X8OCE/M2IIGrS6+5Jczr7Q7p0GytSwnUtbxS09Jry+qmcQNuidIYIMTz2
	SDpAVpORi7D9B1lrbCliRnfw0mkm8KHcHZ7Vuoq08tpqjhPEJX1OJETvLdSYnoqO6qnxjK2l6Sm
	b23pHZJg7C4Uuea5n3/mbjrNwsQc8EdmSaSSMsJ8BaPv9c/YWMyZsXytdMZIqIlMPWIiCp0XqNc
	1KjCCkUWasowq7OfgY/K53ydwNiHmx8AbfPrknMuEyUtSwbT14aXEdLlAhB
X-Google-Smtp-Source: AGHT+IFW63Bwfbwt1r7nEra6/X0zHjZplwbZEEvxrVjHJQWcqJ6dsspcIrEAlljRCDVj38n7O3xh9g==
X-Received: by 2002:a05:6871:c709:b0:29e:392d:afc8 with SMTP id 586e51a60fabf-29f7329ae2dmr10035201fac.15.1733728787275;
        Sun, 08 Dec 2024 23:19:47 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f5677528bsm2530681fac.28.2024.12.08.23.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:19:46 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: kw@linux.com,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	lee@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pbrobinson@gmail.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Mon,  9 Dec 2024 15:19:38 +0800
Message-Id: <05998df400a64734308e986069ca0b337618e464.1733726572.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733726572.git.unicorn_wang@outlook.com>
References: <cover.1733726572.git.unicorn_wang@outlook.com>
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
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
new file mode 100644
index 000000000000..aec31ec97092
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
@@ -0,0 +1,141 @@
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
+  msi:
+    type: object
+    $ref: /schemas/interrupt-controller/msi-controller.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        items:
+          - const: sophgo,sg2042-pcie-msi
+
+      interrupts:
+        maxItems: 1
+
+      interrupt-names:
+        const: msi
+
+  msi-parent: true
+
+  sophgo,pcie-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SG2042 uses Cadence IP, every IP is composed of 2 cores(called link0
+      & link1 as Cadence's term). "sophgo,pcie-port" is used to identify which
+      core/link the pcie host controller node corresponds to.
+
+      The Cadence IP has two modes of operation, selected by a strap pin.
+
+      In the single-link mode, the Cadence PCIe core instance associated
+      with Link0 is connected to all the lanes and the Cadence PCIe core
+      instance associated with Link1 is inactive.
+
+      In the dual-link mode, the Cadence PCIe core instance associated
+      with Link0 is connected to the lower half of the lanes and the
+      Cadence PCIe core instance associated with Link1 is connected to
+      the upper half of the lanes.
+
+      SG2042 contains 2 Cadence IPs and configures the Cores as below:
+
+                     +-- Core(Link0) <---> pcie_rc0   +-----------------+
+                     |                                |                 |
+      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
+                     |                                |                 |
+                     +-- Core(Link1) <---> disabled   +-----------------+
+
+                     +-- Core(Link0) <---> pcie_rc1   +-----------------+
+                     |                                |                 |
+      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
+                     |                                |                 |
+                     +-- Core(Link1) <---> pcie_rc2   +-----------------+
+
+      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
+      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS
+
+      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two
+      RC(Link)s may share different bits of the same register. For example,
+      cdns_pcie1_ctrl contains registers shared by link0 & link1 for Cadence IP 2.
+
+      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
+      this we can know what registers(bits) we should use.
+
+  sophgo,syscon-pcie-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the PCIe System Controller DT node. It's required to
+      access some MSI operation registers shared by PCIe RCs.
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
+  - sophgo,syscon-pcie-ctrl
+  - sophgo,pcie-port
+
+additionalProperties: true
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
+      bus-range = <0x80 0xbf>;
+      vendor-id = <0x1f1c>;
+      device-id = <0x2042>;
+      cdns,no-bar-match-nbits = <48>;
+      sophgo,pcie-port = <0>;
+      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
+      msi-parent = <&msi_pcie>;
+      msi_pcie: msi {
+        compatible = "sophgo,sg2042-pcie-msi";
+        msi-controller;
+        interrupt-parent = <&intc>;
+        interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+      };
+    };
-- 
2.34.1


