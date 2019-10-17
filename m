Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC44DAE3B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394562AbfJQN0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 09:26:40 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:46275
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfJQN0k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 09:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeuGXQcNOeU0xAZ4kSK8dUEYpg+sqKZ52Tsb4ewQ9gCG8c+koLSDeGvp/QM/4YKgtzPyXfQ/YEchrIXsFZgCYYxCrLdLobBa0487MesJ7LB9vn/3Jy3sSVGePTDa3xed4te1NUy6RuOwdFB/4XVAhZDC6oxvgAqOsuTcmKxVNaeX/Qo2UffbAmRXnK/foPBg52iIidJC1sOdTW9qFmkqhhGrOg4TXzAwb7B2LK6+fu6D4WKhA0syimuTl0jXPDi/b6P9WQQKPW0zvqxmaWuIVPC1UK1Ay6hYg6KV4vJtyNMhzR6eyIDVeL38zFbsvrjSf3h48/2m89wdqYinsj+h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W/hZ7IYnlXUcn1VHx/J6LgQhaejooO1Dy3c5SaOfnA=;
 b=NtUBDCGR2r9qahkFxwzLe/AQmCt5icKsPNg/a95qRl6e+cepultqV+PevPYHX0RMxyGCjtLBr+E9G+7nbR07V2PDfgoJGtZVfWIkFNROq+mOz/iovbhXi50exRS+tYyNUvXGMOo44jruwp8vUr9bnbzaUjDIPwsiggkspu9VI6wCM/JWmK1kLrNBrqnGpGumwqqLMv36Tnz/fHR8d2Hyam1DIoDUbvdwf2LpibBK/5XkPFEdiJCwQLmDiyRZCEuuxtNPUM3rhNX2gIAglR7IZe3PJZFypOwmAPTImt3iv6Fqc7V9UfkJHRo2qLbqaZqey/Wn55JtpnJlmdX15liYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verimatrix.com; dmarc=pass action=none
 header.from=verimatrix.com; dkim=pass header.d=verimatrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verimatrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W/hZ7IYnlXUcn1VHx/J6LgQhaejooO1Dy3c5SaOfnA=;
 b=KcaVzpG0bFvfpbbCOeU3UvbKRxCKGIZW+CadjT0IHvIFeD/JTZQ6ZKEA0lpZ5a0Z9IguC7rq9KOwV8t09btQseY6Vy/CPMjNNJJduMkeztg9QQox4KtC2CARMmpc04XG/D6PN8u0ZBwzj/fiKG7fOw4qDrKMJQQRD/8ZmzmWYkA=
Received: from MN2PR20MB2973.namprd20.prod.outlook.com (52.132.172.86) by
 MN2PR20MB3182.namprd20.prod.outlook.com (52.132.175.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 13:26:23 +0000
Received: from MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::b986:4f02:3206:31e4]) by MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::b986:4f02:3206:31e4%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 13:26:23 +0000
From:   Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Pascal van Leeuwen <pascalvanl@gmail.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Thread-Topic: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
Thread-Index: AQHVd4jdTWYvsvdMgECIJvWMP+Nud6de2q1g
Date:   Thu, 17 Oct 2019 13:26:23 +0000
Message-ID: <MN2PR20MB2973D14C38B7BC7E081A73A9CA6D0@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <20190930121520.1388317-1-arnd@arndb.de>
 <20190930121520.1388317-3-arnd@arndb.de>
