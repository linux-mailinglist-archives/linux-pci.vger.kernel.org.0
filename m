Return-Path: <linux-pci+bounces-9925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506AE92A14C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04A01F21FE3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BE11CA1;
	Mon,  8 Jul 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zdgh2m5Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AB101E2
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438804; cv=none; b=SrF4iAcN9lh8vYDEdUoAnrEKu4dWXCjSef2II9yr5ZzD8nAN9EatSLOoSct9MvV7/ipy7GrsxlVmBSsu+ULTrdShr/Xl+FuBmzWymWuufNyH1KRzOB3dvEESGNPKBWjGDPsSylqL77LQEWOt9adyQGjyFXovBJCNNLcJRnp/9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438804; c=relaxed/simple;
	bh=54wa11/hz+J1Y1lVR2LnaMFWGrZy7uhL9aaHZOfJxso=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qd/Rf/3PxjmIhmNi1H8O57q+6OeZswhXAvIU3Crb/fbYF4MaP35MchhUZIC0Vr0f4F8DMejlNe8xC129pOUibOq3GecSPybeOhQoY0K3A4jAlGTFAkgh7gEzqBf15EMU/dNwzCMeczTT2cwp8HUpJ67VwSdYAN4/E8gr4Mgoib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zdgh2m5Q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720438803; x=1751974803;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=54wa11/hz+J1Y1lVR2LnaMFWGrZy7uhL9aaHZOfJxso=;
  b=Zdgh2m5Qj4tXu4nfwO88X7if0GitBc1qaZU/FMm2JSpK5Lk5bmUW4X8V
   WSw5zJnLG75w0etsRHA78jAkvGW8C9/W25MCJG2GaQAMJpXZXnT/YzO9q
   /35ZsqhLMQOGU8JmctWHuUlZFG5YHD5rU7EKe8hDJlnymsz6kpl6M8ZsV
   rWAx9zHNrv3kbWmJwZcTaoZpn4fIONIzUf99GAxAnsNnSl/SAtwD8MVdi
   x/nK8NTypxBcwKNSKOSe0hUnVpkLSdlkN2ZVUHxtW+99JkWaGOcjflfPD
   K3QxEnpXNPikkliMyQoyoKKdCIjWpFe5+evoB16vtLJi+lErWno/vzYKA
   A==;
X-CSE-ConnectionGUID: /4dzIVJrQNOeK6qOpy9h+A==
X-CSE-MsgGUID: NNUn3t6LQlmdstYY1RBumg==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28789663"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28789663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 04:40:03 -0700
X-CSE-ConnectionGUID: m0o2a9DsQc6WC+LRkV5AzQ==
X-CSE-MsgGUID: OBqyitl/Q3+Mhqrbej4ewA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="48210631"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 04:39:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Jul 2024 14:39:53 +0300 (EEST)
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
Subject: Re: [PATCH v3 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED
 management
In-Reply-To: <20240705125436.26057-4-mariusz.tkaczyk@linux.intel.com>
Message-ID: <32fc307d-5d72-fe5c-03cf-efe57704144c@linux.intel.com>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com> <20240705125436.26057-4-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-181078046-1720438793=:1343"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-181078046-1720438793=:1343
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 5 Jul 2024, Mariusz Tkaczyk wrote:

> Device Specific Method PCIe SSD Status LED Management (_DSM) defined in
> PCI Firmware Spec r3.3 sec 4.7 provides a way to manage LEDs via ACPI.
>=20
> The design is similar to NPEM defined in PCIe Base Specification r6.1
> sec 6.28:
>   - both standards are indication oriented,
>   - _DSM supported bits are corresponding to NPEM capability
>     register bits
>   - _DSM control bits are corresponding to NPEM control register
>     bits.
>=20
> _DSM does not support enclosure specific indications and special NPEM
> commands NPEM_ENABLE and NPEM_RESET.
>=20
> _DSM is implemented as a second op in NPEM driver. The standard used
> in background is not presented to user. The interface is accessed same
> as NPEM.
>=20
> According to spec, _DSM has higher priority and availability  of _DSM
> in not limited to devices with NPEM support. It is followed in
> implementation.
>=20
> Link: https://members.pcisig.com/wg/PCI-SIG/document/14025
> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  drivers/pci/npem.c | 147 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
> index fd3366bc3fb0..e3bc28d089d3 100644
> --- a/drivers/pci/npem.c
> +++ b/drivers/pci/npem.c
> @@ -11,6 +11,14 @@
>   *=09PCIe Base Specification r6.1 sec 6.28
>   *=09PCIe Base Specification r6.1 sec 7.9.19
>   *
> + * _DSM Definitions for PCIe SSD Status LED
> + *=09 PCI Firmware Specification, r3.3 sec 4.7
> + *
> + * Two backends are supported to manipulate indications:  Direct NPEM re=
gister
> + * access (npem_ops) and indirect access through the ACPI _DSM (dsm_ops)=
=2E
> + * _DSM is used if supported, else NPEM.
> + *
> + * Copyright (c) 2021-2022 Dell Inc.
>   * Copyright (c) 2023-2024 Intel Corporation
>   *=09Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
>   */
> @@ -55,6 +63,21 @@ static const struct indication npem_indications[] =3D =
{
>  =09{0,=09=09=09NULL}
>  };
> =20
> +/* _DSM PCIe SSD LED States are corresponding to NPEM register values */
> +static const struct indication dsm_indications[] =3D {
> +=09{PCI_NPEM_IND_OK,=09"enclosure:ok"},
> +=09{PCI_NPEM_IND_LOCATE,=09"enclosure:locate"},
> +=09{PCI_NPEM_IND_FAIL,=09"enclosure:fail"},
> +=09{PCI_NPEM_IND_REBUILD,=09"enclosure:rebuild"},
> +=09{PCI_NPEM_IND_PFA,=09"enclosure:pfa"},
> +=09{PCI_NPEM_IND_HOTSPARE,=09"enclosure:hotspare"},
> +=09{PCI_NPEM_IND_ICA,=09"enclosure:ica"},
> +=09{PCI_NPEM_IND_IFA,=09"enclosure:ifa"},
> +=09{PCI_NPEM_IND_IDT,=09"enclosure:idt"},
> +=09{PCI_NPEM_IND_DISABLED,=09"enclosure:disabled"},
> +=09{0,=09=09=09NULL}
> +};
> +
>  #define for_each_indication(ind, inds) \
>  =09for (ind =3D inds; ind->bit; ind++)
> =20
> @@ -250,6 +273,120 @@ static bool npem_has_dsm(struct pci_dev *pdev)
>  =09=09=09      BIT(GET_STATE_DSM) | BIT(SET_STATE_DSM));
>  }
> =20
> +struct dsm_output {
> +=09u16 status;
> +=09u8 function_specific_err;
> +=09u8 vendor_specific_err;
> +=09u32 state;
> +} __packed;

As mentioned by Christoph, __packed is not required here due to natural=20
alignment (Using __packed will cause other effects beyond just preventing=
=20
compiler from adding padding which is why it's good to avoid it where=20
it's not needed).

With that removed,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-181078046-1720438793=:1343--

