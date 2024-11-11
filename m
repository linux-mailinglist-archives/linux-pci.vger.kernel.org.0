Return-Path: <linux-pci+bounces-16419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5659C3818
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21DF280E19
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B4147C86;
	Mon, 11 Nov 2024 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doKwgEWB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FF137747;
	Mon, 11 Nov 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304790; cv=none; b=HgvDoLmw1tXkNvmDnxmEOr+fYWCu7yqVZ7XkFRDWtYwnIkTU5IG3jYQd2WM2zeYy5AL6OuCZMDPDxJ0UFhStyllyS+DeNMm9HHII7W8yWyi0B+hhizleZHYNLi0e4NWaOm5jW1trZJ1+p7AwSjjmbjBQFNzgZWiHK1mA2alu4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304790; c=relaxed/simple;
	bh=IQsklxW9iHWbBpzddygNMjibIkcbcEsUQQJBhcrEPgE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dk28hmYYTh2HMVuGhuL/MGvYMj/ypr1nTfPon3SFYUlcwZUFojdUQnqQuwglXN3LQ52D4xSqhUW1jx02O2iJkbVEIFwd82Jvq++/JvQJdvb46x/fDP5ATtIqRlJpaCs27lLs/Iooy52Nt5X5G4BmEyYYkQ93vznfS0L4G35dhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doKwgEWB; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e601b6a33aso2403568b6e.0;
        Sun, 10 Nov 2024 21:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731304788; x=1731909588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcDsTsbAoHrjuJNrpeEiHIIXwt512iaJZ1liGpvMOf8=;
        b=doKwgEWBQqzyAyjmhn8gQPVwamdGNFvKFfquwWdPOt4aYlfNqvX7LnyEdjUb+yxRMg
         q+0PFQ8ZalTd7JpG3VQ5uKobVt0EChGncH0DdyL/tsRoflrt38vHuSpseV7ZeD1xXe4v
         aZEjmB25QDNu0luypULhjJdFvs4iJrMXcICh8V+pgxd2AIaWDUBjIaGT9tCQ2mq1WpaY
         QlTxcT/jfeWHPJqn0uSCwuRn89xEeGQN7ryg3wHMee4GyAgT8upvgVu+ElkPfkmyUV3Z
         ui7ksqF/AsxI3Yu5hwfIUYuFhw3OIB4jDVvuW3PVSXLJ4hBhStcZoF+JD8/GqzzlZsf9
         U+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304788; x=1731909588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcDsTsbAoHrjuJNrpeEiHIIXwt512iaJZ1liGpvMOf8=;
        b=HLi21EYEb+mKeyDV6BptXVRYS8EbiLxGPUXFzGFxx7RMBBp7xRlDrylv1TyPAcXFQT
         jBiqSJ2WFCz11p7dt46g+rIXub9AcaO0U3LJNQ0G5hoKJb3DrXgeqjh0MUi4yZg0q3Pd
         MEyPP/UiS1WLwkgO6V9Wfb3bBPbWJJhLf97O9eW8/zae0LDlYi8b7fhkBQyhoyv6CCXA
         OVc7/YHHd6kEZZfsae1DLq0evokOoQwuvf/w5Uct66tlwyV+n2rYQ9HsN87TPidPLdlE
         R6ajYKAFaXHqqItgULWXzwzWB3iFD1rNQKks0/QTvqPYUNuZJC48MJKzWFThi1zXJVEc
         eHbA==
X-Forwarded-Encrypted: i=1; AJvYcCU02MOPBSkt1EqI4aI3dzOKRSJr0ZupRvHhLaZB/2dQz1rPd0QNHzgtA4tF86bKpPnrSsunEoNaIE6gsXfD@vger.kernel.org, AJvYcCWfVViEgShBcsfbvZMUgTwXvtIPrgOi/Qz//aUyGs9OLeN6mD7FQVet0M5ZMFc8+qi5tW23qH3pt1RW@vger.kernel.org, AJvYcCXOeASqKYQX0eRMEcxADokJUHY1VPmsKRz2GdYffrJNsAcKfp8P9v4rn7ljT9a3f2GwBmoDqWZXXWXn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86TXXWj+5vu33PpD0pZ13OcNZt3j6Auu55br7Q5RwhzIxn7aq
	2SYS7TBvaphMmAqwoV1dnGYE1Cqh4cvDv2AyE0cPNqqAZN9uU7j/
X-Google-Smtp-Source: AGHT+IGGuV49WNiTojEUmDK73Hy2JmrVXWdZzG5Wfg2sJpT+JoDVwiKHPnfkhzuQPC7X4Wfwh+9GrQ==
X-Received: by 2002:a05:6808:3012:b0:3e6:2408:6117 with SMTP id 5614622812f47-3e7946687f7mr9876627b6e.13.1731304787650;
        Sun, 10 Nov 2024 21:59:47 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd706a5sm1971906b6e.54.2024.11.10.21.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:59:46 -0800 (PST)
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
	fengchun.li@sophgo.com
Subject: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Mon, 11 Nov 2024 13:59:37 +0800
Message-Id: <1edbed1276a459a144f0cb0815859a1eb40bfcbf.1731303328.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731303328.git.unicorn_wang@outlook.com>
References: <cover.1731303328.git.unicorn_wang@outlook.com>
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
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
new file mode 100644
index 000000000000..d4d2232f354f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
+
+description: |+
+  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
+  It shares common features with the PCIe core and inherits common properties
+  defined in Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml.
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
+  sophgo,syscon-pcie-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the SYSCON entry
+
+  sophgo,link-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Cadence IP link ID.
+
+  sophgo,internal-msi:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Identifies whether the PCIE node uses internal MSI controller.
+
+  vendor-id:
+    const: 0x1f1c
+
+  device-id:
+    const: 0x2042
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: msi
+
+allOf:
+  - $ref: cdns-pcie-host.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - sophgo,syscon-pcie-ctrl
+  - sophgo,link-id
+  - vendor-id
+  - device-id
+  - ranges
+
+additionalProperties: true
+
+examples:
+  - |
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
+      sophgo,link-id = <0>;
+      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
+      sophgo,internal-msi;
+      interrupt-parent = <&intc>;
+    };
-- 
2.34.1


