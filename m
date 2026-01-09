Return-Path: <linux-pci+bounces-44309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E2D06996
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 01:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52DBE30242AB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6384F5E0;
	Fri,  9 Jan 2026 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FH3moi6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841D2745E
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917644; cv=none; b=fLgrsz7SRRsN9IaspZM2HMei3Q3dLajxRiEWQTsYWNwV9VeJvpl8Q9M0cVx+vBVsrcGTbitJEWF1Csgdm8VtbfesSOdkfQWqiNP6cL3Hh/1Tr0w9BzxeR9VczeVcOXQuZZ9KUPrjo0n+S9kqOrm1wRD2Z+b/Lqa2eO1WWrP+ARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917644; c=relaxed/simple;
	bh=YvgZCnLl8kDCHCjYz124e5DuWVm+JFqUM7j6gYl/Rug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3WhjVRjZHYc5fXvASigY2nYHriA4DF17hCYAoDVSOUhGnNHEJQCaZeG5B6cq5DpgdxK5sygt9w9yZ1+3m7AX5d66nTujvOlvX8EuGmKZIgWI4V8wak8k6Wo4/7ihORmtft/W4jnk9pFCErORs85HsyB6IjjOMuCRhSeDUrzNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FH3moi6k; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11f42e97229so3658967c88.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767917642; x=1768522442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSmvH8adkHXhiRZhlyJ8FsTU6C13zE7kMYKGJFx44kE=;
        b=FH3moi6kqLYrB3ASM4m+rJNCvVp+yJb9VXR8wT5ORxA6qX8IfzVu+YioPSvzoY5vz6
         +64TtQVCZv7H5THNP8PMHZr1ULGz871fCDJE+F6bWxI6CmvQU9jZH4eqn0CAo7DCucUK
         KxJGo4mAc2e/ceLBex6iwF2fz+2wcadBhniQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917642; x=1768522442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSmvH8adkHXhiRZhlyJ8FsTU6C13zE7kMYKGJFx44kE=;
        b=ffR1mu3Jga8+nrnoHeR+pc0jbuWogRnTd7giTk6+B+MVa5oRyxMF2kphtyAXN7ASg3
         SOzL1ABfHIDyEwyszXdzBax+npCu9Z3vn+Dwm3Bu6K//4y1VkrT9LNV6rYYz3UXENcgr
         XOzR6cwmV8h922CHI1g9lJFuuhmiLYpUfJJn7AOCd8/Q4cHGn644hMS3Q9wW4yIVblnh
         BZm/cf+nBEmNsumAvtZNNVMyVSwEbque3Pm4y+Zy5IiYPgwq48UpXPD2Jl35H7vw8EYh
         2HC6R/PdpYv4exs1171Wa2V1uPBsW6ILqo4mqRHHFyzEI1ZXjBDnvL6EuBlDmtSk4Q+1
         ANDw==
X-Gm-Message-State: AOJu0YyuT2T2inl7z3OW8nepJa7+kEmaiUXjy2vm/5Dkj4yH2wr2DXrG
	pl9y5JavecrMbGXSVINDerC+th/Uv+NN7BtPd12vCF3TqmY67w1CWHVcHi0pKHrSyA==
X-Gm-Gg: AY/fxX46U3v/nEKW+NQSd5V0VuoNURP0cZIxnxerTB6UXopRz9CqvoWPNap+wHdZtZK
	bWkMvM8lGveY+24yte77wjj4V+4bSqU8A9HYBCLvHjbgCLniXxzR62GSeHzI6XsxexrqaEegk/y
	NIstAizol+pgmMhucpX8FMnCxZpKjI0bFpEoLYz6rVl/+nsfMvFhM30wHm7lh/7AoHgzNfPwULb
	kb9n3+Ahi11BiBIRLcnH+6VX7Y2/IMfj/P+qnV87CbRPlnObj6hbrDz+qyq645Mx0xIzZI5FElg
	MvMbQDtdjRS8P8yptvbGtwmPMQZ7LlvTQfWi0fy8bK9qrkozzC/7bRGDJxA6UULrhh3/aPgHnel
	uf1D6eERD40s6INYEMSwtwXu9/9Ts3sy+Xje2Iggvpv1MDYNGfZiVzjmRkBzH5Ott88ZqIe/Ozv
	UKRt2SbiTIlG3Kt7KP5FKlc+RY4U6tbbOTRXOe4FskhHb7DxyM2Q==
X-Google-Smtp-Source: AGHT+IFbyeR0IKbTSW5DsBALJOUyi/QuZs6mlolvqhHMWKSyvFRSWjGskyqytGZx3KJpEpVbtiA4+A==
X-Received: by 2002:a05:7022:2398:b0:119:e569:f260 with SMTP id a92af1059eb24-121f8ab9c7emr7233832c88.9.1767917641602;
        Thu, 08 Jan 2026 16:14:01 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d9f4:70dd:b942:60f7])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-121f24a65b9sm12123978c88.17.2026.01.08.16.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 16:14:01 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH pciutils v2 2/2] dump: Support `lspci -F -` for stdin
Date: Thu,  8 Jan 2026 16:11:51 -0800
Message-ID: <20260108161151.pciutils.v2.2.If87a54f8fef6bb9e14edd6a4518b37fa57ef08d6@changeid>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260108161151.pciutils.v2.1.Ib31bf88c8cfc7ff9aa517fdc4842f7d80b6f9d1b@changeid>
References: <20260108161151.pciutils.v2.1.Ib31bf88c8cfc7ff9aa517fdc4842f7d80b6f9d1b@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Factor out parsing into a separate patch
 * Don't close stdin

 lib/dump.c | 7 +++++--
 lspci.man  | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/dump.c b/lib/dump.c
index 97c6befe8a5c..d234657b25fd 100644
--- a/lib/dump.c
+++ b/lib/dump.c
@@ -130,12 +130,15 @@ dump_init(struct pci_access *a)
 
   if (!name)
     a->error("dump: File name not given.");
-  if (!(f = fopen(name, "r")))
+  if (!strcmp(name, "-"))
+    f = stdin;
+  else if (!(f = fopen(name, "r")))
     a->error("dump: Cannot open %s: %s", name, strerror(errno));
 
   dump_parse(a, f);
 
-  fclose(f);
+  if (f != stdin)
+    fclose(f);
 }
 static void
 dump_cleanup(struct pci_access *a UNUSED)
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
2.52.0.457.g6b5491de43-goog


