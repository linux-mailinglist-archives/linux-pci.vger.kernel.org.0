Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38366318E4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 04:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKUD0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 22:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKUD0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 22:26:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C81CFDB;
        Sun, 20 Nov 2022 19:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669001174; x=1700537174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TfE7hNEvwkEUN4d9UiB1C0H/zZcO2Tn6z3ryGOtmc/A=;
  b=fgHy0tXydIxUz9ZML1x+aPe4yxLJDG/3UMusi9IVnpIKmUkIHpXsL/Lc
   eJfJ86v8TX92Lxs18/TmSu+n100gUqNB4J/YmSFloHoUUWlR2QkGMPzQQ
   eRUVGwSuR3JODri9uLhYLlJNxghrBvi9lKOFuMFwLBM2pMJB2zp4OlVFX
   vl7q14j9h9wujJixaN3vrfiVsGCPNhzzHEwbPCqdv2SjzZBmipCS6mAIC
   UGSD3Rw+fScr9Y71XDGC+ToQZ+314wCkKIH3KT4y0RAwJjRvgiRrWhMnm
   T2fTzB7RTxVjHlGuomUvWAWJtw9RvH7WQ1Ykutho8ANaTSYiFSVsfhYz9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="340318631"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="340318631"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 19:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765816004"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="765816004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2022 19:26:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 19:26:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 19:26:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 19:26:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 19:26:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiMf6z/TU9xMh0uB4SvQw3uTSFDWyDhb5kXXM3XGiAn+ogkDHaS0gDvWOh8k7HfkYkWqnZzJJdp+tbBqdzEZYhBxD/9MN6ObvHXp3NTta5y1Vi5L8TUmhXm50YdNzI6BCX0dzaaRQ87/V+foiAcULSH4cXb0ODP9AswTnUHwkdzQQIfBxojTl0R1LEye/PP7PaU9pP3CGnWU0wbpYXK5I3Go0Cc9DozSYKs2mlKbetdwWuBujxMxM4lHcLBFz5aUWN1OF0eVt/6xbL1+BHR7ceYWzq4sBEOy1izdf16LizOASgCdOjPUOt7Gvt49gqYkSiZOQDSnQPlIBxAAWuvX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isemtXkS5cNHA179/qwyL3zzCyijZUFYqF2x1/STV+E=;
 b=WngEZiGpg505mMN3t/wpr8eE/qvhmqZbQmOcz8VVhKhVH8BK1eOkXM12yKHOqV0/gJ5epIKkytG0aTqadTTS7drBFwiukCjS+5trjRRiGYwZArxdd0ynpd+a8pBpOhFQe2JA3ROm8ZdWCD/60naeU1kCw9558FaOds6S9tXzviYOctNmNGcpBywXNt8zBr2SSBXRz8/EaMWP5aTYo5gox4Cb1FcWJWFgMpkFG0gOTtUbRkYmLXteOhbLdkq/AOioAEw9t2E07g98n27dQKSY9dKPLu6DDOaQ6Gq73pYKZ9Covn8bhwcfwIQYxUnNY13JX3SyGiyjTY3ZBqe56d0r1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 03:26:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 03:26:11 +0000
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 15/20] genirq/msi: Provide new domain id allocation
 functions
Thread-Topic: [patch 15/20] genirq/msi: Provide new domain id allocation
 functions
Thread-Index: AQHY9dWAtezPKicU9k+8s39P1gVnWK5EOeAAgABsaICABB/0YA==
Date:   Mon, 21 Nov 2022 03:26:10 +0000
Message-ID: <BN9PR11MB5276F29068E4B9BEBD088F648C0A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.892426212@linutronix.de>
 <BN9PR11MB527679752FAA7294E33619C98C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87iljcjvny.ffs@tglx>
