Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3B2DA455
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 00:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgLNXmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 18:42:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64390 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgLNXmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 18:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607989369; x=1639525369;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=33PHwqJ/wK7i58gbDwOM9s3fmUfMYZ3NWhii2Loltb8=;
  b=b1aUXRD/Mpp40RsydPV9qH9j6DnTB1mCGbEzfI3bKqUZmidkSXP/Tm7O
   H4XfhfVJD6C/Gs7sgSyULRUkSxtX8CsVdv59Pkl6DOL1r8K7QuiMWr6bu
   Wi/lH6Tz0JARUBsE4Sp7Q27IZZ69JklQ1mBLY4CcM2OoBPz5rkASN+FDg
   nZ+iQC7mKtQsuTA3QLFR0Oqnr03EE5vjaoXKi8F0QI7U2SyVZWqWtCdr/
   5ZfCdA61G+YHIJNbyNY/NLE6SYPio2s+Fuys6NxU3KaAWES/wMkluAd2J
   eqsf6xIEtpIdSjYBREMz39umes6+fhrrB/vDLW1RrJ/gexo5I7wunxpQK
   w==;
IronPort-SDR: 3Ef9NWsCimbXCOb9mnDdS8T3kH6ajS4+1nWRkFxrAfpa9tt11pHCvqdYTA1vii6ZBsekpbsD1G
 t5+3l5w3JpgR6NpjY6fMLF2rcQjHQV9DmggOZmfkQcHmRhkcrlSqaH87mnZqAOp6pSAa/IhKgN
 WrkIrwh2uxAXirEDaM8SAUbH/c+rGd3mcSnA8O9m4YDbMHoEGHLHOSSqDFRMFJofxgSD/9ZWe9
 +OJmX29rhbIvwx0U1wbYhJLNaMRZ2rMsqrRzahd5Ny0zpkEtRV+HUE2Bsb57g50VQTmXfeo7K0
 3CI=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="156347789"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 07:41:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7Q7bHb1csnpklnTxyDpK+5FLl6qWGZTFjP1ARCorsSbITwbNWhPuKHXUjBS+uJQHEW7nBNEP7jv7rynAucxyAGRYH5M+flL4PDso/qJlKlagwPt2033CmCcUrZfV4Fpu33CRbDuK6YJYvKO6mTw5UVNjsFOePAYmNvmlZUZG8YvQMjoZhthUZyOEdtL1T8mtzlGTyMPKaINfEvBFxjpoWIiBgIC2CXFRQrtPmLfYP+tD4eC5dz/OtOnPz/JB+pEEjs0T8BF0neH0RZFmHKh1LTRXHkCaXudMxQuBaatE7EZGePac/eKFdZje8SDvqFlzq2nTW7JWzcbesk6R+FZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/rBc+wGKc+WqoTqP/m4T4UKGqpfwvZpf0Ya8vDxQLo=;
 b=IGAdg7IoLH9DcumERRL0c3zh+aTdMZvCFtiAP0iPYodM8Q7f4pTPuG+p1zDviwDxXc9xdN49nn6iizwWtZwMqV9I7bRQ3Szwtf0lVtpYd+aE8IJaAp6CA7ieZ8En7wEkrRulj1yMxlqGca2bJnSGGNNt85lY9UmkxdPnv6OM134TmX/dyXQdfhZ8ZAnTOzU+CA2xHrm8Ck7p5j2W2zscLMg9UEyDRtNwtifgcwOJzbtLoZX/55BdgXQ/KoLw+Dqxy7ukUqWR15LFLZE9IuzW57WAkA14DvMMVW++RCuWV66s67eJS74DBqo+t1rCIFTMS5xRHftVSibb3yRxuBuePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/rBc+wGKc+WqoTqP/m4T4UKGqpfwvZpf0Ya8vDxQLo=;
 b=eL7JUgASPWc/D3RBf9UEWh8PbUIBIC/RaFSUHRcULBlCrdVw3qj8W/tygyQE6mXaoWKCcD1iJHCXUE6qCFVxQmXbubbbRKceNljyivhj3LN0N4Xf/OEIGLkXTucrU9cWdgWHBR0q5Ul/HtQuEf375PPOPMALqZ2J7704vzOm70M=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6760.namprd04.prod.outlook.com (2603:10b6:610:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Mon, 14 Dec
 2020 23:41:40 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Mon, 14 Dec 2020
 23:41:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drivers: block: skd: remove skd_pci_info()
Thread-Topic: [PATCH v1] drivers: block: skd: remove skd_pci_info()
Thread-Index: AQHW0i2wqDaNil4lgECF1jii2YcNxg==
Date:   Mon, 14 Dec 2020 23:41:40 +0000
Message-ID: <CH2PR04MB6522E0FCC3673C97064156C7E7C70@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201214152720.11922-1-puranjay12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4d8e6ff-e2c7-4e29-7a09-08d8a089ce8a
x-ms-traffictypediagnostic: CH2PR04MB6760:
x-microsoft-antispam-prvs: <CH2PR04MB67609FFE5EA09E62E199A9C8E7C70@CH2PR04MB6760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:191;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6P8hVyN9/xGgikENqTIVVinoMjE/FwXzRiUgSBG+9unnAE4Ckxvs5KCai564JkQFQj5GvYYn4w0+Hk7Xi8wE6nBQZ5mXeLVpwpi8RwqIRUe/mwozuuF4kRzZypHm2pW7znl+7n2cyaZosBnFw2elxR0liSReJtjz91kjR4tMU6lmGua0Wl5pYj5XFZBSl6jYIkVCMx/MAzK3AdKgGe2c6pn7qNebWHvSR3J+oAnl/XdgC0TbWMl2gR3pAkcJPlLm8Pk6wKnV5D19P/1UF1i5FzkHijfGgqHZr9UeI1XKwBMh2Yf/GN23pCeDKgQ3yGqys9kR6Caoq41o5BXMYNvOlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(9686003)(52536014)(5660300002)(64756008)(53546011)(186003)(2906002)(8936002)(66556008)(66946007)(76116006)(66446008)(66476007)(91956017)(110136005)(6506007)(71200400001)(7696005)(8676002)(26005)(83380400001)(55016002)(508600001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h0Mbl6VK50wjO2p4UW5UAv8VjSOMwLFmpkhP7769wRr0yBnsgn2Rbqs266lV?=
 =?us-ascii?Q?M8911XzGkNLSnUtO3erc6z8MkgIC5nMFPNFlY2zskNbgIR2DZai+sNhmTEQP?=
 =?us-ascii?Q?L5F/lH8A5NhBSRT08A6x1V78ZxLnOoWk4qDTarDi1rW16TVvhM37dPuW7WDE?=
 =?us-ascii?Q?DwmEVrM6OhoIcbvzdbIRFlfL7o7tYMwiADE+HcxJGs1/NTxhfVOXASBHUGWZ?=
 =?us-ascii?Q?LNtWoSfmG/xQZM9NgPyMQWja24XZmxvUztjvAwlA5G52mNqqHFsXV8S89t7r?=
 =?us-ascii?Q?1+EwwkA0Y7jcqdzZ+BLE3GpIyj+iz7PlPsSHkmJub2RBZMgYE3rMKfKRww3e?=
 =?us-ascii?Q?H08ooM9376v9w52EY4BTASmtoAIP2JPlSICAadZDtkBeG6y/eQc2AGPaAhK4?=
 =?us-ascii?Q?ifJWh8s2rRWP2TBlMRxtEHDbd4gQPZsZ7l5ezS8zTHvE/NgI2G4x79MUv7Di?=
 =?us-ascii?Q?Wl3zr0Dkhbrgwd06jjLXJlPPxKb7NDnhez+Jp1HV7FmfnSPDuO9JA7V0V3NT?=
 =?us-ascii?Q?1XAxQDmJE4BHbNjLcFiexwMcQTTwNLR/Yglh1cOKn8T3uHM7s3zOmc/RtKrD?=
 =?us-ascii?Q?m0vtZBWyk3tiew4pCwo2cqtNfyopS7O8XHgOpobDRZ9qeaZFykyVL8IMIo0p?=
 =?us-ascii?Q?KPxgrouClcPp1420yYpzhH2/2n+uPFPR2JIpx7stmWCNYxUjKPLpiaQHWD/E?=
 =?us-ascii?Q?NqFCfJsKlH6VnhdHESHom3j0WXrwHOvOy0XCGQPPvmQYWFiwvGRjoQ8jyXsV?=
 =?us-ascii?Q?taBbW84bEHUJefhiWDCMyc6EBT6AU9o/mYNNd4RxbC4xcNz0zmjYxw95HLqP?=
 =?us-ascii?Q?olepakqaQPESu8SITvcI1lYf2GMyrNuK5dWPcGHwzxCcKXZpv2Ujcju34nEy?=
 =?us-ascii?Q?ibqKzYhJkh0ep6HnIsI2EuFoz/H+7yBmuM1mcWT3sWevzdiKDb003A6RRvKG?=
 =?us-ascii?Q?qRiBnqLvnlGBVQ1WlkEqjlocRW3MymbBBh2iFB9hr522W1ueFlODPnEE7gnI?=
 =?us-ascii?Q?tkXg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d8e6ff-e2c7-4e29-7a09-08d8a089ce8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 23:41:40.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rnl1CaQ9yY6qi4hVgtNL5VKooJ8VLz4LSEdq2SQX3skGykTtOFer61W8MYPgvNPMaGnUHQNHxFXXyMI5TncruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6760
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/12/15 0:27, Puranjay Mohan wrote:=0A=
> Change the call to skd_pci_info() to pcie_print_link_status().=0A=
> pcie_print_link_status() can be used to print the link speed and=0A=
> the link width, skd_pci_info() does the same and hence it is removed.=0A=
> =0A=
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>=0A=
> ---=0A=
> v1 - Add call to pcie_print_link_status()=0A=
> ---=0A=
>  drivers/block/skd_main.c | 33 +--------------------------------=0A=
>  1 file changed, 1 insertion(+), 32 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index a962b4551bed..efd69f349043 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -3134,40 +3134,10 @@ static const struct pci_device_id skd_pci_tbl[] =
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
> -		snprintf(lwstr, sizeof(lwstr), "%dX)", lwidth);=0A=
> -		strcat(str, lwstr);=0A=
> -	}=0A=
> -	return str;=0A=
> -}=0A=
> -=0A=
>  static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_i=
d *ent)=0A=
>  {=0A=
>  	int i;=0A=
>  	int rc =3D 0;=0A=
> -	char pci_str[32];=0A=
>  	struct skd_device *skdev;=0A=
>  =0A=
>  	dev_dbg(&pdev->dev, "vendor=3D%04X device=3D%04x\n", pdev->vendor,=0A=
> @@ -3201,8 +3171,7 @@ static int skd_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)=0A=
>  		goto err_out_regions;=0A=
>  	}=0A=
>  =0A=
> -	skd_pci_info(skdev, pci_str);=0A=
> -	dev_info(&pdev->dev, "%s 64bit\n", pci_str);=0A=
> +	pcie_print_link_status(pdev);=0A=
>  =0A=
>  	pci_set_master(pdev);=0A=
>  	rc =3D pci_enable_pcie_error_reporting(pdev);=0A=
> =0A=
=0A=
Note: V1 of this patch was the one I commented on. This one should thus be =
V2.=0A=
=0A=
In any case, this looks OK to me.=0A=
=0A=
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
