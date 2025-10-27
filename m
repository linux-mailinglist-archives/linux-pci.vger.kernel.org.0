Return-Path: <linux-pci+bounces-39420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E11C0D828
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3DB1886A3D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04B301498;
	Mon, 27 Oct 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPBjO0Nw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2A2F83BC;
	Mon, 27 Oct 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568022; cv=none; b=pKAvjVi5bzBieCIp7HQ1tSchhu1DM/BzOQzTN8CjASE9GnuLJv8XvAZ+6etIAT0mnYlIpyYP0BMQMW3H6KhngIDaXvo5ZPYGNSqFpKgzyGDE9iiD0FOri6EgX/WlGuAxxWN1KbCDnBmGxnI9aXhzTvenxW1GM9v1tSGedsKGXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568022; c=relaxed/simple;
	bh=fvaGxMacO8O1vJMtEVa9TcNxktkuquuPCtfiu/C0La4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrmtjrn63hDwo3QeR3NHXOZj5ymDHdlEUXL+l1jxlocPLzCVqS5rg4NK6tAfHJ0a7Mo6A6SPdtJpoq2Vr9+m3k9xsGJiULndHcAwj7tXCphVF+ONI8/HwQNOVzXs84YKNtlJ2AtqcNiY/Y8SZTUGbGdEAoemAzyS/J7mFthye+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPBjO0Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADD7C4CEFF;
	Mon, 27 Oct 2025 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568022;
	bh=fvaGxMacO8O1vJMtEVa9TcNxktkuquuPCtfiu/C0La4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPBjO0Nw9HE5Zbh0K6f5PTC+DExsZT9JWu2FUORUj+Q2Q0ANNLkEH7x8c3yIjBJpy
	 LQPGWAwm5xdtD3nWgWYv9oJ+FtcNxMWV6Dt8KYcmQrM5t0MWPi4lpDYiOT6ofOjX9g
	 GmdCS+xsmRmPYgTEOTzy4yUk09iIa4WUAqhZGB+DQ5hrP7imNycojA31KCr68LpEsh
	 ZAevvd9De7rqzpplCqSBaiFJYpGwlPIZJxcKzdU04jHkK1f71Y7QY4Q/1Hu2lDm5ag
	 Vcm55ZKqcK7h3IvR11npmY2HNPQkcPYg9BxRjxO3vhL0cNJTtAGx3xKSxQXGmXnewl
	 wM4LSiGpjnTDA==
Date: Mon, 27 Oct 2025 17:56:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: rcar-host: Add OF Kconfig dependency to avoid
 objtool no-cfi warning
Message-ID: <myt35uyg7v3pwlck6zd643dzjezfrc2d4t66kn7gdzxwjhysdo@64cprpjpbjlh>
References: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>
 <20251014191330.GA899677@bhelgaas>
 <20251014194728.GD1206438@noisy.programming.kicks-ass.net>
 <20251014222524.GA3575477@ax162>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014222524.GA3575477@ax162>

On Tue, Oct 14, 2025 at 03:25:24PM -0700, Nathan Chancellor wrote:
> On Tue, Oct 14, 2025 at 09:47:28PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 14, 2025 at 02:13:30PM -0500, Bjorn Helgaas wrote:
> > 
> > > Ugh.  This might be the best solution, but it's a bit problematic
> > > without a hint about why "depends on OF" is here.  Theoretically there
> > > are stubs for everything to make COMPILE_TEST work, so I think we're
> > > about to drop all the dependencies on OF.
> > 
> > Its those stubs are exactly the problem.
> 
> Yeah and I had thought about changing of_device_get_match_data() to use
> something like ERR_PTR() in the !OF case but that does not fix the issue
> since the call destination is still going to be invalid. To me, this is
> just one of the sharp edges of compile testing: you give up some code or
> configuration cleanliness/expectations for the flexibility of build
> testing.
> 
> > > This dependency to avoid a no-cfi warning looks like the kind of thing
> > > that could someday go away if the tools get smarter.  Maybe we can add
> > > a Kconfig comment here, but I don't really know enough to write one.
> > > Something like this?
> > 
> > Its not a CFI warning per-se, the compiler is hitting known UB
> > (unconditional NULL deref) and is currently emitting a NULL pointer
> > indirect call, but given how aggressive clang has been on encountering
> > UB it might just stop code-gen entirely and generate fall-through
> > warnings (been there done that).
> > 
> > Smarter compiler here is only going to make this worse.
> 
> Yeah, we are lucky that this is all LLVM does with this code.
> 
> For what it's worth, there is plenty of "depends on OF" that appears
> across the tree and I see exactly one instance that has a comment above
> it (none with the comment on the same line). Perhaps these are all
> historical if there was a point where stubs were not provided for !OF. I
> do not mind adding a comment if really so desired but this driver does
> not do anything without CONFIG_OF so it feels like the dependency is
> natural anyways.
> 

@Bjorn: Do you still want to add a comment for the dependency?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

