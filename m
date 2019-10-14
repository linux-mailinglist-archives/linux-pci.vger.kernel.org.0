Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED9D5D46
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfJNIU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 04:20:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10985 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfJNIU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 04:20:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da42fcf0000>; Mon, 14 Oct 2019 01:20:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Oct 2019 01:20:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Oct 2019 01:20:27 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 08:20:26 +0000
Received: from localhost (10.124.1.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct 2019 08:20:26
 +0000
Date:   Mon, 14 Oct 2019 10:20:23 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191014082023.GA232162@ulmo>
References: <20191005182129.32538-1-vidyas@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20191005182129.32538-1-vidyas@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571041231; bh=3R3NhNbrwBjleRgLhoTnWJZLBZ7SGWD1nQCPrLJD/iw=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=lXfj/XFo+iJJIDbILjAXEtl46HbuTAeJWK05/E1FcN144vfzDqb1s9Y5r7ShSEnYx
         hF8y4kxQ9Nd4IrZzUCRJxiRW8j6exw6no/4mzJbgd+XJI/02HhkY/sqhNuzak9K7lj
         n5tOw5BGV+7ZMiOs74oHHN5QNUmhqg5gtBDWL8va8EGnRuO2A3QXnUWeiHI3mxrrW8
         oTlk5GvUVbNdcVTWvWbSO9/rr93KOalCRKaop0DO65dJUXKz+wdlu188G+ddHqUlp6
         79oLMfVHbRGuuN4SHBNK+xSgBd/4oStEKTb7ShlucK3jdASJlgqK5zHuaaTb4Gt+f9
         b4zq8jV+uhq/g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2019 at 11:51:29PM +0530, Vidya Sagar wrote:
> Adds a 60 seconds timeout to consider CRS (Configuration request Retry
> Status) from a downstream device when Vendor ID read is attempted by
> an upstream device. This helps to work with devices that return CRS
> during system resume. This also makes pci_device_is_present() consistent
> with the probe path where 60 seconds timeout is already being used.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pci.c   | 3 ++-
>  drivers/pci/pci.h   | 2 ++
>  drivers/pci/probe.c | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)

I think this makes sense, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

However, it looks like Sinan has researched this extensively in the past
and gave a presentation on this at Plumbers in 2017:

	https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4732/orig=
inal/crs.pdf

Adding Sinan to see if he has any concerns about this, since resume time
is explicitly mentioned in the above slides.

Thierry

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95dc78ebdded..3ab9f6d3c8a6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
> =20
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
> -	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> +	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v,
> +					  PCI_CRS_TIMEOUT);
>  }
>  EXPORT_SYMBOL_GPL(pci_device_is_present);
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f6947ee3324..aa25c5fdc6a5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -4,6 +4,8 @@
> =20
>  #include <linux/pci.h>
> =20
> +#define PCI_CRS_TIMEOUT		(60 * 1000)	/* 60 sec*/
> +
>  #define PCI_FIND_CAP_TTL	48
> =20
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7c5d68b807ef..6e44a03283c8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2258,7 +2258,7 @@ static struct pci_dev *pci_scan_device(struct pci_b=
us *bus, int devfn)
>  	struct pci_dev *dev;
>  	u32 l;
> =20
> -	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
> +	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, PCI_CRS_TIMEOUT))
>  		return NULL;
> =20
>  	dev =3D pci_alloc_dev(bus);
> --=20
> 2.17.1
>=20

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kL8UACgkQ3SOs138+
s6Gn4Q//VxI/PVxz+a9QSqpPhLaanrs3PZ6+rriFTOto/X/uePSP5UQeFQQDRSfs
WlJf6SiZtENNc/tagAfFXrFqLdevt3LBYEZNS6FB7ecWArOvUFnfpqkpAqm5fBwz
ZalLJNwX8USeUlkWNsxamRSJmQiqT1aWejM5eOd/oVLXXYb9M0jK9T1OVSQQJrMB
vbFqn510ya7LVIr0gJKWYpsULh3XX1HGtdGHg21xua/IUk7M3qGFTPa+Los+Q8tg
p5czrOjJci+ibeGt1pac7kYpc+KNbqcGJEAttU2cwUuJfMctOeneWyTac9aw1q8L
Qr4jY4IwWtC5Qgi0sOg3pI4Q5FIFxUqJ5Qmk9wzb4EhTC0BDxb4E6F3wPEFqIW5K
qdrDH6jxFrUssHTyrrL0JO9B5b5o0SSBD/r5L05BkPBHPkKD+5Mo9achnjqpm356
rYqyWfrax2iUP8Y3x1F+T92PDfi1iCsFbM/S5n9gU0XcgCZRS6UxCHmE+CH48lY4
XIDDStEjjsNqBgr6Xd1KcX03W5I8bGYkAZ9cGvo4/f5aJnFSQ1AJpMbTitoTU/o8
8kLNxWd/fNjSOhpTvlMHSWSfnNKaP285SriQ9r5KHj/CCdbWQgotTueLnVdhGxao
XiyNQmHc+/75/0t3dap30gforBnMPdLK8B2vioY1laGsBzKKLsc=
=c9H9
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
