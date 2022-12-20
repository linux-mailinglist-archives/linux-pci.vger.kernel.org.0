Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D887B651CEA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 10:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLTJLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 04:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLTJLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 04:11:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D1D5F8B;
        Tue, 20 Dec 2022 01:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671527496; x=1703063496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yeRltF96HktLw9HQ5e7COlNTIMPHVkSPwHfgrwnb2es=;
  b=FOW0q6WyAuxzsmDTyaTuZPXxPPNgXccujjHvxk8cnLTv/+p0rL2PB374
   OPIxHrl4w1uZp5DFwTVZrPKHMNNeZiHwLjtzwlwTPrRo+8N1mZMGo5TBi
   9OGPFIDkZZ45wRL3PWunx+2htZv30OGCoJLZGZYfcWFrgulBy+afbkzb4
   y1uiB2/5mzW8G7vsv+CgcG0nnjFwPtHJN6lKMuJuw3cEimD9KpSSPQCXi
   hDZEIOWMKTm4np5OQi+7DBA8JofqD89J4zIBZmhSS5zN1yG6cgcinbyv6
   G6CNnnMg/sFH3ibjv1HcSLfpyfHA94ew+PmyTvexRTeMCl8x20iM1gvy3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="318261310"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="318261310"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 01:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="628653069"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="628653069"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2022 01:11:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 01:11:35 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 01:11:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 01:11:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 01:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWt20OVA6YUcxdPsaP+k6p7SL9T/Ea0A+YZHvYaMLEBvYdO1vQk32M4ZUDDXo4HmHuFzcfakTxOZBhcyvp/JWWSiFSw+Ms2RCPApxlssF9MMUjeE9WjroTvGUqgELC/dlpAZ7OM2kgMKTdcKxozJzQDQyynniz4zh2YkE6w7x3MLw5O8P6C4tzeFd1rCtRULMtydS4HEIIx9pj6tTWjXCAr0Do5LdvntF8tSmqm4wbgUlzoJbqfBxEwIqOS3bXhByOwjP6lboq7NkpvsVVHascfyM5EAdlgexK/p5mxKhXi5JWXS4DAvuzToLrFes4TiHA57/hfAHXWjeYGZDMUp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=movIvsPQr5k5XmEWLqo2X5ZuiEe2mkiBts9gG25OY+4=;
 b=QlG4wIhPS8/bRFHGzRdSX6uikUcTCBwBXXeDTSlPD3IoFgUDmbOYXknY6iE5VF2rpU04TZMmOiMqm3JSeOjB3SYkImRDdLMV6FS/373yLtVWDA5CmA0EXMojatncO9a4Tu98CMLm/k0cQaVI6ZAsH8jGY05RYWZEy0v3Neznp/+BkoGBW9eoNFHfJUCgz6CNTp66Zrvn5zB68kl07LlDfHLQQixh9ODVZV5ZE8cxPRyUpyqCrFQK6GKp+/TpL4a5d2l32f39C7VOHeFoZNCLJHRHAo0l/XDLqTNxdIZ55la5No3bPPTiGp4w97Z6FfqkwRzDb5CrdRRbmh5d/srMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3457.namprd11.prod.outlook.com (2603:10b6:208:64::24)
 by MN0PR11MB5985.namprd11.prod.outlook.com (2603:10b6:208:370::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 09:11:32 +0000
Received: from BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::c8a4:588c:d831:f6aa]) by BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::c8a4:588c:d831:f6aa%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 09:11:32 +0000
From:   "Lee, Ron" <ron.lee@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lmajczak@google.com" <lmajczak@google.com>,
        "Jain, Rajat" <rajatja@google.com>,
        Ron Lee <ron.lee.intel@gmail.com>
Subject: RE: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Thread-Topic: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Thread-Index: AQHZEGWaE406GK/6VUCqucUZkFrJaK5vD4AAgAGUZSCABd9bMA==
Date:   Tue, 20 Dec 2022 09:11:31 +0000
Message-ID: <BL0PR11MB3457C04B0BF3E0F06A8607F2FEEA9@BL0PR11MB3457.namprd11.prod.outlook.com>
References: <20221215091357.8738-1-ron.lee@intel.com>
 <20221215151604.GA107336@bhelgaas>
 <BL0PR11MB34577E415B692A2B1CB000ACFEE69@BL0PR11MB3457.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB34577E415B692A2B1CB000ACFEE69@BL0PR11MB3457.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3457:EE_|MN0PR11MB5985:EE_
