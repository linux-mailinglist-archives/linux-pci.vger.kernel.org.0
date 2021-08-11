Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1232A3E8D8D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhHKJvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 05:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhHKJvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 05:51:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9AC061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 02:51:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDktP-0000qM-4V; Wed, 11 Aug 2021 11:51:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDktN-0000bd-JH; Wed, 11 Aug 2021 11:51:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDktN-0003Cy-IH; Wed, 11 Aug 2021 11:51:21 +0200
Date:   Wed, 11 Aug 2021 11:51:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 3/8] xen/pci: Drop some checks that are always true
Message-ID: <20210811095119.qxwhsexayjq6xhmx@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjjcl33e7y7yovv7"
Content-Disposition: inline
In-Reply-To: <20210811080637.2596434-4-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rjjcl33e7y7yovv7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This mail didn't reach all intended recipients as there was a newline at
the wrong place in the input for git send-email. I fixed this up for
this reply, please make sure to do the same if you reply to this patch.
The other patches in this thread should be fine. I'm keeping the mail
content below to facilitate replying.

Sorry for the inconvenience,
Uwe

On Wed, Aug 11, 2021 at 10:06:32AM +0200, Uwe Kleine-K=F6nig wrote:
> pcifront_common_process() has a check at the start that exits early if
> pcidev or pdidev->driver are NULL. So simplify the following code by not
> checking these two again.
>=20
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/xen-pcifront.c | 57 +++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index b7a8f3a1921f..3c648e6cb8f8 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -591,7 +591,6 @@ static pci_ers_result_t pcifront_common_process(int c=
md,
>  	int devfn =3D pdev->sh_info->aer_op.devfn;
>  	int domain =3D pdev->sh_info->aer_op.domain;
>  	struct pci_dev *pcidev;
> -	int flag =3D 0;
> =20
>  	dev_dbg(&pdev->xdev->dev,
>  		"pcifront AER process: cmd %x (bus:%x, devfn%x)",
> @@ -606,40 +605,34 @@ static pci_ers_result_t pcifront_common_process(int=
 cmd,
>  	}
>  	pdrv =3D pcidev->driver;
> =20
> -	if (pdrv) {
> -		if (pdrv->err_handler && pdrv->err_handler->error_detected) {
> -			pci_dbg(pcidev, "trying to call AER service\n");
> -			if (pcidev) {
> -				flag =3D 1;
> -				switch (cmd) {
> -				case XEN_PCI_OP_aer_detected:
> -					result =3D pdrv->err_handler->
> -						 error_detected(pcidev, state);
> -					break;
> -				case XEN_PCI_OP_aer_mmio:
> -					result =3D pdrv->err_handler->
> -						 mmio_enabled(pcidev);
> -					break;
> -				case XEN_PCI_OP_aer_slotreset:
> -					result =3D pdrv->err_handler->
> -						 slot_reset(pcidev);
> -					break;
> -				case XEN_PCI_OP_aer_resume:
> -					pdrv->err_handler->resume(pcidev);
> -					break;
> -				default:
> -					dev_err(&pdev->xdev->dev,
> -						"bad request in aer recovery "
> -						"operation!\n");
> -
> -				}
> -			}
> +	if (pdrv->err_handler && pdrv->err_handler->error_detected) {
> +		pci_dbg(pcidev, "trying to call AER service\n");
> +		switch (cmd) {
> +		case XEN_PCI_OP_aer_detected:
> +			result =3D pdrv->err_handler->
> +				 error_detected(pcidev, state);
> +			break;
> +		case XEN_PCI_OP_aer_mmio:
> +			result =3D pdrv->err_handler->
> +				 mmio_enabled(pcidev);
> +			break;
> +		case XEN_PCI_OP_aer_slotreset:
> +			result =3D pdrv->err_handler->
> +				 slot_reset(pcidev);
> +			break;
> +		case XEN_PCI_OP_aer_resume:
> +			pdrv->err_handler->resume(pcidev);
> +			break;
> +		default:
> +			dev_err(&pdev->xdev->dev,
> +				"bad request in aer recovery "
> +				"operation!\n");
>  		}
> +
> +		return result;
>  	}
> -	if (!flag)
> -		result =3D PCI_ERS_RESULT_NONE;
> =20
> -	return result;
> +	return PCI_ERS_RESULT_NONE;
>  }
> =20
> =20
> --=20
> 2.30.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rjjcl33e7y7yovv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmETnZEACgkQwfwUeK3K
7AngaAgAhEohc3nPXbwySEwZbfw6RPi2g6gRtdXlaRxqTxqb0JZ11qNwa6bM0v9W
b8nEtOl3bkpqXI9s5UBip3TmvluoVEiSvG84QigbZoj3DkgDa80it/20WZE9FTcT
7Gy9JlF0K4hHt4ui/1kUfdB5fwHvFjU+Sa7/j/2zBZlxFeBanU4MbxNRu92g75ny
P3QVqNa7HlqxvWAzdr0Ris9qd04mIDHkeuelBKtxWKTDrVN997meU+WexFOrdHd0
Y7CKpGvAJDlJdBHs40/d1zt9kLrd/XpV2PXxWY+HmeWTQfna1W59H64mwe84G2zb
vreJoLkUUhMYD/VSOLW8TgN33oZERA==
=rzAP
-----END PGP SIGNATURE-----

--rjjcl33e7y7yovv7--
