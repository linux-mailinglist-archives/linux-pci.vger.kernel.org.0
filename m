Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7543968A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhJYMrY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 08:47:24 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40382 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232474AbhJYMrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 08:47:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PB8A9r019098;
        Mon, 25 Oct 2021 05:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OxNqCMoqWLPGj6gDvgmab2m98ps00brNzuRgaMVohyI=;
 b=CrNRp11YY4uzqJwaLKKV2fO6bY84ZCs4C4q6oOvyUdwnfGT9mQRJXG7/uNI8i3tMBKr8
 WD2lGYtJx8J4IJ44VvL3QKXXKfchrJDT5HcC7SVUaVRWoJSev5FWOByMRRXiPehom6Ry
 U6ERqQyN857eSTqLNZx/8RdaaS1skwyQkgd1nuEcn/KoDYxFApp3gNeQcaoOwRhr0UI8
 zqiH+2SxZc5nVH89l1ZnpstM6U2j2tNDM2q5T1fOFUVrnbh/N2uOz7oJ7J+iZsdXp2VX
 8Wxh8/j3xSJMiwscbvkbtGuAJAMJGtXcNrTjXE2voY2zB+ntK1aGBAp+nIQMV0doCx+j pA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3bwc5t2sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 05:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtV2R8hkDp+OQmC0yzA/r5Yga1EjsbApBFf7mFkgBq6e4rTNhdeWreDGnNo+jnYQ6L6mOXJgGtv5lZDdzRZrgL5OCNVEo0dD68Kp1XI5KcYOb6/FYjm7GnFXf4k1Z/Tjb5R6L6/6LKVaKN6L+56ajHOvOMCOAwH5wsAH2FBeTGvE6DRJxr61HSwYdCPQiPXVHBeU3pNi8V8xc+gWOBVdZwXu3b5n+GsXt6yLUoMUveRhhT/BHrJcErK/CwQc59Fi5hZHaiRe2PZvUia6S3D+xUiUnT0TyGz3SpujocovPW4I/zpPxjlNsi9mS0hCSIwsSJ2fdepJnfgjvem39/5Xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxNqCMoqWLPGj6gDvgmab2m98ps00brNzuRgaMVohyI=;
 b=NNtrWa1oLPOvfxVYlKJxW2i2adOZEfyiYDrrC71OHIopSChAiPoeMOSOQW9R7/HKAWM1CQeGybcTlDydsR74GT0NkknyGMZQ6MvZXJ3cXrx7lkZ1bS8O6FCFp3DHWSUcDheL2sNFlMuX/fD1DJ1VcHrOcd/s5aQHpj0b2f9jNo6xeFRi3LazGpqmwPawBI0FWwa9gMkxCEcwEVPt4m8XoVVFtc/WizkBaLwhfUGwq6WPTY0wjR6Y/hdNuCizVbXGBNGcUxO8EWs7J0AJJMzgpEeVo/eBNmnyBh5BXSq/e8SjG5ha0U+IvoA1KcnkLFMJZAX8j8D79uLZQFrf2SnsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxNqCMoqWLPGj6gDvgmab2m98ps00brNzuRgaMVohyI=;
 b=zWBQJjXWJTohmTX5ATEZhTM1ctrc6CIaFx0fI5rmKpmUlUsslLbxK11aGINrRKBOVpndoMdnK8iD8r6PomUY0oOpE9PA+xmHjdk6B5Tzl7yrP043EqUAkToPJsM9eK6tfiGpdMc+SOoWUqtlvFXTvBElez9K9ECCnwTAKkPkDTQ=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB2872.namprd07.prod.outlook.com (2603:10b6:903:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 12:44:46 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::18cb:253e:25e5:3928]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::18cb:253e:25e5:3928%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 12:44:45 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>
CC:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v2] PCI: cadence: Clear FLR in device capabilities
 register
Thread-Topic: [PATCH v2] PCI: cadence: Clear FLR in device capabilities
 register
