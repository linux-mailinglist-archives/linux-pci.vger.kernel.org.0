Return-Path: <linux-pci+bounces-19394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94EA03CAF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D693A3CF8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B141D1E47B1;
	Tue,  7 Jan 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj3rp2cu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B651E3DCC;
	Tue,  7 Jan 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246495; cv=none; b=CtkrsRiVABiNa8Q1bgxr46j9JjqlkEla4vfKpXuD+r2WpO7x59G4gky7q0fhQChkERPSS8qxy5b9EPSHsNhupmdsDpNvRGMyOBrq5EgZPjdCmO6FhVGx1EenqvMRDigQ/DJevG/RkvXkzJGkhPwgMrbYMpxraeIllIFpiITV2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246495; c=relaxed/simple;
	bh=E3+8V3PhNnLiMDHhpGxMKuxb+1sB5eunZyDSpoq1yx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0Wq7w+Os+9WZ8CI77y0IjFWUAcvBwdsyH3XRZWkV4TkTab9rY3saAE9kqGWqnqqFuMspBZs8gZ7RtO+Vpg5K235KJfzqeIYik2ecjthuDC42G7h0ZBtlArBG5DcrmtxTk5DPUJpC5l6dwH4/0Aex4TDumWYW7mpCKe6TfQh9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj3rp2cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADDAC4CED6;
	Tue,  7 Jan 2025 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736246494;
	bh=E3+8V3PhNnLiMDHhpGxMKuxb+1sB5eunZyDSpoq1yx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fj3rp2cu+rmWNjWCUc3BqYlDLuComle2hYUtNDhP7qgh2EGFoecl5SIlxEY9+Flro
	 q0cQGWf1pObdINFS6KPNc6k1lWw8OfkIG3s1MSV22FDBogLLYlZw5CVdck0XrcQqli
	 Iwu0QsIpXqGcXQT6PMVknaFLKFF0p9qTck3BVeVAt2lpPxRpUYo55OU9y9bHnB0hwP
	 82tDDnBDf/NSLzPbhohKjXZVN43t0RgV6q/lJOnqZ9XpGYYwmhWZdsOwnOJ+Aai2fb
	 /bgrujCZvzKyl+oDU3mEebzQbDAbgmK77Ra31a71nrkIox1+GWLZDwMvwn5MV2ckhs
	 2f3CXPxcQrfIw==
Date: Tue, 7 Jan 2025 11:41:28 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, bhelgaas@google.com, fujita.tomonori@gmail.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] rust: pci: do not depend on CONFIG_PCI_MSI
Message-ID: <Z30E2F2uDiJo12Ux@pollux>
References: <20250103164655.96590-1-dakr@kernel.org>
 <20250103164655.96590-2-dakr@kernel.org>
 <2025010702-bonus-afar-1565@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010702-bonus-afar-1565@gregkh>

On Tue, Jan 07, 2025 at 11:31:26AM +0100, Greg KH wrote:
> On Fri, Jan 03, 2025 at 05:46:01PM +0100, Danilo Krummrich wrote:
> > The PCI abstractions do not actually depend on CONFIG_PCI_MSI; it also
> > breaks drivers that only depend on CONFIG_PCI, hence drop it.
> > 
> > While at it, move the module entry to its correct location.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501030744.4ucqC1cB-lkp@intel.com/
> > Fixes: 3a9c09193657 ("rust: pci: add basic PCI device / driver abstractions")
> 
> Where did that git id come from?  It's
> 1bd8b6b2c5d38d9881d59928b986eacba40f9da8.  I'll go edit it by hand...

Oops, that's from my tree. I did not rebase to the driver-core tree, sorry.

> 
> thanks,
> 
> greg k-h

