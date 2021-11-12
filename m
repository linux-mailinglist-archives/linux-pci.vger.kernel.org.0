Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B044DFF3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 02:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhKLBuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 20:50:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:50439 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbhKLBue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 20:50:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="293880206"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="293880206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 17:47:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="565340646"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2021 17:47:44 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 17:47:43 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 17:47:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 11 Nov 2021 17:47:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 11 Nov 2021 17:47:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJNKyQyDVn7n91+5WlXuz83enTJCMNGFLr5B69b5X8wJrd0+HMbnRDGLT49thcQXwE7F1j7NwW3eTJy568jBvYyVGGc/InyHEBhvQF6x26f0AlKLhjWwH7+bZdqbPGjGckBhNU7d7SW+0krhjbPOKSM1IcU3uKM+IeL7+AcBD3M2YQZber1St3G9XrqF0hbRAjALoQqudQiyBykqCqVpMGWI8p3dl2prw5iwZhknMC9giVIMUH1ALGounlVcCT6Au30iOdgS36wTK/Z0Kqdq7MZa8L3g3+B+/rHTtFU2KjYmAuPyNLgpBeSAsLS3pogAcQ7CLN/ALCHVEK94va+keg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LzpmAzgGTq8DoHFBKyGiT245v1S1y5WZL0XMIjDJiE=;
 b=e5xrcw+hFUG9QZCI45P/E9UDTWkkFR4uf5q6l3m4+o+Va18nGLV0Zfdp3D+VZd6QmaZBXPraj6YbVEKSFAbZT0deBA3JNM3/XSd54T/tmuAOGZbiOywhw5GyZLaHiR5lXWIyaiQBBF3cKmbaC2Mrllmolp2D9ABezoSFs57XPRSXPK8A18VdXo1zz3/sUW/honWaw/W/iLmeUkyQqw8FkPooq5QtyX7+jcaQRcKHsD3ysYh4M6eU85kTvNM+qvifA0pJYwzCYObJTc+9l15SvN7u3Qm6DFZQpAAbXEHAd7qEXdS5KUXhF4s7EUmILhM/JAy8fxCPgAPt0/RPIh3XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LzpmAzgGTq8DoHFBKyGiT245v1S1y5WZL0XMIjDJiE=;
 b=RBjDGUXtTXHrgQCNI3MZapjl/vxDX7Nh8GoEq3OmQdxOaneG1ho/xmjQLfVQgsLHPS8beQ2ZvCT+0SbzExjH1VUAVvEZGz1nmR2jjDlNEnSC2FJKh0V3swJVxjhznfjKAKnXBIOrc5lSOtJlSMPdOELrueMCzfUdOMUw+HTGcQI=
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Fri, 12 Nov 2021 01:47:42 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849%4]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 01:47:42 +0000
From:   "Bao, Joseph" <joseph.bao@intel.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Sasha Levin <sashal@kernel.org>
Subject: RE: HW power fault defect cause system hang on kernel 5.4.y
Thread-Topic: HW power fault defect cause system hang on kernel 5.4.y
Thread-Index: AdfPm0b60GGT2vlORua28HBxsdiYnQAnnSiAAUFzF9AAD8bKgABIu/sQAC84CIAAAhFtUA==
Date:   Fri, 12 Nov 2021 01:47:41 +0000
Message-ID: <DM8PR11MB5702198ABAD1DF43237CC1D586959@DM8PR11MB5702.namprd11.prod.outlook.com>
References: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211109152951.GA1146992@bhelgaas>
 <DM8PR11MB57020F3491E508A334469E2186949@DM8PR11MB5702.namprd11.prod.outlook.com>
 <YY247SPgRT8OpNrF@rocinante>
