Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F11564B440
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 12:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiLMLdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 06:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiLMLde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 06:33:34 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A221B79D;
        Tue, 13 Dec 2022 03:33:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLQTnsUgcaryEj19q4UtZOkTwqEgO/UK+VqdTtzL3trOg7Tr2nHGphupaf/D3A6p7okQO2avFRX/ztz+NwttauGUtAjaQtkwhewLNkIabLLgqS/vpc+9mxKEsUWjeOTjb/EeO43b8CmvBvMxLMt7cmMzgfU8NgjuQeEEpr3Xx7MJfHi2DAoryp4PF+DYLUhBN/ANI2ETkzzNTIX7aRTaL9f2/McaucPCoMMgOHn2WMBKILWWz2JphpB07JY6nDiwGZKHhar5W4MX0FA+b+7AxlDiyG+4g68We4R35V01KSTIAoqmSaPdIZ15aThpCnsNY9FWHJk1R6WDxe7VgxDchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FCKSfYi7oVN+d1xi09pyE/Mtb7tk3+dpcLzCCVwjew=;
 b=cdhcgFfV6BNNP2Vrwy4OQMYCjP3jlNZwkI8WvR4e22Sf7DyBOcucLfBq1sQ/Yt+hLlmsUiOB1nCjMBAF4dPSH/EOTdig/B8eYPIda8tABP5G4qu0m2IYJRk/r675L4uw6SL8PQw9p6uWrmJR8eNwzsMGGiiMSbRzF0e+ecjWcbhjNdyVz4W6zvYAa4fEemlyCG6rMEJmbwSeGHXmxbV0DDWawpvIc90FNCxdXYeP5SuOzEvq54Y097ZRGa5mQAZMTbxLsb370EFgTURnCxKZ7B70XSunU6LZ9U4rrhcbtM/R6o+XlZu5KXg4TsJq+iLcfjQDEJNu33YbrkPoaxEiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FCKSfYi7oVN+d1xi09pyE/Mtb7tk3+dpcLzCCVwjew=;
 b=Zlra6tSYtZB1ktlB+6UBjLCngX6ve1DZQF1rNJuyKEk2Ib5aQUBhvFCz/iPynMPavz6ea8ww8kTQVfQYN7Lh9oD6mHDuMeuD9THGb/k928zuTTbTMwHgDph0mXgoixLF4jRNBI2O3Toq9X3d+5htf8TnpVUCzL7shTqkqUVNB1jkhOS8EQWTOmTn0rnGsunIumNx0f561OFHpXa65x7HKa4PwheBp4mHUNIET+nDcE/qwY9bpIAnWhDdVAFqxXEEreM3f1oEM4lrrecqIvKiC8oCICf/sSkWTRqAUzWxaDX7RmZUMnwRPcJZLGuXO2HQPOD1pBYlKsHf/utCxEnpiQ==
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by SI2PR06MB4172.apcprd06.prod.outlook.com (2603:1096:4:f6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Tue, 13 Dec 2022 11:33:28 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::dbda:208a:7bdb:4edf]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::dbda:208a:7bdb:4edf%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 11:33:27 +0000
From:   Liming Wu <liming.wu@jaguarmicro.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "398776277@qq.com" <398776277@qq.com>
Subject: RE: [PATCH] PCI/IOV: Expose error return to dmesg
Thread-Topic: [PATCH] PCI/IOV: Expose error return to dmesg
Thread-Index: AQHZDsszYjQ+53GopUaS8VK+5B1xya5rhXcAgAAIcEA=
Date:   Tue, 13 Dec 2022 11:33:27 +0000
Message-ID: <PSAPR06MB3942A2CFB519F5F3BB6DE6B7E1E39@PSAPR06MB3942.apcprd06.prod.outlook.com>
References: <20221213081607.1641-1-liming.wu@jaguarmicro.com>
 <Y5g/eo3Z7xy3COzn@unreal>
