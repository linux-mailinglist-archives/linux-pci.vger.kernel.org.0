Return-Path: <linux-pci+bounces-36972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F76B9FC4E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0D3AADA0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600E286420;
	Thu, 25 Sep 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyMXbrVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D462D63F6
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808533; cv=none; b=cB+OQNecTUO0OJZYAoISYgess6J5H8EIklKyWt/2KlQiTw1PZNV5rK10OzJ1TuBoIRR0YjOg3f6rWS+r9O50aZJUOZneiaoTEeTcKVl8Lh1alh2gOFnssJpSUmr5JFhXdjMbtbfST8yvJy2nheWnCqNZPfolmsokHIopp21cS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808533; c=relaxed/simple;
	bh=D/F3RUnYNMNKrZc7ezIrEwfyGQmWHVwyjceS6shQSWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX4UfDStVDA2TE1+aaISwKfXA4i3+aqqZreuUaYUuG+vpz9Pym9ww+ZquNxT0s4zg+QxC0YWyGzMvnMQT5bChLRHrKLe+amPeLDMKjfsykXrircQiyz5xR2MrYmtEsK1L6HsuQAqgCg0igRzw9WThhv9lCJZPIaUcPyo50cRH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyMXbrVL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7f7835f4478so6058146d6.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808530; x=1759413330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovaMuoVhmWcLonjnTl4MFtKaHR9pluhUoUKBZs6ASUY=;
        b=gyMXbrVLp101h/tQHbeWqrn9fQ3voncTf+fRhGlhOrd8SqhLi2ljfdqXUG0/MO0IQe
         s1m5AzsWY7rreX5eh4Oi8zLFAFNpdwprKWu6quAe+RE9qoH1ouf/hV//HrU2k0J9i+Yg
         V6G65nlSuRBEfJBQ/5Y3vkd6/lrvWyu5CoTLeL2g/OsQ/CLlQyMnAYVrWFY0L+/W1xOW
         0yt+XVJ3rnN2O8YlLnQM2WMnGZhYbP+6LbwPN6zia3AHc4GmjSgNKiYHdotRO0Ecpjd3
         /QPkpeN1j64pWep+kZJkHdlrdjg2q/Y77RxCg47nUbl53ihGUJ6QBg1XDQZowveaqrPu
         ulkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808530; x=1759413330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovaMuoVhmWcLonjnTl4MFtKaHR9pluhUoUKBZs6ASUY=;
        b=vdxkBeNLb41B/QcMnJ4VybKVXsMgytWlYImWMz9bLMPDki0kJClb626nKWGVOykCFp
         KH1vuflSE6HgrkslABIigHmhW3Hse5F/qA4dn649WYwLQiVTTTK/EJJQe2jgcL585fax
         V1IBnzeWLXxx4eUGs2GllwWx3PaMwrRTAABSaCmBlSSBtHqMCrpjCFjv+hww2qsQ4+mB
         9BviIcIdmqawG2SgP1W0VwTKe02Kofl+R0njyQvFj3QMZdkrY3tbhevFDow29bSYt9LQ
         b17snmowxjdgrVF6mmoTyql/Va+fdUH3QhSadoJvVeRlfQR4In0/dANDRWpRfzlSfE8o
         ZW2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmk6uUcSythXp0aXjnj4gIebiUbQFoL+Xlv+6lxCWi59BNzhEWUyxqrRsto791JjlFdJU2sdI5R4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLi4lH0pgWWLVRm6UgOwSjpcBn7Uqv0TwNq9fSpvVbdQcdDFj4
	pFFfSAoawv9RvLOwBkTo5V+2dMVpmT/mQ67jXGyLFB2DgeYeYr8VaHhl
X-Gm-Gg: ASbGncuUtxgys1W/pDxsO8ExsXcyuUmUlqIMk9wcGMU0htuUH5x54w2MDaNaL+SAFx0
	gz9Np0zcj+tzL2NhHbqlB41M9I1k7wYQ18qhedO1Th6nCwj09w2/fiMlwGeBRng4j3LXem5Fiw/
	tYYd3fpSD1FpnqG5NJqKhskFCNOkHk3b0l6mycysMPUKfgRl+6EoHdXy17EMeyoU0DoibV4uvgw
	CNEeLHY1QYuiddWmg0T9PaBEM4U3Ji2kg86m7GugVeeH64QRz+xTwbUa1Wmkzn62kXagb/88RSj
	HpYaZN9l/3hvefJ+HiYwFc+iNfP5wFBcJCq7A4PYXJJS3MLY6szlVSR1eCzh61+ynekuGsydTde
	n4T7lwwlst6qifki9oBLX74++yrSoy4GmH4uredq4yFreHyL2TLQbfVzs7LRqJ6EkeJINOqQXX6
	dZXE0PQeyi1TmXA+q5kTm0Geu+SDwi7kGq1enMK8lR0dYeHcnfx63mCkFdPXCO+vKj/cDE
X-Google-Smtp-Source: AGHT+IHcH/Zjn6brKl+FzN0cM+iQubEhxUKmnAUgz27UdizV+uwHwEDx4WTup8nJvc6pXzFU23iTKQ==
X-Received: by 2002:ad4:5dca:0:b0:792:50bd:2fa8 with SMTP id 6a1803df08f44-7fc30ae34e5mr50026206d6.30.1758808529557;
        Thu, 25 Sep 2025 06:55:29 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:28 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:00 -0400
Subject: [PATCH v2 12/19] rust: net: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-12-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1712;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=D/F3RUnYNMNKrZc7ezIrEwfyGQmWHVwyjceS6shQSWA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLl+bRXWnt5oagOInMjpq0Q6TsOND3CIu30DW9zld+zzKdTSHrUu641mOBVFK+TECUsf9QEq85h
 /zu5kdzwmPg0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index be1027b7961b..9aeb2bd16b58 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -780,7 +780,6 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -799,7 +798,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 /// # }
@@ -808,7 +807,6 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -828,7 +826,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 ///

-- 
2.51.0


