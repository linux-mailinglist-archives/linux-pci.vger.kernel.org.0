Return-Path: <linux-pci+bounces-40082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C405CC2A37F
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 07:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 719EB344C0B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 06:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83C27FB35;
	Mon,  3 Nov 2025 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NlUR5wDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB327146B;
	Mon,  3 Nov 2025 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152258; cv=none; b=TBfdeW6XbUim5dFgoDKAZRaYa+CxY3HhrRh7cJlfz4R1cRehR83CtWiJVU68wzuVI3SiDPbvOIK1Fu0r0pJofHqTeRV+6qol/WdnKrLb1ZPjqAuci/JKnYfWYEo77mZ7OCFLadwkruf0kswdcjtZYJRzZAJrIMmiNsFb0txAhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152258; c=relaxed/simple;
	bh=s6TBw8Z7arpd85zMJYTbJ335nuLfyRFS4btaVMHiPOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz1j5uA8s1Eb38izQ2SfvXIH/m3kxpigZR+CQP4wCc3eljtVQKrELCtUUlyg6VtAI2rVp5S/NaV5eY60LvRe0xdCJ9fiMS5RKjc3BoVeFWEu4APIU9jQz6OEkFzqAhCEOmdoW153xLcl2axf9A4FBn8lLXQJd+AlkGNZQ3mqyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NlUR5wDS; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3VP4bf0C1euyy0fUZuVCkJWtwbHxu2zWGGoC2mJKs+w=; t=1762152256;
	x=1762584256; b=NlUR5wDSkR1aIQ8QQ63y8Bzw0zQvh1bwSiKj1NoO5CetPrWq/9KwwfthLTWYM
	k/lYcR5txXYSAyeQvXJ8/GC9JMQWCxg1MoS/7RldoU+yzkpITIUn8IfYQ+hQgqn2dfKKCwh293ZBt
	LzSeD7EOO/ztz/A06cO5dfWhTvJ6ZWA17BwRTN5K9bI4DLFmh/clrEzT0MMy3UHTkGgzGo8A4+Jd2
	01DheLLntZ/N26Fdw9hTFJvGPrJNrbyyYCbyAdpzaS/orY/Pu3BWb2i8JPcEF60gvwF0y1YHC2+vG
	DETKTypVIM/DTW5uDGQX5j4mnr9wQ5jEJFgpDCjT6W6G2NzC/A==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vFoIH-00CiK4-0h;
	Mon, 03 Nov 2025 07:43:57 +0100
Message-ID: <1c8afbc0-e888-4702-9e4e-fa8aef0f97ae@leemhuis.info>
Date: Mon, 3 Nov 2025 07:43:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Build error on -next in rust/kernel/usb.rs:92:34 (was: Re: [PATCH
 1/8] rust: device: narrow the generic of drvdata_obtain())
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
 acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, pcolberg@redhat.com,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020223516.241050-1-dakr@kernel.org>
 <20251020223516.241050-2-dakr@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20251020223516.241050-2-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1762152256;7b1e0a23;
X-HE-SMSGID: 1vFoIH-00CiK4-0h

On 10/21/25 00:34, Danilo Krummrich wrote:
> Let T be the actual private driver data type without the surrounding
> box, as it leaves less room for potential bugs.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This patch showed up in linux-next today and I wonder if that caused my
build to break on arm64 and x86:64. The error message looked like this
during "make bzimage":

"""
error[E0599]: no method named `data` found for struct `core::pin::Pin<kbox::Box<T, Kmalloc>>` in the current scope
  --> rust/kernel/usb.rs:92:34
   |
92 |         T::disconnect(intf, data.data());
   |                                  ^^^^ method not found in `core::pin::Pin<kbox::Box<T, Kmalloc>>`

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0599`.
make[2]: *** [rust/Makefile:553: rust/kernel.o] Error 1
make[1]: *** [/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251103/linux-6.18.0-0.0.next.20251103.436.vanilla.fc44.x86_64/Makefile:1316: prepare] Error 2
make: *** [Makefile:256: __sub-make] Error 2
"""

Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/09759703-next-next-all/builder-live.log.gz

A quick search for "T::disconnect(intf, data.data());" on lore
lead me here:

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 9238b96c2185..05eed3f4f73e 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -87,9 +87,9 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
>          // SAFETY: `disconnect_callback` is only ever called after a successful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
>          // and stored a `Pin<KBox<T>>`.
> -        let data = unsafe { dev.drvdata_obtain::<Pin<KBox<T>>>() };
> +        let data = unsafe { dev.drvdata_obtain::<T>() };
>  
> -        T::disconnect(intf, data.as_ref());
> +        T::disconnect(intf, data.data());
>      }
>  }


Ciao, Thorsten

