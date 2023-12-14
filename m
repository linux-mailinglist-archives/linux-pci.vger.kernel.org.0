Return-Path: <linux-pci+bounces-948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68448128C3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 08:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CAF1F21691
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8194BD536;
	Thu, 14 Dec 2023 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XbcMcx0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E4B9;
	Wed, 13 Dec 2023 23:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE1cyh8UOHjttsOswOT5CFBPpCnxOyWGrUoL1gk8lwkXynC6OZhr+Ma1vq6g0VXUk/Km5lIQhp9+bcyRV+kno2ExI/VfpNi2UUvO0jFXZ34lW75+pnO+InUmimq59Q00RZQUielAdU7EYZOc8MSIA4jusaDukRkmEnEo02nXXzuC/mKLGKVrLBqTfj/08gjEIndLWqy5BfaQwORN2zbW+x5Rwp6M2eUS/mFtcHKVAhpSworzLswSiy73JqgC8mbP2nMQxP6e6CJLWYgwdztbEhgDAe4nnEcL1QCSgsNIstPFmrDrpUC7Fsj9L+vjbGeg7R9b7nvsLWQhIkxUP0tKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJnuVdnySQ5WBlK3eXqbHIn+m45C0uBgaqmgii4zrsQ=;
 b=Zts83f/tvmXtzxwBsVE0hMitatBZLNjGVuuS1FN20SgNT0NldjqvLj/s85SEnFNiRR7gRVdd3Ipe4cP8PDUD1fWETr8ZUI4/BvzIYf5LagfA0xWUS7IYyG7S1zNlDqdVyzw63j/VuAofN9c86nWBm8YyYkcFhl3a1A9d/xbXBPG6wVv+lqI2kupGgHMlEDHiDImWKaEPKnKgalRa1QV00s5cH3fvaK0SKE8ZsQ/AlyuWAsvt2EXWm88fbwwgKypt4Zx3ANdGcuxgR3QKWKx2YJJaA8sx+ZgYbzKfDaoS1bomJ+b4XeZIg/DX6J1NbisRXg+ipr9Y6GcJg0VX73r7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJnuVdnySQ5WBlK3eXqbHIn+m45C0uBgaqmgii4zrsQ=;
 b=XbcMcx0/uwTlaqy+BCVPdliPgALMlr+W6eijhnqw8qkptfNIebyq/17NVnrkLhLQWnHKzJiZkPsP2QzlggBwX1o2oxAngov1e3puV3aoklvOpGPgDv9emuw0nBOwcL+OVRqllyd3Neu2ZF2iOUSegEaELKM5H6et6f3AUk5roi8=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 07:08:32 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 07:08:32 +0000
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
 AQHaK4Q534ViUL7xiE2p4ymr6ObEurCkX+6AgAFU/YD//6xNgIABr6aAgAATSoCAAcFZAA==
Date: Thu, 14 Dec 2023 07:08:32 +0000
Message-ID:
 <BL1PR12MB584911B4DFF4D9ED65CF92F0E78CA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com> <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXglU0EtBrRNiWVp@macbook>
 <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXmfmbb4S8Iuy7si@macbook>
