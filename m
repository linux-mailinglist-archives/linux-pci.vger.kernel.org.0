Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79F67337F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 09:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjASITb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 03:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASITa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 03:19:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B95A801;
        Thu, 19 Jan 2023 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674116367; x=1705652367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zkJmDmVPo4xfXntl57BQu7qOEFDAHu62KextpUEEzWU=;
  b=mVYR8X1IjGIdtpZy77DDrx1jpfJxSDAB98vDVbovdcE4l2QX+HWBBIRt
   iHR3UFJ8b6aOO2yx7kC9NHVTGwy/fxSChIc6MGrzRT3djZob+xgZOTwe9
   AE4pWUhzGq0Y+7QaCwSOWKguchVOq+wSlfFevBEKS33F/nDy93V2MsI8N
   TIOZxQiSqEqL+SmUGt74EIy8dvYJPIEmuy8N5SxWX3014uY2flbsMTWL1
   ig+BdqqRFPJECjntzKbGI1PtHJc0jPmD8+lzIU4FTxD4cjORRbL1MyKX1
   ke7w3ZrdScdtfXmSEd6YVaQVhHTITIW++iZyZ9MzQJUm+j2xzkO0MfbYL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323912518"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="323912518"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748811558"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="748811558"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2023 00:17:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 00:17:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 00:17:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 00:17:09 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 00:17:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8yzjCF543rgezUbjEu8eLy9MKoP/amr37SmgnxHhrztJCqkrCb2TZWqpPHjpY4ZxaP/0bQlNO7mKua5IkiJ6MAMiIPHF6R9H8t0EYIOYXs3NBHFbUIdx6T9JbPif/X0TZOza1OCBN7Y2xncmmicrUKKkUS0MTL/dMpfO3lYNDB3p1oNXL4lbBrszvd8Q9XDg5heZ2uYH0C+p9/x9rdjYkO4DEuJp5Phn2d9pb3bruvUaPgUv1s/by6pMYwJKvcPkRw2OIbYp19iSXa/wnTJK3aV1w4+NrhLmaHDzDoYvIuWCObn/yAy5b8nV5TfQ6TVGNCdjVE9KJD/hz/fm93e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT1wcuZEa+a1DorG/DmeIWReoBYK0pvEu+bmy7tHguA=;
 b=NlXef25uw+nNKKSsNBgo/fA9tmIBVe7zpm4YHwaBsIX5MHk7qwueInR5JshFBGc1erZkkS8OiCCmRAmd7F3PvLCJbke0kStAajbwRBGu4Po15ZxXTbtJreje+NSA2FHlcQZrbzYkBcjSQ3JwPQQK+2AykvLzbi2QOzCH5Enq5BjmIJp5Lr62kuMhS+KYVhuoEcGIDlDH8P7bzzPlyijyakxjJJIcGXsch2WvRQhdyEykO1Y+zj/5OOoLW+9WUu79+msqS1RGxxn9EioEMVpsiACBcJZPo0qwHMhV3SvIrPOxz1LH9M3Ged/bsejrkQTYZyzl0AqFPHZc4sod6O+CSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 19 Jan
 2023 08:17:05 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::ee18:f0d6:8983:5a24]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::ee18:f0d6:8983:5a24%3]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 08:17:05 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "Weiny, Ira" <ira.weiny@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 00/12] add FPGA hotplug manager driver
