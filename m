Return-Path: <linux-pci+bounces-19751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1051A10FFE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AB8188A8F7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F01FBC8B;
	Tue, 14 Jan 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eU3ZWj+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D883232458;
	Tue, 14 Jan 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879115; cv=none; b=LgUxN2RX65KOlpu5dPZ4LxmLYQ7RWH0XSdHlCnr77naYAqdb6E8PFSHok6it8uIFV/XS4wHI8HKu1B6dwB7Khm4lCnltE4bpn/EXtqIKMxe9Kg8pSIpOvHd/prVe9HJJy3QIqRmjaGsxx6ryYA+BbtYWlSDtGWBL2YZ9a0TCF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879115; c=relaxed/simple;
	bh=tEe8xzbJJWUcgdlezEjLvqqEzMBNmrQay9rNAISnqz8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cxu3rX//lZ3VbSuSHt7kHOJ4UYAFDsfTez/P8XTEoor7bkxlO5fIQ5UVsQGamNUq1F3kcFcx+I+SZf2z/CMj927BGZX2o/VKhDkap+i7/H4/bAgfqowZW93aQpljbPqJ8UK7tmH++pZ0YrMeYAKMDU7BHoQM6JiRamb4E4c16hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eU3ZWj+E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736879111; x=1768415111;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tEe8xzbJJWUcgdlezEjLvqqEzMBNmrQay9rNAISnqz8=;
  b=eU3ZWj+E64gAOvhMfPHsvlC71aYnSncTbQBwJpuI+ihoK14TFouWKcUA
   7uQMlQAOIIE9jGXhzRdk59itgl2pCYQ4KwmR4t2jeLbh5ApS3c3YjynV7
   eiPVmIau1ayn1IsIaQnuLMnna/aWsYi16vRMn1mg9jHfps8mistma7xRw
   DHCxc0AWVy+yRYqQWWIM6Iz7UGOUBfuR9wL/CNSFtBEe5rWVxvvILmKQI
   xIbUf0Jf5D2bAFBYh6sviocwsoKcJnnmx4CmYdlExgDzbevqDzQ9q2aAq
   w4JEmJlD62H0qKEjKNY6+AmhPApZXZ248UjZSYx5iOG/12jLwfex0yoId
   w==;
X-CSE-ConnectionGUID: JKUnNtJ1RAK3A/HMzjnfcQ==
X-CSE-MsgGUID: afSbYQ6eRIG8Zgt62a4ovg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37418141"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37418141"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 10:25:10 -0800
X-CSE-ConnectionGUID: kqojEGJiT86MhQP99bwwxg==
X-CSE-MsgGUID: nXEQKQ+VQjGAs4iRF70EEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142158376"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 10:25:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Jan 2025 20:25:04 +0200 (EET)
To: Jiwei <jiwei.sun.bj@qq.com>, Lukas Wunner <lukas@wunner.de>
cc: macro@orcam.me.uk, bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, guojinhui.liam@bytedance.com, 
    helgaas@kernel.org, ahuang12@lenovo.com, sunjw10@lenovo.com
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
In-Reply-To: <tencent_4514111F8A3EF9408C50D9379FE847610206@qq.com>
Message-ID: <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com>
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com> <3fe7b527-5030-c916-79fe-241bf37e4bab@linux.intel.com> <tencent_4514111F8A3EF9408C50D9379FE847610206@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1690480513-1736879042=:1077"
Content-ID: <3d1c64a4-59e0-dd5d-860b-f48845c6b1fb@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1690480513-1736879042=:1077
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5ec82426-d579-a7b0-1aa5-84ee52409e8f@linux.intel.com>

On Tue, 14 Jan 2025, Jiwei wrote:
> On 1/13/25 23:08, Ilpo J=E4rvinen wrote:
> > On Fri, 10 Jan 2025, Jiwei Sun wrote:
> >=20
> >> From: Jiwei Sun <sunjw10@lenovo.com>
> >>
> >> When we do the quick hot-add/hot-remove test (within 1 second) with a =
PCIE
> >> Gen 5 NVMe disk, there is a possibility that the PCIe bridge will decr=
ease
> >> to 2.5GT/s from 32GT/s
> >>
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Link Down
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> ...
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: broken device, retraining non-functional downs=
tream link at 2.5GT/s
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No link
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Link Up
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> >> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> >> pci 10002:02:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
> >> pci 10002:02:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> >> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
> >> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contain=
s BAR 0 for 64 VFs
> >> pci 10002:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5=
 GT/s PCIe x4 link at 10002:00:04.0 (capable of 126.028 Gb/s with 32.0 GT/s=
 PCIe x4 link)
> >>
> >> If a NVMe disk is hot removed, the pciehp interrupt will be triggered,=
 and
