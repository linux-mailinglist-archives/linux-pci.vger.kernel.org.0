Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC9443FD0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 11:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhKCKHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 06:07:41 -0400
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:64164 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231792AbhKCKHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 06:07:40 -0400
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A39mpfF020489;
        Wed, 3 Nov 2021 10:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=S+hRTj6xPQxODu1Q/RunsJ0U/p2D4hvgD8Nmha1ImVU=;
 b=TylxC0eyRQAdwVq9C1RRcg7v+L+carUIyQPWhtoNbI5IdxPfG2uYneg7Bu+KN/IMtx3d
 VF9oHl53OP6bEHZDfCHsOT5bwGb2JVHB7luI9lVyU3DP/8M2u3jj9LcUfiGZ2M4ASXXc
 WAe9YZnhMR3LHInTt0ivWtyKyhNj6LOlL73hCp2Odgtx9UL/LRe3qj9fdG0Jsfaythd/
 dx/pFxKDqpcNu8YiPczxh75wa72PoLZvRJ5LjGLoKpxI53zImgwONILrri7UIB3NlfS+
 LiJooNSRR6YLxesVJvnXLc3GjHDpvZ/vua+XY9pE1C0kZoHI1VT6VvsehILgTTcF9wEF 1A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3c3dvs07q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 10:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzI70vdaciF8D/veIp3O/rm2hMRy+8Gw18qjHSyxS0eAU7rF2RMgDLjcXQNH0VqToMVYOH95slJXGxYZseDDGTGS2ygigh9GIkSRACQpHZ/FtlbiQhyvNIYMQ30DLXBuODVy+b+qXcjmBvDjxZxXBAbRCeG2g+gLS8IL/iAzdFYlyckDu5O7HwoBqptwWokGBdiSGtt+9fU9UTQlCdteg96gr7BbMkNTy/wrbCz99VhX22v0cwuSPzgP7oeE6OEreEfbNZCI5fmF3P4E9q49ucNWMIjGQ6AypzKY0Q89AumSo5CdbErYvubDBE2dh6BGW8qz2XufsAkYS4Wi8dhWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y029IgAVSYfcgwgNdn4LXm6XlFLZFPc3FRHNgeYUl94=;
 b=aqzrHTqLQqQQMxwpTQuwr73NU2XWlTkq7pabEMg/zKap6/z29Df+nOqyTncoY9C6Z72QuOWOrIcvxNJdgwi6iyAsyLGoTBfWLjJWPT/JS7eH560KOki2ApjC0zyXaMbu7D4q3NhT1dSpBvGgx5N++011/TApP37GCXLsesD3Y6VoVbiJdRJxMgRb0MYTbgXmQUPQAtYDzH6vpnLKZOiSQhkeYpIXy/IGxoKTpOpvc6hEn4tJZbI/qRWDr0O+RFfx5n8yhFrR+BqQdj6Mucn4ouwuQr5OF8GAIUn+4iE9iI0Pzy/Jr5TtJIkNaywS7CxnVOmPVAV2hyzt+TWK1lvIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y029IgAVSYfcgwgNdn4LXm6XlFLZFPc3FRHNgeYUl94=;
 b=FzAtb/cl710vVf1LjWrMHyCH9im7kRK7iS+kyMNKTwXdHNn1cD7tHWhr7sKYVNIOWXHMxSO/s6AbpWgFH6nZAe4bfWRNnNxoJSVM5Z/MkrjoT2/rSDx7Jb4KyCyLpFevauni0g24yQS2ha6WdhgnzaWQnIgFRRsM0FJwG5BhPTk=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB4070.namprd19.prod.outlook.com (2603:10b6:610:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 3 Nov
 2021 10:04:23 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 10:04:23 +0000
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
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8AAB+KwAAJu5nUAAG4h1gACqLnSwAASk8gAANw5dEA==
Date:   Wed, 3 Nov 2021 10:04:22 +0000
Message-ID: <CH2PR19MB402416169BDC609DE473E2B7A08C9@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024F88716768EC49BCA08CCA0879@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211029194253.GA345237@bhelgaas>
 <CH2PR19MB402445CF3AEF3529E9041211A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
 <CH2PR19MB4024B5D103F249F574839713A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
In-Reply-To: <CH2PR19MB4024B5D103F249F574839713A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1919bf0-6f0f-4010-2a75-08d99eb14fa8
x-ms-traffictypediagnostic: CH2PR19MB4070:
x-microsoft-antispam-prvs: <CH2PR19MB4070ED9E9499DBBBA547EA45A08C9@CH2PR19MB4070.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSlCsndPg8OcydVun8+qHgenMO50L8h57gKUko/od0zWrO1RU4alUsGVCZ9zUjb4hvt6ws2hK2kRUg3ZHqb9vvDfSNEKLEeS1G/39Vr4wKteRDQZvq7/7/KPXHsDzm435+Glog4SqR6XgU2L7TVNwK+A7hPPrdp9b7dIwi4Od9pPTNaruO2TNzZTXE4vldbqCvAPjU+Z+m07IvAwI6tl184uBdGt+6q/rW3vgksyW62mmm63huMuLgIEdbCwVElh2RvBu/aN53np+su8zfuaeZqrHsnxI1LIh91nDgyrv99pDvJDEjQ3Iqrgy3eOCMhBdWjb/6FGEul7zhhR0VhR+H+doRj+r9SkDlEUxeTxGVj71dUZr44Ts6C3wQGr9vynT69YrBWfAyJ8hdhVjwtGQH9DuJv4ZNlCXoVnvQhvkkowa8pHFq1KJJupatIFq/0crTKr90oyVVIUYbiZHwvDUd3o8LUt7P1giXo4No3K95jxV1j0WNtrIcoL9ac6kA7JAACtmrM0xLhJfGhWqf1TFfWQNmFBMMvcfS1Nx7B1gG+72CB484Qq5ikyZ+qA+wrOVpgszYwHcbK5UTOTxvMmZrZWUHkygZLFkiyMxaxDIQDlxiXKLJLzacCPSx3N+8Y22HlUUvs7WwJTsvmkaIMpU9KYDbuV88BQQz/+x7KhVHAzWx3pWv93ol/cRJ4zXEt7FHLNakhPER1TG3LACO68rYfxM5WxEzUmRf49TCzB114PZ/jLURW4iLb3Wf77jpcc2n+ZRf3JsXLmBpWLH4XtLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(66446008)(966005)(64756008)(5660300002)(66476007)(66556008)(2906002)(6916009)(8936002)(508600001)(52536014)(7696005)(122000001)(86362001)(38100700002)(7416002)(66946007)(26005)(186003)(33656002)(53546011)(6506007)(8676002)(4326008)(83380400001)(71200400001)(54906003)(55016002)(316002)(9686003)(88996005)(21314003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4uDgQy6iIQtMhQmJi4NWuLg9+ExOQCmCcuhXP3CfZahcDTABv4WMnC3LPPNA?=
 =?us-ascii?Q?fCQPpB0U5FnFBo/jdONUHK0qwXdtUFQqCI5e5bYddWYCH0855OqmX42070Yz?=
 =?us-ascii?Q?MIlX7DQLFAr1XyQ00uItC0Lrhl3U8KOF3KyZagFYtGZNuDhnIKLMEOnu0xfq?=
 =?us-ascii?Q?RdOrQWByAx6VIetFVII5wWEJNWLdeI3ohd2py+Vg0uF5B3KwjZKbegntVXH6?=
 =?us-ascii?Q?cvCWZWr1nm5APnuAb4lOVJ+CLMP4b5eKmaSYUyuc9gFL8UIoC7AzQJ1/OASw?=
 =?us-ascii?Q?RZJY4YNBNWCJ5iPJGjY94iK+CdUvrkDBD+e30qx+rba0W0WT2e8tb5ByDwXp?=
 =?us-ascii?Q?CbSC6k1EBreVRGc/qzLGSwyqA/WMmetL/wrLJls6pmTLgERmKwUOP0p7iHae?=
 =?us-ascii?Q?JXCqvzGN5Z255XMiXEHW5DVlHCBgbQoQqpKNC6aqQ97uKlaR0/Q6AvyMON0U?=
 =?us-ascii?Q?6B3pMjrqVha5klL2iQx0x9Qj4gUZW/TU1J5nII7GxQ91rJ7a7TUvDNvxdMvx?=
 =?us-ascii?Q?zaJkRP+84yRh7wMEohAfUxr+meTgfNbbzowsFSDTjEnXybRARtVNkssLU/W9?=
 =?us-ascii?Q?0N93rXKUhEtIMFvioGkTvdAlsEsU4ce8vcHO74orEFy55GjP4q/D8d4b9K6R?=
 =?us-ascii?Q?Grugsjk6TWf8a/YLeN4SMUuq3zJhH7sBd3Fz3FmK8801REzwXpmejE9lr8Xs?=
 =?us-ascii?Q?NyA5e8C5ppRFwdOnv3v8MIkTr05HlOCFKgccQpDTSb4h9NeqBlIpWGnCqWF1?=
 =?us-ascii?Q?kGOWCQj8KuhP8wULHKzfQ1J2cYPmNaKm4V7RAlutjZ6jEn4CduVELcdpw2rj?=
 =?us-ascii?Q?ARcub+Z1fSsERPOmdZ0wOk8hqg9415wUJiIWm57xlVJPUtsOWwubb7Gf88pB?=
 =?us-ascii?Q?rkinCV7PPWdDMy3KLT9qMrVX1CP3vPIRA/oeApvbj7CQ668eeoU5feA6KF0T?=
 =?us-ascii?Q?iaok0rLAwj2iw27VtUgMKIkbuTsdSv8h7UyeEuotRUb4yOAxXURKdYrDqyJM?=
 =?us-ascii?Q?ER3Wcl9iu+/CbjHcJx1Z3JhVPDNXuxYG3fGEY94MZMHDBEiBooVsFoU9oOyT?=
 =?us-ascii?Q?dPRQy366Lslr091/T3TPN4izybVXINwN/9sd21YAd2+n8fPjmCc+SxusK8LG?=
 =?us-ascii?Q?Gxxh/criVRxtu+jNvwYNRr+U2g0KI93muIShJ4urcXZPihnzhcN4HH5TP4O5?=
 =?us-ascii?Q?sPTFuoV9eDAm/33msIJWtxKnbslY4nWCGkNjf75/qsC+61RpUFtA5DdhNdCu?=
 =?us-ascii?Q?oP1pmTIHQnwik8MK2OulYFLuENr+r2v4UPHFrHs3ru1K0q2UG0+sIxy1Udmx?=
 =?us-ascii?Q?XT93tNvWCNq8Zy2+GvTuRrvtAcNIclKSKuKYFkZKRIHK9xyToXELB3jfpItY?=
 =?us-ascii?Q?KXjJ/Kp5b9g8t/a5+NcZUK7bkwasDJSAe//p/6cM0qOEeihLjsg32MnL1T8S?=
 =?us-ascii?Q?LFssj9R9f573ct3LakMDTbFm/rpaLKbcjGfEBOzgbPRjYMVhac/rPb8MciDP?=
 =?us-ascii?Q?PxSNJzWmXOG+cm0cA1k1uSfDsJt57JciGSdeC6JMzT6NTiMmVxJyIrq9H49v?=
 =?us-ascii?Q?DyHfp5kP4iDOOpQUlNRxN2MWUpA7TdNBHFgoA9shxMYU6AifV2PQ2QYPx5dp?=
 =?us-ascii?Q?U4vRivRLU0YklkYmqeLRZOA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1919bf0-6f0f-4010-2a75-08d99eb14fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 10:04:22.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csikf+wnNqgq9qGZdTT6GDKmswSArqa0yrVH6CpOGHTz2VBLtvMrpOP9aakEG++LZ3PYDOWLLf2HsgZR9Kznnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4070
X-Proofpoint-ORIG-GUID: AI6Do0H1GSS17ZC5N09LLu4Zi9Dt1OHt
X-Proofpoint-GUID: AI6Do0H1GSS17ZC5N09LLu4Zi9Dt1OHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030057
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Li Chen
> Sent: Tuesday, November 2, 2021 3:12 PM
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
>=20
>=20
> > -----Original Message-----
> > From: Li Chen
> > Sent: Tuesday, November 2, 2021 1:18 PM
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
> > Hi, Bjorn
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > Sent: Saturday, October 30, 2021 3:43 AM
> > > To: Li Chen
> > > Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob He=
rring;
> > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph;
> Jens
> > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.o=
rg
> > > Subject: Re: [EXT] Re: nvme may get timeout from dd when using differ=
ent
> > non-
> > > prefetch mmio outbound/ranges
> > >
> > > On Fri, Oct 29, 2021 at 10:52:37AM +0000, Li Chen wrote:
> > > > > -----Original Message-----
> > > > > From: Keith Busch [mailto:kbusch@kernel.org]
> > > > > Sent: Tuesday, October 26, 2021 12:16 PM
> > > > > To: Li Chen
> > > > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi; =
Rob
> Herring;
> > > > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Jo=
seph;
> > > Jens
> > > > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infrade=
ad.org
> > > > > Subject: Re: [EXT] Re: nvme may get timeout from dd when using
> different
> > > non-
> > > > > prefetch mmio outbound/ranges
> > > > >
> > > > > On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > > > > > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung
> Electronics
> > > Co
> > > > > Ltd NVMe SSD Controller 980". From its datasheet,
> > > > > https://urldefense.com/v3/__https://s3.ap-northeast-
> > > > >
> > >
> >
> 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> > > > >
> > >
> >
> ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> > > > > PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I'm
> > not
> > > sure.
> > > > > Is there other ways/tools(like nvme-cli) to query?
> > > > >
> > > > > The driver will export a sysfs property for it if it is supported:
> > > > >
> > > > >   # cat /sys/class/nvme/nvme0/cmb
> > > > >
> > > > > If the file doesn't exist, then /dev/nvme0 doesn't have the capab=
ility.
> > > > >
> > > > > > > > I don't know how to interpret "ranges".  Can you supply the=
 dmesg
> > and
> > > > > > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > > > > > >
> > > > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefff=
ffff
> > > window]
> > > > > > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7f=
ffff
> > > window]
> > > > > > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > > > > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ..=
.]
> > > > > > > >
> > > > > > > > > Question:
> > > > > > > > > 1.  Why dd can cause nvme timeout? Is there more debug wa=
ys?
> > > > > > >
> > > > > > > That means the nvme controller didn't provide a response to a=
 posted
