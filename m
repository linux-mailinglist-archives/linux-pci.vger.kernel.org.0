Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415B832C274
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhCCUyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:54:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:38231 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1450621AbhCCFfJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Mar 2021 00:35:09 -0500
IronPort-SDR: ccL5l6N5xQWNlHrfwWQvyihLyDewi8/M4GggvhCnnpWuc/hE+GIgHoGm0LYKJDfrDEZSv4yuvs
 /URh1ANSQHZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="183721778"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="183721778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:34:27 -0800
IronPort-SDR: MObJDv1RbqqG0EOiuTCgCoyp8y7qh82Tj0LunJLsRT1EEIQT4cYVPkQqVF5BJ5Q8P64xfcqB0h
 I43ccLxuwK5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="399509208"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2021 21:34:27 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 21:34:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Mar 2021 21:34:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 21:34:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg9B4gfyKFJC7/WfWy4+b/ZD31AdNHswyDomnUQBnE8J3mHXqHhyKS4AizEUVRqAWTKjY1tMvUkQNThdkS8yPZwLPSdvN7fJ3a19kWWtx9KXyz2XsgLRNGQMhEEo/QBZf6BdZ2zonw9yyoVC9qPGOrK8fRu75YrMwgu5oiBcrOQGYjM6oUEUQJ5JhbU1JhB4oMfCOD6tNX+AGVDc8MVv4hTs42GsUqnVDayFOmljeQI7BsgnCSosxC67USXqWXVmp2/1tpmuwwiJLbV5YHyJrsZyhulaYedmVT1rVahg02dy+Wquc6BbdBvKmrnI9+4HVmlT0L7dXiae/N4+VeJjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pNMZhSm2IR6wrAG6TqVIxMxeI4gIm+3mbFML2JKKuw=;
 b=hlIm4AroNaJts2S0i6bGfoZAqUCFBj50feBEnE9uc/p3LarsI6Gj8ZzFHbWsb2S6qHWOEyUccFhD2N+8vUucObXHQzSXOTqEQDfDJOrnr4LodqgYLC/iLcmEqH00fMKmqmG7lP4yecIT1/KbVaGqroPHqeM62MEjpKlA6NjhgxtjqCo7w/v3QLKwJJG6Dat7TxvQXQHSpLvn5a3IDuoS1Kx4KhxDMrdA8N6PpgnVLdQrsu8C5ehOtNN0YtLYe3rrWGZCfmnFqb6SfWc4XUuN4t8puXBF/+khZgqjn2cCurTlB1lTE4OlUhbUZAW986K3p4PaRMxhNqUVG3NtiVwFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pNMZhSm2IR6wrAG6TqVIxMxeI4gIm+3mbFML2JKKuw=;
 b=gXMEmbq4OSu++sOlZSNehs1lWV/7cleQwqzmGMxSSxX/hVGaQIKwITsrDm6ZxuxcSEzxbaQdY/CMzHOOiHRULSt24tJJb65MV6i7tFF+XmGl+cyLIDhqhECmP9+jpM5YClDGvNJQ4IDapbQq8GrnClP5UCN+3H3Z73ZsTmhmGqQ=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BYAPR11MB3462.namprd11.prod.outlook.com (2603:10b6:a03:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 05:34:25 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5127:2366:9745:85d8]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5127:2366:9745:85d8%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 05:34:25 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
Thread-Topic: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
Thread-Index: AQHXD+7f8OuIEoDWQ0Clp13WfcEKQw==
Date:   Wed, 3 Mar 2021 05:34:25 +0000
Message-ID: <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
         <20210104230300.1277180-4-kbusch@kernel.org>
