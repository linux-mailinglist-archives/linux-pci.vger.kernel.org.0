Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6553E4488
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 13:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhHILTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 07:19:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:56882 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234657AbhHILTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 07:19:01 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179BDsaH017234;
        Mon, 9 Aug 2021 04:18:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=XWZU78k4//MXXanocbr4CL+sGBdV9L9CVBJ6xLW5nGY=;
 b=vp2RLFLFudFQ88HG32WmNCmf+GbaEkKO0wpUSTfvCjlFfdStaHzboJRWpNSBgW84IOZa
 tNtWGJtVpj4ppOM3GqjvUnY3OpksCy8AR9HKWKgXpPjh6I3WJyiwSHCtasP2IvWXgrnF
 hbuF07IOgYSINc2I01MGSEke9ToRETf5uORR+Fps1AxFSPWN23xHW56UU7QTo61ptuIL
 92qNVDsxx8NSEMS7UN/7NZBDduW5tg3XeGNfUKGzVpg1IT8MvvUkQbbG9SGZPUZL0sOQ
 cSkU2h5n81AebM/46QfbBQZt3Bwx03liI1BtO/g1R7/8d2t2Ahc44nnvcQpTIAL+/X07 7g== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3aawvg8k4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 04:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3C5w69Zzljxv1XsChVOUts6Fg/Djbth1DU8sz4Ynud/7CHNvwFU94JiM7PY8Q0U7ACrDhE3TiNCEuwjPjAsThPMx28y89qNEmnjBJhRnOx68A9Q/I7mKIh6neo7zDPbgt4B8p+1A3jFhk1BmdOyNKM+t82muqSsYoCzDHLt8P+RXK2udgr5I2+gWRABaOzJhYy4ghmlbVSklOt+IiVhTuvtCBdVw2uLfj1Bw6lQbP1YLQKJysOEZha9ZSFiagD6Qc4uQuZVHCU8A93ic1kItQYusUxl87pKg52PoPSQ7F4c0v7bQFe75Jug+f2mYLhPra/V1svgZbM9RWDY87PIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWZU78k4//MXXanocbr4CL+sGBdV9L9CVBJ6xLW5nGY=;
 b=eOvLCTMIIbPWiFVvXr2EQKsNmEwqQro1d2sgH4rwRvcxWv8PSQBUKq45COk/cJzbgm40FmhhFqBKQ9pu/DqbJOXrrQMZvsAF/HlkbEYm68LpDMWkTXnthI6WxDK0CKoD6FItxouoeLESasBiMSpwExTj7NnZDTE3WJWu6HLHPsEaQgpJQgk6I5QlbrFZZ5I1FO5C4LT1CW17XAZifylLeq/FXoCk1OniLAOJLejjVZqaXYyqqO1xSG09hUXznmvyUPsz8up+5p0SOK7/lxN7eAfv4Ci1u/4lzWGYstduCfAfMaiKeNr0uvEUTgRSq3A3po559mVCQWDeAuMvIVChww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA2PR02MB7754.namprd02.prod.outlook.com (2603:10b6:806:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 11:18:30 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 11:18:30 +0000
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
Subject: Re: [PATCH v15 3/9] PCI: Add new array for keeping track of ordering
 of reset methods
Thread-Topic: [PATCH v15 3/9] PCI: Add new array for keeping track of ordering
 of reset methods
Thread-Index: AQHXihceJQWkKHzgeUClq1YdfagqhKtrDGCA
Date:   Mon, 9 Aug 2021 11:18:30 +0000
Message-ID: <20210809111829.GC867@raphael-debian-dev>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
 <20210805162917.3989-4-ameynarkhede03@gmail.com>
In-Reply-To: <20210805162917.3989-4-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95d59df7-3fc1-47dc-3e3b-08d95b276ad2
x-ms-traffictypediagnostic: SA2PR02MB7754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR02MB7754E3AC34919B8A551F985AEAF69@SA2PR02MB7754.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/pr4Jtte8I/Aj7kZVEBDTBdC1L8KYQVjyC0HxR4kvgVQFGnIimi32TvDu7xiq2DVkTFWeUUi2X+LMwruzC2iTASSynqGks2WSoiaood2byocR7YnobSFVPwDBRezfJaE2pml092yGniGZFr7WVLrz7PpggZQn4QnBEoq4b9t5DYtssGUmqy0KS76gQSTuQOHgpHgDSPQ55ODrQcvepOQVXCQkSRDRqR+EJG0fQTv5yU3k1h7ucBipRif/lDGw7xZ/7qxlGy7pk6TaJD67FUyiTqrhWxOib5GfrDNMv/1Wri9hhzgGwgEkVca1Br2FCG5a6P6FOyH/GN4Bx1mmLr2Xzw811TxNUlCwJaBCbPlkTIkWdtZj6MXMzzmBb2ebtVEAfVDFf0/rgq7kHRtLgoyTUNWT4RFymKA9ByqelJryPWTgLZ1jn3ZTAuS9P2xez1EgxB0zyr2YhOPjTNPczl4Pih9DrqxUK6vhdLhImRfC+CuqeQWk56HOcoXv5/Wi2HLChzp5kz+MVFcHSmZHXETZ3qkVy00fIa59LiErhXhp+LwgrP2ZPnecVJMNNI88Yr5d2M0EOK803kbDpMofvkLKVUjSK9lX41ck0/2LpqRZTh45W2msBEiU9IUmeyHPgTsdHDt1Piu+jayhhlhi3XxTnikq+b9TvAz7cvAwE/+QVaAewLZOemNKCRyx2TsLrneRF1I90BeeSohJHSuATP2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(396003)(136003)(376002)(366004)(39860400002)(38100700002)(91956017)(7416002)(2906002)(6916009)(54906003)(316002)(71200400001)(86362001)(122000001)(44832011)(83380400001)(64756008)(8676002)(4326008)(5660300002)(66476007)(66446008)(66946007)(1076003)(26005)(33656002)(9686003)(76116006)(66556008)(6512007)(38070700005)(8936002)(6506007)(186003)(478600001)(33716001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zefMHNL40zAS7+L3MiSE/nro8U0dCHeMzXhKdGJrbNk+jxTeGWWZdS703mUk?=
 =?us-ascii?Q?7z9h+u9BQanbREljDA30RNzesNEiytq2n+6imrQlE0Os6QkdahoUjXDcwpBe?=
 =?us-ascii?Q?TamwTzNGeFaMgp1/a9d13z7SKnw4PbBYvVwrYtsaYfF/OYW1hIljPy+drclH?=
 =?us-ascii?Q?cS60y9iysZP97zLrmG16hMcuyQ/m2b698M3EzxBxQr3w7AUZPOblLXs5FeLP?=
 =?us-ascii?Q?h7C2CvaAYqY/385aNmhF652wzB0wgepo2kZGU89lQf5fAi3D4VgmO4yhc1oh?=
 =?us-ascii?Q?f9LC/0gxWFB3Xk+3/RRp6UhgKiDa6NMd4K9RrMHjTDGP/+bprgF1O8+gBf1J?=
 =?us-ascii?Q?LvUH7wBO+oUFXoxlE5qRgywHn75QW2eHeBEspNG5dwUZN3YIhN0C0mu+TEmX?=
 =?us-ascii?Q?2VS5R+LlXDEQj7fysrEGamDDR1Kk8JQWGOC3O8JDgeaZSD/N7cnJmFcq1+Uq?=
 =?us-ascii?Q?PMzHMfooeUYVYzj+3NJ3LxZYJvTlYGkz5DyLuYcnFMBRqNxIsTdoLpZQH0Vd?=
 =?us-ascii?Q?vRAYrj4BMyJILp9VHazSm8iyoL6sbkBojF2Rf4v1d8J6DSQiJgcA93Kfjl0w?=
 =?us-ascii?Q?SkyFMUQjMOhFBAn70xORVcWo+Nm1RViwRLfOxvcRY97cwsAzwV77pQx8C7O9?=
 =?us-ascii?Q?ENchYCqnsDEHZdVBoGpE2gWainR3TtaRKio79uB7bvDv+xLsiBpqqQ93/9Vm?=
 =?us-ascii?Q?on98oYv49UEGaDqHT2QF1Kh8U2/0YfvlbGy3mHr7SxroymbHaGS/KUa/nswS?=
 =?us-ascii?Q?WGxMhfyCa/y7BQTMCgq2LXfeuNOtyH9pelyjEYl/JoyMNx5BdbN5Ys4HbNyE?=
 =?us-ascii?Q?sf0EtIypEo0Q7wGxKh48Z1hlK7pEEE884PdCCbgoY7BPx+yMbE0UUSFIuZAK?=
 =?us-ascii?Q?tBnv0r866uOSifNxlr+nTx+2GnU6cJllbtIq4jozpHVT3YNpgVX7tOeaZTMa?=
 =?us-ascii?Q?hnl5nWr0tMF8hNr21FVccVBBZ9iGDiwOuU+5XN+w+Pd+tAlyBqEbeiUhcOrE?=
 =?us-ascii?Q?mQ42Vi/NBuun84qvOiuq727vJfrMKjCcMVoeCnFQP2Hcd3ZgLg/VaXIBYnFs?=
 =?us-ascii?Q?NqBc/771qPPqrqyE6aweYDNrnN81PYj4si4ikOvO4VHdp+ViybvZmwXiP33o?=
 =?us-ascii?Q?AHuKsApx5x6CWtncUOWZexRVu8BAXxfwai1Ozj1tjSdIQUMdaTIITsCOgR4l?=
 =?us-ascii?Q?wdwUfVVWkHG91tJHLlfCKEy5Nd77gSLgqNGI0f1TYVKm/vJCoVCCFSAbweEx?=
 =?us-ascii?Q?babj3chVjLCd4d7++Cv6giCeMvWVgeobPwAjQbRURzmRx7+9Q4maepyzFw4g?=
 =?us-ascii?Q?Rj///yrDHPOUeSZ7GCjqb5k9?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D976191F7C689C4CA058310CDE2FF925@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d59df7-3fc1-47dc-3e3b-08d95b276ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 11:18:30.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx73cqjStICRwVjJm+8V8uw9TUhB5+3ZrJPqgjgL+SUrE9Oq1hwydxZJv2dSIAAz8ieJT2QefUGKSTNgwB8XBfwYDhy98LLqtgc2AGBcjgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7754
X-Proofpoint-GUID: 48CjXpEmc_1Y1p2tnxuabLFg3O21MkuT
X-Proofpoint-ORIG-GUID: 48CjXpEmc_1Y1p2tnxuabLFg3O21MkuT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_04:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 09:59:11PM +0530, Amey Narkhede wrote:
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
>  drivers/pci/pci.c   | 95 ++++++++++++++++++++++++++-------------------
>  drivers/pci/pci.h   |  8 +++-
>  drivers/pci/probe.c |  5 +--
>  include/linux/pci.h |  7 ++++
>  4 files changed, 71 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d1d9671160b..67eab3d29cb3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -73,6 +73,11 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  		msleep(delay);
>  }
> =20
> +bool pci_reset_supported(struct pci_dev *dev)
> +{
> +	return dev->reset_methods[0] !=3D 0;
> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  int pci_domains_supported =3D 1;
>  #endif
> @@ -5117,6 +5122,16 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
> =20
> +/* dev->reset_methods[] is a 0-terminated list of indices into this arra=
y */
> +static const struct pci_reset_fn_method pci_reset_fn_methods[] =3D {
> +	{ },
> +	{ pci_dev_specific_reset, .name =3D "device_specific" },
> +	{ pcie_reset_flr, .name =3D "flr" },
> +	{ pci_af_flr, .name =3D "af_flr" },
> +	{ pci_pm_reset, .name =3D "pm" },
> +	{ pci_reset_bus_function, .name =3D "bus" },
> +};
> +
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holdi=
ng
>   * the @dev mutex lock.
> @@ -5139,65 +5154,65 @@ static void pci_dev_restore(struct pci_dev *dev)
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
> +	for (i =3D 0; i <  PCI_NUM_RESET_METHODS; i++) {
> +		m =3D dev->reset_methods[i];
> +		if (!m)
> +			return -ENOTTY;
> +
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
> - * other functions in the same device.  The PCI device must be responsiv=
e
> - * to PCI config space in order to use this function.
> + * other functions in the same device.  The PCI device must be in D0-D3h=
ot
> + * state.
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
> +	int m, i, rc;
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
> +	i =3D 0;
> +
> +	for (m =3D 1; m < PCI_NUM_RESET_METHODS; m++) {
> +		rc =3D pci_reset_fn_methods[m].reset_fn(dev, 1);
> +		if (!rc)
> +			dev->reset_methods[i++] =3D m;
> +		else if (rc !=3D -ENOTTY)
> +			break;
> +	}
> =20
> -	return pci_reset_bus_function(dev, 1);
> +	dev->reset_methods[i] =3D 0;
>  }
> =20
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 37c913bbc6e1..7438953745e0 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -33,7 +33,8 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct=
 *vmai,
>  		  enum pci_mmap_api mmap_api);
> =20
> -int pci_probe_reset_function(struct pci_dev *dev);
> +bool pci_reset_supported(struct pci_dev *dev);
> +void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> =20
> @@ -606,6 +607,11 @@ struct pci_dev_reset_methods {
>  	int (*reset)(struct pci_dev *dev, int probe);
>  };
> =20
> +struct pci_reset_fn_method {
> +	int (*reset_fn)(struct pci_dev *pdev, int probe);
> +	char *name;
> +};
> +
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_reset(struct pci_dev *dev, int probe);
>  #else
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index df3f9db6e151..5d8ad230f7d0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2405,9 +2405,8 @@ static void pci_init_capabilities(struct pci_dev *d=
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
> index aa85e7d3147e..d1a9a232d08e 100644
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
