Return-Path: <linux-pci+bounces-29479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E83AD5C7D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE72A3A9325
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C930210F53;
	Wed, 11 Jun 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+5vncWg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859820FA86
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660014; cv=none; b=pO6mPUO3cPcFu7ZcUJ09GztMmZn/llCArjloZjLDOdf/b/RN6o8HtbFSd/njNPio9TGdYPo9GCD4V8ZJorkwW08VqxZxfxM2sB0nM57kuqFSW1WKmj4HruWAb13gOa3ZqYS/ZI06cMxJxbifkRPyYteuUQA42+mzxXgj2cLJnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660014; c=relaxed/simple;
	bh=l+mxvvSJje3rc/DPsMuR4oUJwj6tIwV3YLlupNT2q8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rps9Alw1AcS8BNJCuCj7la3JWg0T12BMySvpBm+gm/LCtxa+TnjFNCG89y+XnSpB8T538KMCMfBZgwRRNoHJMKRDy1FaJ07o/hR6AX7Xc/iixBre2vTXRLTPlwZlzmLKZmo2RfRHdEpCe6h7x+f6N2qQO0GcisYEGGLdRQuPvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+5vncWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DA6C4CEE3;
	Wed, 11 Jun 2025 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660013;
	bh=l+mxvvSJje3rc/DPsMuR4oUJwj6tIwV3YLlupNT2q8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+5vncWgNfib6yxkAr1RxTaTjnMuqitybv2gULgmuHIbiIBIUgEXxsV00uheNo2HJ
	 QbNY9PIcZAR6DazSrJN3pvNlD6sgvDZl7Fp/PdiBYScy3HjsUUEziKtOymJFwO9jU8
	 dsY5C478XZ2HAto2KPkkEOv8ne/8klqAJ2Ra6JeJdI/PkL26QfyIP/3xMj1psOmFj2
	 WArqJgMAewIuSKIJlDesNTIhLAtHKguUzOZPB1qorRPJmt7QzTxCFmbINvDgtQ83r/
	 AKiMtYGgZtLjgHPgqFJtnXY9ennu9EUmI+10aLiUbctNUa4p7HSst6wonKFfjAhZcj
	 jjQHnaJrJT7zQ==
Date: Wed, 11 Jun 2025 10:40:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
Message-ID: <aEmxanDmx6f_5aZX@kbusch-mbp>
References: <20250218165444.2406119-1-kbusch@meta.com>
 <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>
 <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5>

On Wed, Jun 11, 2025 at 09:58:59PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 14, 2025 at 06:11:44PM -0600, Keith Busch wrote:
> > On Tue, Feb 18, 2025 at 08:54:44AM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The spec does not provide any upper limit to how long a device may
> > > return Request Retry Status. It just says "Some devices require a
> > > lengthy self-initialization sequence to complete". The kernel
> > > arbitrarily chose 60 seconds since that really ought to be enough. But
> > > there are devices where this turns out not to be enough.
> > > 
> > > Since any timeout choice would be arbitrary, and 60 seconds is generally
> > > more than enough for the majority of hardware, let's make this a
> > > parameter so an admin can adjust it specifically to their needs if the
> > > default timeout isn't appropriate.
> > 
> > This patch is trying to address timings that have no spec defined
> > behavior, so making it user tunable sounds just more reasonable than a
> > kernel define. If we're not considering upstream options to make this
> > tunable, I think we have no choice but to continue with bespoke
> > out-of-tree solutions.
> 
> Do we know the list of devices exhibiting this pattern? And does the time limit
> is deterministic? I'm just trying to see if it is possible to add quirks for
> those devices.

No. I'm dealing with new devices being actively developed, with new ones
coming out every year, so a quirk list would just be never ending
maintenance pain point. The fact I can't point them to off-the-shelf
kernels to test with has been frustrating for everyone. If we just had a
user defined option instead of forcing the kernel's arbitrary choice,
then the problem is solved once and forever.