> >> the kernel thread pciehp_ist will be woken up, the
> >> pcie_failed_link_retrain() will be called as the following call trace.
> >>
> >>    irq/87-pciehp-2524    [121] ..... 152046.006765: pcie_failed_link_r=
etrain <-pcie_wait_for_link
> >>    irq/87-pciehp-2524    [121] ..... 152046.006782: <stack trace>
> >>  =3D> [FTRACE TRAMPOLINE]
> >>  =3D> pcie_failed_link_retrain
> >>  =3D> pcie_wait_for_link
> >>  =3D> pciehp_check_link_status
> >>  =3D> pciehp_enable_slot
> >>  =3D> pciehp_handle_presence_or_link_change
> >>  =3D> pciehp_ist
> >>  =3D> irq_thread_fn
> >>  =3D> irq_thread
> >>  =3D> kthread
> >>  =3D> ret_from_fork
> >>  =3D> ret_from_fork_asm
> >>
> >> Accorind to investigation, the issue is caused by the following scener=
ios,
> >>
> >> NVMe disk=09pciehp hardirq
> >> hot-remove =09top-half=09=09pciehp irq kernel thread
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> pciehp hardirq
> >> will be triggered
> >> =09    =09cpu handle pciehp
> >> =09=09hardirq
> >> =09=09pciehp irq kthread will
> >> =09=09be woken up
> >> =09=09=09=09=09pciehp_ist
> >> =09=09=09=09=09...
> >> =09=09=09=09=09  pcie_failed_link_retrain
> >> =09=09=09=09=09    read PCI_EXP_LNKCTL2 register
> >> =09=09=09=09=09    read PCI_EXP_LNKSTA register
> >> If NVMe disk
> >> hot-add before
> >> calling pcie_retrain_link()
> >> =09=09=09=09=09    set target speed to 2_5GT
> >=20
> > This assumes LBMS has been seen but DLLLA isn't? Why is that?
>=20
> Please look at the content below.
>=20
> >=20
> >> =09=09=09=09=09      pcie_bwctrl_change_speed
> >> =09  =09=09=09=09        pcie_retrain_link
> >=20
> >> =09=09=09=09=09=09: the retrain work will be
> >> =09=09=09=09=09=09  successful, because
> >> =09=09=09=09=09=09  pci_match_id() will be
> >> =09=09=09=09=09=09  0 in
> >> =09=09=09=09=09=09  pcie_failed_link_retrain()
> >=20
> > There's no pci_match_id() in pcie_retrain_link() ?? What does that : me=
an?
> > I think the nesting level is wrong in your flow description?
>=20
> Sorry for the confusing information, the complete meaning I want to expre=
ss
> is as follows,
> NVMe disk=09pciehp hardirq
> hot-remove =09top-half=09=09pciehp irq kernel thread
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> pciehp hardirq
> will be triggered
> =09    =09cpu handle pciehp
> =09=09hardirq=20
> =09=09"pciehp" irq kthread
> =09=09will be woken up
> =09=09=09=09=09pciehp_ist
> =09=09=09=09=09...
> =09=09=09=09=09  pcie_failed_link_retrain
> =09=09=09=09=09    pcie_capability_read_word(PCI_EXP_LNKCTL2)
> =09=09=09=09=09    pcie_capability_read_word(PCI_EXP_LNKSTA)
> If NVMe disk
> hot-add before
> calling pcie_retrain_link()
> =09=09=09=09=09    pcie_set_target_speed(PCIE_SPEED_2_5GT)
> =09=09=09=09=09      pcie_bwctrl_change_speed
> =09=09=09=09=09        pcie_retrain_link
> =09=09=09=09=09    // (1) The target link speed field of LNKCTL2 was set =
to 0x1,
> =09=09=09=09=09    //     the retrain work will be successful.
> =09=09=09=09=09    // (2) Return to pcie_failed_link_retrain()
> =09=09=09=09=09    pcie_capability_read_word(PCI_EXP_LNKSTA)
> =09=09=09=09=09    if lnksta & PCI_EXP_LNKSTA_DLLLA
> =09=09=09=09=09       and PCI_EXP_LNKCTL2_TLS_2_5GT was set
> =09=09=09=09=09       and pci_match_id
> =09=09=09=09=09      pcie_capability_read_dword(PCI_EXP_LNKCAP)
> =09=09=09=09=09      pcie_set_target_speed(PCIE_LNKCAP_SLS2SPEED(lnkcap))
> =09=09=09=09=09     =20
> =09=09=09=09=09    // Although the target link speed field of LNKCTL2 was=
 set to 0x1,
> =09=09=09=09=09    // however the dev is not in ids[], the removing downs=
tream=20
> =09=09=09=09=09    // link speed restriction can not be executed.
> =09=09=09=09=09    // The target link speed field of LNKCTL2 could not be=
 restored.
