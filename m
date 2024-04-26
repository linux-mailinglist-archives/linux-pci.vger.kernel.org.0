Return-Path: <linux-pci+bounces-6688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7C8B3324
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FBB28683B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588343ACD;
	Fri, 26 Apr 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXe6VZZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0D3D57D;
	Fri, 26 Apr 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120954; cv=none; b=krrq2PZORevndMvfDmqwAH/WB8YM7cLoji1Fj2+BJTgPObnDcd2MQaOiOomt6n7qwiT4b6NVZD48twT6O2CWRjq3E9P6qJvgvLJZ+0iYaxnXUqKSefkIhhuvGy0qQPbAmFvnpVySamK5qztYRqqDZrsiQ4vqR4plBZt/uCCT8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120954; c=relaxed/simple;
	bh=w0uh5w7GTitfg6PmY2X3+PvccK3BLnO70DnZjCGubWs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MkEbPWexoajrOgOulTTEv5c0sud0oddi4SZNE5VOdUfn34QCh+SKi/tFW06Izawuis0wiCvI1iPsV4arz+4EkGpD1uXk09eTbdaHgZ9WYOuomka47ODOID9+dY3PU+b0uUtnzz2zgA8IUP8RnL1PHFmSy/c7m5FOamJUqr8nQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXe6VZZc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714120952; x=1745656952;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=w0uh5w7GTitfg6PmY2X3+PvccK3BLnO70DnZjCGubWs=;
  b=OXe6VZZcrowTF2vgJnBpM6mmwBL7TW8Kq2qWdqL75d7gaQ+TafrQszLt
   ROo2cx7qKgwSHCdoDoXa7rM+mm3fLBMEMLcKOcfBvjrL1KWUNxN39dgfy
   4tTAhQEBgvNWJNOYhx3WNBRIVG9bcjbX0LV62pt4ff/1fp/4xTwgCFrA6
   eqVQhOe7USp8g+Wnzo3v3pnmcWI3wrri35RXy37+uMu0hzXubkhxivHDd
   DnbqfPH5rvzJz/hwFgvui4gP3EzS76Uwle0irNGeewmStfNkKqSJDXS1W
   +07Gm2iJ0RQau2+ZSYdK1+jZkvnqceTl/d4uyE7tsT6nJ/NtdeTMPCqlr
   w==;
X-CSE-ConnectionGUID: AhqLBiBLSease/RhoYMNgA==
X-CSE-MsgGUID: kZUG0RqGR9izZUdSlQ0mmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10381197"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10381197"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 01:42:30 -0700
X-CSE-ConnectionGUID: 9qPrIU/CQPuE+mbnpjgbCQ==
X-CSE-MsgGUID: NRANCpWRTV26KgEmwm16yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="29805805"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 01:42:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 11:42:23 +0300 (EEST)
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <helgaas@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
    Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>, 
    Hagan Billy <billy.hagan@amd.com>, Simon Guinot <simon.guinot@seagate.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    jon.grimm@amd.com, pradeepvineshreddy.kodamati@amd.com
Subject: Re: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
In-Reply-To: <4852519a-c941-aa0c-2912-f6383c708ade@amd.com>
Message-ID: <38cfc6fa-ad39-86e6-3904-45f5fc937609@linux.intel.com>
References: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com> <52290bb0-97bc-aa52-6606-cc734a492cc1@linux.intel.com> <4852519a-c941-aa0c-2912-f6383c708ade@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-160196204-1714115264=:1049"
Content-ID: <1b7e0b79-7cbd-ceeb-f69d-b1f04aeb7631@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-160196204-1714115264=:1049
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <247a7619-7709-9080-fd6f-ec8e2357393e@linux.intel.com>

