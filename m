Return-Path: <linux-pci+bounces-42536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A03C9D342
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 23:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A54E3752
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF62F9D8C;
	Tue,  2 Dec 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbnahQjR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552342F90CD
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714208; cv=none; b=P0VbWfV/XxqeulFmSJKKVPPlDADKeawdDEiJabvfOmaWiYS/uA9IiYkkK+9KoZCXeSId0oqq9jt5DdTBjPtFzlDYsV3qLXmaSerBuFQkbT85AQV+KskKyycbgMVjwUTnmPPa9Lt/sl+vskTZFxqIMUJclZ1UMzpO47I8zZuhLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714208; c=relaxed/simple;
	bh=lansFPWa8a8i9MtzvmNIvbKm2tfyDv9hIhtaM5rOO88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5G2KGAIn+b8zvvHkmqIVu/huV5ucusx232UlMIyziImiBbV6A45GwhxUspaLDsC95xcYZy+g5hwYN9GNM7SaSHbWwiwOolq8rHkMNlj4AgRI5x9X78nzyM7n+LYMUydZ2zh2/+T8mwdX1QVJOaS7Fz0A83SBT2FIrwODoREOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZbnahQjR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29812589890so71859605ad.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 14:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764714206; x=1765319006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWRcZibZvKcAdZFQm9zANwrWSXsw9mMjGu/qDQSEZf8=;
        b=ZbnahQjRLmQxl79zUQUzr2185OVL1YI91iQo2Ic7NODQAO3hrxvgcH4jiTMpIi10hg
         9mnZeRhj49FUHEfpxjqbl0aoZIyYZFHLGCwMX1CXXmx76IiK/+c3sBzqZ3kuD9i8ldSj
         2I0d738uRJj4q8DgWNGhc1VAxFqOX3G2ZxCG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714206; x=1765319006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWRcZibZvKcAdZFQm9zANwrWSXsw9mMjGu/qDQSEZf8=;
        b=fcnp0bf3xP2z9AT/iAk1P1GWT3XyrCvedN0eUxQdLxMGWqQEg64bKdfyd6cZO+9N0L
         nQhlJ6KOW3i7f0h2Waae8Oa0oQcUVWs8B26y4RPeBfKVbktpkBqfADe3uo0gcKf6hDhv
         PfLGhozceWfOEqQF1G7bHMITZLhn8datryI+7y4O9+xKlOKx3ZjrjqcUn3A+LnqSwf3N
         dxGyXHEer6QcxBxJpvbD6KarcCRQ/uTOUQmOOpfbOwu4wR5hCYnHyRUwY3Xx+Wt2K40o
         vSI5pHlcIQq8d6xHBS6rglzn210m/ZpY8GBvopGUVmWHA6dlHuCy4Cu/CX15+lmT2X7s
         WCcw==
X-Gm-Message-State: AOJu0YxyQcV3YK+Ta5WJYugVSqJVVPJ74h2Sz0it8siw3i0k69y1NMLj
	pz6yjfKTX3mDvTvaBsJONYZ4eIAfw4VcGRZCaLi22ADvbSphcSMG5t8/40y69cTfMA==
X-Gm-Gg: ASbGncsMc1XKdn92b+3TE6339f0MboTSc62eFQltcvOLwqzAs7y0EdsTYjCQ+UVIxqF
	HxELrwYQMuhecMsKQpjbJGnlhmaM5Ziu0vH1ILhgXZO7+1s2uWYni7AYSCJBwBc4c2FzHnyxil/
	bBqx5YffhXE5x9GO2fT2N7bVL6ymbZziih12JA7pKudCqHPArxVZlQG6fo3PlL0r8qHw7coZcYv
	o6cF2K2+vVwomHEhCF3jwh7or4sYWSi1rVXJWjNWp5IyCr99kS1rzcP8+h46/JRiuts/p3UYR7x
	g9yYYSaMV7JIgYEBjEye3QqwSRORHwljwPBTyEOCq4PMSqF7YCrTUaaxHDe/7/nRZnAeD4hILcb
	GJ0i1FdmItHeLkhnXopex+1tJwJZDd7fqa9+KI80sAM1s1216nYcuvInqkGI7YzsX1PvQQVQIcp
	vbsomn01+d8hRZEvwEI903sLWXcGmIZCn3Szi2Bjh6wulAdlptMEh+L3xnX4vW
X-Google-Smtp-Source: AGHT+IEZ4t98e3McIXvA087J+RzIVfq5DO8Mk7SHDo0b01kfLReZdqadUVOa6n+b9FV4HtS5YlTPkA==
X-Received: by 2002:a05:7022:6b82:b0:119:e569:fb9e with SMTP id a92af1059eb24-11df0be2f34mr230780c88.13.1764714206495;
        Tue, 02 Dec 2025 14:23:26 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcb067088sm53125115c88.10.2025.12.02.14.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:23:25 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>
Subject: [PATCH pciutils] dump: Support `lspci -F -` for stdin
Date: Tue,  2 Dec 2025 14:23:12 -0800
Message-ID: <20251202222315.2548516-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

It can be useful to pipe raw config registers (lspci -x) from one system
to another, so the latter system can do the parsing (lspci -vv -F ...).
For example, one might do this if the former has a more limited / older
version of lspci. Today, one has to write the contents to a file.

Support stdin via "-", so it's easier to run it through a pipeline, such
as:

  ssh ${remote_host} old_lspci -xxx | new_lspci -vv -F -

A dash (-) is a common convention used by many other tools. If one
really expected to access a file named "-", one can use "./-" or similar
to disambiguate.

Signed-off-by: Brian Norris <briannorris@google.com>
---

 lib/dump.c | 4 +++-
 lspci.man  | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/dump.c b/lib/dump.c
index 00ebc9e3e782..65d8dd5d7b55 100644
--- a/lib/dump.c
+++ b/lib/dump.c
@@ -66,7 +66,9 @@ dump_init(struct pci_access *a)
 
   if (!name)
     a->error("dump: File name not given.");
-  if (!(f = fopen(name, "r")))
+  if (!strcmp(name, "-"))
+    f = stdin;
+  else if (!(f = fopen(name, "r")))
     a->error("dump: Cannot open %s: %s", name, strerror(errno));
   while (fgets(buf, sizeof(buf)-1, f))
     {
diff --git a/lspci.man b/lspci.man
index 7907aeb8a5dc..9281e8a3edb1 100644
--- a/lspci.man
+++ b/lspci.man
@@ -204,6 +204,10 @@ Use direct hardware access via Intel configuration mechanism 2.
 .B -F <file>
 Instead of accessing real hardware, read the list of devices and values of their
 configuration registers from the given file produced by an earlier run of lspci -x.
+If
+.I file
+is a single dash (\fB-\fP), read the contents from stdin.
+.IP
 This is very useful for analysis of user-supplied bug reports, because you can display
 the hardware configuration in any way you want without disturbing the user with
 requests for more dumps.
-- 
2.52.0.158.g65b55ccf14-goog


