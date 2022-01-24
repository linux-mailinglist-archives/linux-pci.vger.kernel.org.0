Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89A14986BF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiAXR2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 12:28:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13168 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235748AbiAXR2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 12:28:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OF2FSg008652;
        Mon, 24 Jan 2022 09:28:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=aut1IbWAix1/ZpQ3Rjx6YdoQMAE19cPSj/NhYIf4e6E=;
 b=Koh/wHc5bZ5Tfmmbu+ye12i8e9q3fOxvIDit5ABbUQIJe7x4T2T/Bjr6pcWpkG0HGEHW
 uEjM30rlXfx3u5XFnkeEE6dIe8UlYMozlfxgApKmVSNagVzNXA7jdn3srEsq80BManLz
 IwuMzxir+Zigr7rw/N9sIwXbdp8cH6w6hpNkjmtjak2wYYyOa2DL24VhCMCpRdvKEUwo
 RKvgIWcopXeuaDs1Vre9yznwC8VvH16hiryvPHbG42qyAqhOjAZfH/u9/JiIiuVMpx6y
 kPJyo6EEv4UDRNPmw+894f6LvXl9ITb17dgQRE/wv11EN26G+/Sf/281mc4B4FdUo5yB PA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dsxdcgjd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 09:28:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlgqWJe36ZOLsl3pZX0tN/Fxbl+88UtSNjh6oGLEzpOtI0TK343ROqV2MRA0TcYPuiNPvnVNNx8rp6LCr3v6ESrJyCqm+fM/s51e5Zb6pnDiDr6GpJ3kvSCb9SB3cZ0+58qKmRF3MoT4i6hJotg4CMj6cvjDBpSwewL7MlM6+lfD9mUuKteXR6CEOlb+WJQjH3qvXNd1GtISgCS5Lv4NHontMZm1bueg55cUlCEltNeXfq6rHSLemafWM7qqsJ9ESS5yeZODbVb+ALxAV2o1bqoveLPd/ZeBCchh0+zFF+8gLfn1gZxGU0/mIG7zesTUsMJo44jcDBCtGLqsIZFvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aut1IbWAix1/ZpQ3Rjx6YdoQMAE19cPSj/NhYIf4e6E=;
 b=iJgJqOUubq6JGpNgxVrRK3VQkD5k4xjstz1865icZg0crFvQIs6wZivwuj7zjTZcsBzHBtTk6GJ7W7MEz9eHX/WfIBSpBPrGnccCkmlfH8E8f36gpQO9+N25YmniwhAE0byeV0SjvJ/BSPvbEcR3Se714DRwYZCzVaGj0x927vLMGnPZXAEDaY1GKI4eqS0HDK/b9XpcQ8UxwVQ3O63vM2JufJI8LfwXY9Ib4KDsaW1PYXEsAjzTREiz6fk4zmKOEhemFZydsjVyq0/WzN96IShPT9e5egabqxABQmEX5Pj5lnSm3HNa1Hmjza/Ust3nVwx5if1BCDvSDkB6R24Luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aut1IbWAix1/ZpQ3Rjx6YdoQMAE19cPSj/NhYIf4e6E=;
 b=fp+FqSNNkiuKFSQ/csSMyp5pL84bDAyZZfWtAB95D8ZEfSLEmctnXmYfwK5vk2/LiIdxZPfcWpCniTQZpHH/0TJeHym/OARQ3lbdd23+sA7UXZurZ8mBYdAaP6zvgHgzzK1FuNET34caMNy1W9Vjm4Bl4PZtgqUWI8zBcceG0BM=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by SA0PR07MB7674.namprd07.prod.outlook.com (2603:10b6:806:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Mon, 24 Jan
 2022 17:28:05 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::907b:2b5d:7de:ea15]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::907b:2b5d:7de:ea15%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:28:05 +0000
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
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFwA1O41wACEoNOAAHaA/QAB4hGrAABB8shA=
Date:   Mon, 24 Jan 2022 17:28:05 +0000
Message-ID: <MN2PR07MB62086105FD43BD7330E3D38BA15E9@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
 <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
 <PH7PR19MB55625B4733F2F45133AA4EACA05B9@PH7PR19MB5562.namprd19.prod.outlook.com>
 <BN8PR07MB6195FAE77802B3B04DE87C71A15B9@BN8PR07MB6195.namprd07.prod.outlook.com>
 <PH7PR19MB55625AD720072882D03B5E51A05E9@PH7PR19MB5562.namprd19.prod.outlook.com>
