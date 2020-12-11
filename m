Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBA2D814F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406437AbgLKVws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 16:52:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56528 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393025AbgLKVwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 16:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607723533; x=1639259533;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tgJ71mbjaFfiwBso8x6Q+ZvaQudcDnf0t5I22yz3FKc=;
  b=ogFcxJ0mUSZX9+fbl+PZfUOqSI3xkzdr8tREUugRRL/GBV5KgK7KINQL
   /HjQC6I05f2v22JFDoZ+R4jRYcdCliFK43sIUrYSOO72NJLNkyh0iCwif
   gorcBcOrgO3tfDVNFIQX60tkEYG/tKTi99U3kihxtQ65UwJT3hCf3s+jF
   WO2VxyJJMTcIBgKA5hGiXHbtudY8V4QR4N1BMKvVYtqzvCtk/gJhZ7fFl
   5Ampvx7mW1cg0ZJueT2xTf50OfSvIfetSDISoUtmXNV2AvZ3LOe3NgZ0k
   JPuv1Gmp1YXFl93trV3ddJiyhjQ48XMxOD5HEh238qAWuDNjXkaG9alez
   Q==;
IronPort-SDR: CbR0Be67DWTqZciaZwLbPmd9C7A7L67LWwkMxnOL6akGezHCJKPu630plRwOXc4dF4S3P4bNMk
 AGWeYtMkqGx91ZWUfF912r/aUx1MOJP8++t99rYvDcOfD6b8kUauBOX4vMZq84q+CpcgMoUMFB
 SuNFs/sVCk3zh2qYsrD1xSMJ270U7Y0NNsqg+MlEC1E/xApjoS8nrgNou6do+dIooBJwt0dMia
 apUDG+El+mQm+ztbNUYGUnGYpOPAkFIxDQMeugqbSbzZLexndqeMYW3lbnzErRohY5EJ1c+XQV
 obg=
