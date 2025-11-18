Return-Path: <linux-pci+bounces-41493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38084C689D4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 10:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0252365FFD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091283195E5;
	Tue, 18 Nov 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzR081wP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06726738B;
	Tue, 18 Nov 2025 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458912; cv=none; b=dQ9Kkw85qCTCmjTEyQiflGE94tYdEb/zObsZB+n3KmyB1m0we74H1ZZl2vF1TrUZo6WvWi/1gRjvGwvM76e4CBnoDZ/onp+MmTgi51DjB6vdgImyz2rOwO4smOG4VI/SEQ9JqNWkNyBP1mspKeBrUOc46nB5m5KIZhwoxSY39vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458912; c=relaxed/simple;
	bh=6TUYgiA62XUz5gKE4YkIs/WJ0a5pVPi5602UevDtAlY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CZVJH7N1QlV0b04C+rXmITqNfHyqDe5faj3x7mwLEKvbzJoQZvrOzUTzdRDEpBwf/KCorwxXbeJlt+g6gu2htSSaxUa/YRyaBtGZzcVD7NF8b4+NCadqmggjYrphveCUgukK3A4qD/gRQGFt35qZnwv782lUU7Oris28KO5hwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzR081wP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763458911; x=1794994911;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6TUYgiA62XUz5gKE4YkIs/WJ0a5pVPi5602UevDtAlY=;
  b=UzR081wPZxkDRaaIbh1KppUZyn3crNGOIIxDKNhFbKEWsyMqgJm+vtq8
   ZY976XJ6mjDkrVRn0Ot4+Gi6CkmI6ALQ0jtvbH23YOTfV5wXtt4uaqIMF
   VfguenggWiXMe2rOWWMW4ktyHEAhZ8vfTgcJSdG22ZPLP9Q+4sUlQ64zm
   P1PaSZCQnfkXhYpD8zznf5P1wJ6OtWNccmTZLjW8qpE2btgt3hmyUC+I2
   dVy0g0cn2L6P4HUvE42k5vJXaNO8qQ4kP4s+xYRxZGX3L6aXSqWJww0X1
   zH9jYZUdItmcMmPDXN5YlARc2XXiB1oqqy/lB5/klLs9VXo+6QxbsQAXT
   w==;
X-CSE-ConnectionGUID: YiQMgWYeR5+erdJnA/Lulw==
X-CSE-MsgGUID: XrFja3FCSZaFeEE0FgsGPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64675468"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="64675468"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 01:41:49 -0800
X-CSE-ConnectionGUID: xmDX5Nz1QGeTmdrc+qjkfg==
X-CSE-MsgGUID: 89IvyINKSiqWhYbke59zNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190501785"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.74])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 01:41:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Nov 2025 11:41:37 +0200 (EET)
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
cc: Rob Herring <robh@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Nicolas Schier <nicolas.schier@linux.dev>, 
    Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Bartosz Golaszewski <brgl@bgdev.pl>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
    linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
    Stephan Gerhold <stephan.gerhold@linaro.org>, 
    Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 3/9] serdev: Allow passing the serdev device name to
 serdev_device_add()
