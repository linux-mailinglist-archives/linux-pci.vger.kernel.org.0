Return-Path: <linux-pci+bounces-10493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB5493492D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23DAB20F0A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 07:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9155886;
	Thu, 18 Jul 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frQSO0db"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C01C36;
	Thu, 18 Jul 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288854; cv=none; b=GW9aAZk0Czvr59obYy9ZPFBn4LdSYq6i6d5EyT3BhMLibx4GpEM+SXw5QRpAEvL/yQSTzN1vwwj/sMoyjeVC9cS3xSpB0lxD1aFszpR7EMJDY/j8zr27PjZtSdRu9m/JvwNK0QbhwVe6ENW1TcSYFj1SV26sk7u37QfI+8yi1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288854; c=relaxed/simple;
	bh=Ifd3ZyZiWcGSeHHusth+UilGRRT83bnliaZFUc5lL5s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RCn2NE4QvOg6EnkjvMkSsoVz9TI9YbfccJbgnECeN54IiaX0DWDFn4wsjIQBajdoG1+8dlpJr3/uQjEIGICq1Vk2MYgYa64mtAB58wI0k2B95pLO29t9Hts5UTSgLe6qJcDupQEGePI3RGVj90yK10CAa/0EMgp5+dqXb/btDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frQSO0db; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721288853; x=1752824853;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ifd3ZyZiWcGSeHHusth+UilGRRT83bnliaZFUc5lL5s=;
  b=frQSO0dbi4PcnZH6czEi+rIienkT5No/kB0IHOFEa6jrTFJ79STANyRx
   tWxPXxnAF2JreROuq4/HFZjzwrghAAXE5sKKYYK678SOKm3SJBPA27DLh
   DIO20KPejOHlqVKenBR5ngZuoIcbGjDlHimpjnSk+0VZ8/sK/YzGeRDN3
   1zI673zIXRYGmXzb+InoSPQ9e+FrMePhEVey8vzkkR7jR0XU5XEAI+l6M
   V6uyxTnXz4oo3OilOymljaDdYCUjc7rkwRri6JwAjXsN3XAgoXshJJvFZ
   4XP7YhPUBrueizSHP23vyy7aOWkLeQxhgCa69fjviTx3XMNCO1rBiSc1t
   Q==;
X-CSE-ConnectionGUID: B7b0SZ7qTb+QlLtl7SIzPg==
X-CSE-MsgGUID: 7hdq7lglQUOXfNaOcaIqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="21739157"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="21739157"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 00:47:32 -0700
X-CSE-ConnectionGUID: S6P2ceP9RimzKllZ/qPsXA==
X-CSE-MsgGUID: REKv0HNkT9eWoi+65bXpjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="51288364"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.139])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 00:47:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Jul 2024 10:47:24 +0300 (EEST)
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>, 
    Hagan Billy <billy.hagan@amd.com>, Simon Guinot <simon.guinot@seagate.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
In-Reply-To: <ca2b8c13-a7d8-e157-fd1a-770ee8cb10c1@amd.com>
Message-ID: <1a252080-2076-5840-5add-7b584188d025@linux.intel.com>
References: <20240617231841.GA1232294@bhelgaas> <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com> <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com> <ZnKNJxJwdtWRphgX@wunner.de> <73fd7b2d-9256-9eba-70be-d69ea336fd67@amd.com> <6014882f-0936-ec31-d641-112a70eb2749@linux.intel.com>
 <ca2b8c13-a7d8-e157-fd1a-770ee8cb10c1@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1535258471-1721288844=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1535258471-1721288844=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Jul 2024, Smita Koralahalli wrote:

