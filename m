Return-Path: <linux-pci+bounces-12908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936796FC1A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177A0289815
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA881D2780;
	Fri,  6 Sep 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj79nbI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9FE1B85D5;
	Fri,  6 Sep 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650672; cv=none; b=uVza7zu1BE7hhMNXMA15wG7YIxKX3e0g0L+7jOf+5aiVim6q3zezVwKVccikRAXZRX7SaJZAwUhGedatord8A+6reo6ZP8MSsl4zGZRNpRyrXpIWm23XuFhGc2DFezLnTfAETCXhQqC/GO6di6Z/aEtfKvog2/5ie61o/kGTRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650672; c=relaxed/simple;
	bh=v8SmWXempYEbE8MC7uuyIGyBwpu5VxDrO1UE3g0pK78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V+A0eiMCYe0Db/7oRXxXrkiZZ2ICyQyevcHt6TO2T1T1wB2DOGfusAtKqPjcXJFphu1x6WWkaqs8Dk7PkVCXLWBZ439EGHKQyDfz93zzEvoHjD6xuqvn7udJcb15yeIIuFmAUjV2kbc8EosFVORGuHDUJcKVoOjXuIHHKQl2zr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj79nbI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69334C4CEC4;
	Fri,  6 Sep 2024 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650671;
	bh=v8SmWXempYEbE8MC7uuyIGyBwpu5VxDrO1UE3g0pK78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bj79nbI2aNRiWFaMqXfpHr1R9ibyIcBMlTnEc+GCFeL2Ze2iJrUi8zighD60UL8jT
	 uhHql73kSPV0fD0at1QgCD/uI8GLQRBGNIzBEvhSa1AH8VmxbvUiNjGyy2F9ZRCwDC
	 65VGHBKmWWUAu1YNRlI9GC4v7bKnsoLJeB87e2anm4334mir87faMLIMnEafTE0o/O
	 h6ENO+gdvrpEwamxVoYi69YyyIJuvo89XRSQF+L4QPhijTgD33zTtwB2tsYDedQ/Gy
	 elIbmssqUfQEbGjQ0j2x6pS9V/rWfRqYRFmV14pe1MBN2FlhyXsczzmCXphfYbQfBM
	 RgsXQxG4OqodQ==
Date: Fri, 6 Sep 2024 14:24:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: Jonathan Corbet <corbet@lwn.net>, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: Fixed spelling in Documentation/PCI/pci.rst
Message-ID: <20240906192429.GA430486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u4xan54bdxf5sniwhtvrixw3b2vg4c7magey6q3rsd4ssq6ihk@xfbijuhadyw4>

On Sat, Sep 07, 2024 at 12:44:13AM +0530, Abdul Rahim wrote:
> On Fri, Sep 06, 2024 at 12:53:18PM GMT, Jonathan Corbet wrote:
> > Abdul Rahim <abdul.rahim@myyahoo.com> writes:
> > 
> > > On Fri, Sep 06, 2024 at 11:41:52AM GMT, Bjorn Helgaas wrote:
> > >> On Fri, Sep 06, 2024 at 06:15:18PM +0530, Abdul Rahim wrote:
> > >> > Fixed spelling and edited for clarity.
> > >> > 
> > >> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> > >> > ---
> > >> >  Documentation/PCI/pci.rst | 2 +-
> > >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> > 
> > >> > diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> > >> > index dd7b1c0c21da..344c2c2d94f9 100644
> > >> > --- a/Documentation/PCI/pci.rst
> > >> > +++ b/Documentation/PCI/pci.rst
> > >> > @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
> > >> >    - Enable DMA/processing engines
> > >> >  
> > >> >  When done using the device, and perhaps the module needs to be unloaded,
> > >> > -the driver needs to take the follow steps:
> > >> > +the driver needs to perform the following steps:
> > >> 
> > >> I don't see a spelling fix here, and personally I wouldn't bother with
> > >> changing "take" to "perform" unless we have other more significant
> > >> changes to make at the same time.
> > >
> > > - "follow" has been corrected to "following", which is more appriopriate
> > > in this context.
> > > - I know its trivial, but can disturb the readers flow
> > > - do you want me to change the message to "Edited for clarity"
> > 
> > The problem is not s/follow/following/, it is the other, unrelated
> > change you made that does not improve the text.  There are reasons why
> > we ask people not to mix multiple changes.  If you submit just the
> > "following" fix, it will surely be applied.
> 
> Understood, will take care next time. I will resend this patch with:
> "follow" -> "following", with commit message "Fixed spelling"

Sorry I missed the "follow" change, which is indeed worth fixing.  If
you resend it, make your subject and commit log say "fix" (not
"fixed"), like it's a command.

https://chris.beams.io/posts/git-commit/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.9#n134