>=20
> Due to the limitation of a length of 75 characters per line, the original=
=20
> explanation omitted many details.
>
> > I don't understand how retrain success relates to the pci_match_id() as=
=20
> > there are two different steps in pcie_failed_link_retrain().
> >=20
> > In step 1, pcie_failed_link_retrain() sets speed to 2.5GT/s if DLLLA=3D=
0 and=20
> > LBMS has been seen. Why is that condition happening in your case? You=
=20
>=20
> According to our test result, it seems so.
> Maybe it is related to our test. Our test involves plugging and unpluggin=
g=20
> multiple times within a second. Below is the dmesg log taken from our tes=
ting
> process. The log below is a portion of the dmesg log that I have captured=
,
> (Please allow me to retain the timestamps, as this information is importa=
nt.)
>=20
> -------------------------------dmesg log---------------------------------=
--------
>=20
> [  537.981302] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7841
> [  537.981329] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  537.981338] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7841
> [  538.014638] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  538.014662] =3D=3D=3D=3D pciehp_ist 703 start running
> [  538.014678] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
> [  538.199104] =3D=3D=3D=3D pcie_reset_lbms_count 281 lbms_count set to 0
> [  538.199130] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  538.567377] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  538.567393] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845

DLLLA=3D0 & LBMS=3D0

> [  538.616219] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045

DLLLA=3D1 & LBMS=3D0

Are all of these for the same device? It would be nice to print the=20
pci_name() too so it's clear what device it's about.

> [  538.617594] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  539.362382] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7841
> [  539.362393] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++

DLLLA=3D1 & LBMS=3D1

> [  539.362400] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7841
> [  539.395720] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041

DLLLA=3D0

But LBMS did not get reset.

So is this perhaps because hotplug cannot keep up with the rapid=20
remove/add going on, and thus will not always call the remove_board()=20
even if the device went away?

Lukas, do you know if there's a good way to resolve this within hotplug=20
side?

> [  539.787501] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  539.787514] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  539.787521] =3D=3D=3D=3D pciehp_ist 703 start running
> [  539.787533] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  539.914182] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  540.503965] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  540.808415] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:-110
> [  540.808430] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1041
> [  540.808440] =3D=3D=3D=3D pcie_lbms_seen 48 count:0x1
> [  540.808448] pcieport 10001:80:02.0: broken device, retraining non-func=
tional downstream link at 2.5GT/s
> [  540.808452] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D pcie_set_target_speed 172, =
speed has been set
> [  540.808459] pcieport 10001:80:02.0: retraining sucessfully, but now is=
 in Gen 1
> [  540.808466] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x5,newlnksta:0=
x1041

--
 i.

> [  541.041386] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  541.041398] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  541.091231] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  541.568126] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  541.568135] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  541.568142] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  541.568168] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  542.029334] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  542.029347] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  542.029353] =3D=3D=3D=3D pciehp_ist 703 start running
> [  542.029362] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  542.120676] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  542.120687] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  542.170424] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  542.172337] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  542.223909] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7841
> [  542.223917] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  542.223924] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7841
> [  542.257249] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  542.809830] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  542.809841] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  542.859463] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  543.097871] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  543.097879] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  543.097885] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  543.097905] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  543.391250] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  543.391260] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  543.391265] =3D=3D=3D=3D pciehp_ist 703 start running
> [  543.391273] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  543.650507] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  543.650517] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  543.700174] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  543.700205] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  544.296255] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe=
 Endpoint
> [  544.296298] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> [  544.296515] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64b=
it]
> [  544.296522] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64b=
it]: contains BAR 0 for 64 VFs
> [  544.297256] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  544.297279] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  544.297288] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  544.297295] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  544.297301] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  544.297314] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  544.297337] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  544.297344] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  544.297352] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  544.297363] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  544.297373] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  544.297385] PCI: No. 2 try to assign unassigned res
> [  544.297390] release child resource [mem 0xbb000000-0xbb007fff 64bit]
> [  544.297396] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0f=
ffff] released
> [  544.297403] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  544.297412] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  544.297422] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x00=
1fffff] to [bus 81] add_size 300000 add_align 100000
> [  544.297438] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: can't assign; no space
> [  544.297444] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: failed to assign
> [  544.297451] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  544.297457] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  544.297464] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: assigned
> [  544.297473] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to expand by 0x300000
> [  544.297481] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to add 300000
> [  544.297488] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  544.297494] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  544.297503] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  544.297524] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  544.297530] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  544.297538] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  544.297558] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  544.297563] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  544.297569] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  544.297579] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  544.297588] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  544.298256] nvme nvme1: pci function 10001:81:00.0
> [  544.298278] nvme 10001:81:00.0: enabling device (0000 -> 0002)
> [  544.298291] pcieport 10001:80:02.0: can't derive routing for PCI INT A
> [  544.298298] nvme 10001:81:00.0: PCI INT A: no GSI
> [  544.875198] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  544.875208] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  544.875215] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  544.875231] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  544.875910] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  544.875920] =3D=3D=3D=3D pciehp_ist 703 start running
> [  544.875928] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
> [  544.876857] =3D=3D=3D=3D pcie_reset_lbms_count 281 lbms_count set to 0
> [  544.876868] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  545.427157] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  545.427169] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  545.476411] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  545.478099] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  545.857887] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  545.857896] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  545.857902] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  545.857929] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  546.410193] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  546.410205] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  546.460531] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  546.697008] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  546.697020] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  546.697025] =3D=3D=3D=3D pciehp_ist 703 start running
> [  546.697034] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  546.697039] pcieport 10001:80:02.0: pciehp: Slot(77): Link Up
> [  546.718015] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  546.987498] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  546.987507] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  546.987514] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  546.987542] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  547.539681] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  547.539693] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  547.589214] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  547.850003] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  547.850011] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  547.850018] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  547.850046] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  547.996918] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  547.996930] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  547.996934] =3D=3D=3D=3D pciehp_ist 703 start running
> [  547.996944] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  548.401899] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  548.401911] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  548.451186] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  548.452886] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  548.682838] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  548.682846] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  548.682852] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  548.682871] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  549.235408] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  549.235420] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  549.284761] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  549.654883] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  549.654892] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  549.654899] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  549.654926] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  549.738806] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  549.738815] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  549.738819] =3D=3D=3D=3D pciehp_ist 703 start running
> [  549.738829] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  550.207186] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  550.207198] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  550.256868] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  550.256890] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  550.575344] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  550.575353] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  550.575360] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  550.575386] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  551.127757] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  551.127768] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  551.177224] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  551.477699] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  551.477711] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  551.477716] =3D=3D=3D=3D pciehp_ist 703 start running
> [  551.477725] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  551.477730] pcieport 10001:80:02.0: pciehp: Slot(77): Link Up
> [  551.498667] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  551.788685] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe=
 Endpoint