> On 7/9/2024 3:52 AM, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 25 Jun 2024, Smita Koralahalli wrote:
> >=20
> > > Sorry for the delay here. Took some time to find a system to run
> > > experiments.
> > > Comments inline.
> > >=20
> > > On 6/19/2024 12:47 AM, Lukas Wunner wrote:
> > > > On Tue, Jun 18, 2024 at 02:23:21PM -0700, Smita Koralahalli wrote:
> > > > > On 6/18/2024 11:51 AM, Smita Koralahalli wrote:
> > > > > > > > > But IIUC LBMS is set by hardware but never cleared by
> > > > > > > > > hardware, so
> > > > > > > > > if
> > > > > > > > > we remove a device and power off the slot, it doesn't see=
m
> > > > > > > > > like
> > > > > > > > > LBMS
> > > > > > > > > could be telling us anything useful (what could we do in
> > > > > > > > > response
> > > > > > > > > to
> > > > > > > > > LBMS when the slot is empty?), so it makes sense to me to
> > > > > > > > > clear
> > > > > > > > > it.
> > > > > > > > >=20
> > > > > > > > > It seems like pciehp_unconfigure_device() does sort of PC=
I
> > > > > > > > > core
> > > > > > > > > and
> > > > > > > > > driver-related things and possibly could be something sha=
red
> > > > > > > > > by
> > > > > > > > > all
> > > > > > > > > hotplug drivers, while remove_board() does things more
> > > > > > > > > specific to
> > > > > > > > > the
> > > > > > > > > hotplug model (pciehp, shpchp, etc).
> > > > > > > > >=20
> > > > > > > > >   From that perspective, clearing LBMS might fit better i=
n
> > > > > > > > > remove_board(). In that case, I wonder whether it should =
be
> > > > > > > > > done
> > > > > > > > > after turning off slot power? This patch clears is *befor=
e*
> > > > > > > > > turning
> > > > > > > > > off the power, so I wonder if hardware could possibly set=
 it
> > > > > > > > > again
> > > > > > > > > before the poweroff?
> > > > >=20
> > > > > While clearing LBMS in remove_board() here:
> > > > >=20
> > > > > if (POWER_CTRL(ctrl)) {
> > > > > =09pciehp_power_off_slot(ctrl);
> > > > > +=09pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> > > > > =09=09=09=09   PCI_EXP_LNKSTA_LBMS);
> > > > >=20
> > > > > =09/*
> > > > > =09 * After turning power off, we must wait for at least 1 second
> > > > > =09 * before taking any action that relies on power having been
> > > > > =09 * removed from the slot/adapter.
> > > > > =09 */
> > > > > =09msleep(1000);
> > > > >=20
> > > > > =09/* Ignore link or presence changes caused by power off */
> > > > > =09atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> > > > > =09=09   &ctrl->pending_events);
> > > > > }
> > > > >=20
> > > > > This can happen too right? I.e Just after the slot poweroff and b=
efore
> > > > > LBMS
> > > > > clearing the PDC/PDSC could be fired. Then
> > > > > pciehp_handle_presence_or_link_change() would hit case "OFF_STATE=
" and
> > > > > proceed with pciehp_enable_slot() ....pcie_failed_link_retrain() =
and
> > > > > ultimately link speed drops..
> > > > >=20
> > > > > So, I added clearing just before turning off the slot.. Let me kn=
ow if
> > > > > I'm
> > > > > thinking it right.
> > >=20
> > > I guess I should have experimented before putting this comment out.
> > >=20
> > > After talking to the HW/FW teams, I understood that, none of our CRBs
> > > support
> > > power controller for NVMe devices, which means the "Power Controller
> > > Present"
> > > in Slot_Cap is always false. That's what makes it a "surprise removal=
=2E" If
> > > the
> > > OS was notified beforehand and there was a power controller attached,=
 the
> > > OS
> > > would turn off the power with SLOT_CNTL. That's an "orderly" removal.=
 So
> > > essentially, the entire block from "if (POWER_CTRL(ctrl))" will never=
 be
