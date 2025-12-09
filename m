Return-Path: <linux-pci+bounces-42805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 064EDCAEA7C
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 02:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BE6308B5B5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 01:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995262FF166;
	Tue,  9 Dec 2025 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciD/Nww0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254092FE59C
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244615; cv=none; b=lT/LVevfkm/68JSvIHs4+VS7n56qPUw+dxnG7Eq4g+38ce2ahYtti+t1G5m68K1jE9aD1DwLwcCWCLHGM8emwHnkCpr6c5mhIi9p1ijjq+yReXMqmVBk1vKeCAql6VrhUl0aaZrKZ9/NSKnHkOqs1Q52KMbhmoesOreyHIsTJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244615; c=relaxed/simple;
	bh=D5Hpjljf4bCWdefenH6EWn+YOSkODxK2FQEefn1QbiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ7VUhsIaUPTkwFNa0A0Y2/zf7zu373vKRUJDybHdFuLiF8USIBxmCGFclKFtwU03x5X17A5PyVw1aHTHO+gp8tGSxN7wHUtrweO3mhFZiCx6IfDd9wbQzx/WNfA3DQfG3kGlNQq6jwpnIlB6D3wqin6q7c2J8rCAEHJn6WTb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciD/Nww0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3437ea05540so4013887a91.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 17:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765244613; x=1765849413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJqMiOBGI2oVx5Tx7PZBYKb0Ytw7CfxQ2dAViW4MVLM=;
        b=ciD/Nww0opoh/G3ye+pE8N4QVJyUBw1NeuR9QFrFXw15X03U8/S6/QLwWCuEwOTSZN
         FG5Zj2F4gnm5e/8RqzPgCOWOeBE8zSrwwaurnql49nt3RmuGLCmAzyFXgMgaSQgZhsI7
         G5piWHJoWWOlXr2t6tD913+6DOsm9ZnLTdC7B5fLgwGITnkhWyUy9n14vZAsfFRTpWnq
         wbfJVEJpPUnpz4K/hBcLaiF62jq4GBz5eA2H3x2mE2oUab35oHJr7bVwaJzz+AyiAfTn
         Ep8JguEEvdk5oHTzL/oHjH7HO0tczjbqP8xuu6ldNxu1dFzOUkR2+BJtcQ+sZtiNQ3ss
         0meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765244613; x=1765849413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJqMiOBGI2oVx5Tx7PZBYKb0Ytw7CfxQ2dAViW4MVLM=;
        b=pJSVBgstSTFeQlsErL4IUFLi5sWOdgw3rB+WY3lAbNED+onaVym+uel+thAgZ+BTB1
         BSfCayjHfDFxJd35Lso0cbgW5DEC8fwtpxHn/+cO9Uuyd0HVKV7cBWJ5S8vcF5/GFU1K
         4Qj3sH/Rt+TvCnt4zBqSiW4RjxYWauZK9895L26kHy7MpjjU7S0eVHbQB+RZH+rilF/h
         AQ5bpqHv+0LehBOBJQIfx1x2OKfDKJQwhPcM+B4dBj7uOOXhWXhNwpSZ8B3hl5V7pFNT
         ZHZH0AjybDBwzkd4tjr+ryZ5c328dk3oEDlT54sMziW1zhOSj99Fg6dBgHdehlTHAnBB
         a5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOy0/aT43ozDWSZc+XWeQXQ76RtBNr+fqjdckIYtd7fQMkISO3gvzw/ds1WLgqcWqdILEwJKau+Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhYiC4LhZvGLPGKtmaIb49NkxHR4j9XWvySjAII1YrqnI64+T
	zBGvdLmHCEOvH1lK0IuY2reo8uoMhIiMrXX0r+4fgAlA79pubP+grlv8
X-Gm-Gg: ASbGnct8vfVZqltPQ3upw2NmBFQbpS8ysHVgsFp9ds8SxiMMeudk6KpR+96aHZaMuVs
	vSW+/UnjU+Bnj4O2ObsMD0VPTddDoGCyvDL7a82RyDB3Csu+F4fHryivdOO8xmzIf/fFDONsQXw
	4A1Ev2wUJDFHTMDgs0cVMG7WxKDOH8OnymvI+SsAIFG66hY0T3eox0QCk3GQ97BUnixm038SH4f
	y0a1CCjBAMPfKjS5QflSLotmXyXaTBfsqifD+08/Nf5Xu58v1tDc+ISqCPC1yD7tsyF9jH5Nn8c
	IBhXMmfsztYIWhC7p3BXeq2O5rlo0CotM57p9S+df5rUY/m9j6+dB1SPSXPEk8nBZgWYXrMCJBd
	UhL+4/ngubDG0xmKGGNCIyJ8Jr7AMeCVkp6dFfYetMiPtWAYKneDjhUpw5vYDkeoUpapZtZimu9
	A2G/C8fJtGHZNKMKPGZ+GuVXuInuRBd0kf8QBPXtuT4cr6CtAc36p2Yge0gtZn
X-Google-Smtp-Source: AGHT+IGjGvOq2fxe/0mozGUMfMsuSEg7hQi5HOpma6OQ/ZDZ2dCDcbFypS3kyW4M80ddsNItOTtPHA==
X-Received: by 2002:a17:90b:1b4d:b0:341:6dc2:b9ac with SMTP id 98e67ed59e1d1-349a25fb912mr8755041a91.24.1765244613371;
        Mon, 08 Dec 2025 17:43:33 -0800 (PST)
Received: from bee.. (p4783053-ipxg23301hodogaya.kanagawa.ocn.ne.jp. [153.209.99.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a47bc2056sm361140a91.1.2025.12.08.17.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:43:32 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: dakr@kernel.org,
	ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kwilczynski@kernel.org,
	lossin@kernel.org,
	tmgross@umich.edu,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v1] rust: helpers: Fix pci_free_irq_vectors() build with CONFIG_PCI disabled
Date: Tue,  9 Dec 2025 10:43:12 +0900
Message-ID: <20251209014312.575940-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following error with CONFIG_PCI disabled:

In file included from linux/rust/helpers/helpers.c:40:
linux/rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   36 |         pci_free_irq_vectors(dev);
      |         ^
linux/rust/helpers/pci.c:36:2: note: did you mean 'pci_alloc_irq_vectors'?
linux/include/linux/pci.h:2208:1: note: 'pci_alloc_irq_vectors' declared here
 2208 | pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
      | ^
1 error generated.
make[3]: *** [linux/rust/Makefile:621: rust/helpers/helpers.o] Error 1
make[3]: *** Waiting for unfinished jobs....
linux/rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
Unable to generate bindings: clang diagnosed error: linux/rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index bf8173979c5e..0038903a37a0 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -2,6 +2,8 @@
 
 #include <linux/pci.h>
 
+#ifdef CONFIG_PCI
+
 u16 rust_helper_pci_dev_id(struct pci_dev *dev)
 {
 	return PCI_DEVID(dev->bus->number, dev->devfn);
@@ -41,3 +43,5 @@ int rust_helper_pci_irq_vector(struct pci_dev *pdev, unsigned int nvec)
 	return pci_irq_vector(pdev, nvec);
 }
 #endif
+
+#endif

base-commit: a110f942672c8995dc1cacb5a44c6730856743aa
-- 
2.43.0


