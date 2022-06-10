Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84015545CB8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbiFJG5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiFJG5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 02:57:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7810D302;
        Thu,  9 Jun 2022 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654844250; x=1686380250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uyA7w8gGmbPGpbEtfc80AwPgxDRyayiPPUAF2eQcckM=;
  b=Xq9MYIHBL9ZI4WkMaLpFq80xW/s6zgL8Hfk2YBgtDv/PM8/wwwyb7NYQ
   QvnIHqR7fW9uLklhUuB04Df2x/jUffHGITnaDcz2bqzEAlSo3gyb62AuK
   GPVp9PyrZoUIcrlqcknUMBBfnRYlnS2CuD3mFTCn9qVKm6oAw5sl5HDAW
   Nfj31YmeBYesoVAXfCphW/9GpQ8UQ6OKgnvPjYBex+UcfHNc/3q9fdXJh
   AyFnGBqSKUvxihKSA0UiAAIFPQNHvVUtFf0cYTfs9LxbYm2NmENEtsz1F
   vx8fy5KauU8RB/Xso6ZtWsGSnZedK+8ru2UDj+qSLbUw9+yuRH8AKPB1h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363867086"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363867086"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637981468"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2022 23:57:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 23:57:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 23:57:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 23:57:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUjf3RWPXE2nhZN6BrQtgZStzL+uj/1JEWGoKZ0jYfZxSzGeF8gBRoSRnpWSaBvlqO4m++xO48iDCmcavXHJEwE5dAgvz+aIVLt7b0kGvlYDbQPllHNhR/QkjHxR28USUxJkCPvVzlubDJ4s1NydNkbJS/MWdKU0BvE0siV1ZYnBaZ6t5EoHPp+iclR1G6jI/pUbIp31OSvxQun5poTpqwYvI3lNhoJlZz8T3tQgm6MNcCy5X+7mWjRsyrsnR8nnvssbOUx6/tf5Z86OrrsYHvvqETdQwP8YUjToODpI70g96jMqbacAW/kfQzgU7ZTmloCQIptCMueAyMlaaPxa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfVlsroAQ3+wRXigLhZwCUfKJhgikB4Kday2iK5nF4w=;
 b=U1KLZ5bGWBioJbGrXVRbSjR+9IoX/ylbHt2wmoTjshbW7PDLHztjlZ5tB/VKdCfyGfIUXGfQUg49lBvgFN75+pZMS0ki8nmNw8dsiWMfzbAPIhHG4ve6QVkbAVPeMPHfKySSXVCfmw35vLykefqkrClcCn/dGSNpD2tNJnavXBnqdUrpiWzVnvtimX8Iu/RYpRgoQw74xtxnBzyNcMRRswkqu8LldJjoXtIwOYfmnS5KsCj1lwRQkG9G3dlg5vDBuBGc2jqIkVwo5kBq8gPMfY8Omb3imTxl1XlFVuWZ2GdXqVyBUhORORBfEVvxV8H7cX/wD4xY9IAklMrUoXsIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by BY5PR11MB3862.namprd11.prod.outlook.com (2603:10b6:a03:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 06:57:27 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::1c62:2c43:b52f:f042]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::1c62:2c43:b52f:f042%3]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 06:57:27 +0000
From:   "Mohan, Subramanian" <subramanian.mohan@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: RE: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Thread-Topic: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Thread-Index: AQHYdR3Tp8Htu1XVkUWnASKhV7DpSq06ZPhAgA3e/ZA=
Date:   Fri, 10 Jun 2022 06:57:27 +0000
Message-ID: <PH7PR11MB5862175ABA605BAB7FF62E0EF7A69@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20220531132617.20517-1-subramanian.mohan@intel.com>
 <20220531183920.GA770895@bhelgaas>
 <PH7PR11MB5862B80BADAFD6A16C56B476F7DF9@PH7PR11MB5862.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB5862B80BADAFD6A16C56B476F7DF9@PH7PR11MB5862.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 679b70cb-d44e-4e65-9d67-08da4aae7b1f
