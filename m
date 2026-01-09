Return-Path: <linux-pci+bounces-44308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A96D0699C
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 01:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBA13004F7A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B5B4F5E0;
	Fri,  9 Jan 2026 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="io7N+CP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1322745E
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917641; cv=none; b=GEE9Qq2WHFBucrtx/YzkD1Ml8+gqLKIuEvjGNtAdmxDdnynNY6mB9xrQn2jBzPEtNwGyU8ahOeEx39nxisGLAkdOLuH4bO1xyV5NxuUlX6j1wwtuuHXICLi6tF83l/eJnlPoPhR3RmwlNnovXPIVnao3d1KB9hFqw++r6Ez+UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917641; c=relaxed/simple;
	bh=8dV9TWEC8tJsGtQvYT0IoSeNVMmidv75ixk0J+sLqPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqAINVWnNCnTdfpgrQQOVRUsXf00uExXgER1SPerUw1CQ+h2TKiuCHHrzgckq6Agasj70ijehpMQbSghe1GwgH9N3BNOwERKeDkLO5yRNVdGC3ysdnsoLp41Y/2CR8bMHJV9C3xxJZUuN2mOO3yn6N0V1ncvyYNdh+WNqWcMkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=io7N+CP6; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so8224547eec.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 16:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767917640; x=1768522440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyFTG/wWf5ren6hochNNRhl9vjOeLhNcl/CoRFhMfeY=;
        b=io7N+CP6ugYZiq5OVCKYR3kKEr3ILwYCbtaWtXhgGNTgMqbZrxvNP2AHNEXkGKkQ4y
         AcPdm34K0+9LvcTLCdFUnevDMIZyzpN9y/8iFmOccZ71J9x8PZagc5UYFeT3bpNOK2de
         E4hfvysYBwI1SAU3vKfqV8QApReQYe7MujKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917640; x=1768522440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyFTG/wWf5ren6hochNNRhl9vjOeLhNcl/CoRFhMfeY=;
        b=qdEHCBDKbP09tUQTy37/2Jnm5lCUd/FqjflYdku2pv5tip6F3h+04++Cji1937pVVu
         ULVqTW63YE5ChYqt/XNfyWZ9pfEAOhrczILxlKhB3+97DG54RY2CitGuvU+l1UiPD2qf
         wkahyfruFc1yreH62z//gb8RX0Nx4RNAMNWoNwcql+ML0y4D6FT+aPxmffx5olWISE6p
         2Hf+oXbboeoItjGo5JDp6y/zVBArffr/LEmy+RIv0oKiqk/DW2pn6gqrlsI3vcrRkWgY
         5DgJWtFZt7UxMFlDoLdfKwCCacCV75zwrKx+lfdj/7jtB89jgrP+5nFtFuy1Y0k29U1u
         00/A==
X-Gm-Message-State: AOJu0Yy2FCfkEBuO+SUUDoodvBed5QUKZAACo9igi0W87CMdRu7iYPlf
	Kzce+f9RYAnzmuVuKxSIq596ocgN2GaqMqwE6s7MXxkE5iYxr4KbUFkUo+ik7l89gA==
X-Gm-Gg: AY/fxX4Kb7AFJEqVCWmdzQQhcX+pa6Pnkt0JPIdBi1Seyc8vfLq+RRA4uezvpvxNNyz
	lHPs6vRs5ocaD5n84VSx+wiPxiJVk8XKGojr6bmEOgEdquiJPwOSX22guMs3PRkDCvBaOfowiDZ
	WgORmkOsDs22WyElHVNsT+LzSamkubX93dBwesQPXe/a3NAjk8DNr9lsKl5gdd4WsiWu7/ZTg1h
	VX8VIzAc0t5/Tg8cm2hRIWE3TKE0KUYubSihsyU9989Vs5LEPsAm8RTP3jK3DaUJ0e4FhgKcx/U
	ZAsBWGOUuwL2JCT1AyMNqQVV3W6iRfcmHbDq/XTw2vhjxjELsJzzmOSPCKD2HMZfI9IJVUpIElr
	5rjfxWPuwPlPem1qLZpIdzs5ipm2NKiPQ4+GvO6ZwIU4sucgFjBzM3mnZQJ0k8M0YKChHP5BfuR
	gNSfqriFRYDYbVZYpINmYAZMEpi0W1BzeexKRP6xtHHT74R47znA==
X-Google-Smtp-Source: AGHT+IH1rEWWT2i92ztMKe1dns+Na137Xl+Qb518QLO/aAOmz0ohVPA5v07QMpSbyUNn+x3+l7L62g==
X-Received: by 2002:a05:7300:8b85:b0:2ac:1a21:841d with SMTP id 5a478bee46e88-2b17d24ff29mr5880591eec.16.1767917639589;
        Thu, 08 Jan 2026 16:13:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d9f4:70dd:b942:60f7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b1707b0b2bsm9833167eec.23.2026.01.08.16.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 16:13:59 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH pciutils v2 1/2] dump: Refactor file parsing from file path logic
Date: Thu,  8 Jan 2026 16:11:50 -0800
Message-ID: <20260108161151.pciutils.v2.1.Ib31bf88c8cfc7ff9aa517fdc4842f7d80b6f9d1b@changeid>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to tweak the FILE handling a bit. It'll be cleaner if we
separate the FILE initialization/destruction from the FILE
reading/parsing.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * new in v2

 lib/dump.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/dump.c b/lib/dump.c
index 00ebc9e3e782..97c6befe8a5c 100644
--- a/lib/dump.c
+++ b/lib/dump.c
@@ -56,24 +56,17 @@ dump_validate(char *s, char *fmt)
 }
 
 static void
-dump_init(struct pci_access *a)
+dump_parse(struct pci_access *a, FILE *f)
 {
-  char *name = pci_get_param(a, "dump.name");
-  FILE *f;
   char buf[256];
   struct pci_dev *dev = NULL;
   int len, mn, bn, dn, fn, i, j;
 
-  if (!name)
-    a->error("dump: File name not given.");
-  if (!(f = fopen(name, "r")))
-    a->error("dump: Cannot open %s: %s", name, strerror(errno));
   while (fgets(buf, sizeof(buf)-1, f))
     {
       char *z = strchr(buf, '\n');
       if (!z)
 	{
-	  fclose(f);
 	  a->error("dump: line too long or unterminated");
 	}
       *z-- = 0;
@@ -105,7 +98,6 @@ dump_init(struct pci_access *a)
 	    {
 	      if (i >= 4096)
 		{
-		  fclose(f);
 		  a->error("dump: At most 4096 bytes of config space are supported");
 		}
 	      if (i >= dd->allocated)	/* Need to re-allocate the buffer */
@@ -124,14 +116,27 @@ dump_init(struct pci_access *a)
 	    }
 	  if (*z)
 	    {
-	      fclose(f);
 	      a->error("dump: Malformed line");
 	    }
 	}
     }
-  fclose(f);
 }
 
+static void
+dump_init(struct pci_access *a)
+{
+  char *name = pci_get_param(a, "dump.name");
+  FILE *f;
+
+  if (!name)
+    a->error("dump: File name not given.");
+  if (!(f = fopen(name, "r")))
+    a->error("dump: Cannot open %s: %s", name, strerror(errno));
+
+  dump_parse(a, f);
+
+  fclose(f);
+}
 static void
 dump_cleanup(struct pci_access *a UNUSED)
 {
-- 
2.52.0.457.g6b5491de43-goog