Thread-Topic: [PATCH v1 00/12] add FPGA hotplug manager driver
Thread-Index: AQHZK6VLCdlhIKUsp0qb4AVuDG8fX66lYngAgAAAWxA=
Date:   Thu, 19 Jan 2023 08:17:05 +0000
Message-ID: <BN9PR11MB54839E8851853A4251451719E3C49@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119080606.tnjqwkseial7vpyq@pali>
In-Reply-To: <20230119080606.tnjqwkseial7vpyq@pali>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|BL3PR11MB6435:EE_
x-ms-office365-filtering-correlation-id: 57978532-20e5-4037-abb9-08daf9f58ce6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35tUPAjNRODSSsiPqfkzCIN46pXikPBSwapr1EbyFxSkF9U/NT9v+sOCoFwMijxPhJIHWXDU2J7T5vat09ruhKXGV5KdOZuBWGrKUOXTzRfq1hvEGvNmjRavtJ/ut4o97KRD0r933tkmW/ynYyKWINsQ8GFLl8SaO23OibtLZwpm+HYX8yRmwElsBEuZYKlBPXPlM2fd3HflqOjsFJpfo0Ir9Ea7NgtqS33DJSWQu6fiLhApPnkyciEppgwD5dLRj4mgaU7JIEDHV0X2r6altAY1BJpcm3/c9Beu2W4JBTF0yCTifbwPH2rNPt6TKMQa8aHWH/vcJm5DHJ5j7LPNXTEhADIokqonc+eD7xqmsOkKm9BhrJk1sIxH0KZAFFXHhKvqHZ+B+PgR7DkTVPpQdd5zDh8HY2eGFM8dSfFD3/cHUZs+p2lNg7tNh0iWg8eSmKiSOwWs8npKCa4s9HcJAsBiIgwCyhkKVEHbZZl1du+L0fZyKUHCqkfPSxb87HiCZmDUPWtdY5Rc+ikEpgRnB0Bc/x0wDK0v2eVQKq3eMoEyWOvW/sphAf0CIz1d2DHfpkHQBr5b1zi7EHmw9UdJz/pZOXPPCMexyB/lzMYWU6rchQfZ9Vp1gLzETEwCOF/3nJOj+2bywL+txHo9HqgHpYCthXLDA+CCO/A5lbYbY3D4xqdCbr30pZWCrv/n/b9DJRF+KXNDp2QL/41gPmTnLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(2906002)(8936002)(7696005)(33656002)(53546011)(71200400001)(5660300002)(186003)(9686003)(41300700001)(7416002)(6506007)(66476007)(38070700005)(6916009)(8676002)(66556008)(4326008)(55016003)(86362001)(66446008)(38100700002)(76116006)(82960400001)(122000001)(64756008)(52536014)(83380400001)(478600001)(316002)(66946007)(54906003)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+uwsfvn1btc3p0SIhy1D19b/7MPYgZNtpTnxnq64lITxl2F1OdXlZZJstx?=
 =?iso-8859-1?Q?XVaRviMcC9DCHc3GrWcd1vixhzKhRwQEhAlGpBcK+ZmDaTTJPL5rD5afem?=
 =?iso-8859-1?Q?7hTjaA8qO/21DqWrbOMOCk9xJMJ1iaoGfmvR+pP0wdNdMRbE7G0y6aWeCj?=
 =?iso-8859-1?Q?3lSCkeDJ3SySDD3K0jcXBIU+YKzY4poudoU84GxLuctu6/RK2Va94+Wyzq?=
 =?iso-8859-1?Q?7xyvsdstHUu8EgvKKr9eZN4BG/f+eQbtacXR/i3EPdkg6nLwwWKpmO+RhF?=
 =?iso-8859-1?Q?jNXBsDxAfb21PBHCnGOZZbjc2dAjnqVD7ANCf7dQ4VLFanFo/BvJTHAou0?=
 =?iso-8859-1?Q?ZQusPCataAEgDXFgwRlg0UIDBfLAC0HlqBukJwvLBkA09S/Vrp2Uanjv4l?=
 =?iso-8859-1?Q?NN1rsXnc09ZjVPy+X80MhV0v54A3RgnOwnqSd0M0VzCX/XD865c110WKtk?=
 =?iso-8859-1?Q?VbieWsTlWBrywDj1k7Uq5h5K03ypkgQRnFgEpf63nkUhIZt7b59F3cQ0az?=
 =?iso-8859-1?Q?XiW+U/YYi/V41uhqh2hM2TteyncUfTqRW91a8ov236rPtwh0YgX4dQU/Q1?=
 =?iso-8859-1?Q?LrcNVty9dchSY9juKCfyYzyb1sbobQV+bI+rJXse2PoTB2g0R5jXKLB1vY?=
 =?iso-8859-1?Q?ubhxv6cEwBGKqGZ/ENV4+4nQZqBCD1jdqxI+hbzd3UPtsR7ccrPsJnp8W9?=
 =?iso-8859-1?Q?MmsyNTijb4i7vrLVzpUxookszLuMT7Qrn5YY58Cl2raI/4fo2Dq2mqsLF2?=
 =?iso-8859-1?Q?k4Qx4PZW6V4hhHxwwCDsQSmIbKGlPFoCChvL5FgjfqHIAvdXvQ1Jm/XyGB?=
 =?iso-8859-1?Q?OR24y59v3671yixbdxFkXlZZ+cAPg/S45+sBM89sBi47cUJbhClBa9liYm?=
 =?iso-8859-1?Q?b/p97HwwSHoTL+BPBo9iJb900R7oS88DGlWTgjycgPLo1LFje3hzsX9MEF?=
 =?iso-8859-1?Q?nY1EL6exyYPQkB3RCItmhsLihClY7Pz5VQnqzO0PC7m0KiyBLNifKcfUXd?=
 =?iso-8859-1?Q?pad20tBujXZQQYtHWaAeZ094qX7ZOmMqTj4arD5PIDX3SHKFbsGIN1230k?=
 =?iso-8859-1?Q?Wqts2n9bPOa0/fhc/5Tf7zcMTFCsG1QYvVhymgarFGa5xmMYeSmznmSm1O?=
 =?iso-8859-1?Q?dz8JZFf1I9tqp2KpvTbdDshRpz4emiYANiZkdsazmq3WbcFbmUipe4CMPk?=
 =?iso-8859-1?Q?QHXJAqxv3HvGvcIp8R6Tg3bzfLZ+AmXmSiQCT3M++BJIjixUqNj6l8d85y?=
 =?iso-8859-1?Q?Xr8mQqY5GizvjR1o+dcCVI4b07JwORavR/ABIFbyHJ8ijKh10ks+K4TVTa?=
 =?iso-8859-1?Q?6JlNlvMTateiXhpOBGL6woA18sye0NEErE9He0rHsHL9ULYMyUy8N/SpvD?=
 =?iso-8859-1?Q?baBAy6CtrIjpMxUhUzfwPGn9NvyoMgptxbWAuXvrPkq69f8VzFePBs8sBg?=
 =?iso-8859-1?Q?flXVFvFsjPqgwaAzPvkQjv7vEeEVQkX279yG0Mjq6otdmiHnyJYW1LMWCz?=
 =?iso-8859-1?Q?UTrT3X7An5gwdFNGeU1KfYewy/tGyVOttv8m+CVfzOjlsBmu8kNyc1k/M1?=
 =?iso-8859-1?Q?DVRw9z1kYvmmapprREUfBc8XHm28d3RjcB3wzJ8pYTn6CG85ScDBpt+Fup?=
 =?iso-8859-1?Q?Tf1+c3vVCalIZ3jVX0tPee7D9BjJee/fYm01lJDjg9QhtS/AHNHstFHaSJ?=
 =?iso-8859-1?Q?TarEm6UH/Wd7XnM5Zo6JYtzYTZhcUeW+3GNHsbpu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57978532-20e5-4037-abb9-08daf9f58ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 08:17:05.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0TFzHHK/sSP4u6psVRrbJoCL86I2xo6iLLTPt2uEswUWDswEATxUUd15SLIvJDG/Ka0YLhUExVZDjU1fqbwHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Pali Roh=E1r <pali@kernel.org>
