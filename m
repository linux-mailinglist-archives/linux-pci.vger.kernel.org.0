Return-Path: <linux-pci+bounces-35781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F87B50AC1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325F81C62C2A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC622FE18;
	Wed, 10 Sep 2025 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMlQGG0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0A1DFFC;
	Wed, 10 Sep 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470089; cv=none; b=u4QBVJ5jrKUsAZZuqjwrxjUlf7XJjTs/iCYP7duxcEdsPVItxj+WAjRBK/+vf0OduTE8HWuaFHFtR3dG5Kt6UcudYkVw8zQdjO4tUtcRB2ejHQODz5CSZ+vzdqmUZpfUEXlkUuliM1Was5t+r2ReAEkeOVKBTfr/rkilsQsNWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470089; c=relaxed/simple;
	bh=ne/AJ08EINCLHq1YL8QOv01wvisw6A7Ct54Qvu1CzBE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TE2VjJT7jOCmWJDB+kbd1d+RlgWNerabubDjF17I7pTk0Yh7H4DLVOsQKVJJmmq3MD5rcNpIN0ehcLCAXig2+UB51DQOdbedhUqSck6P8OAd+ViBnmxx5EXwEvQ2tyn8qQuur6gxxnBPUbGr79QgWVVUwfXkRBjb+du1FqDAxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMlQGG0+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7240eb21ccaso2072346d6.0;
        Tue, 09 Sep 2025 19:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470087; x=1758074887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XFM07Z5n/PQZ1U15JfmMTCdL390KHJnWHFIuZFK96s=;
        b=gMlQGG0+DBuYWirjYNIt38Fi8jgu5qDbIw9oepCJCRGauM6JuIGha+3HGwgREdyGcG
         KljSkTTuiWGEZEKobo4HAw1ZDGaAT/bPNpdzWTzR0PYUvThieY3Uk0799u76rUkdQ/dh
         DPKnHjTNzIamyEi2cVP/IGJ32lVGeSsbUuOioQE0aM6BV+dbty/VlTAdDXCKm+9skP7D
         qQhPy3rSnjwVQA72Ck548mEEiD+Y96cKuTvwfCjpX9M0Kek0tLlHzz2wcA9G60qNlQsZ
         b4CapdTI31G1mpO2ZFjG3JSAkFeKQiCjfh3DtVW6H2ia8a8BKNk/6lL7DrOCQT8M/vBw
         AZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470087; x=1758074887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XFM07Z5n/PQZ1U15JfmMTCdL390KHJnWHFIuZFK96s=;
        b=bQbNJGdhRFsKtrdBXXi3JSnSus30HTlbYFYZY0x1DKevjIfflNO6E5XXn2BGBh7EqK
         A52lAbazU1RizJnj1ClQiEg9neINKue1wramegGg1Bc49zYoP5bgJJJH1DVElFxo1kZW
         bQcaQn2SWhAdsF0FqzEZXe0+lCYL8w0qnvSa6zmiB9QMtFzj7/Nh5RTnZXzib70iPvnF
         4g6aSweg1EQTOY7z5WhC+98eih9ddmRPI6qvEqwJQmsQIsBi0kLk6yucl+c62nbKPlVs
         PpADBiCeOsLoPJc4aRM7PVCgssrcBxxbSY/fNZ98yjnifBr/vZxGsQzdO5SKYV06IpN5
         j/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqMvMZ3JYvRF6iG+4z6HPgYB/AekITvHLs5N9J5Ea1HSWlDxxXCz3y5Rb+C5cmO9OyrWO86/bVZN8q@vger.kernel.org, AJvYcCV6cuAUpNUN4tvDPAHeZ9g1que4ZSUkck+VN3Sd4XZuNBUZNmDi6y0IJ/3Fzd9Cg8xDwceO34KDp7+hPOa9@vger.kernel.org, AJvYcCVKenegIPxAU5enS4yS5JE4yRuf7t99vL0l+fKaK3hTAIJ2EhK7kcbKOlCHOU87mQ72rnYQZ469sKtg@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNsVbOCpNTIDmbyUJl7WVVJhA1+nsmmvDvYm9BjFoRrw8C3XS
	z8TCeRzmKUYF7sdwci4LUSN/eD2wovroOXYbFc+gzZe6Z8MB85de+0Ss
X-Gm-Gg: ASbGnctKqc5XEl5ht1XcYVPMIANXZR47+Sfgi8SnADFa7eNXVpqQGZdE7vwzaDdseBa
	fE/RLBu800+O3x7jBv+V8fPfBlE89yg1zZlDVobFlEVtaW1FcbkiSlCZh9rz84ZUxk4VujJo2/L
	aNBHQSOhK3RybpaSrGocvSWIMDKk2C241nRqxldB3faqux8KfXvbyciMyr4IHd5GNpLeTdP8wdN
	xeFyio955Ic7c3QBsadfzxvzt0WysWOJ2USjkPnv6OkfWWPadaQdarHXpC6OTXEI+rCh6YtN9JF
	KXKlArnanJJGvhw9GBo1RMk4zCRJuV2yWZ0WZwyVfPOphnow+h4o3NB7jvaXw4/qABJDESpOQGs
	8NFqe8+ELCFsduQeLm45lCKYhHewQVzzx7t/rOVEC5veGUK5gnEOWKQ==
X-Google-Smtp-Source: AGHT+IGNC8sHtACh6gI+vt2l2BTS2R0uh7vi8B+8jgdFE32SPqkIaSaf1sgwm1dD4KthnaDiWgRQyw==
X-Received: by 2002:a0c:f096:0:20b0:71f:b221:9aa9 with SMTP id 6a1803df08f44-73a3dbf58a3mr135461976d6.29.1757470087200;
        Tue, 09 Sep 2025 19:08:07 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-728d6f8b338sm119377366d6.0.2025.09.09.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:08:06 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Wed, 10 Sep 2025 10:07:57 +0800
Message-Id: <2755f145755b6096247c26852b63671a6fea4dbf.1757467895.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757467895.git.unicorn_wang@outlook.com>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
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


