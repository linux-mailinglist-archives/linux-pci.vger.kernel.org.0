Return-Path: <linux-pci+bounces-43978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D2CF2100
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 07:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E06B30010E3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C36530DD00;
	Mon,  5 Jan 2026 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y1+zCqp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337EC2BCF5;
	Mon,  5 Jan 2026 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594355; cv=none; b=LSc5TkjOK+hrNEJhQPCQ5t6eV3+L6b/eYykU3I4w6kZzkk8uFsKhDtWwq4XVukbEWuweNzFJjWHOKndqE3/FRw3XEih3Gop8AHCV0ICJZNh2XAlpMSwVVvMQ89k+va3CI3/VZnURgjQL3aLiFP2b5PYaeEcmHQELMBExIAeqF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594355; c=relaxed/simple;
	bh=znNJncmbBCy4v0V/A8ag6P3qRxQ8kYYT08leohhSGkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af9pFzOa80zzogDiyTKuiwcAkNmObwbdyfl38imF6Gcx5vFnKfPf7nYoNzssW3fA6JVC4HT04L5m6XH6EUktGu4CeOc6ZjJxS4cs00951bXHLSf3C2NV3vpTweiXDtPRGU7QwHxBGM89Dyib0ziZ+uY6+hgK9s6J7gpNaGsBedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y1+zCqp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5814FC116D0;
	Mon,  5 Jan 2026 06:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767594354;
	bh=znNJncmbBCy4v0V/A8ag6P3qRxQ8kYYT08leohhSGkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y1+zCqp/19qYNFp+skjNYUN8hzfo5VdLs6lyi4GRjKzIGzsNHMcVYWGJPsQ5FS4fK
	 nB8f7w01P7OQm20CoPEIqRRafUQP0TF2FrCEwpavzb9KxVodgUK3dD/WIOxBFF5vrR
	 dMVBjnHnGxZcP/9MKsdTGN3ZU4lAPo6pnecpH3u4=
Date: Mon, 5 Jan 2026 07:25:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, sashal@kernel.org,
	Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@gmail.com>,
	dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
Message-ID: <2026010520-quickness-humble-70db@gregkh>
References: <20260103143119.96095-1-mt@markoturk.info>
 <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
 <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info>
 <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
 <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
 <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>

On Sun, Jan 04, 2026 at 07:30:22PM +0100, Miguel Ojeda wrote:
> On Sun, Jan 4, 2026 at 3:08 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > In general I prefer to only add a Fixes: tag for the commit that introduced the
> > issue.
> 
> If their scripts track moves well, then it is great to avoid it, but I
> am not sure how well that works or not or in which cases, i.e. it
> could look like two different commits introduced the issue and thus
> one backport could be missed. Not sure.
> 
> > Again, I could also remember this wrongly, but I think I just recently reviewed
> > such a commit from Sasha. :)
> 
> Hmm... I also had a few cases where Sasha autoapplied, but in most
> cases, I had to provide custom patches when they didn't apply cleanly,
> even trivial ones.

It all depends, sometimes we can handle file moves easily, sometimes we
can not.

But really, why is a comment typo being needed in stable kernels?

thanks,

greg k-h