Thread-Index: AQHXyZxCOzc8riCXgkO+a5FUgFfAFKvjqMHg
Date:   Mon, 25 Oct 2021 12:44:45 +0000
Message-ID: <CY4PR07MB275704359967D303864DEB2BC1839@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1635165075-89864-1-git-send-email-pthombar@cadence.com>
In-Reply-To: <1635165075-89864-1-git-send-email-pthombar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01M2JkMDY3Ni0zNTkxLTExZWMtODY0ZC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcNTNiZDA2NzgtMzU5MS0xMWVjLTg2NGQtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxNjMiIHQ9IjEzMjc5NjM5NDg0MzIyNTg4OCIgaD0iY0VxR0VIa1lFYzBLVDJjd0RHellON0RzdTBzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88af2fec-5ca0-4596-7705-08d997b53974
x-ms-traffictypediagnostic: CY4PR07MB2872:
x-microsoft-antispam-prvs: <CY4PR07MB2872CB049C62949B79C2AF1FC1839@CY4PR07MB2872.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COEd+vtIF50XylumUVABJrVHCKafQSIVyidHrJamZF+dAR7pskNa3nggtHBYEWkolMICa0Mcf9Fv6Gvio8pEoSZfH3Bj0pQDbXeMT4BkXSeokLOBatRejCEDjHA3xT0aIhxM/P8GvlW1ZEJB6vZAUoG/ux4NMfI/upffR9pUybyS7Rn9a5LdrZ2TGg1UZaJG//i05/f6ZKRps6AnbUzXJrWRk0D2Yvi5vag6YLP6XNDpVVGyHdPO4LfYWj2PamRJfBe8EsgMF8a7mtuTCQAoTrPcXBdJFV72bXdtvV/R2ghHWoO7YvhFldXliQSL0FRPZqwn/WQ6ACZOfA8bKVB2+en74GPeV/R+1cvlgpvKptJjNACOWEg+Omk8OEc4LSaaI+ktxIMOy8nt7RktSKFNo3m93qjqB0U4JAGt4C0SlbxQZ0PDr/C4uY8Ky/ZIiOePsy3LJwBRQFRTdVGMnugMb1F00QrV8HJFGKwx6F2EBN6M5Q+pKjlIuHA1TPOWkW5kMF8LJVYxVJr5l0RU8Xu26W2p2HOBNyf2kKV0hFpr/RCBZO4RJR7pnlBIbKKOGB8G2AloXcqM1+r2Rbgf0h5HNXHHQfXatsicsNj2jCQTzpl1yLlGS6DNBLDWVNljfshCsiJ59j6fIrlxojiiGQh0wnHeeTEpWmLkLJ+vdZheuZKnP/ZitmAJ8wWZxqDf+Nr3jp74DeaU7tdSTisqpnJhmE6Ir7Y5oLygx59GfcEXzNeSQPEWlXH1cf053NU8P2bM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(54906003)(4270600006)(55016002)(8936002)(26005)(19618925003)(76116006)(2906002)(6506007)(107886003)(8676002)(7696005)(38100700002)(9686003)(110136005)(122000001)(66946007)(5660300002)(558084003)(71200400001)(33656002)(52536014)(66476007)(66556008)(66446008)(186003)(64756008)(38070700005)(316002)(508600001)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?79DSrUr3CXEVwDoXN4HkIaoztJEelbceMTj41XAXkZcAU7MzQWUTWyQEygpf?=
 =?us-ascii?Q?sUF/mS5dLPYkVNRaip+NT01AFHId90OH6a4yEPxSg8rHvrflXyIdKjyv9CLO?=
 =?us-ascii?Q?Dka4/ckY6lGztVDoXWynd1qJiuO6ot7AgxVHvDG6gB/CgPo8TlIjsEC3dHWN?=
 =?us-ascii?Q?YkSC9X5IG0m5iEn+IfSWKA7QvnuCGwkjAnK8f4a3oOtWelvT/ZwmYrt5O4Ai?=
 =?us-ascii?Q?WxDvTWv95r7kQ9ezmqiM7Hv8mZ7sbVG/Nyohbmxc92o/h4l+/FY90pFUhcvC?=
 =?us-ascii?Q?AmR6VVG5AL9RH1n7JYSQRQgWAkPH/XLuFvWbT1WOWp1ggcr7h/8BuWUC5wiD?=
 =?us-ascii?Q?bc3TjeBX6DEA3ZSxaTKVbkU111on3h5fy1wdJ2VwC/X4xv87I7ju3qdx95xx?=
 =?us-ascii?Q?95SqAnNumjIEIljSTx5QtXu/OKjkO7dt661N6Y9G1HEBWkQD0C5loq1UiTBv?=
 =?us-ascii?Q?DdG8gysCgnZWDiE+KFC/cSs4LxLqPeIKewOlGaq9eYfUDC0q/4WGL2Ud1trj?=
 =?us-ascii?Q?ki5k4hMe6TWJWHCfb2b6yUBH3ki9iJ9MaMHD/rZZJuuAssG7xooq8lyLuRUu?=
 =?us-ascii?Q?5V1OTxzOGZGClI1TVSPrQqUHDMC0WeAq0mnJ9YZzE9fARLfZ+IUlHZjUJk2O?=
 =?us-ascii?Q?5vu81cOkzOzvZd8fAclqOLGBuO14tY5QwKQYjQWc7glkJQ1tYRaCZHVLfBaK?=
 =?us-ascii?Q?WqzoDWuidgQ8EWqhRvc4kiMv/DXuRA0vFWDI98S4lx65wwt08kXGgUpYt182?=
 =?us-ascii?Q?/y6y2Luj2VN1AlBrDtysDpwsaf022W/zMp5hJaQjrrMW+LoxINVikbl0QlYt?=
 =?us-ascii?Q?Xgngam9y36m+zj7MegmQHNvLu+dFMTtVXKd4Q6ak8it/QVnDmLNK4ct1cmog?=
 =?us-ascii?Q?DI3G98Jb9MXJ0avvJ/sKpVAsisw+/2HY4jN9z4nUWY3sD05cR2TKUCdEdCYX?=
 =?us-ascii?Q?njfmUi4hVasIJ2Hjt56B6toig88D3YNrL029vhx1ufe+1/D+tGIr2Shw1FAT?=
 =?us-ascii?Q?HADXw2xvNw3fYQvm/tbXUukRfr/WYHeAKcFiXpZ5Tr0Wn2s/pPz9+8HFyWbz?=
 =?us-ascii?Q?+2RhmTEdy2bRNP6+qtqz3f8DWrgb2ayy7i+BwEjZnonQ65KL3WUOv+XkG4wZ?=
 =?us-ascii?Q?qlUm1u6YmkCVusQyqKkD1qlV6MuJMnZ+mUdSuDswryvciZpvvApz9KDFEOQV?=
 =?us-ascii?Q?5L9UyvaVoQ6fdtVg6UQfCvfYIFDzShiGgK6xJaGA7UE32/TXOg6C2tFMdvv4?=
 =?us-ascii?Q?Wa/+19t8T4DuFt/9fhqKJMhR26/caaIDiLS6h4Q5sj4MeSUgjLszHShH13fn?=
 =?us-ascii?Q?m4jgNCHjK51RB8bTvlz/m3r/A7JLTbohA7YVbwL22r8k+ruWd2CHGOTmNNj0?=
 =?us-ascii?Q?fQejD+pt/6gzV+SzOPVFSksFgCP8B16h3qKteFan6sIkSV3C9qyuq5y9vo6+?=
 =?us-ascii?Q?F+o9NoA/Tihk9jhlDtdDtGGtDlKD6TDxQToWa71AvudT3OZiq47svTs444Ky?=
 =?us-ascii?Q?5o5Wy/XLXYoggjYSRxuzeDCOvsuorUOzKE9lj1chBd+gbhQO349DpthQaAQM?=
 =?us-ascii?Q?tli4HQ7OAi79byMdogBTOacsbrWU20ombCmtu0tT/Fb1prvfngfeSdHY/kiA?=
 =?us-ascii?Q?NSkJj4yEe6RHIwlgg8EAej845yqRNzMMeWT14drOA2OlDrBFYqZgjOquPLkk?=
 =?us-ascii?Q?FtM5/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88af2fec-5ca0-4596-7705-08d997b53974
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 12:44:45.5275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSz3fEZ6OzLeOtgsglylkNxZ6tfWZljyxDJu/BbSRDRjfUdI9V53vWlUiO1gpmXFK+QmebQTWZKNoT9iZFtpk95WjXrwP0Z0AGMlrUxsFl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2872
X-Proofpoint-GUID: qpMtHfzVaacrDsjbBiJhT7lbZ7b1s-xm
X-Proofpoint-ORIG-GUID: qpMtHfzVaacrDsjbBiJhT7lbZ7b1s-xm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_04,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=672 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110250077
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please ignore this patch.

Regards,
Parshuram Thombare