x-ms-office365-filtering-correlation-id: 4bf0f867-f773-426a-906d-08dae26a2f96
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDtYHekJ0nbYLWl2Apg4bepEmQuaym1w6RxsTwO4oe2nZ91nf1pfsssr7xypKhVkqkw/C9te9WZ7QvBNv0g2wF+eKdCh5W6v+I29QQx1rEIQ4jB6x7FYQnR5ZlVGsIeJrdW8+yurFEjzx0zWCndJK+uBD2Akej2YZPmBDMDa8n7APYwOwoqSDyjJvxApXUM66no8FC9aB0boOeIdx2XrOJ3mwEFisuV6819aVYS4+i4GZlTWqJZQrW9vr4Wwgtbxlik7Q6eODCdrO0U6lhB/pfuhdbtM4W1EBhiFc4FXpmb7eRIiaqukbDJwjTPWnUEs51OvjG6qQx36Teh2DvJbz6lpZlGow2mRxLLadYNUxdsuPV869kCpYPJEYr6dE9aX8MRYg9QXYb1juGik64oX07kpaUtqS9TQzO1PxeYTktHyQ08XuUKnIe7//NQUo2R2g1af8E5BDx8SSOw4Yjl0A4q1WdFPdkCjmNtrw/cgo3spSt6mutgYTYyPOAkZO58r80ksG0uj3Z9wM7E2dP1JmUkaXRhBY6yNP9wxmu2QPgonrxd81mfckBDtC0znboAAa769YrZlv2TUJnOPTU35nQ3dUW1QcMess2n1y55bXfurXa/E65C8h+s1f1OtKCM5OuY8xyPh6QpECt1L/IZVT2WCX8Zfe18OndgAUd64ZZ6b5vPtHZ90/yFFlTSTajyDSchfcesS9S2nPLDkAtjM2I77tQndyuPdxjG1n8yDL2hghSgWmxTYtLccIl3m7nfsDOv8LcRbTOMnvF4J4hk1TMKS6rJaI/63sBqdaKJ99NDpHwL1Cv5qaf4PZ7J/M3mY3CIEr91l+9HAiYg0D7LvYbaCzUCmNIVM1akAmK0zyxs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(33656002)(54906003)(316002)(6916009)(66556008)(19627235002)(2906002)(55016003)(38100700002)(122000001)(186003)(26005)(66476007)(52536014)(86362001)(8676002)(478600001)(9686003)(64756008)(4326008)(8936002)(966005)(82960400001)(7696005)(6506007)(66946007)(71200400001)(76116006)(66446008)(38070700005)(41300700001)(5660300002)(83380400001)(32563001)(505234007)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zym6xykkIihOytjVMWuawJWcUCqYANvkEXtBYAOTeQjXi51EQ/TAFcZ9gMXI?=
 =?us-ascii?Q?yOe9nc4DBLXtoV2aRvAxzaW6QEb9n3qygHlZC/GFIEgvVhH54ANJeWIB40rW?=
 =?us-ascii?Q?54RwRI+5ZKMMqipRKgdzVWTxc/uxFkT6yxx53ePuyKlfVhuXKelU9y1d+3+u?=
 =?us-ascii?Q?pT7EMpkbsL6gxv9yqDGUyQakNq7G2JJvd7h7H5JPUk+G/AQXQijzH7BgwL7c?=
 =?us-ascii?Q?DU8Q/gnLDvbrD53msVdo13KspMZ9AIjpLUO9OrS62Be71mEGYSUs9SP16uzb?=
 =?us-ascii?Q?GSIywJJ6/uatBHV0x+oKo66h/bJk3FjPLXLYafFV8hSvE3RcIF+GktmJfab6?=
 =?us-ascii?Q?S7FmFn64s8uJUYK+zGcw5WFrekiP1Num+WygFm54KOHq7yoOEMo2DTv+MvHq?=
 =?us-ascii?Q?vXxnMv+2slvj6JF9vvVvLn4RriaPVkfrQWuKdDp8xe1PjmNTmRzi92LAilLg?=
 =?us-ascii?Q?RvnhZFjO6cgWIuy1qKR7rlcDF7lUUcvGef2pP4acRpGSvc0vH1izuSaHbGvW?=
 =?us-ascii?Q?d0fr4ghp+i3d4FwWr4l0PytD+nKi4zTeuaIaiKd8kLM4iGOHXzG9brZvVs/w?=
 =?us-ascii?Q?dbv3wcyGrOrKMUi//pZANTgLuln0GlKYQBb6nYQGxro2tN+oFJnQJQhQhlF4?=
 =?us-ascii?Q?ig54mx/cMMRzFBaZomzv8ZAJvSBOniK445KC4KT8uwrnG/udoJgCWiLv2qMQ?=
 =?us-ascii?Q?JnJJF2U4J9jOOOY3ihzEcwFaOITRB6O+GLw43aHOSDOLaBM7JYEDqb6IMAA4?=
 =?us-ascii?Q?G9nkgmc74ol0iw+xHzqrgL+Vxd/gWqcRpJTI5H25SSaoB+IvbmGMEhubvRp9?=
 =?us-ascii?Q?r1qdJXd7segPJm2+rfAUEs63PNgU3eIpRSXG+Yk95JAyrVewABrffXX66Y96?=
 =?us-ascii?Q?QhxbK1F5Na5ZciN4VVF+imp+ojU8/BhAQ0MOGDX48K+/IJXWzwlv4qGufnye?=
 =?us-ascii?Q?fgCjahVSU93lGKWf0kDPoxYjNuJB7DIY0JnnxjsKQCpzqLSmzOCv4mewFrkf?=
 =?us-ascii?Q?puH/PrPqoS+Vw7gE0A495E8Fsej95X1ZXUKD0/HwSCD0shLhUrz/f2e28T2m?=
 =?us-ascii?Q?j2NF0PzyFtohHoOdfP+MuzUGc6TTLJRyXz+mCjEUueEHRK6Fml65zpmjpJoM?=
 =?us-ascii?Q?1c+SxQPgswNTUpZLNgzcVLyNCjKlNfKWNAPFFchAOl8rt8aQhb61d1clH1ud?=
 =?us-ascii?Q?amtXWgCeQteFdY9ZXXqN6wHgD5bByq9KhIu8B25XF6nNhqwNfJSRai0G049d?=
 =?us-ascii?Q?D51hY1pE+mx0yCTnv6jw1XnbOg8TZkU38beEH9WmngaH6x92Cz87V8tUsoet?=
 =?us-ascii?Q?7d3iQT00QtsgBh+fNNxfZBsyUrMGxcJsTTZoUGoVRV93oLXWlxbZAHRXpJjC?=
 =?us-ascii?Q?EPow7JxUU4km/aO/Knjpo9hHz6NaIWrMbERQglNFZCWnrx4MUqbVjfr9iYkP?=
 =?us-ascii?Q?mBZnBpLSvxg/NI0cbSyqYXntLzzNdy8/aw2s/6iSUfdBe0KjX47bjS51P4aP?=
 =?us-ascii?Q?7QDn3PuO3CX+QbD3B7NF54rBwlb1xAk4kk3TIsFjuyEtvBdmFrtaeCqL3WXq?=
 =?us-ascii?Q?LwlG6VWyl6xLZxP3YjRYRNA3JQ79Rn7uuGuBxDSM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf0f867-f773-426a-906d-08dae26a2f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 09:11:31.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx+wAy+tWfqxpb3gFsXgQ9BPE+8DPLq1T/xPGLk5zxdF8FbHcyuGAfC0SKFTHmKdG23283EA5BiIbeHxIFbFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5985
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Fri, Dec 16, 2022 at 04:29:39PM +0000, Lee, Ron wrote:
> > > On Thu, Dec 15, 2022 at 05:13:57PM +0800, Ron Lee wrote:
> Even if you haven't seen a battery life issue, I suspect you might be=20
> able to measure a power consumption difference if you looked for it=20
> and likely could see issues with manual ASPM enable/disable using=20
> sysfs.  That might be a legitimate reason for this quirk, and if it is, w=
e should mention it here.
We can arrange the power measurement, but I doubt this quirk has correlatio=
n to power consumption.=20
My point is that the ASPM behavior is not changed with or without this quir=
k.
>=20
> > The following merged commit can save/restore the
> > L1SubCap/L1SubCtl1/L1SubCtl2 registers for this bridge, However this=20
> > bridge not only lost its capability contents but also lost the link=20
> > to this capability.
> >
> >     PCI/ASPM: Save/restore L1SS Capability for suspend/resume
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c
> > om
> >
> mit/drivers/pci/pcie/aspm.c?h=3Dv6.1&id=3D4257f7e008ea394fcecc050f1569c35=
0
> > 3b8bcc15
>=20
> The current version of that code:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre
> e/driver
> s/pci/pcie/aspm.c?id=3Dv6.1#n760
> doesn't search for the L1SS capability; it uses dev->l1ss just like=20
> your patch does.  So it should restore the capability even though the lin=
ked list is broken.

