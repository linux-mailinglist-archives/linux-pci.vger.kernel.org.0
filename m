Return-Path: <linux-pci+bounces-32019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C1AB0316E
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C152A3BA31E
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7D277800;
	Sun, 13 Jul 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAXLy5HM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB478F4A;
	Sun, 13 Jul 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416403; cv=none; b=clcHAM2S/slyI+BJachUSJsz+xeBVRq+JgfrL/ma4LLVal/sceRAjdd9dqkAahvbyNRautMhhk9S6vGF2zKqBaJduzaTEmBrjXAgQW8P3+yN/5cLfeUzUqLv7Fvyrjt2f4FwlsmR39mJT7MHNM5LOd+idhR0Cf8ByWE3jPE89RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416403; c=relaxed/simple;
	bh=X+GeHH8pfuXrXmc3cWrR2M+jAONYM1dPj8QJJmReTok=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YTDtzuqD9oL+eY0wCJC3masKH0rVckVi5zpg5KqXRimlLqRa0UQyLlvkRXPVdEOav9th8WEAolbGdBOtPov/Tejuh3QyN+9XV+zqPuV6cc3a9l8kZImn5KgHm7G+p+ascrBPqvjlfq3L726kuUWpc5EZhLS9MmldYngLi4UMYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAXLy5HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F06C4CEE3;
	Sun, 13 Jul 2025 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752416403;
	bh=X+GeHH8pfuXrXmc3cWrR2M+jAONYM1dPj8QJJmReTok=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aAXLy5HMoJAhsskfrtY9/IXAayWIorkhguUylqw8bgYt7FDVjAzX94Xpq03FY3IxX
	 DAyNDFYQurbLYddlKN7Nhno6MbXHpKOVBRMbGrqNkmzkX9U6KQ9ufOej0mPyKD6xhU
	 mPLtR+D6NDGOhpuRTxv8Kl8llr2a3zfcsiVpup0vh34ESZCwy0CzHGPWsgHAyeXMy9
	 0gCBUECGilc9aFueW/YcE/CKj58eLA+d61LPYBx5t609ghjdX2YauTaZ7Qc3taRHWE
	 25toDZTtOLXhMjFbc4h3sCnW8gDwdSvRg+GHyORXCMUciudx87waiB2wEtfAK/PLOb
	 oECmyUwfI1gPw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 16:19:58 +0200
Message-Id: <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
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
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
In-Reply-To: <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>

On Sun Jul 13, 2025 at 4:09 PM CEST, Daniel Almeida wrote:
> On a second look, I wonder how useful this will be.
>
>  fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>
> Sorry for borrowing this terminology, but here we offer Device<Bound>, wh=
ile I
> suspect that most drivers will be looking for the most derived Device typ=
e
> instead. So for drm drivers this will be drm::Device, for example, not th=
e base
> dev::Device type. I assume that this pattern will hold for other subsyste=
ms as
> well.
>
> Which brings me to my second point: drivers can store an ARef<drm::Device=
> on
> the handler itself, and I assume that the same will be possible in other
> subsystems.

Well, the whole point is that you can use a &Device<Bound> to directly acce=
ss
device resources without any overhead, i.e.

	fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
	   let io =3D self.iomem.access(dev);

	   io.write32(...);
	}

