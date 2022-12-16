Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD864EF14
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiLPQ3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 11:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLPQ3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 11:29:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E132B85;
        Fri, 16 Dec 2022 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671208184; x=1702744184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygyYXP+dljVM1XsutBrIgGzNdFhOKfAexCFPjWO+wpQ=;
  b=e7ZPm79FZtM+VegYFZgftUkRhpUIDpkZyQMiokPx5bAcst2hP7Qzuu2q
   4Q4NQDFS4nsFba/2ZbGXOR1Q7DBZxrIOfvEk+ouh1C2DjCJ7SHeNLFSgR
   ajz5WJ6eSvuEwb3hPkgIhQwSyyZOP5iWG7fyLYBAIkbAX2UVbsnJvG3bK
   vLh3MMsUIzdK+50L4Aukus/9LcIFIiGrJFnw5NwnS2mtfY4HDFXzUMzat
   oz1CriRJ34poc+Tk/gya0xBUGw5QUhC6cs5VYpO12WOzXBCaMwd/bdzSP
   TlCRo4rLEnJV9wgAFhhmKvenvDHJ4LRm+gzbED4UPpRiN+08D15T5YDc9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320887092"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="320887092"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="649880039"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="649880039"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2022 08:29:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 08:29:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 08:29:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 08:29:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC79jHMg5pxSMTWO8mzBMnu1yr+bl99APFp1BQ9ZPui/eurqauJ43tR6ODxZ/fL3K6VMt1yLlTiFiwoMfyQzKgCsh+S6KTRpEzHHkxpL93Q4X805zZ+qvsduIyaCnJfFV+0p7oKsZL12JlQaHKTdEJBhhfaggVmW8ALHVSlDmMHzlkcWcXrOYIckuptx4ORABHkexrU4EprRrzLSrN+n+7kDaC49uS9wwru5imr+jlG8qVhDvDznRtWSkZE862nHde/CTL1wKnE/sV6oGiZ5a2qKbOSY4hO63jec+1yD6ZebH2tzN+eGc+mYpbOUCrqex9h+X1zQXDY+/zPAx39F3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQwErUFIsuanAp97RElHH5CzFFa/rcmNK2YFTaHXvgE=;
 b=Wj9DY2TgzYyQWfk9hr/I4lel4QwhxkeuQ9/a4ghXGQ5M6cqhU1clsi9/xgYIe7LxcRHnRy3INhFliEynQn4fOi3zqkhZ5ZBK/yNt+/eV8wQkQ/+rfCMjYk4sZ1VriD6N+jocXgrJ3MtpnXPYhfq/Ejxr73BokXYpzIHQxURmMBB8B20can6WyW0YxESKlZtrW+FL5N9o8vefnQS2EkO5jyiKTgNUmQnwB5T15psKmHIICkQKFdXN4Dqo0KiX4sbibXXQfzIJUJfPvNLxPAi4uSjd29HTrixWcKeKWtwf1xMCnqigQAY/KRKufXdMW1Q7aXz7lD85wXYamnLjLrwD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3457.namprd11.prod.outlook.com (2603:10b6:208:64::24)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.21; Fri, 16 Dec
 2022 16:29:39 +0000
Received: from BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::c8a4:588c:d831:f6aa]) by BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::c8a4:588c:d831:f6aa%7]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 16:29:39 +0000
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
Thread-Index: AQHZEGWaE406GK/6VUCqucUZkFrJaK5vD4AAgAGUZSA=
Date:   Fri, 16 Dec 2022 16:29:39 +0000
Message-ID: <BL0PR11MB34577E415B692A2B1CB000ACFEE69@BL0PR11MB3457.namprd11.prod.outlook.com>
References: <20221215091357.8738-1-ron.lee@intel.com>
 <20221215151604.GA107336@bhelgaas>
