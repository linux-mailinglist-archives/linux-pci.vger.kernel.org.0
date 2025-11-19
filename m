Return-Path: <linux-pci+bounces-41696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF1C713F1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3719D350919
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55A30BF60;
	Wed, 19 Nov 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biHbBs4W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMdubPD1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44A313E34
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590773; cv=none; b=kQRoBB6axScRn8g4fWPD/evuEvF4KzchV/OkPpGBWtwLwXu4Yh5av9HQ4mDsT/cDCXvW3G8uQYgCc4zlOkadFQVVarJI4NVxM9SxI6EUBLAXna6Hu5+En+nWsGYXNQkFTcnn8PLlK+F2l2vLCh0Fp7EIK/PL8PaFLSNOrii9heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590773; c=relaxed/simple;
	bh=isBVQ57+Brz1VfxrUYneQSmfzbDfRyfWhKEYUrQf6Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+I+YETteSOGPif9wYI9E1CBW5LI3DztZWR+zS+/IFwhsSFDag3w+eiuW3qROKVGCwr/uL0nTqxyE6YBA+lnrQjzWdeyVtoGOg+tUthLLyx0IK31/d0qDHjBKWlbizPa6XaJnPnil8V004SZU+008eoE96HVXuOr4KJm6ZRN95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biHbBs4W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMdubPD1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763590768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TaHEw4qfrN2YhxZsjXLb3t5RR9TWTSPbbKUt1wn06E=;
	b=biHbBs4W6MA3mA8w/xXf1ZKoJJHwHClsy2OrVNo6i82F4BPct8cAB1ARoB5UJ3nHX2LDZW
	JJ59LTfWzz8jcEcLJ2JIWSS1qRK3RF3V7911wc0oTS2RMEJ4EGatk/iXpSxMGM16kbR3PF
	91KzGrewdjKgEe5bMlcWcNkuZb7g7LU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-2KvPYnxwOtiS-A0d3Pd6hg-1; Wed, 19 Nov 2025 17:19:27 -0500
X-MC-Unique: 2KvPYnxwOtiS-A0d3Pd6hg-1
X-Mimecast-MFC-AGG-ID: 2KvPYnxwOtiS-A0d3Pd6hg_1763590767
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-882381f2092so10353826d6.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763590767; x=1764195567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TaHEw4qfrN2YhxZsjXLb3t5RR9TWTSPbbKUt1wn06E=;
        b=QMdubPD1MAzVcmSYvJ3WKZpqlDeoC2bXnJZ7pYxToyCByT+VZ67873aZoEtVLwTtzw
         wbMnOOHyP25l1tWQrIiZOrqpr2u/OHe+u7FoMoL/UvCOat9FMqzki3Qe6iHFlFhFa+ar
         XwxHNgryTyqWhPt1DhCkL/KApNLRaspcmGk8QZ0qK4bXSsNEvueIbWqaaAax55YZUTUc
         ENfYehJLBrc6uT+1+GVOG8GMlhNj5w3sxMIonAt4JIXmru3FvJ/2yKINh0QnE/nw3DWp
         vt8RTYdbWggosDKvxz5PhYyKZoTUeuFnnMzYCqY1FfvzR0Ekg8/jV1KNzETjMo9yVf8B
         GMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590767; x=1764195567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TaHEw4qfrN2YhxZsjXLb3t5RR9TWTSPbbKUt1wn06E=;
        b=EZk1Lyk9Y9FVFfqaCZi7h3SmXqj7S+guTqnizxha4N2bsB++ol1asp84Z3f9ze7yMt
         Zr7Mep2LVC0S46E+WBJKvjiLW949l7FwhOq36m6pZkdCknYFhuzdNUefAfhjghI1YhFf
         3PJ3cAWVJjFA+j7cvMLlRc08yb/Z/K8DuusN2wwsIYRUhpSAr1/qD5K17reL+MsVtRYy
         XHIgxuRjBdD1b6FmnP+YVpc62Dzh+tf/uAXK/QzuxmS9Pp3wPvDN8c7mNXDP5SFus1sl
         1kGQjxK/at3jDqJNZlArwTsGdw4k2bj6kPTcx6f4E3LJ/YXCQsnNELa5CzWcNk+aROxW
         k1lw==
X-Gm-Message-State: AOJu0YyRNHsKu9To6KTdBo/aQ4EiiGE0W1HHN195mffVAxMiKTaGIK30
	lkAOlqg3bpJ/qfrkulxGZM1/l1CUv+qsRRieRS+yrIsuyy4bPqH6rc4z2RVqQTHsn3igcebbQ3+
	wm62izCeIJOGobQw6YRpQh0KYF+jTK79AW5Tjs89SIeYEFnN8KAMXmjlbo3LrKQ==