> > > > > > > command within the driver's latency tolerance.
> > > > > >
> > > > > > FYI, with the help of pci bridger's vendor, they find something
> > > > > > interesting:
> > > > > "From catc log, I saw some memory read pkts sent from SSD card,
> > > > > but its memory range is within the memory range of switch down
> > > > > port. So, switch down port will replay UR pkt. It seems not
> > > > > normal." and "Why SSD card send out some memory pkts which memory
> > > > > address is within switch down port's memory range. If so, switch
> > > > > will response UR pkts". I also don't understand how can this
> > > > > happen?
> > > > >
> > > > > I think we can safely assume you're not attempting peer-to-peer,
> > > > > so that behavior as described shouldn't be happening. It sounds
> > > > > like the memory windows may be incorrect. The dmesg may help to
> > > > > show if something appears wrong.
> > > >
> > > > Agree that here doesn't involve peer-to-peer DMA. After conforming
> > > > from switch vendor today, the two ur(unsupported request) is because
> > > > nvme is trying to dma read dram with bus address 80d5000 and
> > > > 80d5100. But the two bus addresses are located in switch's down port
> > > > range, so the switch down port report ur.
> > > >
> > > > In our soc, dma/bus/pci address and physical/AXI address are 1:1,
> > > > and DRAM space in physical memory address space is 000000.0000 -
> > > > 0fffff.ffff 64G, so bus address 80d5000 and 80d5100 to cpu address
> > > > are also 80d5000 and 80d5100, which both located inside dram space.
> > > >
> > > > Both our bootloader and romcode don't enum and configure pcie
> > > > devices and switches, so the switch cfg stage should be left to
> > > > kernel.
> > > >
> > > > Come back to the subject of this thread: " nvme may get timeout from
> > > > dd when using different non-prefetch mmio outbound/ranges". I found:
> > > >
> > > > 1. For <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x04000000>;
> > > > (which will timeout nvme)
> > > >
> > > > Switch(bridge of nvme)'s resource window:
> > > > Memory behind bridge: Memory behind bridge: 08000000-080fffff [size=
=3D1M]
> > > >
> > > > 80d5000 and 80d5100 are both inside this range.
> > >
> > > The PCI host bridge MMIO window is here:
> > >
> > >   pci_bus 0000:00: root bus resource [mem 0x2008000000-0x200bffffff] =
(bus
> > > address [0x08000000-0x0bffffff])
> > >   pci 0000:01:00.0: PCI bridge to [bus 02-05]
> > >   pci 0000:01:00.0:   bridge window [mem 0x2008000000-0x20080fffff]
> > >   pci 0000:02:06.0: PCI bridge to [bus 05]
> > >   pci 0000:02:06.0:   bridge window [mem 0x2008000000-0x20080fffff]
> > >   pci 0000:05:00.0: BAR 0: assigned [mem 0x2008000000-0x2008003fff 64=
bit]
> > >
> > > So bus address [0x08000000-0x0bffffff] is the area used for PCI BARs.
> > > If the NVMe device is generating DMA transactions to 0x080d5000, which
> > > is inside that range, those will be interpreted as peer-to-peer
> > > transactions.  But obviously that's not intended and there's no device
> > > at 0x080d5000 anyway.
> > >
> > > My guess is the nvme driver got 0x080d5000 from the DMA API, e.g.,
> > > dma_map_bvec() or dma_map_sg_attrs(), so maybe there's something
> wrong
> > > in how that's set up.  Is there an IOMMU?  There should be arch code
> > > that knows what RAM is available for DMA buffers, maybe based on the
> > > DT.  I'm not really familiar with how all that would be arranged, but
> > > the complete dmesg log and complete DT might have a clue.  Can you
> > > post those somewhere?
> >
> > After some printk, I found nvme_pci_setup_prps get some dma addresses
> inside
> > switch's memory window from sg, but I don't where the sg is from(see
> > comments in following source codes):
>=20
> I just noticed it should come from mempool_alloc in nvme_map_data:
> static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *r=
eq,
> 		struct nvme_command *cmnd)
> {
> 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> 	blk_status_t ret =3D BLK_STS_RESOURCE;
> 	int nr_mapped;
>=20
> 	if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
> 		struct bio_vec bv =3D req_bvec(req);
>=20
> 		if (!is_pci_p2pdma_page(bv.bv_page)) {
> 			if (bv.bv_offset + bv.bv_len <=3D NVME_CTRL_PAGE_SIZE
> * 2)
> 				return nvme_setup_prp_simple(dev, req,
> 							     &cmnd->rw, &bv);
>=20
> 			if (iod->nvmeq->qid &&
> 			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
> 				return nvme_setup_sgl_simple(dev, req,
> 							     &cmnd->rw, &bv);
> 		}
> 	}
>=20
> 	iod->dma_len =3D 0;
> 	iod->sg =3D mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
>=20
>=20
> 	unsigned int l =3D sg_dma_address(iod->sg), r =3D sg_dma_address(iod->sg)
> + sg_dma_len(iod->sg), tl =3D 0x08000000, tr =3D tl + 0x04000000, ntl =3D=
 0x00400000, ntr
> =3D ntl + 0x08000000;
>=20
> /*
> # dmesg | grep "region-timeout ? 1" | grep nvme_map_data
> [   16.002446] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1c21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   16.341240] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1a21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   16.405938] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1821c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   36.126917] lchen nvme_map_data, 895: first_dma 0, end_dma 8f2421c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   36.703839] lchen nvme_map_data, 895: first_dma 0, end_dma 8f2221c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   38.510086] lchen nvme_map_data, 895: first_dma 0, end_dma 89c621c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.542394] lchen nvme_map_data, 895: first_dma 0, end_dma 89c421c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.573405] lchen nvme_map_data, 895: first_dma 0, end_dma 87ee21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.604419] lchen nvme_map_data, 895: first_dma 0, end_dma 87ec21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.874395] lchen nvme_map_data, 895: first_dma 0, end_dma 8aa221c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.905323] lchen nvme_map_data, 895: first_dma 0, end_dma 8aa021c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.968675] lchen nvme_map_data, 895: first_dma 0, end_dma 8a0e21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   40.999659] lchen nvme_map_data, 895: first_dma 0, end_dma 8a0821c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.030601] lchen nvme_map_data, 895: first_dma 0, end_dma 8bde21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.061629] lchen nvme_map_data, 895: first_dma 0, end_dma 8b1e21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.092598] lchen nvme_map_data, 895: first_dma 0, end_dma 8eb621c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.123677] lchen nvme_map_data, 895: first_dma 0, end_dma 8eb221c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.160960] lchen nvme_map_data, 895: first_dma 0, end_dma 8cee21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.193609] lchen nvme_map_data, 895: first_dma 0, end_dma 8cec21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.224607] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7e21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.255592] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7c21c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> [   41.286594] lchen nvme_map_data, 895: first_dma 0, end_dma 8c7821c, in=
side
> region-timeout ? 1, is inside region-non-timeout ? 0
> */
> 	printk("lchen %s, %d: first_dma %llx, end_dma %llx, inside region-
> timeout ? %d, is inside region-non-timeout ? %d", __func__, __LINE__, l, =
r, l >=3D tl
> && l <=3D tr || r >=3D tl && r <=3D tr, l >=3D ntl && l <=3D ntr || r >=
=3D ntl && r <=3D ntr);
>=20
>=20
>=20
> 	//printk("lchen %s %d, addr starts %llx, ends %llx", __func__, __LINE__,
> sg_dma_address(iod->sg), sg_dma_address(iod->sg) + sg_dma_len(iod->sg));
>=20
>     ................
> }
>=20
> >
> > static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
> > 		struct request *req, struct nvme_rw_command *cmnd)
> > {
> > 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> > 	struct dma_pool *pool;
> > 	int length =3D blk_rq_payload_bytes(req);
> > 	struct scatterlist *sg =3D iod->sg;
> > 	int dma_len =3D sg_dma_len(sg);
> > 	u64 dma_addr =3D sg_dma_address(sg);
> >                 ......
> > 	for (;;) {
> > 		if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
> > 			__le64 *old_prp_list =3D prp_list;
> > 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC,
> > &prp_dma);
> > 			printk("lchen %s %d dma pool %llx", __func__, __LINE__,
> > prp_dma);
> > 			if (!prp_list)
> > 				goto free_prps;
> > 			list[iod->npages++] =3D prp_list;
> > 			prp_list[0] =3D old_prp_list[i - 1];
> > 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
> > 			i =3D 1;
> > 		}
> > 		prp_list[i++] =3D cpu_to_le64(dma_addr);
> > 		dma_len -=3D NVME_CTRL_PAGE_SIZE;
> > 		dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> > 		length -=3D NVME_CTRL_PAGE_SIZE;
> > 		if (length <=3D 0)
> > 			break;
> > 		if (dma_len > 0)
> > 			continue;
> > 		if (unlikely(dma_len < 0))
> > 			goto bad_sgl;
> > 		sg =3D sg_next(sg);
> > 		dma_addr =3D sg_dma_address(sg);
> > 		dma_len =3D sg_dma_len(sg);
> >
> >
> > 		// XXX: Here get the following output, the region is inside bridge's
> > window 08000000-080fffff [size=3D1M]
> > 		/*
> >
> > # dmesg | grep " 80" | grep -v "  80"
> > [    0.000476] Console: colour dummy device 80x25
> > [   79.331766] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end addr
> > 80bc000
> > [   79.815469] lchen dma nvme_pci_setup_prps 708 addr 8088000, end addr
> > 8090000
> > [  111.562129] lchen dma nvme_pci_setup_prps 708 addr 8088000, end addr
> > 8090000
> > [  111.873690] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end addr
> > 80bc000
> > 			 * * */
> > 		printk("lchen dma %s %d addr %llx, end addr %llx", __func__,
> > __LINE__, dma_addr, dma_addr + dma_len);
> > 	}
> > done:
> > 	cmnd->dptr.prp1 =3D cpu_to_le64(sg_dma_address(iod->sg));
> > 	cmnd->dptr.prp2 =3D cpu_to_le64(iod->first_dma);
> > 	return BLK_STS_OK;
> > free_prps:
> > 	nvme_free_prps(dev, req);
> > 	return BLK_STS_RESOURCE;
> > bad_sgl:
> > 	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
> > 			"Invalid SGL for payload:%d nents:%d\n",
> > 			blk_rq_payload_bytes(req), iod->nents);
> > 	return BLK_STS_IOERR;
> > }
> >
> > Backtrace of this function:
> > # entries-in-buffer/entries-written: 1574/1574   #P:2
> > #
> > #                                _-----=3D> irqs-off
> > #                               / _----=3D> need-resched
> > #                              | / _---=3D> hardirq/softirq
> > #                              || / _--=3D> preempt-depth
> > #                              ||| /     delay
> > #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> > #              | |         |   ||||      |         |
> >     kworker/u4:0-7       [000] ...1    40.095494: nvme_queue_rq <-
> > blk_mq_dispatch_rq_list
> >     kworker/u4:0-7       [000] ...1    40.095503: <stack trace>
> >  =3D> nvme_queue_rq
> >  =3D> blk_mq_dispatch_rq_list
> >  =3D> __blk_mq_do_dispatch_sched
> >  =3D> __blk_mq_sched_dispatch_requests
> >  =3D> blk_mq_sched_dispatch_requests
> >  =3D> __blk_mq_run_hw_queue
> >  =3D> __blk_mq_delay_run_hw_queue
> >  =3D> blk_mq_run_hw_queue
> >  =3D> blk_mq_sched_insert_requests
> >  =3D> blk_mq_flush_plug_list
> >  =3D> blk_flush_plug_list
> >  =3D> blk_mq_submit_bio
> >  =3D> __submit_bio_noacct_mq
> >  =3D> submit_bio_noacct
> >  =3D> submit_bio
> >  =3D> submit_bh_wbc.constprop.0
> >  =3D> __block_write_full_page
> >  =3D> block_write_full_page
> >  =3D> blkdev_writepage
> >  =3D> __writepage
> >  =3D> write_cache_pages
> >  =3D> generic_writepages
> >  =3D> blkdev_writepages
> >  =3D> do_writepages
> >  =3D> __writeback_single_inode
> >  =3D> writeback_sb_inodes
> >  =3D> __writeback_inodes_wb
> >  =3D> wb_writeback
> >  =3D> wb_do_writeback
> >  =3D> wb_workfn
> >  =3D> process_one_work
> >  =3D> worker_thread
> >  =3D> kthread
> >  =3D> ret_from_fork
> >
> >
> > We don't have IOMMU and just have 1:1 mapping dma outbound.
> >
> >
> > Here is the whole dmesg output(without my debug log):
> > https://paste.debian.net/1217721/


