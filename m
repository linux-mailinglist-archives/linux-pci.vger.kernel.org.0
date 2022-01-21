Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F186C4963E4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349816AbiAUR0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 12:26:40 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:22731
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239235AbiAUR0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jan 2022 12:26:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPEQn9/DNff78hI+ugVed+0HKW1oWBus95j95Rfa3eJP9MY13ZB41yK1Cryp/afZ7xHOs+M4E9VMJ+46N1wfE++KOEM2lPJyWMN9ZaZBWEGSO6QSeqWrKhLtwJf1jhbFQ8QQH1xik+q8Ox+CWDxdKohojY0N7LPKxnPddf7KhBG/8KxqWH/+3yCaRlAes/Frx6sq0qh5TVaqaCXCJ3EcPkNaUHEUHb1FMmvOh21BMHPQnJV5x3T3n0aqN9F8wgJIR0Ks+BoYra7gn+O+wB4L7MzWwj3bMPUBV/Hsi0P+vLT0JzfXWMJ82lWB3LkCWMdfc9VUQz7e3gKBRobLfBsD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6/u36iSCgn2RvSCPakYhxG7EoqxjM9q51GKAIjnRhA=;
 b=foz51Z61pzTu6FAf4dxh0CNK3VVNMcA0LmlKT8//7aI5UzQIAZI2OpdC0fyD8cBYxJpIhPdT91GLcTCrLZFLcjg4ew50+IKqYGWHsgctqf0P7dwx5lDSnbrK+Sw4oAu19gw1TEzX8KZNdQ8I9BLSEf47DQWzooM+7UR7dxyAUFshYq9Q46mFye/cRqolPbXuoxPefM2yywYFO4/C/js5g+dUot6hViRSLWpmzNrE7SASHFowYd1UXl/Bqn2d/ZNBdhf2HqZI4c+Qj1mi/vv1bquvfnXqhdp5kA8jMhKzdQ1Ff763McgemO6/7k7EMpo6VGtUNE+qPPzSIOKJUgRGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6/u36iSCgn2RvSCPakYhxG7EoqxjM9q51GKAIjnRhA=;
 b=N26/jrVs0GIygmYrtCwj6cmye31MKDPIhwOcu/xF0hN8h4V4bmT2aIGCQ9r1zBD9ZU+12L0JHqKtz3u7T2I/2d5anwnlD0vEnAi9LW3MXvpb/LEDMqnlT3C4UMoMl2Pn69eA3cle1sCnohUdOqHY0gj6wNvKbt/j6G/ILvwC3MU=
