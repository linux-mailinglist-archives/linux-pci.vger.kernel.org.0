Return-Path: <linux-pci+bounces-16493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86739C4E8D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E822879D0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D1209F43;
	Tue, 12 Nov 2024 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7pqRIFd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009891C303A;
	Tue, 12 Nov 2024 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391980; cv=none; b=YEEfzOzvMkre8XrMfIdi8kn1pjPppRXRwwoeWh9I9zmQonIz5QcSnwbaSV/wpmkKrvoHu3iVDO9hJOKja3IsxUveMolX+HJng3tg49PIIWmh8qnfGILmt/BwV+gxhoz95CnPoQfPfq033ZpsaXJaIHLjtpU7zeiBiaEGtjQL3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391980; c=relaxed/simple;
	bh=QgTT7r0KqdxQuGEyaNMWaIbXVXDTyKgK3Gsg2wAV8VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf0YX+hd4wo39p6d6r/SUQnW62UDlmCnftWsDnXUkIEjCYUoo2PXG7pRx4xASTqBSeXj10IIVQfmhGuxXsREOczdgHVZSpRfCiMRGmloPmc4WWNavf86FCUW7KJyK2HUNVokqCxCvv96PhdVWbO5cDpTwqryvlKSXHIg/AyXUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7pqRIFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E68C4CECD;
	Tue, 12 Nov 2024 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731391979;
	bh=QgTT7r0KqdxQuGEyaNMWaIbXVXDTyKgK3Gsg2wAV8VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7pqRIFdF2Q8kK200JhJZVR15jL8IAIjTRAsJ/3iqygUv52ELnGusC8MdwAGEWURj
	 Ux3qDflbxmJCSGWO9wS+f2kd/6dWwesQ0MeWWcRwhFkXJhSvvY7VFR3MlNaUKUoJ8t
	 36DlAxbl6HgQzVGGbcTRFRdjEfVrTBOE8P71PclNKZWtm7hZU0QZ4fBJDmKKuvsvET
	 PElV5kIZI72F5yDUCmL+ABZBH4+ZXXccfzitW/p2EQnMPeoklGn3pI+a4yXisZPM3E
	 S7CosqEeb/1etakULkJMiuoJ4Cd5+CowGR8D2t453kkvzmZd+IuIIbbPEgRTGpVtbn
	 hV2fszerLJ0Cw==
Date: Tue, 12 Nov 2024 08:12:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241112061251.GE71181@unreal>
References: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
 <20241111204104.GA1817395@bhelgaas>
 <20241111163430.7fad2a2a@hermes.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111163430.7fad2a2a@hermes.local>

On Mon, Nov 11, 2024 at 04:34:30PM -0800, Stephen Hemminger wrote:
> On Mon, 11 Nov 2024 14:41:04 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > The Vital Product Data (VPD) attribute is not readable by regular
> > > user without root permissions. Such restriction is not really needed
> > > for many devices in the world, as data presented in that VPD is not
> > > sensitive and access to the HW is safe and tested.
> > > 
> > > This change aligns the permissions of the VPD attribute to be accessible
> > > for read by all users, while write being restricted to root only.
> > > 
> > > For the driver, there is a need to opt-in in order to allow this
> > > functionality.  
> > 
> > I don't think the use case is very strong (and not included at all
> > here).
> > 
> > If we do need to do this, I think it's a property of the device, not
> > the driver.
> 
> I remember some broken PCI devices, which will crash if VPD is read.

This is opt-in feature for devices which are known to be working.
Broken devices will continue to be broken and will continue to require
root permissions for read.

Thanks