X-IronPort-AV: E=Sophos;i="5.78,412,1599494400"; 
   d="scan'208";a="159428056"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 05:50:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVYbGXKVWbPCy1dvXGBUQ7hR4wfPsVJzz7aoGYcbM89NGGq3nyOEsz6NP+/Ve/w+jfmEVOOGW+EV2NRzeHFU7+RGNzJdN+O7wnsvmo/rEDpMARArv4tXgt1GBGIUK2Qd/udxTV7kIGlWd8SLz77Gd/sb7ELUraSBtvoXZwFXiqGduUoTaeVyjNoM6BTHbJpHrPQgtgOhNqN8VN08RRM2J3sUGv7OaAZVFqzigRCN9WryAeV5PpTQW1HbRDEuV0aFX121v7m556DXJr9QBlchn9XCvpB7GuLRsNYRsPV8fzircSu6q82CDSBzpZFRZDW2s4IrGNlNu6rIhiGJBp1WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpVLfmPFAMoTlGC2JvMEbIde1Ot/st+Y/fjPvtLhrIY=;
 b=jryG2F5XEXGpjwoSUTzRtsPDlAu8+lhErqy1qdQ/18MJweC7yos2v9xdoUtRyT0Z46SMmcZKmOq5F23Stgf3+/dsoA/moIzuecRp8fcYHPmVjqKUgiTIqsvb2jctbM5g74/s+8J6N9Opub7xstcCZrDrIyKJgeuqQCfl0VryPcz+64mZbL2NLG+PCRDXebd4N7dqk9vXRpzx7McMLNO+M1ihPMwdDbMkzMnnL2vmw1O8irb6+RsOQ9e8QB0TUiHi++YDrJjqtTCLLmkBxFO/oQToR2qLUNn/pbNxNqkeTr/3YJzZRI5zSBAt697Wo/zQ9T+5x2lyDOD7dH4aHewyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpVLfmPFAMoTlGC2JvMEbIde1Ot/st+Y/fjPvtLhrIY=;
 b=hM9t5VdaPC3ZcDG3psmaT3FbWIwrBBKm/4H4VKbOwOBlCfEqb6oji32QfYcU6rNZefPXCDBvvPA+70Ko4czoxIQre6TzFfFDtpF02obsGzIe4eKI95nYUlTKJQoJjdSlwBtOd31ImEiJFSJV0mcoBFniK7ufhz822bLcY7p3sAQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3958.namprd04.prod.outlook.com (2603:10b6:a02:ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 21:50:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Fri, 11 Dec 2020
 21:50:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: skd: remove skd_pci_info()
Thread-Topic: [PATCH] drivers: block: skd: remove skd_pci_info()
Thread-Index: AQHWz9z+X41O+6EQc0KJnRIciprIXQ==
Date:   Fri, 11 Dec 2020 21:50:52 +0000
Message-ID: <BYAPR04MB496513CB49E42A3467427BF686CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201211164137.8605-1-puranjay12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc9a3a23-85fb-4267-8300-08d89e1ed4eb
x-ms-traffictypediagnostic: BYAPR04MB3958:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3958ACC0AD18C2558919906886CA0@BYAPR04MB3958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q121NoGuewogx/r7vEko0noTYCcdbSlO+hs9O7MKot487FeJWRNsvK1rUfvxWypFB0LxhRdQrUcx8N3d8xElYhgTS3KBga7CSxpJv2Q1WXX4XEwLuFMepyeXEnjQ9PPQfgn08qOnsfkIM6PTnQHGUHcOf+3rsMIOUuTUDF5a9YlK6nX4Z0gbA9GDDszcIM6zzGmr6mKmwwgu0k0rD/7uaz8S/U/oPUJ5ygQ3R4sVv7jHVqxcVBPco9Rik6BSh6JmPFKrIZSu0EeJnhSgl12M9KFKlQgIKGmpTkBS7p1QQMah6CRWkZBJpAistwoL2ykSBmaQNNrpben0Lp2xPzVZIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(76116006)(9686003)(6506007)(71200400001)(110136005)(66946007)(66446008)(8936002)(2906002)(52536014)(55016002)(5660300002)(86362001)(66476007)(53546011)(33656002)(8676002)(66556008)(64756008)(7696005)(508600001)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YCOj0pXbYvGoH7YzI9sC/uYKDN8kJsoUgQsPZydfJHKbMtCdqSTVmadqQXo1?=
 =?us-ascii?Q?EUfTGsf560XEvzn/AcrDZIEWuPLEuuk5bHNvbiBSqRNcGrwJyxJXjxgcSaqM?=
 =?us-ascii?Q?EgEDpOziPT0+ha95xWjNW8iXJEru30mJnoib1R4Bq9KiTrajM8tMm93+9hyj?=
 =?us-ascii?Q?nU+1eiy2e5s8JcyqBshmfD3Niutbl3OehwySTuDQMXHPvTfltm6uG/5tyCo2?=
 =?us-ascii?Q?Gjc2AwznXLeKCkZ3vtrDuM16B+BL79etIqV9opmZjpIJkZsQ+AeYzMdZF/nF?=
 =?us-ascii?Q?vBxX0i+FLyW9ga0jhN53AGMOc78n4ZhOEpYz1R3HD9WnXRbNCYRMVuXwIMeB?=
 =?us-ascii?Q?pNXPl82mnmzXfTuMvFYdz7gO9FdYOeHF5f5bvP2z/ss/ImOAhpJOZn7wSxqH?=
 =?us-ascii?Q?OsN9HZJYfS500D1AM8VZuaxHVxZ5Eengn/ylyBnXWTSPL+EtttF0S6q4sfS0?=
 =?us-ascii?Q?C2cNkAD4eUmFuxnBFeNydAcbX9cQLs1DWZaWpnskMnnBFnGFbE6bd+DMiPq9?=
 =?us-ascii?Q?Bn1uWAtJFK38yUFab+JD1T8J2UKpuGDAhiVVVowadFjTfoBBsK3MqRxTWU4c?=
 =?us-ascii?Q?+N7wcKLf8a9GEZOs0DfBKWQjppeqRm2A2IkHs30AN5UuvWPNqGx33oPAGKmk?=
 =?us-ascii?Q?v2sS4BqZfestfwZDOtNDfz7pxbkQWEqZCJABA5VUZyKBoMSnZq7OOUEyTRSU?=
 =?us-ascii?Q?7jQDCETFh/Jx47xPBcdafUJw3B+OUXlY/ItDYzQBma43ouzK3hw1idqNAHmN?=
 =?us-ascii?Q?4lMaG9PsNS6YfZvsQ2I6Efb1bCWrioTawgIuhdOHUlU+VvAkJOF5HbjusOco?=
 =?us-ascii?Q?8BgyvDLhRqh3f96KNCPYK/+1xFBQgd2bqSXNmPNasCSvxRupPCiUlV70NMuT?=
 =?us-ascii?Q?OvJ9Mz3qyzF1p/6UyARaOW06NlQp/W95xp1hspXZJdUExUy/P7ZpufcQYJ8v?=
 =?us-ascii?Q?GjbRAnv3Ef0Fe1WRW3xDZxnlFBLoBp6vu7/zbhRAMaYXSGPzKfqQrQ2e7rWh?=
 =?us-ascii?Q?2sfi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9a3a23-85fb-4267-8300-08d89e1ed4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 21:50:52.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzIK5DtNcmB7cSG0nkRJ32jg36nVt3UBe4J9/kiea4YPdqpe3gZ+UkC3Mwbv6U31W7N7BTdrIvuiJQI3/kEY5EaDV6xPkJSn89R5FWVNRdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3958
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/11/20 08:45, Puranjay Mohan wrote:=0A=
> PCI core calls __pcie_print_link_status() for every device, it prints=0A=
> both the link width and the link speed. skd_pci_info() does the same=0A=
> thing again, hence it can be removed.=0A=
>=0A=
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>=0A=
> ---=0A=
>  drivers/block/skd_main.c | 31 -------------------------------=0A=
>  1 file changed, 31 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index a962b4551bed..da7aac5335d9 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -3134,40 +3134,11 @@ static const struct pci_device_id skd_pci_tbl[] =
=3D {=0A=
>  =0A=
>  MODULE_DEVICE_TABLE(pci, skd_pci_tbl);=0A=
>  =0A=
> -static char *skd_pci_info(struct skd_device *skdev, char *str)=0A=
> -{=0A=
> -	int pcie_reg;=0A=
> -=0A=
> -	strcpy(str, "PCIe (");=0A=
> -	pcie_reg =3D pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);=0A=
> -=0A=
> -	if (pcie_reg) {=0A=
> -=0A=
> -		char lwstr[6];=0A=
> -		uint16_t pcie_lstat, lspeed, lwidth;=0A=
> -=0A=
> -		pcie_reg +=3D 0x12;=0A=
> -		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);=0A=
> -		lspeed =3D pcie_lstat & (0xF);=0A=
> -		lwidth =3D (pcie_lstat & 0x3F0) >> 4;=0A=
> -=0A=
> -		if (lspeed =3D=3D 1)=0A=
> -			strcat(str, "2.5GT/s ");=0A=
> -		else if (lspeed =3D=3D 2)=0A=
> -			strcat(str, "5.0GT/s ");=0A=
> -		else=0A=
> -			strcat(str, "<unknown> ");=0A=
The skd driver prints unknown if the speed is not "2.5GT/s" or "5.0GT/s".=
=0A=
__pcie_print_link_status()  prints "unknown" only if speed=0A=
value >=3D ARRAY_SIZE(speed_strings).=0A=
=0A=
If a buggy skd card returns value that is not !=3D ("2.5GT/s" or "5.0GT/s")=
=0A=
&& value < ARRAY_SIZE(speed_strings) then it will not print the unknown but=
=0A=
the value from speed string array.=0A=
=0A=
Which breaks the current behavior. Please correct me if I'm wrong.=0A=
> -		snprintf(lwstr, sizeof(lwstr), "%dX)", lwidth);=0A=
> -		strcat(str, lwstr);=0A=
> -	}=0A=
> -	return str;=0A=
> -}=0A=
>  =0A=
>  static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_i=
d *ent)=0A=
>  {=0A=
>  	int i;=0A=
>  	int rc =3D 0;=0A=
> -	char pci_str[32];=0A=
>  	struct skd_device *skdev;=0A=
>  =0A=
>  	dev_dbg(&pdev->dev, "vendor=3D%04X device=3D%04x\n", pdev->vendor,=0A=
> @@ -3201,8 +3172,6 @@ static int skd_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)=0A=
>  		goto err_out_regions;=0A=
>  	}=0A=
>  =0A=
> -	skd_pci_info(skdev, pci_str);=0A=
> -	dev_info(&pdev->dev, "%s 64bit\n", pci_str);=0A=
>  =0A=
>  	pci_set_master(pdev);=0A=
>  	rc =3D pci_enable_pcie_error_reporting(pdev);=0A=
=0A=
