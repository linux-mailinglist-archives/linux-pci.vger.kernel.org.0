Return-Path: <linux-pci+bounces-1539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9EE81FE17
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF89FB21398
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73906FC4;
	Fri, 29 Dec 2023 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUKjtZfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6CE63D4;
	Fri, 29 Dec 2023 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703837835; x=1735373835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=US06RFh+UsCUsX2+81dRobYD2W17ROzqUZ6365KTmno=;
  b=jUKjtZfXRaXR+gIuwTAv3wkmEQdygg0wDEWK6ghPa0kqQECO7/1lOma6
   mvDNCedoGtc144Xy2T4etTq0FmOpsP6jCrrTN6xBfTO/a0F4O1BQNBmjl
   WeirFjSHlYhA8mX5KFZSaSvNjBRTNDlhz/oEJgtQDcDISqjfuNQ4MLyjc
   cFQqhM/cZscp2ZQ92WopO5U6NeibfooHuuYxTKopisLORe2azif7iqEf3
   XZ/E7lgpC3hY8TWboYkhR6mZfjSsNAfp28nZo4eZj6c4L+X2NUrVIM13B
   jqqI/SLvz+nsx7GnzbOej89KT+g91jYltqdej6hS3jy6ArhSE1Vf79NwV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="18182080"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="18182080"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 00:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="897441163"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="897441163"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 00:17:14 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 00:17:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 00:17:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 00:17:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqnuLjBJRola0t8wvjQlfOoWFetqzS7skHHhn/wPFhABFX6Q3n7dZvOmQ5rD3mW64hXR4dKEzfmxBQUpCCapfa6u3RwCXVjBYI0rvAY6gUOPXNO54+ohgGAXp1wJd1HrxqNWgqal7NDD2u2BoFFJtBI26mGhRXowa28WizCRLZrzHUgY8Urp8JXtwyTfSfLx4YdhQID4z8gaFh7hWZ+REkTog5SdS7XWJ3yF0Xf7YzIcqGSMkqrctCBx4oxd/ixpFIdzr5BbI8MbtWGmPeMe4HWg2bezb88vhtSlyQlccY+iwrkJSKhlvPxGj6lxc9hce6E0hIyuY4joloj1rnqCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US06RFh+UsCUsX2+81dRobYD2W17ROzqUZ6365KTmno=;
 b=M+JZnQId+5FtNPy/Dt/Dp7V+tUFVjU4D7wF6Z9TJ7Wpf9N0JdyYs6ehW1V9y/byp/6RCG2xV8cwu9BUKBZnIcCryFQiKCJQwH5GmBBFJ6BR0X4YmiQsK674XvncBVlZ3t+nYsWHtErUYXaGbc/bx9ScMjfuUSMwx+o+dGl/EpJxfqQqzkqrcV29HlKPLChTrF6oNy4h41svGeO5Vqp/ktOpe7asavVAEYMiE5X8kKNoRx4ACtoSwl+zhi7IbBj75k+avrWdqeUftPHTf1rMVPBsw5IAbmQ+mciqcphIdhov9OKnqfM/qD9Hei3TwbRPwLEwk0XBExwTFDlxfPHf5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Fri, 29 Dec
 2023 08:17:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 08:17:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v9 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
