Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1C63A0B1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiK1Eu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK1Euz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:50:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093FDEA2;
        Sun, 27 Nov 2022 20:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669611054; x=1701147054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gd2rcBoTLKwEW0MFfMEi+/lb7fjkyzznSjFNuGie9aM=;
  b=gUO5oUVi1PwjiJNzsuzmSthmSVMr4M7J3rsykwhoRHwN3YkmAAD6tElk
   Y9iqLP07/R3WGoHXxsznY2CYLmyZvd1Frtn+jmI6p5KOyRiQ1vzIjI5C3
   5JMYPXzQpa0rt1xPOR8sP8DNhby3DS9cpvraq1q3IvgczryPG8P2mYAcU
   IOuAZm1R0QC/FxPNb2FWPmHKZtLUXq3Oia5k0cCb3/jeeP53jUwY55qLX
   f6nmFfzC0Wm1qyxR1CCP2RHK/z2z1kG2rh2f0kL1NL8hQyKKbnJnjCMvJ
   HCuj8VBISWbrLYf98wzQA8/WY68JxQ2Za7rRViQVGRCk/hpKAvj0aC0w2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="295131363"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="295131363"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817685820"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="817685820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2022 20:50:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 20:50:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 20:50:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 20:50:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbq/p7Ade2Mtq2sWBLa27dRxN4QZ/FVn7ljdAjDlJARGXg+d5n1QN4fTg7zxecNZQ6toppmRmo+VoE0p0tgBt0B7hgCs0a8bX0Oe5E94IS4s58Ii6k2MW34oqh76OJoqixQxqjtNDhmXsV2uE2DxZa3G7ERgHUsnys/i5E3y1gpo7p8dRfkkAJCIHXwDXvb+bjqyy85Bh/QNcmvNp7veDplNeC3AiKL71Z5TQ1I3CMAJ/QdyXZ8aVUtywajw3s8nJBDdFSjAgU6B/6S3FGxwR0dWJeLesEtaNS4jJghuMhJO+Q3GG8FGTGQZu3D13Ub/TJWENe783EHnnix7q2eTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md3AB2+iNPljC/zuHnD5OeqFNTVLGONhlzD2v5PY6UI=;
 b=DgQaYG4yAPtCpEplToiG7cxxXYBbIjPx9X89sEzp6Ywq7nH3AiyWLYVCr35V0tm2UyTCq0TiAZ92wVRqugE81VYgYaBRnsDGV7jrPMnxhnt9VCOxpRLcwEGSt8dm90FkE3sUiALecosdj+/XgzOCsFcHGskkBmegn86NIh+/NQikIasHBrczRLzStsf7X5PkyC5AK4dJxl/cggO0/Ge9NHZAoswnr2rdFEwlrluVwsoytfRrd9fsTSPwWAnd/p9FG7Zat9iOMGqsKXNRkh5WqIkN0cZfvbGzW15XYYMJnohGTyYlNsGlsmKHMKoHQJeqnr0aNUD2mybcYlX2qFaZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 04:50:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 04:50:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V3 00/33] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 3 implementation
