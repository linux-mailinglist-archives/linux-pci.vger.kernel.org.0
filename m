Return-Path: <linux-pci+bounces-3599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6F857E45
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA03828136F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216912BEA5;
	Fri, 16 Feb 2024 13:58:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E612C7E4;
	Fri, 16 Feb 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091910; cv=none; b=FAGuBJK3xKKIcabi5ybkRkjN31OHO+T9WvKOnMsxMWjaYjuJoF32uAd03C6qXNt2FGZsaIt4+YNQUZegv+ywmvCssWOhg1QAe6NJLqflzpSvqIUDw0CnQerISCSFns8qKWiObIEP30i38m94tEMc0FTHy4YN4xSAu1BrHbm0/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091910; c=relaxed/simple;
	bh=gvevfXqvHIBXNNVCKb7to6U/1T+JLO2BfiaVSk6KNlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MuV5HspbMpk+SPjW9+o3UpIb+EPDGSckXdA9l5PxwFuq+ortgHsJZtQ5vMD4MUPVFMeE/65QLj1ur3sA7zcTrAhgdB8LwQt9rwXV/vedx8EGCictiVZMdorkcsKEiKnOcc0fIyvxHflLwLkuiytv0z4QiAOQJYibu1DKVG2GarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D6F5092009C; Fri, 16 Feb 2024 14:58:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D051D92009B;
	Fri, 16 Feb 2024 13:58:19 +0000 (GMT)
Date: Fri, 16 Feb 2024 13:58:19 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <ce73f41a-b529-726f-ee4e-9d0e0cee3320@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2402161349350.3971@angie.orcam.me.uk>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk> <ce73f41a-b529-726f-ee4e-9d0e0cee3320@linux.intel.com>
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

> >  You change the logic here in that the second conditional isn't run if the 
> > first has not.  This is wrong, unclamping is not supposed to rely on LBMS. 
> > It is supposed to be always run and any failure has to be reported too, as 
> > a retraining error.
> 
> Now that (I think) I fully understand the intent of the second 
> condition/block one additional question occurred to me.
> 
> How is the 2nd condition even supposed to work in the current place when 
> firmware has pre-arranged the 2.5GT/s resctriction? Wouldn't the link come 
> up fine in that case and the quirk code is not called at all since the 
> link came up successfully?

 The quirk is called unconditionally from `pci_device_add', so an attempt 
to unclamp will always happen with a working link for qualifying devices.

> Yet another thing in this quirk code I don't like is how it can leaves the 
> target speed to 2.5GT/s when the quirk fails to get the link working 
> (which actually does happen in the disconnection cases because DLLLA won't 
> be set so the target speed will not be restored).

 I chose to leave the target speed at the most recent setting, because the 
link doesn't work in that case anyway, so I concluded it doesn't matter, 
but reduces messing with the device; technically you should retrain again 
afterwards.  I'm not opposed to changing this if you have a use case.

  Maciej

