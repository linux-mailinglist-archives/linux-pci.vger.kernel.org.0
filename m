Return-Path: <linux-pci+bounces-23229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE7A5828D
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BD616B3F5
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D11917ED;
	Sun,  9 Mar 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mF+pIM8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC614D70E;
	Sun,  9 Mar 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511687; cv=none; b=OBfBxeAbU51HBEPMCN3nISjrMRDtOkpGeF2B4dRMGI5nopPLAPj7RqIElkyuZpetPqiJyWytmfZqEKqdT0ORzniumWOO8zBMsgrIw41s2iXCE2N12SrmSQN/PZBBc2iAeulfmM0TLa2k/wG/byBcXPbgeffxa2w9Iu6sC2G0Cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511687; c=relaxed/simple;
	bh=aK4ddDcxtFJ7lB6ezpnifndlbSfF66rpQY92j4prjdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3Pzxyc+jI+B84QcmnkMl1oap5imXGLK1JU9Sdu1jaP/lji3sqDJjCkH4uY8swQY4JEZJ8CEBn0AvDuQZOsiRcQNYRoVF20AToumhcGPbCjjON8x0SsAnE16xLzCEkxqooP4Rl8tNrUJiv5DrKYtuGwxZnagHzlww+kwOuwaVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mF+pIM8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA69C4CEE5;
	Sun,  9 Mar 2025 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741511686;
	bh=aK4ddDcxtFJ7lB6ezpnifndlbSfF66rpQY92j4prjdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mF+pIM8KBqC/G6pPebNDNayB8PQXlehhZD5mNNaXeOIKl4rJWNxuQ+rRg+QVu6tp8
	 ClLUY7Fn17AvbzFkWfT/K3MTPinCYwwkC1vuN2MAyhcUMr0L0W/9xVJS2YpSqjUvI/
	 F9t4n1CXcgBIFlKU3dtCQMnQfFcEltjzKsVaSsLc=
Date: Sun, 9 Mar 2025 10:13:30 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Message-ID: <2025030913-sensitize-exposable-abce@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2B62772A-4292-4673-8F86-9D27D7AB4EE6@live.com>
 <2025030939-moonrise-zipfile-97cf@gregkh>
 <PN3PR01MB9597AEE275F867871BD9A5DFB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597AEE275F867871BD9A5DFB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Mar 09, 2025 at 09:00:07AM +0000, Aditya Garg wrote:
> 
> 
> > On 9 Mar 2025, at 2:21 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Sun, Mar 09, 2025 at 08:44:16AM +0000, Aditya Garg wrote:
> >> 
> >> 
> >>>> On 9 Mar 2025, at 2:10 PM, Aditya Garg <gargaditya08@live.com> wrote:
> >>> 
> >>> From: Paul Pawlowski <paul@mrarm.io>
> >>> 
> >>> This patch adds a driver named apple-bce, to add support for the T2
> >>> Security Chip found on certain Macs.
> >>> 
> >>> The driver has 3 main components:
> >>> 
> >>> BCE (Buffer Copy Engine) - this is what the files in the root directory
> >>> are for. This estabilishes a basic communication channel with the T2.
> >>> VHCI and Audio both require this component.
> >>> 
> >>> VHCI - this is a virtual USB host controller; keyboard, mouse and
> >>> other system components are provided by this component (other
> >>> drivers use this host controller to provide more functionality).
> >>> 
> >>> Audio - a driver for the T2 audio interface, currently only audio
> >>> output is supported.
> >>> 
> >>> Currently, suspend and resume for VHCI is broken after a firmware
> >>> update in iBridge since macOS Sonoma.
> >>> 
> >>> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> >>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> >>> 
> >> 
> >> FWIW, I am aware of the missing maintainers file and still not removed Linux version checks in the driver.
> >> 
> >> My main purpose of sending this was to know the views of the maintainers about the code quality, and whether this qualifies for staging or not.
> > 
> > I have to ask why do you want this in drivers/staging/ at all?  Why not
> > take the day or so to clean up the code to be the proper style and
> > handle the needed issues and then submit it to the normal part of the
> > kernel?
> > 
> > Putting code in staging actually takes more work to clean it up and get
> > it out of there than just doing it all at once out-of-tree.  So we need
> > a good reason why it is in here, as well as what the plan is to get it
> > out of staging entirely.  So a TODO file in the directory for the driver
> > is required here.
> 
> I see. I was of the view that staging is more of like a place to keep beta drivers

No, staging is for code that has obvious problems as to why it can't be
merged into the real part of the kernel.  I'm glad to take it but you
have to have a TODO file listing what needs to be done and who is going
to be responsible for reviewing patches and the like.

But really, take the day or so to clean it up and get it merged
properly, what's preventing this from happening?

thanks,

greg k-h

