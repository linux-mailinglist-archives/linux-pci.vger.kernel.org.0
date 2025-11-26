Return-Path: <linux-pci+bounces-42111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5ECC89CCA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138423B20A2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F22DD60E;
	Wed, 26 Nov 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYZqBc5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8652FFDF3
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160632; cv=none; b=rmeZaUkBQXey0eddsrMgld7ovi/c1pvqqkP/I1DfJCyjqm7Xmm2Vn/1Uc9nJzmPR8dMTzpvN5BwXfLuiEWI+aaPjFu3vUh/Pkd58kKOfx5w3ChhHrJwTCWfw5kD/cCtyduHuz2ZbTnhVIUDp6VwPgJ9s2Jc2oUcKNJX3pOR+Dao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160632; c=relaxed/simple;
	bh=NncvZ3DXIM6EPNOPuutaOoSMrLGzuL0Hu9EsP2urgmw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NR0iIvmsq7aSi4UzHBHmA93iJBy7fh9lxGBh3ywClByXfoXL1NnZgvqOLRkdKg/PgZMkpdS9xkBKHz6x4+RUhFHMlhkJnU2EtrE0I0VRLP94uE5XkJ/U3oWjiDA7JHFLUuaOHhGYVQ8Rw/rupGcW+8KO3tPdhqmhDGFYgXjcW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYZqBc5W; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764160630; x=1795696630;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=NncvZ3DXIM6EPNOPuutaOoSMrLGzuL0Hu9EsP2urgmw=;
  b=MYZqBc5WEHgNVEt45kv1FSXzQMHqMdJPklht3LPgrK9qUebLdoanEamw
   9e1faK29zWtNHZHMVhAWDa2bu+EiXnly6CF0Xse+odo6D1LmGSmpj3gii
   xKx5GhfKE+bM0OuFz+himwf7nlTEkWonigmvLdXOb7V6Cb3Mei8e8tqEG
   tb/uMwe/0cA6aMWapAuIsgaolktMJdK+DEH5HYLArEz1kHvfS47KSr6JU
   O2uZRAzrDcU1y/fVLUItEAr0yBznkqE42TdMEHJ8eRfrGyxWI41CL+KVC
   j4Isan4/ZngH1F4yBnEKz3ZBUpkRDkcs6otkqA3QBmksjMENAY3w7vtiL
   g==;
X-CSE-ConnectionGUID: zyshCA7ZTSGt6H7d5gBmAA==
X-CSE-MsgGUID: bjWjJuhpTqmthXhoAa9p4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76820472"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76820472"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:37:09 -0800
X-CSE-ConnectionGUID: NyjW48IqRbqaG9ucBQ9nKg==
X-CSE-MsgGUID: ZcuxRuD5S8ioQPC75jCTtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192070353"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 04:37:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Nov 2025 14:37:03 +0200 (EET)
To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
cc: bhelgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>, 
    kanie <kanie@linux.alibaba.com>, 
    alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
In-Reply-To: <aad7547b-5486-45af-88fe-8697fa288299.guanghuifeng@linux.alibaba.com>
Message-ID: <4f982c78-05ab-5e54-cead-a6d876f14ac0@linux.intel.com>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>,<bcc2c523-ed9e-59a7-d6f1-b39f4b2e8e30@linux.intel.com> <aad7547b-5486-45af-88fe-8697fa288299.guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-944046392-1764159513=:968"
Content-ID: <8ce15bea-3629-97dc-010e-cd4cce69a406@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-944046392-1764159513=:968
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <3cc137e9-45d5-c79f-138d-e296a1be462e@linux.intel.com>

On Wed, 26 Nov 2025, guanghui.fgh wrote:

> 1. Does this add recursion without restoring config space on each level=
=20
> before starting the child wait?
>=20
> Yes
> The current implementation does not require restoring the PCIe device=20
> configuration space. The status is determined during the waiting=20
> process, either based on software-recorded status or on the device's RO=
=20
> and HWINIT type registers.

What guarantees a link even come up without restoring the config space
first (it may work in your case but is that true universally)?

