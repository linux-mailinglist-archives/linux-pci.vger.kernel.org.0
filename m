Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AA7636F96
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 02:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKXBHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 20:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXBHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 20:07:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF4D9BB6;
        Wed, 23 Nov 2022 17:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669252032; x=1700788032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OgIqWQ3wbHzwObxFeRq8Ty0+VGGrLYlMAYNq27ILrwo=;
  b=edRsEt7uKflQnLUO9jpJ1lQu81dOz9Mf8NGc0DNqsndZUTd5JJQj3Pwr
   RromByw7A+cTXq0Ka59ARNx2a23xrNNsya7BYMbiDH/jJgGDgyuJeM7yL
   NJxkYfIUqk3UGset2OKG06zgYtsGdt1VjWfYQjb6ywGFYxvPqGys5LeTg
   1dLlIhwICftdhMstzvHysMxm78sR1rmCcM64eDSxE7qXDv7CmjohTalVg
   AQLraijxtgsTvK5iK9BuRaNdiS6tjfxcEjH3iABq/4oeZ5kfZuj9dOUh2
   /HUjqvA7Ma6UXCqQqBZ7pQ+LfBYF+hMRxUERxDOnPHZ2IG8MuTVpjRuh7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315340884"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="315340884"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 17:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="705559156"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="705559156"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2022 17:07:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:07:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:07:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 17:07:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 17:07:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e01+Txs0SowUnQ0Um7M4VFc7xnDoOvHM27NsZLIpV4dbJCqrWXSr7b2oqFlP8ySWAbhXVMMSOQFbY6r/KUxWsHyc30Jib+q1GkYCsvXlf1WN70YYhmvwDZ5D97wkq84SgCckkfMfiPAHeJ2fafxJrKOrXnHO09ljdFtIuLy753OekZJl0ZBQqT091+2Dfltbigdzsl1ntfDyINrS1RtQKAGm5OH363IfEDwatohM1qaqCh57dvvT+Lunv3+gPkdRXsxCdAhGDWXAQdIQW9Zu35ulLL+BGY4v3F+XrYZ07GeZHj52farKZ2DaDXQncnpSVusoIJYFz/fuU1IXwpud4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZC5tAjirQ9nGnswaOsLHGwCWLwE9eWzWYeaDgu9bGI=;
 b=Vk9+RNGKzkj9eXIs3lmMTaN9NYVoJorlIMmGbKTY/b6Axewp6eYn3Ju7DpeV+nbrcwCofy6z/08s4QEXnG50rW87Pe4PX41Q+J72k78nWwJmtbTKPKIVQ+eXoM7N9NHoPTiPxvI+PDAllOr0uYva0we7DRwu27AQmz0YukaDpZn3XsOQAr2ZPnkt1B7r011tUU7AJWkghk/g0qBaNweT9kDeKx1LU3Z5VIR2+9kgsg6L5qSkV5oJDUwOUIX5qLwQRZqlGfDpVo+Dh7CtVtpFan99XXAaDwV0Akcxe37UPffvKLZ1bRlulIMmC0LldVogVlweQdK3EZokWv5TrWki8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 01:07:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 01:07:08 +0000
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
Subject: RE: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
Thread-Topic: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
Thread-Index: AQHY/bblStmeh1OioEClNZ/eww2WyK5MCblggABa9gCAAN5AcA==
Date:   Thu, 24 Nov 2022 01:07:07 +0000
Message-ID: <BN9PR11MB5276EE7F109A251141E936308C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.879869866@linutronix.de>
 <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8735a9gau7.ffs@tglx>
