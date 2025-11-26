Return-Path: <linux-pci+bounces-42124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF3C8A739
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D043B2802
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AE302CC3;
	Wed, 26 Nov 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+qYXmOU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E72F39BD
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168486; cv=none; b=Sjf75knCdzo+hHNTPQ1CheuXwTcxnnReKnKSXxPiW9I+r6rzhnXKpQ83Mr0zy1bWExRPlj0NTVXvOZfiWIudasNY5dAmxMt2rcnCOF2f/9HrTZZ3t2Y1EmliiODPztfoul8lgellj0PzzwG4KYplVOpyixhhGggBBvPzFg8UoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168486; c=relaxed/simple;
	bh=a/udGsCVw0R/JH2wx+wRSrfH4Gy2IXoLrpmEvkUIQFA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ktoT71COdAl0DEBqaS4ps8/3B/dG+kOBJ6B7pwgnq+4jU6Ovl+xrYhPP04ODNNgdWNFMOA736sp+Z7oJ/mw3V+qwseEC+48Uo0958xweyEXZdHpCSHuIHytD1glS3qAQdyopF2z9c/ZUELdALa6xc6P8YGNzrlh5EfqpwGiFl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+qYXmOU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764168484; x=1795704484;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=a/udGsCVw0R/JH2wx+wRSrfH4Gy2IXoLrpmEvkUIQFA=;
  b=R+qYXmOU2EhQh1jA4gbDJLRq9Og1nDdVlFeZLUB4ZTuLai1QhPMdty15
   uXUMIAh1EGoAGhmddVi8Bj39f7oOXWR3U2wFIs80RGfzNKVYPTnMTdGzo
   ta/3GmFXDh6rmgq/G31cIXTBDVf39kUknU3BQjdSiBEbqc9VMAiPC/ChD
   zRc6pKufDFyNKUxVkYtD/sAW1wfBBLK9t61IbTipn5ckYmdtXWo33JWlQ
   BXem1VC6Jh5l1636drdGwC5YPgB4xvkSP/F+so69qtMoNV5TEzpMElvTl
   Qyt130nKPSqJED5S8/xJ6Q6vunIJ52gycu1b7mZED1+SEKGvykAEepVz6
   w==;
X-CSE-ConnectionGUID: 9/TpnvRNQli1ix+WeTwhEg==
X-CSE-MsgGUID: 9+OAknzFSLe/4TnM/5/h+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77571883"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="77571883"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 06:48:04 -0800
X-CSE-ConnectionGUID: KYQrYK9VS0C0GxYX8ZhYSw==
X-CSE-MsgGUID: rB6iLHYvRimL49ZfjC6h/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="230218545"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 06:48:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Nov 2025 16:47:56 +0200 (EET)
To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
cc: bhelgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>, 
    kanie <kanie@linux.alibaba.com>, 
    alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <6b654498-f43f-4772-aad8-d84798d25107.guanghuifeng@linux.alibaba.com>
Message-ID: <2e3a1e6b-40ae-3878-e237-fb9032796af8@linux.intel.com>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>,<bcc2c523-ed9e-59a7-d6f1-b39f4b2e8e30@linux.intel.com> <aad7547b-5486-45af-88fe-8697fa288299.guanghuifeng@linux.alibaba.com>,<4f982c78-05ab-5e54-cead-a6d876f14ac0@linux.intel.com>
 <6b654498-f43f-4772-aad8-d84798d25107.guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-49606816-1764167763=:968"
Content-ID: <b230e0ed-4f4c-2dfd-84a5-e0bba070ee19@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-49606816-1764167763=:968
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dbe6c9cb-86f5-d570-77b2-c2f02b60a2de@linux.intel.com>

On Wed, 26 Nov 2025, guanghui.fgh wrote:

> Refer to the previous email discussion replies=EF=BC=9A
>=20
> 1. When a multifunction device is connected to a PCIe slot that supports =
hotplug,=20
>    during the passthrogh device to guest process based on VFIO, some devi=
ces
>    need to perform a hot reset to initialize the device:
>    vfio_pci_dev_set_hot_reset ---> __pci_reset_slot/__pci_reset_bus --->
>    pci_bridge_secondary_bus_reset ---> pci_bridge_wait_for_secondary_bus.
>
>    After __pci_reset_slot/__pci_reset_bus calls pci_bridge_wait_for_secon=
dary_bus,
>    the device will be restored via pci_dev_restore.=20

