Return-Path: <linux-pci+bounces-36968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED1B9FBE7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7141C239A2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312E2C1591;
	Thu, 25 Sep 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxkifYJo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A63288527
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808509; cv=none; b=cN2F8QLDQTs+9088adIWHj1ASw5VH5L/JtRfu6pRBdK/mAjaOAseFBtfUoafYAFORKbmeUVvcBBLcCqKWKwFb16QTZJQaSR/H9ezPTJSmFwwXqM7Nab8nhj+5jDO4ULTjxsChf0cL0TG4nqQwUQ8nUfJeRgmi+p4Ews8ckYbAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808509; c=relaxed/simple;
	bh=bPZeninN2/V/7zw/PYEF64yfGflgZsOfq0JcAWxkVI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaOKWV9xK8MxprerRGZmmbkREPYVX1UKzBHQlp3loE2iXVQTg7FDqyrzayWSi9AhJqiUbs/d9fvlOx13z6lJuvYlicxicNf8CVf7ywX4MSb4NoOe+gvwd2RDb4f3uJIrVIcS3c+wDMRYF7uYpHcGXeQ27VDDenrhCnkDvTq+iGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxkifYJo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-84d8e2587d6so68342085a.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808506; x=1759413306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqTcvT5yONUFeYmOIO5vRSTnodd8gLQVUhuVrtBW+JA=;
        b=jxkifYJo+Hqlth5IMZ0ckwB+jZMkZSY7/ck3+l/fKdQym9jDfHP4sSFZKL3pvqeRVy
         awcwEqkjMfFXU73o/Z4iiE24UnZLQWUIkspE+yT8bPfOvHAT4moOiRhPbvEC/AB4nv3+
         EkhWXjtyngWTJ8QdHxqg4fDZzCFPidm3Aum92Jd9Vl9dByKlV6FevWiCifjohsT6U81i
         c8v/gkBBw7YKw8IWCXxoYydPQNCQQd3kNwhRUGjjctRRCCAnL8UOkk+xpAn7yGE2Z6XN
         /yBnCbL7jM488cln8R6ffaHIvIU+50M2t+2diyUEf2h4HgfnryJKe2cSWwitVa5HYY8M
         AF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808506; x=1759413306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqTcvT5yONUFeYmOIO5vRSTnodd8gLQVUhuVrtBW+JA=;
        b=lx+xUSnt2Bymyg3fVWEYOfVg1Qz8Tli5530eWqDkHTfsHFfB4JmnlkSm/KbpuQL3FT
         QdyMx5ZHYZ5TKiEMrJUJKsyHXfUO7zkfXfqDm3QsSx79b/gKD1vP5yZ6GOprKVS4FtQw
         C6bb1vauQW59P0Zo0xe3jShGMDsemHL5Qb4S/o1PknSByj/erkDQLMu+WB7Lu5d6wZ4v
         /D7wqKg/xUfmIQqI4juXP61fqPCL2L/EUo3a57aJHq11yqRhRk8cap7pgrbVtvvZhIV2
         wJzk5Zrofo4QGqHSFIb4ZzO0e/YQQLK/wxRCJref2mCCtmJBwemNO13ehulDknkyM26G
         WgAw==
X-Forwarded-Encrypted: i=1; AJvYcCXhYEJfwZOCSPiI56l+VeUdUJgGIBwjL/hE1BcVYrn3VGOBX6kTMvVIFRjVdQaQEB+hgp4lrQcO5nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbg/NxopIv3YbqWGUY3Z13JfrZ0DWWt/wApGd+u0PyB8HhbD+F
	LVqHCZ5OwT94mrbKwgQYVHjaR4MDz69Y899dRSZKAm6lV9WkxdvqAsb1
X-Gm-Gg: ASbGncsmuqDrzQpjTwHNfr7dc4DQHVMz8ENOBvif9gz6Zg25D5TVKF0eXaF4BL5XO5O
	PhoGT7byT1KJjpILn4KZB67Mjww8TbNdp2qC7NrsdeYn3jBMcEGekYxwuz6RfRqn/Mc8R4pNqez
	gOTjPXZt5Zzy32AYHbrMoMGrCQPapsd25874rRVX4N+eoeY1pbFfI4/p0CTp+gME2yIylmznQfn
	uGijo2Wqu5lop7T9XnBK6If04ZMets3DOnUHzd7G13neGECpx2voUVSNWKi69QSpTIfgGoqUGEN
	Sf11uaGkABmGyfTTMGaA/t6y3Q/plHbB4sAVue8PmAaZF/v7VdiFC6i0pGCXbx+l62BukO6skhx
	u0KNaLpC5lAX+mui0zBwfWLADE+nrHIAtda991sLsCucnucFvlM2hYALz67KycndvyXjB+cd1Al
	5k+Mk38EPq4TBpB4RlFY2+xyE8yxKPIPwA3dqU9mGuMSeuImf2CQw5EMGdRBW8mgMbLWDB
X-Google-Smtp-Source: AGHT+IG6EzTyEA3INGOgld+kkM2E6bSTO6bhB+H8gEAN47wRnZax/H9RzJp1nvFdm1VelrmNbN2bBg==
X-Received: by 2002:a05:6214:765:b0:809:5095:4144 with SMTP id 6a1803df08f44-80950954186mr19841926d6.67.1758808505713;
        Thu, 25 Sep 2025 06:55:05 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:56 -0400
Subject: [PATCH v2 08/19] rust: firmware: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-8-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1629;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=bPZeninN2/V/7zw/PYEF64yfGflgZsOfq0JcAWxkVI0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD4rak/xDK1Yk5v1duIKSYGyXctY6/oZ8jehaiqaTOxIbpGhy5zl8Kext0tE9Jsy8CWrpsliDV5
 3U5gCpsnnhAA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 376e7e77453f..71168d8004e2 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -51,13 +51,13 @@ fn request_nowarn() -> Self {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{c_str, device::Device, firmware::Firmware};
+/// # use kernel::{device::Device, firmware::Firmware};
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
 /// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
-/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
+/// let fw = Firmware::request(c"path/to/firmware.bin", &dev)?;
 /// let blob = fw.data();
 ///
 /// # Ok(())
@@ -204,7 +204,7 @@ macro_rules! module_firmware {
     ($($builder:tt)*) => {
         const _: () = {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
-                $crate::c_str!("")
+                c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
             };

-- 
2.51.0