From dmesg:


[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000001200000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001200000-0x00000000ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000001200000-0x00000000fffff=
fff]
[    0.000000] On node 0 totalpages: 1043968
[    0.000000]   DMA zone: 16312 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 1043968 pages, LIFO batch:63

I only has one zone: ZONE_DMA, and it includes all physical memory:

# cat /proc/iomem
01200000-ffffffff : System RAM
  01280000-01c3ffff : Kernel code
  01c40000-01ebffff : reserved
  01ec0000-0201ffff : Kernel data
  05280000-0528ffff : reserved
  62000000-65ffffff : reserved
  66186000-66786fff : reserved
  66787000-667c0fff : reserved
  667c3000-667c3fff : reserved
  667c4000-667c5fff : reserved
  667c6000-667c8fff : reserved
  667c9000-ffffffff : reserved
2000000000-2000000fff : cfg
2008000000-200bffffff : pcie-controller@2040000000
  2008000000-20081fffff : PCI Bus 0000:01
    2008000000-20080fffff : PCI Bus 0000:02
      2008000000-20080fffff : PCI Bus 0000:05
        2008000000-2008003fff : 0000:05:00.0
          2008000000-2008003fff : nvme
    2008100000-200817ffff : 0000:01:00.0



From nvme codes:

dev->iod_mempool =3D mempool_create_node(1, mempool_kmalloc,
						mempool_kfree,
						(void *) alloc_size,
						GFP_KERNEL, node);

