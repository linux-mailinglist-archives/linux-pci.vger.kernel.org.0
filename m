Return-Path: <linux-pci+bounces-38590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF264BED471
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927963B9C04
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45098258CE7;
	Sat, 18 Oct 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2W1IKbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943624886E
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807392; cv=none; b=C94LjfPUKl+lzdO5wSP71utR2Z3fPO5v2U9oL+JOLnjtQ6EvtEmseo8AgX9/0urvFuj1wmqs0VQ3kshWnqQfM++GNLRVahi/hx6SZDeNBlwvk/Fr806Pv+CsH744NyM4/2bNiA/0Z9rCOViiMbygsdj7C5s/F8SndpiwHzT1Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807392; c=relaxed/simple;
	bh=odtCe9zBLcd2KigvnEagfj6Hjlz+S098qgy/zAjyk5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s4ErysFyxbiXpoGhrKq2D35vOObI5hhsWyC03ly7PWygNJBU9+tKMmudZidAHTc1JZ7PTOeo7xGt4bUGTR+HrR/RJOo06AQejGtwSVd4kC4bZVPbk1QFBjCqF5SE2ticAPt4O4KTQgEjPEwvT9XQWn9C2QPHwy9L/8fTHNAR79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2W1IKbe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so11248885e9.3
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760807387; x=1761412187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gbgmXbo5t+1RIxOlN8V1tPuxrDnGp84UG4kpKP+4AI=;
        b=s2W1IKbeLEuX2kkxo9AybDWEDEm5rqNnkDaV/DCZDcr0M6r+aOVdhus7bB83epvYuf
         CfQos9YRn9xfGKMVJ3dtLfPW/AyRT3U/NAkz+FEHIwuEgELPVWAAqLoHTxd6i0Ay+Frg
         64BU/nqpOZAiTu4YijG6Wt3rsAnk5/+v55pEJ+icNmkTX6g2MHda3cZmgfXYt+0wQt5s
         JMMWH7elqV35qJZZmILPEgos39P2n/nEHhzD+SDeEwR7m0dE/0522ChttpOlSoXdgslt
         45Uj42+Eto2H85xG5oSev9Es3P4neIyc/0LilICNFNdkpU3y+ZFQ0moED2mm8mqZn4v2
         Tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807387; x=1761412187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gbgmXbo5t+1RIxOlN8V1tPuxrDnGp84UG4kpKP+4AI=;
        b=rYRS8+W+TfyZ3pTzxBvur9z+AhAmnGd2Bkva1UhqLvV867rljMRW+aTnvePVZ7Vtbg
         7BZ8UwUZEZr6zkWq1pkMNvb8xOQ2ieutwgsL20T7MchyQNJzuIXzUhKTQ/3nu2Yhp60e
         iTeYSUP0u9RPVP/MCRmmEMocp5/Ey5iXezg//0jb8vwQWJO8/YNwR2dbwJJb3mdvTRHO
         LTcHlQzYTU+ift7+W59GFtcTR6BjsA7Xthi5h1ZCGLN9IZ3zVKOZE6OzkFjEybfKDhy5
         tzqdEmQhb7XZ8YlzuRjX+rHjJPkf82QTEmsX2HbAMWaYArG5cyutCtHdvBI0XqadcJmM
         /15w==
X-Forwarded-Encrypted: i=1; AJvYcCXBcEhV3fINpYIiub+/KKGfMWlBqBcwFZOhaTA/hQowglJm2NQEFfk9NZ3PCxHGl5cM63+01ByuCQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/04HBYr95su2MPkpP7HuhUSRSFy+EM6/yL6cihZfOQlmlGnKL
	wnPGVpieALchBWNj6Swgw7j5w+jcsWlrxtx08Zifk8o0e/IqN8aXFIapu2dnhQC+XdbFaNsWlDS
	em0SFMA2zqYawI8Maeg==
X-Google-Smtp-Source: AGHT+IE2qIYxI4Vw1+ECgA1gn5ogbwuagPgH2cctNTftSEDiGSn1/+RvZtZON2v3lqv5N/Nfcs1I9R9CXWA7rAA=
X-Received: from wmwg2.prod.google.com ([2002:a05:600d:8242:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3512:b0:471:12c2:201f with SMTP id 5b1f17b1804b1-471179134f0mr67710035e9.32.1760807387121;
 Sat, 18 Oct 2025 10:09:47 -0700 (PDT)
Date: Sat, 18 Oct 2025 17:09:46 +0000
In-Reply-To: <aPPIL6dl8aYHZr8B@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <aPPIL6dl8aYHZr8B@google.com>
Message-ID: <aPPJ2qDhxXNh8360@google.com>
Subject: Re: [PATCH v17 00/11] rust: replace kernel::str::CStr w/ core::ffi::CStr
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Oct 18, 2025 at 05:02:39PM +0000, Alice Ryhl wrote:
> On Wed, Oct 15, 2025 at 03:24:30PM -0400, Tamir Duberstein wrote:
> > This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> > have omitted Co-authored tags, as the end result is quite different.
> > 
> > This series is intended to be taken through rust-next. The final patch
> > in the series requires some other subsystems' `Acked-by`s:
> > - drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
> >   look?
> > - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> > - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
> > - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> > - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
> > 
> > Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> > 
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> 
> You need a few more changes:

One more:

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 69efbdb4c85a..5489961a62ca 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -156,7 +156,7 @@ macro_rules! declare_drm_ioctls {
                         Some($cmd)
                     },
                     flags: $flags,
-                    name: $crate::c_str!(::core::stringify!($cmd)).as_char_ptr(),
+                    name: $crate::str::as_char_ptr_in_const_context($crate::c_str!(::core::stringify!($cmd))),
                 }
             ),*];
             ioctls

