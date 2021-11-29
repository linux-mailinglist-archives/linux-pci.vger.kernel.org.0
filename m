Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA12460CF6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 04:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbhK2DKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 22:10:53 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:57834 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237582AbhK2DIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 22:08:52 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AT1C7E8020690;
        Mon, 29 Nov 2021 03:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=KpK8SOtjuXuDb5OIe5l6U4t93/jzHFzM6TIvOFZj/cU=;
 b=0DK+x04mYN1X4eE5x1XTe8Gi9rRuXgX1yktJCuuierQo7FBJhAEsga14xDHh3yxB5u84
 w3q+Y/wLoNq/l01LzxY6O1Vy+tg5uJ6OicbreyThVktU+oFKpicakQUGa1CafQ9P/8Kt
 Gm84hQWxlUlZ/4NNZ8YbsY1zGRFU57r8IHg9InKaftWaxMvjfu6SQYdTdYcZZmilMWdY
 FnHXeEgFH8ac5+uu2tM5uT2i1/jrlLkDAxDpTzx6HYSMPSc+q/umFNuZGl5vCTIhUiOv
 0kFegNCD5jnkn/ARYeY6WkRoWjkMxBIpX15vxYnRvSiY4OfD3QwdwdLRQ2BQKCvmi+8y mg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3ckdsr0ptt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 03:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjc5jAcpTNrEJBgpi4jHNkvfhailTSWyMvezTPhgFmVwcV5+mj7RLowtEZB9YClHZtpNTck6d2bpIEPi5/Q7R4iSaSaOLYi16p4WVNhg1tI1LgX62p+KELcwLkraFP5FBkaxVmlU1fu1aOpKvKEjYDKnxTlGv/C1oj4PGOCrn9e+UZvtyTksmdSQVsjqDLar8RT4f4mYfFzZNDAoDNyBKo7wbODT3+QGtaC/q2YOCtdAS0jpRZawIF1ySbP1hpb0CqCx8KsrGVrUCvhI6TV7iZbdnShYuXyzErlpNy/shZyfGFtd+gB+7dntjYwSWucbpE1eN2uc6DSdUAA7qTgekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6I4nlcU53iLkiSEYW4wrJKCOTZbJO6wuuxkHQcMoEM=;
 b=AFKojl7pAbodI6c1C8oTCfQ22OjSLYYUaKnv9krk3IAiFbWGF5Ui2yGgf/DggyfvzWDRiYSa19vCmW9TLNwLotBWFbq/JFV15/AaEUje2getx2lwwnWQat5IFJw5REXcyhr891RSjxxSFje2qboi+cJCGj7A8jte8zrEoLw7kwn1zJQB3er6qcyjj+PcA8B8I8Uma5aInrtSuceEH/OWv6tJiCL6UQ2zlmX3vXZd4lv3TcuoF2N/DlxZ20UZc265wa0ibPZ8c+yjM9xLTl8ZzauaPHagfi6UP8hkjz2uKosK2MHuhreDB7TvT5RkdW3aAsUdZRhSiC1aJAW8WbPb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6I4nlcU53iLkiSEYW4wrJKCOTZbJO6wuuxkHQcMoEM=;
 b=bS3TLnYXy69jtMY0dwnq8Rj7ED7CJBaNtIm1HH5NULuiAP5gPn8CJKqaBQRwOrxDNEdRTWRaFDmrNPKuTaBH2ylxOCuPFerBgVsFN5ueqKE61TUK0RAkaFsY1Q96wvqp1skF2XC5gWl/jlIqEHG1Eb3Zy/RM2vLZHvpU5TCxTuA=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3574.namprd19.prod.outlook.com (2603:10b6:610:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 03:04:56 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 03:04:56 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Topic: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8AAB+KwAAJu5nUAAG4h1gACqLnSwAASk8gAANw5dEAUOJyIg
Date:   Mon, 29 Nov 2021 03:04:56 +0000
Message-ID: <CH2PR19MB40245BF88CF2F7210DCB1AA4A0669@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024F88716768EC49BCA08CCA0879@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211029194253.GA345237@bhelgaas>
 <CH2PR19MB402445CF3AEF3529E9041211A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
 <CH2PR19MB4024B5D103F249F574839713A08B9@CH2PR19MB4024.namprd19.prod.outlook.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6342afd3-ae3b-489e-4653-08d9b2e505d1
x-ms-traffictypediagnostic: CH2PR19MB3574:
x-microsoft-antispam-prvs: <CH2PR19MB357493B572DB607F0EA558E7A0669@CH2PR19MB3574.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qa9uDqjYRFiDBxNtqv6dWgteQ8jvWSNiv+l8cplrfuzqFJrjV6Jt/4zgl72XEmQ3mcZcccsraIJxNbZOpvVDk4urfHrc8vob6xnfAqbJAEfbknBlZ2NGHoc6SWiBQVCXS6tGQp+GceuCSBkxbcWR6E/7rSncLtUKYOMlGLxAWonFcArpZGh7cAeub9VIP3w8l9UjXtzO9XejYSI5hHJOwWCnYavNCgEWae8CPf1dmrNwAVOaLv0SJUJok9VQl0i/klhmBmSrd17Az1AYWxryhkdHHP+6ov6QdPTyLaFKO8CXtLrJ2sHLOzjpV/kqM1EeMqq+BYyNwS8IHWdXOZb0tYZgzFTVH+yKZOmzuXNUIpCHyw6wE9rNlIvBbpFZUwmUKkUnIJcLgBaQwKSCEJ9OmKgDqFLb+m2xyuk4ZFqJxyPc1o8TdhT2WDEFozg7+agJlIuzVso5+eTksfGDzsvMtGr7WAP0hi6korUZXp0Hzqx1q1ViQFhsayCcjZDxlemLJL3ayAS65ktK2m7396EuFiPC3mdSJTGkYxiwlENfFQLlRxscVV7LxegCMWwGl+guE/qR4aLZVd5/y8bo2DkrQd1IqXNMOpqgz5vF1IqfWFaLQgu+S6lG3Xnn+d+69Ifd8PxLCG31CmLXkiC97xomkDbOON+u/OsUe67S9GXRDlU03s7IRzqPVKP5j9Q1tTyM0jXHh6Ts+nZsF6E/VhvPVdSGcWnP30crz/OTxMiefGbI6IO8eOc3C1Ccu5tztY9YDVpr0/YUx9kkCz+/8qFgMg452erUlmwk0Acx4xPdEvI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(4326008)(52536014)(7416002)(6506007)(66446008)(83380400001)(966005)(55016003)(54906003)(66556008)(86362001)(9686003)(8936002)(5660300002)(508600001)(84970400001)(66476007)(316002)(122000001)(8676002)(53546011)(26005)(30864003)(33656002)(88996005)(2906002)(7696005)(38100700002)(71200400001)(64756008)(66946007)(186003)(21314003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OfXOhXCwKoPNtL6+KMJz6b8YrMimQDZ1eqmG5giy3qWvL/d5YF5pSnjElJBe?=
 =?us-ascii?Q?03jb1jLpcaNp0zk+Wwih7xz4KSbNTI8gi8aQBhsq6Z5KvacWl/722Z323mjd?=
 =?us-ascii?Q?5Vtbn1qTdIgZg0Jdp68iTaPYRtdqeTJ7j25RdpjFrZAFNaT7Jf95/zeQ4Qxs?=
 =?us-ascii?Q?94iQP7w8uVwTEDoS0j1Lk53PpBPZfd0xTT4tObrsMo0BtwLti+Ls6BtSzThY?=
 =?us-ascii?Q?/oiHxV9xkLpUPyQ+qFsySRtt3n+7v+tPXDNMZ/IkAkLYtAJLn09vsc/p427N?=
 =?us-ascii?Q?o2luh71cIrkuQE/XZnc1kmJSo8FUVhtZMp8OYnBm3IuvfxSICKL/I4Ck3s0E?=
 =?us-ascii?Q?i2SFIw4QECIpQKGSM/v8XXx2Tr6BBj4H1NM9VJAnzrZG69OfaA1Id4FcvvUw?=
 =?us-ascii?Q?yrUKGCGDspbMIjBqU1vJ3tkJe2Ejis/TAMc4zNuZAZ7TPZEO/cLSqSGj6TMz?=
 =?us-ascii?Q?/QlwtfdIsMiagZ9eUmAYiohSWUycb08+JslbLpx80n9r1WXrjJJGFnMRM+hH?=
 =?us-ascii?Q?oBkSv/zP9zkJK/sAcGj8cuaSRbnQyIna9FSisrb4sloNBEj8IJhS6zzEY+ox?=
 =?us-ascii?Q?MOtJ8uYj/FNFDajjq++cHWNiJd0qESn0xnn4zuasppO8JZk162Y9u7Auoncw?=
 =?us-ascii?Q?0vTCXTymeaPcSoeJhvZOHkhbZsPyIdN0LB4Xcohw09dTf402ljR93/d1V/8S?=
 =?us-ascii?Q?qJXZ3hXj/GB+pC5oE3k+zX3bJhUFNID6T3ZKQ4n31lJ4LPiA7dLXVBuvtOV6?=
 =?us-ascii?Q?2eXj0G+izYwi3FrrfyGILPWTA9nSWZ4fACbtVIOF3kedyzBZVjnccGX9CM3F?=
 =?us-ascii?Q?fPdvV9EJMtyVpoqg6KGhtbBaVQs/hAMI7F6DFOVA13Uw5/1PIpyHDmQMw3sR?=
 =?us-ascii?Q?TI8qj2Jdh5jJ1gDD9cJN7+oKTGEShu/lmnYL0fJnDlglyjtOBsnqryMHJs7Z?=
 =?us-ascii?Q?VW55ccpAEPw7v8TLMphQRdwdQZtNfg2Y4rmkpaVBEQJwRbUCQQsE8isx4NF1?=
 =?us-ascii?Q?75qyr8oHxzoL5bo5Yh12DfICa3Tt37Qm9ytzo/UfNRHmZoCaqTudCIM1kzjc?=
 =?us-ascii?Q?qG6l5fuFbWysKlG2Ck1WWdRQWTefEJGK6vdxKjgIiuHsP8C44ax6m1LN4mak?=
 =?us-ascii?Q?Gairb/MYROkzhl/e2j3NATodDhVvB32U/B8trXTrZAb3fZSEETvqqlR7ERmp?=
 =?us-ascii?Q?90H6lHA5xOsJpA20GmDfc6akuQWee1o5f7DIkg/mZTxbfWVm64b0s1v0hMeL?=
 =?us-ascii?Q?nfnHh1pXeIhF0ehq4OSt7CJUM/XBVsP0rG+UOqR/6Ryn0obf51jEJ1iU0frb?=
 =?us-ascii?Q?3LWeaF87tCJ869wITSvnXGrZCC16kvQMv2Cuq8kzCPiWYAq/MKR2G6l0EXR3?=
 =?us-ascii?Q?KnHnJfZZi9/ui3hAWdt1D/uHZM3q1bd5VzBzNTf7nwMNL0HL5ECXxQiiyy8T?=
 =?us-ascii?Q?ZhZCKAQXNO4YL8+9btUjt6ie/L4DbbUHS0Ax+M1XWCmAaj3kCiJabgtbhBTe?=
 =?us-ascii?Q?tP7Tr3PnPyhSE2VEgH4AHd3/GfDDQ5tUUpWJkYwmhzIqP6WK4QlxjNKs/5c4?=
 =?us-ascii?Q?bEZq0O6f4c4OptkN9bTnLRkQTgngJ0oYIkHvoRRs8O+lfCziUW/KuYWly1sT?=
 =?us-ascii?Q?sX1by2ez4WbnIm5tvHrwcqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6342afd3-ae3b-489e-4653-08d9b2e505d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 03:04:56.2550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywrtzuQeqFaPjs9S3mbfTNYL5P6Sx4jSFkOftpaIxpYk6V5ufbIVpXqDNmb4koBUUf5DKqZ7EsIJ7HeVIeofug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3574
X-Proofpoint-ORIG-GUID: C9Yb9g1Fzlqh4nGy7T3-RrNGoy4Q3koj
X-Proofpoint-GUID: C9Yb9g1Fzlqh4nGy7T3-RrNGoy4Q3koj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-28_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290012
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here is a summary of my solution:

From amba bus view, dram mapped from 0-64G on our soc.

PCIe's non-prefetch mmio need be inside 0-4g, which
may be used as switch bridge's mmio.
if ep do dma, and the phy address is 0-4g, the dma address
will be the same, because cadence's codes currently only
support 1:1 mapping of dma and phy addr.

For example, if ep's upstream switch bridge use phy addr 4-5M
as mmio window and ep use 4-5M as dma addr, then when the tlp
comes to switch bridge, it will find this dma addr is inside its
mmio memory window, then UR(unsupported request) error will be issued.

To resolve this problem, the only way is to let ep cannot use these mmio
windows, IOW, we should do something to prevent slab use these mmio's
physical addresses. So, if there is a reserved memory area below 4G, we can=
 use it as
PCIe's outbound/mmio's dma address.

Regards
Li

> -----Original Message-----
> From: Li Chen
> Sent: Wednesday, November 3, 2021 6:04 PM
> To: 'Bjorn Helgaas'
> Cc: 'Keith Busch'; 'linux-pci@vger.kernel.org'; 'Lorenzo Pieralisi'; 'Rob=
 Herring';
> 'kw@linux.com'; 'Bjorn Helgaas'; 'linux-kernel@vger.kernel.org'; 'Tom Jos=
eph';
> 'Jens Axboe'; 'Christoph Hellwig'; 'Sagi Grimberg'; 'linux-
> nvme@lists.infradead.org'
> Subject: RE: [EXT] Re: nvme may get timeout from dd when using different =
non-
> prefetch mmio outbound/ranges
>=20
>=20
>=20
> > -----Original Message-----
> > From: Li Chen
> > Sent: Tuesday, November 2, 2021 3:12 PM
> > To: Bjorn Helgaas
> > Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herr=
ing;
> > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; =
Jens
> > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> > Subject: RE: [EXT] Re: nvme may get timeout from dd when using different
> non-
> > prefetch mmio outbound/ranges
> >
> >
> >
> > > -----Original Message-----
> > > From: Li Chen
> > > Sent: Tuesday, November 2, 2021 1:18 PM
> > > To: Bjorn Helgaas
> > > Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob He=
rring;
> > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph;
> Jens
> > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.o=
rg
> > > Subject: RE: [EXT] Re: nvme may get timeout from dd when using differ=
ent
> > non-
> > > prefetch mmio outbound/ranges
> > >
> > > Hi, Bjorn
> > >
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > > Sent: Saturday, October 30, 2021 3:43 AM
> > > > To: Li Chen
> > > > Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob =
Herring;
> > > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Jose=
ph;
> > Jens
> > > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead=
.org
> > > > Subject: Re: [EXT] Re: nvme may get timeout from dd when using diff=
erent
> > > non-
> > > > prefetch mmio outbound/ranges
> > > >
> > > > On Fri, Oct 29, 2021 at 10:52:37AM +0000, Li Chen wrote:
> > > > > > -----Original Message-----
> > > > > > From: Keith Busch [mailto:kbusch@kernel.org]
> > > > > > Sent: Tuesday, October 26, 2021 12:16 PM
> > > > > > To: Li Chen
> > > > > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi=
; Rob
> > Herring;
> > > > > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom
> Joseph;
> > > > Jens
> > > > > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> nvme@lists.infradead.org
> > > > > > Subject: Re: [EXT] Re: nvme may get timeout from dd when using
> > different
> > > > non-
> > > > > > prefetch mmio outbound/ranges
> > > > > >
> > > > > > On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > > > > > > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung
> > Electronics
> > > > Co
> > > > > > Ltd NVMe SSD Controller 980". From its datasheet,
> > > > > > https://urldefense.com/v3/__https://s3.ap-northeast-
> > > > > >
> > > >
> > >
> >
> 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> > > > > >
> > > >
> > >
> >
> ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> > > > > > PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I=
'm
> > > not
> > > > sure.
> > > > > > Is there other ways/tools(like nvme-cli) to query?
> > > > > >
> > > > > > The driver will export a sysfs property for it if it is support=
ed:
> > > > > >
> > > > > >   # cat /sys/class/nvme/nvme0/cmb
> > > > > >
> > > > > > If the file doesn't exist, then /dev/nvme0 doesn't have the cap=
ability.
> > > > > >
> > > > > > > > > I don't know how to interpret "ranges".  Can you supply t=
he dmesg
> > > and
> > > > > > > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > > > > > > >
> > > > > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xef=
ffffff
> > > > window]
> > > > > > > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe=
7fffff
> > > > window]
> > > > > > > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > > > > > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff =
...]
> > > > > > > > >
> > > > > > > > > > Question:
> > > > > > > > > > 1.  Why dd can cause nvme timeout? Is there more debug =
ways?
> > > > > > > >
> > > > > > > > That means the nvme controller didn't provide a response to=
 a
