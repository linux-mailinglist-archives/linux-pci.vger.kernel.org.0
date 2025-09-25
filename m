Return-Path: <linux-pci+bounces-36978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D42B9FD0F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C94383B3A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122E2FE05F;
	Thu, 25 Sep 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHFNSybA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E02FD1AC
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808570; cv=none; b=ex1as4j8t8OVubaU9lFUZ9zKUTutRNl5liAin1HIBHWXSzDrfzbt12J9a2fjVZNjoVTCu3pIeCSLdu/MyI4z8oNIyXobsOQK7e6qP8imBxMMD/VKVIMHWI1sJKlclqyiqESQUhqXazoHgYkZcHRVCQPsCeNcpGRi3aUFtJv9dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808570; c=relaxed/simple;
	bh=cd10vY+LdNFm15kjf9buohLVZDsgfigdMJZaOhvjUZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dA5ZhYG6/FLhaGcrzFAtG26aYFQ2TPWMKYUd3FJa3P6x1j1vMoNBflUUA/RL//bzLQ+YchtrB9ab6VxAvibbozL0L0nKCiOCKDLFhyUCp90x3M6DY0K3KfiotJT1uSzuR3uagSrnNXoOyNJiqMWoNSuj/IpitYfpOeTBXlGDFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHFNSybA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78eba712e89so7111066d6.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808568; x=1759413368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq31dC2vDN2a94utvC/B02Ptv/MXvCOxOItQtZFE3ic=;
        b=kHFNSybAgLMmKvNMEsbdEliOxzUGNfq9vagPqAa/2P2ouxseJFVuYbQskZ+4fD8YM9
         9NIt3mmdbJMC+i3qWvQ08fGJ8MT9hIqSisd4lnXj5EEj6rC0nyJF4/rRHWEqGVdMJ5TL
         gEoIayc33yVrGOkqeZtXbi0WrcUmsIFnAkJ5nPhsZg4FZWVokLo9MqKqI85+ltSjprJy
         5PQRU4ClR3AHlJGgrE4p1TO/3VoLha0O/Nxi6ls+OYPcDCcsvgCCn9ibTvMFoc3nz5wB
         YfKsEWSRaFBxKQW9z03Jvmyf/Nx9L7D2xx/tZWHSPqvJNdBIGECg11eC0myYQxueOI66
         jyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808568; x=1759413368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq31dC2vDN2a94utvC/B02Ptv/MXvCOxOItQtZFE3ic=;
        b=uf62kZNvp+W5+VCOq7VBeyExQVPGyS2fpMAE/gWbyMs9PjPKBYEfQLlmRqssXON+ID
         AJLoC7EgDepgNua1mmUAwCSvEjHc6vKtkVUZBg8Zt5VME/7W5ZNhqizCF90VivWjvzmm
         78IcdHmf+jBrHKSHsCj5aiM3dTbSCb6Kp23quIwE+sSS3Qrk3jxsnTGfE3bl4O4j6Yz8
         AmsEgMeygeQqIz+ueaq94dHVpwLnScMWyraIzdsIPHJuo1DfN/G6kAbq4B96GDfNvXUY
         aXuL3irKBbHfg1cSmQZY7oNmQ6ec9SJ9MGdpK3ljWVYncYlJLSef2zDw6aPowbkydD90
         b7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWTeq1Kj5t3KeY0gHVx4WX8afO5ZOivnwtR5l2PvY8Fhj6rnyd+bdM2TtjM0xmxAV8Cr6h0CF4HNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuwNfaHEtVrU2a2P4IJL3Nr8L7ThBUGyLO1wa79FYdnNqpAW/
	V2YzAg3yDQsWvv13lN27gtu3Al7Zwtd3HyeQ4rDg2mbnaiTK7OyJngDk
X-Gm-Gg: ASbGncuQqTz7RPmE6myp+8kAXcfjl2eLv2XN9keGtnFSEz4JIl4YrNtoF9RQQZxPIPb
	Hwf66FkgjLpmd8Yi1dHkH7HetcqQODikm/BhW1CJ52QGQixTXDcGd8PbhI93n12k1ld6VUIYkXc
	qLUZHsrbV61Gdk8hOGCiOnnYaEtlTNVawYbd8HqKzf/2/MxfMDADi9Noq8v6jiyjWcOQRsLbFSh
	vUOKSivEHG1VjqrAvDjksnlEo0JS5fUhvM26J+WOUge+xIbLoKABElcTPwYAfJ4JJFfBXPAa4Hq
	JGM/naLQDY5yNBWyRhG9bo8DCMNvwbHLAylLZBtkwus0lMjJkGQwNwOCj1ZoFYmw6oP9B7TOCww
	PKq5tK7EtVMxFxjCRs0Vj/Nda9WZr/zEgTSAwmdqazWAVwngVLdZ9bcQm+AIxoD+42t8dioN5fu
	85y140kAz5YBVqi998Fd6p+jakU5CoHBKI50iZeN0gVTPOj3W7MGZ7NTDOzj/ctP/Wm3UyLv2ir
	MD6m2E=
X-Google-Smtp-Source: AGHT+IEZhM30AGXNdbFILEQiyz/kr05nZm4O0BE8w754iMuzz8n1eM1enRH3Kra7C8BiuYUbQtPrdA==
X-Received: by 2002:a05:6214:3014:b0:80e:4f6d:23be with SMTP id 6a1803df08f44-80e4f6d25a9mr15832686d6.62.1758808567133;
        Thu, 25 Sep 2025 06:56:07 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:56:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:06 -0400
Subject: [PATCH v2 18/19] rust: io: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1724;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=cd10vY+LdNFm15kjf9buohLVZDsgfigdMJZaOhvjUZ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNf162nJINfyau54ApOtSNUKBNqSEvAN/RUj/VaS1rCjXvJ9mtYy/yqZWgJQlP/HSnYEPjCYYdQ
 IPwDjgyMc4w4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/io/mem.rs | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 6f99510bfc3a..2e42eb906061 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -4,7 +4,6 @@
 
 use core::ops::Deref;
 
-use crate::c_str;
 use crate::device::Bound;
 use crate::device::Device;
 use crate::devres::Devres;
@@ -44,7 +43,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     /// illustration purposes.
     ///
     /// ```no_run
-    /// use kernel::{bindings, c_str, platform, of, device::Core};
+    /// use kernel::{bindings, platform, of, device::Core};
     /// struct SampleDriver;
     ///
     /// impl platform::Driver for SampleDriver {
@@ -102,7 +101,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     /// illustration purposes.
     ///
     /// ```no_run
-    /// use kernel::{bindings, c_str, platform, of, device::Core};
+    /// use kernel::{bindings, platform, of, device::Core};
     /// struct SampleDriver;
     ///
     /// impl platform::Driver for SampleDriver {
@@ -164,7 +163,7 @@ impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
     fn ioremap(resource: &Resource) -> Result<Self> {
         let start = resource.start();
         let size = resource.size();
-        let name = resource.name().unwrap_or(c_str!(""));
+        let name = resource.name().unwrap_or_default();
 
         let region = resource
             .request_region(

-- 
2.51.0


