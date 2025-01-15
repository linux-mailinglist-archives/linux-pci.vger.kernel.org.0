Return-Path: <linux-pci+bounces-19828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EE9A11A64
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AD716654B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9522F853;
	Wed, 15 Jan 2025 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxhsAHBz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828C22E406;
	Wed, 15 Jan 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924809; cv=none; b=Vp7pcsLBVOaNAeBin5MMfuPOgf2H/KQK5uiixFgT66Y2eBXPPxZZMrUlmn0MpP9IaXwE2XrgjGqjl1zS+wkQ+uquVqJWN32x5+sM2KY2K4IMlxC/JLic+wWDrd8ZKmM4HZ/kRtj+CRSF0GNoYs6aSvPCezx2N2Z4uEtUg62IEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924809; c=relaxed/simple;
	bh=kwMnNoWh9WbWQ6ib+RUMP650V9rwYjD2EYIvkhy7+dQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2tJO012orgpuFM5AJoa+IwE5JazLw2WyhYvEtEyYmB8EaMwRzhoLpcRVnN7gtzqwffn7YJl6N9n2T4GIUQOtapztRq/WEofZMu6H3cuyBIDtRNarJDiRM+WCxtNi8w41+PwFazscaSLPlDNDDT4StMMr+hoQ/S0pDBdDV9MmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxhsAHBz; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f321876499so327359eaf.1;
        Tue, 14 Jan 2025 23:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924806; x=1737529606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6LsDSRxso3EvoawgFxcfFBhG8RtxCRF21ny5YM/h+8=;
        b=jxhsAHBzfN1qiWsEw+dbZa7pjNCKTt51N07tswoifVJornCnio0SiOfy3eGPl9M0Hq
         WQAStwVqxWQCq4vpoFt1W0AvjsreosM5ScpG1oXzw5yE6vhgiGCGoQbmD9zxwrcGVFD9
         +yAVw1owOWIwxkViAXvMELweVGoTaQHflQWCsm9yvqyxO/WyZZe9HapEj4UfuOdKGgzF
         DVvx5UhChsajQHEvy4OomcHZbk2bzMix/iZBJs6NH87MOzKJTszAJZbUA3yy8H5P+kxI
         LTmn1BAWeqL3+fTzTCV8x9a30P8Zxx7k4RLEuK+xhk62Mki4iR7ss9blBLz0C/BOp8IT
         ZkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924806; x=1737529606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6LsDSRxso3EvoawgFxcfFBhG8RtxCRF21ny5YM/h+8=;
        b=JAYsll4KQbO/PwUbpq49vUggHGwO6TCXxJi5Hrvi0IDdxfhNaS6klAw/hHC1m4P/i9
         uuKi8XpzsxsbEZGnNk/ZTLzXijT5kB6DX4VNz25w5hcXmOpgUsrnjsnfLLoe6eyVum19
         l4mPPRe8JnV8R7p5hXCMKWtCRb9FFsPjabpHNdfuxLE1/fMx3WPh3WnH42zWkA2WkfBf
         jTYI2uks+CXmgKG0i+Q6D7E+YX68Nm53jgzwS1tp5jzRdcX4VNDWpQTG6WFR/bSL3pEy
         vylsTZV3zyiCDxZF5fDMcf7m8r0JflZCKYA79OR9fl1oWmiptKMDmZ7nYZuwL5hH8j1l
         XtYw==
X-Forwarded-Encrypted: i=1; AJvYcCUr3C86Clu8gaElG3oOdFK6WIFjSQH5x3HqpMMz4PBLqg70jLNiHnoQL0mkuLXzS/5W9r0wrIOZAbwi@vger.kernel.org, AJvYcCVANAGWSCBjKT90FGGHGdMciLKBEweRWjTMJC6zU8YulZT5wP182yo/j8n5rgEldN5OshN/mqRWfq56@vger.kernel.org, AJvYcCWksKS8TuDOnWlmglk3XdHDrVIhXytKoPZoJl9oxOeSqcO7yPl1D2/YXGqrF7wA+YFaBflILTnTTS226Wi/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zrqmcb9td0Acm6HeWKHSYXPtVA3HkKUoWMGAloUMYNjvqxFA
	9KH6qgV58rgV1sT+xI8uc2ioO/4g0kNoFcncM5qrcBEH0VHLrkjx
X-Gm-Gg: ASbGncviWEYCHWALq1ZkgwIeM8WQaKZf99B9n/BgLBxUZcm7Ve7xV5Y368WGULC+EGC
	0isSa5WT/TzmvuMLDIFuAgdSk9h2C0X3vTl36FFG+N7UC1hbGM3Xv0a1tybSCPc+cCce6DshiYx
	meNHGuepS/OHseQnWI/fLb9tnYNyComAbXcbcE77piwQ5lT/ngKGIe538VTx8EC24u12vVDkwQ+
	BVrZGGfatLi520SpdfLEdgk/kwuHGNtsZCyQJrAcxLZBi4Odg/aNYVLDw+544FCkoE=
X-Google-Smtp-Source: AGHT+IG1BnRm1bURx9ei4lbPam8um8KU2KsMP9ifZa/V7dvLXRAArhlchv75sptxdIonaHl6GhtQiA==
X-Received: by 2002:a4a:d682:0:b0:5f3:3d75:7d8f with SMTP id 006d021491bc7-5f8fa888b40mr1218310eaf.2.1736924806485;
        Tue, 14 Jan 2025 23:06:46 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723185383e7sm5428507a34.11.2025.01.14.23.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:06:45 -0800 (PST)
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
Subject: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Wed, 15 Jan 2025 15:06:37 +0800
Message-Id: <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736923025.git.unicorn_wang@outlook.com>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
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
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
new file mode 100644
index 000000000000..f98e71822144
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
@@ -0,0 +1,147 @@
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
+  sophgo,link-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SG2042 uses Cadence IP, every IP is composed of 2 cores (called link0
+      & link1 as Cadence's term). Each core corresponds to a host bridge,
+      and each host bridge has only one root port. Their configuration
+      registers are completely independent. SG2042 integrates two Cadence IPs,
+      so there can actually be up to four host bridges. "sophgo,link-id" is
+      used to identify which core/link the PCIe host bridge node corresponds to.
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
+                     +-- Core (Link0) <---> pcie_rc0  +-----------------+
+                     |                                |                 |
+      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
+                     |                                |                 |
+                     +-- Core (Link1) <---> disabled  +-----------------+
+
+                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
+                     |                                |                 |
+      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
+                     |                                |                 |
+                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
+
+      pcie_rcX is PCIe node ("sophgo,sg2042-pcie-host") defined in DTS.
+
+      Sophgo defines some new register files to add support for their MSI
+      controller inside PCIe. These new register files are defined in DTS as
+      syscon node ("sophgo,sg2042-pcie-ctrl"), i.e. "cdns_pcie0_ctrl" /
+      "cdns_pcie1_ctrl". cdns_pcieX_ctrl contains some registers shared by
+      pcie_rcX, even two RC (Link)s may share different bits of the same
+      register. For example, cdns_pcie1_ctrl contains registers shared by
+      link0 & link1 for Cadence IP 2.
+
+      "sophgo,link-id" is defined to distinguish the two RC's in one Cadence IP,
+      so we can know what registers (bits) we should use.
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
+  - sophgo,link-id
+  - sophgo,syscon-pcie-ctrl
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
+      sophgo,link-id = <0>;
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


