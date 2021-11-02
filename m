Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F784427E4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 08:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhKBHPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 03:15:02 -0400
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:25394 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhKBHPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 03:15:00 -0400
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A24uNxg021399;
        Tue, 2 Nov 2021 07:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=duiOrVCPytO2JbWqZN37wt2yB7/3lI+Zjtp23/TakmM=;
 b=zisygAfNOdxDxlM2Wqi9s2h/NXMMalF8xgLAQnC4Z35Cvpte/WX7RwIeoTSunI76tQ6L
 68YELrcuLw9HnO3av/Yc6RY3MLVDTsx1jJaBerF3H21KIR6Q9lngsNd44cb7gOppokvp
 wYQ9c9NzOk/ltdYes+q4sCJd5XQo1fesFJ1lCEj1xDuvyVOajFwgL/UEv9GfhiCGWHxh
 l24KX3g1wKtgKlJHMD0ZB8wWcu5w+uBK07tfxqmn7sI59GI+ryHA5CRGxqKX7K/l817w
 VRqT83IVi+lSYeF0slm0DLERK9WSvDBgGzWGSPmxCpfsHQI4nWF/YwRU1AkhcxXfrkMv Pw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3c28c88jy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 07:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/i/Fcx2tmdBu30YsGzGoqVY921onIoY/4wj+01UAuBG+ugMzG3P6a9FQcAUOkJDptnsyG3Apr+eTnD46eYf281L9z69CmFkn4G9F6ZroFq89BIoKDssxuViwJ6CgbdkJQgfBRkGvMpuE+7HuE9iGK5ovD2VnqhMUpUAvgkh9E6yQgR75M5lm4Sll207bDZ0cyuKnK5XIFJ6dLr7C2zKBfUcNvx2meCXCuq1zCAzxXxpAb6KOlqyPHsKWohPbi858y2vzF9xfUPhCEir68G/s1dPm29bqoonk8rEM2KZS09CCql8z71k3As55o6OlhqfApWZv0gNoB5LL8ceC61KNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnrn9lE09h0UyiE0wCJ7GGbAfR4YZqq32Vuvm3fEDAY=;
 b=mzS50KBMXzv9gIs6mJfdphSXmC50byNVR6HsiU2kZUsRfNvaER8aC8IpQ+3KHtaz6BH9Xa+lksPWGjmssUk6ug4fvqh3TImvYwewWfgpNmmeFE36Zc55da/qIeNf8X0uGDaDmzPvq93j9QA3UCyk19pq0GkFy1WCoXkJ7MDhevWgVEVyqMfb4XbCDMvwV6ktGy9/CzpcSGJ+NbSrxncoKrtoWUG3EnufeO0hruQo8NqUc8P327Ouq/JTLEmjRqzKY16LENYN8v9L9ihc+gI82ChlLH2yclzTrhxed8sHVOFVcJN8fHRUfD/jrikQsuQ0j/Jmognke/Nul2wvrULrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hnrn9lE09h0UyiE0wCJ7GGbAfR4YZqq32Vuvm3fEDAY=;
 b=IejlYd7sCQFlFgl0PZmabFjAl/uTqFQPo89w0lDprVLdM7jZ2eCfCpDQgQCIS5qZxoIxMnz56gofUMwzIVaaghKCAFZsatXC8Hh0YC9oCPMlt7LeOexYeP7vq1O7NmZ9p4lMlqKhyNcQHU51eet0d/LjsOwasdm3HhTCuWJ9DHk=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3735.namprd19.prod.outlook.com (2603:10b6:610:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 07:12:02 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 07:12:01 +0000
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
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8AAB+KwAAJu5nUAAG4h1gACqLnSwAASk8gA=
Date:   Tue, 2 Nov 2021 07:12:01 +0000
Message-ID: <CH2PR19MB4024B5D103F249F574839713A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024F88716768EC49BCA08CCA0879@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211029194253.GA345237@bhelgaas>
 <CH2PR19MB402445CF3AEF3529E9041211A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
In-Reply-To: <CH2PR19MB402445CF3AEF3529E9041211A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8114627c-452a-4161-18ee-08d99dd01167
x-ms-traffictypediagnostic: CH2PR19MB3735:
x-microsoft-antispam-prvs: <CH2PR19MB37353E550AA8704054C22B98A08B9@CH2PR19MB3735.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCIK/WRbwRPKze1/cwfQu4lkgI67HZl8UQAnxsamh5WN8HlhwetIYBWFLcbIHGq3KDDqWM133Ysd4kLODlRSlaANis0eqnFSikWiK4AdjVycWUsdKn+81Y0XYTg0KRuIvxHoQvJKiC+hXAYfR4TBH5ajwQfPo57yHpZeuLsYJXo+yRCzvHZuC+EsKE41GTD5kxhmp4+6OuftCbF8AtVQOxZg/RX0i8YKS1fw5IZaH158b3vz2Q1Mt2d+eJRinJemh2QzxN9aD4HVJtwamJUCKFN/Ij08KMIk9MKH1+FxOsB/byyuMKcOa6MZhopel1dToZZ8GU75kPSHTFKVddDZLhYbnfA+neTsGSecZToLSShYyunP8ERHqwnVVNgCfYJnf5DTKkeEvuOFmj3e1JgIFCgMbPoQRWBimDfni/D/3HPfM/7Dp7svdB8TpqM+OA9pMe26gwjID3hSJR7ne5M6K61xppTU/OvOxk7jWGIcQKcNi/9ZpVtcXvJz8tUdZQVPxbhlM2TF2IrX/ib0sjVneOZUafJtrmbCfoiVSk4NZUd+0Ef+lzP/ASU0mRGX2npklqy72Lf/WvKEIXx/LhkyJ/0f/08/51fhDZ9ZduX2ANbI3EqjsBNr2iQX/BcE9kWzCuDKF49wbY7N8xvCPYAeQH9y58aNTUH54Td7vGl6pd4PAnQjdOEwvtwtzRFTjLEJeG0/u5ac9iHgt8isp9vfz2nXpss18zYX5LuItfZPXbwhvffz0eKO/9z4G3uEbXFjhqJmmm3dw6cQlS2MJCd25g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(33656002)(508600001)(2940100002)(122000001)(26005)(186003)(38100700002)(83380400001)(86362001)(30864003)(88996005)(9686003)(66476007)(66946007)(7696005)(66556008)(4326008)(54906003)(6916009)(53546011)(5660300002)(966005)(316002)(66446008)(64756008)(2906002)(8936002)(52536014)(55016002)(8676002)(7416002)(6506007)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l+zo+LK6FSvbXyi0mzSCnXgqMnNlIqMDXW2AsGjcKloL0LJqzlkrntGpRQoV?=
 =?us-ascii?Q?/2qlmLgnso5sIS/HhctTTIlM+sTVdYxMb4r3mL8cesER2AjMhJ6AGui3naMO?=
 =?us-ascii?Q?15xys6eDNDq0MsC3r9LvvM4vATOHWEd+FFf/EqI20mh/MuYJikkQfFcTzS4y?=
 =?us-ascii?Q?MWUJdp0njWtQzxO20Mr1SI0wzR6ePnkAV7geM+8dfRkiEGd7/+jj1p8aCGMh?=
 =?us-ascii?Q?htZrG4L2BoXSEEQa+PiqEmatb4Yr/zUvsMilYFYdDryVoHv3oEeM4NLn/27T?=
 =?us-ascii?Q?wfXZg2noU1IpFj/3fTYC73ZI/WvEE0sFVsYdM8LzuqvxB0qW0KSp4ewcjdlk?=
 =?us-ascii?Q?NqHM/PqMx5VWkXI4JVb3lW31Q9xfzetIC3FQuXLp4eYX27LhTt3Jt+5tOHI6?=
 =?us-ascii?Q?1NEZHL3JsHVSuqh1FRFDu87/JRRVWa5sh5vspiTn+yuf44OTH3CfoFx/Nh90?=
 =?us-ascii?Q?tcIwIfE8B8WiLsVsbBPpZqSzV7/MM3gz4sqVpzriW+m95sP9g82IeMZrSDgH?=
 =?us-ascii?Q?sywgl//tV+ZcCPxJqmieHZ1r6RjAiCTRetmVET9Iv2Mby4UfAK6ZIx19TLNd?=
 =?us-ascii?Q?ZNmgB8flYnDLgVZE5EmZB51+PdRyEybWmG3n+xOA+7Tdq7pjTvHrWqHbctTG?=
 =?us-ascii?Q?lU1IFkHk+9NcNO0tiqxR01dWaNEEfs7JzcrkaeZQdspii4bZxg0dNi1EjeYH?=
 =?us-ascii?Q?jgRLO4fXKw58f/k112TsitYEQWfz4Il1uROXiAshmaj00mJAi4ztxVbuEpiW?=
 =?us-ascii?Q?WfIcVrqg+gjRLbKD6j+X0stxQdckA5ZB+WI/1NvP91VF6V8GZXsteL+grEy1?=
 =?us-ascii?Q?tfD0Xd68EfQQmDZn81/iGOLWfsyIhx7ASLIPtQSsk8mh+Ca1c2pFI3Oaw08V?=
 =?us-ascii?Q?TUYHsfiU3lC7IAWABEWPFe0Gi1kg/ap6YypyqB9cZjcRPE52M22taPMzzwf7?=
 =?us-ascii?Q?3R4c9issrPuaYXZktXt65TcA0MTbwr+RecJgPTE8cZ7/+PSX5svxT3GorYaI?=
 =?us-ascii?Q?30Ti2gRe21hiEGQKWc4+1A5TYSD8NCnYmU+GoiqR/UgaIB9qg7qzpGfRIL+Y?=
 =?us-ascii?Q?OxJYVajx6KGUfXpzxCKb7AfAfqB+VeaOWzR/0mv6Zw4sHhSFZpxSjmp/ApIT?=
 =?us-ascii?Q?z6YFHzhEnXSH0WE7qLVNeoQMmecaaeqnGOt8bQ3y5OHcz5hGFR/cILi9stlW?=
 =?us-ascii?Q?hnuhEozvmLusBNpVBA8E8df4zMaXlWbNRyD7aPfn/HsrU91cdQAPPdtVa1Qy?=
 =?us-ascii?Q?pnp0t0iqdFfWq2cWvxah2XZV6QOn5xacJKZPxX90WBF/WztjLQfEppLNCZMl?=
 =?us-ascii?Q?WzMHXO6ut6WfzJzeU9WKCvK3TH2AtwQOlsKv8RYkrXeT6K66bL/3vUSfu/nI?=
 =?us-ascii?Q?rsAzP1riP48Q47kv/qn6QeiXkZ+fqWDPrXMUQ931TwtcipfimUFglbQNBPgm?=
 =?us-ascii?Q?31ogoDSxAWqciKW3S0bQVHL4mlT27+pNj2h0Hm9kjHUdtuPE8IkzCIaHv2QG?=
 =?us-ascii?Q?m+BZVTYTNLbx3Co4maxQWuuMmcTgXDzyQvF/RrWNB9tkR+iekYE7eWIqUNyk?=
 =?us-ascii?Q?XtXNUovwnInNPMrbRPiITtf2FmJoBdRYu9dUillStn9g+RCFu0/yBziyeNt8?=
 =?us-ascii?Q?8gNAayE24/35nUcnQBQ6Uvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8114627c-452a-4161-18ee-08d99dd01167
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 07:12:01.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLwCk/sxzZPO/a9ZJkRJi1D0tIhks1JRsVbn3dAjGiWEJ/4xyn1Vn0Bfupb/R1gZMSFerK8S9AXsWX8ILmtTfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3735
X-Proofpoint-GUID: HWgJPL3X0FPJ6kYmRsaRvnxRNbC2xFqu
X-Proofpoint-ORIG-GUID: HWgJPL3X0FPJ6kYmRsaRvnxRNbC2xFqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020041
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Li Chen
> Sent: Tuesday, November 2, 2021 1:18 PM
> To: Bjorn Helgaas
> Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herrin=
g;
> kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; Je=
ns
> Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> Subject: RE: [EXT] Re: nvme may get timeout from dd when using different =
non-
> prefetch mmio outbound/ranges
>=20
> Hi, Bjorn
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Saturday, October 30, 2021 3:43 AM
> > To: Li Chen
> > Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herr=
ing;
> > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; =
Jens
> > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> > Subject: Re: [EXT] Re: nvme may get timeout from dd when using different
> non-
> > prefetch mmio outbound/ranges
> >
> > On Fri, Oct 29, 2021 at 10:52:37AM +0000, Li Chen wrote:
> > > > -----Original Message-----
> > > > From: Keith Busch [mailto:kbusch@kernel.org]
> > > > Sent: Tuesday, October 26, 2021 12:16 PM
> > > > To: Li Chen
> > > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Ro=
b Herring;
> > > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Jose=
ph;
> > Jens
> > > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead=
.org
> > > > Subject: Re: [EXT] Re: nvme may get timeout from dd when using diff=
erent
> > non-
> > > > prefetch mmio outbound/ranges
> > > >
> > > > On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > > > > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Elec=
tronics
> > Co
> > > > Ltd NVMe SSD Controller 980". From its datasheet,
> > > > https://urldefense.com/v3/__https://s3.ap-northeast-
> > > >
> >
> 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> > > >
> >
> ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> > > > PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I'm
> not
> > sure.
> > > > Is there other ways/tools(like nvme-cli) to query?
> > > >
> > > > The driver will export a sysfs property for it if it is supported:
> > > >
> > > >   # cat /sys/class/nvme/nvme0/cmb
> > > >
> > > > If the file doesn't exist, then /dev/nvme0 doesn't have the capabil=
ity.
> > > >
> > > > > > > I don't know how to interpret "ranges".  Can you supply the d=
mesg
> and
> > > > > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > > > > >
> > > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffff=
ff
> > window]
> > > > > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fff=
ff
> > window]
> > > > > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > > > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > > > > > >
> > > > > > > > Question:
> > > > > > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > > > > >
> > > > > > That means the nvme controller didn't provide a response to a p=
osted
> > > > > > command within the driver's latency tolerance.
> > > > >
> > > > > FYI, with the help of pci bridger's vendor, they find something
> > > > > interesting:
> > > > "From catc log, I saw some memory read pkts sent from SSD card,
> > > > but its memory range is within the memory range of switch down
> > > > port. So, switch down port will replay UR pkt. It seems not
> > > > normal." and "Why SSD card send out some memory pkts which memory
> > > > address is within switch down port's memory range. If so, switch
> > > > will response UR pkts". I also don't understand how can this
> > > > happen?
> > > >
> > > > I think we can safely assume you're not attempting peer-to-peer,
> > > > so that behavior as described shouldn't be happening. It sounds
> > > > like the memory windows may be incorrect. The dmesg may help to
> > > > show if something appears wrong.
> > >
> > > Agree that here doesn't involve peer-to-peer DMA. After conforming
> > > from switch vendor today, the two ur(unsupported request) is because
> > > nvme is trying to dma read dram with bus address 80d5000 and
> > > 80d5100. But the two bus addresses are located in switch's down port
> > > range, so the switch down port report ur.
> > >
> > > In our soc, dma/bus/pci address and physical/AXI address are 1:1,
> > > and DRAM space in physical memory address space is 000000.0000 -
> > > 0fffff.ffff 64G, so bus address 80d5000 and 80d5100 to cpu address
> > > are also 80d5000 and 80d5100, which both located inside dram space.
> > >
> > > Both our bootloader and romcode don't enum and configure pcie
> > > devices and switches, so the switch cfg stage should be left to
> > > kernel.
> > >
> > > Come back to the subject of this thread: " nvme may get timeout from
> > > dd when using different non-prefetch mmio outbound/ranges". I found:
> > >
> > > 1. For <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x04000000>;
> > > (which will timeout nvme)
> > >
> > > Switch(bridge of nvme)'s resource window:
> > > Memory behind bridge: Memory behind bridge: 08000000-080fffff [size=
=3D1M]
> > >
> > > 80d5000 and 80d5100 are both inside this range.
> >
> > The PCI host bridge MMIO window is here:
> >
> >   pci_bus 0000:00: root bus resource [mem 0x2008000000-0x200bffffff] (b=
us
> > address [0x08000000-0x0bffffff])
> >   pci 0000:01:00.0: PCI bridge to [bus 02-05]
> >   pci 0000:01:00.0:   bridge window [mem 0x2008000000-0x20080fffff]
> >   pci 0000:02:06.0: PCI bridge to [bus 05]
> >   pci 0000:02:06.0:   bridge window [mem 0x2008000000-0x20080fffff]
> >   pci 0000:05:00.0: BAR 0: assigned [mem 0x2008000000-0x2008003fff 64bi=
t]
> >
> > So bus address [0x08000000-0x0bffffff] is the area used for PCI BARs.
> > If the NVMe device is generating DMA transactions to 0x080d5000, which
> > is inside that range, those will be interpreted as peer-to-peer
> > transactions.  But obviously that's not intended and there's no device
> > at 0x080d5000 anyway.
> >
> > My guess is the nvme driver got 0x080d5000 from the DMA API, e.g.,
> > dma_map_bvec() or dma_map_sg_attrs(), so maybe there's something wrong
> > in how that's set up.  Is there an IOMMU?  There should be arch code
> > that knows what RAM is available for DMA buffers, maybe based on the
> > DT.  I'm not really familiar with how all that would be arranged, but
> > the complete dmesg log and complete DT might have a clue.  Can you
> > post those somewhere?
>=20
> After some printk, I found nvme_pci_setup_prps get some dma addresses ins=
ide
> switch's memory window from sg, but I don't where the sg is from(see
> comments in following source codes):

