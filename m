Return-Path: <linux-pci+bounces-15903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1259BAC32
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 06:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3141C20BF1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3318B491;
	Mon,  4 Nov 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RR4Qk1YP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FD14E2FD;
	Mon,  4 Nov 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699297; cv=none; b=NKd9/81FgnRlyvL8QHie+wSZXofdZORY4AVg6iWZMSJARsRi2ZIAop9TUm7c1vr1p37cwVLTaT6wHtQQybdtks4FuIxuU88k6JklECdx+6BoucEs/XFLdk32IxN+xiGxNnjmTYwgolZrInX/GIGqZeZdoas/VOodoAZynTn1dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699297; c=relaxed/simple;
	bh=edvxFmTBjxvI4nBUqoMSl9EeUROQLK62qEI3WJuFB7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ittbHbyDfdu7IQqq0TP02rlq0g9L2sqStyghvIi4l8/52Vnw2V4bM1C5ev3cQ80tdT3Q7vcs7loPOB6doQ1wysyI6pgrwIaJJ7tYfU3lVDhZN+4bVDha1ctgiYNQjWZ6JSBqVVLS4znttYhfOQuGg903gnp2oHt9yWFTn3oDcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RR4Qk1YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD88BC4CECE;
	Mon,  4 Nov 2024 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730699297;
	bh=edvxFmTBjxvI4nBUqoMSl9EeUROQLK62qEI3WJuFB7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR4Qk1YP7HOhaPMLrbFubaN0eN/0WTF9lNfya6BDCca24j5pjeFVwLAlPN4/q73Oq
	 X6p84GqYT0i0wOzO2Hj355bNf4VLemJPT4+lakeHAOvoLqlexULxPa2O3ibKdPYPJu
	 rOiE46mkXmX7AVdsqbqCOLtO21tNVq6CCorvZHYg=
Date: Mon, 4 Nov 2024 01:15:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, rafael@kernel.org,
	bhelgaas@google.com, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 02/16] rust: introduce `InPlaceModule`
Message-ID: <2024110425-overfill-follicle-c963@gregkh>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-3-dakr@kernel.org>
 <CAH5fLghQ3Rdgk+xzz9RzNzTs4vYLMO0q-SkDOrnb1u4TkPQVUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghQ3Rdgk+xzz9RzNzTs4vYLMO0q-SkDOrnb1u4TkPQVUA@mail.gmail.com>

On Tue, Oct 29, 2024 at 01:45:36PM +0100, Alice Ryhl wrote:
> On Tue, Oct 22, 2024 at 11:32 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This allows modules to be initialised in-place in pinned memory, which
> > enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> > registrations, etc.) in modules without any extra allocations.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Miguel: I think this patch would be good to land in 6.13. I'd like to
> submit a miscdevice sample once 6.14 comes around, and having this
> already in will make the miscdevice sample nicer.

If no one objects, I'll just add this to the char/misc tree that already
has the other misc device rust code in it.

thanks,

greg k-h