=2E..and then they call to pci_slot_restore_locked()/pci_bus_restore_locked=
()=20
that do recursively wait + restore config spaces since the commit=20
3e40aa29d47e ("PCI: Wait for Link before restoring Downstream Buses").

>    However, when a       =3D=3D=3D=3D=3D=3D      multifunction PCIe devic=
e      =3D=3D=3D=3D=3D=3D=3D=3D=3D
>    is connected, executing pci_bridge_wait_for_secondary_bus only guarant=
ees the restoration
>    of a random device. For other devices that are still restoring, execut=
ing pci_dev_restore cannot
>    restore the device state normally, resulting in errors or even device =
offline.

Addressing this doesn't require recursion AFAICT.

> 2. In the PCIe dpc_handler process, do pcie_do_recovery(pdev, pci_channel=
_io_frozen, dpc_reset_link)
>    to restores the PCIe link.=20
>    But dpc_reset_link waits for the link to recover via pci_bridge_wait_f=
or_secondary_bus before returning.
>    Similarly, pcie_do_recovery restores devices via pci_walk_bridge(bridg=
e, report_resume, &status),
>
>    =3D=3D=3D=3D=3D=3D      which also requires pci_bridge_wait_for_second=
ary_bus to wait for all devices to recover completely.
>    For other devices that are still restoring, executing report_resume ca=
nnot restore the device state normally,
>    resulting in errors or even device offline.

This might lack wait for subordinate buses and ordering with restore, but=
=20
I don't think the right place to add that is=20
pci_bridge_wait_for_secondary_bus() that is used by others.

> 3. The PCIe specification only constrains the minimum wait time under dif=
ferent resets. In the historical kernel implementation,
>    SBR wait also did not need to restore the PCIe device configuration sp=
ace before waiting for the coordinate.



I'm not saying there isn't anything to fix/change but I'm not convinced by=
=20
the approach taken by your patch.

--
 i.

