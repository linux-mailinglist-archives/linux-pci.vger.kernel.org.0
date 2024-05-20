Return-Path: <linux-pci+bounces-7671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95878CA14A
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E967F281A63
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E6D137C40;
	Mon, 20 May 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDuNQQKn"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFB137C24
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226019; cv=none; b=JmUUtmg+ZZKt+5FXpHjazM1vSzzANWW2B5LP1/XBxx/QhAcN0e5GO4uZLtdrk5zp1skd2AuSH4o3LosBBMgvTQ/QVKeOJjNg7IJRa1WKIGbBMy7bBqYBF+QjAozbfPvMBHckqTb6Bwl8v3WiIThIPLLaCF2JF559ks8+qEPGRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226019; c=relaxed/simple;
	bh=kxfAh9lS7Mn3sjXjn7qlnE4XYCDSGyNPjC+wTb+HBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5aEBRwDhVGMdJh6uogIPpDQHshSqG610N8Osuprw9TmHNS78pLd7jFkR56ksJKLxbeLJ3FH34d6YV2dNqUqdySN1xOHXTw2gzM0XvWK4k7DPx+DvY/NaV4XQaNk7hSKx0/wwX7wXQgL84W8uBqC3e8jq2OWsY4Jbj6+NKHYfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDuNQQKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gx3u0JEgfsEhAPjA6GAC4pQYVsboBrU6ONnJXfcQWCM=;
	b=MDuNQQKniSbHxFOV4m7MveU3xqNFYM+dB9F5qWULMGHnrDuxm2rbUb2wcIPB28wDPb8jND
	EYXzwmWJoREi3Uh2I6mXFgDUxKkHmE9YelxPDkNEEyfQr9z8LB8MbxVQFzDGMoyCS/w7aB
	o5M5j8n/vu3zrp34e74SLAgucOxSaO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-kmlgZVTnOzGicrO1qmXCFQ-1; Mon, 20 May 2024 13:26:55 -0400
X-MC-Unique: kmlgZVTnOzGicrO1qmXCFQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-420122cf3eeso42789225e9.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 10:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226014; x=1716830814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx3u0JEgfsEhAPjA6GAC4pQYVsboBrU6ONnJXfcQWCM=;
        b=OGF7z2S2X2cdARq8E58eXM8diJEnjcP+CixPbW3ncwJqrLGbeb4lKvaL7/M9I63Xle
         /CgAblYhKynaQqU9uWB7YfF0CvTkpn3vCBpD387VlPz4k1UJaAAIZ0GWOA+MA8gurZut
         UJnrMZATzrQgxagDunrOGKbPRF2PIjstx7b/uupCeeQkrZtdWm8PWnOAE8LwzWyLuDzN
         AX/2Dc9R557V4ISBgwUNkWn+FbRwwDhUUw0g7dtpm6+2gYxaOrztwQ/ieiuBfjdx+07H
         IbKhWynNtxywjFczUM/qe6DCi2yPx7n6SyyEXvpsnwp0MKLgatR5kjq3oUzUele/XZgJ
         9qZA==
X-Forwarded-Encrypted: i=1; AJvYcCUt7cPr9/UKb8VrNDWFfJMRDYo8IiDIVe9xcBb4idSSeRQUHHqI4wd3xXkn2d6NtISrI6wD0nlWvY6H8WIvAcPHvX2rmj4UWvpJ
X-Gm-Message-State: AOJu0YxsTewrTH6Y7JpYrJYnVPzvArJXC7ojRPW6d2Gjhe7GBgE3XwF0
	LMah6Ypze/rn5jWDU3kX42urvVoC60I45hocIb8W+S3eMjuXGl2ZNoDcM2A5lwkOPrzC8NzyORx
	8VyGgLK0SS78xPzIQTiwKa1zMxwEz8Xy+cEJTwn6k3R4XpnUsj7pSOzhP3Q==
X-Received: by 2002:a05:600c:5008:b0:41b:dca6:a3fa with SMTP id 5b1f17b1804b1-41fead6dc7amr216719405e9.39.1716226013271;
        Mon, 20 May 2024 10:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbmLLTMe3CGThrlx2vgSOJ73LtYD3RAzGHWt9c3xNEvxKcy9SyuzQjhuQVYI306IjBPps6SA==
