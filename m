Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020D362386C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKJAvJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 19:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKJAvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 19:51:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD91DDC3;
        Wed,  9 Nov 2022 16:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668041465; x=1699577465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iHJzrPcixXhqE0iDvXHhBxdo0R4t11Wjvh67bbJWL2U=;
  b=k3pGexywVlKy7rV/IiW0AMir7W+LqW7DAdgrDzFfnbPeghq8lwHtVwOO
   X/j+0r8DWix5JgzLdR1Oa+4L95hpGIEXdls8nGMfRmMHdzvmt2xCrkkMp
   f3IrcaOf7KBNxdu7m1lakd6CQsIakPphC2w+Xsh2I40A2Ga4k1hOeZzwH
   31FlHvrEcIN0HkBQYyE/FZN5gBPyMqKx//j0YB0jF0BLJGCeArGaRtbAS
   zPypBkKdY2nrHVnvW1s+oRxfhPuobKPROwhTQ1/mUDNwiy9XdBUxwPwrF
   FNrDe86Qud8d2s7z8OpBAKFDFNJaPusSI1I3wVkTtmoYu5yVPvOnS13Cs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="308791498"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="308791498"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705932338"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="705932338"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 16:51:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:51:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 16:51:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 16:51:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/HAeONX8OwGgl4+OCcskjepeRg22kwC8p99vnI/3IHhfFzVqPtsieGsFzFY/gkLbL4fxzuYoNtbII1VPHK/UDw/53bzKgkRwyoepj6J96mQQhScYhQVSSQyIpOGhAZe2sdaadoU/eFaVNlNALSEAVqoqQ4qmCxBidsepDMLq3UY+Ny4KlkyxlEE/h5wB3BMcOIBGayxOwpTGsyc0JGnldl7SdOBLho4ZJX1IJEpptfrR6lh0KTtQO4QNwns3xXMvG0W/rOQw489Y+btB075cRtNb13IXx7tV+E1P4yakzvgW2AVOy2RpTPhDQlXq0v58IDsiZRXsf//jRAm+C1QQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHJzrPcixXhqE0iDvXHhBxdo0R4t11Wjvh67bbJWL2U=;
 b=KGspKUyOvuYR4ewFEln//YKGCbBQmyKqzw5hvv1CU6IHvsowUv3Ex2VTWNzSmjBymyTXUT96yer7UuWTd7EZJNKYK2IKE+AfR83LiG69lra15Sbx7VVYZWH/7Gjlmz9wZIg0Z8+ZjX1pKr6UCzsRqOcxCYoDevXHTfsP5p4tE5/ExGMXggoHfglfzzXHW2wAuZE6NtcnecNA7Zv2z63Y8OOO9VIlLkPL952qUf4H007B/DZTfGybJVRcswKyHuo+Se8NltFD6aokc8OWRUFuA4Y0E4kRP2uU3Pn4/PVpIK5fy2Nj/+UywscebHkrTE+49PeuSpQim+6wbz/jSHGt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 00:51:02 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:51:02 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "rrichter@amd.com" <rrichter@amd.com>
