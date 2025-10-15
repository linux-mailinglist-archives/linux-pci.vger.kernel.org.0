Return-Path: <linux-pci+bounces-38216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF9BDE9D0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F695075FC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D6C326D75;
	Wed, 15 Oct 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vXKGWoKL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B46326D79
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533171; cv=none; b=gRgzfD0VlEmdDs6L3uAppMrn7DFP/rxUvdttzV4VdVt6wqOl+sf34F+OX40plH8d7yfOTQ2szK0BYm2pXiM29dQj2YZtvAPME6fn4RvIwU4obCjXrupz3giaaAGT60p/A9CJR3A0cu48UmOY8x1Ft+SGPfsc1PN/cndosIniRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533171; c=relaxed/simple;
	bh=mA7DIVHgKPvepc7J7kY2hTWCrTF7HVJXBDwLWlEw0MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ut2xWJ3a+No4XefqTfTGPhR8xe23AvWnq4H4NbK6bz1Jkuz//cijYCin5xl+y4afUnhlV6Yufup8YpF4e/hv3S4MkHb+wAUpq0E2DwleN5cVVU54e0wnNZaDhLgj63ovOzm/PUycF8rcVDI+6x+M0fyiOBLEB2uKYuBeRF37TdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vXKGWoKL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 644D24E410D7;
	Wed, 15 Oct 2025 12:59:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 31720606F9;
	Wed, 15 Oct 2025 12:59:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11EBB102F22C9;
	Wed, 15 Oct 2025 14:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760533166; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m0D5lTBcRRjQJDnMrKYFTSajSsfESny/hir+6+IztSM=;
	b=vXKGWoKLCXCUAGdXC3OwlCdAQymxkkrvdpzzd4URDlQaQTu1vQLPHJC017heFxnT1EW04e
	IXG4AOCWtOqNWXGc8yQT8PddYEjb+3S444gkqLlF0OHI7T+FsP0R6bHh/+OLGchTkfw2Pg
	+FpXk/t1MDhV6qtD/lMl/Kmi3sJWSQ5XGKAOpbCnxde/OsTK/JJAj5d6Fi2h1AebNU5xFw
	2yHMqpM7O/y+L4TsCbezCoqI0TTnF2wcz5MScuEKSmHZ8blFB/BjH3mRler0fMd/vJ8UWJ
	HGbxXETRHihUIul00MlMDpp17FxdMozgH6Q0h4CEhOf7fCPipPYNnT5JkL+dzA==
Date: Wed, 15 Oct 2025 14:59:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, mad skateman
 <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian
 Zigotzky <info@xenosoft.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>,
 debian-powerpc@lists.debian.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251015145901.3ca9d8a0@bootlin.com>
In-Reply-To: <EF4D5B4B-9A61-4CF8-A5CC-5F6A49E824C1@xenosoft.de>
References: <20251015135811.58b22331@bootlin.com>
	<EF4D5B4B-9A61-4CF8-A5CC-5F6A49E824C1@xenosoft.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 15 Oct 2025 14:27:00 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> > On 15 October 2025 at 01:58 pm, Herve Codina <herve.codina@bootlin.com> wrote:
> > 
> > ﻿Hi Christian,
> >   
> >> On Wed, 15 Oct 2025 13:30:44 +0200
> >> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >> 
> >> Hello Herve,
> >>   
> >>>> On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:  
> >>> 
> >>> ﻿Hi All,
> >>> 
> >>> I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> >>> ClockPM and ASPM states for devicetree platforms")    
> >> 
> >> Thanks for reporting.
> >>   
> >>> 
> >>> Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> >>> an the quirk also fixes the timing issue.    
> >> 
> >> Where have you added quirk_disable_aspm_all?  
> > 
> > --- 8< ---
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..a3808ab6e92e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >  */
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > 
> > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> > +}
> > +
> > +/* LAN966x PCI board */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, quirk_disable_aspm_all);
> > +
> > /*
> >  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> >  * Link bit cleared after starting the link retrain process to allow this
> > --- 8< ---
> > 
> > Best regards,
> > Hervé  
> 
> It is the same patch, I use for my AMD Radeon cards.
> 
> In my point of view we have to add a lot of other devices.

Yes, probably!

> 
> But if the computer does not boot, will the average user know that there is a problem with the power management and their graphics card?
> I am unsure whether I can deliver the kernel to average users later on.

Also when it boots, it is not easy to know about the problem root cause.

In my case, it was not obvious to make the relationship on my side between
my ping timings behavior and ASPM.

Of course 'git bisect' helped a lot but can we rely on that for the average
user?

Best regards,
Hervé

