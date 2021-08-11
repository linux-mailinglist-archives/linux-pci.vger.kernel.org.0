Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E273E891D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhHKELS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 00:11:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43438 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229481AbhHKELS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 00:11:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B4AZGc021121;
        Tue, 10 Aug 2021 21:10:53 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0016f401.pphosted.com with ESMTP id 3ac6qtg309-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 21:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aayg0RwQRASPV1v4wxgoxkD4XVWtrTvWsSRJ1WmPFDi3A8Qab2tIq2xBYsbzWAW442MH1Ov3LDEr4KN7WMpK3w20KyI/OuiBpxbgOzkXUjBAec9mgbSIJJUOD0s19Qu51gd5y7cx4ZiAaJK6QZmX7SZAtTe7YbpuZfUk5wS/Kzg7g2FbD1vLEaoz787AU4GAnL89g6DPwSKxmH32vVHAlsfb+18G+ZxlZZYaEFd45kYK1luriqqOq/BlNIlHeg/5xLK3eQLQElxulaEq9OY2M1ezYZ0b/n7Z41VuawLVarp6gSwbgEq74Rglm2tMhVOpPc/4XgkBUgXZMS9rt/K4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/35UmcX1B6CPxtzfoGh2Z4sar2bXlmQvXGVMKs9ntIE=;
 b=Y3kMwDiCI3ksuCPcsyBVMt8PevH76MEMf0/vteBF14kax5UIz42lOG36scwnbsARHRF3VWctvgvMUJwzhog9b1IVQKrrnu4G9SAyRvSZE/3Plssu2i2adab1w32loSGMx5+HAkkSjOCnVvBEJa/hLWNkNdTYtWM1/o6yqsqZZ4BPdf5hucDoCy4MSSHIjpyVS3tvB0CSFTF/sj1Kx702xxgvmw87ElfZYfgd72n4q0Cz1xEhJSDPhVpIh9ZawTsLTN6BJqcaMwnl3obp4SyzxAuaPlWW23Zub77noaP+wGZBqAwQ/9ufnQTJQ3hXVSgcLmlJ64qRAOLHwz0vLuNjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/35UmcX1B6CPxtzfoGh2Z4sar2bXlmQvXGVMKs9ntIE=;
 b=nh1toFupfnTHlmjy3BHunsLDYOXwYrjZSVjtacWPX8iMBWB99mFS+hSyKcrUiAvJCs2QlC79UU8HUaVH3cx2GEUAtuziMuiohbWbqquxmrbVIeb+uSWDKgcKh8LesDpdEAfngbORZpD07d35EQWKHvE+UJk57eqp0qMFVQSZJAc=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by BYAPR18MB2534.namprd18.prod.outlook.com (2603:10b6:a03:12e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Wed, 11 Aug
 2021 04:10:51 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::c5bd:2699:2b32:f948]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::c5bd:2699:2b32:f948%5]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 04:10:51 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        George Cherian <gcherian@marvell.com>
Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium multi-function devices
Thread-Topic: [PATCH] PCI: Add ACS quirk for Cavium multi-function devices
Thread-Index: AdeOZkuPjfiksRxTQZi7GMJ7KZJajw==
Date:   Wed, 11 Aug 2021 04:10:51 +0000
Message-ID: <BYAPR18MB267988A59552755801CBCBABC5F89@BYAPR18MB2679.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c929c36c-9236-4a12-bf7b-08d95c7e01a5
x-ms-traffictypediagnostic: BYAPR18MB2534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2534952CA4D856F28B4CD7E5C5F89@BYAPR18MB2534.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +MfefPjqMM9Sn0ymJF/OvQdVqV0apxoOun73VkoQ5aEvLJrUjiTa8LTYuiop96e2r+Jj2hT7YIwxHRK4CHYsMi1zh4sPjJ35QgIwe8PepNvh0ksZDZOeBGgrpGAAfVwU0LJd/NV9pcc+A3RyAAy+Q8KfCpdDoIEj1ATL55Wx7UZLb1Gr7wVx8oJDZ1BowfHZ4H5W80RjgNFe6EyCWCPZUS/G+XeToMLJhkgfyzTA5GV66G2WpTHpLYOikZ2pN/V9kZtSYpNIkwu0+mjmV8SN0W8Fo3aVCWQWPcVHvznjo+w36ajpkKvsgdsTJX7XDdl/owWS+kuDlQFdpXnMbjJog8MLEQBx6vIRkS2Q011VdYWF9I97XjDP0XtyBWQjXkmM441Sa90oo+fdCtr5lqwCGfggjoC+6X9nIUdfANJkXllOpaanf+RRWof6tgqvGz88v6PB+kDM/px/tI4PlAhEXcrLl1Bi3oImHzZ4tUKqu6wm2xc6+xJa3tBPo0JbaDKqNcpmFJ7piroR760kkwRnuS3q/gIxT62EJcHKcrNvDCSMRVB363JCf30azYtYUbreZ+6hXkdJ/v66mh+9VTlnaE5MXCROfJM1wuQ3VA/KomS7pwz1M6J98ep6QRzguHbgQvGnfwUpQNrAWEVFMhdDislXt1WxADv1V0+Pp53JDw+nmKFRD0pNaMLzav8MB2AW0noSDTpT4hEFP3FiaEgoVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(83380400001)(26005)(7696005)(8676002)(5660300002)(33656002)(6506007)(52536014)(38100700002)(6916009)(38070700005)(55236004)(186003)(4326008)(8936002)(53546011)(55016002)(478600001)(66476007)(66556008)(66946007)(9686003)(64756008)(86362001)(54906003)(107886003)(122000001)(2906002)(76116006)(66446008)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L0RZ+t0ChOSfjjqha77fQwOLxXtfEX/46nin2ke3Jjhx35YrzEb+O+j28qZ/?=
 =?us-ascii?Q?rAHA68zlyrP5QtW9IaM5qt/73ks5dfCWAxt6+lX7rBbaJ/OrWhY+alEA6F3I?=
 =?us-ascii?Q?avkD8iSxhK87IhvVp5xdC6OpQHZN/q/6MxGkoJSovMS1aNm1DL0TwAzL30Gf?=
 =?us-ascii?Q?X7PgfmqTR6wUNPyp5ENlym2dHFrAn7YacKTR9DfHPc0A4PqMVtcZ6QlHVFvp?=
 =?us-ascii?Q?CI30H+nGH4ZFoh/2dnzEYkNtNp6BwJTlxPNWH+MdSdA/eicKPItJk70yWYg2?=
 =?us-ascii?Q?Ru7ArZeLE8LYegXQfaAmp00ZUw7hlYWduKgxlOpu6XeLoDpZIt11IiusQhOy?=
 =?us-ascii?Q?FnlUhoXUKv4cC2gGElWaPNsmm1/Jeg6jmZAhTttzm52uB3zd0xa25PTEy44c?=
 =?us-ascii?Q?2RsSqGgf51YGGhfMWlSZ3VhvVv6G/FSHBf2IpMbj3xs8x3N1dkWlnPxw1foM?=
 =?us-ascii?Q?tgRP0lRGGZiOI7F22NZAxeWyloava4Xf/BivoPXrxTMYA4/8PYr/UuX8NYjT?=
 =?us-ascii?Q?nQggFQljoYMye24cMKojSmPM6MbH3OSzYa0k4mBttl2v9LsdaIZcN+wXpM1U?=
 =?us-ascii?Q?MOTrdRyDOirQVT4YY5KaZnLIK3OqoMJnk8sK711P5cZfKNMyrelJ3kvrXYIK?=
 =?us-ascii?Q?h45ijNCDyd354zoffgsP9rS3VABxKJ/2ksp2OZXfbHiay03/3u61sHPQznyN?=
 =?us-ascii?Q?iw2XQLBjuFpXdju2YB/3lcocinysj50oeg8+NFQb79s7IGjzV+vE/vGU88oo?=
 =?us-ascii?Q?mIzPS+zjZPNPQ4l0T+2qb4+KsK+zGWDEXFmzpVMG9WcYpTfeqvCPs1ifKlBw?=
 =?us-ascii?Q?wiIsZuGcFTgBB84DidRj/jpEn5FnRizBc/CaF1bbstj09HXMewgPz7hou5pQ?=
 =?us-ascii?Q?0Y1E+JV8dR2vmPe64tuWXJGVh76Ovun7CnwXnOH2Jo1oRtS0kByaasTu9+xq?=
 =?us-ascii?Q?Bv08swe8RV+9MR7lrxW1nNcWx9UM/LGH39fjzxeeeKnpJeowFka++1K1zdNu?=
 =?us-ascii?Q?BTv18AmAagX+0o+R+6Ke5+nB6YP9w5kTUA5Wx8RW07JMAbXk1bFNWiaOuDHG?=
 =?us-ascii?Q?WHL9euHyeoswwxKdQIIEcqXeVKcRfhFA8ODMqUvXV5diHC2OjELiwYb9w3ej?=
 =?us-ascii?Q?o9/O4BlRaFumJt2i3yziV9E2MTO6OG42SpOgxPMBVzU00fZtnBW9yPWCp616?=
 =?us-ascii?Q?8u3pO2MZHR9tsWtrXqJAtdEcHKKbNZ2ImtUUKasRB2gRbsX8659gZhae/RyQ?=
 =?us-ascii?Q?yFN91+ooYRm+5XPXpQ/fDaO6NUnzEIGus0OEuixsbH4+jW5Rbn4Hu//T/GLZ?=
 =?us-ascii?Q?L0c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c929c36c-9236-4a12-bf7b-08d95c7e01a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 04:10:51.1311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yn+jv7KMwpvLqZ2lXFUvUYnoMb0vfByysMk2VPyWXfewNz61jaqjiznd30Jw0xKTktuouMB7stiyH4F0FlLTFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2534
