Return-Path: <linux-pci+bounces-41689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14821C713C3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BAE034D305
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62D283FF8;
	Wed, 19 Nov 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLP3jKcX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="na2PgkPg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E02D738F
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590760; cv=none; b=RXRp+DtfMd/1Pj/Bsp0BPeXKxyuvUQ9UQltcoe673aeGk5RGTfDyTT6FvafbmCYdSgA4mvD9xEW0vABJy6FOADgvNXqF8fMJqVfTSSX30NlPv49x3TbCMWiifBKOctFUPp3/UqqQDg1PMx3MJG5P2weoK/VZsouf2zRDgGkDjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590760; c=relaxed/simple;
	bh=+Ew1MxHcxbH+jlKqEW6JTrhgP/QMWnhNx7X3j0QN/oo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gXjeiHHE/SRfcpFBHyLxN8fVHTXHoZcJeBHVgTRUSHa+68BFUjH2Nd8xWglNBMQoWe/wsUri10vaBC1wKLtg+WBKzWoi6IH/5S3tQetRm7xm7JsfHb7ca1a39V0mFM5QnNGPFNYdlcFF91PgxLk3/ziUFHzZgVOWbteHrO1IoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLP3jKcX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=na2PgkPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=InbEGXlkbC7aIxo6RxR3oAJ6BzaAFqST5Ccg6MsT3TY=;
	b=MLP3jKcXx/SdTEqJN7kNRAjY/vFn49ITgDfZRSy5sHAsDXkUVjGdlt8crTYSctzPeRsf4M
	zc0/q5lzfPTm8A3voyuQVhNY8U7EVxZrmIQiFftpVSq7my4c+jdYw4/Y6tJdVJ+lZ1CnlF
	qAtGnxxzgzKq+Li3eo2naMMYgYhaaDM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-oXzlEz44O16RXekvo3PcTw-1; Wed, 19 Nov 2025 17:19:16 -0500
X-MC-Unique: oXzlEz44O16RXekvo3PcTw-1
X-Mimecast-MFC-AGG-ID: oXzlEz44O16RXekvo3PcTw_1763590756
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88237204cc8so7998366d6.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590756; x=1764195556; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InbEGXlkbC7aIxo6RxR3oAJ6BzaAFqST5Ccg6MsT3TY=;
        b=na2PgkPgNlip4O3NHN266aWKgEv4edHQvBp8dlZiWRMrwEfBqEGN85pA/lfauRwhbY
         xNN/3bhKjRfez71pw3Yx/vhb9Z6n/kzRlw6i3oV6KwwKPaHybfzucPkrIQcuccUKiJGb
         RGtzka/kHJbJIosRLGfr+WRzeo2Ttd3tsBdtqf/Nxuhb0/5ytab3x7NPDO5Qawq3T6WY
         F4IbGrPGTlH9RX0+j+pfkpm6a+s9cZ3lpIxfo6YC3U6sp1Hq/3rumnbol9we6NT4uI4G
         RFxelNGnAURdJ5L5gNPz+kXgWQL7Qwb35lhRVh7AFIlPsadmf6mGJjyeG6qfxUIDWL0R
         4eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590756; x=1764195556;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InbEGXlkbC7aIxo6RxR3oAJ6BzaAFqST5Ccg6MsT3TY=;
        b=ALK1nZq6eQXafKrN+shQ+jEJS6yuz5Q93VABJtXIGG0Wbjosfwx2SmFeN2wvIzxFtt
         rPBRMdnf6NdgeotSnSuk5wc2f7jLYQCYBS5+EWaDnx/Qs3zIhFf8mooUrWRPwjqBdbO7
         ADlyWHUYv0dt2jPSlpqoEpwoQfugcLze+hs81ixEA9J9fEzRGYnc4YY8Mojw9WDbjLFC
         QfTSvk478RlplS/ixxITvxMtnQVzka9Rizm2vWO/xB/EYc5ZswzVijXGwxHaQCQoLza0
         +0nlmfP1G1Rm+Uu2ktJxvAxQ06cd3NTAWfSDcl2m+TZ85AVn6mKAjYQcMkhCyoC7cZeK
         E2Dg==
X-Gm-Message-State: AOJu0YxuqDhqGtaIw0wvdyqC0ymyy9DkPN1lGN34bgNy+3wc8GhwrEhr
	+8Qu+srU8eITNWvSVZm/51aLwTH0xJpG2nna0IDRZP4HMbwbvMW0WpJ3oHoe7VjItJUQCJP1Mhn
	q+CYG7pIhNPK85DpGpIe6S0eNyAZIzXKOQur9l/dbQzPT4jWBwH9V9/Hqrbhu6A==
