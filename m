Return-Path: <linux-pci+bounces-9539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A916E91E9B5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3681C231F9
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24C17164A;
	Mon,  1 Jul 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgA6c7Pr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C85171640;
	Mon,  1 Jul 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866346; cv=none; b=f1RC7/L1Er8m9aWfj8X6bq0ndJMgVp+aHZRLNAof5bRwRwO3YmCLMw2Y+p0eWR1TtUwBDQECkD3JuL03ytfhv3p3fDCdt+wbA36IO3WZIeHHS9QxtANG6F5GovxU5PWGRfnV/cADwrjzr6c/QEjEqE/HkeHyGgRi51KOsshOIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866346; c=relaxed/simple;
	bh=2qz9WlwfBLzvo9zAcJWum1WmCVFtOyqc6raSVTag70s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dfY/g69mzorBZTluwleH4WV6FsU9axg94ntaDDpDNwVQqjn2/RErmvgHToCwFBTz9V6Pi/S1fBQrook87IFYlXRtJzrgm9tNiGQNmM0hG68LnpBEZsWoXiq36h3FYimlADVF1R+zL/0f5oKSu3bY3YkNSZ6YfkVJqqTueH+cMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgA6c7Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39A1C116B1;
	Mon,  1 Jul 2024 20:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719866346;
	bh=2qz9WlwfBLzvo9zAcJWum1WmCVFtOyqc6raSVTag70s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lgA6c7Pr8iuV9QiKxpUCLGLFkphJy3ou8gjIKaJz5hqlkd03DhkHz44AuHk2A1mvA
	 HKcazStZ7n32SrO82qbFa4MgYr3clY37nUkFsT2031+60y2hG7OHI6EhCkFELWnEBc
	 LC4k8DKpMlI57cKkgEaapbcYpAGTNw7YBRTPIOZzJvW69rKbebd4iGKSctuKp+yGNf
	 widTpauY94SDNfpITvuXRG/Ex94oi32ndE0qNz0Hq3Hkw0RbjuBs7ryYHk3w+dPngs
	 Skam+IfSO/h8wBArVhpp0Dfggp/fmpdVgeCCIwgqhgjxBQBPiLUXIeiq8KKy1nhYtZ
	 N/yzfxDdM2l9Q==
Date: Mon, 1 Jul 2024 15:39:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yihang Li <liyihang9@huawei.com>, cassel@kernel.org,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	john.g.garry@oracle.com, yanaijie@huawei.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxarm@huawei.com, chenxiang66@hisilicon.com,
	prime.zeng@huawei.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
Message-ID: <20240701203903.GA16142@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e86954-4ab7-4bb0-b78d-56f44556318e@kernel.org>

[+cc Alex]

On Thu, Jun 27, 2024 at 09:56:02AM +0900, Damien Le Moal wrote:
> On 6/27/24 00:15, Bjorn Helgaas wrote:
> >>> Yes, I am talking about the PCI "Function Level Reset"
> >>>
> >>>> FLR and disk/controller suspend execution timing are unrelated.
> >>>> FLR can be triggered at any time through sysfs. So please give
> >>>> details here. Why is FLR done when the system is being
> >>>> suspended ?
> >>>
> >>> Yes, it is because FLR can be triggered at any time that we are
> >>> testing the reliability of executing FLR commands after
> >>> disk/controller suspended.
> >>
> >> "can be triggered" ? FLR is not a random asynchronous event. It
> >> is an action that is *issued* by a user with sys admin rights.
> >> And such users can do a lot of things that can break a machine...
> >>
> >> I fail to see the point of doing a function reset while the
> >> device is suspended. But granted, I guess the device should
> >> comeback up in such case, though I would like to hear what the
> >> PCI guys have to say about this.
> >>
> >> Bjorn,
> >>
> >> Is reseting a suspended PCI device something that should be/is
> >> supported ?
> > 
> > I doubt it.  The PCI core should be preserving all the generic PCI
> > state across suspend/resume.  The driver should only need to
> > save/restore device-specific things the PCI core doesn't know about.
> > 
> > A reset will clear out most state, and the driver doesn't know the
> > reset happened, so it will expect most device state to have been
> > preserved.
> 
> That is what I suspected. However, checking the code, reset_store() in
> pci-sysfs.c does:
> 
> 	pm_runtime_get_sync(dev);
> 	result = pci_reset_function(pdev);
> 	pm_runtime_put(dev);
> 
> and pm_runtime_get_sync() calls __pm_runtime_resume() which will
> resume a suspended device.
> 
> So while I still think it is not a good idea to reset a suspended
> device, things should still work as execpected and not cause any
> problem with the device state, right ?

The reset will clear almost all state, including both the generic PCI
part that pci_reset_function() saves/restores *and* any
device-specific state the PCI core doesn't know about.

That device-specific state isn't saved and restored anywhere in the
sysfs reset path, and the driver doesn't know this reset happened, so
I think all bets are off and we shouldn't expect the driver to work
afterwards.

A user-space reset might make sense if there's no driver bound to the
device, but I don't think it does if there is a driver (except maybe a
trivial stub driver that doesn't actually operate the device).

Bjorn

