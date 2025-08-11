Return-Path: <linux-pci+bounces-33775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284CB2132E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4413A7A83CA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BD311C16;
	Mon, 11 Aug 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcgAUVsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4D15A848;
	Mon, 11 Aug 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933419; cv=none; b=Qfg6mVSs2Wm1iGKnffQG6IFWuwEIE0PO94QSxHTPGR9i1tAdmkwq5h31W1QA4VZWDc7UfRIumlMh96L0GLl17CxgzebSo3BouOsQB+bGM5OTNb0oK3CFizpJj/hvmfxba8W+rnhT/2IQ9U3Lr4StrLzz2y/ORXBnK1KiueKnuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933419; c=relaxed/simple;
	bh=QTUJmNuIA9Y8USJQy0wkUEM7A1icU1YnzbFoTOlFan8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Jh5Ssv8AFT4USTtpuhzyi1hSG35Vx7Cvup/i5uEaNHX5vIELOadQ5pR2vaCXd91c4bKdGNmLf7nTuIIzP6jejVEV1LmEXCL/mLP/yR94LfssP/Vro7MBEowAtPQynwaFo2J0eP/JR+5F6cS9//Ikyyavs14fkngya5ISsGt6JGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcgAUVsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D55C4CEED;
	Mon, 11 Aug 2025 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933416;
	bh=QTUJmNuIA9Y8USJQy0wkUEM7A1icU1YnzbFoTOlFan8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=dcgAUVsBTHF9QfoKmlubmqlHzmn7mZuuwcfbBegOq8vsHU6iyyTPn6vMC2pHuBHGs
	 U9h9EnNdLO1Y+disDSpYK12itPxHxKawC4n3cWljwg1wlUY45hzeftYigC/sNNvmCb
	 LyuCaZXrXJM/qrViaYgL0GbX8npsYqv9acLxPBxoKAWfycX/I/2X2aM347twKvQ2ac
	 HDD/pOPGkfhqgjcTbiYh5m6P07Q5fTE3p9RIQPef8yctRr3bEK7w8oNWb1huBZeRr7
	 eLOVvAEYqUDEwXhXoGI+6E7Ej4jxiy0qz4cot3wuWE3w+lPrW9opUg8yW+MsRAM+lD
	 reVk2ZEl9E3Xw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 19:30:11 +0200
Message-Id: <DBZRZ3LKJQF7.210QIJ4S1EI94@kernel.org>
Subject: Re: [PATCH v9 7/7] rust: irq: add &Device<Bound> argument to irq
 callbacks
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com> <20250811-topics-tyr-request_irq2-v9-7-0485dcd9bcbf@collabora.com> <32B71539-BF90-4815-9085-2963F5DD69B5@collabora.com>
In-Reply-To: <32B71539-BF90-4815-9085-2963F5DD69B5@collabora.com>

On Mon Aug 11, 2025 at 7:00 PM CEST, Daniel Almeida wrote:
>
>
>> On 11 Aug 2025, at 13:03, Daniel Almeida <daniel.almeida@collabora.com> =
wrote:
>>=20
>> From: Alice Ryhl <aliceryhl@google.com>
>>=20
>> When working with a bus device, many operations are only possible while
>> the device is still bound. The &Device<Bound> type represents a proof in
>> the type system that you are in a scope where the device is guaranteed
>> to still be bound. Since we deregister irq callbacks when unbinding a
>> device, if an irq callback is running, that implies that the device has
>> not yet been unbound.
>>=20
>> To allow drivers to take advantage of that, add an additional argument
>> to irq callbacks.
>>=20
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Sorry. I forgot to add my SOB here.
>
>
> Perhaps this can be added when the patch is being applied in order to cut=
 down on the
> number of versions, and therefore avoid the extra noise? Otherwise let me=
 know.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sure -- no need to resubmit AFAIC.

