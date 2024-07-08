Return-Path: <linux-pci+bounces-9932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4792A4A2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C569E1C214EC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D81E515;
	Mon,  8 Jul 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSVxAfte"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13313AA5D
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448869; cv=none; b=GUV7PbcveDvP6ShBIxxFRZ+0cYyBopdN25oeyq6+1SUWp/3uAhVuDittvComhG0MguY4eVqvxyq2vzM0P6vZmMhCzrYuPAEUkwareJDQw0XJb3/33vwaIPsaUmU7wMrR00pRD6++2X7OBZoBWURRb3Siu7FPV9047H6q2SbtXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448869; c=relaxed/simple;
	bh=HahzFLsXB+a5f5ormsD+Tgh3hYeuD2ayJIXqQfXaL/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U21/Yi8kpeFBB9iDYZpRZE/MShorDqjQPawBvoPzLgcPWdx1Qz+TOwBQFglFYw0Qa67llLIqoGQsGx9j0hhQhYnYiDNzjoZIH9aCKYu2gaaqwsuMhpDL1KK4FpmyHb3p4EAGm/ElyD+Zr+LWVBXd4pEJM0CyCiOhyBOTaKw024E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSVxAfte; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720448868; x=1751984868;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HahzFLsXB+a5f5ormsD+Tgh3hYeuD2ayJIXqQfXaL/s=;
  b=VSVxAfteD9Tyzc/0JNKuEB9kRrYs+PcIVd9IJTslCyX5ka/3X+5vMBYZ
   zfpOxm2/alI6IepCCvinQXmpPcFa3VkfqRVtswbSScJKcw7lM/Wciu7UI
   ZWIreTuirArmGwUT/B+fG5ftW5DwKiNWmnTsGbab2WXADs2hGPEEXCnoa
   kodO4P0QlqpDifAy6wcLCwXswvhnbId3MJ8rv/LnJFmfAMwlAbBwiGH0P
   1V9w6MdL1uo2mBJIcHA+cmdvwCJMKfjMhWR1A54eirpJkn8xyG0nNjCAt
   UpFtoPI09WtyjFniawj0LGKMV2Kp9VCaDF7RzCJdui/5FXWbYr42czWfs
   w==;
X-CSE-ConnectionGUID: fBNrX8WaT2CBj7XITDtAXw==
X-CSE-MsgGUID: VtsVNnRVQN2xR2mEv2nydQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35092599"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="35092599"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:24:41 -0700
X-CSE-ConnectionGUID: n1hiDg/USu+89GWoqpbThg==
X-CSE-MsgGUID: mfqmg7qCQZiR4U38GjT3Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="85070717"
Received: from unknown (HELO localhost) ([10.237.142.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:24:37 -0700
Date: Mon, 8 Jul 2024 16:24:31 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>,
 Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, Pavel
 Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240708162431.00006d13@linux.intel.com>
In-Reply-To: <f318f400-88ef-fe56-dcd5-27434e305d9f@linux.intel.com>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
	<20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
	<f318f400-88ef-fe56-dcd5-27434e305d9f@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 14:33:34 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Fri, 5 Jul 2024, Mariusz Tkaczyk wrote:
>=20
> > Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> > managing LED in storage enclosures. NPEM is indication oriented
> > and it does not give direct access to LED. Although each of
> > the indications *could* represent an individual LED, multiple
> > indications could also be represented as a single,
> > multi-color LED or a single LED blinking in a specific interval.
> > The specification leaves that open.
> >=20
> > Each enabled indication (capability register bit on) is represented as a
> > ledclass_dev which can be controlled through sysfs. For every ledclass
> > device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> > It is corresponding to NPEM control register (Indication bit on/off).
> >=20
> > Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> > device which has an NPEM Extended Capability and indication is enabled
> > in NPEM capability register. For example, these are leds created for
> > pcieport "10000:02:05.0" on my setup:
> >=20
> > leds/
> > =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:fail
> > =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:locate
> > =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:ok
> > =E2=94=94=E2=94=80=E2=94=80 10000:02:05.0:enclosure:rebuild
> >=20
> > They can be also found in "/sys/class/leds" directory. Parent PCIe devi=
ce
> > bdf is used to guarantee uniqueness across leds subsystem.
> >=20
> > To enable/disable fail indication "brightness" file can be edited:
> > echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> > echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness
> >=20
> > PCIe r6.1, sec 7.9.19.2 defines the possible indications.
> >=20
> > Multiple indications for same parent PCIe device can conflict and
> > hardware may update them when processing new request. To avoid issues,
> > driver refresh all indications by reading back control register.
> >=20
> > Driver is projected to be exclusive NPEM extended capability manager.
> > It waits up to 1 second after imposing new request, it doesn't verify if
> > controller is busy before write, assuming that mutex lock gives protect=
ion
> > from concurrent updates. Driver is not registered if _DSM LED management
> > is available.
> >=20
> > NPEM is a PCIe extended capability so it should be registered in
> > pcie_init_capabilities() but it is not possible due to LED dependency.
> > Parent pci_device must be added earlier for led_classdev_register()
> > to be successful. NPEM does not require configuration on kernel side, it
> > is safe to register LED devices later.
> >=20
> > Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com> =20
>=20
> Looks to be in quite good shape already, one comment below I think should=
=20
> be addressed before this is ready to go.
>=20
> > +static int npem_set_active_indications(struct npem *npem, u32 inds)
> > +{
> > +	int ctrl, ret, ret_val;
> > +	u32 cc_status;
> > +
> > +	lockdep_assert_held(&npem->lock);
> > +
> > +	/* This bit is always required */
> > +	ctrl =3D inds | PCI_NPEM_CTRL_ENABLE;
> > +
> > +	ret =3D npem_write_ctrl(npem, ctrl);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * For the case where a NPEM command has not completed immediately,
> > +	 * it is recommended that software not continuously =E2=80=9Cspin=E2=
=80=9D on
> > polling
> > +	 * the status register, but rather poll under interrupt at a
> > reduced
> > +	 * rate; for example at 10 ms intervals.
> > +	 *
> > +	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of
> > NPEM
> > +	 * Command Completed"
> > +	 */
> > +	ret =3D read_poll_timeout(npem_read_reg, ret_val,
> > +				ret_val || (cc_status &
> > PCI_NPEM_STATUS_CC),
> > +				10 * USEC_PER_MSEC, USEC_PER_SEC, false,
> > npem,
> > +				PCI_NPEM_STATUS, &cc_status);
> > +	if (ret)
> > +		return ret_val; =20
>=20
> Will this work as intended?
>=20
> If ret_val gets set, cond in read_poll_timeout() is true and it returns 0=
=20
> so the return branch is not taken.

>=20
> Also, when read_poll_timeout() times out, ret_val might not be non-zero.

Yes, it is good catch thanks! What about?

	if (ret)
		return ret;
	if (ret_val)
		return ret_val;

If ret is set it means that it times out- we should return that to caller.

If ret_val is set it means that we received error in npem_read_reg()- we sh=
ould
return that (device probably is unreachable).

If read_val is set then we are less interested in ret because error from
npem_read_reg() function is more critical, so it is "acceptable" to have re=
t =3D 0
in this case.

Mariusz