Vidya's patch definitely can restore the L1SS capability, the dev->l1ss is =
still valid and
L1SubCtl1/L1SubCtl2 are restored after resume. With Vidya's V4 patch I thin=
k although=20
the L1SS capability is missing after resume , it didn't change the ASPM beh=
avior,=20
the ASPM function may still remain normal and same as before suspend. =20

But Vidya's patch didn't restore L1SS capability header and the pointer to =
L1SS capability,=20
this is the purpose of this quirk, it just reflect the bridge's current L1S=
S status authentically.
i.e. the user and developer can see the L1 PM substates through lspci comma=
nd.

For reference, the following is PCI config dump of this bridge between susp=
end/resume.

Before Suspend:
...
150: 00 00 00 20 00 04 00 00 00 00 00 00 00 00 00 00    <-- point to L1SS c=
apability at offset 0x200
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 1e 00 01 22 1f 28 28 00 0f 28 03 60 f0 00 00 00      <-- here is L1SS =
capability
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 7f 7f 7f 7f

After Resume:
...
150: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00       <-- The pointer =
to L1SS capability was cleared
160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
200: 00 00 00 00 1f 28 28 00 0f 28 03 60 f0 00 00 00       <-- L1SS capabil=
ity header was cleared too

>=20
> >
> > This issue could be and should be fixed by BIOS, however the=20
> > manufacturers have no resource for firmware validation and it's=20
> > risky for firmware update per their assessment.
>=20
> This fix is risky, too, because it writes to random places in config=20
> space and there's no guarantee that this is safe or even that the=20
> capabilities are at those locations.
Agree.