Received: from PH0PR05MB8510.namprd05.prod.outlook.com (2603:10b6:510:a7::23)
 by BN7PR05MB4033.namprd05.prod.outlook.com (2603:10b6:406:90::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Fri, 21 Jan
 2022 17:26:36 +0000
Received: from PH0PR05MB8510.namprd05.prod.outlook.com
 ([fe80::5490:3d56:8317:5965]) by PH0PR05MB8510.namprd05.prod.outlook.com
 ([fe80::5490:3d56:8317:5965%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 17:26:36 +0000
From:   Vikash Bansal <bvikas@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Topic: [PATCH] PCI: Speed up device init by parsing capabilities all at
 once
Thread-Index: AQHYDI9PHjjBXmLhA0GwF8F8yaRAo6xrdBqAgAKnDoA=
Date:   Fri, 21 Jan 2022 17:26:35 +0000
Message-ID: <7E2C2648-76CE-4987-AB4F-7B4576F10D7B@vmware.com>
References: <1642526161-22499-1-git-send-email-bvikas@vmware.com>
 <YekAgfkDgV6z6hYV@kroah.com>
In-Reply-To: <YekAgfkDgV6z6hYV@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.56.21121100
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d00f07ef-0cb0-4e01-b1db-08d9dd032d2d
x-ms-traffictypediagnostic: BN7PR05MB4033:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BN7PR05MB40334354C59C314883B74F56AB5B9@BN7PR05MB4033.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FX+aveGtNEbN4c0K/UN1N8MhrkkmtnhftbPqZ8XOrikEd6UFfvZdCnOLxnuXxW1U9sA89vOQEYf7ybbDNphcL7J7MzNFSFG6L/CJfzFyMpYxMAXIz/6In+fhgpva/VEYBVZn9RoJSC4kpPR3BFQBo1vEtqw+lKBb8Z1MiG3Pb7HgFNAn1p7PJz1K2zcNluQScbZI4TLncmFeHYKl8WaBbc/C23v/bPhniBF443R+Iut05eMH8BWimKMo+vRhH1id01MdsRN52mCmUjnZarR1qQKsFSemoDfKU9X/14rl3zcBNiVJ9Isa7At7dJldiZwvANJwpROuWbvtUtkcK7BsXYgMvPFf0errSCworzXEBazkP05ZCy0i6igjHJB/iRyqRsXyznpYvKMlc3wfAoWzk9VZBIYdbPwjZ3YM7UtSn4HyF1EWiKYAY/zvo4p7rB31TIltQlXHll3uofoSZ1ApWY3oFxE/YB2YkYOs5IGybyn3pF68dLMZAjS/MStm4PxBxAJhsCmEVW6oGLpB4RpvHHqvbesnOw2+JBwZyWPojiKfRZqhSrDg3WTEIHJB18K71AhSLrCWLkDMP6m/SLF+bGSzGVnWp0dXD0xOlHaIQp3oYEae7T8Dd6dJzx1x8LJEXeTRImttr3qcyNqNa+hc09tEVuAnxi1s/Y12mWdXQoI7O4YBFF55++6r03J86Ws36BPz3JYNorJtMv5gv5XB9kfT8YFpUyhkiKcwrymxIpu/DZfRjB1pSuonduL955Hsreede3b8JAfx61f5Glx424dRZ2pNNkzl14GnMCcsK8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8510.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(6916009)(53546011)(2906002)(91956017)(6486002)(54906003)(86362001)(36756003)(33656002)(508600001)(2616005)(107886003)(26005)(316002)(71200400001)(76116006)(186003)(38070700005)(38100700002)(83380400001)(5660300002)(8936002)(8676002)(4326008)(66946007)(64756008)(66446008)(66476007)(66556008)(122000001)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEh2dDNlRDZzQWt6RXZYSkhJSkNndGRqdzFXNE02cys0eUFhWm5oYnpGMk5Y?=
 =?utf-8?B?ZlEvL05EanlXNXRaQW1LYUZJSDBrNHE4WFBETG1hRm9YTVgyWVk2UHNPWFBu?=
 =?utf-8?B?UUdibWZLZUZDM1JGelJ3MG5GMUhCbllqKzBsMXNmN1UvTnNwSURiRWdZRjcy?=
 =?utf-8?B?U2VpWmMxRDlweWlPVEJsWHpFYWdhUmd2UUJRVTRLRG1XbzJreVBGYkVNMHZI?=
 =?utf-8?B?VzdQRGphWURlY1l0UEV0eW5aWXk3OU9tc1RuTjA0M05vMzNLbmorNWs1V1Fk?=
 =?utf-8?B?dHRqZFhDdjlzMjRKMldhWlFFdXRtOXFMQmpNbEJSTzNxMU14YVFVR3lnQlh1?=
 =?utf-8?B?RmhkbnpFYnU5UXB2cXNUMktyaHd3a1F6YUFjMzRSVFBsMjFnZlFMQ2VJSzJ0?=
 =?utf-8?B?ZlBiaHJQbmtSeXpvWFdwcHZyVmg0TEVwWjJUT0lVV0FuOVc3ZlY3V29zVDZv?=
 =?utf-8?B?UFM2Y1pmSjdlVU5WMHJHSnVjTWpGOU1RdVhLZkJxMkpaSDFERkF1ejIrckVz?=
 =?utf-8?B?eFlCQnEwQS9wUWxYNWF1bFNhYmphNGxTbkFtMzR6eTNtckhja2NYRTNQRWpL?=
 =?utf-8?B?NGR3SWsvVFlWNTIyVGhpWHF2S2JiWC9xenhIcUZCL0R0SHBteUFCMUtDRjRJ?=
 =?utf-8?B?UHk1eEVtSldwdC9WRVdkYnpoamJEejlaRkxkQkVuQUtGZGRaN0QzbGdCYWJI?=
 =?utf-8?B?OU1reGNHdVVjRlZ6TzNDNXRaVTBxUVN1akRiTGZZcnRpaWdOdGM0YzBmbytz?=
 =?utf-8?B?MzBTaHQxZkZZSGFDWGVtdytRY2NtTnZqRDdsZ1plWlArZ2ljK0wrYmRBL2lt?=
 =?utf-8?B?czFFTkg5WEx6NDRqWlJCbThFaXNNNGpKZ0dHVlUrOHl6UjVQdmFBZkZiLy9a?=
 =?utf-8?B?Rkd1NWQ2SkN4M0pxZzRMVTVIek1IaWE3Qnd2S1o1RmdMSkV3ZHY3ZEx0OWFJ?=
 =?utf-8?B?Mmcxa3IxZzI3RDROcGlwekhZdWp4YXpTSFk3V3RIaktUbVQ4RGQ4M2tPR25y?=
 =?utf-8?B?UUkyZTZTNkNrUXN1dW9qV3Q1ZXpNeU4yZ0NjcjYveEhpRXI3VkJQQlZzS05L?=
 =?utf-8?B?RlJMeTlxMVhEd3ZoYlJkLzFVOXJPYWFvUUFJczdMb0FkVkY0T29qaUJvc3BO?=
 =?utf-8?B?bDd5YVFDWFBjakp1NjNRVjd3bkF6S0dvbm04WENiMy9ZT2F3TWtsZHhSSDdE?=
 =?utf-8?B?aHlzUG9VMEFvM21VNTFsVGkvUitqeWpxWXBudEd1ZS9nbGZTb3ZoNlpxazI5?=
 =?utf-8?B?UVhlYnpjZEdQRC9KWUxHWTU3ZGpYT1lsZk5paVBmT04wQnQ0NkZkT0dSUWJG?=
 =?utf-8?B?bmhtdWlKWXpxcDJFUXVQL2NLRWxXL2FiK0hVT1VhcmcyQkFGMnZVY2tPd29j?=
 =?utf-8?B?NitDY05xUTI1VklPRkZ1ZlVRVWkvcnR3cHJENDFyY0JMdjBlTFhLd3FlNWcv?=
 =?utf-8?B?VWxtdWQ2RHh4MkZHbDFpZXYvZUp0eXd2MlY5ai83OFNqd000dG1BOUNmOUtx?=
 =?utf-8?B?Z1RTRzhTRmgwUFM5dVIwRjJVbDlzS0kvMGQrbGFnNlZLSDY1c0lZWjJPYmdI?=
 =?utf-8?B?TFJxUmJGNmc3OWtVNFlFVjRiaFhYQ0hETEpPSHNxSUZ4QmZXTVY5U0cwSWRz?=
 =?utf-8?B?azlvanhtdFo0UnJibnVCR3pMSzVZT2o0RUt6RHZUaGZjaWNIandCd2FVcVls?=
 =?utf-8?B?REF3Z1JKb0VuaENUNzUzNFJHMzJVUHprTm9mV2xNK09VL0Y1dFZZQWxyZE44?=
 =?utf-8?B?TUtHTVZqUUJ4Y3ZZTzlmWitOTHRsNnJvcUVvMnFRdkloZVB3WGRpMnlXN0tV?=
 =?utf-8?B?WlRvZ2lyMk5XWHlSNytPVE1jaENKdFJ3ekRlY0tBUmM4MHpJc2U5ckl3K0gv?=
 =?utf-8?B?N0NGdTRIRzlyRWdieitMckhtRGVuaTFrM1RUY1FvRm5Sem5lR0pBN1lXTUM4?=
 =?utf-8?B?bGJISjBJSkhsVXY5Rng4bjRldWxQQmhsNk81NWMzMU5kOElWVlFsRWMwZUxu?=
 =?utf-8?B?SVJBMnA2ZlpZNUpqL09Cd1FQaG5YUVlZZlZjeTlRTVF3RmZBcnRpcXVwb2Ft?=
 =?utf-8?B?SHBETVFuNGlqdkZYNTl6WnRxaFltQXhqQzRsNlErL0FmMzliN25Ba2RsRVlm?=
 =?utf-8?B?QlM3MEIvR0lCbkFEQXJEM3JMQTJ4K0FwbVZndlJrNjZ3TDZPL1I5aGZWVkFt?=
 =?utf-8?Q?dbn1btm45UXgK7Y92GQl2/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01440553C5DFA14B976CE0C5B14D3414@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8510.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00f07ef-0cb0-4e01-b1db-08d9dd032d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 17:26:36.0214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TNpOCkhYkUDAxoYjwm0a8erbd2zhsen3ADBf7E98oODYqOLdg7tqJfYTYWwCAE1bnKeP+VOYtP6NrM9+z5wgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4033
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ICAgIE9uIDIwLzAxLzIyLCAxMTo1NiBBTSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZz4gd3JvdGU6DQoNCiAgICBSdW4gcGFob2xlIGZvciBwY2lfZGV2IHN0cnVjdHVyZSwg
aXQgaXMgbm90IGFkZGluZyBhbnkgcGFkZGluZyBieXRlcy4NCiAgICBQbGVhc2UgcmVmZXIgdG8g
bXkgcHJldmlvdXMgZW1haWwgZm9yIHJlcGxpZXMgdG8gR3JlZydzIG90aGVyIGNvbW1lbnRzLiAN
Cg0KICAgID5PbiBUdWUsIEphbiAxOCwgMjAyMiBhdCAwOToxNjowMUFNIC0wODAwLCBWaWthc2gg
QmFuc2FsIHdyb3RlOg0KICAgID4+IEluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB0aGUg
UENJIGNhcGFiaWxpdHkgbGlzdCBpcyBwYXJzZWQgZnJvbQ0KICAgID4+IHRoZSBiZWdpbm5pbmcg
dG8gZmluZCBlYWNoIGNhcGFiaWxpdHksIHdoaWNoIHJlc3VsdHMgaW4gYSBsYXJnZSBudW1iZXIN
CiAgICA+PiBvZiByZWR1bmRhbnQgUENJIHJlYWRzLg0KICAgID4+DQogICAgPj4gSW5zdGVhZCwg
d2UgY2FuIHBhcnNlIHRoZSBjb21wbGV0ZSBsaXN0IGp1c3Qgb25jZSwgc3RvcmUgaXQgaW4gdGhl
DQogICAgPj4gcGNpX2RldiBzdHJ1Y3R1cmUsIGFuZCBnZXQgdGhlIG9mZnNldCBvZiBlYWNoIGNh
cGFiaWxpdHkgZGlyZWN0bHkgZnJvbQ0KICAgID4+IHRoZSBwY2lfZGV2IHN0cnVjdHVyZS4NCiAg
ICA+Pg0KICAgID4+IFRoaXMgaW1wbGVtZW50YXRpb24gaW1wcm92ZXMgcGNpIGRldmljZXMgaW5p
dGlhbGl6YXRpb24gdGltZSAgYnkgfjItMyUgaW4NCiAgICA+PiBjYXNlIG9mIGJhcmUgbWV0YWwg
YW5kIDctOCUgaW4gY2FzZSBvZiBWTSBydW5uaW5nIG9uIEVTWGkuDQogICAgPg0KICAgID5XaGF0
IGlzIHRoYXQgaW4gdGVybXMgb2YgIndhbGwgY2xvY2siIHRpbWU/ICAlIGlzIGhhcmQgdG8ga25v
dyBoZXJlLCBhbmQNCiAgICA+b2YgY291cnNlIGl0IHdpbGwgZGVwZW5kIG9uIHRoZSBQQ0kgYnVz
IHNwZWVkLCByaWdodD8NCiAgICA+DQogICAgPj4gSXQgYWxzbyBhZGRzIGEgbWVtb3J5IG92ZXJo
ZWFkIG9mIDIwYnl0ZXMgKHZhbHVlIG9mIFBDSV9DQVBfSURfTUFYKSBwZXINCiAgICA+PiBQQ0kg
ZGV2aWNlLg0KICAgID4+DQogICAgPj4gU2lnbmVkLW9mZi1ieTogVmlrYXNoIEJhbnNhbCA8YnZp
a2FzQHZtd2FyZS5jb20+DQogICAgPj4gLS0tDQogICAgPj4gIGRyaXZlcnMvcGNpL3BjaS5jICAg
fCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQogICAgPj4g
IGRyaXZlcnMvcGNpL3Byb2JlLmMgfCAgNSArKysrKw0KICAgID4+ICBpbmNsdWRlL2xpbnV4L3Bj
aS5oIHwgIDIgKysNCiAgICA+PiAgMyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KICAgID4+DQogICAgPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Bj
aS5jIGIvZHJpdmVycy9wY2kvcGNpLmMNCiAgICA+PiBpbmRleCAzZDJmYjM5NDk4NmEuLjhlMDI0
ZGIzMDI2MiAxMDA2NDQNCiAgICA+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0KICAgID4+ICsr
KyBiL2RyaXZlcnMvcGNpL3BjaS5jDQogICAgPj4gQEAgLTQ2OCw2ICs0NjgsNDEgQEAgc3RhdGlj
IHU4IF9fcGNpX2J1c19maW5kX2NhcF9zdGFydChzdHJ1Y3QgcGNpX2J1cyAqYnVzLA0KICAgID4+
ICAJcmV0dXJuIDA7DQogICAgPj4gIH0NCiAgICA+PiAgDQogICAgPj4gKw0KICAgID4+ICsvKioN
CiAgICA+PiArICogcGNpX2ZpbmRfYWxsX2NhcGFiaWxpdGllcyAtIFJlYWQgYWxsIGNhcGFiaWxp
dGllcw0KICAgID4+ICsgKiBAZGV2OiB0aGUgUENJIGRldmljZQ0KICAgID4+ICsgKg0KICAgID4+
ICsgKiBSZWFkIGFsbCBjYXBhYmlsaXRpZXMgYW5kIHN0b3JlIG9mZnNldHMgaW4gY2FwX29mZg0K
ICAgID4+ICsgKiBhcnJheSBpbiBwY2lfZGV2IHN0cnVjdHVyZS4NCiAgICA+PiArICovDQogICAg
Pj4gK3ZvaWQgcGNpX2ZpbmRfYWxsX2NhcGFiaWxpdGllcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0K
ICAgID4+ICt7DQogICAgPj4gKwlpbnQgdHRsID0gUENJX0ZJTkRfQ0FQX1RUTDsNCiAgICA+PiAr
CXUxNiBlbnQ7DQogICAgPj4gKwl1OCBwb3M7DQogICAgPj4gKwl1OCBpZDsNCiAgICA+PiArDQog
ICAgPj4gKwlwb3MgPSBfX3BjaV9idXNfZmluZF9jYXBfc3RhcnQoZGV2LT5idXMsIGRldi0+ZGV2
Zm4sIGRldi0+aGRyX3R5cGUpOw0KICAgID4+ICsJaWYgKCFwb3MpDQogICAgPj4gKwkJcmV0dXJu
Ow0KICAgID4+ICsJcGNpX2J1c19yZWFkX2NvbmZpZ19ieXRlKGRldi0+YnVzLCBkZXYtPmRldmZu
LCBwb3MsICZwb3MpOw0KICAgID4+ICsJd2hpbGUgKHR0bC0tKSB7DQogICAgPj4gKwkJaWYgKHBv
cyA8IDB4NDApDQogICAgPg0KICAgID5XaGF0IGlzIHRoaXMgbWFnaWMgdmFsdWUgb2YgMHg0MD8N
CiAgICA+DQogICAgPj4gKwkJCWJyZWFrOw0KICAgID4+ICsJCXBvcyAmPSB+MzsNCiAgICA+DQog
ICAgPldoeSB+Mz8NCiAgICA+DQogICAgPj4gKwkJcGNpX2J1c19yZWFkX2NvbmZpZ193b3JkKGRl
di0+YnVzLCBkZXYtPmRldmZuLCBwb3MsICZlbnQpOw0KICAgID4+ICsJCWlkID0gZW50ICYgMHhm
ZjsNCiAgICA+DQogICAgPkRvIHlvdSByZWFsbHkgbmVlZCB0aGUgJiBpZiB5b3UgYXJlIHRydW5j
YXRpbmcgaXQ/DQogICAgPg0KICAgID4+ICsJCWlmIChpZCA9PSAweGZmKQ0KICAgID4+ICsJCQli
cmVhazsNCiAgICA+PiArDQogICAgPj4gKwkJLyogUmVhZCBmaXJzdCBpbnN0YW5jZSBvZiBjYXBh
YmlsaXR5ICovDQogICAgPj4gKwkJaWYgKCEoZGV2LT5jYXBfb2ZmW2lkXSkpDQogICAgPj4gKwkJ
CWRldi0+Y2FwX29mZltpZF0gPSBwb3M7DQogICAgPg0KICAgID5TaG91bGRuJ3QgeW91IGhhdmUg
Y2hlY2tlZCB0aGlzIGJlZm9yZSB5b3UgcmVhZCB0aGUgdmFsdWU/DQogICAgPg0KICAgID4+ICsJ
CXBvcyA9IChlbnQgPj4gOCk7DQogICAgPg0KICAgID5XaGF0IGFib3V0IHdhbGtpbmcgdGhlIGxp
c3QgdXNpbmcgX19wY2lfZmluZF9uZXh0X2NhcCgpIGxpa2UgYmVmb3JlPw0KICAgID5XaHkgaXMg
dGhpcyBzb21laG93IHRoZSBzYW1lIGFzIHRoZSBvbGQgZnVuY3Rpb24/DQogICAgPg0KICAgID4+
ICsJfQ0KICAgID4+ICt9DQogICAgPj4gKw0KICAgID4+ICAvKioNCiAgICA+PiAgICogcGNpX2Zp
bmRfY2FwYWJpbGl0eSAtIHF1ZXJ5IGZvciBkZXZpY2VzJyBjYXBhYmlsaXRpZXMNCiAgICA+PiAg
ICogQGRldjogUENJIGRldmljZSB0byBxdWVyeQ0KICAgID4+IEBAIC00ODksMTMgKzUyNCw3IEBA
IHN0YXRpYyB1OCBfX3BjaV9idXNfZmluZF9jYXBfc3RhcnQoc3RydWN0IHBjaV9idXMgKmJ1cywN
CiAgICA+PiAgICovDQogICAgPj4gIHU4IHBjaV9maW5kX2NhcGFiaWxpdHkoc3RydWN0IHBjaV9k
ZXYgKmRldiwgaW50IGNhcCkNCiAgICA+PiAgew0KICAgID4+IC0JdTggcG9zOw0KICAgID4+IC0N
CiAgICA+IC0JcG9zID0gX19wY2lfYnVzX2ZpbmRfY2FwX3N0YXJ0KGRldi0+YnVzLCBkZXYtPmRl
dmZuLCBkZXYtPmhkcl90eXBlKTsNCiAgICA+PiAtCWlmIChwb3MpDQogICAgPj4gLQkJcG9zID0g
X19wY2lfZmluZF9uZXh0X2NhcChkZXYtPmJ1cywgZGV2LT5kZXZmbiwgcG9zLCBjYXApOw0KICAg
ID4+IC0NCiAgICA+PiAtCXJldHVybiBwb3M7DQogICAgPj4gKwlyZXR1cm4gZGV2LT5jYXBfb2Zm
W2NhcF07DQogICAgPj4gIH0NCiAgICA+PiAgRVhQT1JUX1NZTUJPTChwY2lfZmluZF9jYXBhYmls
aXR5KTsNCiAgICA+PiAgDQogICAgPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMg
Yi9kcml2ZXJzL3BjaS9wcm9iZS5jDQogICAgPj4gaW5kZXggMDg3ZDM2NThmNzVjLi5iYWNhYjEy
Y2VkYmIgMTAwNjQ0DQogICAgPj4gLS0tIGEvZHJpdmVycy9wY2kvcHJvYmUuYw0KICAgID4+ICsr
KyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMNCiAgICA+PiBAQCAtMTgzOSw2ICsxODM5LDExIEBAIGlu
dCBwY2lfc2V0dXBfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQogICAgPj4gIAlkZXYtPmhk
cl90eXBlID0gaGRyX3R5cGUgJiAweDdmOw0KICAgID4+ICAJZGV2LT5tdWx0aWZ1bmN0aW9uID0g
ISEoaGRyX3R5cGUgJiAweDgwKTsNCiAgICA+PiAgCWRldi0+ZXJyb3Jfc3RhdGUgPSBwY2lfY2hh
bm5lbF9pb19ub3JtYWw7DQogICAgPj4gKwkvKg0KICAgID4+ICsJICogUmVhZCBhbGwgY2FwYWJp
bGl0aWVzIGFuZCBzdG9yZSBvZmZzZXRzIGluIGNhcF9vZmYNCiAgICA+PiArCSAqIGFycmF5IGlu
IHBjaV9kZXYgc3RydWN0dXJlLg0KICAgID4+ICsJICovDQogICAgPg0KICAgID5Db21tZW50IGlz
IG5vdCBuZWVkZWQgaWYgdGhlIGZ1bmN0aW9uIG5hbWUgaXMgZGVzY3JpcHRpdmUuDQogICAgPg0K
ICAgID4+ICsJcGNpX2ZpbmRfYWxsX2NhcGFiaWxpdGllcyhkZXYpOw0KICAgID4NCiAgICA+QW5k
IGl0IGlzLCBzbyBubyBuZWVkIGZvciB0aGUgY29tbWVudC4NCiAgICA+DQogICAgPj4gIAlzZXRf
cGNpZV9wb3J0X3R5cGUoZGV2KTsNCiAgICA+PiAgDQogICAgPj4gIAlwY2lfc2V0X29mX25vZGUo
ZGV2KTsNCiAgICA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1ZGUv
bGludXgvcGNpLmgNCiAgICA+PiBpbmRleCAxOGE3NWM4ZTYxNWMuLmQyMjFjNzNlNjdmOCAxMDA2
NDQNCiAgICA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oDQogICAgPj4gKysrIGIvaW5jbHVk
ZS9saW51eC9wY2kuaA0KICAgID4+IEBAIC0zMjYsNiArMzI2LDcgQEAgc3RydWN0IHBjaV9kZXYg
ew0KICAgID4+ICAJdW5zaWduZWQgaW50CWNsYXNzOwkJLyogMyBieXRlczogKGJhc2Usc3ViLHBy
b2ctaWYpICovDQogICAgPj4gIAl1OAkJcmV2aXNpb247CS8qIFBDSSByZXZpc2lvbiwgbG93IGJ5
dGUgb2YgY2xhc3Mgd29yZCAqLw0KICAgID4+ICAJdTgJCWhkcl90eXBlOwkvKiBQQ0kgaGVhZGVy
IHR5cGUgKGBtdWx0aScgZmxhZyBtYXNrZWQgb3V0KSAqLw0KICAgID4+ICsJdTggICAgICAgICAg
ICAgIGNhcF9vZmZbUENJX0NBUF9JRF9NQVhdOyAvKiBPZmZzZXRzIG9mIGFsbCBwY2kgY2FwYWJp
bGl0aWVzICovDQogICAgPg0KICAgID5EaWQgeW91IHJ1biAncGFob2xlJyB0byBlbnN1cmUgeW91
IGFyZSBub3QgYWRkaW5nIGV4dHJhIHBhZGRpbmcgYnl0ZXMNCiAgICA+aGVyZT8NCiAgICA+DQog
ICAgPj4gICNpZmRlZiBDT05GSUdfUENJRUFFUg0KICAgID4+ICAJdTE2CQlhZXJfY2FwOwkvKiBB
RVIgY2FwYWJpbGl0eSBvZmZzZXQgKi8NCiAgICA+PiAgCXN0cnVjdCBhZXJfc3RhdHMgKmFlcl9z
dGF0czsJLyogQUVSIHN0YXRzIGZvciB0aGlzIGRldmljZSAqLw0KICAgID4+IEBAIC0xMTI4LDYg
KzExMjksNyBAQCB2b2lkIHBjaV9zb3J0X2JyZWFkdGhmaXJzdCh2b2lkKTsNCiAgICA+PiAgDQog
ICAgPj4gIHU4IHBjaV9idXNfZmluZF9jYXBhYmlsaXR5KHN0cnVjdCBwY2lfYnVzICpidXMsIHVu
c2lnbmVkIGludCBkZXZmbiwgaW50IGNhcCk7DQogICAgPj4gIHU4IHBjaV9maW5kX2NhcGFiaWxp
dHkoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IGNhcCk7DQogICAgPj4gK3ZvaWQgcGNpX2ZpbmRf
YWxsX2NhcGFiaWxpdGllcyhzdHJ1Y3QgcGNpX2RldiAqZGV2KTsNCiAgICA+DQogICAgPldoeSBp
cyB0aGlzIG5vdyBhIGdsb2JhbCBmdW5jdGlvbiBhbmQgbm90IG9uZSBqdXN0IGxvY2FsIHRvIHRo
ZSBwY2kNCiAgICA+Y29yZT8gIFdobyBlbHNlIHdvdWxkIGV2ZXIgbmVlZCB0byBjYWxsIGl0Pw0K
ICAgID4NCiAgICA+dGhhbmtzLA0KICAgID4NCiAgICA+Z3JlZyBrLWgNCg0KDQoNCg0K
