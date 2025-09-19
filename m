Return-Path: <linux-pci+bounces-36515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D7B8A926
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29385A71AA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B308D26B2D5;
	Fri, 19 Sep 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j3R9Hs4Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+uAzxoCJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j3R9Hs4Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+uAzxoCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA423815B
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299526; cv=none; b=nRsWa2R57WBiHUnpsSWBDOC2m8L/dt34k6hLvgYNh9VMmNNNtwxAI0p+F5/sI2nCN0XpGh3sVnNX9GavOL8QFjxmR/mHj5a+PRmiRnvUQPKC3gs0mhBexROuy4UEv2uNV6FmnYaij+0GhR4yPB3xu5PW5WJovYXuc3eIk8MUZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299526; c=relaxed/simple;
	bh=vw8OS8C1PnD7jjQp/x3X7l/ZLVMQnrHUTB1C7ieWDNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i12XcQJVr+OZu8HBVCKE9x7o/6QhWAKQh81SC1Anc6qBM86i+rEKgFNSuB/FnUriepV+o5XERk5P4BpGl2sPQkeEgHRJy5CeVwoJMte89juSwB7CaPXfDImhvYg+dIZm6538JMwSrr5CiJolDf3GF7iPpXOotrmtxxAD7F/l2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j3R9Hs4Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+uAzxoCJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j3R9Hs4Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+uAzxoCJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 465DC21254;
	Fri, 19 Sep 2025 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeu8Ku2rvkIi8sWxYCKlM50eGDdg+VzqEacYc38VvmY=;
	b=j3R9Hs4QV+ZqVlXQUUCiOAz6jSTXbiTUd+1CbFqLGEOu/IyBOaKIbHhHm/7OP68WoBr3fk
	b/E92cu+EwhCVw1skt37xlj5+PVEVg5S8PfTCFjJ1EuYa/tSX9HP/sPR+ZSAmHbP+3mb0/
	w7uqyDbOzEi9uPvjHfToqf72okzbR/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeu8Ku2rvkIi8sWxYCKlM50eGDdg+VzqEacYc38VvmY=;
	b=+uAzxoCJ1OJ1peg8D4O6nCPD/hbwxU64GVQA3VdedlQbKuG3qKRSC3iuGfNuv8fmICwEtP
	6Ev2XPnQRnBZfKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeu8Ku2rvkIi8sWxYCKlM50eGDdg+VzqEacYc38VvmY=;
	b=j3R9Hs4QV+ZqVlXQUUCiOAz6jSTXbiTUd+1CbFqLGEOu/IyBOaKIbHhHm/7OP68WoBr3fk
	b/E92cu+EwhCVw1skt37xlj5+PVEVg5S8PfTCFjJ1EuYa/tSX9HP/sPR+ZSAmHbP+3mb0/
	w7uqyDbOzEi9uPvjHfToqf72okzbR/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeu8Ku2rvkIi8sWxYCKlM50eGDdg+VzqEacYc38VvmY=;
	b=+uAzxoCJ1OJ1peg8D4O6nCPD/hbwxU64GVQA3VdedlQbKuG3qKRSC3iuGfNuv8fmICwEtP
	6Ev2XPnQRnBZfKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F29D513AB2;
	Fri, 19 Sep 2025 16:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MNb2OYKFzWg3UwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 16:32:02 +0000
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: Use PM runtime class macro for the auto cleanup
Date: Fri, 19 Sep 2025 18:31:43 +0200
Message-ID: <20250919163147.4743-3-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919163147.4743-1-tiwai@suse.de>
References: <20250919163147.4743-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Use the newly introduced class macro to simplify the code.
Also, add the proper error handling for the PM runtime get errors,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pci/pci-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..08e5cf2ba73e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *dev,
 		return count;
 	}
 
-	pm_runtime_get_sync(dev);
-	struct device *pmdev __free(pm_runtime_put) = dev;
+	CLASS(pm_runtime_resume_and_get, pmdev)(dev);
+	if (IS_ERR(pmdev))
+		return -ENXIO;
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);
-- 
2.50.1