>=20
> > > Is there a bug report for this issue?  Include the URL here.
> > >
> > > Is there a bug report for the firmware?
> > >
> > There is a Google's internal issue tracker for this bug, seems not=20
> > available for public.
>=20
> Maybe you can make a public report with any secret details removed?
> A simple email would be enough.  I haven't seen the internal issue;=20
> hopefully it has more details than are in this patch.
Sorry, I forget Lukasz ever filed a bug report for this, please see=20
https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7i=
G53yaLBaQg@mail.gmail.com/T/#u

>=20
> > Actually this bug had a discussion on this thread, and Lukasz=20
> > Majczak identified this issue on Apollo Lake platform.
> > https://patchwork.kernel.org/project/linux-pci/patch/20220705060014.
> > 10
> > 050-1-vidyas@nvidia.com/
>=20
> That patch mentions Dell XPS 13, not a Chromebook, so your patch=20
> wouldn't affect it.  Are you saying this issue is common across all Apoll=
o Lake platforms?
> If so, maybe a fix should be more generic?

The history is
1. Apollo Lake's bridge DSP is connected to a WiFi card, the WiFi card cras=
h while system resume due to Vidya's save/restore L1SS patch.
2. Vidya submitted V4 save/restore L1SS patch, and it work fine now.
3. However Lukasz found the bridge's L1SS capability still disappear even a=
pplying Vidya's V1-V4 patch

Allow me to excerpt one of their discussion,
    Hi Vidya,

    The results from my previous mail are for V3 of your patch;
    Amberlake - works fine
    Apollolake - still the same issue, but here it is not related to your
    changes (we are still working on this).

    Best regards,
    Lukasz

>=20
> My point is that there is no PCI requirement for capabilities to be at
> 0x150 and 0x220.  The only defined way to find these capabilities is=20
> to traverse the list starting at offset 0x100.
>=20
> The L1SS capability at pdev->l1ss is reasonable since we found it by=20
> traversing that list, but 0x150 and 0x220 are magic numbers with no=20
> justification.  We have no reason to believe there are capabilities there=
.
>=20
I agree that, I ever try to recover the link by traversing list, but it did=
n't work and the capability list have no method to do reverse traversal.
One approach may save the whole capability list before suspend, and check e=
ach capability link then restore the missing one after resume.
Do you think it's practical ? It is appreciated if you could recommend a pr=
actical solution for this issue.

> We might know this based on device-specific knowledge of the Root=20
> Port.  If that's the case, please cite the Intel spec for device 5ad6=20
> so we can tell this quirk can't be blindly applied to other Root Ports.
>=20
> > > > +	/* Fix up the pointer to L1SS Capability*/
> > > > +	pci_write_config_dword(pdev, 0x150, pdev->l1ss << 20); }=20
> > > > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6,=20
> > > > +chromeos_fixup_apl_bridge_l1ss_capability);
> > > > +#endif

