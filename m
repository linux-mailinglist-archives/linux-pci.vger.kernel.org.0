Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64182DFAA0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLUJ5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 04:57:15 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:18368 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgLUJ5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2020 04:57:14 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BL9qknN004472;
        Mon, 21 Dec 2020 01:56:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=sF50ZUiJayhk2XThcH1fKmjg3FvDwLZk2xM8dCoasCs=;
 b=LBZvPpKwHkszaaG1zFs53i9oGtaCi+TDnYPCheo4u2YkFcMb9v5WdmyVIq0hF9yo7/g2
 tYnl/lbmMoQmGYna9XIFRfzBEAGa2Tyj5LY7LGW/WpV/xGP/mlhxtlUCTZXzFYAGFM/h
 D/FCoCvIeby8Im5Db9/lRzC6hiWsgXcm96HufmyNLYzk0M5IR3Jnts+wBkjKHy1LPrGj
 RwPR1GVX451PQsQk4G4gmvpkTn7UAe5moqN2sgK8NypSwWZw4DrExiGwBbxP9g4saAPP
 vAQo161NPKI5GjYIV3aFL33JQsOHe3xIPP2LJLmnEhQSjWdmHHmTLuPFUhEXqpyut2oR Wg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35hey2mgpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 01:56:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewpDEMrqFnJTHcbuCdS6rNL49VAoUh2m4Hkr/BJi1gWfaw6e7M3313GF6XDcgvMH6Ljtp9R+5jQxa6VG07U75deamnAM24Vhtq2FePnmi0m1ZwQck668ezHs7vIlwT7GuragqOgpuJjIX/loWRsW4nTLIArg8Lod7AwRTmTzaxu7WVmPRd2esWPYabYCAnrQKlaCua7jDjmUktY58cCWORWQifIMphQwlqw4R/OpxVv7sdmripk0w0s5EZdLg1Ru84551PlMUPAAUix7Rga3nfIjPRgbt+X2ZhDGHKSr1SmUMvcDoQ6hxeQFs1WbMpzVczYOnKXTaCEtsB12i5zkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF50ZUiJayhk2XThcH1fKmjg3FvDwLZk2xM8dCoasCs=;
 b=ZoL96ssYxkB3SQEWgHGliIm9gwuenziV9LzVh+mVU+D4KJNri2tqYIAtcTc4qV5vrYPbmCzKPrBjDGtLOIHIvlmwQ+8vbP5iotYqYcjSAhzG2eusU74iFRqvfuGFT25HW+jIT2iOCTc0HahRMzy50N0ykI7wZSdVVZk+eANEZ6rJpP3gWJUUa9O9Olw7ZecGef0u/cOBQmbmJaKvp1EI0xXEu1nSvHoTXam3vDX0TmQnmJi6U2fcHZzCg705WrpfKzTe1B6lNvFfI9hNZ25kIfqJ5YrmgoLW8PKdNCBPzonw8RUPUoM9hwnYBtytgi2ZRIwLYQeARu18LEsvdi8g2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF50ZUiJayhk2XThcH1fKmjg3FvDwLZk2xM8dCoasCs=;
 b=aSSijEGFGRf2h3+oPj4Gw42TDR6p6zxRTiwsqShaKA7XO1BUE16c4BB9AnWYxyMOSAW9pZPHq/AyyeON3P7QZG/nmvj/k6fpW0s5ra3mZo37izRDo3EBC8wiWhsCT5g8wV4tXzQKispCDWEgjvq49at0O2bd1Q0ZyHz0CTqjIKo=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN6PR07MB4768.namprd07.prod.outlook.com (2603:10b6:805:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.30; Mon, 21 Dec
 2020 09:55:57 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a%8]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 09:55:57 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Thread-Topic: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Thread-Index: AQHW0q/zrZ1Sf6FZkk+47dkzT3Kdt6n4zyoAgAiIBeA=
Date:   Mon, 21 Dec 2020 09:55:56 +0000
Message-ID: <SN2PR07MB2557691709B30C5290141F99D8C00@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20201215070009.27937-1-kishon@ti.com>
 <20201215233028.GA336802@bjorn-Precision-5520>
