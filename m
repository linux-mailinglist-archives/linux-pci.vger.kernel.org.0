Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7244AD717
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359686AbiBHLbp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356400AbiBHKiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 05:38:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668DC03FEC0;
        Tue,  8 Feb 2022 02:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI1WraiZWwgTFCfNgC1V7eS3ha5ejAaAvfD6WXs4iTxIKQGyxNcRF7TPfGEUBPkFgjrORFp9m2uF0TVLenS4YMHk06a8hooF/CvsQWzjCdsMtt7prJ7AqcWTVLERmhc7sxS5I7OI3u4WMfCZEqghXn0LmkfLuFbAwvV5nqACOp+kf7Nbon9cEKxaWK5wLe5QPwPn9oMMklpsMRyiTLjGfe0ImhnXTgSFftvYjTcTE5g1vfTtVsXlN/bunPj1mO9Y96tG4d8exVMRXEZ1U2aI24hrK5RXgX4tZLHApJOwBwBKm+LKNDz/yaXj2/jifuSACwlhK8fvWaQ+SBazDiNJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oMxP3dPxhWKXBV92DaCS7Q1ov2+6rpwKOgu8Pho42E=;
 b=giYZI3yLmVhQRW29FXZP6uLqv7GFzhKZQkuhsrpDGF0h0BZnqqr48bz+uCMTzTSEzPMnTIOIpr/Eu1/XHDbjNIOYY/2GsVFLfxAgHgi1CuyKLi+TWi/HKTxeLg6Xam/Yt287HMLxuexIktvHE/p3Zz9aooakAClAyFyO9umrRM82Agk6h8/xu8aNMRnUxw4nsUzz4gSM8yj9GgQVZ3ZwA7yPNrMjfln3UelB+mxhdkGBvmGTLoVBjFRTmbuMUBizQ+cyRxSI8LJXRmNyHOcFbwqrb0AQZGgHNnvjhoOjnr7eDT88KVJ+5kskGlJXxJ88mS0yTMyPGxd05rq6dSJGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oMxP3dPxhWKXBV92DaCS7Q1ov2+6rpwKOgu8Pho42E=;
 b=FgA82pERrr342TkB0XLgZiqe+CURE++OrfNhF26MQlQIEeUk/YSggKxkutCrjAmRNH0DkHWDP+GHO/r3Af09urmuUWz2VHMoAbfQ/BKW9q1UJv/FQdNc4/lWN5a6P0R3LGhPdHDwzglmDj/QJQq9nvn2Hj6Q6TkzRW6+pRXfSr8=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by DM6PR02MB7003.namprd02.prod.outlook.com (2603:10b6:5:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 10:38:21 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::259b:b0b6:7574:328f]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::259b:b0b6:7574:328f%9]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 10:38:20 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port driver
Thread-Topic: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port driver
Thread-Index: AQHYG9kFP8Vxuz1vvUqhZX2L0Vr9iayIafIAgAEOR6A=
Date:   Tue, 8 Feb 2022 10:38:20 +0000
Message-ID: <BY5PR02MB6947352C282C1A84650D5B31A52D9@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220207041250.1658-4-bharat.kumar.gogada@xilinx.com>
 <20220207183046.GA408682@bhelgaas>
