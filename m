Return-Path: <linux-pci+bounces-14459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4699CB03
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D07F283138
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA531AAE1D;
	Mon, 14 Oct 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LyCcFPnd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLRKonVj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LyCcFPnd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLRKonVj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3D1A4F20;
	Mon, 14 Oct 2024 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911257; cv=none; b=b6XJU3f4kk7M8LxJII7fPBpJHA0ueqZcpyg3IM8/OkirOly1P0xaRWe+MzxiBjwggXBYFhRNDbYPmMfg8sAlar1V4YJhLexv3FkaE+1DIUcAkI2CzHiADT64lutA8AUYoyIrkFxRq3q6HIg+inUQeynb9ffNb3eDNksH9lU+nmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911257; c=relaxed/simple;
	bh=z6sB3e8cc5d1kVSrrj6PiNW1NIw+ViPa5TrND5u+Gdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAj7aGSjUpaU3eTnvPUjKLjz6tOc7x4ZA/VynerET5VxX1Yy39TMnz4eZwDVxbY1oxz48F3jdgk3dJUlWUK+yozlHZbbJgi70xRW65V9qpf07lCo9dFezgLOgD2Vd8uJOi2HPJdzJt0BQq7gF6rl2YGPi251RFOLYrZVoCJsiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LyCcFPnd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLRKonVj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LyCcFPnd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLRKonVj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 837191FE53;
	Mon, 14 Oct 2024 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tl+ijzx8t0Wm+xYDI9MH7aQKiAFkxvERDwPC/kdMac=;
	b=LyCcFPnd7IPjfQPVm1777mM8KM/iLCIYxrnwfPIIITlPdWwmaN5VDpU7MPo1WZf44ZTfSP
	rTgBKBX+KQwrBq1U/IYnZ/0zoqjGgT7AckuE5lXymr/dylI29PGpaz8JrOV8djUtZPlZCg
	ApRb7wIs5qcqtnkJDFsDToST4kA2yYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tl+ijzx8t0Wm+xYDI9MH7aQKiAFkxvERDwPC/kdMac=;
	b=xLRKonVj4zdi/X4TAsFFa29y3S+CluFj9r8vFHsiA46oAo5H4zWyy0BIHJEenCaYMgLHNs
	C9JVs+74JC7mvNDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tl+ijzx8t0Wm+xYDI9MH7aQKiAFkxvERDwPC/kdMac=;
	b=LyCcFPnd7IPjfQPVm1777mM8KM/iLCIYxrnwfPIIITlPdWwmaN5VDpU7MPo1WZf44ZTfSP
	rTgBKBX+KQwrBq1U/IYnZ/0zoqjGgT7AckuE5lXymr/dylI29PGpaz8JrOV8djUtZPlZCg
	ApRb7wIs5qcqtnkJDFsDToST4kA2yYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tl+ijzx8t0Wm+xYDI9MH7aQKiAFkxvERDwPC/kdMac=;
	b=xLRKonVj4zdi/X4TAsFFa29y3S+CluFj9r8vFHsiA46oAo5H4zWyy0BIHJEenCaYMgLHNs
	C9JVs+74JC7mvNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 753F513A79;
	Mon, 14 Oct 2024 13:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eBFDGpQXDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:32 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v3 01/11] dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
Date: Mon, 14 Oct 2024 16:07:00 +0300
Message-ID: <20241014130710.413-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014130710.413-1-svarbanov@suse.de>
References: <20241014130710.413-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v2 -> v3:
 - dropped '>' from the description entry (Rob)
 - dropped interrupt-controller and interrupt-cells properties (Rob)
 - dropped msi-controller and use 'unevaluatedProperties' (Rob)
 - use const: 0 in msi-cells (Rob)
 - dropped msi-ranges property (Rob)
 - re-introduce brcm,msi-offset private property, 
   which looks unavoidable at that time

.../brcm,bcm2712-msix.yaml                    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
new file mode 100644
index 000000000000..c84614663b5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm2712-msix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom bcm2712 MSI-X Interrupt Peripheral support
+
+maintainers:
+  - Stanimir Varbanov <svarbanov@suse.de>
+
+description:
+  This interrupt controller is used to provide interrupt vectors to the
+  generic interrupt controller (GIC) on bcm2712. It will be used as
+  external MSI-X controller for PCIe root complex.
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm2712-mip
+
+  reg:
+    items:
+      - description: Base register address
+      - description: PCIe message address
+
+  "#msi-cells":
+    const: 0
+
+  brcm,msi-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Shift the allocated MSI's.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - msi-controller
+  - msi-ranges
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    axi {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        msi-controller@1000130000 {
+            compatible = "brcm,bcm2712-mip";
+            reg = <0x10 0x00130000 0x00 0xc0>,
+                  <0xff 0xfffff000 0x00 0x1000>;
+            msi-controller;
+            #msi-cells = <0>;
+            msi-ranges = <&gicv2 GIC_SPI 128 IRQ_TYPE_EDGE_RISING 64>;
+        };
+    };
-- 
2.43.0


