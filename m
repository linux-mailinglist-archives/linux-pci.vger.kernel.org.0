Return-Path: <linux-pci+bounces-27474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC18AB08A7
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA863A6E26
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3922D9EF;
	Fri,  9 May 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brzNU2Hv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596164A8F;
	Fri,  9 May 2025 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760571; cv=none; b=d25Udfux4xR8exqu+QtFOUv8RoKlgpaIkMiJaLKyiMQN8pAWDOQkLOmvpWJ0fybIkrs1F/1k9Tt6pWm1A0UtRZ+RyCKh/K3BLqGlbYWNdY/k17jpHa2rrdatso6Z0iHxZtPCCAPwgtqXpLJe4Wy0BQ86qDfa1VZiy1MTYrlWaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760571; c=relaxed/simple;
	bh=rME6fzb4OQsE0xWRpVdtPyAh60eWclIfOsYbwHQ4eI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5hXlmiLvmyclWLvGkdhqT2aOYFRnew8oJQWU/98hsDukmJvzFRQnqLGrE1JgD+8LzRzVdM+lIMI5JqAmIDRHPnzLqn8ZpoYHFDsUEv1Vy4duqZOVtyoaRqaFVubSuCZgjnu9Xv9qnt9lZ7DisvI8eAUqHxGdw9iBiO2704pAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brzNU2Hv; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-606668f8d51so1105174eaf.0;
        Thu, 08 May 2025 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760568; x=1747365368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTOwig8lTDkxPKMgyzizdRYq4XG3E64o3g/lB7m6NZU=;
        b=brzNU2Hv8Vea5DBuhpgOWQA7u4zQjQ5vVTwRaS9/YOuqJmlOCFSzXyobyNHPrTURAc
         wbWZC6jIQZukCEZqCLfOpt45Ova9xtMsg08ODerpmtYQ5xcqSg6TRexO3vfJlXHGkb0c
         JOQIi9DB4Q6Ope3lxOudAnoYwlWJN/YvvUvfGqtdWJUZlWjxjxmBDbagXfq3vvaNsgLl
         XyE4lrBWb18VdAdyZCi6rcg+BbpS0APFqs6bHMvas0Zjn6BrQMP0+AaubLEPWX0YSF8H
         qD7vjpwPLueL99QHBF95MscY5rCCPTXNBBWJaRZX0EBNcbYncnMvfnaMKKdRcdzv3+X5
         jsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760568; x=1747365368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTOwig8lTDkxPKMgyzizdRYq4XG3E64o3g/lB7m6NZU=;
        b=JtVjsx2W6YuE22QNw16jEkbTcbw3qKI3N6C9bSK5GEOOga7Yhfg/dsK93049k002VE
         x7sxTwGm5QH6mSk/8EYUF7gllZeQJh2n5zFznqCXK8bv2HV/7AZi5YAzuL4zeUqR8U8G
         X4tMLUqLK9tzcGShat3VrGRmbBrojF90+qI5AZ3dh1KGNvpoqs7j1OSJJjYHY6TED+UY
         bEHmOFoqdAav9VdCejQmOa3DZRajO2nhQAKaUezjRFWN+bi1pXSt9TzWrYXe3Ks4f6mi
         tfIvpjgKfnnoCCr/p4QMIv12g+XufSRYhQ1fEmhTbkNWbA7jGE9Poi9OdW/36hsK6CBa
         sMNg==
X-Forwarded-Encrypted: i=1; AJvYcCUmO2bZKS0Dg66dWBZdyEkI9yGlUDa7hlWpLPqHaRDCQ4w0f4QQdc6qkRcNVQYY5hIujRrcdNo13ocj5YkWXjg=@vger.kernel.org, AJvYcCW76x7fWaxS9Hlv3Ye3UgrbllA87Lmw1QhP2jdwBQAGco5WVTi34tDfQmHlSrvP8xGnyo+6wIGzXdzYejw=@vger.kernel.org, AJvYcCX/o6oNns/fxr6/G88KDh4H0a2v2MfdMfGNQd48ULWpVst/+nDTZcVeIx2juYXczXUL7nnioyCKsC0v@vger.kernel.org
X-Gm-Message-State: AOJu0Yx808yq/Dy5Mxh5//NSf6t3PgkvwhmUu3fv0vK2dPioeV9TKsQR
	5TjWXtslHPmw1Pt1DXhnTsgAN2CSwwKfoR3yrwFCTHZXA4TIxxUS
