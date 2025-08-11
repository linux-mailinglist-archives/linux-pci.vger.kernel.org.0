Return-Path: <linux-pci+bounces-33776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D7B2134F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B8C4210E9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F22C21CB;
	Mon, 11 Aug 2025 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NysrL6Ue"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24D311C16;
	Mon, 11 Aug 2025 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933726; cv=none; b=hZAQ6NONJ40uDIS6ajHDLiun2UrcTMpXKAXuBFIaAzEqq/poO8Dx7N2tfW4p3FIo+kacSWBce1BMXwNOo8bL+3/VIlFpJhpUA6N1pEcjR0S0OUHQgKvJqBAEKe4Xg2Bn8AFG0xy3y6Q2SwpI+sr5BQ87/wlHZsPCH8087vdo7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933726; c=relaxed/simple;
	bh=VHYkAMTWO/uflyM3hNy6b0QKSlDmdKt+NgvrVDt9cMI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=OPnaJFqtn/DECt/l47+JPstK3phvjoVR/NvyGECGd+yl5OqYTc6/1ddm7XM2b4656njkebzWC+BUsKFE7RPbPM4EeTwTLCx1W90swoh+He4WK6bsOo+n5YjP+gWFNGXh0yO6YVGyj/ZhKzjRMvsslJglZ37EUwj3uNMjNQAGr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NysrL6Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAABDC4CEF4;
	Mon, 11 Aug 2025 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933726;
	bh=VHYkAMTWO/uflyM3hNy6b0QKSlDmdKt+NgvrVDt9cMI=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=NysrL6Ue0qICy2WNoA0xnyhzgSJcftnDt9+TsS0uFHrGiytw29NNzc/O81+lZ8vXQ
	 HHeDo8+dY8k+SGq4W1ED1FAlKd9nzSm0uocn22VjsewXDUHOTF0GxYAOPqzKEiDM1t
	 23mpIbEkg34QYFKjg4ExUfQk+PXG1jbeLwd82ycx9xo9MDoDejAWJh7X54MkDFVd39
	 OZdPlGhtTvr9xON7uccjkIxyCBM+MD/9YcrgroziDvSU3hG+RF2MtQKw37Q7yjtvV2
	 B4mT2iAnRa+qchTvdWEMq/NQoZQogVt79t0lCfkFRxN9AnUZEmwKjIxxvv5nZVdFWG
	 FH11my/tHo+Pw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 19:35:20 +0200
Message-Id: <DBZS31MID9U3.2K30H3P4E8BUX@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v9 7/7] rust: irq: add &Device<Bound> argument to irq
 callbacks
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com> <20250811-topics-tyr-request_irq2-v9-7-0485dcd9bcbf@collabora.com> <32B71539-BF90-4815-9085-2963F5DD69B5@collabora.com> <aJokQTM97xBMXxVo@Mac.home>
In-Reply-To: <aJokQTM97xBMXxVo@Mac.home>

On Mon Aug 11, 2025 at 7:11 PM CEST, Boqun Feng wrote:
> I think it's fine to submit with only Alice's SoB, my understanding is
> that you won't necessarily need to add your SoB if you are simply
> re-submitting a patch (with minor changes).

I think it is required for everyone who is handling or transporting the pat=
ch in
any way, documenting the exact route a patch has taking while conforming wi=
th
the developer=E2=80=99s certificate of origin.

