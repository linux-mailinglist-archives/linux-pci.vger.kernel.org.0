Return-Path: <linux-pci+bounces-20151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC7A16CD0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7156188A041
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B961E378C;
	Mon, 20 Jan 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RWAXdbFn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r4N0AN9m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RWAXdbFn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r4N0AN9m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4D1E285A;
	Mon, 20 Jan 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378117; cv=none; b=bHGsTOdJxqzrOkvniLfQiaqUaPhFsXHyqtKwHyBA02RnCnzoXie4eqfl+Av71fdCcls/eOph0KtR5BYqx2UIc7CgbbF3T0mOgJTNdto8iDs57qv98alZm3kG3QhTlZNOWsYheH+WQd8UfMcpaYoqNi5EDR60fumM3BDym7yURlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378117; c=relaxed/simple;
	bh=Gr1o32P7ugsCkmtktc4zxY9HtYGEGhFp0I2dJYdkerc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx8YvCeyq4KClGCuTz3YvhmSJmWsx0zKP0k4pKGOw5oYZ369/aka2lOdoCd2bofM7v+sujJtsPx6vlaFr84UwHlVJXe9y5Uh9y6ubeIb1ySM/rtFzujBu50ylCqSbwEMbfSMGxGQ6JZb2fqS/OS5qgxN7cOoitemNxoL39/35c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RWAXdbFn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r4N0AN9m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RWAXdbFn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r4N0AN9m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C622118F;
	Mon, 20 Jan 2025 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THo/maIKfTzgN3WYKtKcKtsOTNaYojuut9E/X8nm/F0=;
	b=RWAXdbFnYjtveYx1Q1z2cE6V6dPR6/oy21jEHeihv5z7RlHTkejoAc8BvFJA1AS6XYkXS9
	RcGRT4HCIZW4TIziz7YZzmCepX3UFRlz6VgNhBs7+z0prsR3BSfOoC2uc5N/5unz/PEA2V
	8JE1xpOA9PkQuHebXWj1Cn8ERgqn9OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THo/maIKfTzgN3WYKtKcKtsOTNaYojuut9E/X8nm/F0=;
	b=r4N0AN9mjMEXwSAi2AjfZhCOoaNA/DDcj6Z/t0zzUZR7EAZF2YaFfR6uXodihzPjOscISX
	po1+Ajxaw89xK7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737378113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THo/maIKfTzgN3WYKtKcKtsOTNaYojuut9E/X8nm/F0=;
	b=RWAXdbFnYjtveYx1Q1z2cE6V6dPR6/oy21jEHeihv5z7RlHTkejoAc8BvFJA1AS6XYkXS9
	RcGRT4HCIZW4TIziz7YZzmCepX3UFRlz6VgNhBs7+z0prsR3BSfOoC2uc5N/5unz/PEA2V
	8JE1xpOA9PkQuHebXWj1Cn8ERgqn9OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737378113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THo/maIKfTzgN3WYKtKcKtsOTNaYojuut9E/X8nm/F0=;
	b=r4N0AN9mjMEXwSAi2AjfZhCOoaNA/DDcj6Z/t0zzUZR7EAZF2YaFfR6uXodihzPjOscISX
	po1+Ajxaw89xK7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61AC31393E;
	Mon, 20 Jan 2025 13:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QH6BFUBJjmc4XQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 20 Jan 2025 13:01:52 +0000
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
Subject: [PATCH v5 -next 08/11] PCI: brcmstb: Adding a softdep to MIP MSI-X driver
Date: Mon, 20 Jan 2025 15:01:16 +0200
Message-ID: <20250120130119.671119-9-svarbanov@suse.de>
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
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCPT_COUNT_TWELVE(0.00)[22];
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

In case brcmstb PCIe driver and MIP MSI-X interrupt controller
drivers are built as modules there could be a race in probing.
To avoid this add a softdep to MIP driver to guarantee that MIP
driver will be load first.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
v4 -> v5:
 - New patch in the series.

 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 03396a9d97be..744fe1a4cf9c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1997,3 +1997,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.47.0


