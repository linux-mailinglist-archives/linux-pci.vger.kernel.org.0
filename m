Return-Path: <linux-pci+bounces-22885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06DA4E967
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6247A8AD5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79147296153;
	Tue,  4 Mar 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VL/7yigD"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEB25178A
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108393; cv=pass; b=WK6vXCh8Zsczhk/N2GQ425X36c1sOWINj1gfAWrqXUCu8X4c9RVdv87ydvMaM0uK5jQPy48IbpW1sttZAftZi6LG6UsCspr9JcRIQBCoS3nk/imxxvldlP25kVoQBBJiMVD785EvJOd7uipgcwwQPQz2DBQ/csWSmjy8BDpNeJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108393; c=relaxed/simple;
	bh=e0Wy96/Vl/Za2xK/skILAtBW0xOPi/xeh93FvbxO05A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VIRn80ZV/nGbTlp6uWwHnH/AMwwRX/SJEiFDd4ADh2m5nBHaKkTxj3PQV4uJ8nVH9Ok40Ftl4O8qjuWMTf4WJrLyESAd7qloa7BVqnnk4/ID1gvKNxyVIiBrc9+NZ6vAjsSAwRADGdmBQ3BF7fWbVG9piSmWfvhjLMT80yequb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL/7yigD; arc=none smtp.client-ip=192.198.163.8; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id C79CC40D1F48
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 20:13:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VL/7yigD
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gfS48SWzG2Pp
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 19:11:28 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id EDAFC42744; Tue,  4 Mar 2025 19:11:22 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL/7yigD
X-Envelope-From: <linux-kernel+bounces-541656-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL/7yigD
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id BA43B42855
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:04:43 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 256E92DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:04:42 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BA53B57F3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45B20DD48;
	Mon,  3 Mar 2025 11:58:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2D2036F9;
	Mon,  3 Mar 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003111; cv=none; b=UZxp1juwH/4H/KFqGkdrlsa5fAoHjvWblt13nz9++dYCNns0+f8RvOdF4vI36LiNvXKQuOWT/bQLdm+5mKpxC9aJZeKRk+p9zNAGvT0peB9frVUaCZe0xNNTalng2nfHnYhK3PX3hcINEUvG3/Ng1bsA591TBvXxp3cGe2WjsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003111; c=relaxed/simple;
	bh=e0Wy96/Vl/Za2xK/skILAtBW0xOPi/xeh93FvbxO05A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T3/KWn8r+cnDKua4eX/uZ4cSQQUFSCtS0WZ1OozirHOcq5eZqI24VbptJb7+TdGHacoGBobrMIf/wkoIbKYAZbaJqGKncmx8Z+9dojlWaqLOee/B4ifD2uTisnmWXYxi17D1Os6tcwKDBfxseiSlVYDfziSE5EjFjl/IYahS9KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL/7yigD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741003110; x=1772539110;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e0Wy96/Vl/Za2xK/skILAtBW0xOPi/xeh93FvbxO05A=;
  b=VL/7yigDTIhgpVZFi2217on20CxNR/u0lVny0+G836xGjRe6sjoJotcV
   1mYbOrTMUz2yCdvLV3eFi9015cO27PcN6+m1+67jubLnHk5FOlSqTjduI
   ILBL9y4wNiUwGt5v5+5mRbz4v9n+CJFDvSCd2MnafB7+j9A6yDFuRVJJM
   hLxuaV0a9QatQIYjDH8tej64heZEa7watkTYh/4r4YtP+2uEAFMM6Caai
   BbxE4BMwR+L3Ck6WonV4QrBQqu5O64kwjvyBpCsufuMwY61f72OfERBm6
   NBg+ooIXGBiWeZYWXyrxbZZpwnUkOHa2QGNHxBAalbzn5f9nm+t5wpaaT
   Q==;
X-CSE-ConnectionGUID: qO1VuDtXT+mwgkTN8qh9lg==
X-CSE-MsgGUID: TVOE7AfYSmOPNiNw48XHOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="59419267"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="59419267"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:58:29 -0800
X-CSE-ConnectionGUID: d9MuPnbBQimcIBMNmwtQFg==
X-CSE-MsgGUID: 7CustbZ9QxqW5b+mhEq4NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122939010"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:58:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Mar 2025 13:58:23 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Joel Mathew Thomas <proxy0@tutamail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable PCIe BW controller during
 reset
