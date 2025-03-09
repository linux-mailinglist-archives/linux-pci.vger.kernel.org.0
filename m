Return-Path: <linux-pci+bounces-23224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463AAA58279
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FD416802E
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF18194A44;
	Sun,  9 Mar 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="indNsyjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAC19259F;
	Sun,  9 Mar 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741510435; cv=none; b=JANXsP/SzpN+vmWpwVzzqCjHEZSxEICSa1+Smt7qf1Xja7TKMLS2xZECy7WV4/FUBDf+zIVOHT0lnlOm65f2o2WZPThPie2q/d2BY5SCkfNKugE+llc01/rARtnLckKXgjBWHmyAAByKLIw6BGzT8Q/uR1mjUl1YQPdit08aDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741510435; c=relaxed/simple;
	bh=wz/+40Tq14csC9EebO2vx0wnKhL9su3uBVDgNU/22HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l136K6Djk2g9KdLaLyMttRBci/kDYhbShx3uphJ17xZD9JiDbtZKTleL/xB9wO9DLo3d1HATJ5LTyyiKBk4yMAOx3ROabrWo3EWXIszUtM08oH0Rk7p/XsiOu58tf5yBE7TQF3qqrfAgNjUOwFMtkd5XiUmSxamaqe934O0VpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=indNsyjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AA9C4CEE5;
	Sun,  9 Mar 2025 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741510434;
	bh=wz/+40Tq14csC9EebO2vx0wnKhL9su3uBVDgNU/22HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=indNsyjDu4/iITTryLHg2DISyRtmD2HqY5CvJGHBYyB935WnK6p508ddpi4oC5AOm
	 Vs0F8Sf+wYIb2pH4dCBoyU9y8YsnxEAg1duIQM+1xMzUKj7zV2dEszt9n8KaV5MJxf
	 s7TyqgylT6kDPxS/9If308rjmAmSL+4Y7Zltojsw=
Date: Sun, 9 Mar 2025 09:52:38 +0100
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
Message-ID: <2025030931-tattoo-patriarch-006d@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>

On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
> From: Paul Pawlowski <paul@mrarm.io>
> 
> This patch adds a driver named apple-bce, to add support for the T2
> Security Chip found on certain Macs.
> 
> The driver has 3 main components:
> 
> BCE (Buffer Copy Engine) - this is what the files in the root directory
> are for. This estabilishes a basic communication channel with the T2.
> VHCI and Audio both require this component.

So this is a new "bus" type?  Or a platform resource?  Or something
else?

> VHCI - this is a virtual USB host controller; keyboard, mouse and
> other system components are provided by this component (other
> drivers use this host controller to provide more functionality).

I don't understand, why does a security chip have a USB virtual
interface in it?  What "devices" hang off of it that are found and
enumerated by the host OS?

And what other drivers use this controller, just normal Linux drivers,
or vendor-specific ones?

> Audio - a driver for the T2 audio interface, currently only audio
> output is supported.

Again, is this a platform device or does it sit on the BCE "bus" you
will create here?

thanks,

greg k-h

