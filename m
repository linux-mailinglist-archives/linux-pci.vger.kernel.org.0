Return-Path: <linux-pci+bounces-37734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C1EBC69DA
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 22:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 958614E1FB7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEC27A46F;
	Wed,  8 Oct 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMgL26eN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7B279DA9
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957094; cv=none; b=iteQcL9vr7RCXlAW6vc+CyRxuDpfrrYzNufGvWtS5bT4FsqK7r9T+rM0NUotQLzjPGSgCdjxfmDS+pn4ktG0JwOWfSos3K+7/l5lH5HvHOskyJDDKt0Om1T1De/RhR/2xkXichGODlXCDBYDKw+EChcotyMWBLsbO5FUrLZNM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957094; c=relaxed/simple;
	bh=xnO5HgzTyiLz/UwQxKbb9Uwd4yc4LASsm1dZK5WOjJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MFVerOYVuc9NO+v2PVQK/b0Rtg0xt0pXmwkzHpacWqhk1KiPlyaEUe3kZuvgAhy3uh8OOwQy8AY5qyoeYU0JYv6iX/KcvGVVuIZblZ6NPxZiMAwR2405mUkQ0CMv23ByHcn+ClGJ3VYSfEuZhMmRZeaiAZ66Yvq6C1NrXKZf5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMgL26eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B0DC4CEF4;
	Wed,  8 Oct 2025 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957094;
	bh=xnO5HgzTyiLz/UwQxKbb9Uwd4yc4LASsm1dZK5WOjJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SMgL26eNgqcg831veoJUGlypH4ZtGJcYXzZiycuFYsyepTd7C0DzWURkzxsPGyL3t
	 kM6GBwMpYXvzDplM91KYL9FN4Yfsll2lRzTJdSJjXgcror4s8LNv0du/YqNtBhQrhC
	 RsokvvO9FErCVLM2+aw9S5JxLrZabbGJmPOJSvfvtLD7KRiOBscZiQo+mMvT76Dfgb
	 pU65u0mpKJ9H3/43Cu4yM0PXG4wqFq4g4ayCGJLJKnIEl65yiuPEd6k/u2xPwQ9aNb
	 fI8xWQjOfwV47ZI67h7n5Chzjjbp/m7QmN8ybac32TgxJWqCt8lZ10fnGyzq2WWdzt
	 0t5Sfu6e2J4Mg==
Date: Wed, 8 Oct 2025 15:58:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available
 memory to use loops") gives errors enumerating TBolt devices behind my TB
 dock
Message-ID: <20251008205812.GA641752@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d5e1d1-10ef-4e51-9a46-d6d67db61c43@panix.com>

On Wed, Oct 08, 2025 at 01:30:46PM -0700, Kenneth Crudup wrote:
> On 10/8/25 13:14, Bjorn Helgaas wrote:
> 
> > Can you try this patch, which identified the same 4292a1e45fd4 commit?
> > 
> >    https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com
> 
> I'll try it RN. But OK, is it just me, or has Lore changed from straight
> text to "funky" colored HTML? It's nice visually, but now "save-as" doesn't
> work any longer to produce "git apply"-able patches.

Interesting, I see colorized diffs too; I don't remember if that's a
change.  My biggest beef with lore is that it's hard to use on a
phone.  But it's still the best thing since sliced bread :)

This worked for me:

  $ b4 am https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com

Or I suppose you could use the "(raw)" link and save that.

> > I tentatively put it on pci/for-linus.
> I just "git remote"ed your tree, do you have a SHA? I'm not seeing it.

Should be 4230b93d836f ("PCI: Fix regression in
pci_bus_distribute_available_resources()") at
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/