In-Reply-To: <20221215151604.GA107336@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3457:EE_|MN0PR11MB6205:EE_
x-ms-office365-filtering-correlation-id: d11589e0-be62-4b8c-b05d-08dadf82ba68
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9xQfsldVivvtbK5qBVOWQYiTwiSDtlzGPCW5vlJorHsFQXxA/3dqbBkHacxsu/9SndZZaiN/i0QBA/ON10W+hbwc+mdjHX6sKJBtaLTy+V+Cno0pVP7Kf31EZj4JAn/JP9K9Q5g0oW1KtiYFseBEEwgUINRkmYu0MwyPHAGD671sEq7gyPxS5PGZI/pa802NCbyY+1/4sxCSsZ+tlN4wPRa7aa6yQKzB/KBoPSfBVODQ/h9LKXstKt0UdQDw8O6uQ8TGiOhXiBoTtp4VZw5OZA8l1MXQOpUQPfsc1RDwVHxDDWdud7QSxOnXJ+QixlqcqIIiirHB+thAq3knAr0X14RbXq8HnYCVoN1nBHD/ZxXg7+pxdBk0BsMsmjYks/s8jEHhH2fI4wq4MO1yH3ICUllaBmI+WMRMuFKNggWeoUvfxe6Mktuk5BEBbWGyVRRS5k86eR9zgr0jj0ICeyvtB0WtNovxJps14Yb1sCnPIVEUptfz9rKfKlDc/W58NdBLwsGDXISg4TQsDITdmwwedtlSNiake6skqHG8mN6PUCfbgk8aBzmg2vWxouyOsQh8yL112Zlnu2vYcKjgOaa3vPOR1Xh3b9TJJ8H01fxY5gN9SQmNSn/2K17yr3uKMrZw+RXW1aasi+wQFFBH6t1JhgT3yS1gSDhlmO58xjvGdco9emBIUYlOh4j5YmiV+Z++AHmz0ZNS1sZMHTmp2hqhkk5H9uTC3W26hM2niXi8D4DqRYCAyN2LMDXXaVPerS2qE+/pmL0fdp9i5b3UtCw/oVB/zbo9QhDSnOuY7BxipujSimq/KB6K68UWg+4zLVu9jUIHiDp/MHTc0ffbW2mAjJfMJNaPgCe/kKMAqawH+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(71200400001)(186003)(26005)(83380400001)(7696005)(6506007)(9686003)(8936002)(2906002)(33656002)(19627235002)(54906003)(38100700002)(316002)(6916009)(478600001)(122000001)(966005)(41300700001)(55016003)(86362001)(4326008)(52536014)(38070700005)(5660300002)(8676002)(66556008)(64756008)(82960400001)(66476007)(66446008)(66946007)(76116006)(32563001)(505234007)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LwIuMXLqLm15nU5EVGIHEPz4IYdk8vt1xmF8LxlQo3o1dejJ4oibtUbujMz7?=
 =?us-ascii?Q?T8bTEiEAEnXMqH9mrZtQULz5GJd8RalSLidPPoJxB6hYQIv98GCfzJTkH9Fy?=
 =?us-ascii?Q?t3EwtoRd7Sll7s2Xg3uUSfmbn5yZ6UmMP6qIxzTv5I9peDyNw5GXjLuiAU/9?=
 =?us-ascii?Q?MMxnGkTHa+/aJ2zsJBIH9KttR2Iq2CAR7ZgL7WIisid+oRuQ0VsdTeM2D6Ei?=
 =?us-ascii?Q?IgBBqM2kJDSWYtvvfCyM31rrQGhBJlbZPouEmEPKPBFcrvMmNSeOE/P+Fc8N?=
 =?us-ascii?Q?yvYcepUb5v8RNGhbpKO5DUAvoCuzKXid9OxcpBcEwkkapinYyr/5Ba7HSdeJ?=
 =?us-ascii?Q?n4s+fNlJLtn5ilIZlvAUpsmNBpclF7kEHzjmNRI2tuHGDE97tkqvLrGTByJC?=
 =?us-ascii?Q?oaflJH1ScoxmEKXOXS5BCXiwk8LONhQm3p8IxQEG0Ii8PqJg5c+8rIpxTSj2?=
 =?us-ascii?Q?SKmX0m60cxtDVe1ucmIeEDh4a/Bsz4x9VxkyKwCka2O6zk6iBwDg2Ol9F5It?=
 =?us-ascii?Q?TPa6Zk5RFQapJr1keLSm06KH3ZyyepLjir9NVYx4TfflW6UlSs1lFahwQBTX?=
 =?us-ascii?Q?4retYaC9VVIUbMMe9wM0R7/evxNo9gqYh4lS8D517e7dE7As7Jwfto9ETyRg?=
 =?us-ascii?Q?vMXLtnV6JBRPgwhN6obzbhrj+TKt9Z2g+8DhmVL9GnooQ3R15g+PTM+3fgQV?=
 =?us-ascii?Q?VLxFe6w7AvL66GUWbGb+ndCLYKZ7r/rcpmR5NuT42Eh8m59A08phQpRK7KNA?=
 =?us-ascii?Q?3H/pA9FR735HlZ9MBF59/p8+V3YBG0UMQdPhyN9EMvtSQEgPkyH5fJ52E35E?=
 =?us-ascii?Q?jjrppQpW044kMJKfhQZigoaZnvU4DKroxZ+48DtwnaEST6IXliC7RU5xXPhy?=
 =?us-ascii?Q?OZA1GgkhTYIqUUCK9ARVk/Jls6KjJzbVDAvSQTEiFsMtgjJfGGJGrxMfu/zD?=
 =?us-ascii?Q?TwtlRsWcPPjXEZ+smgFRU7uqyVPYt9q7LbltWafCRPKl64VKjnjE2EV/Pogs?=
 =?us-ascii?Q?9eIUR3ArJQ2YCp6KxqvD5XXsJb0mJoCqmBMszxmXpQxd5RM7P41Xi2f46aMM?=
 =?us-ascii?Q?joMUPlNWDlbFyCL0L7GDmhS7C2ypT3cRV9NlTvsRzworU/3FYmwt9X8ubX96?=
 =?us-ascii?Q?gl9o3hoKdHFAVx5H9E8a2YjXprNbaeQTJit3mHWkxv7zqi2cqIClWUGvxrYZ?=
 =?us-ascii?Q?FUeVsQn1EjO4EfI9UMIenRpH2CPGmAoP5lJw3JkcIU3UuqM+pANsqPNi4i2T?=
 =?us-ascii?Q?eG4kI3qgKfBzjkG9UIsGaYmioKnHO9QrD5vlDIeHQlK+Zjr0PYbpIhmerl9+?=
 =?us-ascii?Q?PEei75sGMnVjqvnwaULxJZGYT+G5j4yp7ukpIlEubUkr8BniObz5LWgb7SMo?=
 =?us-ascii?Q?6cgcwLxjyVM9YbqcYp/cew6ewYH3TVDyJf7D8Kwp5fzRriBRB34FEIB8xkgl?=
 =?us-ascii?Q?SuNdB2IoyR1BWRAiB7tfbnjVhKdKQ2l1BADPX1X2RGRtuufLkvaW0i8HAHf0?=
 =?us-ascii?Q?FqLyTl3n0PUsYuD96poEMWG94ttAPv/Aes4+fce7R70oTXLK5Zaf+WbCm1E8?=
 =?us-ascii?Q?27W/21Ou/yhykG7hNu4zOLWITMwrXylzDgm6skhH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11589e0-be62-4b8c-b05d-08dadf82ba68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 16:29:39.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNz1PCSqyH6bzRJHkLSD3/Y8snbournzjRU+u2KMgXfOQJ8/r9iJdizlBqE/E/rNfK/pfDnUVhP86NO8mKnoGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Thu, Dec 15, 2022 at 05:13:57PM +0800, Ron Lee wrote:
