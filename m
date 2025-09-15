Return-Path: <linux-pci+bounces-36115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83089B570C8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB57D7A113D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB02246BBA;
	Mon, 15 Sep 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b27XNKfx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393B136E3F;
	Mon, 15 Sep 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919533; cv=none; b=CaHQhmT95PQdnl8KAosLDg3NN4EjS2B+2jWdAizMOLpo2XL1ek9M7f1Cw9XdrTh+HQ0iKqifMgwJ+hxH/IsPovfTOOQ0BvSRNEn1lgJxinlYlnnjeC4Eqd0OJ7eF1Q4ZqB9fpp8bhXDpeCo5aQR/hXFtJ57JK7JdsP+Vd8rsPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919533; c=relaxed/simple;
	bh=nRRbPf3NF5C5ekIv2cigVd3N3aQVOq638dblv75A6XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMqj/I3JWwxftGjm153xBfccik6NLjaPQsvu6i6qDfg9W4xZcI0cknGkqHyMjKPSKvWk/HyOeANkfVnHsPZmOFbvzHrtqBLXaucJAEPyb0BCDovJMlDt+uADt8E6QK1bVbp5U5qG8p8t97S5oU90+rGeTOstF+pNlYKukPTrnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b27XNKfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB3AC4CEF1;
	Mon, 15 Sep 2025 06:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757919532;
	bh=nRRbPf3NF5C5ekIv2cigVd3N3aQVOq638dblv75A6XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b27XNKfxXO32bo4XZTUsv8BOFRM9ukXfA74S+9pSymWTZKe9OL37vQVMWFQuTGoX7
	 xnhV5dLTMuwQo5MUeMBNitcdttBBB+21eka6zPwDeMOqoV7kF8u/gRmoLR2/9gUr3k
	 gMcwmLZfFbLkcdvy7lwK36543l6fTGpF+1ccADQcT7uNzbZ0RBj/dEkt0wwO1PxUf/
	 wP3hr9r5Me6npLG/X4AqRuVVbYJO43zNuETmp1VrCMfW629KjykSfUVsy3jtpGJy8t
	 MfdZ4a69ktTRIuemttgPORLBHGk9GwBcUVLifcryeyT8mIbwUF1dBF/JoI7DpFtCZR
	 yCmDYvs9p9y9Q==
Date: Mon, 15 Sep 2025 12:28:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: pci: fix incorrect platform references in doc
 comments
Message-ID: <3tvlfhghyl3xu7drx2vawkw54ghrbbf32qfgsiutrltm3sszck@bdgqp64pbdy7>
References: <20250913172557.19074-1-sergeantsagara@protonmail.com>
 <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com>
 <26oqasrlptl5v4ymfkrlznltbwqx5rfi4dworhri3msme4wlmm@cclnphvwur6r>
 <CANiq72mpQO0v-acGOWUcYaBmETSTAjkJUDN4MT498imVGboYQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mpQO0v-acGOWUcYaBmETSTAjkJUDN4MT498imVGboYQQ@mail.gmail.com>

On Mon, Sep 15, 2025 at 08:28:30AM GMT, Miguel Ojeda wrote:
> On Mon, Sep 15, 2025 at 7:29 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > Why should a spelling fix be backported to stable? The stable kernel rules
> > explicitly states that these kind of fixes should *not* be backported:
> >
> >   - No "trivial" fixes without benefit for users (spelling changes, whitespace
> >     cleanups, etc).
> 
> I am aware, but the stable team has autoselected a similar fix in the
> past (and I asked them about it, precisely because of the rules
> above).
> 
> For typos outside doc comments, I wouldn't tag it (but they may still
> autoselect it).
> 
> For typos in rendered docs like this one, especially one that is not
> just a spelling one (like this one), I think it is OK either way, and
> a bit more worth it since these are meant to be rendered unlike
> implementation comments.
> 
> Thus, since this one was in the fuzzy line, I suggested it so that the
> contributor avoided Greg's bot when detecting the missing tag.
> 
> As for noautosel, I wouldn't do that -- they want them sometimes,
> after all. Instead, I would reserve it for things that really
> shouldn't be picked for a given reason.
> 
> I hope that clarifies a bit.
> 

Fair enough!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

