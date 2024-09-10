Return-Path: <linux-pci+bounces-12993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4C973B81
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344401C23A4F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A271A2561;
	Tue, 10 Sep 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OIAVqq3u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CMTTD09m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OIAVqq3u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CMTTD09m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB61A2C2D;
	Tue, 10 Sep 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981562; cv=none; b=hX+rbs4EBbT1YbUaPYVopTZzO9zg5P+NczT68pg7Xj1J0bIBhoJhOLVdl4RVWIOYERp3QQEzYzd8qajwY73VSXjpjs+oyZKxSZ+YHvlxfi8GFt789DfzFQp9mZK+1jeo787KzvRBavn0WyTfBe7tZovLJGlLOgcBKV6HmBniy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981562; c=relaxed/simple;
	bh=TK7Jmi6a99zxmpEBpWZV10a/eipG2cwPafHSUxDoY6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qidugk8FQ0es/QXt0BmsajVzf5zf6q/OlyMva+bPUFp6VxxxDOmZ0gd0JwMbQjyvA9ygvsa028u2HE45ysqLtzosW2x7ZzpqunTZwn9MG2ofdLyunARJwEo1Nq/UiTJaOML6khDjfV5unfhYrYAEWRjktQF0iyauJfg2PA1XZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OIAVqq3u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CMTTD09m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OIAVqq3u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CMTTD09m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCF5D1FCEE;
	Tue, 10 Sep 2024 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFlIhbcwyLOEVIatJTFJXmYhTXFI79aTUk4k/uAUPic=;
	b=OIAVqq3uREfLvTY9mFg9mNchKkw+iOwq2+yXXH2+BUc0UyFsYtRXrH0PBbBUC7xM4iKm9U
	OTMy96bmsAoBaNtrru1q6AdPPumK8tisz9ocU4aM9HIFQB4diEH7KTOZTz3vEEEZdnvAcN
	c2e4yogdeHoi/luSvxQN4qlPtWhIa7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFlIhbcwyLOEVIatJTFJXmYhTXFI79aTUk4k/uAUPic=;
	b=CMTTD09mt+uEGu/ICZTwK8wVPYH/kcI91BsrTTjDICXotIw0B84rw5uFlBfnrUb85CVg0v
	n+dNCbNYV56VyZCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725981558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFlIhbcwyLOEVIatJTFJXmYhTXFI79aTUk4k/uAUPic=;
	b=OIAVqq3uREfLvTY9mFg9mNchKkw+iOwq2+yXXH2+BUc0UyFsYtRXrH0PBbBUC7xM4iKm9U
	OTMy96bmsAoBaNtrru1q6AdPPumK8tisz9ocU4aM9HIFQB4diEH7KTOZTz3vEEEZdnvAcN
	c2e4yogdeHoi/luSvxQN4qlPtWhIa7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725981558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFlIhbcwyLOEVIatJTFJXmYhTXFI79aTUk4k/uAUPic=;
	b=CMTTD09mt+uEGu/ICZTwK8wVPYH/kcI91BsrTTjDICXotIw0B84rw5uFlBfnrUb85CVg0v
	n+dNCbNYV56VyZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6FA313A3A;
	Tue, 10 Sep 2024 15:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AMFGKnVj4GaxQgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 10 Sep 2024 15:19:17 +0000
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
Subject: [PATCH v2 -next 08/11] PCI: brcmstb: Add bcm2712 support
Date: Tue, 10 Sep 2024 18:18:42 +0300
Message-ID: <20240910151845.17308-9-svarbanov@suse.de>
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
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Add bare minimum amount of changes in order to support
PCIe RC hardware IP found in RPi5.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 185ccf7fe86a..43d071d12201 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1769,6 +1769,15 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.num_inbound_wins = 3,
 };
 
+static const struct pcie_cfg_data bcm2712_cfg = {
+	.offsets        = pcie_offsets_bcm7712,
+	.soc_base       = BCM7712,
+	.perst_set      = brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.quirks         = CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
+	.num_inbound_wins = 10,
+};
+
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= BCM4908,
@@ -1820,6 +1829,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
-- 
2.35.3


