Return-Path: <linux-pci+bounces-9946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB292A714
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 18:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC5B1F22304
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA677F2F;
	Mon,  8 Jul 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSPwepQo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA2146593
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455239; cv=none; b=Iw5WHCfs8qxK+As2fdfHGT+UqRvoJp8PPpr0BZXChZ6axBOvJZyWxxOlDLiIxFf/bTVwfdk5xQ6xEvy9SW6DjLTde775Md7iR8rV1iRasSChSfhi83s27ZA8qfmuKinzQF+8rpQf9dSdblmf3moFJNy2OcDfrIWzFop75i0ih4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455239; c=relaxed/simple;
	bh=35A/pn0NM7tIpNoGVxrsuplq1maCvcBGi7/el7a7lZw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N5iEzMhttGsoRJNAZsBqqZIDwp4vhLFlgh289HXzgeCLzo4pcamGiTg745609o1RDKKu/F1ND7ZWzJJrTJsKuIJXUyQPQ7QMf5lJCWUGy0sdqTLJL7S47fZeAn6EWGZSCZsVsnYvtrBieZ1kyaB6GMFyDqZQQMo4BAqdkZEuvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSPwepQo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720455238; x=1751991238;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=35A/pn0NM7tIpNoGVxrsuplq1maCvcBGi7/el7a7lZw=;
  b=kSPwepQo4fCYjMIswrNn7hQyjg9S6wO0tBeEppoAzJi9bsj2f6ER86Fz
   l4owE5bnttxuvzTDtjSIYfatUjWvTwJWYVOlbc3rS0gKUF6PAdma5Ma1c
   Mi2tdP4OgD4tEV4iyG+Yue6VLWZKY735dFSzsA56uuwApvc4++urD6pPe
   L94Iz8IaRGJK3bQZh1Pwg6Pouf2QN1lKX4yiO7nql1iy38ng5GXyvr2l9
   Dy1H8n6TEaxpE48y3hmzKAkqtaPuKeg7lZn58M3+i6vAUjjUZJsBjfc+b
   jhCXpwR09e7Mh0W5/K5HWcDLfHvouHxHSmg+dJWU43K2Xb0fMFkrjMUrZ
   g==;
X-CSE-ConnectionGUID: QeQpdz1fSZ+tlhDWnIyECA==
X-CSE-MsgGUID: g5cpfex7SsyiZxKUDLvSnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21478820"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="21478820"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:13:57 -0700
X-CSE-ConnectionGUID: voYbp45OSTSctyBvdKJ3zw==
X-CSE-MsgGUID: aNkO4utNRgC2UA2i9HN0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47976388"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.115])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:13:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Jul 2024 19:13:48 +0300 (EEST)
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>, 
    Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
In-Reply-To: <20240708162431.00006d13@linux.intel.com>
Message-ID: <d917dc3b-c9e5-8c5f-65e1-0a32ae1d7509@linux.intel.com>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com> <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com> <f318f400-88ef-fe56-dcd5-27434e305d9f@linux.intel.com> <20240708162431.00006d13@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-977289223-1720455228=:1343"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-977289223-1720455228=:1343
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Jul 2024, Mariusz Tkaczyk wrote:

> On Mon, 8 Jul 2024 14:33:34 +0300 (EEST)
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Fri, 5 Jul 2024, Mariusz Tkaczyk wrote:
> >=20
> > > Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> > > managing LED in storage enclosures. NPEM is indication oriented
> > > and it does not give direct access to LED. Although each of
> > > the indications *could* represent an individual LED, multiple
> > > indications could also be represented as a single,
> > > multi-color LED or a single LED blinking in a specific interval.
> > > The specification leaves that open.
> > >=20
> > > Each enabled indication (capability register bit on) is represented a=
s a
> > > ledclass_dev which can be controlled through sysfs. For every ledclas=
s
> > > device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0=
).
> > > It is corresponding to NPEM control register (Indication bit on/off).
> > >=20
> > > Ledclass devices appear in sysfs as child devices (subdirectory) of P=
CI
> > > device which has an NPEM Extended Capability and indication is enable=
d
> > > in NPEM capability register. For example, these are leds created for
> > > pcieport "10000:02:05.0" on my setup:
> > >=20
> > > leds/
> > > =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:fail
> > > =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:locate
> > > =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:ok
> > > =E2=94=94=E2=94=80=E2=94=80 10000:02:05.0:enclosure:rebuild
> > >=20
> > > They can be also found in "/sys/class/leds" directory. Parent PCIe de=
vice
> > > bdf is used to guarantee uniqueness across leds subsystem.
> > >=20
> > > To enable/disable fail indication "brightness" file can be edited:
> > > echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> > > echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness
> > >=20
> > > PCIe r6.1, sec 7.9.19.2 defines the possible indications.
> > >=20
> > > Multiple indications for same parent PCIe device can conflict and
> > > hardware may update them when processing new request. To avoid issues=
,
> > > driver refresh all indications by reading back control register.
> > >=20
> > > Driver is projected to be exclusive NPEM extended capability manager.
> > > It waits up to 1 second after imposing new request, it doesn't verify=
 if
> > > controller is busy before write, assuming that mutex lock gives prote=
ction
> > > from concurrent updates. Driver is not registered if _DSM LED managem=
ent
> > > is available.
> > >=20
> > > NPEM is a PCIe extended capability so it should be registered in
> > > pcie_init_capabilities() but it is not possible due to LED dependency=
=2E
> > > Parent pci_device must be added earlier for led_classdev_register()
> > > to be successful. NPEM does not require configuration on kernel side,=
 it
> > > is safe to register LED devices later.
> > >=20
> > > Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com> =20
> >=20
> > Looks to be in quite good shape already, one comment below I think shou=
ld=20
> > be addressed before this is ready to go.
> >=20
> > > +static int npem_set_active_indications(struct npem *npem, u32 inds)
> > > +{
> > > +=09int ctrl, ret, ret_val;
> > > +=09u32 cc_status;
> > > +
> > > +=09lockdep_assert_held(&npem->lock);
> > > +
> > > +=09/* This bit is always required */
> > > +=09ctrl =3D inds | PCI_NPEM_CTRL_ENABLE;
> > > +
> > > +=09ret =3D npem_write_ctrl(npem, ctrl);
> > > +=09if (ret)
> > > +=09=09return ret;
> > > +
> > > +=09/*
> > > +=09 * For the case where a NPEM command has not completed immediatel=
y,
> > > +=09 * it is recommended that software not continuously =E2=80=9Cspin=
=E2=80=9D on
> > > polling
> > > +=09 * the status register, but rather poll under interrupt at a
> > > reduced
> > > +=09 * rate; for example at 10 ms intervals.
> > > +=09 *
> > > +=09 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of
> > > NPEM
> > > +=09 * Command Completed"
> > > +=09 */
> > > +=09ret =3D read_poll_timeout(npem_read_reg, ret_val,
> > > +=09=09=09=09ret_val || (cc_status &
> > > PCI_NPEM_STATUS_CC),
> > > +=09=09=09=0910 * USEC_PER_MSEC, USEC_PER_SEC, false,
> > > npem,
> > > +=09=09=09=09PCI_NPEM_STATUS, &cc_status);
> > > +=09if (ret)
> > > +=09=09return ret_val; =20
> >=20
> > Will this work as intended?
> >=20
> > If ret_val gets set, cond in read_poll_timeout() is true and it returns=
 0=20
> > so the return branch is not taken.
>=20
> >=20
> > Also, when read_poll_timeout() times out, ret_val might not be non-zero=
=2E
>=20
> Yes, it is good catch thanks! What about?
>=20
> =09if (ret)
> =09=09return ret;
> =09if (ret_val)
> =09=09return ret_val;
>=20
> If ret is set it means that it times out- we should return that to caller=
=2E
>=20
> If ret_val is set it means that we received error in npem_read_reg()- we =
should
> return that (device probably is unreachable).
>=20
> If read_val is set then we are less interested in ret because error from
> npem_read_reg() function is more critical, so it is "acceptable" to have =
ret =3D 0
> in this case.

Yes, I think that will do.

--=20
 i.

--8323328-977289223-1720455228=:1343--

