Return-Path: <linux-pci+bounces-38082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B1BDB1C2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 21:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76992542453
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F42D2490;
	Tue, 14 Oct 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XX59pz1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0F27280E;
	Tue, 14 Oct 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471257; cv=none; b=GL5oqyu1DoLG9u/NEJ2mjYB9IP6tGBHTwNwgCDTUrw0O6tWlLNUbdHDsKSy53jYfwZMEQ6ie8Rp6MoS8emDJAQbRQCueEQI4S81NuvCkmqaJyhCrRMJZRVZbM+Wson63hK5wzh5hPfZKDk9CRWpMIInLsxT8qgzrQbTlzRPziMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471257; c=relaxed/simple;
	bh=0S/EKsWggzQkapDkJ1mnKJi6Np27cypVP77NWqf3IFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krgsQLr02WvXp2yfcsO/DlIK6AZXaN+qNRB8ZbQO7wdfOEuT9GVdIhSmWXSfPqELpM7C8PyxmOMssEitYrF5kvRMVmiTCgpaFg3NR644uLdl8JJ20vdGwdeL1TsDZxHRhrPgRe4GS9j+Y+13SdDjuaZZoJ0U5p+THt92XWoEhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XX59pz1J; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9zsB+Z9veiz23XOub9hUkvExAVgUxc80kZIPD9+X7bI=; b=XX59pz1JME4ECjGTWmUxXFqUsD
	54ciJmMk21ZCK10jWkBtnTXW/UGhkQ6q5vnuh6V1YNtvRiuGzM/muwNGDNfVTiyWmx0OE4vqPQVuL
	DYQgkz5mgXB+JPWhr119pzMhGTX/1c6lBoDp+iPpz/YX00fP1wTfyGOhAgIniISA10IZwM5VftJOh
	MrhHbH/N/US9w/uyk6PW2lQXGf/UMd677wMOtvnMFXfn+tcCuK3kXlSVIMULGQLex8Mghhr1b6/D+
	dFlf1TTvNQ++pUat2xF4484U/MVRkylLPg5TJHWXdzcvAzAZqQc6Uv64GhFnTz0m5sB1IG97XkZJk
	KQB4r4zQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8kzZ-00000005PO4-2bMj;
	Tue, 14 Oct 2025 19:47:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 33D0C300212; Tue, 14 Oct 2025 21:47:29 +0200 (CEST)
Date: Tue, 14 Oct 2025 21:47:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
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
Message-ID: <20251014194728.GD1206438@noisy.programming.kicks-ass.net>
References: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>
 <20251014191330.GA899677@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014191330.GA899677@bhelgaas>

On Tue, Oct 14, 2025 at 02:13:30PM -0500, Bjorn Helgaas wrote:

> Ugh.  This might be the best solution, but it's a bit problematic
> without a hint about why "depends on OF" is here.  Theoretically there
> are stubs for everything to make COMPILE_TEST work, so I think we're
> about to drop all the dependencies on OF.

Its those stubs are exactly the problem.

> This dependency to avoid a no-cfi warning looks like the kind of thing
> that could someday go away if the tools get smarter.  Maybe we can add
> a Kconfig comment here, but I don't really know enough to write one.
> Something like this?

Its not a CFI warning per-se, the compiler is hitting known UB
(unconditional NULL deref) and is currently emitting a NULL pointer
indirect call, but given how aggressive clang has been on encountering
UB it might just stop code-gen entirely and generate fall-through
warnings (been there done that).

Smarter compiler here is only going to make this worse.