> ------------------------------------------------------------------
> On Wed, 26 Nov 2025, guanghui.fgh wrote:
>=20
> > 1. Does this add recursion without restoring config space on each level=
=20
> > before starting the child wait?
> >=20
> > Yes
> > The current implementation does not require restoring the PCIe device=
=20
> > configuration space. The status is determined during the waiting=20
> > process, either based on software-recorded status or on the device's RO=
=20
> > and HWINIT type registers.
>=20
> What guarantees a link even come up without restoring the config space
> first (it may work in your case but is that true universally)?
>=20
> The commit 3e40aa29d47e ("PCI: Wait for Link before restoring Downstream=
=20
> Buses") tried to address this sub-hierarchy wait issue within the=20
> recursive bus restore (without me ever encountering this problem for=20
> real). So I don't understand why you had to add the recursion to the wait=
=20
> side as well?
>=20
> --=20
>  i.
>=20
> > > When executing a PCIe secondary bus reset, all downstream switches an=
d
> > > endpoints will generate reset events. Simultaneously, all PCIe links
> > > will undergo retraining, and each link will independently re-execute =
the
> > > LTSSM state machine training. Therefore, after executing the SBR, it =
is
> > > necessary to wait for all downstream links and devices to complete
> > > recovery. Otherwise, after the SBR returns, accessing devices with so=
me
> > > links or endpoints not yet fully recovered may result in driver error=
s,
> > > or even trigger device offline issues.
> > >=20
> > > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > > ---
> > >=C2=A0 drivers/pci/pci.c | 112 ++++++++++++++++++++++++++++++++++++++-=
-------
> > >=C2=A0 1 file changed, 94 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b14dd064006c..9cf13fe69d94 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4788,9 +4788,74 @@ static int pci_bus_max_d3cold_delay(const stru=
ct pci_bus *bus)
> > > =C2=A0 return max(min_delay, max_delay);
> > >=C2=A0 }
> > >=C2=A0=20
> > > +int __pci_bridge_wait_for_secondary_bus(struct pci_dev *, unsigned l=
ong, char *);
> > > +
> > > +static int pci_dev_wait_child(struct pci_dev *pdev, unsigned long st=
art_t, int timeout,
> > > +=C2=A0 =C2=A0 char *reset_type)
> > > +{
> > > + struct pci_dev *child, **dev =3D NULL;
> > > + int ct =3D 0, i =3D 0, ret =3D 0, left =3D 1;
> > > + unsigned long dev_start_t;
> > > +
> > > + down_read(&pci_bus_sem);
> > > +
> > > + list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
> > > +=C2=A0 ct++;
> > > +
> > > + if (ct) {
> > > +=C2=A0 dev =3D kzalloc(sizeof(struct pci_dev *) * ct, GFP_KERNEL);
> > > +
> > > +=C2=A0 if(!dev) {
> > > + =C2=A0 pci_err(pdev, "dev mem alloc err\n");
> > > + =C2=A0 up_read(&pci_bus_sem);
> > > + =C2=A0 return -ENOMEM;
> > > +=C2=A0 }
> > > +
> > > +=C2=A0 list_for_each_entry(child, &pdev->subordinate->devices, bus_l=
ist)
> > > + =C2=A0 dev[i++] =3D pci_dev_get(child);
> > > + }
> > > +
> > > + up_read(&pci_bus_sem);
> > > +
> > > + for (i =3D 0; i < ct; ++i) {
> > > +=C2=A0 left =3D 1;
> > > +
> > > +dev_wait:
> > > +=C2=A0 dev_start_t =3D jiffies;
> > > +=C2=A0 ret =3D pci_dev_wait(dev[i], reset_type, left);
> > > +=C2=A0 timeout -=3D jiffies_to_msecs(jiffies - dev_start_t);
> > > +
> > > +=C2=A0 if (ret) {
> > > + =C2=A0 if (pci_dev_is_disconnected(dev[i]))
> > > +=C2=A0 =C2=A0 continue;
> > > +
> > > + =C2=A0 if (timeout <=3D 0)
> > > +=C2=A0 =C2=A0 goto end;
> > > +
> > > + =C2=A0 left <<=3D 1;
> > > + =C2=A0 left =3D timeout > left ? left : timeout;
> > > + =C2=A0 goto dev_wait;
> > > +=C2=A0 }
> > > + }
> > > +
> > > + for (i =3D 0; i < ct; ++i) {
> > > +=C2=A0 ret =3D __pci_bridge_wait_for_secondary_bus(dev[i], start_t, =
reset_type);
> >=20
> > Does this add recursion without restoring config space on each level=20
> > before starting the child wait?
> >=20
> > > +=C2=A0 if (ret)
> > > + =C2=A0 break;
> > > + }
> > > +
> > > +end:
> > > + for (i =3D 0; i < ct; ++i)
> > > +=C2=A0 pci_dev_put(dev[i]);
> > > +
> > > + kfree(dev);
> > > + return ret;
> > > +}
> > > +
> > >=C2=A0 /**
> > > - * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be =
accessible
> > > + * __pci_bridge_wait_for_secondary_bus - Wait for secondary bus to b=
e accessible
> > > =C2=A0 * @dev: PCI bridge
> > > + * @start_t: wait start jiffies time
> > > =C2=A0 * @reset_type: reset type in human-readable form
> > > =C2=A0 *
> > > =C2=A0 * Handle necessary delays before access to the devices on the =
secondary
> > > @@ -4804,10 +4869,9 @@ static int pci_bus_max_d3cold_delay(const stru=
ct pci_bus *bus)
> > > =C2=A0 * Return 0 on success or -ENOTTY if the first device on the se=
condary bus
> > > =C2=A0 * failed to become accessible.
> > > =C2=A0 */
> > > -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *res=
et_type)
> > > +int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, unsigne=
d long start_t, char *reset_type)
> > >=C2=A0 {
> > > - struct pci_dev *child __free(pci_dev_put) =3D NULL;
> > > - int delay;
> > > + int delay, left;
> > >=C2=A0=20
> > > =C2=A0 if (pci_dev_is_disconnected(dev))
> > >=C2=A0 =C2=A0 return 0;
> > > @@ -4835,8 +4899,6 @@ int pci_bridge_wait_for_secondary_bus(struct pc=
i_dev *dev, char *reset_type)
> > >=C2=A0 =C2=A0 return 0;
> > > =C2=A0 }
> > >=C2=A0=20
> > > - child =3D pci_dev_get(list_first_entry(&dev->subordinate->devices,
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev, bus_list));
> > > =C2=A0 up_read(&pci_bus_sem);
> > >=C2=A0=20
> > > =C2=A0 /*
> > > @@ -4844,8 +4906,12 @@ int pci_bridge_wait_for_secondary_bus(struct p=
ci_dev *dev, char *reset_type)
> > >=C2=A0 =C2=A0 * accessing the device after reset (that is 1000 ms + 10=
0 ms).
> > >=C2=A0 =C2=A0 */
> > > =C2=A0 if (!pci_is_pcie(dev)) {
> > > -=C2=A0 pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + dela=
y);
> > > -=C2=A0 msleep(1000 + delay);
> > > +=C2=A0 left =3D 1000 + delay - jiffies_to_msecs(jiffies - start_t);
> > > +=C2=A0 pci_dbg(dev, "waiting %d ms for secondary bus\n", left > 0 ? =
left : 0);
> > > +
> > > +=C2=A0 if (left > 0)
> > > + =C2=A0 msleep(left);
> > > +
> > >=C2=A0 =C2=A0 return 0;
> > > =C2=A0 }
> > >=C2=A0=20
> > > @@ -4870,10 +4936,14 @@ int pci_bridge_wait_for_secondary_bus(struct =
pci_dev *dev, char *reset_type)
> > > =C2=A0 if (pcie_get_speed_cap(dev) <=3D PCIE_SPEED_5_0GT) {
> > >=C2=A0 =C2=A0 u16 status;
> > >=C2=A0=20
> > > -=C2=A0 pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> > > -=C2=A0 msleep(delay);
> > > +=C2=A0 left =3D delay - jiffies_to_msecs(jiffies - start_t);
> > > +=C2=A0 pci_dbg(dev, "waiting %d ms for downstream link\n", left > 0 =
? left : 0);
> > > +
> > > +=C2=A0 if (left > 0)
> > > + =C2=A0 msleep(left);
> > >=C2=A0=20
> > > -=C2=A0 if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> > > +=C2=A0 left =3D PCI_RESET_WAIT - jiffies_to_msecs(jiffies - start_t)=
;
> > > +=C2=A0 if(!pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, res=
et_type))
> > > =C2=A0 =C2=A0 return 0;
> > >=C2=A0=20
> > >=C2=A0 =C2=A0 /*
> > > @@ -4888,20 +4958,26 @@ int pci_bridge_wait_for_secondary_bus(struct =
pci_dev *dev, char *reset_type)
> > >=C2=A0 =C2=A0 if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > =C2=A0 =C2=A0 return -ENOTTY;
> > >=C2=A0=20
> > > -=C2=A0 return pci_dev_wait(child, reset_type,
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIE_RESET_READY_POLL_MS - PCI_RESET_WAI=
T);
> > > +=C2=A0 left =3D PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies =
- start_t);
> > > +=C2=A0 return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, =
reset_type);
> > > =C2=A0 }
> > >=C2=A0=20
> > > - pci_dbg(dev, "waiting %d ms for downstream link, after activation\n=
",
> > > -=C2=A0 delay);
> > > - if (!pcie_wait_for_link_delay(dev, true, delay)) {
> > > + left =3D delay - jiffies_to_msecs(jiffies - start_t);
> > > + pci_dbg(dev, "waiting %d ms for downstream link, after activation\n=
", left > 0 ? left : 0);
> > > +
> > > + if (!pcie_wait_for_link_delay(dev, true, left > 0 ? left : 0)) {
> > >=C2=A0 =C2=A0 /* Did not train, no need to wait any further */
> > >=C2=A0 =C2=A0 pci_info(dev, "Data Link Layer Link Active not set in %d=
 msec\n", delay);
> > >=C2=A0 =C2=A0 return -ENOTTY;
> > > =C2=A0 }
> > >=C2=A0=20
> > > - return pci_dev_wait(child, reset_type,
> > > - =C2=A0 =C2=A0 =C2=A0 PCIE_RESET_READY_POLL_MS - delay);
> > > + left =3D PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - star=
t_t);
> > > + return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_=
type);
> > > +}
> > > +
> > > +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *res=
et_type)
> > > +{
> > > + return __pci_bridge_wait_for_secondary_bus(dev, jiffies, reset_type=
);
> > >=C2=A0 }
> > >=C2=A0=20
> > >=C2=A0 void pci_reset_secondary_bus(struct pci_dev *dev)
> > >=20
> >=20
> > --=20
> >=C2=A0 i.
> >=20
>=20

--=20
 i.
--8323328-49606816-1764167763=:968--

