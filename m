Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CB4964CA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbiAUSJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 13:09:08 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:14968 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230223AbiAUSJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 13:09:07 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LE279s031136;
        Fri, 21 Jan 2022 10:08:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=sHCVFpjnQISTvExtdwP4U59gGPgNsukQU2YMPOmd5EA=;
 b=tYeGA4xpTQk+5ttMw1igCGuv8xnhtSZF3QiTXJ78Kik4v1TI60z+uVzFRrLsanTioAqg
 NP7Pe+dHqArZq/mwtydgmGSjEFIIJKu6GRm0eNIiveCAueVL850wpmNmD/lxRGx1CvG/
 eC3xlxlcBW1PlNqyO+deNac1vYQ15x5dM0VKpiUTU4zLk0PhFAUhBRtzJs/tJSCHwYxR
 TuaUqYpvbonAFg/uSvPEPsht348t/6j8P5KUpaOgaPhTttDIeA56uxP2JtAbNVAL16jK
 GYw9pj7TziHI+RCo3J9eXQwYiH0bu4lBiH2vlWxKJl25KKhWh1JYfKzEKMguDwSPjZbU iQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dqhycu28q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 10:08:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYrd1hOIc6Fta7Pnw4iu7rQiuNprck5MbBQ2cOSUBhmc+LcZ3ALnKZFyiwS2pmR+ysjZu/ie66hvwgiP5J2/Z615eqM87O2DAcEtpSWgkca6ato3Bxg0TndtRsI7dtJjD8mGzGKfSI5pNnYA/nnyeN0q0xYCP0CtETH9QaYvFqaKrUg4sKXhVvPvmk8DNcHAVgi0+JpgISwCwq61VPYbml/pvh8AoiuhmfkcWAW6N4O265QgqQVzW0Bkz3lsff0lYvUNp9Rh0Av+pU3fIvl9SaF4EJHjtbPfQjbYlWIm3z23ahnjDysGVSlP/OaV7+L/eKySkZetiKWSCGDhL+6quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHCVFpjnQISTvExtdwP4U59gGPgNsukQU2YMPOmd5EA=;
 b=mqpgebFFMvFrZosEzqf+k6XybX9ZixDnJqcmWNkbk5gJDTpOgSqQkcI6CJBPIzUR76+yTT4MW8w6rUDpITyOMR0bcfcEUh/t0rqrgIrVow/n6EXk3mQyH6hXhJpG3sJl9UdEXspoYSrr48GVudqAIYLG+GzpyLtXEMAzFDAHjr0WWhTtHXbHL3qhDvt41e9suQGC4CuR2/7jPitaCyACynjWXyQmx8dw6DJ40i4DbBFZXbvPSItyuVt36XBdrYvhT7TveT/J+GFQM4qrWTiPPThbfha4xAw37g8S8G5bxw3OrvfrIAdZS3CpFEJhyBrFnXj1afGSeZ4PayEFyqTS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHCVFpjnQISTvExtdwP4U59gGPgNsukQU2YMPOmd5EA=;
 b=j3sfWnjJ1GwHDedNnP7E5toQj+wivRdH86NQkK4CoCAcykiXFI10l+V4dYjjIK72kvD/0lPqVaDHU4HUU578bpHPD3m7Xa/Wyl3ns2w/SAcPIdysprTbkUgjJ977ozKQ5gR2BzD4Tc5mUy6wBYAL5flTY0UPantUfEqaunZyjy4=
