Return-Path: <linux-pci+bounces-23225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C170A5827F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A6C7A1ACB
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689B190692;
	Sun,  9 Mar 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFVnYnnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD404C70;
	Sun,  9 Mar 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741510532; cv=none; b=Rf8gpvCGPlxD0lRV3D2CcN9GB+Z90BGRDp9TBv61ULFUP0RnI67yk3imcqRtMkpmbiFfTqJ7mRPPXC13rPwpeesdfza89aEPrM9Css6NgB9oICyq1HTTmomHYMxr9ZRWJaEFHH1Eqiu86hr2yNUWJ+vfzcGE5rU3xD3rhSxdyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741510532; c=relaxed/simple;
	bh=Wjt+xysmdxHjcPi7v9Rzrv9MYN7cn5Yh7OgK54RDH6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut8DnPZfFO80effO4ZLQPtD2GsTTX8po8OXU29IKFmsKuM4/tM76FOHh9WXYLf8/5XuzkyY5pOLq+1DYGffim8MAxbex2B3j6cbpDTVuFmnxn6r1NESJHkdjxAGXlcEayW3nwxDQaffMYMUVIRD4OUwZT8QPoc5cPVjf3F2q8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFVnYnnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90519C4CEE5;
	Sun,  9 Mar 2025 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741510532;
	bh=Wjt+xysmdxHjcPi7v9Rzrv9MYN7cn5Yh7OgK54RDH6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zFVnYnnRHzH1G44dELdk5eT87sOfAiwxf63ml+mpd7+zFRa2QfAMzXvtycSwGya0a
	 DF5R4Ro5WR2D446pt22PoSY+6KOpmuF/xQyk+HYslmSUKZ56HqcKp8TAv/9gVPgbiY
	 VeBKQhl2bOZDg2qUrI4GMLBNXMotUzk2Xewon4YY=
Date: Sun, 9 Mar 2025 09:54:16 +0100
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
Message-ID: <2025030905-claim-hardiness-4e7b@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025030931-tattoo-patriarch-006d@gregkh>

On Sun, Mar 09, 2025 at 09:52:38AM +0100, gregkh@linuxfoundation.org wrote:
> On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
> > From: Paul Pawlowski <paul@mrarm.io>
> > 
> > This patch adds a driver named apple-bce, to add support for the T2
> > Security Chip found on certain Macs.
> > 
> > The driver has 3 main components:
> > 
> > BCE (Buffer Copy Engine) - this is what the files in the root directory
> > are for. This estabilishes a basic communication channel with the T2.
> > VHCI and Audio both require this component.
> 
> So this is a new "bus" type?  Or a platform resource?  Or something
> else?
> 
> > VHCI - this is a virtual USB host controller; keyboard, mouse and
> > other system components are provided by this component (other
> > drivers use this host controller to provide more functionality).
> 
> I don't understand, why does a security chip have a USB virtual
> interface in it?  What "devices" hang off of it that are found and
> enumerated by the host OS?
> 
> And what other drivers use this controller, just normal Linux drivers,
> or vendor-specific ones?
> 
> > Audio - a driver for the T2 audio interface, currently only audio
> > output is supported.
> 
> Again, is this a platform device or does it sit on the BCE "bus" you
> will create here?

Also, it looks like you are creating some new user/kernel apis here
(i.e. a char device for a USB host controller?)  So those need to be
explained a lot as to what they are for and who is using them as I
really don't understand their need, nor know what userspace code
controls them.

thanks,

greg k-h

