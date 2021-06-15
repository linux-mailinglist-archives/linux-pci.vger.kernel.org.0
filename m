Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65323A8307
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhFOOkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 10:40:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:18250 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhFOOkp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 10:40:45 -0400
IronPort-SDR: OnJYjHrWdexqiL7CQANUkp3PK454TkTWWeZF+HQgNyJEZxYUDP28BDhvVpkRm7W63tScGVO0Yu
 w67cGtao3c4w==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="269851233"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="269851233"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:38:40 -0700
IronPort-SDR: jDT1T2EQd+asKeb8mLKNZBDgqMpV8O7w3T6x75KRicPVkSWuWoWb7cF0ZSl9W5lOoyrwOkYdwW
 CxXGbc2k0m5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="404244886"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2021 07:38:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 07:38:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 07:38:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 07:38:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 07:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXobcmHaXn/10oOONNVYYPJFfYoxAdRJSL4awMG+tS+92i6Rp0Z5SP17vo3K+fh5QG76S5qIgbzyZu1kqff+pdaCWiNIYYaZdQM6YeGyjKVc4MNhtn2avJ+Cf2KmwHbzh/TVRXoLsnBfcxns3CXKx+ShA0GmAdbH0p1Y1Vz3jD5GFhGsvpNIGZoO5GPSXLT1f9vqbQ39N5qPQE/90tEH4YRdwUmRXJloLKDbxlkxOanUEwLRJltdxaqcAyUG/pWx+Cfva9WboG4tQK2kFWRnmXtJnvCb4WdWoeglmlTKMGuepltpxQmBOK+PS54PGHr04S5BFZKQHjF02RWW7MCuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZXJ2sfRqYNPwMtNGE81TkYFexvXPLeIq9ZBYXhltvE=;
 b=XVCpnFPW3FOA99mTkQGYEQ3w3xou8AndRv3unNuYUgTiDM19oo/puyAIMn/jOxcxXWrj2QmNMAlZhQ2DW48dbVO+YQ/l5upl1oiD/Mf4oUK5C8aHWYX96ALmzeb+jxEWaz2SYzZUHYVfhZTsb0001jLTKwzkBYjMgrlJP8YLqH3f+67REsfm6E0wpkP8QvXpyOy1hXGqJBclzWA9pKmh/xAyhZjIwLCqxDrc7g6FjLvACaj7ZFlicKjIZb5Gk73Mo4zURNbjhKAYwR82tfe/XOnQWuUixyDqzJIricG4vJ6UwdRGZQrrEuy3/V+m4V1IbvftCZdWO0d+C/+pm71Rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZXJ2sfRqYNPwMtNGE81TkYFexvXPLeIq9ZBYXhltvE=;
 b=FbJqS/g1b+mRNLDwxODTJ/iF7GkwY2OOk3akIxlT1xTY70VG0MsolUlOy2eTXS8nsDRHE2/5YS3dv+7ZoUDCr3dvgK87qogY5guvzNsGCnVI5cZRCX8HFlMPkhFC62uLTvfEIdld3CgbyvvSVuowggI0y6+WHPlBbOd6lRQtyvE=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5660.namprd11.prod.outlook.com (2603:10b6:510:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 14:38:37 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::201a:d1e0:b3b1:fb8f]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::201a:d1e0:b3b1:fb8f%4]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 14:38:37 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH v10 0/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v10 0/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXW3FLMqCYomwSM0ewxrZmCWjVxKsUkTSw
