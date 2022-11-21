Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7363256A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiKUOSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKUORp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:17:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374216140;
        Mon, 21 Nov 2022 06:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669040263; x=1700576263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qg2c1qk00qSaKSNy4gBbAMvZlLtDV8jKcGBsSpyczwU=;
  b=eOC3p9yZbo51gQgT8ovuzdrw5T7FUkFKA140lPl/U+f7RuHS+IOmGXpi
   xVymXM15wOCuBNnOx+dDfRuzD655BcwiO/ZdUJW3vFKhJbBp/Kw4xXiZU
   8P3ZgU0Akq1ked5WbjWDBYku7Rr6FRuV4QiFGHsXylxHlUsIU/8re/LZH
   12iu/NW0BaLlS0sHkb47bpWgcuL9hJVX+xl84FDEEa9aj2HSxilV6Ch7e
   gNhr0tgwxCk5N9/i2VOmyrQ2sczR9/cKS1IP6Ie+DJ0xd7lUXXI/yYE7B
   3mxToJeYuCs6lvcIXNdWdlxQ5qzQnT/EHisMk3JmnyGNx8L0eo/1oozVC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340425310"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="340425310"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="730019832"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="730019832"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2022 06:17:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 06:17:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 06:17:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 06:17:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNwPeRdnHjTfHnw26vlXccbAMK2OcvAsyD7htwf5ECwIF9gvQOde7qEah/FTWAixij2FYPci/7SR2T9QxiJvcq71tG6sMEvnkGO6VlBurXrCQWBNPKvuQbLPEjWz7X2dlIjrSllsJHhcbIIP3BvfP9+UzlU5xbpNYHVZ8bYJvrtgnKBns1NDDCtuEX2w2WwtFoD1ahwVX84c7ghJmmA9BXO0n0uAJdE+MKupjKbI19JyBhS2Dobmc6WQ2AadhXd66xLzuVM1cFJ7YwbaPem5HzJa79PhYu1Ub+lrqWYRkYsiyVG6nlrfKlFtsjWhq727bhPpSYtvJ6IGaYFGKcGtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg2c1qk00qSaKSNy4gBbAMvZlLtDV8jKcGBsSpyczwU=;
 b=mjp62D72AkmtluQdC3b/+YhoxjitOyYIPYMC5QY2ZwJV2/SoVgBPQshomUW47Z7HvawPjNseRCXJmyi+oK9b5c7Gy7xoeVkYdM/seHKiqCm7dpxC6IsdJZf5VfqQ0D4pZu5BjJ2neBlMixr2DdTrwsHABovvgDby4Uq6x0zfghIbGAWM7SOPI5z10wqCXjbaeEhBsAclsTdHOCrMuEP3e8Roc0Fzs+h7eiSjuzb1y+pli4akBS7jBM7jZCcP6n2zbwZgJ9VKUOMkJIIuLXU2xBDSQMvWoXR9ughMdgB/4TZNySTkN7Cow1xi1VaIR371/mUC65hau6uBtSD+FCyZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 14:17:38 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::d204:9aee:594c:273e%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 14:17:37 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Gregory Price" <gregory.price@memverge.com>,
        "Li, Ming4" <ming4.li@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI/DOE: Remove asynchronous task support
Thread-Topic: [PATCH] PCI/DOE: Remove asynchronous task support
Thread-Index: AQHY/GXd/0D4hRhIPkuRQ8htDgun0a5InQpwgACc/ACAACtJ0A==
Date:   Mon, 21 Nov 2022 14:17:37 +0000
Message-ID: <IA1PR11MB6171444A263C4ABB216FF1F5890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
        <IA1PR11MB6171B27750AB469AFE47CD5E890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20221121110714.0000720a@Huawei.com>
