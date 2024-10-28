Return-Path: <linux-pci+bounces-15441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6099B2C9A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE0FB20BE2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65D1C6F41;
	Mon, 28 Oct 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIauviEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB952F9B;
	Mon, 28 Oct 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110748; cv=none; b=MPtbx8zsstTFUhf8UPQ7GxVfDKoMLDnxFyKDz3wo7sKQA1H+SkBW6Ux/xawOBdU/arxaTXA2p6Uas8l4k2tQdJXdzYN+Gg0kqERqoio+Jg3fAPaF4RP0YPU02xDeEiiDO3f65yE6YwUHGKEIyOXMoRe7zVyo/e2Ev60/csQAm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110748; c=relaxed/simple;
	bh=0st3IhjfB70U77+O5BtVgJMTEQ3ZsfyA5ALl+OrRE8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3K5xpHUGoSK6sA5qRqHB9i7vp5oXKcILAE7TvJl1hrdRkc5QtuFZkD7NLvUzCmAfp8zIKWc6Oja17/CySuZIhLlZhIp2YOFEEN4JkINR0xYYveOT1k0enX1rJ+95ruyIBC/NKrl6NJnNfm2fgvkL3LB0dkuCpj4Z/JFg9CFL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIauviEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2B5C4CEC3;
	Mon, 28 Oct 2024 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730110748;
	bh=0st3IhjfB70U77+O5BtVgJMTEQ3ZsfyA5ALl+OrRE8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIauviEnga5Wdy0UAY8v8zHhbuFk2VC9QclBcfWIFMi+/RzqSxMt+0OKbzlKaCpoK
	 ASN0aShyKEUicqMXYJxB537RAwb/fvuVc38kTYRrr27zGhBMOB6yS9Z2iLz8ek4Fpj
	 omkAelGeqoLfsGiytScPkhaj0sipM4B+xUqWcu0Foe1lhLbLuUkSdI/3nxdtROGpI9
	 5hvV5+xyRwrU6qLZ8kOtii1xr5MQ0EUtO/Ap6K8v68rCkkoZ1/4ucsbn6MW3pIoWq9
	 lNdLUuc3/SVocqDxFhBbE9I94fHJbRvcWteQffGVX8JblWbkeklxHkIBpbO4R0Itwi
	 TwiQ8UAYb2YYw==
Date: Mon, 28 Oct 2024 11:19:00 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <Zx9lFG1XKnC_WaG0@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
 <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com>

On Thu, Oct 24, 2024 at 11:11:50AM +0200, Dirk Behme wrote:
> > +/// IdTable type for platform drivers.
> > +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> > +
> > +/// The platform driver trait.
> > +///
> > +/// # Example
> > +///
> > +///```
> > +/// # use kernel::{bindings, c_str, of, platform};
> > +///
> > +/// struct MyDriver;
> > +///
> > +/// kernel::of_device_table!(
> > +///     OF_TABLE,
> > +///     MODULE_OF_TABLE,
> 
> It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names
> used here. Shouldn't they be somehow driver specific, e.g. OF_TABLE_MYDRIVER
> and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the other
> examples/samples in this patch series. Found that while using the *same*
> somewhere else ;)

I think the names by themselves are fine. They're local to the module. However,
we stringify `OF_TABLE` in `module_device_table` to build the export name, i.e.
"__mod_of__OF_TABLE_device_table". Hence the potential duplicate symbols.

I think we somehow need to build the module name into the symbol name as well.

> 
> Best regards
> 
> Dirk
> 
> 

