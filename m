Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7BA2D9E5D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395405AbgLNR7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 12:59:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:5494 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502552AbgLNR62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 12:58:28 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BEHo8YA003758;
        Mon, 14 Dec 2020 09:57:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=uudqvXGh5VNURuj2qrVrApJzOEhC38nmMFyzLD92I6g=;
 b=PGq5elo47utdzVfO0t/bujCb8y3bueqjFsfzt5GxZXofQVxvIPhfdA2INnMbcjRt8plW
 J6IMOHoE+sd4Qcdmio+oil/6ddGTzMe7FoI5DsZLhncsPS+Tv67ACQr2HNtc+RLkP3Qy
 lj9J3ej+s8gPHPj05NJ6qK5t/qWq0s4mr+uQjEuwEil5bEBD51ixK6HTl1ZY1bQ1uXVB
 w1g5JbXxWdT8laPwfJH6CK+Y82lpisI6lr6CQ1XPqdoqnc/GLqFgYVTWq/gJtI90g2bQ
 DMHt08Xhqdl4Zb3WUNwBB3CEvyc67j/mI1QvpK2ND19bqbaoysVKA2UMzLRXPuKsxEQH hQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 35ctb2pant-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 09:57:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev3SIVcoJMQvrgogGIOSpDZG+YbV8AmkxLY1nHqsY+vXhYAPBBXoes7LqCKXGggzJHPiiF2lnFErnIy/813ENX+o8FksRzfJlPM/Y2pDw0Eh+esOPeMaWCGn/SxvjYGjd9b9l4bJbwPON6Cbu0ELGMXK+9Vf/WZKKM44jH0T5irv5GCMlPeVauY9b2x+ETueepWCrjsRi5HoSlHKVDvQ3bWpQ1GKWcecvizKMJzT7dfTw9PYJ3kTXmIzzwnfQFO1NTDjB+GPFMVoehIvNJEENATZzpbYTlpjKYVqs8STatKC+u3KDgCdO5lhOZSPLSTtgle/j/ywt7NHD9VQIXJbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uudqvXGh5VNURuj2qrVrApJzOEhC38nmMFyzLD92I6g=;
 b=DtX6OqZ1gMmkghmTcF+BdDxp5jU21MULaQe7kmwX8MB17P56u+jr2fiS/eGKDgsUMLcsqiU+uKkbQQljNXbMP7YXqhgx2V/niKGdytKZ8/S3WXEoW6ZVoDaG5UYMUtusNhEwWdZOQ829qFM8QBpG49WiqCTM+cqA32nMc8jrnIXny/Maa9g3zsIHGj/PWbBGRnQ6PxMbAJKaOtppf5JbyioTmkn76EnNCJH4uXihyQzYOqaXyZ+ImMTALE+OAlHJ92TUvS/AnzuhWx5VnGcYwRhlGXYYJNj50QqAM2ctaEkJAPTw3n/MGg9QekfXin/RJPB7gNQTRLblnD72hKA0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uudqvXGh5VNURuj2qrVrApJzOEhC38nmMFyzLD92I6g=;
 b=mcflzDYyuQcsiVoEN5ZcDvtwCH2mRFUzwYg7TUMft/+eetTfD+oSdm7iw+ExkEG/sbK9dHVVss4Ah8q3fvgaF2RENg7mllwhfg0z/3F22SsYvIiG5nGaIUUmgXj33nffK/AymuDvRXNljHGsxAf0iFmswB56G9QU1cl5Hy0DcII=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB6128.namprd07.prod.outlook.com (2603:10b6:208:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Mon, 14 Dec
 2020 17:56:59 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::e80a:361:a186:f317]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::e80a:361:a186:f317%5]) with mapi id 15.20.3654.017; Mon, 14 Dec 2020
 17:56:59 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