> > On Google Coral and Reef family chromebooks, the PCIe bridge lost its
> > L1 PM Substates capability after resumed from D3cold, and identify
> > that the pointer to the this capability and capapability header are
> > missing from the capability list.
>=20
> s/chromebooks/Chromebooks/
> s/to the this/this/
> s/capapability/capability/
I will submit patch v3 to correct these errors.
>=20
> This should say what problem we're solving.  I assume some devices used L=
1 PM
> Substates before suspend, but after resume they do not, so the user-visib=
le
> effect is that battery life is worse after resume.
This bug has existed since these series of Chromebooks was shipping, it see=
ms no harm for system execution,=20
and we didn't identified battery life drop after resume. However we still e=
xpect this issue could be solved and=20
follow spec criteria as per PCIe spec rev6.0, section 5.5.4 L1 PM Substates=
 Configuration

    An L1 PM Substate enable bit must only be Set in the Upstream and Downs=
tream Ports on a Link when the
    corresponding supported capability bit is Set by both the Upstream and =
Downstream Ports on that Link, otherwise the
    behavior is undefined

>=20
> > Capabilities: [150 v0] Null
> > Capabilities: [200 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ ...
> >                   PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D1=
0us
> >         L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> >                    T_CommonMode=3D40us LTR1.2_Threshold=3D98304ns
> >         L1SubCtl2: T_PwrOn=3D60us
>=20
> I'm not sure what this snippet is telling me.  Based on the patch, I gues=
s before
> suspend, lspci would show:
>=20
>   Capabilities: [150 v0] Null
>   Capabilities: [200 v1] L1 PM Substates
>   Capabilities: [220] <some other valid capability?>
>=20
> but after resume, you see only:
>=20
>   Capabilities: [150 v0] Null
>=20
> Right?
Yes, but there is a difference in this case.
Before suspend:
        ....
        Capabilities: [140 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd- EgressCtrl- DirectTrans-
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Capabilities: [150 v0] Null
        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L=
1_PM_Substates+
                          PortCommonModeRestoreTime=3D40us PortTPowerOnTime=
=3D10us
                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                           T_CommonMode=3D40us LTR1.2_Threshold=3D98304ns
                L1SubCtl2: T_PwrOn=3D60us
        Kernel driver in use: pcieport

After resume:
        ....
        Capabilities: [140 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamF=
wd- EgressCtrl- DirectTrans-
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Kernel driver in use: pcieport

The following merged commit can save/restore the L1SubCap/L1SubCtl1/L1SubCt=
l2 registers for this bridge,=20
However this bridge not only lost its capability contents but also lost the=
 link to this capability.

    PCI/ASPM: Save/restore L1SS Capability for suspend/resume
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/pci/pcie/aspm.c?h=3Dv6.1&id=3D4257f7e008ea394fcecc050f1569c3503b=
8bcc15

>=20
> > This patch fix up the header and the pointer to the L1SS capability
> > after resuming from D3Cold.
>=20
> The main problem here is that this patch covers up an issue without sayin=
g what
> the root cause is.  Presumably this is a firmware issue.
> Has that been identified?  Has it been fixed for future firmware releases=
?
This issue could be and should be fixed by BIOS, however the manufacturers =
have no resource for firmware validation and it's risky for firmware update=
 per their assessment.
>=20
> s/D3Cold/D3cold/ to match above.
>=20
> Is there a bug report for this issue?  Include the URL here.
>=20
> Is there a bug report for the firmware?
>=20
There is a Google's internal issue tracker for this bug, seems not availabl=
e for public.
Actually this bug had a discussion on this thread, and Lukasz Majczak ident=
ified this issue on Apollo Lake platform.
https://patchwork.kernel.org/project/linux-pci/patch/20220705060014.10050-1=
-vidyas@nvidia.com/

> > Signed-off-by: Ron Lee <ron.lee@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
>=20
> Nits:
>=20
>   - Use "Apollo Lake" to match Intel usage.
>=20
>   - Below the "---" line, mention what changed between v1 and v2 (I
>     see that you added the "#ifdef CONFIG_PCIEASPM", but you should
>     save readers the effort of figuring that out).
>=20
>   - For work-in-progress, the "Reported-by: kernel test robot" is
>     pointless and I will remove it.  This quirk is not fixing a bug
>     reported by the robot.
>=20
> >  drivers/pci/quirks.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 285acc4aaccc..fc959be17a9d 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5992,3 +5992,20 @@
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > 0x9a2d, dpc_log_size);  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > 0x9a2f, dpc_log_size);  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
> > 0x9a31, dpc_log_size);  #endif
> > +
> > +#ifdef CONFIG_PCIEASPM
> > +static void chromeos_fixup_apl_bridge_l1ss_capability(struct pci_dev
> > +*pdev) {
> > +	if (!dmi_match(DMI_SYS_VENDOR, "Google") ||
> > +		(!dmi_match(DMI_PRODUCT_FAMILY, "Google_Coral") &&
> > +		 !dmi_match(DMI_PRODUCT_FAMILY, "Google_Reef")))
> > +		return;
> > +
> > +	pci_info(pdev, "Fix up L1SS Capability\n");
> > +	/* Fix up the L1SS Capability Header*/
> > +	pci_write_config_dword(pdev, pdev->l1ss, (0x220 << 20) | (1 << 16) |
> > +(PCI_EXT_CAP_ID_L1SS));
>=20
> This looks like it adds a link to another capability at offset 0x220.
> What is that, and how do we know this is safe?
The following is the dump of this bridge config before suspend, the L1SS ca=
pability is at offset 0x200 and=20
it point to offset 0x220 which is a null capability. This patch just add it=
 to keep consistent during suspend/resume.
...
150: 00 00 00 20 00 04 00 00 00 00 00 00 00 00 00 00
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
200: 1e 00 01 22 1f 28 28 00 0f 28 03 60 f0 00 00 00
210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
220: 00 00 00 00 00 00 00 00 00 00 00 00 7f 7f 7f 7f...

>=20
> These registers are read-only per spec (PCIe r6.0, sec 7.8.3.1), but I gu=
ess you
> have device-specific knowledge that they are writable?
>=20
> > +	/* Fix up the pointer to L1SS Capability*/
> > +	pci_write_config_dword(pdev, 0x150, pdev->l1ss << 20); }
> > +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6,
> > +chromeos_fixup_apl_bridge_l1ss_capability);
> > +#endif
> >
> > base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
> > --
> > 2.17.1
> >
