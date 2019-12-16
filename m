Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCC120172
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 10:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLPJtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 04:49:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:43718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfLPJtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 04:49:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D467AF13;
        Mon, 16 Dec 2019 09:49:11 +0000 (UTC)
Message-ID: <6384f1dac3bfbcad625138b2d528b1855c4a92a0.camel@suse.de>
Subject: Re: [PATCH v4 2/8] ARM: dts: bcm2711: Enable PCIe controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        eric@anholt.net, mbrugger@suse.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        maz@kernel.org, andrew.murray@arm.com, linux@endlessm.com,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Mon, 16 Dec 2019 10:49:08 +0100
In-Reply-To: <20191216064638.5067-1-jian-hong@endlessm.com>
References: <20191203114743.1294-3-nsaenzjulienne@suse.de>
         <20191216064638.5067-1-jian-hong@endlessm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ca9uKgWQRdtwH/iqxJQ5"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-ca9uKgWQRdtwH/iqxJQ5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jian-Hong,
On Mon, 2019-12-16 at 14:46 +0800, Jian-Hong Pan wrote:
> Thanks for your effort! System can have USB with this patch series, if th=
e

:)

> device tree is modified properly.
> Here is the question: Will not the device tree "scb/ranges" in this patch
> conflict with commit be8af7a9e3cc ("ARM: dts: bcm2711-rpi-4: Enable GENET
> support")?

You're right, the patch needs to be refreshed.

I'm going to send a v5 of the series factoring out all the log2.h changes, =
and
addressing this.

Regards,
Nicolas


--=-ca9uKgWQRdtwH/iqxJQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl33UxQACgkQlfZmHno8
x/5qZAgAspvPWdeld7fMjDA7RgPcepOG/7Tlr7qM5Pj4OqiMED5mmllk/dlq9t9v
I2VQp6/JpG1KuEjaSQdy7i+0xJrQsl9NAKUyqDnp704MXqpLHa7prZUehxuIsyGf
jvVThTMIcdp8/XBp5QfuuVIZ/6DkCh0eg/P1f/SXsImRR6waGSprkWfertIMgf+L
nKsupBFPruKtVSAUPuI33r8TvQxRJsU7qdMQ+djmPI6CpChYtzFfUk0xqYHvgGKB
B8h+kjrZLw1G4rlN8o0BMgnO8EX/fvuH3kKMYMpQAxWAlRoMfbcu7vFg+uiaOY/t
2RDihMFD4GAnIcNHrU0l5J8RKBGkVA==
=WVjN
-----END PGP SIGNATURE-----

--=-ca9uKgWQRdtwH/iqxJQ5--

