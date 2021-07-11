Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99D43C3E07
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jul 2021 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhGKQn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jul 2021 12:43:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:42456 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhGKQn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jul 2021 12:43:27 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16BGduBa009313;
        Sun, 11 Jul 2021 09:40:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=lSd868veQpqv5tDmKQF9xWlkE7aJO+YCe5zUY+FrV9k=;
 b=c0oabKZQTriTkmLaGUz0ZLGjTVvHc+6qlgsRRkEq8lBRpGVF1skw8HcFCKUfeBbzfsPP
 05p1ESs3ZPWY9kWwt+NcAF0nF1FNUV7wOEJrSEP9oxa1x1ERbBqI0KKOHlgfbpv4vqlh
 dOICF1420BSJI92u6A4CAFOiPRpwLsInjBrZtyUUbV8TtKIkOpTh0yxsXa6Zk/11XnoB
 9UtbKTsookXvNECAucOCR+8TRDlT4t87P+Ebc2XXMVReGmPQAnACVttcYVtElMaLFKdH
 cfm/Q015kI3xr1bBxzQzEOfnIVXpKCEKQpvDbxmvJgzKNi/FrLiqYalqlya7mcPSDYYO yg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-002c1b01.pphosted.com with ESMTP id 39q7fb1vwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jul 2021 09:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7dOnKpZtT3dq9eRto8u54R/X1m8UfduWcm3Au1CT9H3dFy8BB0vKpf2nK9mPCSujzQjPmPTRHmo2SjtVax04IdSAqsrhzIPLjCbzW1WCmnqhbzSuGb5Clg8jyvpT3DxYu2Huka+qdGBBHaQQiMxccdJg5dErOJyXcg7bb427CfKw0KosabmkiinW79xQSQp3naxIh266LyQUWIiWYNrOxMmvX2+ZzMj6SlxUMQAcH0EVLM3Whws+9x3a90bjVOqVUdmuolaf3Qg3lMsWW3j+7kNNUjuDox/Svi8PEIPE1vqbCQ/3eT6uP2Jup9psFmrZh7hD2iOwhwp9BEmrdMKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSd868veQpqv5tDmKQF9xWlkE7aJO+YCe5zUY+FrV9k=;
 b=XD9HrTPIBbX46pvJqrHOnuYz7YythA+f1HEnMcGDqZCMxPeoEdKt4X6o+fkZseyNk7BzHUR7077JmQPFJNrakW1Phh9m/rTs64vlQPFkXiRG3WtX7Z7icgExFfluiuAYVwMkQcQddkWVtfFWY22RaKGyGFX/YanirtHGjK5+YuaS4jNvwCsouR1vdALPn8eV95CdMZLcY9B0/nJUxfbnoQ3+hZlLG2X+IsQ9nDw+7B33iMDOFE3NdrB7GOabKmjM77qMEdxnFppYOC/8pWo1d9wxM6qPeVMrKiMR5B/L5wOW25YiBl/s72TVCl4pPnLE8JH5iZKEdgGkrY8+V2PnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB5568.namprd02.prod.outlook.com (2603:10b6:805:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Sun, 11 Jul
 2021 16:40:23 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4308.026; Sun, 11 Jul 2021
 16:40:23 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Thread-Topic: [PATCH v9 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Thread-Index: AQHXcakj2rIXEKBF9E+ZHHzo9vxZBas+A4MA
Date:   Sun, 11 Jul 2021 16:40:23 +0000
Message-ID: <20210711164012.GA30406@raphael-debian-dev>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-2-ameynarkhede03@gmail.com>
In-Reply-To: <20210705142138.2651-2-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb266398-b6ab-4bc2-b45a-08d9448a942e
x-ms-traffictypediagnostic: SN6PR02MB5568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB5568C4DD1311FACEB0E9696EEA169@SN6PR02MB5568.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwW7YFRgiUXFKabnr2ezF7+P03uRoSLEGr/pIjMEQDgDPTReitEwq6vqwNCwqctVHeh6iHtrpcOwHmBBNfj1+k1XGF1GgCercuH46jXF6bfhIalHGavgMpPDkOZbIXC/K4l1j5nbSOOTajkXZ6LHP2ovC5m8Ifm4NsAlHqSNeJ6vpyBGj4ANnMwiIcic1S/ozArZsqpRyq6xlyMJczDz3WLoEBICEFuXb5AVvA58kLbGSCpZFo/s1rtjPlcamg0SM/UqFei30IrPdxcMG3fCvuLfUIYqwB3hk7MGVqnEvfzu26uqf2Oh0Dkd4agM8rNjahuDerjipQRAaGycPCSc/Zn32r1S7oLTVOB+0BQEZ7VVfCcESHCKEAAGjo2LV1Y3SCZEg1Vk7loq8QRyAaTqNd16PXbNos7kP9pBihuwM7DgCp8eQVO8tmSSg/FpJp6F+zmcQodsHY8hMvCuKn1GV6kJMR/IcykJtGCH96IKJSqJd6nZ/TVQmSuJDZOMRjdULxkXRV19NhzttI9TIbYZE+4TF7vwgsIusxSv9fSp8gge23yumBpm6uKffGvxdM50dPsEpMh+gwwaasBW/SdJCvujbdGvLd7hONBr6S2yrAhr3mGXCtqP3EC2bh1dhKGTwFdLvlKFNqK72T0hkFNRNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(346002)(39850400004)(366004)(376002)(396003)(4326008)(6916009)(1076003)(83380400001)(54906003)(2906002)(122000001)(8936002)(44832011)(6486002)(33716001)(71200400001)(186003)(5660300002)(6506007)(33656002)(66446008)(66476007)(9686003)(8676002)(64756008)(66556008)(478600001)(316002)(86362001)(38100700002)(91956017)(66946007)(76116006)(26005)(7416002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7QTDJ6OHtbZ+8BhNXR2Nl8y2VIOeuEJaeM8A18GUAe/2cY3oAe/jzJMaq9AX?=
 =?us-ascii?Q?xj3WQHdAhEhCDzob0xd6NZoJiMf7112MTKGXA03qqJ/jTKsvDllO9YsEgPif?=
 =?us-ascii?Q?j6zg6tHq0gn3W170dfXi7T//aX4y2I1Kx94bNrcWwniSJe2iByVfaaSwg1OI?=
 =?us-ascii?Q?U7zHKUso9uX7/H/VlsE/CR3+D6mIfGfSB9jmhS8Mj37gdZcVgoRytp2CIusI?=
 =?us-ascii?Q?gVPWwCrDWsQBtVU48gl5ywik3AA6Q/YH1LxHGUjejK1vahbDH0NIoFq4UrWG?=
 =?us-ascii?Q?Lv24Sab+h+ZZ694EuTlzGns6z6ghmPp3MDzYtCJwxzu38nAGmxajkvXHvl7f?=
 =?us-ascii?Q?k6GRMqoJ28EeaVBulQFqwsylGTQU1kzDWZmwxfLntF7LCzU0UFuQVCJK3izA?=
 =?us-ascii?Q?L9c73WOYk0kfEhhyZ49B1wvKjIGSyBECCWs9yWXaaxajtdrK/EPhJ6DUFf3G?=
 =?us-ascii?Q?CO3dLWpLgV+CYAFafk4Q3cNRXwNUfmAxFXgAs3v2I/SO5B3qN7d/HrXw4Yij?=
 =?us-ascii?Q?XU49LNkh1vWAOJLTZzDAQq8TeBFHYxwgaIivnuB48/1eXIbmhj0iJ196yFGh?=
 =?us-ascii?Q?wrNN2tgMerbUft61q/aKTXdszVzEiQcTQ5iMu65js2ZnpkUfL66V9tYX2+TA?=
 =?us-ascii?Q?R8W/yDZM69QSe7a/MvFNq/FSckM+27I8dX/s8v9J05c9wKjCMR8B8CAdMfCI?=
 =?us-ascii?Q?sxhJHCTIvHwJfcaI+BleaHlPgOJgeREnDEp7lDNnJO9flRF43yFqBcBaeU+/?=
 =?us-ascii?Q?aepZJfArfGjzPanh8F+40G1lNhYMeVVLWdT/QE7wXfhxyVYSomFvdXBkpEA0?=
 =?us-ascii?Q?UjR6SVRo4wRYWARzPk47dDDD7rjp+jZKRFgRs7g94qqceeztpzXET2+LCjch?=
 =?us-ascii?Q?8XFawhCyIxekvZwinKkZZBiRCglypqq9hKcqhZ3scXB8ftf+fB9RAW4uynXe?=
 =?us-ascii?Q?Dr/36u9+3v2InOUMiPkILnjfNFSknp2+VEw2uXTH0K34wSdxhXW4PzzGY3Kl?=
 =?us-ascii?Q?4ytAOumAkV+mR1WgsAsTiyfVVf0MQQrrfMt9L6afYG52bohTCoe8HIFxRQb+?=
 =?us-ascii?Q?/sZY01NqivFAAp3iA1fxolqrgIaR67JQZkVx8r+02aYsdkRh+UqyGMGZB9yx?=
 =?us-ascii?Q?zkz0hCptDgJBSWNfRNIxJMnuM825jRsORym77gOOEiUvFrot1leRSBG26QQ8?=
 =?us-ascii?Q?Tn6cVuFMo9Y4twvt5vPMjWoqHSrHLTQCIXvnF1rtejBgg7Ut+EWS+CwSQzSU?=
 =?us-ascii?Q?8HatGaXIJfO6g7RCpBQLsvWh01YiD6At19qUPffazWZElM3WZVYitQDwsLoA?=
 =?us-ascii?Q?ryl9Udgtw56i5psX3dntpBZy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96A53EDB2BEC0240A72827AB2CB229B2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb266398-b6ab-4bc2-b45a-08d9448a942e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2021 16:40:23.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GY3kFUJ4Q9BZoYwVwGxytmbSolh+YzuSmo0xsjMKIDWJ/OEjQLo3JsbvjPd07/auJQU1jvEoflUSN82+l6huahWZHaMpb5ntQCgDJyPNdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5568
X-Proofpoint-ORIG-GUID: wh65xaxO9FI4dlLwHqgqu99CW3gyCm07
X-Proofpoint-GUID: wh65xaxO9FI4dlLwHqgqu99CW3gyCm07
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_10:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 07:51:31PM +0530, Amey Narkhede wrote:
> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
>=20
> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> is supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not. Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
>=20
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>  drivers/pci/pci.c                          | 59 +++++++++++-----------
>  drivers/pci/pcie/aer.c                     | 12 ++---
>  drivers/pci/probe.c                        |  6 ++-
>  drivers/pci/quirks.c                       |  9 ++--
>  include/linux/pci.h                        |  3 +-
>  6 files changed, 45 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/=
cavium/nitrox/nitrox_main.c
> index facc8e6bc..15d6c8452 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
> =20
> -	/* check flr support */
> -	if (pcie_has_flr(pdev))
> -		pcie_flr(pdev);
> +	pcie_reset_flr(pdev, 0);
> =20
>  	pci_restore_state(pdev);
> =20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 452351025..fefa6d7b3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4611,32 +4611,12 @@ int pci_wait_for_pending_transaction(struct pci_d=
ev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> =20
> -/**
> - * pcie_has_flr - check if a device supports function level resets
> - * @dev: device to check
> - *
> - * Returns true if the device advertises support for PCIe function level
> - * resets.
> - */
> -bool pcie_has_flr(struct pci_dev *dev)
> -{
> -	u32 cap;
> -
> -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> -		return false;
> -
> -	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> -	return cap & PCI_EXP_DEVCAP_FLR;
> -}
> -EXPORT_SYMBOL_GPL(pcie_has_flr);
> -
>  /**
>   * pcie_flr - initiate a PCIe function level reset
>   * @dev: device to reset
>   *
> - * Initiate a function level reset on @dev.  The caller should ensure th=
e
> - * device supports FLR before calling this function, e.g. by using the
> - * pcie_has_flr() helper.
> + * Initiate a function level reset unconditionally on @dev without
> + * checking any flags and DEVCAP
>   */
>  int pcie_flr(struct pci_dev *dev)
>  {
> @@ -4659,6 +4639,28 @@ int pcie_flr(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
> =20
> +/**
> + * pcie_reset_flr - initiate a PCIe function level reset
> + * @dev: device to reset
> + * @probe: If set, only check if the device can be reset this way.
> + *
> + * Initiate a function level reset on @dev.
> + */
> +int pcie_reset_flr(struct pci_dev *dev, int probe)
> +{
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
> +	if (!dev->has_pcie_flr)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pcie_flr(dev);
> +}
> +EXPORT_SYMBOL_GPL(pcie_reset_flr);
> +
>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  {
>  	int pos;
> @@ -5139,11 +5141,9 @@ int __pci_reset_function_locked(struct pci_dev *de=
v)
>  	rc =3D pci_dev_specific_reset(dev, 0);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev)) {
> -		rc =3D pcie_flr(dev);
> -		if (rc !=3D -ENOTTY)
> -			return rc;
> -	}
> +	rc =3D pcie_reset_flr(dev, 0);
> +	if (rc !=3D -ENOTTY)
> +		return rc;
>  	rc =3D pci_af_flr(dev, 0);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> @@ -5174,8 +5174,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	rc =3D pci_dev_specific_reset(dev, 1);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev))
> -		return 0;
> +	rc =3D pcie_reset_flr(dev, 1);
> +	if (rc !=3D -ENOTTY)
> +		return rc;
>  	rc =3D pci_af_flr(dev, 1);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ec943cee5..98077595a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci=
_dev *dev)
>  	}
> =20
>  	if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC_END) =
{
> -		if (pcie_has_flr(dev)) {
> -			rc =3D pcie_flr(dev);
> -			pci_info(dev, "has been reset (%d)\n", rc);
> -		} else {
> -			pci_info(dev, "not reset (no FLR support)\n");
> -			rc =3D -ENOTTY;
> -		}
> +		rc =3D pcie_reset_flr(dev, 0);
> +		if (!rc)
> +			pci_info(dev, "has been reset\n");
> +		else
> +			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
>  	} else {
>  		rc =3D pci_bus_error_reset(dev);
>  		pci_info(dev, "%s Port link has been reset (%d)\n",
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8..a95252113 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  {
>  	int pos;
>  	u16 reg16;
> +	u32 reg32;
>  	int type;
>  	struct pci_dev *parent;
> =20
> @@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pdev->pcie_cap =3D pos;
>  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>  	pdev->pcie_flags_reg =3D reg16;
> -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> -	pdev->pcie_mpss =3D reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
> +	pdev->pcie_mpss =3D reg32 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pdev->has_pcie_flr =3D reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;
> =20
>  	parent =3D pci_upstream_bridge(pdev);
>  	if (!parent)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d85914afe..f977ba79a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3819,7 +3819,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev=
, int probe)
>  	u32 cfg;
> =20
>  	if (dev->class !=3D PCI_CLASS_STORAGE_EXPRESS ||
> -	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> +	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
>  		return -ENOTTY;
> =20
>  	if (probe)
> @@ -3888,13 +3888,10 @@ static int nvme_disable_and_flr(struct pci_dev *d=
ev, int probe)
>   */
>  static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  {
> -	if (!pcie_has_flr(dev))
> -		return -ENOTTY;
> +	int ret =3D pcie_reset_flr(dev, probe);
> =20
>  	if (probe)
> -		return 0;
> -
> -	pcie_flr(dev);
> +		return ret;
> =20
>  	msleep(250);
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59..d432428fd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -337,6 +337,7 @@ struct pci_dev {
>  	u8		msi_cap;	/* MSI capability offset */
>  	u8		msix_cap;	/* MSI-X capability offset */
>  	u8		pcie_mpss:3;	/* PCIe Max Payload Size Supported */
> +	u8		has_pcie_flr:1; /* PCIe FLR supported */
>  	u8		rom_base_reg;	/* Config register controlling ROM */
>  	u8		pin;		/* Interrupt pin this device uses */
>  	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
> @@ -1225,7 +1226,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, s=
truct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
>  void pcie_print_link_status(struct pci_dev *dev);
> -bool pcie_has_flr(struct pci_dev *dev);
> +int pcie_reset_flr(struct pci_dev *dev, int probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
> --=20
> 2.32.0
>=20
> =
