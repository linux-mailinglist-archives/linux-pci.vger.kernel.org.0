Return-Path: <linux-pci+bounces-4011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371A867577
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 13:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D76B24D13
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BA7F497;
	Mon, 26 Feb 2024 12:43:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765D1CF89;
	Mon, 26 Feb 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951422; cv=none; b=uKkcF6WoDCxUdWE81OZf57+wDUylYkvDpaksXhs71QdfJ0mmzuWkOMbMbXRCTHOS1dllta+xQ5zI5RHD1uC5FxNNcM9+1oUp3wOs6KVdEg3X4rx1RBfIaXc6vGNT7MeMO4KfQEqaeW6GE19mRM9TwdHmXrPSD0owzeMAOlrYU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951422; c=relaxed/simple;
	bh=OmC2KY9S6KztzIeROYHg4vcpqyBH0EE1JKRIeMH7UOM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nZFnbxTjCM3D4oxg1UA+uubeAgpnVsB35/pvNRZNIG7jgqRgXbNT42f14wDiLHszNiuBKq9J/XugaaKlPKylPM+1kl63hM9eDRdcIx6cWLRjdsDPrP2FEw+ejacO3rlTl9sEiOJY9AcyNVOVsJszgcFoKCQSdAimQlatCVE9+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9C7BC92009C; Mon, 26 Feb 2024 13:43:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 96DF992009B;
	Mon, 26 Feb 2024 12:43:31 +0000 (GMT)
Date: Mon, 26 Feb 2024 12:43:31 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <853a63bd-74cb-e19b-24b7-426a0fdd9003@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2402261237260.60326@angie.orcam.me.uk>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk> <ce73f41a-b529-726f-ee4e-9d0e0cee3320@linux.intel.com> <alpine.DEB.2.21.2402161349350.3971@angie.orcam.me.uk>
 <853a63bd-74cb-e19b-24b7-426a0fdd9003@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 16 Feb 2024, Ilpo Järvinen wrote:

> > > Yet another thing in this quirk code I don't like is how it can leaves the 
> > > target speed to 2.5GT/s when the quirk fails to get the link working 
> > > (which actually does happen in the disconnection cases because DLLLA won't 
> > > be set so the target speed will not be restored).
> > 
> >  I chose to leave the target speed at the most recent setting, because the 
> > link doesn't work in that case anyway, so I concluded it doesn't matter, 
> > but reduces messing with the device; technically you should retrain again 
> > afterwards.  I'm not opposed to changing this if you have a use case.
> 
> It remains suboptimally set in a case where something is plugged again 
> into that port, for Thunderbolt it doesn't matter as the PCIe speed picked 
> is quite bogus anyway, but disconnect then plug something again is not 
> limited to Thunderbolt.

 Sure, my understanding has been all PCIe option devices are supposed to 
be hot-pluggable, at least these in the regular form factor (which is why 
PCIe edge connector contacts have varying lengths, unlike conventional 
PCI).

  Maciej

