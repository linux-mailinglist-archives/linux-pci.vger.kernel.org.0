Return-Path: <linux-pci+bounces-9289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D7917EB9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BBF282C80
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612501802AC;
	Wed, 26 Jun 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OTA7hDlZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAhDT4gG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OTA7hDlZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lAhDT4gG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFF17F4F0;
	Wed, 26 Jun 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398810; cv=none; b=d2zub/v88sGBCQgTX7gcORe/eBcZI6CuY8vPQuFSv3VYyVz4hkfFXYmZm3DUz2ToFzDaIPGJOdz2xQRxYoaTKTskLnyxVfB6tkAjVpIbeB9XjKMMB3yT8DARnomIN29DSiE8IvOZHyrvxTA1HeSAUHoxeSPLTFb32acKQJ/m6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398810; c=relaxed/simple;
	bh=k25WT7wQufddlnJMtTU17m/2MP4gRCuw4YxiroFBeWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1ZIzSfxOWk8Cn5DQH2ipYS9pHAyobaxCDIBeqMWYsPKiDWMKyy/tOYKDV+CmSeoqEnQx4YaWm88bcpoFxiVZQnB7alx1MJsJFOWKfXpLJeLjph+ZRppwBjnlagbNHezupL9Abr0JIKvfuipdLHOC8C13WGAasYbGAj0gJUrCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OTA7hDlZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAhDT4gG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OTA7hDlZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lAhDT4gG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35DC121A7B;
	Wed, 26 Jun 2024 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2434HIjtjtyvW7COVv7pzKRXGIJaqq7Io+dvzhKQV/M=;
	b=OTA7hDlZvtG/bZHm8by33VFrSXcpX7MT+sb7qCMYZzVyh0BF4t154pmW8Jk7CWYSPP03eq
	CDuktCnM+CZv5fNLqijeA3AFIRiUEKz99z9DDrIOifgcDV/UPwlIvjrmLOta6iVeJBx/Y4
	fT2a09GSzLq9oyBBKKL4RsCuj/YMS/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2434HIjtjtyvW7COVv7pzKRXGIJaqq7Io+dvzhKQV/M=;
	b=lAhDT4gGJfqHjccwgN9yOY4SFgz+JcNZ2vQZJAQo+v/rh3YxkFgbwtdgsNiW2rbrqjSBFg
	KVzNkTay4aSo3eCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OTA7hDlZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lAhDT4gG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2434HIjtjtyvW7COVv7pzKRXGIJaqq7Io+dvzhKQV/M=;
	b=OTA7hDlZvtG/bZHm8by33VFrSXcpX7MT+sb7qCMYZzVyh0BF4t154pmW8Jk7CWYSPP03eq
	CDuktCnM+CZv5fNLqijeA3AFIRiUEKz99z9DDrIOifgcDV/UPwlIvjrmLOta6iVeJBx/Y4
	fT2a09GSzLq9oyBBKKL4RsCuj/YMS/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2434HIjtjtyvW7COVv7pzKRXGIJaqq7Io+dvzhKQV/M=;
	b=lAhDT4gGJfqHjccwgN9yOY4SFgz+JcNZ2vQZJAQo+v/rh3YxkFgbwtdgsNiW2rbrqjSBFg
	KVzNkTay4aSo3eCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2620013AD2;
	Wed, 26 Jun 2024 10:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJKUBpDxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:40 +0000
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
Subject: [PATCH 1/7] dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
Date: Wed, 26 Jun 2024 13:45:38 +0300
Message-ID: <20240626104544.14233-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626104544.14233-1-svarbanov@suse.de>
References: <20240626104544.14233-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35DC121A7B
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 .../brcm,bcm2712-msix.yaml                    | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
new file mode 100644
index 000000000000..ca610e4467d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
@@ -0,0 +1,74 @@
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
+description: >
+  This interrupt controller is used to provide intterupt vectors to the
+  generic interrupt controller (GIC) on bcm2712. It will be used as
+  external MSI-X controller for PCIe root complex.
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - "brcm,bcm2712-mip-intc"
+  reg:
+    maxItems: 1
+    description: >
+      Specifies the base physical address and size of the registers
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  msi-controller: true
+
+  brcm,msi-base-spi:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The SGI number that MSIs start.
+
+  brcm,msi-num-spis:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of SGIs for MSIs.
+
+  brcm,msi-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Shift the allocated MSIs up by N.
+
+  brcm,msi-pci-addr:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: MSI-X message address.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - msi-controller
+
+examples:
+  - |
+    msi-controller@130000 {
+      compatible = "brcm,bcm2712-mip-intc";
+      reg = <0x00130000 0xc0>;
+      msi-controller;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      brcm,msi-base-spi = <128>;
+      brcm,msi-num-spis = <64>;
+      brcm,msi-offset = <0>;
+      brcm,msi-pci-addr = <0xff 0xfffff000>;
+    };
-- 
2.43.0