Thread-Topic: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
Thread-Index: AQHWuECdntfltqp6Jk2ERAKvH6zQcanwZJCQ
Date:   Mon, 14 Dec 2020 17:56:59 +0000
Message-ID: <MN2PR07MB620832AC733463A0702A6155A1C70@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-12-kishon@ti.com>
In-Reply-To: <20201111153559.19050-12-kishon@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWMxOWFlMjU0LTNlMzUtMTFlYi04OTNlLTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFxjMTlhZTI1NS0zZTM1LTExZWItODkzZS01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjUxNiIgdD0iMTMyNTI0NDIyMTc4MDIyNjcyIiBoPSI2eGNpaFFFbk1ZWDF2NVA4QlduSEhQU1RsZEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b730db76-6d09-4fb4-c9e5-08d8a059a777
x-ms-traffictypediagnostic: MN2PR07MB6128:
x-microsoft-antispam-prvs: <MN2PR07MB61284C1D50C1A7A6AE0CCE7DA1C70@MN2PR07MB6128.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvVdQHrwpNHeMpVGqq+uAJC92XVghFP4JF+kdsmQxbrA9MKe8y4F9ImSf2ADkISj/fSbMv/FlGoHmqJ8ZICfsYQCCAkWvPHLFnXZ810+QZn2xHAsA5Q3aWV9RZwdGtmOVBZlTUhV+ENjj8AQTW58JYRvcKx6AF6Aybz9F/L2cUWTBVtYV19ebAvYpaya8tG2OETdXw9Id3GBPQkWJxrUVE0RFGsAykxq2R4y3JLw5CyaJZzZ/4a4YoLfKBQ1W9OF1fN1GdF7t1wez0EfBUBb0zyR1pjrAiNJGe5CTVZaOpz1T78xFKG0huXk8u1iNouaL/19M/KF3EEU1DzP2B7wO/1C+Sd4c/EzeeURwcxylPPMhB7KMJ+oHANgCMq53tGo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(36092001)(4326008)(6506007)(64756008)(9686003)(186003)(83380400001)(33656002)(7696005)(508600001)(54906003)(2906002)(7416002)(55016002)(110136005)(66556008)(66476007)(66446008)(71200400001)(8676002)(76116006)(5660300002)(52536014)(66946007)(26005)(8936002)(4744005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M7k/O93dn0qG0g5+9bK33t0HKcfVqAchrg3gD4R/tByFDKPlHpIKa6zI4Dhz?=
 =?us-ascii?Q?I4i2X41WgwI5+au/9EBjAeON8stMMbAAo3clHL1hjOpg56alNnIC9GOCwRwk?=
 =?us-ascii?Q?aBD8PSn5fyCL1locMYDt/IHE5Cu8SdmQViHW/HU3nUYMmDX2ngNc6UHmi4yj?=
 =?us-ascii?Q?ibExLpZLK3gxZoHRNu/uHybiZbRt/ZjMXjWDMx7LiAT8+xEDVa/BPbfLNyCM?=
 =?us-ascii?Q?nP7i+ADzwCCuoE4wMvHVvUg8+sIbMqhBurXSZXYuQV54IaRR5K0CK99jKjXM?=
 =?us-ascii?Q?5RjB2egJsWZAnT8WJ1AxQfPQLgCrF8ErllYungktw7ea6uk/lV+YNznzhkDN?=
 =?us-ascii?Q?QdZyrAMzhcnZ3iYkMsc34yBbr4fQZ3AESbUW/v/BEzMV731qvHFWPfcLIb70?=
 =?us-ascii?Q?cod1oaUUZkcQnr6p9rxwm3PRrHAqpDdSKmR+Ob51JeHgdHrj13jammQFx8JM?=
 =?us-ascii?Q?qkAoc603sxvGd9BAMDff2mnKqqQ+mTw0fbaYG9XptfN6UDcWwHnMi8dFW+Jw?=
 =?us-ascii?Q?XFhrcdfGabRO/mcWFNYERAWXVJf+4ITiA2Ew8D3TqgAsSfWJojJBrdvMgCAM?=
 =?us-ascii?Q?U3nHkBChDI6Tl2eXJSYaOEyo0jhALSrzTx88gW/+WCWDFV4C8sEoq2xThlwH?=
 =?us-ascii?Q?rnXXGhMmYNzNommkbwRaZ3hNQMiX7SeRJr9pFhBH7v+4y+syNqGoNzAlLG3A?=
 =?us-ascii?Q?Iivsro9Zk2yz4VBl8/uAqdWPAKclv01tl7kjFtWgTWPyl9OC4yK1RpFHk/Vc?=
 =?us-ascii?Q?SAjovS2II7VPsNuTC0sgeDZzG68vStDF8p98cUThE91cDBF7+Fc6VwB4fYB2?=
 =?us-ascii?Q?rs+GeVyQdwvSl/++M2y4SmT6H7fGPgx4EdkUCPSUwjBk/n+k4i6hH/6wT7bm?=
 =?us-ascii?Q?ASNkN9/0u+BE963/9v+hiTNbuywIxbumLTfMJvH1ASh2hyXe4W8hbRPKHCjc?=
 =?us-ascii?Q?AQwkqba7gskbNbzCEQXpf7joHbSa39i8nsaBthl+8go=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b730db76-6d09-4fb4-c9e5-08d8a059a777
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 17:56:59.3874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VG+dzwYwRnz4QymAwWifL/KUjz/+Q08y4SBRAN4WBoVcRMe8PfgQS2AW6nKt9b4rzuoMs7EKkOnjw/HAqmyLE5J7uh+HO/rzTvAXuK1HqX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6128
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_09:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=856 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012140120
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Implement ->msi_map_irq() ops in order to map physical address to
> MSI address and return MSI data.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20

Reviewed-by: Tom Joseph <tjoseph@cadence.com>
