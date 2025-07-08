Return-Path: <linux-pci+bounces-31729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8FAFDB5C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FF73A8E06
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 22:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E290E2264A7;
	Tue,  8 Jul 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa4QQGD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73E22331C;
	Tue,  8 Jul 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015092; cv=none; b=p9hZv1Qay+MvR0BfZiQH9y/5p6ae1CxgC6Ijzoj0licrhT/9DFhASqEw4SdIGSl2iRsWMhrfef9F1CKr4wg93XheJp5stWsUBhEdO9UrpmSDtSoJsOChgc1zVGZsYWAaKRmHFzdY9tMVn1xmPN+p6X5QGltI72TpvtnDAeXyr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015092; c=relaxed/simple;
	bh=2BPqfUcttv0EZxTvpxu93KNE1aoct6tDcUZmdKu92Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OndTQE6R950Z2DGGEYxRNj/IJA0fbNtGBLn1FOhCaoSFce3a69T/qfUBZd+pmb35Z8P9P/waXf+tABrg4VwBjthAAow/nkBw8ALY+Ms5VYQw3Pv73W++G4uhId03i8Qktu6nGi+PW/tG1zJZhxg5qWmbmrgJzwfsqHkopYi1Ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa4QQGD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2987EC4CEED;
	Tue,  8 Jul 2025 22:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752015092;
	bh=2BPqfUcttv0EZxTvpxu93KNE1aoct6tDcUZmdKu92Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aa4QQGD54wYrbC2s7BDuFiJeKjRsM2Jbanil5tsAwkTfNRmM1zyCnZwjUEDPNoqBc
	 5zgDUyuK9dWVp3U9lLa7cNqkMgp9Rf1s9vvsfNINshi/oJdnlAJacf3lLpsmTx8OS/
	 hy80TeYUPmZgcyHcqT39+BHlDEp89SzU8wdkaDxQjXGSajMF5aNQmcNUCkszVD0rGj
	 QC/ficGvoctYNHGOSPUDBNuqbMgIz3XEHmmyD024U1+WenPu+b+xkZMBUWaNwXCLNw
	 1UN1iuPIAMAInnR5WclnKky8Cmf6sVLoZdEYFq/OOWWIOQm81JYrdmqiSuzj5XTYPo
	 yKL1EbDiMECyQ==
Date: Wed, 9 Jul 2025 00:51:24 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, kuba@kernel.org,
	gregkh@linuxfoundation.org, robh@kernel.org, saravanak@google.com,
	alex.gaynor@gmail.com, ojeda@kernel.org, rafael@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
	david.m.ertman@intel.com, devicetree@vger.kernel.org,
	gary@garyguo.net, ira.weiny@intel.com, kwilczynski@kernel.org,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lossin@kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
Message-ID: <aG2g7HgDdvmFJpMz@pollux>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250707175350.1333bd59@kernel.org>
 <CANiq72=LUKSx6Sb4ks7Df6pyNMVQFnUY8Jn6TpoRQt-Eh5bt8w@mail.gmail.com>
 <20250708.195908.2135845665984133268.fujita.tomonori@gmail.com>
 <DB6OOFKHIXQB.3PYJZ49GXH8MF@kernel.org>
 <CANiq72=Cbvrcwqt6PQHwwDVTx1vnVnQ7JBzzXk+K-7Va_OVHEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=Cbvrcwqt6PQHwwDVTx1vnVnQ7JBzzXk+K-7Va_OVHEQ@mail.gmail.com>

On Tue, Jul 08, 2025 at 08:47:13PM +0200, Miguel Ojeda wrote:
> Thanks Danilo -- ditto. Even netdev could make sense as you said.
> 
> Since it touched several subsystems and it is based on rust-next, I am
> happy to do so, but driver-core makes sense given that is the main
> change after all.
> 
> So if I don't see you picking it, I will eventually do it.

Checked again and the driver-core tree makes most sense, since we also need to
fix up the ACPI device ID code, which is queued up in driver-core-next.

I also caught a missing change in rust/kernel/driver.rs, which most likely
slipped through by not building with CONFIG_OF. :)

Here's the diff to fix up both, I already fixed it up on my end -- no need to
send a new version.

--

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 2af4d4f92924..7ae317368b00 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -2,7 +2,11 @@

 //! Advanced Configuration and Power Interface abstractions.

-use crate::{bindings, device_id::RawDeviceId, prelude::*};
+use crate::{
+    bindings,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
+    prelude::*,
+};

 /// IdTable type for ACPI drivers.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
@@ -12,13 +16,14 @@
 #[derive(Clone, Copy)]
 pub struct DeviceId(bindings::acpi_device_id);

-// SAFETY:
-// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct acpi_device_id` and does not add
-//   additional invariants, so it's safe to transmute to `RawType`.
-// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `acpi_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
 unsafe impl RawDeviceId for DeviceId {
     type RawType = bindings::acpi_device_id;
+}

+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);

     fn index(&self) -> usize {
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index f8dd7593e8dc..573d516b2f06 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -170,7 +170,7 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };

-                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id)))
             }
         }
     }
@@ -204,7 +204,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
                 // and does not add additional invariants, so it's safe to transmute.
                 let id = unsafe { &*raw_id.cast::<of::DeviceId>() };

-                Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+                Some(table.info(<of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id)))
             }
         }
     }


