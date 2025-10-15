Return-Path: <linux-pci+bounces-38260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCBBE05E4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67DC9502FDC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE130F52A;
	Wed, 15 Oct 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA0e42Ho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61030E84B
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556311; cv=none; b=J+RUeeglRmFdlHQlcagA08LHN/7DdhSH7JQAWka0eJ9ddjZxE9GiYgghINu2crmBD4rRgqzK1N3698qwvCqS0VRa83NSfnT9H2vtLhgIZZ8Rg2RBb2hCkmTaUIsgcfgs/R3bDbCPD83gS3u8fc5ez8SuuQnh9Xu7GeOXwyOBVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556311; c=relaxed/simple;
	bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibYATYy4WbJ+ASe8PDqodU4TIvxD3+4N10nFRSdq5kqofBT7Uhv3p4uFQdkkCFs6jgOjwz3VmIn44xdyaONtu4Pi+sIZ/wWSHOskHF+i+j9vvrBYqcCFxfyl9a+yEi8PDb2dOJf20QgV2UV2FWlizPWOsPxAitYD1SkUvqUompY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA0e42Ho; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-863fa984ef5so1186271085a.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556308; x=1761161108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=cA0e42HoUfvW3gVGL6iILHQaTVyX/2HEor6DEKhjyaVcB7FRSv5qHA29OksEfPZqjS
         t7wxBGLxx8ApRZpqC5v1ILhA8EUiN84/+tYTfRCIyIPr8IfGo/63h5x2P/edOFmMYS8/
         DOOP49a1itunEXOlj78PLdKB2Gph4vdk9gmT2h3J5xmtwC9ga6OrGRNf/VCZeMf4rUtV
         lBO1IpexRrtiZLemfbk+Vods/Cq+LpvJFTJtIGTPVuONUhXgCq5pucfQ9ZBqjHklOUBL
         j9pbyGLmAVVWDd7lMM20z18ms32goqE2sMBByxyyuNXPuTGpygfAx0M2mgM9fH5JDkm2
         xCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556308; x=1761161108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=itma3E1SZpupMN+lYsfX79JXvzx2t0r7bmljTM2oeKy20KpURhhgCv9GWvEl9imvf0
         mACafsihplaBqX2G5PMNm/q8DNnhjCmX2TRzy9n9bUmYdkXuWL0AvppZZ6dPjF1OtMWr
         bwhSJJ9OyJmxfiyL/vco9JXJag97P1DvRzkAz2DvM9VtUqspsFk01N5ZEowRdZRfBt10
         jb/0+Q+JbTJ7a7RSEQe3akpN2yekqlxWYviVPrt10dvwVfVfDwqkni7i6RVnjQ6jOIrq
         Om+4ptMB7wowsW9nVFIhfviaQt75+7sfRRjjVRdJQ+8S0w5o/ds74G+SfbZ+/PxiYAd/
         Py+A==
X-Forwarded-Encrypted: i=1; AJvYcCWpY73xFKg5a4w2DGDCAovOm0l9vM3cW272sqcN6TABZpO1RJfOHFbVZY19zTJa4dMMoyeVfIf3XLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOBXSmKM9YG58b4NnwWnGM5ZwgLg771KD9m6YHHsHV/CFe/p9
	avMe93Kt+Sng0AuLsb7x54zF88E+9Ts0W5Zafvnvr3Zp1Zyec2TkNw4G
X-Gm-Gg: ASbGncve5M/3m7n7u6wyoNPOC0n6DX1WaztRz2WpornVwzAIT1Ge7ng2db/1ki4TK03
	dyOWvKr2+8l+8G+lWU4aKS2aqDYLZM71DSNS6KRJZPUBbxBHIkxjPjHmsvX9J/iHoBb3hQM73tm
	/QVG7e0OzpFUrYZb0LWwDDoRJzPkMaA+CRIpmhB0JE3f8hYlhEaaDpQ71tlkO/E7RjISWyvQ5dj
	K+FNdYG8/EGC6X/2Uvsy4fLeVxix7I68r0awByUgyagT0OKcjDS11DEitwTBwY3/SvR1BmYHzKs
	dBXv7Z6mYgs8mdM2LOjO5oY0yt57UTGvvz+incu2jPBUUYk7Lw1feqHq1F6xOxlly9Uix4zFS80
	fQZctefcKeaqcQ2NnOLT+1a5d+0RYBe9myjHcBzMnei8bHV9XRxxBV/e8jBgs6eptrnt0/knSez
	hEfAC6pGe/OYwffX6POxzZRzgj5j8l6qssv+9a1ghpYUkCEHMmDa6WveV1REFaoz/Uo1ulrm2RW
	vozMonGM6u88CEdTLLMfQpKM1b7
X-Google-Smtp-Source: AGHT+IF/CUBVvLt2dkQCDA5YZrHOn4tHGJzgB3mXHJTBxXrUXPaXJyBN4wC5HBKmPT8DqAH/ADgWzg==
X-Received: by 2002:ac8:7f8f:0:b0:4db:aeb0:b624 with SMTP id d75a77b69052e-4e6eaceb3e7mr380441741cf.30.1760556307886;
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:34 -0400
Subject: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1790;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLuOpLGTfFQjBZXdio1nayh5dtiHoR1n54dLy3fgkauJkhueXEntNbGxy1JTge4mrx8nVKiNy+z
 1vw2Aya3HWws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/stats.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
index a83ec111d2cb..10c43679d5c3 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -72,7 +72,7 @@ pub(super) fn command_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_command_strings` is always safe.
         let c_str_ptr = unsafe { binder_command_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }
@@ -81,7 +81,7 @@ pub(super) fn return_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_return_strings` is always safe.
         let c_str_ptr = unsafe { binder_return_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }

-- 
2.51.0


