Return-Path: <linux-pci+bounces-22171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291BFA41775
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6797F3AABDD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E309419AD93;
	Mon, 24 Feb 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VqwOVeC/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BzcvNPNS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0m+LErZE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QwaEcRE2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BED198845
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386200; cv=none; b=Z+HKCImaPNELS4/mC8SOKbtLtWil/nz2L8R+/MYQtghFCtUyMlD4H7OyYyarQPf6o3JB7qHZRzM/B0EhRgMiEdU9pgJTZ00BumeG34O6cYb4C20kxtSy9dTrs9K8xJQUvqkaOG49CpIvJrvoa8nDdRziWL3AeLCHHHYAsNP8AU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386200; c=relaxed/simple;
	bh=JUbFKimg2CZhy6HpqtjsbGrEysXwRR+hAehcIx/w46g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouQTftKlCMfoHEHnnxwff0QtDrAmV5vZcFIBVpwlk09EYKyYuQ5zNxIH1O5D7PE98WyZ6ksdDFIqmQ3HC3+VxRRLsB/CXk5K3EsPk72UxQRU26JVZbtQqSAKccpCQOt3ZjS9YDtLTRvZxve3ggA5Udo0UzvSebCwuDdORFUy+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VqwOVeC/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BzcvNPNS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0m+LErZE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QwaEcRE2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96C242118A;
	Mon, 24 Feb 2025 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0Sm5ehaucSsHtr6evv3VGyr+MK05C9WXfxsoPw7fTU=;
	b=VqwOVeC/aAzI8axq7ewUQVK8rC8zL2CYl5SGComh1YidKEGQ6mh8lDZEjPx+L/Qyu4Cfcb
	Ri8NPtqBgr6DLurMUkTrYvGzGK6bJPrvT6gLO6K2gbPK5fUf4a79Ube+FDCcqr6ZeZC2N/
	Tx/P6XiyWuFjTXB4JeX/wGW1H9XhoNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0Sm5ehaucSsHtr6evv3VGyr+MK05C9WXfxsoPw7fTU=;
	b=BzcvNPNSUnWUCBBazoZIOStRDlonbD6+RvX4JBIpR3d31PrVUX9NZtjk75H+ck7Yg6Df8T
	LAvWVISSHy/P3UCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740386191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0Sm5ehaucSsHtr6evv3VGyr+MK05C9WXfxsoPw7fTU=;
	b=0m+LErZEI8wM3jS+peh5ZSoE6uspSey2qBD9MM7kxSyzYA2CBeMfvxUgHS1Ewtg6RAfb3D
	y3vjH4LfQD53SIGg4rIz01VQi4leOMY54KFgqZoQjpgg2v1b026I1xDn02+7hyVEhLtj8w
	v+nYaqsJ3fZo/yXewmsEiw0iQkitkw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740386191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0Sm5ehaucSsHtr6evv3VGyr+MK05C9WXfxsoPw7fTU=;
	b=QwaEcRE2NA3237zz6OAVlwmzsbFkdCLUsMmMsDL917w0D5+OWP6dF1FFNkvy2R+YR6ZoRc
	+W3NTBZfoPSUMeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5429313929;
	Mon, 24 Feb 2025 08:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDEoEo4vvGeJVAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 24 Feb 2025 08:36:30 +0000
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	"Ivan T. Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v6 1/7] dt-bindings: interrupt-controller: Add BCM2712 MSI-X DT bindings
Date: Mon, 24 Feb 2025 10:35:53 +0200
Message-ID: <20250224083559.47645-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250224083559.47645-1-svarbanov@suse.de>
References: <20250224083559.47645-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.80
X-Spamd-Result: default: False [-5.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Add bindings for BCM2712 MSI-X interrupt peripheral controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250120130119.671119-2-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
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
2.47.0


