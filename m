Return-Path: <linux-pci+bounces-41790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 769ACC743CD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD5F2353A26
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBF372AD8;
	Thu, 20 Nov 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cl5fE7e5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED91F0995
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644913; cv=none; b=ajgFoFxyEJJ2HFNmiSf0/xiVP7SO+JaPxt8V/TI5TeoWlorZ9uZHjoxZoR/vwklW0ckXOYEM/M/bZpD/D0duT7Y9vCjUqpxQlxJr9iOwIyU77Oj2/8/79NyukykpT4FHhHeE6MUAj+uXOaP8haFfzRX4kwFCTEywpWpCUt0kIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644913; c=relaxed/simple;
	bh=H4K4KUY2Rzx8q9CqWZhbCnxR9pPbZ7Vwxf6VkBfJ98Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1GLZ+oQPzg7s+Yrlql1+jsY5VRMJVbDQvCoSSl7bgOwwk+W/lwyioJo9U0P7akKdLBMI/PxSJctjF1EKlV49ahCUZ45sD3/YjiaeiUMA+u82/4ZYG2A21ZsD5LLsvns85BAkaqKciDhoA0Q5PCElnFT1rQwHCAFedLb7oQNlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=cl5fE7e5; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A11CE24002D
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 14:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763644909; bh=H4K4KUY2Rzx8q9CqWZhbCnxR9pPbZ7Vwxf6VkBfJ98Y=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:OpenPGP:From;
	b=cl5fE7e504X1rwtiDkf+S2e17/Wa1wh1wQKVwXEzkamJqAzSfBLTA+PaZgFf2jPl0
	 9tX8Z/7IwK2TGmqXEe8rh2Gc6T3cp8hkxq4I9qdrA+NSxBTltjlv4yXe0NFegCukA0
	 WiKfhCfHfoNlD8fO+OCdFgZAORysyLsbqRizQMAM144a4EAEa+5kwoGAOAkhwpeV07
	 k6Wx45GzuqDOPDJ8ISgCgBniYxP6D9OP2Y2cxrFC26qltK9xnTqzQTxaDTZLMXeNhh
	 0myKSd55quK8N5FowWQzUyL8/rg/7k/9uxSj6yTDAHYJnM8rFaf61xR9+BHO6TJI2h
	 Vcljwtdn9IGJA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dBzX96WVSz6twj;
	Thu, 20 Nov 2025 14:21:45 +0100 (CET)
Message-ID: <501ad13182eb1c18f671343a34490deb043c2643.camel@posteo.de>
Subject: Re: [PATCH v9 2/3] rust: leds: split generic and normal led
 classdev abstractions up
From: Markus Probst <markus.probst@posteo.de>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny	 <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Miguel Ojeda	 <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng	 <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich	 <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas	 <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Thu, 20 Nov 2025 13:21:48 +0000
In-Reply-To: <aR7zeX-akq2Zyf8B@google.com>
References: <20251119-rust_leds-v9-0-86c15da19063@posteo.de>
	 <20251119-rust_leds-v9-2-86c15da19063@posteo.de>
	 <aR7zeX-akq2Zyf8B@google.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 R3rOFHA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

On Thu, 2025-11-20 at 10:54 +0000, Alice Ryhl wrote:
> On Wed, Nov 19, 2025 at 02:11:24PM +0000, Markus Probst wrote:
> > Move code specific to normal led class devices into a separate file and
> > introduce the `led::Mode` trait to allow for other types of led class
> > devices.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>=20
> So it seems like the goal of this trait is to support both normal led
> and multicolor led under the same code. However, it seems the traits
> involved with this are pretty complex.
>=20
> My primary feedback here is: please consider if we can avoid these
> complex traits. How much duplication would it really take to just have
> two Device structs and two LedOps traits? I think a few pieces of
> duplication would be far better than what this patch does.
I counted over 221 lines of code for each classdev type (not counting
LedOps). If we want to support `led_classdev_flash` later down the line
(if a Rust driver would need it), that would be over 663 lines of code.

It doesn't look too complex to me, but thats maybe because I wrote it?

>=20
> In fact, I'm not sure you even need two LedOps traits if you did that;
> it seems like you could even get away with reusing the trait for both
> cases.
Currently it only uses one LedOps trait. The implementation in the
multicolor needs access to `Device::subleds()`. `Device` gets passed as
a reference to every LedOps function. If there would be two `Device`
structs, I am not sure how we can preserve one LedOps trait. Possibly a
type declaration on `Mode`? (assuming we still want the `Mode` trait)

Thanks
- Markus Probst

>=20
> Alice

