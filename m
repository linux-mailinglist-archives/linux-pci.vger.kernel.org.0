Return-Path: <linux-pci+bounces-38602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D4BED6BB
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEC634EFDB5
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701682FBE0E;
	Sat, 18 Oct 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHG+AFkM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2D2FB610
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809567; cv=none; b=li64j60hxrRkwYQ81mlk+bM/+wZ4ilcLyjsegTTsQzaX9zIKrn3F+DYELxHN3LpPusN++pee7AmFcMvUZRGRE647XK+5/mWDjuReZCuwmaq8c7Pwgbgohjys7oO0ICcO2T+HQ3x3n+64h6KkqiEyrHTxK7xxACLDFwsk8ykglcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809567; c=relaxed/simple;
	bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUq0YksZRuDoTNRureVWQM8g47RMQ0/pNrBOkn7Hz9hSgssjXt6qpNkVPma9+JpGACn9PxqJIsL/emUjH3fBdmfF3XmtpWqYNISOWjibFQEzSkYRH+A1vOIOeFWjBotnZ6bA8qWq60C+/QkDcGeI894uORbKlFgExzfFTubLWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHG+AFkM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2aebce7fso450798285a.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809563; x=1761414363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=lHG+AFkMbyufoj+SWOxxS4Jlzvye3+ZRVR3Wqpp8AfEOyxhL6mE+AOcVUJ4AiDmGLo
         1zhxrXq0n/n7BN0pZHr2D/IT0qYPM6Xs7IMW4VddAkyMUlyWQru1bVTzds4jFXGiH4OE
         vEe737BsPF3vXZF9wUdFgnj92fXmR16e/txtYSxdRajM+5jwe0cKQD9f2N/zenHtA/g3
         YPHhTMxWPUB90rIEpcevr0hUWrU37oC7li/e+I0Xi1MvMy43keNy36zeW2JTJ+X/1wMv
         skmkD+LA555N1oOfWNasqygss72HyIrUfzboyc6cYQkeAS/qMqMyT6p8eUyi8TlQbY5K
         YC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809563; x=1761414363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=C3YOjMGLVHdGgFBx2/x48PANfRUCf6KDxJkOABppjodp1DJ/OvZ+JLGLe5Pe7N5iue
         v7QVMX/CWKnw7IXSt06BADffwjCBAfuJ2Y3uonGC1ciPPPQPl9yfPt1+XYmKLX0b+7/m
         qZiIsKCrTFfikpMaHrHDgbqLKY2+gLRBKaRwfa4ccTso/8r0mRuUio/JUrki4XsB5nRd
         AIh6UYxxgPuSThnJihzV3vPYcCSvdOk+R0+WM74g2g7NilTkgYQsI8uNVmWzh4TBVrV/
         SKdpxcZs5zMaj0N0X8cTzrepMMwFgtW48saCfI2MRHczlbObfeqmayjfh8CcxHCzAC1E
         fBaA==
X-Forwarded-Encrypted: i=1; AJvYcCVUPjdLAnI/JYi1rE4Mgtdvq+VbeaVeprkAQoCyuy88/fvW2KvIb7zPTIOEciDk5dDM717y7WPmE2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPp0RCgo6tpJ7irugT5DwkmlizOT2oUikO2utvH3oJs/FtV9f
	STMLwXbK5VtP4oen1ZV/mi4VZbSSFEIrt7+nQoujnMS/yx1ajYUV3yYA
X-Gm-Gg: ASbGncu/pJHnKZts8+j1jW3cngfFTVXT7iFLahiVb77W4nmaNmXoBdBaLeWDfNpiZqH
	DFv/+T8pKfQDkp7yklczGUEycum+BIyzHpsly1/ZE9kXGPKxBnT1LnqwA4kgBk8Ratz0kPOY1d1
	LZIT7EGmt8pSg3IR+drXB7pb1maCPcTXWFUuIdwu+qJ7mQzd5zqAQi8OMATgPj5Od4HE5PA7dLL
	ZfokJl05xTbzqejnssyaOKmqdVY+bdSXmIT+79yhTLNW7S1p+ByTC0aM7JlsWvdW96Y4Glawelc
	D/xXULR/2W4zILmBNxQMY7JdcGdoNWZC8xloDU34fh6sUDhYO6CveHzIBWmJADp1vwhiRdFL/FZ
	w48j3AruZIv6/XRqIe4luIKw6dHqo0LYpgp0wwQ6nnrVhUeXXbY+S5jPwe4/hmT2LpXk4PJN7Nw
	haCb1XReu+6gXW83HtgA86+6xkbu0EAP/Tgy1LA8fpEs3bxKS9yw0pnLKAA0RYVwF6H33p7y0Db
	VnRwvw3bgGEKGusNcNwrE7flgaseEhhUwg0eHrgjEXFjon4LN2EX+JfWaYtxi2Y3UE9fHPRGg==
X-Google-Smtp-Source: AGHT+IGG7z7f3MNU21/Rti4PmtrZca4GFxKfblibRIkboUBwmpGvzYHP42u9XCSh6vTqFJ+cvotYfQ==
X-Received: by 2002:ac8:5910:0:b0:4e8:9596:ee77 with SMTP id d75a77b69052e-4e89d1eca83mr102709391cf.10.1760809563421;
        Sat, 18 Oct 2025 10:46:03 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:20 -0400
Subject: [PATCH v18 09/16] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-9-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=668;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGXXqQt9RHGxpoBFZLlXeLUPAugoqd/q2N96Ig7iFhgm9rnqX6mshM+HDXmtIVBN7F9GI6CbJIb
 k7xYI3LBrrwQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/ptr.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 2e5e2a090480..e3893ed04049 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -2,7 +2,6 @@
 
 //! Types and functions to work with pointers and addresses.
 
-use core::fmt::Debug;
 use core::mem::align_of;
 use core::num::NonZero;
 

-- 
2.51.1


