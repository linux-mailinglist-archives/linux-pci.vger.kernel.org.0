Return-Path: <linux-pci+bounces-38259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC9BE05D8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 21:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD2A501A3C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9380730EF70;
	Wed, 15 Oct 2025 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQvM5R3/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2F30E0EF
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556310; cv=none; b=AlGxtRfLnyoUtF20Gpfy1qdXJKHgdy2WNJKW9m/JR0qaRV+V4WqLVYaTEP+TLN7dpKzNZ3lWeygQh5YkdEpRPhbbPMghaDA7MGGWT6Z6SO3iC9vu41uc81n1KluoNvjgNQ2PhawBSjV//dCP6I6pkazDrmVmzLXFSh7PWEkH7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556310; c=relaxed/simple;
	bh=Qn1W1cp+yTwc3WIdXx1edrK3W/vliJQWYr2kDZAgGBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QS/voY23h3Vv7TmEnzQ7GTodhj6XtA5BbtgmzYvRlNMCRtMdiDtxJ28wb8egfPoH7HP5xmI3YXxOyH63Cq/18XAaIZ2NhVOgdh2hv29W79h96McFOq33qH2fcawyA6PtIEoa84GmayL3dNZlwyUg+AHBQDWs+cMTSTpNMKPTna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQvM5R3/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c0ea50881so5028996d6.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556307; x=1761161107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z0UoCENjvPOzaJ7c22Y9TSWGsGdKl3uaGJR5NzjspE=;
        b=dQvM5R3/bTVeAHIbUhXqCyhCYZcU2V479ToP4Mb6X3gow/0QaV5XGpAwgYWc0SY7u1
         IYhjuFgyGlvae9b4GXv8CiXg0suQgSx2kZebwo4xpH0erARZy2n59Wi6ymlCm0tDOy0E
         FHEYKI5uQbt9WDEsqLKjaH9dH6vGzbHaATSNsXUCkzUfUplquBZNekAEM88lEJontwlH
         iVTxhLG9ogDBPN6jQO3d2fmWzzOC/86D53uLmLHMtC8imgpScq62ximwgdmzobps7DHN
         8Ol9VPg7wWJjldHLmBJmMT/P+OQRBuvNKCpye01ADsqKD0g1HV7dzO4zOyTIDpZJjOup
         Gy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556307; x=1761161107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z0UoCENjvPOzaJ7c22Y9TSWGsGdKl3uaGJR5NzjspE=;
        b=oevSXp3fze7QHVMBbcuI510StGsj65fundkB8ix7rkkqjgipbJTf6P5n/4K1IVNtOU
         3JimPx8+lmsd4dlwfazGNFN0bWFeiKDIgQGPj40ueoarTwRd+vQJRTBsqNMod+YfHJBv
         QGwR2x9TNoMNU/CGFhm2BXov6/SUNg/64HrDk3VoUjrKyfTF8Mfp8yjNa1kOtxYJzAj+
         1hieo5ljDaF5jzWOxV+9DjY6zUPqRAKb8WNhddPzhtpk7pRga2WhT8lnVYrNmn21cZq3
         2wkvpKUW8av1Y65y54iRbWS7iCNmhCUrDRZaMdKEikltAx5DXZSfjanEtnwXh9qsQstC
         13qw==
X-Forwarded-Encrypted: i=1; AJvYcCUwzunKkpwwjwDvAE4JvPo6bTuR62l0ZM7F6RflpMfLas6kjpHVA+bdEkAZdj0H7JV42bfMuulRi3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycRiWN7X5Mez+k4+QZcK5YekasYkIbSBJ88YTAkVa7vkklhit
	pkglItC+GNIf3WHuTi0ZBX8mf3GyOIQVhVHHUgBhlHlmcUS579RzZSaM
X-Gm-Gg: ASbGncuolycUqUFpD8wuuFhlS/YcTU0DbiCnA7sFiSZcKpMVWT2Pfplr5jHxXMiiQr9
	Oa0OTvNkrIMXSBeoXLcCwiICr/CRnI2kDGWht89LmyuN5PLeDxvWDNpt5FVjUNMqulC0Euq7w4V
	Wnghlnm51pxntZf7m6+IGGrS4teTXYbfsYHYS63CU74ehW+Xf6CzZ4fkwttqheCXrVZhwfRMSWY
	jDfK6d4St9QnhZTrAbHjgMSsP7p+J044/+4X+O+kd8bDMsUvQYVauZh9nRmaRPvjsuIt+gImwqG
	T891YuV0WoTzYSyr++lCz7IoY32wUB9lgv/KrDcY/wyklP51dbzUEwaGeaKX9wdRDDgqRiIUqBm
	1poH3vOcAMpCDDJUw2ZVlamPMKFz0ecZwZTU97LHLTjtUBgRrIbb5WZW2k5zdH4iXBEo99HHQBB
	62jcTkVlCNLsGHrysRQVDTFGtc/T+EFr46mUZPKy2Usdm7MKH3taoRBB1K2v68HM1jCzV+2o2QH
	NektZxjVyldl1vpDuQiPBE+Y3gxDYtBcPIkyP/OnA28C9S7xylg7enQRnGS2E/814JH352GzQ==
X-Google-Smtp-Source: AGHT+IG2tULJ6h6PVvWUIOB2ZFPRQKa/V9qgfB8TRjULEb+0DCRZ6eO1hx3aZgOim3FIHrolDm9d/Q==
X-Received: by 2002:a05:6214:27e9:b0:803:3b8e:e9a5 with SMTP id 6a1803df08f44-87b2efc2c78mr410404166d6.36.1760556305773;
        Wed, 15 Oct 2025 12:25:05 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:33 -0400
Subject: [PATCH v17 03/11] rust_binder: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-3-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1147;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Qn1W1cp+yTwc3WIdXx1edrK3W/vliJQWYr2kDZAgGBI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPq4IgijUUTbPqcb/sFKSMvqN+uNEx3DeWVE1av3DAj4osSldGBCYfq78JujAqGy30VkSuPwWuG
 OpXoXaJlyWQ8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/error.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 9921827267d0..b24497cfa292 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -2,6 +2,7 @@
 
 // Copyright (C) 2025 Google LLC.
 
+use kernel::fmt;
 use kernel::prelude::*;
 
 use crate::defs::*;
@@ -76,8 +77,8 @@ fn from(_: kernel::alloc::AllocError) -> Self {
     }
 }
 
-impl core::fmt::Debug for BinderError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BinderError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
                 Some(source) => f

-- 
2.51.0