> [  551.788723] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> [  551.788933] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64b=
it]
> [  551.788941] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64b=
it]: contains BAR 0 for 64 VFs
> [  551.789619] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  551.789653] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  551.789663] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  551.789672] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  551.789677] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  551.789688] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  551.789708] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  551.789715] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  551.789722] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  551.789733] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  551.789743] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  551.789755] PCI: No. 2 try to assign unassigned res
> [  551.789759] release child resource [mem 0xbb000000-0xbb007fff 64bit]
> [  551.789764] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0f=
ffff] released
> [  551.789771] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  551.789779] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  551.789790] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x00=
1fffff] to [bus 81] add_size 300000 add_align 100000
> [  551.789804] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: can't assign; no space
> [  551.789811] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: failed to assign
> [  551.789817] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  551.789823] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  551.789831] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: assigned
> [  551.789839] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to expand by 0x300000
> [  551.789847] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to add 300000
> [  551.789854] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  551.789860] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  551.789869] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  551.789889] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  551.789895] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  551.789903] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  551.789921] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  551.789927] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  551.789933] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  551.789942] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  551.789951] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  551.790638] nvme nvme1: pci function 10001:81:00.0
> [  551.790656] nvme 10001:81:00.0: enabling device (0000 -> 0002)
> [  551.790667] pcieport 10001:80:02.0: can't derive routing for PCI INT A
> [  551.790674] nvme 10001:81:00.0: PCI INT A: no GSI
> [  552.546963] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  552.546973] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  552.546980] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  552.546996] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  552.547590] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  552.547598] =3D=3D=3D=3D pciehp_ist 703 start running
> [  552.547605] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
> [  552.548215] =3D=3D=3D=3D pcie_reset_lbms_count 281 lbms_count set to 0
> [  552.548224] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  553.098957] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  553.098969] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  553.148031] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  553.149553] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  553.499647] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  553.499654] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  553.499660] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  553.499683] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  554.052313] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  554.052325] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  554.102175] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  554.265181] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  554.265188] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  554.265194] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  554.265217] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  554.453449] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  554.453458] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  554.453463] =3D=3D=3D=3D pciehp_ist 703 start running
> [  554.453472] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  554.743040] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  555.475369] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:-110
> [  555.475384] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1041
> [  555.475392] =3D=3D=3D=3D pcie_lbms_seen 48 count:0x2
> [  555.475398] pcieport 10001:80:02.0: broken device, retraining non-func=
tional downstream link at 2.5GT/s
> [  555.475404] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D pcie_set_target_speed 172, =
speed has been set
> [  555.475409] pcieport 10001:80:02.0: retraining sucessfully, but now is=
 in Gen 1
> [  555.475417] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x5,newlnksta:0=
x1041
> [  556.633310] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  556.633322] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  556.633328] =3D=3D=3D=3D pciehp_ist 703 start running
> [  556.633336] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  556.828412] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  556.828440] =3D=3D=3D=3D pciehp_ist 703 start running
> [  556.828448] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  557.017389] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  557.017400] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  557.066666] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  557.066688] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  557.209334] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe=
 Endpoint
