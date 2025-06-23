Return-Path: <linux-pci+bounces-30387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669BAE40E2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F66E3AEA6B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46274248862;
	Mon, 23 Jun 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4a8RYcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA71244663;
	Mon, 23 Jun 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682517; cv=none; b=sCnvVIEL50Ui71MAFDsh0Y9jDj1v3CHzo0JgQsJkVqszzWCD+2tfjg1NiT0mD8nZfUEdIhD4B8I0YjEyMmtaD4gPiodNZ3wEVdUh0m6ms264jPMx1gLJA9X9V1u7aoVeo6I16vWluTBqm8v6nXHDunX5E5ziUhwSJnA2NIAxUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682517; c=relaxed/simple;
	bh=+FElCxP+gPXujA324quUzQTpAMHP1zjz6iLGuGL6yIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYbxMnGlPq2Q1dX8gqWHvXf4IxdrrNspLW0LlVuXKapaEsIPU7y0V0v74ND4nnqk/sO7Jlw5vgorQE+ZHouKE91JGyvNlE6zIy1YRJfsDN1GQfnJiaLRAjLro9YR0ryD0sruE2ONCvZTciQlWw2OAmBTXEJHJvWn8v72KsMBDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4a8RYcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8BBC4CEF0;
	Mon, 23 Jun 2025 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750682516;
	bh=+FElCxP+gPXujA324quUzQTpAMHP1zjz6iLGuGL6yIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4a8RYcui3jW+pZ++5z/Y9O58xN6h3JAMC1hy1bAl2d2/Iol0QfeJmsnvXc8EZxWK
	 f1Gm/EEwKH8qqVN4Jnh51r0qoRVuQ6KmY+hF5glEQvpZ0sEi0L8k+XfhROjVqC3oae
	 Y7HtOJcU8dtZS2aSWWX02ceXhLIX8QGNaIcGcf1jhOprcVi7moIjRmuFTmONlBhQKJ
	 cYZzMNHiYpchEWyssdB3V8Kac/yih7c7mMaxnzhis5rNpypPZM/5nB3c/0CSLb02VU
	 veRpDRwbcpfBZSYZ4dznOs70rJ+ZtLD9NsDZus0el9kqQF+f6/zAtMm3oSULGxUI0K
	 PxGinu+3ky0Cg==
Date: Mon, 23 Jun 2025 14:41:49 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] rust: devres: replace Devres::new_foreign_owned()
Message-ID: <aFlLjQFZ8gzh5Mz6@cassiopeiae>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-3-dakr@kernel.org>
 <aFlA92ooeQsSThLh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlA92ooeQsSThLh@google.com>

On Mon, Jun 23, 2025 at 11:56:39AM +0000, Alice Ryhl wrote:
> On Sun, Jun 22, 2025 at 06:40:39PM +0200, Danilo Krummrich wrote:
> > +pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flags) -> Result
> > +where
> > +    T: 'static,
> > +    Error: From<E>,
> > +{
> > +    let data = KBox::pin_init(data, flags)?;
> 
> Wouldn't we also want to expose the ForeignOwnable version? It seems
> likely someone would want to avoid the allocation.

Allowing other things than Box changes the semantics of the API. For instance,
if it'd be a reference counted thing (e.g. Arc), it would basically mean "please
make this object live *at least* as long as the device is bound".

Before considering to allow such things, I really want a potential user to
present a valid use-case for that.