In-Reply-To: <Y5g/eo3Z7xy3COzn@unreal>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB3942:EE_|SI2PR06MB4172:EE_
x-ms-office365-filtering-correlation-id: a129e959-e58e-4d53-0a28-08dadcfdda7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6F4wjU5vcRNrpeO70iRWDE5E11on2i6vDleDdOWe724VhdqWfYrawHVIfDbAxJdq0koTh8P47vDdXwb2MpCuvjOFcVj+Zp1wdxmWTGb7mHEX83t18valgzvOnv7A8TBpLmyYdkCJpK5Vr8Zx+Ln0cYG7yEj9NOD3vEFLXF0TM6DFDPBLGLRr4POArCmZuTp8QCylZ1D8tj7mP/9ZE+7fhT3amMgEk/gyqnKUqO5wETqNzP0XVGNIV656vYEE+yiG9nQ0qZ3Wyz5a7/P2I7oTdFYHgp2kSL6/QQCFW+Ub+nEwxU+OAE1f0N7XwxWyz2Ts5uJejMOMHAABnbVfxSPZaSxDutMyqoSLdXbsAOIw6qXDNdxQLxrcVLlVsYUrgYCQ6SUFkgyJ89AIcQjJCPGhfyGpss3G/FrQsDBnak4Xk+vvHiDxee0rW62t/U7C52a00AkN7Fq6hOeB35Jz2bjddcD09rhv1+bedQoATcVRGQvvPN2Z00yd3+o2Yfl8WETQf1LLLXF+2RddLQ43IXZbMexxrMs1CvuWFXZO0OjfJyIF7CJH59ah7ziManuDmMecZ8pMO2MFF9sS3ticN06E2+FNN5sqHPqdLTh1HU0eBcLoYBhoQNwF7FTmTs0BCmn3MiqV30vuR+LnRzyZMWZ6t5/WzRJTka8T89YzC/V+dWrfrP/HIXXSAMnLRAhf3jY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39840400004)(346002)(366004)(376002)(396003)(451199015)(41300700001)(8936002)(5660300002)(38070700005)(52536014)(86362001)(26005)(71200400001)(9686003)(478600001)(76116006)(54906003)(66556008)(6506007)(64756008)(7696005)(66946007)(53546011)(8676002)(66446008)(66476007)(4326008)(316002)(6916009)(33656002)(55016003)(83380400001)(38100700002)(122000001)(44832011)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jMdeCQ8x3zcXsgqx0NBv5fNT8a+ZyMnDk2gR4HIe1GVGtyk4mBzuCskuISio?=
 =?us-ascii?Q?Lphs0K4d51uZ3dRBYesysygdnrbXowwLuMQ2GCeGurBVs9DIpU04xWrbblZr?=
 =?us-ascii?Q?nR7KuHBN7NbytPUKuySw2Plkt5qEgGvWc5rEF19dTPKT2EhX+zbnshews1wq?=
 =?us-ascii?Q?txYq7Q4TtnKlprkv7ZOY1aK99b9IBpFg1/Tqg0oROlxHas0ntUeNJBbbXNuN?=
 =?us-ascii?Q?Q58rWzZhaOqEs1F0fVEfIIt9LeOFBkOrwJr5WETORG/aWemM+pBkQrwaBDpq?=
 =?us-ascii?Q?HdNatkkl84JGcr52UabQD1MxBvg7UoLGz8dZNLDe6P3bfaL2gqzpE9+EAYhW?=
 =?us-ascii?Q?IFcZZtsnP2vI/Su6tmUNUaiWp0EYIgMOoQSHiPa4pd5RxMyHIc0uuIjkjxad?=
 =?us-ascii?Q?845TI5yGz1w2Wzh0ID55QULQuonBBzlXQeITg6RJWK/8RB05YUtYIT+4OKv0?=
 =?us-ascii?Q?8A33mdtc7JZFrG221CFbvwZfonr3JUqpJSjXbF+5wh27FNcXgxFOA/5caAi/?=
 =?us-ascii?Q?d0QEiDgf2kF2wxa8K2JRyOpkQqz83s7Euvs9B3/PY9k1aPiZSbe7BV9A+qu4?=
 =?us-ascii?Q?+U47xmDK4Or59vFXlff8QKcQogIDWxBA8rhZvVLQ6mAuHTvtAsCp/wByLVCL?=
 =?us-ascii?Q?W6tV4CLYeB9yTYnJSFml/a/wMoiEV6Buyc8jx0gPDWyf0fdmlQ/297J0ZTuA?=
 =?us-ascii?Q?sJVMBrLeYNhMSvFmQ3fPCKKlPtUkOsHI3zZ8yJ/hXfkwJHMhFztnOiSqxPQb?=
 =?us-ascii?Q?MU7959QmLsHF/wFvRtWwUlnahue8+kUauS+NwrFUXw/vXb0YIMVQE5MDwvn5?=
 =?us-ascii?Q?DF8asDUKKaIk6Ih56ixzn2Md4ysXHsfuump2XrLgyj5FZrop7D9QxUjfbete?=
 =?us-ascii?Q?KTLYpU5VY2ubfAJMrzxCbu/W0olAax0m/XQpE91D7C6XKNeBhGngkeV5Pmb+?=
 =?us-ascii?Q?1iPGpYZdiG+x/ZCAU/uJctGQXZ83lZi7odmzQFvvBr1SdjHPzqt3q3hHD8Dh?=
 =?us-ascii?Q?cXzCk/2okEDuikC6NmyBc73S4xKtNFiGQ5kM2UQCliTEZWX9K5zdjOPwrwon?=
 =?us-ascii?Q?YE0t/HLI41JQonudtmOcW3xCQXPBw1ff1Pnvdan4193IY15s+ebIOGywAG0t?=
 =?us-ascii?Q?FmyTO9appvUo7uI3DGSv0RT0cXAD9XGJjdHk6P8iVt/xMc+cSa/Pmo2Rxhk5?=
 =?us-ascii?Q?2QZyx/jKfHBqcWpnqkY5DmqWINtxMTExImu2wKqeyntM2aYdj88abj8ZuNdC?=
 =?us-ascii?Q?Yl3Bs1yvLwL6Nl5alU93BDyRRo+udex3oxQEAAS7Krj5Sbd4A6vrcNt7En5h?=
 =?us-ascii?Q?+08HDNK6k9PXyynH4ARngKdd04wOCyFOAfHMBgxTpXKdLMkcPg22bwJNN95L?=
 =?us-ascii?Q?+FcTmG2lVSeQwKD490q3XqgfOHO2c0j2vfIhJO9zesu6EvcTEwRvAmcV7zmV?=
 =?us-ascii?Q?adKLbbO3czWJDVJP5uV+dVOiUmAJp0+b0lSf12amHAE15Gx432nJoxyLSuKp?=
 =?us-ascii?Q?JakDstafKt6nOPAOrd6vJ4kpJjFo1JSUqQv+sSMofxYbt4dEJ7xZWYYl12qb?=
 =?us-ascii?Q?utMVppzefgsXUpoPxA1EdsjJvbxARridBn0V7Xo4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a129e959-e58e-4d53-0a28-08dadcfdda7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 11:33:27.6407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev1uyNTc/fDahH4I3p/rBw/CmFCnW3INk6htsmWmdqPM9vPGRFmo8Se1x1TUEXT3AuejCHUCRNqO11XyutZQK5AVHk5WmsVokVNMHnMCjSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI,