X-Proofpoint-ORIG-GUID: ePjIzEqV51aO6v_M3Nqdv_s4k_pqPvwR
X-Proofpoint-GUID: ePjIzEqV51aO6v_M3Nqdv_s4k_pqPvwR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_01:2021-08-10,2021-08-11 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, August 10, 2021 8:18 PM
> To: George Cherian <gcherian@marvell.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> bhelgaas@google.com
> Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium multi-function
> devices
>=20
> On Tue, Aug 10, 2021 at 05:54:25PM +0530, George Cherian wrote:
> > Some Cavium endpoints are implemented as multi-function devices
> > without ACS capability, but they actually don't support peer-to-peer
> > transactions.
> >
> > Add ACS quirks to declare DMA isolation.
> >
> > Apply te quirk for following devices
> > 1. BGX device found on Octeon-TX (8xxx) 2. CGX device found on
> > Octeon-TX2 (9xxx) 3. RPM device found on Octeon-TX3 (10xxx)
> >
> > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > ---
> >  drivers/pci/quirks.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 6d74386eadc2..076932018494 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4840,6 +4840,10 @@ static const struct pci_dev_acs_enabled {
> >  	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R
> */
> >  	/* Cavium ThunderX */
> >  	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
> > +	/* Cavium multi-function devices */
> > +	{ PCI_VENDOR_ID_CAVIUM, 0xA026, pci_quirk_mf_endpoint_acs },
> > +	{ PCI_VENDOR_ID_CAVIUM, 0xA059, pci_quirk_mf_endpoint_acs },
> > +	{ PCI_VENDOR_ID_CAVIUM, 0xA060, pci_quirk_mf_endpoint_acs },
>=20
> Is there a plan to add ACS capabilities to future devices, or is Cavium j=
ust
> resigned to forever adding and backporting quirks?

Yes, the plan is to get these fixed in future silicons. So that we won't be=
=20
needing any quirks.

>=20
> >  	/* APM X-Gene */
> >  	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
> >  	/* Ampere Computing */
> > --
> > 2.25.1
> >

Regards,
-George
