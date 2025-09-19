Return-Path: <linux-pci+bounces-36518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDAAB8A93E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8F55A79F5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80BC3218B0;
	Fri, 19 Sep 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJTT3WXf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+QCKOQv9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJTT3WXf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+QCKOQv9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A632144F
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299532; cv=none; b=e+jHZsdt+0mxs3nZ2EBPdQaQsiuQkyY1AVLPytpXXPIKMjgOMtRC1Y2kOAAJUNZzrOTxBBBW9V2QYoJEz/2mK93FHH0JkW41SypdtL+vQ91ABUuQM+XNsMcMS4YWKlqKrg2+PITFMsy3Z4cG4DU7os107QEVa9xQL12TVdz7epQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299532; c=relaxed/simple;
	bh=6kjlxtAaKEKwqWPYADldDQV55pMUahCcj4KCt6px5ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIBVOosJMXFPMVXpj5VrPlyJKqVQu6jEqHt2EOacDf3eCZGUiKvfE7qteF/NRuIcKeP4lZNZp4Gl0+kwqYJY86/ao1T30KKlLsIFtisvnUZzXuavawCwnsunsWlK+fnqYfogz4IFU9e7gS0nPISsfsyIi/LrckVjizI6kLtz1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJTT3WXf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+QCKOQv9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJTT3WXf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+QCKOQv9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 867441F7E0;
	Fri, 19 Sep 2025 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTG2gaW2eoTvDCKZNxhXHU5hoiL6obDkARwhNAllDqQ=;
	b=NJTT3WXfjUp8b4R7PSK5CcMsykG0mZM8/T7PZZxlfIvt76kWa1wJLJu0MtfETVkjsfK2kd
	jfq1Um0P0+ahAr/VPf+ZTODnDfOZK8Apqr48z9+l3X+WgZm8HSfAoSSn0rHfNz6yHY/KWP
	ihCKSmPm9GSOWFozx8GLW2Zwk06/zW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTG2gaW2eoTvDCKZNxhXHU5hoiL6obDkARwhNAllDqQ=;
	b=+QCKOQv9fgJ/ZMrNk1BVfeu3P+rLFGoP3pGRa5Q1mOM/b5hXudKNYKu9SkISdu7zhU0z9W
	VLYUF30n8AUjzdBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTG2gaW2eoTvDCKZNxhXHU5hoiL6obDkARwhNAllDqQ=;
	b=NJTT3WXfjUp8b4R7PSK5CcMsykG0mZM8/T7PZZxlfIvt76kWa1wJLJu0MtfETVkjsfK2kd
	jfq1Um0P0+ahAr/VPf+ZTODnDfOZK8Apqr48z9+l3X+WgZm8HSfAoSSn0rHfNz6yHY/KWP
	ihCKSmPm9GSOWFozx8GLW2Zwk06/zW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTG2gaW2eoTvDCKZNxhXHU5hoiL6obDkARwhNAllDqQ=;
	b=+QCKOQv9fgJ/ZMrNk1BVfeu3P+rLFGoP3pGRa5Q1mOM/b5hXudKNYKu9SkISdu7zhU0z9W
	VLYUF30n8AUjzdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44EE413AB1;
	Fri, 19 Sep 2025 16:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8JlrD4OFzWg3UwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 16:32:03 +0000
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PM: runtime: Drop unused pm_runtime_free __free() definition
Date: Fri, 19 Sep 2025 18:31:44 +0200
Message-ID: <20250919163147.4743-4-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Since the introduction of CLASS macros for pm_runtime_get/put and the
conversion with it, there is no user of __free(pm_runtime_put) any
longer.  Let's clean it up.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/pm_runtime.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 637bfda9c2cd..29d746f57f98 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -579,8 +579,6 @@ static inline int pm_runtime_put(struct device *dev)
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
-DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
-
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.
-- 
2.50.1