In-Reply-To: <ZXmfmbb4S8Iuy7si@macbook>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH0PR12MB8176:EE_
x-ms-office365-filtering-correlation-id: a522719f-9363-47a9-0123-08dbfc737b64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CNokCmMLiAcB2OpIIMQImCJ6Ko5EHTFKBBfMAFkLACMGz2hevDcEDdZVf3CCxPubDR+fiKrJzEhppLj6B6Ld7NGqmOkN+wHgrtu2SdVmL4boalFPnxOtHx0sa2GpbhKdAUzqqfZ148t/Cak8I6ZtLLBAVoR7z5N+TcwkrC/5cU7FEyXeR25DfKnybzvrhYY9LHkts6CWIC+J1qIkG9QZDNkROuMwjLiU3pgWWzkShrxSsPPbAHAb3smw6qJ0D+DA7zemv3gQ3P9FtrWr77eUTyy4E79DqFcvrUbbU/xD+bvyuVMPJQNGfeE4FDB1/BpCjd/zuK0whU7tdJXkDGtW8MG38ILni3uCrcfTwgG8GsBjFoQpTAg/8BBgmYsu75rQNuSGSlbw39Z2R3gHqHq7j0iJ5TSND5OnYgKnac8ZlS++XFKtIyURrDvGpPM7JHllFHefQ6MoLam0jDON+1/XUi/eePIKZZaWsN5Al4LlfqifJCpqSy038/Y75qzwmIcpVrwoGZJc7rUiAxsHc2Rjxgf1Bcd7Dx8bBR+Az/BgXcp5nam3ybAX0GjEOyv0Tiukz1gJNeHUsnEDS9IFalidSePBE86twzIyJEQARulapCkM7esYgugfC+AEYlrstQJ2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(122000001)(2906002)(38100700002)(33656002)(38070700009)(41300700001)(4326008)(8936002)(8676002)(9686003)(71200400001)(478600001)(83380400001)(54906003)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(316002)(6916009)(7696005)(6506007)(53546011)(5660300002)(55016003)(52536014)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmZvWG9oWFZodVY5bUlkb1l6cDFlWVRmbjRYK2pmaytEUUMxRGJMNE1Sb0Nj?=
 =?utf-8?B?QzUzSXZtYmIrdFJQSDNySUhvajNjblBPczZHT1d0ajdwVjJORHRqZ0ZkRzhU?=
 =?utf-8?B?RlV6NmxSTTE3Y094WTByWlVEM1RPTmNpSGlHSXNuNlh6S1ZwUzV5dHUwZ2xI?=
 =?utf-8?B?NndKZWM2U3dYdFBHcHh4UEFjWTZiTXNjU0ZOYXdiSHI3YitzczcwZTJPWUVs?=
 =?utf-8?B?dzdLanZIcFpsSWMxeWF3U3djL2FwRGdWVW0vWjNORk9xU1pib2pRc0kxQUk0?=
 =?utf-8?B?WHc1NTcwWU5vdVI1THloMGJaMUV4ZktUMXhTSkxyME5aQkRoTXVSV1RGNnJr?=
 =?utf-8?B?VjdTV1dNZW5PZnRPaC8vaVpLcnZSczFTMmVpYzNHV2NSZy9jczZiZ0ZVcnVl?=
 =?utf-8?B?eUNnVnNWb1pQTHZQWmxGdDAvNEtDM2luWGdJei9UWlo0RU1IQ2h4bDdWdEsy?=
 =?utf-8?B?OWJYdUI2MXBVWnNMRE5FSXFPcEJnazhPVTlpY0hPZlQvVURSNmtXQzRzZDJi?=
 =?utf-8?B?WExxcmY5dkUzek1YSkNXL2taL0pSZUJJL3JHS3hXS3ZRSXVkQVhLNXB6WmYv?=
 =?utf-8?B?QkpIeTVsK2tXbmQ1em9DclhQNkRLSkhCV3Z6VW10aERscERuY0h4U05GYjE2?=
 =?utf-8?B?WWZrV0h4aUtPM0Z0NldIVGpsWHZSL1RxWWdyN2RTTzVUVzdKT1dmc3Y2emVC?=
 =?utf-8?B?TFNjeDF5MFhJSXJTbzk3QXRXSVpYNUxQQ2gzTHM3cjdJeVJCdzdXRlBLbU1O?=
 =?utf-8?B?N2V3TktpUUl0QnVERmo2N2ZYS0hDVW5qbjJtMzd3dVBEOG1oRTYwSkpuWjh1?=
 =?utf-8?B?Sjd6TmtPV2tiVzR6aG5KejZTMUJNYmlJQ0RMdGE4OXJCclBPak1VNFFaZk9O?=
 =?utf-8?B?eXpyM3A4aVEweVNseWEvbTNjbU1NWk53NTAvVG5qUTF0aVB6VDBranZVVndv?=
 =?utf-8?B?R0ZsYjlxM1ZyN0ZDY2ZLR216Q3pjQ3FkK25QOGFSVW9zbGh3cTZEeDNjN01l?=
 =?utf-8?B?UXZibkk2QXY4TW8rcmFTYTdsbllWV0tkUElzbTN6Vjh1NFQyZXFRNHkvdlhU?=
 =?utf-8?B?bm0yWTRZY1lXekduTUR5dDRYeWJDa0NBalFVRXZQZWt3M3pSM3IwRk9sTzhG?=
 =?utf-8?B?SUQyRTVBSHl0MUNZa1dDTVJjd0tUaVdlUmloRFo5NXlHYlpzSlNXR1ZneCt3?=
 =?utf-8?B?c29OS2lYenZvY295VURleS9iNmZhWkFhYU5ER09acTJ3Wktqck91eFZSc3Jt?=
 =?utf-8?B?N0x1V2g4M2tjZHJrUlo4Sm9HWGZlSUFXYUlpaitKTUhLckZQcTdaZ2h3RVBj?=
 =?utf-8?B?WTZVVEhHdzlZWHQzNTloeXM1MHBxd0UvaXkvTEFhMUV4L1ZJK3NqbXdEYWIz?=
 =?utf-8?B?K2dFSEdYaVZ1RmFFcHVCaU9jQ21NN1BtWDVwRUU2ODlYRElvekRWUEpEbGQx?=
 =?utf-8?B?NDJ1VlhjZkJjeEFYcGEway9XdlU5MTVyL0hBZkxMcms4T01oTDNVa25NejJq?=
 =?utf-8?B?TjhUc3ZCYnJqb0FNKzZ3TDZFUVN1bC9HYjJYbVJ0NVdQSTlza2FEL3VQYmJ0?=
 =?utf-8?B?MlpMK2tScU1QWU1Lb2F0OXBDZ3JUbzkvVjViUW1wN2s2U2tkbWp3Umdpc3Bo?=
 =?utf-8?B?cjZBQlJqMkxpUHhOdVRRdzVRR0dUZFgxRUFjQWp3a2dWbGM4cWQ3VHY2QytT?=
 =?utf-8?B?VzlVWi9EU3lFWmowQzZBRzhVNnlyNDM3c2puZW43MFdWZWxIU21wNG42a3VL?=
 =?utf-8?B?UEtWam5iWS9TWEo2VmV2N093dTNFU2lvODdFQnJIK09jNU9QNlFDcVMzYjBi?=
 =?utf-8?B?MVZyUGdFNlVmcTZCT3hMR05ZNGpVNitNNVU1aGc0bEtNWnlQTkgrWjlBQkFF?=
 =?utf-8?B?cXRHd0hwa1dndmxaTFB6WVlJc3hnVHNHRUQxVHFPRWNVOE5SK3ZxaGp5elVS?=
 =?utf-8?B?R3RsaVN1Z0h4T3MvaVlIM0tXU0o1b3Z1Q1g5dFFTS0VEYXZjUlFvVXR4Y2FP?=
 =?utf-8?B?dXU0MUZkMFUzTExiVjFrMllwRjQvWXpJaVRPZk10Wk9aZ3ZYZ0thWWp1NjNL?=
 =?utf-8?B?ZWVUZHJsNGsrY3BacVdaU212aE9rcTV1K1I0NDdncFF5NFlqL1pETjByZTJj?=
 =?utf-8?Q?x1yE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B8CBC3B7490BE418DAAF6685149657A@amdcloud.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a522719f-9363-47a9-0123-08dbfc737b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 07:08:32.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Fb31fz9i5RzRhT6CgSMTkoSCcyFgJvJ+AfYT2ApWqfFpTKjh7Ekeh5TkDktEMhXlezPo7znjKQyFnIHaLVkDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

