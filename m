Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B614547F87
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 08:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiFMGdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 02:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiFMGdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 02:33:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7063DC;
        Sun, 12 Jun 2022 23:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655102013; x=1686638013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y9hGbqruErSSwKNR3/fnnivLvgoEcCFYKPXGHFaWaaY=;
  b=KHVJWFOb9zpruBccpDVFyc5eHa7d+5Vou7saJhBvBLZoCKNOLsrigUpu
   jBT+vZ7eG16ksi9NRH6XSlNx7YuZLcWS6yVdLHe53B7Jn80SlaDdA4cYo
   lBvCHn6vpRKqchBf3WKkuwM8ObhLzcqnkBmu7pVqVofqUIQFxfLq0EtHv
   QrMcndsKIIm53zeUhHJ7K4ATDSdI9WpvDl3dkLsYF1FJ/lVq3Zi+1UTi/
   ytcNXF8QKwJuOLxCKDmcKxyFFhOI1fx7Vth6iCbbe6BTsEA6xCKecSUg4
   RUoVcykIhXwmjWiVqqsH3zqz+6K8yG8XAgfNDk6XzdP+QhL8KoMd10ij8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="261221228"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="261221228"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="582081383"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2022 23:33:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 12 Jun 2022 23:33:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 12 Jun 2022 23:33:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 12 Jun 2022 23:33:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 12 Jun 2022 23:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhmm/DsWMiGWEm51U6bcAk9wxXEdnOqSIC3JVlfY7MQg0NQEAkszpG2rv7lSFHFEmC9pH9GpRtTvaLFzUTWSUVOUePgfCZ6MQ0ZURg6acNloMh3pI7Llyx/aznj3ivkmItddLT1I9D+YZTrjoBM9UpxVcWOyibvs01VooFHTx/nztXAJRJR2rNX2MaoswhaBEtcfdVSAmreKhXH8cZPAmRiOEzvVULVJYXN719f2J4Ayqwt9Y0kdFbg66zQCTiz2t7m4dOUTXVJgjdhaizO40cYeWewmlGJoiro0bCsnLK1gloWMwypI9M4IdSgfBlYTIQz+jZT9L03+x0Dwq9NpFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjPI+9Gfrnzova2p/iWR/KzWQe9oEr9lTCDxPLbNOHI=;
 b=GbaTzc1ZtcwHItgMETeoSZeSJjwnjwiKg65L0ZEzOVGNXw2ZXg3MC0eYiY8R/sM0EuUuxzBe35Rax5uWm3yCXE069fMvv6VqSQ8ieb4BpooFU22runYdqk8hHI/4kLwACtNXkO6QqdHMZhM3oa/Pv3dUXlxYbWljHCI+aISAQvOuwdCuk57CVuFztlq/dBrn2UcqomrF0HX+FKhrOldfLHe3scUlaeEA1hRa4yFoT1/K9daC3GxeUAZICBHXxFK1WeXpFyTNyGCMYGYDB6r8Qsn/K5ikGG/1b7ShVIFIPdtHo755GDHNYGCEj/iVc22EF+hxTOp3Vu4Zl5B12dV92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by DM6PR11MB2858.namprd11.prod.outlook.com (2603:10b6:5:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Mon, 13 Jun
 2022 06:33:30 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::1c62:2c43:b52f:f042]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::1c62:2c43:b52f:f042%3]) with mapi id 15.20.5332.015; Mon, 13 Jun 2022
 06:33:30 +0000
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
Thread-Index: AQHYfNj+p8Htu1XVkUWnASKhV7DpSq1Mt6uA
Date:   Mon, 13 Jun 2022 06:33:30 +0000
Message-ID: <PH7PR11MB58622C3C639058508C8883A2F7AB9@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20220531132617.20517-1-subramanian.mohan@intel.com>
 <20220610144724.GA597886@bhelgaas>
