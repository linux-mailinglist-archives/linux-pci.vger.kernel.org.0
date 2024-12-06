Return-Path: <linux-pci+bounces-17835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D449E6A17
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BB218859DC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925E1E1322;
	Fri,  6 Dec 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixuE945n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DF1DFE16;
	Fri,  6 Dec 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477375; cv=none; b=KpqhMxLY8PZD6KbV8ToI0kemaIJ+Y/Wh1CbUXqhFcRkGnVhBxfbwwD8mF45bCzZCqWSpLj49qXIn6QS9GPaGROaBEg+cLXvRid/MTK4sFNzNuGIk4KMkD4/6Abae0IpLBy50WOzlBZ6weShplfE0V2wOINpSTeo2kMZOqI252EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477375; c=relaxed/simple;
	bh=z3UgihyWzrbkvKFliqv8LzUML9WKdI0gtnwfc2ODd0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7XtZ2aSVR4KhZMbRCjY8Ey2jgULn6k1zH5EyqTGJcl4BhWRObRP0l/caQeSbOKbEU3FY2Ux/EroiJX5/M29rdLqVreYWvUWCBmca8x26bVkb44tUVmG2mCpyqRMBstzoNzG/lb0vD3s18tZwKV6QEiWz3cvHP8mYs+81tgJHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixuE945n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a45f05feso20377215e9.3;
        Fri, 06 Dec 2024 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733477372; x=1734082172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stbx1NEM35bVdNwXBH7Qjy70Xo3jWZihLJ77LxtbkVE=;
        b=ixuE945nQKK7jste/NZKiGAnv5EKR7xh9cLSs319X5wZznk5/QOop+ABZOwfjWKhTC
         vHLlfjNuG729FmG6JDG45k6Z1YIRrwV0XPpCd6B9aNqbsGVDmPEjGEkjPNfHVuH+KsFb
         mH1t/4cPZFMwy2wULfpAFSF7Cb9nvh7XTMMmqbymna/BwshDkmC2xf5aa4dGLrB+c2te
         OPTCASVZM7bSYpbtEP5VkySOZ3DUL3gc68/tEXv1XXa8b4yWNhyWBYCyd0hfsp3/9/KQ
         ogg1VV+DIewtd95TSiOmE7i1dNfqcHbZRRWMMDI7Xq1AOtAKnGVNZc1bXhwDH6sGiUXl
         biFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477372; x=1734082172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stbx1NEM35bVdNwXBH7Qjy70Xo3jWZihLJ77LxtbkVE=;
        b=Jq4aA/rkZFgS/W2P1/ky/wPw9iORkw9CGX9UGjzNRfz5pMKYvK6SGqF0TYKJb9HbZ9
         /PCKbXQDFBIMiXkRHphH5dPwP6OdtD0twLWA9WFEhBJQ/MLt9vwks29egtcC289pDw1Q
         RMipei6YKQT0/pWNQvl11kv8CU3qqIzU9JrWEchRuTIC/0z0ftvFdMqTd775tZ8h6vez
         eoHCNUvuP1moOOZanfexD5hW+rGWrWQw5yPByT70WFk0JdDbRQRP18P1ZkV1wUUUNz6G
         xP5ucf2hfYxW0Z3UX9lVPNpUfQ8//Fe7BVbcG3JtbQG2csYkYcK89qeDHun4CBhWVG96
         qsHw==
X-Forwarded-Encrypted: i=1; AJvYcCV4hMwMl65uNDI46OtG6VFpspG7exiaJ08SND+Rq8qcpfCXeq8As0epbDUYs7uH6WnD8dtCwpZmI7HUGLJu+uo=@vger.kernel.org, AJvYcCVqg5MgEwusNPZVwUGLjvtHCWG3u4+UiA0kRjmrrthTjt0OUbr+nkMcncJFRynMoofJM8naX7t2kv9J@vger.kernel.org, AJvYcCWRAd5ecHr4nEwSXowEl/1IDugn+2LPFn7Jaz/hcq95+cXTJdf3nF2OVQRytxsfMt6/1Pjdh0TVnQnx0PJt@vger.kernel.org, AJvYcCWqSwOqYpBQdkMFpDDRkXzs0vX6n0JTbSnnvtSuPrcAQzieWQj9EVmvw9JN06L4//JUiBPLvZeLaMyy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64JGeqW0rx9gEot/muOMLvf6e6PduBf7TAdN7Eny2bXZKNW+T
	Xnu6gsB9HFcosHrUCNQr5rwGyW+gtdJ2lgMtnECkH3vZyzCtwGe9
