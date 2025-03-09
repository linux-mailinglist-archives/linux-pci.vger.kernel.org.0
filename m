Return-Path: <linux-pci+bounces-23231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60818A58292
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F216B8B5
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4818CC15;
	Sun,  9 Mar 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGdJCrdC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82354690;
	Sun,  9 Mar 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511804; cv=none; b=k6CC6d5MhjS1tOMXOqP0bnbD0p4T1JtZnTJg59ZMT8fXG3HolvMgSsjXLir01JhvIzmbtLAVvZj0vw0hjZlKjIZxKMAowMtAYulRofSw+zRQju3xKwieO27iochD5BuaFyzKUEJ+7WDhvGOerYd3VrdSkA+ac9Mx/ZAgKdw5gPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511804; c=relaxed/simple;
	bh=jbFe7ddimBDQiXrzOt+4oWBnLDBtq14PZ4Nbch0NrFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji9PnxC8BgRRyMemVNPz2RNpg839ca/L5YDYBWPmHpbqDgQ+adbLyVRflcD5e28vGFZ50c7ENc/YkB/BCI+RPKY2qVFK7cHMamzNeBwo0h+g7Y6hs9XuwURSribuYZOdMUBkx2QVULSXe0OXOjDneD0UxdIS8/VEDewJcqui7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGdJCrdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74A2C4CEEC;
	Sun,  9 Mar 2025 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741511804;
	bh=jbFe7ddimBDQiXrzOt+4oWBnLDBtq14PZ4Nbch0NrFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGdJCrdCk1x+afaOW1jTLngPq6pnoGYdquvIjKtCdVx9YM68P8ymKKOistTwWGVJJ
	 Qut2ws/M0hqmVwVAxy2lcg4rOpetn17MZeidb0L5tUgHzhsG1KWzC2g0tLt6+zv1Du
	 f+lYpvW6HNDlyaj57b0yWcfP9pAeI0QssKHc1+GU=
Date: Sun, 9 Mar 2025 10:15:28 +0100
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
Message-ID: <2025030949-makeover-trend-e079@gregkh>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <2025030905-claim-hardiness-4e7b@gregkh>
 <PN3PR01MB95970134B40651A901F825DCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB95970134B40651A901F825DCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Sun, Mar 09, 2025 at 09:05:45AM +0000, Aditya Garg wrote:
> 
> 
> > On 9 Mar 2025, at 2:25 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Sun, Mar 09, 2025 at 09:52:38AM +0100, gregkh@linuxfoundation.org wrote:
> >>> On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
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
> >> 
> >> So this is a new "bus" type?  Or a platform resource?  Or something
> >> else?
> >> 
> >>> VHCI - this is a virtual USB host controller; keyboard, mouse and
> >>> other system components are provided by this component (other
> >>> drivers use this host controller to provide more functionality).
> >> 
> >> I don't understand, why does a security chip have a USB virtual
> >> interface in it?  What "devices" hang off of it that are found and
> >> enumerated by the host OS?
> >> 
> >> And what other drivers use this controller, just normal Linux drivers,
> >> or vendor-specific ones?
> >> 
> >>> Audio - a driver for the T2 audio interface, currently only audio
> >>> output is supported.
> >> 
> >> Again, is this a platform device or does it sit on the BCE "bus" you
> >> will create here?
> > 
> > Also, it looks like you are creating some new user/kernel apis here
> > (i.e. a char device for a USB host controller?)  So those need to be
> > explained a lot as to what they are for and who is using them as I
> > really don't understand their need, nor know what userspace code
> > controls them.
> 
> I'll cleanup the code, and try to fix the todos if possible, and send a patch with proper explanation. My main purpose to put it in staging was that without keyboard, trackpad and other input devices, linux is unusable on t2 macs.

Again, what's with the new user/kernel apis?  Who is going to use them?

thanks,

greg k-h

