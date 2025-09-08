Return-Path: <linux-pci+bounces-35695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B93B49C4A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE76D4E1098
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9F2E7F16;
	Mon,  8 Sep 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1nq8UmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6372E7BCC;
	Mon,  8 Sep 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367591; cv=none; b=K8DWHb1TSa4G62yutknHwt2bphzQMfGPAFvBCoXvVccplFiF3MIUWDLYfpuwTJ4TV90Rvw1VqgcqqVpK6t6X65kO90c6pbLy1IqteeWh+Gp2oJFagsTibiaNItTnKgXW0Fcf1VBavZe+se4JoLWeyatjatdC4cuVBapbTLWcd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367591; c=relaxed/simple;
	bh=UU018OS5T8BP6FQvRLgEBBbYmTBbhOLVCvGQwUhRScg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSclH9eQL/Uhcm9cZq7QT2d/aHvcO8rhbYDzrGLPV4exSwbDDInB5KGtnOl2TWNZ/hmztAS+T2FYyyeSanaQZ6558GPhED1p2hM7yA3GPGbdpyWsgJTUS2fJc70K2RrjBH6l68y6op1gZ7ZB9Au3p7klI0DwpuYBgt2SwyzyANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1nq8UmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183ABC4CEF1;
	Mon,  8 Sep 2025 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757367591;
	bh=UU018OS5T8BP6FQvRLgEBBbYmTBbhOLVCvGQwUhRScg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1nq8UmLGx5uRMQs6vh1VmUFVYOAhLM8k3R8gBBpIz5bJ8FbBW4/mPoZh3opih+d9
	 fD77GaQ1PNtQC9IachDxXUOs0L9pFzXvHPnMwZJJynrt6xEfjEMooCEvEITPHc2aQd
	 2YzvfcA+lyEs5QjH+jYg4eO3bAGh3oW5cyvpvv8wl8fjyR4Iy89cCYBM8kKwzHVf7t
	 4TM7W86KNAj7GTJEPLUU9c9xhFdgp1jQ+dNmBInuvFJsNzq+BBjvITJaLyzAk7hwB8
	 YzE1A/QaN4qDYNpA1+gqTN/Qs97XnUkegNOA/cJmkgxiXE0qs28rB1mLGHaH+AP1Qx
	 dlEv9ESd1sVSg==
Date: Mon, 8 Sep 2025 14:39:50 -0700
From: Kees Cook <kees@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Message-ID: <202509081437.1F92F56@keescook>
References: <20250905052836.work.425-kees@kernel.org>
 <20250908205349.GA1463686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908205349.GA1463686@bhelgaas>

On Mon, Sep 08, 2025 at 03:53:49PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 04, 2025 at 10:28:41PM -0700, Kees Cook wrote:
> > After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> > ffs()-family implementations"), which allows GCC's value range tracker
> > to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> > "ffs(rq) - 8" used here:
> > 
> > 	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> > 
> > could wrap below 0, leading to a very large value, which would be out of
> > range for the FIELD_PREP() usage:
> > 
> > drivers/pci/pci.c: In function 'pcie_set_readrq':
> > include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
> > ...
> > drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
> >   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> >       ^~~~~~~~~~
> > 
> > If the result of the ffs() is bounds checked before being used in
> > FIELD_PREP(), the value tracker seems happy again. :)
> > 
> > Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> 
> What's your plan for merging cbc654d18d37?  I suppose it's intended
> for v6.18?  If it will appear in v6.17, let me know so I can merge
> this for it as well.

I had it planned for v6.18.

> Maybe this should go in v6.17 regardless, to avoid a warning
> regression between this patch and cbc654d18d37?

Sure, or I could take it as part of the ffs series?

-Kees

-- 
Kees Cook

