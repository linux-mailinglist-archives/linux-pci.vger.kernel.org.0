Return-Path: <linux-pci+bounces-39120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E865FBFFA71
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581771889333
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB5619C54F;
	Thu, 23 Oct 2025 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B0TI/thY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318426F29B
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205128; cv=none; b=CMYWuzcaXZdpgNCiZDfvBYbSCPwgeB3EUYSCR8RrDYkR+ccA6VEbIHSkJ0kAThN8DTZQocQL6/BqbplBu5Wys+0D5O1ZLfqgr4rUcLVpwOHK01eJ81EkQ5fTb081z0YMWD7pfVpymJQ+F4qvakGEijXVGKKw4500LSPTggxCpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205128; c=relaxed/simple;
	bh=W8b8tj6e2hSVdA2tFt0fo12ghljCu3C+sxeMjT09UTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gc1S1bR25cyewdfBVJHI/8nXLg4St+2lxs2w082wfbhgZE+ncrafo7NZswivjKFDlUmviwAt2x3Pv4ucJw7iGkEYqSlpUZqffUik49Zk87TesOAtteKgGudxCqiSriZQDwKSdkAjo9/8BOhtpVebtUmCMU/TGZfHYlxdg641SIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B0TI/thY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8927FC0C40B;
	Thu, 23 Oct 2025 07:38:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48E6E6062C;
	Thu, 23 Oct 2025 07:38:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 049A2102F245C;
	Thu, 23 Oct 2025 09:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761205122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q5QOWxjIdlO0fc/UnPkoihwCDoCk4/HEVUl6x5L2E6o=;
	b=B0TI/thYf1svatfjx455F/6ddcIQ9+ytTACWEHo+NDvVXAT5mGOX1W0kOWOidG9qbMdJyA
	2QCY/luYvxsQUks8ZedL4LmScCFshZ17lG3rYYFBW7dIfN2L8AckafVYaZVGNWTvrnQd1N
	nSLtPv5bV/oS/6WSJHt/ANnnJnKt9oDaRUvoblfsg20gvmCsQ/sl2MR0QNivNIKRhvZa1T
	O3U60Syjul5/jbim5WtGpCcO2tV86+YnMOQO5FddGySaMmInWMLI9KpJ+a+6AbNreBxMU1
	oNBqC4Bae66xB7508vq9Xnf5VjGWIf7bluKZrzWsN8NSXmep7EsxgRNcRz20hw==
Date: Thu, 23 Oct 2025 09:38:13 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Bjorn Helgaas
 <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, mad skateman
 <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian
 Zigotzky <info@xenosoft.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>,
 debian-powerpc@lists.debian.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251023093813.3fbcd0ce@bootlin.com>
In-Reply-To: <4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i>
References: <20251015101304.3ec03e6b@bootlin.com>
	<A11312DD-8A5A-4456-B0E3-BC8EF37B21A7@xenosoft.de>
	<20251015135811.58b22331@bootlin.com>
	<4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i>
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

Hi Manivannan,

On Wed, 15 Oct 2025 18:20:22 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> Hi Herve,
> 
> On Wed, Oct 15, 2025 at 01:58:11PM +0200, Herve Codina wrote:
> > Hi Christian,
> > 
> > On Wed, 15 Oct 2025 13:30:44 +0200
> > Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >   
> > > Hello Herve,
> > >   
> > > > On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:
> > > > 
> > > > ﻿Hi All,
> > > > 
> > > > I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> > > > ClockPM and ASPM states for devicetree platforms")    
> > > 
> > > Thanks for reporting.
> > >   
> > > > 
> > > > Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> > > > an the quirk also fixes the timing issue.    
> > > 
> > > Where have you added quirk_disable_aspm_all?  
> > 
> > --- 8< ---
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..a3808ab6e92e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >   */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> >  
> > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);  
> 
> Could you please try disabling L1SS and L0s separately to see which one is
> causing the issue? Like,
> 
> 	pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2);
> 
> 	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
> 

I did tests and here are the results:

  - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_ALL)
    Issue not present

  - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)
    Issue present, timings similar to timings already reported
    (hundreds of ms).

  - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
    Issue present, timings still incorrect but lower
      64 bytes from 192.168.32.100: seq=10 ttl=64 time=16.738 ms
      64 bytes from 192.168.32.100: seq=11 ttl=64 time=39.500 ms
      64 bytes from 192.168.32.100: seq=12 ttl=64 time=62.178 ms
      64 bytes from 192.168.32.100: seq=13 ttl=64 time=84.709 ms
      64 bytes from 192.168.32.100: seq=14 ttl=64 time=107.484 ms

  - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_CLKPM)
    Issue present, timings similar to timings already reported
    (hundreds of ms).

  - No quirk, echo performance > /sys/module/pcie_aspm/parameters/policy
    Issue fixed

  - No quirk, CONFIG_PCIEASPM = n
    Issue fixed (obviously)

Hope those results will help on the topic.

Best regards,
Hervé