> [  557.209374] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> [  557.209585] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64b=
it]
> [  557.209592] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64b=
it]: contains BAR 0 for 64 VFs
> [  557.210275] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  557.210292] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  557.210300] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  557.210307] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  557.210312] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  557.210322] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  557.210342] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  557.210349] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  557.210356] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  557.210366] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  557.210376] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  557.210388] PCI: No. 2 try to assign unassigned res
> [  557.210392] release child resource [mem 0xbb000000-0xbb007fff 64bit]
> [  557.210397] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0f=
ffff] released
> [  557.210405] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  557.210414] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  557.210424] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x00=
1fffff] to [bus 81] add_size 300000 add_align 100000
> [  557.210438] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: can't assign; no space
> [  557.210445] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: failed to assign
> [  557.210451] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  557.210457] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  557.210464] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: assigned
> [  557.210472] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to expand by 0x300000
> [  557.210479] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to add 300000
> [  557.210487] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  557.210492] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  557.210501] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  557.210521] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  557.210527] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  557.210534] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  557.210553] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  557.210559] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  557.210565] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  557.210574] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  557.210583] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  557.211286] nvme nvme1: pci function 10001:81:00.0
> [  557.211303] nvme 10001:81:00.0: enabling device (0000 -> 0002)
> [  557.211315] pcieport 10001:80:02.0: can't derive routing for PCI INT A
> [  557.211322] nvme 10001:81:00.0: PCI INT A: no GSI
> [  557.565811] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  557.565820] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  557.565827] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  557.565842] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  557.566410] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  557.566416] =3D=3D=3D=3D pciehp_ist 703 start running
> [  557.566423] pcieport 10001:80:02.0: pciehp: Slot(77): Link Down
> [  557.567592] =3D=3D=3D=3D pcie_reset_lbms_count 281 lbms_count set to 0
> [  557.567602] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  558.117581] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  558.117594] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  558.166639] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  558.168190] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  558.376176] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  558.376184] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  558.376190] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  558.376208] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  558.928611] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  558.928621] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  558.977769] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  559.186385] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  559.186394] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  559.186400] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  559.186419] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  559.459099] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  559.459111] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  559.459116] =3D=3D=3D=3D pciehp_ist 703 start running
> [  559.459124] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  559.738599] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  559.738610] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  559.787690] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  559.787712] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  560.307243] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  560.307253] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  560.307260] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  560.307282] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  560.978997] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  560.979007] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  560.979013] =3D=3D=3D=3D pciehp_ist 703 start running
> [  560.979022] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  561.410141] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  561.410153] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  561.459064] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  561.459087] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  561.648520] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  561.648528] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  561.648536] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  561.648559] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  562.247076] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  562.247087] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  562.296600] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  562.454228] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7841
> [  562.454236] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  562.454244] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7841
> [  562.487632] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  562.674863] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  562.674874] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  562.674879] =3D=3D=3D=3D pciehp_ist 703 start running
> [  562.674888] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  563.696784] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:-110
> [  563.696798] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1041
> [  563.696806] =3D=3D=3D=3D pcie_lbms_seen 48 count:0x5
> [  563.696813] pcieport 10001:80:02.0: broken device, retraining non-func=
tional downstream link at 2.5GT/s
> [  563.696817] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D pcie_set_target_speed 172, =
speed has been set
> [  563.696823] pcieport 10001:80:02.0: retraining sucessfully, but now is=
 in Gen 1
> [  563.696830] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x5,newlnksta:0=
x1041
> [  564.133582] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  564.133594] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  564.183003] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  564.364911] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  564.364921] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  564.364930] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  564.364954] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  564.889708] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  564.889719] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  564.889724] =3D=3D=3D=3D pciehp_ist 703 start running
> [  564.889732] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  565.493151] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  565.493162] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  565.542478] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  565.542501] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  565.752276] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x5041
> [  565.752285] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  565.752291] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x5041
> [  565.752316] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  566.359793] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  566.359804] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  566.408820] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  566.581150] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7841
> [  566.581159] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  566.581166] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7841
> [  566.614491] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  566.755582] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  566.755591] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  566.755596] =3D=3D=3D=3D pciehp_ist 703 start running
> [  566.755605] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  567.751399] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x9845
> [  567.751412] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x9845
> [  567.776517] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:-110
> [  567.776529] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 116, lnkctl2:0x5, lnksta:0x1845
> [  567.776538] =3D=3D=3D=3D pcie_lbms_seen 48 count:0x8
> [  567.776544] pcieport 10001:80:02.0: broken device, retraining non-func=
tional downstream link at 2.5GT/s
> [  567.801147] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3045
> [  567.801177] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7841
> [  567.801184] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  567.801192] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7841
> [  567.801201] =3D=3D=3D=3D pcie_reset_lbms_count 281 lbms_count set to 0
> [  567.801207] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D pcie_set_target_speed 189, =
bwctl change speed ret:0x0
> [  567.801214] pcieport 10001:80:02.0: retraining sucessfully, but now is=
 in Gen 1
