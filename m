Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C116370B5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 04:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKXDBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 22:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXDBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 22:01:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85461BB5;
        Wed, 23 Nov 2022 19:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669258907; x=1700794907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q5raC8g+CELpaa5B7NN9x2WnQRrvDfNhXmPawd8teRE=;
  b=cXOL38oW17FOPcffcgjdrn7P/u088DJ7gvyTrnarCDdtBEhpQ4kYys/W
   Hb55lWKJLG7ZV92s8IRWgTiztx+1QlB4KhJhS3kzkvAgNdv3QNLvdbol+
   y6YtnrBWbSDY/722KuWpJ9ocxiho9UGvWt58noWYfr+EEA7Nug0L6zqhC
   51Hf9Er2iBHfBs5vIDSV7RyfDc2E4x29VAvT+6W9fJQfbyFNyosOFcp+4
   HFLuN841f8wLwXqgyXmqlkOAE6vOm/7drc6dIWPme98uCUj7OTHMtwOPx
   5diEiUk/TLhib4oAJ2TsIZi/goZy5N0lIZ3H+2ox697cQY00oWMkmXjBY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="400496264"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="400496264"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="592747187"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="592747187"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 23 Nov 2022 19:01:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:01:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:01:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 19:01:45 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 19:01:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPRXybUUtq1sZDNJEEQgHLrxytS0O7zDp4+z+ntJCzRIQhg75BiJ6Y5WHZpQW6rcXMlaAlo5yIb71rLXCnAS2efZhCSqSPLboQuAeGZ1zsCReJqxRQa8PWwD7oWmcYjkvnRnQoKCEJbBFaziBWtakDIg6kgpVq6BhsQ2IWWRcuAHM8KvwdKaRfeN0V8LbtSApnBQ2sOxy64EJwvNwPnTNpcfqtvdLoUyZJkdUg2bd76Bea7YHgfThQY2M53qxqPlLKEpFTyLzWH1onVGJx8yrA0xzxdl+W3Q11UXJcF3bDmC8XZ5EQR74czm2WfBBHtBePQ2ABSLmcsHVUAyyLFSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5raC8g+CELpaa5B7NN9x2WnQRrvDfNhXmPawd8teRE=;
 b=CKXyFwuW05vh+CRkpViXWsOV2PHmC5vhe3QyEWiyKoYXz+GKK2B0qA7S3hrwMjtRXiITBZaJBoVfu7MUzxyu8PSvFAhDbVnKz5F6ERIxiMkx+Z4eEZ2gXkai9DpvEAubHx1oLPpofNfWv+Uv8KiQraX0QMvPKeJm9lFXCTSBpWnxR8KB2FPUTtHAOYvoNj7TWTaqEop5CMLGUqxfbuSoQX3Z27lIjOs1QIlO3sAvGpLujiUremy/T3jy5E5jSQERyHGoXR6HJtTynpoPvItW7Om2uyiUX7O1dZUCRYwprXftRAFU/o8hgnF66s9uWOJ6MW+a8Iw8UKCgLE5j5Hng2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7466.namprd11.prod.outlook.com (2603:10b6:806:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 03:01:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 03:01:44 +0000
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
Subject: RE: [patch V2 27/33] genirq/msi: Provide constants for PCI/IMS
 support
Thread-Topic: [patch V2 27/33] genirq/msi: Provide constants for PCI/IMS
 support
Thread-Index: AQHY/bbuFV+geGe0jkS6zSNkPVl/GK5NVq7A
Date:   Thu, 24 Nov 2022 03:01:44 +0000
Message-ID: <BN9PR11MB5276C9AE570B4CF854F6F5E48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.974140298@linutronix.de>
In-Reply-To: <20221121091327.974140298@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7466:EE_
x-ms-office365-filtering-correlation-id: 9ef59bac-1a8d-405d-533c-08dacdc837e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vg4RV3CM3Ux/BLj4QMLUhSTWmBSc0ItNxddnwry/f9dcwgUpKIXDKlNmQhD8kNs7s95rRxlC60/pEATRg1yDPqmoro+2BwjUkibEVuw7DVSWR6vZmjTLQ9Qr+/vqHC2c8PhwYPm4uvfil1CD1wdLTCaMcTFdiqRjoUA2GZtv+Bi7jsyO51s4c5P7i5TRKvJthmVavHvzVPbJIjAgL3+1ZzsARHb/5MR0DGRz8yhUqQlfsZXnsqLQkiQFtanQ37DvhaVaUz4DJeKCW8A6rFbkGLGOickELjpfG4SyyXdvjbIbQ9RtSZRBLO8n13it1//SrrarqLOF8d3MAar3clZ1J8QtCCOmi6x/+8E6Hqfpuk6G1y3JnGakd7lg/XPzlI7HDhoj6plZNmKQ7xIiP0rX8et5poZWgUF5f9btST8adwSyi9UVgeM00HiAq5JBjg306u4FYgsi/5FpWsNuMF60HzNTl3ho8OlcF5BaPAZYAThBAG8iavFaJIyRLa0taj7W++wkSRHXJVbj5dQ+61e+pylAR6+yCMXsQzQTlfEUUDZiNMqeuWbGnzW5iPXSWPCcUyeDLATKhZ779M11Ymzhb5XJe6eZENMphMRnlLJKhJJgmznshfTeeJsbu0F7CHcrJLz+vhnLFCawXCzapC09QOQICREugP4ake8h1czfU65TBQ7UzGOR9xkZb0QIH10ZZUzTyJtE/oidwuqp6itTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(82960400001)(55016003)(54906003)(33656002)(38070700005)(478600001)(110136005)(316002)(86362001)(64756008)(66476007)(8936002)(4744005)(66446008)(2906002)(4326008)(66556008)(41300700001)(8676002)(76116006)(66946007)(52536014)(5660300002)(7416002)(38100700002)(9686003)(122000001)(6506007)(71200400001)(7696005)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3JncEJLaWVIR1dDZU5FdEVWR0hlZXJoUVRQVXIvRkVYUys2aGtLN1hmVnlj?=
 =?utf-8?B?cktRYy9FOWg5b1JOZUx6aUxyT0R6RkxEelprUEVSSDhNK2pRZEhUeDdWRU9E?=
 =?utf-8?B?bDFKc0FoaVFxOXh0NVdQc0w3OHp3cHgzQXNsTExzQWVVMVdyN1EwMWJyWVl0?=
 =?utf-8?B?WGovbU5XcXFSYk03ajNkUm9IdE1IbWxmcUlwNlp1RXNLVFM3ZW5XU1YrNGZ2?=
 =?utf-8?B?MTlqRGlaZzRyM0FIbUQyZi8zUzBWQlA1bDU2Nm9YTXRkWFpZOVkzMkF6T3oy?=
 =?utf-8?B?bHlHWm8wMHp2L0tZQ21uOUFlSHlIWTRMcWx5UnZoNmJPM0tPanE4a1B1UGdt?=
 =?utf-8?B?YXpHdEZuanJYMFVGeTZQdnRLc2cwZ0tmWkV5SmhyTnNVVVVIUFBwWWZCSFo5?=
 =?utf-8?B?ZTNOZ1FocEd6ZzFEOG5CUGw3aVdJeWVzMlZzZ1VQTWhieXI5VndBNkxldkU3?=
 =?utf-8?B?eUMycmtHVFBYcFBVOVRFNTBzcUZtU0JHTjVkM2J2eERpVGhzQ1lROWJDNkNX?=
 =?utf-8?B?TSs3NVdxanZBN2lHbmg3YlFRVHVhZllBRkZTNVpNREU5SnVrNlp2eUY0KzVX?=
 =?utf-8?B?aTdqNnl3TkxHV3pEYWE2Y29ZYW16VFU1TzdvTlc4K3pTQlJsc0dZSUNQUVdp?=
 =?utf-8?B?SVoveGlLYStUSUtkRDBvQjFJZDUxeDkvSHRtd0trakUzSExnRjJSejU2cEtL?=
 =?utf-8?B?NnlYSzZnQThsbkVaN3NTTUo5SUFhZXpkcmtYNWI5MGdCMVNjTHBjOERBRnBZ?=
 =?utf-8?B?Vnc1bTlkVkNUVHJNTXpGUFBNY3ZJN2xhTnczVG5Ma2xlRGl0TzlxUWR6dEhJ?=
 =?utf-8?B?RzFNUXBRUDJVT0lDZFRSenlYeHJNNURJNDZGMWgrRC9vQklRTVI2d2trUlVB?=
 =?utf-8?B?eC9xemFNUUJYRTloV0ViYjdxU05VbFltbVdhblpyVkdWd2MyRnVFVzBlQmNr?=
 =?utf-8?B?bXQzRFQ5U0MzenBWbXVKeXNLOHkzdCtBaHBPTnRrMTJpOHA4TWcvK2w4TVZi?=
 =?utf-8?B?OUFLcGtwOTNVSDRLV1RGUDZnTkwyWlVzdHhHbjlYQk55b2VtbVpMQU0xV09p?=
 =?utf-8?B?dVppOS9kTVI5elBRSXlxd1Y2d2ltOFF1Snk3NXJJSHJpTXdPMmU3MUpsQ2tq?=
 =?utf-8?B?YW15eXF6Q0hoY3U3N3RDSnZjZ1Y3Rm10c2ZjZExtMjBkL05TL2Zqcy85QTFw?=
 =?utf-8?B?eERJVWV4dWhIMzVHYnU2WnYyTUE3a3k0bXpEa2M2YlA5WTdEMFBPdTBZemY2?=
 =?utf-8?B?TWlWWDVabXNxUm1JeS9Jd2ZVQVQraWxMMkoxdVJrUnF2dS8ycVVyOVFWY1Qw?=
 =?utf-8?B?aUd1enBuOEVGZXBNYi9TNERqL1hFaU5XWXpwdFVERW9uZFl6aDhUTUJkYmFv?=
 =?utf-8?B?Myt4ZTlVZWw4NUdGYXZzMTdDSDAyb0dOZEx4YmVDemxlVmwwQVhUSFhTL2lJ?=
 =?utf-8?B?QzBvcTdkcTk5WDZVUlhRS3BqWEoxTVViWkZpWUYxNjZYdlVlSG9vMjNJS0E2?=
 =?utf-8?B?OWhodFFra2ZtTTRRbmpWU0UxNGswd29IMGRuSWlUcWNGVXloVG1hSS92N1lp?=
 =?utf-8?B?VVFCNVN5SmtYaWY1Y3JBV0ZOSUNUakdOSm9ycS9Ja09oazhWY1BOMzJwR0JY?=
 =?utf-8?B?cjN2V2pUZjdIVmxBUkxVa1kxWHk1c21XTkErYVd6KzJXZ2FUNm9mdVlvZmp1?=
 =?utf-8?B?dkxwZlNINEI2L3JWbnYxd0lRZzVaYVpOZG1xUU13Q25IL3pKVVJCd0VsNkRa?=
 =?utf-8?B?cjNRWjhZQkZEeVFPRlRQbGh6SFc2L25hcml6OWxlcVVoeGdHV25xTkZTMG94?=
 =?utf-8?B?UFJSQVZLbHo0a3RSU0NPdWxhclRPTlpHN3VkNlV1U2xPQUg0ZGVac0pjK1pZ?=
 =?utf-8?B?VUtNK1RGcWI1NVRQQkxNQjNyanN1akFDcXB0ejJiRUgycUxNNFlDdTVzYTRr?=
 =?utf-8?B?NTdZMnExNUk0bGxJTkladThUeDBPaWdxUk9TaVZoa3lyUG02S1piRjBoNE5B?=
 =?utf-8?B?WUs2VmcrVDE0bTRvWUcyZGNCUmtLWXZSZlBBeHlnN3ZvTURmODB5aFY2RzVZ?=
 =?utf-8?B?NDN1Mi9OSGtJT1VETTVheDdTVGJFTkZWb1RXaWdaeGJaRk5xTW5uQURLZWkw?=
 =?utf-8?Q?0tyY51MQbgiW192sUpvExtApZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef59bac-1a8d-405d-533c-08dacdc837e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 03:01:44.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npCin3Lr+7GRZigx4X19UcuKBCyt9cFLoqu22irjl383Pe+ARY2wzXbRKQYxOWuTXRp+vku9T7q9J3+ouplraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiAgLyoqDQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvbXNpX2FwaS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbXNpX2FwaS5oDQo+IEBAIC0x
NSw2ICsxNSw3IEBAIHN0cnVjdCBkZXZpY2U7DQo+ICAgKi8NCj4gIGVudW0gbXNpX2RvbWFpbl9p
ZHMgew0KPiAgCU1TSV9ERUZBVUxUX0RPTUFJTiwNCj4gKwlNU0lfU0VDT05EQVJZX0RPTUFJTiwN
Cj4gIAlNU0lfTUFYX0RFVklDRV9JUlFET01BSU5TLA0KDQpTRUNPTkRBUlkgb3IgYmUgZXhwbGlj
aXQgSU1TPyBBcmUgd2UgZW52aXNpb25pbmcgbm9uLUlNUyB1c2FnZXMgdG8NCm9jY3VweSB0aGlz
IHNsb3QgaW4gdGhlIGZ1dHVyZT8NCg==