T24gMjAyMy8xMi8xMyAyMDoxMiwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gT24gV2VkLCBE
ZWMgMTMsIDIwMjMgYXQgMDM6MzE6MjFBTSArMDAwMCwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4g
T24gMjAyMy8xMi8xMiAxNzoxOCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+PiBPbiBUdWUs
IERlYyAxMiwgMjAyMyBhdCAwNjozNDoyN0FNICswMDAwLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+
Pj4+DQo+Pj4+IE9uIDIwMjMvMTIvMTIgMDE6NTcsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+
Pj4+PiBPbiBNb24sIERlYyAxMSwgMjAyMyBhdCAxMjoxNToxOUFNICswODAwLCBKaXFpYW4gQ2hl
biB3cm90ZToNCj4+Pj4+PiBUaGVyZSBpcyBhIG5lZWQgZm9yIHNvbWUgc2NlbmFyaW9zIHRvIHVz
ZSBnc2kgc3lzZnMuDQo+Pj4+Pj4gRm9yIGV4YW1wbGUsIHdoZW4geGVuIHBhc3N0aHJvdWdoIGEg
ZGV2aWNlIHRvIGR1bVUsIGl0IHdpbGwNCj4+Pj4+PiB1c2UgZ3NpIHRvIG1hcCBwaXJxLCBidXQg
Y3VycmVudGx5IHVzZXJzcGFjZSBjYW4ndCBnZXQgZ3NpDQo+Pj4+Pj4gbnVtYmVyLg0KPj4+Pj4+
IFNvLCBhZGQgZ3NpIHN5c2ZzIGZvciB0aGF0IGFuZCBmb3Igb3RoZXIgcG90ZW50aWFsIHNjZW5h
cmlvcy4NCj4+Pj4+Pg0KPj4+Pj4+IENvLWRldmVsb3BlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVh
bmdAYW1kLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNo
ZW5AYW1kLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgZHJpdmVycy9hY3BpL3BjaV9pcnEuYyAg
fCAgMSArDQo+Pj4+Pj4gIGRyaXZlcnMvcGNpL3BjaS1zeXNmcy5jIHwgMTEgKysrKysrKysrKysN
Cj4+Pj4+PiAgaW5jbHVkZS9saW51eC9wY2kuaCAgICAgfCAgMiArKw0KPj4+Pj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2FjcGkvcGNpX2lycS5jIGIvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0KPj4+Pj4+IGlu
ZGV4IDYzMGZlMGEzNGJjNi4uNzM5YTU4NzU1ZGYyIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZl
cnMvYWNwaS9wY2lfaXJxLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+
Pj4+Pj4gQEAgLTQ0OSw2ICs0NDksNyBAQCBpbnQgYWNwaV9wY2lfaXJxX2VuYWJsZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQ0KPj4+Pj4+ICAJCWtmcmVlKGVudHJ5KTsNCj4+Pj4+PiAgCQlyZXR1cm4g
MDsNCj4+Pj4+PiAgCX0NCj4+Pj4+PiArCWRldi0+Z3NpID0gZ3NpOw0KPj4+Pj4NCj4+Pj4+IEl0
IHdvdWxkIGJlIGJldHRlciBpZiB0aGUgZ3NpIGlmIGZldGNoZWQgd2l0aG91dCByZXF1aXJpbmcg
Y2FsbGluZw0KPj4+Pj4gYWNwaV9wY2lfaXJxX2VuYWJsZSgpLCBhcyB0aGUgZ3NpIGRvZXNuJ3Qg
cmVxdWlyZSB0aGUgaW50ZXJydXB0IHRvIGJlDQo+Pj4+PiBlbmFibGVkLiAgVGhlIGdzaSBpcyBr
bm93biBhdCBib290IHRpbWUgYW5kIHdvbid0IGNoYW5nZSBmb3IgdGhlDQo+Pj4+PiBsaWZldGlt
ZSBvZiB0aGUgZGV2aWNlLg0KPj4+PiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdCBwbGFjZXMgdG8g
ZG8gdGhpcz8NCj4+Pg0KPj4+IEknbSBub3QgYW4gZXhwZXJ0IG9uIHRoaXMsIGJ1dCBkcml2ZXJz
L3BjaS9wY2ktc3lzZnMuYyB3b3VsZCBzZWVtIGxpa2UNCj4+PiBhIGJldHRlciBwbGFjZSwgdG9n
ZXRoZXIgd2l0aCB0aGUgcmVzdCBvZiB0aGUgcmVzb3VyY2VzLg0KPj4gSSdtIG5vdCBmYW1pbGlh
ciB3aXRoIHRoaXMgdG9vLiBCdXQgaXQgc2VlbXMgcGNpLXN5c2ZzLmMgb25seSBjcmVhdGVzIHN5
c2ZzIG5vZGUgYW5kIHN1cHBvcnRzIHRoZSByZWFkL3dyaXRlIG1ldGhvZCB3aXRob3V0IGluaXRp
YWxpemluZyB0aGUgdmFsdWVzLg0KPj4gSWYgd2FudCB0byBpbml0aWFsaXplIHRoZSB2YWx1ZSBv
ZiBnc2kgaGVyZS4gQW4gYXBwcm9hY2ggdG8gaW5pdGlhbGl6ZSBpdCBpcyB0byBjYWxsIGFjcGlf
cGNpX2lycV9sb29rdXAgdG8gZ2V0IGdzaSBudW1iZXIgd2hlbiB0aGUgZmlyc3QgdGltZSBpdCBp
cyByZWFkPw0KPiANCj4gSG0sIG1heWJlLCBJIGRvbid0IHJlYWxseSBoYXZlIG11Y2ggZXhwZXJp
ZW5jZSB3aXRoIHN5c2ZzLCBzbyBkb24ndA0KPiBrbm93IGhvdyBub2RlcyBhcmUgdXN1YWxseSBp
bml0aWFsaXplZC4NCk1heWJlIHRoZSBtYWludGFpbmVycyBvZiBzeXNmcyBjYW4gZ2l2ZSBzb21l
IHN1Z2dlc3QgcGxhY2VzIHRvIGluaXRpYWxpemUgdGhlIHZhbHVlIG9mIGdzaS4NCg0KPiANCj4+
Pg0KPj4+IE1heWJlIG15IHVuZGVyc3RhbmRpbmcgaXMgaW5jb3JyZWN0LCBidXQgZ2l2ZW4gdGhl
IHN1Z2dlc3RlZCBwbGFjZW1lbnQNCj4+PiBpbiBhY3BpX3BjaV9pcnFfZW5hYmxlKCkgSSB0aGlu
ayB0aGUgZGV2aWNlIHdvdWxkIG5lZWQgdG8gYmluZCB0aGUNCj4+PiBpbnRlcnJ1cHQgaW4gb3Jk
ZXIgZm9yIHRoZSBnc2kgbm9kZSB0byBhcHBlYXIgb24gc3lzZnM/DQo+PiBObywgZ3NpIHN5c2Zz
IGhhcyBleGlzdGVkIHRoZXJlLCBpbiBhY3BpX3BjaV9pcnFfZW5hYmxlIGlzIHRvIGluaXRpYWxp
emUgdGhlIHZhbHVlIG9mIGdzaS4NCj4+DQo+Pj4NCj4+PiBXb3VsZCB0aGUgY3VycmVudCBhcHBy
b2FjaCB3b3JrIGlmIHRoZSBkZXZpY2UgaXMgYXNzaWduZWQgdG8gcGNpYmFjaw0KPj4+IG9uIHRo
ZSBrZXJuZWwgY29tbWFuZCBsaW5lLCBhbmQgdGh1cyBuZXZlciBvd25lZCBieSBhbnkgZHJpdmVy
IGluDQo+Pj4gZG9tMD8NCj4+IElmIGFzc2lnbmVkIHRvIHBjaWJhY2ssIEkgdGhpbmsgcGNpYmFj
ayB3aWxsIGVuYWJsZSB0aGUgZGV2aWNlLCBhbmQgdGhlbiBhY3BpX3BjaV9pcnFfZW5hYmxlIHdp
bGwgYmUgY2FsbGVkLCBhbmQgdGhlbiB0aGUgZ3NpIHdpbGwgYmUgaW5pdGlhbGl6ZWQuIFNvLCBj
dXJyZW50IGNhbiB3b3JrLg0KPiANCj4gVGhpcyBuZWVkcyBjaGVja2luZyB0byBiZSBzdXJlLCBJ
J20gY2VydGFpbmx5IG5vdCB0aGF0IGZhbWlsaWFyLiAgWW91DQo+IHdvdWxkIG5lZWQgdG8gYXQg
bGVhc3QgdGVzdCB0aGF0IGl0IHdvcmtzIHByb3Blcmx5IHdoZW4gdGhlIGRldmljZSBpcw0KPiBo
aWRkZW4gdXNpbmcgeGVuLXBjaWJhY2suaGlkZT0oU0JERikgaW4gdGhlIExpbnV4IGtlcm5lbCBj
b21tYW5kIGxpbmUuDQpTdXJlLCBJIGhhdmUgdmFsaWRhdGVkIGl0IG9uIG15IHNpZGUuIEJvdGgg
dGhlICJTdGF0aWMgYXNzaWdubWVudCBmb3IgYnVpbHQtaW4geGVuLXBjaWJhY2soeGVuLXBjaWJh
Y2suaGlkZT0oU0JERikpIiBhbmQgdGhlICJEeW5hbWljIGFzc2lnbm1lbnQgd2l0aCB4bChzdWRv
IG1vZHByb2JlIHhlbi1wY2liYWNrICYgc3VkbyB4bCBwY2ktYXNzaWduYWJsZS1hZGQgU0JERiki
IGNhbiB3b3JrIGZpbmUgd2l0aCBjdXJyZW50IGltcGxlbWVudGF0aW9uLg0KDQo+IA0KPiBUaGFu
a3MsIFJvZ2VyLg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

