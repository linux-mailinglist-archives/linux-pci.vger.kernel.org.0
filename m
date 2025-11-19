Return-Path: <linux-pci+bounces-41695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A0C713D8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A98834E265C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77575329C6F;
	Wed, 19 Nov 2025 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YypFePJk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoUWQt7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2D3271EC
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590771; cv=none; b=e3/rOZl9glxuUpKPF4Zp5vZec3Idt2DdiAI8wwOCCHX46YJ8OFeBLHYBLPmD9626/hYytI2IINHlhQbW84ckDYetT0OdBeMxcou8jJBVBdqSi2tJ2z/k9J0ZKoe/9tjWs110jDXFAFbqF2S6gD8Fb4GoRBQc6JONAvGZB3YQU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590771; c=relaxed/simple;
	bh=ePuew1JCM1Hs1e6ZIWmT70f+aea4BDiTcwCKTX9QAMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzdijjKNY9c2e2QfzA07yltSfmqrfOVIsvGYlprLQ88fw3mfQjJh1sEARwVvtU6xurOQrz8JeiviVNbRIxT4x+/fDwfVKRPHXWFRSSvcnVQBDdHRxz0aVKEP+IV7WPh+8lXfSvnPr2vMrafp6fSB4haZFmjb1d1T383RjCYlG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YypFePJk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoUWQt7H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRACUSt64wUiVLTpoLMSIYgwAJ0MY3voBS0pEwO7IGQ=;
	b=YypFePJkq/uwUBvZMzVD9DgjdhRJkuxAnMZjmlo78XbChw2Byvbo0GeYmFIPGmIVATFZ/v
	eMvJUviaZIs/iNcb9/EboQQlzJHsVPkKPP2jtbXj/ldgwDnoVdmOm+ZbuvCAUwdw7Xfvpm
	oXZ8fdowDAXHtmStxI7YmgflPI+isUw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-PId_Tk8XOFy9CGoh1xVY9Q-1; Wed, 19 Nov 2025 17:19:26 -0500
X-MC-Unique: PId_Tk8XOFy9CGoh1xVY9Q-1
X-Mimecast-MFC-AGG-ID: PId_Tk8XOFy9CGoh1xVY9Q_1763590765
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2e235d4d2so107840385a.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590765; x=1764195565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRACUSt64wUiVLTpoLMSIYgwAJ0MY3voBS0pEwO7IGQ=;
        b=OoUWQt7H5tRpHDkaqkcCHnEC+CcTyl6JiFC43SAu4W1Zh4rbVgN+Cqsw/736fW/OH8
         F7QAZ2bn1GSYMGA0hq+4NWbMoih1ZKKaD1lErPJ9mykwO2c8JdjuDNyGPnhclKq0Kngc
         ipXmyXSc6KODqvGeUmoZ1QEFMq0wYSO1y9m4z8kaplpGjYEHS1E4jd7vYwoBXy9CThO7
         mfH3wgBYWMS5qtPRzcwON+NSABolHhUEyl+daraz62SXHUaiPsu83tTk7Tw30WQ47/2W
         Vhjp2Tm+cZC5AsF7h9zrUnuFODN0WBQYWSa0wwyqGXYnwguUVY5U7Pv/NksZkYEsLRMH
         95iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590765; x=1764195565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRACUSt64wUiVLTpoLMSIYgwAJ0MY3voBS0pEwO7IGQ=;
        b=UK0Wl1VfPkdoYgqONhOmYUXcJtI+XTp9JkdWiJLrhDG2I3VjLCmDqRzzLt3lT86lyQ
         0ojB3NYC1/4or05PeTBAzZvC73/yXuAF3jkeHtmlaxglYaffe/PKSRnRnQMsz7pGeMlj
         S3A1oDFmNano8Sr3fzoE+cPMxIT9dlNvQn/hLlwtgufl5B8DJrwQcLoYZCJXfaW+2X+4
         iSvp78SzjYWRfnLHKrSjB5C9VnXEE79aVN1CoYiZYu4i6pca406K6IPs6jPj7T+sj5XB
         RPGQEmcbmDUtLfrj9zys1sQnbkLRwszxglrtAqyV1+HUQ/milVKjiAZxF7NrI5j8Iygg
         Fqew==
X-Gm-Message-State: AOJu0YxTKMeZgq83102K2P9Zxfjzm1QWbwAvgQubDPAsqOglDqyyQ6i8
	19aHt4vGmRZb885mvnjtkP9DIPo9iGRRTAZsEsakPoeMgjuOcoGNdxK7DG41VjLb4yZI2NVN7xS
	6gulnCj3wTPuCXd/h+P1Q+sKXZHodtOzQmd7krCj5fRO8g+BPcsgya7ZWf2QHug==