In-Reply-To: <8735a9gau7.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: 1aacafed-6391-4605-7c80-08dacdb83569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLb2SHR0AirKgRsbmWlK+p3D6v3NXpYQrwW57q7Ua9kIshw+RFYNxy1h4j05DnbZOUheMBPDd+8W4fQcc9BcEpOeQ0kPTxWDEle4tTsL9IyLQMNqNssuoEtkAhv6YigcZoUVJPqTITjqZDc+yEzPQA80aJDqSi/lakvegPoNFkw4wtpdaaL/lmYRzZJHBy6saLSJQcxkEkXH3MeB7OxTXgeftys/eewMF+IwJCiNXdRHvyOB5MULTvHzHqxTWv1YObXmiH6oEGCf7wY0bH2+o+tOr9q5UNGWDqG7AEOPP6PBkKJqo0MduORmT+zh3EZ8W06DIA+1yJ68PPh4z6A6BQJbC9JMp0rZRilXaujK5V+DH687wULCC4fPamiMHf6cDawuVKu1SNagI0vqSEf22s6Vb4v89HmEbD9j5/O8NHdbgO/8fc2Fm609tl85HsMjfftT8qdNWfvbnM8Kd5ED+a3g5m8lmo1tf7mM0HpUZi/Cnts0qTn4ko6kFbzXSAqadbSblM3PUlF1QA4BK0eyjbWZiPV5KsdCw+vDSrVkQ1GHXEwfjUvCas8aXkbPNKkxfiYEIETNCgRkVMdGKwASZtLCNEsYjdWRKzsbNiNJ/MeOU4Ebh3PD1IKFiNpYDHsXjRCHkKMaGxp5J1IZ7LozrTqGc5vCrq4kIcKYGgDCc8o8BzC2uWmfsygJcvm4bVmKenjENli4wdQRVTMtlyFiKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(9686003)(478600001)(55016003)(38070700005)(6506007)(71200400001)(186003)(26005)(5660300002)(52536014)(86362001)(8936002)(7696005)(41300700001)(2906002)(82960400001)(38100700002)(122000001)(33656002)(54906003)(7416002)(110136005)(66476007)(76116006)(4326008)(8676002)(66446008)(66556008)(66946007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1qLwuCVOtoYCI12SK1ZxbKKAnK7gJ5tJT0Ah08QTUE1D8LTIabJcX/U0ux5h?=
 =?us-ascii?Q?8IhXrZMWXoQAhvk8bMx3D1pWURv81WK/lGgGqXpRW7Rfqpv4erNI5x+qze2f?=
 =?us-ascii?Q?sWRH0UMzU9X++yQPk+iNhrm678rkpuVt/Ts10cSVuTCn2cCzrJmZhhRdPdaw?=
 =?us-ascii?Q?6h3DMoyccG1hZBagxmcE+rXzl01XWgpkVjo+gaVnD0zME51qScppWkH1eSB7?=
 =?us-ascii?Q?f5l7fxaTogCEOcikFNxEG5wDwBhaIkgNSFmO/WaCBHC6xXcLMgF/3A7SPr9s?=
 =?us-ascii?Q?RQDpbtysO7mHPlctrjtKUvQt132gIIL8h9VOOYtHQqYE//uEkvqb8joaGUtj?=
 =?us-ascii?Q?9uaH+cbhiH4JRWlarXfm/GY/YeCx6NbxeMyb+Tvj1d4G+EQjikbaRPcY+YYc?=
 =?us-ascii?Q?NDbF7np+9wWr1sOesmGvJ9XQaw37lNuVhI2hQrqBtxYdP+iGWBJJOPkPYrdU?=
 =?us-ascii?Q?H760h1wKaqlpgo2SrPfGfGYH0+sqQrE1zQIKw3xXme6yZb1U+3/5/ASt2GKH?=
 =?us-ascii?Q?gnvXrsy/EqHhedvZ22DQkjEjDKGwMvrBUMaL+X+P1BRJsniaaFuwS/wUUNKY?=
 =?us-ascii?Q?prCGonuiKjphL++99eMDgtm1b651PYjveWGq9YPN/+nDs8QPT1sOWzWmjGyF?=
 =?us-ascii?Q?HIexyImbipTEt4zBEzTjHeNldPe2o2VdmkPkDDucgvfaAjccR4sRXkXUBW0I?=
 =?us-ascii?Q?q2Mo3KPZyBb5iwxQ0xosC55b86WDOeEXdvOllYr5jGf5Nl+MdhUU87LmMZrm?=
 =?us-ascii?Q?5RY3qVAdBv/DYf+0ZtYneufyc/sxtGuLicylG7NW02RGfxv1TEZnVGuGtqoS?=
 =?us-ascii?Q?/e4AJml1YRRJ6dEmBohK8J3sNem1yUPO5IW1tpbiSKD+EUNvkfp5xFItEkZV?=
 =?us-ascii?Q?ZI0U46Mn7+tWeYIast9fI1kQOj82kJJSk9IXugOeh+jVX0pkuUEUEbhxHp4P?=
 =?us-ascii?Q?UikQvEZiJkMIITS9ZyUG+2z7TpdDLcpnjdwUzj6F8FbZLxkNg04OwKMdp7Ek?=
 =?us-ascii?Q?K9hZu8xJUgrhFhJTvdkl86WWex65qMsqTHO0UNdNhoCBMYWm62nIyndeuhr3?=
 =?us-ascii?Q?NA9COuatJxLyrxGFoMIXfdDuXTTJ+tTK6R9LQqQ+0jhwNqhuzv1UuWFqbNww?=
 =?us-ascii?Q?mYaFL2AVRbrXMzqcxbGYinmiQW7C+iOq8f4w0RbBD8tdHOweyWnrl4Gh8c11?=
 =?us-ascii?Q?0+axRP34iHl5lJ8ASGKVD5lAdbeOiemUx6mSD9BdGR2sl2gSMyp3nfsZRPXY?=
 =?us-ascii?Q?IRmJ2M/DQdhJ9N5wdc04L8+3a82vlbun684t7eBxM+NE0PHhETLoPcvS+1/U?=
 =?us-ascii?Q?YE7W/f4fKZkSEsOAjN/e0QHUS80/9A7zL2TsiNS3zDG+sxWS885awvqGHbMI?=
 =?us-ascii?Q?hf7SOOQ4oN+vX/OArYikaYcW1WKYoAAdH1eTSiI0stBOZ8sFOsX0Q7P6Wrah?=
 =?us-ascii?Q?iqC6Xl2b0dShqKKqgmuOaYpMsy5c6iv3VPhlRU3oNoaQHoh9oF9qFWGXtmAi?=
 =?us-ascii?Q?hW6u1BRuRM5wknOhIyjITr/aJ+X3HMSFV/s8j/FvwbpQGNrxmL1o9hIwIYDO?=
 =?us-ascii?Q?jLRelgzsS1OlhN6Tt9J8Er1wvvSyX5lA1j804qqL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aacafed-6391-4605-7c80-08dacdb83569
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:07:07.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7S5SIvuGi6SUJdB7if/GC5c4VlyvfU6KuaHYSTsva9ztHq/eELsSPeCRsUgKzYM2QcFLYAUK8aH/13pwzWDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, November 23, 2022 7:38 PM
>=20
> >> + *
> >> + * Return: True on success, false otherwise
> >
> > Can you elaborate why boolean type is selected instead of returning the
> > actual error codes? the outmost callers are all new functions:
> >
> > 	pci_setup_msi[x]_device_domain()
> > 	pci_create_ims_domain()
> >
> > I didn't find out any legacy convention forcing this way...
>=20
> What's the value of error codes? 99% of all callsites do:
>=20
>        ret =3D foo();
>        if (ret)
>           goto fail;
>=20
> Nothing evaluates the error codes, unless there is real useful
> information like EAGAIN or ENOSPC which can tell the caller to retry
> eventually or with different parameters. But for the above, the error
> code is just useless.
>=20

I looked at it from the outmost invocation:

@@ -436,6 +436,9 @@ int __pci_enable_msi_range(struct pci_de
 	if (rc)
 		return rc;
=20
+	if (!pci_setup_msi_device_domain(dev))
+		return -ENODEV;
+

the current style kind of converts meaningful -EINVAL/-ENOMEM/etc.
into -ENODEV.