> [  567.801220] pcieport 10001:80:02.0: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D pcie_failed_link_retrain 135, oldlnkctl2:0x5,newlnkctl2:0x1,newlnksta:0=
x3841
> [  567.815102] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x7041
> [  567.815110] =3D=3D=3D=3D pcie_bwnotif_irq 256 lbms_count++
> [  567.815117] =3D=3D=3D=3D pcie_bwnotif_irq 269(stop running),link_statu=
s:0x7041
> [  567.910155] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x1041
> [  568.961434] pcieport 10001:80:02.0: pciehp: Slot(77): No device found
> [  568.961444] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  568.961450] =3D=3D=3D=3D pciehp_ist 703 start running
> [  568.961459] pcieport 10001:80:02.0: pciehp: Slot(77): Card present
> [  569.008665] =3D=3D=3D=3D pcie_bwnotif_irq 247(start running),link_stat=
us:0x3041
> [  569.010428] =3D=3D=3D=3D=3D=3Dpcie_wait_for_link_delay 4787,wait for l=
inksta:0
> [  569.391482] pci 10001:81:00.0: [144d:a826] type 00 class 0x010802 PCIe=
 Endpoint
> [  569.391549] pci 10001:81:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> [  569.391968] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64b=
it]
> [  569.391975] pci 10001:81:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64b=
it]: contains BAR 0 for 64 VFs
> [  569.392869] pci 10001:81:00.0: 8.000 Gb/s available PCIe bandwidth, li=
mited by 2.5 GT/s PCIe x4 link at 10001:80:02.0 (capable of 126.028 Gb/s wi=
th 32.0 GT/s PCIe x4 link)
> [  569.393233] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  569.393249] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  569.393257] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  569.393264] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  569.393270] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  569.393279] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  569.393315] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  569.393322] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  569.393329] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  569.393340] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  569.393350] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  569.393362] PCI: No. 2 try to assign unassigned res
> [  569.393366] release child resource [mem 0xbb000000-0xbb007fff 64bit]
> [  569.393371] pcieport 10001:80:02.0: resource 14 [mem 0xbb000000-0xbb0f=
ffff] released
> [  569.393378] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  569.393404] pcieport 10001:80:02.0: bridge window [io  0x1000-0x0fff] =
to [bus 81] add_size 1000
> [  569.393414] pcieport 10001:80:02.0: bridge window [mem 0x00100000-0x00=
1fffff] to [bus 81] add_size 300000 add_align 100000
> [  569.393430] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: can't assign; no space
> [  569.393438] pcieport 10001:80:02.0: bridge window [mem size 0x00400000=
]: failed to assign
> [  569.393445] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  569.393451] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  569.393458] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: assigned
> [  569.393466] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to expand by 0x300000
> [  569.393474] pcieport 10001:80:02.0: bridge window [mem 0xbb000000-0xbb=
0fffff]: failed to add 300000
> [  569.393481] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: c=
an't assign; no space
> [  569.393487] pcieport 10001:80:02.0: bridge window [io  size 0x1000]: f=
ailed to assign
> [  569.393495] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  569.393529] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  569.393536] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  569.393543] pci 10001:81:00.0: BAR 0 [mem 0xbb000000-0xbb007fff 64bit]=
: assigned
> [  569.393576] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: c=
an't assign; no space
> [  569.393582] pci 10001:81:00.0: VF BAR 0 [mem size 0x00200000 64bit]: f=
ailed to assign
> [  569.393588] pcieport 10001:80:02.0: PCI bridge to [bus 81]
> [  569.393597] pcieport 10001:80:02.0:   bridge window [mem 0xbb000000-0x=
bb0fffff]
> [  569.393606] pcieport 10001:80:02.0:   bridge window [mem 0xbbd00000-0x=
bbefffff 64bit pref]
> [  569.394076] nvme nvme1: pci function 10001:81:00.0
> [  569.394095] nvme 10001:81:00.0: enabling device (0000 -> 0002)
> [  569.394109] pcieport 10001:80:02.0: can't derive routing for PCI INT A
> [  569.394116] nvme 10001:81:00.0: PCI INT A: no GSI
> [  570.158994] nvme nvme1: D3 entry latency set to 10 seconds
> [  570.239267] nvme nvme1: 127/0/0 default/read/poll queues
> [  570.287896] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  570.287911] =3D=3D=3D=3D pciehp_ist 703 start running
> [  570.287918] =3D=3D=3D=3D pciehp_ist 759 stop running
> [  570.288953]  nvme1n1: p1 p2 p3 p4 p5 p6 p7
>=20
> -------------------------------dmesg log---------------------------------=
--------
>=20
> >From the log above, it can be seen that I added some debugging codes in =
the kernel.=20
> The specific modifications are as follows:
>=20
> -------------------------------diff file---------------------------------=
--------
>=20
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index bb5a8d9f03ad..c9f3ed86a084 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -700,6 +700,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  =09irqreturn_t ret;
>  =09u32 events;
> =20
> +=09printk("=3D=3D=3D=3D %s %d start running\n", __func__, __LINE__);
>  =09ctrl->ist_running =3D true;
>  =09pci_config_pm_runtime_get(pdev);
> =20
> @@ -755,6 +756,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  =09pci_config_pm_runtime_put(pdev);
>  =09ctrl->ist_running =3D false;
>  =09wake_up(&ctrl->requester);
> +=09printk("=3D=3D=3D=3D %s %d stop running\n", __func__, __LINE__);
>  =09return ret;
>  }
> =20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 661f98c6c63a..ffa58f389456 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4784,6 +4784,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev=
 *pdev, bool active,