CC:     "terry.bowman@amd.com" <terry.bowman@amd.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
Thread-Topic: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
Thread-Index: AQHY9CfqQ0FpEwKjE0mwwfTPHLbah643P7kAgAAU+IA=
Date:   Thu, 10 Nov 2022 00:51:02 +0000
Message-ID: <4d0da6a410ca49c1b70628a2a4814bdf2cbfce58.camel@intel.com>
References: <20221109233558.GA581582@bhelgaas>
In-Reply-To: <20221109233558.GA581582@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY8PR11MB6985:EE_
x-ms-office365-filtering-correlation-id: 5ead37db-3352-402c-6445-08dac2b5a3ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99SNUIx0MUHoI0u8mRKf/NSDOTeYTpZgddp9cbwF+3Nnqc3VlO+zzJ6xrVK0trQDpzd5B/wLmZb1/ZBX5GiJrpNx/1lTEvCktuWcuR3EYVha84UJucblbgMLH8RORW335MKZJSRtKIs+IP0u4GGBloFdgZkdBYJPhWIEl4FvsLrH6/23ex/dxGgtGudlwKeLpAxPWWvR/f9m3YiLmF29I9P0c/jtfmgh/zSuz96KWq0UWL6vqorDdwCyru/020b5V1t4LJkYnZNlHnjjBl6q2Yfp0SDfnxRsvcDre7crFXkFq49lf29JZRuifHmDsUyKySdyPgealdzWxAQ+5ZtKxJhZy+hjvrRVxb7WHIGYFq9WJW6zBWpJ+syEiaU3LUNZb0ExV6GElD7C9htGROyBywqlxruVM4RUTTAZZWpmyaxtQF9P0mqIPogFBRKddUtcD7hgcWrVZsW5x0S/xHuQuqljeF4pJYAQN7dq8pVrvDTR1gvpQhlZ/ifcbe09sl/lW8RURfzJm+S71syj2Xi0iygyQl2yFmd4xE0kKdAa5xyrTeanpjRoAr4YVl+sqeHNFQSvnQ3959lB1SbdzXE3k1p2Q+vgB/dyy2HqM0yaHOhQYTJ3T6CpsCWHXw/8+OzfhBNgKhoU4DzMlRXP1b7Ql7Jcp5t+QWQ2A3AuhB7Ykyt/ltElEIPS5lQ/PvxBvLGdSEz3uRSfWgom9xSvfazOXYO/LV+QUtMw0OlYF5h9M6f8H1aQX/cXaZLIE4pUlkER+eDu2zBuNfFZYIuhOxM7/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(6486002)(54906003)(478600001)(71200400001)(38070700005)(110136005)(316002)(2906002)(6506007)(4326008)(26005)(66556008)(66476007)(8676002)(91956017)(38100700002)(64756008)(66446008)(66946007)(76116006)(82960400001)(86362001)(6512007)(7416002)(122000001)(41300700001)(2616005)(5660300002)(36756003)(8936002)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBPMFNacC9KMStqdUs1bHZPc0k5VGl4NWtvNkxWU3dkZzRCV1V5ZHRzMjY3?=
 =?utf-8?B?bnFvTWVHRklNR0EyUGRoK0NkOHppUXBid1dMNXRBRUZoUmtTdkp4YjM2RlVN?=
 =?utf-8?B?eDdwK2hSdXU0Q05FQ2JMQkNwQkUvMVpwR21aNUxaU0VyTmJPc2xKcFNVdkNY?=
 =?utf-8?B?RCtZN1lweGhVYTdNYWdxYW4ydGlBT0JSUU42TzliaERuNzQ3VDEwR2VEQkcy?=
 =?utf-8?B?Mm9xV3ZySW1FMU1JdkhBZFA2dVpIOE1DSmFZbnZzWmVhNFA5cmE2OVFXbmpm?=
 =?utf-8?B?ZXhUek1LQ2ZxS214QkxCWlBCaVlyTkViU2dpTXdZU0djZnAzbjdPdkcwNEwz?=
 =?utf-8?B?M3BYLzNVeDVMV2hHSlJlK2tVcS9nTVJobXpoclFMcS9lRTBSSEJFbWVqNTRq?=
 =?utf-8?B?Z2pGYmFiTkllZWJPM3dDYjNyYmg1bkcvYWszNWhjNzhsWTJDTXVuNSt0S2Fs?=
 =?utf-8?B?cjgxSFZNMFl3eEVoQSsxb0IyUFZrQlZUeUgzN0ZEVUQrUGdodHY0YW1obHJ2?=
 =?utf-8?B?azFMRVM1MGNEYmV5RkZ3blNtNk43NTJSc2t2S1B2c2QrcGxDWFZwMkdFSHp3?=
 =?utf-8?B?WmtSQXdmN0k4MCtmOWVDVGZhUi9DRnJsMEZhUnZTb0g3d051d01NN0ZmTDhn?=
 =?utf-8?B?ZHo3eXlKeGVkYmRnd0hJZEpubUJjZHd4aWEwSTQ2czFFcEw5NVFBTXBzclNQ?=
 =?utf-8?B?SDhDdUtGamIyWkhwMlVvYTk5Mm56Q2ZNamVsZ0E1L0tCN284THZwYkFqN243?=
 =?utf-8?B?NU9ad0RuUlZBRENQb1lxeEJKRURTTWY4ZlRYU1dnaTQ2TUtPZXA5eTVNTTBX?=
 =?utf-8?B?TGZCSU1VbVFNTWgwZVhzaEZBOTJHL2VHZUI1NGZOZGRrUENzUWFmbWRLc01h?=
 =?utf-8?B?QlNhb1cvRFlwWnJ4cGRLdStyOWVXUUNOOHFrOFExdEw1MURKclkzYzg5ZXNP?=
 =?utf-8?B?TCt0YUZjSVI1RzdwbmEzT25EbTZYZndkTWVqZVl3ak9FLzFhc1BpcjhSM3No?=
 =?utf-8?B?R3R4d1dMZWhUMjZpSXlNZm0xZVZiclU2QnYvdWlOcUNqS3cyMzZxdVJKRXJW?=
 =?utf-8?B?NTZEUTl0UnhPM2hJTjNpUkI3V1JsZFdLVTBZZy9SajltaFEyZVIrRWk1VjEv?=
 =?utf-8?B?ZWRnSlFnaXJDRmQ2ZFJ6Z2UxWkVEWEpWQk5sakFyK29Fb3A1L0lhYXhVbmRa?=
 =?utf-8?B?SGJYSmhRNDNLYnBIUEI1YjB4RmFwRi9TNU1keng1emQzdlRIYkU4bjBrRkNm?=
 =?utf-8?B?TGhoZS9YVjAzL053Vy81dXRkcGI4dE5TRmdLQVdmSHRJQktTNlBLZ3JzVUxj?=
 =?utf-8?B?SE9ueUNJWDZ3bFRkeTVkbWxqdFVkREZjNUM3cWc2Q1AvbFlyK3l0Qmc3VkQw?=
 =?utf-8?B?Ylk3dm5UMlV4UFBCcUpPZzlPOXJtOHFOWWJ6emxTNzNUQUJBNWhURzlsOVlx?=
 =?utf-8?B?Uy93QXZBNDJ4TDJTSDJwaFl0VEcwakU3ZEtBamU3d1VwYS85ODF6QXc3NTNL?=
 =?utf-8?B?SVdEcm5US2ZiODNvU0hNbGR5bTF4M0piWWVsMXhJSmpxOStCVGZVMHVPcGhQ?=
 =?utf-8?B?eTBKNEQ3UVNscDRqZjRpMUE0RVZtUWlSYmxleGFpejBaNUYyV2Q2aldZcjZF?=
 =?utf-8?B?TUwyekYwdmJ2OFBTR1A3aHRadFdGZlVRTFlKZGdkcDZBQ3hoRGhma3FobGhT?=
 =?utf-8?B?NE1hdTVSV0cvWmVKTXBnQVVJNmxYYWgrUGg4VmVab0I4M1kzVzZLaHVVV1FO?=
 =?utf-8?B?Q1AxREJvK0FuRTRweEFycnpSSTRLVHpTTkU4OTJVL2NGV2pLRFd3eWNwNjBv?=
 =?utf-8?B?ZCtpK2IraCtlU1paZkQ5WnQrYTI5ZW5KYTBuSVRYeE1WTGFyQ0IwbHB3dW9U?=
 =?utf-8?B?c3FFSzFuU001cCtiUUZSUTlKcFpsNHAwMDd2cmdIVThUV3FIWmhwYzRTcHB5?=
 =?utf-8?B?ZGZxLzhVZitya2xhTzdKVkdmdVZkWnlJNWc2citEeVNCVXZuSFF5a3FmbGdl?=
 =?utf-8?B?eDRQL3pLbHZWOXZOY2sxMW5oNzVHNDNNZUQ2NXNneFdqWnVoaC93Z09zaVM3?=
 =?utf-8?B?aXdWU0xNdFZ1OWVTd0J6Z0xPcmUzSGRmS1h4cCswMVVFRmtQWFRDYWFnNGdB?=
 =?utf-8?B?dXM1ODNXd2FacEFYdlEzRWJGTVNzRVdkSlpxZFk4aTRQbnd2dGRiMko2d1JX?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6480C0B93EB2B34C9EA6005277DB8C1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ead37db-3352-402c-6445-08dac2b5a3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 00:51:02.0925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DO6qNU+NzcFbsFu0hzAf5UBqo+CZyLvWDwlaHdF2RYy9AcsM4YIyhvbWRRrQp35Lmyacx/BMb5fC2HJl13kpWnEhEGjL+gqDgXdXlWRyQns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6985
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTA5IGF0IDE3OjM1IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE5vdiAwOSwgMjAyMiBhdCAxMTo0MDo1OUFNICswMTAwLCBSb2JlcnQgUmljaHRl
ciB3cm90ZToNCj4gPiBGcm9tOiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBhbWQuY29tPg0K
PiA+IA0KPiA+IEFDUEkgaW5jbHVkZXMgYSBDWEwgX09TQyBzdXBwb3J0IHByb2NlZHVyZSB0byBj
b21tdW5pY2F0ZSB0aGUgYXZhaWxhYmxlDQo+ID4gQ1hMIHN1cHBvcnQgdG8gRlcuIFRoZSBDWEwg
c3VwcG9ydCBfT1NDIGluY2x1ZGVzIGEgZmllbGQgdG8gaW5kaWNhdGUNCj4gPiBDWEwxLjEgUkNI
IFJDRCBzdXBwb3J0LiBUaGUgT1Mgc2V0cyB0aGlzIGJpdCB0byAxIGlmIGl0IHN1cHBvcnRzIGFj
Y2Vzcw0KPiA+IHRvIFJDRCBhbmQgUkNIIFBvcnQgcmVnaXN0ZXJzLlsxXSBGVyBjYW4gcG90ZW50
aWFsbHkgY2hhbmdlIGl0J3Mgb3BlcmF0aW9uDQo+IA0KPiBzL2l0J3MvaXRzLw0KPiANCj4gPiBk
ZXBlbmRpbmcgb24gdGhlIF9PU0Mgc3VwcG9ydCBzZXR0aW5nIHJlcG9ydGVkIGJ5IHRoZSBPUy4N
Cj4gPiANCj4gPiBUaGUgQUNQSSBkcml2ZXIgZG9lcyBub3QgY3VycmVudGx5IHNldCB0aGUgQUNQ
SSBfT1NDIHN1cHBvcnQgdG8gaW5kaWNhdGUNCj4gPiBDWEwxLjEgUkNEIFJDSCBzdXBwb3J0LiBD
aGFuZ2UgdGhlIGNhcGFiaWxpdHkgcmVwb3J0ZWQgdG8gaW5jbHVkZSBDWEwxLjEuDQo+IA0KPiBF
aWdodCBpbnN0YW5jZXMgb2YgInN1cHBvcnQiIGFib3ZlIHNlZW1zIGxpa2UgaXQgbWlnaHQgYmUg
bW9yZSB0aGFuDQo+IG5lY2Vzc2FyeS4NCj4gDQo+IEkgZG9uJ3Qga25vdyB0aGUgaGlzdG9yeSwg
YnV0IE9TQ19DWExfMV8xX1BPUlRfUkVHX0FDQ0VTU19TVVBQT1JUIGFuZA0KPiBPU0NfQ1hMXzJf
MF9QT1JUX0RFVl9SRUdfQUNDRVNTX1NVUFBPUlQgc2VlbSBsaWtlIHNvcnQgb2Ygd2VpcmQgbmFt
ZXMNCj4gc2luY2UgdGhleSBkb24ndCBtYXRjaCB0aGUgc3BlYyBhdCBhbGwgKCJSQ0QgYW5kIFJD
SCBQb3J0IFJlZ2lzdGVyDQo+IEFjY2VzcyBTdXBwb3J0ZWQiIGFuZCAiQ1hMIFZIIFJlZ2lzdGVy
IEFjY2VzcyBTdXBwb3J0ZWQiKS4NCg0KQWggdGhlIFJDSC9SQ0QgYW5kIFZIIHRlcm1pbm9sb2d5
IHdhcyBvbmx5IGludHJvZHVjZWQgaW4gdGhlIENYTC0zLjANCnNwZWMuIFdoZW4gdGhlIGFib3Zl
IGRlZmluZXMgd2VyZSBhZGRlZCwgdGhlIHNwZWMgd2FzIGF0IDIuMCwgYW5kIGl0DQp1c2VkIHRo
ZSBkZXNjcmlwdGlvbnM6ICJDWEwgMS4xIFBvcnQgUmVnaXN0ZXIgQWNjZXNzIHN1cHBvcnRlZCIs
IGFuZA0KIkNYTCAyLjAgUG9ydC9EZXZpY2UgUmVnaXN0ZXIgQWNjZXNzIHN1cHBvcnRlZCIgKFRh
YmxlIDIxNyBpbiAyLjApLg0KDQo+IA0KPiA+IFsxXSBDWEwzLjAgVGFibGUgOS0yNiAnSW50ZXJw
cmV0YXRpb24gb2YgQ1hMIF9PU0MgU3VwcG9ydCBGaWVsZCcNCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJp
dmVycy9hY3BpL3BjaV9yb290LmMgfCAxICsNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGNpX3Jvb3QuYyBi
L2RyaXZlcnMvYWNwaS9wY2lfcm9vdC5jDQo+ID4gaW5kZXggYzgzODVlZjU0YzM3Li4wOTRhNTli
MjE2YWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3BjaV9yb290LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2FjcGkvcGNpX3Jvb3QuYw0KPiA+IEBAIC00OTIsNiArNDkyLDcgQEAgc3RhdGlj
IHUzMiBjYWxjdWxhdGVfY3hsX3N1cHBvcnQodm9pZCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgdTMy
IHN1cHBvcnQ7DQo+ID4gwqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3VwcG9ydCA9IE9TQ19DWExf
Ml8wX1BPUlRfREVWX1JFR19BQ0NFU1NfU1VQUE9SVDsNCj4gPiArwqDCoMKgwqDCoMKgwqBzdXBw
b3J0IHw9IE9TQ19DWExfMV8xX1BPUlRfUkVHX0FDQ0VTU19TVVBQT1JUOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqBpZiAocGNpX2Flcl9hdmFpbGFibGUoKSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHN1cHBvcnQgfD0gT1NDX0NYTF9QUk9UT0NPTF9FUlJfUkVQT1JUSU5HX1NV
UFBPUlQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FTkFCTEVEKENPTkZJR19IT1RQTFVH
X1BDSV9QQ0lFKSkNCj4gPiAtLSANCj4gPiAyLjMwLjINCj4gPiANCg0K