I just noticed it should come from mempool_alloc in nvme_map_data:
static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
		struct nvme_command *cmnd)
{
	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
	blk_status_t ret =3D BLK_STS_RESOURCE;
	int nr_mapped;

	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
		struct bio_vec bv =3D req_bvec(req);

		if (!is_pci_p2pdma_page(bv.bv_page)) {
			if (bv.bv_offset + bv.bv_len <=3D NVME_CTRL_PAGE_SIZE * 2)
				return nvme_setup_prp_simple(dev, req,
							     &cmnd->rw, &bv);

			if (iod->nvmeq->qid &&
			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
				return nvme_setup_sgl_simple(dev, req,
							     &cmnd->rw, &bv);
		}
	}

	iod->dma_len =3D 0;
	iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);


	unsigned int l =3D sg_dma_address(iod->sg), r =3D sg_dma_address(iod->sg) =
+ sg_dma_len(iod->sg), tl =3D 0x08000000, tr =3D tl + 0x04000000, ntl =3D 0=
x00400000, ntr =3D ntl + 0x08000000;

/*
# dmesg | grep "region-timeout ? 1" | grep nvme_map_data
[   16.002446] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1c21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   16.341240] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1a21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   16.405938] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1821c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   36.126917] lchen nvme_map_data, 895: first_dma 0, end_dma 8f2421c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   36.703839] lchen nvme_map_data, 895: first_dma 0, end_dma 8f2221c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   38.510086] lchen nvme_map_data, 895: first_dma 0, end_dma 89c621c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.542394] lchen nvme_map_data, 895: first_dma 0, end_dma 89c421c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.573405] lchen nvme_map_data, 895: first_dma 0, end_dma 87ee21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.604419] lchen nvme_map_data, 895: first_dma 0, end_dma 87ec21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.874395] lchen nvme_map_data, 895: first_dma 0, end_dma 8aa221c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.905323] lchen nvme_map_data, 895: first_dma 0, end_dma 8aa021c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.968675] lchen nvme_map_data, 895: first_dma 0, end_dma 8a0e21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   40.999659] lchen nvme_map_data, 895: first_dma 0, end_dma 8a0821c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.030601] lchen nvme_map_data, 895: first_dma 0, end_dma 8bde21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.061629] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1e21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.092598] lchen nvme_map_data, 895: first_dma 0, end_dma 8eb621c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.123677] lchen nvme_map_data, 895: first_dma 0, end_dma 8eb221c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.160960] lchen nvme_map_data, 895: first_dma 0, end_dma 8cee21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.193609] lchen nvme_map_data, 895: first_dma 0, end_dma 8cec21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.224607] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7e21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.255592] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7c21c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
[   41.286594] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7821c, insi=
de region-timeout ? 1, is inside region-non-timeout ? 0
*/
	printk("lchen %s, %d: first_dma %llx, end_dma %llx, inside region-timeout =
? %d, is inside region-non-timeout ? %d", __func__, __LINE__, l, r, l >=3D =
tl && l <=3D tr || r >=3D tl && r <=3D tr, l >=3D ntl && l <=3D ntr || r >=
=3D ntl && r <=3D ntr);



	//printk("lchen %s %d, addr starts %llx, ends %llx", __func__, __LINE__, s=