On Thu, 25 Apr 2024, Smita Koralahalli wrote:
> On 4/24/2024 2:32 AM, Ilpo J=E4rvinen wrote:
> > On Wed, 24 Apr 2024, Smita Koralahalli wrote:
> >=20
> > > Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove
> > > event.
> > >=20
> > > The hot-remove event could result in target link speed reduction if L=
BMS
> > > is set, due to a delay in Presence Detect State Change (PDSC) happeni=
ng
> > > after a Data Link Layer State Change event (DLLSC).
> > >=20
> > > In reality, PDSC and DLLSC events rarely come in simultaneously. Dela=
y in
> > > PDSC can sometimes be too late and the slot could have already been
> > > powered down just by a DLLSC event. And the delayed PDSC could falsel=
y be
> > > interpreted as an interrupt raised to turn the slot on. This false pr=
ocess
> > > of powering the slot on, without a link forces the kernel to retrain =
the
> > > link if LBMS is set, to a lower speed to restablish the link thereby
> > > bringing down the link speeds [2].
> > >=20
> > > According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cann=
ot
> > > be set for an unconnected link and if set, it serves the purpose of
> > > indicating that there is actually a device down an inactive link.
> > > However, hardware could have already set LBMS when the device was
> > > connected to the port i.e when the state was DL_Up or DL_Active. Some
> > > hardwares would have even attempted retrain going into recovery mode,
> > > just before transitioning to DL_Down.
> > >=20
> > > Thus the set LBMS is never cleared and might force software to cause =
link
> > > speed drops when there is no link [2].
> > >=20
> > > Dmesg before:
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> > > =09pcieport 0000:20:01.1: broken device, retraining non-functional
> > > downstream link at 2.5GT/s
> > > =09pcieport 0000:20:01.1: retraining failed
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): No link
> > >=20
> > > Dmesg after:
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): No link
> > >=20
> > > [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
> > >      https://members.pcisig.com/wg/PCI-SIG/document/20590
> > > [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failure=
s")
> > >=20
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.=
com>
> > > ---
> > > 1. Should be based on top of fixes for link retrain status in
> > > pcie_wait_for_link_delay()
> > > https://patchwork.kernel.org/project/linux-pci/list/?series=3D824858
> > > https://lore.kernel.org/linux-pci/53b2239b-4a23-a948-a422-4005cbf7614=
8@linux.intel.com/
> > >=20
> > > Without the fixes patch output would be:
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): Card present
> > > =09pcieport 0000:20:01.1: broken device, retraining non-functional
> > > downstream link at 2.5GT/s
> > > =09pcieport 0000:20:01.1: retraining failed
> > > =09pcieport 0000:20:01.1: pciehp: Slot(59): No device found.
> >=20
> > Did you hit the 60 sec delay issue without series 824858? If you've tes=
ted
> > them and the fixes helped your case, could you perhaps give Tested-by f=
or
> > that series too (in the relevant thread)?
>=20
> I'm assuming the 60s delay issue is from pci_dev_wait()?

Yes.
=20
> Correct me if I'm wrong.
> I think series 824858 potentially fixes the bug at two different places. =
What
> you are seeing is at suspend/resume operation called from the calls below=
=2E
>
> pci_pm_runtime_resume()
>     pci_pm_bridge_power_up_actions()
>       pci_bridge_wait_for_secondary_bus()
>         pcie_wait_for_link_delay()
>           pcie_failed_link_retrain()
>         pci_dev_wait()
>=20
> But series 824858 helped me in properly returning an error code from
> pcie_wait_for_link_delay() and also avoiding the 100ms delay inside
> pcie_wait_for_link_delay() and probably the timeout in
> pcie_wait_for_presence()..
>=20
> The sequence of operations which I'm looking at is after an PDSC event as
> below:
> pciehp_handle_presence_or_link_change()
>   pciehp_enable_slot()
>     __pciehp_enable_slot()
>       board_added()
>         pciehp_check_link_status()
>           pcie_wait_for_link()
>             pcie_wait_for_link_delay()
>               pcie_failed_link_retrain()
>=20
> pcie_failed_link_retrain() would initially return false on a "failed link
> retrain" attempt which would make pcie_wait_for_link_delay() and
> pcie_wait_for_link() to erroneously succeed thereby unnecessarily proceed=
ing
> with other checks in pciehp_check_link_status().
>=20
> Series 824858 fixes the bug by properly returning an error code.

Yes, that series also fixes other bugs too. I wasn't aware how the
incorrect return value impacted hotplug too.

> However, I had missed looking at your patchset when I initially wrote
> this. From the patch below I see you have addressed clearing LBMS as well=
 but
> at a different place. But I didn't understand why was it dropped.
>=20
> https://lore.kernel.org/all/20240129112710.2852-2-ilpo.jarvinen@linux.int=
el.com/

That change wasn't perfect solution given how the target speed quirk=20
works. Unconditional clearing might have broken the quirk so localizing=20
the LBMS clearing into the cases where the device is actually gone would=20
be the best approach.

For normal hotplug, it's relatively easy to clear LBMS as demonstrated by=
=20
your patch (I have consider putting it into somewhere in remove.c if the=20
device is in disconnected state while removing the function 0 but roughly=
=20
the same idea as in your patch).

The additional problem with suspend/resume cycle is that the device can=20
disappear while suspended and we only notice the disconnection after=20
hotplug has resumed. This occurs only after full portdrv resume because it=
=20
requires interrupt which is too late to avoid the 60secs delay. Series=20
824858 avoids the 60secs delay even for suspend/resume but if LBMS could=20
be cleared in time, it would help things further because the quirk=20
wouldn't even trigger, or at minimum, the wait delays could be=20
short-circuited if device disconnection is noticed while the wait is in=20
progress.

> From what I understood while experimenting is, tracking the set/unset beh=
avior
> of LBMS is hard, as HW has the right to attempt retrain at any point exce=
pt
> when the status is DL_Down as per the statement from the the SPEC: "This =
bit
> is Set by hardware to indicate that either of the following has occurred
> without the Port transitioning through DL_Down status".

It's actually not that hard. On medium term, I'm trying to get PCIe BW=20
controller into kernel (about to send a new version of it, probably next=20
week), which will keep clearing LBMS by enabling BW notifications that are=
=20
the SW/OS way to track LBMS assertions.

> The set LBMS when the port was not in DL_Down, is never unset after the P=
ort
> is transitioned to DL_Down. So, I think clearing it after the port status=
 is
> DL_Down (which I assume happens after DLLSC interrupt fires to bring the =
slot
> down) makes it remain cleared only until the port remains at DL_Down stat=
e. As
> soon as the port transitions to other states (I don't know how SW could t=
rack
> the states) there is no guarantee that the bit is still clear as HW might=
 have
> attempted retrain.
>=20
> The only way would be to track the DL_Down and Active/Up states. I at the
> moment don't know how to do it or if it is possible to do it in SW in the
> first place. Hence, I'm more inclined pushing [2] below as a fix  for lin=
k
> speed drop. However, that has some complexities as well :(
>=20
> After talking to HW folks one place where our HW sets LBMS is:
>=20
> Device is removed.
>   DL_Up doesn't immediately change.
>     HW will just see errors on the receiver and doesn't automatically
>     know that it was because of a hot remove, and tries to recover the
>     link.
>     LBMS gets set here as rate change is attempted.

That's interesting. I have earlier thought it's only set when the rate=20
change was actually successful but it seems that isn't even meant to be=20
the case here when I now reread the spec.

>     DL_Down occurs after this.
>=20
> Once DL_Down occurs nobody is supposed to set the bit. But the set bit is
> never cleared and is creating all issues.
>
> HW mostly considers other parameters and LTSSM behaviors in transitioning
> between Active/Up to Down states which I'm not sure at the moment how muc=
h of
> it is transparent to OS. :/
>
> > > @@ -134,4 +134,10 @@ void pciehp_unconfigure_device(struct controller
> > > *ctrl, bool presence)
> > >   =09}
> > >     =09pci_unlock_rescan_remove();
> > > +
> > > +=09/* Clear LBMS on removal */
> > > +=09pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA, &lnks=
ta);
> > > +=09if (lnksta & PCI_EXP_LNKSTA_LBMS)
> > > +=09=09pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> > > +=09=09=09=09=09   PCI_EXP_LNKSTA_LBMS);
> >=20
> > It's enough to unconditionally write PCI_EXP_LNKSTA_LBMS, no need to
> > check first. The comment is just spelling out what can already be read
> > from the code so I'd drop the comment.
>=20
> Sure, I will make changes once I send v2 and if we consider to address it=
 this
> way.. :)
>=20
> >=20
> > I agree it makes sense to clear the LBMS when device is removed.
>=20
> Thank you!

As I said, I think it's correct thing to do when we know the device is=20
gone and shouldn't interfere with the target speed quirk unlike my=20
clear-LBMS-on-resume attempt.

This won't help the disconnected while suspended case for now but it's=20
still a step into correct direction even for that.

--=20
 i.
--8323328-160196204-1714115264=:1049--

