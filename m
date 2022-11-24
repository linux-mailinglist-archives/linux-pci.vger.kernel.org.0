Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0047C6370E7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 04:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKXDT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 22:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKXDT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 22:19:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8064ECE9D3;
        Wed, 23 Nov 2022 19:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669259966; x=1700795966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zg///oa3YpQLH5+oTUDiUT6n0yxIIs/5/mWkekdH5yA=;
  b=BheYZ1UWVqeEKuq+KhGo5wvdLolh2v73Lb0go4RLTv5A5T1OEuLcZyfb
   g0yX88+/v3tMi/3a+cZrykZB2lnBVb9p12Eps7NmxERv+of8lF0SgK+Lf
   6lbGMhRoBvfaNEYA4I8tc6pzHB7DiEY1mJC0BizB1JxfBUjh1MqzgKH97
   f6l5dv4KeCe702N3h2Lp0ZaEav8AmqQxqJwRNyL6Ea5B7PAOtRuSjFDHw
   UgOT3S8VS2ZLfUWNSP2nEJ+QLWcsubHch99wMXVAB+/mLSVwPu7IaRp1Z
   wpkbcfw2M1YIfqjFlsaIg5gJmHM9M0wpYV46CmenjgYIyI5z75/CTFCXs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="294592430"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="294592430"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="673089029"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="673089029"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 19:19:25 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 23 Nov 2022 19:19:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 19:19:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 19:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEbz1jRMDMRCdzsQ1/h4gFHQnSv8bS57HJbNYxzIBQGg5qud3rLpAHBt6fqRVj6vYmcVyt8bAxf0GHwvC6DKsw9F0Thq0WPALi1ty/Kds1f6YDhlgEYJcu1gDBtqy2gJZZrV+/V7JTx44kAXAK8z10N5/7ITN3HQjXQLXCOLhEQAfAOKoW8qIokzi0rOX3mG3A0mHq0zGpXB212D+aULgBNSrEWUoHbxlpFHuV1ZclxDob7a22nJ3Mm7tDsmDZsifjcnAeNu9j+673ympx6ftHE8CbLioLgjsh9KGQITW0GvKjEp8A349lz6aP+NjB1cOZ8iPqpdQOxsWfySCpRVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg///oa3YpQLH5+oTUDiUT6n0yxIIs/5/mWkekdH5yA=;
 b=FQaQ/eH3Uh/TF0I7kG+3OvehP3Ae9DpUOwZfJVTEIRcWgiD4mgKe5hFhgbfU1Aa5kU4w7AqkFyrHi+OemMwpBLpaBveMgOFnItlVtvlZGn72l8jzO/ZzD4BaWe6LWAR2viz2oaK+PJ/k32Zh0beXvVYBHHYpakswEgk3clrZuFAtCma8p/hvqDg/VXp9pR/RmZhNpa0q+aZli7V+aGnESMGEn+nkTzZRsDGvYPa6pLYkuHC2JuM79WMWg94OYaH5jQQSUnVN8XPAyrpzNnWB0+DfNf+jFcoe+4a3040aCJa3u7jkY/sz/wPPmecNfGGD5hHXDlPlShJs+0Xa3XVS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 03:19:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 03:19:23 +0000
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
Subject: RE: [patch V2 33/33] irqchip: Add IDXD Interrupt Message Store driver
Thread-Topic: [patch V2 33/33] irqchip: Add IDXD Interrupt Message Store
 driver
