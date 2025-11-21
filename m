Return-Path: <linux-pci+bounces-41867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E0C79E39
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 15:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9349C2DDAC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6D354ADA;
	Fri, 21 Nov 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QR1CdM2C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QUIm56lf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QR1CdM2C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QUIm56lf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25257354AD6
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733413; cv=none; b=hNkA6A5w+vg4lqhLbEcsI/XjOtaF2QV7+idIIj26mS3gcqEcKda+Zt1usGs9Rengi6J44rsKv/u5APPUAwnBxD0jfA46xUcWpkHS1n0xQwI0xstUd/ckP+CaOUQ9fNyWYn5VH8BwqRgbpqtiCldHTRxtpMlgKuD7P+p4vjy+xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733413; c=relaxed/simple;
	bh=S7Nic2bxf7oGYpwIysBCjaCQjVCytqHt/w9Rg4cogeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLnGoqqZSKPsOpmhGKGbDQ4Xeb/nkBV6y6nw6PiyH+T2T3W0HbwQcei89KVXUF2aSUkUQSxeZmH9m/jgyAEzjJ1P6e4+MTlrPXxvimw+RYebHxNYxIGbGJE5Ognnvu599WhgAV6S4RdgIBAT1U891femFLgz1AexnnemjpyFM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QR1CdM2C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QUIm56lf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QR1CdM2C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QUIm56lf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 414B221016;
	Fri, 21 Nov 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAxet3UEKwaG+PUFWX2Nl0t3feyDMtWMZgFFiwrZBnk=;
	b=QR1CdM2CVR9vRVXBWpDJYlAamlTnGAxH5k7iQyavNLTctbBLjGpqMT1ESw5zJtWTLTw+HK
	j4xbFiwu8d56/AXtPQVpLTF3IkDQhed0/OFmohyXaB0VpvciWAwVtQxgosLGSMrfcVsWh4
	1vo8c7lpGaJSSzMEN8LP7pTGDyhu47A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAxet3UEKwaG+PUFWX2Nl0t3feyDMtWMZgFFiwrZBnk=;
	b=QUIm56lf0E6HbUO3tcH7VoxS3yTmHPNDlNWyGM16yR268E8EcHous3huXehlk+HQV4Od98
	ptRVr9Oz3JyCYABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763733392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAxet3UEKwaG+PUFWX2Nl0t3feyDMtWMZgFFiwrZBnk=;
	b=QR1CdM2CVR9vRVXBWpDJYlAamlTnGAxH5k7iQyavNLTctbBLjGpqMT1ESw5zJtWTLTw+HK
	j4xbFiwu8d56/AXtPQVpLTF3IkDQhed0/OFmohyXaB0VpvciWAwVtQxgosLGSMrfcVsWh4
	1vo8c7lpGaJSSzMEN8LP7pTGDyhu47A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763733392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAxet3UEKwaG+PUFWX2Nl0t3feyDMtWMZgFFiwrZBnk=;
	b=QUIm56lf0E6HbUO3tcH7VoxS3yTmHPNDlNWyGM16yR268E8EcHous3huXehlk+HQV4Od98
	ptRVr9Oz3JyCYABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE3BB3EA62;
	Fri, 21 Nov 2025 13:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +CARNY9vIGkqdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 21 Nov 2025 13:56:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	javierm@redhat.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/6] sysfb: Add struct sysfb_display_info
Date: Fri, 21 Nov 2025 14:36:07 +0100
Message-ID: <20251121135624.494768-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121135624.494768-1-tzimmermann@suse.de>
References: <20251121135624.494768-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Add struct sysfb_display_info to wrap display-related state. For now
it contains only the screen's video mode. Later EDID will be added as
well.

This struct will be helpful for passing display state to sysfb drivers
or from the EFI stub library.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/sysfb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 8527a50a5290..8b37247528bf 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/screen_info.h>
 #include <linux/types.h>
 
 #include <linux/platform_data/simplefb.h>
@@ -60,6 +61,10 @@ struct efifb_dmi_info {
 	int flags;
 };
 
+struct sysfb_display_info {
+	struct screen_info screen;
+};
+
 #ifdef CONFIG_SYSFB
 
 void sysfb_disable(struct device *dev);
-- 
2.51.1