X-Gm-Gg: ASbGncshenKlmFm3APy+IXrgcaWX92c0zmjXw24zU/MT5ZK3oqZuQfz92sXnUFclzJ4
	SLUbR2yVL6DSNrsnQ7EgymrgwUz6IhiGyFExttySIo1JItHv9X4kF+8v1/pTpOWSa4lbvxuwGIU
	fKmVxi3sD6d3Cce2cLeCT0AEm80O/KAVFmj5v6bzt9baotNUUVp7TL6rBqki5V/S0lHW39yt1Yc
	DTwErWYJ/3/1MavPqXoPsxTQfHUhY/ZwBfhIud9NjvjzrzftFekoddhO2gxVD9gjNZgrIvAspXV
	cTbja44mbeub4C+flsL4sqOwabKdiZ1IR+fJPloj3XTnaPlNRvKoK0waZqYRH0aHAyVzEHWVPab
	zwepqLqE9aj/lnA==
X-Received: by 2002:a05:620a:c54:b0:8b2:9765:3a69 with SMTP id af79cd13be357-8b32747f96amr159065185a.68.1763590765328;
        Wed, 19 Nov 2025 14:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPsHmN0cQPL5HT5GsktthJovUEqLhZHDaj3qO7Z3zvSReIfEaHAgbYWjYECBY/fX2jHQY1EQ==
X-Received: by 2002:a05:620a:c54:b0:8b2:9765:3a69 with SMTP id af79cd13be357-8b32747f96amr159058585a.68.1763590764685;
        Wed, 19 Nov 2025 14:19:24 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:24 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:10 -0500
Subject: [PATCH 6/8] rust: pci: add bus callback sriov_configure(), to
 control SR-IOV from sysfs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-6-883a94599a97@redhat.com>
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

Add an optional bus callback sriov_configure() to pci::Driver trait,
using the vtable attribute to query if the driver implements the
callback. The callback is invoked when a user-space application
writes the number of VFs to the sysfs file `sriov_numvfs` to
enable SR-IOV, or zero to disable SR-IOV for a PCI device.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 24dda12f6402098a1a323f3b5aae884201b26d89..f9054c52a3bdff2c42273366a4058d943ee5fd76 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -66,6 +66,10 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            #[cfg(CONFIG_PCI_IOV)]
+            if T::HAS_SRIOV_CONFIGURE {
+                (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
+            }
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -118,6 +122,20 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
         T::unbind(pdev, data.as_ref());
     }
+
+    #[cfg(CONFIG_PCI_IOV)]
+    extern "C" fn sriov_configure_callback(
+        pdev: *mut bindings::pci_dev,
+        nr_virtfn: c_int,
+    ) -> c_int {
+        // SAFETY: The PCI bus only ever calls the sriov_configure callback with a valid pointer to
+        // a `struct pci_dev`.
+        //
+        // INVARIANT: `pdev` is valid for the duration of `sriov_configure_callback()`.
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+
+        from_result(|| T::sriov_configure(pdev, nr_virtfn))
+    }
 }
 
 /// Declares a kernel module that exposes a single PCI driver.
@@ -307,6 +325,39 @@ pub trait Driver: Send {
     fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
         let _ = (dev, this);
     }
+
+    /// Single Root I/O Virtualization (SR-IOV) configure.
+    ///
+    /// Called when a user-space application enables or disables the SR-IOV capability for a
+    /// [`Device`] by writing the number of Virtual Functions (VF), `nr_virtfn` or zero to the
+    /// sysfs file `sriov_numvfs` for this device. Implementing this callback is optional.
+    ///
+    /// Upon success, this callback must return the number of VFs that were enabled, or zero if
+    /// SR-IOV was disabled.
+    ///
+    /// See [PCI Express I/O Virtualization].
+    ///
+    /// [PCI Express I/O Virtualization]: https://docs.kernel.org/PCI/pci-iov-howto.html
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci, prelude::*};
+    /// #[cfg(CONFIG_PCI_IOV)]
+    /// fn sriov_configure(dev: &pci::Device<Core>, nr_virtfn: i32) -> Result<i32> {
+    ///     if nr_virtfn == 0 {
+    ///         dev.disable_sriov();
+    ///     } else {
+    ///         dev.enable_sriov(nr_virtfn)?;
+    ///     }
+    ///     Ok(nr_virtfn)
+    /// }
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    fn sriov_configure(dev: &Device<device::Core>, nr_virtfn: i32) -> Result<i32> {
+        let _ = (dev, nr_virtfn);
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// The PCI device representation.

-- 
2.51.1