>  =09if (active)
>  =09=09msleep(20);
>  =09rc =3D pcie_wait_for_link_status(pdev, false, active);
> +=09printk("=3D=3D=3D=3D=3D=3D%s %d,wait for linksta:%d\n", __func__, __L=
INE__, rc);
>  =09if (active) {
>  =09=09if (rc)
>  =09=09=09rc =3D pcie_failed_link_retrain(pdev);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..b7e5af859517 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -337,12 +337,13 @@ void pci_bus_put(struct pci_bus *bus);
> =20
>  #define PCIE_LNKCAP_SLS2SPEED(lnkcap)=09=09=09=09=09\
>  ({=09=09=09=09=09=09=09=09=09\
> -=09((lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :=09\
> -=09 (lnkcap) =3D=3D PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :=09\
> +=09u32 __lnkcap =3D (lnkcap) & PCI_EXP_LNKCAP_SLS;=09=09\
> +=09(__lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :=09\
> +=09 __lnkcap =3D=3D PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :=09\
>  =09 PCI_SPEED_UNKNOWN);=09=09=09=09=09=09\
>  })
> =20
> @@ -357,13 +358,16 @@ void pci_bus_put(struct pci_bus *bus);
>  =09 PCI_SPEED_UNKNOWN)
> =20
>  #define PCIE_LNKCTL2_TLS2SPEED(lnkctl2) \
> -=09((lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
> -=09 (lnkctl2) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
> -=09 PCI_SPEED_UNKNOWN)
> +({=09=09=09=09=09=09=09=09=09\
> +=09u16 __lnkctl2 =3D (lnkctl2) & PCI_EXP_LNKCTL2_TLS;=09\
> +=09(__lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_5_0GT ? PCIE_SPEED_5_0GT : \
> +=09 __lnkctl2 =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
> +=09 PCI_SPEED_UNKNOWN);=09=09=09=09=09=09\
> +})
> =20
>  /* PCIe speed to Mb/s reduced by encoding overhead */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index b59cacc740fa..a8ce09f67d3b 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -168,8 +168,10 @@ int pcie_set_target_speed(struct pci_dev *port, enum=
 pci_bus_speed speed_req,
>  =09if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
>  =09=09return -EINVAL;
> =20
> -=09if (bus && bus->cur_bus_speed =3D=3D speed_req)
> +=09if (bus && bus->cur_bus_speed =3D=3D speed_req) {
> +=09=09printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %s %d, speed has been set\n=
", __func__, __LINE__);
>  =09=09return 0;
> +=09}
> =20
>  =09target_speed =3D pcie_bwctrl_select_speed(port, speed_req);
> =20
> @@ -184,6 +186,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum =
pci_bus_speed speed_req,
>  =09=09=09mutex_lock(&data->set_speed_mutex);
> =20
>  =09=09ret =3D pcie_bwctrl_change_speed(port, target_speed, use_lt);
> +=09=09printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %s %d, bwctl change speed r=
et:0x%x\n", __func__, __LINE__,ret);
> =20
>  =09=09if (data)
>  =09=09=09mutex_unlock(&data->set_speed_mutex);
> @@ -209,8 +212,10 @@ static void pcie_bwnotif_enable(struct pcie_device *=
srv)
> =20
>  =09/* Count LBMS seen so far as one */
>  =09ret =3D pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status)=
;
> -=09if (ret =3D=3D PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBM=
S)
> +=09if (ret =3D=3D PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBM=
S) {
> +=09=09printk("=3D=3D=3D=3D %s %d lbms_count++\n", __func__, __LINE__);
>  =09=09atomic_inc(&data->lbms_count);
> +=09}
> =20
>  =09pcie_capability_set_word(port, PCI_EXP_LNKCTL,
>  =09=09=09=09 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> @@ -239,6 +244,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *co=
ntext)
>  =09int ret;
> =20
>  =09ret =3D pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status)=
;
> +=09printk("=3D=3D=3D=3D %s %d(start running),link_status:0x%x\n", __func=
__, __LINE__,link_status);
>  =09if (ret !=3D PCIBIOS_SUCCESSFUL)
>  =09=09return IRQ_NONE;
> =20
> @@ -246,8 +252,10 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *c=
ontext)
>  =09if (!events)
>  =09=09return IRQ_NONE;
> =20
> -=09if (events & PCI_EXP_LNKSTA_LBMS)
> +=09if (events & PCI_EXP_LNKSTA_LBMS) {
> +=09=09printk("=3D=3D=3D=3D %s %d lbms_count++\n", __func__, __LINE__);
>  =09=09atomic_inc(&data->lbms_count);
> +=09}
> =20
>  =09pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> =20
> @@ -258,6 +266,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *co=
ntext)
>  =09 * cleared to avoid missing link speed changes.
>  =09 */
>  =09pcie_update_link_speed(port->subordinate);
> +=09printk("=3D=3D=3D=3D %s %d(stop running),link_status:0x%x\n", __func_=
_, __LINE__,link_status);
> =20
>  =09return IRQ_HANDLED;
>  }
> @@ -268,8 +277,10 @@ void pcie_reset_lbms_count(struct pci_dev *port)
> =20
>  =09guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
>  =09data =3D port->link_bwctrl;
> -=09if (data)
> +=09if (data) {
> +=09=09printk("=3D=3D=3D=3D %s %d lbms_count set to 0\n", __func__, __LIN=
E__);
>  =09=09atomic_set(&data->lbms_count, 0);
> +=09}
>  =09else
>  =09=09pcie_capability_write_word(port, PCI_EXP_LNKSTA,
>  =09=09=09=09=09   PCI_EXP_LNKSTA_LBMS);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..a602f9aa5d6a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -41,8 +41,11 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 ln=
ksta)
>  =09int ret;
> =20
>  =09ret =3D pcie_lbms_count(dev, &count);
> -=09if (ret < 0)
> +=09if (ret < 0) {
> +=09=09printk("=3D=3D=3D=3D %s %d lnksta(0x%x) & LBMS\n", __func__, __LIN=
E__, lnksta);
>  =09=09return lnksta & PCI_EXP_LNKSTA_LBMS;
> +=09}
> +=09printk("=3D=3D=3D=3D %s %d count:0x%lx\n", __func__, __LINE__, count)=
;
> =20
>  =09return count > 0;
>  }
> @@ -110,6 +113,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> =20
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +=09pci_info(dev, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %s %d, lnkctl2:0x=
%x, lnksta:0x%x\n",
> +=09=09=09__func__, __LINE__, lnkctl2, lnksta);
>  =09if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) =
{
>  =09=09u16 oldlnkctl2 =3D lnkctl2;
> =20
> @@ -121,9 +126,14 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  =09=09=09pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
>  =09=09=09=09=09      true);
>  =09=09=09return ret;
> +=09=09} else {
> +=09=09=09 pci_info(dev, "retraining sucessfully, but now is in Gen 1\n")=
;
>  =09=09}
> =20
> +=09=09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  =09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +=09=09pci_info(dev, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D %s %d, oldlnkc=
tl2:0x%x,newlnkctl2:0x%x,newlnksta:0x%x\n",
> +=09=09=09=09__func__, __LINE__, oldlnkctl2, lnkctl2, lnksta);
>  =09}
> =20
>  =09if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
>=20
> -------------------------------diff file---------------------------------=
--------
>=20
> Based on the information in the log from 566.755596 to 567.801220, the is=
sue
> has been reproduced. Between 566 and 567 seconds, the pcie_bwnotif_irq in=
terrupt
> was triggered 4 times, this indicates that during this period, the NVMe d=
rive=20
> was plugged and unplugged multiple times.
>=20
> Thanks,
> Regards,
> Jiwei
>=20
> > didn't explain LBMS (nor DLLLA) in the above sequence so it's hard to=
=20
> > follow what is going on here. LBMS in particular is of high interest he=
re=20
> > because I'm trying to understand if something should clear it on the=20
> > hotplug side (there's already one call to clear it in remove_board()).
> >=20
> > In step 2 (pcie_set_target_speed() in step 1 succeeded),=20
> > pcie_failed_link_retrain() attempts to restore >2.5GT/s speed, this onl=
y=20
> > occurs when pci_match_id() matches. I guess you're trying to say that s=
tep=20
> > 2 is not taken because pci_match_id() is not matching but the wording=
=20
> > above is very confusing.
> >=20
> > Overall, I failed to understand the scenario here fully despite trying =
to=20
> > think it through over these few days.
> >=20
> >> =09=09=09=09=09=09  the target link speed
> >> =09=09=09=09=09=09  field of the Link Control
> >> =09=09=09=09=09=09  2 Register will keep 0x1.
> >>
> >> In order to fix the issue, don't do the retraining work except ASMedia
> >> ASM2824.
> >>
> >> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> >> Reported-by: Adrian Huang <ahuang12@lenovo.com>
> >> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> >> ---
> >>  drivers/pci/quirks.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 605628c810a5..ff04ebd9ae16 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -104,6 +104,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> >>  =09u16 lnksta, lnkctl2;
> >>  =09int ret =3D -ENOTTY;
> >> =20
> >> +=09if (!pci_match_id(ids, dev))
> >> +=09=09return 0;
> >> +
> >>  =09if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
> >>  =09    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> >>  =09=09return ret;
> >> @@ -129,8 +132,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> >>  =09}
> >> =20
> >>  =09if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> >> -=09    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5=
GT &&
> >> -=09    pci_match_id(ids, dev)) {
> >> +=09    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5=
GT) {
> >>  =09=09u32 lnkcap;
> >> =20
> >>  =09=09pci_info(dev, "removing 2.5GT/s downstream link speed restricti=
on\n");
> >>
> >=20
>=20
--8323328-1690480513-1736879042=:1077--

