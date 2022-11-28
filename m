Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAD639F0F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 02:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiK1Btt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 20:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Bts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 20:49:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB84C76A;
        Sun, 27 Nov 2022 17:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669600187; x=1701136187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=maecq7vvUbnmiB6rg4eK7mmXOAQJTKReoP1UD9nEvSY=;
  b=fkLWePL8webHZESCGUltE4AVPXEG70rnSrvqkeIFY6nbrGancTLY0fIx
   u/jrAp2Kc+NbBcIBuIlMeybA7HU9T8P1mxVDMyqXxT7L41FuZVE6deXHF
   s4rSr0MGxrdzlABvuS6ioNaMfhTvKXiwPjLAJttI2RK7KM+hVKMs3n1Il
   WW//EouL0sEvfjNpoaY88XoaVlRNPbrc+JtmJLkWfDjbTyU9AW+Yb6kwE
   LbBi3jyUW7NTe8Oha4F2V9MzvHt9HYkqPLou6HoIJthgpXmcAff8VC3p9
   nQTZTvFHBF0BsoyNCcG0lh8193f+QXD2n+EelBtsBbeg8S3xb6aPqhV9s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="295113714"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="295113714"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 17:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="972082650"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="972082650"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2022 17:49:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 17:49:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 17:49:46 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 17:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJAJvXsvaEGe2XjUgqS5Inv/2NYNIl8Haos8ZOX9/TnzJ9V+A2vODB711tbCP+xxWaT1Jc09LTzJ2qB0UZeuCdrhbTfFf5l7oceFt4SFj3UrOHmjeWbswCJhfHOhnCaIx1j5IIz+y/6tsR5D0hTZ0uWyRe4u2iil/eSZHSC1nAkosavWY6Xct8fhCYYH8knICBDI8L8GbmOdgUyQX0Pu8ylAE3fxAdgE64vJVVoSpHU6qSZs2Kid7gb8gRfcCPnrxEU9nhH+NrwESAMp1hly1rjwGsQwVJUZuVk5b07WfNBB430OH45QOvyPRKH7P/k0aM6+1CUe2w7fgHOgG87Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfFWUDp+eH8SNUPrjBW12lUVlsWd5mP0bm+P83G4Hxk=;
 b=jyqbf8vOc377OSLoqVMG2Ai4AujCN40zfw5627YdjKtTguLgGoHWSYFt/WPo2Q/tPRk1kdmwuAK4QGM1rRi0WjVqDp18u1/tT4JUeJRAGnRPnOzZ/zObGTHkea+b22z3qOlmevp61Mv1/nl8kE5MXq7zMa4+wgItFeETaLNpKfbVPx9x3LDzy5h5ewzG0dZi/REl8hWbO9bBcVXVdAsFhs/kkI2c5cDezFH7y416ZcZieF0fdce0zqc6Cfa/4gd7m3Hbhi1LBfr1fBgj5FnpfT1igayNnk0yRqKeVO6NuqvjlkmQnPkRsWNWv5nY213dTudkqaH0TqDrRk26EAt7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 01:49:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 01:49:44 +0000
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
Subject: RE: [patch V2 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
Thread-Topic: [patch V2 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
Thread-Index: AQHY/bbtFxCOpPjo80emqF3PmRNPf65NVNpwgAB4XYCABc4isA==
Date:   Mon, 28 Nov 2022 01:49:44 +0000
Message-ID: <BN9PR11MB52766BA9CE2BA102FA41297A8C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.869774994@linutronix.de>
 <BN9PR11MB527668DB0B5B9C8D8C36C95F8C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87r0xsd8j4.ffs@tglx>
In-Reply-To: <87r0xsd8j4.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7372:EE_
x-ms-office365-filtering-correlation-id: d3e9d714-3cd6-437a-2f52-08dad0e2d2bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTqv/jXyJhYEVjjuucgcTebGMg8c1LfagJb4yQ1qprhH5eNwZEiQ7xAsZD+j0r7rXRstpptmpKccC44YQBd72PKyzOA+qiATRp6AQB6nVIu7owkIHA+26x417EbIhIPxBxnMOsOWVKSXLvUrZ2+3DLrCCA+7ZJSTGorCu17rS/g94aAHiCkiF3kOFWJz6boi6bHka1HnhRJFLGY87qU8dQxBzUJTPF7PQ98yj/OpFnbg1YyQQgVL1RCypEDMOThBQRpR38B5XBoxI36CaXteVql77qYIqndpOlASqoTe93vXtfh7YCO6pqFXNuw9dHlKEW+5bzJAuQ7+N2zk15lmWuK07BdInpSk5bCPYujBqsVSAWwnxliwKQGWzgagQ4Hzh0STZyvRIP+CkgcT5Xkwc3grQav4DT1HedlDjeIhdNB0TqoXHe6aQvWTTcOEs1ZtBLld6Zm9iqqrPrRQjphMWlFm24Ebs9Tkg/GKPo6kR0dA9nty6sJc1mbb7XQJmh3+USk9eL4N2c40+p0/NFWOvCFW09Gpjqi3zdMk7rNrOarKGczU73F6zsldTawihTU68YPEcn6vpmlEGnRk4dJ3pf2vOCRmJbd0F6UEeAoZzRUlOMZiQzoufbp1vXT7lQObcIxijF5N+BNKJUn8/BdwV9PQPZNmF93XJA27i1MY1T8v0uyiXB16frF6D0N4QZ2tZ2YqAPBdZKrqDQnlmQwJ5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199015)(478600001)(33656002)(66946007)(66556008)(66446008)(76116006)(66476007)(4326008)(64756008)(8676002)(54906003)(316002)(41300700001)(110136005)(55016003)(82960400001)(38100700002)(122000001)(38070700005)(6506007)(7696005)(71200400001)(9686003)(186003)(26005)(86362001)(2906002)(52536014)(8936002)(7416002)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ugbLSNtPqRbvtNACqwcR0LvlwcwXJwVcnvBlts9EV09JvMWEG6p/xJ/OZZnG?=
 =?us-ascii?Q?MkATt3a1xnbfj3vOa6cG6GWDdi6T3eo1pBZ95nwFyOX5C3ayxadRaR0MJtCg?=
 =?us-ascii?Q?E7fErrTIo9eeGkYJnO1kZ8Uu95LG0q4lQqoOe6rGVXxLpOu0poV27/Frh+N+?=
 =?us-ascii?Q?mG6K+cA/VC0o/BTlu/i/dMRXIju8A0OWSZMy0jZhB44fLRXa4hSqKKhyUCNT?=
 =?us-ascii?Q?hYPh5TzXUMhgYYMMFTNONrZT3/U8pl29vyYqNWkz47s0Bi+YF+tHhR/ds9Ih?=
 =?us-ascii?Q?OEXV5pLI0gXcDO0CaJ1GGubLy1AaAAQB5dBtUGKW+0sVB2gAqVSWKEE7/PGb?=
 =?us-ascii?Q?pEczCRgutX9Pe3L0H/bgn22OsYWy8W6tYV8zaJSxKODoxLzUewEsfqLfEMMc?=
 =?us-ascii?Q?vt4xG/+mKhbGoL0qLDwgg0x+LERc2G6Njucu2Kf1FHbm2kWKVhLni4jzkXmE?=
 =?us-ascii?Q?H5O7QbSPaSBv03SR9aC/P7nBBnNMuUeNBK+tGahtrQtmA01b9g1TRPRmOMa5?=
 =?us-ascii?Q?dVCa3/NVN2sQfvGddJ/gJttf97EQI+I7+Nfk9ERIWxobBytRs5bumuEA/S+G?=
 =?us-ascii?Q?fzIDQNmKb2gXvKZkna+eX3vENwS4OdYBAbG0LVH1vNiWPpen5W0j+F743WBo?=
 =?us-ascii?Q?upwm4zh9h2DUf3Ngxehix6Kr28NEgNZLnnx5I1s3njvjAQnNEMa6WQxANMvJ?=
 =?us-ascii?Q?ji0EBhXBv6e6zPcjkOGcUvlp/hAyB8DkcAlvgTP01q2cTTimKSoQawZmdp2e?=
 =?us-ascii?Q?Zl6NagyNCnim3VeyMXQ7Iyw/+RUaCtBKK8BQMHgNd5f3SEGK0p8NlxejDhoQ?=
 =?us-ascii?Q?xHrezc/RWVTFMOEMPqNee7gUsbrtkwuUsEOhcGy1S6M2xh/ear9IQDmP8lmH?=
 =?us-ascii?Q?CfYA/UZBMiMl4QLClIlryC7oS7H2Hso6nlEmzOh4izzDNU68OBOk4s/Dr2Ud?=
 =?us-ascii?Q?VX3wN2SCfgVGyoqpH+dQamKw3+vB5uFHlKmD55MV8JkuWZoGOYolrQd82wXP?=
 =?us-ascii?Q?QEybFLARaWdzqxt0Zb+dXHtghQmPJHJrWaBgfEudvjkUtFoEhWLCOnZJFTyN?=
 =?us-ascii?Q?vBThn3ts59PK+Xvi/F9noB0bUMTVYKcxulmX/pT7b8GHXyjT01HSYwckpdfV?=
 =?us-ascii?Q?C5qMUK0zgoZmeHJCCDeNJtyD8E65+sepxbTWtG71/4W5CYISBgOodO5mOJgp?=
 =?us-ascii?Q?ZzyugTKyrGC6WArzlZqi3x08BI1PQBwdfAh1w81Tpw79p94DgF+zYlb7nxgJ?=
 =?us-ascii?Q?c+ih1qs8jUtPAZD2bfBusT9vNZTmqOKBmAOW2P6kfFsypBNhzI2m3oWbSxzJ?=
 =?us-ascii?Q?EqjjYs3B8EKaqdm5gWxLQjAEzx5LMO6lXn+ablDJT/JJWKwxFlzviHBVekEj?=
 =?us-ascii?Q?E3dLOhys0TSPExJNq3F1S5wc3hQfPCYS+TJVhiDuCUXYgAp8dWuCocoQiDdt?=
 =?us-ascii?Q?a7QgjUk1NSOYkh3vjvPmIS+nS56nTgFKSjnNJCosS0NOjuabjGhFIFsodfUs?=
 =?us-ascii?Q?DOO0GcL83RuYIrm2qxPNNbd106FdMaRTh/B/AW+DrBJUQ0m468czPQzMO13M?=
 =?us-ascii?Q?W4qGemVSEsPA5DBxAlS4aMeCG5JYNAag+Ky6osJZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e9d714-3cd6-437a-2f52-08dad0e2d2bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 01:49:44.2390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0+JIzes3wquZCHDxFkQzKZhft5Nw4bIwbPf7u2c5XxqHFvU3GWjb6dGp6dsbKcSC2gHrN0KbUCipQ1i/3E7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
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
> Sent: Thursday, November 24, 2022 5:09 PM
> >> +void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
> >> +{
> >> +	if (WARN_ON_ONCE(map.index < 0 || map.virq <=3D 0))
> >
> > map.virq cannot be negative.
>=20
> Why? Callers can make up whatever they want, no?
>=20

obviously callers can. Read too fast...

Then following check should be fixed too:

+void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || !map.virq))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, ma=
p.index);
+}
