Return-Path: <linux-pci+bounces-23241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC6A582FE
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 11:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEAF188B655
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4919F104;
	Sun,  9 Mar 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0/qQf7d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7782114;
	Sun,  9 Mar 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515840; cv=none; b=oaEH4DZid+W2QMR0C9WknwDY3ZzbBlCPHSxZaiWUyeyPenLabEbvHdFohEhfG800th9Jwd1GP2I4cQA5wno+/eHRad7QRtJBVMH7KKDzi+5AjvaTBe8kczH37idEiN4Au/5k/huv7PraLa+XPIj1Lvy7knMFgBmgmyuMZ8FOJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515840; c=relaxed/simple;
	bh=s4OlYYrHmgxAkduxUPPzl6dmn5j30zeeUCSL98+gt0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDdoX+cm4wwLmPdqnOuxbAKV0zaE8JWXvMq4tyKmqYHYCMgEpdlP9eya84LtL+6bdiltP1tv2uIzB2TccHq6N/vfrT17bpqqz0NRaZTdIKnBT0A5e0MJTqCxjV3WHLviZD4YjgPfolYdcdl7ZdJPm+k+Mo2pw2iiiPQ5VaLJZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0/qQf7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25358C4CEE5;
	Sun,  9 Mar 2025 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741515839;
	bh=s4OlYYrHmgxAkduxUPPzl6dmn5j30zeeUCSL98+gt0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0/qQf7dbD1L/RE4VY7VRk5SHv13Ank8EeC7HdjaJUEqaRcajePJA1U0KNKe7MW69
	 ZZKiur1ARxaCX4qN8Q236I1rnzq0+Kud1hLv77mnCSTSte3y1PPuNjZW8OcIqlXrQ6
	 RK1+GlxIqL1eFPdysvH6YBZh4b1arYfz3jrRhDTw=
Date: Sun, 9 Mar 2025 11:22:43 +0100
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
Message-ID: <2025030929-cryptic-ducky-9e23@gregkh>
References: <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030935-contently-handbrake-9239@gregkh>
 <PN3PR01MB9597F040DD8F5A9B1A65B397B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030909-recoup-unafraid-1df0@gregkh>
 <PN3PR01MB95970E60B250F91CA8E12720B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030901-deceiver-jolliness-53f5@gregkh>
 <PN3PR01MB9597B64008E01DC0336FAE37B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597B64008E01DC0336FAE37B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Mar 09, 2025 at 10:12:06AM +0000, Aditya Garg wrote:
> 
> 
> > On 9 Mar 2025, at 3:26 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Sun, Mar 09, 2025 at 09:52:43AM +0000, Aditya Garg wrote:
> >> 
> >> 
> >>>> On 9 Mar 2025, at 3:21 PM, gregkh@linuxfoundation.org wrote:
> >>> 
> >>> ﻿On Sun, Mar 09, 2025 at 09:41:29AM +0000, Aditya Garg wrote:
> >>>> 
> >>>> 
> >>>>>> On 9 Mar 2025, at 3:09 PM, gregkh@linuxfoundation.org wrote:
> >>>>> 
> >>>>> ﻿On Sun, Mar 09, 2025 at 09:28:01AM +0000, Aditya Garg wrote:
> >>>>>> 
> >>>>>> 
> >>>>>>>> On 9 Mar 2025, at 2:46 PM, gregkh@linuxfoundation.org wrote:
> >>>>>>> 
> >>>>>>> ﻿On Sun, Mar 09, 2025 at 09:03:29AM +0000, Aditya Garg wrote:
> >>>>>>>> 
> >>>>>>>> 
> >>>>>>>>>> On 9 Mar 2025, at 2:24 PM, gregkh@linuxfoundation.org wrote:
> >>>>>>>>> 
> >>>>>>>>> ﻿On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
> >>>>>>>>>> From: Paul Pawlowski <paul@mrarm.io>
> >>>>>>>>>> 
> >>>>>>>>>> This patch adds a driver named apple-bce, to add support for the T2
> >>>>>>>>>> Security Chip found on certain Macs.
> >>>>>>>>>> 
> >>>>>>>>>> The driver has 3 main components:
> >>>>>>>>>> 
> >>>>>>>>>> BCE (Buffer Copy Engine) - this is what the files in the root directory
> >>>>>>>>>> are for. This estabilishes a basic communication channel with the T2.
> >>>>>>>>>> VHCI and Audio both require this component.
> >>>>>>>>> 
> >>>>>>>>> So this is a new "bus" type?  Or a platform resource?  Or something
> >>>>>>>>> else?
> >>>>>>>> 
> >>>>>>>> It's a PCI device
> >>>>>>> 
> >>>>>>> Great, but then is the resources split up into smaller drivers that then
> >>>>>>> bind to it?  How does the other devices talk to this?
> >>>>>> 
> >>>>>> We technically can split up these 3 into separate drivers and put then into their own trees.
> >>>>> 
> >>>>> That's fine, but you say that the bce code is used by the other drivers,
> >>>>> right?  So there is some sort of "tie" between these, and that needs to
> >>>>> be properly conveyed in the device tree in sysfs as that will be
> >>>>> required for proper resource management.
> >>>> 
> >>>> Yes there needs to be a tie, basically first establish a communication with the t2 using bce and then the other 2 come into the picture. I did get a basic idea from what the maintainers want, and this will be some work to do. Thanks for your inputs!
> >>> 
> >>> If there is "communication" then that's a bus in the driver model
> >>> scheme, so just use that, right?
> >> 
> >> So basically RE the whole driver to see what exactly should be use?
> > 
> > I'm sorry, I can not parse this.
> 
> 
> I was asking that should I introduce a completely new bus instead of
> pci and probably reverse engineer the original macOS driver to see
> what exactly is going on there?

No, if it's a PCI device on a PCI bus, then use the PCI api for all of
that.

It's what that PCI device "exposes" here, are the other devices, like
the USB host controller, hanging off of that, or are they real PCI
devices as well?

What exactly does this BCE driver do?

> I might not have been clear, but I'm not the author of this patch.

That's fine, but why doesn't the original author want to do this work?
Have you asked them if they want this code included in the kernel tree?
Who is going to do the maintenance for it and who is going to answer
questions like the ones I have here?

And again, what is with the new user/kernel api being added?  What is
all of that for?

thanks,

greg k-h

