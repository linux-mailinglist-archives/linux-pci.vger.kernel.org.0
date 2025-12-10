Return-Path: <linux-pci+bounces-42882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4062CCB2D19
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CAC430056C8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB12FA0F5;
	Wed, 10 Dec 2025 11:25:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044E2F9DAE
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365941; cv=none; b=OExOV120K5uLcO3aL7wrOAjGYnsY7wVMmNE3Oo3wKJnCck+uc+sViDHSnzAfHHAw+iLpHofepIqjANh4o84hwl0neSauTn81xE+9ky+dwu+NjWutMqbqHuRMfnjZmkYsQtOJMysJexieBBe+FjqZlfg7BUAbXkOeQ1GMPClOl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365941; c=relaxed/simple;
	bh=SiflQ8BqReS4IAkXvC+ybFavpL26sJ+t3AeNXPU0WLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bwHL2FyZT7C0WPrm9JrEetjxV90K74a8JAod26twxCRpQEeA80tQ0n58/Mad0QSylBpi8WEai5G0WHNEa4g6WXH1MsgPfVUbzUGORbQUuvdarbKVWhZUtzEHyVdO7HCWxl3v5aGgbjaMpwLE4yl9x+Fmx/4m8LjZNdYQ2PT7fI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736ffc531fso382394366b.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 03:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365938; x=1765970738;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/KEgc0VuJbMbVFu5ef1xgSG23C2eQz5SCc2+vandgc=;
        b=tjYwn48+ZQ8xwAYY4Z4WEW+3a8G6Tmf6QqJhH3UfLkSoiC/BQHpONKB/kU4l0UcS9p
         oGzghATE+rQL1xbLEOamdljDhlL+LMF7hmVBg1+A5mdVCc8z2Tb7TGG3EiDtGufVpchY
         gVH+/AwEFrlKs7LHD5I1hGl8XbVysFLvCd6/Z2zxXhM/0yJoEGlrNv1qIssRFVnA9eZS
         j4mL9fZIYtP8a/Dfxko5udwj03Z852hwxa5I0qNLug6AQEgAjPs9Syjqv0xE/woqbcH+
         y++/tPRGa2142gdYfAJbGhKEXzqc1u0bMOl2cidJxn9jJ9ZmkXo27ZTks6kHwbTqjp6D
         nm9Q==
X-Gm-Message-State: AOJu0YwH+DVZ2JvoabDQ4HW5LjB9/jrY1dRT3AMcrxni6/Dun+Xaj6eO
	WyadMUgG8QNrB9HGB7gYoTpIPPARHXUnYcuBpoZQtYP0Bx1xb16FP8bUKg6CBrWrXgqmr8FudwX
	S/AAitPc=
X-Gm-Gg: ASbGnctZRU/yUb4QP0H5cVTay4L0BbQ2aOgvIFvloVyRFpbvSG7eXnFk6d1F5KndEkg
	Sjc5lhZMim7Oxd8RIECiSAZOL/yZuc4nYtduuiGZfRhdRvfEXtwZ1cHyyhEq/l5q9rkqP30POW0
	3drMV90dLQ6Fy+IAhl0j5Ej0viz05oEt9hxebIB2eDZu2M1Nb4aW6LGkDYzk5Ke/CVxy9zmPKgt
	jF9n5YMt2vQbPDQGdbhDikOOkFp1zciHhh1UwIhGojwt6oQXiewGP0+CHAhFiato2QLg9DSlWmD
	j6gfzqLR+lhrt8VUIgVLGp+0FDcHrg6NMakXs/Fwkk9i3KiMVbCFpzJ9rl3nETTmyy1ilVJUmnh
	wYTKiu8qEmi3/1/5aVSDxEbFrbFgUX3YKNyCg95OVv21mD8Yh8MnD0AooHROfp1kZTgiGgs/EKO
	BZyvqHu7/mRkFV8NVOS2EEnK4myOCD4oV2RHFQs+C3FCBw9ZSdSt4=
X-Google-Smtp-Source: AGHT+IHIpXxJMkLL/+eyW21uSytCKFrqeqKdh2xUnVgpDC8S3A+wyRIllZtL1Su7fh+/R4PQxbxQ9w==
X-Received: by 2002:a17:907:3fa7:b0:b73:5f5e:574d with SMTP id a640c23a62f3a-b7ce8498f08mr225280666b.59.1765365937868;
        Wed, 10 Dec 2025 03:25:37 -0800 (PST)
Received: from vps.markoturk.info (cpe-109-60-37-145.st4.cable.xnet.hr. [109.60.37.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cf2a9717fsm53958266b.24.2025.12.10.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:25:37 -0800 (PST)
Date: Wed, 10 Dec 2025 12:25:35 +0100
From: Marko Turk <mt@markoturk.info>
To: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	miguel.ojeda.sandonis@gmail.com, dirk.behme@de.bosch.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, mt@markoturk.info
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Marko Turk <mt@markoturk.info>
Subject: [PATCH 1/2] rust: pci: document Bar's endianness conversion
Message-ID: <20251210112503.62925-1-mt@markoturk.info>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0

Document that the Bar's MMIO backend always assumes little-endian
devices and that its operations automatically convert to CPU endianness.

Signed-off-by: Marko Turk <mt@markoturk.info>
Link: https://lore.kernel.org/lkml/DE7F6RR1NAKW.3DJYO44O73941@kernel.org/
---
 rust/kernel/pci/io.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0d55c3139b6f..bfa9df9e9bb9 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,9 +18,12 @@
 
 /// A PCI BAR to perform I/O-Operations on.
 ///
+/// I/O backend assumes that the device is little-endian and will automatically
+/// convert from little-endian to CPU endianness.
+///
 /// # Invariants
 ///
-/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
+/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-- 
2.51.0