In-Reply-To: <20221121110714.0000720a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|CO1PR11MB4962:EE_
x-ms-office365-filtering-correlation-id: 799a38ba-472d-495b-ea92-08dacbcb2487
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwzWnFuNzNUb0UI2w3Mkk5pLhsNoYk7ziTPCfb+6EimcbNVQoO8M6Z6MDSU490G/rbKLpVUPXOYwNryJBLh3kfkqlqz1VX4UNwKjjn9i6tZ2POsPFSnKItiIwSKYnJBRsOszGP/f4YdBrR0QEOh/SIzVxFB7JzaSITCO58QxLCnowlZjjK5Gnj9utD0xx9D9L3/KSwjMhZ/brC1Wap6ynPTGJwfmf6TBhqrK1EmulKmZkY7VP2eF0kvQ5t4lAkdZBXiwrlVrz2J24GkkoiqFg6F54ZaS6NF30MEZW1ak021e1j04SgWXD5kNhvBjvRL9TPYRN+aHJriD4Ts0c+QRsisy9IznSKaUf9I3Jp6UFPjg2g5/YUA/60fm7UneuOj1st4jfIf7mcGb7/F2CMc88DG4EMb2ldYMinXfaucjhXc6OCZ8MPKSdbkIch0hcCk7yjGuddz2VWZu/emcUzhDAK1zXXCi3TIu0wrgo4PpkqE/oEQwkJPErzufZM/MZinWcUzCSwnWLC9piGMUN4r46cZzFTv2Bhcihw4WDFLjuKWuyV0bgVB8QO1mPb/fjSBvbbvQ0bG0c83dOPqQTOrfbe3BXaRkmbxMnAZmNSOmXY6igafyQe8QNK6F6CMn10kCBAs1w8UJ8w216oybJf3lJqubeacKX7HzTjjN0xG9MriFo3t++22trp8ZfZWlcpAqRg+O1USBitUA9H2j5pJeRK0Aus6I+OLxuwlAX75UXIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(33656002)(86362001)(38070700005)(7696005)(64756008)(76116006)(55016003)(5660300002)(2906002)(26005)(186003)(9686003)(38100700002)(83380400001)(82960400001)(122000001)(6916009)(66556008)(54906003)(966005)(71200400001)(6506007)(52536014)(66476007)(8936002)(41300700001)(66446008)(316002)(66946007)(478600001)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3Y0YjcyY1FHbDFVc1BBVGh0VXl2elpiWTlDY0xsaXFSWmZiM3NNZFBtNW42?=
 =?utf-8?B?Qmk3OUdwU08xS281SGZJYXZLSllPSWVNeFlYb3BITHpicmJoTjNZVTV3WEp1?=
 =?utf-8?B?ZWp0M2laRnBlL21Md2VwWEowbEVkY3BreEgrR0tnZzF3UlI4LzdUajFyRW80?=
 =?utf-8?B?Tkhic3ZhTW55VzU5ZUtWYVNVakJsd0RDL0plSG15R0EySy9XRFIyTERRS0tW?=
 =?utf-8?B?NzV1Rnh3U2xINzVpb1dXbmt5THl5UFBJUkNDTDVtNzNleUowY3huRDRleVYv?=
 =?utf-8?B?ZXl3c210UVJsaFE2ZmxxbVM3YVVLVUJULzYzWktJaUdwaS9MUDdack5WWDBQ?=
 =?utf-8?B?bGRLYmpyWi9uYkVvVlFvS1QwMjVJTEpjQ0JMSnBtQlF1Ukx4aWV4bFl0VDN6?=
 =?utf-8?B?OW9yMnhmT1h2cVJ1TXNpaHBJQUtjVUtaRDdvYUNvcnVTVnhDTklQR2V1akxw?=
 =?utf-8?B?Qy9qTjd6RnRNcWwxbUJpNnh4Zng3N3lEMDk5eWMyZzRtL0kzMmhxRXRkaDVL?=
 =?utf-8?B?Skl2L1pqaUJiay9JZzVCRmVIM2N5S2tuNlNhN3hpL056bFN0WmMrMktUamp1?=
 =?utf-8?B?U2lZV3dCUitZekNBSkZ3bitqYzh0YTlIZ2o0c1Frelhab2RMMm0xVWJMdWtM?=
 =?utf-8?B?QXZBQVF1bkRLdTcvbStCdXlKYzJTUUhGeGxERWtFR2tXZ0dtdGFoaXlmSUhW?=
 =?utf-8?B?VzdROWpSVHRBRnUremdlWkU0VnpvSjUyVmowWWIrckJUWkVuaUxKNjUvNjZy?=
 =?utf-8?B?S1F4cmVDR09BWG5aSituZ2l3YnMvMG9vNVJ0TzEwTjFWd01LbExwbmlFSyty?=
 =?utf-8?B?QnhqdU5SbTlqTHVPUXlaZCt4bWJBOUtZZ1B5NnZSb0tKVzY0YXo5MCthZFFy?=
 =?utf-8?B?UFZrL3dkM0xvOTFTNFE0UGczNU9Hb2dqcklQOGVpVDdvajJ3MmE0bkc1akUy?=
 =?utf-8?B?UWg2VVVhWmxNeHdycG1paXpKVGtxby90Wk9IcjIwKzNsWEViZFZHTExWanl5?=
 =?utf-8?B?L0NweWZLMWd6M3k5YTB2bGt3T1U1VHI4OXJ0YXgwb1JaRGhXbVo2VHRDZGxR?=
 =?utf-8?B?Wnc5ZGpKaU44SFpnRisxYzNkQXhEZTY0eW0vZ3p2YUVSMWdFTGw1a1cwRHgw?=
 =?utf-8?B?N0d3eUhKRmw3QjVYdnR5TzRFSWpSdG41R0I3a0gvL3h1YzMxZS95aXpuZ3BW?=
 =?utf-8?B?SGoyclREaEdzaC9sVGdiWjlNYk5CM1VVdWVNY2hCWjg5VVZ0YjlOWVkwZlVV?=
 =?utf-8?B?elYzcmRWRlJzS1p2L2JlY1pYTTJLRysxSnhkT0pPZHh3bERleGRVMGQxeE9Z?=
 =?utf-8?B?cnAxaU0yalBXMzVBdjJoQ1NoZ0d2NlZpV1poeFdTNloyckk3MmRCYzBkQjhh?=
 =?utf-8?B?cXhaL0dCSTdtbVg4TFlhZVBnY3AwYzg1Wk8xRUNmWjFwWkVEOHRFbUV1aE1u?=
 =?utf-8?B?aHd1WHNXMlhWaldCb0c4dlZBZUFkQVlHUGZvSS82U1JmMUt6N2RGUE4rQkVH?=
 =?utf-8?B?SVdRSkdibG9rOHZ1Q1h6TlFLT1ZxczFxWGd4Q054ZzdJZW43a0xmR0tOc3NC?=
 =?utf-8?B?Q0VCWC9BVGZxUVkxQUdZckRPMmRFeDg0VTYyM2QwQnVrenNFTnRORWhBTzhy?=
 =?utf-8?B?Rks0SHJFSFZNY29hYVhtRWRyUXk5WjcxNExIaWlkWkIyaE0zd1dPV21qTCtm?=
 =?utf-8?B?TmhkNGwxMzk4ZHZIdWxSSkZmWGtVb2xBdXhKeDQ4RDVVRDdZVnRueWcvTnlm?=
 =?utf-8?B?MlZMbHRrYkZzTXFNRm5PSDZ0TWdrREJkS0R0NVphdXMwNmtSb2l2TGFoR3Rq?=
 =?utf-8?B?b0V6UEFrbE1pR05HYjRNQW1PWlh1SGdCUmlBcWRDL2toekFvblZkd2lNWTBj?=
 =?utf-8?B?dTBRaS9ZZzRCM1NUOXY2ZUc3RE5hRExPeXBPQm9OSDM4THo3ZTF1N2RGSTNI?=
 =?utf-8?B?RDQzVmN6MWQ2WGpPYjR5dWJKbXFRNW04cHlUZ3hSQkkrb0VRRmNaeGIzUHRn?=
 =?utf-8?B?VDZ0Q2JkRDhzTFlDYmtkbG5hYTlHZGI2SjF4aDg0Zmd3aHBHWmtQdVlaMTZt?=
 =?utf-8?B?Z1IyRHF4ZjFFdDNLU3JMUDNUWU1DTWhNOHJ0bnB5MXRIRWZmZStpRTRLM2E0?=
 =?utf-8?Q?iL3lNqT/d2oXqAoHvbkqr9qKv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a38ba-472d-495b-ea92-08dacbcb2487
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 14:17:37.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4D5KTTD9qNOS+tym1os0IhciktL6UqUp2fTUTEIYgtBYSnp+SjXd4XAi6QaciXEXO8am69CxV+eSIUDUj0uBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
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

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQEh1YXdlaS5jb20+DQo+
IC4uLg0KPiBPbiBNb24sIDIxIE5vdiAyMDIyIDAyOjAxOjMyICswMDAwDQo+ICJaaHVvLCBRaXV4
dSIgPHFpdXh1LnpodW9AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gPiBGcm9tOiBJcmEgV2Vp
bnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+ID4g77ye44CALi4uDQo+ID4gPg0KPiA+ID4gQEAg
LTQyMywyNSArMzk5LDEzIEBAIHN0cnVjdCBwY2lfZG9lX21iDQo+ICpwY2ltX2RvZV9jcmVhdGVf
bWIoc3RydWN0DQo+ID4gPiBwY2lfZGV2ICpwZGV2LCB1MTYgY2FwX29mZnNldCkNCj4gPiA+ICAJ
ZG9lX21iLT5wZGV2ID0gcGRldjsNCj4gPiA+ICAJZG9lX21iLT5jYXBfb2Zmc2V0ID0gY2FwX29m
ZnNldDsNCj4gPiA+ICAJaW5pdF93YWl0cXVldWVfaGVhZCgmZG9lX21iLT53cSk7DQo+ID4gPiAr
CW11dGV4X2luaXQoJmRvZV9tYi0+ZXhlY19sb2NrKTsNCj4gPg0KPiA+IEluIHJlYWwgd29ybGQs
IG5vdCBzdXJlIHdoZXRoZXIgdGhlcmUgaXMgYSBjYXNlIHRoYXQNCj4gPiBwY2ltX2RvZV9jcmVh
dGVfbWIoKSBpcyBpbnZva2VkIGJ5IG11bHRpcGxlIGRyaXZlcnMgdG8gY3JlYXRlIG11bHRpcGxl
DQo+ID4gRE9FIG1haWxib3ggaW5zdGFuY2VzPyBJZiB0aGVyZSBpcyBzdWNoIGEgY2FzZSwgd2Ug
bWF5IG5lZWQgdG8gZW5zdXJlDQo+IHRoZXJlIGlzIG9ubHkgb25lIERPRSBtYWlsYm94IGluc3Rh
bmNlIGZvciBhIHBoeXNpY2FsIERPRSBvZiBwZGV2DQo+IEBjYXBfb2Zmc2V0Lg0KPiANCj4gSSB0
aGluayBpZiB0aGF0IGhhcHBlbmVkIHdlJ2QgaGF2ZSBhIGxvdCBvZiBtZXNzLiAgVGhlIG1haW4g
UENJIGRyaXZlciBmb3IgYQ0KPiBnaXZlbiBFUCwgc3dpdGNoIHBvcnQgZXRjIG5lZWRzIHRvIGhh
bmRsZSB0aGlzIHBhcnQuDQo+IA0KPiBTdWIgZHJpdmVycyBjYW4gdGhlbiBkbyBzaW1pbGFyIHRv
DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVy
cy9jeGwvY29yZS9wY2kuYyNMNDY1DQo+IHRvIGZpbmQgYSBET0UgaW5zdGFuY2UgdGhhdCBzdXBw
b3J0cyB3aGF0IHRoZXkgbmVlZCBhbmQgdXNlIGl0Lg0KPiBUaGUgRE9FIGNvZGUgJ3Nob3VsZCcg
d29yayBmaW5lIHdoZW4gZG9pbmcgdGhpcyAtIHRoZSByZXF1ZXN0L3Jlc3BvbnNlDQo+IHBhaXJz
IHdpbGwgYmUgc2VyaWFsaXplZC4NCj4gDQo+IFdlIGhhdmUgZGlzY3Vzc2VkIG1vdmluZyB0aGF0
ICdmaW5kJyBsb2dpYyBhbmQgdGhlIHhhcnJheSBpbnRvIHRoZSBQQ0kgY29yZQ0KPiBhbmQgdGhh
dCB3aWxsIG5lZWQgdG8gaGFwcGVuIHRvIHN1cHBvcnQgQ01BIGV0Yy4gRm9yIHRoZSBmaXJzdCBz
dWJtaXNzaW9uIGl0DQo+IHdhcyBlYXNpZXIgdG8ganVzdCBkbyBpdCBpbiB0aGUgQ1hMIGRyaXZl
cnMuLg0KDQpGb3IgdGhlIDFzdCBzdWJtaXNzaW9uLCB5ZXMsIGl0J3MgZWFzaWVyIGluIGN1cnJl
bnQgd2F5Lg0KDQo+IA0KPiBKb25hdGhhbg0KDQpJdCdzIGdvb2QgdGhhdCB0aGlzIHBvdGVudGlh
bCBpc3N1ZSBoYXMgYmVlbiBub3RpY2VkLiBJIHRoaW5rIG1vdmluZyB0aGUgJ2ZpbmQnIGxvZ2lj
IGFuZCB0aGUgeGFycmF5IA0KZnJvbSBDWEwgdG8gdGhlIFBDSSBjb3JlIHNob3VsZCBzYXZlIGEg
bG90IG9mIHN1Y2ggZHVwbGljYXRlZCB3b3JrcyBmb3Igb3RoZXIgZHJpdmVycyB1c2luZyBET0Uu
DQoNCk9uZSBtb3JlIHRob3VnaDoNCkZvciBhIGRyaXZlciwgSSB0aGluayBpdCdzIG9ubHkgaW50
ZXJlc3RlZCBpbiBnZXR0aW5nIGEgRE9FIG1haWxib3ggZnJvbSBhIFBDSSBkZXZpY2Ugd2l0aCBz
cGVjaWZpZWQgVklEK3Byb3RvY29sIGFuZCB1c2luZyBpdC4NClRoZSBkcml2ZXIgZG9lc24ndCBj
YXJlIGhvdyBpcyB0aGUgRE9FIG1haWxib3ggaW5zdGFuY2UgY3JlYXRlZCBhbmQgdGhlIGRyaXZl
ciBhbHNvIGRvZXNuJ3Qgd2FudCB0byBtYWludGFpbiBpdC4NCkFmdGVyIHVzaW5nIHRoZSBET0Ug
bWFpbGJveCBpbnN0YW5jZSB0aGVuIHRoZSBkcml2ZXIgcHV0cyBpdCBiYWNrLiANCkEgcGFpciBv
ZiBnZXQtcHV0IEFQSXMgaW1wbGVtZW50ZWQgaW4gdGhlIFBDSSBjb3JlIGxpa2UgYmVsb3cgbWln
aHQgbWFrZSBkcml2ZXJzJyBsaXZlcyBlYXN5IPCfmIoNCg0KICAgICAgICAgc3RydWN0IHBjaV9k
b2VfbWIgKm1iID0gcGNpX2RvZV9nZXQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHUxNiB2aWQsIHU4
IHByb3RvY29sKTsgDQogICAgICAgICAvLyBpZiAoIW1iKSByZXR1cm47DQogICAgICAgICAvLyBU
aGUgZHJpdmVyIHVzZXMgdGhlICdtYicgdG8gc2VuZCByZXF1ZXN0cyBhbmQgcmVjZWl2ZSByZXNw
b25zZXMgLi4uDQogICAgICAgIHBjaV9kb2VfcHV0KG1iKTsNCg0KVGhlIGNyZWF0aW9uIGFuZCBh
bGwgdGhlIGhlYXZ5IG1haW50ZW5hbmNlIHdvcmtzIG9uIHRoZSAnbWInIGFyZSBoaWRkZW4gaW4g
dGhlIGdldC1wdXQgQVBJcy4gICAgICAgDQoNCi1RaXV4dQ0KDQoNCg0KDQoNCg0KDQo=