X-Gm-Gg: ASbGnctIk9SaXaM6bAvOSH5JeT37a6KC6QCkhLzeNMDme85cpBGt0hDiiMFMpuzXt9p
	VgiSVo/zzyO+lRTGyy6/CYqIHR8l7EeeaAxADot9H1V4fIdTL35KitghiZekiZZot9tvC6g4g8c
	J4iX0Uqf7wu/+eHzQgkW5gxImxdnYdVqC9jOOQr2tzPHp+wh65Z30z3KhnKXtU+0A4gk+/j8Tgf
	ClYZQ3lJTFZYlVv21badlfa//I8q/PvJ1GNG2+yDfdJOhg8g705q1IM7+9ACqbnQ1Gl0Fk9H+X7
	u/xQT54PG/wkEcWvRLFWX2IaGn1ocAwWCHG+VlMMmQb14cty3vNTeVop+uxgHZwGwCh8AwPf2hb
	4Q3+zWowcBxkcIQ==
X-Received: by 2002:a05:6214:5d05:b0:882:5078:8da1 with SMTP id 6a1803df08f44-8846e1a66abmr9937526d6.64.1763590755827;
        Wed, 19 Nov 2025 14:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAuyNCjGboSddd6tU49f/lePK3CChtTK/F5SRNahw3YOsS3sJ5DgJj+6nNXHdp9XkGb8cTBw==
X-Received: by 2002:a05:6214:5d05:b0:882:5078:8da1 with SMTP id 6a1803df08f44-8846e1a66abmr9937156d6.64.1763590755371;
        Wed, 19 Nov 2025 14:19:15 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:14 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Subject: [PATCH 0/8] rust: pci: add abstractions for SR-IOV capability
Date: Wed, 19 Nov 2025 17:19:04 -0500
Message-Id: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/w3HMQ6AIAwAwK+QzjaBGozxN4hVu4ChykL4u9x2D
 ZSLsMJmGhSuopLTiJsMxDuki1GOcSBL3llasHz64hMFtUiuGMN6eut2CjxD7z8wDNMLUAAAAA=
 =
X-Change-ID: 20251026-rust-pci-sriov-ca8f501b2ae3
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Peter Colberg <pcolberg@redhat.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2

Add Rust abstractions for the Single Root I/O Virtualization (SR-IOV)
capability of a PCI device. Provide a minimal set of wrappers for the
SR-IOV C API to enable and disable SR-IOV for a device, and query if
a PCI device is a Physical Function (PF) or Virtual Function (VF).

Using the #[vtable] attribute, extend the pci::Driver trait with an
optional bus callback sriov_configure() that is invoked when a
user-space application writes the number of VFs to the sysfs file
`sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV [1].

Add a method physfn() to return the Physical Function (PF) device for a
Virtual Function (VF) device in the bound device context. Unlike for a
PCI driver written in C, guarantee that when a VF device is bound to a
driver, the underlying PF device is bound to a driver, too.

When a device with enabled VFs is unbound from a driver, invoke the
sriov_configure() callback to disable SR-IOV before the unbind()
callback. To ensure the guarantee is upheld, call disable_sriov()
to remove all VF devices if the driver has not done so already.

This series is based on Danilo Krummrich's series "Device::drvdata() and
driver/driver interaction (auxiliary)" applied to driver-core-next,
which similarly guarantees that when an auxiliary bus device is bound to
a driver, the underlying parent device is bound to a driver, too [2].

Add an SR-IOV driver sample that exercises the SR-IOV capability using
QEMU's 82576 (igb) emulation and was used to test the abstractions [3].

[1] https://docs.kernel.org/PCI/pci-iov-howto.html
[2] https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
[3] https://www.qemu.org/docs/master/system/devices/igb.html

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
John Hubbard (1):
      rust: pci: add is_virtfn(), to check for VFs

Peter Colberg (7):
      rust: pci: add is_physfn(), to check for PFs
      rust: pci: add {enable,disable}_sriov(), to control SR-IOV capability
      rust: pci: add num_vf(), to return number of VFs
      rust: pci: add vtable attribute to pci::Driver trait
      rust: pci: add bus callback sriov_configure(), to control SR-IOV from sysfs
      rust: pci: add physfn(), to return PF device for VF device
      samples: rust: add SR-IOV driver sample

 MAINTAINERS                           |   1 +
 rust/kernel/pci.rs                    | 148 ++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig                  |  11 +++
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   1 +
 samples/rust/rust_driver_pci.rs       |   1 +
 samples/rust/rust_driver_sriov.rs     | 107 ++++++++++++++++++++++++
 8 files changed, 271 insertions(+)
---
base-commit: e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
change-id: 20251026-rust-pci-sriov-ca8f501b2ae3

Best regards,
-- 
Peter Colberg <pcolberg@redhat.com>