In-Reply-To: <20220207183046.GA408682@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1134bff-b8d2-4ff5-0eb6-08d9eaef2040
x-ms-traffictypediagnostic: DM6PR02MB7003:EE_
x-microsoft-antispam-prvs: <DM6PR02MB700373EFBEE8ACE6A998A866A52D9@DM6PR02MB7003.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fp/cJUD8NyamWFwXuNgqZYGnbwB0AQYES9rAOfI9KRxbDQQ8+lVJ/Aar7e/OVGdXNnDdefrB/yxS0c5dzZaOL6Vm1zodTCIDcJSgl+jFCTXZTiwSANo2tAlSSL3awWCpER3RLfw3xwCipXTpIvUE94Qayn1yIzPQRBgvpX75TdZ2al9hqBUsVWKTJhO/Glk8fWNj5/1n7YIE+tmMzhpv36VbZajQVJ9XmI6bhU4UNi2rB/RY3K0NPIVsrJlpccZSA6Nul5WEqGVdQ3bCkwY7QmJM378dd+EZhuf9SWcZKzG5RadRs8hO357FNb5hYZEh61uRA1vVP6hrn6PBUk7nzGtEqoTYOXeRRJoBNYCmmnq/nzqsXMU5bNkCHFuEEJKSnnc3vE1MKOFIRRII4ONFaiYBB+O0870giwJkNGzYDt6jILcPZ2O1efjKORv76X+XUQBTribjxDCUt1juJ9984/x25Jvd49+ehS24yOP505Xv5hju1MMEB+SKPh1/59l71BXarG78YraoaeHVFSJEJvBHeeKcwwyzXuJ/DsRLTNmewtN78vgxUWE7hVPfbRyuBwEyqc1FJlimCPOgyEvevUVGN9mxpuqmhpCiuYj3bDVq2MJ15LlPIc4j0cHVJUEI6lnEvjL1OznQ0+GN7XxPQokiWLomXvHq9+v5VRM3kaKf+OmpgwqG+1V4jaii8HAULT2Beh0W6NiFOpdOR8m3og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(107886003)(4744005)(86362001)(508600001)(122000001)(55016003)(38070700005)(71200400001)(54906003)(38100700002)(6916009)(186003)(26005)(9686003)(2906002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(8936002)(8676002)(7696005)(5660300002)(52536014)(33656002)(83380400001)(6506007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aw1mFqCclt3m3fD6jhICuwrWBhA1TTG3BwbvkSsOFTU0wYv6+BxiK95KLKpv?=
 =?us-ascii?Q?+djiwQKLlxdG3UulLU+PFKXUME3Mf65z20v1BrNe31Xa3udGflJIetBu/IOQ?=
 =?us-ascii?Q?lh9MD1jTxYJzW0jN5E3xGRwxjCHLFheQ9CPoNydsS99ga50YhPr1lMX6Kqgx?=
 =?us-ascii?Q?y99m2AAxUy9lPWJU2FIr46PVIR2Y2fd5sMmpwzwACbolSj5PtVNeoyqUD1Hh?=
 =?us-ascii?Q?JS/cKU9JE22cQyUhgLHc35J7axN3dsTMtng4mVMsdfSn9w/q1UUbWjQEtMDs?=
 =?us-ascii?Q?W1QaONcp7e3eG+0mELCtg+7h9Ta36g6dyIZIlUjdAOd4FhyCaT3QWp2NC/ge?=
 =?us-ascii?Q?1AOmHjEu25XADyrIeq+bQtzdymikv7s4291leSzvL0Fi8Arcr5eNFkWtP5Z7?=
 =?us-ascii?Q?2ppHJk1HbPb0aQcYg9rGiMpyoNwuM4T4S3VFSvBu0wPk4HVMf6T5CkbjY9xP?=
 =?us-ascii?Q?2J3VaN+1iwNugOwE83daKmN4jI3/I7rPQxqo5nALWh/r2UBfG5g4KQ5FErdC?=
 =?us-ascii?Q?PPDgL3zmrgiT11mDt1UBxKFaJ52XH4EgehboFl7qQBXcZHNnU3RyOO8vcYfd?=
 =?us-ascii?Q?DO1aqE53cQzPue1f310KCuhFt9npjxIR6YlqbQWS1504VWCYL3XTLkih6uJH?=
 =?us-ascii?Q?kQ2IGdRajWNH3w6jli6ZmPn3p8Iq3WqNaLtNXrcC4QRZfxdTrG2Nzt/7Nnaz?=
 =?us-ascii?Q?rsraQGFm4eD+mHIBtrRVDkx3ByFNqMbQd9jP8d5VAnVDsJ+LVQughyVnpfG5?=
 =?us-ascii?Q?1qjvPP+pebi1E0auIgQRiO47xCERyoR+VxDlRuGGFcxM8e2/PNHdfLDWNMcV?=
 =?us-ascii?Q?ywYsYHXsGwZjIivV8IH/n7XH4QYag6rd3Y3Y6Q6plaZUqjTwa2hX27dnWOv+?=
 =?us-ascii?Q?QBWTANPgQBome1fK8nUvSxErNItgbcb+wdYp8hGI1MWCiQDlsnLUmFoXuini?=
 =?us-ascii?Q?z9nq+D/G+ua0O/dhOwpLq2CWbJRpEgsP4ZHr/O2eHj3Y3oCbEE4ws1BAQkbj?=
 =?us-ascii?Q?EyiVCGSeYmOe+bvzmIutxiHqEJh6BePaOrVzrqb8a8vdzT1tiXnNYfw6WDaw?=
 =?us-ascii?Q?1ysVd4hpfLmDVzTuk0xbqCNOhmAaY4IVto5i7wEFCoX1L1RB/fVKNROISyz2?=
 =?us-ascii?Q?ivy0b3APtxbOToeGpcye9hnpK5tZSE69pFtGVoPeUHjKptyRqulibrGStDia?=
 =?us-ascii?Q?DuKGfQjvtZ0j93F2YsDBXIx3HwpvcvI8JWzV/IbtT6sA8qGCa2mxxOMmB53k?=
 =?us-ascii?Q?vA4R4tsvAv5kqf2W16oDKzCwyUwKWaSDXR0I+0S4tFclyH2HThT+pA42tH8t?=
 =?us-ascii?Q?rwnNLsav0PFqxTo4NVJoVLSt6hw/Pd6fvvY67av1z4cljiDDc2WP09XoEiBh?=
 =?us-ascii?Q?Hv48w0YMXdASaTEPZhM+F8Yss4pQWHPFoE1r9LkKYYICTYuDJ8sz1IaQEIbl?=
 =?us-ascii?Q?wzuBjSXOTWLNTihpmYQQ1fydupOj7GkXxNyjMeK72VRUsq3Lv+93GDeJ70d+?=
 =?us-ascii?Q?A2e+IpdwRY5c/NU6mriJtkZZiMyGBbE/Lae/BKNa8Rz2LXW3/bKMhClPoOqv?=
 =?us-ascii?Q?ktNPDK/QVxUUyrRcPxEsDprjstr0qeK2ycFNc1EpwO0vpQGqdjPMBy4FnxzJ?=
 =?us-ascii?Q?ItUWYkeXiZCL28Xnzl+LSes=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1134bff-b8d2-4ff5-0eb6-08d9eaef2040
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 10:38:20.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4Wmgv/JZd0XhcZZ0o0TM2U/4X1dJ4CFM2CJnCu2+0/jXDZIUy7wjUuPrEkpnt/iRQnSwYWAQfEjkRbBXHFw1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7003
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Roo=
t
> Port driver
>=20
> In subject, possibly:
>=20
>   PCI: xilinx-cpm: Add Versal CPM5 Root Port support
>=20
> since you're adding support for a *device*, not for a *driver*.
>=20
> On Mon, Feb 07, 2022 at 09:42:50AM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root port
> > functioning at Gen5 speed.
> > Xilinx Versal CPM5 has few changes with existing CPM block.
> > - CPM5 has dedicated register space for control and status registers.
> > - CPM5 legacy interrupt handling needs additional register bit
> >   to enable and handle legacy interrupts.
>=20
> s/Root port/Root Port/ to be consistent.
> Add blank line between paragraphs.
>=20
Thanks Bjorn, will do the changes in next patch.

Regards,
Bharat