In-Reply-To: <20201215233028.GA336802@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjVmNmEzYzQtNDM3Mi0xMWViLWFlOTMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XGI1ZjZhM2M1LTQzNzItMTFlYi1hZTkzLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iOTE1NCIgdD0iMTMyNTMwMTgxNTMzNjQxODI5IiBoPSJURkhCQkdZZVkzQU9rSGNlWUZUSzFDK1JPUTQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb790e42-d63f-4443-58f6-08d8a5969d0d
x-ms-traffictypediagnostic: SN6PR07MB4768:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR07MB476865B45D2B28D2667D3EB8D8C00@SN6PR07MB4768.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrBlrsORvIf3SHmgfg2tBt3vH0e6L5iCfYyf9bp6GqKkJZOsZzM/2WE+gxs23xdeapBATWbSUPFPy72dObK/Hm6oKSGu5eYTjNewYAlLf8rpVIlWRIPyGRIaA+XMJbM3W9fqMxcG+6OSJKlsXskn1YzgKboi6bRFcXS5NY8hVzy37+fMOBZJHucaeIlWSxWHSU0ZaT2lKyp/TttTYNDdVBwN1nTR62lkvV8cnyseoqm4o6d7r+RI1YyVU1+Hnn011Y4AAo6b6/38U+Bt9Kl9NYApGYb8+HiFkmVJCGXkPCMPvQz/OdwLgJ9FDLFc93bUM2DITdD3CVTrK5fyHDJ7vk5exv88Cg02idaLj959ZkbhCF2W6c/LiwCjExwzyR9kZbk5b600EKIVO+uhQWtFtog6PeUNZdWyqkelgwogBsSFXxVz2iA7cMxSD8OGwTyy+uuGeOchTatqgQqj33B5wOcrHfzN9P43hgzxWJCskpoGATvpYUp2JtdUXZBYVkRLmfa4OPhF0Qtl9Nj/OELyLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(36092001)(53546011)(966005)(55016002)(66946007)(52536014)(2906002)(6506007)(8936002)(26005)(107886003)(5660300002)(71200400001)(7696005)(83380400001)(66476007)(66446008)(66556008)(76116006)(9686003)(54906003)(110136005)(186003)(4326008)(86362001)(478600001)(316002)(8676002)(33656002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bA0vpobzbSijrWGD3AUsILBZ1S3ylVbWN6xjSXZcxmh329WeKx1NHxCWMmMG?=
 =?us-ascii?Q?FCo4F4LnnYTsv+EW69kgV+JmmUV1SpPMMiRHgaBbuf9AOqoRTMDnLGpoAMrM?=
 =?us-ascii?Q?bExcKG9lOVAXA+vR/p3xPoXeXOXko410mJheGu6UNDefdCb1z7qsQ3kqPbFY?=
 =?us-ascii?Q?+GXsIZSM7YtGt+00Ei0jio3V1Ou4XaSUHHBLxfPGrz9ZHxrZtRaqHk+eEXYm?=
 =?us-ascii?Q?WRS/+KsDc3oXC7B3iak50wgpiRizUFKIN6o63vSvLY0xHF+V9m3Z749A9RsZ?=
 =?us-ascii?Q?0Cn8YVT0YbaU/1qf6DlWExbyAq5ppiHi4UQ/OdJPW0fKN93kWk0CobGfhv44?=
 =?us-ascii?Q?B5g5ZqE29a2K2xBPvYYXOldxmJbEcGljvHqkjSGmunz/rPIgrPvrFE1yZeAY?=
 =?us-ascii?Q?TC8BH/Epx1hb4ctB2rA1siZUPMKyYrdl4g/Ek2MKqde46DvsL3O/z0lSlyNh?=
 =?us-ascii?Q?l44dcqj7n06bDOga9tYgvQcnocE+AdeRahl4bviAb7M9VCe/+6jjKUmEzSyj?=
 =?us-ascii?Q?qLnBGkOZwuMk3l6RzPjg23QOrLDVe/R9KSOGsaDaTyFo0aapet7zfgZSOLvy?=
 =?us-ascii?Q?4PTgj8Y4BwTDCmwCT/3NtAEv5EEWxliuWevHL4CCZR6ggAyTqElNCw9hG5T8?=
 =?us-ascii?Q?p8RaYzvY7Xnw05tJJTpb4TFHTX5vmgVi3aZuGaxXUvVWzJQI1VT1+GaRLcTr?=
 =?us-ascii?Q?O+8BcVJTV+lzEXpgPrNP3YOvulVca95UlN35ncY0gY1n4ErHy0stNI9xw0rW?=
 =?us-ascii?Q?kwnoPyAcsv0yryaajWTa3cZgVAY9l3TepaoOplHek4PQFfAP5qgOtUkra4z2?=
 =?us-ascii?Q?alvRw1c5l7WXmPwGuoKadM2ZmTZ0yu+/sW7LZROj8o8Lr4QiOeAvF1lYiRiD?=
 =?us-ascii?Q?FuKyFF+AMLMMRIcfgDfcvt3PyBFkGPXVQ7mSbCR95WiicN6vL7W0rSc1qm/i?=
 =?us-ascii?Q?qWOsSfAMvgb1/Lp/hgQWUoYHt3+kGw+xQumPq2DiLwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb790e42-d63f-4443-58f6-08d8a5969d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 09:55:56.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elbkEgXdeCyOjKh2hIZuMEduJ6SvpZ0zB9TnJvAYdAMAJoi5OOjNhXJvcZNBf2/IE8wpqeqZVem4PPJeXZVfOIdgyk3RXCbn/V8TJR4w3+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4768
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_02:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012210072
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, December 16, 2020 5:00 AM
> To: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tom Joseph <tjoseph@cadence.com>; Rob Herring <robh@kernel.org>;
> Bjorn Helgaas <bhelgaas@google.com>; Athani Nadeem Ladkhan
> <nadeem@cadence.com>; linux-omap@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Milind Parab <mparab@cadence.com>; Swapnil
> Kashinath Jakhade <sjakhade@cadence.com>; Parshuram Raju Thombare
> <pthombar@cadence.com>
> Subject: Re: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
> training defect.
>=20
> EXTERNAL MAIL
>=20
>=20
> On Tue, Dec 15, 2020 at 12:30:09PM +0530, Kishon Vijay Abraham I wrote:
> > From: Nadeem Athani <nadeem@cadence.com>
> >
> > Cadence controller will not initiate autonomous speed change if
> > strapped as Gen2. The Retrain Link bit is set as quirk to enable this s=
peed
> change.
> >
> > Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> > [kishon@ti.com: Enable the workaround for TI's J721E SoC]
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> > Hi Lorenzo,
> > The previous version of the patch can be found at [1].
> > I slightly re-worked the patch from Nadeem
> > *) Removed additional Link Up Check
> > *) Removed quirk from pcie-cadence-plat.c
> > *) Also removed additional compatible
> >    "cdns,cdns-pcie-host-quirk-retrain" added in that series
> > *) Enabled the quirk for J721E
> > [1] ->
> > https://urldefense.com/v3/__http://lore.kernel.org/r/20201211144236.38
> > 25-1-
> nadeem@cadence.com__;!!EHscmS1ygiU1lA!SAT97OdWrbRceVlkVfH048koT
> X-
> > ZjfJL85CdVQ1P6TCEOJ2TnJk06mGnd8fz1g$
> >
> >  drivers/pci/controller/cadence/pci-j721e.c    |  3 +
> >  .../controller/cadence/pcie-cadence-host.c    | 67 ++++++++++++++-----
> >  drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
> >  3 files changed, 62 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c
> > b/drivers/pci/controller/cadence/pci-j721e.c
> > index dac1ac8a7615..baf729850cb1 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
> >
> >  struct j721e_pcie_data {
> >  	enum j721e_pcie_mode	mode;
> > +	bool			quirk_retrain_flag;
> >  };
> >
> >  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32
> > offset) @@ -280,6 +281,7 @@ static struct pci_ops
> > cdns_ti_pcie_host_ops =3D {
> >
> >  static const struct j721e_pcie_data j721e_pcie_rc_data =3D {
> >  	.mode =3D PCI_MODE_RC,
> > +	.quirk_retrain_flag =3D true,
> >  };
> >
> >  static const struct j721e_pcie_data j721e_pcie_ep_data =3D { @@ -388,6
> > +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
> >
> >  		bridge->ops =3D &cdns_ti_pcie_host_ops;
> >  		rc =3D pci_host_bridge_priv(bridge);
> > +		rc->quirk_retrain_flag =3D data->quirk_retrain_flag;
> >
> >  		cdns_pcie =3D &rc->pcie;
> >  		cdns_pcie->dev =3D dev;
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > index 811c1cb2e8de..773c0d1137ed 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -77,6 +77,50 @@ static struct pci_ops cdns_pcie_host_ops =3D {
> >  	.write		=3D pci_generic_config_write,
> >  };
> >
> > +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie) {
> > +	struct device *dev =3D pcie->dev;
> > +	int retries;
> > +
> > +	/* Check if the link is up or not */
> > +	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > +		if (cdns_pcie_link_up(pcie)) {
>=20
> - cdns_pcie_link_up() always returns "true" except for j721e_pcie_ops.
>   Is it really true that we can assume the link is up otherwise?
In cdns_pcie_link_up, the soc specific code should return the link status.
In this case, only TI j721e soc uses the driver.

>=20
> - Where did the LINK_WAIT_* values come from?  Are they derived from
>   something in the PCIe spec?
No, not derived from PCIe spec, but based on experimentation, working value=
.
This value is worst case timeout. Almost all the host controllers uses this=
 value.

>=20
> - Is the LINK_WAIT timeout related to LINK_RETRAIN_TIMEOUT?
Yes

>=20
> - If the PCI core does a link retrain, e.g., in pcie_retrain_link(),
>   does that work correctly on this device?
Yes
>=20
> [I see now that this patch only *moves* this code without changing it.
> But I'm still curious.]
>=20
> > +			dev_info(dev, "Link up\n");
> > +			return 0;
> > +		}
> > +		usleep_range(LINK_WAIT_USLEEP_MIN,
> LINK_WAIT_USLEEP_MAX);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static void cdns_pcie_retrain(struct cdns_pcie *pcie) {
> > +	u32 lnk_cap_sls, pcie_cap_off =3D CDNS_PCIE_RP_CAP_OFFSET;
> > +	u16 lnk_stat, lnk_ctl;
> > +
> > +	/*
> > +	 * Set retrain bit if current speed is 2.5 GB/s,
> > +	 * but the PCIe root port support is > 2.5 GB/s.
> > +	 */
> > +
> > +	lnk_cap_sls =3D cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE +
> pcie_cap_off +
> > +					     PCI_EXP_LNKCAP));
> > +	if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <=3D
> PCI_EXP_LNKCAP_SLS_2_5GB)
> > +		return;
> > +
> > +	lnk_stat =3D cdns_pcie_rp_readw(pcie, pcie_cap_off +
> PCI_EXP_LNKSTA);
> > +	if ((lnk_stat & PCI_EXP_LNKSTA_CLS) =3D=3D PCI_EXP_LNKSTA_CLS_2_5GB)
> {
> > +		lnk_ctl =3D cdns_pcie_rp_readw(pcie,
> > +					     pcie_cap_off + PCI_EXP_LNKCTL);
> > +		lnk_ctl |=3D PCI_EXP_LNKCTL_RL;
> > +		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
> > +				    lnk_ctl);
> > +
> > +		if (cdns_pcie_host_wait_for_link(pcie))
> > +			return;
> > +	}
> > +}
> >
> >  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)  {
> > @@ -398,23 +442,6 @@ static int cdns_pcie_host_init(struct device *dev,
> >  	return cdns_pcie_host_init_address_translation(rc);
> >  }
> >
> > -static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie) -{
> > -	struct device *dev =3D pcie->dev;
> > -	int retries;
> > -
> > -	/* Check if the link is up or not */
> > -	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > -		if (cdns_pcie_link_up(pcie)) {
> > -			dev_info(dev, "Link up\n");
> > -			return 0;
> > -		}
> > -		usleep_range(LINK_WAIT_USLEEP_MIN,
> LINK_WAIT_USLEEP_MAX);
> > -	}
> > -
> > -	return -ETIMEDOUT;
> > -}
>=20
> This piece looks like a pure move of cdns_pcie_host_wait_for_link() with =
no
> other changes.  It would be nicer to split that to a separate patch so it=
 doesn't
