Return-Path: <linux-pci+bounces-17883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A21C9E81C2
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 20:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C76A18845FE
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43B114AD1A;
	Sat,  7 Dec 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENf0b0WJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BA1DFE1;
	Sat,  7 Dec 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733598769; cv=none; b=sK7yBPwgcPaEL6d4JEeTTcZzqisAUTAOkM//CaSK+jDyq5l/T7ITc1YfI4t/OJC7NGOlgki3ZUFCyb3efLeKN5TW8ETc5AVV2o6aJUwPbYCAfKYeMrUtHOMgOaEtMafg7WQuGkq9zKXzYHPzG6kdbDzMF6rHJvxQN5O4asVYQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733598769; c=relaxed/simple;
	bh=yQCxNOWpYE2zP8GWmjAnXVSizgiFV2VCzR6S0gikH70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juuZOvRD6Q6phj220OB2DBpqV2msrNYEgdOjKRUH7zM4vfcgzsWxRtLtTlz/Pqo+YH73okHeMtbLhJL6ZvizWi3xdzjFamZKmWbOmF95+2P7Kt5/9BbPT5dZgvWSnGw/zTlivnHO/54hRiqQV/uHa1SPpu4CoGzAyesPySIJybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENf0b0WJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AD5C4CECD;
	Sat,  7 Dec 2024 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733598769;
	bh=yQCxNOWpYE2zP8GWmjAnXVSizgiFV2VCzR6S0gikH70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ENf0b0WJJ1ZKIi2x4vpHoVx0nPfNagLn7YZtKGiXg9CgjJB3ALJ9SAUPtkt1u6MIu
	 oUGBE0tSvppAx2OZpAHojW+Yj9s4J5h4kPJ3U8OX4InffYEXF+hEVJCdo+3slmrB4G
	 lcA+1TnGGTwwZblpisjYwKEOpbHXL0JXqCV7l9kmxiFySZoKjTygTLBass4dBd1V7H
	 FesLWhMEr7P6nc7wEMxOd/tq5gzY2V5CAPDGLojNz2VM+FcH+K6AeYp9/9hJK+iFvn
	 hBJNKAdkWa0955asAQ7cRpgt2HM+6hM0HfJn01x7xP35E/dHO1+mWZqNlGPpBvoA/C
	 0S9desoLfMN7w==
Message-ID: <ed3dc3e668ebc54f347986bc2cacbcb53300f8ce.camel@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=	 <kw@linux.com>, "Maciej W . Rozycki"
 <macro@orcam.me.uk>, Jonathan Cameron	 <Jonathan.Cameron@huawei.com>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>,  Krishna chaitanya chundru	
 <quic_krichai@quicinc.com>, Srinivas Pandruvada	
 <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, 	linux-pm@vger.kernel.org, Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Lukas Wunner <lukas@wunner.de>
Date: Sat, 07 Dec 2024 20:12:43 +0100
In-Reply-To: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-12-07 at 19:44 +0100, Niklas Schnelle wrote:
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
>=20
> More generally if 2.5 GT/s is the only supported link speed there is no
> point in throtteling as this is already the lowest possible PCIe speed
> so don't advertise the capability stopping bwctrl from being probed on
> these ports.
>=20
> Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Signed-off-by: Niklas Schnelle <niks@kernel.org>

Should probably add but forgot:
Suggested-by: Lukas Wunner <lukas@wunner.de>

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
>  		u32 linkcap;
> =20
>  		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +		    (linkcap & PCI_EXP_LNKCAP_SLS) !=3D PCI_EXP_LNKCAP_SLS_2_5GB)
>  			services |=3D PCIE_PORT_SERVICE_BWCTRL;
>  	}
> =20
>=20
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241207-fix_bwctrl_thunderbolt-bd1f96b3d98f
>=20
> Best regards,


