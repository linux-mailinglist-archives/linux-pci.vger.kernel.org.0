Return-Path: <linux-pci+bounces-28086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF1ABD53D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C488D4C48C3
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6FF26FA5D;
	Tue, 20 May 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIectLYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A71270EA6;
	Tue, 20 May 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737214; cv=none; b=sngUwGo/SyZED5U7rawFvBwFXpJghoz27UTeXx4LELy1040+4/tg9T/EUUCn2oPaLQz3LIEhISuqqy74bHDy1NMNQrpKKGAzdI0l65Pd0gC7XZpKFH+iWKJ/zW79YtPZJ/AQOWZ4byHNCGQqH5gJdORn+O6S9zxRHf5gnO9x0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737214; c=relaxed/simple;
	bh=6/pDG+AvJT15c5ska4ppz+CuaS46pEaA766nfX3ii2Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xc/9tmk0oYSFNNX0B8JcmV/33FzndhcgX52pMcLwM9L1JCJsixnv4QknbDHvGNB8hi9et0mBpsTlwgkoVIDZdJIcFRisoGEQUpgDwCZyvM5NFXZ9Xms0z2VkzArn+2xTMqHjCiUoIEAfnMwOAXWZJEs+OuntfHsW8Y9qF3LIFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIectLYA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747737214; x=1779273214;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6/pDG+AvJT15c5ska4ppz+CuaS46pEaA766nfX3ii2Y=;
  b=oIectLYAbb9S5c/4WHDO8UJz+aB3ckitE6PU+d4lv0QUODYNrHd1fO3L
   ZOWXZbx2oXEQkjvS2brzGYYEZqKy7rG2iezdZjARBQ8TAfQGtcK4SS/4e
   o5lAf0iq9vBALOeG+VcbBTbXF8QYG9cipe1TV5QtdsZI4cBuUtVLVuzi7
   CUaBYr2340WD6/KfZjqoH6J43uLKXuRqjb744ltUddjlovhAhj7esc7Xb
   f2vmLgtDyQGUKvVRMjTuAzIHco/gSm/3430hwhzOdYDqVKRyoPoxi7eUQ
   FqndoKuHM2g2aBEjbi5iioHgwoKB/7nlPNGcFqzgZ4hYUso2S5Ce7w+SW
   w==;
X-CSE-ConnectionGUID: qqSbgg3LT426AGGR6iE/aQ==
X-CSE-MsgGUID: VPjQfNPHS1ijXC90A4cxUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="61058989"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="61058989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:33:32 -0700
X-CSE-ConnectionGUID: 8xb8IhFVQtmzJreTdiAd6w==
X-CSE-MsgGUID: rCBTico+SkGyQg6oESRtFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176777146"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:33:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:33:22 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 05/16] PCI/AER: Rename aer_print_port_info() to
 aer_print_source()
In-Reply-To: <20250519213603.1257897-6-helgaas@kernel.org>
Message-ID: <2ebdfb8d-18ec-d87e-469d-c33ee245d244@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-6-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-247255916-1747737202=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-247255916-1747737202=:936
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Jon Pan-Doh <pandoh@google.com>
>=20
> Rename aer_print_port_info() to aer_print_source() to be more descriptive=
=2E
> This logs the Error Source ID logged by a Root Port or Root Complex Event
> Collector when it receives an ERR_COR, ERR_NONFATAL, or ERR_FATAL Message=
=2E
>=20
> [bhelgaas: aer_print_rp_info() -> aer_print_source()]
> Link: https://lore.kernel.org/r/20250321015806.954866-5-pandoh@google.com
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index dc8a50e0a2b7..eb42d50b2def 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,8 +733,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>  =09=09=09info->severity, info->tlp_header_valid, &info->tlp);
>  }
> =20
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info=
 *info,
> -=09=09=09=09const char *details)
> +static void aer_print_source(struct pci_dev *dev, struct aer_err_info *i=
nfo,
> +=09=09=09     const char *details)
>  {
>  =09u16 source =3D info->id;
> =20
> @@ -932,7 +932,7 @@ static bool find_source_device(struct pci_dev *parent=
,
>  =09 * RCEC that received an ERR_* Message.
>  =09 */
>  =09if (!e_info->error_dev_num) {
> -=09=09aer_print_port_info(parent, e_info, " (no details found)");
> +=09=09aer_print_source(parent, e_info, " (no details found)");
>  =09=09return false;
>  =09}
>  =09return true;
> @@ -1299,7 +1299,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09=09e_info.multi_error_valid =3D 0;
> =20
>  =09=09if (find_source_device(pdev, &e_info)) {
> -=09=09=09aer_print_port_info(pdev, &e_info, "");
> +=09=09=09aer_print_source(pdev, &e_info, "");
>  =09=09=09aer_process_err_devices(&e_info);
>  =09=09}
>  =09}
> @@ -1318,7 +1318,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  =09=09=09e_info.multi_error_valid =3D 0;
> =20
>  =09=09if (find_source_device(pdev, &e_info)) {
> -=09=09=09aer_print_port_info(pdev, &e_info, "");
> +=09=09=09aer_print_source(pdev, &e_info, "");
>  =09=09=09aer_process_err_devices(&e_info);
>  =09=09}
>  =09}
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-247255916-1747737202=:936--