x-ms-traffictypediagnostic: BY5PR11MB3862:EE_
x-microsoft-antispam-prvs: <BY5PR11MB38628CB276EF5342F6E73288F7A69@BY5PR11MB3862.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L8hjtMarCU8CC351MQYAPd3eoN+NnCjUN8iQfCqnazhUOXpnGc3p2KulJzqV3XgU0Kf1vrG6OzzkxT5w2EMKkD7hOuSWBmdhTAZdRs1i81jAVGS7Yf6j3kOihJ/D/en6Ya1CEByvad1xW/jHMt76dlqyjpxtpus+e5SXsiCnYjlRwRcwUpEq0/1XKwOppoPLxHU2U5eUqKJBl9aS/3lQd4Is/zu2TVbHZ6OGclKA850b+lJOhegrWWmYloV3/BjEL/3moH8X2qsVHNGr+ibWIn5XPUx/PCj9AbC2jOj7rfD2tB98X501NtmAjH2nuOSx04pS5jFZ+pshsFTpbhW6jBH7pyv1ImVFWsK1E4epQAZ+JfoelRWsShDYc6rHrYqKrYLa3NAWjz6TXSKsO1+TjBgebTly/VsUa8aLkLfl4+npus+3db2ll1fncLYNtE1rcqi7fhiVKdBizjT7YVfe8POJUAUq+oPS53R02+TXdMThYhRkvoxPTE9mtXCWpsizsFh5jAnp1hnZyerPvIr/KMSjRuNLuMhxDy/k72m/IlTSiuiytwAd9k0l2CpnKu0pRihG4FboglciCwH3s17qLrh4PtrmapHty7RhtcCocB7NUrQR+PBn9HQcwXYGlR7r9PSocehPRnM1wEJUi5q60RTNKdFY9odUdUIF0hJJXUY2JGkW7Z0nYYZ72v8/jb8XZD6nljziWkCSzb5kW6Ip9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(186003)(26005)(9686003)(83380400001)(53546011)(55236004)(7696005)(122000001)(38100700002)(82960400001)(508600001)(71200400001)(38070700005)(5660300002)(86362001)(55016003)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(8936002)(316002)(64756008)(6916009)(33656002)(2906002)(52536014)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3cW37lgT8EpVD/XEgYtS1GPxbqXTckmNQ21CM7Dr67ohjN1RNevhmjB9kZId?=
 =?us-ascii?Q?ogC4Yvbfd+P63m6U0NznzLdZXxG8GTj5WYM1iisfzcc+b4IZcshZgsI8NYiB?=
 =?us-ascii?Q?NuYF8C0E5rpLpfe6O3nX0k9Xc1wEeo6wRY5nyzhdvf0TOkT6G9jWfPeeS8f3?=
 =?us-ascii?Q?cH2lLGu0Lyq9coLBdknEly+Tj1oxrnBpnFk6M/q/sB8NCnHPD71Fhw3IDZvX?=
 =?us-ascii?Q?zMccpyJF8hy9eiUdkg/cf8d5aaq/jgb9fpOvYfUndzZGazcthVG2YW12B1Gy?=
 =?us-ascii?Q?MY8AnMY+HqVjQWgPXLEe0z0IpnpCW/IkmP9xC7Epakn8pddFduo9ylEd3qny?=
 =?us-ascii?Q?snMXWtUxg8TLZpm0Jxe/NWPT8MIxX0IUN9IiJO4NgJ0N9yQbyKRGfxuv0zsA?=
 =?us-ascii?Q?0AAB76ga7mjOhWSM8VxXdsxFyJr2ged0b2GD52HzAZsmWeSIp1Jfd6ACRaj7?=
 =?us-ascii?Q?n1HtVid+KCMv5vh4UnDSYjxot7FVYuqzS7Q8WiSpdcY207O7r8yLNapEPk2r?=
 =?us-ascii?Q?wErz/mfNq0Cp2PYmMinGclwRvzzU3RwehLYzO2d/Id9Sj4k9O3u2JOhb5cf6?=
 =?us-ascii?Q?Uj0goshJAr6w2G17mJnjqO3cu1wd5Qdy+TvLvQumMRXoy3n8+n3tNwUW2xoN?=
 =?us-ascii?Q?68J1/xqXntS+VPUCtkWQ+MRT0rgqTbICJ2doxIeY2TiJMairk34nobPosGuC?=
 =?us-ascii?Q?B9rxviC6mJp/IQv9ptk1njBNP7rPr7Yda16/nb+VBducku+v8BGvhYfxolYO?=
 =?us-ascii?Q?M0gd41EkykfmtcjNvtYHl98wVS9XiJXBCcyNCsqcnGPhY1PvcfZXpwxXL+xA?=
 =?us-ascii?Q?ZWScKKCkeT9pwSU3vXccvKKKJFLa1AQbf/GS012rZn/OAnsVkELNjK00xhe7?=
 =?us-ascii?Q?U5AezSNtPFTRB3crvU+lODc3qXMA7bStY3eAhiOu/uAjo09MrL9dIFAqmTun?=
 =?us-ascii?Q?PGOFEpCL9YwxMsQVDgJCoSyYpvrZTewS/jlrm7cwxiKw7bBuln1DRKw1jbzL?=
 =?us-ascii?Q?C1MoRCa5csvlc/1Ui5N/px9QahF4raQNCgPAf2u6b0p1lVQloGFdqqB+Dwj4?=
 =?us-ascii?Q?acyROz4cBvaoa9HgI2muVCwVngVvZdICzl1EoQYS1Y/XG9JxU0xfDGTRwSB6?=
 =?us-ascii?Q?LR/LuZsFnSsmmtR85F4FqDc5sRD98AdcFzxxfE+Tkqo0Gv3JJXfUpPIzC3N/?=
 =?us-ascii?Q?3nZAYpSmZviLW7IubiAkF7AIOCyl/9aCiYJc5tLmCTAz+9wcaD/zqC3/dk5X?=
 =?us-ascii?Q?CR2tnn2lytRA+rvjW/rZVh3vEZOakyIKVmGG+XSxb18lKl0rsdisrTorzUjn?=
 =?us-ascii?Q?9YMM+0BXVzHdj25sd3JerCS5fLrwVX6AP97B09SygAOTAQHDA2H0Ehh1PxEK?=
 =?us-ascii?Q?v5igiiUbnh2EECbnfiraHNkU7+zAZWtTYxpB4ON2z3/yAT4bWFHVFewnChaf?=
 =?us-ascii?Q?tGTsWOBHDf4SQyHtEI6Z5sHZVZ4pNnZr5t9QBZ8MREZxsANfJAq/4hLj88cn?=
 =?us-ascii?Q?hZoZoj8nFrLkEW1gVjCsgwC5owI1PpWp2qlGByYPUG0BjFecX71Xrbw1XSMy?=
 =?us-ascii?Q?I7/d+EAITLhu3FxZmwPXQXwVW18fsLJtimukzwOenkF/io+EiaOs0N3EivlZ?=
 =?us-ascii?Q?qWa91+OI9p2Zn0lJqJk/0pTFkhAEHzctBi6Qh1nd2cvQm42T8wgLyx8zSUYC?=
 =?us-ascii?Q?vs5jFtiP8Kspn09SrEVAE4BUorCR12bHy98Uns9yyeB8Obc1dWurrjaR0pUL?=
 =?us-ascii?Q?pC1dus/iNBl+pI2dczacQBb2mBn5594=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679b70cb-d44e-4e65-9d67-08da4aae7b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 06:57:27.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmySAmfGP7u1dGK5ARbs6rP6Bt9nrXvtySHxhiMiWDB/aYafXKFzm51FzdgdwKfyOUUYbMps1KDTtXTYBJnqiHGcuptrhYfC5TCkOLs4pfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,=20