X-Gm-Gg: ASbGnctY+u2rT+FWoBbupdzQjldD1KAje5r+Q07UXMNT/gLp7yusYLDU2vuQ4IKWI1r
	EE3ipikvtExDMPwTBks1nQm0IiOa8Bkl8/Xgo/Ae33rEaXHT9o8grMbn6u5GRxnbkIIy3lIpEtL
	gh3hJW9JzeD4SdCXWu0UHgIyz6uesAoBfj7aub34Jz+AsBnkwMRMhcD2CqHj2VzAWHOkaw1Ug0n
	jLZsRCKpRFvdFHT0/yDD3AV4AeV61odQbLLR77aOfbgekPyOK8JmUHX0z7fk11hRTm0Fydau8t2
	9ZTcHTgm81xAj5Dc5QC/XfPa0qdTPL5yA2PINmI/UuQJarQBjB9xM5O56pCGSE/UIrqQtGLSY7o
	hJwJu5w==
X-Google-Smtp-Source: AGHT+IGFIYyUD9HEqIG73xUb72UXx8tEHaiNhA0ipV2EB4tCdQu8+kXVLo5dUDpxcqbC3LEkvZb7ew==
X-Received: by 2002:a05:600c:458a:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-434ddee1384mr17702945e9.33.1733477371270;
        Fri, 06 Dec 2024 01:29:31 -0800 (PST)
Received: from ?IPV6:2003:df:bf0d:b400:44f9:3850:f4a9:a264? (p200300dfbf0db40044f93850f4a9a264.dip0.t-ipconnect.de. [2003:df:bf0d:b400:44f9:3850:f4a9:a264])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d691csm51269205e9.11.2024.12.06.01.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:29:30 -0800 (PST)
Message-ID: <417cebcb-6311-43c3-a74f-edef10be0fb7@gmail.com>
Date: Fri, 6 Dec 2024 10:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
 pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com,
 j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-14-dakr@kernel.org>
 <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com> <Z1K22NjYjwhFnsit@pollux>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <Z1K22NjYjwhFnsit@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.12.24 09:33, Danilo Krummrich wrote:
> On Thu, Dec 05, 2024 at 06:09:10PM +0100, Dirk Behme wrote:
>> Hi Danilo,
>>
>> On 05.12.24 15:14, Danilo Krummrich wrote:
>>> Add a sample Rust platform driver illustrating the usage of the platform
>>> bus abstractions.
>>>
>>> This driver probes through either a match of device / driver name or a
>>> match within the OF ID table.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> Not a review comment, but a question/proposal:
>>
>> What do you think to convert the platform sample into an example/test?
>> And drop it in samples/rust then? Like [1] below?
> 
> Generally, I think doctests are indeed preferrable. In this particular case
> though, I think it's better to have a sample module, since this way it can serve
> as go-to example of how to write a platform driver in Rust.
> 
> Especially for (kernel) folks who do not have a Rust (for Linux) background it's
> way more accessible.


Yes, ack. Rob said the same :)

Thanks

Dirk