X-Gm-Gg: ASbGncstSyotufJIWDoJBwW4pv+cdyHdVdereqctmwD9KMVOP8O/Dh1HY1Fsh89H949
	xBklOQ2fd6OJlbWH/Jy1kxi/X1VV3+uRt3ZK98CPRgdX4UWEGABcFGDCE5g4f9dOFjp92lAr1q5
	FDj/AvPxkb/YoZeNG+3TBWiFtIwkT2HYIr5SQw1FOYPgStQQ3jGmJyMRvF9Rs+TxbJ95jN2E5s0
	KJhohfLO7phHcNT3DeYEBqVUfZDvtFGyConnSSgH2nf4VFvIhgD3VJYqSVboJh1ATugDGtiOymU
	ked12pDKvBpxwk+/HL8+SFEtJrcVMLoPZDLmzLgXN3PsDmQQsJPwqB8saZk2Adeauu0J6i61B8V
	F3vSMEBBmDtD6mw==
X-Received: by 2002:a05:6214:33c4:b0:880:5bff:74d6 with SMTP id 6a1803df08f44-8846e16c331mr12082986d6.51.1763590766628;
        Wed, 19 Nov 2025 14:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG56WlPFxLZ+xUxoXWMrJpIJfnEVBJYcG8NscQK+qr9mchmkFNoMy2xH4aNIky2oxUFrfMmpw==
X-Received: by 2002:a05:6214:33c4:b0:880:5bff:74d6 with SMTP id 6a1803df08f44-8846e16c331mr12082416d6.51.1763590766172;
        Wed, 19 Nov 2025 14:19:26 -0800 (PST)
Received: from [172.16.1.8] ([2607:f2c0:b141:ac00:ca1:dc8c:d6d0:7e87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447304sm4426866d6.4.2025.11.19.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:19:25 -0800 (PST)
From: Peter Colberg <pcolberg@redhat.com>
Date: Wed, 19 Nov 2025 17:19:11 -0500
Subject: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
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

Add a method to return the Physical Function (PF) device for a Virtual
Function (VF) device in the bound device context.

Unlike for a PCI driver written in C, guarantee that when a VF device is
bound to a driver, the underlying PF device is bound to a driver, too.

When a device with enabled VFs is unbound from a driver, invoke the
sriov_configure() callback to disable SR-IOV before the unbind()
callback. To ensure the guarantee is upheld, call disable_sriov()
to remove all VF devices if the driver has not done so already.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
---
 rust/kernel/pci.rs | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f9054c52a3bdff2c42273366a4058d943ee5fd76..d6cc5d7e7cd7a3b6e451c0ff5aea044b89c6774a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -120,6 +120,19 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // and stored a `Pin<KBox<T>>`.
         let data = unsafe { pdev.as_ref().drvdata_obtain::<T>() };
 
+        // Always disable SR-IOV before `unbind()` to guarantee that when a VF device is bound
+        // to a driver, the underlying PF device is bound to a driver, too.
+        #[cfg(CONFIG_PCI_IOV)]
+        {
+            // First, allow the driver to gracefully disable SR-IOV by itself.
+            if T::HAS_SRIOV_CONFIGURE && pdev.num_vf() != 0 {
+                let _ = T::sriov_configure(pdev, 0);
+            }
+            // Then, forcibly disable SR-IOV if the driver has not done so already,
+            // to uphold the guarantee with regard to driver binding described above.
+            pdev.disable_sriov();
+        }
+
         T::unbind(pdev, data.as_ref());
     }
 
@@ -332,6 +345,11 @@ fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
     /// [`Device`] by writing the number of Virtual Functions (VF), `nr_virtfn` or zero to the
     /// sysfs file `sriov_numvfs` for this device. Implementing this callback is optional.
     ///
+    /// Further, and unlike for a PCI driver written in C, when a PF device with enabled VFs is
+    /// unbound from its bound [`Driver`], the `sriov_configure()` callback is invoked to disable
+    /// SR-IOV before the `unbind()` callback. This guarantees that when a VF device is bound to a
+    /// driver, the underlying PF device is bound to a driver, too.
+    ///
     /// Upon success, this callback must return the number of VFs that were enabled, or zero if
     /// SR-IOV was disabled.
     ///
@@ -500,6 +518,35 @@ pub fn pci_class(&self) -> Class {
     }
 }
 
+impl Device<device::Bound> {
+    /// Returns the Physical Function (PF) device for a Virtual Function (VF) device.
+    ///
+    /// # Examples
+    ///
+    /// The following example illustrates how to obtain the private driver data of the PF device,
+    /// where `vf_pdev` is the VF device of reference type `&Device<Core>` or `&Device<Bound>`.
+    ///
+    /// ```
+    /// let pf_pdev = vf_pdev.physfn()?;
+    /// let pf_drvdata = pf_pdev.as_ref().drvdata::<MyDriver>()?;
+    /// ```
+    #[cfg(CONFIG_PCI_IOV)]
+    pub fn physfn(&self) -> Result<&Device<device::Bound>> {
+        if !self.is_virtfn() {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
+        //
+        // `physfn` is a valid pointer to a `struct pci_dev` since self.is_virtfn() is `true`.
+        //
+        // `physfn` may be cast to a `Device<device::Bound>` since `pci::Driver::remove()` calls
+        // `disable_sriov()` to remove all VF devices, which guarantees that the underlying
+        // PF device is always bound to a driver when the VF device is bound to a driver.
+        Ok(unsafe { &*(*self.as_raw()).__bindgen_anon_1.physfn.cast() })
+    }
+}
+
 impl Device<device::Core> {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {

-- 
2.51.1


