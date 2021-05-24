Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3FD38E0BA
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 07:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhEXFz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 01:55:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:29927 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhEXFzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 01:55:25 -0400
IronPort-SDR: 9TCWjB8KZFYWhze5U5mkXV80qqyazTFlQ0mBqS5Fs/ls9/C/XBMT0//x7sRzgQSuizDgPjZ/Mn
 DhQmbu8IY+cQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="198802377"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198802377"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 22:53:57 -0700
IronPort-SDR: UQqBmGPCtX1sc0hK9TlqtvG3tmZyoEbWIYQLTa48GnYzSxNniOXLM9Ffw8uA7D/JHShuAfNLK/
 Ek/9wRzESmDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="632508884"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 23 May 2021 22:53:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 23 May 2021 22:53:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 23 May 2021 22:53:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 23 May 2021 22:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS5Am2WTTUM45DKU/gCBiHZVhQkj7tQd29Zm7VWfgoE6blvUdJAt/bI/guInlkKl3TXOoJABAsLpMHHa9IPQgPrCRNRz+faG0NayGTNqHKY3eu/QGxZM/dPpDAYUpG21MPcpDp92BCSqt+QTpN6enq929g7FQMwhPpqDXSH6zUqXF5ns5OD4s3A+Pl5a3togiCcp6+GTRfzs/gDUICZKi2ugjihxVW1WMIRXKkxXM4/UaQ3HAxzvDAnxseS3ydW4GqblbBkUR87qCrbJRDIgs8MnlJgIjORcShp42sJZ0hzMSpdOv9zlXPStAVJ9dfToRMMLqm4AwebTNZpGVnKWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxuTmd0RzAT9ueF1VtCEs1nhULx6OCMVyX2n/WzPYis=;
 b=cS1hEPoPjJa3FkPs34vJy2i7bdpVVp2+4M43GMTzoCubzLcnTIG9VqukAAUa3Hsz9NfeQCJU9X5c07poTBajVMBneVYbX8nQvKrG+rBX6TJKadNNBrqEDhhfzw4i/OEtXO8kBXC4jkqLQlOnISXtLLNYQgL4OVvmLlTgjDp3M2KsG5QQrmQbpQVcHS+N1YRVq0ZcHyNQMgGEv3MauLjXKFYROYJGKzX9LdFA7nJMoqHMJdMoJuANzvMQHNT/1XYviSTRDHA3vx6PkAhImq2wUuVo/45gzf1GYtTGUFoFi7tc/g0kcVroKHVmEO8nb+xPaphR6CWEQAg/uX84717uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxuTmd0RzAT9ueF1VtCEs1nhULx6OCMVyX2n/WzPYis=;
 b=utlU6FLiDk36uOrX5vgi3Aiz4gaEoge71xubA19FkXXm47/nU2jL4REXiK9KStsrC3GKthk6y1MBnAvtc5VgXBaYFOBkXNsb/IWMb2MjXGBgAvWk/DdTGOFVXzWv/r0/9ciyC4i01hiLj6g1W6noiQG3hWFrMMtuQ7y0nQnFAAE=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5675.namprd11.prod.outlook.com (2603:10b6:510:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 05:53:54 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::e07a:5095:a1a3:2667]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::e07a:5095:a1a3:2667%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 05:53:53 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
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
Subject: RE: [PATCH v9 0/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v9 0/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXS7Ry6Yi/5DLcvEyVHY65Q1dIJ6ryKrNw
Date:   Mon, 24 May 2021 05:53:53 +0000
Message-ID: <PH0PR11MB559577104A13F8DCA429B4D485269@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210518150050.7427-1-srikanth.thokala@intel.com>
In-Reply-To: <20210518150050.7427-1-srikanth.thokala@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [136.185.183.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e06c8383-0098-4410-dfb4-08d91e785030
x-ms-traffictypediagnostic: PH0PR11MB5675:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB567541C3B6BD39ECD877123885269@PH0PR11MB5675.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNlkZfb6IEjmy3Cb2MNLdIesGmKGKEUxtQjCny2+GdRWFQHjNCaa192uCOZRF08StuvjkW7gKpdWHeH+EigExgtWjA0KFa9wPM/8lx2uo+tWMIGlwnIlXpO6o0RX84FOyd0Xe64YZdXVb56gN/vAVqPx2gcM4TgpQ8+X7cB5Vt7gvdVjZCcmJHfeSh10BVtsbpWjlrh0b3siv3/Uj6DxhODEUopJtwIB2AeEf3TyF0SwLWFmGnfjMP9q4ApsXTUB7lZsW1Lq9G9I4QJPE7bk3a6yX2uBcsw1/mTBbDocBvRkVeNEiCyACIWS25wU0VldmZjEf8yhVwHOhLo/nisVeyj/X9Xg+EGRdyeUcweAGl2uxwVIVVjnljwmr0Fi9us9IhaFgbPUJm+wSxCVpEzMs30aE9hfrXoABkfQcVwIbGXkBIJOk9bB9lVqJI5qDnBLeqkV6nbhq57DgsEAfRZWvLbjKI2zg8UekPcLYcgWE4fpatcqId0bQAp+rlfjrMYqn8FBpNu9RVJ+h8FoeCvDMl/wk3vmpaJJLqB3+APZtcV6XgSszApTX0gz4bZxsvSjZ41cvBplFd/h8Pz06xXLqS6qSJHLY5Y0p9hHR0Ldi14bbb4DC7+DdKLc/w3wdKt4i5p3jQtDtc1byk+DOl+ErswyDJil92HlYHuD3SC+4VJ/JLFdCQdx14e7WDYW+6n4/LuZwNX/qw68e3qtOU88XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(966005)(76116006)(66476007)(33656002)(186003)(8936002)(9686003)(66556008)(66446008)(7696005)(110136005)(478600001)(83380400001)(54906003)(66946007)(64756008)(38100700002)(26005)(122000001)(316002)(66574015)(2906002)(6506007)(4326008)(86362001)(52536014)(55016002)(71200400001)(5660300002)(53546011)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UWhJYzNuSEl1RkE0Q1RxR2R6MkFrUUltMFFkclpzTEI0SDhkVWJOT1VxRjdx?=
 =?utf-8?B?VTNEMlh3OVIxMWtZMGVNa1Vmcnplc0JOYUIvY05xajBJSkJNT0ZGcGY2Titx?=
 =?utf-8?B?S0YwZC9wbmlQL0xhb2xzZkJFeTNoLzNZS2oyMS83enFTLzFmQVROd2hLZ2tZ?=
 =?utf-8?B?bHRmSXZXamYvQ0tFNGNEM25laXloOHZmTGwvNWFkTCtyVkpaVVQzcWd5RXg5?=
 =?utf-8?B?NnJjcUx5WHdQRTFIUE9NMkVyQ2g2KzlnbTNrN2MwYkVTeTNnVlFWZy83MEZL?=
 =?utf-8?B?a20rQVUxSlVsYXptUUs1YUdWRXdrZmJhdUhhM0lkRHlUbUNOVEQ2c1lHMjFP?=
 =?utf-8?B?ZHo0NC9BVUhpVnBqVlFacWpub3Npc0crNjV2elBRRkN4aEhPT2tZYTJrQVdH?=
 =?utf-8?B?REx5ODF5TFhtR3FhcXRoVGxDSzhlb3BlcEFGcDd2ei9kUVdpS2F0RmZFK293?=
 =?utf-8?B?aU45ZnJJZVJ4Q3dJVzhWUURmUHVISlYwMGE1VWxkeUFZem5kRTVCWnVkaHBP?=
 =?utf-8?B?cFNFSnZ0dFhFNFp0S1lidzJLYVU1VE1hbmIvR3M1Vko4Z1VmWXBoQktkRXEy?=
 =?utf-8?B?Q0hobnVLNnlIY1YyVTNKUEF4Lzd3Si82dm93K29IWGFQM3lXNGljSTNkOWIv?=
 =?utf-8?B?bzlsaGpCRmtwYXY5VFU2Wm5SZWVJMCtvVWo3RXdFSzUwMnJsaVE2REpoTXV5?=
 =?utf-8?B?VnNkeG1Jc0YvemQxY3FnbzdVeHpSQi83WlNSNFdYNVpoWXAvRmhZNXNzM1BM?=
 =?utf-8?B?QWQ3eGx3cmNDN3VWVHZFTmlKUTY4TGk5ZmE1WjdpbmN5dkxXUjVLNlM2WVky?=
 =?utf-8?B?UC93S3NLeW5wL1g3RjA3ekp4RklrZE9hS0lKdERaRVhaSytYYjJUMTkzY3du?=
 =?utf-8?B?ZFVkOGk2NFR3YTU3Zk5UMHZiaWtJRGk3M0VaUzVXam1jVGNqS1lQaDBpaEFh?=
 =?utf-8?B?Z2l6cGpyci9zY1llaTVVR3dJRjExdVBuckpkOS9BWVhZeHA4MFZqS0hzZGNM?=
 =?utf-8?B?TnVpcGNBK2xDUU1BQWVad2hvQjNHRUFtZ0hXZ25pdE1adXNDbStzTmdsRHI4?=
 =?utf-8?B?bVIwVGlqczZZTk8zOUdrWGo3NmFQemdja2ZHaHB2K2FoeS9scHBMbi9lRVAz?=
 =?utf-8?B?eWlQZmxISi9DNEVxUGp3YlV4VlBsc20xSXZSYmgxajBUM3NRQytQRW5YeXZ4?=
 =?utf-8?B?RzF2S01ZN0poUjVueTEza0xMaUdjOXhiNnFhVnpYNGFRNDUvYVo5K2ZoeXVB?=
 =?utf-8?B?NlRFQk1CSFRJNDkzeWdQYXR0UEZaOWtiRTdpLzZVL3VEdi9keEQzVmx1NnAx?=
 =?utf-8?B?b1c5OGR0SkYvSjgwejNsZ2ZvMjRuZHdrMFhYWWdkdWRLRUxtWVhyWG1PeG9L?=
 =?utf-8?B?SXl2YitCMjhWcnQ0Y2VSdTJCWXh3dC8rTHoyYUlKWVdZb2VkRzFBK1N1RHhT?=
 =?utf-8?B?Nk1NRDFVRU5BckVnVTMrd25BQjZOOXhEcVlqblBBZWg3R3dsNWFMNXh5RGxW?=
 =?utf-8?B?cFZFaEgvYWtjVDBZekhlM3d1ZDFjcE5Eb05pY0ZqZnNYR3FaeHoyekdiZkg2?=
 =?utf-8?B?VFk4ZlBWdHZxTU5qMDVTTFVPQ29Dd3pocG5RNTV3Und2U0gyR01qMm1QWWp0?=
 =?utf-8?B?azY5eG5LWFhrM0ZKcEFCNG50WE5mRDFuRW5nRjZWNzE1QW1iZmt5Q3pvaGlw?=
 =?utf-8?B?K0FFQWhuMnM0enA5Um1FRHdpL1FyMXRKamNLWEo0UjA2Yk51Zm5PVmRlNW4r?=
 =?utf-8?Q?VMiu+Ez+omNyNswI3QFTCGMGwJi0HWU4uHLnTVL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06c8383-0098-4410-dfb4-08d91e785030
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 05:53:53.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RU6nisilG//p1aamM2Ma/Z+aAm0EF7QMj1Y6tdqYQ6a0Q0K5LPiMobVdggQFlAgtuxhiuQ9PKH617TJQEzfLBPTlSwyiYPtDe/vCOZhMJKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgYWxsLA0KDQpHZW50bGUgcmVtaW5kZXIhDQpLaW5kbHkgcmV2aWV3IHRoZSBwYXRjaCBhbmQg
Y29tbWVudCwgaWYgYW55Lg0KDQpUaGFua3MhDQpTcmlrYW50aA0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFRob2thbGEsIFNyaWthbnRoIDxzcmlrYW50aC50aG9rYWxh
QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDE4LCAyMDIxIDg6MzEgUE0NCj4gVG86
IHJvYmgrZHRAa2VybmVsLm9yZzsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsgbWdyb3NzQGxpbnV4LmludGVsLmNvbTsg
UmFqYQ0KPiBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkgPGxha3NobWkuYmFpLnJhamEuc3VicmFt
YW5pYW5AaW50ZWwuY29tPjsNCj4gU2FuZ2FubmF2YXIsIE1hbGxpa2FyanVuYXBwYSA8bWFsbGlr
YXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNvbT47DQo+IGt3QGxpbnV4LmNvbTsgVGhva2Fs
YSwgU3Jpa2FudGggPHNyaWthbnRoLnRob2thbGFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjkgMC8yXSBQQ0k6IGtlZW1iYXk6IEFkZCBzdXBwb3J0IGZvciBJbnRlbCBLZWVtIEJheQ0K
PiANCj4gRnJvbTogU3Jpa2FudGggVGhva2FsYSA8c3Jpa2FudGgudGhva2FsYUBpbnRlbC5jb20+
DQo+IA0KPiBIaSwNCj4gDQo+IFRoZSBmaXJzdCBwYXRjaCBpcyB0byBkb2N1bWVudCBEVCBiaW5k
aW5ncyBmb3IgS2VlbSBCYXkgUENJZSBjb250cm9sbGVyDQo+IGZvciBib3RoIFJvb3QgQ29tcGxl
eCBhbmQgRW5kcG9pbnQgbW9kZXMuDQo+IA0KPiBUaGUgc2Vjb25kIHBhdGNoIGlzIHRoZSBkcml2
ZXIgZmlsZSwgYSBnbHVlIGRyaXZlci4gS2VlbSBCYXkgUENJZQ0KPiBjb250cm9sbGVyIGlzIGJh
c2VkIG9uIERlc2lnbldhcmUgUENJZSBJUC4NCj4gDQo+IFRoZSBwYXRjaCB3YXMgdGVzdGVkIHdp
dGggS2VlbSBCYXkgZXZhbHVhdGlvbiBtb2R1bGUgYm9hcmQsIHdpdGggQjANCj4gc3RlcHBpbmcu
DQo+IA0KPiBLaW5kbHkgcmV2aWV3Lg0KPiANCj4gVGhhbmtzIQ0KPiBTcmlrYW50aA0KPiANCj4g
Q2hhbmdlcyBzaW5jZSB2ODoNCj4gLSBVc2UgY2hhaW5lZCBJUlEgdG8gaGFuZGxlIE1TSXMsIGFz
IHN1Z2dlc3RlZCBieSBMb3JlbnpvIFBpZXJhbGlzaS4NCj4gLSBSZW5hbWUgKl9zZXR1cF9pcnEo
KSB0byAqX3NldHVwX21zaV9pcnEoKSB0byBiZSBtb3JlIG1lYW5pbmdmdWwuDQo+IC0gTW92ZSAq
X3NldHVwX21zaV9pcnEoKSBjYWxsIHRvICpfYWRkX3BjaWVfcG9ydCgpIHRvIG1ha2UgaXQgaW52
b2tlDQo+ICAgb25seSB3aGVuIGNvbnRyb2xsZXIgaXMgaW4gUm9vdCBDb21wbGV4IG1vZGUuIElu
IEVuZHBvaW50IG1vZGUsDQo+ICAgSVJRIHdpbGwgYmUgc2V0dXAgYnkgdGhlIHJlc3BlY3RpdmUg
ZHJpdmVyIHdoaWNoIHdpbGwgYmUgYmFzZWQgb24NCj4gICBQQ0llIEVuZCBQb2ludCBGcmFtZXdv
cmsuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY3Og0KPiAtIFJlbmFtZSBrZWVtYmF5X3BjaWVfbHRz
c21fZW5hYmxlKCkgdG8gYWxpZ24gdG8gaXRzIGZ1bmN0aW9uYWxpdHkuDQo+IC0gRml4IG90aGVy
IG1pbm9yIGNvbW1lbnRzIGZyb20gIktyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29t
PiINCj4gDQo+IENoYW5nZXMgc2luY2UgdjY6DQo+IC0gQXJyYW5nZSBTb0IgaW4gY2hyb25vbG9n
aWNhbCBvcmRlci4NCj4gLSBBbHBoYWJldGl6ZWQgYW5kIG1vZGlmaWVkIHN0YXR1cyBvZiBlbnRy
eSBpbiBNQUlOVEFJTkVSUy4NCj4gLSBBZGRlZCBhIGNvbW1lbnQgdG8gc3BlY2lmeSB0aGUgUENJ
ZSBzcGVjIHNlY3Rpb24gYWJvdXQgdGhlIGRlbGF5Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NToN
Cj4gLSBSZWJhc2VkIHRvIHY1LjExLXJjNC4NCj4gLSBVcGRhdGVkIG1haW50YWluZXJzIHRvIGFk
ZCBteXNlbGYgaW4gRFQgYmluZGluZyBkb2N1bWVudHMuDQo+IC0gRml4IGNoZWNrcGF0Y2ggaXNz
dWVzLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gLSBSZWJhc2VkIHRvIHY1LjExLXJjMSBh
bmQgcmV0ZXN0Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gLSBBZGQgUmV2aWV3ZWQtYnk6
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IHRhZyBpbiBkdC1iaW5kaW5ncw0KPiAgIHBh
dGNoLg0KPiAtIFJlbW92ZSB0aGUga2VlbWJheV9wY2llX3tyZWFkbCx3cml0ZWx9IHdyYXBwZXJz
LiBBbmQgcmVwbGFjZSB0aGVtIHdpdGgNCj4gICByZWFkbCgpIGFuZCB3cml0ZWwoKS4NCj4gLSBS
ZW1vdmUgdGhlIGRlYWQgY29kZSByZWxhdGVkIHRvIHVudXNlZCBpcnFzLg0KPiAtIFJlbW92ZSB1
bnVzZWQgZGVmaW5pdGlvbiBmb3IgdW51c2VkIGlycXMuDQo+IC0gSW4ga2VlbWJheV9wY2llX2Vw
X2luaXQoKSwgaW5pdGlhbGl6ZSBlbmFibGVkIGludGVycnVwdHMgdG8ga25vd24gc3RhdGUuDQo+
IC0gUmViYXNlZCB0byBuZXh0LTIwMjAxMjE1Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4g
LSBJbiBrZWVtYmF5X3BjaWVfcHJvYmUoKSwgdXNlIHJldHVybiBrZWVtYmF5X3BjaWVfYWRkX3Bj
aWVfcG9ydChwY2llLA0KPiAgIHBkZXYpOyBzdGF0ZW1lbnQgYW5kIHJlbW92ZSByZXR1cm4gMDsg
YXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24uDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAt
IEluIGR0LWJpbmRpbmdzIHBhdGNoLg0KPiAgIC0gRml4ZWQgaW5kZW50IHdhcm5pbmcgZm9yIGNv
bXBhdGlibGUgcHJvcGVydHkuDQo+ICAgLSBSZW5hbWUgaW50ZXJydXB0LW5hbWVzIHRvIHBjaWUs
IHBjaWVfZXYsIHBjaWVfZXJyIGFuZA0KPiAgICAgcGNpZV9tZW1fYWNjZXNzLCBzaW1pbGFyIHRv
IHRoZSBuYW1lIHVzZWQgaW4gZGF0YXNoZWV0Lg0KPiAgIC0gUmVtb3ZlIGRldmljZV90eXBlLCAj
YWRkcmVzcy1jZWxscyBhbmQgI3NpemUtY2VsbHMgcHJvcGVydHkuDQo+ICAgLSBSZW1vdmUgbnVt
LXZpZXdwb3J0LCBudW0taWItd2luZG93cyBhbmQgbnVtLW9iLXdpbmRvd3MgcHJvcGVydHkuDQo+
ICAgLSBSZXBsYWNlIGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHdpdGggdW5ldmFsdWF0ZWRQcm9wZXJ0
aWVzLCBmb3IgUkMNCj4gICAgIG9ubHkuDQo+ICAgLSBBZGQgZGJpMiBhbmQgYXR1IHByb3BlcnR5
Lg0KPiAgIC0gUmVtb3ZlIGRlc2NyaXB0aW9uIGZvciByZWdzIGFuZCBpbnRlcnJ1cHRzIHByb3Bl
cnR5Lg0KPiAgIC0gQ2hhbmdlIGVudW0gdmFsdWUgZm9yIG51bS1sYW5lcyB0byAxIGFuZCAyIG9u
bHkuDQo+IC0gSW4gZHJpdmVyIHBhdGNoLg0KPiAgIC0gSW4gS2NvbmZpZyBmaWxlLCByZW1vdmUg
ZGVwZW5kZW5jeSBvbiBBUk02NC4NCj4gICAtIEFkZCBuZXcgZGVmaW5lLCBQQ0lFX1JFR1NfUENJ
RV9TSUlfTElOS19VUC4NCj4gICAtIFJlbW92ZSBQQ0lFX0RCSTJfTUFTSy4NCj4gICAtIEluIHN0
cnVjdCBrZWVtYmF5X3BjaWUsIGRlY2xhcmUgcGNpIG1lbWJlciBhcyBzdHJ1Y3QsIG5vdCBwb2lu
dGVyLg0KPiAgICAgQW5kIHJlbW92ZSBpcnEgbnVtYmVyIG1lbWJlcnMuDQo+ICAgLSBSZW5hbWUg
YW5kIHJld29yayBrZWVtYmF5X3BjaWVfZXN0YWJsaXNoX2xpbmsoKSwgdG8NCj4gICAgIGtlZW1i
YXlfcGNpZV9zdGFydF9saW5rKCkuDQo+ICAgLSBSZW1vdmUgdW5uZWVkZWQgQkFSIGRpc2FibGUg
c3RlcHMuDQo+ICAgLSBSZW1vdmUgdW51c2VkIGludGVycnVwdCBoYW5kbGVyczsga2VlbWJheV9w
Y2llX2V2X2lycV9oYW5kbGVyKCksDQo+ICAgICBrZWVtYmF5X3BjaWVfZXJyX2lycV9oYW5kbGVy
KCkuDQo+ICAgLSBSZW1vdmUga2VlbWJheV9wY2llX2VuYWJsZV9pbnRlcnJ1cHRzKCkuDQo+ICAg
LSBSZXdvcmsga2VlbWJheV9wY2llX3NldHVwX2lycSgpIGFuZCBjYWxsIGl0IGZyb20NCj4gICAg
IGtlZW1iYXlfcGNpZV9wcm9iZSgpLg0KPiAgIC0gUmVtb3ZlIGtlZW1iYXlfcGNpZV9ob3N0X2lu
aXQoKSBhbmQgbWFrZSBrZWVtYmF5X3BjaWVfaG9zdF9vcHMNCj4gICAgIGVtcHR5Lg0KPiAgIC0g
S2VlcCBhbmQgcmV3b3JrIGtlZW1iYXlfcGNpZV9hZGRfcGNpZV9wb3J0KCkgYSBsaXR0bGUuDQo+
ICAgLSBSZW1vdmUga2VlbWJheV9wY2llX2FkZF9wY2llX2VwKCkgYW5kIGNhbGwgZHdfcGNpZV9l
cF9pbml0KCkgZnJvbQ0KPiAgICAga2VlbWJheV9wY2llX3Byb2JlKCkuDQo+ICAgLSBJbiBrZWVt
YmF5X3BjaWVfcHJvYmUoKSwgcmVtb3ZlIGRiaSBzZXR1cCBhcyBpdCB3aWxsIGJlIGhhbmRsZWQg
aW4NCj4gICAgIGR3YyBjb21tb24gY29kZS4NCj4gICAtIEluIGtlZW1iYXlfcGNpZV9saW5rX3Vw
KCksIHVzZSByZXR1cm4gKHZhbCAmDQo+ICAgICBQQ0lFX1JFR1NfUENJRV9TSUlfTElOS19VUCkg
PT0gUENJRV9SRUdTX1BDSUVfU0lJX0xJTktfVVAuDQo+ICAgLSBJbiBrZWVtYmF5X3BjaWVfZXBf
cmFpc2VfaXJxKCksIHJld29yayBlcnJvciBtZXNzYWdlIGZvcg0KPiAgICAgUENJX0VQQ19JUlFf
TEVHQUNZIGFuZCBkZWZhdWx0IGNhc2VzLg0KPiAtIFJlYmFzZWQgdG8gbmV4dC0yMDIwMTEyNCwg
dGhhdCBoYXMgZHdjIHBjaSByZWZhY3RvcmluZywNCj4gICBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1wY2kvMjAyMDExMDUyMTExNTkuMTgxNDQ4NS0xLQ0KPiByb2JoQGtlcm5lbC5vcmcv
Lg0KPiANCj4gU3Jpa2FudGggVGhva2FsYSAoMik6DQo+ICAgZHQtYmluZGluZ3M6IFBDSTogQWRk
IEludGVsIEtlZW0gQmF5IFBDSWUgY29udHJvbGxlcg0KPiAgIFBDSToga2VlbWJheTogQWRkIHN1
cHBvcnQgZm9yIEludGVsIEtlZW0gQmF5DQo+IA0KPiAgLi4uL2JpbmRpbmdzL3BjaS9pbnRlbCxr
ZWVtYmF5LXBjaWUtZXAueWFtbCAgIHwgIDY5ICsrKw0KPiAgLi4uL2JpbmRpbmdzL3BjaS9pbnRl
bCxrZWVtYmF5LXBjaWUueWFtbCAgICAgIHwgIDk3ICsrKysNCj4gIE1BSU5UQUlORVJTICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9LY29uZmlnICAgICAgICAgICAgfCAgMjggKysNCj4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL01ha2VmaWxlICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWtlZW1iYXkuYyAgICAgfCA0NTEgKysrKysrKysrKysrKysrKysr
DQo+ICA2IGZpbGVzIGNoYW5nZWQsIDY1MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9pbnRlbCxrZWVtYmF5
LQ0KPiBwY2llLWVwLnlhbWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL2ludGVsLGtlZW1iYXktDQo+IHBjaWUueWFtbA0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5j
DQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDg4YjA2Mzk5YzljNzY2YzI4M2UwNzBiMDIyYjVjZWFm
YTRmNjNmMTkNCj4gLS0NCj4gMi4xNy4xDQoNCg==
