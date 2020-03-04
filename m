Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D158178F87
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgCDLZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 06:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:40210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgCDLZm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 06:25:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01303AC77;
        Wed,  4 Mar 2020 11:25:40 +0000 (UTC)
Message-ID: <720dd2a49b6efea353367effe25c29ebb4c9aa23.camel@suse.de>
Subject: Re: [PATCH v3 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     f.fainelli@gmail.com, Mathias Nyman <mathias.nyman@intel.com>,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Wed, 04 Mar 2020 12:25:39 +0100
In-Reply-To: <20200304090555.GC1429273@kroah.com>
References: <20200302155528.19505-1-nsaenzjulienne@suse.de>
         <20200302155528.19505-5-nsaenzjulienne@suse.de>
         <20200304090555.GC1429273@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-P5OQO7Po4GtPGRWMR0Yz"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-P5OQO7Po4GtPGRWMR0Yz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-04 at 10:05 +0100, Greg KH wrote:
> On Mon, Mar 02, 2020 at 04:55:28PM +0100, Nicolas Saenz Julienne wrote:
> > @@ -1243,11 +1246,26 @@ static void quirk_usb_handoff_xhci(struct pci_d=
ev
> > *pdev)
> > =20
> >  static void quirk_usb_early_handoff(struct pci_dev *pdev)
> >  {
> > +	int ret;
> > +
> >  	/* Skip Netlogic mips SoC's internal PCI USB controller.
> >  	 * This device does not need/support EHCI/OHCI handoff
> >  	 */
> >  	if (pdev->vendor =3D=3D 0x184e)	/* vendor Netlogic */
> >  		return;
> > +
> > +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_VIA && pdev->device =3D=3D 0x34=
83) {
> > +		ret =3D rpi_firmware_init_vl805(pdev);
> > +		if (ret)
> > +			/*
> > +			 * Firmware might be outdated, or else, something
> > +			 * failed, keep going and hope for the best.
> > +			 */
> > +			dev_warn(&pdev->dev,
> > +				 "Failed to load VL805's firmware: %d\n",
> > +				 ret);
>=20
> {} please.
>=20
> Also, you might want to provide a better warning, something like:
> 	"Failed to load VL805's firmware, will continue to attempt to
> 	work, but bad things might happen, you should fix this..."
>=20
> or something to give people a chance to know what to do here.

Noted

Thanks,
Nicolas


--=-P5OQO7Po4GtPGRWMR0Yz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5fkDMACgkQlfZmHno8
x/7MtAf8CcxhF9NY9+Rz70jvj0WDqPx3fSwK9zhR2dRTvjZnvANlYSMO5C+3TMDs
93AzERTD0PYCma+vaOy0dWKyfDNixuWdYTD88a5Z5Z9dbu0NhViE+x1CtE9lVVlp
6eqFpj+3oR9QiB4bsoRECcsfzGhVGrTOIQhNjkIxghDwDTrN7gjFzZy/d1VGToFU
/SLh8F2KMjErxbE4x1MkDHiaXJr8OD9la8SfQ5w4Yi/YgMJhpp+2kin0A2p85JMf
HB3uIDMVrqkTT57Ayk6qTbJocMKd7r0sX7X2rdUEtoI/jkX1uaAhETlVDJv43MM2
a9oF+6wL2C8gTCegxH5BSpp5ittxBA==
=sAjn
-----END PGP SIGNATURE-----

--=-P5OQO7Po4GtPGRWMR0Yz--