In-Reply-To: <YY247SPgRT8OpNrF@rocinante>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66683c09-fb8c-443f-c2db-08d9a57e6a84
x-ms-traffictypediagnostic: DM6PR11MB4513:
x-microsoft-antispam-prvs: <DM6PR11MB45130919DA252198CCA192C886959@DM6PR11MB4513.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06W7zZBPQu3bcuuhNnBPMFElYDX6DxRNUuVWYPVtbulH4Z+XWUT1G35Po22nPeX4HrGpBMN2opKTN0Ky5p6LExTXAr7whdMMHHo7yu5LEN3vqzCe32LOj8yeLCcYEco37Mh1vLUWDssVej9/o94ilrgOKoOk51jBoH3UsxZ257VdE/Dkl1WqXscJKkit70YpeITf4T8nAriFZK1ebfrj+VKNKkXz3gyrd3O1azcoupecPlv+FSuYKy1FrX7veHCip9/YtGslVPYLT15fFhL8k5rV1YLbo8Z+VPo2XMahuriKFUWfQvFm5xgQ4Vdv0Z5LLSkWwukp1hEzwVhx0MSlFFDCjrnANTwgIgtu7cQHpL5X+HgB/H5uGyukBEUY2oemKkUnwi71dFilvQwOn6phT7wuEtv68MD7NSA4+aNIY9mVRPKn8puSuhjFYNZFVYQ0p4GQkwFWRXB+GibTt7xp+MUDthbWdmYuGmgui2Exu320wBQIXFMgNGy3SwiPGn4NnoKxx5Q5UduHy13CKvCOsecuNKbIy/J5jJAlGWa2FVAV9nCfvZ4cG1GHdLPOUO1j2/5+47vbyv2UNLsJuCsXk6QvJUJjCiZ69qwVcKjyojDRE/TGvSnOIUDhaozj9k1hiLK4e26/OUfy8NaKw3rPrDrPKvEiY3sDAX0QxijFDAz5r0qqBfswK9IQIMeVRu1HymAl1gvnvSXa/VlL7dTDJWMDkq0OexLsX4MyatoFY9acIcndHQKDkbF7e1kGoWVz0gCCaVSnW3toTYJ1WqYyAAtGDUvYfVE2GUa/sbApuzIhNzycDk4nFinfdn1Izt81rOfUOBCfE/xySY007oth8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(86362001)(76116006)(9686003)(55016002)(966005)(8676002)(54906003)(66574015)(38070700005)(6916009)(4326008)(82960400001)(316002)(83380400001)(508600001)(186003)(8936002)(66446008)(26005)(52536014)(38100700002)(66476007)(71200400001)(6506007)(66556008)(53546011)(64756008)(66946007)(122000001)(7696005)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5ReGcxZ1pqMmRrcS9ESWpiWGJZMXpnTE9xWmtZNVhoclE4KzhoZGZKL1FX?=
 =?utf-8?B?Z2NWM3RQcU9mSG5oVGVLaEI0RlpBaXF3NXVyRHVFekNqa0NuNWZkYWo2dHZU?=
 =?utf-8?B?ZExkVW54YThGRXhkT29Iay8wancvcm9LV0R1SHB0VG96andCa2wxTmNMYTBW?=
 =?utf-8?B?N1BKSXZ5R0lJcVNsQi9LY3luNDI1akNoUWZ6RUxkVGxVREtlSU9EQmZlMkFU?=
 =?utf-8?B?RkE3VkRVUkVaOEFsR1V2MW9yM0FydzVFU1dTRVNrNXVKUjFVd2VyeXdjLzBT?=
 =?utf-8?B?NDBZd1FMb01rbURzVVlQQy9HYUFoQ0RoMitlQmVNUmJiSkhTN2ZnS2IxOE9K?=
 =?utf-8?B?MmhkbjhhSFVMYlRZdVd5a2x6WmE0TzdyTzFYdVpVSk1wSGd3ZzhGc3hmRFk1?=
 =?utf-8?B?M0tadDVaQ0NxbGxQWS81dHdNUHBuRW5heE8raUJxdUlBbVdBU3lISFpsKzd3?=
 =?utf-8?B?OWlvU0NLNi91UUNDRTZYTjNvZ2xHbm5mL2U5NFFVZ0pNZnJzNGNIYnlqbEJt?=
 =?utf-8?B?SktubXFuNlFCNHBUSVQvTU9TR0VxOW1DRWxlSUdxYnBEZ1NXRk1NUmtWQzl5?=
 =?utf-8?B?endMSjRCa21mRDBLTFpPVzYrcVBJQlpCOXV1VGtHOFlQa1dtWjZZcnVFa3BS?=
 =?utf-8?B?TG55aUVQS0I1V05xbVNVaG8yV1pIdEwrNzNSYjdwanhhSjd0RXA2dkExc3Zh?=
 =?utf-8?B?RmIxQUVtS0hSTnlNa2dlZ3Q5eWpNemtZK2FaYldMWis1dE0za2N6NGxscTNK?=
 =?utf-8?B?b1BHZmN5S3F5eFduaWI4eTI0ajE2UnE1bjA4a0NDR21NdTUyTGkxV2xxeHg3?=
 =?utf-8?B?K1RGUTFUSUhSSFgyQUFoV0VsdnhQOG1qNTNsTktmU21LQUFyRUtWeXhoZnpE?=
 =?utf-8?B?dlhBUUxXa1dxN2wwWWpicWFuNUpGZlZjaGVIaGhQL3Yxc2w5aTI3VEgxK0lW?=
 =?utf-8?B?RVEzbzArSjNDV05kelloTUE2NnRueUFNbkl2NkFJcWliaStWdWpGRkFUT3Qv?=
 =?utf-8?B?ZENMY0dXU05IMElmQ1AzTllyd0V3ZTJWVDFxcFBsOWRjYWJuTXZKT1N0WS9G?=
 =?utf-8?B?Wkh3NTNVUlJlZXdISjdpdUJ4RjIrWmRSRlRVWEJ6Kyt0VGtWcHJLUlp5cmo1?=
 =?utf-8?B?VjQ1OU52eU9uQmJWVU5hN045em1ITXhqbGhBWURLS21wWDUrTDMxY0FJK3hj?=
 =?utf-8?B?VWE3NWFNcUV4YituUDNZcktNcGFWNWVRNTRFTkhVUWIwL203N04rYlJ5N0Vz?=
 =?utf-8?B?dWsvUG9WZTZOTENLVWlYeTlpZEIzd0EzV0FoVk1NdDkxWFhGd3VoME42Y3RX?=
 =?utf-8?B?dFNrcHV6TXNDSmpYcjdpb3Jxc1R3L3g0ZXFUQnlVY1c0eFNBTitxM285aThN?=
 =?utf-8?B?SWREZ2ZUU2R0ald5UFpESE8rK1lZZFNFNjYwdGNaOGxOMStpQW5zd1ZkWGtj?=
 =?utf-8?B?MHQrTXVlOERpbmVsTjRETDRETlMvNVpoSGFBSGdlT3VGT3Raa2dCTlFtQVdi?=
 =?utf-8?B?Tmp6VEhNNnUxTFRNcmNhUTZoT0VHTE1NQ0I5TWNEWldwRUlGekpxaHoveFRD?=
 =?utf-8?B?YnNDQVVLNk51RHQza084Qk4wY2E5ZzZDaXQvc3ZLWlZXMHpCSzRrWEM4My9Q?=
 =?utf-8?B?ZTB1ajBaYTAvYjk3bDJreWJCd0FYUk05RENlM24xVXBMM2N0RlRiMkFUSGp4?=
 =?utf-8?B?MHcxNmJnRDBYZHE4NEo2RmtFYXBvR0hYb2J0a0t0RWFDdnRSbGkzdTN1cTNo?=
 =?utf-8?B?NDhyRk84ekZZeS93dWZpelhVcTFFY2tyV0Y4Mi9YbXhwUW1iV1FJYVRGK2dw?=
 =?utf-8?B?MkQ2WUNsZE9JQnhhR0RWU3JsaDZSYlB1Z2FRZHpGdmZIc084MDBkTzBDOWtF?=
 =?utf-8?B?Tzl3NitUSzc0ZXZCaVFYRTFKS1BIaERjU1JMQml3Y21VMTVHR0oyU3NsOFBk?=
 =?utf-8?B?bFA1SWN2QmZic1kzV2Y3eUhlaS9uWTdDWXZZMUdRNXNFL2dIZExJZ0NJdTMz?=
 =?utf-8?B?N016MEM3Z3FSdVdOQjhLVzFudnFWYStDSUNqVTdMMWhvaEV4N2h4MnNwNmtp?=
 =?utf-8?B?TzRzcXVtUmFJNXV2TjFVdHlaazljRDNQcmUxYVZCcFdkdkNlNEhkREUrTEJZ?=
 =?utf-8?B?R2VnMU1OZUxGWVpXcCtnL2pSak1CMkJzQkVHRmpjU3RnOVJwenZCNGx0V2pk?=
 =?utf-8?Q?9vxJxN3OK5gAnD7gWIOxS4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66683c09-fb8c-443f-c2db-08d9a57e6a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 01:47:41.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0KqcrMc1Cv4x7CwJVBVhiUQ2gjDpXMP1f5hX9esnkZ0GHb5pzui6npi8QDD6Q1++56eFRQ3GnYBoZpbumriag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WWVhaCwgb3RoZXIgcGVvcGxlIG1heSBlbmNvdW50ZXIgYSBzaW1pbGFyIGlzc3VlLCBJJ3ZlIGNy
