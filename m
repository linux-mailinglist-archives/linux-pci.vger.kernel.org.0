Return-Path: <linux-pci+bounces-4008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E88673D4
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8181C25C83
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F01D54B;
	Mon, 26 Feb 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIYdPJD8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0B1DA37;
	Mon, 26 Feb 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948184; cv=none; b=fRLDPGmEwOQ7Z764LR12ehD941heY9eOmfN/7aQbZMkIRCJpAmkuu+GKDTh8G2gthv6crPh0m3349yFhCm6jrEt+nj5q/z4yGUtz9cc1B5KdIm1vCb15WOfha0Y+QCqxJe5rA9wkonJ+pA4XkWYQvhAc0skjXGq9xUqSjwK12lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948184; c=relaxed/simple;
	bh=XDVR6cUnSSDPnKY5yPTZWPfRyY9FP26xvfynU2Sa91A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=seaWdjGHeqvn0LesYda3ZWQxcFkjRivmtuAbhCXNVlpSWTdwXb6H6P5+v5V9a1Qo43iTjnKgOq6ohSVFsqJ2AS/WryUyMI4XfwslG8TCaJXvdsmA3GaVlas5ozKIvL7cqthtiCpqG+8Qc3xdctAnRr0Y36bAhS+cjqKfwxlHBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIYdPJD8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708948183; x=1740484183;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XDVR6cUnSSDPnKY5yPTZWPfRyY9FP26xvfynU2Sa91A=;
  b=FIYdPJD8xgpDHi8jNyFTM13HGtcC37xUoTJMe/o7L4MnMf7TIvnj7pTo
   /hz3kG7CtyTP6egioOUb6sUPEEwujf3Nw5IJpC5wY5f9bi3DgxROxzvZv
   EOhCpZqkGM7awIxqA6bND1zor7cH/L40s/FsWRoaZ9JgRQCopzuajja8S
   0hO5Pgn8dIksEjRQhq76hiSjDocRgrRvu2dR2iyg6sveQKd62XAcSTWvZ
   4bAdFgCPD8CNWn+zKPhWBKI8q9hDGMGTBz/q+2xuVSHFHhtTfZwAvzzsH
   G9aQh/7DC5MxOnjn7TGjl7UODQ2rdBRGKoHjxgWE8py//CsKO/JPhdVQ4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7032128"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7032128"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6634988"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:49:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Feb 2024 13:49:34 +0200 (EET)
To: Mathias De Weerdt <mathias.de.weerdt@gmail.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, ben.chuang@genesyslogic.com.tw, 
    johnsonm@danlj.org, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, 
    linux-pm@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: Bug Report: Delayed Wake from Suspend with Genesys Logic GL9755
 SD Host Controller
In-Reply-To: <CAKfmkPK+T0887-uQORxOzbcz-ZxBY+wKLYPRoiQiUfNhffQBEg@mail.gmail.com>
Message-ID: <0aa430ff-c60d-b2c6-bb1c-e352ae7be020@linux.intel.com>
References: <CAKfmkPKW=cD88D-cYJUaoN0A6i91C5ukiy6AYYWpNbW8VBQaGA@mail.gmail.com> <20240225233117.GA182018@bhelgaas> <CAKfmkPK+T0887-uQORxOzbcz-ZxBY+wKLYPRoiQiUfNhffQBEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 26 Feb 2024, Mathias De Weerdt wrote:

> Hi Bjorn
> 
> This has indeed never worked. I have even tried plenty of older
> kernels and now also the latest mainline.
> 
> I collected the data you requested on the following kernel (Latest
> mainline as of yesterday)
> Linux core-arch 6.8.0-rc5-1-mainline #1 SMP PREEMPT_DYNAMIC Sun, 25
> Feb 2024 21:59:28 +0000 x86_64 GNU/Linux
> 
> After booting the laptop I put it to sleep and woke it up and
> collected the dmesg and lspci logs. (They have been attached)
> 
> Thanks for your quick response.
> If you need anything else please let me know.
> 
> Kinds regards
> Mathias
> 
> On Mon, 26 Feb 2024 at 00:31, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sun, Feb 25, 2024 at 11:38:35PM +0100, Mathias De Weerdt wrote:
> > > Hi
> > >
> > > I am writing to report a potential bug in the Linux kernel related to
> > > waking from suspend on a system(Laptop) with a Genesys Logic GL9755 SD
> > > Host Controller. Below are the details of the issue:
> >
> > Hi Mathias, thanks very much for this report.  A few questions below.
> >
> > > Issue Description:
> > > After suspending the system, waking it up takes an extended amount of
> > > time, typically 1 to 2 minutes. The delay occurs consistently and is
> > > observed in the dmesg logs.
> > >
> > >
> > > System Information:
> > > - OS: Arch Linux x86_64
> > > - Kernel: 6.7.5-arch1-1 and 6.7.6-arch1-1
> > > - SD Host Controller: Genesys Logic GL9755 SD Host Controller (PCI ID:
> > > 17a0:9755)
> > >
> > > Observed Logs (dmesg):
> > > [ 642.483972] sdhci-pci 0000:2f:00.0: not ready 1023ms after resume; waiting
> > > [ 643.537370] sdhci-pci 0000:2f:00.0: not ready 2047ms after resume; waiting
> > > [ 645.724028] sdhci-pci 0000:2f:00.0: not ready 4095ms after resume; waiting
> > > [ 649.990655] sdhci-pci 0000:2f:00.0: not ready 8191ms after resume; waiting
> > > [ 658.310658] sdhci-pci 0000:2f:00.0: not ready 16383ms after resume; waiting
> > > [ 675.590673] sdhci-pci 0000:2f:00.0: not ready 32767ms after resume; waiting
> > > [ 709.723965] sdhci-pci 0000:2f:00.0: not ready 65535ms after resume; giving up
> > > [ 709.724183] sdhci-pci 0000:2f:00.0: Unable to change power state
> > > from D3cold to D0, device inaccessible

Hi Mathias,

In your dmesg, there's the Target Speed quirk triggering. Please try these 
two patches, they should fix the logic bug that causes the long delay you 
see:

https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/T/#t

(They won't help to the link not coming up issue though).

-- 
 i.

