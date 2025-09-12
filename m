Return-Path: <linux-pci+bounces-35972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63899B5406A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBB0A05096
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702461F4176;
	Fri, 12 Sep 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRNW4smC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2381D54E2
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644546; cv=none; b=KvKmd7ykY1Mdr0qYpc+xxDJFZOalrj8XX9ztNqawQcyiZ01zp0D3uCVuEF152+QA9txs13xCxS77OAyq6oD70WCQIXgSgfTcK7v87XDMaMwmTc9VL6hJKzm6xlXeavELbjonBFlPvra1rAycay5z1gwBR/bQ2G6hO4KuUB3NcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644546; c=relaxed/simple;
	bh=ne/AJ08EINCLHq1YL8QOv01wvisw6A7Ct54Qvu1CzBE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfL34lPcENi0Fe5WdEpFt3QWyjfB7Ulk9we2XDbnbflzJA67u0J9tpVZV/wHmCF/81vUYVp8Mzt8dAGfAiTAWboqZK0CCBVackDY1l2bn8MjVTgTwiaomq2EHMn686Qg6Qng+DPb+Ea8wNAiS+Lm+QHwS+4TBIJSGWaRzp+G3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRNW4smC; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381e2079fso1511605a34.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644543; x=1758249343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XFM07Z5n/PQZ1U15JfmMTCdL390KHJnWHFIuZFK96s=;
        b=mRNW4smCIN18Aar/uf+ApBp7CgTwGDU/VmpytkYxLux4yNKAEV96XBfM17rI7W3FfI
         tb1Y6Qc8WEH6XWAb5VnLYnBZhZ6AoKpa25FkQX7OSPNUTXooOYoaegTIrhq0nykQR7HI
         hIjJSgLDY+dLhEo6htcfE7lFwrJQALrkAebfC2bVaEgnwBSM1u/KXYmDbk4wNOrqiCe/
         STNOJQ7GOC0ldoqfHZ5kvbeBA8SsB5Bpudw8CFvqzJ0+0GgV/SUNrPFnVIZGk3I79kO4
         0AtRVFa4SOfHnSpmGVYLgWjZGvTwoyPlcZ+Mm5K0bP2isPN+TLY6YtTMHuZOU/UF/03H
         dpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644543; x=1758249343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XFM07Z5n/PQZ1U15JfmMTCdL390KHJnWHFIuZFK96s=;
        b=xQThnkdctAoJuYQZ4h4I/a0c7UIl3FRMM+8ppEUoYg/uQXGtUacNDzojsUQUXYl83O
         r1e7SYGYLJU0TufyAoabHNBFIRAz83NVIcZBzoCFbYPW1l3Jb+swcsSeB08qtCzNq4bP
         ec9M5h8QJXtX418iHhibR5e4bSvQxQaxR29d8Bh2ApbXrektkFbJvoLGtkFXIB3Eacvv
         V7lz9KAb2Sdb7CPvp+sgwoE4ZBubEGtM/kK0m3Mbvh7XQzTQo9LqQeKyUCNeOP0cv/Ki
         HR5bIs+FtZuUPQ+R4N1+Qf7avuCAIP4oYGIj6Do9ro7YdRl0Zac+bfJMe/i01rgB526v
         rezg==
X-Forwarded-Encrypted: i=1; AJvYcCWwIX3lrVHz6NOSDEWtTXBbMNL55E250NV08OjQ/GavAhNREOTSuA9UmfrtKKklKXVmo8gbDduf+Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jooOh0bmrOOSkcv1zobUpoUXGkk0MxjhSpYg827p1njseyGR
	g1S/PDO28dR129oL9QHeyAHVFPYKRYp74+bhYO5vCcUx8q2Z5ArRJ7bl
X-Gm-Gg: ASbGncuuy6pk9LbbOHg0gIiuVRnFr8/gKRLoDHAgHc1f2KbygLm5MA75Kv7cEtFn6UQ
	eQetMlcZxZrCiW4WI/CDu/+OKhpbI5pK5U7F9J/di4IaJWbEzCnsNEryKAwZ3iUFhDxEf/IgABD
	uQoR4j+WfxUiLAVKxCOFP0JulwNGoVqKJt11+x1MOtjJj0U4/TkgoJdSDqKXNOoPFk71XN94vib
	/esqvzn3c3hU1l5NmkmiUdP0ORbD+RDxp8tcMM5Rl0Aqvoewc7lJsiKLWNc2E4Y0eHB4drvnZm8
	Om/CBpx2tMzdAArpXNYBt/diD+RdjldLeBEX6MO7bdJOmxEe0Y+awVI7R9dYySxgyNs3EwZuMRW
	+fVkdYzckL0nRvJKR680JMAUInblmW/x7
X-Google-Smtp-Source: AGHT+IHQMNFCh86X7WUtfRMJW33oGIfkq7JFshCaD1qyzjsyBvpS3iS1S6F89Dx5xJzPUg1mM6pJVA==
X-Received: by 2002:a05:6830:67d5:b0:744:f0db:a199 with SMTP id 46e09a7af769-75355abff0emr852539a34.29.1757644542764;
        Thu, 11 Sep 2025 19:35:42 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524be797e6sm739170a34.29.2025.09.11.19.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:35:41 -0700 (PDT)
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
	fengchun.li@sophgo.com,
	jeffbai@aosc.io
Subject: [PATCH v3 1/7] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Fri, 12 Sep 2025 10:35:32 +0800
Message-Id: <2755f145755b6096247c26852b63671a6fea4dbf.1757643388.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add binding for Sophgo SG2042 PCIe host controller.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
new file mode 100644
index 000000000000..f8b7ca57fff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
@@ -0,0 +1,64 @@
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


