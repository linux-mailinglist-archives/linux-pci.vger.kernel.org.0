Return-Path: <linux-pci+bounces-12986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5E973B6B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA77E1C24C67
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950D19F470;
	Tue, 10 Sep 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UthZWKc+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dnWE397o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UthZWKc+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dnWE397o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26319994F;
	Tue, 10 Sep 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981554; cv=none; b=SI9gtVxO8J7VCGNMBpQNrpWV8pNuKVO115T5NpH4aFHOuemetwaE4K6YWc8vJYkeo9Zwop1+eLdog7BLyedsefnOEP536sNCO3LMqNRqYJvxdsXKEkKvqbrKNvG9ktsW/sXfgNqDKKGD5zUeC6k39qpz7Drj4J2DRdrgHaykSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981554; c=relaxed/simple;
	bh=FlWzX9CLTdiW0BBba8Bd2wSYtvXb+dYpVQ1qF+i3HOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPptay/JLFIZXwDg0EQL3e43/bo0tOV4Om7047GEFYzM+7jLaY1cizCMAr0GzTqWvawm1fi1TDRztdc2anRTp74QeVDeZuqzG2jSyauqswuZhm5psZMhvPLKalFOqRSC40a+gkGtmlXE6FVfhm7pPfZvVjVswWYTBSE9G5R5phY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UthZWKc+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dnWE397o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UthZWKc+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dnWE397o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED381F7D4;
	Tue, 10 Sep 2024 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCSgmZA01tHhKsv+TFvFXr+5EZOzTQmEgzfpPMn1+tk=;
	b=UthZWKc+Fh7D2RKZRV4ApoY5qSY70e9y52aq8t5itKFkUrllZbMB/Ri+CgdoMriYwUXx2h
	uXT1HtHCi1PScpJS5SBA/E64HTIFWaJ3NegB08w4f2s+lYH07mYfcxGq6utbzEGgBGgOCR
	0CAXS1pAF08y3mFK1CUGQ9j2MyVgszg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCSgmZA01tHhKsv+TFvFXr+5EZOzTQmEgzfpPMn1+tk=;
	b=dnWE397oo2RE7LevWOo3qWlXJeUWyzLkepSXq9wlR3ZpQ71fvsvTdyIWXskDjYTT/Xpyw9
	PacHwZV036hLeTBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCSgmZA01tHhKsv+TFvFXr+5EZOzTQmEgzfpPMn1+tk=;
	b=UthZWKc+Fh7D2RKZRV4ApoY5qSY70e9y52aq8t5itKFkUrllZbMB/Ri+CgdoMriYwUXx2h
	uXT1HtHCi1PScpJS5SBA/E64HTIFWaJ3NegB08w4f2s+lYH07mYfcxGq6utbzEGgBGgOCR
	0CAXS1pAF08y3mFK1CUGQ9j2MyVgszg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCSgmZA01tHhKsv+TFvFXr+5EZOzTQmEgzfpPMn1+tk=;
	b=dnWE397oo2RE7LevWOo3qWlXJeUWyzLkepSXq9wlR3ZpQ71fvsvTdyIWXskDjYTT/Xpyw9
	PacHwZV036hLeTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1C5713A8F;
	Tue, 10 Sep 2024 15:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ICzILG1j4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:09 +0000
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
Subject: [PATCH v2 -next 01/11] dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
Date: Tue, 10 Sep 2024 18:18:35 +0300
Message-ID: <20240910151845.17308-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910151845.17308-1-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 .../brcm,bcm2712-msix.yaml                    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
new file mode 100644
index 000000000000..2b53dfa7c25e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
@@ -0,0 +1,69 @@
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
+      - description: base registers address
+      - description: pcie message address
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  msi-controller: true
+
+  "#msi-cells":
+    enum: [0]
+
+  msi-ranges: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
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
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            msi-ranges = <&gicv2 GIC_SPI 128 IRQ_TYPE_EDGE_RISING 64>;
+        };
+    };
-- 
2.35.3


