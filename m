Return-Path: <linux-pci+bounces-9924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6392A140
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDF8281FEC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D278C71;
	Mon,  8 Jul 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVBVT10d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29F7F466
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438426; cv=none; b=Bmc5ghK4P6l9bDc/VS0FkiF5iOLTHUZA5nAr8aifh9y5TPfNc5pSEWvjbkOUJZSSWlFU5reQauHL/euwv+jPJI3/ghRutucp3BjMSOcD/cBxFcfgnHTiw7xysRfr4Vx0Tmt+ZKZCfE1BSuyyvW0Z6jO1w8MX6cHtw3Tc2XR+2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438426; c=relaxed/simple;
	bh=aBdLMkkPZs5AGv0uiAydtdIDhTHaK7/ySurVjMioEuI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YyganiQ3C4oUQMNFNUjNb/PBzy4c9qFOnNkzC6+KnaKs0EMOkE9TsNXVR73ywcLLg4rIXl25aJ+KT0/8EiM6DopZyubxExYgCbCyIWm06QkCkxLmO51GJ50M8YLTYSyenC9+Jt5ZRkQNH48WYo9Gb48psMfL/35S9kO9YNZMrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVBVT10d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720438425; x=1751974425;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=aBdLMkkPZs5AGv0uiAydtdIDhTHaK7/ySurVjMioEuI=;
  b=fVBVT10dcWfog9ANcJ57vQFj93YPfeiWzATHtTAmJLeh2gPqLa7ydrTA
   i5R9MHXaaC1DLWWh+GVBTiS3NFELlCfDpdJxtCC4mCKYB73sHNR5HpqlT
   BvuiWc8Pxsqmg/o1Wo0OcFTlm1o/ILIg+BmfT16OV9QZH00sfd10S7CUI
   37Y+mP5i1XMNUtyLkuOGYUt9yKME4N/w8GeWMnBrT0SBKkO1tCE/QtDwz
   UMRk1+ah4oeWIjuNMa8pke/dUY6ZbUeQgB9KtyCHK6mMyhi1fxNSvcmaF
   nu1pk9waSLKuPcM3lLEr1J7OryJnNU2UezgCv1ZEBFK7NpqYZHNPqhjJX
   A==;
X-CSE-ConnectionGUID: Ydku8cAeTFK2OfeZnILLuw==
X-CSE-MsgGUID: k+iS/R8QQCaw1PskNC92EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28240789"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28240789"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 04:33:44 -0700
X-CSE-ConnectionGUID: fEb5XNlyQoyyZW5NkXFwfQ==
X-CSE-MsgGUID: PSPu08sEQ4CvoywLOOfaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="52419932"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.115])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 04:33:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Jul 2024 14:33:34 +0300 (EEST)
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
In-Reply-To: <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
Message-ID: <f318f400-88ef-fe56-dcd5-27434e305d9f@linux.intel.com>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com> <20240705125436.26057-3-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1501028441-1720437734=:1343"
Content-ID: <605f87d2-5c36-9e50-4f93-50d7824e2d5f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1501028441-1720437734=:1343
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2354a271-84ff-1026-6669-f1f32e85c38f@linux.intel.com>

On Fri, 5 Jul 2024, Mariusz Tkaczyk wrote:

> Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> managing LED in storage enclosures. NPEM is indication oriented
> and it does not give direct access to LED. Although each of
> the indications *could* represent an individual LED, multiple
> indications could also be represented as a single,
> multi-color LED or a single LED blinking in a specific interval.
> The specification leaves that open.
>=20
> Each enabled indication (capability register bit on) is represented as a
> ledclass_dev which can be controlled through sysfs. For every ledclass
> device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> It is corresponding to NPEM control register (Indication bit on/off).
>=20
> Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> device which has an NPEM Extended Capability and indication is enabled
> in NPEM capability register. For example, these are leds created for
> pcieport "10000:02:05.0" on my setup:
>=20
> leds/
> =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:fail
> =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:locate
> =E2=94=9C=E2=94=80=E2=94=80 10000:02:05.0:enclosure:ok
> =E2=94=94=E2=94=80=E2=94=80 10000:02:05.0:enclosure:rebuild
>=20
> They can be also found in "/sys/class/leds" directory. Parent PCIe device
> bdf is used to guarantee uniqueness across leds subsystem.
>=20
> To enable/disable fail indication "brightness" file can be edited:
> echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness
>=20
> PCIe r6.1, sec 7.9.19.2 defines the possible indications.
>=20
> Multiple indications for same parent PCIe device can conflict and
> hardware may update them when processing new request. To avoid issues,
> driver refresh all indications by reading back control register.
>=20
> Driver is projected to be exclusive NPEM extended capability manager.
> It waits up to 1 second after imposing new request, it doesn't verify if
> controller is busy before write, assuming that mutex lock gives protectio=
n
> from concurrent updates. Driver is not registered if _DSM LED management
> is available.
>=20
> NPEM is a PCIe extended capability so it should be registered in
> pcie_init_capabilities() but it is not possible due to LED dependency.
> Parent pci_device must be added earlier for led_classdev_register()
> to be successful. NPEM does not require configuration on kernel side, it
> is safe to register LED devices later.
>=20
> Link: https://members.pcisig.com/wg/PCI-SIG/document/19849 [1]
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Looks to be in quite good shape already, one comment below I think should=
=20
be addressed before this is ready to go.

> +static int npem_set_active_indications(struct npem *npem, u32 inds)
> +{
> +=09int ctrl, ret, ret_val;
> +=09u32 cc_status;
> +
> +=09lockdep_assert_held(&npem->lock);
> +
> +=09/* This bit is always required */
> +=09ctrl =3D inds | PCI_NPEM_CTRL_ENABLE;
> +
> +=09ret =3D npem_write_ctrl(npem, ctrl);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * For the case where a NPEM command has not completed immediately,
> +=09 * it is recommended that software not continuously =E2=80=9Cspin=E2=
=80=9D on polling
> +=09 * the status register, but rather poll under interrupt at a reduced
> +=09 * rate; for example at 10 ms intervals.
> +=09 *
> +=09 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
> +=09 * Command Completed"
> +=09 */
> +=09ret =3D read_poll_timeout(npem_read_reg, ret_val,
> +=09=09=09=09ret_val || (cc_status & PCI_NPEM_STATUS_CC),
> +=09=09=09=0910 * USEC_PER_MSEC, USEC_PER_SEC, false, npem,
> +=09=09=09=09PCI_NPEM_STATUS, &cc_status);
> +=09if (ret)
> +=09=09return ret_val;

Will this work as intended?

If ret_val gets set, cond in read_poll_timeout() is true and it returns 0=
=20
so the return branch is not taken.

Also, when read_poll_timeout() times out, ret_val might not be non-zero.

> +
> +=09/*
> +=09 * All writes to control register, including writes that do not chang=
e
> +=09 * the register value, are NPEM commands and should eventually result
> +=09 * in a command completion indication in the NPEM Status Register.
> +=09 *
> +=09 * PCIe Base Specification r6.1 sec 7.9.19.3
> +=09 *
> +=09 * Register may not be updated, or other conflicting bits may be
> +=09 * cleared. Spec is not strict here. Read NPEM Control register after
> +=09 * write to keep cache in-sync.
> +=09 */
> +=09return npem_get_active_indications(npem, &npem->active_indications);
> +}


--=20
 i.
--8323328-1501028441-1720437734=:1343--