So mempool here just uses kmalloc and GFP_KERNEL to get physical memory.=20

Does it mean that I should re-arrange zone_dma/zone_dma/zone_normal(like li=
mit zone_dma to mem region that doesn't include pcie mmio) to fix this prob=
lem?



> > Here is our dtsi: https://paste.debian.net/1217723/
> > >
> > > > 2. For <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>;
> > > > (which make nvme not timeout)
> > > >
> > > > Switch(bridge of nvme)'s resource window:
> > > > Memory behind bridge: Memory behind bridge: 00400000-004fffff [size=
=3D1M]
> > > >
> > > > 80d5000 and 80d5100 are not inside this range, so if nvme tries to
> > > > read 80d5000 and 80d5100 , ur won't happen.
> > > >
> > > > From /proc/iomen:
> > > > # cat /proc/iomem
> > > > 01200000-ffffffff : System RAM
> > > >   01280000-022affff : Kernel code
> > > >   022b0000-0295ffff : reserved
> > > >   02960000-040cffff : Kernel data
> > > >   05280000-0528ffff : reserved
> > > >   41cc0000-422c0fff : reserved
> > > >   422c1000-4232afff : reserved
> > > >   4232d000-667bbfff : reserved
> > > >   667bc000-667bcfff : reserved
> > > >   667bd000-667c0fff : reserved
> > > >   667c1000-ffffffff : reserved
> > > > 2000000000-2000000fff : cfg
> > > >
> > > > No one uses 0000000-1200000, so " Memory behind bridge: Memory
> > > > behind bridge: 00400000-004fffff [size=3D1M]" will never have any
> > > > problem(because 0x1200000 > 0x004fffff).
> > > >
> > > > Above answers the question in Subject, one question left: what's the
> > > > right way to resolve this problem? Use ranges property to configure
> > > > switch memory window indirectly(just what I did)? Or something else?
> > > >
> > > > I don't think changing range property is the right way: If my PCIe
> > > > topology becomes more complex and have more endpoints or switches,
> > > > maybe I have to reserve more MMIO through range property(please
> > > > correct me if I'm wrong), the end of switch's memory window may be
> > > > larger than 0x01200000. In case getting ur again,  I must reserve
> > > > more physical memory address for them(like change kernel start
> > > > address 0x01200000 to 0x02000000), which will make my visible dram
> > > > smaller(I have verified it with "free -m"), it is not acceptable.
> > >
> > > Right, I don't think changing the PCI ranges property is the right
> > > answer.  I think it's just a coincidence that moving the host bridge
> > > MMIO aperture happens to move it out of the way of the DMA to
> > > 0x080d5000.
> > >
> > > As far as I can tell, the PCI core and the nvme driver are doing the
> > > right things here, and the problem is something behind the DMA API.
> > >
> > > I think there should be something that removes the MMIO aperture bus
> > > addresses, i.e., 0x08000000-0x0bffffff in the timeout case, from the
> > > pool of memory available for DMA buffers.
> > >
> > > The MMIO aperture bus addresses in the non-timeout case,
> > > 0x00400000-0x083fffff, are not included in the 0x01200000-0xffffffff
> > > System RAM area, which would explain why a DMA buffer would never
> > > overlap with it.
> > >
> > > Bjorn
> >
> > Regards,
> > Li
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
