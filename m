Return-Path: <linux-pci+bounces-17187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4999D5590
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 23:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33534282F9B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CABD1D9324;
	Thu, 21 Nov 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e06pMEyX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65B1D90DC;
	Thu, 21 Nov 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228905; cv=none; b=ozVJjzAEhSd1Z7kqd3EK9oB+rdX7VekYGp7YNT7rFBExeZS0tiKwwzd+FEnxzaii0BvTbqslnASbq1+TSdwQqrOHYgqkq0wTWe23+0znF1Ssbg3QQpLB+sPClLJjEfA9ff6ASiP2OX4euP0SKu2QtEcTBPOlCxqIsJQ4YaiWquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228905; c=relaxed/simple;
	bh=H3cMHoF2yTikgTdMsVLzgXmeayix4GzbY+snFvGE5Js=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YRsUI4hdV5FQBtxk8Y9ngpi83I/EOU/5gPQsRixMZvzM7SdogyfWtijKE2Ng6ocAQEnPQhQ/ki/ccJE01NZJFe+2CEmyAQtOPDau5PgsD7hx+D7bpyv/DXOKwu1dC/fzPAbjdNUWpSW5xdTuOcuNxR0gnShjoFj+gmoae4B/Tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e06pMEyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD8DC4CECC;
	Thu, 21 Nov 2024 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732228904;
	bh=H3cMHoF2yTikgTdMsVLzgXmeayix4GzbY+snFvGE5Js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e06pMEyXB4v/qSfE87VmPOBF+pXhY63w1hcIy1VsYFe4jZBlDUuL3VwU6xI5xHu52
	 0qIW0GhI5ihpfA2LqABCQld1T9LNU79jgBFQxg3vGg/0X6ZvnyOhMzF4s3E68JoPDx
	 lt4ul3NxYGDYylK2Umk7sJO1dkl2/+d7GV4SlWl/ikpQuTrYondR0wA/f6pqqE5WuV
	 PX8CvyrT++kA8xsHKXpN+5aXytNOn9OhkImOwffOyVkB25X9pLGzoidcWyxeulWg99
	 SCGy8/Tz8pi2hUjsVEgxYVaB9WYZRONpYDBYeQS3mZeEPGQueGr483fpWJX9tzegcg
	 rSXXrubzozxAg==
Date: Thu, 21 Nov 2024 16:41:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jean Delvare <jdelvare@suse.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241121224142.GA2401143@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121121301.GA160612@unreal>

On Thu, Nov 21, 2024 at 02:13:01PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 21, 2024 at 01:01:27PM +0100, Jean Delvare wrote:
> > On Wed, 13 Nov 2024 14:59:58 +0200, Leon Romanovsky wrote:
> > > --- a/drivers/pci/vpd.c
> > > +++ b/drivers/pci/vpd.c
> > > @@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> > >  	if (!pdev->vpd.cap)
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * Mellanox devices have implementation that allows VPD read by
> > > +	 * unprivileged users, so just add needed bits to allow read.
> > > +	 */
> > > +	WARN_ON_ONCE(a->attr.mode != 0600);
> > > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > > +		return a->attr.mode + 0044;
> ...

> I still didn't lost hope that at some point VPD will be open for read to
> all kernel devices.
> 
> Bjorn, are you ok with this patch? If yes, I'll resend the patch with
> the suggested change after the merge window.

Reading VPD is a fairly complicated dance that only works if the VPD
data is well-formatted, and the benefit of unprivileged access seems
pretty small, so the risk/reward tradeoff for making it unprivileged
for all devices doesn't seem favorable in my mind.

This quirk seems like the least bad option, so I guess I'm ok with it.

Bjorn

