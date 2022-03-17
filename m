Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152744DCF6C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 21:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiCQUhg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCQUhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 16:37:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D014A3CB;
        Thu, 17 Mar 2022 13:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avQOxoW756tiYpzRX7YsEZ7OHHDle7BXuWTftLXaYPA2YPbZRE9RXtp0A5Hy6hoQS3kbhddcnxIFzfrESlrot7QZBcACachJkkLlwVrUm1YYogKrotYmERn6Hys514UVFgcE2+umK66zTORQZpyZ0swZH4xvXI0nZc5QpbGO0ySz9rca6LMDsXQ29/EQ1ZM4ovExDeMZz5GrG4zaWKYPg3lqHSJJj1a4cl4IduqTP18hdOCDspz9pUlr0to2o+KJCCUGYyzNMiyo45LZx19PPIBvZQSfhE54RL3gbdYfMl4byCIYodZfaLV7kVj+LO4Ak6kvipXys/MEI7BSKWp4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/araM3ZAckFIhLXK5X/ReSmXrMNfbzQG7UdPySz9ZQ=;
 b=Z6R0wflJ07gknMr50OXxj8RYykWatFGO+iyxH/jHuZxLL0X3yjCpCO6YBLNI0aNlR6Rzj8IBXfebSwZ1C+vBzcuqpHG1yy13f16Uw/q/U+JKgUnKamTTrCo/n4WyzuTe2AypJs+B9f2OVnlx/ROveKRhcI2Y2jsqptHZRth2t83J5vg/JzEt+i7YDT648JtBHva2hvU51uuV0cjdYtdQ30hHnYH4Zg2je7/FFdm0wcOPHPfpY1SH2iMK8zSDt+79R4+V9thtEcx7kgQg3cvjqwQbmN0xuSY58/ansMM8vn4xZyLMi3XHvF7HezhcYyOPGS4SW81xjb8JBpJBMz4ayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/araM3ZAckFIhLXK5X/ReSmXrMNfbzQG7UdPySz9ZQ=;
 b=XkMukia70h7nq7cYKqBLWmwBpJSfwFLKLUNZ0IgWCcCJLHi0NNzBwaKthqGDTy5aw5XxBke++4zb+gqL/Hosd7C3LH/ZBoym/dzWwD7CrPttj03hp7o2PlBeQgTyhHpbSZl6KzwAeV63VzZAGPXHf+hWh6tuZJAomTvNoABTEjo=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB2467.namprd12.prod.outlook.com (2603:10b6:207:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 20:36:13 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 20:36:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Thread-Topic: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Thread-Index: AQHYOhp64mDBz0dixEuTVKpvZlnwUazDzQWAgAA7e0A=
Date:   Thu, 17 Mar 2022 20:36:13 +0000
Message-ID: <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-17T17:05:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3841583d-c068-40ec-8aff-6eddf12732e4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-17T20:36:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f049c9b2-9aee-4f7a-8288-d0cd4b64a700
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b77bf98b-a52e-48a1-2ea3-08da0855c77c
x-ms-traffictypediagnostic: BL0PR12MB2467:EE_
x-microsoft-antispam-prvs: <BL0PR12MB246721B7753E0F5CFAEC4457E2129@BL0PR12MB2467.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hmwp3vfbOYVIxHa2UdMQtrKSn3iCi3Lry40iKqWoeHQyhXILcMVkvyx7Njj/bxuCB/g6RSxG+HCiEgQnkGTpP17CDuUZz4xXUbDScLOWInmMlIDhSbRiwtLqkEmRftkvSAiQYxxoBt24LSEevbKzyvh8sX28G1cjlliUFjXsxDse03X/8Dt/XOwEo3PC2/F/P4YA8FVvklOmPG31eiN6EbxJ/6JSg6Vawo69VsGPJlRmpbP5BCNv0/err7bEgct7p3na9l429kWCwwHL/qu8HBO4haWmOuDpln8z0x2kYyw8NRIR85CAm6rAn6rA6GFpP0k4h1n2twNHXv9g45FmlKohAwpVFVlTu4sm61PYr0lMPaxcySQ8bBVS/O60dvwoKHtljzBhE5kh/YIYUk3SUk854OEW8cvAFrTXqHiZxmZ0gfCx5yLc/guSUBesceHSR3PLZiRsm2jaUiAHUm2G9N42YwfgupXXj84trr43/QUg8WEJfG2/lQZGN/JudyHVmXpJgtDpzKgz1QPo89prb5XClmFJ+FHdw0jll/ClM4ncbTnrDL4fBVToDAFUGZLch0ppOzoEZMvP1EN8to+mTJWMaw4j3tYy85FfgA8AL2wWz3arNXxWVD4kH+nYigX9Pz0L6ptlt7fH9cCxwGgPyU3o9uCxZ7QYATRv1mJSD/J96L1iKqJYSHmva5hpAByMQ3WHF6nlVI8zmyBrI+BNUkN0Qo6Pm/VyBD9sDquRIaAL6lfAxBM9vtv9DNeZofX1B5jgEl6pr4wpi2kbfzolTsDIQAQKxrFdV4MTbBdcFng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(83380400001)(38070700005)(186003)(122000001)(26005)(38100700002)(8936002)(110136005)(5660300002)(52536014)(66446008)(66476007)(8676002)(4326008)(30864003)(33656002)(66556008)(64756008)(55016003)(2906002)(66946007)(45080400002)(508600001)(9686003)(2940100002)(966005)(6506007)(7696005)(53546011)(76116006)(316002)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dkRPPwYqidKCsGcbmdfaK9TMhRCWUUyKq2Sl8Y/hD6zpGojlY6t5Facupyx/?=
 =?us-ascii?Q?QBNdfJ2ugHEYwMPQWhJEaqzWHhXPqcHcu45Y0NTzTXtg0sSPJ9lyM1pYyp/G?=
 =?us-ascii?Q?ddho9fsOuK4oDnDLbIbtYM3ZW0ylviZDQxceJixt4Op+C62MsCLR2nMQhzlo?=
 =?us-ascii?Q?jJemcJsFnriDVbRj2ia11QaXbFVgFWO1EuIQraZOw/PurxHM6diKA6ZmpzDh?=
 =?us-ascii?Q?tibM98+vGl23vpje/SpgvPN48YfjKVLMZ4Q0y8V/PdX90w04Izj8jZPqYlef?=
 =?us-ascii?Q?KjKampS+oOrmojiHvxaTa26pj+GRowsL9buxx+DL44R3HsMJ6qLna2Va2X1D?=
 =?us-ascii?Q?QCYxNkM15I06v/pMxISRf5WIY8dOEhTFUc+HdAKMFqax1iEv5s4mqIBj5y28?=
 =?us-ascii?Q?Q+HlwamMCFIukr0nCCf6JUcOyxNxElNtCA+cTdZYdQ5betXE6/opG7aihDwD?=
 =?us-ascii?Q?yX9BGZr1ItaGfzfzMxGc5+tuZagum6T30DmENgGL0RiY6x5K156JC5CHXehH?=
 =?us-ascii?Q?+mKajfz4aDzeDVInttgnuZ5d/eZcnuZkGC+VJULq8CWfjc51V/B0MZyrKEzG?=
 =?us-ascii?Q?pZ+/gPx17C5NsRzDXczETMi6NFtU6ard621jzpAjAtl3efmRjeHWiIqhBHIP?=
 =?us-ascii?Q?DhGgnh7Fe3dFc0vbVGQy5pH/n5nFym8GRLD7NQCIxW5GJhmVyqfz1KgiiCx5?=
 =?us-ascii?Q?z9euoOTnMfCPUvHfxFAzlIUgzNicvGvVyJjDp2OHecVSo3DB6Jh89f5Q3ui4?=
 =?us-ascii?Q?mMFM7lRpqyhbRpwLj/C3cKJGUxek6ZWX15KB0J1+j03A2JnJZwHIv8b0ml1Y?=
 =?us-ascii?Q?KdvYwLDa+e0U+1VAjfi0a079IPL5qkAKYfZXMtBcChXSaallR0BuME8rANgH?=
 =?us-ascii?Q?l7gmGSt6W5/WSR7Tt5zmij2WfBz3PGemxnwn4Cl/QJFlAQNjeE/wgh9jv0Zs?=
 =?us-ascii?Q?OvkMDzFnfGbU3oZIIW3GQm+SDgbxxvVZxcok+tWlH9cSGaVu95YOX2WxBJUP?=
 =?us-ascii?Q?qX6sOd4/X7yjnaa07ugA2ciRVifqwFS4p8aX6HUeW82c2GbF/Wir+8uHQ336?=
 =?us-ascii?Q?wjSC7VQgdrB/twmMeGWyrBgT1TpSJ7F7S2RwwbTjQ3+nryhC2j4dqDpz7BXV?=
 =?us-ascii?Q?v+IiiwmIWsnXR7xTHwr6ypq8IelMu61bL1pjXLcxqEffFpVx1taEqUIjKyJ7?=
 =?us-ascii?Q?Zix/Q3QnLhgj+QqzsFkfIbTyZoxREkpKNhcnSQpn3rDxqD8GbsRike5KgZMM?=
 =?us-ascii?Q?l6qvnK3hXu1rcC+IuG6TeMMaJFHfv/Famfw/W/Xm8qQgevQwmbg9JOJax7UH?=
 =?us-ascii?Q?a5IKCHCJB/Zh1MPHBTOyzBoA7TtAZ2uxxrkR4YyRtcya9FhKBJmVmNFvzjK0?=
 =?us-ascii?Q?0AyS1Z5BDXlINfqgyb/yikH1K8IqEnpUJXT/RTwzQnstdysx0khXSf7fC4Rg?=
 =?us-ascii?Q?ox8kdNVkv4KVBYHTQnaGevDKKyqLHYKo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77bf98b-a52e-48a1-2ea3-08da0855c77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 20:36:13.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F596fdPjj4az94/bC1MHq3MtvHrPlLZw8duv3GY4K4wu3VU+wz34eq+TziTFLzIP+57NJb8RkJUygZjA3/bAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Limonciello, Mario
> Sent: Thursday, March 17, 2022 12:09
> To: Robin Murphy <robin.murphy@arm.com>; andreas.noever@gmail.com;
> michael.jamet@intel.com; mika.westerberg@linux.intel.com;
> YehezkelShB@gmail.com
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org
> Subject: RE: [PATCH] thunderbolt: Make iommu_dma_protection more
> accurate
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Robin Murphy <robin.murphy@arm.com>
> > Sent: Thursday, March 17, 2022 11:17
> > To: andreas.noever@gmail.com; michael.jamet@intel.com;
> > mika.westerberg@linux.intel.com; YehezkelShB@gmail.com
> > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org; Limonciell=
o,
> > Mario <Mario.Limonciello@amd.com>
> > Subject: [PATCH] thunderbolt: Make iommu_dma_protection more
> accurate
> >
> > Between me trying to get rid of iommu_present() and Mario wanting to
> > support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
> > shown
> > that the iommu_dma_protection attribute is being far too optimistic.
> > Even if an IOMMU might be present for some PCI segment in the system,
> > that doesn't necessarily mean it provides translation for the device(s)
> > we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really
> does
> > is tell us that memory was protected before the kernel was loaded, and
> > prevent the user from disabling the intel-iommu driver entirely. What
> > actually matters is whether we trust individual devices, based on the
> > "external facing" property that we expect firmware to describe for
> > Thunderbolt ports.
> >
> > Avoid false positives by looking as close as possible to the same PCI
> > topology that the IOMMU layer will consider once a Thunderbolt endpoint
> > appears. Crucially, we can't assume that IOMMU translation being enable=
d
> > for any reason is sufficient on its own; full (expensive) DMA protectio=
n
> > will still only be imposed on untrusted devices.
> >
> > CC: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >
> > This supersedes my previous attempt just trying to replace
> > iommu_present() at [1], further to the original discussion at [2].
> >
> > [1]
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> > kernel.org%2Flinux-
> >
> iommu%2FBL1PR12MB515799C0BE396377DBBEF055E2119%40BL1PR12MB515
> >
> 7.namprd12.prod.outlook.com%2FT%2F&amp;data=3D04%7C01%7Cmario.limo
> >
> nciello%40amd.com%7C14f5afbba9624b4d0ef508da08319b2a%7C3dd8961fe4
> >
> 884e608e11a82d994e183d%7C0%7C0%7C637831306409535091%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> >
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D9xJ9bNT3pR3YhqOOqiJtGv94ln2
> > IJSvrXllbPZjTI6M%3D&amp;reserved=3D0
> > [2]
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> > kernel.org%2Flinux-iommu%2F202203160844.lKviWR1Q-
> >
> lkp%40intel.com%2FT%2F&amp;data=3D04%7C01%7Cmario.limonciello%40amd
> >
> .com%7C14f5afbba9624b4d0ef508da08319b2a%7C3dd8961fe4884e608e11a8
> >
> 2d994e183d%7C0%7C0%7C637831306409535091%7CUnknown%7CTWFpbGZs
> >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> >
> 0%3D%7C3000&amp;sdata=3DwSbpjpPQk8ulX8ifOTt%2BNMdO5svwQceQthyca
> > txzScI%3D&amp;reserved=3D0
> >
> >  drivers/thunderbolt/domain.c | 12 +++---------
> >  drivers/thunderbolt/nhi.c    | 35
> > +++++++++++++++++++++++++++++++++++
> >  include/linux/thunderbolt.h  |  2 ++
> >  3 files changed, 40 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.=
c
> > index 7018d959f775..d5c825e84ac8 100644
> > --- a/drivers/thunderbolt/domain.c
> > +++ b/drivers/thunderbolt/domain.c
> > @@ -7,9 +7,7 @@
> >   */
> >
> >  #include <linux/device.h>
> > -#include <linux/dmar.h>
> >  #include <linux/idr.h>
> > -#include <linux/iommu.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/slab.h>
> > @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct
> > device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> >  {
> > -	/*
> > -	 * Kernel DMA protection is a feature where Thunderbolt security is
> > -	 * handled natively using IOMMU. It is enabled when IOMMU is
> > -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> > -	 */
> > -	return sprintf(buf, "%d\n",
> > -		       iommu_present(&pci_bus_type) &&
> > dmar_platform_optin());
> > +	struct tb *tb =3D container_of(dev, struct tb, dev);
> > +
> > +	return sprintf(buf, "%d\n", tb->nhi->iommu_dma_protection);
> >  }
> >  static DEVICE_ATTR_RO(iommu_dma_protection);
> >
> > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > index c73da0532be4..e12c2e266741 100644
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/pci.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/iommu.h>
> >  #include <linux/module.h>
> >  #include <linux/delay.h>
> >  #include <linux/property.h>
> > @@ -1102,6 +1103,39 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
> >  		nhi->quirks |=3D QUIRK_AUTO_CLEAR_INT;
> >  }
> >
> > +static void nhi_check_iommu(struct tb_nhi *nhi)
> > +{
> > +	struct pci_dev *pdev;
> > +	bool port_ok =3D false;
> > +
> > +	/*
> > +	 * Check for sibling devices that look like they should be our
> > +	 * tunnelled ports. We can reasonably assume that if an IOMMU is
> > +	 * managing the bridge it will manage any future devices beyond it
> > +	 * too. If firmware has described a port as external-facing as
> > +	 * expected then we can trust the IOMMU layer to enforce isolation;
> > +	 * otherwise even if translation is enabled for existing devices it
> > +	 * may potentially be overridden for a future tunnelled endpoint.
> > +	 */
> > +	for_each_pci_bridge(pdev, nhi->pdev->bus) {
> > +		if (!pci_is_pcie(pdev) ||
> > +		    !(pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> > +		      pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
> > +			continue;
> > +
>=20
> Unfortunately I don't think this logic holds for the topology I see.
>=20
> Here is the NHI on a system I have here:
> $ lspci -vvv -s 64:00.5
> 64:00.5 USB controller: Advanced Micro Devices, Inc. [AMD] Device 162e
> (prog-if 40)
>         Subsystem: Advanced Micro Devices, Inc. [AMD] Device 162e
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 42
>         Region 0: Memory at b0500000 (64-bit, non-prefetchable) [size=3D5=
12K]
>         Capabilities: <access denied>
>         Kernel driver in use: thunderbolt
>         Kernel modules: thunderbolt
>=20
> The links it makes (from those _DSD) are:
> $ ls /sys/bus/pci/drivers/thunderbolt/0000\:64\:00.5/ | grep consumer
> consumer:pci:0000:00:03.1
> consumer:pci:0000:64:00.3
>=20
> $ lspci -s 64:00.3
> 64:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Device 15d6
> $ lspci -s 00:03.1
> 00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 14cd
>=20
> Looking at the topology the PCIE root port for tunneling (00:03.1) isn't =
actually
> on the same bridge.
> $ lspci -t
> -[0000:00]-+-00.0
>            +-00.2
>            +-01.0
>            +-01.2-[01]----00.0
>            +-02.0
>            +-02.4-[02]----00.0
>            +-03.0
>            +-03.1-[03-32]--
>            +-04.0
>            +-04.1-[33-62]--
>            +-08.0
>            +-08.1-[63]--+-00.0
>            |            +-00.1
>            |            +-00.2
>            |            +-00.3
>            |            +-00.4
>            |            +-00.5
>            |            +-00.6
>            |            \-00.7
>            +-08.3-[64]--+-00.0
>            |            +-00.3
>            |            +-00.4
>            |            +-00.5
>            |            \-00.6
>            +-14.0
>            +-14.3
>            +-18.0
>            +-18.1
>            +-18.2
>            +-18.3
>            +-18.4
>            +-18.5
>            +-18.6
>            \-18.7
>=20
> How about in this function to have two cases:
> * the one that looks at links
> * and if no links then the logic you have in place?

Here is a proposal on top of what you did for this. =20
The idea being check the ports right when the links are made if they exist=
=20
(all the new USB4 stuff) and then check all siblings on TBT3 stuff.

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 79b5abf9d042..89432456dbea 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -14,6 +14,7 @@
 static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *d=
ata,
                                    void **return_value)
 {
+       enum nhi_iommu_status iommu_status =3D IOMMU_UNKNOWN;
        struct fwnode_reference_args args;
        struct fwnode_handle *fwnode;
        struct tb_nhi *nhi =3D data;
@@ -91,6 +92,8 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u=
32 level, void *data,
                if (link) {
                        dev_dbg(&nhi->pdev->dev, "created link from %s\n",
                                dev_name(&pdev->dev));
+                       if (iommu_status !=3D IOMMU_DISABLED)
+                               iommu_status =3D nhi_check_iommu_for_port(p=
dev);
                } else {
                        dev_warn(&nhi->pdev->dev, "device link creation fro=
m %s failed\n",
                                 dev_name(&pdev->dev));
@@ -101,6 +104,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle,=
 u32 level, void *data,

 out_put:
        fwnode_handle_put(args.fwnode);
+       nhi->iommu_dma_protection =3D (iommu_status =3D=3D IOMMU_ENABLED);
        return AE_OK;
 }

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index e12c2e266741..b5eb0cab392f 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1103,10 +1103,30 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
                nhi->quirks |=3D QUIRK_AUTO_CLEAR_INT;
 }

+enum nhi_iommu_status nhi_check_iommu_for_port(struct pci_dev *pdev)
+{
+       if (!pci_is_pcie(pdev) ||
+           !(pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
+            pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM)) {
+               return IOMMU_UNKNOWN;
+       }
+
+       if (!device_iommu_mapped(&pdev->dev)) {
+               return IOMMU_DISABLED;
+       }
+
+       if (!pdev->untrusted) {
+               dev_info(&pdev->dev,
+                       "Assuming unreliable Kernel DMA protection\n");
+               return IOMMU_DISABLED;
+       }
+       return IOMMU_ENABLED;
+}
+
 static void nhi_check_iommu(struct tb_nhi *nhi)
 {
-       struct pci_dev *pdev;
-       bool port_ok =3D false;
+       enum nhi_iommu_status iommu_status =3D nhi->iommu_dma_protection ?
+                                       IOMMU_ENABLED : IOMMU_UNKNOWN;

        /*
         * Check for sibling devices that look like they should be our
@@ -1117,23 +1137,13 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
         * otherwise even if translation is enabled for existing devices it
         * may potentially be overridden for a future tunnelled endpoint.
         */
-       for_each_pci_bridge(pdev, nhi->pdev->bus) {
-               if (!pci_is_pcie(pdev) ||
-                   !(pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
-                     pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
-                       continue;
-
-               if (!device_iommu_mapped(&pdev->dev))
-                       return;
-
-               if (!pdev->untrusted) {
-                       dev_info(&nhi->pdev->dev,
-                                "Assuming unreliable Kernel DMA protection=
\n");
-                       return;
-               }
-               port_ok =3D true;
+       if (iommu_status =3D=3D IOMMU_UNKNOWN) {
+               struct pci_dev *pdev;
+               for_each_pci_bridge(pdev, nhi->pdev->bus)
+                       if (iommu_status !=3D IOMMU_DISABLED)
+                               iommu_status =3D nhi_check_iommu_for_port(p=
dev);
        }
-       nhi->iommu_dma_protection =3D port_ok;
+       nhi->iommu_dma_protection =3D (iommu_status =3D=3D IOMMU_ENABLED);
 }

 static int nhi_init_msi(struct tb_nhi *nhi)

diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 69083aab2736..1622d49b1763 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -11,6 +11,13 @@

 #include <linux/thunderbolt.h>

+enum nhi_iommu_status {
+       IOMMU_UNKNOWN,
+       IOMMU_DISABLED,
+       IOMMU_ENABLED,
+};
+enum nhi_iommu_status nhi_check_iommu_for_port(struct pci_dev *pdev);
+
 enum nhi_fw_mode {
        NHI_FW_SAFE_MODE,
        NHI_FW_AUTH_MODE,

>=20
> > +		if (!device_iommu_mapped(&pdev->dev))
> > +			return;
> > +
> > +		if (!pdev->untrusted) {
> > +			dev_info(&nhi->pdev->dev,
> > +				 "Assuming unreliable Kernel DMA
> > protection\n");
> > +			return;
> > +		}
> > +		port_ok =3D true;
> > +	}
> > +	nhi->iommu_dma_protection =3D port_ok;
> > +}
> > +
> >  static int nhi_init_msi(struct tb_nhi *nhi)
> >  {
> >  	struct pci_dev *pdev =3D nhi->pdev;
> > @@ -1219,6 +1253,7 @@ static int nhi_probe(struct pci_dev *pdev, const
> > struct pci_device_id *id)
> >  		return -ENOMEM;
> >
> >  	nhi_check_quirks(nhi);
> > +	nhi_check_iommu(nhi);
> >
> >  	res =3D nhi_init_msi(nhi);
> >  	if (res) {
> > diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
> > index 124e13cb1469..7a8ad984e651 100644
> > --- a/include/linux/thunderbolt.h
> > +++ b/include/linux/thunderbolt.h
> > @@ -465,6 +465,7 @@ static inline struct tb_xdomain
> > *tb_service_parent(struct tb_service *svc)
> >   * @msix_ida: Used to allocate MSI-X vectors for rings
> >   * @going_away: The host controller device is about to disappear so wh=
en
> >   *		this flag is set, avoid touching the hardware anymore.
> > + * @iommu_dma_protection: An IOMMU will isolate external-facing
> ports.
> >   * @interrupt_work: Work scheduled to handle ring interrupt when no
> >   *		    MSI-X is used.
> >   * @hop_count: Number of rings (end point hops) supported by NHI.
> > @@ -479,6 +480,7 @@ struct tb_nhi {
> >  	struct tb_ring **rx_rings;
> >  	struct ida msix_ida;
> >  	bool going_away;
> > +	bool iommu_dma_protection;
> >  	struct work_struct interrupt_work;
> >  	u32 hop_count;
> >  	unsigned long quirks;
> > --
> > 2.28.0.dirty
