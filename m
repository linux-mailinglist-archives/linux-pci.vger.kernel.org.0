Return-Path: <linux-pci+bounces-14460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FED99CB07
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB001F231BB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB01AAE32;
	Mon, 14 Oct 2024 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OT8O0qow";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9tnAkSal";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OT8O0qow";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9tnAkSal"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A11AA7BF;
	Mon, 14 Oct 2024 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911258; cv=none; b=Zdv/c4ODt72KL/rAtahWRIzPH5Bd2iDeQ/mNIspCmCH/1KZPld3Vi5tpysCgc/HJNQF3NjyOxcu9axVSii8cfwSjEisTJo4bWJbc0OG1iyZq0bPXmL/6InDj0Ix6wxapLA223c7lPQIk9STtqmTY3u4Svz6pFloOI0obJo0ruLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911258; c=relaxed/simple;
	bh=Vg83u49UwAxaabf4t/R4xzbWBzJ+2T7NgmUe2P23TkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFNEQTMcbFJHKwmqslZmgbPlJAu5QOjKkSngIMb2qlyQWm17vr0SQa22ezP/PxROV6d/yjUnGSMKuCi3YX2Kp32Fhh9IZ1xM54INy8PhDwDpgbzis09tiGcx9f6Vhr6x6llmgc1yOsYSjndoHArP/0okoRs+cVHyL9kdHt7Ln4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OT8O0qow; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9tnAkSal; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OT8O0qow; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9tnAkSal; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E89D1FE55;
	Mon, 14 Oct 2024 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQQCuAZgUA0ZS2BddMPfeF3ByHWicC4N3TsbURbed0Y=;
	b=OT8O0qow8SJnU4rlrM75cajtggrAJQcoXCljMS/GN5JteVE2JWhxIwoNNYsFEKHoSXHNYW
	DP0mqFdxTsxWuD9L0+YdU1GCEQp7zNKaYYSVvfE6FzTQjYCDElcYiMqnwJj8EmjZstQ7pO
	5vrpRq3qBdUekY4B/hZwgXAAxCLOHMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQQCuAZgUA0ZS2BddMPfeF3ByHWicC4N3TsbURbed0Y=;
	b=9tnAkSalx0tYxdTJe/lZMYZjayV2SmqfRsirmezlz8wUwbcJ5psrf5JS6NBGKpT6aNj9XU
	haAch/cyb4Lc0qBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQQCuAZgUA0ZS2BddMPfeF3ByHWicC4N3TsbURbed0Y=;
	b=OT8O0qow8SJnU4rlrM75cajtggrAJQcoXCljMS/GN5JteVE2JWhxIwoNNYsFEKHoSXHNYW
	DP0mqFdxTsxWuD9L0+YdU1GCEQp7zNKaYYSVvfE6FzTQjYCDElcYiMqnwJj8EmjZstQ7pO
	5vrpRq3qBdUekY4B/hZwgXAAxCLOHMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQQCuAZgUA0ZS2BddMPfeF3ByHWicC4N3TsbURbed0Y=;
	b=9tnAkSalx0tYxdTJe/lZMYZjayV2SmqfRsirmezlz8wUwbcJ5psrf5JS6NBGKpT6aNj9XU
	haAch/cyb4Lc0qBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 868A713A42;
	Mon, 14 Oct 2024 13:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMJ3HpUXDWcqTwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 13:07:33 +0000
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
Subject: [PATCH v3 02/11] dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
Date: Mon, 14 Oct 2024 16:07:01 +0300
Message-ID: <20241014130710.413-3-svarbanov@suse.de>
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Update brcmstb PCIe controller bindings with bcm2712 compatible
and add new resets.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v2 -> v3:
 - Added Reviewed-by/Acked-by tags.

Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 0925c520195a..8517dd9510ef 100644
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
@@ -158,7 +159,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: brcm,bcm7712-pcie
+            enum:
+              - brcm,bcm7712-pcie
+              - brcm,bcm2712-pcie
     then:
       properties:
         resets:
-- 
2.43.0