Thread-Topic: [RFC PATCH v9 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
Thread-Index: AQHaOSNeLqk7OMC1FUmomOwsRPnbNLC+XgtwgABOCgCAAT2PAA==
Date: Fri, 29 Dec 2023 08:17:06 +0000
Message-ID: <BN9PR11MB5276E70591021395F1ED90D28C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB527651C1A108721CFF057BCF8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bb3a8a4c-6dad-4347-9076-0f28d1e23de3@linux.intel.com>
In-Reply-To: <bb3a8a4c-6dad-4347-9076-0f28d1e23de3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8319:EE_
x-ms-office365-filtering-correlation-id: 2060d8e3-9513-4136-f47a-08dc08468c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcAk6smdC567V239VG140nHDPc1BCkgDn/8+wjUioDQ3n7riCpQmZwNsJnqd8NJMotb95WuKyXeU7sEhvXCk6FjW0ecvWbSmvTipcjUbahYLGe2+NjgKbr5QBWfJFaq24PnNAQdWI5oatGIY2L0D7RhhJiQqjHJp5Lv6IPQWAP6zBgSfgGV5zPJWnGrOjCHEKKBDdHQy07xCurKewDGgsSnnGwuG9BetA0qYnwV1G1vqIGK+v5FAQ1GrcjphziJGCCLAu1TaJBRP0xhPLOaVaJog9AKsMaO4jN67jporrHBACaczqKUmNWJXQu7LjPGsqGowFoaNIITwXbtQd5rPo2G2Zkm/3d+20PGC95ZHZL+rK+pmD2h6qNjMIr5JQxAo4qxa3S90H/FshVsfCy6x+Oln8ndtT/4Z/bgKuhn7H1HvcYHvZQki7E46/HZG5Vla4QVxiCeztp++tbDQRXMDoLKrcBkzafxPFKQND2r5ARSXj/C/s6zFsPHc9op2mQa8ppTvIP5ChOrRjQoqNuxM6QId7Hf9zKmrZ5JO0AQLWNeX+mBDk6Yc/FF8ExBTl//SGWXNMSNgefI1BkNHmn9Mk9pSVyoZB6thOPTXMQRxOj2UcUvgkyCDWYBskt+rq05C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(64756008)(66476007)(71200400001)(6506007)(9686003)(53546011)(76116006)(66556008)(66946007)(66446008)(7696005)(38070700009)(86362001)(26005)(38100700002)(122000001)(82960400001)(83380400001)(54906003)(2906002)(8676002)(5660300002)(4744005)(478600001)(8936002)(316002)(4326008)(7416002)(52536014)(110136005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDdRQ3FPS2xESmNHUW45ZVBsOVZZSnc3WEREY3A1elhUa2ZLbjJacXBLNnVT?=
 =?utf-8?B?VkJBYjZidzErSDdLUEtXSXdrbHJNWG5oZlhSdDErWmRTcXdmaW1DV3IrMnhF?=
 =?utf-8?B?RHlKbUR0TjJ0RXlicmg3NElmRjNYS0FkcTIrY2p3TGluQmxycVR0UDhSOHFs?=
 =?utf-8?B?UE1pMkRkYVZTVkp0aDhiMjIrcXhEbm5zM3dSWUwrZURHS0loK0ppQ1lEY3pY?=
 =?utf-8?B?cS9nSzZPN3F2WlN2VklvUnIwbVRqaFU0MGlrNTluejlQRkxJS3poWk5qZ1Fv?=
 =?utf-8?B?TzMya1JQeFh2S2V0RHBIeElDSkU2cDM0alRaUTVyZ1VENGZtNHE3eGRVM0F6?=
 =?utf-8?B?UGh0a2c5dFp3Q1YvcVJRdDlsWU4zZDJJOHA4dzhTdlJoR3BRSFZpc0dlbkY1?=
 =?utf-8?B?Yzc1SWVyUXlYZU52L09hNFhrMlZSeWhLemUrT1UwOHRCTU9zZDdGcmR1VFdp?=
 =?utf-8?B?WTV2RnVTaTMzZ3NDVGNyNUFLS0YzZU1HSFRaOEhINzB4RCtWOUlJYmllalQv?=
 =?utf-8?B?a2w4cVd0VVRsdEVUMDJNRFpvWXNRRDN6QWl3WFpFMFg5NHo4ay9Nd2IyMi90?=
 =?utf-8?B?SkgrZGgwZmxkTFhURmc0UnBaZGVLYjYwc242QkpqN1VJOVNEY0J1OHFQZ2Zh?=
 =?utf-8?B?MTRnTGRkTGFJWHloNW1hNVdJSjRpdG5rb0xMWWpaUlRsNFlwME55SHlXMlht?=
 =?utf-8?B?WldZbVZmN1RML0pyWkdZU2xOSjdxVTJzcWozZzY1bGVqRWlvVzBBS0FCQ0hm?=
 =?utf-8?B?ZHV5WlN4cVJoQ3lMdDRydlF1RG1GakxKc3VMeDZZbGp6OWtHZ2huTDh0akNk?=
 =?utf-8?B?UDgzVUk0TTRwbTFXOTdoRHg0TDgzSDhrWTMzSU9NQ3B6b0RZVndRa1N0YVVG?=
 =?utf-8?B?RndaVy90T3VDL1pYbWV1VnVQWmxMZ2pPcC80ejF6QTQ5WTJXNStQaUpiNGFZ?=
 =?utf-8?B?Zk1BYkRRNjhoRjFLa3Y3Y2hNclFIMXdzQkNodCtyYzlHRElHbEwzVVYydzRu?=
 =?utf-8?B?MTIweHNTSkpPc0hjREVrQ3A0ZFRkSGE1WGMvelpuMThaTHRrYlZmaUFTbTh6?=
 =?utf-8?B?Mk8xVXFlV2tjS2hKZGEvbmxiQ2NVUExlRG8xVkpnbTAxVktwaytqckdYWnR2?=
 =?utf-8?B?eFBjaTJHNHRJakkydDhaWG1hUmhRTUhWZlQxYkJORFM2ZGU3QW5HQkJvbFVo?=
 =?utf-8?B?NGFpTGFLckE2MHNDS0ZxR1AxcGMzNnFMeVlKeGpqd3hqRkpGeDRDQXRwT0Z1?=
 =?utf-8?B?VktGdUx3cE45cmV3Qlc2VlFrdXR2VVAvTnUvYnlaNGhUQ29DdnFYbTFFck1r?=
 =?utf-8?B?SDc5VlhTTFRYSithL3M5QS9OUjBndS9WRmlZV2RkSFdaUVVEM3Jzam0zUVpN?=
 =?utf-8?B?czRUeFNrUm44ZUNDRm9yaW9OMXFwRDBsbGlBTDhPR2puMDA3aTV4RVVzc3Fq?=
 =?utf-8?B?SXIzeStYRVA4aXZibTRKYVMrSFJWQnNCekJQNUZvY2t1OWNzOTVDb2s3TzA4?=
 =?utf-8?B?VmRFdENBaWh4UVB1RmJxNU9HYW9UcWV0Uk4yM0dBYXJVSitrUjNUQ1BkNmkw?=
 =?utf-8?B?R0xNMDJkMktzTWVQdjdiSWNNWkU3bkZqZld3MUVBMy9OMTUwd1BaMm5qWGxW?=
 =?utf-8?B?RDN2NUg1bnBJZmdBRmVOa3oyaFB5NWJ5ZlZWNDRZcmNEcDdFejE1dEI2MHRR?=
 =?utf-8?B?YzAxcHVVWWRxZVlIYWZ0bkdUYWQ0RlpjOC9zUExHWGZ1SW02K1NNNEptbDFR?=
 =?utf-8?B?N2xhSURuWWN1ampUZnJkQnN4NFI3eHRXdGtIc3ZpL29oMk1hRUtaNnN1UUMr?=
 =?utf-8?B?c0VoYy9ObUZ6WldITjU5cjUvN3pYT2w0QlQ5WlQxRnVWMi93ejlSZ3IvOTZQ?=
 =?utf-8?B?QlZZUDMzbndoUjNqcGJiY2FjQWtsY3Iwck03VVdlUnowODN5bzRMdHE0Nm1B?=
 =?utf-8?B?ZHlKOEhwTCtGZ0lHdkR3TGt6MEtIbU1QZTBWcXJzd2prSlZBMDVmYTF6cGp4?=
 =?utf-8?B?SVZ5YURTUnBKcTdRY2JQTGpRK01hZFB0ZDg1YUY3VVJUYXBidHB4T0djNVRw?=
 =?utf-8?B?L3pPWG0zUFRxSmVlQ0pQWG9oaVBFY21NZm9aajEyNEt5bVlaSWJRdlRLNTQ5?=
 =?utf-8?Q?lb8L7rFNr/7lZFw6JPNTgaVBc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2060d8e3-9513-4136-f47a-08dc08468c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 08:17:06.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2idvP+BSYRZFjTMA6UtFjRmnV2j8GQ06lUVGIYf9R8yKmUsmcEhJsiP6va7wMe25AxZxcMu5VD33OHGxFqw84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgMjgsIDIwMjMgOToxMCBQTQ0KPiANCj4gT24gMTIvMjgvMjAy
MyA0OjM4IFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogRXRoYW4gWmhhbyA8aGFp
ZmVuZy56aGFvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVy
IDI4LCAyMDIzIDg6MTcgQU0NCj4gPj4NCj4gPj4NCj4gPj4gLQlpZiAocmMgPT0gLUVBR0FJTikN
Cj4gPj4gKwlpZiAocmMgPT0gLUVBR0FJTiAmJiB0eXBlICE9UUlfRElPVExCX1RZUEUgJiYgdHlw
ZSAhPQ0KPiA+PiBRSV9ERUlPVExCX1RZUEUpDQo+ID4+ICAgCQlnb3RvIHJlc3RhcnQ7DQo+ID4+
DQo+ID4gdGhpcyBjaGFuZ2UgaXMgbW9vdC4NCj4gPg0KPiA+IC1FQUdBSU4gaXMgc2V0IG9ubHkg
d2hlbiBoYXJkd2FyZSBkZXRlY3RzIGEgQVRTIGludmFsaWRhdGlvbiBjb21wbGV0aW9uDQo+ID4g
dGltZW91dCBpbiBxaV9jaGVja19mYXVsdCgpLiBzbyBhYm92ZSBqdXN0IGVzc2VudGlhbGx5IGtp
bGxzIHRoZSByZXN0YXJ0IGxvZ2ljLg0KPiANCj4gVGhpcyBjaGFuZ2UgaXMgaW50ZW5kZWQgdG8g
YnJlYWsgdGhlIHJlc3RhciBsb2dpbiB3aGVuIGRldmljZS1UTEINCj4gDQo+IGludmFsaWRhdGlv
biB0aW1lb3V0IGhhcHBlbnMsIHdlIGRvbid0IGtub3cgaG93IGxvbmcgdGhlIElURSB0b29rDQo+
IA0KPiBpZiB0aGUgZGV2aWNlIGlzIGp1c3Qgbm8gcmVwb25zZS4NCg0KaWYgaW4gdGhlIGVuZCB0
aGUgYWdyZWVtZW50IGlzIHRvIHJlbW92ZSB0aGUgcmVzdGFydCBsb2dpYywgdGhlbiBkbyBpdC4N
Cg0KaXQncyBub3QgZ29vZCB0byBpbnRyb2R1Y2UgYSBjaGFuZ2Ugd2hpY2ggZXNzZW50aWFsbHkg
a2lsbHMgdGhlIHJlc3RhcnQNCmxvZ2ljIGJ1dCBzdGlsbCBrZWVwcyB0aGUgcmVsYXRlZCBjb2Rl
Lg0KDQo=

