Return-Path: <linux-pci+bounces-18139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD39ECEB1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B116B0B8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B91DC197;
	Wed, 11 Dec 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cn+DWU9z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E91DBB36;
	Wed, 11 Dec 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927456; cv=none; b=S7Z1XgGXZah9ATJWcMm1IybxlcAJWEGglWMBk22MANaQoMy3YVV8BeXn2E85FuwZr0/ayV/GK+CP4IVzqtsnkv+2ilK4jHQxU+cYTkKy4bEHMrUeLfBgiZoSwWoBMhugBsP8PWQViB9GVXIgHuV7FL9h6nHEneArIxZJOT7MBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927456; c=relaxed/simple;
	bh=sf7J34p1Pkgecwlqi0r21A5mwW0XxASsI9vA7F+tTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Rqn0FdMWnV2oDa/6pma33/28N6BbqUalGl3C0ChmmM85TqM6/mO2Cbj4rlA5X4f4gzOeF2CfRWoX2jZwxmjKKq97EEMtpBR8UIyeAE23quStVM5VPXOaXQfiU7DV2LJZmDG4eO11pXwxnbukW+Shhl0+bsOvbnwFzzoCzRSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cn+DWU9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C011C4CED7;
	Wed, 11 Dec 2024 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733927455;
	bh=sf7J34p1Pkgecwlqi0r21A5mwW0XxASsI9vA7F+tTXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cn+DWU9zl9GpkkoxEqCTeyb7BGrEYTypixBsHMeE/OtdnJzNWe77iqFyRuaJcyFoa
	 Ua7/8PXPk1vhC/o/JUg/+udsySvAXM8M8mh55hRQXIEearsPOFXkoZp2l7Tx3MfDJx
	 narR0WuypGXUu4dRaf3nvKKcbsNJnZtu0clytarY=
Date: Wed, 11 Dec 2024 15:30:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
Message-ID: <2024121102-promotion-other-e7dc@gregkh>
References: <2024121112-gala-skincare-c85e@gregkh>
 <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh>
 <2024121131-carnival-cash-8c5f@gregkh>
 <Z1mEAPlSXA9c282i@cassiopeiae>
 <Z1mG14DMoIzh6xtj@cassiopeiae>
 <2024121109-ample-retrain-bde0@gregkh>
 <Z1mUG8ruFkPhVZwj@cassiopeiae>
 <2024121121-gimmick-etching-40fb@gregkh>
 <Z1mgATmU2WgYwCGZ@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1mgATmU2WgYwCGZ@cassiopeiae>

On Wed, Dec 11, 2024 at 03:21:53PM +0100, Danilo Krummrich wrote:
> > Really?  You can't have something in a required "register()" type function?
> > Something for when the driver "instance" is created as part of
> > pci::Driver?  You do that today in your sample driver for the id table:
> > 	const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> > 
> > Something else called DRIVER_NAME that you could then set:
> > 	const DRIVER_NAME: env!(KBUILD_MODNAME);
> 
> Sure, that's possible. But that means that the driver has to set it explicitly
> -- even when e.g. module_pci_driver! is used.
> 
> In C you don't have that, because there it's implicit within the
> pci_register_driver() macro. (Regardless of whether it's a single module for a
> single driver or multiple drivers per module.)
> 
> Anyways, like I mentioned, given that we have `env!(KBUILD_MODNAME)` (which we
> still need to add), there are other options to make it work similarly, e.g. add
> a parameter to `pci::Adapter` and bake this into `module_pci_driver!`.

Ok, I'm all for that, just don't modify the module rust functions for it :)

> For this particular option, it would mean that for modules registering multiple
> drivers a corresponding name would need to be passed explicitly.

True.

> > Also, I think you will want this for when a single module registers
> > multiple drivers which I think can happen at times, so you could
> > manually override the DRIVER_NAME field.
> 
> My proposal above would provide this option, but do we care? In C no one ever
> changes the name. There is zero users of __pci_register_driver(), everyone uses
> pci_register_driver() where the name is just KBUILD_MODNAME. Same for
> __platform_driver_register().

You are right.  But I see other drivers messing with that field, oh no,
wait, that's just the EDAC layer doing really odd things (a known issue
as that layer does very many odd things.)

So nevermind, multiple drivers per module isn't going to be an issue, if
you all can move it to a macro (best yet, like what Alice pointed out),
that would be fine with me.

thanks,

greg k-h

