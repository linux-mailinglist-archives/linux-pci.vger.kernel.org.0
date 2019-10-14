Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D14D6ABD
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfJNUVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 16:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730516AbfJNUVr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 16:21:47 -0400
Received: from [10.70.64.60] (unknown [131.107.174.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9A52089C;
        Mon, 14 Oct 2019 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571084506;
        bh=SuHH7U+mH5t8+WPj4WHqZ77uVgHzmvvuMqsGrvYjbwY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O2H61VSk3P2HhZl/74rQEy5kCPj3IWODFVPYAvy4oxICtH7zqLtzt9xqHzw6RA5O+
         7smS6NcXQw/9BqBIQqyHUN1zpMq/z/EMInxI0KHuNZtHqgXn83oAvyFOSgQvdxfgUm
         IcjsKP1Q3iSiCEReB6smysATFpbYUwmymkBzZJwk=
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
From:   Sinan Kaya <okaya@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
Date:   Mon, 14 Oct 2019 13:21:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014082023.GA232162@ulmo>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UylE6D3vf4eFGBaP2VPSPvTV9RZDgIgTb"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UylE6D3vf4eFGBaP2VPSPvTV9RZDgIgTb
Content-Type: multipart/mixed; boundary="VAe2OGdce5xvOR23JKi06E8SmqdiLjPcX";
 protected-headers="v1"
From: Sinan Kaya <okaya@kernel.org>
To: Thierry Reding <treding@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
Message-ID: <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
In-Reply-To: <20191014082023.GA232162@ulmo>

--VAe2OGdce5xvOR23JKi06E8SmqdiLjPcX
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/14/2019 1:20 AM, Thierry Reding wrote:
> I think this makes sense, so:
>=20
> Reviewed-by: Thierry Reding <treding@nvidia.com>
>=20
> However, it looks like Sinan has researched this extensively in the pas=
t
> and gave a presentation on this at Plumbers in 2017:
>=20
> 	https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4732/=
original/crs.pdf
>=20
> Adding Sinan to see if he has any concerns about this, since resume tim=
e
> is explicitly mentioned in the above slides.


Thanks for including me. Let me catch up here.

pci_dev_wait() is supposed to handle this case via pci_pm_reset().

/**
 * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
 * @dev: Device to reset.
 * @probe: If set, only check if the device can be reset this way.
 */

Do you know if your execution path hits this function? We might have
missed a use case.


--VAe2OGdce5xvOR23JKi06E8SmqdiLjPcX--

--UylE6D3vf4eFGBaP2VPSPvTV9RZDgIgTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEYdOlMSE+a7/cckrQvGF4I+4LAFcFAl2k2NoACgkQvGF4I+4L
AFf1Bgf9Ey2qkyqyU42ll24wr/FYUCaALWp2gyEMmKvNRagaZmBUrIPjFu17PQOp
nZJurJa57Asekl0mpLDmk/+o3mBcjrZpe1turqAFSB3DuyB/d0XDJ05jneoT6iaT
jVLW0uN4owZrK9oKrFgCdSAcHaL+NYa9Ya8uoM2SgukRRMZyV5/3ASyOU26bdHAl
+Bn8mgqncCBhBN/93vwQAySbyPy/b3JDR1v8iFLbKg41OWjnHPBXpm4Pu409/j2A
atthlvj69pmUnf2nF4wX8Mr7rVXWWAaxSpp6YM22yH1R0zFoL2Aw4B3MeDkdxEca
TeNgQuIAPx+W6F1jUC9unvFRID3VQg==
=Qx5i
-----END PGP SIGNATURE-----

--UylE6D3vf4eFGBaP2VPSPvTV9RZDgIgTb--
