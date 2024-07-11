Return-Path: <linux-pci+bounces-10146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C992E2AA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8BD1C20E5E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD74315B;
	Thu, 11 Jul 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC066yrP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DBD518
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687593; cv=none; b=W2gxgyOILlxzi6Ux3+xQTAbViQ50SGJksLK91kpiXOUj4jTz2pRE9GPXBRUk9hE+qbljMTj8qNXnHUJf0bPR5Ehm3op1uRZxVDRpdVoZftsxV4m354Yjcx6Goz2tAPdV9eRYtYGxuPdoOIt3zHXynvbWWaqHpqTInXsvpQbpm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687593; c=relaxed/simple;
	bh=qWvbhoTCUX/0xD8Fm9nqYnPGH8Z58QN0rqZVZeoUBQE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZcQJ0r6hynHHZd4FOdoyw6E/NjphRYwAUaUlA7LPBTS0zM4VdpMkJtKgU6LHrZWKy9inYYpaD/1NkSkfj2D1ZoQGCkXz7Upg6ZianrVadoetOnKYGihBmQ1QkDd6zFH0YOQbrqAeUXqyQzYz8JMZcvx/bMJuua8YG2KXsYi4pgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC066yrP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720687592; x=1752223592;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qWvbhoTCUX/0xD8Fm9nqYnPGH8Z58QN0rqZVZeoUBQE=;
  b=CC066yrPKFsJUtdvvSv2+EGlYmys9rUW0r4XU6GhB5fKM5PCZOq0H63T
   OX9DokIzVTm6Lc2OpdqLn+wPX7vhADNWFfrDJcIqrUjG59Pdz1anSOsVf
   VcFuEVfkMcVqvswIPnZWxbGAPkUz3lxjh5HvbOfksyu9scLIFMSZqNXNX
   huSR6smEBXhaFDnfa6Iv6kwksovXUER0w5qzdGoH3znGKHLN8JwNXu4iM
   yaLenntgkA3yGDCTfGU2xv2G2ngmzrrD0L3ITg+WzDJkjwJP5RspikcgP
   3XSOBhEE5P2aGdIhWFnZhEzFLNnGE47pe1sIlBylzZ90SK3IQ2PQcZJ7y
   w==;
X-CSE-ConnectionGUID: OvOuhHXQT/WkwX6rKfbE6w==
X-CSE-MsgGUID: YanWwTN8SXaCjYCtN41Rbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18000015"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18000015"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:46:31 -0700
X-CSE-ConnectionGUID: hokNfQaJQgWd+6V5Pq4e2Q==
X-CSE-MsgGUID: KCmSf4IRRtq32IZcumY/PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="49142836"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:46:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 11:46:24 +0300 (EEST)
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
    Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, 
    Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
In-Reply-To: <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
Message-ID: <c6b8c057-42e9-7b6b-c9c4-1017bb354ab9@linux.intel.com>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com> <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1811525700-1720687584=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1811525700-1720687584=:6262
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jul 2024, Mariusz Tkaczyk wrote:

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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Thanks for the update,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1811525700-1720687584=:6262--

