Return-Path: <linux-pci+bounces-27485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBEBAB08C7
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E218C985E00
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB523BD0F;
	Fri,  9 May 2025 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzNHKCRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84A2309B6;
	Fri,  9 May 2025 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760634; cv=none; b=j8jJx4R6no2eHAhIdQL/9yOZkDtH3AooHK6/sRtEFGj1haGM6EqZFsUalnNjjJy1Qe+qn9TwIbjp+w+QiUa3cMl+MCAXpIUirI81/6YovdKXWNXpSxkuCgMzjCSAXKqom/7i3eBZCqRCH8bwcrEp/JaYZBvwGZYXQVyBYFjwYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760634; c=relaxed/simple;
	bh=ikNZWA4W/xDZ87MZLhVL5j7JHUo4Urz4+Jrx+gTjdK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gm3QUTuMN5KZ4VzAqEmdsY7vI6/d1KMbHSBj7ARP2lsIA/pezRkDgiyJFo/7PW9m2K4mw48k8n/WhexeXVCd53DaPzn7tHb3YJoVoqpvuW6FG8PVP7wLZv5RL9WZ/7o0Dm3roo4Lc7fC9e5DSK62V9sT9so17iGtL10rhBEZ7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzNHKCRc; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f9832f798aso1415675b6e.2;
        Thu, 08 May 2025 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746760631; x=1747365431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opoK+AzPTNKgO/SAmsMVBjeqSr697aHxwJmC1KlGbRc=;
        b=lzNHKCRc3s0S74Sb3s+w1DCWcKVTS1Mg2t+XGyKiqVOXpKDtfJdnHoomOPMEEfkSRv
         BumMf+mXLGwQUDgsCVoIBlb4+v9xIP96q9dfEP3GbUkvFacGV1PO5GjZv1lZnHPLBtjJ
         ZhQo13D84JFYAvs+113ah3BUrhn6mIez/0c3Urqsk0sWEzXY89w0Lg/LCgYLkxCy7+B4
         RqS4O4CRztn9jZSqKU8woRzz/TGK/n5tEdStAlY+rktCjwSaNROJGV3Ul1KpowLF1LYM
         GatvxYhcBgGO378SE3yQ+BM8wGiDm7iIb18Qj2IiEqtEJkkk4ZWk+T0fXB33pV8tmRdx
         7jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746760631; x=1747365431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opoK+AzPTNKgO/SAmsMVBjeqSr697aHxwJmC1KlGbRc=;
        b=MukAip5Zg9j8BkiCH80M+85km4v9Y/nUMatJK7BKNQzxGrmoG/BIYE4Rthxuia3Itw
         qZZ8+wRZbQjrTkF6OyU6AijJHgdzwpenFPlnFG6/H63oxMioKqZL4lmZBTGPbxyPjUbW
         m46B0334PJAXKhwueXMo6/4tzHFtenO/5dU//tmuoCVTny8ykYe/D6H7LTJyyb4E4QRK
         ZktHgrHHZCKRfOdL2nFNJQeih+RZXUK46HdFbHA0zro+tn4eNpfGeJ7our1IctFlFaUz
         JAL+PlDyhQW1PNtGwo49YjYhIOzOGmqej30WwxTMJn1dsYhumUyGc4jisNqTHiRu3QdL
         TlMg==
X-Forwarded-Encrypted: i=1; AJvYcCUeWINop9v9E7ITQ8Wh9TQDh5Uep76W1hNfV+mtlpb7tNOamYHAXY8hOnuR1TQFHy2GsJeqG99Maa22@vger.kernel.org, AJvYcCWZxuO/4ppLZHMxuZ+21H4Ijjsk+Mae7OYc6pwixQnTkKAARjbpAuk0uPOhII2bVdynTxhH4YGKlK8c/9v/ZPs=@vger.kernel.org, AJvYcCXgfdPY+ZTmlSEx+L8thxoU1aX3es8ButlYUgWdP1LisSkOowN01+eqQOeNT9JHr+MTpbLjkonpr+2irrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkmlD7ESjwDnTpJypJl5grV4006NleXIQU8mMcYxxMFlK5ykb
	11s9EEPEwxxA0gJRSAYqUDETgAhqmNLGTqOTH9I/OJWpa+s3J5s/
X-Gm-Gg: ASbGnctNlxTDVPY5xsjuD0M+tW7KUIzSmpfhmWxUX/7hhb8hPRvmi7Y6IiR6o41h2jA
	aP0kE9KmGvRCGvAwBTQMe4F0mxa7bnrqNkbOhZQcxawN+ej9wOxudsihV7ijJniUE7agV8fL0zS
	nssY6Dl/k/5G2UZomliihUP0yfgEqKQ7P6rlA0kp81sKlbz6CHg+mjLFOnRDSPl7fVKGmnT8Xoa
	P1NPyJaYfLft8QM3dLpnHb/Icw4I0fCn7UlHj4IzNvvRVvO1h22vtcXpHJQSXruV8Qo/PvRVliA
	IjKV8b3pI3rulvH6jFwUlpN8jKNBoAuFafpnuEytYbtcENwZM7Dd8GDBx6b8Cdr6eRpJeZjbkVE
	m0WS4vPyO9UOrH8oygicks3w=
X-Google-Smtp-Source: AGHT+IFr5wDxcxjZ9Q/iUAiLI2ifQ/cRB+9pzvQIRp+QV4tN7rCEAY/Ke6odF2Cy5+AfeYLWPdfhrw==
X-Received: by 2002:a05:6808:1885:b0:401:e7c0:62bd with SMTP id 5614622812f47-4037fe1e47amr1167787b6e.3.1746760631582;
        Thu, 08 May 2025 20:17:11 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-60842b096desm303745eaf.30.2025.05.08.20.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:17:11 -0700 (PDT)
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
Subject: [PATCH 11/11] rust: devres: fix doctest
Date: Thu,  8 May 2025 22:15:24 -0500
Message-ID: <20250509031524.2604087-12-andrewjballance@gmail.com>
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

fix a doc test to use the new Io api.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 rust/kernel/devres.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ddb1ce4a78d9..88d145821ca8 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -45,7 +45,7 @@ struct DevresInner<T> {
 /// # Example
 ///
 /// ```no_run
-/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw, IoAccess}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
@@ -80,7 +80,7 @@ struct DevresInner<T> {
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Io::from_raw_ref(&self.0) }
 ///    }
 /// }
 /// # fn no_run() -> Result<(), Error> {
-- 
2.49.0


