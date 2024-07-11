Return-Path: <linux-pci+bounces-10163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7A92EBB4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2DD2819FD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC215EFB8;
	Thu, 11 Jul 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0XkhEFJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08612FB1B;
	Thu, 11 Jul 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711711; cv=none; b=uic8PSE3VN0oFbUSm0GNriVxEzxrcko6digceEfmkIT5y7T/d8ZFt0EbzpX85ojaNL+0aFH1jzsJmXBTPLWONo3JXtiA6E57rF68DeZ4kYLoCgiCJrhcZKrZkbIBu2lhZ+j5Bed6POEpmKUDWAV5w2nWPOUoqmyqCxg7WKYvDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711711; c=relaxed/simple;
	bh=Mp6aeP16rDe0NgNWIzBoWpraUHDvr79iZxKuBFhJlTM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M3Uwk30mB5C9as93E04Pg83Y5bJF58DO0m47oWO/C4g9EZcPKH3bZu90XHS85NGRRWQT27Ej78hTBK7Dg6U2j0f7l+F72twAoLE2no9N9+SjsXhqMRK2thk+jJuw2/AGLQUKAqiGjOWmfj6F9wVErPAJhoAv16nWBZG8TNx6hJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0XkhEFJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720711709; x=1752247709;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Mp6aeP16rDe0NgNWIzBoWpraUHDvr79iZxKuBFhJlTM=;
  b=B0XkhEFJL+gxn7leHDTjx+e7axY0ldGNr1uqQTAofPOK/IEv31lXxvm4
   +w88YKYHxN7cRYz3L6zfkAWZtcOD9Ad9ojfHB4ycWTTdYXRhUR3VPLr2p
   cxIT7Ozc+hVTfwFwm4iblpdbIU7I0NrIyji0F0FVqLe7XhmtY4vTaXo14
   0J+NTRF3Ztpov8JuWUDCUewlALtMveXZiw8vTjYAOxUYpDkPWY0DS1EKj
   f6i4YjkuW/EAybStLTGkkKcLJ55dJTYC/uCMfFaZzW7PoI8dPQ+Ap9yvc
   MsH+pqq8l60Raw1v/zf+cccsE9xo4L7RxhF+pKVZms6y6u9uzaw9RY0lo
   A==;
X-CSE-ConnectionGUID: jwo3iKt3TOCpUZ2AT6Ts5w==
X-CSE-MsgGUID: Lk2x2/jrTkuY6CHR44HuJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17808699"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17808699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:27:21 -0700
X-CSE-ConnectionGUID: c9wssgMYS8W+5OlqCdzdcA==
X-CSE-MsgGUID: kGuY6bOZRN+tTexzDVQivA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="49027757"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:27:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 18:27:13 +0300 (EEST)
To: superm1@kernel.org
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>, 
    Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/4] PCI: Verify functions currently in D3cold have
 entered D0
In-Reply-To: <20240710205838.2413465-3-superm1@kernel.org>
Message-ID: <29d388a8-b529-6af1-d3a3-a0846e1f0692@linux.intel.com>
References: <20240710205838.2413465-1-superm1@kernel.org> <20240710205838.2413465-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2025960674-1720711633=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2025960674-1720711633=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Jul 2024, superm1@kernel.org wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> It is reported that USB4 routers and downstream devices may behave
> incorrectly if a dock cable is plugged in at approximately the time that
> the autosuspend_delay is configured. In this situation the device has
> attempted to enter D3cold, but didn't finish D3cold entry when the PCI
> core tried to transition it back to D0.
>=20
> Empirically measuring this situation an "aborted" D3cold exit takes
> ~60ms and a "normal" D3cold exit takes ~10ms.
>=20
> The PCI-PM 1.2 spec specifies that the restore time for functions
> in D3cold is either 'Full context restore or boot latency'.
>=20
> As PCIe r6.0 sec 5.8 specifies that the device will have gone
> through a conventional reset it may take some time for the

I'd add comma after reset.

The code change looks okay though,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> device to be ready.
>=20
> Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
> in D3cold to return to D0.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4ad02ad640518..9af324ab6bb02 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1388,6 +1388,17 @@ int pci_power_up(struct pci_dev *dev)
>  =09else if (state =3D=3D PCI_D2)
>  =09=09udelay(PCI_PM_D2_DELAY);
> =20
> +=09/*
> +=09 * D3cold -> D0 will have gone through a conventional reset and may n=
eed
> +=09 * time to be ready.
> +=09 */
> +=09if (dev->current_state =3D=3D PCI_D3cold) {
> +=09=09int ret;
> +
> +=09=09ret =3D pci_dev_wait(dev, "D3cold->D0", PCI_RESET_WAIT);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
>  end:
>  =09dev->current_state =3D PCI_D0;
>  =09if (need_restore)
>=20

--=20
 i.

--8323328-2025960674-1720711633=:6262--