> obscure what's really happening in this patch.
Yes, the api is moved to remove compilation error.
Will split the patch into two as suggested.

>=20
> >  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)  {
> >  	struct device *dev =3D rc->pcie.dev;
> > @@ -458,8 +485,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >  	}
> >
> >  	ret =3D cdns_pcie_host_wait_for_link(pcie);
> > -	if (ret)
> > +	if (ret) {
> >  		dev_dbg(dev, "PCIe link never came up\n");
> > +	} else {
> > +		if (rc->quirk_retrain_flag)
> > +			cdns_pcie_retrain(pcie);
> > +	}
> >
> >  	for (bar =3D RP_BAR0; bar <=3D RP_NO_BAR; bar++)
> >  		rc->avail_ib_bar[bar] =3D true;
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
> > b/drivers/pci/controller/cadence/pcie-cadence.h
> > index 30eba6cafe2c..0f29128a5d0a 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -119,7 +119,7 @@
> >   * Root Port Registers (PCI configuration space for the root port func=
tion)
> >   */
> >  #define CDNS_PCIE_RP_BASE	0x00200000
> > -
> > +#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
> >
> >  /*
> >   * Address Translation Registers
> > @@ -291,6 +291,7 @@ struct cdns_pcie {
> >   * @device_id: PCI device ID
> >   * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free
> or
> >   *                available
> > + * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
> >   */
> >  struct cdns_pcie_rc {
> >  	struct cdns_pcie	pcie;
> > @@ -299,6 +300,7 @@ struct cdns_pcie_rc {
> >  	u32			vendor_id;
> >  	u32			device_id;
> >  	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
> > +	bool			quirk_retrain_flag;
> >  };
> >
> >  /**
> > @@ -414,6 +416,13 @@ static inline void cdns_pcie_rp_writew(struct
> cdns_pcie *pcie,
> >  	cdns_pcie_write_sz(addr, 0x2, value);  }
> >
> > +static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
> > +{
> > +	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> > +
> > +	return cdns_pcie_read_sz(addr, 0x2); }
> > +
> >  /* Endpoint Function register access */  static inline void
> > cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
> >  					  u32 reg, u8 value)
> > --
> > 2.17.1
> >
