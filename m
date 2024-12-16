Return-Path: <linux-pci+bounces-18508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE179F32E3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC701699B9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB69205E07;
	Mon, 16 Dec 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaD7QPWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A12450F2
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358387; cv=none; b=P/Wakh8A9zldo2fLjIUwUAMh80CL2Fcfb+bpr4WAUNP5tgwNVvRNaId28CaR5pNl0hj+6QYoynVAPlxH1JNFLXB0C/SVHSt017sqRhDTJfsnk5moVIdKssFA27RMheXUUR4mMKxsZYOtACn4yOIXpd90xJpxz4IBHtONylzfdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358387; c=relaxed/simple;
	bh=gEO2Lt+DkW2cEC3ACKc4vTf45impSN/9KSxGKpSSXdE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q/a/QRHISjM6UUrmc6eKrRvO0R7pwCPe/6JL6NFPn83TNeuvpNhpRzsZGo5lCOIOLAdHqg7jGqBuxHl2eVK+n89H9k0sTzcgDwc1jc0LFPwy30GMV19FwifWHsgOyCROjcBGF2Vfrjy10ED9U1P3wJVn8zeRQFJ53CF3TqSsEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaD7QPWj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734358386; x=1765894386;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=gEO2Lt+DkW2cEC3ACKc4vTf45impSN/9KSxGKpSSXdE=;
  b=VaD7QPWjpmyHhd1RG6fkoJw1W0c0hWzY1gFS91e9u7RUmHUePVH8Zbjb
   PMCYa5REKxp8MV3o0TzRyRBI/bLK/+DRX+oOo4rhrneAmDp2CJv+knIP4
   IwNIz1RAhaFpGZc1LC72yMzlfmIyM1ZAJFjLh/9xGNkrNbqBi+dKACDz+
   fK/fI/sfiC6B5UwbjL9zVmyjbPr445oBWbCt0mHY47+EDn5B3y9oWr/14
   PofewxOJgJOKB7XWb3piAMGBMFN+C2/NC46DaTNCQTxYrBKVim607W25k
   biMCn3lLPjcWjrGHxxpHD69e/K/sMPhoufaHyh2boHGxeH+X3K5rCsviS
   Q==;
X-CSE-ConnectionGUID: 5Z2Cx1BaQrGkbKttMTf3mQ==
X-CSE-MsgGUID: IBha3kxnRiyISvoGH8fevQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38516285"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="38516285"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:13:05 -0800
X-CSE-ConnectionGUID: gTefJzkQSqetmzqanNeLug==
X-CSE-MsgGUID: Nkgv6GmrSMqITLnq0elToQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="128012013"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 06:13:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Dec 2024 16:12:59 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v2 2/3] PCI: Honor Max Link Speed when determining
 supported speeds
In-Reply-To: <0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
Message-ID: <ceb3c702-1465-e7a9-e7fd-c5b1c7accc50@linux.intel.com>
References: <cover.1734257330.git.lukas@wunner.de> <0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-565403366-1734355451=:941"
Content-ID: <56a0436b-7a7a-1e95-0639-7b8f33bb23de@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-565403366-1734355451=:941
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <b089f2e4-2825-0a21-c3c9-4f1ec61b791c@linux.intel.com>

On Sun, 15 Dec 2024, Lukas Wunner wrote:

> The Supported Link Speeds Vector in the Link Capabilities 2 Register
> indicates the *supported* link speeds.  The Max Link Speed field in
> the Link Capabilities Register indicates the *maximum* of those speeds.
>=20
> pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> and will thus incorrectly deem higher speeds as supported.  Fix it.
>=20
> One user-visible issue addressed here is an incorrect value in the sysfs
> attribute "max_link_speed".
>=20
> But the main motivation is a boot hang reported by Niklas:  Intel JHL7540
> "Titan Ridge 2018" Thunderbolt controllers supports 2.5-8 GT/s speeds,
> but indicate 2.5 GT/s as maximum.  Ilpo recalls seeing this on more
> devices.  It can be explained by the controller's Downstream Ports
> supporting 8 GT/s if an Endpoint is attached, but limiting to 2.5 GT/s
> if the port interfaces to a PCIe Adapter, in accordance with USB4 v2
> sec 11.2.1:
>=20
>    "This section defines the functionality of an Internal PCIe Port that
>     interfaces to a PCIe Adapter. [...]
>     The Logical sub-block shall update the PCIe configuration registers
>     with the following characteristics: [...]
>     Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput. Throughput
>     is implementation specific and based on the USB4 Fabric performance."
>=20
> The present commit is not sufficient on its own to fix Niklas' boot hang,
> but it is a prerequisite.
>=20
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Reported-by: Niklas Schnelle <niks@kernel.org>
> Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d136=
9.camel@kernel.org/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ab0ef7b6c798..9f672399e688 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6247,6 +6247,10 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  =09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
>  =09speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
> =20
> +=09/* Ignore speeds higher than Max Link Speed */
> +=09speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS,
> +=09=09=09  PCI_EXP_LNKCAP2_SLS_2_5GB);

You pass a value instead of bit position to GENMASK() which is not=20
correct way to use GENMASK(). You need to do either:

=09=09=09  ilog2(PCI_EXP_LNKCAP2_SLS_2_5GB)
or
=09=09=09  __ffs(PCI_EXP_LNKCAP2_SLS)=20

(Technically, also __ffs(PCI_EXP_LNKCAP2_SLS_2_5GB) would work).

+ Please check the correct header is included depending on which you pick.

> +
>  =09/* PCIe r3.0-compliant */
>  =09if (speeds)
>  =09=09return speeds;
>=20

--=20
 i.
--8323328-565403366-1734355451=:941--

