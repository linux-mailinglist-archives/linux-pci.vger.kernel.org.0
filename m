Return-Path: <linux-pci+bounces-40100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B25C2B29F
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D949E3BB18D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA62FFFA7;
	Mon,  3 Nov 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R654j01t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A92FD69B;
	Mon,  3 Nov 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166994; cv=none; b=lrXHJShZ7zHg+W1CrqHNpVlv5fr6g6MSYgNMYlecz89j3t3o4s98sHSr9g93uWuptp/xIVOKkHU7ajoTyOL2O461npcNvz1acCbMPV8jE49xwqy3NJn1EMJsTzaoCXYJrniVtzPSR2q4iGkPQDD7AAVOuBQDegcep59BNbNLwBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166994; c=relaxed/simple;
	bh=uUifxonKcla3BWytmq2yxQx+E6zovUda0T3W9rcNDck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJwdjAUDMje3toXMNO+ntWjEb3WifeHGybrIMO3B4jDulz5mOmd05gHiIgYSmiDsi7xrM5bgPutsy6iLOqnKJpnC3cTgeLVx6bymJP069DbBVfHbsL71YrkpjC7ovrAfCNrFHDJBJcn6Wd+M3zP2mpqQK1NwvLamnW3/PVRPw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R654j01t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5903DC4CEF8;
	Mon,  3 Nov 2025 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762166994;
	bh=uUifxonKcla3BWytmq2yxQx+E6zovUda0T3W9rcNDck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R654j01tkgr7j+kGctXGIU7wXdjqv9jn/OELsSKcDst5bpbuP0wRucegkwsqf/Aiu
	 IJktZHywCzfnkRDZsFHJQ5H6QkW9S+m31mYwJqq6gpV5PJjFrocgDpHPBnqbBoyjev
	 YhWoKyHS3b/u2HFvQCiiTyrfOI8rGYxzpdjaAxI1kUSOl2hERJ+aV+p1HzmZw8hEOJ
	 mqtmD7ChPljk8VWDVxn3KhmuyedV1bY1oi2UCzNup3eRP5CgmcmvRVlAPm6MLnKL33
	 J+r3xdNbig6e9bWe+QUbIJy/JxUvmitqi78ft1WAl4qIaPguQG4mkHFlRNYDv7fxd2
	 vyOdw0liTWB0Q==
Message-ID: <bebb6b2b-869d-4931-adb3-de5a2a201401@kernel.org>
Date: Mon, 3 Nov 2025 11:49:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build error on -next in rust/kernel/usb.rs:92:34
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, acourbot@nvidia.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, pcolberg@redhat.com,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020223516.241050-1-dakr@kernel.org>
 <20251020223516.241050-2-dakr@kernel.org>
 <1c8afbc0-e888-4702-9e4e-fa8aef0f97ae@leemhuis.info>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <1c8afbc0-e888-4702-9e4e-fa8aef0f97ae@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 7:43 AM, Thorsten Leemhuis wrote:
> """
> error[E0599]: no method named `data` found for struct `core::pin::Pin<kbox::Box<T, Kmalloc>>` in the current scope
>   --> rust/kernel/usb.rs:92:34
>    |
> 92 |         T::disconnect(intf, data.data());
>    |                                  ^^^^ method not found in `core::pin::Pin<kbox::Box<T, Kmalloc>>`
> 
> error: aborting due to 1 previous error
> 
> For more information about this error, try `rustc --explain E0599`.
> make[2]: *** [rust/Makefile:553: rust/kernel.o] Error 1
> make[1]: *** [/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251103/linux-6.18.0-0.0.next.20251103.436.vanilla.fc44.x86_64/Makefile:1316: prepare] Error 2
> make: *** [Makefile:256: __sub-make] Error 2
> """
> 
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/09759703-next-next-all/builder-live.log.gz
> 
> A quick search for "T::disconnect(intf, data.data());" on lore
> lead me here:
> 
>> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
>> index 9238b96c2185..05eed3f4f73e 100644
>> --- a/rust/kernel/usb.rs
>> +++ b/rust/kernel/usb.rs
>> @@ -87,9 +87,9 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
>>          // SAFETY: `disconnect_callback` is only ever called after a successful call to
>>          // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
>>          // and stored a `Pin<KBox<T>>`.
>> -        let data = unsafe { dev.drvdata_obtain::<Pin<KBox<T>>>() };
>> +        let data = unsafe { dev.drvdata_obtain::<T>() };
>>  
>> -        T::disconnect(intf, data.as_ref());
>> +        T::disconnect(intf, data.data());
>>      }
>>  }

This error is cause by commit 6bbaa93912bf ("rust: device: narrow the generic of
drvdata_obtain()").

It seems it slipped through, since the USB abstractions are disabled in all
trees other than the USB tree. I tested with enabling them locally, but it seems
I forgot to re-enable them after a rebase etc.

I will send a patch with the following fix:

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 92215fdc3c6a..534e3ded5442 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -89,7 +89,7 @@ extern "C" fn disconnect_callback(intf: *mut
bindings::usb_interface) {
         // and stored a `Pin<KBox<T>>`.
         let data = unsafe { dev.drvdata_obtain::<T>() };

-        T::disconnect(intf, data.data());
+        T::disconnect(intf, data.as_ref());
     }
 }

