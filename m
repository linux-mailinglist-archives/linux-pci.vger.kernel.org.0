Return-Path: <linux-pci+bounces-41692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D7C713C9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 86F532B8FA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83E3191D1;
	Wed, 19 Nov 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYz1oigS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWKzJG7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325953112C4
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590765; cv=none; b=R8kPuS7J8q77cCkJ8qD1Hxh0aoWBiCZH3oOOJSlvV7cesp+d/WjPpcRpQ8PZRMgkEmlEfapS5HNL7X5uU7ZKFaAssPZi86ln4Wc9QPdBcLedpP6JO32FY1Tz5O3eCDxRM0IEmU+nkdflo28xwnWAItxyOpZ+tesMS3pZW4lukN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590765; c=relaxed/simple;
	bh=gUctwyZu30sn6ERuNz9kxhzBQ/dbl4j0za7C8gd+O2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6Vkj3qRH9FEeicbKX0xU0RhNLWokJVu3Sn6V/nI1YcScyf9cUcnBHqWeNJz2JpVdMQqqrOwXLWYiAV3/kn4CtqyS48KESoMLjRtFtruc2QaRDdtL1WU63lwTZPWHE8LTCEW2X85j81GmuYxdfvwFYYwG6/E/VDcJw0Z1nG8lqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYz1oigS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWKzJG7l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlM8hkUz32RUJhAJoZInUpHPPnxIuanN0JL39L4XpyI=;
	b=fYz1oigSHasGpXc/Th3+y2gLZY8r64IveYiT4105RWD42ktwKu9MLKZt1CrzyCHO45thmG
	2eNHTkuCICmg5aCuN9g2zDEABCXU6hvJE7Y8T5L94RGqD960aiXrS+miJ4f/4dOSMliT2A
	zn6ThSFk80GiyZgxhjQVqpxYRA5ym/0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-EapwirggM7OYgyEZH02aOA-1; Wed, 19 Nov 2025 17:19:21 -0500
X-MC-Unique: EapwirggM7OYgyEZH02aOA-1
X-Mimecast-MFC-AGG-ID: EapwirggM7OYgyEZH02aOA_1763590760
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88044215975so8019566d6.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590760; x=1764195560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlM8hkUz32RUJhAJoZInUpHPPnxIuanN0JL39L4XpyI=;
        b=MWKzJG7lOmzezYH0r4R4YG/OgU8nhQv9rZ9gmKWreD1Wh67cxIzdPXFbi4Zl7V8Blp
         WUejBYjjIVNaPmiIQwIyjfobJMVaZBViKS9QsCccjrsyBVYB4gujTCx3JyooXOXwoRIx
         QxcTEO//FNU6U8st8t/khZsN7kodyW2iOiRoWlkBHWfJVNG0eLdlDEa6V1/QD2jMt9Bk
         9ukF8QFDQyhb9rzT396D79YqL2tHqQ6eyOcjpck/eZTCRpeUcmFSm5rCFWcekA/e0hhj
         fu2dAnzhlWZ64KQRyi0HC9OFEst81u0UF+H3CKt3DobM/0/UAdFUS5jApRq0LOm1ibGv
         behQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590760; x=1764195560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZlM8hkUz32RUJhAJoZInUpHPPnxIuanN0JL39L4XpyI=;
        b=ID6AXX+BKCNiXjTSCfKLrJaTygBlyF80unx5b/oa/ZygDRxD5q8nlkx6P3/H5aIkx8
         EEVVSjpxos/vEz7pXklj2rCVPHn526XFJ03c7Rvc3UR2OnoRav41WLQnHlhbvvphYgZU
         zpGbgy3kX58b7H55QlHPl5EKsaxQwHYyAQ6EbgSIp1miWj6lrFt3QuVH3e+YJOKGiqoE
         ObOhNZwj6PUdklOQjm4rf2Fi2T+MfZBTXDxterXKImyTjcV9uyNY1CkhBGh2rhl00Ttv
         EOb5eHOUQKaZwFjztF57GPFbpaCXBjQqaMmAP2zVguywNw/qPQIcfrSZcg2E7eRrvSmG
         bdUw==
X-Gm-Message-State: AOJu0Yxi5DQQTD4NUS0+8j6hOygnXs2E98LPndu0tm1Dpbr0yfbjHVIl
	lD26ypfVLSpuFPRVxJmfRAd1/XU8vKR3MI5tWEtl0GU9oDiBqZURUrZCFZ01WsutBY7fEHeVuLx
	g/7DfqLhTltxkR0OkJO1UUNnE2GjGp9rHyLZ8wGc+eNMPOhYsLS8kBMAOiyU5cQ==
X-Gm-Gg: ASbGncsD5Pg756ewapMnJFCbzctyTLY7duycUYuagMnET/qM6duMeaWcIzdvRZxDK55
	lVrWpJekTRPhVMx/ol5p9Qtu0E6WZamMbEy+0ZpNe0EuWNAp51c9vcassigZM8OHhQdO0OBejWA
	FZEOoq5QhRwPvjlNKQEgEWUSyT9yNwWr4SY6aXgDeD5V1PA9XDCJ/5NE/Lnnm2k9p5x9OEsXOUd
	uC0N/xhCSq3yfRMmJDDHnrb4zwvgby53doRHVIUqJ7pGTs4HJ/xCOy30fZHPkD3n+4bgk/nWed3
	1JxsEoB1Fa4xrt/dvKrfn5yNm7AgZF6w2wmT1OoJWy8Yv0tzNEqaTVdw9AN6hG7OaLWz7BZcs9w
	VrFwtYaDfcwZOmQ==
X-Received: by 2002:ad4:5b83:0:b0:882:3ca2:f11f with SMTP id 6a1803df08f44-8846e03443fmr11097176d6.25.1763590760483;
        Wed, 19 Nov 2025 14:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQRDKmD0+59L+zDoLtDgwZTS1tpvNC87WX1cJ9AhOArAPTwORVd3gh8lQT/iBQwh8Q6EZBug==
X-Received: by 2002:ad4:5b83:0:b0:882:3ca2:f11f with SMTP id 6a1803df08f44-8846e03443fmr11096766d6.25.1763590760029;
        Wed, 19 Nov 2025 14:19:20 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:19 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:07 -0500
Subject: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
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

Add methods to enable and disable the Single Root I/O Virtualization
(SR-IOV) capability for a PCI device. The wrapped C methods take care
of validating whether the device is a Physical Function (PF), whether
SR-IOV is currently disabled (or enabled), and whether the number of
requested VFs does not exceed the total number of supported VFs.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 814990d386708fe2ac652ccaa674c10a6cf390cb..556a01ed9bc3b1300a3340a3d2383e08ceacbfe5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -454,6 +454,36 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
+    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_enable_sriov()` checks that the enable operation is valid:
+        // - the device is a Physical Function (PF),
+        // - SR-IOV is currently disabled, and
+        // - `nr_virtfn` does not exceed the total number of supported VFs.
+        let ret = unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) };
+        if ret != 0 {
+            return Err(crate::error::Error::from_errno(ret));
+        }
+        Ok(())
+    }
+
+    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn disable_sriov(&self) {
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `pci_disable_sriov()` checks that the disable operation is valid:
+        // - the device is a Physical Function (PF), and
+        // - SR-IOV is currently enabled.
+        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
+    }
 }
 
 // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.

-- 
2.51.1


