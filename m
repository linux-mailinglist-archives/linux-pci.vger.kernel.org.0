Return-Path: <linux-pci+bounces-32020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0525B03179
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1117C875
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831A27979C;
	Sun, 13 Jul 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxyHEfUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BF27815C;
	Sun, 13 Jul 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416854; cv=none; b=qdGek709Wfq8KpFNeHfwr9eOyPuP/x8jpFX/QwYjJV5OeSHu/7xppb2d+u/GbvFyiwfU7w7ARqqLXCWLfR1V92klfvkxFQLPanQDQ63HwpL6yN3VRIg/dcUt8fA9mPS10kpiRVfFAhZhpKztAl1CFsg+hN5PouphnI9sHhpc2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416854; c=relaxed/simple;
	bh=lWlEeob8ZmQpxvcDxDzxk/MN8KbZC//aM/OVmb2B14M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=b072ew2xq8d9m5TU9rLtMxS8Bfp6grQvBEaNOIE1sez3hRx35z+c/TAVyVlFnOVsx2RMNI70tpuCXx3BUBTT82eiyF4WS8pzEyt09aCGexw4eudECA6bm9pS5DVOlXr202x9Tj/INFpxIkZDmqJ3yIec6SVchitkNBMVvXeiC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxyHEfUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C1C4CEE3;
	Sun, 13 Jul 2025 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752416853;
	bh=lWlEeob8ZmQpxvcDxDzxk/MN8KbZC//aM/OVmb2B14M=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=PxyHEfUHERBurdpbBWwWVLpsx6TrwsLcl2qzKqVCbk2vUEY8v8kpvOtavNA0Nuf2e
	 nPW4kDZMybshqorPhkmHUhitioM4Ipdey1w0+QLUV6hvKx02hmLl0wydjiyJeslsn6
	 /pS9MMqXStTStdPi58LWmB4+qpkhEpP98ERcu2ooQ26nr7i13BZD9OHAvw6SgEhwNh
	 4R0RxDCNQv2ZabGcTq4YnFnUdvFrvPY4JCwgZV0AOHV2H9cp4k1NV7UXZWeqRPY0bE
	 p/ljgZK+UzhFC2cKqDhZiWs7ebliCCOySbMfzYlPpqSiFAkclGbqsAxkxsXfrNj842
	 TBydEFDPKH3Og==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 16:27:27 +0200
Message-Id: <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com> <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
In-Reply-To: <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>

On Sun Jul 13, 2025 at 4:19 PM CEST, Danilo Krummrich wrote:
> On Sun Jul 13, 2025 at 4:09 PM CEST, Daniel Almeida wrote:
>> On a second look, I wonder how useful this will be.
>>
>>  fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>
>> Sorry for borrowing this terminology, but here we offer Device<Bound>, w=
hile I
>> suspect that most drivers will be looking for the most derived Device ty=
pe
>> instead. So for drm drivers this will be drm::Device, for example, not t=
he base
>> dev::Device type. I assume that this pattern will hold for other subsyst=
ems as
>> well.
>>
>> Which brings me to my second point: drivers can store an ARef<drm::Devic=
e> on
>> the handler itself, and I assume that the same will be possible in other
>> subsystems.
>
> Well, the whole point is that you can use a &Device<Bound> to directly ac=
cess
> device resources without any overhead, i.e.
>
> 	fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
> 	   let io =3D self.iomem.access(dev);
>
> 	   io.write32(...);
> 	}

So, yes, you can store anything in your handler, but the &Device<Bound> is =
a
cookie for the scope.

