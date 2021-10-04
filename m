Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FF4218B5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 22:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhJDUxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 16:53:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:14192 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhJDUw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633380669; x=1664916669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PxJk3k1POpNbV0Ii2545W/gjCjAENOobSPyia7QnC8g=;
  b=YnpcZISdckYJ3GDP/1ipzw88+yOlEZ+psFK98umsmziJp4doJ+zg89/h
   l8BzauLyHZAGTy1LvxTLsCZIXM7sw3lINaP0pZ9ku3GqcWToAeKTQ53GW
   qjTeovKK1wD90fhw0VfDEhYRBjMzbgUqtg2vefvdB/GMwFFRokjaIuRCF
   7rdDjicgdS+WiY3N5SvAwxrf11Tfqzkvvlq99j0LJJhwLz96EObpN4nDL
   /Rw5suamLmm7S0umQLXGAou3CzFWM3n7U/GMLeTsD/ssmeonJ7n/txD7g
   mavnLPRZnUlPulL+7GqSrThc5g5tGvxrcZjRwzeuip/Pv9n4jcGL3JatJ
   w==;
IronPort-SDR: hbdcKSN8sZ0LWWL3yFa4AWcuuWxzJ4VTbeOw6AgOKGJ5QxoMxy0kAtK1VhebZ50H4wc/VKyqKk
 b5Bv3+PocBwKF1lgBBa10Ie3GoutHsM+vquUnvi8Hg52kWKOedYuzoTKdtoSwE3uNWluomquvH
 Z8YRTqtQbWpz/Brpwjco6Oek+LEeS/exiV8vlJodQ8poAJE9A8vZW1VcblKmh7bL9NCY474U5Q
 mcEfq1tRGB0LBou3Fp+P9TBdgCqB9+R2QJXgirm6A0tj0BDTrNjHoTKQcG6gNvQE+B/rCnoFiC
 82bWaADGzi384utR92H6Th8t
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="71671141"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 13:51:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 13:51:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 13:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcHMnY7SUgz6c+DHiL1wPfMsHLTlkV31DBhrs4r4IDos08ck7IxCUnVkxofUBSXqR4T4s/uPWcmnzoI2GX55HurjOuGEdw8zjg5ZvhtbZ/W9hQxlKlaSGQmTJxbVfo1aDgMJqSvP+pnx8d8+45izUKczr4WPuC+fFR/VEI8QHFqyvt4uV6cx37ilyKXmVIKtt7Bi2dIsLtV34c9oDbSyQORkq0bUB07Gk8BVZvRkVKRx9k/Y0wz4BnhtLq7cl4flf3G+tYq2GjUKUdRrk+rdy4mqjIjfCgTiDQVW3X+5bbqweZ1Rkn2AnsTeWfZCdDn2Lc5Cmcf8nZmaKakco8MRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxJk3k1POpNbV0Ii2545W/gjCjAENOobSPyia7QnC8g=;
 b=KngSzwUkbsQxyNCa8NfSIXu5/pLzR1i8H0pyNiZZW6z9AuV1O1Wkih91g/gOxt574/48C9xIohsLDnMderh+4ZQOj29L565WZv2iZNLCOEBqqIa3QHMikhD+d48mwBCPf+JMgjeQzGw0qeL8DD1BCkvHwc0b0RkMboZUeBPQwFml1zPMtvmZkH75r8roomGCWMkT1rROQbH5okiSa9wNOMN/u5LjckZ3RHXg/fq583UGUew4D8HJyDnwRQTHux0YtDrjaElo8a+a6ySNXQz1MQ9Igo+lYz5NQ457tcEwwipGMpfWlKgzfW/nmKXVEwMR1nfMSFGKGUTt/vPPGVyL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxJk3k1POpNbV0Ii2545W/gjCjAENOobSPyia7QnC8g=;
 b=QgW2TvoOfL88Jnk7wLjbyHOYFzdibzg78wxCU4rgGOAzTRh0tefMTj2MDknkDvDJR4T/053rwz3xC49SY0WrjG1YSkHcE7QaN52Fr9x9E1+AkD5ZyGNIbNbP+LUtKI/5DBQe82Gcipi3m9VVzm9mw7agxm18dRvo+55rgXscSgE=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 20:51:07 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 20:51:06 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <kelvincao@outlook.com>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAADAgCAADeugIABAgSAgAODLoA=
