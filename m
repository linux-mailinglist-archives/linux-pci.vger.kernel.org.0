Return-Path: <linux-pci+bounces-11201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE05894623C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1B128345D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856713634A;
	Fri,  2 Aug 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9/KQwt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702016BE3B;
	Fri,  2 Aug 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618336; cv=none; b=ebJEwexfQfoDnDkP9L6ByRQ7LHc6SrKuelRZUbVHgMR7KXVNxWtJJVzeeBFSr7nS3Vg/0OdQXR9PrW50gZWrqiYwzxu377DjnH4v++du+mUdOt0X632IQZ2y09ypIQclmcAblzxjEd4Bp/hI8Rk+YymZn0Q7w9DGYenBykHwlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618336; c=relaxed/simple;
	bh=BaaOUPxE63y8U8q+BOZAPvydLCLHsJUCTvZjvrGQvZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XpsJugMbbAgvACWbGjQFb2IAGkYWQ588jxHK5IKDCkjCGw8RmhK9oa48CvX8PAN1iKIwkL52Ru+kwAI4g0Av6KGU5gSTP3XUc+fSVjGXc0eIyNToUUBFSNui0Cupm97paFYJJiK61RYKIUe+jOzrls6ZlteQ3a//kAkdpmLelZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9/KQwt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D70BC32782;
	Fri,  2 Aug 2024 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722618335;
	bh=BaaOUPxE63y8U8q+BOZAPvydLCLHsJUCTvZjvrGQvZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T9/KQwt37sTL2WfXrSrcgjOVRW4lUtEeZDNmaFAnoyofTA+GTIWkG1/EPzdhYTjg6
	 QXsttm4dGSvDePi8ZRwkWdBeb7Gx6EPgHtc6ug5GqVtmzryX5zeylUoVJh3Bs1LYkU
	 zlqp39zadhTPMqtapvnTbh5TThfpoSsGZUYO3GRDgslZNUEUrUCSi0yGHL9MnMZULr
	 8AbR62F8hUyLyqk5xqSetopJ97MNTH3Zd8OMV33bSXoyOCYCDyW4q9t8HM9GOyTxFc
	 TXi7sjV8mwxRDxDOvgS5mPxSrEFvLzwgg8YMyOdIiaJos8cF0CIvGwRAyT3Z9mFHpm
	 wFY6iDbtF51RA==
Date: Fri, 2 Aug 2024 12:05:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 04/10] PCI/TPH: Add pci=nostmode to force No ST Mode
Message-ID: <20240802170533.GA154363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f25d99-bf27-4521-944e-7ebfe3447a14@amd.com>

On Thu, Aug 01, 2024 at 11:29:22PM -0500, Wei Huang wrote:
> On 7/23/24 17:44, Bjorn Helgaas wrote:
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -4656,6 +4656,7 @@
> > >   		norid		[S390] ignore the RID field and force use of
> > >   				one PCI domain per PCI function
> > >   		notph		[PCIE] Do not use PCIe TPH
> > > +		nostmode	[PCIE] Force TPH to use No ST Mode
> > 
> > Needs a little more context here about what this means.  Users won't
> > know where to even look for "No ST Mode" unless they have a copy of
> > the spec.
> 
> I can certainly add more description to talk about "No ST Mode". Also, will
> "tph_nostmode" be better than "nostmode" in your opinion?

I don't really care about the parameter name.  I think just spelling
these out once, e.g., "PCIe TLP Processing Hints (TPH)" and "No ST
Mode (Steering Tags must be all zeros)" is probably enough context.