Thread-Index: AQHY/bbxfgLLhb0ruUq7v4zDonV6g65NXkLQ
Date:   Thu, 24 Nov 2022 03:19:23 +0000
Message-ID: <BN9PR11MB527675086F946B35494C4BD38C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.288703733@linutronix.de>
In-Reply-To: <20221121091328.288703733@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: 32bf6433-cec3-499c-da1d-08dacdcaaf16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjzU7s1ZG07u0v/11SuDH+cTGPErRqoInVtCrsZ08hzIJv1U7x/xHKBBnyD6ZaOwXDSX/8F0hkmD36wBW9KRrCgmro56Ykp36fa1AhkWHYT0OGZvdfJb5Yq2wtLpfIM0w3E+ERDVVLArTFxdGtoFnml8de1SqTLmr7Uv2nLQFMhFKa4wBVCoKwOZbryX29+W+EI0ukhujrYg3wtwwU773v8aZZP3jJB/sb2zZWem9egYsC6xWyb3t+LNvIFLN0h4qvcwN335ibFfXZTODIe/2zu575ATv7svsC/XHaN6kio5hlMs/t7z4QSwvErP/MsjPLRDffJgR0aCz9qKEMPba6T2B8Y/lwF5Oc4UyIelNdG7e5BoqBNzAgALmxg3rNtF7tjZYbbg24+WdwVhFM5JoELnCKMnJnooSO33THOcuI+81ewPBfKAn85GTE8tHJFmjlZYHG9zhxvtL1z+6bQ3ZPJgDdu0YktNOlEcIxbF//pRqP8rNsgNIph65vvnL+LYJc1GwGW7WDmlznOKZkTtXye/wnej7h2F44wEbQELghiY14ZpTY3Yk0C69cE0jmKobCr8pOUOsx1oeBtpBQVwVNuZI3DPkgLphpM0pM8Qm9v6w/1c9WZ4pefK75yXVBPklpCO94SIkVisbabT4wzxw0KZ1aWmOlsDsaawDJoVIYGAt0UKnfVrlCHiKNf/BRYkJWBeXVERrR20Ip2NJyqwhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(76116006)(38100700002)(26005)(122000001)(4326008)(64756008)(8676002)(66946007)(41300700001)(66476007)(66556008)(66446008)(82960400001)(2906002)(86362001)(54906003)(83380400001)(55016003)(52536014)(15650500001)(33656002)(7416002)(9686003)(8936002)(5660300002)(4744005)(186003)(316002)(478600001)(38070700005)(71200400001)(110136005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVYxOXA3Q3d2anIrMDJITE9GWHhCZDlVU2VPb0piamJVY0I3VXV4R2dMTjF4?=
 =?utf-8?B?cmpzMnd4Zitzblg3QkN4V3FBSm5tTUdDK01nMVRoQzlVRk9BZitRc0FyeHFF?=
 =?utf-8?B?SGJ3MFhIazBUMXZXb2hEZmpUN3lYTloxV3h1TVc5b2ZWK2Y1YWxCWnp4T01X?=
 =?utf-8?B?TUVGTC96clhMQTFWaHduc1o0YzlNQ05JRGE3TUd1NmFaRTdOSU81R0hrNitS?=
 =?utf-8?B?S3VFYW9ja1JybnB3cllQN2djajJwVGU3UGxZR1FwL2tLMVorRnQ5V05mTzlq?=
 =?utf-8?B?MnJYWXZPQm9CTHpDOHUxVEdkaTI0QUNJOGE2N2ZNVW4vbE8zejZEQWg5Z2J1?=
 =?utf-8?B?MkJFUk90dGcrN2Y5alN5V1o0cDU5cmpuVEJIRFNpRnlTeXhxbnNoV0Ivc09z?=
 =?utf-8?B?SEk2ZStxYU9paldRTEpIc1hjT2dBTFQ4VUl2NFNocHh4QnlXb3VvRTFOcFdl?=
 =?utf-8?B?SDJBaC9QZWVXd0RRWm5UcE5xL2NIOUZrOG1IL2cxUnV0QzkzbW1MNWlwb0xz?=
 =?utf-8?B?Rjh0Y25tQ0MrbjNWNWdTTml3Y1NFT2J1cGRuTlNuVjBzTFJFMDcrdU1MakVK?=
 =?utf-8?B?Q3hWdEdxTVhuUzhxTk5LaURMS05uRXZ4M3RyTk9yUUZScitOSjVldktjeFlt?=
 =?utf-8?B?UERxeTJOL0FScWZMeHE0aFYwVTNPYldEdHpzZFB6YklUbUVmWTVRcTdxSHBm?=
 =?utf-8?B?dUcxL2xlK3kyV3Zmc0xqNVdvUyt3NFlFVEM5Ym1pUUpRd05lTTFoNU5TS3Mv?=
 =?utf-8?B?dnJZT0V0eFhSQVFZT2w0YXc4b1NDYXhSOTU2MGlJUWNFNDIrUmdHT2pMK1dL?=
 =?utf-8?B?YnRWYVV3NnhEUW52WkNpalNjREEwRTNpU2I4R2VTeFZUSStTRmN6K05DRDkr?=
 =?utf-8?B?d3JRY0cydDNPYVNVdVpZQjhNNk5VbGVEVmFIQ2tKR2JaNmsvSUc1eTZCM0Vn?=
 =?utf-8?B?Z2pHYVdqS0I5dmZUK0V3eDNta0VuS3VIK1U3UDlNMnFwMzVUV1Y0OUVWbDB2?=
 =?utf-8?B?NnNxNjZWYklCcGZ3T2RmRmVIcEhXMnkxSGwwZEpVWS9QNEx2ZnNJQkxUcEhs?=
 =?utf-8?B?OEMySmM2UGJFMGNHWWdHaUVSNUZoNXliQUNlc0tlOUVjOXhMSlFLUGFNWUFN?=
 =?utf-8?B?dkJ4MTFXNk01NGE0WTJWT3NxbHNPU29EN3hmYitMUDYyeThMZTdvdEJZZUhq?=
 =?utf-8?B?TVl4Znp1MFZTa3p0QzlNMHFXQUF2Zm82K1hDa25WY0lTdmhyNGt3RE9sK29J?=
 =?utf-8?B?ZkIrVlB0REZ2NEp5M05LSUhNZjI0QkZYR3hIdEo4SU1lRTJlVjJmcFlZcTNw?=
 =?utf-8?B?MnVmam1TQXRMbWRCOThseEJRVkNER0pKMU1UL1ZNSTFqVC9JRnZ3a25GOHJ3?=
 =?utf-8?B?RlBycStYSlk1S2l5TmQxY0h2RGFhNXJ0YVNaaXV2M0ZzcFJnb3dTeVdnTEk2?=
 =?utf-8?B?cnJac0tXN21QSVRDV011MkxUT1cyYzRHQWdZVUhhRStycllpYnhEL20zK2VW?=
 =?utf-8?B?SThKN0ZqVHNCd0VSRGErUWlJRGYvMUtQbTBqcHRjZ2xhNHhjaS80Qjdabmox?=
 =?utf-8?B?Y1M3R3dYVlhlNmNldmwwaE9CNGp0S0g0RnVUYmtoRmJCL2pYUDZRYjhXMVkv?=
 =?utf-8?B?VXJra1VBaXJyNFNzNmhLcHdsY2RYY2FJNlRwMC9aNWtNanpRbVB2M2JGV2p3?=
 =?utf-8?B?aWlGMzlsd0NVSTBhWE8xRmdLZWpWUlc5bDJhYTlDa0dQdWg0N2ZMMUluYzFT?=
 =?utf-8?B?TmpyM3Zva3dBZ3Z5c3Z1dFA4K3M3SGdNYWtEK1hXMkhQV21QTVp2a1V4bUxn?=
 =?utf-8?B?SlhoVFlXNXNDVitUVDYyT3pZT3VxbHJTT3JycURSU0xZaDNYdEZyR2NHU0Yw?=
 =?utf-8?B?Y3dWNmJIdWVZbGFSczQ0bXQveXhDNlhWOUFGOGxWY0kwTWhTcHRKcjJDdnha?=
 =?utf-8?B?RUswcEwrUjBJY0lLcHlwZ2JOTVdWQWE3QldlRzZHMElyUmQwNzhkK0FOL3JF?=
 =?utf-8?B?a1lZcWVaeUE3cnFtRFg5bTJneVlTN0t3M3liZWRVTGFnWUhZS1BxaG1KT0th?=
 =?utf-8?B?NUZXN1hieWJoNUxSRTNQSVJrL0dkZHozRUczVEgrZUFKSC94ejJWckNKVnpF?=
 =?utf-8?Q?Xpg9bulV2UYUGQFLDpSlKVwbD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bf6433-cec3-499c-da1d-08dacdcaaf16
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 03:19:23.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8oGBkpvXJFgMdE6s/r7+YtygjkEuhLe9ra1dFyIpDoPHBKD1zlMWfoJKld3c9J/2iPTcTmlp0v1YH3ZbegbnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gK2NvbmZpZyBQQ0lfSU5URUxf
SURYRF9JTVMNCj4gKwl0cmlzdGF0ZSAiSW50ZWwgSURYRCBJbnRlcnJ1cHQgTWVzc2FnZSBTdG9y
ZSBjb250cm9sbGVyIg0KPiArCWRlcGVuZHMgb24gUENJX01TSQ0KPiArCWhlbHANCj4gKwkgIFN1
cHBvcnQgZm9yIEludGVsIElEWEQgSU1TIEludGVycnVwdCBNZXNzYWdlIFN0b3JlIGNvbnRyb2xs
ZXINCg0KSU1TIGlzIGFuIGFiYnJldmlhdGlvbiBzbyBpdCdzIGJldHRlciBiZToNCg0KIlN1cHBv
cnQgZm9yIEludGVsIElEWEQgSW50ZXJydXB0IE1lc3NhZ2UgU3RvcmUgKElNUykgY29udHJvbGxl
ci4uLiINCg0KPiArLyoqDQo+ICsgKiBwY2lfaW50ZWxfaWR4ZF9jcmVhdGVfaW1zX2RvbWFpbiAt
IENyZWF0ZSBhIElEWEQgSU1TIGRvbWFpbg0KPiArICogQHBkZXY6CUlEWEQgUENJIGRldmljZSB0
byBvcGVyYXRlIG9uDQo+ICsgKiBAc2xvdHM6CVBvaW50ZXIgdG8gdGhlIG1hcHBlZCBzbG90IG1l
bW9yeSBhcnJyYXkNCg0Kcy9hcnJyYXkvYXJyYXkvDQoNCg==
