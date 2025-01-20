Return-Path: <linux-pci+bounces-20145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6185A16CBF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEC3A981F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81A1E1A17;
	Mon, 20 Jan 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QgiaB8Fu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wkyes94e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QgiaB8Fu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wkyes94e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C61E0DF2;
	Mon, 20 Jan 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378110; cv=none; b=M/2ywQNTM+OyrswEk6zgcSzq9Zk4k3QNzSb87veuNoxQyEpUne77eN0wOrgQtBLBEpnd3Sl0Jaho7q4p6h0kXAaGHuN0NVYAouEjbSGVJ7wjtaOAVKedoZPjtlzznBjt9Metll1mTK1GcfWQcY8541V3Wb9ghP/rcBekQ6IW68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378110; c=relaxed/simple;
	bh=6mVw+WT/Z7U5M4AgEIRVp8TsG/tzGx9c2VEAvNuv5cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9TjCx3l0EPNV1Q9FLIHJn2FzpySYb4+mrndSyjVWWoRFMOAz1OHsJpVhvYNgRAC5Q+W0M8++LFcMfo0+LHlIO7md2ALHlAaHb1I/g3rgcqM8/eWuD0bJdJVr/OXU0xuOfWv2HQWM75FWVz69QxqvTOCEDFzK807r0O2sB0uxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QgiaB8Fu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wkyes94e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QgiaB8Fu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wkyes94e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 230671F7B4;
	Mon, 20 Jan 2025 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Pq2XxnHZxo2+C4Rr9yiexSy9zSXpeiaKfv8x80cn5I=;
	b=QgiaB8FuDxBMJOnr1LvPETuh5ggGg3nSrXmPTnjdMgq/bOqhLq1FRZiDIZthIXgRKIwIiy
	jV0S6MlhtkBM/K47JNuFj3JnseLwM7RTh+G++oJnKACXHDPUDBEg8zjYWAfTwF+f0IwU7O
	ZpO7VZwMVAYMyXdS7vaGvrNlxbKBGek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Pq2XxnHZxo2+C4Rr9yiexSy9zSXpeiaKfv8x80cn5I=;
	b=wkyes94eB5hW7Kcfl7p8RWuCsKYg04ODe8TIezUEI/PH9ifK7dLTfQcALgm2APkMpfPnfH
	NnEJWfZ2WitCnoBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Pq2XxnHZxo2+C4Rr9yiexSy9zSXpeiaKfv8x80cn5I=;
	b=QgiaB8FuDxBMJOnr1LvPETuh5ggGg3nSrXmPTnjdMgq/bOqhLq1FRZiDIZthIXgRKIwIiy
	jV0S6MlhtkBM/K47JNuFj3JnseLwM7RTh+G++oJnKACXHDPUDBEg8zjYWAfTwF+f0IwU7O
	ZpO7VZwMVAYMyXdS7vaGvrNlxbKBGek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Pq2XxnHZxo2+C4Rr9yiexSy9zSXpeiaKfv8x80cn5I=;
	b=wkyes94eB5hW7Kcfl7p8RWuCsKYg04ODe8TIezUEI/PH9ifK7dLTfQcALgm2APkMpfPnfH
	NnEJWfZ2WitCnoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CEE01393E;
	Mon, 20 Jan 2025 13:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2N6fCDpJjmc4XQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 20 Jan 2025 13:01:46 +0000
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
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v5 -next 02/11] dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
Date: Mon, 20 Jan 2025 15:01:10 +0200
Message-ID: <20250120130119.671119-3-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250120130119.671119-1-svarbanov@suse.de>
References: <20250120130119.671119-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Update brcmstb PCIe controller bindings with bcm2712 compatible.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 2ad1652c2584..29f0e1eb5096 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
+          - brcm,bcm2712-pcie # Raspberry Pi 5
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
@@ -101,7 +102,10 @@ properties:
 
   reset-names:
     minItems: 1
-    maxItems: 3
+    items:
+      - enum: [perst, rescal]
+      - const: bridge
+      - const: swinit
 
 required:
   - compatible
-- 
2.47.0


