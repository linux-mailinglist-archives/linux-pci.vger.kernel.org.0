Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D5841B3A3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhI1QUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 12:20:33 -0400
Received: from algol.kleine-koenig.org ([162.55.41.232]:32770 "EHLO
        algol.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbhI1QUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 12:20:32 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 12:20:32 EDT
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 2365FDA7E6;
        Tue, 28 Sep 2021 18:08:34 +0200 (CEST)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id q6a2vnLQ04YA; Tue, 28 Sep 2021 18:08:33 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:f270:5eb7:2fb1:f48a])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Tue, 28 Sep 2021 18:08:33 +0200 (CEST)
Subject: Re: [PATCH v4 6/8] crypto: qat - simplify adf_enable_aer()
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marco Chiappero <marco.chiappero@intel.com>,
        linux-pci@vger.kernel.org, qat-linux@intel.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        Jack Xu <jack.xu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
 <20210927204326.612555-7-uwe@kleine-koenig.org>
 <YVL4aoKjUT2kvHip@silpixa00400314>
 <20210928112637.kolit6fusme7g2qf@pengutronix.de>
 <20210928135704.oqyffwwt4lvmmlx3@pengutronix.de>
 <YVMuTMMzPSyCBSVS@silpixa00400314>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <ef5c117d-6264-ecb1-1e6c-4d228ad67071@kleine-koenig.org>
Date:   Tue, 28 Sep 2021 18:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVMuTMMzPSyCBSVS@silpixa00400314>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ddnd7TGziuneUnVkzI0ocXpZiGVNywx7"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ddnd7TGziuneUnVkzI0ocXpZiGVNywx7
Content-Type: multipart/mixed; boundary="lYGl9vD3ujjsKATJI2zM64TZqJJXwpkLB";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fiona Trahe <fiona.trahe@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Marco Chiappero <marco.chiappero@intel.com>, linux-pci@vger.kernel.org,
 qat-linux@intel.com, Bjorn Helgaas <helgaas@kernel.org>,
 linux-crypto@vger.kernel.org, kernel@pengutronix.de,
 Jack Xu <jack.xu@intel.com>, Wojciech Ziemba <wojciech.ziemba@intel.com>,
 Tomaszx Kowalik <tomaszx.kowalik@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>
Message-ID: <ef5c117d-6264-ecb1-1e6c-4d228ad67071@kleine-koenig.org>
Subject: Re: [PATCH v4 6/8] crypto: qat - simplify adf_enable_aer()
References: <20210927204326.612555-1-uwe@kleine-koenig.org>
 <20210927204326.612555-7-uwe@kleine-koenig.org>
 <YVL4aoKjUT2kvHip@silpixa00400314>
 <20210928112637.kolit6fusme7g2qf@pengutronix.de>
 <20210928135704.oqyffwwt4lvmmlx3@pengutronix.de>
 <YVMuTMMzPSyCBSVS@silpixa00400314>
In-Reply-To: <YVMuTMMzPSyCBSVS@silpixa00400314>

--lYGl9vD3ujjsKATJI2zM64TZqJJXwpkLB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/28/21 5:01 PM, Giovanni Cabiddu wrote:
> On Tue, Sep 28, 2021 at 03:57:04PM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> I fixed it now, comparing with your patch the only thing I did
>> differently is ordering in the header file.
>>
>> I pushed the fixed series to
>>
>> 	https://git.pengutronix.de/git/ukl/linux pci-dedup
> Would you mind sending the new version to the ML?

No, I don't mind. I will just wait a bit more for more feedback and not=20
to annoy in a high frequency :-)

Best regards
Uwe


--lYGl9vD3ujjsKATJI2zM64TZqJJXwpkLB--

--7ddnd7TGziuneUnVkzI0ocXpZiGVNywx7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFTPfMACgkQwfwUeK3K
7AndQAf+JG4o+6zDVw/wM85fTeADGBQt25SZRp/GmUHC2YHqq6u7J6Krb2ps2qL2
FUdmgbisaDSLRB6U4Pwa9RfYSsCeUR/gN0rVupBIaDPTlAM0U18IhSnw6I28NvbQ
tMKyviVCJl9Oz+2TbmeRbN5DgecLCVpPniKNBd13CUsgJnp/PsJ6yBmo5i0r1gkX
B7nGGJPQ3bogH2XrxGyCztm41/NGjHvx3HDuKcxnulBY/bS7Vlth7YpgJt4wrxhw
JmYPFWxnVIDGISdQJjgmH+lu00qo/Sklf3A+rYwuhWivjzfXCceYmjICn5kfesrH
FeDXP/N3WWiyGtOacvgDWfHXjmlKxQ==
=xPHG
-----END PGP SIGNATURE-----

--7ddnd7TGziuneUnVkzI0ocXpZiGVNywx7--
