Return-Path: <linux-pci+bounces-38094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A16BDBA51
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 00:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCD3A9E64
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2C30DD2C;
	Tue, 14 Oct 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liNf9T2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4273081DC;
	Tue, 14 Oct 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480730; cv=none; b=K21/qt7ZVRnlptZrJHGSLuTyQNuNaJXysgbZN1lMHZKe5AmHXwgKQNsYT1r2TXEw8hRCCqiw6Fp+Rl1aOD8Juuo/Fng3oT5nPLDGVdtdFV3IBfgu3ibvSLn93v5pelwpaGf9iMbESEAxax/+V1u71DIFUmSJ7lBYM9JTGSVM4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480730; c=relaxed/simple;
	bh=Bk6tOAIjGpqsinKNke8LjcxZyyMelB7HsuLcZ9QiFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdl7AJbguhf2v+D5naFlYcEglvNwkhDnQlJCO6b/LU70ihiZ3aOyHuM9Im7Km+6fVvWUpkTptegklmjcMC7UQQK8cy2HYdlAP8s0d/TrwuPGWduTnTqxGX7TpDnxDxtERJSS8ug16NntBqSnQxusTV94oEz+P4CEEVuqVtD1YD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liNf9T2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86892C4CEE7;
	Tue, 14 Oct 2025 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760480729;
	bh=Bk6tOAIjGpqsinKNke8LjcxZyyMelB7HsuLcZ9QiFLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liNf9T2KgDoTlDWPXHp4RjShC+K3DUZ+0h4AqtoTd5a53VZ7d5YZsQ2xbliHSWX/H
	 AVZ2IY44zySEwbu1omBXNYZLH3hUhe8RRfB39VKCokTuCCpYc0d8X02zjxX39tUJdm
	 hgyif4WSm0OFWdEZGKoCakhz3nMqpit0SfXdsKF9xRyyqcyvlh00LD+8ncN3i9odYu
	 dkVbGv31nI9iBdSvy7vdV6MLmC6dTL+Q9s1qEu8o6uEKcz1lSwBVd7a1Svb2mF+atm
	 BXSXWAKUrLOtE4IViy4GK0RO9pud1srhd9PoYGgtAov5ET0ycGndYzdr/b7HMYM26w
	 TayD5VD/3V7+A==
Date: Tue, 14 Oct 2025 15:25:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: rcar-host: Add OF Kconfig dependency to avoid
 objtool no-cfi warning
Message-ID: <20251014222524.GA3575477@ax162>
References: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>
 <20251014191330.GA899677@bhelgaas>
 <20251014194728.GD1206438@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014194728.GD1206438@noisy.programming.kicks-ass.net>

On Tue, Oct 14, 2025 at 09:47:28PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 02:13:30PM -0500, Bjorn Helgaas wrote:
> 
> > Ugh.  This might be the best solution, but it's a bit problematic
> > without a hint about why "depends on OF" is here.  Theoretically there
> > are stubs for everything to make COMPILE_TEST work, so I think we're
> > about to drop all the dependencies on OF.
> 
> Its those stubs are exactly the problem.

Yeah and I had thought about changing of_device_get_match_data() to use
something like ERR_PTR() in the !OF case but that does not fix the issue
since the call destination is still going to be invalid. To me, this is
just one of the sharp edges of compile testing: you give up some code or
configuration cleanliness/expectations for the flexibility of build
testing.

> > This dependency to avoid a no-cfi warning looks like the kind of thing
> > that could someday go away if the tools get smarter.  Maybe we can add
> > a Kconfig comment here, but I don't really know enough to write one.
> > Something like this?
> 
> Its not a CFI warning per-se, the compiler is hitting known UB
> (unconditional NULL deref) and is currently emitting a NULL pointer
> indirect call, but given how aggressive clang has been on encountering
> UB it might just stop code-gen entirely and generate fall-through
> warnings (been there done that).
> 
> Smarter compiler here is only going to make this worse.

Yeah, we are lucky that this is all LLVM does with this code.

For what it's worth, there is plenty of "depends on OF" that appears
across the tree and I see exactly one instance that has a comment above
it (none with the comment on the same line). Perhaps these are all
historical if there was a point where stubs were not provided for !OF. I
do not mind adding a comment if really so desired but this driver does
not do anything without CONFIG_OF so it feels like the dependency is
natural anyways.

Cheers,
Nathan

