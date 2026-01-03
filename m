Return-Path: <linux-pci+bounces-43962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A4CF062E
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 592B83015E36
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B129AB1D;
	Sat,  3 Jan 2026 21:16:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514D18C933
	for <linux-pci@vger.kernel.org>; Sat,  3 Jan 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474975; cv=none; b=XgFaNO2PIrICzXyqCzKeWQ+m1XWW9LmKOLITrOVZZo7ih2wAYObQcJvH5EGVAxsx7LXwePs8zM66KlinE11bKrJlXMbzk3h3PkJkEKrwA6kfUxCqLCXelBKFjCmKhKW0f6W//Waed/z/l161lpivwp5zzCU2wsnq3qzfwDqh79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474975; c=relaxed/simple;
	bh=uiOLYSm61ERq2gPGbffcOs1yp9L6ssLDhSpjJurNdxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osWRO+EnWcUYsHbfug0L7T5g4fEpYZSBgR0G+zOEq3gglipYQFSoGBHdiRHY8Z9rG7nJNrwtJsQpl6fvZEZ+ssuGazijg+FSZs2GIapjuChJUw7/i7CQ0v6VUmWVgj2gq7tWmNWCdxT4n0WqiBN6v8KldZ5TRxKs8jpLQD2pVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info; spf=pass smtp.mailfrom=markoturk.info; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=markoturk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markoturk.info
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b725ead5800so1834164966b.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jan 2026 13:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767474971; x=1768079771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7unVhQC3T8DNmPkvBEAcaa6tSYQmAuHw+iiC51rCJE=;
        b=jo82ObW7ZwLGdD7h5Me8X/OkNoGYs1rtF+AKodJQOckYxaNjGTZB2fIm94CRTKuC0/
         CAAh/W0xbTZS0Xe6WQHAjhV1F7ch9yokELpB7+Kp1N04zUbVrDDzbcX0zFIKZ6tJNx4h
         iw+yqoiTQB16jCUHogYSnQqfl0xDDxWPiCbVLH6OA/c+/lEMIyumsRdC1gl1FPiuQjrf
         iddujLnVc0u/FM0QamFj76++BxcQ2Y1RBCRQ7NoQs1iPA2umKMBDfPbm+Sb3Tf4Xlesf
         85VhOvSSUlp/GR4SkoUxAOIwVs+9oHnOYQatW4bwsOZtgkVblUxQbli6aoHUgj3RhG66
         qqQw==
X-Forwarded-Encrypted: i=1; AJvYcCUU8SZrcForTVO8+KWkHENfG4H9O8T3wA89Ptp27xLVnRfgidlba0OAJR7FKNcneytllTpUDYcVfFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErXvmSXPQNDenadk7LJcM9FeE5DSK5tt+8gXUJJxIZWG+rMAN
	Inyo4XWtF1dI8TGBHYIlhLItEZ43n4KV34QA3yFEElsoohEFqrFQhega9/s1e8XPPAE=
X-Gm-Gg: AY/fxX7q+7OQfff5iEZ6K4fuiZ9NiOevqck8eCWv2eg4uKkjCiaXh2r0oFy+hYfxKpn
	ixHCfGQrI2B5wZujMewwIRR78R0afQDpPnYdF0oRW+7mo3WTTWOKj3XoosxuwQbKbbKhu4Quunk
	Aufs3GbuOTl1nco0XtxILIyCqFb/A72EEiY6/U0Zb8xbjMSVc2dGKbz4Mf5G2+co0Tp7I+XgTiy
	COQnANLDkzXqMtqFUH59O3mrl9nWes0pZTqjj/gr95lrdZs8K+h9qjX8i4JDZrHj4DoqM/0nemF
	RsQMdhdQuYipive98GgLuymmUn/Pk7Ld8iF77dAdr69BSE4Lz9yh38kZN3VF5AY3lE0DNOOndHy
	aIhkkw2s1ReCx2PzDjtAx7/2rSIK0H09iUQND7ZTowO4lUNYTLLezQ0jkaSNznhWmbTWgXrNAzy
	fyGxlJG1d214o=
X-Google-Smtp-Source: AGHT+IFuGObiLaYcEpCLsdnPWy/fW1azgSOUQs/3/+r6mlDFstD9ErqMY1MnRi+0ZMkkAUAoABOzjg==
X-Received: by 2002:a17:906:f598:b0:b79:cf10:a17c with SMTP id a640c23a62f3a-b8036f2d2e9mr4343539166b.10.1767474970707;
        Sat, 03 Jan 2026 13:16:10 -0800 (PST)
Received: from vps.markoturk.info ([109.60.4.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a60569sm5170024166b.4.2026.01.03.13.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 13:16:10 -0800 (PST)
Date: Sat, 3 Jan 2026 22:16:08 +0100
From: Marko Turk <mt@markoturk.info>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, dirk.behme@de.bosch.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
Message-ID: <aVmHGBop5OPlVVBa@vps.markoturk.info>
References: <20260103143119.96095-1-mt@markoturk.info>
 <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
 <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>

On Sat, Jan 03, 2026 at 04:38:36PM +0100, Dirk Behme wrote:
> On 03.01.26 16:24, Danilo Krummrich wrote:
> > On Sat Jan 3, 2026 at 3:31 PM CET, Marko Turk wrote:
> >> inststance -> instance
> > 
> > It's trivial in this case, but we usually write at least something along the
> > lines of "Fix a typo in the doc-comment of the Bar structure: 'inststance ->
> > instance'."
> > 
> > Please also add a corresponding Fixes: tag.
> 
> While looking at this some days ago as well I came up with
> 
> Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate
> file")
> 
> But that just moves the pre-existing typo from rust/kernel/pci.rs to
> rust/kernel/pci/io.rs. So I'm unsure if that move-only commit should
> be mentioned in Fixes:? Or if we should go back more to search for the
> commit introducing this typo?

The typo was introduced in the original commit where pci::Bar was added:
Fixes: bf9651f84b4e ("rust: pci: implement I/O mappable `pci::Bar`")

Should I use that for the Fixes: tag?

> 
> Best regards
> 
> Dirk
> 
> Btw: While we are at this file, do we want to add an 'is' in line 57
> as well?
> 
> // `pdev` valid by the invariants of `Device`. => ... is valid ...
> 

Should I do that in the same commit?

Marko

> 
> >> Signed-off-by: Marko Turk <mt@markoturk.info>
> >> ---
> >>  rust/kernel/pci/io.rs | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> >> index 0d55c3139b6f..fba746c4dc5d 100644
> >> --- a/rust/kernel/pci/io.rs
> >> +++ b/rust/kernel/pci/io.rs
> >> @@ -20,7 +20,7 @@
> >>  ///
> >>  /// # Invariants
> >>  ///
> >> -/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
> >> +/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
> >>  /// memory mapped PCI BAR and its size.
> >>  pub struct Bar<const SIZE: usize = 0> {
> >>      pdev: ARef<Device>,
> >> -- 
> >> 2.51.0
> > 
> > 
> 

