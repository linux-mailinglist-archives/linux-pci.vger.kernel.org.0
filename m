Return-Path: <linux-pci+bounces-41690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213CC713CC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 005D034D68F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782830BF4B;
	Wed, 19 Nov 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejYWQbOb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t+67ORCo"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4A2ECD37
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590762; cv=none; b=obh0Jg3mQQu/BJHIU49l8xJi0SNQ/LxbA2REBCczRIEsjaYtk23uLyLSVQWAG1ts+D6FKuNAoqWewu6RTHqrZOIdF4tZ2InrpMsR31LC16Jsrlz8y0XuE9gm3BYZhkXboqNELUuzL5WPCIhsFdu4CE3ExHPXwffjUIssPiziMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590762; c=relaxed/simple;
	bh=MeAH/L9J30qCwqNdMB87QZq7p2/nxJ5qIpUSuF+RrHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/YJafojST5s8uQdGu7/6vSUA8Yu02pt6nBoVUr6k2Gl1ItC/KgcpGQfpq5TjxogcznAkvEJoEO8LouQkfCG+meOWqcgZVZLPEVvySze5EZeojhgDaiaH+xTFXVR0e/tQ6f219J9sPyz/TEesq48u/4v+twaLggFa3bvvRsenVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejYWQbOb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t+67ORCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0Vb/20jTWy28ubGj9MV+Ibuanb4TZxQpwWcQXJ663I=;
	b=ejYWQbOb4MWpprm+N03+x/SZSuyp4cZfF9v7+DUhgZ0B7Kg0HO6P6EYNQLMgGp7eKb+aD3
	i33sRcpNvic8HBiCobDnLARW4rtomcv4YMRpsM/HDAbQf0PqfJP45wwshq7rAih+HIqxFx
	aqCdskQDZYWp8GI9wo5InG5UvEc9jEk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-KJJGM8nLN760IfErbM6qfg-1; Wed, 19 Nov 2025 17:19:18 -0500
X-MC-Unique: KJJGM8nLN760IfErbM6qfg-1
X-Mimecast-MFC-AGG-ID: KJJGM8nLN760IfErbM6qfg_1763590757
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88233d526baso8301936d6.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590757; x=1764195557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0Vb/20jTWy28ubGj9MV+Ibuanb4TZxQpwWcQXJ663I=;
        b=t+67ORCoQvloq0ZpCZzCXRZ1dG6L1e2Fagkc2ClXYCH6LqFrSiXeyddwaUJiXEkrSN
         QBBMuI6QIAEbKWRh8tDYo97qjCziBr19H4qSS3/goFj8o0NTrXE4gNyq4FGULp2ohXAH
         dpqFz4sgmhIlW83WAeR0/9KU8ByZG7hp7kKBBLt7Jfc9mIz1C70Z0+7QU8xGATGUUR7O
         LE1WLkhB6Wd5zXUMeQHlpvqZFmH15QWvT3OpVR0kzobeOz+RAJx21wNeXylo2PBHD2tE
         sDZE6rNidMH3c2UhSsWzIoH+Vm2Uv971b+IcHMa+2HSLhemeKiG4VeQjllUR1Hj+2LjE
         MYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590757; x=1764195557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0Vb/20jTWy28ubGj9MV+Ibuanb4TZxQpwWcQXJ663I=;
        b=HaOHuYA31G55RkIjlnoM/Ai8WA/83bBXv8etoa+3Rbfuq/rUO4gDZfCwT6QVK5YDMj
         toItjgkdcgMY6kP8PF4cAJz2drOpGIPzZFgZUFDJAT5NkcTE/AgRGfYYz4WpznoKY0pV
         N3yQOv2cRZdTVesskBANGgirKpAwpvEJOa00y67Er87vJt+02sIz2KXfUK9mh7Iugl9o
         IkKlhv0u8bI/e24U1Oc0ibAMWTtlb0VcjkytzamS9Dn2lOVuHgnKCR5t9Ca8AaJVKPrf
         6MI7cedhacwUqzfV7VOcbRl7mbdyQgB5txHISJ6rK2/aWTrCM/nGk63KDGoXIZztAJEk
         KKEQ==
X-Gm-Message-State: AOJu0YxYN4Vn6oSgrlC2jkKUwKMQ4jm7+TdMPZ75ywZLRP9RyxNYlRDP
	fnDryDtAdfCDekUA0hraQIq36Q5zRGlPFX65dqGQ36P9f12wllDEhIIGATnJBes3VNvEagsVuyN
	obrvdnLr7p3CKeNkQW1dtt6bh2h7iJZ1YtZP5vKe4FFfgnL9IqydzFckJ0+jlgQ==
X-Gm-Gg: ASbGncu/CfZl6NaeJVXwUnBE0maYkxdqF/M4AkmbSJRWlYgQToWs9y6Xuga4wodWo2b
	2RVd+2N3Y+uNod4tP0JFESX9B4emCMZBQBfYx08cRgUP+BkNV5YMdxf3V5LgajYzJVrRbEYDMnz
	ZaFeFXVPZOdH8UYh261XEOI5yfcyGxog3Y0Eu95TZZefH2SHY2K7ki4dEDweDudGvdjf79bvz9U
	9RxMIh8p66/v53Gy0m33EZv4OogAZ3kNdP9qO78EcMzvvpVtIlxdLKQiOwLnnJmTv6oVoxQNgGm
	p53R193FwMORqCOra6mfVdsDkXtEJDH/DgDl7M53h9jYOEr/ic4xlP98ErpBc9Iuub35zZuRegn
	89xylfatrDUVIaQ==
X-Received: by 2002:a05:6214:768:b0:78e:6354:b258 with SMTP id 6a1803df08f44-8846e055f2bmr12533166d6.15.1763590757403;
        Wed, 19 Nov 2025 14:19:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT94Xj7OzL6w7dHQO8Ye/Fmage53na9GJygM3mxuQHkkniYgbaAhhdRnQnnHNNrHgeJgJp7Q==
X-Received: by 2002:a05:6214:768:b0:78e:6354:b258 with SMTP id 6a1803df08f44-8846e055f2bmr12532836d6.15.1763590756867;
        Wed, 19 Nov 2025 14:19:16 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:16 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:05 -0500
Subject: [PATCH 1/8] rust: pci: add is_virtfn(), to check for VFs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-1-883a94599a97@redhat.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
In-Reply-To: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
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

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
This patch was originally part of the series "rust: pci: expose
is_virtfn() and reject VFs in nova-core" and modified as follows:
- Replace true -> `true` in doc comment.
- Shorten description and omit justification specific to nova-core.

Link: https://lore.kernel.org/rust-for-linux/20250930220759.288528-2-jhubbard@nvidia.com/
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f080fde78a06dc5c284ab12739e747e..c20b8daeb7aadbef9f6ecfc48c972436efac9a08 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -409,6 +409,12 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Virtual Function (VF).
+    pub fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+
     /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {

-- 
2.51.1