> Sent: Thursday, January 19, 2023 4:06 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-fpga@vger.kerne=
l.org;
> lukas@wunner.de; kabel@kernel.org; mani@kernel.org; mdf@kernel.org; Wu, H=
ao
> <hao.wu@intel.com>; Xu, Yilun <yilun.xu@intel.com>; Rix, Tom <trix@redhat=
.com>;
> jgg@ziepe.ca; Weiny, Ira <ira.weiny@intel.com>;
> andriy.shevchenko@linux.intel.com; Williams, Dan J <dan.j.williams@intel.=
com>;
> keescook@chromium.org; rafael@kernel.org; Weight, Russell H
> <russell.h.weight@intel.com>; corbet@lwn.net; linux-doc@vger.kernel.org;
> ilpo.jarvinen@linux.intel.com; lee@kernel.org; gregkh@linuxfoundation.org=
;
> matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
>=20
> Hello!
>=20
> On Wednesday 18 January 2023 20:35:50 Tianfei Zhang wrote:
> > This patchset introduces the FPGA hotplug manager (fpgahp) driver
> > which has been verified on the Intel N3000 card.
> >
> > When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
> > from the PCIe bus. This needs to be managed to avoid PCIe errors and
> > to reprobe the device after reprogramming.
> >
> > To change the FPGA image, the kernel burns a new image into the flash
> > on the card, and then triggers the card BMC to load the new image into =
FPGA.
> > A new FPGA hotplug manager driver is introduced that leverages the
> > PCIe hotplug framework to trigger and manage the update of the FPGA
> > image, including the disappearance and reappearance of the card on the =
PCIe bus.
> > The fpgahp driver uses APIs from the pciehp driver.
>=20
> Just I'm thinking about one thing. PCIe cards can support PCIe hotplug me=
chanism
> (via standard PCIe capabilities). So what would happen when FPGA based PC=
Ie card is
> also hotplug-able? Will be there two PCI hotplug drivers/devices (one fpg=
ahp and
> one pciehp)? Or just one and which?

