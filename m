Return-Path: <linux-pci+bounces-36516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB6B8A92C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9446F6204B3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2226D4C0;
	Fri, 19 Sep 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qXjMYOPb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R+n/ZcKh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m2z+VB18";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Na8T5o/L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9511221D9E
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299526; cv=none; b=sYErC88WRLvsO2nbFX2YmGNLa7s3JfLZxOSxQqWrL2pDu/Zephp8LpwzMrH0v17f0o3DL0J67t8yh1eeYxDe3YEEBQUu9Jc1sfHBkOtKg4Wcqai/6c5ruCMpmxotn1Yex52aTIs3SRNHANq7YqgFhUfk99vnTN4eR3V3xQ022kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299526; c=relaxed/simple;
	bh=e7IXqqSXjA70wXHBKc8FNg5mgO6PvRnRSD3P3qjKTmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOAQzXXXpS8HcqvF7we56UwXrng56EXld1Z/nqnIS0z1sRXhwPUUe3kNpoq8GQYNPe7QDDqSyIbkp3p19Z4ECG04hR/VLGGPq29FgG3ZPugR5yN6xodxucS+aKb04dyoSIPH5r6F315JfJqYCQd6kBhCeparbIGNMkQE6jo6/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qXjMYOPb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R+n/ZcKh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m2z+VB18; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Na8T5o/L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF5611F7E9;
	Fri, 19 Sep 2025 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL1nuIMA25UdHui+sNTNPrg7l3hF6XOJR1S/KLkQxYk=;
	b=qXjMYOPbEkoveM64Qmo4yBmLKtPWuPBtNxviq0BX7r/HoILaMCdU6ZS/LcKxIylFuawoDN
	Btpb7d8QZ3bCbumTxosIv5S21qFmF0WKiEmq2LFiV6HOw+yha5FgsK1Q7/RxG7HFTJ3iml
	mLZ6JBJvuJsY8W2S2RPPrSxQqJDay84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL1nuIMA25UdHui+sNTNPrg7l3hF6XOJR1S/KLkQxYk=;
	b=R+n/ZcKhI9mpuICeyZGWiG12l38LqKQ8jHnPbCN4K81t1dmdkO9jQiRRQtS4qhWucX59y1
	SjcgtIYV78WnAUAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m2z+VB18;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Na8T5o/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL1nuIMA25UdHui+sNTNPrg7l3hF6XOJR1S/KLkQxYk=;
	b=m2z+VB18l+BbFkJYgborRcGosHWhOzfW409kGXfYrw/ul6WRERMtVM5qHyTMy/YSBz7tOU
	CxHM9MbJqJTSfyXFQmreduFX6f/rG5mg5VA88F8nGo7umm1u66O8mJQ2ug8IGGnqHAG240
	91jlKnxazVVdCf5XwFHy/zxWM+aUMZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL1nuIMA25UdHui+sNTNPrg7l3hF6XOJR1S/KLkQxYk=;
	b=Na8T5o/Lxgs5l3Ab/NGs4d0wYMzEQVC2ME9g0KrMy/m/vIgoR1OP1v4Ee/azywnLJqV4BC
	yrvvEIKcRU3avfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB31013AB1;
	Fri, 19 Sep 2025 16:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2H5ULIKFzWg3UwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 16:32:02 +0000
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PM: runtime: Define class helpers for automatic PM runtime cleanup
Date: Fri, 19 Sep 2025 18:31:42 +0200
Message-ID: <20250919163147.4743-2-tiwai@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EF5611F7E9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

From: "Rafael J. Wysocki" <rafael@kernel.org>

This patch adds two CLASS macros for the easier use of the
auto-cleanup feature to manage the runtime PM get/put pairs.
With the CLASS macro, pm_runtime_put() (or *_autosuspend) is called
automatically at its scope exit, so you can remove the explicit
pm_runtime_put() call.

Simply put, a code like below

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	.....
	pm_runtime_put(dev);
	return 0;

can be simplified with CLASS() like:

	CLASS(pm_runtime_resume_and_get, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

(see pm_runtime_put() call is gone).

When the original code calls pm_runtime_put_autosuspend(), use
CLASS(pm_runtime_resume_and_get_auto) variant, instead.
e.g. a code like:

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	.....
	pm_runtime_put_autosuspend(dev);
	return 0;

will be like:

	CLASS(pm_runtime_resume_and_get_auto, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

Note that there is no CLASS macro defined for pm_runtime_get_sync().
With the auto-cleanup, we can unify both usages.
You can use CLASS(pm_runtime_resume_and_get) but simply skip the error
check; so a code like below:

	pm_runtime_get_sync(dev);
	.....
	pm_runtime_put(dev);
	return 0;

will become like:

	CLASS(pm_runtime_resume_and_get, pm)(dev);
	.....
	return 0;

Link: https://lore.kernel.org/878qimv24u.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/pm_runtime.h | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d88d6b6ccf5b..637bfda9c2cd 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -532,6 +532,30 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
 	return 0;
 }
 
+/**
+ * pm_runtime_resume_and_get_dev - Resume device and bump up its usage counter.
+ * @dev: Target device.
+ *
+ * Resume @dev synchronously and if that is successful, increment its runtime
+ * PM usage counter.
+ *
+ * Return:
+ * * 0 if the runtime PM usage counter of @dev has been incremented.
+ * * Negative error code otherwise.
+ */
+static inline struct device *pm_runtime_resume_and_get_dev(struct device *dev)
+{
+	int ret;
+
+	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
 /**
  * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
  * @dev: Target device.
@@ -606,6 +630,25 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
 	return __pm_runtime_put_autosuspend(dev);
 }
 
+/*
+ * The way to use the classes defined below is to define a class variable and
+ * use it going forward for representing the target device until it goes out of
+ * the scope.  For example:
+ *
+ * CLASS(pm_runtime_resume_and_get, active_dev)(dev);
+ * if (IS_ERR(active_dev))
+ *         return PTR_ERR(active_dev);
+ *
+ * ... do something with active_dev (which is guaranteed to never suspend) ...
+ */
+DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
+	     pm_runtime_resume_and_get_dev(dev), struct device *dev)
+
+DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
+	     pm_runtime_resume_and_get_dev(dev), struct device *dev)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.
-- 
2.50.1