Thanks for review it.

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, December 13, 2022 5:02 PM
> To: Liming Wu <liming.wu@jaguarmicro.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; alex.williamson@redhat.com; 398776277@qq.com
> Subject: Re: [PATCH] PCI/IOV: Expose error return to dmesg
>=20
> On Tue, Dec 13, 2022 at 04:16:07PM +0800, Liming Wu wrote:
> > There are many errors returned during the initialization of sriov,
> > such as -EIO/-ENOMEM, but they are not exposed to dmesg.
> > Let's expose the real errors to the user.
>=20
> Please provide motivation. It is pretty easy to see what went wrong even
> without info print in dmesg.
The background is that we use our smat nic in the ARM64 architecture server
The following code in the sriov_init() function threw an exception

if (resource_size(res) & (PAGE_SIZE - 1)) {

The resource size obtained from smat nic is 4096(it's incorrectly set to a =
fixed value in nic).
 But the PAGE_SIZE is 65536,=20
so sriov_init()  exits, but the relevant exception information is not found=
 in dmesg.=20

> >
> > In addition, -ENODEV doesn't make much sense and is not returned just
> > like any other capabilities.
> >
> > Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> > ---
> >  drivers/pci/iov.c   | 9 ++++++---
> >  drivers/pci/pci.h   | 2 --
> >  drivers/pci/probe.c | 6 +++++-
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> > 952217572113..519aa2b48236 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -767,8 +767,11 @@ static int sriov_init(struct pci_dev *dev, int pos=
)
> >  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
> >
> >  	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
> > -	if (!total)
> > +	if (!total) {
> > +		pci_info(dev, "SR-IOV capability is enabled but has %d VFs)\n",
> > +			total);
>=20
> total is always 0 in this print.
Spec describe PCI_SRIOV_TOTAL_VF reg (Total Virtual Functions) as below:
Indicates the maximum number of Virtual Functions (VFs) that can be associa=
ted
With the Physical Function (PF).
This values is HWInit in Single Root mode and must contain the same values =
as InitialVFs
In Multi-Root mode, the Multi-Root PCI Manager(MR-PCIM) can change this val=
ues.

I don't think total is always 0 in this print for it has been confirmed to =
have  SR-IOV capability Enabled.

My arm64 Server dmesg as follow:
# dmesg -T |grep -B 1 -i total_vf
[Tue Dec 13 04:02:34 2022] pci 0000:07:00.0: reg 0x18: [mem 0x80001c00000-0=
x80001c00fff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 255
--
[Tue Dec 13 04:02:34 2022] pci 0000:08:00.0: reg 0x18: [mem 0x80001a00000-0=
x80001a00fff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 255
--
[Tue Dec 13 04:02:34 2022] pci 0000:20:00.0: reg 0x18: [mem 0x80000200000-0=
x80000200fff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 255
--
[Tue Dec 13 04:02:34 2022] pci 0000:21:00.0: reg 0x18: [mem 0x80000000000-0=
x80000000fff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 255
--
[Tue Dec 13 04:02:34 2022] pci 0000:7d:00.0: reg 0x18: [mem 0x120f00000-0x1=
20ffffff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 3
--
[Tue Dec 13 04:02:34 2022] pci 0000:7d:00.1: reg 0x18: [mem 0x120b00000-0x1=
20bfffff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 3
--
[Tue Dec 13 04:02:34 2022] pci 0000:7d:00.2: reg 0x18: [mem 0x120700000-0x1=
207fffff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 3
--
[Tue Dec 13 04:02:34 2022] pci 0000:7d:00.3: reg 0x18: [mem 0x120300000-0x1=
203fffff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 3
--
[Tue Dec 13 04:02:34 2022] pci 0000:83:00.0: PME# supported from D3cold
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 8
--
[Tue Dec 13 04:02:34 2022] pci 0000:83:00.1: PME# supported from D3cold
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 8
--
[Tue Dec 13 04:02:34 2022] pci 0000:dd:00.0: reg 0x18: [mem 0x400120000000-=
0x4001200fffff 64bit pref]
[Tue Dec 13 04:02:34 2022] drivers/pci/iov.c: 632 [info]: read PCI_SRIOV_TO=
TAL_VF 0

>=20
> >  		return 0;
> > +	}
> >
> >  	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
> >  	i =3D PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0; @@ -899,13 +902,13 @@ in=
t
> > pci_iov_init(struct pci_dev *dev)
> >  	int pos;
> >
> >  	if (!pci_is_pcie(dev))
> > -		return -ENODEV;
> > +		return;
>=20
> Please at least compile patches before you send them.
OK, thanks.
How about return 0, or any other suggestions.
>=20
> >
> >  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> >  	if (pos)
> >  		return sriov_init(dev, pos);
> >
> > -	return -ENODEV;
> > +	return;
> >  }
> >
> >  /**
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > b1ebb7ab8805..c4836104f697 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -485,10 +485,8 @@ extern const struct attribute_group
> > sriov_vf_dev_attr_group;  #else  static inline int pci_iov_init(struct
> > pci_dev *dev)  {
> > -	return -ENODEV;
> >  }
> >  static inline void pci_iov_release(struct pci_dev *dev)
> > -
> >  {
> >  }
> >  static inline void pci_iov_remove(struct pci_dev *dev) diff --git
> > a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > b66fa42c4b1f..c951e0a50388 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2449,6 +2449,7 @@ void pcie_report_downtraining(struct pci_dev
> > *dev)
> >
> >  static void pci_init_capabilities(struct pci_dev *dev)  {
> > +	int ret;
> >  	pci_ea_init(dev);		/* Enhanced Allocation */
> >  	pci_msi_init(dev);		/* Disable MSI */
> >  	pci_msix_init(dev);		/* Disable MSI-X */
> > @@ -2459,7 +2460,10 @@ static void pci_init_capabilities(struct pci_dev=
 *dev)
> >  	pci_pm_init(dev);		/* Power Management */
> >  	pci_vpd_init(dev);		/* Vital Product Data */
> >  	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding
> */
> > -	pci_iov_init(dev);		/* Single Root I/O Virtualization */
> > +	ret =3D pci_iov_init(dev);		/* Single Root I/O Virtualization */
> > +	if (ret)
> > +		pci_err(dev, "SR-IOV: init failed (%d)\n", ret);
> > +
> >  	pci_ats_init(dev);		/* Address Translation Services */
> >  	pci_pri_init(dev);		/* Page Request Interface */
> >  	pci_pasid_init(dev);		/* Process Address Space ID */
> > --
> > 2.25.1
> >