> -----Original Message-----
> From: Mohan, Subramanian
> Sent: Wednesday, June 1, 2022 4:45 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev;
> lorenzo.pieralisi@arm.com; robh@kernel.org; kw@linux.com;
> bhelgaas@google.com; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> <Srikanth.Thokala@intel.com>
> Subject: RE: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kaspr=
intf
>=20
>=20
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, June 1, 2022 12:09 AM
> > To: Mohan, Subramanian <subramanian.mohan@intel.com>
> > Cc: nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev;
> > lorenzo.pieralisi@arm.com; robh@kernel.org; kw@linux.com;
> > bhelgaas@google.com; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> > <srikanth.thokala@intel.com>
> > Subject: Re: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple
> > kasprintf
> >
> > On Tue, May 31, 2022 at 06:56:17PM +0530, subramanian.mohan@intel.com
> > wrote:
> > > From: Subramanian Mohan <subramanian.mohan@intel.com>
> > >
> > > Use devm_kasprintf instead of simple kasprintf to free the allocated
> > > memory automatically when the device is freed.
> >
> > I guess this is pure simplification, not a bug fix, since we *did*
> > free the buffer in the error path and in vmd_remove(), right?
> >
>=20
> Yes this is simplification and not bug fix.

Gentle reminder, kindly let me know any further comments.

>=20
> Thanks,
> Subbu
>=20
> > > Suggested-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > > Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> > > Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c index eb05cceab964..7a72948e001f
> > > 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -897,7 +897,8 @@ static int vmd_probe(struct pci_dev *dev, const
> > struct pci_device_id *id)
> > >  	if (vmd->instance < 0)
> > >  		return vmd->instance;
> > >
> > > -	vmd->name =3D kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
> > > +	vmd->name =3D devm_kasprintf(&dev->dev, GFP_KERNEL, "vmd%d",
> > > +				   vmd->instance);
> > >  	if (!vmd->name) {
> > >  		err =3D -ENOMEM;
> > >  		goto out_release_instance;
> > > @@ -935,7 +936,6 @@ static int vmd_probe(struct pci_dev *dev, const
> > > struct pci_device_id *id)
> > >
> > >   out_release_instance:
> > >  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> > > -	kfree(vmd->name);
> > >  	return err;
> > >  }
> > >
> > > @@ -958,7 +958,6 @@ static void vmd_remove(struct pci_dev *dev)
> > >  	vmd_detach_resources(vmd);
> > >  	vmd_remove_irq_domain(vmd);
> > >  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> > > -	kfree(vmd->name);
> > >  }
> > >
> > >  #ifdef CONFIG_PM_SLEEP
> > > --
> > > 2.17.1
> > >