In-Reply-To: <Z7_4nMod6jWd-Bi1@wunner.de>
Message-ID: <7fd2f9e9-9c31-abb0-d0c9-f9d0a0ac1bd6@linux.intel.com>
References: <20250217165258.3811-1-ilpo.jarvinen@linux.intel.com> <Z7RL7ZXZ_vDUbncw@wunner.de> <14797a5a-6ded-bf8f-aa0c-128668ba608f@linux.intel.com> <Z7_4nMod6jWd-Bi1@wunner.de>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-551350541-1741003103=:33389"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gfS48SWzG2Pp
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713100.4428@xtFI9e7Aw0ZZfbGXsiK5Hw
X-ITU-MailScanner-SpamCheck: not spam

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-551350541-1741003103=:33389
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 27 Feb 2025, Lukas Wunner wrote:

> On Mon, Feb 24, 2025 at 05:13:15PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 18 Feb 2025, Lukas Wunner wrote:
> > > On Mon, Feb 17, 2025 at 06:52:58PM +0200, Ilpo J=E4rvinen wrote:
> > > > PCIe BW controller enables BW notifications for Downstream Ports by
> > > > setting Link Bandwidth Management Interrupt Enable (LBMIE) and Link
> > > > Autonomous Bandwidth Interrupt Enable (LABIE) (PCIe Spec. r6.2 sec.
> > > > 7.5.3.7).
> > > >=20
> > > > It was discovered that performing a reset can lead to the device
> > > > underneath the Downstream Port becoming unavailable if BW notificat=
ions
> > > > are left enabled throughout the reset sequence (at least LBMIE was
> > > > found to cause an issue).
> > >=20
> > > What kind of reset?  FLR?  SBR?  This needs to be specified in the
> > > commit message so that the reader isn't forced to sift through a
> > > bugzilla with dozens of comments and attachments.
> >=20
> > Heh, I never really tried to figure out it because the reset disable=20
> > patch was just a stab into the dark style patch. To my surprise, it end=
ed=20
> > up working (after the initial confusion was resolved) and I just starte=
d=20
> > to prepare this patch from that knowledge.
>=20
> If the present patch is of the type "changing this somehow makes the
> problem go away" instead of a complete root-cause analysis, it would
> have been appropriate to mark it as an RFC.

I'll keep that mind in the future.

I don't think your depiction is entirely accurate of the situtation=20
though. The reporter had confirmed that if bwctrl is change(s) are=20
reverted, the problem is not observed.

So I set to understand why bwctrl has any impact here at all since it=20
should touch only a different device (and even that in relatively limited=
=20
ways). And that is how I found that if bwctrl is not enabled during reset,=
=20
the problem is also not observed.

I also noted that the patch just works around the problems and there was=20
also informal speculation about the suspected root cause in the patch (the=
=20
only other theory I've a about the root cause relates to extra interrupts=
=20
causing a problem through hp/pme interrupt handlers).

> I've started to dig into the bugzilla and the very first attachment
> (dmesg for the non-working case) shows:
>=20
>   vfio-pci 0000:01:00.0: timed out waiting for pending transaction; perfo=
rming function level reset anyway
>=20
> That message is emitted by pcie_flr().  Perhaps the Nvidia GPU takes
> more time than usual to finish pending transactions, so the first
> thing I would have tried would be to raise the timeout significantly
> and see if that helps.  Yet I'm not seeing any patch or comment in
> the bugzilla where this was attempted.  Please provide a patch for
> the reporter to verify this hypothesis.

I've problem in understanding how reverting bwctrl change does "solve" to=
=20
this. Bwctrl is not even supposed to touch Nvidia GPU at all AFAIK.

> > Logs do mention this:
> >=20
> > [   21.560206] pcieport 0000:00:01.1: unlocked secondary bus reset via:=
 pciehp_reset_slot+0x98/0x140