For our Intel PAC N3000 and N6000 FPGA card, there are not support PCIe hot=
plug capability from hardware side now,
but from software perspective, the process of FPGA image load is very simil=
ar with PCIe hotplug, like removing all of devices under=20
PCIe bridge, re-scan the PCIe device under the bridge, so we are looking fo=
r the PCIe hotplug framework and APIs from pciehp=20
driver to manager this process, and reduce some duplicate code.

>=20
> > Two new operation
> > callbacks are defined in hotplug_slot_ops:
> >
> >   - available_images: Optional: available FPGA images
> >   - image_load: Optional: trigger the FPGA to load a new image
> >
> >
> > The process of reprogramming an FPGA card begins by removing all
> > devices associated with the card that are not required for the
> > reprogramming of the card. This includes PCIe devices (PFs and VFs)
> > associated with the card as well as any other types of devices
> > (platform, etc.) defined within the FPGA. The remaining devices are ref=
erred to
> here as "reserved" devices.
> > After triggering the update of the FPGA card, the reserved devices are
> > also removed.
> >
> > The complete process for reprogramming the FPGA are:
> >     1. remove all PFs and VFs except for PF0 (reserved).
> >     2. remove all non-reserved devices of PF0.
> >     3. trigger FPGA card to do the image update.
> >     4. disable the link of the hotplug bridge.
> >     5. remove all reserved devices under hotplug bridge.
> >     6. wait for image reload done via BMC, e.g. 10s.
> >     7. re-enable the link of hotplug bridge
> >     8. enumerate PCI devices below the hotplug bridge
> >
> > usage example:
> > [root@localhost]# cd /sys/bus/pci/slot/X-X/
> >
> > Get the available images.
> > [root@localhost 2-1]# cat available_images bmc_factory bmc_user
> > retimer_fw
> >
> > Load the request images for FPGA Card, for example load the BMC user im=
age:
> > [root@localhost 2-1]# echo bmc_user > image_load
> >
> > Tianfei Zhang (12):
> >   PCI: hotplug: add new callbacks on hotplug_slot_ops
> >   PCI: hotplug: expose APIs from pciehp driver
> >   PCI: hotplug: add and expose link disable API
> >   PCI: hotplug: add FPGA PCI hotplug manager driver
> >   fpga: dfl: register dfl-pci device into fpgahph driver
> >   driver core: expose device_is_ancestor() API
> >   PCI: hotplug: add register/unregister function for BMC device
> >   fpga: m10bmc-sec: register BMC device into fpgahp driver
> >   fpga: dfl: remove non-reserved devices
> >   PCI: hotplug: implement the hotplug_slot_ops callback for fpgahp
> >   fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback
> >   Documentation: fpga: add description of fpgahp driver
> >
> >  Documentation/ABI/testing/sysfs-driver-fpgahp |  21 +
> >  Documentation/fpga/fpgahp.rst                 |  29 +
> >  Documentation/fpga/index.rst                  |   1 +
> >  MAINTAINERS                                   |  10 +
> >  drivers/base/core.c                           |   3 +-
> >  drivers/fpga/Kconfig                          |   2 +
> >  drivers/fpga/dfl-pci.c                        |  95 +++-
> >  drivers/fpga/dfl.c                            |  58 ++
> >  drivers/fpga/dfl.h                            |   4 +
> >  drivers/fpga/intel-m10-bmc-sec-update.c       | 246 ++++++++
> >  drivers/pci/hotplug/Kconfig                   |  14 +
> >  drivers/pci/hotplug/Makefile                  |   1 +
> >  drivers/pci/hotplug/fpgahp.c                  | 526 ++++++++++++++++++
> >  drivers/pci/hotplug/pci_hotplug_core.c        |  88 +++
> >  drivers/pci/hotplug/pciehp.h                  |   3 +
> >  drivers/pci/hotplug/pciehp_hpc.c              |  11 +-
> >  drivers/pci/hotplug/pciehp_pci.c              |   2 +
> >  include/linux/device.h                        |   1 +
> >  include/linux/fpga/fpgahp_manager.h           | 100 ++++
> >  include/linux/mfd/intel-m10-bmc.h             |  31 ++
> >  include/linux/pci_hotplug.h                   |   5 +
> >  21 files changed, 1243 insertions(+), 8 deletions(-)  create mode
> > 100644 Documentation/ABI/testing/sysfs-driver-fpgahp
> >  create mode 100644 Documentation/fpga/fpgahp.rst  create mode 100644
> > drivers/pci/hotplug/fpgahp.c  create mode 100644
> > include/linux/fpga/fpgahp_manager.h
> >
> >
> > base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> > --
> > 2.38.1
> >
