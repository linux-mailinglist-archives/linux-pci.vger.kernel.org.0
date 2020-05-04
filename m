Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819701C3526
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgEDI7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 04:59:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgEDI7e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 04:59:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E65D5ACF1;
        Mon,  4 May 2020 08:59:33 +0000 (UTC)
Message-ID: <d105712418b93ebce7c0498d05eea77171892366.camel@suse.de>
Subject: Re: [PATCH v7 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, helgaas@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, f.fainelli@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, RayJui <rjui@broadcom.com>,
        ScottBranden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Date:   Mon, 04 May 2020 10:59:29 +0200
In-Reply-To: <5fce05ca-5d7e-f4cc-be34-0764fbe4edff@gmx.net>
References: <20200429164734.21506-1-nsaenzjulienne@suse.de>
         <20200429164734.21506-3-nsaenzjulienne@suse.de>
         <5fce05ca-5d7e-f4cc-be34-0764fbe4edff@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xrGwwQwF9+uJnqYpmvFb"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-xrGwwQwF9+uJnqYpmvFb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan, thanks for the review!

On Sat, 2020-05-02 at 11:05 +0200, Stefan Wahren wrote:
> > +	/* Make sure we don't trigger a firmware load unnecesarely *
> s/unnecesarely/unnecessarily/

Noted

> > +	pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET, &version=
);
> pci_read_config_dword() can fail, we might want to store the return value=
?

I planned on doing that, but realised that the vast majority of
pci_read_config_*() users pass on checking for errors.

Bjorn, any rule of thumb on when to check for errors here?

> > +	if (version)
> > +		goto exit;
> > +
> > +	dev_addr =3D pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> > +		   PCI_FUNC(pdev->devfn) << 12;
> > +
> > +	ret =3D rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> > +				    &dev_addr, sizeof(dev_addr));
> > +	/* Wait for vl805 to startup */
> > +	udelay(200);
>=20
> I know, it makes it harder to read but do we really want to wait
> unnecessarily if rpi_firmware_property failed?

Yes, I figured that it wouldn't hurt much at that faulty state, and you'll =
be
waiting some extra 5s further down the line in quirk_usb_handoff_xhci().

But if you feel it's more correct I'll be happy to change it.

> Btw i assume we are in non-atomic context, so maybe it's worth to use
> usleep_range() here?

Of course, I'll fix that.

Regards,
Nicolas


--=-xrGwwQwF9+uJnqYpmvFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6v2XEACgkQlfZmHno8
x/6tJQgAqKxAf6yuXPyZ70bzD6f9Lw8O516dwBki+Md23tM1+Fw/cmdCe77tbMgq
d0xAlhNfnHxXiXWLX3+C5jEGn7rJyVAjLHZx8JC+uPrGZyuZMPHfxRwBwLglkkIt
U4B07Kan2MZRiQ1ZQ3jlpzEXvNfGl7KpComy8U/fPad8wpGXqZjIy1e+rlQO9FEg
1weKYQIGSSdJSK2hIlnMPVLw9o342QE6KL7DCxV025ttlasor0mavVvfdX+HYRns
fDtXerc+8wWRTNwusO4f5Zd/7GS1mAPYOYSUHrSMzT5rkSS5rDTfT33hQLUKFIaB
bsGjvNxDJbG1cPJFfYYStNo4Id0Oqg==
=Vbo6
-----END PGP SIGNATURE-----

--=-xrGwwQwF9+uJnqYpmvFb--

