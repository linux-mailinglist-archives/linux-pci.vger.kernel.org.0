Return-Path: <linux-pci+bounces-27477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C1AB08B2
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D611BC1C2E
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082823F43C;
	Fri,  9 May 2025 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBBOdlwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111E23F41A;
	Fri,  9 May 2025 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760588; cv=none; b=RDkZCc7NxPg8ykaaLqqvUXUi7SzFi198fYN4aYS1pJLCoGNexkIr4MfExnme8b2uobm5UWPadmFujkkTp4jp+p3wOJ/Plpqf1kR3mh55kTk9hzORNK6RfyliYtHF1gLS09m0goR90iWYgNNgykQO9cs4oX6IU5hk4qivDAK3urI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760588; c=relaxed/simple;
	bh=DYZudydKXnRN5JRZIm8QjR3MbAJqJm+P6qotN/BVgq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHaT8CWk/Up8vv3+I4HiTP0I7b2e8Tn6e4t8L7Sr5RmVkZv3WoWIqQ5koqlwdVCwT0Yn9lqee+iHVnVjcjCFKhMjgvYRJnnbNc+hJHiY5pOTQI8CxQD0mES1vskVxhLzQMt+46ArtuB9Oi7KG3Y1JBjEBv8geaIJ0S2Dn7Kemg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBBOdlwO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fea67e64caso1524130b6e.2;
        Thu, 08 May 2025 20:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760586; x=1747365386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53t6htouqo+fEO0HbXs8RHhTtXKEPino5VAfoY4/NnE=;
        b=BBBOdlwOfeF0tHPGPX7hqvEA1MlZaYZyW3vLwH9J75meNmkg8ODFZoZwOUPgL63GaA
         vt59VSrUDQZZZ81vI4Rntj0wQP+SqaMlp/cJHXfhAs6tqfhGOM7QUQKnFD2U/qgXKB6b
         BI1iIUAGMH0Ni3NQNdoP/D/Z/sHrvdgr5lNA2W+jGh4kgikuC+Knu/hsZveLZ0OqXi/9
         85kTB1ims1IB+QSOJZNht4h0aFEbjElccwfLIHLO3EpkMH/7KjX+xNeE2NKlERIG1hsV
         UzSNm/5Y2Ok1fEkj8yJMoJAGyEfuzzOPIrOi0U7Bkmj1WlnVCXpJNSqXanpKKLqwJTfM
         Tlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760586; x=1747365386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53t6htouqo+fEO0HbXs8RHhTtXKEPino5VAfoY4/NnE=;
        b=c8vNsQM6qubX2gbOcpOaFrm6gcJBnuEltMoPcKHzciBUnWfP7qqs+VufOBFc7eCBnF
         bI603HhBbVlvEJJ+iBNQaZ8kOOsJEWIzB0jg6lUgBKOgL+Y4JnwCh2iOiqGQTgONEeoI
         mQRc/tG6uUmq50z1n7OcSXn8gagpOoKFF1i1mPrH6z4Ruhr3umRAseYAPPgyTv6H2eTv
         /RUA3+TVraz6riIT3EcZBuQorwx8soNEkHVFyWpq0MS0KAB7MdFxrkTGIeUf7Yjk783l
         ti5WR8O3UKGJU5BI1cSj5N+yPCfn3HF5/fmvND6P9rrfcknBKEOKojBbr/rInLLPpSFO
         jcig==
X-Forwarded-Encrypted: i=1; AJvYcCUOqSUEaFo/mK8sBeGbxq6rP0c9+PUsM0IKLxGCrrzUjdHUhURG3911/onMvKnc26gbUTqtsS/YQHLotLo=@vger.kernel.org, AJvYcCVlDpl7Pl2mZLAGQ3SyRhXiRgrGEeLDZUEEAJPRXJoOceqs3c0DRsfkb+dPiRqFgozPnNtlkM2lYA5WWI14/Fs=@vger.kernel.org, AJvYcCW3srLWstifopWdVlRKa6t83SFBFAvs3TGmmKecstMxFael9PyGTJsakipX6l8WvAYMmaPKNzqSan6R@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGyPQFQq2m5xYwS3W4Gg27R8vWwTNgOoxDZ1LekWomj/6LZSE
	OWerDRsYIptM2y8g8B3zoOpAmG2lgng7K22QUc7Jdt/+kW51OO5n
X-Gm-Gg: ASbGncv8KdZhZsqfmYba9I/eEiGH1n9wuUCfzeH0xGKqR5WTPIMbX87yqX4TXmoLn9G
	qDBiDxNRlBYnjIupZhGE6s6Ogi2e/AuwpL9DxlSeeDXsf1u9YZ4J0QKrI5AQjAUFsi9t+XvkMoY
	elpFXr6nG83QYsePJ0UW14Y/oQBA1dvLJMbEpoXuOaBYi/VANhjFDjXwqSv1jcj1h+euY/JD2x7
	chaHqwZFViNq3LpdjDd9J8bgzmtbEV/nXGGsi+BSyoRO4mpC30uHNvbPVX9SVN4VTZcuaojHQdm
	ATMMNlYYojaGvI7tyswFhBrMMA/sPRHdcz6QePoasqwrcvRHU5UHflt2nxZkXrUVXUqQTS3S4WW
	KW5uwb3I8XreE
