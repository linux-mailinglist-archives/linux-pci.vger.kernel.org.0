Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EEC49773A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 03:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiAXC0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 21:26:25 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:43028 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231358AbiAXC0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 21:26:24 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O2BeZn003756;
        Mon, 24 Jan 2022 02:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=ssCR1uSHctxaEmgJK4ZC2dJR4MI2hnVRAwYg0PHHchA=;
 b=B9odaUh6oa8a9Kuuhm9fgW+DGaO8/9lV0+vI1sEDWamEluVQEi3vqWPmsrQqKtfSxZb6
 LD0KlYhBZF8MeaeIhgzgw0i3JDJA/Z+Gl/4OtKGtx3NOjAzYYoKhEXP93z4kNyIO5EeH
 DvHtFqOM8eDmJ8Xa6uVkSUpSiVB0r851pjXTaaZsKeH46LozGMZSNblB82oI5A1lJ9py
 +FuMT0G/mBfWBROU2l/BfBZnyE2zF3x42hhqfnE46vzYPTm+3HoeToS+GNVwS4H0Vblo
 FI5PspCmQPFDJ6nL31ao2ryeIot3vX+Y1KT0MCe3rCnnWA8SRJCphuq9283TIRMKHUht ig== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3drb1nrjtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 02:26:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF1qXQqhn9O6els4+5B40ie6ixIusZWcMn+6tRUAG1Qy0GJSZ6EEFbQUZEw+8oMv/rne8PEZ76DJVKXJdLBV2eLBWHB3gLaAJqXo4Rx0MLQZjJjY02Ww65sdaLCX99S8QjHeySHWvpp2kdlprr2fQ4GyTo4RoCe7CjAOjbe+0d/C/yacDayvfo8Wo30/7/mn9kH9tVbWGblSF/1JSCNi/vqjYS0tLm0QpG2mcP5pV1hNr7UbWKPOx3JIKqj8ohMKLXSYz1IYF2yu1kW29Wg5mRlpDQY31GL70u2+dB5RtzmKqLn4rEcuz0ImHhgqSeqUR6wsJMhEOqQ20clOUx8CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/KC3i4wFlQvlCAOOfCXusVi1PKZKegFKgRwAiMNB9Q=;
 b=gQezEbwlOOgH16iDhfH6QsHKr3TLvPy+9OUH0dQGSHyKzNz2+/xM4t/wtUqVjBnSqJqOX5aiwVaUm68bNoSIUqHWH2P0rbB1oMx3TOeLjIBBXKKrMxmPfXkuXEPaF8MIMwbXLHOuv5vKyNCAaao9n6ZeBZLPU0PmW6msy1kzscd8cwZHa/K8VJyOjQ631vIFSUK9xEi8BigB4n8UXJU5GsHJrajEHlxsa7rInAR1fssF6A8JWwGQNG+8yk4pYxdweKzAlvrIVeS7QLrmNOierofsMj7iru+Ni2NhrgkfWH0hLIZ7LlBmhd0pvXrkVueN4j6Uu1IViA2xVhZzXPjXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/KC3i4wFlQvlCAOOfCXusVi1PKZKegFKgRwAiMNB9Q=;
 b=bA38w6N0gez/P8iUFD7O3nzOv2BgB3CRx0UXbsWCxjVXKgkc7M8E8lt/2jzbKRBrYCrbaMw4EZ1UkM9HKPBAv3q/Y378JmYTjKERuPjqjuMJWttPiYTpQFz1AjJhIh0vIGjdKLaiyqRIjumuyYpCzKpg6lMgt+RWAZL9z2O2rOdr7r7JAiKJyouD5CV5g1aCxK5t6eriU2H8cDUPOgctToWwxOUobhkdC04MlvKv+kvkQU0gs3ZUyP/tZwISlKMIPDXkHq4+fCls6MzBwME37C7D+35brbEqRej5++4hRBMw/+ObrwemOvPStDPdXxoogzCUq1hG/jxczFefqJzh4g==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by MN2PR19MB3839.namprd19.prod.outlook.com (2603:10b6:208:1e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 02:26:02 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 02:26:01 +0000
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
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFwA1O41wACEoNOAAHaA/QAB4hGrA
Date:   Mon, 24 Jan 2022 02:26:01 +0000
Message-ID: <PH7PR19MB55625AD720072882D03B5E51A05E9@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
 <MN2PR07MB62084589DE98AD2611C55FFDA15A9@MN2PR07MB6208.namprd07.prod.outlook.com>
 <PH7PR19MB55625B4733F2F45133AA4EACA05B9@PH7PR19MB5562.namprd19.prod.outlook.com>
 <BN8PR07MB6195FAE77802B3B04DE87C71A15B9@BN8PR07MB6195.namprd07.prod.outlook.com>
In-Reply-To: <BN8PR07MB6195FAE77802B3B04DE87C71A15B9@BN8PR07MB6195.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abcb97b3-9338-4130-8d1e-08d9dee0dd69
x-ms-traffictypediagnostic: MN2PR19MB3839:EE_
x-microsoft-antispam-prvs: <MN2PR19MB3839A33E8140965C910E0AAFA05E9@MN2PR19MB3839.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/3IaF6/bPOvN3U2O+a0JzY3fMYIbeyAZQqCe6gHtyN8N1HpqmIae2evbCHBAIpQdIqwJfpF4xk6HBkFIQrOsYLQkosnsP6XQGZglcMyr4r65skOUODyHLDU83Sukhqw7l+34O9KVRQHyUE3ROBRmgrYdvesS/qigDD0cTjS8xwfSaOxuKhfQ5ZIrVDx5VLKiqzvrJFsRieo9MNhar09Tw2mcR6e6+bbLnVYyLTI6L5PECsFXcyYKVRBoL29oKFBd8ATfAJrEjN6wEfx3fXxbuE/38iU3OODmU+Dhy+VvsoasRT+QZj9dD2ZJFoGpzgcpKQWUxoytWkMkk52eNsz/zWvY01uN3TVk2g3W9IyAGWh0XfWQawEerLBlPAjaP4Yk0ZTwEROBWUErEfNh8MSNAl6gt42Onf5Hu5f4ZaDA9WCMf9EGHH4YC3kTq1hHE24OLZ/9okCOuIzkrDjjN/9AA5A0RHSVC/htWS3STPqWGxeOhu0u1Eno2Ma9ScyX4dt8zMTKDqU0x9nBq6MbyxIUJAKw+4D5ArFf60XzrbMwYLvgMFikW74FKGvGzlgeQHWawnTNqpJ+3MZ2YqUUV7oBSbhU7dYf/vtAPYNby5uqzbtRG6sigunjZr3ZQT5qME2IUrjlsZsZ2FqspkB5/eBPMs9IFe8lM1ClTgq4pz+Sxnv31/AeRCjXXS1P+pYA1SeriGZkV4nv9DsKRG9tg1ryMPSlyfjt0czBi+7S2dV+6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(88996005)(33656002)(6916009)(8676002)(66946007)(66476007)(64756008)(66446008)(66556008)(5660300002)(4326008)(38100700002)(54906003)(86362001)(316002)(52536014)(8936002)(26005)(66574015)(45080400002)(508600001)(186003)(2906002)(71200400001)(966005)(7696005)(53546011)(122000001)(9686003)(83380400001)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?/WOhWgr2bS6pfWdykeyiqGniL1IbipmymOcaYPitlJulzAA7oU8VEJstoc?=
 =?iso-8859-2?Q?AVCzRXp8aZoumiuhNQSFNnLs5pkwB0rZ3c5IKxjpFZMftZXxCBocDOaRhy?=
 =?iso-8859-2?Q?z6uMtuLJzSX+MFvhZBo79fS6y5X9QsV4Z3jMZY4knrC3fbYuCkrKM9Cwkg?=
 =?iso-8859-2?Q?7ciV+B711f7A6SS9ZT5fR5IdOGqOh3n3hyhiMPLOxRNRT0Zp2jt4Qr5X1y?=
 =?iso-8859-2?Q?hM7QEFlrV6TxtsNNh8u6UNztCmx6rnHfz8Jn7wJo6CYFiH+4FFwD4PaWra?=
 =?iso-8859-2?Q?kEXlslDPwZDPI7oKqVYHaPm0NJd5bGsBF6vwPWim6dsI6f6UJnffcaU0w/?=
 =?iso-8859-2?Q?A5XbZFOv7Qw8rndR+y8i8JuCTe5AA9OBJDSHjdWOo69qyjLtFKL9a/vfSK?=
 =?iso-8859-2?Q?LQGKAiQZExy1nN9SeQCmJ7GYFMAkxZeC1mtIHdLP2Zvqj6aKzs+wSF0Rz5?=
 =?iso-8859-2?Q?Eq6P84YL3Xr7bTPAz8ycYvUejLtbhs5QPTvbPihCJN2YaYas1zAc/G9QPr?=
 =?iso-8859-2?Q?o/ct59lSFslJdhaRchuR0XPN0T4ZCP8fZxYvLN2QPnAMG6XXvj1W6R0aNz?=
 =?iso-8859-2?Q?kKG1+DcMcsbATWnbJrjCTgzdxzwhDr9ilax1Age3EWJI6yMlRO2Lts0Vec?=
 =?iso-8859-2?Q?YmCZZuxG5Ow+RL11M5lioGKQeppF1OqrYhap9ghqw6zt0VLUesdu9dqH3w?=
 =?iso-8859-2?Q?Jmqj78bJopOWkAT672N9PhRh0tpBIOP+hSnVE6qxgV1h349hbPk/bzOw/h?=
 =?iso-8859-2?Q?y1EIrdttzl8CHiMEkwjol66CMePaUJjfzZ1Dr0/YBvKj9+HjNhR0ZbR2PK?=
 =?iso-8859-2?Q?arTsIiuVaXRDT+IacoRlafd+dgA14Hj9bqhDTW+56ZZkvkz59YdZJqR5gt?=
 =?iso-8859-2?Q?vEZEXHPYjNHvib8pSsv8njbgSXjkcErAggDcSnVPwY/DIempsGpCZJU3pq?=
 =?iso-8859-2?Q?YMIT5vP5y6GEBJFYPYrAcvIF8/uZCnYlfFlW+0fHuAqBshB76Baq4yYlQl?=
 =?iso-8859-2?Q?MGFXDZEtxBJ4pkut1zqBmIp23VRNkipuf4+zANS3LoNSTmRX5nI13Irnk1?=
 =?iso-8859-2?Q?JGgs6jagSvmSo5yU6eOq7Gn1sDdB3VvFmVnU0AhwDBKliwi63HUS0jNsKA?=
 =?iso-8859-2?Q?F38/vddsEKO4Psdw/BPBDPVFgcLskZBEtGxwwhIZ6EtjG+XNdoDNZWICDf?=
 =?iso-8859-2?Q?rqQKWlv5Ud7p4lFyBqDWbEaRDIE3PisHqHc8K0aDvKI4TAcx7ylr72a2uc?=
 =?iso-8859-2?Q?zlX6g5tCG7g5S+GeR64sdeQ3YLYKh4fkWQdBF1tW6N8zmmVDyk5SIGOuRL?=
 =?iso-8859-2?Q?S+lEm1xafnwIbtDbmBiM/zJoAqYFZ8Fms/pMgw078iZ7D3VV9sSpa4+pUY?=
 =?iso-8859-2?Q?7VXQcQF98TnYc+nOQ2blttTw3piRqBogUdjlzq8ea89kAHG2wNs5RrIisG?=
 =?iso-8859-2?Q?VsfzqYaVURgDCT5ipXOIcp7debbexFgBS7avnolOhxutlz1I4CUTBBvhlI?=
 =?iso-8859-2?Q?V/V5morfUtGu+2+71eqmkeCgiOW2oaiQJcGyjyie3VxBiJPxfKBLAE2kiI?=
 =?iso-8859-2?Q?X7DI6O5PxS3mqbNpyNVOu+CTH6mnNazZJA7kHLI403urHspsthr1ce4vBA?=
 =?iso-8859-2?Q?MMb8QVt9+IogSyv2RwaklqRllQDuSP4/Nob2ZEbI9gmwja4yPFOXi9qOg+?=
 =?iso-8859-2?Q?i9rL7DIINEg/nKTNDcY=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcb97b3-9338-4130-8d1e-08d9dee0dd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 02:26:01.5546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emlwR5pqWKJh85wVVESlKjoWAvK2q/Z89zxtQ5kyEGMOO5kISN61DcU+jkCezaijPPvUvZjzq8dCK5h9B8toTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3839
X-Proofpoint-GUID: 8oJ4Tzziimj4YyljDOXPrpejBbY22HyQ
X-Proofpoint-ORIG-GUID: 8oJ4Tzziimj4YyljDOXPrpejBbY22HyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-23_05,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=968 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240013
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tom

> -----Original Message-----
> From: Tom Joseph [mailto:tjoseph@cadence.com]
> Sent: Saturday, January 22, 2022 2:09 AM
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
> > Sent: 21 January 2022 02:56
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
> > > Sent: Thursday, January 20, 2022 9:11 PM
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
> > >  For 64_bits ,  all the odd bars (BAR1, 3 ,5) will be disabled ( so a=
s to use as
> > upper
> > > bits).
> >
> > Yes, I get it.
> > > I see that the code is assuming 32_bits if size < 2G , so all bars co=
uld be
> > enabled.
> > >
> >
> > Ok, but I still wonder why 2G instead of other sizes like 1G or 512M? I=
MO if
> > there is no obvious limitation, 64 or 32 bit should be left to the user=
 to
> > decide(like bar_fixed_64bit and bar_fixed_size in pci_epc_features), in=
stead
> > of hardcode 2G here.
>=20
> Check for 2G is important as this is the max valid aperture size encoding=
 (0x11000)
> allowed by the controller for 32 bit BARs.

Thanks, I get it now, and also find it in 7.3.1.50. Physical Function BAR C=
onfiguration Register 0 just now.
>=20
> >
> > > As I understand, you have a use case where you want to set the bar as=
 64
> > bit,
> > > actually use small size.
> > > Is it possible to describe bit more about this use case (just curious=
)?
> >
> > It's because our SoC use 0-64G AMBA address space for our dram(system
> > memory), so if I want to use 32 bit bar like 16M bus address, I must re=
serve
> > this 16M area with kernel's reserve-memory, otherwise endpoints like nv=
me
> > will report unsupported request when it do dma and the dma address is a=
lso
> > located under this 16M area. More details have been put in this thread:
> > https://urldefense.com/v3/__https://lore.kernel.org/lkml/CH2PR19MB4024
> > 5BF88CF2F7210DCB1AA4A0669@CH2PR19MB4024.namprd19.prod.outlook.c
> > om/T/*m0dd09b7e6f868b9692185ec57c1986b3c786e8d3__;Iw!!EHscmS1ygiU
> > 1lA!SVgmPO0MrmUUnZzlmc-fCPsSBddkfUgT-
> > Y7EmlLAgz9AoQSVZXa_18TIdT6O7kY$
> >
> >
> > So, if I don't want to reserve much memory for BAR, I have to use 64-bi=
t bar,
> > and it must be prefetch 64 bit, not non-prefetch in my case, because my
> > virtual p2p bridge has three windows: io, mem(32bit), prefetch mem(64 b=
it,
> > because CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS is set), and
> > if the controller running under ep-mode use 64 non-prefetch, this regio=
n will
> > fallback to bridge's 32-bit mem window but I don't(and cannot) reserve =
so
> > much 32bit memory for it).
> >
> Got your point. Does a change in the code as below will be good enough ?
>=20
> - bool is_64bits =3D sz > SZ_2G;
> +bool is_64bits =3D (sz > SZ_2G) ||(!!( flags &
> PCI_BASE_ADDRESS_MEM_TYPE_64)) ;

Before answering this question, I want to raise another question, why bar 1=
 cannot be 64 bit?
		bool is_prefetch =3D !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
		bool is_64bits =3D sz > SZ_2G;

		if (is_64bits && (bar & 1))
			return -EINVAL;
I would be very grateful if you can tell me.=20

I don't know the answer and will this change break something of bar 1, so m=
y current way to handle this issue is:

PCI: cadence: respect 64bti when size is smaller than 2G

Original codes force size under 2G to be 32 bit somehow.
Signed-off-by: Li Chen <lchen@ambarella.com>

1 file changed, 2 insertions(+)
drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 ++

modified   drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -107,6 +107,8 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8=
 fn, u8 vfn,
 		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
 			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
=20
+		is_64bits =3D epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64;
+
 		if (is_64bits && is_prefetch)
 			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
 		else if (is_prefetch)
>=20
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
