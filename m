Return-Path: <linux-pci+bounces-11537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3294D132
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1D11F23A2F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F78194089;
	Fri,  9 Aug 2024 13:25:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19085194C65;
	Fri,  9 Aug 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209929; cv=none; b=gX/2VveUilfRVtEGPDiup4rv2WjaGGMSzvryybpVY2H8ZrT7AbUdwV+HBV2mlDAYpoRCcG8MHCKof4IYQM2FSNHonYMxoSGxARFMfdArcM/oNiKjyLkufgbTbwnKfyfifRtBnl9YE6dvtI5TO/ak9VeKXuMcixjz5nBVYA8JonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209929; c=relaxed/simple;
	bh=AtkkjPh+Ted5GB4fTtHZPq1H1FQq5CogpzPJVG+eftc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aEOizl6vkURMuF+8lf4rVMyj7Ku8/JEwxZb2PLUQuAXwujdsU4/2tRBgvVpqlBqdqjD+eySrY5QbrXlEl92R31lFoWZgQ0ZFKHftI+MgV2+/U71rWJSlFM2LkOek5Cd/0nVjWujKpvlFKGrmXuevZq2HXskmNSyvinU+kP4Vs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2A9E392009D; Fri,  9 Aug 2024 15:25:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2475192009B;
	Fri,  9 Aug 2024 14:25:27 +0100 (BST)
Date: Fri, 9 Aug 2024 14:25:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <a0b070b7-14ce-7cc5-4e6c-6e15f3fcab75@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2408091327390.61955@angie.orcam.me.uk>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com> <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
 <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk> <d9f6efe3-3e99-0e4b-0d1c-5dc3442c2419@linux.intel.com> <a0b070b7-14ce-7cc5-4e6c-6e15f3fcab75@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Feb 2024, Ilpo Järvinen wrote:

> > > > Because if it is constantly picking another speed, it would mean you get 
> > > > LBMS set over and over again, no? If that happens 34-35 times per second, 
> > > > it should be set already again when we get into that quirk because there 
> > > > was some wait before it gets called.
> > > 
> > >  I'll see if I can experiment with the hardware over the next couple of 
> > > days and come back with my findings.
> > 
> > Okay thanks.
> 
> One point I'd be very interested to know if the link actually comes up 
> successfully (even if briefly) because this has large implications whether 
> the quirk can actually be invoked from the bandwidth controller code.

 That was more than a couple of days, sorry about it.  I have now been 
able to verify that LBMS keeps getting reasserted over and over again as 
the device goes through the infinite link training dance.  I haven't ever 
observed the link to become active in the course.  Here's a short log of 
commands repeatedly entered at the command prompt:

# setpci -s 02:03.0 CAP_EXP+0x12.W
5011
# setpci -s 02:03.0 CAP_EXP+0x12.W
5812
# setpci -s 02:03.0 CAP_EXP+0x12.W
5811
# setpci -s 02:03.0 CAP_EXP+0x12.W
5812
# setpci -s 02:03.0 CAP_EXP+0x12.W
5011
# setpci -s 02:03.0 CAP_EXP+0x12.W
5811
# setpci -s 02:03.0 CAP_EXP+0x12.W
5811
# setpci -s 02:03.0 CAP_EXP+0x12.W
5812
# setpci -s 02:03.0 CAP_EXP+0x12.W
5812
# setpci -s 02:03.0 CAP_EXP+0x12.W
5811
# setpci -s 02:03.0 CAP_EXP+0x12.W
5811
# setpci -s 02:03.0 CAP_EXP+0x12.W
5812
# setpci -s 02:03.0 CAP_EXP+0x12.W
5812
# setpci -s 02:03.0 CAP_EXP+0x12.W
5811

As you can see the Link Training bit oscillates as I previously reported 
and noted in the introduction to `pcie_failed_link_retrain', and also the 
Current Link Speed field flips between 2.5GT/s and 5GT/s.

 HTH,

  Maciej