X-Received: by 2002:a05:600c:5008:b0:41b:dca6:a3fa with SMTP id 5b1f17b1804b1-41fead6dc7amr216719145e9.39.1716226012470;
        Mon, 20 May 2024 10:26:52 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9348sm421295005e9.24.2024.05.20.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:26:51 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 00/11] [RFC] Device / Driver and PCI Rust abstractions
Date: Mon, 20 May 2024 19:25:37 +0200
Message-ID: <20240520172554.182094-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sereis implements basic generic device / driver Rust abstractions,
as well as some basic PCI abstractions.

This patch series is sent in the context of [1], and the corresponding patch
series [2], which contains some basic DRM Rust abstractions and a stub
implementation of the Nova GPU driver.

Nova is intended to be developed upstream, starting out with just a stub driver
to lift some initial required infrastructure upstream. A more detailed
explanation can be found in [1].

Some patches, which implement the generic device / driver Rust abstractions have
been sent a couple of weeks ago already [3]. For those patches the following
changes have been made since then:

- remove RawDevice::name()
- remove rust helper for dev_name() and dev_get_drvdata()
- use AlwaysRefCounted for struct Device
- drop trait RawDevice entirely in favor of AsRef and provide
  Device::from_raw(), Device::as_raw() and Device::as_ref() instead
- implement RevocableGuard
- device::Data, remove resources and replace it with a Devres abstraction
- implement Devres abstraction for resources

As mentioned above, a driver serving as example on how these abstractions are
used within a (DRM) driver can be found in [2].

Additionally, the device / driver bits can also be found in [3], all
abstractions required for Nova in [4] and Nova in [5].

[1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/T/#u
[2] https://lore.kernel.org/dri-devel/20240520172059.181256-1-dakr@redhat.com/
[3] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
[4] https://github.com/Rust-for-Linux/linux/tree/staging/dev
[5] https://gitlab.freedesktop.org/drm/nova/-/tree/nova-next

Danilo Krummrich (2):
  rust: add abstraction for struct device
  rust: add devres abstraction

FUJITA Tomonori (1):
  rust: add basic PCI driver abstractions

Philipp Stanner (2):
  rust: add basic abstractions for iomem operations
  rust: PCI: add BAR request and ioremap

Wedson Almeida Filho (6):
  rust: add driver abstraction
  rust: add rcu abstraction
  rust: add revocable mutex
  rust: add revocable objects
  rust: add device::Data
  rust: add `dev_*` print macros.

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  | 145 ++++++++++
 rust/kernel/device.rs           | 498 ++++++++++++++++++++++++++++++++
 rust/kernel/devres.rs           | 151 ++++++++++
 rust/kernel/driver.rs           | 492 +++++++++++++++++++++++++++++++
 rust/kernel/iomem.rs            | 135 +++++++++
 rust/kernel/lib.rs              |  10 +-
 rust/kernel/pci.rs              | 449 ++++++++++++++++++++++++++++
 rust/kernel/prelude.rs          |   2 +
 rust/kernel/revocable.rs        | 441 ++++++++++++++++++++++++++++
 rust/kernel/sync.rs             |   3 +
 rust/kernel/sync/rcu.rs         |  52 ++++
 rust/kernel/sync/revocable.rs   | 148 ++++++++++
 rust/macros/module.rs           |   2 +-
 samples/rust/rust_minimal.rs    |   2 +-
 samples/rust/rust_print.rs      |   2 +-
 16 files changed, 2529 insertions(+), 4 deletions(-)
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/devres.rs
 create mode 100644 rust/kernel/driver.rs
 create mode 100644 rust/kernel/iomem.rs
 create mode 100644 rust/kernel/pci.rs
 create mode 100644 rust/kernel/revocable.rs
 create mode 100644 rust/kernel/sync/rcu.rs
 create mode 100644 rust/kernel/sync/revocable.rs


base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
-- 
2.45.1


