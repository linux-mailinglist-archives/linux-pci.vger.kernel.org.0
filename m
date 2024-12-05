Return-Path: <linux-pci+bounces-17792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDA9E5C90
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2128E168921
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF222259B;
	Thu,  5 Dec 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw7LGNHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A4218AD3;
	Thu,  5 Dec 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418556; cv=none; b=itSd/eo5HkteKY39UmSj4qK7/STUoCY4wefKbMeS5wubFf/UGwino7JtfrYohc1xjqHN6/lDKzii2TFqu/CdxdsJnvcTNev45JaWdGLa+Uve2ZGH6xILMppFgaS19HT8eKwlmJ8uVCIBTbkrHJtlEHoqyxqCN0iOpxpbejG+vRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418556; c=relaxed/simple;
	bh=I4DEoRstOFcKsUpfYkwh7Milk7wreQOuPu9qeHfesrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AokQKGgkbvKS0CHRVUBHGW3jxUqfOBO1pNFudbnTPZCAg7xaQcdiDNP9zF0Q1NDpfNjcY0QubSrJOxvatHYOswu84QdlZLK8khIOgpH+7HnAbL/S/OF4R5UYdOHd+y/SsAg4VuLuj0xnb0oN+QaBn8NJy9BM/yXxacI4e0ZhHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw7LGNHZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so158667366b.3;
        Thu, 05 Dec 2024 09:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418553; x=1734023353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLTMW2Dj42F10wol8zzpR4Mkc6DH3Pu7ITJmFdh0VZI=;
        b=Tw7LGNHZHJgXEwGZRzaSma+/oMe1KFu6OhEzUKmJ4Fp0hxZ0uxI8RrPqePbu4p6pOQ
         4xpR05CMdiGFArGeY/cQHoVB82kgQmt3ypLdaGz1DIhXppcS6tWMWHV+tHbaC1J+7oL0
         QqbaTgtocbZ6lSvuSKD4wRX2arsHga7pWa3mOnL7TBOcCK8vx1mswHmY+zoAaXB9CcSe
         tPI3UHAo5uexNchQ80pqDhAVL85OPKKhQqIT/MjLTyXorCnywcBQtc4EuoT96sF7Blhp
         MpyXy1in2uRRJm3jPifdxKoHQ8IS/x3OcteJPENtcIJg4MJHYWBgV6UwyD7O4Mf8HbQO
         F8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418553; x=1734023353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLTMW2Dj42F10wol8zzpR4Mkc6DH3Pu7ITJmFdh0VZI=;
        b=X1VSUQoT8gXIGZnc9XukfuTFkYuOk9dhrAy0gMZTh8gINYq5w/KfI5TI0vsmKzcI+A
         1MIQpSuKj5hbFPLh40ZcC6K1B5I6DJBMspGjRkli4WNBwf1GBhhXBmvcd5Aj/5qZiH3I
         pq8n7fCZjoMVAjpGv5I+crEQuS302X2a3/C2Mr0W1ssie4iWn+U6v9tOVlBMBAOncJDy
         dIbnGGgjnpsd9ybdZmEj2AYaLcZlI1Q11gIYArnn9IpYj8t+4mVPWPXMUwmNlndq6B8k
         6zCOVYf+hXX1BXhP+7y4UXGo9roM06KME75Rdg7IJ9vIXEpw7+eUqmfCie5oOtaDLRsd
         uLMw==
X-Forwarded-Encrypted: i=1; AJvYcCU53rlW0loGXEfx/XYEYyrN8PMc6lgte4b5n8Obdw6dYtfW4qqrhcpGNz57IulSwV5cfZHrV8DsqjwSGhLR@vger.kernel.org, AJvYcCUdk76B7n9HloQLH+vMh2SzE2yUZNQFw1gcpPuZRQb3D/EzHJCUBWpZFfdM072V5gJmzIIkklzRKXw4@vger.kernel.org, AJvYcCX4bkW/Z6eKAmxuOhdnXGvL0GiZgh/Cn354zjsQTXJhl4MGtawVt4QI9NnbnSbVENuQrMPBMv4o1NDy@vger.kernel.org
X-Gm-Message-State: AOJu0YysR8VXARiXa+RvbQXoLHocfA92BZJElgupnu0OM7aLV8/lkQng
	0d3ez21V3jrJFu6M39eLO0wH9XU95a8kpqwZUQnE5qXAXR1Qw26v
X-Gm-Gg: ASbGncvHIb42v6C12P4Cgj8EbJIJr0y76n0P3SvyUrwEVY5HkgDUj4m7QF6yh6k+Efy
	XOvEabkS59YuZx535GfWajW9Rjz3o/iKel4gWwVqtfyX8kWaIPHYmChX9V5kaq8EFQnkCCW81TS
	Bu0PHRnGI1GBbAmxi8/jCjB0oswfcYelaXPxuVSMmUQArWTstr1NLwBdpn8zkfMAFFV9XU1Dmhf
	9k5v8jeXrPaEJKTUKowwpO1VLGAB6E0bOaZ/TzPKD6S5XVg8m4j01pCpn+uaflhqBDRnv/33k70
	aWvJCzNbAdX6SVPC02WwSY8+yYcLZlMr3B8PainH+l7aQvgaYxu+DqHV58gJ4g0WzTGfzbgrG0o
	JveaXsw==
X-Google-Smtp-Source: AGHT+IHp4L56zZx8xVirTEtsBRdCV6sYlMC7xhSpCQg4VJ/JPZqPaD/WMENWNwroqnO/GnB/9bnPDw==
X-Received: by 2002:aa7:d455:0:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d10cb5649emr16914349a12.12.1733418551999;
        Thu, 05 Dec 2024 09:09:11 -0800 (PST)