X-Gm-Gg: ASbGnctNlHRgu4WWI5UdtnTZ3a7kGGeteiqXzojzT97FXDnqq+O13U0JE5BTW5Ww6Pp
	t6ohQI/bD5dXFCNezb8NKc8t03OwNJsNEsYHpjhq/FyGYOo5G0OWZHeGaa4c0+4HiB9PwyTVtYZ
	djlNj1mi3m3EBg74YOga4h97a37JaNmp7/Prx4dx9QJrQ1DIuYap2WNM0uQRED4KRNH4M59sO5I
	pQ1TRt63qPbrsBXb4SugA5CGpTr2ClLDaOhz7Uk8UFwJwSJmtLtDpI1598Me+0vRxqDXwO11e7F
	vtMx5P+4LGzJK2W/W9/wbHG4Wf7oIhYv7QMoBgQtSjTaCSelwG85nvK8J8DaDxJUNCzefu9oQf1
	8Lyp510yt66Zs
X-Google-Smtp-Source: AGHT+IFabaKG5IMI4f6lw/FzmXhfD/qA1aN2NZHwCsMXYiRNwWJ9KzD39S8IFVi2DsYvBD60grQSJw==
X-Received: by 2002:a05:6820:208c:b0:604:99a6:4e90 with SMTP id 006d021491bc7-60868ad8738mr995531eaf.0.1746760568573;
        Thu, 08 May 2025 20:16:08 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:07 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	me@kloenk.dev,
	andrewjballance@gmail.com,
	fujita.tomonori@gmail.com,
	daniel.almeida@collabora.com
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 00/11] rust: add support for Port io
Date: Thu,  8 May 2025 22:15:13 -0500
Message-ID: <20250509031524.2604087-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

currently the rust `Io` type maps to the c read{b, w, l, q}/write{b, w, l, q}
functions and have no support for port io.this is a problem for pci::Bar
because the pointer returned by pci_iomap is expected to accessed with
the ioread/iowrite api [0].

this patch series splits the `Io` type into `Io`, `PortIo` and `MMIo`.and,
updates pci::Bar, as suggested in the zulip[1], so that it is generic over
Io and, a user can optionally give a compile time hint about the type of io. 

Link: https://docs.kernel.org/6.11/driver-api/pci/pci.html#c.pci_iomap [0]
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.60IoRaw.60.20and.20.60usize.60/near/514788730 [1]

Andrew Ballance (6):
  rust: io: add new Io type
  rust: io: add from_raw_cookie functions
  rust: pci: make Bar generic over Io
  samples: rust: rust_driver_pci: update to use new bar and io api
  gpu: nova-core: update to use the new bar and io api
  rust: devres: fix doctest

Fiona Behrens (5):
  rust: helpers: io: use macro to generate io accessor functions
  rust: io: Replace Io with MMIo using IoAccess trait
  rust: io: implement Debug for IoRaw and add some doctests
  rust: io: add PortIo
  io: move PIO_OFFSET to linux/io.h

 drivers/gpu/nova-core/driver.rs |   4 +-
 drivers/gpu/nova-core/regs.rs   |   1 +
 include/linux/io.h              |  13 +
 lib/iomap.c                     |  13 -
 rust/helpers/io.c               | 132 +++---
 rust/kernel/devres.rs           |   4 +-
 rust/kernel/io.rs               | 753 +++++++++++++++++++++++++-------
 rust/kernel/pci.rs              |  88 +++-
 samples/rust/rust_driver_pci.rs |   6 +-
 9 files changed, 731 insertions(+), 283 deletions(-)


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.49.0