Thread-Topic: [patch V3 00/33] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 3 implementation
Thread-Index: AQHZAFwapzlMzx/iHUe1D818KMmiHq5TyG4A
Date:   Mon, 28 Nov 2022 04:50:46 +0000
Message-ID: <BN9PR11MB5276189A5B7E1A761AD410538C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221124230505.073418677@linutronix.de>
In-Reply-To: <20221124230505.073418677@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4673:EE_
x-ms-office365-filtering-correlation-id: a42a4871-678c-4c1a-ce04-08dad0fc1d39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iy9c8xh9JSoNt7PmSZJJfyZyYMUmMselE3MC7z0YgkXnLR4v/6LT5l4m3RUKyLYFrxr3wFEXbRySiFHJG857X7EtfVSRssyKd3l7JiSJBPs6U0DZnsiBr2WunH83WkxfSc1DV16tJVVz7aJwLHos22tUDMujQfkg4oh/cVXY0yG/6jWd1FADmwiYeCuqSlVarNC6pV5nykGsXfDHc/sMYj7+uXU4XFAMS1WrTZgfGHmwsligB7B0TudINvXtUolOoo05XXdmmMFd6wGb7+XFsMvcEQJrdB9KqMbygRlPF7rbtds+XrBmq/6i6/aLCmsGlF6QaI6JqIWvPP8XFIpM+M+c43ijLye/jCxoLVpprKZZl3ouXVd3cSwF8qoNLKh0Btp9DCh3Y4vXL+3AuikimiE0qBCOTXEna4+qCI2D9ia+huYygpF4PeOnMnefSVpGREQ3288W8JJYmcCftSs/AogaajU05L4F9I6uqGOiorZCaPcYGHB5MKyvvvexAd/ldwpwb/ysGdyUevMxQAyY3ebiUG4mVksOBlRMsTQf7qxRYqzsknQBIJaDNBoIjGUmWjFYR+uixra7sCXfhdhNVuKiSfwacvcYqg3SIjN9n8tetoiJxWnVxrX1nH7HTVwEYIyn1RmpZ8e9+Wy05onEOehMjrWvEa9qFe9EriKf0HlYyPR3ufJlum+bL77N0kx2KtJZEFuxHqoFPm528JT76A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(2906002)(83380400001)(38070700005)(478600001)(8936002)(5660300002)(52536014)(186003)(4744005)(7416002)(86362001)(26005)(6506007)(316002)(9686003)(7696005)(41300700001)(82960400001)(38100700002)(71200400001)(55016003)(33656002)(54906003)(110136005)(66446008)(122000001)(4326008)(66556008)(8676002)(76116006)(66476007)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BS/Dec9m+M4iB8h3IDPZR4XPbRUkIZTKBX7rPzeC9jX9M7Y5orGasDWHkZ1+?=
 =?us-ascii?Q?D92rhsY9/OQxKCUwfah7ZqLPWSvIY2KYBNgTl7y8fqW2Y6O15RIE/lPilcxP?=
 =?us-ascii?Q?3q3BA716TshZIXDUdESFTHukLWJnJUm/uNsXTWf8dLF1ZnCbH8sP5VjYmYC5?=
 =?us-ascii?Q?cXgMmzsjvqMp8u/a15azevOBdEnMbR6j+BTXFoYG8pLshuuk91ctYDGAzt07?=
 =?us-ascii?Q?qP1UHBSX6clLE/pNHT1lDdCv+Cn69hkEh/vUiR2sc0xCMX4yMlvrhUuGIwgk?=
 =?us-ascii?Q?JZKvxholC+Sk/m5vnnnZVNCbadmzxy3Hh56/aJ/3B2Uxss4TzZrm9dL3kP2D?=
 =?us-ascii?Q?MudmeOBqMONCsQd1JduTvm4suzqlYIx2K7lnrDZq/zPXUvm72zUiHcqO21Dq?=
 =?us-ascii?Q?ShDGVUEzW9bun+9G0pj9fabiizUKnurdbd63xRbNRbGNNYZlGMNJbT7wVHPv?=
 =?us-ascii?Q?diDw/yZlGChEn59cLG0POCIEG4jWg8mhA/MxXRJLu8LfF9mj0rd7lbOs61QE?=
 =?us-ascii?Q?IpNrFjM1Zrjn2Nkl6v8gRigEVj5zJEYev+C2V2RHlf9LkGp+R1HTIFQEY/+J?=
 =?us-ascii?Q?+K6jNF3mHcNIApwMxK0enmELxQoPFWQYkAqkz8NIMwDfy98NU5Xf5in6o+Mx?=
 =?us-ascii?Q?sGnQ3FzIUoC6xdWxs03iW9OK9OQ0B6oBZZREPStJ9JV8ninXeQtVowQLQbRD?=
 =?us-ascii?Q?c77nnE61a8X2EVS+kb8iFYlj6oxt6L8lzrJ+DywjGyQg0ONAzwIauvCakfQ2?=
 =?us-ascii?Q?10uJcCmkIIRwRH6xpkxp/mVT0b6VcbRhBiogKZPY7iSMAbjD8LLhRx0Q+yE9?=
 =?us-ascii?Q?U4mlGMZ/JXEFOVaahRpl1bd147jg7AroGq03p26yVhEB/3ZRAt5glFX7zblm?=
 =?us-ascii?Q?U2Lb8ZrZAtMsttJG3RbHSvoGT+AMRM5iW4EY/8f6M1rhbQNnS2IGXiVLA06c?=
 =?us-ascii?Q?WG8W5Df0mc9cRKdtgi6uQMuGv2JrlGP0tFbb01LjIJHqO4Cdi9GarU3PnESk?=
 =?us-ascii?Q?VjSoeo0Q0tE7GdWReKe+sbWmMWct71pvGmTfd/mBt54D4zttTZ3XhQ+QR+uS?=
 =?us-ascii?Q?FXkDiBih9hsjvIsOD2IWXLr1KxS3K5w+rGwk8LrapVwUF7YUJ/qG5TW2Kyyt?=
 =?us-ascii?Q?PtFOlXdncp6bnxXbIOkHEdTE4p27hfWm5EmP+eZn6sPXVFre5J9je6O3q6OX?=
 =?us-ascii?Q?C7iLPvdRyJt2vfwEQ63PcWfUw0VPOMM3u0oHBypOXhxF2Dz0PLcibpPxG7uQ?=
 =?us-ascii?Q?Mm5qpWif/0dFJQw2SOkIkZwRQksSB0VbBNmRUYjuJdPSiepYn6w0G1DwWgGe?=
 =?us-ascii?Q?1TUqHnnQXC2ZW98HBkE9IDKFlqqqWkZmUaWnxuSOWSgBCFX0i04kyNuqj4Fz?=
 =?us-ascii?Q?nSm0xkmqtm70Y/n5Ti00m1C4GjgXEcFDg8/syAXYgLXmlo2RzfaKv0OZhlGS?=
 =?us-ascii?Q?ai1584uxy7UPND7uKaCz0PLI7fAbM4J0ylC7QKWBnCM4OaZragbFmJjkQMa9?=
 =?us-ascii?Q?X2SHogkmaQRoF+xZmO341B24LboujOS7VkvyHPGkq/5V/CZNW1+d4ZAGewEJ?=
 =?us-ascii?Q?5iISiy0WX182n0qoKFHXfy+OIB3uA9QoNLbLHLFh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42a4871-678c-4c1a-ce04-08dad0fc1d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 04:50:46.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26u3P5aT6fK9IXMoSgy6dMYcBNgaRPFlMv2BDEYr1BQ7XOM6kgwCJwpHEyM4X4pOU/w42OSgP625QpkFIXGXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, November 25, 2022 7:26 AM
>=20
> Changes vs. v2:
>=20
>   - Rework the domain size initialization and handling (Kevin)
>=20
>   - Enable IMS only when on real hardware (Kevin)
>=20
>   - Rename the PCI/MSI irqchip functions (Kevin)
>=20
>   - Update change logs and comments (Kevin)
>=20
> The delta patch vs. V3 is attached below. It's not completely accurate as
> it has some changes from part 2 intermingled, but you get the idea.
>=20

This series looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
