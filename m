Return-Path: <linux-pci+bounces-2815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917978429E8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC7C288F35
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487386AEF;
	Tue, 30 Jan 2024 16:49:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B267A0F;
	Tue, 30 Jan 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633374; cv=none; b=aLW0DKjDITkRDM9kvuTDWVMmtPfbiTWQeMtXM3QZ+iGBDzfmTFZ6P6eqEPes15x5YJqjXwR3g150h+86YzrQnPzoyjEYR8SDqMY4xJdHad8/8RM8yKCw3tQKOP6DmYui0TlZYEfEDdLgWVpEYMzZBxBMh4mzXlW8uAEoh+D616g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633374; c=relaxed/simple;
	bh=EjZYQSAeVcbB/ATJve01M75Q052kcfkHcSMWKh7NAYk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VSGSbQ5yZtTkDCpcZXdr1p0bB+FcvkjDf8IhtljI5EVT+WCb7wgyxs/o+20kBt0yq8AX4q/ISK5EcFJ413L9Rn4WSSVvaIumw+o0RYgPvOu0YJ8dvtF0CcXkgeF6pIEVfz2CHSToisEokTJOAXUeTRR1SAyZhooKqsp7alaMxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6C7FD92009C; Tue, 30 Jan 2024 17:41:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6601D92009B;
	Tue, 30 Jan 2024 16:41:34 +0000 (GMT)
Date: Tue, 30 Jan 2024 16:41:34 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Jan 2024, Ilpo Järvinen wrote:

> First of all, this is not true for pcie_failed_link_retrain():
>  * Return TRUE if the link has been successfully retrained, otherwise FALSE.
> If LBMS is not set, the Target Speed quirk is not applied but the function 
> still returns true. I think that should be changed to early return false
> when no LBMS is present.

 I think there is a corner case here indeed.  If Link Active reporting is 
supported and neither DLLLA nor LBMS are set at entry, then the function 
indeed returns success even though the link is down and no attempt to 
retrain will have been made.  So this does indeed look a case for a return 
with the FALSE result.

 I think most easily this can be sorted by delegating the return result to 
a temporary variable, preset to FALSE and then only updated from results 
of the calls to `pcie_retrain_link'.  I can offer a patch as the author of 
the code and one who has means to verify it right away if that helped.

 Overall I guess it's all legacy of how this code evolved before it's been 
finally merged.

> > >   3. pci_bridge_wait_for_secondary_bus() then calls pci_dev_wait() which
> > >      cannot succeed (but waits ~1 minute, delaying the resume).
> > > 
> > > The Target Speed trick (in step 2) is only used if LBMS bit (PCIe r6.1
> > > sec 7.5.3.8) is set. For links that have been operational before
> > > suspend, it is well possible that LBMS has been set at the bridge and
> > > remains on. Thus, after resume, LBMS does not indicate the link needs
> > > the Target Speed quirk. Clear LBMS on resume for bridges to avoid the
> > > issue.

 This can be problematic AFAICT however.  While I am not able to verify 
suspend/resume operation with my devices, I expect the behaviour to be 
exactly the same after resume as after a bus reset: the link will fail to 
negotiate and the LBMS and DLLLA bits will be respectively set and clear.  
Consequently if you clear LBMS at resume, then the workaround won't 
trigger and the link will remain inoperational in its limbo state.

 What kind of scenario does the LBMS bit get set in that you have a 
trouble with?  You write that in your case the downstream device has been 
disconnected while the bug hierarchy was suspended and it is not present 
anymore at resume, is that correct?

 But in that case no link negotiation could have been possible and 
consequently the LBMS bit mustn't have been set by hardware (according to 
my understanding of PCIe), because (for compliant, non-broken devices 
anyway) it is only specified to be set for ports that can communicate with 
the other link end (the spec explicitly says there mustn't have been a 
transition through the DL_Down status for the port).

 Am I missing something?

  Maciej

