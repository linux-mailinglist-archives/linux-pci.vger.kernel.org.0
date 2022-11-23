Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265F2634DA3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiKWCMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 21:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiKWCMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 21:12:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A0D104;
        Tue, 22 Nov 2022 18:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669169554; x=1700705554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DQkN13KrODJilmRGg99MnnGQ85XpfMpDy6QC77Xhrv0=;
  b=MkD78xsEv48pcu9tfFGjlVLAr/yv3rHYcKKCXa5KjmmhoucrRxXM6QQf
   JWEKBAaOjBq4RzsuxEuXXfpa7/Wj0g0m2sntrZjgSZ7Faoi35ZFOZ2wDt
   xDnRyGK0foCsg6PAVAMxGqZdue/fzhYEqwDjGGMtqH3oSm2nqff9DjPC+
   ffZ8uGXdKx1wRzybzuB35mymTrzlRsyZgF4CH9RqKIlUBqKvdAPSu5VeU
   Es1VrYDzmItnCdoBRN6beooIko92u9SoVoZVtaIqh/wMSTmhxD2Z6CHhj
   fAM1vhklTOouIhkqcUx2Ey5Pt1oMhtRKqIZ4tjpYaG6qizFQ/6ZKL7bxR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311589523"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="311589523"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 18:12:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="641624960"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="641624960"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2022 18:12:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:12:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:12:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 18:12:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 18:12:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZg0yRpBCwwHLTP/CNS6qwWiFOXtBAjfYrkmbVmJ0HRlcv8xeLpXdDoWWccl46Jhgd26QyICj0FFhx5Sa+1Y3SQ12WXKoY5N8tIXAf6tN574Zj7V3Ba6RBLj0Uct0hncM/WwpG9d4tOdk0FxLQCGFuPdLVKhIDv8Xx7c+9iWR4fiJVjdoR2rSV5eEgKzKICXnV2Y0Q6SetUf/RdaWteYry9RboWXUS8EMESDXY9OmCLHLsbaQqy3NEg2qIRjd3dbc5TTQ1qaoZb40OOrrjJEWzElvTK/opZNkEIXFMs37HBXTy0nHGu1q2pTZLC5aPM0Qx4Nvd17kFynkiV79UKIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQkN13KrODJilmRGg99MnnGQ85XpfMpDy6QC77Xhrv0=;
 b=OV7ZHCxCxZRwms7+l42rn+6w9r+DnK9NtgeG6W/FmzlBmM3Hxqrj/AlxKZbjSO5v3UBuFwPkqkYaXPHveX5w9HwXf4X4j0snHebDzObV39vV7ijwQsMof7Z63C2gc4TvdlDG5uZnYIdkJwlJQqGNyHki4BUixEAplHife5DP+H0YwtQ8FAN0v+uvkrwoDmlmAwqKOYDEsHinFUSJfdGgX6KFqpGNyRKTELQhg5pex+4JEjl7LmDVNLUiqNrTCmJ/tJ2RYM3gIVPb7PL7pnr9LuZvAYJS/FrPosv7FFIsTL8Hdgt0shfA77YUmDnNxwNp1QIbxMaUcma0yxRDSyo38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 02:12:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:12:30 +0000
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
Subject: RE: [patch V2 00/21] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 2 API rework
Thread-Topic: [patch V2 00/21] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 2 API rework
Thread-Index: AQHY/bapoVGJTvKd90OAdM4fzEqvZ65LxnDw
Date:   Wed, 23 Nov 2022 02:12:30 +0000
Message-ID: <BN9PR11MB527641DAED2CD2BAFDEE74218C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083210.309161925@linutronix.de>
In-Reply-To: <20221121083210.309161925@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7520:EE_
x-ms-office365-filtering-correlation-id: 806184fb-1e29-4d62-0db1-08daccf82d02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szKqle4yCcfmPsKKfINmOYjEKFM+ondK6LhV93LNweTVqnp4Odah2MiuDJcFL5WXXyzvMKCddueyJGc6GBR7lbTbRyH7/XBHWWtU7i1P482vgriDR+MnMQl4eIhhUUaZ2fPFbtPWhR+YY4T8wAWjSficWzfQkeL+LfA6NS+NHDyInvoclwuJQdGAddNZxFNl24NeVrkoyj7JnJOWnkKdTt7ELTJ9gmxDC4wfMphy2bFj8MiL6yVroaJKGEB4OflElTiePjifpszr9bUmJ4bwmfQ6bKf68We4RTZe0aC7ZALzQDT7kU81PslET0KOLNxpwXW+NWsOUrPjm0eaKYDQ88Jethh6l7fGG4cyuij3bprxaZak1Z/T7oZE6zqBC3cWTuPlEN4YtRE3YVKGSkEHOIUuXw2g0KiN2G5J7pml0oHkhKmGlUfP6NbuckdJcBg5MclsJUzY6KE7TraSH4thr79GbIWPo3Zd2+ObsOmrMghufJT4htfoBCwdCfgWaAMPfshSrxIUktGTdOkx7RZOCdsXPfByfTukEM9Ybaue0CglZS3+B1++qw/sHSu1GlDKWElJIIZzc+9j66oixm0HStFHxdcmFcHngbHSXKrZuYh/nFOOyAgBv9f1DtdeyMwxaEOry4gPEizFh0SPLFaEyLvo25zHAla3YcL94S5DjaEOa5EheC+hRN004+OmnFFjULSzOfzTTWdOB4hg8vDcLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(33656002)(558084003)(86362001)(38070700005)(5660300002)(66476007)(82960400001)(55016003)(2906002)(186003)(26005)(9686003)(122000001)(7416002)(38100700002)(66446008)(7696005)(76116006)(71200400001)(6506007)(52536014)(41300700001)(64756008)(110136005)(66556008)(8676002)(478600001)(54906003)(4326008)(66946007)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mdOfyDu8gYZwEvEvA6CpQFtBZ44eqd1IqudECNpRNzy1YAMJwEKiBkFu8af4?=
 =?us-ascii?Q?AJK/kiVW+hJDl74zuqkfnoTXp8hjP8fnR2c+J3Tl+CEopM8VPU3rznKqXTo6?=
 =?us-ascii?Q?r7Dy8V5qUuCy0L4b4cFec0ELo7HaBrwPKSbAaQnM4XLktokuzGMSSV9PakZP?=
 =?us-ascii?Q?kbYG0yZ6Xu/8ZWLOHdLtiIepAOy0GA6abm0NKDS0TNi0s7GQ2tlhwqjwB2PN?=
 =?us-ascii?Q?j9gfjqZQArj+5YXLOsfULRwo3ffIxuzt2nyyRL3iH0QdLZ4PWD2W9EVmmZQ1?=
 =?us-ascii?Q?Y3niXIzxh956T970MyFdJ9y/oMxdFFjrOiEPeBBigDfgLlBndUJegswbp+Kn?=
 =?us-ascii?Q?SWJoqO1h5pV5Tqlbv/WAv69/2sv1My5Br5SPw/V/NE0RgC9xidx22HL0lLzk?=
 =?us-ascii?Q?Qy4i51pL9tGnznZej1SZ0JxXdVcVvk5Jy/JohbGtifLN5R7l/fURtPAPKG3c?=
 =?us-ascii?Q?p2AJuk+DK4aQciTtLgk9nyZYCYnl8lB4A482iA8AiR+VpcAGE0YJJjEWahCl?=
 =?us-ascii?Q?NoC5h7xw5OOGr2r+2WiSKBskX9AjCPwWYBfLsQrtJ4j4PnSFUxkoiIoRFmmA?=
 =?us-ascii?Q?6S8jiAjLV8TRLqMJi3TgS5fGrh/ijFEYYDO52ppcydV9gL46vrKYBj29b0q2?=
 =?us-ascii?Q?/ZyBSUm7hLigmsFlS1wED4IeQ2f5H1zDKGsOag9GrhK3DFxAeNaqR4OPKMSj?=
 =?us-ascii?Q?dsu6scdyPjluXUO6zBlDz6sQYbTNHbEtrr55xNRr7MrwKcBe9n4BEMlCIdcD?=
 =?us-ascii?Q?h4ArJsX+XUySvMgY80WqXWlwxoPf/SNbXh0+wN7SpgQS0yYQpAzK6hAYAaCM?=
 =?us-ascii?Q?bzd9CWoJmm0XH1jjsg/8/+SmaaNlze7UWSHm6Dk9W7x7/9dVlZpVVXsu+Qia?=
 =?us-ascii?Q?0wchXYVr+wQaFDMC+QP4XCMtWKy2X4XCQ9dGlrZ3eizdY7jy3/hrHT7llLmG?=
 =?us-ascii?Q?R9V5Of1vsJGJfx0+PAWt+vQffww6nO8y9h0zKVm6Ssj9n9hV8DN45A+Kk16X?=
 =?us-ascii?Q?jt7+UTTdTtp6glK5/DuyGx2o/3sUzzTjN3berv0hjAtVuc6xMmGl1Cd7vvzs?=
 =?us-ascii?Q?d9G5MqDi4ytLs+854U4wiIWAllqfPrxfjEJZvmcEbKQxOZ4rxl6lVrpFlBKj?=
 =?us-ascii?Q?Xmr/MOmScCR0759RzFHpWUXLfV7Z7ORNCQUSFGHA+6kr4v28NwkAy9cTF154?=
 =?us-ascii?Q?qFdPjg4tS5FDxFmeovam1xjZ04rqaalPHpFgNyrkgwblfUKmm2vYUBPN5504?=
 =?us-ascii?Q?PWqVjTlCMUb6bkXzbDyic37SF5pN2RHr/zdp9qDas1dUgcI20gwpbqfO54LU?=
 =?us-ascii?Q?UlNUIhnFwS0VJ//gRQp9oK3r1y/ugRsiAopm4IhqXHhKwf3K2DTnA+BOPlBI?=
 =?us-ascii?Q?4zZUx18d02k56SrSI8cSYoYbIExIRPS8FteM1+MCR4mk37jUp5NvPjduWxZS?=
 =?us-ascii?Q?QHmNvzgm3IqOkq/zg7i+a/UnAqmCTEh5ddQKdeBqOrWonYG//XayX4LJwCkn?=
 =?us-ascii?Q?Zlr4XEK9AXb4jyAfaPy+J7QlySrnah79+H7S4bt4Q1dQA459o2TGCJKrqNl+?=
 =?us-ascii?Q?Y4mSB6JH67xCxYYmwsBIMVJgfk01PKekAEPI8JkF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806184fb-1e29-4d62-0db1-08daccf82d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 02:12:30.4786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2OMfTmkyuwMcknYi8CbaW8zvYdrS5jGrFfQzRGzHOtXoFPQywUlFft6GbGZix4k6isKRHVaXSOz0+e9nG3tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Monday, November 21, 2022 10:36 PM
>=20
> This is V2 of the second part of effort to provide support for per device
> MSI interrupt domains.
>=20

for the entire series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
