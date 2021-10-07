Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79362424F3B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhJGI0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 04:26:05 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41438 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbhJGI0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 04:26:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C51E71C0B87; Thu,  7 Oct 2021 10:24:10 +0200 (CEST)
Date:   Thu, 7 Oct 2021 10:24:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     stuart hayes <stuart.w.hayes@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        mariusz.tkaczyk@linux.intel.com
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
Message-ID: <20211007082410.GA15698@duo.ucw.cz>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
 <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
 <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Thank you for the comments, Dan.
> >
> > I originally did submit something simple that just added a couple of
> > sysfs attributes to allow userspace access to the _DSM, but Greg K-H
> > said (1) that I shouldn't create new driver-specific sysfs files that do
> > things that existing class drivers do, and that if I'm allowing LEDs to
> > be controlled by the user, I have to use the LED subsystem, so I went
> > with that. (See the end of
> > https://patchwork.ozlabs.org/project/linux-pci/patch/20201110153735.585=
87-1-stuart.w.hayes@gmail.com/)
>=20
> I agree with the general sentiment to adopt and extend existing ABIs
> wherever possible, it's just not clear to me that the LED class driver
> is the best fit. The Enclosure class infrastructure, in addition to

LED drivers are not good fit for this. It is unlikely to be accepted.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYV6uqgAKCRAw5/Bqldv6
8pX/AKCudWgskrUbWQ1QmnLvqNkKxOlaPgCfU6mC54N8D2e/929nAEUBxg53nKw=
=a4CR
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