Date:   Mon, 4 Oct 2021 20:51:06 +0000
Message-ID: <1690d2d34fe8d1d11959cdbe9c00ba48ff01d9c3.camel@microchip.com>
References: <20211002151153.GA967141@bhelgaas>
In-Reply-To: <20211002151153.GA967141@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156dd75d-6d88-4b59-0cf4-08d98778b015
x-ms-traffictypediagnostic: CO6PR11MB5636:
x-microsoft-antispam-prvs: <CO6PR11MB5636AD48E4B4E4F2FDB676818DAE9@CO6PR11MB5636.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xo37v5FF0I0VE13k8nWa8eF95tPHfl0U/Mx/lWGzEOn+EvqkbTnT/DHYI3Zy4VAHyiYpD6YH3J/nGWgxR6ShfmxYWRobvBskoU68eLDbFAC/HR6nKK+frux/9FckI1PfE7dy9ULIHyZTy8q99ZPOeLeH7b6ESauZKWQuC0k2SD5pla0UbKI7FklpGuP9BekhAOXCeidDwYtiSLoPcGl6VrUVWwHnCqSJKJ8R9C+RTurTBU7MoAE2YSmSDnzbhu/FK9sBqsUatzGbovvUtUHwxbRCQsXViv0jMUBYhyEVupX4F7L/sCg4HpCvXD2yC3ExZQp2c8lK4BqVzT9uM2rOA3Oep2vEClEHsSptVW085iPGA+U+10Cy3GbDdF3i6L509dcWW8zWUxXBJdBmXKjhSY5gSryHEF6FQQkZdo/fbrUcxsmoFVhbPm8nLj5rlpR9qgh2BCsMQELgS3L/hJ231xC3Vf+EOmjd6J8HCqbqR0Hn0A0cjVOrd6gjT8hXaRIfftQmh3/wltog3vqNZzd626dzjIV/I3bjiTs5wfLgX7WRaAmjdYFG489bvx3Mgqdp5C/UMHAS6QCMf8hJjymJ89QDMppyvXyyiguZclR75IV72F3LctP8QbvMezoB/L6Ng/TvJzj0MNrjL12V9/657MZ1yT3i2rODzIZslE1DmjIlolCTwaqnzMT6QmysJkIn0CnaWb/Gk+aptWU1hvwBZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(86362001)(53546011)(71200400001)(6512007)(36756003)(2906002)(186003)(26005)(38070700005)(66556008)(64756008)(66446008)(66476007)(6486002)(122000001)(2616005)(83380400001)(6916009)(66946007)(6506007)(76116006)(316002)(4326008)(8936002)(8676002)(38100700002)(5660300002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZYeEdjMUkwSmhRZTlhOE9xSGtEYmN2L2tDY0p5ZHhxbmt4ejVnVUovaS85?=
 =?utf-8?B?dHQyMjI4V01Kc2FlSXF3WG03ZE01OUFxMlR5NzNPcmlMa2l2MU1yMnNqN2Ux?=
 =?utf-8?B?aEtIaXUxMGZPSG1nSXF3VFlDMlZpS2lubG1WWE9pek4vRUJZQWp1TGpjSXBh?=
 =?utf-8?B?cjZoNi8wRG0yY282bUtxMkFxOU4vL0cvbmI4R2xiQ2dLOHVxdlVIRCt1NTJE?=
 =?utf-8?B?Q0FIU2dNTGhlTDBVTGtNclNhMVIyWkJCOUhJMGppTmdoeGNaOE1aYjVrRDJJ?=
 =?utf-8?B?ZlZOSFRyR1kyRERYcit6VWR2b2t3N0tXSUlxWU54cTV2NStCbzFMMHBXNC9s?=
 =?utf-8?B?dmhIWGVETjBtU2Y0T1Z6L25Zb3Nibjhma1NVdThjcWRJeE5Na09PdUhmbHNl?=
 =?utf-8?B?RGlScVptd0hrVTlyQ1MwR2NlSWU2MkNTLzF6RjN4MGN5eU4vNXErSG16WlBG?=
 =?utf-8?B?VlZqMzdXSWRna2IxYmNrTzJHYVE4TmJLcnJSQ2FQTk1odWkrcXRrMDNBNTFV?=
 =?utf-8?B?RVYrUTJHeTd0VGczRzAzUHNrQTNIckhjTEU0c1lZbkN3dXB2UUZXR1hrMkl2?=
 =?utf-8?B?RllEUHJERE9odjVGTmQySVdNN0F5M0JoNHpOUlcrQ1NkeVM2TzVvWmo3c0lF?=
 =?utf-8?B?ZGU1YkFZcnh2VFUxcEZhKzRCQmw3NnlXNklySDlHSWZXTDgzNXk1T3dkVm9Y?=
 =?utf-8?B?VGNqa0E0b3NpMHVEYTRHdW04b1ZiRjBrNEN6dmZWT1piRlBSdEhEU3pkamRx?=
 =?utf-8?B?ZDVXbDFja1B2a0ZNay93QVNwbEJZbXZzS2VRcDJSMUt1SXVHL0JMbmg1Y2Zy?=
 =?utf-8?B?TlBZZVE3OW5ORTE1enhrbkphR3NCMi9nUlBYcDFubnZYMUZBd3ZwRG5wdGRE?=
 =?utf-8?B?bjhHdm9MbXM0a0M2L3JTcmpBQlIyWkVKS2wzQ3duWVh1ZW5NQzdKZmMyR1Bu?=
 =?utf-8?B?QTdaam5rRFE2N3RSNnovMm12WDFRUzBlZ2RUOXVPUUFveStueXQ2bk5xdjFL?=
 =?utf-8?B?emVqbU92Tmd3ZmZrQ3VmdU9iYWp4Nm1ueVVlajE5eXQ4VnlPbHMzcmczUGFB?=
 =?utf-8?B?UGtMWDAyZW5XdGZXSUlLa2ZoVlhUeVJ4T094NWlyWVBFQVZHaTA2TmlSNzBX?=
 =?utf-8?B?THUvWFdlMUJIVlRST1pxMGJFSTVZVkE5NnYwemRPR21EOXNrU1RKUm9NODZl?=
 =?utf-8?B?TXVaSHh4V2Q2UWV5TDNDVkFneFV4KzY4cVZJbGYrZ0IzNmhoRWh0UDJWVURF?=
 =?utf-8?B?c2Z0dzAxd3NvdklMakl6QmNYRE80dDJpNzFxV09mMUR2SXBMN3h2K05YQWFH?=
 =?utf-8?B?Q1ZMM1RtZE10WkpSeDFRbng1OEd4U1lQV3k3NUh5emdvOGw4aUZCbEJNSDg1?=
 =?utf-8?B?UFpOVVlLMWRWTTllM1J3VHIvdmZiSVUxZk5VNlBVVHZSZGNrazR5TzBoQlZ6?=
 =?utf-8?B?OGdpU29oajNHbGc0bmZQMkVNVE10VkFsa1V3aG5GNWp5MHBsMzluSHRjWUZy?=
 =?utf-8?B?VUVoa1VNUzNsYUFCem9kRTIzRFY3dURLN1hzaHNTUUJnUmVkemk4V3RBV2d4?=
 =?utf-8?B?bzV1SlRkZmhRRkdyVE01QTlRcmt4RUJUR1JESmFEUnUvd0pzTUx4SUhFRzNM?=
 =?utf-8?B?a1NyeXhINGlicFBhdENuaW9zZHlzaXdDMXpPWjRBZ0VoTld0RFVxeGlaVDlF?=
 =?utf-8?B?b2JEeG9ocmtjMnU2Rkh4Yk9RVU9wbmYzOGgvdUVNcmRyRHhzYUtPR1R3YzBU?=
 =?utf-8?B?QnpMUU4zZUZKU0FZVFAvRFEvUksrcFZRVk5hSGJpamJ5NTZSajlBZHExaVRt?=
 =?utf-8?B?TXhCcXRFVGpOL28ySXRJZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <640E73AA19D0264A8B42F04EB825D2B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156dd75d-6d88-4b59-0cf4-08d98778b015
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 20:51:06.8047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSwfldSjio+FIIPhQCBT5ojY4UzsokKrkjDGT5uRrbwIuLC/LNSgN5py+e0UU3rwDXffEbUl2Q6TrJzsmytkZUbpfWWfnp4FVx9yxqSYIOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5636
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDIxLTEwLTAyIGF0IDEwOjExIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBGcmksIE9jdCAwMSwgMjAyMSBhdCAxMTo0OToxOFBNICswMDAwLCBLZWx2aW4uQ2FvQG1p
Y3JvY2hpcC5jb20NCj4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIxLTEwLTAxIGF0IDE0OjI5IC0w
NjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiA+ID4ga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPiANCj4gPiA+IE9uIDIwMjEtMTAtMDEgMjoxOCBwLm0u
LCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIFNlcCAyNCwgMjAyMSBhdCAx
MTowODozOEFNICswMDAwLCANCj4gPiA+ID4ga2VsdmluLmNhb0BtaWNyb2NoaXAuY29tDQo+ID4g
PiA+IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEtlbHZpbiBDYW8gPGtlbHZpbi5jYW9AbWljcm9j
aGlwLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZnRlciBhIGZpcm13YXJlIGhhcmQgcmVz
ZXQsIE1SUEMgY29tbWFuZCBleGVjdXRpb25zLCB3aGljaA0KPiA+ID4gPiA+IGFyZSBiYXNlZCBv
biB0aGUgUENJIEJBUiAod2hpY2ggTWljcm9jaGlwIHJlZmVycyB0byBhcyBHQVMpDQo+ID4gPiA+
ID4gcmVhZC93cml0ZSwgd2lsbCBoYW5nIGluZGVmaW5pdGVseS4gVGhpcyBpcyBiZWNhdXNlIGFm
dGVyIGENCj4gPiA+ID4gPiByZXNldCwgdGhlIGhvc3Qgd2lsbCBmYWlsIGFsbCBHQVMgcmVhZHMg
KGdldCBhbGwgMXMpLCBpbg0KPiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+ID4gY2FzZSB0aGUgZHJp
dmVyIHdvbid0IGdldCBhIHZhbGlkIE1SUEMgc3RhdHVzLg0KPiA+ID4gPiANCj4gPiA+ID4gVHJ5
aW5nIHRvIHdyaXRlIGEgbWVyZ2UgY29tbWl0IGxvZyBmb3IgdGhpcywgYnV0IGhhdmluZyBhIGhh
cmQNCj4gPiA+ID4gdGltZSBzdW1tYXJpemluZyBpdC4gIEl0IHNvdW5kcyBsaWtlIGl0IGNvdmVy
cyBib3RoDQo+ID4gPiA+IFN3aXRjaHRlYy1zcGVjaWZpYyAoZmlybXdhcmUgYW5kIE1SUEMgY29t
bWFuZHMpIGFuZCBnZW5lcmljDQo+ID4gPiA+IFBDSWUNCj4gPiA+ID4gYmVoYXZpb3IgKE1NSU8g
cmVhZCBmYWlsdXJlcykuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGhhcyBzb21ldGhpbmcgdG8g
ZG8gd2l0aCBhIGZpcm13YXJlIGhhcmQgcmVzZXQuICBXaGF0IGlzDQo+ID4gPiA+IHRoYXQ/ICBJ
cyB0aGF0IGxpa2UgYSBmaXJtd2FyZSByZWJvb3Q/ICBBIGRldmljZSByZXNldCwgZS5nLiwNCj4g
PiA+ID4gRkxSIG9yIHNlY29uZGFyeSBidXMgcmVzZXQsIHRoYXQgY2F1c2VzIGEgZmlybXdhcmUg
cmVib290PyAgQQ0KPiA+ID4gPiBkZXZpY2UgcmVzZXQgaW5pdGlhdGVkIGJ5IGZpcm13YXJlPw0K
PiA+IA0KPiA+IEEgZmlybXdhcmUgcmVzZXQgY2FuIGJlIHRyaWdnZXJlZCBieSBhIHJlc2V0IGNv
bW1hbmQgaXNzdWVkIHRvIHRoZQ0KPiA+IGZpcm13YXJlIHRvIHJlYm9vdCBpdC4NCj4gDQo+IFNv
IEkgZ3Vlc3MgdGhpcyByZXNldCBjb21tYW5kIHdhcyBpc3N1ZWQgYnkgdGhlIGRyaXZlcj8NClll
cywgdGhlIHJlc2V0IGNvbW1hbmQgY2FuIGJlIGlzc3VlZCBieSBhIHVzZXJzcGFjZSB1dGlsaXR5
IHRvIHRoZQ0KZmlybXdhcmUgdmlhIHRoZSBkcml2ZXIuIEluIHNvbWUgb3RoZXIgY2FzZXMsIHVz
ZXIgY2FuIGFsc28gaXNzdWUgdGhlDQpyZXNldCBjb21tYW5kLCB2aWEgYSBzaWRlYmFuZCBpbnRl
cmZhY2UgKGxpa2UgVUFSVCksIHRvIHRoZSBmaXJtd2FyZS4gDQo+IA0KPiA+ID4gPiBBbnl3YXks
IGFwcGFyZW50bHkgd2hlbiB0aGF0IGhhcHBlbnMsIE1NSU8gcmVhZHMgdG8gdGhlIHN3aXRjaA0K
PiA+ID4gPiBmYWlsICh0aW1lb3V0IG9yIGVycm9yIGNvbXBsZXRpb24gb24gUENJZSkgZm9yIGEg
d2hpbGUuICBJZiBhDQo+ID4gPiA+IGRldmljZSByZXNldCBpcyBpbnZvbHZlZCwgdGhhdCBtdWNo
IGlzIHN0YW5kYXJkIFBDSWUgYmVoYXZpb3IuDQo+ID4gPiA+IEFuZCB0aGUgZHJpdmVyIHNlZXMg
fjAgZGF0YSBmcm9tIHRob3NlIGZhaWxlZCByZWFkcy4gIFRoYXQncw0KPiA+ID4gPiBub3QNCj4g
PiA+ID4gcGFydCBvZiB0aGUgUENJZSBzcGVjLCBidXQgaXMgdHlwaWNhbCByb290IGNvbXBsZXgg
YmVoYXZpb3IuDQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQgeW91IHNhaWQgdGhlIE1SUEMgY29tbWFu
ZHMgaGFuZyBpbmRlZmluaXRlbHkuICBQcmVzdW1hYmx5DQo+ID4gPiA+IE1NSU8gcmVhZHMgd291
bGQgc3RhcnQgc3VjY2VlZGluZyBldmVudHVhbGx5IHdoZW4gdGhlIGRldmljZQ0KPiA+ID4gPiBi
ZWNvbWVzIHJlYWR5LCBzbyBJIGRvbid0IGtub3cgaG93IHRoYXQgdHJhbnNsYXRlcyB0bw0KPiA+
ID4gPiAiaW5kZWZpbml0ZWx5LiINCj4gPiA+IA0KPiA+ID4gSSBzdXNwZWN0IEtlbHZpbiBjYW4g
ZXhwYW5kIG9uIHRoaXMgYW5kIGZpeCB0aGUgaXNzdWUgYmVsb3cuIEJ1dA0KPiA+ID4gaW4gbXkg
ZXhwZXJpZW5jZSwgdGhlIE1NSU8gd2lsbCByZWFkIH4wIGZvcmV2ZXIgYWZ0ZXIgYSBmaXJtd2Fy
ZQ0KPiA+ID4gcmVzZXQsIHVudGlsIHRoZSBzeXN0ZW0gaXMgcmVib290ZWQuIFByZXN1bWFibHkg
b24gc3lzdGVtcyB0aGF0DQo+ID4gPiBoYXZlIGdvb2QgaG90IHBsdWcgc3VwcG9ydCB0aGV5IGFy
ZSBzdXBwb3NlZCB0byByZWNvdmVyLiBUaG91Z2gNCj4gPiA+IEkndmUgbmV2ZXIgc2VlbiB0aGF0
Lg0KPiA+IA0KPiA+IFRoaXMgaXMgYWxzbyBteSBvYnNlcnZhdGlvbiwgYWxsIE1NSU8gcmVhZCB3
aWxsIGZhaWwgKH4wIHJldHVybmVkKQ0KPiA+IHVudGlsIHRoZSBzeXN0ZW0gaXMgcmVib290ZWQg
b3IgYSBQQ0kgcmVzY2FuIGlzIHBlcmZvcm1lZC4NCj4gDQo+IFRoaXMgbWFkZSBzZW5zZSB1bnRp
bCB5b3Ugc2FpZCBNTUlPIHJlYWRzIHdvdWxkIHN0YXJ0IHdvcmtpbmcgYWZ0ZXIgYQ0KPiBQQ0kg
cmVzY2FuLiAgQSByZXNjYW4gZG9lc24ndCByZWFsbHkgZG8gYW55dGhpbmcgc3BlY2lhbCBvdGhl
ciB0aGFuDQo+IGRvaW5nIGNvbmZpZyBhY2Nlc3NlcyB0byB0aGUgZGV2aWNlLiAgVHdvIHRoaW5n
cyBjb21lIHRvIG1pbmQ6DQo+IA0KPiAxKSBSZXNjYW4gZG9lcyBhIGNvbmZpZyByZWFkIG9mIHRo
ZSBWZW5kb3IgSUQsIGFuZCBkZXZpY2VzIG1heQ0KPiByZXNwb25kIHdpdGggIkNvbmZpZ3VyYXRp
b24gUmVxdWVzdCBSZXRyeSBTdGF0dXMiIGlmIHRoZXkgYXJlIG5vdA0KPiByZWFkeS4gIEluIHRo
aXMgZXZlbnQsIExpbnV4IHJldHJpZXMgdGhpcyBmb3IgYSB3aGlsZS4gIFRoaXMgc2NlbmFyaW8N
Cj4gZG9lc24ndCBxdWl0ZSBmaXQgYmVjYXVzZSBpdCBzb3VuZHMgbGlrZSB0aGlzIGlzIGEgZGV2
aWNlLXNwZWNpZmljDQo+IHJlc2V0IGluaXRpYXRlZCBieSB0aGUgZHJpdmVyLCBhbmQgQ1JTIGlz
IG5vdCBwZXJtaXRlZCBpbiB0aGlzIGNhc2UuDQo+IFBDSWUgcjUuMCwgc2VjIDIuMy4xLCBzYXlz
Og0KPiANCj4gICBBIGRldmljZSBGdW5jdGlvbiBpcyBleHBsaWNpdGx5IG5vdCBwZXJtaXR0ZWQg
dG8gcmV0dXJuIENSUw0KPiAgIGZvbGxvd2luZyBhIHNvZnR3YXJlLWluaXRpYXRlZCByZXNldCAo
b3RoZXIgdGhhbiBhbiBGTFIpIG9mIHRoZQ0KPiAgIGRldmljZSwgZS5nLiwgYnkgdGhlIGRldmlj
ZSdzIHNvZnR3YXJlIGRyaXZlciB3cml0aW5nIHRvIGENCj4gICBkZXZpY2Utc3BlY2lmaWMgcmVz
ZXQgYml0Lg0KPiANCj4gMikgVGhlIGRldmljZSBtYXkgbG9zZSBpdHMgYnVzIGFuZCBkZXZpY2Ug
bnVtYmVyIGNvbmZpZ3VyYXRpb24gYWZ0ZXINCj4gYQ0KPiByZXNldCwgc28gaXQgbXVzdCBjYXB0
dXJlIGJ1cyBhbmQgZGV2aWNlIG51bWJlcnMgZnJvbSBjb25maWcgd3JpdGVzLg0KPiBJIGRvbid0
IHRoaW5rIExpbnV4IGRvZXMgdGhpcyBleHBsaWNpdGx5LCBidXQgYSByZXNjYW4gZG9lcyBkbyBj
b25maWcNCj4gd3JpdGVzLCB3aGljaCBjb3VsZCBhY2NpZGVudGFsbHkgZml4IHNvbWV0aGluZyAo
UENJZSByNS4wLCBzZWMNCj4gMi4yLjkpLg0KDQpUaGFua3MgQmpvcm4uIEl0IG1ha2VzIHBlcmZl
Y3Qgc2Vuc2UhDQo+IA0KPiA+ID4gVGhlIE1NSU8gcmVhZCB0aGF0IHNpZ25hbHMgdGhlIE1SUEMg
c3RhdHVzIGFsd2F5cyByZXR1cm5zIH4wIGFuZA0KPiA+ID4gdGhlDQo+ID4gPiB1c2Vyc3BhY2Ug
cmVxdWVzdCB3aWxsIGV2ZW50dWFsbHkgdGltZSBvdXQuDQo+ID4gDQo+ID4gVGhlIHByb2JsZW0g
aW4gdGhpcyBjYXNlIGlzIHRoYXQsIGluIERNQSBNUlBDIG1vZGUsIHRoZSBzdGF0dXMgKGluDQo+
ID4gaG9zdA0KPiA+IG1lbW9yeSkgaXMgYWx3YXlzIGluaXRpYWxpemVkIHRvICdpbiBwcm9ncmVz
cycsIGFuZCBpdCdzIHVwIHRvIHRoZQ0KPiA+IGZpcm13YXJlIHRvIHVwZGF0ZSBpdCB0byAnZG9u
ZScgYWZ0ZXIgdGhlIGNvbW1hbmQgaXMgZXhlY3V0ZWQgaW4NCj4gPiB0aGUNCj4gPiBmaXJtd2Fy
ZS4gQWZ0ZXIgYSBmaXJtd2FyZSByZXNldCBpcyBwZXJmb3JtZWQsIHRoZSBmaXJtd2FyZSBjYW5u
b3QNCj4gPiBiZQ0KPiA+IHRyaWdnZXJlZCB0byBzdGFydCBhIE1SUEMgY29tbWFuZCwgdGhlcmVm
b3JlIHRoZSBzdGF0dXMgaW4gaG9zdA0KPiA+IG1lbW9yeQ0KPiA+IHJlbWFpbnMgJ2luIHByb2dy
ZXNzJyBpbiB0aGUgZHJpdmVyLCB3aGljaCBwcmV2ZW50cyBhIE1SUEMgZnJvbQ0KPiA+IHRpbWlu
Zw0KPiA+IG91dC4gSSBzaG91bGQgaGF2ZSBpbmNsdWRlZCB0aGlzIGluIHRoZSBtZXNzYWdlLg0K
PiANCj4gSSAqdGhvdWdodCogdGhlIHByb2JsZW0gd2FzIHRoYXQgdGhlIFBDSWUgTWVtb3J5IFJl
YWQgZmFpbGVkIGFuZCB0aGUNCj4gUm9vdCBDb21wbGV4IGZhYnJpY2F0ZWQgfjAgZGF0YSB0byBj
b21wbGV0ZSB0aGUgQ1BVIHJlYWQuICBCdXQgbm93DQo+IEknbQ0KPiBub3Qgc3VyZSwgYmVjYXVz
ZSBpdCBzb3VuZHMgbGlrZSBpdCBtaWdodCBiZSB0aGF0IHRoZSBQQ0llDQo+IHRyYW5zYWN0aW9u
DQo+IHN1Y2NlZWRzLCBidXQgaXQgcmVhZHMgZGF0YSB0aGF0IGhhc24ndCBiZWVuIHVwZGF0ZWQg
YnkgdGhlIGZpcm13YXJlLA0KPiBpLmUuLCBpdCByZWFkcyAnaW4gcHJvZ3Jlc3MnIGJlY2F1c2Ug
ZmlybXdhcmUgaGFzbid0IHVwZGF0ZWQgaXQgdG8NCj4gJ2RvbmUnLg0KPiANCj4gQmpvcm4NCg0K
VGhlIG9yaWdpbmFsIG1lc3NhZ2Ugd2FzIHNvcnQgb2YgbWlzbGVhZGluZy4gQWZ0ZXIgYSBmaXJt
d2FyZSByZXNldCwNCkNQVSBnZXR0aW5nIH4wIGZvciB0aGUgUENJZSBNZW1vcnkgUmVhZCBkb2Vz
bid0IGV4cGxhaW4gdGhlIGhhbmcuIEluIGENCk1SUEMgZXhlY3V0aW9uIChETUEgTVJQQyBtb2Rl
KSwgdGhlIE1SUEMgc3RhdHVzIHdoaWNoIGlzIGxvY2F0ZWQgaW4gdGhlDQpob3N0IG1vZW1vcnks
IGdldHMgaW5pdGlhbGl6ZWQgYnkgdGhlIENQVSBhbmQgdXBkYXRlZC9maW5pbGl6ZWQgYnkgdGhl
DQpmaXJtd2FyZS4gSW4gdGhlIHNpdHVhdGlvbiBvZiBhIGZpcm13YXJlIHJlc2V0LCBhbnkgTVJQ
QyBpbml0aWF0ZWQNCmFmdGVyd2FyZHMgd2lsbCBub3QgZ2V0IHRoZSBzdGF0dXMgdXBkYXRlZCBi
eSB0aGUgZmlybXdhcmUgcGVyIHRoZQ0KcmVhc29uIHlvdSBwb2ludGVkIG91dCBhYm92ZSAob3Ig
c2ltaWxhciwgdG8gbXkgdW5kZXJzdGFuZGluZywgZmlybXdhcmUNCmNhbiBubyBsb25nZXIgRE1B
IGRhdGEgdG8gaG9zdCBtZW1vcnkgaW4gc3VjaCBjYXNlcyksIHRoZXJlZm9yZSB0aGUNCk1SUEMg
ZXhlY3V0aW9uIHdpbGwgbmV2ZXIgZW5kLg0KDQoNCktlbHZpbg0KDQo=
