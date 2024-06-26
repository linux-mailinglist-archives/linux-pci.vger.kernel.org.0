Return-Path: <linux-pci+bounces-9286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24086917EAE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEEB282492
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E517C7BF;
	Wed, 26 Jun 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sg3M12zC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JSUPLruN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sg3M12zC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JSUPLruN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD01662E5;
	Wed, 26 Jun 2024 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398805; cv=none; b=omx52adXeVDpEIo3pLVmqORDleyxS4f8VX4sUqpu6J7uzC5/iA7uLFXqn4d4OMIUsHGzwPF1Yy4Cd+HFcCcZBtJWxzsOYUmr1ZLRV1YIoVsqssKW4J+WkdJw14rC1j96v1pv4S/hi4S/5NtEfRY71bi/+USwo7xOWNYnGNeRtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398805; c=relaxed/simple;
	bh=uqSTTUb9Gb7WrP9an2CuSeedx/h5Gnsek2SE9pdhFfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiS5ASLjVxHHR0A3NaZ7VZZbuPR2T3RK2t9lve2V+ft+3LkAO928bD+utgyqIZRWdvrF+tN0SCDuJR8VSEpjIuUhh/tFsXkbHdZaSBLMNvtHjfDyPX6KH27Fen4eJ0j7ZpeqNjkvYsML+4iQQMbQv27bYil6OVjC5sY0s/lEqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sg3M12zC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JSUPLruN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sg3M12zC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JSUPLruN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DF4E1FB4F;
	Wed, 26 Jun 2024 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8urjhsdKq6ksWGlu1qa20TpT445nq7glnOeLn4yy0tQ=;
	b=sg3M12zCjEmRYlKUFW1jcx4SpxglvoMrAee0js4JhLNxGH6broxCm34DsVOC2qZkHFR9iY
	vt1sgW4OazUQ2IjsvprANMhZigzLoC0XmAWQG0Y9XL4Tx1pA5EMMn3Wv0VT1dtGVrq1DQh
	OUsZj6A4w3GztVS8RIJbtwylt4STW+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8urjhsdKq6ksWGlu1qa20TpT445nq7glnOeLn4yy0tQ=;
	b=JSUPLruNn6Qm9WODRPLrcDPZkRT5GL+CNL8OtPxGzYaLK//m1M76numcXsytyIC8pZlbrx
	rNaCySvxv1UZk/CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719398802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8urjhsdKq6ksWGlu1qa20TpT445nq7glnOeLn4yy0tQ=;
	b=sg3M12zCjEmRYlKUFW1jcx4SpxglvoMrAee0js4JhLNxGH6broxCm34DsVOC2qZkHFR9iY
	vt1sgW4OazUQ2IjsvprANMhZigzLoC0XmAWQG0Y9XL4Tx1pA5EMMn3Wv0VT1dtGVrq1DQh
	OUsZj6A4w3GztVS8RIJbtwylt4STW+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719398802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8urjhsdKq6ksWGlu1qa20TpT445nq7glnOeLn4yy0tQ=;
	b=JSUPLruNn6Qm9WODRPLrcDPZkRT5GL+CNL8OtPxGzYaLK//m1M76numcXsytyIC8pZlbrx
	rNaCySvxv1UZk/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 485F7139C2;
	Wed, 26 Jun 2024 10:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLH9DpHxe2ZuDQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 26 Jun 2024 10:46:41 +0000
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
Subject: [PATCH 2/7] dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
Date: Wed, 26 Jun 2024 13:45:39 +0300
Message-ID: <20240626104544.14233-3-svarbanov@suse.de>
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
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

Update brcmstb PCIe controller bindings with bcm2712 compatible
and add new resets.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 22491f7f8852..7c7b3d25ff89 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
+          - brcm,bcm2712-pcie # Raspberry Pi 5
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
           - brcm,bcm7278-pcie # Broadcom 7278 Arm
@@ -147,6 +148,22 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2712-pcie
+    then:
+      properties:
+        resets:
+          items:
+            - description: phandle pointing to the RESCAL reset controller
+            - description: phandle pointing to the bridge reset controller
+        reset-names:
+          items:
+            - const: rescal
+            - const: bridge
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


