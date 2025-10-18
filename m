Return-Path: <linux-pci+bounces-38598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F43BED682
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 19:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71265621C79
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A712773CB;
	Sat, 18 Oct 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw7kVOzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E404263F44
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809553; cv=none; b=fOsexrbHX3SQzwAN4KOJV0DDpdFqqpWY5C6U8j37GHasmTPwgAJWwFRip0sdZSvknxI8AMwVMJTj2+wnkML1NuUMSZt/MfFgXCC5JyqIct6SquulSN8N83LeMiqsdcExyVx91Rv6Bf5tKOMbw0bRRcu8cUTahTh1J+IlSYfko/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809553; c=relaxed/simple;
	bh=/cgHz1cX/7pqPCiwokdGYY23t2YMKDX7WgaCRbImZEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFGYwupkdRd9ZjiaUFpXr0dqqzHkrjMTkDrpFuY3PK3eSkRB8l0YRgwEIoXDNKBYcsTO9o8eQNElfOtW0wMVQfn5dVUKli83+HBPAPrN5F/jiPr5CPzS3qGfbk8kWPsnyWCLCCSAEIxnWVFTMzE8NVDrAlYjKtxYRPI6SHReSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw7kVOzU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-85d02580a07so480398785a.0
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809550; x=1761414350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6x4i2Nx/KcrVad3Kw/MMDkaM+hSW8mJw3uIz+XsVU4=;
        b=aw7kVOzUSupMQBgDrjBE7QuJ7LuSFqr+NhJsKQ7LCquYg/kvtDTTFLRs6nBILlaamN
         inkYr+EVR6qY1CAyYVXZm1jjA6ScXcauQxnBH8OXODNmN1vpZuaMmYS86NmfrRk44JYJ
         hyFNp35WF4ZNz8i6w5zk8QSXWQXAHs4Vk33n8AuuADWpCxny7VMEskeb5PaVP4qz610q
         5Z68eeMf8WA7r+swC/7wvBICNrkN1mlH5Jpo9CuvGZ/pdlxfj5hFxUurO0EH1FSgjTzx
         zuCZ5epmWqGbRlk0lex1rsXOnLOFy9tHJwphVJIRJl3lMhNhBzwrfyMSZPRhVyCDCO45
         TTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809550; x=1761414350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6x4i2Nx/KcrVad3Kw/MMDkaM+hSW8mJw3uIz+XsVU4=;
        b=uizGiSh8G+gRpQ0QrDOA5CdYw/Y795H5iyv0WoaDUyrrATgbPfgC0iD71GJTAlXwVb
         KfPRQPewl2l5/gEZextMWSGXwq0RWvRV92c9wXSc8VX0vuaiTT6SiyfJUWW6SjhGIh+X
         hh/A0Z+MdkP5KRVQYBuenM6laAhjajWFoior4XpqwtJam/J20EsLLo0VH/y63FiSURAe
         Gq5Rw6t5Ykn91ZHRwP5vuISWKGRRGq7IBOkhsUHj+/5KwXVAujotNfclaw/0cpUaQNDi
         oMP57G5iewk3ToPju2RJ77EFz0WgDAFo2jOepg7TMFovxpWEO6tDsXnHbT2GM7mpvVbj
         lrIw==
X-Forwarded-Encrypted: i=1; AJvYcCXGKmjv9qNxIaJpM1IdOmZGDz/aQZE8zoNjiBs05XROo1lbaYdIEoEzoyLct5Fm+sXy7opCVfkv3uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sla6NS3uTVMIHM1tk5sdQNUQ33+qeI+H8GDBdL9/gky9E+hf
	4cqW/Ng1cSAP+Fl/O6dCmXUPT/eO9bXRV2SFOceaVL9fDV586/Skk1QJ
X-Gm-Gg: ASbGncu8HRH4IMRsnswYYHnGOtsqgY1nUzUPxFKXAahpJkMJlQo8iF/w0hyqT2+SiOA
	Hd8NW/9AkIqq1HNy3DSKA/HCv/M/M91sRXJTO9Nf0k+xjyxwrus6AUxV87C/O8GEn4u+k2z2GLt
	Yi247VRgQhjXnuoOKCw0chMFcuyzwI0C8RU1VzNMlRq47RPNMMhcO+u8zuvNNmEmlt7ncFHGy/5
	8D9ETH5eKYOunm6XIzYqRA9a3Gtv1d/OIwBDGduw5Sf7bO4A502cLKVXjaugrDQ5xr1QFZ/naKw
	RXHuoImBAO2SRbdFBOmFA3E14at7L3eRTBN/nCFhwDn5uE8nP4COadY3/Lmjlqz3+bT/qIfpeyy
	7BIjoFDvpV9CsaXRPamlXINPcPYPEu6APh8BtU3TFBfd9PreRcNI2YOkN1OLar5m7vU8PEMXCZR
	kijM6MD0QJuSJI8ff2AGfTkX8rhq7Kx6BD4hWbL4J78D6USRjl5dLDm8LCtxY3tYQ45nNlsUiQr
	T/nSBn8PE9//0gg/Lz5Y9c4qpfwTjXUH5SDJw2RkIa+ceh0RAkC
X-Google-Smtp-Source: AGHT+IFp9Vyr6DTgU7wMi5TzpEwlGd9IqV/k5vFAlka/PSHuVo2bkmg6CmRBEzK7leqOE/jg7Hax7Q==
X-Received: by 2002:a05:622a:609:b0:4d1:c31e:1cc8 with SMTP id d75a77b69052e-4e89cf24499mr98131111cf.22.1760809550121;
        Sat, 18 Oct 2025 10:45:50 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:16 -0400
Subject: [PATCH v18 05/16] rnull: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-5-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=1568;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/cgHz1cX/7pqPCiwokdGYY23t2YMKDX7WgaCRbImZEk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFUyC4lRe8XY0+2gwbmqCYLMq7haRexJVvoEh9TOXoK7TJHzmAqN9kHMrHdHUQpbaYKcy+kW0rr
 jQd4qaEURmQ0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit d969d504bc13 ("rnull: enable configuration via
`configfs`") and commit 34585dc649fb ("rnull: add soft-irq completion
support").

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull/configfs.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 8498e9bae6fd..6713a6d92391 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{NullBlkDevice, THIS_MODULE};
-use core::fmt::{Display, Write};
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     c_str,
     configfs::{self, AttributeOperations},
-    configfs_attrs, new_mutex,
+    configfs_attrs,
+    fmt::{self, Write as _},
+    new_mutex,
     page::PAGE_SIZE,
     prelude::*,
     str::{kstrtobool_bytes, CString},
@@ -99,8 +100,8 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
-impl Display for IRQMode {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Display for IRQMode {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self {
             Self::None => f.write_str("0")?,
             Self::Soft => f.write_str("1")?,

-- 
2.51.1


