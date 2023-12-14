Return-Path: <linux-pci+bounces-979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6C812AF7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA601F21259
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5725764;
	Thu, 14 Dec 2023 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="guC/ZiTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43910C;
	Thu, 14 Dec 2023 01:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5TuH6qm9sIaFJo9n3S0YOhfFMHRGf7qw6yT+OVI8Kwf+bjfjwEw1MWJfAigsBdlA7UG2S3RkzDF4Y9psNom4+DbiT0+X4zJjoDEKEkAnzHFMdS4rnbZyME4bQ87n1SzD2DarOihT9QlGKbq/ZYVcpWq8oErpA2i1c9bTy5hXH8TLvpReU9gV1S7eF3hcdvgwzEPSzN3KW8dSXvPvSLsVhKP2RhzOBrw9bKf7K+FK7mcMTwuoThFdmicKBEWiAE5dkgAmQwd2QpSz9u+Ftj+gQaWP+Uc2WJsJAuF5oRqVJEQ9nN4gYZFscvWnDzwMfChmwi7mMydqyNMnj8/NcU4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiD1twIm+7M1Z3FKTgqVyLuFi2s6IY/iZq7/xn5tyCk=;
 b=F/ZtMkJXDGlaE7xIZZ6OrTPWGnWi+CowOOlxwDOP6hsaivyFHwLcHOk7jO5f+P18Ksbi+jaLtKzgAYWolMYQAznd1hGrU2m7YhLFY06qC1RCXe0EEJuXurVSwnAdIdAF/Z1Z0ePM+QNCv+56LViQ8PvtPiCpK2pghzcm+K6zHgFXnWfhrmgTcHJwkZYQrc4fSauSRKiM2KMSIrBStoswiU1R3bMeRl1claP+ZLUSIu3mIvLAS+Bs6Y+4tpFAffCaBSyyV7DPb2O+D7uYiumgDINt2FjQv1y8LnG32cb0p4+vuUc9VQ4/8ReNFk+/za70APlLSI+59fReAYfWoHE7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiD1twIm+7M1Z3FKTgqVyLuFi2s6IY/iZq7/xn5tyCk=;
 b=guC/ZiTYbzVQ80E15lPVZu3IRZOHUiGPO1Tupo697FXEdwBLS356w7WKI1tGBo/7CAwZ3IrLvtlLez6pBjCsfIQi1kQj7MrzUhzn6sRDPeRBxcJ+vN1ynl15712sC2H6KZMywB5eGT3NGIOKG8t196hJrvXzsrXlcZVBEVRmkfU=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 09:03:26 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 09:03:26 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Topic: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Index:
 AQHaK4Q534ViUL7xiE2p4ymr6ObEurCkX+6AgAFU/YD//6xNgIABr6aAgAATSoCAAcFZAP//l6EAgACJ0wA=
Date: Thu, 14 Dec 2023 09:03:26 +0000
Message-ID:
 <BL1PR12MB5849A269A09CB3837F2B3FA9E78CA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com> <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXglU0EtBrRNiWVp@macbook>
 <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXmfmbb4S8Iuy7si@macbook>
 <BL1PR12MB584911B4DFF4D9ED65CF92F0E78CA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXrA_OocbBkFAkM-@macbook>
