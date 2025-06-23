Return-Path: <linux-pci+bounces-30439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFAAE4C26
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC1C3B69E9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2D2673B5;
	Mon, 23 Jun 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQpDNoVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDA2472A0
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701118; cv=none; b=J7ZtvwJof9OCL7adqhAR1GK5MChr0CgBVs7uB+1ZJDsdO+vCVPm5Hsm/GSNwg0eUQfTW1atRThRaM3md6k2uqVZLDcUN27UrzgSmZuuvzm7YP7jDLp0oaTyC3Kjme81QU56TCx39rHzbiyiZJPSsEmVgtoHokS6vaxhZ+mbKM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701118; c=relaxed/simple;
	bh=uT4eN0oH0BdUOC4cASVdHXq2DlOuNyGLBtFUDBFkZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+O+TUaEWyUwyeBJg7OZwAEv772QLpEI5P7p0peIzPH3ht9w2GHfgSE+bD4/jk35W3dUzK0FW5dDr2hbBikPLZpA5M9HoKdIkwzave7eDfFLSrxvOIPf/t/0Hfni1UrSDfub0H27xeU0+foL7vda7f1CTA4TxBbHRtM5rSzSGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQpDNoVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AE0C4CEEA;
	Mon, 23 Jun 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750701116;
	bh=uT4eN0oH0BdUOC4cASVdHXq2DlOuNyGLBtFUDBFkZlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQpDNoVHCuf2Bm3F+BfZISp+4ioI9QOjF6Tb8XIaDS7qauk/rQ7hWIc46aQ6/UUho
	 ECMNgTy8kGUHL3VAsRFcKm+oXJtJPmtOj44mhsgPhBZEngYsi1bnw+c602QyNpVWF4
	 lA37Mh0vovq6jewPAe8RZsUFGEmMNf1fs7T+VHd1mvKYKxSNEttfgocS15vHlG8/OC
	 32C68q4jaKb8Xv0gk8Nslin53L2hMgDhCD9FjGuH0nbPCpa6Qka/GNtWgIJM8E1acR
	 T+bJcEqAt7gUb1WECiDKGQXXzH+FeGPgeg5z9buB7dcGLrc70hDTjPtZDXy/D6Wjh6
	 V3Vtg7MxNTkHw==
Date: Mon, 23 Jun 2025 11:51:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Keith Busch <kbusch@meta.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
Message-ID: <aFmUOppCJKylJznO@kbusch-mbp>
References: <20250218165444.2406119-1-kbusch@meta.com>
 <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>
 <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5>
 <aEmxanDmx6f_5aZX@kbusch-mbp>
 <reekyt4dm7uszybipm25xfxlksn5bm2cdpubx5idovxenpg44z@qcqs44xlevea>
 <aEm6Nx6bSDvyouEy@kbusch-mbp>
 <48d598a4-27e4-e1d4-a6a2-9dc1fec10b77@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48d598a4-27e4-e1d4-a6a2-9dc1fec10b77@linux.intel.com>

On Thu, Jun 12, 2025 at 11:06:41AM +0300, Ilpo Järvinen wrote:
> On Wed, 11 Jun 2025, Keith Busch wrote:
> 
> > On Wed, Jun 11, 2025 at 10:41:33PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jun 11, 2025 at 10:40:10AM -0600, Keith Busch wrote:
> > > > 
> > > > No. I'm dealing with new devices being actively developed, with new ones
> > > > coming out every year, so a quirk list would just be never ending
> > > > maintenance pain point.
> > > 
> > > Sounds like you have a lot of devices behaving this way. So can't you quirk them
> > > based on VID and CLASS?
> > 
> > What I mean by active development is that the timeout continues to be a
> > moving target. A quirk only gives me a fixed value, but I need a
> > modifiable one without having to recompile the kernel.
> 
> Hi,
> 
> Doesn't DRS/FRS address this such way that the device can tell when it's 
> ready? So perhaps check if DRS/FRS is supported and only then make the 
> timeout like really large?

Even if the kernel supported that, you'd still need an arbitrary timeout
in order to make forward progress in case the device never becomes
ready.

