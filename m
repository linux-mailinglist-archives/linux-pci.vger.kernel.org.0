Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE83EE4C0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 05:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhHQDEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 23:04:23 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:14560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237018AbhHQDEW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 23:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IefcSTA0ymnPPDixsI7qqKW823ceq28m27fl9ZJ+vVpzKDG4G9b+rSR6PItx81ouwdWrxziZraRg+mYfYgQi7jxvQ3B6hWoaO5Bgj2TJyqnKl90jAfUBw+IdFp6+tBPkVt1Ivg5wBFfOc6b3sXBY6rZz9vNYMP7ekW159ABTE8MiGc9UQbNk3unXcLC+FjHUNMCrcdPftyGYvIk6wdyhT999XrIWAREwFIaAeFKS4oZGYAlU0aFAn3Av+cUb9XASngJShvkWZqF4p1ksfXrFwr+LmTqN1UW4CIGkl2APTL/j3bHjmsZLpZy/KjWWEMY4LO8YrpdSr/NfTzWBQujmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNdrIwBMjiThNq2c+7sGFFz7O9+B71Nn0ME+RRsYMRc=;
 b=LFZqAHUuAhgTvtlaDjxsLCB3LI4Vx8UUuFsmxYo+jOjmkPV9NuAfBXp0VAdhbU+F/cgNj+PlnFBZC7qkVK776iOgJQaC1ixewXxIUrDe/YL9NfixKjai3AloS5e4nIOcJxj5FOc3lObBDwsbDhySrCJhsiXrRxIW8RQYMr4SpKvuTQHqINlCBybJUgYYd5gEFFKNCLzzrbsZOZqLsb7uQGjVGGhNDQ9aKfdaGHvWHXarQx+v0lFWot2FXwnbpkukZnrTZW7cl45dfUQ6KWJ6s/9XM5Ew7FVqyu2uXQAEhmaAKDg6oOrNDakneeip8VB7T4ziW4Et7jSl7P8wARHdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNdrIwBMjiThNq2c+7sGFFz7O9+B71Nn0ME+RRsYMRc=;
 b=bxkLkr8lsp1H7GT/2SuNWO+C0dqrJLiQDcaQouGu/+VN0gsbjxptR2RHMH57gC+t8NuNTU9bH1HtYbyozcMQWdfV6co1SOSn5PCUmq3gTM9blRjs/XfehbDN3bJmhlyewC84tOjYfzsQEEasbvU/koHVM9m3p9MSPtKQHh+uPAV6ZXfB+M8aQ3o7g19BaYtiS1LiGuPIoyEykxO1S2XGN0n4KKC/jMd/0hL4SpRpmALod8QusB1dt2ayo9SBlvQgTiSg63PWeKtdrsN6Tccw5dertlusz0LjbICcurEh8OagaYPslgrOYSdCZ4KK3NqcI0FrQ/L6MhwtZH0tINj2bA==
Received: from DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) by
 DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Tue, 17 Aug 2021 03:03:49 +0000