In-Reply-To: <20190930121520.1388317-3-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pvanleeuwen@verimatrix.com; 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed4c552b-3253-47e9-7447-08d753059aef
x-ms-traffictypediagnostic: MN2PR20MB3182:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR20MB3182A81566246DFC4EA3ACC6CA6D0@MN2PR20MB3182.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(13464003)(5660300002)(6506007)(66946007)(99286004)(305945005)(53546011)(66066001)(186003)(76116006)(71200400001)(26005)(71190400001)(33656002)(7696005)(76176011)(64756008)(66476007)(66446008)(14444005)(66556008)(102836004)(256004)(3846002)(54906003)(7736002)(6116002)(110136005)(86362001)(2906002)(52536014)(74316002)(6246003)(9686003)(486006)(81156014)(55016002)(14454004)(476003)(81166006)(15974865002)(8676002)(6436002)(229853002)(316002)(8936002)(478600001)(11346002)(446003)(4326008)(25786009)(7416002)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR20MB3182;H:MN2PR20MB2973.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: verimatrix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAFMkiS6ZfIfAesMvKmu+cz8hW3OvRAfIsBFnIDlK/plTDSRme+7lBpE0ne/iEU/ZMAJ6dWHwbctGTUcJyKCcYmzeKDQoid/qtnsh2juMPT+1d6sa3O9AVm5gFRtRH8/ShI43rhEXJAflvmfNd5X1uY9ccY+yVXQipqh9S4BAE7813PByvUIanXsf+CBfNcRz+vufqpM/dCcuJolI8Qp0COCUSWOlR267DzK7PA2i0f9E9caP9Q1ufUiFr7usD0z2SYlJ9/0U8qef1psir7Oq0kW9MiTzFYJS5WrFS1+WuSej4VuoFbJMqAeG76XNDXHzVYVTebTirWXXhkrlOo5IRsEG64hZw9Zm9iqEeOL8qyAsGVe7YD2iic6UNgeGrSqWOdcxYRUK8oNlJhJC2e0gk4uhYO418yVBmZIp+N9kNc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: verimatrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c552b-3253-47e9-7447-08d753059aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 13:26:23.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcb260f9-022d-4495-8602-eae51035a0d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kVNfX6xTR5eb8P/Gc+1Z8bGPnWrd4rZbWKkCk9CSQQzHZNAoqqSV0B/WSAzy5XJq7oL+5s2v8B+4cJGU7G/pxWIzxg8dnSuHN/vriURNkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3182
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Arnd,