In-Reply-To: <PH7PR19MB55625AD720072882D03B5E51A05E9@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWZiYTU1NTBlLTdkM2EtMTFlYy04OTY2LTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFxmYmE1NTUwZi03ZDNhLTExZWMtODk2Ni01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjYxNzgiIHQ9IjEzMjg3NTE4ODgzNTYxNDc4NSIgaD0icEtkbmh5S2dmc296SGd3V0cxZmcvOUk0dVlBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce283bb9-13c3-43b3-48b2-08d9df5ee1c6
x-ms-traffictypediagnostic: SA0PR07MB7674:EE_
x-microsoft-antispam-prvs: <SA0PR07MB767461D59E956B0D8CC0FF92A15E9@SA0PR07MB7674.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWies7AABSaF0p634C8oZrKVZArM1imXD7mZXGgn6VXz9N3MW0/N/ZMir1IniUVblnYwPTFR0nSyv1OKmJednM+W7mEmNMAiEzrVT2v8ehkfUyEpkeoCvLKyvWeUY0SUWiboUkJLdPPiWMYbthGgbnUK/4+UERySPRAT7GH6EN6vHWAEk4EsVk76o0Mu2R5E2WF/e+eBxwySk+4RUijsLk6VeYQEhFMGds9bP1PxqcpQt/tjB0aFxMV0ODieeJoxSFr7mRQqQ0RM1u20ME0/XaNwOfAyO7RvwLsMjglO7vr29jNlqT61AvaC2espkQPJ7qUcGCNLmldd4Uh6G+HTYFBfkVIeP/GXCfYdadImY5SMzRKJsiJTEBdNyWtYCoHnOLD8Q8P3nzf3l2UEKFJuLMLWisUZKxRI1K8NOTZV2xAbmmJ22oK/4n617tJB0RYREc8G6fUDL3iPd2tJ2WhTEMoQTe5gNPG7PfBN3PfZOb6rkVBq0KEt4HPO+CXWZYfV78hdgPGmZSiRwpqWSroS2vdH9zf59/3cRGloB1XbWNJDOSwouhV+nJNw6Uc+rLbQfsAv95uL+GamElXf8OsSfcGb+1vW9ssaBHFppBEa4Y3MyJE6m35CIwzonvrBe50iq/1mbQ0NhCnjgRMGEfrYz/m1hlqWRALKlqlCd5eRUjOB48xnOCFOK1Eew4TqkQvAcbK/+x1nMxFw8y0Ez30jcVZE1apAgbrNRR4ySNRU063OQ08jNtHODCiYvRyCTMno06AO3b5juoQmpAETW3ZNKpmFnuRFZemZx8ELz+ocwN49LZpVcpViGpvt6JYXNDeYO4gtQoDcoS3JAtZ9IfolvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(66946007)(86362001)(66556008)(55016003)(53546011)(83380400001)(66476007)(9686003)(64756008)(5660300002)(4326008)(316002)(66446008)(52536014)(26005)(2906002)(6506007)(966005)(8936002)(76116006)(8676002)(38100700002)(38070700005)(66574015)(508600001)(33656002)(45080400002)(71200400001)(186003)(54906003)(122000001)(7696005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?CRLa9SMu9SNkIghqJdaxk+vBFzr4PAsdIM1JhJlkhzzQ2T1ukyeBQpg8ww?=
 =?iso-8859-2?Q?l4EKkUB/wFagLvvNjJemaH3bBrxYm4i5n2+EjVPerjdVFSPXzYoGFgnFgE?=
 =?iso-8859-2?Q?vYlRc+VBWxb/k0pLlcmNn0CJoq7k9acrLW8YHm1vxQUp9/mUvbF1hI50OK?=
 =?iso-8859-2?Q?JHxrmlu3iATd9RrXQDaX7zRKW9VSw/+Rbm2k9Z8lRPMHZ1WzVV0RJRStjp?=
 =?iso-8859-2?Q?R4CQjRJAOy60qwzoh2d6hsEZSmAgsxwwXvHyYf2KEAmo/ZXPCO51cHn/mN?=
 =?iso-8859-2?Q?ZlpZurbclGodwlyh0OuuOhe7cz3vvnsjjGB5u68VaKYhgxpcqsCeMVBdko?=
 =?iso-8859-2?Q?5OET7jqbiySiK5cpAiTO216A+3Bn/yLfIXkvV4EbtkuP9TGLin5eNII96X?=
 =?iso-8859-2?Q?5BxsG9+OgJg4KzEJMOa1/EfW/cLHzxHwkR15wxptICEUieixG+JqW0nClH?=
 =?iso-8859-2?Q?W50GEf6gq4VG6Dy5DlpY3tXeF3Q0/FRyDsrWalvFV77tdCVXu6xBhLEYEI?=
 =?iso-8859-2?Q?F5/XthkojoDnPc8Qsit6hJChe8CramoaMZ5pG5VUn3TCIL/KOmW37GjaR/?=
 =?iso-8859-2?Q?n/QL42v9tm+yBV09T44WHayGvNZGJ1veg1q/f8H65A2oPM//jDthpCa113?=
 =?iso-8859-2?Q?SWV8oCQO+VQ9fjvzLZ8ldRAMxu/8AZgjUm6fb9aiNwyr3ZvgW+d2IchbVC?=
 =?iso-8859-2?Q?BCx+gOEW94zAMKlEoRCJvk9Itgqj4iqK3eql+aRpTUdfCPe/KSyBfulsWw?=
 =?iso-8859-2?Q?YOeSIOunJHwPneTBVmQy09s6A742yYqP/NRkx+xuiallgiRzFdDqktYVAC?=
 =?iso-8859-2?Q?F10AEDY9aAnH88MZbfCbIUTZXawAlYNdtRsxbOgPe1sNuJ/7ldJ9JHiIlE?=
 =?iso-8859-2?Q?60MHn7dV97XJkA/jwx8+YVUzV4RzUy9t1NzgBMwDD9K90vA8rFPh+dXSA/?=
 =?iso-8859-2?Q?DNYMlvlt6TDLfGJnExcS9QFEW1QSDFM/3iMkqIhPo7DqFzI6q2MjKz15GC?=
 =?iso-8859-2?Q?R8W9p0chgAEb0kmGa+KmP/V9xoszVyGA3UECF4BVtLyrnwLrC06RB8o5j1?=
 =?iso-8859-2?Q?Mb4wtg29F9rtU53OcZkXObprtCGDkJxPs9A9UYN1PMg07jlwPWAhBgGGiq?=
 =?iso-8859-2?Q?XAd6d+obykqeu0R+Zx/slPtmT0Wr1+PpaWJgK6YfiMCGY/XwcyTZ+7+aU1?=
 =?iso-8859-2?Q?s2tE8lwXSDNEaMfu5ugh5VDjsil04bDJIB7m16WtyXqypGYOHaQZ9AmHDl?=
 =?iso-8859-2?Q?g+a99+NuohD8lajgTrFINTk51iYWo6vvZXFdl4stQsfC+MI5BSJjKI/7I6?=
 =?iso-8859-2?Q?UimJMI+vXwz9fkRShrJZuqzu65pbFoXAujQPueHpwR2OrMZgzQ2Cs52hzI?=
 =?iso-8859-2?Q?Klyc0mUmI6LjQpsktsOoah5GS9qEPT9zfzol67v8FTBDpftjr4olF66knO?=
 =?iso-8859-2?Q?rYBg+lYUrsy9t+ASnj87SLVx0LNt2ThE6Yt41/CFfRi0xBlAv8Gwpp3tYp?=
 =?iso-8859-2?Q?bqNY8Z7Y93lRPDz58nro8iVCsLXnZHr6AGBn9osKDDWYYXE7QxRgEsrLHh?=
 =?iso-8859-2?Q?M6UytnoQZiJS95JQ21ghqOZWAyR7zfcofwPB4lcb7nufXfjHFaO7PxU8Cb?=
 =?iso-8859-2?Q?PGShoTo1wpoJsLiCY4CVvrEtNqeYIDoJG8M6ak6/qNJi6JEujnxTPJR9c5?=
 =?iso-8859-2?Q?sujWRMz+joaTPNfJ1bKnrAQYL0LgK99aioaP0uCjTEmVa5ODUVgTiT2a2Q?=
 =?iso-8859-2?Q?JUwg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce283bb9-13c3-43b3-48b2-08d9df5ee1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 17:28:05.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ44VcF/rPOlqvYucD3hSz+2WzckIAW3UQZGlTpWH+Td2mb7hgLQtq/GSs/AoqVwUjmMJKBhQcEgIVRk6DvonqVoud/qDc6RW9gRQyAjWL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7674
X-Proofpoint-GUID: lvvJyTAcKwJlxOOmJ6WA1VyecnT_hOlG
X-Proofpoint-ORIG-GUID: lvvJyTAcKwJlxOOmJ6WA1VyecnT_hOlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=947 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240116
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Li,

> -----Original Message-----
> From: Li Chen <lchen@ambarella.com>
> Sent: 24 January 2022 02:26
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
> > Sent: Saturday, January 22, 2022 2:09 AM
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
> > > -----Original Message-----
> > > From: Li Chen <lchen@ambarella.com>
> > > Sent: 21 January 2022 02:56
> > > To: Tom Joseph <tjoseph@cadence.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring
> > > <robh@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Bjorn Helga=
as
> > > <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for
> is_64bits in
> > > pcie-cadence-ep.c?
> > >
> > > EXTERNAL MAIL
> > >
> > >
> > > Hi, Tom
> > >
> > > > -----Original Message-----
> > > > From: Tom Joseph [mailto:tjoseph@cadence.com]
> > > > Sent: Thursday, January 20, 2022 9:11 PM
> > > > To: Li Chen
> > > > Cc: Lorenzo Pieralisi; Rob Herring; Krzysztof Wilczy=F1ski; Bjorn H=
elgaas;
> linux-
> > > > pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: [EXT] RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for
> > > is_64bits
> > > > in pcie-cadence-ep.c?
> > > >
> > > > Hi Li,
> > > >
> > > >  For 64_bits ,  all the odd bars (BAR1, 3 ,5) will be disabled ( so=
 as to use
> as
> > > upper
> > > > bits).
> > >
> > > Yes, I get it.
> > > > I see that the code is assuming 32_bits if size < 2G , so all bars =
could be
> > > enabled.
> > > >
> > >
> > > Ok, but I still wonder why 2G instead of other sizes like 1G or 512M?=
 IMO
> if
> > > there is no obvious limitation, 64 or 32 bit should be left to the us=
er to
> > > decide(like bar_fixed_64bit and bar_fixed_size in pci_epc_features),
> instead
> > > of hardcode 2G here.
> >
> > Check for 2G is important as this is the max valid aperture size encodi=
ng
> (0x11000)
> > allowed by the controller for 32 bit BARs.
>=20
> Thanks, I get it now, and also find it in 7.3.1.50. Physical Function BAR
> Configuration Register 0 just now.
> >
> > >
> > > > As I understand, you have a use case where you want to set the bar =
as
> 64
> > > bit,
> > > > actually use small size.
> > > > Is it possible to describe bit more about this use case (just curio=
us)?
> > >
> > > It's because our SoC use 0-64G AMBA address space for our dram(system
> > > memory), so if I want to use 32 bit bar like 16M bus address, I must
> reserve
> > > this 16M area with kernel's reserve-memory, otherwise endpoints like
> nvme
> > > will report unsupported request when it do dma and the dma address is
> also
> > > located under this 16M area. More details have been put in this threa=
d:
> > >
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/CH2PR19MB4024
> > >
> 5BF88CF2F7210DCB1AA4A0669@CH2PR19MB4024.namprd19.prod.outlook.c
> > >
> om/T/*m0dd09b7e6f868b9692185ec57c1986b3c786e8d3__;Iw!!EHscmS1ygiU
> > > 1lA!SVgmPO0MrmUUnZzlmc-fCPsSBddkfUgT-
> > > Y7EmlLAgz9AoQSVZXa_18TIdT6O7kY$
> > >
> > >
> > > So, if I don't want to reserve much memory for BAR, I have to use 64-=
bit
> bar,
> > > and it must be prefetch 64 bit, not non-prefetch in my case, because =
my
> > > virtual p2p bridge has three windows: io, mem(32bit), prefetch mem(64
> bit,
> > > because CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS is set),
> and
> > > if the controller running under ep-mode use 64 non-prefetch, this reg=
ion
> will
> > > fallback to bridge's 32-bit mem window but I don't(and cannot) reserv=
e
> so
> > > much 32bit memory for it).
> > >
> > Got your point. Does a change in the code as below will be good enough =
?
> >
> > - bool is_64bits =3D sz > SZ_2G;
> > +bool is_64bits =3D (sz > SZ_2G) ||(!!( flags &
> > PCI_BASE_ADDRESS_MEM_TYPE_64)) ;
>=20
> Before answering this question, I want to raise another question, why bar=
 1
> cannot be 64 bit?
> 		bool is_prefetch =3D !!(flags &
> PCI_BASE_ADDRESS_MEM_PREFETCH);
> 		bool is_64bits =3D sz > SZ_2G;
>=20
> 		if (is_64bits && (bar & 1))
> 			return -EINVAL;
> I would be very grateful if you can tell me.
>=20

As mentioned earlier,  if the user indicate a 64_bit bar aperture (with the=
 encoding) ,=20
all the odd bars will be used up. User should then be denied to program odd=
 bars.
The above check is not only for bar 1 , but for all odd bars.
This check is important, hence below change list doesn't look agreeable.

> I don't know the answer and will this change break something of bar 1, so=
 my
> current way to handle this issue is:
>=20
> PCI: cadence: respect 64bti when size is smaller than 2G
>=20
> Original codes force size under 2G to be 32 bit somehow.
> Signed-off-by: Li Chen <lchen@ambarella.com>
>=20
> 1 file changed, 2 insertions(+)
> drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 ++
>=20
> modified   drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -107,6 +107,8 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc,
> u8 fn, u8 vfn,
>  		if (is_64bits && !(flags &
> PCI_BASE_ADDRESS_MEM_TYPE_64))
>  			epf_bar->flags |=3D
> PCI_BASE_ADDRESS_MEM_TYPE_64;
>=20
> +		is_64bits =3D epf_bar->flags &
> PCI_BASE_ADDRESS_MEM_TYPE_64;
> +
>  		if (is_64bits && is_prefetch)
>  			ctrl =3D
> CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
>  		else if (is_prefetch)
> >
> >

Thanks,
Tom