> posted
> > > > > > > > command within the driver's latency tolerance.
> > > > > > >
> > > > > > > FYI, with the help of pci bridger's vendor, they find somethi=
ng
> > > > > > > interesting:
> > > > > > "From catc log, I saw some memory read pkts sent from SSD card,
> > > > > > but its memory range is within the memory range of switch down
> > > > > > port. So, switch down port will replay UR pkt. It seems not
> > > > > > normal." and "Why SSD card send out some memory pkts which
> memory
> > > > > > address is within switch down port's memory range. If so, switch
> > > > > > will response UR pkts". I also don't understand how can this
> > > > > > happen?
> > > > > >
> > > > > > I think we can safely assume you're not attempting peer-to-peer,
> > > > > > so that behavior as described shouldn't be happening. It sounds
> > > > > > like the memory windows may be incorrect. The dmesg may help to
> > > > > > show if something appears wrong.
> > > > >
> > > > > Agree that here doesn't involve peer-to-peer DMA. After conforming
> > > > > from switch vendor today, the two ur(unsupported request) is beca=
use
> > > > > nvme is trying to dma read dram with bus address 80d5000 and
> > > > > 80d5100. But the two bus addresses are located in switch's down p=
ort
> > > > > range, so the switch down port report ur.
> > > > >
> > > > > In our soc, dma/bus/pci address and physical/AXI address are 1:1,
> > > > > and DRAM space in physical memory address space is 000000.0000 -
> > > > > 0fffff.ffff 64G, so bus address 80d5000 and 80d5100 to cpu address
> > > > > are also 80d5000 and 80d5100, which both located inside dram spac=
e.
> > > > >
> > > > > Both our bootloader and romcode don't enum and configure pcie
> > > > > devices and switches, so the switch cfg stage should be left to
> > > > > kernel.
> > > > >
> > > > > Come back to the subject of this thread: " nvme may get timeout f=
rom
> > > > > dd when using different non-prefetch mmio outbound/ranges". I fou=
nd:
> > > > >
> > > > > 1. For <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x0400000=
0>;
> > > > > (which will timeout nvme)
> > > > >
> > > > > Switch(bridge of nvme)'s resource window:
> > > > > Memory behind bridge: Memory behind bridge: 08000000-080fffff
> [size=3D1M]
> > > > >
> > > > > 80d5000 and 80d5100 are both inside this range.
> > > >
> > > > The PCI host bridge MMIO window is here:
> > > >
> > > >   pci_bus 0000:00: root bus resource [mem 0x2008000000-0x200bffffff=
] (bus
> > > > address [0x08000000-0x0bffffff])
> > > >   pci 0000:01:00.0: PCI bridge to [bus 02-05]
> > > >   pci 0000:01:00.0:   bridge window [mem 0x2008000000-0x20080fffff]
> > > >   pci 0000:02:06.0: PCI bridge to [bus 05]
> > > >   pci 0000:02:06.0:   bridge window [mem 0x2008000000-0x20080fffff]
> > > >   pci 0000:05:00.0: BAR 0: assigned [mem 0x2008000000-0x2008003fff =
64bit]
> > > >
> > > > So bus address [0x08000000-0x0bffffff] is the area used for PCI BAR=
s.
> > > > If the NVMe device is generating DMA transactions to 0x080d5000, wh=
ich
> > > > is inside that range, those will be interpreted as peer-to-peer
> > > > transactions.  But obviously that's not intended and there's no dev=
ice
> > > > at 0x080d5000 anyway.
> > > >
> > > > My guess is the nvme driver got 0x080d5000 from the DMA API, e.g.,
> > > > dma_map_bvec() or dma_map_sg_attrs(), so maybe there's something
> > wrong
> > > > in how that's set up.  Is there an IOMMU?  There should be arch code
> > > > that knows what RAM is available for DMA buffers, maybe based on the
> > > > DT.  I'm not really familiar with how all that would be arranged, b=
ut
> > > > the complete dmesg log and complete DT might have a clue.  Can you
> > > > post those somewhere?
> > >
> > > After some printk, I found nvme_pci_setup_prps get some dma addresses
> > inside
> > > switch's memory window from sg, but I don't where the sg is from(see
> > > comments in following source codes):
> >
> > I just noticed it should come from mempool_alloc in nvme_map_data:
> > static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request
> *req,
> > 		struct nvme_command *cmnd)
> > {
> > 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> > 	blk_status_t ret =3D BLK_STS_RESOURCE;
> > 	int nr_mapped;
> >
> > 	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
> > 		struct bio_vec bv =3D req_bvec(req);
> >
> > 		if (!is_pci_p2pdma_page(bv.bv_page)) {
> > 			if (bv.bv_offset + bv.bv_len <=3D NVME_CTRL_PAGE_SIZE
> > * 2)
> > 				return nvme_setup_prp_simple(dev, req,
> > 							     &cmnd->rw, &bv);
> >
> > 			if (iod->nvmeq->qid &&
> > 			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
> > 				return nvme_setup_sgl_simple(dev, req,
> > 							     &cmnd->rw, &bv);
> > 		}
> > 	}
> >
> > 	iod->dma_len =3D 0;
> > 	iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
> >
> >
> > 	unsigned int l =3D sg_dma_address(iod->sg), r =3D sg_dma_address(iod->=
sg)
> > + sg_dma_len(iod->sg), tl =3D 0x08000000, tr =3D tl + 0x04000000, ntl =
=3D 0x00400000,
> ntr
> > =3D ntl + 0x08000000;
> >
> > /*
> > # dmesg | grep "region-timeout ? 1" | grep nvme_map_data
> > [   16.002446] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1c21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   16.341240] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1a21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   16.405938] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1821c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   36.126917] lchen nvme_map_data, 895: first_dma 0, end_dma 8f2421c, =
inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   36.703839] lchen nvme_map_data, 895: first_dma 0, end_dma 8f2221c, =
inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   38.510086] lchen nvme_map_data, 895: first_dma 0, end_dma 89c621c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.542394] lchen nvme_map_data, 895: first_dma 0, end_dma 89c421c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.573405] lchen nvme_map_data, 895: first_dma 0, end_dma 87ee21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.604419] lchen nvme_map_data, 895: first_dma 0, end_dma 87ec21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.874395] lchen nvme_map_data, 895: first_dma 0, end_dma 8aa221c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.905323] lchen nvme_map_data, 895: first_dma 0, end_dma 8aa021c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.968675] lchen nvme_map_data, 895: first_dma 0, end_dma 8a0e21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   40.999659] lchen nvme_map_data, 895: first_dma 0, end_dma 8a0821c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.030601] lchen nvme_map_data, 895: first_dma 0, end_dma 8bde21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.061629] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1e21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.092598] lchen nvme_map_data, 895: first_dma 0, end_dma 8eb621c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.123677] lchen nvme_map_data, 895: first_dma 0, end_dma 8eb221c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.160960] lchen nvme_map_data, 895: first_dma 0, end_dma 8cee21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.193609] lchen nvme_map_data, 895: first_dma 0, end_dma 8cec21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.224607] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7e21c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.255592] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7c21c, =
inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > [   41.286594] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7821c,
> inside
> > region-timeout ? 1, is inside region-non-timeout ? 0
> > */
> > 	printk("lchen %s, %d: first_dma %llx, end_dma %llx, inside region-
> > timeout ? %d, is inside region-non-timeout ? %d", __func__, __LINE__, l=
, r, l >=3D
> tl
> > && l <=3D tr || r >=3D tl && r <=3D tr, l >=3D ntl && l <=3D ntr || r >=
=3D ntl && r <=3D ntr);
> >
> >
> >
> > 	//printk("lchen %s %d, addr starts %llx, ends %llx", __func__, __LINE_=
_,
> > sg_dma_address(iod->sg), sg_dma_address(iod->sg) + sg_dma_len(iod->sg));
> >
> >     ................
> > }
> >
> > >
> > > static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
> > > 		struct request *req, struct nvme_rw_command *cmnd)
> > > {
> > > 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> > > 	struct dma_pool *pool;
> > > 	int length =3D blk_rq_payload_bytes(req);
> > > 	struct scatterlist *sg =3D iod->sg;
> > > 	int dma_len =3D sg_dma_len(sg);
> > > 	u64 dma_addr =3D sg_dma_address(sg);
> > >                 ......
> > > 	for (;;) {
> > > 		if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
> > > 			__le64 *old_prp_list =3D prp_list;
> > > 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC,
> > > &prp_dma);
> > > 			printk("lchen %s %d dma pool %llx", __func__, __LINE__,
> > > prp_dma);
> > > 			if (!prp_list)
> > > 				goto free_prps;
> > > 			list[iod->npages++] =3D prp_list;
> > > 			prp_list[0] =3D old_prp_list[i - 1];
> > > 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
> > > 			i =3D 1;
> > > 		}
> > > 		prp_list[i++] =3D cpu_to_le64(dma_addr);
> > > 		dma_len -=3D NVME_CTRL_PAGE_SIZE;
> > > 		dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> > > 		length -=3D NVME_CTRL_PAGE_SIZE;
> > > 		if (length <=3D 0)
> > > 			break;
> > > 		if (dma_len > 0)
> > > 			continue;
> > > 		if (unlikely(dma_len < 0))
> > > 			goto bad_sgl;
> > > 		sg =3D sg_next(sg);
> > > 		dma_addr =3D sg_dma_address(sg);
> > > 		dma_len =3D sg_dma_len(sg);
> > >
> > >
> > > 		// XXX: Here get the following output, the region is inside bridge's
> > > window 08000000-080fffff [size=3D1M]
> > > 		/*
> > >
> > > # dmesg | grep " 80" | grep -v "  80"
> > > [    0.000476] Console: colour dummy device 80x25
> > > [   79.331766] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end ad=
dr
> > > 80bc000
> > > [   79.815469] lchen dma nvme_pci_setup_prps 708 addr 8088000, end ad=
dr
> > > 8090000
> > > [  111.562129] lchen dma nvme_pci_setup_prps 708 addr 8088000, end ad=
dr
> > > 8090000
> > > [  111.873690] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end ad=
dr
> > > 80bc000
> > > 			 * * */
> > > 		printk("lchen dma %s %d addr %llx, end addr %llx", __func__,
> > > __LINE__, dma_addr, dma_addr + dma_len);
> > > 	}
> > > done:
> > > 	cmnd->dptr.prp1 =3D cpu_to_le64(sg_dma_address(iod->sg));
> > > 	cmnd->dptr.prp2 =3D cpu_to_le64(iod->first_dma);
> > > 	return BLK_STS_OK;
> > > free_prps:
> > > 	nvme_free_prps(dev, req);
> > > 	return BLK_STS_RESOURCE;
> > > bad_sgl:
> > > 	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
> > > 			"Invalid SGL for payload:%d nents:%d\n",
> > > 			blk_rq_payload_bytes(req), iod->nents);
> > > 	return BLK_STS_IOERR;
> > > }
> > >
> > > Backtrace of this function:
> > > # entries-in-buffer/entries-written: 1574/1574   #P:2
> > > #
> > > #                                _-----=3D> irqs-off
> > > #                               / _----=3D> need-resched
> > > #                              | / _---=3D> hardirq/softirq
> > > #                              || / _--=3D> preempt-depth
> > > #                              ||| /     delay
> > > #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> > > #              | |         |   ||||      |         |
> > >     kworker/u4:0-7       [000] ...1    40.095494: nvme_queue_rq <-
> > > blk_mq_dispatch_rq_list
> > >     kworker/u4:0-7       [000] ...1    40.095503: <stack trace>
> > >  =3D> nvme_queue_rq
> > >  =3D> blk_mq_dispatch_rq_list
> > >  =3D> __blk_mq_do_dispatch_sched
> > >  =3D> __blk_mq_sched_dispatch_requests
> > >  =3D> blk_mq_sched_dispatch_requests
> > >  =3D> __blk_mq_run_hw_queue
> > >  =3D> __blk_mq_delay_run_hw_queue
> > >  =3D> blk_mq_run_hw_queue
> > >  =3D> blk_mq_sched_insert_requests
> > >  =3D> blk_mq_flush_plug_list
> > >  =3D> blk_flush_plug_list
> > >  =3D> blk_mq_submit_bio
> > >  =3D> __submit_bio_noacct_mq
> > >  =3D> submit_bio_noacct
> > >  =3D> submit_bio
> > >  =3D> submit_bh_wbc.constprop.0
> > >  =3D> __block_write_full_page
> > >  =3D> block_write_full_page
> > >  =3D> blkdev_writepage
> > >  =3D> __writepage
> > >  =3D> write_cache_pages
> > >  =3D> generic_writepages
> > >  =3D> blkdev_writepages
> > >  =3D> do_writepages
> > >  =3D> __writeback_single_inode
> > >  =3D> writeback_sb_inodes
> > >  =3D> __writeback_inodes_wb
> > >  =3D> wb_writeback
> > >  =3D> wb_do_writeback
> > >  =3D> wb_workfn
> > >  =3D> process_one_work
> > >  =3D> worker_thread
> > >  =3D> kthread
> > >  =3D> ret_from_fork
> > >
> > >
> > > We don't have IOMMU and just have 1:1 mapping dma outbound.
> > >
> > >
> > > Here is the whole dmesg output(without my debug log):
> > > https://paste.debian.net/1217721/
>=20
>=20
> From dmesg:
>=20
>=20
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000001200000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000001200000-0x00000000ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000001200000-
> 0x00000000ffffffff]
> [    0.000000] On node 0 totalpages: 1043968
> [    0.000000]   DMA zone: 16312 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 1043968 pages, LIFO batch:63
>=20
> I only has one zone: ZONE_DMA, and it includes all physical memory:
>=20
> # cat /proc/iomem
> 01200000-ffffffff : System RAM
>   01280000-01c3ffff : Kernel code
>   01c40000-01ebffff : reserved
>   01ec0000-0201ffff : Kernel data
>   05280000-0528ffff : reserved
>   62000000-65ffffff : reserved
>   66186000-66786fff : reserved
>   66787000-667c0fff : reserved
>   667c3000-667c3fff : reserved
>   667c4000-667c5fff : reserved
>   667c6000-667c8fff : reserved
>   667c9000-ffffffff : reserved
> 2000000000-2000000fff : cfg
> 2008000000-200bffffff : pcie-controller@2040000000
>   2008000000-20081fffff : PCI Bus 0000:01
>     2008000000-20080fffff : PCI Bus 0000:02
>       2008000000-20080fffff : PCI Bus 0000:05
>         2008000000-2008003fff : 0000:05:00.0
>           2008000000-2008003fff : nvme
>     2008100000-200817ffff : 0000:01:00.0
>=20
>=20
>=20
> From nvme codes:
>=20
> dev->iod_mempool =3D mempool_create_node(1, mempool_kmalloc,
> 						mempool_kfree,
> 						(void *) alloc_size,
> 						GFP_KERNEL, node);
>=20
> So mempool here just uses kmalloc and GFP_KERNEL to get physical memory.
>=20
> Does it mean that I should re-arrange zone_dma/zone_dma/zone_normal(like
> limit zone_dma to mem region that doesn't include pcie mmio) to fix this =
problem?
>=20
>=20
>=20
> > > Here is our dtsi: https://paste.debian.net/1217723/
> > > >
> > > > > 2. For <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x0800000=
0>;
> > > > > (which make nvme not timeout)
> > > > >
> > > > > Switch(bridge of nvme)'s resource window:
> > > > > Memory behind bridge: Memory behind bridge: 00400000-004fffff
> [size=3D1M]
> > > > >
> > > > > 80d5000 and 80d5100 are not inside this range, so if nvme tries to
> > > > > read 80d5000 and 80d5100 , ur won't happen.
> > > > >
> > > > > From /proc/iomen:
> > > > > # cat /proc/iomem
> > > > > 01200000-ffffffff : System RAM
> > > > >   01280000-022affff : Kernel code
> > > > >   022b0000-0295ffff : reserved
> > > > >   02960000-040cffff : Kernel data
> > > > >   05280000-0528ffff : reserved
> > > > >   41cc0000-422c0fff : reserved
> > > > >   422c1000-4232afff : reserved
> > > > >   4232d000-667bbfff : reserved
> > > > >   667bc000-667bcfff : reserved
> > > > >   667bd000-667c0fff : reserved
> > > > >   667c1000-ffffffff : reserved
> > > > > 2000000000-2000000fff : cfg
> > > > >
> > > > > No one uses 0000000-1200000, so " Memory behind bridge: Memory
> > > > > behind bridge: 00400000-004fffff [size=3D1M]" will never have any
> > > > > problem(because 0x1200000 > 0x004fffff).
> > > > >
> > > > > Above answers the question in Subject, one question left: what's =
the
> > > > > right way to resolve this problem? Use ranges property to configu=
re
> > > > > switch memory window indirectly(just what I did)? Or something el=
se?
> > > > >
> > > > > I don't think changing range property is the right way: If my PCIe
> > > > > topology becomes more complex and have more endpoints or switches,
> > > > > maybe I have to reserve more MMIO through range property(please
> > > > > correct me if I'm wrong), the end of switch's memory window may be
> > > > > larger than 0x01200000. In case getting ur again,  I must reserve
> > > > > more physical memory address for them(like change kernel start
> > > > > address 0x01200000 to 0x02000000), which will make my visible dram
> > > > > smaller(I have verified it with "free -m"), it is not acceptable.
> > > >
> > > > Right, I don't think changing the PCI ranges property is the right
> > > > answer.  I think it's just a coincidence that moving the host bridge
> > > > MMIO aperture happens to move it out of the way of the DMA to
> > > > 0x080d5000.
> > > >
> > > > As far as I can tell, the PCI core and the nvme driver are doing the
> > > > right things here, and the problem is something behind the DMA API.
> > > >
> > > > I think there should be something that removes the MMIO aperture bus
> > > > addresses, i.e., 0x08000000-0x0bffffff in the timeout case, from the
> > > > pool of memory available for DMA buffers.
> > > >
> > > > The MMIO aperture bus addresses in the non-timeout case,
> > > > 0x00400000-0x083fffff, are not included in the 0x01200000-0xffffffff
> > > > System RAM area, which would explain why a DMA buffer would never
> > > > overlap with it.
> > > >
> > > > Bjorn
> > >
> > > Regards,
> > > Li
> >
> > Regards,
> > Li
>=20
> Regards,
> Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
