Return-Path: <linux-pci+bounces-9316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C647D918583
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3DF1F234DC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAF18509F;
	Wed, 26 Jun 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KffZscbZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427FC14F;
	Wed, 26 Jun 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414949; cv=none; b=hmSqxW/4l92AoW4ZeIrYACelUxIp+2ncgBhIOF2mBj1zQaLzTAAsDrWs41FEBVC4CrzvfavHjIzrmg9jIq6HuT8vDpr3KooougIxPgWGeTmae+N6E7iZw4LKWV5/iw2m2/zBZehiqFt1iFgU2nK7Nw0hyAg4TbsQCoOJpecirW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414949; c=relaxed/simple;
	bh=UpQC2H0uM70uE62+a4eyqSjsiSzz3ws6dnp8Q28LdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YtanqXclkxoKrnCe3X3xwCK7ncOVh7MUTmP8iI6ZTn4C9ljDDn3lC4tkuMUNyrCYppdLjad1St1zskXqZSKFlQ9/1DJ/9g9sn4x6gxM2mdczidyVk0yewdJIDYNl7h8mK/NBm/v4StatrDaHBPweCStUMAZi1jHJNKKfmjYoJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KffZscbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABE0C116B1;
	Wed, 26 Jun 2024 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414949;
	bh=UpQC2H0uM70uE62+a4eyqSjsiSzz3ws6dnp8Q28LdaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KffZscbZfm1m1k+FV8X2wDXxCDswg03shB/KMu/mxR7fQxOX97ntfEYmoGfb4w8iN
	 bY6DfYd7xslnWK8jlmfEygy7xKoScfwAwU1N2Jh4B0fCSflS4KxN0W/Yek0BeewAxU
	 D01MdCfQHEG3LZJGMHVxiB6/0u1O2I7Ez6ixK0y6mRNLnc4gP8BquwoxwcnWMERw83
	 IlgPmEbojht79NzIe5LBULPQVFFHYwfOyC0PPmKfX2eIKv3juHQWpHnYKCJawBK/aZ
	 KAYCYdl6ZGnEYvkaHzfo/WptbmDFOU2XAZoegr5aQWU0TOa95UiOGnvNYoAmX0q/A9
	 sxi2YhUtTLXIA==
Date: Wed, 26 Jun 2024 10:15:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yihang Li <liyihang9@huawei.com>, cassel@kernel.org,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	john.g.garry@oracle.com, yanaijie@huawei.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxarm@huawei.com, chenxiang66@hisilicon.com,
	prime.zeng@huawei.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
Message-ID: <20240626151546.GA1466906@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39b4a5b-07b7-483b-9c42-3ac80503120d@kernel.org>

On Mon, Jun 24, 2024 at 09:10:41AM +0900, Damien Le Moal wrote:
> On 6/22/24 12:31 PM, Yihang Li wrote:
> > Hi Damien,
> > 
> > Thanks for your reply.
> > 
> > On 2024/6/19 7:11, Damien Le Moal wrote:
> >> On 6/18/24 22:29, Yihang Li wrote:
> >>> Hi Damien,
> >>>
> >>> I found out that two issues is caused by commit 0c76106cb975 ("scsi: sd:
> >>> Fix TCG OPAL unlock on system resume") and 626b13f015e0 ("scsi: Do not
> >>> rescan devices with a suspended queue").
> >>>
> >>> The two issues as follows for the situation that there are ATA disks
> >>> connected with SAS controller:
> >>
> >> Which controller ? What is the driver ?
> > 
> > I'm using the hisi_sas_v3_hw driver and it supports HiSilicon's SAS controller.
> 
> I do not have access to this HBA, but I have one that uses libsas/pm8001 driver
> so I will try to test with that.
> 
> >>> (1) FLR is triggered after all disks and controller are suspended. As a
> >>> result, the number of disks is abnormal.
> >>
> >> I am assuming here that FLR means PCI "Function Level Reset" ?
> > 
> > Yes, I am talking about the PCI "Function Level Reset"
> > 
> >> FLR and disk/controller suspend execution timing are unrelated. FLR can be
> >> triggered at any time through sysfs. So please give details here. Why is FLR
> >> done when the system is being suspended ?
> > 
> > Yes, it is because FLR can be triggered at any time that we are testing the
> > reliability of executing FLR commands after disk/controller suspended.
> 
> "can be triggered" ? FLR is not a random asynchronous event. It is an action
> that is *issued* by a user with sys admin rights. And such users can do a lot
> of things that can break a machine...
> 
> I fail to see the point of doing a function reset while the device is
> suspended. But granted, I guess the device should comeback up in such case,
> though I would like to hear what the PCI guys have to say about this.
> 
> Bjorn,
> 
> Is reseting a suspended PCI device something that should be/is supported ?

I doubt it.  The PCI core should be preserving all the generic PCI
state across suspend/resume.  The driver should only need to
save/restore device-specific things the PCI core doesn't know about.

A reset will clear out most state, and the driver doesn't know the
reset happened, so it will expect most device state to have been
preserved.

Bjorn

