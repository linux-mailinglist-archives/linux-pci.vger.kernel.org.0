Return-Path: <linux-pci+bounces-41691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D10C713D2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDA7734DBDB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1523128B5;
	Wed, 19 Nov 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtelLWxE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rWXXan1O"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371530B526
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590764; cv=none; b=FAInJzCjUJNkZVyjsgKwv1JWRDWOxy12kXtqKb7+Avd9ABEgQxXVn+j6wGaUagyhTUDEaxbY5RHkS2G/KIoWqy/Oi+yjEiBnHA/Sei/RD3pkvbgK+dFpaYzVwISFd/9LQlSQ7JVn0OvABPyRcMTYq65vD5+52igjGc+jnwQ8ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590764; c=relaxed/simple;
	bh=72adYgtsLfbICwRUf51p19hvB2OaCp/Vs8bJEvAgYio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StFjCuE8Dj0oCW8t1V3RtG9HIwFeI+idHYzRIQpmvngozkEbk++YZBEJHEyeI3VhTj8MD625lKKeJbxEEpXR2cVk36GonJMYrTCQkS7YrDzY6IJuW0wjFXJXXIHV91WjTlpuxDb4j/rqXJaeP03Wn5UemcmsmlzUshm9Ex5ulL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtelLWxE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rWXXan1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LT0/HQ7KAbR9mGXfO5hTKJsXPBMjCx5esqT8LbWmcms=;
	b=dtelLWxEZ/K5Hl9zMKc+7mG41QcM3TDpulrAEcf4QXLXL7xZlKiFx4kd+e2sVIBaZxvySl
	ufqYBa2WObWqHRUj2uIQimKKEXmw4msov7NZEsvBVS+rQCNYHv1PlxsU+L4MvUkuWkPqLQ
	lNDNG6KB54l6SnrMigkco+j92S2VPj4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-05mEnG3MMiOBSO9XLL-5Rw-1; Wed, 19 Nov 2025 17:19:19 -0500
X-MC-Unique: 05mEnG3MMiOBSO9XLL-5Rw-1
X-Mimecast-MFC-AGG-ID: 05mEnG3MMiOBSO9XLL-5Rw_1763590759
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-882529130acso6462826d6.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590759; x=1764195559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT0/HQ7KAbR9mGXfO5hTKJsXPBMjCx5esqT8LbWmcms=;
        b=rWXXan1OVrgHp0EDvSnXLv98wYes/yFE1hOVfDFnDhxRWKX/RExjGkVF3zx+D9QtOU
         HBDiv3R3rVFqEMoQgK7OV3OwwBGyUqUGgbaZueZW2oOhtXJyxajm6JZT+tAvaznwzjx4
         /bbBExiQmba9rxf+50uDk+ijh5SyYvqqBH51zNDeq0TGYOgjAKZIOFhVTw1S6ei/tEDl
         redKfdtfqPdLw3Up0mazkpl0opHkDlJvE82XN6Xgr6mS0RKm3iOW2qFnPz91UaLCvY/4
         JyqeWGMXOUjEe59T718FCTZ0qpkEGPu1Nkxj+sEEYyoxELIFMWc7TGf3GUgCWNQDeWPn
         pz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590759; x=1764195559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LT0/HQ7KAbR9mGXfO5hTKJsXPBMjCx5esqT8LbWmcms=;
        b=TisYC7urchOLWEqaOW2/PqWezFEI6vjnUidoIdSblwqYOOCMQhZ3zVFwuanyyH9pAl
         PXvJJSQaJzSwwkvyKPaOWNlS7TAJAzQQwy3SXUNWbX7vidFr1VSMGJYXhYRxOCLrH87W
         Xs6Rw8aaC6WQtv6pmtV6iDtLDI7z8uVQqnwOtGOK2gnhHmLcDbFsooDhnO1k071Ho/m6
         98jK7IjAw16H/E7x75hsGKCflLl5e085NxddNx4weywyeU/Yg4zgFEffnoP06vj8FBdY
         3vBu1iqI/RjyK0wn4dY7Bp80x9/vbCI7P3ghwPGaR+RsHO4Ng4/DPV6lmiaD7DlMG1E3
         hJIg==
X-Gm-Message-State: AOJu0YxwelSY5thz72nR78wJ4/+NlqDZRkCGMvIPKbWphmkRIlbzzfxJ
	L/b9sTyeIzZ4X8yDX0yLr2SFYZsS4w5Z6BD9yz+mAQzVis6xB8dP8XQHaXkrSoNCTVAoKOkIM3Q
	Xgea3FKhFcmJhJ9FCalSSzS9ZEOuhSiBeq/svSF2TX81lRFBlHMRPoWM4ZPrLew==
X-Gm-Gg: ASbGnctIv2+xHYVoj8eJm+JMBoVTUXAB/FT27DoAF31NuNzGiZvJy176qnbZ3V+5v66
	dhKfpVB5QqG+DIUbaeICT5L+f5JaiXS4MJuq4csfW7ENoMdOCMQPPbSLHdMYzvIg6chHg/Akq11
	o9pTq2JBHkt7XeeCyXqDQck9ODdxCUu38rVzwgD89mpClLWRiNqoZc64GwZj0TyfVEhWzXNK/ma
	zZF7AczSbLDZrf3oNbCWIq05yVIkJ21B56e9R1cgNNv5l3f9i3XRn498Am+c1sTlAi41ixQHUXn
	76kO99fXjZcfbyrGInSoorXzXj2g1QJPtPzbdyJhCPUZfmwCtAxsyLqia9a8vwRRNW8m6WlidDv
	hfPn9bc1EcvwLJg==
X-Received: by 2002:a05:6214:c25:b0:882:4be6:9ad2 with SMTP id 6a1803df08f44-8847013f7c7mr2682376d6.33.1763590758943;
        Wed, 19 Nov 2025 14:19:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeuLwFeoT9/1jmiPiEb5rUv7hwbM9DKqLBAekr9VTFnVBnyYQBFN13GwWwKi9JFRBVUiJJoA==
X-Received: by 2002:a05:6214:c25:b0:882:4be6:9ad2 with SMTP id 6a1803df08f44-8847013f7c7mr2681876d6.33.1763590758460;
        Wed, 19 Nov 2025 14:19:18 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:18 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:06 -0500
Subject: [PATCH 2/8] rust: pci: add is_physfn(), to check for PFs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-2-883a94599a97@redhat.com>
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

Add a method to check if a PCI device is a Physical Function (PF).

Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c20b8daeb7aadbef9f6ecfc48c972436efac9a08..814990d386708fe2ac652ccaa674c10a6cf390cb 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -409,6 +409,12 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Physical Function (VF).
+    pub fn is_physfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_physfn() != 0 }
+    }
+
     /// Returns `true` if this device is a Virtual Function (VF).
     pub fn is_virtfn(&self) -> bool {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.

-- 
2.51.1


