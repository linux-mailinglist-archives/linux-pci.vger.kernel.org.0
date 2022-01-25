Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639F849AB06
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 05:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388236AbiAYECI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 23:02:08 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:8904 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1324972AbiAYDff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 22:35:35 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20P2RDRk031323;
        Tue, 25 Jan 2022 03:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=WENiS+4RYI9qioU21RgZItvJOzkvpliP3RZn6CbJewk=;
 b=u/T2u+nZ3vDUZGuyLhmMScjDl638C/AG9uTdNZeelxEwAiQnkQgRZOxkwcbKny9s/5fV
 RoFKwVvUYJzx4lo2Hh9+JzXiTVp16Hj4LW2ObL6uLbiJftKmAKwLC+lieKYvoTUVy0nN
 UU6gbwXDJU4fMmAmHTDlJ6jXzF+j2mKl6xhgShrtzQGNMUmy+vXxj8lh5egbxcqHEFEB
 ZMVt1nAY3zf7JTZKULEwGcFI4ZqUis6oAgEh5hFePzwGwow6osZF3ByWYpDjZCqjWm5H
 cn4oTG+n0Lo68ncJwpR8JfIKWxqXXl7AN+PEKSDIlh1pD0bdMo8qzAGwyRKlSBIJ1Hzc /A== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dsrsf0b1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 03:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf9CduanM+/TCCtLaw7DU6BW8pcLSRH/hxuMJGlmCMbNLpdLXFAQ6i01DAxzJld+Ol6ZhX1x4022EGxaw57KkRICeNPsZxPEXATrSYVKc3BAWzptRQRsKuzy7jqQ36puCSrZV3UUP+tLAgKy7PhTayTv6+XLZtXMkN8UJJfBS9Dq+BlSo1Si2SiW/iOj8/HZ64Pvht7yU/2Rs9IDRgoP1mDCEBJMYm0Yi7IVb/q1D/fWvfKigzXfaT0wD7DjTkmm150uoQ/4vbDqxSQTNe8t1PMrELmIIaL+mnp4dx18i3FOrckn1M93OXIu9WhUGxk+LB+nzo2xRsVrbdPqfiRBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g82JqzPleBJNohDgseEVLynBFj5dQh2a7nvcI68sN34=;
 b=LvGOWgf6NN9CdGWoQ0NKIyYqFKIUhZgZ82YxffV0nwSSshWUW3hCS/0V7gq/VTG7qhRtnBzoo0fKrhquiOL3JUR2Z71gzQ9kfNDeCt/sQFqJ2XIfxVnBvT1InBOh1cb+Yg5xEToSg/Vom3nEXeDD3wiamCmAXbC8L+D1Db9LUi5M1y/fdS4/s4ZJeAZ4CfESJ56CIsmSJidYWezbfTPw4b+HlypRz6mRxFssnyKWBuK2Z2p2PyRB4NtmXwjjBikEc0j2GaxhqUggb6fWTVVpe6IHmiuWK6vCH9ucp1SziSe55rfH5woWCGhosXhXoQsvVmCmhY95BXVH0jmXXrPngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g82JqzPleBJNohDgseEVLynBFj5dQh2a7nvcI68sN34=;
 b=dtOScOgJb6+bk0z3bWwuWnSQJlrUo5KTCeM9hR124f9zp36Lf7ey+KHyntvL/nY5wqQqgZHwEvLBjThn1nUEltkCJROsV7GNLqOdzs4KULse8pweS0OaSkILXKsXgvbrBrhiAOe2vBhtb60tGd0YdnpuyZu7Qe88yTgbX+cY2sg7cjgHZKgrf59NOSXtGu7ItsZiFApk7a4TODUvV59T3j6SS5k812/k8i2RPaUSHXMXxHid2SfAFws0bgODsMQWQkmP/4y2Xn1WfPo6fWFzVPbH5WphRl90K4mzEXZl8Al2Z1KEy2bJ7LMkeRAk3kuUCs8WtD+UvyauuVlLsu/caA==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by SN7PR19MB4829.namprd19.prod.outlook.com (2603:10b6:806:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 03:35:00 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 03:35:00 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Tom Joseph <tjoseph@cadence.com>
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
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFwA1O41wACEoNOAAHaA/QAB4hGrAABB8shAAJDpzAA==
Date:   Tue, 25 Jan 2022 03:35:00 +0000
Message-ID: <PH7PR19MB5562822EBA595B59DCE971B1A05F9@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
 <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
 <PH7PR19MB55625B4733F2F45133AA4EACA05B9@PH7PR19MB5562.namprd19.prod.outlook.com>
 <BN8PR07MB6195FAE77802B3B04DE87C71A15B9@BN8PR07MB6195.namprd07.prod.outlook.com>
 <PH7PR19MB55625AD720072882D03B5E51A05E9@PH7PR19MB5562.namprd19.prod.outlook.com>
 <MN2PR07MB62086105FD43BD7330E3D38BA15E9@MN2PR07MB6208.namprd07.prod.outlook.com>
In-Reply-To: <MN2PR07MB62086105FD43BD7330E3D38BA15E9@MN2PR07MB6208.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3da46f7-bb5f-4c2b-47a7-08d9dfb3aac9
x-ms-traffictypediagnostic: SN7PR19MB4829:EE_
x-microsoft-antispam-prvs: <SN7PR19MB4829D4332D071782EBC79D7EA05F9@SN7PR19MB4829.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y53ywucZnWVMUZ5biKPVuBtp34rSQropMOnb7j0ERqBErJLI4SZCGnYHEHRLGWJdpXmrwGDQQMRn+gLSwrqwbaYEPTcg7pLeHVYDnZ3ULez0oMG3G2GzhJyRTiL/dp8tot/qGHgufVoj3y9pxx+am+PDbCJ8xxAjQgTUGDdJ+H1EV98QTIXfuSsZuUNJDU212K0082Q38e0r8ECFNkHxv812O4db1ipQ7Fa0QbWE5+p75Ww4mqRixPaHkFhTcRAp2MjaXl0UyPHYZpglAPXRYjfJ7OYSX2hNv/rPF0cmUJX0urVrimzKeEyVyLF3I30QbNX6AAQG6wUU9FuHbM7IvRzIpZ/4TY2fcSj/+aMwmlakCMslfun4FZMKn/p7ROOFUANgVIj4Il8juucWpSnFYXuv8pvOANOfMBiv+P+cxy0V+NONWAju3qL82H/Rz/XjaMzfSDPXmONEBEzngHf7kkFqBDrOPdgZQIc4ufbkR/OYqjkApOcCauojFoisI8+wgWfKxG7m8AA1/+XvK3otmZ+R5vEKHYveiVlClVADX09ld8qCmyusOZG6EH/PXg7oK0JsQ4o+VYQMRc1SxNWL9Lfd+SKR4r6LhpbW1xmFdxrymvSndQk53I4vplVXZjAibbqhA3i5/cziTBIgIvhuX37ErpL3MpZlSBxLPsCxWE/RIoGsW/90wALn2Q7Jv3BZsy3+dr0GMpAWB7ECqxkNw2zvdniuZ5R8G7DUpROeCOM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(33656002)(88996005)(8936002)(8676002)(66946007)(66476007)(66556008)(64756008)(5660300002)(4326008)(54906003)(38100700002)(52536014)(316002)(86362001)(55016003)(66446008)(66574015)(26005)(45080400002)(186003)(2906002)(508600001)(71200400001)(966005)(122000001)(6506007)(53546011)(7696005)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?DhVg6GJR8qb+k6uQSwL7ZrD34tQ5qJDMjfwL65ICtbrsKb041BLMGdk2qb?=
 =?iso-8859-2?Q?QG7Q5SbqV/WVQj/aCM027pv7M87y4AsW6PBqL3C2dI3GCVibSIT3s9Ryix?=
 =?iso-8859-2?Q?Limk+Hk3ZPpeVA7SH75/glhQ0yjPKjHrV4rH/bg3TAjppfutcsYVO9ursp?=
 =?iso-8859-2?Q?niZ4bspgqJFtshjwivy0V3ckmaA/1An7xekPUh6ZxfqvG90pw57StDtaYZ?=
 =?iso-8859-2?Q?T5ue34WKONVGRvQAPYTCdZWcR1+lV847reCCpXEOaudzGD04ovXWAy4nZ4?=
 =?iso-8859-2?Q?XcMyOoG7h0mVtSaUI9lxZdAk0dzdlCiuMwfWelcraL35Cu7zC0wJ+T5ivZ?=
 =?iso-8859-2?Q?q3YJfA/SGeeYset3niiBuk7xSmVDd+l+5bNeiz2uOu1zr2BF1zI7+gzN44?=
 =?iso-8859-2?Q?AwMVBvaOZVXlk0ub4oM3X0BXcJa3Al2u/HJ7Z5K9Gq4xjqocc+nHtaYD6+?=
 =?iso-8859-2?Q?/3i0QB8eUEr+Nr4dl3qZQp8LvdL8+dCL6m1tQmQ8HgvdbACtHHRaqc6UH8?=
 =?iso-8859-2?Q?+kyo2Ph++KnMb/ihP/qBLCegL0zIv8vnYjHZDTAz9On5LKst6zwXh2+7/k?=
 =?iso-8859-2?Q?lfYwB6QvKbeRCoNYobZboQdhy6Lse8l27/D3kmSD6WDq/Dqs97w/UW80Jq?=
 =?iso-8859-2?Q?uH35C4dK2w/IacnRWKVtaxOsPaPlYnzGFT/lAt0TsYrI+8oddIELqrHVKo?=
 =?iso-8859-2?Q?RTKYujnVNA9ZJRGNxyeUYS9uZouvjtpWHhSpYBk9jq6F3OkYI0X0xjyZQc?=
 =?iso-8859-2?Q?5VGDTGtyBKmAUFczv7bxcoJDEY737ZBYQ9x8cvkocYRHCYilwjGeqlg/P3?=
 =?iso-8859-2?Q?ALhj2LizaQDTKuB3/oCPJlIV7JxLfrdLqCIQ9piLM83XgzmgeErO5MiqKZ?=
 =?iso-8859-2?Q?6VUKY5PeagRxLXAgGdyHN8E2HkagoPKMJ7R55T8neQ1Dmkc4e78LnmYmQS?=
 =?iso-8859-2?Q?/JovXjgXlqzQhy7HqZxpy8fXRM8k3YCPIAgs9PX1jGGBajvfK15Dp59ZaP?=
 =?iso-8859-2?Q?Wcn24KXojIBDdT9sgM4PWLYdB/fAc3xjg/RGppfJhbD1lxqt4mGLxyqRB2?=
 =?iso-8859-2?Q?gCYHjSGdpBNY5XEziVxP9cK83SVBGpm/or/bTyApsId3EfYESIfPbb5fUS?=
 =?iso-8859-2?Q?jq5vErhHjGc5d6PQQJeYhq0tVkvkhouhLXAaqHGDzqltd7ooFzIyC6la60?=
 =?iso-8859-2?Q?XdCrcnisZk21/NmOIRsngf6aT+sU+IyhuSiizbyEezcQSm2f6tiZVqhLSX?=
 =?iso-8859-2?Q?262A2kQ8Faba+q19jGVhuKQpNhyoauO/UVjkHgf7LNSJONmHRtIoBSm/3t?=
 =?iso-8859-2?Q?Z5SYNHvXwlI721mWISXHBIpmVjnZ1qgRZaZzDgcI2Huqr2uAH02jyaIOn4?=
 =?iso-8859-2?Q?JA5eOQtSlXpYKcKdWgugceCtj01H0zwRMRs8WeAtE78DSftiX7fbJaOdkt?=
 =?iso-8859-2?Q?rCjDjKm4WFkYn4bRA+hAZcvXuP+kcAXajRrEEGS2OVnzGSMCIIqEaEj/sw?=
 =?iso-8859-2?Q?j0jgusbvFnXswMyX7EGLniXa0WdnjOuyrgyxdc5JRxyhDcuZyD0DG3CHUE?=
 =?iso-8859-2?Q?13GQxcvXp1zFAq8moQTlvskeLkeiA605jBZRx0SYPDrJ4/IG1j3Td9Nx8O?=
 =?iso-8859-2?Q?Q5iCRbfhLv4nwWWHDUuSKbtg+DGpdht5lDL0NdrmBa6hp+gBRj8aabhT5h?=
 =?iso-8859-2?Q?qqEntmQiaBPvMQFBk10=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3da46f7-bb5f-4c2b-47a7-08d9dfb3aac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 03:35:00.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLjSXR2fJyVrC3Dcu07r9FwTodThRcHk3nuE4C9KXNneM9ZUeY2Kdqd1tFo5rFhwvzS8ZgEGlnebJmJ9J+yK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4829
X-Proofpoint-GUID: 6AZSBMVMIQDPTZG6WSpGUfUb1L4w6_tf
X-Proofpoint-ORIG-GUID: 6AZSBMVMIQDPTZG6WSpGUfUb1L4w6_tf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_10,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250020
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tom

> -----Original Message-----
> From: Tom Joseph [mailto:tjoseph@cadence.com]
> Sent: Tuesday, January 25, 2022 1:28 AM
> To: Li Chen
> Cc: Lorenzo Pieralisi; Rob Herring; Krzysztof Wilczy=F1ski; Bjorn Helgaas=
; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64=
bits
> in pcie-cadence-ep.c?
>=20
> Hi Li,
>=20
> > -----Original Message-----
> > From: Li Chen <lchen@ambarella.com>
> > Sent: 24 January 2022 02:26
> > To: Tom Joseph <tjoseph@cadence.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring
> > <robh@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits=
 in
> > pcie-cadence-ep.c?
> >
> > EXTERNAL MAIL
> >
> >
> > Hi, Tom
> >
> > > -----Original Message-----
> > > From: Tom Joseph [mailto:tjoseph@cadence.com]
> > > Sent: Saturday, January 22, 2022 2:09 AM
> > > To: Li Chen
> > > Cc: Lorenzo Pieralisi; Rob Herring; Krzysztof Wilczy=F1ski; Bjorn Hel=
gaas; linux-
> > > pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [EXT] RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for
> > is_64bits
> > > in pcie-cadence-ep.c?
> > >
> > > Hi Li,
> > >
> > > > -----Original Message-----
> > > > From: Li Chen <lchen@ambarella.com>
> > > > Sent: 21 January 2022 02:56
> > > > To: Tom Joseph <tjoseph@cadence.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring
> > > > <robh@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Bjorn Hel=
gaas
> > > > <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for
> > is_64bits in
> > > > pcie-cadence-ep.c?
> > > >
> > > > EXTERNAL MAIL
> > > >
> > > >
> > > > Hi, Tom
> > > >
> > > > > -----Original Message-----
> > > > > From: Tom Joseph [mailto:tjoseph@cadence.com]
> > > > > Sent: Thursday, January 20, 2022 9:11 PM
> > > > > To: Li Chen
> > > > > Cc: Lorenzo Pieralisi; Rob Herring; Krzysztof Wilczy=F1ski; Bjorn=
 Helgaas;
> > linux-
> > > > > pci@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: [EXT] RE: Why does cdns_pcie_ep_set_bar use sz > SZ_2G f=
or
> > > > is_64bits
> > > > > in pcie-cadence-ep.c?
> > > > >
> > > > > Hi Li,
> > > > >
> > > > >  For 64_bits ,  all the odd bars (BAR1, 3 ,5) will be disabled ( =
so as to use
> > as
> > > > upper
> > > > > bits).
> > > >
> > > > Yes, I get it.
> > > > > I see that the code is assuming 32_bits if size < 2G , so all bar=
s could be
> > > > enabled.
> > > > >
> > > >
> > > > Ok, but I still wonder why 2G instead of other sizes like 1G or 512=
M? IMO
> > if
> > > > there is no obvious limitation, 64 or 32 bit should be left to the =
user to
> > > > decide(like bar_fixed_64bit and bar_fixed_size in pci_epc_features),
> > instead
> > > > of hardcode 2G here.
> > >
> > > Check for 2G is important as this is the max valid aperture size enco=
ding
> > (0x11000)
> > > allowed by the controller for 32 bit BARs.
> >
> > Thanks, I get it now, and also find it in 7.3.1.50. Physical Function B=
AR
> > Configuration Register 0 just now.
> > >
> > > >
> > > > > As I understand, you have a use case where you want to set the ba=
r as
> > 64
> > > > bit,
> > > > > actually use small size.
> > > > > Is it possible to describe bit more about this use case (just cur=
ious)?
> > > >
> > > > It's because our SoC use 0-64G AMBA address space for our dram(syst=
em
> > > > memory), so if I want to use 32 bit bar like 16M bus address, I must
> > reserve
> > > > this 16M area with kernel's reserve-memory, otherwise endpoints like
> > nvme
> > > > will report unsupported request when it do dma and the dma address =
is
> > also
> > > > located under this 16M area. More details have been put in this thr=
ead:
> > > >
> > https://urldefense.com/v3/__https://lore.kernel.org/lkml/CH2PR19MB4024
> > > >
> > 5BF88CF2F7210DCB1AA4A0669@CH2PR19MB4024.namprd19.prod.outlook.c
> > > >
> > om/T/*m0dd09b7e6f868b9692185ec57c1986b3c786e8d3__;Iw!!EHscmS1ygiU
> > > > 1lA!SVgmPO0MrmUUnZzlmc-fCPsSBddkfUgT-
> > > > Y7EmlLAgz9AoQSVZXa_18TIdT6O7kY$
> > > >
> > > >
> > > > So, if I don't want to reserve much memory for BAR, I have to use 6=
4-bit
> > bar,
> > > > and it must be prefetch 64 bit, not non-prefetch in my case, becaus=
e my
> > > > virtual p2p bridge has three windows: io, mem(32bit), prefetch mem(=
64
> > bit,
> > > > because CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS is set),
> > and
> > > > if the controller running under ep-mode use 64 non-prefetch, this r=
egion
> > will
> > > > fallback to bridge's 32-bit mem window but I don't(and cannot) rese=
rve
> > so
> > > > much 32bit memory for it).
> > > >
> > > Got your point. Does a change in the code as below will be good enoug=
h ?
> > >
> > > - bool is_64bits =3D sz > SZ_2G;
> > > +bool is_64bits =3D (sz > SZ_2G) ||(!!( flags &
> > > PCI_BASE_ADDRESS_MEM_TYPE_64)) ;
> >
> > Before answering this question, I want to raise another question, why b=
ar 1
> > cannot be 64 bit?
> > 		bool is_prefetch =3D !!(flags &
> > PCI_BASE_ADDRESS_MEM_PREFETCH);
> > 		bool is_64bits =3D sz > SZ_2G;
> >
> > 		if (is_64bits && (bar & 1))
> > 			return -EINVAL;
> > I would be very grateful if you can tell me.
> >
>=20
> As mentioned earlier,  if the user indicate a 64_bit bar aperture (with t=
he
> encoding) ,
> all the odd bars will be used up. User should then be denied to program o=
dd bars.

Is this decided by cadence PCIe controller's design? I used to see the devi=
ce that uses bar 1 + bar 2 as paired 64 bit bar, and bar 1 is for type, siz=
e, lower bit, bar 2 is for upper 32 bits.=20

> The above check is not only for bar 1 , but for all odd bars.

Thanks! I forgot this important thing, get it now.=20

> This check is important, hence below change list doesn't look agreeable.

> > I don't know the answer and will this change break something of bar 1, =
so my
> > current way to handle this issue is:
> >
> > PCI: cadence: respect 64bti when size is smaller than 2G
> >
> > Original codes force size under 2G to be 32 bit somehow.
> > Signed-off-by: Li Chen <lchen@ambarella.com>
> >
> > 1 file changed, 2 insertions(+)
> > drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 ++
> >
> > modified   drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -107,6 +107,8 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc,
> > u8 fn, u8 vfn,
> >  		if (is_64bits && !(flags &
> > PCI_BASE_ADDRESS_MEM_TYPE_64))
> >  			epf_bar->flags |=3D
> > PCI_BASE_ADDRESS_MEM_TYPE_64;
> >
> > +		is_64bits =3D epf_bar->flags &
> > PCI_BASE_ADDRESS_MEM_TYPE_64;
> > +
> >  		if (is_64bits && is_prefetch)
> >  			ctrl =3D
> > CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> >  		else if (is_prefetch)
> > >
> > >
>=20
> Thanks,
> Tom
>=20
> ##############################################################
> ########
> This EXTERNAL email has been scanned by Proofpoint Email Protect service.

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
