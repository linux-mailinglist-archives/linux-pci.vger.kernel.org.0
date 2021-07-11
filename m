Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6993D3C3E0C
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jul 2021 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhGKQps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jul 2021 12:45:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:64372 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhGKQps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jul 2021 12:45:48 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16BGeinP012606;
        Sun, 11 Jul 2021 09:42:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=M/Bz+PjQXRkBKZcTnUESgIerSn+ST8eP+q/+NvfHI2k=;
 b=t7qwcRMl/D22OzlLmnnswsXHOPiQJ90Zh1eHwv5DgcQB053ONZRTUPJG9rKqGbsVkJru
 hbFQo7eOLtXm9tRgm5cVjN2ad0BNiPYYVcq3nSHVni0rkNgRV05j5eht6NQEK0BQidRl
 2Piv+LLRcsv8JKijKQbql3tAqDgMRz8eyKdmra3HBWugk6eMpOpyjOPFuTj47xf2OeaE
 uukujgBJXfZ5ImhtS40h6gDGGyoc5y1TFWPesjPcvnG62fuFNNAoJzIVi5YdgOwcsfrV
 GJAXkEhkcqT3N/w4iBCUNTGQSinLRzNuxClmXkde0+FnDVpORvPV7bM1Cxn7xZTkfMes tQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0a-002c1b01.pphosted.com with ESMTP id 39q7vwsurw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jul 2021 09:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzf5cnpBf8q9WM8zt0E8juUnqsk1ZF3Ug/XuaHEnG8RA7nu2a0oy1D/6sbZxDexfCEeZA6h38ca+suKFYBFjFiVvBKOtZ9DidlcVDOpFAGI2KG200WR6hxrx+n3KlbNYCQ447yhWh9llcTnn89ilyTBuWSFoK6f3FoKe/s+bVryDb9/1F489wR1L1UT5ssNBbGIKGBYEzz+CF35KtQqDSH9fsH14LYfwYwZrWeFVMV13JlMhtSI1y4fJ23mGtdSBo0JU8yQIBJn8l5vpdRaS3WGbaJi6ewiktcIIhwdSnUaNUFpxlNZTPuctO2w0hp8J7F2HugeCavfAILnshsa9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Bz+PjQXRkBKZcTnUESgIerSn+ST8eP+q/+NvfHI2k=;
 b=la6XeqcZqMSSSvwbqnepbyePSqg5Pc+hinvg1mXSy5aRS/+fTtLqgxOVxv9d8aZQJUfMfiDgR0Nfa0ilEPCOjw0LIK1zWJtudAR2T5Q1GklW9/LDddbMCMhCAsrpKQjwjt2d9t4WEVuZ37fpYqNzEoL7ZdUJToSH3XK1fxtH1p4NH9J9RWOmX9uZigiXYuA1tu53L1Lbz8f9npRbDbZen/3SVka8gFIDtbgPjlqHL63DXVjjjA/BhcCX16CaemN1DjSea4tTCa13PkzIBGgZ/PzYnqeYibaHi5H/MDnv3H2WyBst3AKniJ68wRrkmreWvF4Nv6us7L185Qc3CEtztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA0PR02MB7241.namprd02.prod.outlook.com (2603:10b6:806:ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sun, 11 Jul
 2021 16:42:46 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4308.026; Sun, 11 Jul 2021
 16:42:46 +0000
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
Subject: Re: [PATCH v9 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Thread-Topic: [PATCH v9 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Thread-Index: AQHXcakn/n1M7adXa0e/+KY+mruWx6s+BDWA
Date:   Sun, 11 Jul 2021 16:42:46 +0000
Message-ID: <20210711164241.GB30406@raphael-debian-dev>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-3-ameynarkhede03@gmail.com>
In-Reply-To: <20210705142138.2651-3-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e4484f3-de40-4558-ef16-08d9448ae9d2
x-ms-traffictypediagnostic: SA0PR02MB7241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR02MB72419CFEAD6613AA4FDD95ECEA169@SA0PR02MB7241.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2VGEnMMYIIjKS5T6FhCXJAZnk1K6zY+UGcGxzzosCga4XkM5NCDXImBeE1oFqdfcC8skwK5xqzxN4MVpaiKOhCUdzlWxQyc5f6A0JqXzDet5kVaezanpsht2RZuXNRy8HfVqdorCG0wgNM/gj6OILOgjNIBnAUQtDCJ8I+tcrl+HVcFZvOS9VURx5+xoyHHDr90wcNwVHZukcDk2SVdrWWN6ouyRv7A4eVWBc0hYhzxgB0jMZJMaW6rSBX4PQHd8KJEvlN0nN0ZAw6GKcldzOLOCOPO9uII8wtCvA0D2jaAwElYToGnlPXQwXl/G8dvY95ow6spPNVMOEyqLus4tnrJV335UEIucD0KVO7RmloI17eT8Mx9VuqDkbai6Y2KbNJUEMdO+1AR7Jd2tLDdNieNWqrfoS8qw3zOet7JZsR5X6ojUg5T2Mz581HYlGxNSO460CXbihpl69aJ0s/HIJ86WCIszR5ONUrZqZ+PFNpZer8GTTfsvCPeRZvo+cHKHnvT4vyq0PwgCoiJw5HvVEcf1vGF7sv9aLX4Xd0/2xXRsGV+T9dgBqTp6haTEsHdQnvMgcy36RIph9Fj+ovE60Pa3HCE9SOhoPSsq+lMmIzGgugNELBxufYy6xmUjPx2hRFXphsTjnq4qfS1ggzNiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(396003)(346002)(39850400004)(136003)(366004)(8936002)(38100700002)(33656002)(83380400001)(76116006)(8676002)(6916009)(4326008)(44832011)(6486002)(86362001)(7416002)(1076003)(9686003)(64756008)(54906003)(478600001)(122000001)(186003)(66476007)(66556008)(316002)(66446008)(71200400001)(5660300002)(2906002)(66946007)(6506007)(33716001)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TMPlsoAqYSYjs/SLw0EsLk3jDPFdEYeqnnUAqzNrOOobmTGlyltv3qnx2iVz?=
 =?us-ascii?Q?wAatIMAlW8d3WV/U1cZb3LN7x+1GPRcB0KQnbgpVFQuOXVS3klgThHj0mHI3?=
 =?us-ascii?Q?WoVnHBJuyuagb6vhcq2Az/cihEgYqov41yid+JhzmX9fdf+5Z6r/ksNBYqeb?=
 =?us-ascii?Q?HdAE1ZwRxzcHie6oPgGNUTbSN5DVlhw+3e/s/GQuXhOP+5c7SjBH1AhVqKN3?=
 =?us-ascii?Q?HJno9ugkHBTlNS8TNNapsPVEXJ418a3avVULtA5NgVDh92Qj3FbzZyfFxxhq?=
 =?us-ascii?Q?cQh3xIQ9/Me2iXF88+Nx9OepGquKdWCQauOswcs7cwQilXC8u2yzrEKCn7fy?=
 =?us-ascii?Q?79kp/ji914D/pBeejjQNtVV8dlPE0w7CoJd9CiFS+iRe0ka2zRC5AZGAZdhv?=
 =?us-ascii?Q?FIINYI3/afh8iDvRTu4GwLGReqf0xeLnQqznWOTd8WR2+PbXylztxhVjn8Vy?=
 =?us-ascii?Q?YoY5Ug96zHv6ObANpS9is9IZMWPM+Z6x8JpnSNC0skAAoso5lJNthvoz6X0x?=
 =?us-ascii?Q?JsJNOlIv8jwpGe+iJ0OJv54Wh1h0NdYCrjI9hnGQVgfC0Hg06wqtOVPhVf+N?=
 =?us-ascii?Q?yrdhQgQwHgBo1A7MIcyAEOU5Srv9k+XU+y6qyZcGzHPDXR48+gRY+/RsGsfT?=
 =?us-ascii?Q?jirfKDupGqKxGnp/xt+82jdrGcW7VmcG/tBkZaiq29FoidzFMv4AwvycqBYW?=
 =?us-ascii?Q?DjXerVNocS8qw5Pl0roRRn8gMnY8Er4uD2+ZE6+1WyGy4x5G6HsZ1afZU4Cz?=
 =?us-ascii?Q?PWqpcsYU4ZM9Ofi6o2YOMYLn8DztR+Sh1n54Fpk77NDptAaRWzP0ORNi0hX8?=
 =?us-ascii?Q?hqkIn6mi9o6TZdQv6KYIgcaG4+6Mmq7piyDtwPRAG6Kwur4nQktd9NtA7L2b?=
 =?us-ascii?Q?COHoQ21B2/vWdrc1i6to8tY3069qaTiBrJvvLFjoGHLlA5nMIOOkD2ezN89N?=
 =?us-ascii?Q?AKNHXmkq9XNLmS/RjtxdAq2qW/XT9cEBqZGLn42gc3w724k5yEgSW1vA2iJU?=
 =?us-ascii?Q?0iiQ6UkBJ4WxMcvuMnmEifohJTdXMh/Ii6v/ZZF0LUxvliILExhtfp8sjq/m?=
 =?us-ascii?Q?eKW7rfuBRJFYoZQ7D8BnOyC2VwwTmGAEwoI6sA39bCNazP+iKca2l2Q3kD+o?=
 =?us-ascii?Q?xX5eaT6Us04BTUjkas4cB3eypxHw1Z+ryki1a1ZC7QsX9+wqveFcHcj3ceqx?=
 =?us-ascii?Q?nB6Nu/rzBYohisWb62tgnedTr/S9W6aQI8wIehVXBG0A8/GyRBc1RZBpnA0L?=
 =?us-ascii?Q?cFZEOMwH2wewPXe3hdMzr4rkuXw2cCoDFy4SohB+nv7v4zSCW0wHzoK+SDGB?=
 =?us-ascii?Q?qFAQO5G9CWFkq8/siCJSJNdn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80ADDE1035B8384A91446226B5DE5B5E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4484f3-de40-4558-ef16-08d9448ae9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2021 16:42:46.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9Fujxi9N6wpSwc0LJ0FS59H7lkwchGQhptJ1oQMldwiVQiKPFbegHx1ljuFtc8PYbF02ESykqv4xgIjnGV6JlanVOnlij3cM78m0iLYv/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7241
X-Proofpoint-ORIG-GUID: Kz8_wZDmyUHfdlKCH-Eu6A_N-MiG_O_x
X-Proofpoint-GUID: Kz8_wZDmyUHfdlKCH-Eu6A_N-MiG_O_x
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_10:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 07:51:32PM +0530, Amey Narkhede wrote:
> Introduce a new array reset_methods in struct pci_dev to keep track of
> reset mechanisms supported by the device and their ordering.
>=20
> Also refactor probing and reset functions to take advantage of calling
> convention of reset functions.
>=20
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
>  drivers/pci/pci.h   |  9 ++++-
>  drivers/pci/probe.c |  5 +--
>  include/linux/pci.h |  7 ++++
>  4 files changed, 70 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fefa6d7b3..42440cb10 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  		msleep(delay);
>  }
> =20
> +int pci_reset_supported(struct pci_dev *dev)
> +{
> +	u8 null_reset_methods[PCI_NUM_RESET_METHODS] =3D { 0 };
> +
> +	return memcmp(null_reset_methods,
> +		      dev->reset_methods, sizeof(null_reset_methods));
> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  int pci_domains_supported =3D 1;
>  #endif
> @@ -5104,6 +5112,15 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
> =20
> +const struct pci_reset_fn_method pci_reset_fn_methods[] =3D {
> +	{ },
> +	{ &pci_dev_specific_reset, .name =3D "device_specific" },
> +	{ &pcie_reset_flr, .name =3D "flr" },
> +	{ &pci_af_flr, .name =3D "af_flr" },
> +	{ &pci_pm_reset, .name =3D "pm" },
> +	{ &pci_reset_bus_function, .name =3D "bus" },
> +};
> +
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holdi=
ng
>   * the @dev mutex lock.
> @@ -5126,65 +5143,62 @@ static void pci_dev_restore(struct pci_dev *dev)
>   */
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, m, rc =3D -ENOTTY;
> =20
>  	might_sleep();
> =20
>  	/*
> -	 * A reset method returns -ENOTTY if it doesn't support this device
> -	 * and we should try the next method.
> +	 * A reset method returns -ENOTTY if it doesn't support this device and
> +	 * we should try the next method.
>  	 *
> -	 * If it returns 0 (success), we're finished.  If it returns any
> -	 * other error, we're also finished: this indicates that further
> -	 * reset mechanisms might be broken on the device.
> +	 * If it returns 0 (success), we're finished.  If it returns any other
> +	 * error, we're also finished: this indicates that further reset
> +	 * mechanisms might be broken on the device.
>  	 */
> -	rc =3D pci_dev_specific_reset(dev, 0);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	rc =3D pcie_reset_flr(dev, 0);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	rc =3D pci_af_flr(dev, 0);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	rc =3D pci_pm_reset(dev, 0);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	return pci_reset_bus_function(dev, 0);
> +	for (i =3D 0; i <  PCI_NUM_RESET_METHODS && (m =3D dev->reset_methods[i=
]); i++) {
> +		rc =3D pci_reset_fn_methods[m].reset_fn(dev, 0);
> +		if (!rc)
> +			return 0;
> +		if (rc !=3D -ENOTTY)
> +			return rc;
> +	}
> +
> +	return -ENOTTY;
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
> =20
>  /**
> - * pci_probe_reset_function - check whether the device can be safely res=
et
> - * @dev: PCI device to reset
> + * pci_init_reset_methods - check whether device can be safely reset
> + * and store supported reset mechanisms.
> + * @dev: PCI device to check for reset mechanisms
>   *
>   * Some devices allow an individual function to be reset without affecti=
ng
>   * other functions in the same device.  The PCI device must be responsiv=
e
> - * to PCI config space in order to use this function.
> + * to reads and writes to its PCI config space in order to use this func=
tion.
>   *
> - * Returns 0 if the device function can be reset or negative if the
> - * device doesn't support resetting a single function.
> + * Stores reset mechanisms supported by device in reset_methods byte arr=
ay
> + * which is a member of struct pci_dev.
>   */
> -int pci_probe_reset_function(struct pci_dev *dev)
> +void pci_init_reset_methods(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, n, rc;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] =3D { 0 };
> +
> +	n =3D 0;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) !=3D PCI_NUM_RESET_METHOD=
S);
> =20
>  	might_sleep();
> =20
> -	rc =3D pci_dev_specific_reset(dev, 1);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	rc =3D pcie_reset_flr(dev, 1);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	rc =3D pci_af_flr(dev, 1);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> -	rc =3D pci_pm_reset(dev, 1);
> -	if (rc !=3D -ENOTTY)
> -		return rc;
> +	for (i =3D 1; i < PCI_NUM_RESET_METHODS; i++) {
> +		rc =3D pci_reset_fn_methods[i].reset_fn(dev, 1);
> +		if (!rc)
> +			reset_methods[n++] =3D i;
> +		else if (rc !=3D -ENOTTY)
> +			break;
> +	}
> =20
> -	return pci_reset_bus_function(dev, 1);
> +	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
>  }
> =20
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 37c913bbc..db1ad94e7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -33,7 +33,8 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct=
 *vmai,