X-Google-Smtp-Source: AGHT+IEdBTSTK3vWlnHF6pnRx7cY0OuwERmRYjEJpQ38H7fbUDdpuDNT5RtsGo1/Cw1+llB50+pCyg==
X-Received: by 2002:a05:6808:1718:b0:3fa:3a0:137b with SMTP id 5614622812f47-4037fe9e79fmr1334343b6e.29.1746760585903;
        Thu, 08 May 2025 20:16:25 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:16:25 -0700 (PDT)
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
Subject: [PATCH 03/11] rust: io: implement Debug for IoRaw and add some doctests
Date: Thu,  8 May 2025 22:15:16 -0500
Message-ID: <20250509031524.2604087-4-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509031524.2604087-1-andrewjballance@gmail.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fiona Behrens <me@kloenk.dev>

Implement `Debug` for `kernel::io::IoRaw` which also outputs the const
generic SIZE as a field.

Add some doctests to `IoRaw::new` and `MMIo::from_raw(_ref)`.

Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/io.rs | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 19bbf802027c..09440dd3e73b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -227,6 +227,33 @@ pub struct IoRaw<const SIZE: usize = 0> {
 
 impl<const SIZE: usize> IoRaw<SIZE> {
     /// Returns a new `IoRaw` instance on success, an error otherwise.
+    ///
+    /// # Examples
+    ///
+    /// Const generic size 0, only allowing runtime checks:
+    /// ```
+    /// use kernel::io::IoRaw;
+    ///
+    /// let raw: IoRaw<0> = IoRaw::new(0xDEADBEEFC0DE, 8).unwrap();
+    /// # assert_eq!(raw.addr(), 0xDEADBEEFC0DE);
+    /// # assert_eq!(raw.maxsize(), 8);
+    /// ```
+    ///
+    /// Const generic size equals maxsize:
+    /// ```
+    /// use kernel::io::IoRaw;
+    ///
+    /// let raw: IoRaw<8> = IoRaw::new(0xDEADBEEFC0DE, 8).unwrap();
+    /// # assert_eq!(raw.addr(), 0xDEADBEEFC0DE);
+    /// # assert_eq!(raw.maxsize(), 8);
+    /// ```
+    ///
+    /// Const generic size bigger then maxsize:
+    /// ```
+    /// use kernel::io::IoRaw;
+    ///
+    /// IoRaw::<16>::new(0xDEADBEEFC0DE, 8).unwrap_err();
+    /// ```
     pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
         if maxsize < SIZE {
             return Err(EINVAL);
@@ -248,6 +275,16 @@ pub fn maxsize(&self) -> usize {
     }
 }
 
+impl<const SIZE: usize> core::fmt::Debug for IoRaw<SIZE> {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        f.debug_struct("IoRaw")
+            .field("SIZE", &SIZE)
+            .field("addr", &self.addr)
+            .field("maxsize", &self.maxsize)
+            .finish()
+    }
+}
+
 /// IO-mapped memory, starting at the base address [`addr`] and spanning [`maxsize`] bytes.
 ///
 /// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
@@ -264,6 +301,7 @@ pub fn maxsize(&self) -> usize {
 /// [`maxsize`]: IoAccess::maxsize
 /// [`read`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
 /// [`write`]: https://docs.kernel.org/driver-api/device-io.html#differences-between-i-o-access-functions
+#[derive(Debug)]
 #[repr(transparent)]
 pub struct MMIo<const SIZE: usize = 0>(IoRaw<SIZE>);
 
@@ -274,6 +312,18 @@ impl<const SIZE: usize> MMIo<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of
     /// size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, MMIo, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let mmio: MMIo<2> = unsafe { MMIo::from_raw(raw) };
+    /// # assert_eq!(0xDEADBEEFC0DE, mmio.addr());
+    /// # assert_eq!(2, mmio.maxsize());
+    /// ```
     #[inline]
     pub unsafe fn from_raw(raw: IoRaw<SIZE>) -> Self {
         Self(raw)
@@ -286,6 +336,18 @@ pub unsafe fn from_raw(raw: IoRaw<SIZE>) -> Self {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of
     /// size `maxsize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::io::{IoRaw, MMIo, IoAccess};
+    ///
+    /// let raw = IoRaw::<2>::new(0xDEADBEEFC0DE, 2).unwrap();
+    /// // SAFETY: test, value is not actually written to.
+    /// let mmio: &MMIo<2> = unsafe { MMIo::from_raw_ref(&raw) };
+    /// # assert_eq!(raw.addr(), mmio.addr());
+    /// # assert_eq!(raw.maxsize(), mmio.maxsize());
+    /// ```
     #[inline]
     pub unsafe fn from_raw_ref(raw: &IoRaw<SIZE>) -> &Self {
         // SAFETY: `MMIo` is a transparent wrapper around `IoRaw`.
-- 
2.49.0


