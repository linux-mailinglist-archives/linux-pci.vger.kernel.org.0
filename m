Return-Path: <linux-pci+bounces-36095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF0B56481
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 05:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457DE170BFC
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236411E1DE3;
	Sun, 14 Sep 2025 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="WRTiMrwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FE1891AB
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757820428; cv=none; b=HEXAxKXmUKk6l+rDoSLhfocEYq2gg3+09/KrZmRbzZYh6W0rw+ozFa12LHn9W/R/XAY/TPbyOxvdX/u4lSvP8Bv/EZAObs8whAtxIGMCcyceJ0MU3kxu5hQ5Gg3t8POBK3Vi07yusE4xTzxSUl3U3nGWjvy7Kzb8AnUQTB8K0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757820428; c=relaxed/simple;
	bh=rZg+3eTMr9lLsvC9MfcbTmU5MYahEjbswNA5wNEWAiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVuiJp4RI7yziFsg+X3HOJttjlhvm1tIQgEmI/GYobofqhtYQuBVjAIBagFVyA6c6d+gTtu+r3cOny+lmI9S3fHeqH9CMwjCh45Z8Rf7lv4StDkZvNqUOLPF9L4MpCceoFTcIfCfykoZ/8CuKCcyQuGhnKjcKuT8oi5xGvoW8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=WRTiMrwR; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757820418; x=1758079618;
	bh=rZg+3eTMr9lLsvC9MfcbTmU5MYahEjbswNA5wNEWAiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WRTiMrwRFPPaQuXVzwLJri0Cu1o0QniF6jfKjqdDqS407HgJQKIVkyIS6G6fqoske
	 Yoa8wozRgjbBN1e5D7CBCIphkqHDUpfGpRX5i7QyTnBWq+UPW11TlBYERpBesW0L+R
	 EYZIRionTjsGvIoDgFx9AUOvw4u0FgtWj2YK4jE8iI+/SFNbZhoNy/rROKYgvZxkyW
	 49GtGeG25E5EPjCwYE8eMukjJ1Da1NLN87wHHg88CXdZTUOz5sqXbCB+gtY1LQnuCG
	 7GXTMTsw7j85vddQE8Sg/PIVLLyhSzxBLAg5X/N6pwjwOSqOr2qgYENzfuGJ4y9u5z
	 ZpmLgFAvTAExw==
Date: Sun, 14 Sep 2025 03:26:54 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: pci: fix incorrect platform references in doc comments
Message-ID: <87ikhlr9xl.fsf@protonmail.com>
In-Reply-To: <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com>
References: <20250913172557.19074-1-sergeantsagara@protonmail.com> <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 287f69c5edc91eabf0806d96011ae80e37681358
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Sep, 2025 21:08:46 +0200 "Miguel Ojeda" <miguel.ojeda.sandonis@g=
mail.com> wrote:
> On Sat, Sep 13, 2025 at 7:26=E2=80=AFPM Rahul Rameshbabu
> <sergeantsagara@protonmail.com> wrote:
>>
>> Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstracti=
ons")
>> Fixes: 18ebb25dfa18 ("rust: pci: implement Driver::unbind()")
>
> These do not point to the same set of stable releases -- one cannot be
> backported to 6.16. In these cases, it is best to split the fix into
> two.
>
> And in the one that can be, you probably want to add Cc: stable so
> that Greg's bot doesn't detect it :)

Thanks Miguel! Just sent out the two patches.

>
> Thanks!
>
> Cheers,
> Miguel