Received: from ?IPV6:2003:df:bf0d:b400:f2bf:b7b6:c9e8:82e1? (p200300dfbf0db400f2bfb7b6c9e882e1.dip0.t-ipconnect.de. [2003:df:bf0d:b400:f2bf:b7b6:c9e8:82e1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b620sm118305566b.125.2024.12.05.09.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:09:11 -0800 (PST)
Message-ID: <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com>
Date: Thu, 5 Dec 2024 18:09:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com,
 j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-14-dakr@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241205141533.111830-14-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Danilo,

On 05.12.24 15:14, Danilo Krummrich wrote:
> Add a sample Rust platform driver illustrating the usage of the platform
> bus abstractions.
> 
> This driver probes through either a match of device / driver name or a
> match within the OF ID table.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Not a review comment, but a question/proposal:

What do you think to convert the platform sample into an example/test?
And drop it in samples/rust then? Like [1] below?

We would have (a) a complete example in the documentation and (b) some
(KUnit) test coverage and (c) have one patch less in the series and
(d) one file less to maintain long term.

I think to remember that it was mentioned somewhere that a
documentation example / KUnit test is preferred over samples/rust (?).

Just an idea :)

Best regards

Dirk

[1]

diff --git a/MAINTAINERS b/MAINTAINERS
index ae576c842c51..365fc48b7041 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7035,7 +7035,6 @@ F:	rust/kernel/device_id.rs
 F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 F:	rust/kernel/platform.rs
-F:	samples/rust/rust_driver_platform.rs

 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 868cfddb75a2..77aeb6fc2120 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -142,30 +142,55 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, of, platform};
+/// # mod mydriver {
+/// #
+/// # // Get this into the scope of the module to make the
assert_eq!() buildable
+/// # static __DOCTEST_ANCHOR: i32 = core::line!() as i32 - 4;
+/// #
+/// # use kernel::{c_str, of, platform, prelude::*};
+/// #
+/// struct MyDriver {
+///     pdev: platform::Device,
+/// }
 ///
-/// struct MyDriver;
+/// struct Info(u32);
 ///
 /// kernel::of_device_table!(
 ///     OF_TABLE,
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
-///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
-///     ]
+///     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
 /// );
 ///
 /// impl platform::Driver for MyDriver {
-///     type IdInfo = ();
+///     type IdInfo = Info;
 ///     const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
 ///
-///     fn probe(
-///         _pdev: &mut platform::Device,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> Result<Pin<KBox<Self>>> {
-///         Err(ENODEV)
+///     fn probe(pdev: &mut platform::Device, info:
Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver
sample.\n");
+///
+///         assert_eq!(info.unwrap().0, 42);
+///
+///         let drvdata = KBox::new(Self { pdev: pdev.clone() },
GFP_KERNEL)?;
+///
+///         Ok(drvdata.into())
+///     }
+/// }
+///
+/// impl Drop for MyDriver {
+///     fn drop(&mut self) {
+///         dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver
sample.\n");
 ///     }
 /// }
+///
+/// kernel::module_platform_driver! {
+///     type: MyDriver,
+///     name: "rust_driver_platform",
+///     author: "Danilo Krummrich",
+///     description: "Rust Platform driver",
+///     license: "GPL v2",
+/// }
+/// # }
 ///```
 pub trait Driver {
     /// The type holding information about each device id supported
by the driver.
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 70126b750426..6d468193cdd8 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -41,16 +41,6 @@ config SAMPLE_RUST_DRIVER_PCI

 	  If unsure, say N.

-config SAMPLE_RUST_DRIVER_PLATFORM
-	tristate "Platform Driver"
-	help
-	  This option builds the Rust Platform driver sample.
-
-	  To compile this as a module, choose M here:
-	  the module will be called rust_driver_platform.
-
-	  If unsure, say N.
-
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 761d13fff018..2f5b6bdb2fa5 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -4,7 +4,6 @@ ccflags-y += -I$(src)				# needed for trace events
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
-obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o

 rust_print-y := rust_print_main.o rust_print_events.o

diff --git a/samples/rust/rust_driver_platform.rs
b/samples/rust/rust_driver_platform.rs
deleted file mode 100644
index 2f0dbbe69e10..000000000000
--- a/samples/rust/rust_driver_platform.rs
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Rust Platform driver sample.
-
-use kernel::{c_str, of, platform, prelude::*};
-
-struct SampleDriver {
-    pdev: platform::Device,
-}
-
-struct Info(u32);
-
-kernel::of_device_table!(
-    OF_TABLE,
-    MODULE_OF_TABLE,
-    <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
-);
-
-impl platform::Driver for SampleDriver {
-    type IdInfo = Info;
-    const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
-
-    fn probe(pdev: &mut platform::Device, info:
Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
-        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
-
-        if let Some(info) = info {
-            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n",
info.0);
-        }
-
-        let drvdata = KBox::new(Self { pdev: pdev.clone() },
GFP_KERNEL)?;
-
-        Ok(drvdata.into())
-    }
-}
-
-impl Drop for SampleDriver {
-    fn drop(&mut self) {
-        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver
sample.\n");
-    }
-}
-
-kernel::module_platform_driver! {
-    type: SampleDriver,
-    name: "rust_driver_platform",
-    author: "Danilo Krummrich",
-    description: "Rust Platform driver",
-    license: "GPL v2",
-}