In-Reply-To: <20251112-pci-m2-e-v1-3-97413d6bf824@oss.qualcomm.com>
Message-ID: <7053dfed-5eff-7182-bc85-0437a4074c82@linux.intel.com>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-3-97413d6bf824@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2055180828-1763458897=:1205"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2055180828-1763458897=:1205
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Nov 2025, Manivannan Sadhasivam via B4 Relay wrote:

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> Instead of always setting the serdev device name from 'struct device' nam=
e,
> allow the callers to pass an optional name and set it as the serdev devic=
e
> name.
>=20
> This will be used by the future callers passing the serdev device ID as t=
he
> name.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/platform/x86/dell/dell-uart-backlight.c             |  2 +-
>  .../platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    |  2 +-
>  drivers/platform/x86/x86-android-tablets/core.c             |  2 +-
>  drivers/tty/serdev/core.c                                   | 13 +++++++=
++----
>  include/linux/serdev.h                                      |  2 +-
>  5 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/pl=
atform/x86/dell/dell-uart-backlight.c
> index f323a667dc2d2c7dec9fb284515bc3b6b984b7b9..f076cfac2bc5ec14899d6622d=
084bae2ffecfa3c 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -354,7 +354,7 @@ static int dell_uart_bl_pdev_probe(struct platform_de=
vice *pdev)
>  =09if (!serdev)
>  =09=09return -ENOMEM;
> =20
> -=09ret =3D serdev_device_add(serdev);
> +=09ret =3D serdev_device_add(serdev, NULL);
>  =09if (ret) {
>  =09=09dev_err(&pdev->dev, "error %d adding serdev\n", ret);
>  =09=09serdev_device_put(serdev);
> diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c=
 b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> index 8551ab4d2c7dbc3a8d0b2f50071d4460a3ee65e9..5e568fe1162d1563183713f8d=
5c71c59ff7667a1 100644
> --- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> @@ -260,7 +260,7 @@ static int yt2_1380_fc_pdev_probe(struct platform_dev=
ice *pdev)
>  =09/* The fwnode is a managed node, so it will be auto-put on serdev_dev=
ice_put() */
>  =09fwnode_handle_get(dev_fwnode(&serdev->dev));
> =20
> -=09ret =3D serdev_device_add(serdev);
> +=09ret =3D serdev_device_add(serdev, NULL);
>  =09if (ret) {
>  =09=09serdev_device_put(serdev);
>  =09=09return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/pl=
atform/x86/x86-android-tablets/core.c
> index 6588fae303562b7dc9a1a8d281b167e44f0d3e84..96140f5d4f79240f44cb4530e=
e63777f783c6aaf 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -316,7 +316,7 @@ static __init int x86_instantiate_serdev(const struct=
 x86_dev_info *dev_info, in
>  =09ACPI_COMPANION_SET(&serdev->dev, serdev_adev);
>  =09acpi_device_set_enumerated(serdev_adev);
> =20
> -=09ret =3D serdev_device_add(serdev);
> +=09ret =3D serdev_device_add(serdev, NULL);
>  =09if (ret) {
>  =09=09dev_err(&serdev->dev, "error %d adding serdev\n", ret);
>  =09=09serdev_device_put(serdev);
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 2b5582cd5063a87c9a6c99f83a8ab071637eae57..76b89dd0720f89dbe34e205b9=
05ef24d9f94d770 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -121,14 +121,19 @@ static int serdev_device_match(struct device *dev, =
const struct device_driver *d
>  /**
>   * serdev_device_add() - add a device previously constructed via serdev_=
device_alloc()
>   * @serdev:=09serdev_device to be added
> + * @name:=09name of the serdev device (optional)
>   */
> -int serdev_device_add(struct serdev_device *serdev)
> +int serdev_device_add(struct serdev_device *serdev, const char *name)
> +
>  {
>  =09struct serdev_controller *ctrl =3D serdev->ctrl;
>  =09struct device *parent =3D serdev->dev.parent;
>  =09int err;
> =20
> -=09dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
> +=09if (name)
> +=09=09dev_set_name(&serdev->dev, "%s", name);
> +=09else
> +=09=09dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
> =20
>  =09/* Only a single slave device is currently supported. */
>  =09if (ctrl->serdev) {
> @@ -544,7 +549,7 @@ static int of_serdev_register_devices(struct serdev_c=
ontroller *ctrl)
> =20
>  =09=09device_set_node(&serdev->dev, of_fwnode_handle(node));
> =20
> -=09=09err =3D serdev_device_add(serdev);
> +=09=09err =3D serdev_device_add(serdev, NULL);
>  =09=09if (err) {
>  =09=09=09dev_err(&serdev->dev,
>  =09=09=09=09"failure adding device. status %pe\n",
> @@ -692,7 +697,7 @@ static acpi_status acpi_serdev_register_device(struct=
 serdev_controller *ctrl,
>  =09ACPI_COMPANION_SET(&serdev->dev, adev);
>  =09acpi_device_set_enumerated(adev);
> =20
> -=09err =3D serdev_device_add(serdev);
> +=09err =3D serdev_device_add(serdev, NULL);
>  =09if (err) {
>  =09=09dev_err(&serdev->dev,
>  =09=09=09"failure adding ACPI serdev device. status %pe\n",
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index ee42e293445d928a311bd3c120e609214f89a5dd..3b87909b199af74d619b4fe54=
8c5c9c994e7bc15 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -163,7 +163,7 @@ static inline void serdev_controller_put(struct serde=
v_controller *ctrl)
>  }
> =20
>  struct serdev_device *serdev_device_alloc(struct serdev_controller *);
> -int serdev_device_add(struct serdev_device *);
> +int serdev_device_add(struct serdev_device *serdev, const char *name);
>  void serdev_device_remove(struct serdev_device *);
> =20
>  struct serdev_controller *serdev_controller_alloc(struct device *host,
>=20
>=20

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2055180828-1763458897=:1205--

