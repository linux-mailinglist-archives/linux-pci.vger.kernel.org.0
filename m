Return-Path: <linux-pci+bounces-11047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B7942D7E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14B81C20621
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286F1AC441;
	Wed, 31 Jul 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/seP2dm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5501A8BE6
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426690; cv=none; b=nlAXKMyFveYdwTCvmPBEOQ74R8mwHfmuFlDztXbx+Toxmp/R6YFNaqIf84AUkWGQkWSxT8KVWkUm7RKg29jPmDutxspjD9eF3PBcqgn2lwZk2M4Jr3KtBYQv293UrQAa9ygS1DsBDVhzEUB+kGH5cKTLzHna7LgdzqtmihqKYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426690; c=relaxed/simple;
	bh=UmtSpGH8cWQPq3/c7EcEepFdU1Wbpdz29Vx7mkvQQww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw/rH2oXP+CPCakMJgqYUT76fS9q7zLPeKJgQ6wJlNk+EdrhL8SKRYVUE+ABOw/o0ftxiEoxibeimD5riM+cORidY293VP1atiOtTMGBWqqdbRDbYmD3QPbpGsiJXyC6aro+WCXi4E3uyhON1OLl6OmBWTscYwQd8MkUgQhaUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/seP2dm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722426688; x=1753962688;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmtSpGH8cWQPq3/c7EcEepFdU1Wbpdz29Vx7mkvQQww=;
  b=i/seP2dmlQD+IrZw2vWjnC7ht0MKoRUhORRUMY2YQOI+PLtEHDopYm0G
   dkVG1y7ZCGqhSi4wZRlH+l8p2dfREQ+0T2LJnYN1acz4bQyg/Tjpf3jbz
   ZHRKV1fqpLoJA3Ca1zKZDQ6MdYm/thcDOEO1XvXPC1X0x0Q+wliVo/uhc
   BgVS1PNugG3h81TYodKKCuvJYL6PJVdm+A//NmaIYSlVsJ2+VcUf5hSV8
   zLv7Djus6m0osoGHKXu5CuGUGnK9CXPDWmDFTg0kNrkS0HSdmauWCqeyK
   IeoMogxnwq+lhcs8ZpWv9/NNh0Zxxp91NHyoM9lBibJYRVS/GyFBY6FuR
   Q==;
X-CSE-ConnectionGUID: zVcDZIzuT5SLL/7EcGkt6Q==
X-CSE-MsgGUID: 4NVt4hKjTFeZRSCismcpjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="30879091"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="30879091"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:51:26 -0700
X-CSE-ConnectionGUID: ztW4cwqCQqCUBhEsFDQ67Q==
X-CSE-MsgGUID: Jz1QC/HORM+GeKD+7G3D+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54583872"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.17.194])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 04:51:23 -0700
Date: Wed, 31 Jul 2024 13:51:17 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Christoph
 Hellwig <hch@lst.de>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Dan
 Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, Marek Behun
 <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240731135117.00004ddf@linux.intel.com>
In-Reply-To: <p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
	<20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
	<p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jul 2024 09:29:36 +0200
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> On Thu, Jul 11, 2024 at 10:30:08AM +0200, Mariusz Tkaczyk wrote:
> > Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> > managing LED in storage enclosures. NPEM is indication oriented
> > and it does not give direct access to LED. Although each of
> > the indications *could* represent an individual LED, multiple
> > indications could also be represented as a single,
> > multi-color LED or a single LED blinking in a specific interval.
> > The specification leaves that open. =20
>=20
> The specification leaves it open, but isn't there a way to determine
> how it is implemented? In ACPI, maybe?


What would be a point of that? There are blinking patterns standards for 2-=
LED
systems and 3-LED systems but NPEM is projected to not be limited to
the led system you have. I mean that we shouldn't try to determine what har=
dware
does - it belongs to hardware. Kernel task is just to read what NPEM regist=
ers
are presenting and trust it.

I can realize NPEM with separate LED for each indication. Who knows, maybe =
in
the future it would become real.

>=20
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
> > echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness =20
>=20
> Have you considered implemtening this via a led trigger?
>=20
> Something like:
>   echo pcie-enclosure > /sys/class/leds/<LED>/trigger
>   echo 1 >/sys/class/leds/<LED>/fail
> but properly thought up.
>=20

No I didn't. I understand the triggers as an actions that may involve led
change we can configure. I thought, it should be cross driver reference (for
example, change LED if keyboard capslock is pressed) and triggers are optio=
nal.

For that reasons I did not consider it. Please explain this concept in deta=
ils.

I think that forcing one and only trigger you can use may we even worse bec=
ause
it seems to be definitely design incompatible (triggers are optional) but I=
'm
not an expert.

Thanks,
Mariusz

