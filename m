Return-Path: <linux-pci+bounces-23230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8BA5828F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6028D188D9EF
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0918C02E;
	Sun,  9 Mar 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Agp4UEUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A264690;
	Sun,  9 Mar 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511758; cv=none; b=Lt3QyewDp7y2L8yTUQ5guB6vjBknCJLL1NlQ+CRHGDoXgrhr15CtnjP5yYk01q09GlbhP8vG/+WK3UAEQZjH+8B2Wr+P6UFp+w05pq6g3v14PYVna2ezwbRQ8j/QHBoFl4ihG1FPEEzoBW8nNxlvnGwLY/NvxiVlTNjs+j1YKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511758; c=relaxed/simple;
	bh=K3xV6qADVt+GGw/9neE6bZZlut/7sckI+B8ywCNR4bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEF6QZgdfYL63yj7O9jizlmd/+BjU1BW9fNgBY524xy8bxb/gW6E3XHx4bfZZB/pA4ZrGc/iur2u2cZe8+JSWZz1OszDM1hhIApk58jDjB0xMR1bkZ+7isWdPmTWsUnUBcKx44KUAm5dMLNvZFV7Ov+hbgpKQt6jecsek5tEwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Agp4UEUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D6AC4CEE5;
	Sun,  9 Mar 2025 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741511758;
	bh=K3xV6qADVt+GGw/9neE6bZZlut/7sckI+B8ywCNR4bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Agp4UEUNLiZ/4p+WyhtsvefIfmqewPW6oSk/fWVfF81VQy//ViK+4dFXKvbgmc2p9
	 RlXrdnjQ6WLEOhFYjoGwZ5jLOUKpPNpSvX3Kxp7A8/7+D1EqgMdj6PfegSN260Vv0x
	 4eCjVjkV47jldDK2O2JAznIY94taldka3mDNFvkU=
Date: Sun, 9 Mar 2025 10:14:41 +0100
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
Message-ID: <2025030937-antihero-sandblast-7c87@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Mar 09, 2025 at 09:03:29AM +0000, Aditya Garg wrote:
> 
> 
> > On 9 Mar 2025, at 2:24 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
> >> From: Paul Pawlowski <paul@mrarm.io>
> >> 
> >> This patch adds a driver named apple-bce, to add support for the T2
> >> Security Chip found on certain Macs.
> >> 
> >> The driver has 3 main components:
> >> 
> >> BCE (Buffer Copy Engine) - this is what the files in the root directory
> >> are for. This estabilishes a basic communication channel with the T2.
> >> VHCI and Audio both require this component.
> > 
> > So this is a new "bus" type?  Or a platform resource?  Or something
> > else?
> 
> It's a PCI device

Great, but then is the resources split up into smaller drivers that then
bind to it?  How does the other devices talk to this?

> >> VHCI - this is a virtual USB host controller; keyboard, mouse and
> >> other system components are provided by this component (other
> >> drivers use this host controller to provide more functionality).
> > 
> > I don't understand, why does a security chip have a USB virtual
> > interface in it?  What "devices" hang off of it that are found and
> > enumerated by the host OS?
> 
> The t2 chip not only handles security, but also has a usb hub, which connects the internal keyboard, trackpad, touchbar, webcam, and other internal devices. The external usb ports are separate.

That feels strange, but hey, we've seen worse :)

thanks,

greg k-h