The commit 3e40aa29d47e ("PCI: Wait for Link before restoring Downstream=20
Buses") tried to address this sub-hierarchy wait issue within the=20
recursive bus restore (without me ever encountering this problem for=20
real). So I don't understand why you had to add the recursion to the wait=
=20
side as well?

--=20
 i.

> > When executing a PCIe secondary bus reset, all downstream switches and
> > endpoints will generate reset events. Simultaneously, all PCIe links
> > will undergo retraining, and each link will independently re-execute th=
e
> > LTSSM state machine training. Therefore, after executing the SBR, it is
> > necessary to wait for all downstream links and devices to complete
> > recovery. Otherwise, after the SBR returns, accessing devices with some
> > links or endpoints not yet fully recovered may result in driver errors,
> > or even trigger device offline issues.
> >=20
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > ---
> >=A0 drivers/pci/pci.c | 112 ++++++++++++++++++++++++++++++++++++++------=
--
> >=A0 1 file changed, 94 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd064006c..9cf13fe69d94 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4788,9 +4788,74 @@ static int pci_bus_max_d3cold_delay(const struct=
 pci_bus *bus)
> > =A0 return max(min_delay, max_delay);
> >=A0 }
> >=A0=20
> > +int __pci_bridge_wait_for_secondary_bus(struct pci_dev *, unsigned lon=
g, char *);
> > +
> > +static int pci_dev_wait_child(struct pci_dev *pdev, unsigned long star=
t_t, int timeout,
> > +=A0 =A0 char *reset_type)
> > +{
> > + struct pci_dev *child, **dev =3D NULL;
> > + int ct =3D 0, i =3D 0, ret =3D 0, left =3D 1;
> > + unsigned long dev_start_t;
> > +
> > + down_read(&pci_bus_sem);
> > +
> > + list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
> > +=A0 ct++;
> > +
> > + if (ct) {
> > +=A0 dev =3D kzalloc(sizeof(struct pci_dev *) * ct, GFP_KERNEL);
> > +
> > +=A0 if(!dev) {
> > + =A0 pci_err(pdev, "dev mem alloc err\n");
> > + =A0 up_read(&pci_bus_sem);
> > + =A0 return -ENOMEM;
> > +=A0 }
> > +
> > +=A0 list_for_each_entry(child, &pdev->subordinate->devices, bus_list)
> > + =A0 dev[i++] =3D pci_dev_get(child);
> > + }
> > +
> > + up_read(&pci_bus_sem);
> > +
> > + for (i =3D 0; i < ct; ++i) {
> > +=A0 left =3D 1;
> > +
> > +dev_wait:
> > +=A0 dev_start_t =3D jiffies;
> > +=A0 ret =3D pci_dev_wait(dev[i], reset_type, left);
> > +=A0 timeout -=3D jiffies_to_msecs(jiffies - dev_start_t);
> > +
> > +=A0 if (ret) {
> > + =A0 if (pci_dev_is_disconnected(dev[i]))
> > +=A0 =A0 continue;
> > +
> > + =A0 if (timeout <=3D 0)
> > +=A0 =A0 goto end;
> > +
> > + =A0 left <<=3D 1;
> > + =A0 left =3D timeout > left ? left : timeout;
> > + =A0 goto dev_wait;
> > +=A0 }
> > + }
> > +
> > + for (i =3D 0; i < ct; ++i) {
> > +=A0 ret =3D __pci_bridge_wait_for_secondary_bus(dev[i], start_t, reset=
_type);
>=20
> Does this add recursion without restoring config space on each level=20
> before starting the child wait?
>=20
> > +=A0 if (ret)
> > + =A0 break;
> > + }
> > +
> > +end:
> > + for (i =3D 0; i < ct; ++i)
> > +=A0 pci_dev_put(dev[i]);
> > +
> > + kfree(dev);
> > + return ret;
> > +}
> > +
> >=A0 /**
> > - * pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be ac=
cessible
> > + * __pci_bridge_wait_for_secondary_bus - Wait for secondary bus to be =
accessible
> > =A0 * @dev: PCI bridge
> > + * @start_t: wait start jiffies time
> > =A0 * @reset_type: reset type in human-readable form
> > =A0 *
> > =A0 * Handle necessary delays before access to the devices on the secon=
dary
> > @@ -4804,10 +4869,9 @@ static int pci_bus_max_d3cold_delay(const struct=
 pci_bus *bus)
> > =A0 * Return 0 on success or -ENOTTY if the first device on the seconda=
ry bus
> > =A0 * failed to become accessible.
> > =A0 */
> > -int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset=
_type)
> > +int __pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, unsigned =
long start_t, char *reset_type)
> >=A0 {
> > - struct pci_dev *child __free(pci_dev_put) =3D NULL;
> > - int delay;
> > + int delay, left;
> >=A0=20
> > =A0 if (pci_dev_is_disconnected(dev))
> >=A0 =A0 return 0;
> > @@ -4835,8 +4899,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_=
dev *dev, char *reset_type)
> >=A0 =A0 return 0;
> > =A0 }
> >=A0=20
> > - child =3D pci_dev_get(list_first_entry(&dev->subordinate->devices,
> > -=A0 =A0 =A0 =A0 =A0 struct pci_dev, bus_list));
> > =A0 up_read(&pci_bus_sem);
> >=A0=20
> > =A0 /*
> > @@ -4844,8 +4906,12 @@ int pci_bridge_wait_for_secondary_bus(struct pci=
_dev *dev, char *reset_type)
> >=A0 =A0 * accessing the device after reset (that is 1000 ms + 100 ms).
> >=A0 =A0 */
> > =A0 if (!pci_is_pcie(dev)) {
> > -=A0 pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
> > -=A0 msleep(1000 + delay);
> > +=A0 left =3D 1000 + delay - jiffies_to_msecs(jiffies - start_t);
> > +=A0 pci_dbg(dev, "waiting %d ms for secondary bus\n", left > 0 ? left =
: 0);
> > +
> > +=A0 if (left > 0)
> > + =A0 msleep(left);
> > +
> >=A0 =A0 return 0;
> > =A0 }
> >=A0=20
> > @@ -4870,10 +4936,14 @@ int pci_bridge_wait_for_secondary_bus(struct pc=
i_dev *dev, char *reset_type)
> > =A0 if (pcie_get_speed_cap(dev) <=3D PCIE_SPEED_5_0GT) {
> >=A0 =A0 u16 status;
> >=A0=20
> > -=A0 pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> > -=A0 msleep(delay);
> > +=A0 left =3D delay - jiffies_to_msecs(jiffies - start_t);
> > +=A0 pci_dbg(dev, "waiting %d ms for downstream link\n", left > 0 ? lef=
t : 0);
> > +
> > +=A0 if (left > 0)
> > + =A0 msleep(left);
> >=A0=20
> > -=A0 if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
> > +=A0 left =3D PCI_RESET_WAIT - jiffies_to_msecs(jiffies - start_t);
> > +=A0 if(!pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_ty=
pe))
> > =A0 =A0 return 0;
> >=A0=20
> >=A0 =A0 /*
> > @@ -4888,20 +4958,26 @@ int pci_bridge_wait_for_secondary_bus(struct pc=
i_dev *dev, char *reset_type)
> >=A0 =A0 if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > =A0 =A0 return -ENOTTY;
> >=A0=20
> > -=A0 return pci_dev_wait(child, reset_type,
> > -=A0 =A0 =A0 =A0 PCIE_RESET_READY_POLL_MS - PCI_RESET_WAIT);
> > +=A0 left =3D PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - sta=
rt_t);
> > +=A0 return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset=
_type);
> > =A0 }
> >=A0=20
> > - pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> > -=A0 delay);
> > - if (!pcie_wait_for_link_delay(dev, true, delay)) {
> > + left =3D delay - jiffies_to_msecs(jiffies - start_t);
> > + pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",=
 left > 0 ? left : 0);
> > +
> > + if (!pcie_wait_for_link_delay(dev, true, left > 0 ? left : 0)) {
> >=A0 =A0 /* Did not train, no need to wait any further */
> >=A0 =A0 pci_info(dev, "Data Link Layer Link Active not set in %d msec\n"=
, delay);
> >=A0 =A0 return -ENOTTY;
> > =A0 }
> >=A0=20
> > - return pci_dev_wait(child, reset_type,
> > - =A0 =A0 =A0 PCIE_RESET_READY_POLL_MS - delay);
> > + left =3D PCIE_RESET_READY_POLL_MS - jiffies_to_msecs(jiffies - start_=
t);
> > + return pci_dev_wait_child(dev, start_t, left > 0 ? left : 0, reset_ty=
pe);
> > +}
> > +
> > +int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset=
_type)
> > +{
> > + return __pci_bridge_wait_for_secondary_bus(dev, jiffies, reset_type);
> >=A0 }
> >=A0=20
> >=A0 void pci_reset_secondary_bus(struct pci_dev *dev)
> >=20
>=20
> --=20
>  i.
>=20
--8323328-944046392-1764159513=:968--