In-Reply-To: <20210104230300.1277180-4-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db6be194-2479-4863-703c-08d8de0601fd
x-ms-traffictypediagnostic: BYAPR11MB3462:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3462117C1DAC04D8D6E20438C6989@BYAPR11MB3462.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NTNwNUR2YneiEsxoSKRWYsZYtAgTW591nRgvgzcSyd0Ty9x8NpQ5f4BQ+EPx5p3Ha9ggfxFDxhf1mjISIH2tkKzPHOcgOfU53IgFYf7s9Rv2LxJStuHUhX0ERlLIqShV6tfQ0EiHuqXxJRRfGNHauo/CuYrX7xPnqA+bhsnePC1jfC5LXnO66cvPFzb8DQpXjJWjHeTS+J0D+vTVDz6kloq7C4luSqdzNPM/O6HOjQYRE6fG7cmcGcN8rnZowij8riPBZ2S7pJ0tcFuaCSHQLSXV5nlEjdJDN5IJIBu/DvibBYk598cP5xvbNo69iIYNDjwXD+EWuhwv/MYSXowWg0UENnod/HFlFOatbS9rXkXll/rT0rcxxpyD1+Fxt7tI/zM0iQpyySMCrIS07mzPhhRNdtKPMIFTroTdlQ9LRW/w25QabdIkfO3k2bQxjTZbDSr1HObDH1dkUUMVDE2y7kTJyFANi8DGA8NXlu+9gjGYTcEGY2DO9QrgZ4K+CXC02wNsOQR1WQX8EoPSDNB4Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39860400002)(107886003)(26005)(4326008)(6506007)(66476007)(6512007)(36756003)(83380400001)(76116006)(86362001)(6486002)(66946007)(64756008)(15650500001)(8676002)(8936002)(66556008)(71200400001)(5660300002)(186003)(2616005)(2906002)(110136005)(66446008)(316002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dDZPREdpMFd2N2NuNzdad202dFVZV0NRZVVDaFVFdDFudkFJZ1kzZjVWN0dK?=
 =?utf-8?B?UTYybG53M2YvQWY0UjZhalBWbTVBeXdRZEtLdzBHRjEwRjJmVTY1ajlkK29a?=
 =?utf-8?B?ZlpjL0RlODF5ODhxVjYzWTc4dU5zVE1qREpFZXRrUXZ5U29kdUp1OHlwb1Yy?=
 =?utf-8?B?M0kySEVCdkcyR0lGMXBHWXNqTTRndDJPVlBCcU5wT2dUejV6d0kzV1A5VmVQ?=
 =?utf-8?B?My9EVDd5N2FlTWZ3UzRkZXhFYTJFS3ExTFE4Z0hRM3FMZ1ppblhycm1rdE5r?=
 =?utf-8?B?OEF6OVo2b2hJaTNaNFF5LzNwSklCWmFqTTlqSHZ3OTBJZ2l3d25henlxVzNY?=
 =?utf-8?B?Zndzb2VRdDY1eDRvTFQwZFFEU3R5Z2hmWVY4ZUhlVko5R2toMGc3d1F4RlA3?=
 =?utf-8?B?LzFZemtCanJGUTRvU3lYYU1xZWo3OHNIclJ4WlJ0UytJR1BpeXlXS3lVait5?=
 =?utf-8?B?NG4xd3dHcVRxd1RzbjI0VGg1OWJZZHF5MFk0QnNxTEp1ZDFXd09tTWErWE1X?=
 =?utf-8?B?bU5RNmZOODBkTFN2WkNtNit2TXJlOXJEL0ZXbWg2QVRKSW55OWFkVkw4UmR5?=
 =?utf-8?B?VGtkVUl5ZG1BQmM2U2NjbW5SQTVwT0ZPN2htd2xwZ3BnR3FIR3VYVXVYSTNU?=
 =?utf-8?B?RDYxTmdLOU1NRVZtK2tBbUhwakF3Z1EwK2h5VkVjaE43WXQzUmNTRXFqaVZq?=
 =?utf-8?B?VXRvQ0VkSXZHanhjRDFhUlIxMkJCVTRXenpxQ3RBSlB1WXYycHBUdkszWTBp?=
 =?utf-8?B?dlZVbFd1NVFmb1hEVUlGbThVdXdGMzFOQ0dUaXNveU5IVTdyRFVlbnp5STdl?=
 =?utf-8?B?MDJNU3l1aiszMTgrMHJqKy9WdlFieVBtT2RubXFMbUFndkU3RGJXd3hvdUIz?=
 =?utf-8?B?azRweXpDL2ViWlh1ZXJEM2NBKysvaVdrbFZ0bXJLS2ZpYXNhQUY0TkFrQ3Z5?=
 =?utf-8?B?REs3bEpkRjlnMFlzWFhPcWFvYmwyOTU1SUl3QnNZemRIeWZmam5qVGdCMkcy?=
 =?utf-8?B?WnNmUDJ6c1ZjeEFqZ1drQ21vUVp2UXpHa2tmVDRFaWtyenpGbWZxZWZCclFq?=
 =?utf-8?B?NVQwMjlSU3F6Kythb0FzWFBKOFp0alZkb3ZSdmFwNGdBVTJpYlBYRnZrZ2Jw?=
 =?utf-8?B?cFpjNFI3UFZEUWRuVVh0U01sVzR4WlFxenBXMDdXQjZBTk5lbUVIek9JdFZW?=
 =?utf-8?B?dFJFdjVheXFlOU5rcnNhcW5jajRRNGJmVXI2VSt0VENHSURoVDBzRlI3Njd6?=
 =?utf-8?B?MFhMNXVGSDN3Z3ZKZWZ3bERkSENNVGRDNnp3b0xNb1RYdnVBSWdBTm1BMG9N?=
 =?utf-8?B?dFVna3RXL1g5bVRySFFEaW5HUHVkZ2xXaGl4QUJkRVJvM2VJL3ZrK0gwUlAr?=
 =?utf-8?B?WllOSFF0bzJBYUxtcnBOVDdSbWdSM2tmYlpOR2loVUxENGNnaVExWVhpZFBI?=
 =?utf-8?B?aXpuTW1NcVpVOGQzUGRRSjU0WTlKNW9KcFVDSGdtZTg5dzBsc3UyS21hT3Vs?=
 =?utf-8?B?QkRyQ21sRTl5ZlB0YTFENmlQOXhLL1lyelE1V1FaWk9haURJR2hmRy9KTDNx?=
 =?utf-8?B?VVZIc0t5eHJ3ZnkrSlJtcDZZNHlOSkFMNkovTjZTUEJpMVZJelEzUWs1Wkhx?=
 =?utf-8?B?UjY5MENSVVhzMjBFQVU1RnFyRm1JRVlxMkZNd1M2MkFETWNqZWN1Zjk0MlRS?=
 =?utf-8?B?Y0dBSEpKdHJpWWh5Y2pKMUlqbzNxNElSTmRUZ0N4L0U1YkpaSGJUWDhMcW8y?=
 =?utf-8?Q?N3IyXsoNdGzr5cGQDp88lrAiqbawEgHXgm2/zoO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <167BC383613FF740B5A9D7F9B58D8F9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6be194-2479-4863-703c-08d8de0601fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 05:34:25.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRTnefle29WeZTBZXyiMnWrh7tT6DfaPvuJ7YMm5IBwHBb3Tmyac7x/oCi/udWHcPYhp+xy3rsp5ekVqGe7QHJ5J69z+AUaigShCRYJeIHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3462
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WyBBZGQgU2F0aHlhIF0NCg0KT24gTW9uLCAyMDIxLTAxLTA0IGF0IDE1OjAyIC0wODAwLCBLZWl0
aCBCdXNjaCB3cm90ZToNCj4gT3ZlcndyaXRpbmcgdGhlIGZyb3plbiBkZXRlY3RlZCBzdGF0dXMg
d2l0aCB0aGUgcmVzdWx0IG9mIHRoZSBsaW5rIHJlc2V0DQo+IGxvc2VzIHRoZSBORUVEX1JFU0VU
IHJlc3VsdCB0aGF0IGRyaXZlcnMgYXJlIGRlcGVuZGluZyBvbiBmb3IgZXJyb3INCj4gaGFuZGxp
bmcgdG8gcmVwb3J0IHRoZSAuc2xvdF9yZXNldCgpIGNhbGxiYWNrLiBSZXRhaW4gdGhpcyBzdGF0
dXMgc28NCj4gdGhhdCBzdWJzZXF1ZW50IGVycm9yIGhhbmRsaW5nIGhhcyB0aGUgY29ycmVjdCBm
bG93Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IEhpbmtvIEtvY2V2YXIgPGhpbmtvLmtvY2V2YXJAZXNz
LmV1Pg0KPiBBY2tlZC1ieTogU2VhbiBWIEtlbGxleSA8c2Vhbi52LmtlbGxleUBpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KSnVz
dCB3YW50IHRvIHJlcG9ydCB0aGF0IHRoaXMgZml4IG1pZ2h0IGJlIGEgY2FuZGlkYXRlIGZvciAt
c3RhYmxlLg0KUmVjZW50IERQQyBlcnJvciByZWNvdmVyeSB0ZXN0aW5nIG9uIHY1LjEwIHNob3dz
IHRoYXQgbG9zaW5nIHRoaXMNCnN0YXR1cyBwcmV2ZW50cyBOVk1FIGZyb20gcmVzdGFydGluZyB0
aGUgcXVldWUgYWZ0ZXIgZXJyb3IgcmVjb3ZlcnkNCndpdGggYSBmYWlsaW5nIHNpZ25hdHVyZSBs
aWtlOg0KDQpbICA0MjQuNjg1MTc5XSBwY2llX2RvX3JlY292ZXJ5OiBwY2llcG9ydCAwMDAwOjk3
OjAyLjA6IEFFUjogYnJvYWRjYXN0IGVycm9yX2RldGVjdGVkIG1lc3NhZ2UNClsgIDQyNC42ODUx
ODVdIG52bWUgbnZtZTA6IGZyb3plbiBzdGF0ZSBlcnJvciBkZXRlY3RlZCwgcmVzZXQgY29udHJv
bGxlcg0KWyAgNDI1LjA3ODYyMF0gcGNpZV9kb19yZWNvdmVyeTogcGNpZXBvcnQgMDAwMDo5Nzow
Mi4wOiBBRVI6IGJyb2FkY2FzdCByZXN1bWUgbWVzc2FnZQ0KWyAgNDI1LjA3ODY3NF0gcGNpZXBv
cnQgMDAwMDo5NzowMi4wOiBBRVI6IGRldmljZSByZWNvdmVyeSBzdWNjZXNzZnVsDQoNCi4uLmFu
ZCB0aGVuIGxhdGVyOg0KDQpbICA3NTEuMTQ2Mjc3XSBzeXNycTogU2hvdyBCbG9ja2VkIFN0YXRl
DQpbICA3NTEuMTQ2NDMxXSB0YXNrOnRvdWNoICAgICAgICAgICBzdGF0ZTpEIHN0YWNrOiAgICAw
IHBpZDoxMTk2OSBwcGlkOiAxMTQxMyBmbGFnczoweDAwMDAwMDAwDQpbICA3NTEuMTQ2NDM0XSBD
YWxsIFRyYWNlOg0KWyAgNzUxLjE0NjQ0M10gIF9fc2NoZWR1bGUrMHgzMWIvMHg4OTANClsgIDc1
MS4xNDY0NDVdICBzY2hlZHVsZSsweDNjLzB4YTANClsgIDc1MS4xNDY0NDldICBibGtfcXVldWVf
ZW50ZXIrMHgxNTEvMHgyMjANClsgIDc1MS4xNDY0NTRdICA/IGZpbmlzaF93YWl0KzB4ODAvMHg4
MA0KWyAgNzUxLjE0NjQ1NV0gIHN1Ym1pdF9iaW9fbm9hY2N0KzB4MzlhLzB4NDEwDQpbICA3NTEu
MTQ2NDU3XSAgc3VibWl0X2JpbysweDQyLzB4MTUwDQpbICA3NTEuMTQ2NDYwXSAgPyBiaW9fYWRk
X3BhZ2UrMHg2Mi8weDkwDQpbICA3NTEuMTQ2NDYxXSAgPyBndWFyZF9iaW9fZW9kKzB4MjUvMHg3
MA0KWyAgNzUxLjE0NjQ2NV0gIHN1Ym1pdF9iaF93YmMrMHgxNmQvMHgxOTANClsgIDc1MS4xNDY0
NjldICBleHQ0X3JlYWRfYmgrMHg0Ny8weGEwDQpbICA3NTEuMTQ2NDcyXSAgZXh0NF9yZWFkX2lu
b2RlX2JpdG1hcCsweDNjZC8weDVmMA0KDQouLi5iZWNhdXNlIE5WTUUgd2FzIG9ubHkgdG9sZCB0
byBkaXNhYmxlLCBuZXZlciB0byByZXNldCBhbmQgcmVzdW1lIHRoZQ0KYmxvY2sgcXVldWUuDQoN
CkkgaGF2ZSBub3QgdGVzdGVkIGl0LCBidXQgYnkgY29kZSBpbnNwZWN0aW9uIEkgZXZlbnR1YWxs
eSBmb3VuZCB0aGlzDQp1cHN0cmVhbSBmaXguDQo=