Date:   Tue, 15 Jun 2021 14:38:37 +0000
Message-ID: <PH0PR11MB55954001B54E69B49247E15785309@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
In-Reply-To: <20210607154044.26074-1-srikanth.thokala@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.181.36.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dbbd810-1cf8-43bf-6230-08d9300b42d8
x-ms-traffictypediagnostic: PH0PR11MB5660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5660818BEBC0002847C6638C85309@PH0PR11MB5660.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uo+uevTV+D3Ke0RRhUYHEwclXjiJl1Tk5gvH3TpwwtfYP/dmotDjTO+jHoWzC04xRSuNB2XSy6P/gEaKc60CnJtC8YT48nMlmcAn1OSOPBuLkbjRgpiAgDEmW80K0GJEPKYsAfrlNhRWq3zrBEMdMitdnZxvxfx93PenjX2kg8ItPkeHfzUviaPILxk8BsMs2J/BRnx0NRwmZVgy6PqhyB9ck+EX5gwMLS4Y5Pz2xyEIVpzJ6qPDfZFtYTuGLzG19bAducVxoF9fs17jj2NBA7OmHsgFgSvBTm8fVH/PIc6e99Qi9vAjodCr1m6hD1adcnjCflgd/YY0U4YnVKmhn3+7mwnVPUJxVtOns9lmWnNWT+DqGWIBgKgVAip6B/4FaeeJTX4BfoVSFb3TeZEfcLzv8YkR9IiUeTf6o7rFWCIAw1RwgUXrqOSTU3X9V9uSQhodwFoPIVjbnmGeP8ApwYPnsm5mLR946t9Ut02X/vIRpOPni6MJCe+LynODW0A1pZRjqkikwFOwra0gYUyar0tc6cBnc8vR0/jDpKA5VuEonLOA7xjuhXH+mWWkqOEe3m3fZiUCilvjelyEs61KxRCBCBmh2Q4TCZFh7HwARWcJXI1IBKxTYnkj1H6JQadRMAXoaLRuXGohp0DofvC1HJpiVRuG/PjpHLsl9HXJrHgW6FO+/gavDkJIayx5E/uF0cPPlCAxQvlRxex1U3EPGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(4326008)(966005)(498600001)(110136005)(5660300002)(66556008)(66574015)(66476007)(2906002)(66446008)(54906003)(64756008)(8936002)(76116006)(66946007)(83380400001)(33656002)(6506007)(26005)(186003)(52536014)(86362001)(38100700002)(8676002)(53546011)(7696005)(9686003)(71200400001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTkxWmFLcWtXY3NyVk5CVkFPbkhsZzlJbkpjK3lCQkVrTHlUeEE2aWREU3Br?=
 =?utf-8?B?MkxWOU9mV29UTXp4cVBzMFBEc0xRV1JlSkNPcmZFRUVmOUZrSkJaNW14a0Vu?=
 =?utf-8?B?SjdISkcwN0JqZ256dXN6UThoSm5haXF4anUrcWwrYm9LRlljc29GZ0ZjcDZP?=
 =?utf-8?B?MStDQUEwenUydHpkTnVwT3hlMVVWenNYQjhXNE56bGduL045R2JUZ1k1Mnc5?=
 =?utf-8?B?a2JPRlBuQjhmYnNEaUJ1bUdSTU00dnJuTkcyR1RNYk1BMUkvWXNHT3U3TmZK?=
 =?utf-8?B?ZERxS245d0RhQjByd1dFa09yZWFzNG95ZFNEZnlObTlhdEFWTWtQVTFoZURV?=
 =?utf-8?B?Z09vR0FzU1dUUTczekM4UVg3MHY4cTA0eVk5N3BPNUxaVEFZeFJWWGdrSFht?=
 =?utf-8?B?aEhlTERmRHNOUVplQVdHRmNPcXlnaU43bjFmdkcwOXVWNENjYk4rWFM0Qmlz?=
 =?utf-8?B?TFlTdGxmVEFUUGNzaHVBbWxhRVJuU0hJbkJhdkhWRmovQjI5ZG0wa0xoN1hT?=
 =?utf-8?B?K0I5UHBGTTNldmsyajJlQlEyMmlIb1dKUzBCSFlUL1VSNUFFaXN6aC9UdmR4?=
 =?utf-8?B?OGtKZEovMW9FQ0RZTk5pSStDOW1sQzhOQS81dDdnemk5VERIc0Y1amZ0S2VT?=
 =?utf-8?B?R0dHYVVIcC9ueW84ei9ucGcwOXFIYkt1ZWdjV2dza0tTdHJ0WnRGNkZGUG9C?=
 =?utf-8?B?N2tibnNqM28rbWlmNERzWEpmWldQcHBLT1QwZ3EvSm9ES3RESUxqRmFWaWF5?=
 =?utf-8?B?VUtlUW5iNnF2YzIwb1ZWZ0FWeEU4NVlNYVJiUERKNldEYUxSU05jRDF6dHpQ?=
 =?utf-8?B?RGIvZjc3NHlQTmNUaGhvb2RONjllRGFVU0xFNllmR2hDa292ejZtQjNKZXlV?=
 =?utf-8?B?MHRPcDNpVCtmRlkySElKMW0yYkQ5Z3BmOFdJOEd0SFUxcndsajlIaTNsS25h?=
 =?utf-8?B?NG5idFp5cVk3VGtSTXBqaytRR29wb0VIVmE1dW9XbUhJVjlobzJIYnZTVGdI?=
 =?utf-8?B?RE1pRVRGbjAvelpSLzlSNTZSMk54T3FvZkdSYU90dmVIRWlVc1luZE5NOVNa?=
 =?utf-8?B?ZmRlaXFZOUxoUi9hd21oMFEzaXJBbkdkejQrS2M3aGMyNE03TnVPcVR0ZkxL?=
 =?utf-8?B?ZkxwZ0hRQ1dMMXdhcFBkdzFpQ2JwQ0lJK2Zibmh1YjJIL0JZUjcyd3RaZFRX?=
 =?utf-8?B?MmtHN09KZnJsSHJsNURyZXVvZEZKeDdJKzFhUlZUWHc2dzlRM0dnM3JhUDFy?=
 =?utf-8?B?bWt0Ujc4T1ROaGpOVk9pM2UzYjk2dDQwbnZWN3poT3ZZOGtTd0dvelVoMDVY?=
 =?utf-8?B?MXZNekVhcktYdHM3N3ZUdmFzTVpla1psRVB4OVhVb29xYVlUUzJqQlhOQll4?=
 =?utf-8?B?aEVXdGdsaURFalFrQlNrZGJNWXJubVV2N1Qwa1FVS0VRdWx1cWtwbU9sSlU4?=
 =?utf-8?B?RjVXNGhLS2hZRnNLRWN3cFBkc1RtemZxeitYS1dsWTR2UmcyZzJENU1Qa3d1?=
 =?utf-8?B?Mi9lL3g5MHBsV2ZWbVFRYi9zUGd2eUQ2REJZNDdNd1FSYnpXSEx1NW1SeTZS?=
 =?utf-8?B?dWRoOFZCeEFPMlFydnVPclZ4VjBUSTgreWJUQy84Ylg4QUVvZW4rSGdzNDEy?=
 =?utf-8?B?VUF6OHpHekh3VE40aVErZDZWZmExa3VhZG5tYUdoMnRocmNkNzlqSjMxbGt0?=
 =?utf-8?B?UkNkYXB1UVFTZzBhRjREd29NZU1mbzBNVW1mUTIwbko1cWxBbEZSc1dFK3ps?=
 =?utf-8?Q?Q+WWq4UnXYjzqUPwbw783IO/spE+f7dPyEytt1H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbbd810-1cf8-43bf-6230-08d9300b42d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 14:38:37.2273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjtvqeV1/Zrv2zMdbD+vyX3fTDj7hYsopCI0ATjd7AW3qMs5+zrN7TOj3f/Ls8CsLYkAd2BrUCblklwaVSH0rOnYE/sChXTr5PxQIVDRYU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5660
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56byBQaWVyYWxpc2kgYW5kIEJqb3JuIEhlbGdhYXMsDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhva2FsYSwgU3Jpa2FudGggPHNyaWthbnRoLnRob2th
bGFAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgNywgMjAyMSA5OjExIFBNDQo+IFRv
OiByb2JoK2R0QGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb207
IFJhamENCj4gU3VicmFtYW5pYW4sIExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWphLnN1YnJh
bWFuaWFuQGludGVsLmNvbT47DQo+IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGEgPG1hbGxp
a2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+Ow0KPiBrd0BsaW51eC5jb207IFRob2th
bGEsIFNyaWthbnRoIDxzcmlrYW50aC50aG9rYWxhQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYxMCAwLzJdIFBDSToga2VlbWJheTogQWRkIHN1cHBvcnQgZm9yIEludGVsIEtlZW0gQmF5
DQo+IA0KPiBGcm9tOiBTcmlrYW50aCBUaG9rYWxhIDxzcmlrYW50aC50aG9rYWxhQGludGVsLmNv
bT4NCj4gDQo+IEhpLA0KPiANCj4gVGhlIGZpcnN0IHBhdGNoIGlzIHRvIGRvY3VtZW50IERUIGJp
bmRpbmdzIGZvciBLZWVtIEJheSBQQ0llIGNvbnRyb2xsZXINCj4gZm9yIGJvdGggUm9vdCBDb21w
bGV4IGFuZCBFbmRwb2ludCBtb2Rlcy4NCj4gDQo+IFRoZSBzZWNvbmQgcGF0Y2ggaXMgdGhlIGRy
aXZlciBmaWxlLCBhIGdsdWUgZHJpdmVyLiBLZWVtIEJheSBQQ0llDQo+IGNvbnRyb2xsZXIgaXMg
YmFzZWQgb24gRGVzaWduV2FyZSBQQ0llIElQLg0KPiANCj4gVGhlIHBhdGNoIHdhcyB0ZXN0ZWQg
d2l0aCBLZWVtIEJheSBldmFsdWF0aW9uIG1vZHVsZSBib2FyZCwgd2l0aCBCMA0KPiBzdGVwcGlu
Zy4NCj4gDQo+IEtpbmRseSByZXZpZXcuDQoNCktpbmRseSByZXZpZXcgdGhlIHBhdGNoIHNlcmll
cy4NCkkgaGF2ZSBnb3QgJ1Jldmlld2VkLWJ5JyBmb3IgYm90aCBwYXRjaGVzIGluIHRoZSBzZXJp
ZXMgYW5kIHBsZWFzZSBsZXQNCm1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbW1lbnRzIHRoYXQg
SSBuZWVkIHRvIGFkZHJlc3MgZnVydGhlci4NCg0KVGhhbmtzIQ0KU3Jpa2FudGgNCg0KPiANCj4g
VGhhbmtzIQ0KPiBTcmlrYW50aA0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2OToNCj4gLSBBZGQgJ1Jl
dmlld2VkLWJ5OiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT4nLCB0aGFua3Mg
dG8NCj4gS3J6eXN6dG9mLg0KPiAtIFJlYmFzZWQgdG8gdjUuMTMtcmM1Lg0KPiANCj4gQ2hhbmdl
cyBzaW5jZSB2ODoNCj4gLSBVc2UgY2hhaW5lZCBJUlEgdG8gaGFuZGxlIE1TSXMsIGFzIHN1Z2dl
c3RlZCBieSBMb3JlbnpvIFBpZXJhbGlzaS4NCj4gLSBSZW5hbWUgKl9zZXR1cF9pcnEoKSB0byAq
X3NldHVwX21zaV9pcnEoKSB0byBiZSBtb3JlIG1lYW5pbmdmdWwuDQo+IC0gTW92ZSAqX3NldHVw
X21zaV9pcnEoKSBjYWxsIHRvICpfYWRkX3BjaWVfcG9ydCgpIHRvIG1ha2UgaXQgaW52b2tlDQo+
ICAgb25seSB3aGVuIGNvbnRyb2xsZXIgaXMgaW4gUm9vdCBDb21wbGV4IG1vZGUuIEluIEVuZHBv
aW50IG1vZGUsDQo+ICAgSVJRIHdpbGwgYmUgc2V0dXAgYnkgdGhlIHJlc3BlY3RpdmUgZHJpdmVy
IHdoaWNoIHdpbGwgYmUgYmFzZWQgb24NCj4gICBQQ0llIEVuZCBQb2ludCBGcmFtZXdvcmsuDQo+
IA0KPiBDaGFuZ2VzIHNpbmNlIHY3Og0KPiAtIFJlbmFtZSBrZWVtYmF5X3BjaWVfbHRzc21fZW5h
YmxlKCkgdG8gYWxpZ24gdG8gaXRzIGZ1bmN0aW9uYWxpdHkuDQo+IC0gRml4IG90aGVyIG1pbm9y
IGNvbW1lbnRzIGZyb20gIktyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPiINCj4g
DQo+IENoYW5nZXMgc2luY2UgdjY6DQo+IC0gQXJyYW5nZSBTb0IgaW4gY2hyb25vbG9naWNhbCBv
cmRlci4NCj4gLSBBbHBoYWJldGl6ZWQgYW5kIG1vZGlmaWVkIHN0YXR1cyBvZiBlbnRyeSBpbiBN
QUlOVEFJTkVSUy4NCj4gLSBBZGRlZCBhIGNvbW1lbnQgdG8gc3BlY2lmeSB0aGUgUENJZSBzcGVj
IHNlY3Rpb24gYWJvdXQgdGhlIGRlbGF5Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NToNCj4gLSBS
ZWJhc2VkIHRvIHY1LjExLXJjNC4NCj4gLSBVcGRhdGVkIG1haW50YWluZXJzIHRvIGFkZCBteXNl
bGYgaW4gRFQgYmluZGluZyBkb2N1bWVudHMuDQo+IC0gRml4IGNoZWNrcGF0Y2ggaXNzdWVzLg0K
PiANCj4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gLSBSZWJhc2VkIHRvIHY1LjExLXJjMSBhbmQgcmV0
ZXN0Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gLSBBZGQgUmV2aWV3ZWQtYnk6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IHRhZyBpbiBkdC1iaW5kaW5ncw0KPiAgIHBhdGNoLg0K
PiAtIFJlbW92ZSB0aGUga2VlbWJheV9wY2llX3tyZWFkbCx3cml0ZWx9IHdyYXBwZXJzLiBBbmQg
cmVwbGFjZSB0aGVtIHdpdGgNCj4gICByZWFkbCgpIGFuZCB3cml0ZWwoKS4NCj4gLSBSZW1vdmUg
dGhlIGRlYWQgY29kZSByZWxhdGVkIHRvIHVudXNlZCBpcnFzLg0KPiAtIFJlbW92ZSB1bnVzZWQg
ZGVmaW5pdGlvbiBmb3IgdW51c2VkIGlycXMuDQo+IC0gSW4ga2VlbWJheV9wY2llX2VwX2luaXQo
KSwgaW5pdGlhbGl6ZSBlbmFibGVkIGludGVycnVwdHMgdG8ga25vd24gc3RhdGUuDQo+IC0gUmVi
YXNlZCB0byBuZXh0LTIwMjAxMjE1Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gLSBJbiBr
ZWVtYmF5X3BjaWVfcHJvYmUoKSwgdXNlIHJldHVybiBrZWVtYmF5X3BjaWVfYWRkX3BjaWVfcG9y
dChwY2llLA0KPiAgIHBkZXYpOyBzdGF0ZW1lbnQgYW5kIHJlbW92ZSByZXR1cm4gMDsgYXQgdGhl
IGVuZCBvZiB0aGUgZnVuY3Rpb24uDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtIEluIGR0
LWJpbmRpbmdzIHBhdGNoLg0KPiAgIC0gRml4ZWQgaW5kZW50IHdhcm5pbmcgZm9yIGNvbXBhdGli
bGUgcHJvcGVydHkuDQo+ICAgLSBSZW5hbWUgaW50ZXJydXB0LW5hbWVzIHRvIHBjaWUsIHBjaWVf
ZXYsIHBjaWVfZXJyIGFuZA0KPiAgICAgcGNpZV9tZW1fYWNjZXNzLCBzaW1pbGFyIHRvIHRoZSBu
YW1lIHVzZWQgaW4gZGF0YXNoZWV0Lg0KPiAgIC0gUmVtb3ZlIGRldmljZV90eXBlLCAjYWRkcmVz
cy1jZWxscyBhbmQgI3NpemUtY2VsbHMgcHJvcGVydHkuDQo+ICAgLSBSZW1vdmUgbnVtLXZpZXdw
b3J0LCBudW0taWItd2luZG93cyBhbmQgbnVtLW9iLXdpbmRvd3MgcHJvcGVydHkuDQo+ICAgLSBS
ZXBsYWNlIGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHdpdGggdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzLCBm
b3IgUkMNCj4gICAgIG9ubHkuDQo+ICAgLSBBZGQgZGJpMiBhbmQgYXR1IHByb3BlcnR5Lg0KPiAg
IC0gUmVtb3ZlIGRlc2NyaXB0aW9uIGZvciByZWdzIGFuZCBpbnRlcnJ1cHRzIHByb3BlcnR5Lg0K
PiAgIC0gQ2hhbmdlIGVudW0gdmFsdWUgZm9yIG51bS1sYW5lcyB0byAxIGFuZCAyIG9ubHkuDQo+
IC0gSW4gZHJpdmVyIHBhdGNoLg0KPiAgIC0gSW4gS2NvbmZpZyBmaWxlLCByZW1vdmUgZGVwZW5k
ZW5jeSBvbiBBUk02NC4NCj4gICAtIEFkZCBuZXcgZGVmaW5lLCBQQ0lFX1JFR1NfUENJRV9TSUlf
TElOS19VUC4NCj4gICAtIFJlbW92ZSBQQ0lFX0RCSTJfTUFTSy4NCj4gICAtIEluIHN0cnVjdCBr
ZWVtYmF5X3BjaWUsIGRlY2xhcmUgcGNpIG1lbWJlciBhcyBzdHJ1Y3QsIG5vdCBwb2ludGVyLg0K
PiAgICAgQW5kIHJlbW92ZSBpcnEgbnVtYmVyIG1lbWJlcnMuDQo+ICAgLSBSZW5hbWUgYW5kIHJl
d29yayBrZWVtYmF5X3BjaWVfZXN0YWJsaXNoX2xpbmsoKSwgdG8NCj4gICAgIGtlZW1iYXlfcGNp
ZV9zdGFydF9saW5rKCkuDQo+ICAgLSBSZW1vdmUgdW5uZWVkZWQgQkFSIGRpc2FibGUgc3RlcHMu
DQo+ICAgLSBSZW1vdmUgdW51c2VkIGludGVycnVwdCBoYW5kbGVyczsga2VlbWJheV9wY2llX2V2
X2lycV9oYW5kbGVyKCksDQo+ICAgICBrZWVtYmF5X3BjaWVfZXJyX2lycV9oYW5kbGVyKCkuDQo+
ICAgLSBSZW1vdmUga2VlbWJheV9wY2llX2VuYWJsZV9pbnRlcnJ1cHRzKCkuDQo+ICAgLSBSZXdv
cmsga2VlbWJheV9wY2llX3NldHVwX2lycSgpIGFuZCBjYWxsIGl0IGZyb20NCj4gICAgIGtlZW1i
YXlfcGNpZV9wcm9iZSgpLg0KPiAgIC0gUmVtb3ZlIGtlZW1iYXlfcGNpZV9ob3N0X2luaXQoKSBh
bmQgbWFrZSBrZWVtYmF5X3BjaWVfaG9zdF9vcHMNCj4gICAgIGVtcHR5Lg0KPiAgIC0gS2VlcCBh
bmQgcmV3b3JrIGtlZW1iYXlfcGNpZV9hZGRfcGNpZV9wb3J0KCkgYSBsaXR0bGUuDQo+ICAgLSBS
ZW1vdmUga2VlbWJheV9wY2llX2FkZF9wY2llX2VwKCkgYW5kIGNhbGwgZHdfcGNpZV9lcF9pbml0
KCkgZnJvbQ0KPiAgICAga2VlbWJheV9wY2llX3Byb2JlKCkuDQo+ICAgLSBJbiBrZWVtYmF5X3Bj
aWVfcHJvYmUoKSwgcmVtb3ZlIGRiaSBzZXR1cCBhcyBpdCB3aWxsIGJlIGhhbmRsZWQgaW4NCj4g
ICAgIGR3YyBjb21tb24gY29kZS4NCj4gICAtIEluIGtlZW1iYXlfcGNpZV9saW5rX3VwKCksIHVz
ZSByZXR1cm4gKHZhbCAmDQo+ICAgICBQQ0lFX1JFR1NfUENJRV9TSUlfTElOS19VUCkgPT0gUENJ
RV9SRUdTX1BDSUVfU0lJX0xJTktfVVAuDQo+ICAgLSBJbiBrZWVtYmF5X3BjaWVfZXBfcmFpc2Vf
aXJxKCksIHJld29yayBlcnJvciBtZXNzYWdlIGZvcg0KPiAgICAgUENJX0VQQ19JUlFfTEVHQUNZ
IGFuZCBkZWZhdWx0IGNhc2VzLg0KPiAtIFJlYmFzZWQgdG8gbmV4dC0yMDIwMTEyNCwgdGhhdCBo
YXMgZHdjIHBjaSByZWZhY3RvcmluZywNCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1wY2kvMjAyMDExMDUyMTExNTkuMTgxNDQ4NS0xLQ0KPiByb2JoQGtlcm5lbC5vcmcvLg0KPiAN
Cj4gU3Jpa2FudGggVGhva2FsYSAoMik6DQo+ICAgZHQtYmluZGluZ3M6IFBDSTogQWRkIEludGVs
IEtlZW0gQmF5IFBDSWUgY29udHJvbGxlcg0KPiAgIFBDSToga2VlbWJheTogQWRkIHN1cHBvcnQg
Zm9yIEludGVsIEtlZW0gQmF5DQo+IA0KPiAgLi4uL2JpbmRpbmdzL3BjaS9pbnRlbCxrZWVtYmF5
LXBjaWUtZXAueWFtbCAgIHwgIDY5ICsrKw0KPiAgLi4uL2JpbmRpbmdzL3BjaS9pbnRlbCxrZWVt
YmF5LXBjaWUueWFtbCAgICAgIHwgIDk3ICsrKysNCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9LY29uZmlnICAgICAgICAgICAgfCAgMjggKysNCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL01ha2VmaWxlICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWtlZW1iYXkuYyAgICAgfCA0NTEgKysrKysrKysrKysrKysrKysrDQo+ICA2
IGZpbGVzIGNoYW5nZWQsIDY1MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9pbnRlbCxrZWVtYmF5LQ0KPiBw
Y2llLWVwLnlhbWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL2ludGVsLGtlZW1iYXktDQo+IHBjaWUueWFtbA0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5jDQo+IA0K
PiANCj4gYmFzZS1jb21taXQ6IDYxNDEyNGJlYTc3ZTQ1MmFhNmRmN2E4NzE0ZThiYzgyMGI0ODk5
MjINCj4gLS0NCj4gMi4xNy4xDQoNCg==