g_dma_address(iod->sg), sg_dma_address(iod->sg) + sg_dma_len(iod->sg));

    ................
}

>=20
> static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
> 		struct request *req, struct nvme_rw_command *cmnd)
> {
> 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> 	struct dma_pool *pool;
> 	int length =3D blk_rq_payload_bytes(req);
> 	struct scatterlist *sg =3D iod->sg;
> 	int dma_len =3D sg_dma_len(sg);
> 	u64 dma_addr =3D sg_dma_address(sg);
>                 ......
> 	for (;;) {
> 		if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
> 			__le64 *old_prp_list =3D prp_list;
> 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC,
> &prp_dma);
> 			printk("lchen %s %d dma pool %llx", __func__, __LINE__,
> prp_dma);
> 			if (!prp_list)
> 				goto free_prps;
> 			list[iod->npages++] =3D prp_list;
> 			prp_list[0] =3D old_prp_list[i - 1];
> 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
> 			i =3D 1;
> 		}
> 		prp_list[i++] =3D cpu_to_le64(dma_addr);
> 		dma_len -=3D NVME_CTRL_PAGE_SIZE;
> 		dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> 		length -=3D NVME_CTRL_PAGE_SIZE;
> 		if (length <=3D 0)
> 			break;
> 		if (dma_len > 0)
> 			continue;
> 		if (unlikely(dma_len < 0))
> 			goto bad_sgl;
> 		sg =3D sg_next(sg);
> 		dma_addr =3D sg_dma_address(sg);
> 		dma_len =3D sg_dma_len(sg);
>=20
>=20
> 		// XXX: Here get the following output, the region is inside bridge's
> window 08000000-080fffff [size=3D1M]
> 		/*
>=20
> # dmesg | grep " 80" | grep -v "  80"
> [    0.000476] Console: colour dummy device 80x25
> [   79.331766] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end addr
> 80bc000
> [   79.815469] lchen dma nvme_pci_setup_prps 708 addr 8088000, end addr
> 8090000
> [  111.562129] lchen dma nvme_pci_setup_prps 708 addr 8088000, end addr
> 8090000
> [  111.873690] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end addr
> 80bc000
> 			 * * */
> 		printk("lchen dma %s %d addr %llx, end addr %llx", __func__,
> __LINE__, dma_addr, dma_addr + dma_len);
> 	}
> done:
> 	cmnd->dptr.prp1 =3D cpu_to_le64(sg_dma_address(iod->sg));
> 	cmnd->dptr.prp2 =3D cpu_to_le64(iod->first_dma);
> 	return BLK_STS_OK;
> free_prps:
> 	nvme_free_prps(dev, req);
> 	return BLK_STS_RESOURCE;
> bad_sgl:
> 	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
> 			"Invalid SGL for payload:%d nents:%d\n",
> 			blk_rq_payload_bytes(req), iod->nents);
> 	return BLK_STS_IOERR;
> }
>=20
> Backtrace of this function:
> # entries-in-buffer/entries-written: 1574/1574   #P:2
> #
> #                                _-----=3D> irqs-off
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>     kworker/u4:0-7       [000] ...1    40.095494: nvme_queue_rq <-
> blk_mq_dispatch_rq_list
>     kworker/u4:0-7       [000] ...1    40.095503: <stack trace>
>  =3D> nvme_queue_rq
>  =3D> blk_mq_dispatch_rq_list
>  =3D> __blk_mq_do_dispatch_sched
>  =3D> __blk_mq_sched_dispatch_requests
>  =3D> blk_mq_sched_dispatch_requests
>  =3D> __blk_mq_run_hw_queue
>  =3D> __blk_mq_delay_run_hw_queue
>  =3D> blk_mq_run_hw_queue
>  =3D> blk_mq_sched_insert_requests
>  =3D> blk_mq_flush_plug_list
>  =3D> blk_flush_plug_list
>  =3D> blk_mq_submit_bio
>  =3D> __submit_bio_noacct_mq
>  =3D> submit_bio_noacct
>  =3D> submit_bio
>  =3D> submit_bh_wbc.constprop.0
>  =3D> __block_write_full_page
>  =3D> block_write_full_page
>  =3D> blkdev_writepage
>  =3D> __writepage
>  =3D> write_cache_pages
>  =3D> generic_writepages
>  =3D> blkdev_writepages
>  =3D> do_writepages
>  =3D> __writeback_single_inode
>  =3D> writeback_sb_inodes
>  =3D> __writeback_inodes_wb
>  =3D> wb_writeback
>  =3D> wb_do_writeback
>  =3D> wb_workfn
>  =3D> process_one_work
>  =3D> worker_thread
>  =3D> kthread
>  =3D> ret_from_fork
>=20
>=20
> We don't have IOMMU and just have 1:1 mapping dma outbound.
>=20
>=20
> Here is the whole dmesg output(without my debug log):
> https://paste.debian.net/1217721/
> Here is our dtsi: https://paste.debian.net/1217723/
> >
> > > 2. For <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>;
> > > (which make nvme not timeout)
> > >
> > > Switch(bridge of nvme)'s resource window:
> > > Memory behind bridge: Memory behind bridge: 00400000-004fffff [size=
=3D1M]
> > >
> > > 80d5000 and 80d5100 are not inside this range, so if nvme tries to
> > > read 80d5000 and 80d5100 , ur won't happen.
> > >
> > > From /proc/iomen:
> > > # cat /proc/iomem
> > > 01200000-ffffffff : System RAM
> > >   01280000-022affff : Kernel code
> > >   022b0000-0295ffff : reserved
> > >   02960000-040cffff : Kernel data
> > >   05280000-0528ffff : reserved
> > >   41cc0000-422c0fff : reserved
> > >   422c1000-4232afff : reserved
> > >   4232d000-667bbfff : reserved
> > >   667bc000-667bcfff : reserved
> > >   667bd000-667c0fff : reserved
> > >   667c1000-ffffffff : reserved
> > > 2000000000-2000000fff : cfg
> > >
> > > No one uses 0000000-1200000, so " Memory behind bridge: Memory
> > > behind bridge: 00400000-004fffff [size=3D1M]" will never have any
> > > problem(because 0x1200000 > 0x004fffff).
> > >
> > > Above answers the question in Subject, one question left: what's the
> > > right way to resolve this problem? Use ranges property to configure
> > > switch memory window indirectly(just what I did)? Or something else?
> > >
> > > I don't think changing range property is the right way: If my PCIe
> > > topology becomes more complex and have more endpoints or switches,
> > > maybe I have to reserve more MMIO through range property(please
> > > correct me if I'm wrong), the end of switch's memory window may be
> > > larger than 0x01200000. In case getting ur again,  I must reserve
> > > more physical memory address for them(like change kernel start
> > > address 0x01200000 to 0x02000000), which will make my visible dram
> > > smaller(I have verified it with "free -m"), it is not acceptable.
> >
> > Right, I don't think changing the PCI ranges property is the right
> > answer.  I think it's just a coincidence that moving the host bridge
> > MMIO aperture happens to move it out of the way of the DMA to
> > 0x080d5000.
> >
> > As far as I can tell, the PCI core and the nvme driver are doing the
> > right things here, and the problem is something behind the DMA API.
> >
> > I think there should be something that removes the MMIO aperture bus
> > addresses, i.e., 0x08000000-0x0bffffff in the timeout case, from the
> > pool of memory available for DMA buffers.
> >
> > The MMIO aperture bus addresses in the non-timeout case,
> > 0x00400000-0x083fffff, are not included in the 0x01200000-0xffffffff
> > System RAM area, which would explain why a DMA buffer would never
> > overlap with it.
> >
> > Bjorn
>=20
> Regards,
> Li

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