Sorry for not responding earlier, but I've been very busy lately.
So I'm looking at this now for the first time.

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Monday, September 30, 2019 2:15 PM
> To: Antoine Tenart <antoine.tenart@bootlin.com>; Herbert Xu <herbert@gond=
or.apana.org.au>;
> David S. Miller <davem@davemloft.net>; Bjorn Helgaas <bhelgaas@google.com=
>
> Cc: Arnd Bergmann <arnd@arndb.de>; Pascal Van Leeuwen <pvanleeuwen@verima=
trix.com>; Pascal van
> Leeuwen <pascalvanl@gmail.com>; Kelsey Skunberg <skunberg.kelsey@gmail.co=
m>; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@vger.kern=
el.org
> Subject: [PATCH 3/3] crypto: inside-secure - Remove #ifdef checks
>=20
> When both PCI and OF are disabled, no drivers are registered, and
> we get some unused-function warnings:
>=20
> drivers/crypto/inside-secure/safexcel.c:1221:13: error: unused function
> 'safexcel_unregister_algorithms' [-Werror,-Wunused-function]
> static void safexcel_unregister_algorithms(struct safexcel_crypto_priv *p=
riv)
> drivers/crypto/inside-secure/safexcel.c:1307:12: error: unused function
> 'safexcel_probe_generic' [-Werror,-Wunused-function]
> static int safexcel_probe_generic(void *pdev,
> drivers/crypto/inside-secure/safexcel.c:1531:13: error: unused function
> 'safexcel_hw_reset_rings' [-Werror,-Wunused-function]
> static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
>=20
> It's better to make the compiler see what is going on and remove
> such ifdef checks completely. In case of PCI, this is trivial since
> pci_register_driver() is defined to an empty function that makes the
> compiler subsequently drop all unused code silently.
>=20
> The global pcireg_rc/ofreg_rc variables are not actually needed here
> since the driver registration does not fail in ways that would make
> it helpful.
>=20
> For CONFIG_OF, an IS_ENABLED() check is still required, since platform
> drivers can exist both with and without it.
>=20
> A little change to linux/pci.h is needed to ensure that
> pcim_enable_device() is visible to the driver. Moving the declaration
> outside of ifdef would be sufficient here, but for consistency with the
> rest of the file, adding an inline helper is probably best.
>=20
> Fixes: 212ef6f29e5b ("crypto: inside-secure - Fix unused variable warning=
 when CONFIG_PCI=3Dn")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/inside-secure/safexcel.c | 49 ++++++-------------------
>  include/linux/pci.h                     |  1 +
>  2 files changed, 13 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/ins=
ide-secure/safexcel.c
> index 311bf60df39f..c4e8fd27314c 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -1547,7 +1547,6 @@ static void safexcel_hw_reset_rings(struct safexcel=
_crypto_priv *priv)
>  	}
>  }
>=20
> -#if IS_ENABLED(CONFIG_OF)
>  /* for Device Tree platform driver */
>=20
>  static int safexcel_probe(struct platform_device *pdev)
> @@ -1666,9 +1665,7 @@ static struct platform_driver  crypto_safexcel =3D =
{
>  		.of_match_table =3D safexcel_of_match_table,
>  	},
>  };
> -#endif
>=20
> -#if IS_ENABLED(CONFIG_PCI)
>  /* PCIE devices - i.e. Inside Secure development boards */
>=20
>  static int safexcel_pci_probe(struct pci_dev *pdev,
> @@ -1789,54 +1786,32 @@ static struct pci_driver safexcel_pci_driver =3D =
{
>  	.probe         =3D safexcel_pci_probe,
>  	.remove        =3D safexcel_pci_remove,
>  };
> -#endif
> -
> -/* Unfortunately, we have to resort to global variables here */
> -#if IS_ENABLED(CONFIG_PCI)
> -int pcireg_rc =3D -EINVAL; /* Default safe value */
> -#endif
> -#if IS_ENABLED(CONFIG_OF)
> -int ofreg_rc =3D -EINVAL; /* Default safe value */
> -#endif
>=20
>  static int __init safexcel_init(void)
>  {
> -#if IS_ENABLED(CONFIG_PCI)
> +	int ret;
> +
>  	/* Register PCI driver */
> -	pcireg_rc =3D pci_register_driver(&safexcel_pci_driver);
> -#endif
> +	ret =3D pci_register_driver(&safexcel_pci_driver);
>=20
> -#if IS_ENABLED(CONFIG_OF)
>  	/* Register platform driver */
> -	ofreg_rc =3D platform_driver_register(&crypto_safexcel);
> - #if IS_ENABLED(CONFIG_PCI)
> -	/* Return success if either PCI or OF registered OK */
> -	return pcireg_rc ? ofreg_rc : 0;
> - #else
> -	return ofreg_rc;
> - #endif
> -#else
> - #if IS_ENABLED(CONFIG_PCI)
> -	return pcireg_rc;
> - #else
> -	return -EINVAL;
> - #endif
> -#endif
> +	if (IS_ENABLED(CONFIG_OF) && !ret) {
>
Hmm ... this would make it skip the OF registration if the PCIE
registration failed. Note that the typical embedded  system will=20
have a PCIE subsystem (e.g. Marvell A7K/A8K does) but will have=20
the EIP embedded on the SoC as an OF device.

So the question is: is it possible somehow that PCIE registration
fails while OF registration does pass? Because in that case, this
code would be wrong ...

Other than that, I don't care much how this code is implemented
as long as it works for both my use cases, being an OF embedded
device (on a SoC _with_ or _without_ PCIE support) and a device
on a PCIE board in a PCI (which has both PCIE and OF support).

> +		ret =3D platform_driver_register(&crypto_safexcel);
> +		if (ret)
> +			pci_unregister_driver(&safexcel_pci_driver);
> +	}
> +
> +	return ret;
>  }
>=20
>  static void __exit safexcel_exit(void)
>  {
> -#if IS_ENABLED(CONFIG_OF)
>  	/* Unregister platform driver */
> -	if (!ofreg_rc)
> +	if (IS_ENABLED(CONFIG_OF))
>  		platform_driver_unregister(&crypto_safexcel);
> -#endif
>=20
> -#if IS_ENABLED(CONFIG_PCI)
>  	/* Unregister PCI driver if successfully registered before */
> -	if (!pcireg_rc)
> -		pci_unregister_driver(&safexcel_pci_driver);
> -#endif
> +	pci_unregister_driver(&safexcel_pci_driver);
>  }
>=20
>  module_init(safexcel_init);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f9088c89a534..1a6cf19eac2d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1686,6 +1686,7 @@ static inline struct pci_dev *pci_get_class(unsigne=
d int class,
>  static inline void pci_set_master(struct pci_dev *dev) { }
>  static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; =
}
>  static inline void pci_disable_device(struct pci_dev *dev) { }
> +static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO=
; }
>  static inline int pci_assign_resource(struct pci_dev *dev, int i)
>  { return -EBUSY; }
>  static inline int __pci_register_driver(struct pci_driver *drv,
> --
> 2.20.0

Regards,
Pascal van Leeuwen
Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
www.insidesecure.com