>> We would have (a) a complete example in the documentation and (b) some
>> (KUnit) test coverage and (c) have one patch less in the series and
>> (d) one file less to maintain long term.
>>
>> I think to remember that it was mentioned somewhere that a
>> documentation example / KUnit test is preferred over samples/rust (?).
>>
>> Just an idea :)
>>
>> Best regards
>>
>> Dirk
>>
>> [1]
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ae576c842c51..365fc48b7041 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7035,7 +7035,6 @@ F:	rust/kernel/device_id.rs
>>  F:	rust/kernel/devres.rs
>>  F:	rust/kernel/driver.rs
>>  F:	rust/kernel/platform.rs
>> -F:	samples/rust/rust_driver_platform.rs
>>
>>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>>  M:	Nishanth Menon <nm@ti.com>
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index 868cfddb75a2..77aeb6fc2120 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -142,30 +142,55 @@ macro_rules! module_platform_driver {
>>  /// # Example
>>  ///
>>  ///```
>> -/// # use kernel::{bindings, c_str, of, platform};
>> +/// # mod mydriver {
>> +/// #
>> +/// # // Get this into the scope of the module to make the
>> assert_eq!() buildable
>> +/// # static __DOCTEST_ANCHOR: i32 = core::line!() as i32 - 4;
>> +/// #
>> +/// # use kernel::{c_str, of, platform, prelude::*};
>> +/// #
>> +/// struct MyDriver {
>> +///     pdev: platform::Device,
>> +/// }
>>  ///
>> -/// struct MyDriver;
>> +/// struct Info(u32);
>>  ///
>>  /// kernel::of_device_table!(
>>  ///     OF_TABLE,
>>  ///     MODULE_OF_TABLE,
>>  ///     <MyDriver as platform::Driver>::IdInfo,
>> -///     [
>> -///         (of::DeviceId::new(c_str!("test,device")), ())
>> -///     ]
>> +///     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
>>  /// );
>>  ///
>>  /// impl platform::Driver for MyDriver {
>> -///     type IdInfo = ();
>> +///     type IdInfo = Info;
>>  ///     const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
>>  ///
>> -///     fn probe(
>> -///         _pdev: &mut platform::Device,
>> -///         _id_info: Option<&Self::IdInfo>,
>> -///     ) -> Result<Pin<KBox<Self>>> {
>> -///         Err(ENODEV)
>> +///     fn probe(pdev: &mut platform::Device, info:
>> Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
>> +///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver
>> sample.\n");
>> +///
>> +///         assert_eq!(info.unwrap().0, 42);
>> +///
>> +///         let drvdata = KBox::new(Self { pdev: pdev.clone() },
>> GFP_KERNEL)?;
>> +///
>> +///         Ok(drvdata.into())
>> +///     }
>> +/// }
>> +///
>> +/// impl Drop for MyDriver {
>> +///     fn drop(&mut self) {
>> +///         dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver
>> sample.\n");
>>  ///     }
>>  /// }
>> +///
>> +/// kernel::module_platform_driver! {
>> +///     type: MyDriver,
>> +///     name: "rust_driver_platform",
>> +///     author: "Danilo Krummrich",
>> +///     description: "Rust Platform driver",
>> +///     license: "GPL v2",
>> +/// }
>> +/// # }
>>  ///```
>>  pub trait Driver {
>>      /// The type holding information about each device id supported
>> by the driver.
>> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>> index 70126b750426..6d468193cdd8 100644
>> --- a/samples/rust/Kconfig
>> +++ b/samples/rust/Kconfig
>> @@ -41,16 +41,6 @@ config SAMPLE_RUST_DRIVER_PCI
>>
>>  	  If unsure, say N.
>>
>> -config SAMPLE_RUST_DRIVER_PLATFORM
>> -	tristate "Platform Driver"
>> -	help
>> -	  This option builds the Rust Platform driver sample.
>> -
>> -	  To compile this as a module, choose M here:
>> -	  the module will be called rust_driver_platform.
>> -
>> -	  If unsure, say N.
>> -
>>  config SAMPLE_RUST_HOSTPROGS
>>  	bool "Host programs"
>>  	help
>> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
>> index 761d13fff018..2f5b6bdb2fa5 100644
>> --- a/samples/rust/Makefile
>> +++ b/samples/rust/Makefile
>> @@ -4,7 +4,6 @@ ccflags-y += -I$(src)				# needed for trace events
>>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>> -obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>>
>>  rust_print-y := rust_print_main.o rust_print_events.o
>>
>> diff --git a/samples/rust/rust_driver_platform.rs
>> b/samples/rust/rust_driver_platform.rs
>> deleted file mode 100644
>> index 2f0dbbe69e10..000000000000
>> --- a/samples/rust/rust_driver_platform.rs
>> +++ /dev/null
>> @@ -1,49 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -
>> -//! Rust Platform driver sample.
>> -
>> -use kernel::{c_str, of, platform, prelude::*};
>> -
>> -struct SampleDriver {
>> -    pdev: platform::Device,
>> -}
>> -
>> -struct Info(u32);
>> -
>> -kernel::of_device_table!(
>> -    OF_TABLE,
>> -    MODULE_OF_TABLE,
>> -    <SampleDriver as platform::Driver>::IdInfo,
>> -    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
>> -);
>> -
>> -impl platform::Driver for SampleDriver {
>> -    type IdInfo = Info;
>> -    const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
>> -
>> -    fn probe(pdev: &mut platform::Device, info:
>> Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
>> -        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
>> -
>> -        if let Some(info) = info {
>> -            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n",
>> info.0);
>> -        }
>> -
>> -        let drvdata = KBox::new(Self { pdev: pdev.clone() },
>> GFP_KERNEL)?;
>> -
>> -        Ok(drvdata.into())
>> -    }
>> -}
>> -
>> -impl Drop for SampleDriver {
>> -    fn drop(&mut self) {
>> -        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver
>> sample.\n");
>> -    }
>> -}
>> -
>> -kernel::module_platform_driver! {
>> -    type: SampleDriver,
>> -    name: "rust_driver_platform",
>> -    author: "Danilo Krummrich",
>> -    description: "Rust Platform driver",
>> -    license: "GPL v2",
>> -}
>>