In-Reply-To: <87iljcjvny.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: 0958a70d-ac72-440a-f52e-08dacb7022df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6Bwf8xdACZ0sYwoMtAho8xZGFW4pAZWt8Zt9nJPTohJtVGfLvu5CYiBjllhC7OjOiFH3UJiaGjTKZF8apYji/i7WXNYLXO2JQgKm5zRjiczYcLdC3yzpe3QI8p/tfSnSjthcRxo9BLrGR23oGymLUppQje5phQpwn/hRCqN6r+P3Mz98xVqaFn97PteaLbLtmUCtnJIgAjKJ2/dLy2qegMPe4Mhp1oBuzLQkimc4eOENRfaPaLNOuI7qRBsJJBKzE2GUGtZO7cEiWWHIwbD0n6qs7F2gy9Z38T/355TBLFqABEbx3Th5IZbKm4O8mPy8Iwz/McXuEPR0hr1zaymd+lYBTqVNFwDn5VmZNOTfCvFUrwr+2BaL9wY5e4Cks0w3f1rcz1rioFgwdv2MgFzeO4kNlo11Dd2YnCiMcT/2aZTin3c2uI/MaAkdDwQWxA9XjO3BtkZJ9oyDoZ9qbg/XaoSSCPTsxj3Qa9VXgxrJVDifMpmjOY52BSkl6LoXUGuoPfJwAmR38nA4OyewdN/3oee4accPRgfhp1XcrTSJNjecbtLPCSez7enWOG0OBJpVX11grKilFN5HlASfQ9Hksmr+0OhygsE/jiXBVEjFAAohs+0C3nEL6Y1sqJyEaq0RqrmewWAK/Q6Pf0IS5wB+JwjoMBIaqzVPLQ+h48+TLBRJhiR2NJiwLcTJeMkDsBTeNIruzTLyjnUj3rrmhpJiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(9686003)(83380400001)(26005)(186003)(122000001)(82960400001)(38100700002)(7696005)(64756008)(76116006)(4744005)(7416002)(2906002)(55016003)(5660300002)(52536014)(71200400001)(54906003)(107886003)(478600001)(6506007)(4326008)(8676002)(8936002)(41300700001)(316002)(110136005)(66476007)(66946007)(66446008)(66556008)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CsmR/+zRa3dExHs4RiRiZy0warQcbun4euKWYeVvKb1a3JnD3/NpF1piylde?=
 =?us-ascii?Q?FjxDCE8yzRLOE67izQdS+59wH0fglTdD7BV9U7fLRAgD7kEXV1jQRZh3MF21?=
 =?us-ascii?Q?iqJOBpPoiUXUa+g8XPey89waAAxi7TPCWZP+fYH/vTQkVZH8dgli1FzkhyqI?=
 =?us-ascii?Q?EmLLMsAfBDzrrcH8pmBfQ7SqKdzitiGmLxr3wUnizGgKvG94FDPxnBze0jlE?=
 =?us-ascii?Q?WPww1OON9ysxW/M2FN+S89uCsB7ufgMlIsoZ7IqZ7lxgOCJ9U4qaZJd7CUsW?=
 =?us-ascii?Q?AIGCW4aclXQKzNeBh2wHR0rrnSD2+Cm4KBREuekHYxHnsbkBPTykTswlmr1U?=
 =?us-ascii?Q?jqGkZjoOjRJbjvf3SWzcaop+pBXCDDfsHRaYbyPdXuEgneLQj43tcXfLLH1V?=
 =?us-ascii?Q?l+1+ZTtmJrgmFdsuxc1rApnJe4aiVV4rgDD13uVCsnXmorSsH7bdcdAuAXdV?=
 =?us-ascii?Q?sxh6/u+EULFiVGWu723tdaSyuwtD6lBTvgb48wy08o995PW2ftJRsc8H2OJb?=
 =?us-ascii?Q?MDafCRgvc8zPw1fWm9qfqNApqhMQhS/7mnH+vLiUt33BY9zsVRshV1EARDkL?=
 =?us-ascii?Q?4R7lVvFZsQgg1BzMQ0E8vr8MRL7NY2n4AcQXxrlguPQhIkY8s/oe4dznWGuP?=
 =?us-ascii?Q?W02GsijZEzIdTkpZR5oudltwAHejWpGZCH0Kp4GgI+RgY3OfZeGnzngqbYsV?=
 =?us-ascii?Q?7ocu/gdCEAY892eEyc8j2LcXJ4Qa0oAylZX5ShQisX0mj4NMWbcpRCziUPOh?=
 =?us-ascii?Q?dpQnHFNHk0A3NFlAhdLf4QyBr957dm6N70YfatJqehZBAriEb4gQ9YTErxAh?=
 =?us-ascii?Q?gCGkqgRNHd9ByZbsYAVQtZEtIrr+SBk1m5/oASPHDO+DKBTyYgHVOYws9wq5?=
 =?us-ascii?Q?8TvG3ouAOmz1WsXlSkJYGrrBhHVZ1PSB46X5zGQpLJD6b74gz1Kghlma4YHS?=
 =?us-ascii?Q?r9iPc1XtvziGdDN2xN4uiMKf/HPmAo0hFHy/WIXleQ1NQlIyNYt1vKGxxMcq?=
 =?us-ascii?Q?lxECd1n8899AZSLgyY8ZxsyHFKb3/Q3R0WzRrzL/AMtXrs96XheaewXlpA77?=
 =?us-ascii?Q?9hxO15SE/JQGctu5gBrQySwWlTxdENE8eNg0pQHeGvxPXh7IAGMy4AO+LS4Y?=
 =?us-ascii?Q?1oKfJLqucp4De0PZrurYu7YJGai5g8hos/eYdARFSn8oURYuxfjvfc5L4b36?=
 =?us-ascii?Q?d3s9nGUN3BV57HKI8QMdN3ULuIkh7Vb16LEhoebSbiH0tUS8IqpJsTHAGrOA?=
 =?us-ascii?Q?iYPdE895WGjZ3Gw5cIXggcdT2bc9wboP84H927gWu5oTBxAMxlYaMnfUHiud?=
 =?us-ascii?Q?ej552IUki1aK5iQm5F1+kuH57dtD0YKFyDFbf2/bMSeyzs4AA6D2C+RupYTF?=
 =?us-ascii?Q?wRrvs8Xxgea8cO9Co1g0Pn41nIrE44qDoXyhpjrzw+pVFO5GSEKDOIG7zavG?=
 =?us-ascii?Q?CIH7ew2+Lnv4kGausYOfpQjRmuItgn3SFkEYs8s2/D9vgXUTT4JACnbduuTE?=
 =?us-ascii?Q?qGSBbKybO/kaj3UkNIES32cM0ywW4rReZs2z8hTdN/gG8PrmcIT+VX8/slUK?=
 =?us-ascii?Q?DqUkcg8qHWsghYSF5HJpM1vxsVf8aYU1aooUet1e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0958a70d-ac72-440a-f52e-08dacb7022df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 03:26:10.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJx5+6lp9s7NCRZ53FYU1vu4p6+uH7yzeOd1PkqDUjpQZHH/miuDQiJ3m2DAtKdvGE/9Gozkoe/MW8ZoQps0ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, November 18, 2022 8:26 PM
>=20
> >> +	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + ba=
se) {
> >> +		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
> >> +			continue;
> >> +
> >> +		/* This should return -ECONFUSED... */
> >> +		if (WARN_ON_ONCE(allocated >=3D ctrl->nirqs))
> >> +			return -EINVAL;
> >> +
> >
> > why is "=3D=3D" an error?
>=20
> because if you get here _after_ having allocated all interrupts already
> then you have more descriptors than what you want to allocate, which
> should never happen right?

yes