In-Reply-To: <20220610144724.GA597886@bhelgaas>
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
x-ms-office365-filtering-correlation-id: 899f7b03-9313-49f2-00e2-08da4d06a19c
x-ms-traffictypediagnostic: DM6PR11MB2858:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2858851392A87B180D4FD571F7AB9@DM6PR11MB2858.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bspgisZ8pdNc018y7QbKZSF6cdYorPilC0tPMmuKK7iDQKFs9tJ4o/GXYnNFBan8EHPNW/Qsy/o7LMSeo9zwd8BzuB9+wsGkif/yukYycGdd/SuCXj94VOFwwndwObsrcyuoe+yV2jZth/ZfcLSLXqzwDrI3ZBO8B07QvIVBog11ELbfUvdAhSYOzWYAcH0xgGP9LY4d/DMMkdP2EKHxYzbI0OUqnWOp7Zp5L+Mg9LtnDpfL7Oy7gB9l5OsBeYzyIegaAY82O9Ez7YkETW2wsXEDnQXuGgwvEQBBTmlXpXGjoDz+RqZ/14g2FPBujMMa1aSTown7CwmeCu4bGGG9A17xg1B4Iu4lDojPXGYHsAbT5RRPKFh88YeZ6wI7pTC8tdHjcFHMaQ71eM8SX97gGUtnVH/yBZP6KrCRKlriUrVpIngulIB7EChcC78mt2Olaas6sLzbHoZnJlKnI4+RtuykxECxZHG2NdkJSvHyFVaPyS4gwlwgtz/NlQQl393dRIfibTvtn+Nnyt1NyTqQ1wldY5azVRBeAN4mVU+ijNZ7gFCFuHECChSWp5n91c2wzx7+wDRr/0ySGqVUcNtWLYo/fXVL1lv/2x5WMFYKd3bph4rTotXjk2gbqjo8sY8Pv7TyWFzuA/bsX7s3d4HOP3sfKxp1pGBCOnutH5x4uS0ehHb/IukDv21z7ncuawin/HTxlHtnj2osy/Nc9udh/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(66476007)(186003)(55016003)(4326008)(66446008)(66946007)(64756008)(66556008)(76116006)(6916009)(71200400001)(54906003)(6506007)(55236004)(9686003)(26005)(7696005)(83380400001)(53546011)(38100700002)(86362001)(2906002)(316002)(122000001)(52536014)(8936002)(82960400001)(508600001)(38070700005)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KnXdOvWjjPD82/t5kxwPug69QeNNYBXO78rsPF2fD6b7NP6SOJzKzNdvddyo?=
 =?us-ascii?Q?c/LtOQcNNX7JC//w206azoRxVJglmmrjPHr4SMk+Ut0Qa4g4am4mMtQdngt7?=
 =?us-ascii?Q?KqROzOIAF5rYdMR9q7pLK9AmGko1K10g2w135RMEoYdOExbP8pxRYt0/vik8?=
 =?us-ascii?Q?caTKioAP+syx02RfV3EQdh0i7MJWn841K0NgDof0LjkWx8gEPxBT/llMV2Wo?=
 =?us-ascii?Q?RmIfmW3NmeC8bon4ytszaKe0sg+ADDP5uYCAQT0lUqB9Wxnk9ZF8onxNoylW?=
 =?us-ascii?Q?zZi8WBkwphuWBbX8blUVIwoY1BXarJzfgaQWx0npYh1juDrEGr9IyNnEMP1f?=
 =?us-ascii?Q?mdy8PW5vwVFGBOieQ/k/9RGETRkSTO/9NZs920/cXwcubZqlHB4bmk9C8tpJ?=
 =?us-ascii?Q?9TOAYWiSXOO3JRHfWBWC6Ur/XDtYJ0hTuKxFrB7XH3wJGlgYq4ODzLsjGL1U?=
 =?us-ascii?Q?ScVAaKTdNt2KTsCvLO8eU3i82zY1ivmi3YYOhw4E3VSHB4NDJjMjpaZvZuW8?=
 =?us-ascii?Q?ncx9jLxKBoFga7QCDfJ+YGW609zobd5X3CQLDkIKMZIcTwdtAQO08sVcENKK?=
 =?us-ascii?Q?EIi5115n7sTDARK7i81spoyQ4+/mrmlFIP3kWGgkzv8sZzlJTS8xIW4i0mbw?=
 =?us-ascii?Q?QQg9LFJmSx47vf0O5snESaStgVY5l25/EEzNU/pwqkEgnlShx2IXVbyQk18e?=
 =?us-ascii?Q?XpzOBmOopjvXFPJgcUz6iGf5Yka7Urk6/At4Zi7yYAhMqzvtWiBsdm0RQItx?=
 =?us-ascii?Q?EblMYVCyhLDGqBeg78K7NbDP8ij1D40i0XJFBZ/J8gZqLq9IL13O9zUSesw/?=
 =?us-ascii?Q?Y3YsXe5ggKsPtwqTQ+0sjydTRcvK/08+K0/HrhCXGfGft1aoyTlWHnRq6HBL?=
 =?us-ascii?Q?lZ4orP/mqxnjhOBs0oRBLQS+Z95spNjlJq+HcnVUjlAa8g9wVCb25T3PLjPv?=
 =?us-ascii?Q?vmKINO+zait3VDKgSMHZJJS5dABkQVdoklR5Z92+P/o/2bWcqCV4TDLxk2pW?=
 =?us-ascii?Q?4LEhtygqyWERDWkO7/sjcsM77R3RoFDp2sJ316I6WDKqumnxClt6exfKw9NN?=
 =?us-ascii?Q?cYBKNJUa/1EhfTL+jVCROw5/jj26/aBBdO4ItI80Shz2+PqOo75+ht6ppOpq?=
 =?us-ascii?Q?iCs08QjMSas9+KUt2RP7NCYTxgMThq8zVt7Nn6lQNIgCafMrAoSLGBPB+m5j?=
 =?us-ascii?Q?AB7LJeSHxb0tiISnUaPFE545N9Va7KFolaCfoqpC6FyzSwgEh+cjh1kRddam?=
 =?us-ascii?Q?Ijbb/gi/PsR98NLoojQY2VRnBk8RFUHC9NskN1Us9mo8SfDSxeCSK4Xn3rJv?=
 =?us-ascii?Q?MaZm7nYzMXeD6/tmuviyiSlGvH6SoKXFOLFDnfnHfMH9EEsWXNmFz6UaDobv?=
 =?us-ascii?Q?MccQ8M22+uz/fg1FTkYkb6/kJmkZ9VuyZQoqzfKQKK5GPimXjuq8jafYsHXx?=
 =?us-ascii?Q?xttUnQGfOsmuG9LoX+KJDh27uzlnmKBbA6C+ofX+7mVfLlDgDC9kEL9egGUZ?=
 =?us-ascii?Q?4p2yVQbY/pircCwHAGbfSK82KE62BDRao6+7qAdY32wYtaUq6m6wno7Kzx1A?=
 =?us-ascii?Q?rBqmXzEC4t1AT4gInvJvlZDsgQE+oA5YgEjnDUbSK9q8iWbUl4orW/380OlY?=
 =?us-ascii?Q?6fJ28LLB2+Bfna6HS7i70gdRbi5CPpIVLNiHX153IEXRMEGSSvGgq2+tGUZr?=
 =?us-ascii?Q?h0I2Sw+QuAlQ6x1ryoQJjf+z5pY8BwAXNdn+2s5V+M9y5l2Dbche+cfhShi7?=
 =?us-ascii?Q?SIHkxbOK5Rv18FMX2MRCmUBBjHvUAfc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899f7b03-9313-49f2-00e2-08da4d06a19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 06:33:30.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tH8gHqhPEhfNcCwa/yhYAqKbEY6sMBwV99YmiNzTsVtI6pUOHWL5ALqEeQPOSKzcHS0GKVRXrtJ0wLCN1p7uP7E0N3sz9iT1uVnAk31e4dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2858
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,=20

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, June 10, 2022 8:17 PM
> To: Mohan, Subramanian <subramanian.mohan@intel.com>
> Cc: nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev;
> lorenzo.pieralisi@arm.com; robh@kernel.org; kw@linux.com;
> bhelgaas@google.com; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> <srikanth.thokala@intel.com>
> Subject: Re: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple
> kasprintf
>=20
> On Tue, May 31, 2022 at 06:56:17PM +0530, subramanian.mohan@intel.com
> wrote:
> > From: Subramanian Mohan <subramanian.mohan@intel.com>
> >
> > Use devm_kasprintf instead of simple kasprintf to free the allocated
> > memory automatically when the device is freed.
> >
> > Suggested-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> > Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>=20
> Applied to pci/ctrl/vmd for v5.20, thanks!

Thanks !

>=20
> > ---
> >  drivers/pci/controller/vmd.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index eb05cceab964..7a72948e001f 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -897,7 +897,8 @@ static int vmd_probe(struct pci_dev *dev, const
> struct pci_device_id *id)
> >  	if (vmd->instance < 0)
> >  		return vmd->instance;
> >
> > -	vmd->name =3D kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
> > +	vmd->name =3D devm_kasprintf(&dev->dev, GFP_KERNEL, "vmd%d",
> > +				   vmd->instance);
> >  	if (!vmd->name) {
> >  		err =3D -ENOMEM;
> >  		goto out_release_instance;
> > @@ -935,7 +936,6 @@ static int vmd_probe(struct pci_dev *dev, const
> > struct pci_device_id *id)
> >
> >   out_release_instance:
> >  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> > -	kfree(vmd->name);
> >  	return err;
> >  }
> >
> > @@ -958,7 +958,6 @@ static void vmd_remove(struct pci_dev *dev)
> >  	vmd_detach_resources(vmd);
> >  	vmd_remove_irq_domain(vmd);
> >  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> > -	kfree(vmd->name);
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > --
> > 2.17.1
> >