> >=20
> > ...so it seems to be SBR.
>=20
> Looking at the vfio code, vfio_pci_core_enable() (which is called on
> binding the vfio driver to the GPU) invokes pci_try_reset_function().
> This will execute the reset method configured via sysfs.  The same
> is done on unbind via vfio_pci_core_disable().
>=20
> So you should have asked the reporter for the contents of:
> /sys/bus/pci/devices/0000:01:00.0/reset_method
> /sys/bus/pci/devices/0000:01:00.1/reset_method
>=20
> In particular, I would like to know whether the contents differ across
> different kernel versions.
>=20
> There's another way to perform a reset:   Via an ioctl.  This ends up
> calling vfio_pci_dev_set_hot_reset(), which invokes pci_reset_bus()
> to perform an SBR.
>=20
> Looking at dmesg output in log_linux_6.13.2-arch1-1_pcie_port_pm_off.log
> it seems that vfio first performs a function reset of the GPU on bind...
>=20
> [   40.171564] vfio-pci 0000:01:00.0: resetting
> [   40.276485] vfio-pci 0000:01:00.0: reset done
>=20
> ...and then goes on to perform an SBR both of the GPU and its audio
> device...
>=20
> [   40.381082] vfio-pci 0000:01:00.0: resetting
> [   40.381180] vfio-pci 0000:01:00.1: resetting
> [   40.381228] pcieport 0000:00:01.1: unlocked secondary bus reset via: p=
ciehp_reset_slot+0x98/0x140
> [   40.620442] vfio-pci 0000:01:00.0: reset done
> [   40.620479] vfio-pci 0000:01:00.1: reset done
>=20
> ...which is odd because the audio device apparently wasn't bound to
> vfio-pci, otherwise there would have been a function reset.  So why
> does vfio think it can safely reset it?
>=20
> Oddly, there is a third function reset of only the GPU:
>=20
> [   40.621894] vfio-pci 0000:01:00.0: resetting
> [   40.724430] vfio-pci 0000:01:00.0: reset done
>=20
> The reporter writes that pcie_port_pm=3Doff avoids the PME messages.
> If the reset_method is "pm", I could imagine that the Nvidia GPU
> signals a PME event during the D0 -> D3hot -> D0 transition.
>
> I also note that the vfio-pci driver allows runtime PM.  So both the
> GPU and its audio device may runtime suspend to D3hot.  This in turn
> lets the Root Port runtime suspend to D3hot.  It looks like the
> reporter is using a laptop with an integrated AMD GPU and a
> discrete Nvidia GPU.  On such products the platform often allows
> powering down the discrete GPU and this is usually controlled
> through ACPI Power Resources attached to the Root Port.
> Those are powered off after the Root Port goes to D3hot.
> You should have asked the reporter for an acpidump.

A lots of these suggestions do not make much sense to me given that=20
reverting bwctrl alone does not exhibit the problem. E.g., the reset=20
method should be exactly the same.

I can see there could be some way through either hp or PME interrupt=20
handlers, where an extra interrupt that comes due to bwctrl (LBMIE) being=
=20
enabled triggers one of the such behaviors. But none of the above=20
description theoritizes anything to that direction.

> pcie_bwnotif_irq() accesses the Link Status register without
> acquiring a runtime PM reference on the PCIe port.  This feels
> wrong and may also contribute to the issue reported here.
> Acquiring a runtime PM ref may sleep, so I think you need to
> change the driver to use a threaded IRQ handler.
>=20
> Nvidia GPUs are known to hide the audio device if no audio-capable
> display is attached (e.g. HDMI).  quirk_nvidia_hda() unhides the
> audio device on boot and resume.  It might be necessary to also run
> the quirk after resetting the GPU.  Knowing which reset_method
> was used is important to decide if that's necessary, and also
> whether a display was attached.

=2E..You seem to have a lot of ideas on this. ;-)

> Moreover Nvidia GPUs are known to change the link speed on idle
> to reduce power consumption.  Perhaps resetting the GPU causes
> a change of link speed and thus execution of pcie_bwnotif_irq()?

Why would execution of pcie_bwnotif_irq() be a problem, it's not that
complicated?

I'm more worried that having LBMIE enabled causes also the other interrupt=
=20
handlers to execute due to the shared interrupt.

> > > This approach won't work if the reset is performed without software
> > > intervention.  E.g. if a DPC event occurs, the device likewise underg=
oes
> > > a reset but there is no prior system software involvement.  Software =
only
> > > becomes involved *after* the reset has occurred.
> > >=20
> > > I think it needs to be tested if that same issue occurs with DPC.
> > > It's easy to simulate DPC by setting the Software Trigger bit:
> > >=20
> > > setpci -s 00:01.1 ECAP_DPC+6.w=3D40:40
> > >=20
> > > If the issue does occur with DPC then this fix isn't sufficient.
> >=20
> > Looking into lspci logs, I don't see DPC capability being there for=20
> > 00:01.1?!
>=20
> Hm, so we can't verify whether your approach is safe for DPC.
>=20
>=20
> > > Instead of putting this in the PCI core, amend pcie_portdrv_err_handl=
er
> > > with ->reset_prepare and ->reset_done callbacks which call down to al=
l
> > > the port service drivers, then amend bwctrl.c to disable/enable
> > > interrupts in these callbacks.
> >=20
> > Will it work? I mean if the port itself is not reset (0000:00:01.1 in t=
his=20
> > case), do these callbacks get called for it?
>=20
> Never mind, indeed this won't work.
>=20
> Thanks,
>=20
> Lukas
>=20

I'm sorry for the delay, I've been sick for a while.

--=20
 i.

--8323328-551350541-1741003103=:33389--


