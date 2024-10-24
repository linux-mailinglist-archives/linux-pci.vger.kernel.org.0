Return-Path: <linux-pci+bounces-15206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115619AEB20
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3514C1C23EB5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67BD1D63F3;
	Thu, 24 Oct 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mj9EvosY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t/jEZzHk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qj2ZZx4A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYHtWvc/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70571D514D;
	Thu, 24 Oct 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785290; cv=none; b=OfzLaGJ3IZFOWwTnKsufJDiIgp2liqrbSYMSp0fuxdY0YVf4pZLQfQDV0zI3OQsYKsJEkV3sn8O7GFfT6DzugMLOnyS+15sI4cMYO2mw+aa9dCJv1pLRIywXwV7BHW+a10tykktDzGn9nzIkroLeBos1TX4l24GC/rou01cC5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785290; c=relaxed/simple;
	bh=9c/JlGxthoyaArPlaLxY90CuKMTdSc1THCspkNfZVOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7xLPVu1oigWxPBWpq9b/yzPRN0bsn1AsWo6Bkb95DO4+UcZo6kjo30IS+iitQt/dTHu8MPMRYQREeL+9j949HtWv+OdN3d1O+h4snQEXPpgbffxRYXDDLthhiZMLZGms7X3y9LkvUl/tUVyHTudg5EAyo9lI5YBYMbO3LTFOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mj9EvosY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t/jEZzHk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qj2ZZx4A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYHtWvc/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D958022114;
	Thu, 24 Oct 2024 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729785287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0XZLTdWjkZ6tLKaPQHGc3uGkuwj+Z6vDYULA8eZJGeo=;
	b=mj9EvosYXrOfAShB+YAiy+wE4l2HdPQHglIeXc0qCmjBor/X+vD8Uaiy9z2UYf7S7dMh2/
	Gz0oIPdR/g6BiXyec2mK30fUSY0iuMo5SggKWRT9sE55aaCFgtkWh9Fus0BjSwNSYYFibl
	osq9umzrztedGghTXIfWomuMJPNYLso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729785287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0XZLTdWjkZ6tLKaPQHGc3uGkuwj+Z6vDYULA8eZJGeo=;
	b=t/jEZzHkIaoCxL4ODJsrM8VluGx29oxL18PeWKaWZX26uJH0z94k1/z59CXXOGsM7vgaZH
	4TKQ8MzXtDkK25Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qj2ZZx4A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="OYHtWvc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729785286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0XZLTdWjkZ6tLKaPQHGc3uGkuwj+Z6vDYULA8eZJGeo=;
	b=qj2ZZx4AJA4ac4fkwytFr6kTTwhwHHzwIoowKIEHicBRyk6UTnIyYy5gbWxnMLsoPw+tOQ
	coNdKMZNFipwYGri+tJcBGPMq/3OnBZK5yy4YuH+suCUNhp7R2nvHnDiA5uxwMwvs6PvEo
	bi3PT6Qd7M2SG6VFzKzOv072ulihMwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729785286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0XZLTdWjkZ6tLKaPQHGc3uGkuwj+Z6vDYULA8eZJGeo=;
	b=OYHtWvc/eW4Rb5EE89wcu0nIu+qdpvzy+SGXjWqgVP//29wy1sIgeuc63jfkSU3Wd5wXgq
	UCXUN9nbXEpDAqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF4921368E;
	Thu, 24 Oct 2024 15:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UhspKcZtGmdGTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 24 Oct 2024 15:54:46 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Restore the original INTX_DISABLE bit by pcim_intx()
Date: Thu, 24 Oct 2024 17:55:35 +0200
Message-ID: <20241024155539.19416-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D958022114
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

pcim_intx() tries to restore the INTX_DISABLE bit at removal via
devres, but there is a chance that it restores a wrong value.
Because the value to be restored is blindly assumed to be the negative
of the enable argument, when a driver calls pcim_intx() unnecessarily
for the already enabled state, it'll restore to the disabled state in
turn.  Also, when a driver calls pcim_intx() multiple times with
different enable argument values, the last one will win no matter what
value it is.

This patch addresses those inconsistencies by saving the original
INTX_DISABLE state at the first devres_alloc(); this assures that the
original state is restored properly, and the later pcim_intx() calls
won't overwrite res->orig_intx any longer.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pci/devres.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..aed3c9a355cb 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -438,8 +438,17 @@ static void pcim_intx_restore(struct device *dev, void *data)
 	__pcim_intx(pdev, res->orig_intx);
 }
 
-static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
+static void save_orig_intx(struct pci_dev *pdev, struct pcim_intx_devres *res)
 {
+	u16 pci_command;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	res->orig_intx = !(pci_command & PCI_COMMAND_INTX_DISABLE);
+}
+
+static struct pcim_intx_devres *get_or_create_intx_devres(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct pcim_intx_devres *res;
 
 	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
@@ -447,8 +456,10 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 		return res;
 
 	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
-	if (res)
+	if (res) {
+		save_orig_intx(pdev, res);
 		devres_add(dev, res);
+	}
 
 	return res;
 }
@@ -467,11 +478,10 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 {
 	struct pcim_intx_devres *res;
 
-	res = get_or_create_intx_devres(&pdev->dev);
+	res = get_or_create_intx_devres(pdev);
 	if (!res)
 		return -ENOMEM;
 
-	res->orig_intx = !enable;
 	__pcim_intx(pdev, enable);
 
 	return 0;
-- 
2.43.0


