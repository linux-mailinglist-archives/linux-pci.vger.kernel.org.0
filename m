Return-Path: <linux-pci+bounces-30389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932DAE4133
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D377B188820E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2B24C669;
	Mon, 23 Jun 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq46LZAN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40393248F6E;
	Mon, 23 Jun 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683124; cv=none; b=WnacGYmX/hxtnrUGBzJZ8JxbWkbuIt2nm+Hmr0/wtV3FszYNddT2ffmIaRz7mkWtddEAvqTOrqECQg3PrlscTaC+IpBnm9qXVuiWSjhYPe9snXEthZ2PvJ81qSeodT45iW9zszye00Gfj+WNoZqnM7XODouAG47pjrAThs/85pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683124; c=relaxed/simple;
	bh=agJj4kYh8kr853tyRsYlX2onZ0GFTf4kg9la+EqMjlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc1PQzZcj46H1DBt2bC75+dS9hXiABnLPJYBbAA6P3fYueAfCsiDFyuRZUN70+2MVlC356sVwE1k5b0qpv6oekDRlziGShxPlw7mT/lrU1HEuRCIFa16F+/lINDTKY2KPruv/eAYTj7VhaL52ZMzv02EkAxlx766zlrMpv6M+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq46LZAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08220C4CEEA;
	Mon, 23 Jun 2025 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750683123;
	bh=agJj4kYh8kr853tyRsYlX2onZ0GFTf4kg9la+EqMjlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq46LZANmOtBJ85Z9P9DsC9vwn68amjzFGw19HCiRQiMQ1VkGm26fVByeMXG1J8o8
	 UHjXLp+4yOYVZZxtJ7j1e1Gu/vmF+dsNMzqdLyXWDmuWpLDuyKT+zVbetC+CwIT3tB
	 Rf7gQH+tUc+6erciqtiazqUEhl7UN0nAP6f/xw19z8ZPt3DbC9/TwkshftA0jc3j4Z
	 1zJnum4tKBXX60M7hrYzrjNroNYaKIbjLXFc8sjV2e+I5/STjEbzUuuj5XaUJkJ2I0
	 nsznF/dolX2GMnC0eWri6BggSc/HoS9Cde9D1ob46TX4l02fZF7JYREdZLlefyp1yi
	 nrg+QeAR/mT/Q==
Date: Mon, 23 Jun 2025 14:51:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: devres: implement register_release()
Message-ID: <aFlN7W5rMRcmE300@cassiopeiae>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-5-dakr@kernel.org>
 <aFlCCsvXCSJeYaFQ@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlCCsvXCSJeYaFQ@google.com>

On Mon, Jun 23, 2025 at 12:01:14PM +0000, Alice Ryhl wrote:
> On Sun, Jun 22, 2025 at 06:40:41PM +0200, Danilo Krummrich wrote:
> > +pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
> > +where
> > +    P: ForeignOwnable,
> > +    for<'a> P::Borrowed<'a>: Release,
> 
> I think we need where P: ForeignOwnable + 'static too.
> 
> otherwise I can pass something with a reference that expires before the
> device is unbound and access it in the devm callback as a UAF.

I can't really come up with an example for such a case, mind providing one? :)

