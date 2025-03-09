Return-Path: <linux-pci+bounces-23223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6EA58277
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0E77A65A5
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE521AA1FE;
	Sun,  9 Mar 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yPLAzDRL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807819DF99;
	Sun,  9 Mar 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741510266; cv=none; b=eTghE37/rw6wUE/Jzu7NpsUdFbxADfY3ifP2wpNu3GtYpNCmUO9R6pJxfMNcaJUjSZk+mHkYyNP4fdDwYVrhSRfGYUVOge6qbwfXfihcNhVZSblkxP7rZVnRR9IB8vB/N9yHRYuQguqnMhHN8ZbI168A0IWSWoH1D2tiWaKhpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741510266; c=relaxed/simple;
	bh=fD/D7P///1cK9p2sXSmjxr9lxXGEV29mR0h4xFfx8GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8/C7M6BUV8+RpxKJ21kDBlT7+0KAiTaBtCc4nTPbKzTvuWocdpucyO40xXcE0beB6VykrAJfoskWIJ873RSOncumN08Ji56t4rzLTiGYtQCgBw25Jk2+k/aumQpeKXr0DCYwOCncGf22vjUmIxhi1ejAJBHyZsP/p2snRPtJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yPLAzDRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA90C4CEE5;
	Sun,  9 Mar 2025 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741510265;
	bh=fD/D7P///1cK9p2sXSmjxr9lxXGEV29mR0h4xFfx8GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yPLAzDRLbDuXQoh3rsbotetRZciGmONETc2l1cMwwL9ZP0s/xQqNWH2giBamr1BLB
	 xa65R4v2jFrPebVpGSis/KeAYsVW9mCbSi7GcPX1w/bmjocgS8u/muVUpKO0NVVxET
	 9Jb1PkWDm3Q5cVQVvUR+jDcde4w+8JqCBc/11an8=
Date: Sun, 9 Mar 2025 09:49:49 +0100
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
Message-ID: <2025030939-moonrise-zipfile-97cf@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2B62772A-4292-4673-8F86-9D27D7AB4EE6@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B62772A-4292-4673-8F86-9D27D7AB4EE6@live.com>

On Sun, Mar 09, 2025 at 08:44:16AM +0000, Aditya Garg wrote:
> 
> 
> > On 9 Mar 2025, at 2:10 PM, Aditya Garg <gargaditya08@live.com> wrote:
> > 
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
> > 
> > VHCI - this is a virtual USB host controller; keyboard, mouse and
> > other system components are provided by this component (other
> > drivers use this host controller to provide more functionality).
> > 
> > Audio - a driver for the T2 audio interface, currently only audio
> > output is supported.
> > 
> > Currently, suspend and resume for VHCI is broken after a firmware
> > update in iBridge since macOS Sonoma.
> > 
> > Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> > Signed-off-by: Aditya Garg <gargaditya08@live.com>
> > 
> 
> FWIW, I am aware of the missing maintainers file and still not removed Linux version checks in the driver.
> 
> My main purpose of sending this was to know the views of the maintainers about the code quality, and whether this qualifies for staging or not.

I have to ask why do you want this in drivers/staging/ at all?  Why not
take the day or so to clean up the code to be the proper style and
handle the needed issues and then submit it to the normal part of the
kernel?

Putting code in staging actually takes more work to clean it up and get
it out of there than just doing it all at once out-of-tree.  So we need
a good reason why it is in here, as well as what the plan is to get it
out of staging entirely.  So a TODO file in the directory for the driver
is required here.

Also, as this is at least 3 different drivers, this should be a patch
series and not all in one if at all possible.

thanks,

greg k-h