Received: from BN8PR07MB6195.namprd07.prod.outlook.com (2603:10b6:408:b7::21)
 by BN8PR07MB6338.namprd07.prod.outlook.com (2603:10b6:408:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 18:08:47 +0000
Received: from BN8PR07MB6195.namprd07.prod.outlook.com
 ([fe80::545a:1c2c:24fc:6025]) by BN8PR07MB6195.namprd07.prod.outlook.com
 ([fe80::545a:1c2c:24fc:6025%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 18:08:47 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Li Chen <lchen@ambarella.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
 pcie-cadence-ep.c?
Thread-Topic: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
 pcie-cadence-ep.c?
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFwA1O41wACEoNOAAHaA/QA==
Date:   Fri, 21 Jan 2022 18:08:47 +0000
Message-ID: <BN8PR07MB6195FAE77802B3B04DE87C71A15B9@BN8PR07MB6195.namprd07.prod.outlook.com>
References: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
 <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
 <PH7PR19MB55625B4733F2F45133AA4EACA05B9@PH7PR19MB5562.namprd19.prod.outlook.com>
In-Reply-To: <PH7PR19MB55625B4733F2F45133AA4EACA05B9@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTJjY2E5YzBhLTdhZTUtMTFlYy04OTY2LTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFwyY2NhOWMwYi03YWU1LTExZWMtODk2Ni01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjMyNjAiIHQ9IjEzMjg3MjYyMTI2OTY4NjQ4MSIgaD0iL2tiMWlMdkJUNTBvK0g5clpUVjRYZU41OGl3PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd39d173-75df-4039-3da2-08d9dd0911ef
x-ms-traffictypediagnostic: BN8PR07MB6338:EE_
x-microsoft-antispam-prvs: <BN8PR07MB6338EB5498EF0D4E3AC8F3EDA15B9@BN8PR07MB6338.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Y3aPKvXBpHelL/y1M8QGVwQf/Fm4ONutgwRMWbf8YDDe0IkeNSodcRW04pI3aXFxJmtqZYg6JIshsxQW4Zv5rq6FARLk9/aymy1G7Ut4+nM4B6yb9OHgJ4Omnx1B46wVH4I9n6IlJ2MWj/z10SD8G/EvJ20GDBev6Lk548pOBe5UWs2t7xjt9BI3+n5NeIuctinwXRlGzYaQpw+kOdhm/T7+1vPoZWXY27LI5dvk9S6/IhKrmmwY23WTn0TlEjMCgAuSoo88WbDcHKqaHafzzEFDDNBtCJiaqLWs30XdTvxAimwhAaGGUEAol0XQkQWT8Ujo5H2QQGjAVMD/yJ8Q7RWmRswQB9tTJkdYjxq43wnuMgnrXG/C8oNqcOVILRpL0hyxabeFzyph5M6/ftTpkzYagHSHSIq/WYnMn9XpT3NcdKRiAK9F+3GCaNWVvgJ2pK08zHMo9404quSvt/GVsuq/XYcUjYd0ZJDh1tUoUH0VAM2kjBkyqVt13qHkLWYgGYdC5orQx7XieoAdaA83VsOybwiFdaGx4y57qFU3KtN2Dpd1yXVPu8YdBvFqyBmcuPfyXnW4/tuwuJZTCXei+H/G0CrfBhPQvmfV/4y7NmJ2/7J+I+GWYedEbcw/J/Bg+1tIHF3FOC6c1YXZDz+JEfza4QVVfZZHYt4YtrgcoxS3q4ZnWAoNQJnpTqRj6Fi9+t0wnf/tg5BYJ4CHwA5AOThrIy9an2tMKA2BUhxw9YUD4cdmVl4YGjYRmuTsDLGrUC6gHONTz4hNy2hZWijZId8SsdroKxa+UxQcxa1klSvKKxD8DoPDA13JGuC1s/Pxl0ypedGwf26naQ7CDBG6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR07MB6195.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(9686003)(76116006)(66946007)(33656002)(83380400001)(122000001)(8936002)(66446008)(64756008)(66476007)(66556008)(54906003)(316002)(8676002)(6916009)(5660300002)(66574015)(71200400001)(966005)(45080400002)(52536014)(2906002)(26005)(186003)(7696005)(38100700002)(53546011)(4326008)(55016003)(6506007)(38070700005)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?5OQoxwG1Xnks4+dzjC5iO/rkkH6Z1XO5ZcGJMiER8kPjzdSVE81WjgAGPe?=
 =?iso-8859-2?Q?y94WQ7DgogUy1AWt91VCfEzPls6xhfYgP0v9AK7JanApfgvAY4P8bQKYJt?=
 =?iso-8859-2?Q?yPRdWQCcTWRTFGbnH+7TFSiyc3Vr2T6pmYPlViVwMbZdwlR6J6eJlwFl04?=
 =?iso-8859-2?Q?oe2v7HBSnLwSTrUNYOmSGj7+tfyoaQ96H3+H/quJkxFQwwF6YdzYhM6Dn1?=
 =?iso-8859-2?Q?fLUX0i+RBvCQW8Ohb8sTdbQML9/JBBA55PXshRSRFPd/mkhPpmSDpnxGUz?=
 =?iso-8859-2?Q?Tu2Ru2rdqJT0STn9UUWnVFc263mHFMmxi2G/ZcfHtw4Eiz9z50mGdYMHLX?=
 =?iso-8859-2?Q?kGz1wUdbDjgjG5HBNfCUM1Zmhg6r/s82tafWW5cFE2cF93DbF62Pl+T9yb?=
 =?iso-8859-2?Q?taLSf+AJNow7MhStAUb1tMz3n1+5Qw2DFryMxjXTEfl8KpfVNQupWrtl6v?=
 =?iso-8859-2?Q?wYE0VUlHedDUtEuhX9MPyieVeaNyg+hDdcI3UAm550wTAy82ImMlt4jCSW?=
 =?iso-8859-2?Q?w4b3ERvIi6a9joXifEH19MsVMTYAaSKqDYaoVcxzjm3hQIvmyVhgy+zdMM?=
 =?iso-8859-2?Q?sb6YZ1DASP2VcQIso7TsPJvwQuhnE0HiFxW6QDDR9YdhkFXMCUIZD1Stx3?=
 =?iso-8859-2?Q?awudLrDSENtt0ShqgxePYRnWRTyFbiX+p0XRMYF4eE8W5tBuuoUwj33e7H?=
 =?iso-8859-2?Q?SeokTbD4tMUGl8lTBHa9SfPvvvd9Uh2nubYWpixw0jy2nDunaZbIk6gbPy?=
 =?iso-8859-2?Q?muAZ2DJiCRXm6shkAnVlBKRApW6sdDCdEReMZKzWO9WerKSxA0+klGrIVM?=
 =?iso-8859-2?Q?zs+uvD7pmE7/dnDwScIsgAK/jTFZ4S/kVRER98DSurSFfN9rtBYssXBqFb?=
 =?iso-8859-2?Q?0gw02tyd2IlpE2zRFt8x+rwOdZ9CWPK/ivelRK/6OfN7PFQbr3QSCZyTDK?=
 =?iso-8859-2?Q?z3/XoQJn/0QBte4TEpZg685I26Z0vXkfN0pyZgV+AMaKe92PjwbmeGbc2C?=
 =?iso-8859-2?Q?5Fdim/RXY000riMSc8vjsXqmlDa/0F+cAsXtL5BOz8lUsAw32/nA4sleqx?=
 =?iso-8859-2?Q?2PioGYSkJx4aaIgG2q3mt41AxK0pf0JJjGMeeovBb/BfGfvToFRFhulukI?=
 =?iso-8859-2?Q?YMdFtHhLt6s4JzBicra2MqSX2Sn+Kz5oVPajdRJZOQPf9YkhwhcYXgbl8t?=
 =?iso-8859-2?Q?2Ay6IjQP0cBY9gCi8vFuXjApewnTmXHH4b3BRW6pUKX+uKLcwnNwaK3IKq?=
 =?iso-8859-2?Q?nXCWJp80k1OPYluEjHrrPtursZOysqGe5ExqaijgG9Q8JYInDw2QGzlBDW?=
 =?iso-8859-2?Q?xfc94EwzjX8/w/2m3TdFkS1BUbesdavi5NcnNs80qZ6eMDpXQC/ttQ+snF?=
 =?iso-8859-2?Q?j3IhNhKlOnjSeTh/PLcrbTVk7dU/GeoFPewo6Ld3Xt5WFQ8Fre5wfrxOv2?=
 =?iso-8859-2?Q?7jGq/Aq4vAeBzNukhyT143Ebc1C7XOKckGT5LKlXrU3S8vVXW/u+RPv4+M?=
 =?iso-8859-2?Q?4Sc3bWhdBRoqZwdDGBPjamdJETNDFrVkEWR/vOc2wb9+aAHkpdcZmodc8e?=
 =?iso-8859-2?Q?+8C9C0nLEPcIJJaqHQFlb7HGFgUISinGYhnVYh2M+NkUiEabQkcBMxcsVH?=
 =?iso-8859-2?Q?PtN3bbarSAXHqmN3l7m5C+GOkMySf5OjhaHu80zdAfD0gyYtbQFfit/Jlu?=
 =?iso-8859-2?Q?fb1DdJnSOLK2PPOh3NSUsjcsCoYCCchvBJC8Rg/WkCcTkUJs0Eqv5ohCid?=
 =?iso-8859-2?Q?onsQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR07MB6195.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd39d173-75df-4039-3da2-08d9dd0911ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 18:08:47.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMzR1wqt6+84O2dbpV6Qjtbfu+s1eDPNb0jHMv32kkmacu9vzpEx0D4W4t6IR7qxbMwCYtiw/BQk1eKN+yO7S8WtsO6OnJ82oGz7/abd4q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6338
X-Proofpoint-GUID: hBIXrqFvzCo_NCUS5yvFsyNeF49ehwJa
X-Proofpoint-ORIG-GUID: hBIXrqFvzCo_NCUS5yvFsyNeF49ehwJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxlogscore=569 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210119
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Li,

> -----Original Message-----
> From: Li Chen <lchen@ambarella.com>
> Sent: 21 January 2022 02:56
> To: Tom Joseph <tjoseph@cadence.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits i=
n
> pcie-cadence-ep.c?
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi, Tom
>=20
> > -----Original Message-----
> > From: Tom Joseph [mailto:tjoseph@cadence.com]
> > Sent: Thursday, January 20, 2022 9:11 PM
> > To: Li Chen
> > Cc: Lorenzo Pieralisi; Rob Herring; Krzysztof Wilczy=F1ski; Bjorn Helga=
as; linux-
> > pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [EXT] RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for
> is_64bits
> > in pcie-cadence-ep.c?
> >
> > Hi Li,
> >
> >  For 64_bits ,  all the odd bars (BAR1, 3 ,5) will be disabled ( so as =
to use as
> upper
> > bits).
>=20
> Yes, I get it.
> > I see that the code is assuming 32_bits if size < 2G , so all bars coul=
d be
> enabled.
> >
>=20
> Ok, but I still wonder why 2G instead of other sizes like 1G or 512M? IMO=
 if
> there is no obvious limitation, 64 or 32 bit should be left to the user t=
o
> decide(like bar_fixed_64bit and bar_fixed_size in pci_epc_features), inst=
ead
> of hardcode 2G here.

Check for 2G is important as this is the max valid aperture size encoding (=
0x11000)
allowed by the controller for 32 bit BARs.

>=20
> > As I understand, you have a use case where you want to set the bar as 6=
4
> bit,
> > actually use small size.
> > Is it possible to describe bit more about this use case (just curious)?
>=20
> It's because our SoC use 0-64G AMBA address space for our dram(system
> memory), so if I want to use 32 bit bar like 16M bus address, I must rese=
rve
> this 16M area with kernel's reserve-memory, otherwise endpoints like nvme
> will report unsupported request when it do dma and the dma address is als=
o
> located under this 16M area. More details have been put in this thread:
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/CH2PR19MB4024
> 5BF88CF2F7210DCB1AA4A0669@CH2PR19MB4024.namprd19.prod.outlook.c
> om/T/*m0dd09b7e6f868b9692185ec57c1986b3c786e8d3__;Iw!!EHscmS1ygiU
> 1lA!SVgmPO0MrmUUnZzlmc-fCPsSBddkfUgT-
> Y7EmlLAgz9AoQSVZXa_18TIdT6O7kY$
>=20
>=20
> So, if I don't want to reserve much memory for BAR, I have to use 64-bit =
bar,
> and it must be prefetch 64 bit, not non-prefetch in my case, because my
> virtual p2p bridge has three windows: io, mem(32bit), prefetch mem(64 bit=
,
> because CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS is set), and
> if the controller running under ep-mode use 64 non-prefetch, this region =
will
> fallback to bridge's 32-bit mem window but I don't(and cannot) reserve so
> much 32bit memory for it).
>=20
Got your point. Does a change in the code as below will be good enough ?

- bool is_64bits =3D sz > SZ_2G;=20
+bool is_64bits =3D (sz > SZ_2G) ||(!!( flags &  PCI_BASE_ADDRESS_MEM_TYPE_=
64)) ;


Thanks,
Tom
