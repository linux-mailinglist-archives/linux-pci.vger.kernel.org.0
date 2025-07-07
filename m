Return-Path: <linux-pci+bounces-31609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E1FAFAFEF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DF816EE20
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA228DF28;
	Mon,  7 Jul 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed1Fsqur"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16A28DB73;
	Mon,  7 Jul 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881208; cv=none; b=Ybs/UNKalmdh0rmIVV/URWvZb6WjV2zMwAAk9xpZ0ruzraiFUISG51r7FHM+E6yXO9GmCSSH4c1QttLdxXelqAmIdpZTH8cOhIYODRilKa2GfsowcB3R5dHeUkLMdsjIXFJn1RDPAoO9Scmf5fN1qYXuqnwNt1bvv7ZzpwXcv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881208; c=relaxed/simple;
	bh=dgjjYLEuj7l6qhjPxNywBOI0/nZUYsYye4YLqE96zn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB8MqfF0hlRhSxhJlrYqFQDePUBs1uEMp1fLxJz1+8trAg4pjK+UDsmjx5sMaDUcTw/JJRAlNhXuRl05MwDwHe4P2+qpev1Gm5kvoiUTWLOHIRruk+O02a3B856Z/nz9ttUvuBtPdLcJiM3RpMLyM4lJ7v3qsZ10yA/0WlIJ6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed1Fsqur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4693C4CEEF;
	Mon,  7 Jul 2025 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751881208;
	bh=dgjjYLEuj7l6qhjPxNywBOI0/nZUYsYye4YLqE96zn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ed1FsqursUWjZXkujG+et8Sp/r0TJtSZMdS6pnA8uulWf2kamvZVD489AMVjouzH1
	 kB+rsKsgD8d+Q/BR+5NA1Mhwhuoa+1lAPTGTiVhA4YHuen+hhtdcyLbvDaZdQxk/hx
	 47xDmB97i9YZA49l21lFom+AReCDf1Q2WneprO8c4HJ1b+ERb7vTN6alQtd1EiG609
	 6ZjVMUmRhTLewCueds1TUseOFwVLEoRG9GobHcxK3dmsPC8DJDJUaCnn6MucH5R7oj
	 /EU1o/TwRgU+oA2fl9pssqBWU3wQIQrhh1BE5isPWEKMsd0B5vWK9QvNaxDqLUoYv4
	 raRtOmASOa59w==
Date: Mon, 7 Jul 2025 11:40:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] rust: device: add drvdata accessors
Message-ID: <aGuV8QVN1HGGvnwC@pollux>
References: <20250621195118.124245-1-dakr@kernel.org>
 <20250621195118.124245-3-dakr@kernel.org>
 <DB5NMUV07ECB.2PQN70X9OWVTQ@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5NMUV07ECB.2PQN70X9OWVTQ@nvidia.com>

On Mon, Jul 07, 2025 at 04:46:09PM +0900, Alexandre Courbot wrote:
>     let pdev = unsafe { &*pdev.cast::<Device<InternalSet<Pin<KBox<T>>>>>() };
>     ...
>     // The type of the driver data is already known from `pdev`'s type,
>     // so this can be safe.
>     let foo = pdev.as_ref().drvdata_borrow();

I think this doesn't remove the safety requirement. drvdata_borrow() or
drvdata_obtain() would still require CoreInternal<Pin<KBox<T>>> to have the
correct type generic.

Maybe we could have some invariant on CoreInternal that the generic type is
*always* the bound driver's private data type. But then we have an
`// INVARIANT` comment on the `Device<CoreInternal<...>>` cast, which would need
the same justification as the current safety requirement.

So, I don't think this safety requirement goes away. You can only move it
around.

> I don't see any use of `drvdata_borrow` in this patchset, so I cannot
> really assess the benefit of making it safe, but for your consideration.
> ^_^;

It will be used from other bus callbacks, such as shutdown(). (There are bus
abstractions on the list (e.g. I2C) that will start using it in the next
cycle.)

