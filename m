Return-Path: <linux-pci+bounces-34474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B7B2FF5B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92666B017C2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6BA296BBE;
	Thu, 21 Aug 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MscgbS+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7B28640B;
	Thu, 21 Aug 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791267; cv=none; b=ey8NQvHCCrHf9WWtE7bjMBW6GfkFR9thpNr0V5xUOa/DsZMKnHYUEDbapvp9xKsRZkCn2zOUTORfGI76fMV80lhXccNUiuwKi1+2zD+2inEpBYVqXmw+JtuUI6Y/86/fzQY+J0MWnsTrgS3rTXX5iE3PZw66bw185+xVxriJwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791267; c=relaxed/simple;
	bh=S7ZDNRuDN0Px39uvl3kGUiH5rUHiJ947Q7oG72mYLyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ja7gc1ugwyi/kiRJN4iC2sZNtN3xuJsSVZA3UDL0ZE0IqQ113ktxCoBXNgZQf7XNmbJnPhdDqqwnwnp/IbMlPQOcnCwp/QhZmdQwRVrUvE3GI96S5Z2ZieUkQ/nzNQV4/gs6QXldJb/kArrYbsT//9YdnMYqiMHvb7rJd26vRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MscgbS+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F9BC4CEEB;
	Thu, 21 Aug 2025 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755791267;
	bh=S7ZDNRuDN0Px39uvl3kGUiH5rUHiJ947Q7oG72mYLyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MscgbS+g6vgu3O2fCBH+GFkHaj9RV9bFHVSOAGzlNcDlqfTQ9uvBM5sGec4QHB54J
	 8HN6pK57H05Sl8Hmev554PCSXDI/k8+iSZMW//AWJ7FMdxEGMNtk0s1JCn1x/j5wwk
	 QneKi5VO60b2EecDGGPzhpH4JHgmj0Sv2Bpnrtw3613TEp4ZUBnBt+X7x6TTOx8Avn
	 2upbV4W2QwtyLrWCCdm8Qdu7A5aYN8fY9pWOxJkhj3Wt4k6FysvSoSIrPChRcVPNTc
	 2TT38sYfMWjptjkkcirFlW8kis46lKdL9v1qJuk4M9Exm5HkVZ9Xx+UusnjLU14FbF
	 9Ltd67nqsNiDQ==
Date: Thu, 21 Aug 2025 10:47:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
Message-ID: <20250821154745.GA677624@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3018c24-7626-d406-2487-67ea32bd2712@linux.intel.com>

On Thu, Aug 21, 2025 at 06:24:12PM +0300, Ilpo Järvinen wrote:
> On Thu, 21 Aug 2025, Ilpo Järvinen wrote:
> > On Thu, 21 Aug 2025, Bjorn Helgaas wrote:
> > > On Mon, Jun 30, 2025 at 05:26:39PM +0300, Ilpo Järvinen wrote:
> > > > When using relaxed tail alignment for the bridge window,
> > > > pbus_size_mem() also tries to minimize min_align, which can under
> > > > certain scenarios end up increasing min_align from that found by
> > > > calculate_mem_align().
> > > > 
> > > > Ensure min_align is not increased by the relaxed tail alignment.
> > > > 
> > > > Eventually, it would be better to add calculate_relaxed_head_align()
> > > > similar to calculate_mem_align() which finds out what alignment can be
> > > > used for the head without introducing any gaps into the bridge window
> > > > to give flexibility on head address too. But that looks relatively
> > > > complex algorithm so it requires much more testing than fixing the
> > > > immediate problem causing a regression.
> > > > 
> > > > Fixes: 67f9085596ee ("PCI: Allow relaxed bridge window tail sizing for optional resources")
> > > > Reported-by: Rio <rio@r26.me>
> > > 
> > > Was there a regression report URL we could include here?
> > 
> > There's the Lore thread only:
> > 
> > https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me/

The email thread is fine and contains good information about how the
reporter tripped over it.

> > (It's so far back that if there was something else, I've forgotten them 
> > by now but looking at the exchanges in the thread, it doesn't look like 
> > bugzilla entry or so made out of it.)
> 
> Making it "official" tag in case that's easier for you to handle 
> automatically...
> 
> Link: https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me/

Thanks for all of these, I added them to the commit logs.

Bjorn