Received: from DM5PR12MB2534.namprd12.prod.outlook.com
 ([fe80::5120:d8f9:95c2:c1f1]) by DM5PR12MB2534.namprd12.prod.outlook.com
 ([fe80::5120:d8f9:95c2:c1f1%4]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 03:03:49 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Chris Browy <cbrowy@avery-design.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: RE: CXL Hot and Warm Reset Testing
Thread-Topic: CXL Hot and Warm Reset Testing
Thread-Index: AQHXjtfrDArBRCuetkSyTwwpxulViatvD4aAgAKZddCAAAalgIAARsWAgAUUVZA=
Date:   Tue, 17 Aug 2021 03:03:49 +0000
Message-ID: <DM5PR12MB25343F17E1583FF35A69AA8ABDFE9@DM5PR12MB2534.namprd12.prod.outlook.com>
References: <DM5PR12MB2534D383B0226498DD7F2005BDFA9@DM5PR12MB2534.namprd12.prod.outlook.com>
 <20210813171421.GA2593219@bjorn-Precision-5520>
 <CAPcyv4gQz7EBkvPdu_y8hBqQ_S12B5cAz4x42C1mx7dsBXKV9w@mail.gmail.com>
In-Reply-To: <CAPcyv4gQz7EBkvPdu_y8hBqQ_S12B5cAz4x42C1mx7dsBXKV9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acb87c10-f3f2-4516-fc85-08d9612ba2cb
x-ms-traffictypediagnostic: DM6PR12MB3482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB348271CC924A41053DAC3E6EBDFE9@DM6PR12MB3482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNWrt3njfXyq73r2mIBVr0TcPIqqNQ2v/Zo+XeD9lHK+IB/LZJG/KhWsaukDj1Xru39eqoQ7gDoAM5r0Mgl7rVzau2hbyi74HpkDg//c2eHfUbhgmuZuJRcoep7kN4bfIvLoGeem3mENz9DZ+PzSiMuBeik5iQgkb9a3bri4z7Zj87Pbv5nWMkh2of9SWSvdtPOi4TviyyeIMK5cY894PXM09Dvm8o5wjQ/q1nQwBRDYabpwA45LtKfvkvnGkuiW+7P0EtoSeiEsey7TtA7jya1XOdpgeg5r/mP8HYJKFDGoEk2JK1e1i4QMwfNgbYrr7xyJN3K3PlS0/I0NU6TD33HCmzwgItUJQKzo+iAxveDu8OQIvA3w+L3/aBgf70gaRCvTIeZaKbVhCtFUChB+GMhpDsw9vD5dZdSrAhKu+SIkpclP7Oy4GsY7aT2S45WlVpeBcALwRwJYMR1eVv7vFSlnuZoVdLIbZB+mbMZb+x8BN+twjDwu+KVWZOuL1mn76N4AzEkOohaTSyIsbxX8Xmimm353SLhu4m+FeDCZvU7wRACaX+njH2a4m4B6ZClDUJoCqpC2XJ+FB2MYitRnzyNhDsZ7Kr536vU86vpeRZvcY4m/Ry8BbQm/RxJCgZhKjolRJUTVlsCNR0ArmXLR2Af0tDNOc0Fz4u61lEPkmcH0cI0VyV9/oHAtORBivdYC0VJS8qavEVshTiIhIaf6oKArCGn35PBhR36LLViZgiJFcZ1GOVjWQsUzCXd73i3cLJlmu6+FFLTblogZ/xA77QJ8S/+peLfmc6mkjXT8RJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(54906003)(26005)(9686003)(2906002)(316002)(33656002)(8676002)(478600001)(5660300002)(52536014)(110136005)(122000001)(71200400001)(7696005)(76116006)(66946007)(38100700002)(38070700005)(83380400001)(7416002)(186003)(6506007)(53546011)(86362001)(4326008)(66446008)(55016002)(8936002)(64756008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmI5bzBtTUlLekFRVnk4MkJXdWdLMDhscEp2Q0xQWWExU20yYmI1ZkpVTFNj?=
 =?utf-8?B?U1dJcU5mejVPdDFSdWVZczhPQVVnNG9Vc1NiQVdDcURJaFBNd2ViMFpVeHRq?=
 =?utf-8?B?S3gxTE0ydEg3YUR4aHdXOStwRkcxUzBGSWZPb1dqamJXOStqamJiNHdrTUph?=
 =?utf-8?B?ME1CSHVPaDA2VUI5QlNNWGYvbVdJSnI5eW15SUxnL2ZHbC9mKzYzWEl4UUhR?=
 =?utf-8?B?Y25kTnVWRFNzQXNLS3MxTVVybnBqZkNuaEcxdVFJbzVpYXlXdkFQdzMrTTFF?=
 =?utf-8?B?QVlPZUZBcFhlbXU3OXFVZG9QYzNqTlQzYVFoWklXelMxUHdBam5MM2g3bUVH?=
 =?utf-8?B?cWNWVU5oK2R3eVkrem1VZXFhTjRVV203Ui84YTJsbWZSejdaYlE0UmhFYUNz?=
 =?utf-8?B?VlE0V05ZTW1USnF4ZFFyb3NHY3ptSzcxSnJtUWgxR3RpbU1Ed0ExcGh5QU81?=
 =?utf-8?B?UDlRckVOL1d2Ui9IUXp0bFl1TC9VVHQ0SjBBdGZSbURaNW1QM1p5VU52ZERz?=
 =?utf-8?B?cDRBV3htQnBtWlgzak9neEJFOEc4azhuNWFxNjVYbUswUjhXYno3UGYyQlZT?=
 =?utf-8?B?MVJBSjJYcjdxRmd0UFRFUWNPWklSbjZBWi9OSitlekYyTDlVT1VRcWlQZkY4?=
 =?utf-8?B?bUtFNE5WYThubTdhZjAwMXJocVRnenBYYWt5alhPYjlmdk1BR3dMV29tRWkr?=
 =?utf-8?B?RHF2WnJraTBxdXpyY1ZBSnhOYnpLQVQ5U3lsUi92eDgySFlqUE5GRHQ0NnFp?=
 =?utf-8?B?U3dQY1ZuZk53U2VTbUlXNFpVOW93TkNsQzJJZkI1YzZoK2hId0dtZ3k2L0h0?=
 =?utf-8?B?ck1KeEhMeStOTFB1dE95UE1tMXR3bno5eUVjYk5wdUt4TW9kcjFKSk1BbEov?=
 =?utf-8?B?aWwxTWl0cUlZcWU5MjBvWXpoN1MrSjZYdkNHNytwdWR6TDJqT2Jib0NkbUMv?=
 =?utf-8?B?dmhaUjJVNGprNHBxQkRIYmc4MVdWWGh0T0NYRkd3Y2VhTTZXRWY3djN4L1Jz?=
 =?utf-8?B?a1piUGxSLys1eXFNTDZpVnlha3dCdHpqcTNwM3MwMXF5NityMFk0UEJBeThq?=
 =?utf-8?B?eUczcllzT0UrZVRwQU9PUzZ6QXN5aWFMb1hxVGhsZWhqcUhOdnFLaFNoYlZR?=
 =?utf-8?B?MGFTaXFGL2FGZ0hIUkp1U3VyR1FIZ3hwZnpaWjVabEdzSVNOVnhoL1YrS2Iy?=
 =?utf-8?B?cWZ1N0VUVDlPRU9zallvMU1PTFovbFZCUWZIbzdhQlUyTjdPbVNtSFRQcDhx?=
 =?utf-8?B?NnpGK0RPdDlrSGJTWHFvTFlzMlJXbG1NdzZqM1F4dSt0TkpQN3NwY09IWHFC?=
 =?utf-8?B?K2tBVXkzdTZML2hvQWM1YWFzVGkrcmNmNnhaa0Q2VUhvWlpCNjlpZVNTU2kw?=
 =?utf-8?B?OGwrOW1xQ0x2c09YTjVwMW1EM2VkbkhWL3JCUmt6aTArVDJGdUZacFhoQURa?=
 =?utf-8?B?YXU4NDBFdXVNbXk0QlFHWDh2eHFpK0JxeExjY1JGUiszalBPTjJ2dlEvd1RR?=
 =?utf-8?B?dGhrY1hKUXhuMzh4czRaR1IxOGd1ZHUxMmhsdldWaHc3d01rREhRZy94U0FY?=
 =?utf-8?B?aUxXNFNVWkJTaEMzYVd6MGVVb0xOYTdPeUczV2dyYjlHcE44VXJhcHFGVW5C?=
 =?utf-8?B?RStwYVdsRDNIbWxLZWxPbkFOazI3YXV6OHd2eit4SmgwWmZaR2prc290akFa?=
 =?utf-8?B?MFRDY1BVYTgyUExINHVIVUU5cVExVlVFYURGMFJBWFdrbFRtYVJvNGp4dkow?=
 =?utf-8?Q?0C596+BMWoOHbZbD7RWpTyJkmngSADKkmqYZiI+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb87c10-f3f2-4516-fc85-08d9612ba2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 03:03:49.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XjH4EwZSU0mPxXwJwWtqqFOYuAqzTaO3tj8ZuLjKWvI6qhg/8wqMk1RsL1RByLWcVYG2cDUOSSTP8MFcqYBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBPbiBGcmksIEF1ZyAxMywgMjAyMSBhdCAxMDoxNCBB
TSBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gWytj
YyBBbWV5ICh3b3JraW5nIG9uIFBDSSByZXNldHMpLCBsaW51eC1wY2ldDQo+ID4NCj4gPiBPbiBG
cmksIEF1ZyAxMywgMjAyMSBhdCAwNTowMTozMlBNICswMDAwLCBWaWtyYW0gU2V0aGkgd3JvdGU6
DQo+ID4gPiBIaSBEYW4sDQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gPiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4N
Cj4gPiA+ID4NCj4gPiA+ID4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgOTo0MiBBTSBDaHJpcyBC
cm93eQ0KPiA+ID4gPiA8Y2Jyb3d5QGF2ZXJ5LWRlc2lnbi5jb20+DQo+ID4gPiA+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8kZGV2aWNlL3Jlc2V0IGlzIGEg
bWV0aG9kIHRvIHRyaWdnZXIgUENJDQo+ID4gPiA+IGRldmljZSByZXNldCwgYnV0IEkgZG8gbm90
IGV4cGVjdCB0aGF0IHdpbGwgZXZlciBnYWluIENYTCBzcGVjaWZpYw0KPiA+ID4gPiBrbm93bGVk
Z2UuDQo+ID4gPiA+DQo+ID4gPiBDWEwgcmVzZXQgbWF5IG5lZWQgc29tZSB0aG91Z2h0LCBzcGVj
aWFsbHkgZm9yIGRldmljZXMgdGhhdCBkb24ndA0KPiA+ID4gZXhwb3NlIEZMUiBidXQgZG8gZXhw
b3NlIENYTCByZXNldCAod2hpbGUgZm9ybWVyIGRvZXMgbm90IGFmZmVjdA0KPiA+ID4gQ1hMLmNh
Y2hlL21lbSwgdGhlIGxhdHRlciB3aXBlcyBvdXQgQ1hMLmNhY2hlL21lbSBzdGF0ZSBpbiB0aGUN
Cj4gPiA+IGRldmljZSBhbmQgdGhlcmUgaXMgZGlzY292ZXJhYmlsaXR5IGFzIHRvIHdoZXRoZXIg
b3Igbm90IG1lbW9yeQ0KPiA+ID4gY29udGVudHMgY2FuIGJlIGNsZWFyZWQgYXMgcGFydCBvZiBD
WEwgcmVzZXQpLiBXZSBtYXkgbmVlZCBhIHdheSBvZg0KPiA+ID4gdHJpZ2dlcmluZyBDWEwgcmVz
ZXQgZnJvbSB1c2Vyc3BhY2UsIGFuZCBpZiB0aGUgZXhpc3RpbmcNCj4gPiA+IC9zeXMvYnVzL3Bj
aS9kZXZpY2VzLyRkZXZpY2UvcmVzZXQgd29uJ3QgaGF2ZSBrbm93bGVkZ2Ugb2YgQ1hMDQo+ID4g
PiByZXNldCwgdGhlcmUgc3RpbGwgc2hvdWxkIGJlIGEgcHJpb3JpdGl6ZWQgb3JkZXIgaW4gdGhl
IGtlcm5lbCBpbg0KPiA+ID4gd2hpY2ggQ1hMIHJlc2V0IGlzIGF0dGVtcHRlZCBiZWZvcmUgbW9y
ZSBkcmFzdGljIHJlc2V0cyBsaWtlIFNCUi4NCj4gPiA+IElJUkMgQ1hMIHJlc2V0IGNhbiBhbHNv
IGltcGFjdCBhbGwgZnVuY3Rpb25zIHRoYXQgdXNlIENYTC5jYWNoZS9tZW0sDQo+ID4gPiBidXQg
bm90IGxlZ2FjeSBQQ0llIGZ1bmN0aW9ucyBvbiB0aGUgZGV2aWNlIHdoaWNoIGRvIG5vdCB1c2UN
Cj4gPiA+IENYTC5jYWNoZS9tZW0gKHRoZXJlIGlzIGRpc2NvdmVyYWJpbGl0eSBhcyB0byB3aGlj
aCBmdW5jdGlvbnMgYXJlDQo+ID4gPiBub3QgaW1wYWN0ZWQgYnkgQ1hMIHJlc2V0KS4NCj4gDQo+
IFdoYXQncyB0aGUgTGludXggdXNlIGNhc2UgZm9yIHN1cHBvcnRpbmcgQ1hMIHJlc2V0IGZvciBh
IENYTCBtZW1vcnkNCj4gZXhwYW5kZXI/IFBDSSByZXNldCBpcyB1c2VmdWwgZm9yIGRldmljZSBh
c3NpZ25tZW50LCBhbmQgQ1hMIHJlc2V0IG1pZ2h0IGJlDQo+IHVzZWZ1bCBmb3Igc2ltaWxhcmx5
IGFzc2lnbmluZyBhbiBhY2NlbGVyYXRvci4gQ1hMLm1lbSBvbiB0aGUgb3RoZXIgaGFuZCBjYW4N
Cj4gYmUgZGlyZWN0bHkgYXNzaWduZWQgYXQgYSBwZXItcGFnZSBsZXZlbCB3aXRob3V0IGFsc28g
bmVlZGluZyB0byBhc3NpZ24gdGhlDQo+IGRldmljZS4gSG93IGNvdWxkIGEgVk0gcmVsaWFibHkg
cHJvZ3JhbSBIRE0gZGVjb2RlcnMgd2hlbiBpdCBjYW5ub3QNCj4gcGVyY2VpdmUgdGhlIGhvc3Qg
cGh5c2ljYWwgYWRkcmVzcyBzcGFjZT8gSSB1bmRlcnN0YW5kIHRoZSB1dGlsaXR5IG9mIENYTA0K
PiByZXNldCBmb3IgZGV2aWNlIGJyaW5nLXVwIGFuZCB0ZXN0IHNvZnR3YXJlIHRoYXQga25vd3Mg
d2hhdCBpdCBpcyBkb2luZyBjYW4NCj4gd3JpdGUgY29uZmlnIHNwYWNlIGRpcmVjdGx5LCBidXQg
dGhhdCBzb2Z0d2FyZSB3b3VsZCBhc3N1bWUgYWxsIHJlc3BvbnNpYmlsaXR5Lg0KDQpBZ3JlZSB0
aGF0IENYTCByZXNldCB3aWxsIGJlIG5lZWRlZCBmb3IgdHlwZTEvMiBDWEwgZGV2aWNlcyAoYWNj
ZWxlcmF0b3JzKSANCndoaWNoIHdpbGwgbmVlZCBhIHN5c2ZzIGludGVyZmFjZSBmb3IgdXNlcnNw
YWNlIHRvIHVzZSBDWEwgcmVzZXQuIA0KIA0KDQo=