> > > executed for surprise removal for us.
> > >=20
> > > There could be board designs outside of us, with power controllers fo=
r the
> > > NVME devices, which I'm not aware of.
> > > >=20
> > > > This was added by 3943af9d01e9 ("PCI: pciehp: Ignore Link State Cha=
nges
> > > > after powering off a slot").  You can try reproducing it by writing=
 "0"
> > > > to the slot's "power" file in sysfs, but your hardware needs to sup=
port
> > > > slot power.
> > > >=20
> > > > Basically the idea is that after waiting for 1 sec, chances are ver=
y low
> > > > that any DLLSC or PDSC events caused by removing slot power may sti=
ll
> > > > occur.
> > >=20
> > > PDSC events occurring in our case aren't by removing slot power. It
> > > should/will always happen on a surprise removal along with DLLSC for =
us.
> > > But
> > > this PDSC is been delayed and happens after DLLSC is invoked and
> > > ctrl->state =3D
> > > OFF_STATE in pciehp_disable_slot(). So the PDSC is mistook to enable =
slot
> > > in
> > > pciehp_enable_slot() inside pciehp_handle_presence_or_link_change().
> > > >=20
> > > > Arguably the same applies to LBMS changes, so I'd recommend to like=
wise
> > > > clear stale LBMS after the msleep(1000).
> > > >=20
> > > > pciehp_ctrl.c only contains the state machine and higher-level logi=
c of
> > > > the hotplug controller and all the actual register accesses are in
> > > > helpers
> > > > in pciehp_hpc.c.  So if you want to do it picture-perfectly, add a
> > > > helper
> > > > in pciehp_hpc.c to clear LBMS and call that from remove_board().
> > > >=20
> > > > That all being said, I'm wondering how this plays together with Ilp=
o's
> > > > bandwidth control driver?
> > > >=20
> > > > https://lore.kernel.org/all/20240516093222.1684-1-ilpo.jarvinen@lin=
ux.intel.com/
> > >=20
> > > I need to yet do a thorough reading of Ilpo's bandwidth control drive=
r.
> > > Ilpo
> > > please correct me if I misspeak something as I don't have a thorough
> > > understanding.
> > >=20
> > > Ilpo's bandwidth controller also checks for lbms count to be greater =
than
> > > zero
> > > to bring down link speeds if CONFIG_PCIE_BWCTRL is true. If false, it
> > > follows
> > > the default path to check LBMS bit in link status register. So if,
> > > CONFIG_PCIE_BWCTRL is disabled by default we continue to see link spe=
ed
> > > drops.
> > > Even, if BWCTRL is enabled, LBMS count is incremented to 1 in
> > > pcie_bwnotif_enable() so likely pcie_lbms_seen() might return true th=
ereby
> > > bringing down speeds here as well if DLLLA is clear?
> >=20
> > I did add code to clear the LBMS count in pciehp_unconfigure_device() i=
n
> > part thanks to this patch of yours. Do you think it wouldn't work?
>=20
> It works with BWCTRL enabled. Just my concern would be to keep the cleari=
ng in
> pciehp_unconfigure_device() and not do it inside POWER_CTRL(ctrl), in
> remove_board() as per the suggestions given above.

I added that LBMS count reset based on one of the first versions of your=20
patch which had the LBMS clearing in pciehp_unconfigure_device() before=20
this discussion went further. The point anyway is that bwctrl change would=
=20
replace the line you put in to clear LBMS, wherever that will be placed=20
in the end.

> > But I agree there would still be problem if BWCTRL is not enabled. I
> > already have to keep part of it enabled due to the Target Speed quirk
> > and now this is another case where just having it always on would be
> > beneficial.
>=20
> Correct, it should always be on to not see the problem.
>
> Would like to have this "LBMS clearing fix" accepted in sooner since its
> breaking things on our systems! :)

Sure, I've no objection to that. In fact, it's what I prefer myself too=20
because it makes things easier for stable folks. :-)

I'd also like to see those Target Speed quick fixes to go in before
bwctl (to the extent I did base my series on top of them) but it seems=20
Maciej might not be updating them so perhaps I'll have to take look at=20
Bjorn's comments on that series and see what can be done to those patches.

--=20
 i.

--8323328-1535258471-1721288844=:1055--

