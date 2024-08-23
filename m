Return-Path: <linux-pci+bounces-12089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C399B95CC0B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 14:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C751C2092B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C1185606;
	Fri, 23 Aug 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnpeNykl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C77184550;
	Fri, 23 Aug 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414840; cv=none; b=WedkJr1WVV0sVIYw9A/zlo+eltnMqBxUqRj2TfoMksRLqs1OOXTRnu7BxawLgM4oWtxw+pa/JBEXNAVC7CshA+giuc68t+tI7/zaYYBhU6aSkzxFyfXJ4CROdlYuKSJz7s+9y9MF7unqclS7xkMqBaWRZ/MGvb9EhSmv2cONGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414840; c=relaxed/simple;
	bh=GmmITxJvuf72+kfLPPaBWOkkyO9Pa4/VVNNaJ/o/los=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pj5GUzg0RHrnL0neNv04q3+BIW3BqprnL1Z3BIrstsisIl0y1VdpFRXjDWYI2aeB9Ig2G6am9uNdhsn9hHcJKBk7QwXS9KNhfVxP9q9R3zGppCjpw23E4yh6ZQXGf+Qd9fSA7xXH+3i64JMlijBJsmzGINoFLd283/01kvxs3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnpeNykl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724414839; x=1755950839;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=GmmITxJvuf72+kfLPPaBWOkkyO9Pa4/VVNNaJ/o/los=;
  b=gnpeNyklvVx8h/lQ24/byJzvc0loNkG8u3574SHOWqaMw8d+O8g4ci3i
   F89jY9nHbcUFtBppyyx/YQ5oh6yfp5L47KWkiZdWz6xkb/YRfoeXVQ1vf
   QstDqwVatE9W91rflPfrC05Jh1rdeXGYbix2UnjIsuPknejUWnfq6F4nU
   8RFLhmmnec9lOOllFeDJrblceO4GCXckP3kR8QR1hIFN8nKlMMgAG4kg4
   NAP/8lGAl4P2+V9kaNdEf/NK1JbFz94/Qp0vuUYtw9TrDXdvyrjyp7qHw
   7aDSFRrRtvl3RDXLkkKwcIisrr+Bh4WWV7ovPPJo1VmOSNyb9phCn3rm4
   Q==;
X-CSE-ConnectionGUID: dL7IDij2RviuwpwenSDjwA==
X-CSE-MsgGUID: ybTqT4IDTvK609CxLBpKPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23033119"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23033119"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:07:18 -0700
X-CSE-ConnectionGUID: K4oJ9jpPRMOJQTS2At7iLQ==
X-CSE-MsgGUID: 5ouiCCrSRR2Qlpwz6QBFpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62501211"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.2])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:07:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 23 Aug 2024 15:07:10 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>, 
    Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 3/5] PCI: Verify functions currently in D3cold have
 entered D0
In-Reply-To: <20240823042508.1057791-5-superm1@kernel.org>
Message-ID: <561b6865-cba3-d640-b56d-072d06b94026@linux.intel.com>
References: <20240823042508.1057791-1-superm1@kernel.org> <20240823042508.1057791-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1541883532-1724414664=:2230"
Content-ID: <0c5fdc0a-f1cf-5b47-eac4-adb56783f51c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1541883532-1724414664=:2230
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f1fc49f7-b589-1d47-a5a9-af0ac9fe67d5@linux.intel.com>

On Thu, 22 Aug 2024, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> It is reported that USB4 routers and downstream devices may behave
> incorrectly if a dock cable is plugged in at approximately the time that
> the autosuspend_delay is configured. In this situation the device has
> attempted to enter D3cold, but didn't finish D3cold entry when the PCI
> core tried to transition it back to D0.
>=20
> Empirically measuring this situation an "aborted" D3cold exit takes
> ~60ms and a "normal" D3cold exit takes ~6ms.
>=20
> The PCI-PM 1.2 spec specifies that the restore time for functions
> in D3cold is either 'Full context restore or boot latency'.
>=20
> As PCIe r6.0 sec 5.8 specifies that the device will have gone
> through a conventional reset, it may take some time for the
> device to be ready.
>=20
> Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
> in D3cold to return to D0.
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 11 +++++++++++
>  drivers/pci/pci.h |  1 +
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b7717155e2fd0..7e861b6923d0a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1425,6 +1425,17 @@ int pci_power_up(struct pci_dev *dev)
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
> +=09=09ret =3D pci_dev_wait(dev, PCI_DEV_WAIT_D3COLD_D0, PCI_RESET_WAIT);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
>  end:
>  =09dev->current_state =3D PCI_D0;
>  =09if (need_restore)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 477257e843952..a675f5d55f298 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -11,6 +11,7 @@ enum pci_reset_type {
>  =09PCI_DEV_WAIT_BUS_RESET,
>  =09PCI_DEV_WAIT_RESUME,
>  =09PCI_DEV_WAIT_DPC,
> +=09PCI_DEV_WAIT_D3COLD_D0,

Don't you need to add a string for this too? :-/

I wonder if it would be prudent to add PCI_DEV_WAIT_MAX and=20
use static_assert() for the sizeof the pci_reset_types[] in patch 1 to=20
autodetect mismatch (though it won't help if something is added in the=20
middle of the list).

--=20
 i.
--8323328-1541883532-1724414664=:2230--

