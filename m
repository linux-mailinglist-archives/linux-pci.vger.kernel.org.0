Return-Path: <linux-pci+bounces-17923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF29E95B9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50B716595D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D363595E;
	Mon,  9 Dec 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Emm/6mDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420235959;
	Mon,  9 Dec 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749160; cv=none; b=EXwwnuWhd2wr5pAkGcbHb4I4Dn+WcNHoImAA3vfBcP1nOCM1w8XbbgKfTCe+KgNq+e8AemvlcwfKfKXzLQ7b7kUZ61SxqeBeZ80DJkTA6X6aVKPxZSUZDj7GVTWlJIFYC0f9D3zEhnzsm89nZOz9rG15Aak2rgKKhc0Lr6MzOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749160; c=relaxed/simple;
	bh=Cm2fR0YHLhUCian+6aRdruvKehg4LBkMWZFDaZSAWtU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sLF8I1TdprnmH2wqEB5n9PYaIzLBqyuB0wfztoKjyOCRAH+oqRmk1urXOwguXVEaruqP6EmMALLH91v4yyUJy5XXoaeExiFwA/NPdQSFtt0futbDSEr18ZAjLeTHaoQuXTRVHei9j34e07VUXUy01ydBwsodpjad2z+bjOsmObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Emm/6mDl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733749159; x=1765285159;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Cm2fR0YHLhUCian+6aRdruvKehg4LBkMWZFDaZSAWtU=;
  b=Emm/6mDlyTdUZtWNgMCv9tIVJH/mEzNzhN4l/8MxO4j5Hdln/ZE21Yw6
   EySnHNVIHMTpKXHcLIMalI9BIpn2z/JExG/GAm4xWvNCrlmgcN+SkGAa8
   ajmLEAxiOfo3bhF1Akcn8NdxVMvxK4eaEHZxUeAO8yr/iMKh+ECb4UtOq
   D4zBjeec9i/U4iz0zJfYG2rwiiqJBL0qX+gtv56acdTr4zFVHF45eHR4+
   JWa9NsqZjQNEuWKllCoQhlQUTWar0bDBjy7rqG0lpUb44I99p7f0ANOUQ
   DvWIGxS9pVzh9M78jzM1V4uJECaN+DUo/IJC9IZaWWObatDRRFNCMg+r+
   w==;
X-CSE-ConnectionGUID: eut4JBffSEyx0L59gwibDA==
X-CSE-MsgGUID: SP7Ka5FrRiOlYK8FsgfKUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33957162"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33957162"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:59:16 -0800
X-CSE-ConnectionGUID: woeuFxg2TZK100U663v8zw==
X-CSE-MsgGUID: 1nbLFhzhSB6nytS710buTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94744228"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:59:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Dec 2024 14:59:07 +0200 (EET)
To: Niklas Schnelle <niks@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
In-Reply-To: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
Message-ID: <21fa32ff-73d0-5446-2d9b-ef1f8fccad8a@linux.intel.com>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-429414955-1733749055=:938"
Content-ID: <0dccd60f-1241-d533-3b08-32aed886f505@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-429414955-1733749055=:938
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <22e425b1-b0d2-3b26-9867-728153f62360@linux.intel.com>

On Sat, 7 Dec 2024, Niklas Schnelle wrote:

> Trying to enable bwctrl on a Thunderbolt port causes a boot hang on some
> systems though the exact reason is not yet understood. As per the spec
> Thunderbolt PCIe Downstream Ports have a fake Max Link Speed of 2.5 GT/s
> (USB4 v2 sec 11.2.1):
>=20
>    "Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput.
>     Throughput is implementation specific and based on the USB4 Fabric
>     performance."
>
> More generally if 2.5 GT/s is the only supported link speed there is no
> point in throtteling as this is already the lowest possible PCIe speed
> so don't advertise the capability stopping bwctrl from being probed on
> these ports.

Hi,

Thanks for finding the reason this far.

Mika mentioned earlier to me this Link Speed stuff is all made up on=20
Thunderbolt but I didn't make any changes back then because I thought=20
bwctrl is not going to change the speed anyway in that case.

Seem reasonable way to workaround the Thunderbold problem and agreed,=20
there's not much point in adding bwctrl for 2.5GT/s only ports.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Signed-off-by: Niklas Schnelle <niks@kernel.org>
> ---
> Note: This issue causes a boot hang on my personal workstation see the
> Link for details.
> ---
>  drivers/pci/pcie/portdrv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 5e10306b63081b1ddd13e0a545418e2a8610c14c..e5f80e4a11aad4ce60b2ce998=
b40ec9fda8c653d 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -270,7 +270,8 @@ static int get_port_device_capability(struct pci_dev =
*dev)
>  =09=09u32 linkcap;
> =20
>  =09=09pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> -=09=09if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +=09=09if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +=09=09    (linkcap & PCI_EXP_LNKCAP_SLS) !=3D PCI_EXP_LNKCAP_SLS_2_5GB)
>  =09=09=09services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  =09}
> =20
>=20
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241207-fix_bwctrl_thunderbolt-bd1f96b3d98f
>=20
> Best regards,
>=20
--8323328-429414955-1733749055=:938--

