Return-Path: <linux-pci+bounces-23238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCA8A582DB
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D41188BD9B
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFB195B37;
	Sun,  9 Mar 2025 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xsi/ClbD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32B2D78A;
	Sun,  9 Mar 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514189; cv=none; b=BWN9qLg89M+Vuac0pbnzikwmD6Ki5xLU++8cWMnTXUrZ5ghTYqtDNrDvbLgcva64CVfvIjbzoXKDY5edyrCAVJGZ+vgX/Ql9qoc4/POASTgklTtT+/z0zT6nLRY1oZIQxhBPTQBIt+k9+UTGladjVRft+glXJIRjRxvx+PAX8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514189; c=relaxed/simple;
	bh=huC0iybV3NgoQGgAkddJITpWfu30ofxovlfYYAx92xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgEdCYgYmoF8e92jiLzrPPHqRMDJZthz26EtEv/VhFen9XN2db8dfpJxybp0zldS6AGicTrSaniS/ih0Kl7w3DcRoTCx1JHmP8jyXjTJT9q2xCr/snHlBTFGwyxT4PuNnrnTvN49TZiF3DBlBEfTZKlPC6h+rYvkA1nXnYDqr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xsi/ClbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F625C4CEE5;
	Sun,  9 Mar 2025 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741514188;
	bh=huC0iybV3NgoQGgAkddJITpWfu30ofxovlfYYAx92xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xsi/ClbDrXEBsaITnP9UKIlK3u244C6Y6RmWLG83ubwKjrlUfcVncRkb0ub/3eUYX
	 qKe7KS5fWQryykBLLmXT7v9nafrpXo57B+jsN3SrpG3eVKyjjiIUjfgQxq78V8GwJR
	 6es/dIuMuBRMWHBMIzf3f2lgVhPTRCqJv+BTwEMY=
Date: Sun, 9 Mar 2025 10:55:12 +0100
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
Message-ID: <2025030901-deceiver-jolliness-53f5@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030935-contently-handbrake-9239@gregkh>
 <PN3PR01MB9597F040DD8F5A9B1A65B397B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030909-recoup-unafraid-1df0@gregkh>
 <PN3PR01MB95970E60B250F91CA8E12720B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB95970E60B250F91CA8E12720B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Mar 09, 2025 at 09:52:43AM +0000, Aditya Garg wrote:
> 
> 
> > On 9 Mar 2025, at 3:21 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Sun, Mar 09, 2025 at 09:41:29AM +0000, Aditya Garg wrote:
> >> 
> >> 
> >>>> On 9 Mar 2025, at 3:09 PM, gregkh@linuxfoundation.org wrote:
> >>> 
> >>> ﻿On Sun, Mar 09, 2025 at 09:28:01AM +0000, Aditya Garg wrote:
> >>>> 
> >>>> 
> >>>>>> On 9 Mar 2025, at 2:46 PM, gregkh@linuxfoundation.org wrote:
> >>>>> 
> >>>>> ﻿On Sun, Mar 09, 2025 at 09:03:29AM +0000, Aditya Garg wrote:
> >>>>>> 
> >>>>>> 
> >>>>>>>> On 9 Mar 2025, at 2:24 PM, gregkh@linuxfoundation.org wrote:
> >>>>>>> 
> >>>>>>> ﻿On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
> >>>>>>>> From: Paul Pawlowski <paul@mrarm.io>
> >>>>>>>> 
> >>>>>>>> This patch adds a driver named apple-bce, to add support for the T2
> >>>>>>>> Security Chip found on certain Macs.
> >>>>>>>> 
> >>>>>>>> The driver has 3 main components:
> >>>>>>>> 
> >>>>>>>> BCE (Buffer Copy Engine) - this is what the files in the root directory
> >>>>>>>> are for. This estabilishes a basic communication channel with the T2.
> >>>>>>>> VHCI and Audio both require this component.
> >>>>>>> 
> >>>>>>> So this is a new "bus" type?  Or a platform resource?  Or something
> >>>>>>> else?
> >>>>>> 
> >>>>>> It's a PCI device
> >>>>> 
> >>>>> Great, but then is the resources split up into smaller drivers that then
> >>>>> bind to it?  How does the other devices talk to this?
> >>>> 
> >>>> We technically can split up these 3 into separate drivers and put then into their own trees.
> >>> 
> >>> That's fine, but you say that the bce code is used by the other drivers,
> >>> right?  So there is some sort of "tie" between these, and that needs to
> >>> be properly conveyed in the device tree in sysfs as that will be
> >>> required for proper resource management.
> >> 
> >> Yes there needs to be a tie, basically first establish a communication with the t2 using bce and then the other 2 come into the picture. I did get a basic idea from what the maintainers want, and this will be some work to do. Thanks for your inputs!
> > 
> > If there is "communication" then that's a bus in the driver model
> > scheme, so just use that, right?
> 
> So basically RE the whole driver to see what exactly should be use?

I'm sorry, I can not parse this.