>  		  enum pci_mmap_api mmap_api);
> =20
> -int pci_probe_reset_function(struct pci_dev *dev);
> +int pci_reset_supported(struct pci_dev *dev);
> +void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> =20
> @@ -606,6 +607,12 @@ struct pci_dev_reset_methods {
>  	int (*reset)(struct pci_dev *dev, int probe);
>  };
> =20
> +struct pci_reset_fn_method {
> +	int (*reset_fn)(struct pci_dev *pdev, int probe);
> +	char *name;
> +};
> +
> +extern const struct pci_reset_fn_method pci_reset_fn_methods[];
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_reset(struct pci_dev *dev, int probe);
>  #else
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a95252113..a3e9a9c88 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2406,9 +2406,8 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
> =20
>  	pcie_report_downtraining(dev);
> -
> -	if (pci_probe_reset_function(dev) =3D=3D 0)
> -		dev->reset_fn =3D 1;
> +	pci_init_reset_methods(dev);
> +	dev->reset_fn =3D pci_reset_supported(dev);
>  }
> =20
>  /*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d432428fd..9f3e85f33 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -49,6 +49,9 @@
>  			       PCI_STATUS_SIG_TARGET_ABORT | \
>  			       PCI_STATUS_PARITY)
> =20
> +/* Number of reset methods used in pci_reset_fn_methods array in pci.c *=
/
> +#define PCI_NUM_RESET_METHODS 6
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> @@ -506,6 +509,10 @@ struct pci_dev {
>  	char		*driver_override; /* Driver name to force a match */
> =20
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
> +	/*
> +	 * See pci_reset_fn_methods array in pci.c for ordering.
> +	 */
> +	u8 reset_methods[PCI_NUM_RESET_METHODS];	/* Reset methods ordered by pr=
iority */
>  };
> =20
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> --=20
> 2.32.0
>=20
> =
