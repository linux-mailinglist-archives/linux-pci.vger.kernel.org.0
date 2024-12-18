Return-Path: <linux-pci+bounces-18694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9077F9F6632
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD1016A66D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24E1A23B0;
	Wed, 18 Dec 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heNnj9OR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7700150980;
	Wed, 18 Dec 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526194; cv=none; b=psMzU+6Gg3/8XU/2f2nFxHTXpjIaiLUGCG69oiAuQNvIfOpvrAUuwk6utIV9lcAsMk3LpdgU8xpy5GhvfFotgHjV7qB7H6WZZTLNeRAoEmOZWi27O57aPV8zuBLhHFZwqLApXWi1grRQlmE+arGgqLr51tXMS6WTHhCbYnkMsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526194; c=relaxed/simple;
	bh=nXDJjw93GPazF3biiEpcE26KFbWaw82zvhArBMzbPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA4oQ7YO1IJVHdrxS/+HAjvD3K5vqQKCA0xIJ0m6rFLctGtnD8faXYOyrKYQVgCnmhaX2Ut923gUXnzzB1S6cbdkq55qJHkGhU2dadNCmlGIqdPdUpNtQDjIUkTa3iUzrDg1bPJRzLdKiBO1YmDvSvabOUOu1MVHPFcU8D+fn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heNnj9OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821FBC4CECE;
	Wed, 18 Dec 2024 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734526194;
	bh=nXDJjw93GPazF3biiEpcE26KFbWaw82zvhArBMzbPFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heNnj9ORQ0jfmOFgmZYU3Vag/7gXd16+JCh1InHpeivec2JJLerrMUPyNFdQLqaH2
	 50dkG41gh4VRVH244rX182yvyBxEtNKcQj65w1IQmVJ1lM5DAmqwG3Utxs7+h5eQTO
	 8cSR3P1NCvz62YUIOortzJjhCKYWCG6bHj5QFntGQ4384Y1oJYWwHnOAFK2MGFtHgS
	 M1AembOc7Ls4h/WM36SAAbc9zkg/T9jYWWfeD63lZZaAgKI5KnRzR7wiQukjDNOmbN
	 vbQt/vspIL5Gw453ueG5B/ldz77D9S76se/pd2FWDCl43Ec/gn/dTRMkxvkzAUSOcY
	 yuAyFFKyyRtGA==
Date: Wed, 18 Dec 2024 13:49:46 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net,
	fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
	paulmck@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v6 15/16] samples: rust: add Rust platform sample driver
Message-ID: <Z2LE6ihYwwMxSPIK@pollux>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-16-dakr@kernel.org>
 <2024121550-palpitate-exhume-348c@gregkh>
 <Z2BV72LDOFvS2p8h@pollux.localdomain>
 <CANiq72=cOgKRbA9_G7XSTNkNx0JxEa8Qqwe+VNCw8t7y1w7n3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=cOgKRbA9_G7XSTNkNx0JxEa8Qqwe+VNCw8t7y1w7n3Q@mail.gmail.com>

On Mon, Dec 16, 2024 at 05:43:31PM +0100, Miguel Ojeda wrote:
> On Mon, Dec 16, 2024 at 5:31 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Thanks! If nothing else comes up, I'll send you a v7 end of this week addressing
> > the two minor things I just replied to (remove wrong return statement in
> > iounmap() helper, `pci::DeviceId` naming and `Deref` impl).
> 
> If you are going to send v7, then could you please take the chance to
> update `core::ffi::c_*` to `kernel::ffi::c_*`? (since we are migrating
> to our custom mapping -- `rust-next` completes the migration and
> enables the new mapping)

Sure!

> 
> I think you have only 3 cases here, and the change should not break
> anything in your case, i.e. it is just a replacement.
> 
> Thanks!
> 
> Cheers,
> Miguel

