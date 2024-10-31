Return-Path: <linux-pci+bounces-15710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1C9B7BE8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F72D28240D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EB19E98A;
	Thu, 31 Oct 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHIsKmBk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NA4uWHNo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHIsKmBk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NA4uWHNo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E619D89D;
	Thu, 31 Oct 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382121; cv=none; b=IXCPil5o91TSiWHd1ik22c1aCMbuvK3emkwJsU+830Sj3yzoNZYfq17dPbhyiXxf1tBKxWfCo7O1mrL/KO/LV07VFlpYxM3sLvGCH3cwwKG6dJgvih2GzUcuZX1DczV2nWsl1dMd2L/2FnwXp6tx0qD6CfRI1e8vJNRo0SPdpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382121; c=relaxed/simple;
	bh=dX+Q+XTiQ/fBA2vx3HZFedzv4T+DlVnkntUE8vdFJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdW7fpwcKDSzdXo1MUJDUYWkJUd7gmidkVV7r2pN6SHIVA6lzBaxrsf80BRwkZmZWCyrVdgDrAIYXmItmtURUir7xbS51fDPzOvJBUScYSOt+c7/yvdWKcm15J3WZUfEw1gW7UklAMM8wTM186jOlZcC2ZvX3krbn39VhTaakCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHIsKmBk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NA4uWHNo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHIsKmBk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NA4uWHNo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB36021D29;
	Thu, 31 Oct 2024 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730382117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P4rYzf0RxbUG+jDjrbpen3xgKQiObxthKPJBOOFcRx0=;
	b=qHIsKmBkENyfPE5A/DNju/MtMLTEB9uPhbaP5RHYODo8O2LxoupKVsRW10LFW92iDbqzBo
	1vtd2yAOTVsqcvS+yZ8hTFU0pHOWiFkZFL1OyaATcBkWZAk8SLcrmMxw5VVsZvTVr5mt4c
	kIxd8XfUgJUNDjW+9AW0UMSHX3vJaEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730382117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P4rYzf0RxbUG+jDjrbpen3xgKQiObxthKPJBOOFcRx0=;
	b=NA4uWHNokwHSqCs1m38pO6DynSSiX5mL48DaoMPaEy0j5VS80oEtRYjj6ggiHRDLskfpRg
	7G+vQLBPQ6yTKADw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730382117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P4rYzf0RxbUG+jDjrbpen3xgKQiObxthKPJBOOFcRx0=;
	b=qHIsKmBkENyfPE5A/DNju/MtMLTEB9uPhbaP5RHYODo8O2LxoupKVsRW10LFW92iDbqzBo
	1vtd2yAOTVsqcvS+yZ8hTFU0pHOWiFkZFL1OyaATcBkWZAk8SLcrmMxw5VVsZvTVr5mt4c
	kIxd8XfUgJUNDjW+9AW0UMSHX3vJaEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730382117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=P4rYzf0RxbUG+jDjrbpen3xgKQiObxthKPJBOOFcRx0=;
	b=NA4uWHNokwHSqCs1m38pO6DynSSiX5mL48DaoMPaEy0j5VS80oEtRYjj6ggiHRDLskfpRg
	7G+vQLBPQ6yTKADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F8AB13A53;
	Thu, 31 Oct 2024 13:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jHitISWJI2dFfAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Oct 2024 13:41:57 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Restore the original INTX_DISABLE bit by pcim_intx()
Date: Thu, 31 Oct 2024 14:42:56 +0100
Message-ID: <20241031134300.10296-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

pcim_intx() tries to restore the INTx bit at removal via devres, but
there is a chance that it restores a wrong value.
Because the value to be restored is blindly assumed to be the negative
of the enable argument, when a driver calls pcim_intx() unnecessarily
for the already enabled state, it'll restore to the disabled state in
turn.  That is, the function assumes the case like:

  // INTx == 1
  pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> correct

but it might be like the following, too:

  // INTx == 0
  pcim_intx(pdev, 0); // old INTx value assumed to be 1 -> wrong

Also, when a driver calls pcim_intx() multiple times with different
enable argument values, the last one will win no matter what value it
is.  This can lead to inconsistency, e.g.

  // INTx == 1
  pcim_intx(pdev, 0); // OK
  ...
  pcim_intx(pdev, 1); // now old INTx wrongly assumed to be 0

This patch addresses those inconsistencies by saving the original
INTx state at the first pcim_intx() call.  For that,
get_or_create_intx_devres() is folded into pcim_intx() caller side;
it allows us to simply check the already allocated devres and record
the original INTx along with the devres_alloc() call.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Cc: stable@vger.kernel.org # 6.11+
Link: https://lore.kernel.org/87v7xk2ps5.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: refactoring, fold get_or_create_intx_devres() into the caller
instead of retrieving the original INTx there.
Also add comments and improve the patch description.

 drivers/pci/devres.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..c93d4d4499a0 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -438,19 +438,12 @@ static void pcim_intx_restore(struct device *dev, void *data)
 	__pcim_intx(pdev, res->orig_intx);
 }
 
-static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
+static void save_orig_intx(struct pci_dev *pdev, struct pcim_intx_devres *res)
 {
-	struct pcim_intx_devres *res;
+	u16 pci_command;
 
-	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
-	if (res)
-		return res;
-
-	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
-	if (res)
-		devres_add(dev, res);
-
-	return res;
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	res->orig_intx = !(pci_command & PCI_COMMAND_INTX_DISABLE);
 }
 
 /**
@@ -466,12 +459,23 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
 	struct pcim_intx_devres *res;
+	struct device *dev = &pdev->dev;
 
-	res = get_or_create_intx_devres(&pdev->dev);
-	if (!res)
-		return -ENOMEM;
+	/*
+	 * pcim_intx() must only restore the INTx value that existed before the
+	 * driver was loaded, i.e., before it called pcim_intx() for the
+	 * first time.
+	 */
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (!res) {
+		res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		save_orig_intx(pdev, res);
+		devres_add(dev, res);
+	}
 
-	res->orig_intx = !enable;
 	__pcim_intx(pdev, enable);
 
 	return 0;
-- 
2.43.0