ZWF0ZWQgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTQ5ODkg
Zm9yIHJlZmVyZW5jZSBpbmNsdWRpbmcgdGhlIHBhdGNoIGZyb20gU3R1YXJ0Lg0KDQpSZWdhcmRz
DQpKb3NlcGgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBX
aWxjennFhHNraSA8a3dAbGludXguY29tPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTIsIDIw
MjEgODo0NCBBTQ0KVG86IEJhbywgSm9zZXBoIDxqb3NlcGguYmFvQGludGVsLmNvbT4NCkNjOiBC
am9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgU3R1YXJ0IEhheWVzIDxzdHVhcnQudy5oYXllc0BnbWFpbC5jb20+OyBM
dWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVs
Lm9yZz4NClN1YmplY3Q6IFJlOiBIVyBwb3dlciBmYXVsdCBkZWZlY3QgY2F1c2Ugc3lzdGVtIGhh
bmcgb24ga2VybmVsIDUuNC55DQoNClsrQ0MgQWRkaW5nIFNhc2hhIGZvciB2aXNpYmlsaXR5XQ0K
DQo+IFRoYW5rcyBmb3IgdGhlIGVuY291cmFnZW1lbnQhIFN0dWFydCBhbHJlYWR5IGhlbHBzIHBh
dGNoIHRoZSBoYW5nIA0KPiBpc3N1ZSwgZG8gSSBzdGlsbCBnbyBhbiBvcGVuIGEgcmVwb3J0IGF0
IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZz8NCg0KSSBhbSBub3Qgc3VyZSB3aGF0IEJqb3Ju
IHdvdWxkIHNheSBoZXJlLCBob3dldmVyIHBlcnNvbmFsbHkgSSBzYXkgdGhhdCBpdCB3b3VsZCBi
ZSBuaWNlIGlmIHlvdSBkbyBvcGVuIGEgYnVnIHRoZXJlLCBpZiB5b3UgaGF2ZSBhIG1pbnV0ZSwg
YXMgaXQgbWlnaHQgaGVscCBzb21lb25lIGVsc2Ugd2hvIHdvdWxkIHN0dW1ibGUgaW50byB0aGlz
IGlzc3VlIC0gYSBsb3Qgb2YgcGVvcGxlIHNlYXJjaGVzIHRocm91Z2ggS2VybmVsJ3MgQnVnemls
bGEgYXMgcGFydCBvZiB0aGVpciB0cm91Ymxlc2hvb3RpbmcuDQoNCkFsc28sIGFzIHRoaXMgaXMg
YSBoYW5nIGluIDUuNCwgYW5kIGEgbG90IG9mIHBlb3BsZSB1c2VzIHRoaXMga2VybmVsLCBpdCBt
aWdodCB3YXJyYW50IGEgYmFjay1wb3J0IHRvIHN0YWJsZSBhbmQgbG9uZy10ZXJtIGtlcm5lbHMu
DQoNCglLcnp5c3p0b2YNCg==
