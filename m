Return-Path: <linux-pci+bounces-7566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598258C7451
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DD11C218F4
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D030143884;
	Thu, 16 May 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UG72apak"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF68143883;
	Thu, 16 May 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853801; cv=none; b=u5EbAPtLJx/b1r36JyquhJKvBvgf94lUvqjPRkXDf5GTbOJIkrhl7GbCNqEE9NNBNCDBLVGRztVd4fi9gDSLMGvFIGc10rZQM30o4TaO0ZiJZULBMIkYNUt43dWS2RjpbhDU74kYqup1Ap9YR2Im54s/8Ux/mrhMWY4NRGUww64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853801; c=relaxed/simple;
	bh=r1RHPwjyAgK2tGzBnhNg6KelUvF/Lg5CeAK7qt4ClQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFQcmmszaASgQlJ2gGXHbqsgRTgHtLqsy8G4fW1mEkYkeBtPfGFsUoR37MD5imv2vDHY9koahMb4dqYYptESm3etLQ50cRgNqYs3ClGh5Cy4NFn/8nwaU5H4sbfal+BegikMRKi92jYqeGqIcIwiQcoVSPk5eSXxoGpX8IEWKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UG72apak; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715853800; x=1747389800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1RHPwjyAgK2tGzBnhNg6KelUvF/Lg5CeAK7qt4ClQw=;
  b=UG72apakARQ3MKOfaPBl0tNsUsCKAygMVbfPErovaDPQEyr7o5p/9zoo
   nIisflh03kPO0zoupvhBcFneLQA58efHDOnkYOSukVRazFXArYoKqbYsd
   BvbBU32MGCRRkwFiBpVXO3ScsL7SyvwyLZZz6NIWhwycyFr3F8JzG2WL6
   iPzsiwdCaoPj/EqRZkngRjjRRS2hIYMbaTeRwE630/9mW4uXGszJEglgN
   EOkstG/Fd50F9kt1l0zg2jQDF/zSNetbdNnH/tv0+lniHBdo9EmF/Q55W
   ETYETqF4bjEidPM7m9pkBqOPNtsssdwsf6vXbDUUGPnPPOQ41vKYnCAxz
   g==;
X-CSE-ConnectionGUID: dFU9DBb+T2yGAY92tbcpXg==
X-CSE-MsgGUID: mHEJaAoPQnq+4D6YqO98Fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11764064"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11764064"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:03:19 -0700
X-CSE-ConnectionGUID: g0V9RiB1SOWq1ESDSqoWdQ==
X-CSE-MsgGUID: pNZHGDq9SeSoRLGhGP/4eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="62215168"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 16 May 2024 03:03:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 63ABB9F6; Thu, 16 May 2024 13:03:15 +0300 (EEST)
Date: Thu, 16 May 2024 13:03:15 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240516100315.GC1421138@black.fi.intel.com>
References: <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516083017.GA1421138@black.fi.intel.com>

On Thu, May 16, 2024 at 11:30:17AM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Wed, May 15, 2024 at 10:35:22PM +0200, Lukas Wunner wrote:
> > On Wed, May 15, 2024 at 02:53:54PM -0400, Esther Shimanovich wrote:
> > > On Wed, May 8, 2024 at 1:23???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
> > > > > On Sat, Apr 27, 2024 at 3:17AM Lukas Wunner <lukas@wunner.de> wrote:
> > > > > That is correct, when the user-visible issue occurs, no driver is
> > > > > bound to the NHI and XHCI. The discrete JHL chip is not permitted to
> > > > > attach to the external-facing root port because of the security
> > > > > policy, so the NHI and XHCI are not seen by the computer.
> > > >
> > > > Could you rework your patch to only rectify the NHI's and XHCI's
> > > > device properties and leave the bridges untouched?
> > > 
> > > So I tried a build with that patch, but it never reached the
> > > tb_pci_fixup function
> > 
> > That means that for some reason, the PCI devices are not associated with
> > the Thunderbolt ports.  Could you add this to the command line:
> > 
> >   thunderbolt.dyndbg ignore_loglevel log_buf_len=10M
> > 
> > and this to your kernel config:
> > 
> >   CONFIG_DYNAMIC_DEBUG=y
> > 
> > You should see "... is associated with ..." messages in dmesg.
> > This did work for Mika during his testing with recent Thunderbolt chips.
> > I amended the patches after his testing but wouldn't expect that to
> > cause issues.
> > 
> > @Mika, would you mind re-testing if you've got cycles to spare?
> 
> Sure, I'll try this today and update.

Okay now tried with your latest branch on Meteor Lake-P (integrated
Thunderbolt). I do get these:

[   12.911728] thunderbolt 0000:00:0d.2: 0:8: associated with 0000:00:07.0
[   12.911732] thunderbolt 0000:00:0d.2: 0:9: associated with 0000:00:07.1
...
[   13.250242] thunderbolt 0000:00:0d.3: 0:8: associated with 0000:00:07.2
[   13.250245] thunderbolt 0000:00:0d.3: 0:9: associated with 0000:00:07.3

The adapters 8 and 9 are PCIe as expected

# tbadapters -r 0 -a 8 -a 9
 8: PCIe Down                     Disabled  
 9: PCIe Down                     Disabled  

# tbadapters -d1 -r 0 -a 8 -a 9
 8: PCIe Down                     Disabled  
 9: PCIe Down                     Disabled  

And the 07.[0-3] are the PCIe Thunderbolt Root Ports:

# lspci
...
00:07.0 PCI bridge: Intel Corporation Meteor Lake-P Thunderbolt 4 PCI Express Root Port #0 (rev 10)
00:07.1 PCI bridge: Intel Corporation Meteor Lake-P Thunderbolt 4 PCI Express Root Port #1 (rev 10)
00:07.2 PCI bridge: Intel Corporation Meteor Lake-P Thunderbolt 4 PCI Express Root Port #2 (rev 10)
00:07.3 PCI bridge: Intel Corporation Meteor Lake-P Thunderbolt 4 PCI Express Root Port #3 (rev 10)
...

