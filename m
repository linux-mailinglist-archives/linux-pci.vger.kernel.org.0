Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED7D7440
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfJOLKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 07:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfJOLKz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 07:10:55 -0400
Received: from [172.20.3.161] (50-235-29-75-static.hfc.comcastbusiness.net [50.235.29.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F82E217F9;
        Tue, 15 Oct 2019 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571137854;
        bh=E5MLeHpWQWPaic/TBZWpTGqKjW+Gaxe7A+7RGn6z5Ak=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=y6EoJkDWO7I4eWXaHdylNXDRWigPkDOjjCdBPCOC7X1t7n2WUAqg2wlzkZ40k/xkp
         nW0SkCGIM+w9GfEqJUYKooGxLe/kVLireFVJwNsbWHlh1r1rZ4beZxfM5ChqYGEZnT
         hWw3mNYyEihPsfQHzgz2uIm1fYVxbn5Islx2pL10=
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
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
Message-ID: <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
Date:   Tue, 15 Oct 2019 04:10:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015093053.GA5778@ulmo>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sTjluv08Mnl4RgMM99UccVdeK0v9tGu6m"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sTjluv08Mnl4RgMM99UccVdeK0v9tGu6m
Content-Type: multipart/mixed; boundary="933WTPgNbHRxifiVVQdQcDiSyYuZNCaYh";
 protected-headers="v1"
From: Sinan Kaya <okaya@kernel.org>
To: Thierry Reding <treding@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
In-Reply-To: <20191015093053.GA5778@ulmo>

--933WTPgNbHRxifiVVQdQcDiSyYuZNCaYh
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

+Rafael

On 10/15/2019 2:30 AM, Thierry Reding wrote:
> Vidya, can you clarify for which device you're seeing the issues? Sound=
s
> like adding a call to pci_pm_reset() (via pci_reset_function()) at some=

> point.
>=20
> Sinan, it looks as if pci_pm_reset() (or any of its callers) is not use=
d
> very widely. Is that just because most drivers haven't had a need for i=
t
> yet? Or am I missing some core functionality that calls this for every
> device anyway?

pci_pm_reset() is there as an alternative reset path. We are not
supposed to call this function. Sorry for giving you wrong direction
here. pci_reset_function() should call it only if there is no other
suitable reset function is found.

I think the PCI core should be putting the device back D0 state as one
of the first actions before enumerating. Wake up could be a combination
of ACPI and/or PCI wake up depending on where your device sits in the
topology.

On the other hand, wake up code doesn't perform the CRS wait. CRS
wait is deferred until the first vendor id read in pci_scan_device().
I see that it already waits for 60 seconds.

Going back to the patch...

I think we need to find the path that actually needs this sleep and
put pci_dev_wait() there.

+++ b/drivers/pci/pci.c
@@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)

 	if (pci_dev_is_disconnected(pdev))
 		return false;
-	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
+	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v,
+					  PCI_CRS_TIMEOUT);
 }

pci_device_is_present() is a too low-level function and it may not
be allowed to sleep. It uses 0 as timeout value.



--933WTPgNbHRxifiVVQdQcDiSyYuZNCaYh--

--sTjluv08Mnl4RgMM99UccVdeK0v9tGu6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEYdOlMSE+a7/cckrQvGF4I+4LAFcFAl2lqTgACgkQvGF4I+4L
AFdD3gf/W0tXaHolyKIOaMIeQ0Lgkp8/SdlZMJkMPgOk0Nl8+GYxUJdf8cLqLUEc
ytQnHeCm6qeLapNQIz9oMrvsM9kJwyVBDlmijbWyqu4ltBfmYcSnueSaUs91hy10
mHhw2GTt4lTbrSp8fq+1OKz147Bzd0H51kYk49qzSu4tZRRgL6KT3DVOC2sK5nR7
6nSUheHPKz79uibgfO9Hq3oXZ+eSVxn0iSl/RV1K3k2AX0I7EkeudQepJg8M7HNb
HmbQmRYsC3Syn7BnDduWv8rwcuwsmEJaxPysPHqoXKT6gwe9yQFNiDuV/TaUbHdP
yDjgpP7u6kKQ53UY4CQ/4FEgnnD1Yw==
=dZzn
-----END PGP SIGNATURE-----

--sTjluv08Mnl4RgMM99UccVdeK0v9tGu6m--
