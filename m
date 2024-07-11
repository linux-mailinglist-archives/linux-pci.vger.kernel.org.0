Return-Path: <linux-pci+bounces-10147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82392E2B8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6BD1C211DD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312512BF02;
	Thu, 11 Jul 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ky0nytD8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996312EBF3
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687784; cv=none; b=SLYWVRdKH6IG8uQni4AHbtU2z5LhtVKJ6DYGEaCZXGMWlUJ8ht3UwMEnubQmMbgho6j1CTu0WOnEbw4dpNMR7ipE5HRf7GTH/OifT/psRDreBiIXbh95Y7NBUqdwtnb0ccHH8uRXFwepwQPp/ZqAoM0OcONawFRHr/TXLz+Qye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687784; c=relaxed/simple;
	bh=jQkt4JF6VbhTeIjD8J8JeQpvbzV1eLCs/7iK8lQtXCA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iWTalw27YNQJ8ovDOaFsx8FXhrJp0CzPgjHr2y4d6tDq7HuJdw2avRSXfK9wATyCMWrFv4bGFaOAAKt5pI7y7/BYombeYheZ56JmfHnSRYqtPuJNvwfkNMaYQx6t3umaaTu/HJlUKeem2TIX/TQ4LOQAVI/1uTGw7cu4jKUzLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ky0nytD8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720687783; x=1752223783;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jQkt4JF6VbhTeIjD8J8JeQpvbzV1eLCs/7iK8lQtXCA=;
  b=Ky0nytD88i6DOJDEgKUxaLMrYkycntUZRRym61Q6HEMn7XyCgz/4jxiL
   S4HdM0sQcHFFfAyg71FHwTD+zmv2Zo7pXqjAaccIBpXErT2A9KFOUw1ob
   z/bCKWNOSvUc16MURixbnqphdVH4PPqLWvP/N++z45tpxU9jkKpGfWsVd
   AyUes9i+y2O9wedgTc9eR6gieywaE5Urg7QlY3xCpno28b9uA76P1erQk
   LRJ+9roWtPPRhnJ3YGjBEMZvYrvc1THsxXKQ2j9t00CTUuaF4XGS9BNkB
   7BVp1sawa2vL7trrF1hS1T2xXOglzmCQR70wu6/5YMddAltrbXvno7VaL
   Q==;
X-CSE-ConnectionGUID: bDBS660jRsKcrufYNS6eAA==
X-CSE-MsgGUID: iStKNO6vTUWNUFrYlCELEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18000362"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18000362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:49:25 -0700
X-CSE-ConnectionGUID: WLEaIcNORjar4CIxzAIXRQ==
X-CSE-MsgGUID: 6IkNsypvSvKrBhiZk711lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="49143136"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:49:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 11:49:18 +0300 (EEST)
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
    Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>, 
    Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/3] leds: Init leds class earlier
In-Reply-To: <20240711083009.5580-2-mariusz.tkaczyk@linux.intel.com>
Message-ID: <f6a5bb0d-61f0-571a-a206-5f93a0a45782@linux.intel.com>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com> <20240711083009.5580-2-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1617298853-1720687758=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1617298853-1720687758=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jul 2024, Mariusz Tkaczyk wrote:

> NPEM driver will require leds class, there is an init-order conflict.
> Make sure that LEDs initialization happens first and add comment.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

FWIW (I trust LKP to catch the problems if this new build ordering is not=
=20
ok for some reason),

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
>  drivers/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fe9ceb0d2288..45d1c3e630f7 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -17,6 +17,9 @@ obj-$(CONFIG_PINCTRL)=09=09+=3D pinctrl/
>  obj-$(CONFIG_GPIOLIB)=09=09+=3D gpio/
>  obj-y=09=09=09=09+=3D pwm/
> =20
> +# LEDs must come before PCI, it is needed by NPEM driver
> +obj-y=09=09=09=09+=3D leds/
> +
>  obj-y=09=09=09=09+=3D pci/
> =20
>  obj-$(CONFIG_PARISC)=09=09+=3D parisc/
> @@ -130,7 +133,6 @@ obj-$(CONFIG_CPU_IDLE)=09=09+=3D cpuidle/
>  obj-y=09=09=09=09+=3D mmc/
>  obj-y=09=09=09=09+=3D ufs/
>  obj-$(CONFIG_MEMSTICK)=09=09+=3D memstick/
> -obj-y=09=09=09=09+=3D leds/
>  obj-$(CONFIG_INFINIBAND)=09+=3D infiniband/
>  obj-y=09=09=09=09+=3D firmware/
>  obj-$(CONFIG_CRYPTO)=09=09+=3D crypto/
>=20
--8323328-1617298853-1720687758=:6262--