In-Reply-To: <ZXrA_OocbBkFAkM-@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5364.namprd12.prod.outlook.com
 (15.20.7113.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM8PR12MB5447:EE_
x-ms-office365-filtering-correlation-id: 06a60244-423f-4c64-b84b-08dbfc838850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qBAWReC55Ze/b1bMr4HgNrXkCGrgpJohgc28dt/hgNg5Em+nGoD5JrUNw1z8SudqrYWQZAJt/pD6E7wUDn2gTH7ZVq5jfLEIjBG8x9lH1iC4LnS0BxLZYJmD+WtyuGXDViuQjEIMkjTOsdX2CHM6f4oczF4FCXLy0q85G8NoMVHRoe3Lj/y9OBZhd6lzR3OJjNYyfWCC+08t8N9uhZnPugTV0rHSXBscNsUlaoEQ71JnODRDjygFQoa4Z1YOHFFxYLeCm9cw62SG5xl1kLIp8dM41Lq5OZvQTxNwuM1khZeojqY0Wg7G7FBWd9YChxVGT/ot8CoF3OSnlO8+eOrulojrcsF24jeHESlg903npjFuCnnpLf/m5EEHNWEUJ4TTBE71PnksOQnrnCqHcdNIjrL398HOSXpFXDNTFar9GMDsKkIkWJ/CrhcqS41Jt2PlKts+n2joTRYkXjsDiR4yZ+9WJNq1K2gOUtvhQltretdn72wZB7rFrheD6Qb+RHPJ8FZAgLphdrERHensLn6/nVUNc8BjYgfu6kYmMAJgLhlz8rLgEBIiqzz5H39AGlWO0YMjBv2QFNHeNbSq5vPxTucxl3N4K8u0O34LT/waV4WYjAe+E6+pElvaEdGr9vDK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(9686003)(122000001)(26005)(38100700002)(8676002)(8936002)(52536014)(4326008)(316002)(2906002)(5660300002)(71200400001)(478600001)(53546011)(6506007)(7696005)(41300700001)(6916009)(54906003)(64756008)(66446008)(66476007)(66946007)(66556008)(76116006)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkdWWUNYTnU2dys3UVA0Z0x5ZUM3ay9oWGJOOVhGdUR4VitoWHNKRTVGQ0xh?=
 =?utf-8?B?SlBMWjkycStBNFc2allCQUJiZkt5cTh2b0YvRWg1ajk2VVNXZU8xakJ0T2tY?=
 =?utf-8?B?bHdSZWdUNys4QnFrQjVYckV1bWtWeEk5SmFTL0ZPNlIxUHBWZkgwbWZQL0ww?=
 =?utf-8?B?TFJGeUdoSkozbDYzQWZJQmMrVVNjeEo2MDczVEZEczdrSFNCNUxNWENSbmQw?=
 =?utf-8?B?OFYyMU42ejBBVXVoUytTemJYcVY5cEdYRjBKR2xacDdlWVBETlhGRnRXaFAx?=
 =?utf-8?B?c2w4U2xvNm5rUlVyd1pwSDMvMUpIaWF4QjhOTC9tdDNsbWMxaEFXNVhLL3I4?=
 =?utf-8?B?RmRWWjFPaE5HdktzNmlqOU44MFBzSzVBTVFIbFN0YkxTRlk3Z0RpM0Y2WTVI?=
 =?utf-8?B?a1VvL3RXVUQ1QlI5MXVER0JGdUQ1azF3VWpETVZRZWxNRjNXMW1jTjZhdUhU?=
 =?utf-8?B?ZnJrbmZQZElmRFQxdC9Cc2EwMm5Ua3hiYTBId3dLZzc3QnRKY2VHRXJtYmY0?=
 =?utf-8?B?R2JkeHVCMVJxcEhUWGlIeEFlMjA3SURwMklQRjRjZHdrUkVxN3MwaGYwV1R4?=
 =?utf-8?B?NGVMWERBVnlvcnNKb3NQNzZ4ZHFqMkcrL0V3bHNXVENzMjAvdStFcUk1STBa?=
 =?utf-8?B?V0hwVmFiS296aXJHeFRCQ0lPU0VMZGptdFA2bXJGN2xvdEdkQ0ZNczJ0dDJz?=
 =?utf-8?B?UzZHTkVZbVJTTklFeFB5NzNJak9XVkFlcHZSUWVjUVpZcVltRUVBaGVuaUZL?=
 =?utf-8?B?amJxRm9hSEROVUZZcDdZNW9EOGJ1NWJFZXkxOGc2QW5CbmVxWTBJT1kvY3BD?=
 =?utf-8?B?ZS92ZVc0elV6T0pHYmRsOGFvRGo5d05rMlRJeUZyUHh3QjlZMDhNRWd3Z0h3?=
 =?utf-8?B?VzFsVTdUdjQ5aEJpRGdEUEhNdE9qY0dOMWwzWE0wM2R4R2RYVU9Ca2NNY0to?=
 =?utf-8?B?RVhRUEVjTzdqSDhQTU1VVGhtZGJwdmFiYmtpS09telJwUCtYWnlQN05jcjRx?=
 =?utf-8?B?MnpaVFZGZDVoVEJlSXRBR0VBR0dFbFlCRFFJbmFsOHlGTFRUY2QwMUlzYkpx?=
 =?utf-8?B?ZFNvU1puMGp6TlA3UGZqc2lMekpYcTZBYWtEMXZtV2o2VFNJd2FhRVh3WU1Q?=
 =?utf-8?B?RFpBZHhNU1MxajR4SlMzdk9CU3lHNGl6UHA1OERzZ0N6OUNDbUMxaWdZSHNH?=
 =?utf-8?B?UEE2ZFlXZnQrc1dhM1cxMFJMZ2RMUmk2Ym15RFczUTJMZWlkWEpkeXFaNVd5?=
 =?utf-8?B?WGtYWXMwd3kzR21XSDQ2aFNzL1FxdU96akdseEdZWlpYaUZqMHNjcHRxVVpY?=
 =?utf-8?B?bHdoeWd1YWt5eVpmTEhjNTdSWGdhNGZSU2lQK0J2WHZYMHVYZWlNL1pIamN2?=
 =?utf-8?B?R0pFYk5wVzFFYy9CS3J5VitVWEpDaVByMHZrRnJsTFpDbDRDckRJdG4xVkdo?=
 =?utf-8?B?a0hMWkZkcXBzOU9LZ1NUZEMrYkY3TTdRSUY5aDVQM3RPSzEyUm03UFpMOU13?=
 =?utf-8?B?RSt3eUJYR1NrSkV4NGhuMFRjNzkwd0N1RSt1OHdnQ09ZMVB1YjRDUjZuMWZF?=
 =?utf-8?B?QWtkM3ZweEhReGtVcHl4OVdpem4rM3NzMzFUZG5CT0NPdStRWXMrb0hENWp3?=
 =?utf-8?B?YWZabURaUlFoaERYWEw5dTZmK1dZUVZBYjBKMXNHV2JmeVp3Vm9qRDhwOFlD?=
 =?utf-8?B?eC9LVm84VzBCTXZkdUNVUXdqSGJ3RlRlNnhySFhlNFFPdFpPRXZTZEVFcUhC?=
 =?utf-8?B?Q0o1bGtsYzE1aWJGeUVseS9NbktVNmhtZHB2aDZOWDJYbDRQenJFV0xDRi9G?=
 =?utf-8?B?QjhFUmxhUGg1cTNTdGFWc21qYVg1cExOZHFGdnNsTW5jUk5wa25URXFBa0Vm?=
 =?utf-8?B?blRVNFN5bmRyR09sVzdDQll4L21yU3o3aVlHaXBGVWRWS0lNbjRrenFBU3JK?=
 =?utf-8?B?YWpxd1VsUUVURHYrSFd3dG9MeUc4WmgwV3hja1RkdXhDOTUwdnBocUNFUjEv?=
 =?utf-8?B?anhoRlVRZnFicVNIck1Zd0RCTlBFUDNiM1RLTDNjMS9NV294Ukh1K3NqNytY?=
 =?utf-8?B?VkE5bmJvelQyZXY4Q2V4NS84aXJlRnNUeGJPbWZYeENXdEIyMThoTE9URlcr?=
 =?utf-8?Q?JzoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D00D119ED4F2D4CB926337B6C059E16@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a60244-423f-4c64-b84b-08dbfc838850
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 09:03:26.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL7DoG0DRKanJiXGGpi2ldKXBWkpI7Gth9o1uNAVmXaMG9E1f5YVfY7JI/GsQPRmVjePANYhzwxkcJFCid79LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447

T24gMjAyMy8xMi8xNCAxNjo0NiwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gT24gVGh1LCBE
ZWMgMTQsIDIwMjMgYXQgMDc6MDg6MzJBTSArMDAwMCwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4g
T24gMjAyMy8xMi8xMyAyMDoxMiwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+PiBPbiBXZWQs
IERlYyAxMywgMjAyMyBhdCAwMzozMToyMUFNICswMDAwLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+
Pj4+IE9uIDIwMjMvMTIvMTIgMTc6MTgsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+Pj4+PiBP
biBUdWUsIERlYyAxMiwgMjAyMyBhdCAwNjozNDoyN0FNICswMDAwLCBDaGVuLCBKaXFpYW4gd3Jv
dGU6DQo+Pj4+Pj4NCj4+Pj4+PiBPbiAyMDIzLzEyLzEyIDAxOjU3LCBSb2dlciBQYXUgTW9ubsOp
IHdyb3RlOg0KPj4+Pj4+PiBPbiBNb24sIERlYyAxMSwgMjAyMyBhdCAxMjoxNToxOUFNICswODAw
LCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+Pj4+Pj4+IFRoZXJlIGlzIGEgbmVlZCBmb3Igc29tZSBz
Y2VuYXJpb3MgdG8gdXNlIGdzaSBzeXNmcy4NCj4+Pj4+Pj4+IEZvciBleGFtcGxlLCB3aGVuIHhl
biBwYXNzdGhyb3VnaCBhIGRldmljZSB0byBkdW1VLCBpdCB3aWxsDQo+Pj4+Pj4+PiB1c2UgZ3Np
IHRvIG1hcCBwaXJxLCBidXQgY3VycmVudGx5IHVzZXJzcGFjZSBjYW4ndCBnZXQgZ3NpDQo+Pj4+
Pj4+PiBudW1iZXIuDQo+Pj4+Pj4+PiBTbywgYWRkIGdzaSBzeXNmcyBmb3IgdGhhdCBhbmQgZm9y
IG90aGVyIHBvdGVudGlhbCBzY2VuYXJpb3MuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQ28tZGV2ZWxv
cGVkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4+PiAtLS0NCj4+
Pj4+Pj4+ICBkcml2ZXJzL2FjcGkvcGNpX2lycS5jICB8ICAxICsNCj4+Pj4+Pj4+ICBkcml2ZXJz
L3BjaS9wY2ktc3lzZnMuYyB8IDExICsrKysrKysrKysrDQo+Pj4+Pj4+PiAgaW5jbHVkZS9saW51
eC9wY2kuaCAgICAgfCAgMiArKw0KPj4+Pj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGNp
X2lycS5jIGIvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0KPj4+Pj4+Pj4gaW5kZXggNjMwZmUwYTM0
YmM2Li43MzlhNTg3NTVkZjIgMTAwNjQ0DQo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2FjcGkvcGNp
X2lycS5jDQo+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+Pj4+Pj4+PiBA
QCAtNDQ5LDYgKzQ0OSw3IEBAIGludCBhY3BpX3BjaV9pcnFfZW5hYmxlKHN0cnVjdCBwY2lfZGV2
ICpkZXYpDQo+Pj4+Pj4+PiAgCQlrZnJlZShlbnRyeSk7DQo+Pj4+Pj4+PiAgCQlyZXR1cm4gMDsN
Cj4+Pj4+Pj4+ICAJfQ0KPj4+Pj4+Pj4gKwlkZXYtPmdzaSA9IGdzaTsNCj4+Pj4+Pj4NCj4+Pj4+
Pj4gSXQgd291bGQgYmUgYmV0dGVyIGlmIHRoZSBnc2kgaWYgZmV0Y2hlZCB3aXRob3V0IHJlcXVp
cmluZyBjYWxsaW5nDQo+Pj4+Pj4+IGFjcGlfcGNpX2lycV9lbmFibGUoKSwgYXMgdGhlIGdzaSBk
b2Vzbid0IHJlcXVpcmUgdGhlIGludGVycnVwdCB0byBiZQ0KPj4+Pj4+PiBlbmFibGVkLiAgVGhl
IGdzaSBpcyBrbm93biBhdCBib290IHRpbWUgYW5kIHdvbid0IGNoYW5nZSBmb3IgdGhlDQo+Pj4+
Pj4+IGxpZmV0aW1lIG9mIHRoZSBkZXZpY2UuDQo+Pj4+Pj4gRG8geW91IGhhdmUgYW55IHN1Z2dl
c3QgcGxhY2VzIHRvIGRvIHRoaXM/DQo+Pj4+Pg0KPj4+Pj4gSSdtIG5vdCBhbiBleHBlcnQgb24g
dGhpcywgYnV0IGRyaXZlcnMvcGNpL3BjaS1zeXNmcy5jIHdvdWxkIHNlZW0gbGlrZQ0KPj4+Pj4g
YSBiZXR0ZXIgcGxhY2UsIHRvZ2V0aGVyIHdpdGggdGhlIHJlc3Qgb2YgdGhlIHJlc291cmNlcy4N
Cj4+Pj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoaXMgdG9vLiBCdXQgaXQgc2VlbXMgcGNpLXN5
c2ZzLmMgb25seSBjcmVhdGVzIHN5c2ZzIG5vZGUgYW5kIHN1cHBvcnRzIHRoZSByZWFkL3dyaXRl
IG1ldGhvZCB3aXRob3V0IGluaXRpYWxpemluZyB0aGUgdmFsdWVzLg0KPj4+PiBJZiB3YW50IHRv
IGluaXRpYWxpemUgdGhlIHZhbHVlIG9mIGdzaSBoZXJlLiBBbiBhcHByb2FjaCB0byBpbml0aWFs
aXplIGl0IGlzIHRvIGNhbGwgYWNwaV9wY2lfaXJxX2xvb2t1cCB0byBnZXQgZ3NpIG51bWJlciB3
aGVuIHRoZSBmaXJzdCB0aW1lIGl0IGlzIHJlYWQ/DQo+Pj4NCj4+PiBIbSwgbWF5YmUsIEkgZG9u
J3QgcmVhbGx5IGhhdmUgbXVjaCBleHBlcmllbmNlIHdpdGggc3lzZnMsIHNvIGRvbid0DQo+Pj4g
a25vdyBob3cgbm9kZXMgYXJlIHVzdWFsbHkgaW5pdGlhbGl6ZWQuDQo+PiBNYXliZSB0aGUgbWFp
bnRhaW5lcnMgb2Ygc3lzZnMgY2FuIGdpdmUgc29tZSBzdWdnZXN0IHBsYWNlcyB0byBpbml0aWFs
aXplIHRoZSB2YWx1ZSBvZiBnc2kuDQo+Pg0KPj4+DQo+Pj4+Pg0KPj4+Pj4gTWF5YmUgbXkgdW5k
ZXJzdGFuZGluZyBpcyBpbmNvcnJlY3QsIGJ1dCBnaXZlbiB0aGUgc3VnZ2VzdGVkIHBsYWNlbWVu
dA0KPj4+Pj4gaW4gYWNwaV9wY2lfaXJxX2VuYWJsZSgpIEkgdGhpbmsgdGhlIGRldmljZSB3b3Vs
ZCBuZWVkIHRvIGJpbmQgdGhlDQo+Pj4+PiBpbnRlcnJ1cHQgaW4gb3JkZXIgZm9yIHRoZSBnc2kg
bm9kZSB0byBhcHBlYXIgb24gc3lzZnM/DQo+Pj4+IE5vLCBnc2kgc3lzZnMgaGFzIGV4aXN0ZWQg
dGhlcmUsIGluIGFjcGlfcGNpX2lycV9lbmFibGUgaXMgdG8gaW5pdGlhbGl6ZSB0aGUgdmFsdWUg
b2YgZ3NpLg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+IFdvdWxkIHRoZSBjdXJyZW50IGFwcHJvYWNoIHdv
cmsgaWYgdGhlIGRldmljZSBpcyBhc3NpZ25lZCB0byBwY2liYWNrDQo+Pj4+PiBvbiB0aGUga2Vy
bmVsIGNvbW1hbmQgbGluZSwgYW5kIHRodXMgbmV2ZXIgb3duZWQgYnkgYW55IGRyaXZlciBpbg0K
Pj4+Pj4gZG9tMD8NCj4+Pj4gSWYgYXNzaWduZWQgdG8gcGNpYmFjaywgSSB0aGluayBwY2liYWNr
IHdpbGwgZW5hYmxlIHRoZSBkZXZpY2UsIGFuZCB0aGVuIGFjcGlfcGNpX2lycV9lbmFibGUgd2ls
bCBiZSBjYWxsZWQsIGFuZCB0aGVuIHRoZSBnc2kgd2lsbCBiZSBpbml0aWFsaXplZC4gU28sIGN1
cnJlbnQgY2FuIHdvcmsuDQo+Pj4NCj4+PiBUaGlzIG5lZWRzIGNoZWNraW5nIHRvIGJlIHN1cmUs
IEknbSBjZXJ0YWlubHkgbm90IHRoYXQgZmFtaWxpYXIuICBZb3UNCj4+PiB3b3VsZCBuZWVkIHRv
IGF0IGxlYXN0IHRlc3QgdGhhdCBpdCB3b3JrcyBwcm9wZXJseSB3aGVuIHRoZSBkZXZpY2UgaXMN
Cj4+PiBoaWRkZW4gdXNpbmcgeGVuLXBjaWJhY2suaGlkZT0oU0JERikgaW4gdGhlIExpbnV4IGtl
cm5lbCBjb21tYW5kIGxpbmUuDQo+PiBTdXJlLCBJIGhhdmUgdmFsaWRhdGVkIGl0IG9uIG15IHNp
ZGUuIEJvdGggdGhlICJTdGF0aWMgYXNzaWdubWVudCBmb3IgYnVpbHQtaW4geGVuLXBjaWJhY2so
eGVuLXBjaWJhY2suaGlkZT0oU0JERikpIiBhbmQgdGhlICJEeW5hbWljIGFzc2lnbm1lbnQgd2l0
aCB4bChzdWRvIG1vZHByb2JlIHhlbi1wY2liYWNrICYgc3VkbyB4bCBwY2ktYXNzaWduYWJsZS1h
ZGQgU0JERikiIGNhbiB3b3JrIGZpbmUgd2l0aCBjdXJyZW50IGltcGxlbWVudGF0aW9uLg0KPiAN
Cj4gT2gsIE9LLCBpZiB0aGF0J3MgdGhlIGNhc2UgSSBkb24ndCBoYXZlIG11Y2ggb2JqZWN0aW9u
IGluIGRvaW5nIHRoZQ0KPiBpbml0aWFsaXphdGlvbiBpbiBhY3BpX3BjaV9pcnFfZW5hYmxlKCks
IHRoYXQncyBhbiBpbnRlcm5hbCBMaW51eA0KPiBkZXRhaWwuICBJIG1vc3RseSBjYXJlIGFib3V0
IHRoZSBHU0kgYmVpbmcgZXhwb3NlZCBpbiBzeXNmcyBpbiBhDQo+IG5vbi1YZW4gc3BlY2lmaWMg
d2F5Lg0KWWVzLCBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGEgTGludXggaW50ZXJuYWwgd2F5
LCBub3QgYSBYZW4gc3BlY2lmaWMuIEluIGJhcmVtZXRhbCBMaW51eCwgSSBhbHNvIGNhbiBzZWUg
Z3NpIHN5c2ZzLiBUaGFuayB5b3UuDQoNCj4gDQo+IFRoYW5rcywgUm9nZXIuDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

