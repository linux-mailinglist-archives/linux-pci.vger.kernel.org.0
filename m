Return-Path: <linux-pci+bounces-38283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B5BE0FD0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47ED74E30EA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD582315D25;
	Wed, 15 Oct 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxg9NwGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43C30F95E;
	Wed, 15 Oct 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569109; cv=none; b=f9bf7owgXnDg14vRKTUtPPjIAwu7xKvGgv4GCeEyTQ0Qhh6Rm0Zmk7aEeyoRNyTxwEaqKWZ3THGd95Iu3aqCoXUXhSExcMKQkLm9bR/VdzY9m6GVhx/jIF8B5Psf1ntwUk6LABg3LbE+KIyXhCXUXzvxA21pABtOA4Newgg5V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569109; c=relaxed/simple;
	bh=LRkvYouxTnFsC0bEndMc1RJ0+HzynhP13TCPxG6uoh8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LgLhXGO5t7Sf6W7vMf79SW6Ov3WKjhVp+IMOMz7jDmwTeU0RBqZlKBWGrcaBueqQnQj3sHTRZhtPKgDri3O75FQgEtLHSrtWWPqvbODDUZID0xOU/RCGBuooAH4LKkzlSVeKH1ueSIHIdfBxDyOzM4KJRmsF89r5FWNVC3MS0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxg9NwGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B0C4CEF8;
	Wed, 15 Oct 2025 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760569109;
	bh=LRkvYouxTnFsC0bEndMc1RJ0+HzynhP13TCPxG6uoh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oxg9NwGlR/xZ6ayF6ZODOPTrDMY9pxooF56Ndb4AHWv+qRIp/efFaF8DzINjNX3d6
	 85wN9ni8ZbtFUny8wGEgb8ZRL5WQW0DDrR5Qe/Dj/gXkaoYTaHuiaCDTnuXLrz+jtJ
	 jKNcM1cfO1WAE8Be8nVPS8G3zz+dQ4k4vLq678AlP/zTHozc/uhAexoWbtM2Z19EM8
	 /W++3ivcRuDy3X/Rz0Yt3tH4mRck6w3mIp2dxEDYAQnd6JVhVqATAOYTaXOIsHRyWF
	 q39EvQCEHtIx34WXWer6nah6dtqR3D52lNAtXfk07wFtKOhGfRsyLNmuaIqAQEF8HS
	 chHW13YKptBIg==
Date: Wed, 15 Oct 2025 17:58:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: pci: move I/O infrastructure to separate file
Message-ID: <20251015225827.GA960157@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015182118.106604-3-dakr@kernel.org>

On Wed, Oct 15, 2025 at 08:14:30PM +0200, Danilo Krummrich wrote:
> Move the PCI I/O infrastructure to a separate sub-module in order to
> keep things organized.

> +++ b/rust/kernel/pci/io.rs

> +/// A PCI BAR to perform I/O-Operations on.
> ...
> +/// memory mapped PCI bar and its size.
> ...
> +    /// `ioptr` must be a valid pointer to the memory mapped PCI bar number `num`.

I know this is just a move, but "BAR" vs "bar" usage is inconsistent.
I think "BAR" is clearer in comments.

> +    /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
> ...
> +    /// Mapps an entire PCI-BAR after performing a region-request on it.

Similarly, s/Mapps/Maps/ and s/PCI-BAR/PCI BAR/

