Return-Path: <linux-pci+bounces-833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121698108C2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 04:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AFB1C20E26
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAD36FD9;
	Wed, 13 Dec 2023 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W/F7nbiZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B1B7;
	Tue, 12 Dec 2023 19:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0KmnSGD+XtvqwhWshbYe5ojnkJq4fVvtGSvTCvwaBpkQi5qPfhPHcxsYrmNk380Jdq3ppya5L9dpNn+Fpe92UDO+OMyJnEZkEAyL6VQNneNBqHglVlcR9b0VCARlJh5RLPORXJlz37KNolSczlQzrZxrX9JiYyJq6WjLYvxjw7YIenRnel8QnwUshXKRGfcv+C2SVTJj4w3/frTJGk42D96XSm6NZ4unjnkDbKenjO+WlqSX4TIYNeF7Nr2lCAbWG4KYErQ9SnoZzrv/5TPom1VuOR2em/6ML0ifdibo5URPWRd21WTMOmsqMy6bhwuxPaFszu1k8E01LjMtIojuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYgQuZUw/YxUYU1oh0lyRWrpXbyROUacQ8m6s5auS74=;
 b=I2gWK+F82a7MhlcyDNMOY62JCrhi345Z6riaFB1Dsvj795J9foVeoKBY+IP3fbRBCQW3o2zLscXAgH8QV8R3OlyUEMytNSpvLaddjcyJ3fdfIm2tDOs4uh0admvJaJ2CaIJQZl+N+a7O+Auwv42cg2cB6uQD3GXCEcRbuoHQM/fqd6dJsTX5KCPwNJNqdmhGOvAEQzxSI9lj9GjyaW7kj3fAIDv3D48bzD10SzBtOSZ7k8+7qlZL200IYUhmki7SCigLKWSPIr0K+p1sFITXEgunDp6nhDffLGrRG2wceM0dBZ/ekNgyT8aEo8k2Mnw8r0hsGkXux8iltxKm4dj1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYgQuZUw/YxUYU1oh0lyRWrpXbyROUacQ8m6s5auS74=;
 b=W/F7nbiZed+MtQhMfdSIXNJb/mvXotb7Bgp/pc6yiblTnzpdFMM0FJVNUlEsDPf/XcKWe0EAP/BFScZRFBWCSxJ8tyzA3I/QSmN/j7iNwF/JLo45T9n6RR1fC6LAPS7asTFSiiGghrZkaobNsF9Bu5t37HRWxKUi8wFgbxjp7pE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 03:31:21 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 03:31:21 +0000
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
Thread-Index: AQHaK4Q534ViUL7xiE2p4ymr6ObEurCkX+6AgAFU/YD//6xNgIABr6aA
Date: Wed, 13 Dec 2023 03:31:21 +0000
Message-ID:
 <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com> <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXglU0EtBrRNiWVp@macbook>
In-Reply-To: <ZXglU0EtBrRNiWVp@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN0PR12MB6151.namprd12.prod.outlook.com
 (15.20.7113.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BL1PR12MB5874:EE_
x-ms-office365-filtering-correlation-id: 20f85686-a2ee-4391-91ab-08dbfb8bf9d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZcHB7floJ0w84FEhlUG/YcoG8n6+WbH/Q1KTCTNEK0hx/eUvffX8QepqsFbZpNrQy1guHf0phLqDnLZVxJC2LoSFrhlwAdO/PDwcISArxedeqlE1aECqdwtH4sw1JUlVuV2G1wiLTj7exYMtnvK88kBQTuV8e+8cnfgsgwpMJPt8ma5gh8XmpKQP6DPPntSLNLvJKvq8iu0ymdy/OyR2jxN/doY/3PQZvcSPEwhmAgp4+DY/ZduNpoWC61ZP9CxPQCgNGUDzjFlJw9ToWENGLf26S60tEKpnbD01lOwEYbRycHXVr4XB8cdKra0ozbj3owMNg0y9/buNQUBVQm6WG1fHYjDl1V1lda/wJXrTBvxQyZO8iIS0Jj5krWkktRObSZVrSWdJ1Tfw+RXx1cJTdChIIYPSDRo7GFEZ+1nWmy4414Ao7mHlaPfIGSlwpGiZTs7bbsJI6CZIsV5108y83KHcWJ1cOVcpEjMvY+nCMjTG3M9U7ipm14KUlevdOCguHj/VKa3CMFBkgZxsKFQ3oBbFVbH9FigIwtnqcxRAwmRy2ddU1YVEUwdlN7OZy5yQ7Q0pFz5sAofVBnIZiTLJTL42yZJB+5bz8i42MtHIpA8FHKSsKlUeadnyefijDmzC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(478600001)(71200400001)(6506007)(7696005)(26005)(9686003)(53546011)(122000001)(38070700009)(38100700002)(33656002)(41300700001)(76116006)(6916009)(66446008)(66476007)(64756008)(5660300002)(2906002)(54906003)(83380400001)(66946007)(66556008)(52536014)(4326008)(316002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anJFTGEvRGg1Yk9LeWlVcWczeXVuL0RzRmhuRHhkemNaQWZTaGIwam5ESkRT?=
 =?utf-8?B?MlpXeEY0WS9jVVYrMlJiQk9BdENpd3ZEZHlVZW9CVlJxTlNzTm9MUmhZRFk4?=
 =?utf-8?B?U1R0ak54Z1M1Rk1PV3ZPUGNxWnI0TGhRYWJXcGZSQ2pEWmRYa0FMVjNjeEdq?=
 =?utf-8?B?bEF4cHJoTUZoRUQvQlVoNW9halFuMjhmekRraWNLc1NPK0hHL3R4Y1Vtd2xT?=
 =?utf-8?B?THhoWnB4UmdzczBmWCtnS2xVb0c2R0hNdEhlSFpMSUVZYmVUcHE5MnhBMjRm?=
 =?utf-8?B?K1ZVQlpOb3pwZVRuUGJscTF3b2RQR1FUckhQZWxROEluYTAzY1hyZkd4cmtv?=
 =?utf-8?B?TklqOTR1bG95Mkk3YTI1Q1RFSDE2WXRsRXM5eXkzejZURHU0a0lQbW4xSjZ1?=
 =?utf-8?B?ald0K1Vmb3dlckpGYXZLNm5Qa24wcHFTN1o3cDR4OWVMUEpONmtqTlJUbHRp?=
 =?utf-8?B?alg2dXpQNklYbDhpcURvdk51Vml1a2p0ZGtTWGJXTS9BMTZZWnNjK2QzekFy?=
 =?utf-8?B?eHdIV05YT0E3bCtnS0dqbGxiYkpDSzYyZDVLWW9laUdYOGlLSUlLWjl0UzU5?=
 =?utf-8?B?RXVDR3RhT0d3b1YxV0RCUmxaVzF6SjNqMXVBdlFOOVhyS29KTFptWXFvZSt3?=
 =?utf-8?B?WnRLdDg2eDErZkJPQnAxazRaUTYwaFhOT3Z0eWQ5anZ3OWM5Wk5NWHI3UUZ5?=
 =?utf-8?B?L0FGM1U3ZUF5SXc2Y1QveFRxSzYxaVpmYmpWQmVQc2tZdElMOVNKeUhaYkRF?=
 =?utf-8?B?R0hDL1MwaVNVcHlnaldiV1NWSURPRE1VbUVHMWI1M01uWlg3ZTJqQmFGSUtL?=
 =?utf-8?B?RHROQnY3c1JmR1B2Y2MrYjdTNnJXWTMwOVZFMjBtaEtjemVNSElJWGlDazZv?=
 =?utf-8?B?VnBnMGIxd0ZrTGZNYzBxcUxqclFDeUxMS1cwK0RCSllwQ0V1bDlVSkVyZzU3?=
 =?utf-8?B?VE50QnJ1UGtvcEJYY2dtc3UrblhoK05UbzhNS0dUQ2FIbnI1dzduTXArT0cz?=
 =?utf-8?B?ZnM1YTcwWXVPVk85UEcwb09SWkR1TkMzOVR3ckx0WWtmeDJ5MVZWWFgvT05t?=
 =?utf-8?B?YnNHWS8wa2QyeGU2c05SVE52VWxOcVB1ZXNadmd4REo0KzVoQVEyMS8yOG5L?=
 =?utf-8?B?SzBtR0tHSFcxeDlYVGxuTEZtN2xFeXhFaGR0N25MMHVGQ1V6aFZxbmNwSHda?=
 =?utf-8?B?OEhIY3ltbnNBV09sNWl0V0tPVTVJRWRNcHBFbkY4K1hNT0svZHJGODF5Vncw?=
 =?utf-8?B?S0N5VG5JQ0hVcWw5bzMvV3Q4NGpkQlNPQ09BTWdzVXNKWTR5WENtTHlmYzVI?=
 =?utf-8?B?S2lvcmYyWjdqRDlsYS80Wk1JbDR2QlBlbEF3OE1hdXlIUFVqL2gyWmtPWS9R?=
 =?utf-8?B?ZzhObjFWTlhsdjZ2ekI4VXBMYUpqRlFaeTBpYmJLRUJxSUg3ZkJiUGZERWJ2?=
 =?utf-8?B?TVV6b2VXbUZTZ1k3KzFkdG9sUnBIbHpZMW1rTitYbklPdkJQdzlSNVp2RGY0?=
 =?utf-8?B?QWEwWFJ3bGF2b1RFVzVkOVZVNzhQK1phdG1acjdRMDAxczNWSTR0UlNtQjA5?=
 =?utf-8?B?NGdDVHRJdjhzcUpXWU1UYWZOaEhrNlZNWjloYktpOXZpWHFvNkg4bjFkc1dh?=
 =?utf-8?B?cWlvRkpYQ05WbURzWE1PazJTNXFkcnQ5NVY5Qk55OHd2eXdQeStCbURSdGtX?=
 =?utf-8?B?OWR3TGUvbWVaeG1xY0JPZVE5VkVtSHoxcHJYeDc0eTBweU9zTEExTFdrdGhq?=
 =?utf-8?B?OVBITHFlWGxLc3NjdmZEYy9yT0NaYnQ0MkZRWVFzTlBnL1VuRmtqbkhiVlor?=
 =?utf-8?B?Rm5UcGpOTVA1blNnMS9zV29XbCtDeGpXVTZyazFYSEdtaStvRWZiei9tNTJT?=
 =?utf-8?B?TVFRVHlJbzVvcytrVFlNVFJnNVJPeWpOWCs0TU40VitpSGZnUHBpRmRnMXBl?=
 =?utf-8?B?Z1JVK3d5enFxK0NRd0JIY2lPcWFLd2ZvRjlEUFBmUk1PT2k3SllSdFFUdXN0?=
 =?utf-8?B?ajRzVUI5RVpxNnVwYysrZmNmUkxHZzl3ZjR5alFPWENNWjVCZitnVkxnMnNK?=
 =?utf-8?B?VXFrVVBaTDcyQmZkVHpNWHlGM09MbWcvT3BqdWFON09tTlZDd1N5UEtXR2ZB?=
 =?utf-8?Q?ey2A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E09FF16BF408DB4994D2147D91EA5D59@amdcloud.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f85686-a2ee-4391-91ab-08dbfb8bf9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 03:31:21.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgkuQ1qFMMaIquj0Kf8mzwDR0ghMHaljl/WYYyAVYdhXZ0tXN346M1CVkCmnw5P+9RUkiVS2/5qxMgalQBdMsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

T24gMjAyMy8xMi8xMiAxNzoxOCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gT24gVHVlLCBE
ZWMgMTIsIDIwMjMgYXQgMDY6MzQ6MjdBTSArMDAwMCwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4N
Cj4+IE9uIDIwMjMvMTIvMTIgMDE6NTcsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+Pj4gT24g
TW9uLCBEZWMgMTEsIDIwMjMgYXQgMTI6MTU6MTlBTSArMDgwMCwgSmlxaWFuIENoZW4gd3JvdGU6
DQo+Pj4+IFRoZXJlIGlzIGEgbmVlZCBmb3Igc29tZSBzY2VuYXJpb3MgdG8gdXNlIGdzaSBzeXNm
cy4NCj4+Pj4gRm9yIGV4YW1wbGUsIHdoZW4geGVuIHBhc3N0aHJvdWdoIGEgZGV2aWNlIHRvIGR1
bVUsIGl0IHdpbGwNCj4+Pj4gdXNlIGdzaSB0byBtYXAgcGlycSwgYnV0IGN1cnJlbnRseSB1c2Vy
c3BhY2UgY2FuJ3QgZ2V0IGdzaQ0KPj4+PiBudW1iZXIuDQo+Pj4+IFNvLCBhZGQgZ3NpIHN5c2Zz
IGZvciB0aGF0IGFuZCBmb3Igb3RoZXIgcG90ZW50aWFsIHNjZW5hcmlvcy4NCj4+Pj4NCj4+Pj4g
Q28tZGV2ZWxvcGVkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+Pj4gLS0tDQo+
Pj4+ICBkcml2ZXJzL2FjcGkvcGNpX2lycS5jICB8ICAxICsNCj4+Pj4gIGRyaXZlcnMvcGNpL3Bj
aS1zeXNmcy5jIHwgMTEgKysrKysrKysrKysNCj4+Pj4gIGluY2x1ZGUvbGludXgvcGNpLmggICAg
IHwgIDIgKysNCj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3BjaV9pcnEuYyBiL2RyaXZlcnMvYWNwaS9w
Y2lfaXJxLmMNCj4+Pj4gaW5kZXggNjMwZmUwYTM0YmM2Li43MzlhNTg3NTVkZjIgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvYWNwaS9wY2lfaXJxLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9hY3Bp
L3BjaV9pcnEuYw0KPj4+PiBAQCAtNDQ5LDYgKzQ0OSw3IEBAIGludCBhY3BpX3BjaV9pcnFfZW5h
YmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+Pj4+ICAJCWtmcmVlKGVudHJ5KTsNCj4+Pj4gIAkJ
cmV0dXJuIDA7DQo+Pj4+ICAJfQ0KPj4+PiArCWRldi0+Z3NpID0gZ3NpOw0KPj4+DQo+Pj4gSXQg
d291bGQgYmUgYmV0dGVyIGlmIHRoZSBnc2kgaWYgZmV0Y2hlZCB3aXRob3V0IHJlcXVpcmluZyBj
YWxsaW5nDQo+Pj4gYWNwaV9wY2lfaXJxX2VuYWJsZSgpLCBhcyB0aGUgZ3NpIGRvZXNuJ3QgcmVx
dWlyZSB0aGUgaW50ZXJydXB0IHRvIGJlDQo+Pj4gZW5hYmxlZC4gIFRoZSBnc2kgaXMga25vd24g
YXQgYm9vdCB0aW1lIGFuZCB3b24ndCBjaGFuZ2UgZm9yIHRoZQ0KPj4+IGxpZmV0aW1lIG9mIHRo
ZSBkZXZpY2UuDQo+PiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdCBwbGFjZXMgdG8gZG8gdGhpcz8N
Cj4gDQo+IEknbSBub3QgYW4gZXhwZXJ0IG9uIHRoaXMsIGJ1dCBkcml2ZXJzL3BjaS9wY2ktc3lz
ZnMuYyB3b3VsZCBzZWVtIGxpa2UNCj4gYSBiZXR0ZXIgcGxhY2UsIHRvZ2V0aGVyIHdpdGggdGhl
IHJlc3Qgb2YgdGhlIHJlc291cmNlcy4NCkknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGlzIHRvby4g
QnV0IGl0IHNlZW1zIHBjaS1zeXNmcy5jIG9ubHkgY3JlYXRlcyBzeXNmcyBub2RlIGFuZCBzdXBw
b3J0cyB0aGUgcmVhZC93cml0ZSBtZXRob2Qgd2l0aG91dCBpbml0aWFsaXppbmcgdGhlIHZhbHVl
cy4NCklmIHdhbnQgdG8gaW5pdGlhbGl6ZSB0aGUgdmFsdWUgb2YgZ3NpIGhlcmUuIEFuIGFwcHJv
YWNoIHRvIGluaXRpYWxpemUgaXQgaXMgdG8gY2FsbCBhY3BpX3BjaV9pcnFfbG9va3VwIHRvIGdl
dCBnc2kgbnVtYmVyIHdoZW4gdGhlIGZpcnN0IHRpbWUgaXQgaXMgcmVhZD8NCg0KPiANCj4gTWF5
YmUgbXkgdW5kZXJzdGFuZGluZyBpcyBpbmNvcnJlY3QsIGJ1dCBnaXZlbiB0aGUgc3VnZ2VzdGVk
IHBsYWNlbWVudA0KPiBpbiBhY3BpX3BjaV9pcnFfZW5hYmxlKCkgSSB0aGluayB0aGUgZGV2aWNl
IHdvdWxkIG5lZWQgdG8gYmluZCB0aGUNCj4gaW50ZXJydXB0IGluIG9yZGVyIGZvciB0aGUgZ3Np
IG5vZGUgdG8gYXBwZWFyIG9uIHN5c2ZzPw0KTm8sIGdzaSBzeXNmcyBoYXMgZXhpc3RlZCB0aGVy
ZSwgaW4gYWNwaV9wY2lfaXJxX2VuYWJsZSBpcyB0byBpbml0aWFsaXplIHRoZSB2YWx1ZSBvZiBn
c2kuDQoNCj4gDQo+IFdvdWxkIHRoZSBjdXJyZW50IGFwcHJvYWNoIHdvcmsgaWYgdGhlIGRldmlj
ZSBpcyBhc3NpZ25lZCB0byBwY2liYWNrDQo+IG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLCBh
bmQgdGh1cyBuZXZlciBvd25lZCBieSBhbnkgZHJpdmVyIGluDQo+IGRvbTA/DQpJZiBhc3NpZ25l
ZCB0byBwY2liYWNrLCBJIHRoaW5rIHBjaWJhY2sgd2lsbCBlbmFibGUgdGhlIGRldmljZSwgYW5k
IHRoZW4gYWNwaV9wY2lfaXJxX2VuYWJsZSB3aWxsIGJlIGNhbGxlZCwgYW5kIHRoZW4gdGhlIGdz
aSB3aWxsIGJlIGluaXRpYWxpemVkLiBTbywgY3VycmVudCBjYW4gd29yay4NCg0KPiANCj4+Pg0K
Pj4+PiAgDQo+Pj4+ICAJcmMgPSBhY3BpX3JlZ2lzdGVyX2dzaSgmZGV2LT5kZXYsIGdzaSwgdHJp
Z2dlcmluZywgcG9sYXJpdHkpOw0KPj4+PiAgCWlmIChyYyA8IDApIHsNCj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5jIGIvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMNCj4+
Pj4gaW5kZXggMjMyMWZkZmVmZDdkLi5jNTFkZjg4ZDA3OWUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Ry
aXZlcnMvcGNpL3BjaS1zeXNmcy5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5j
DQo+Pj4+IEBAIC03MSw2ICs3MSwxNiBAQCBzdGF0aWMgc3NpemVfdCBpcnFfc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+Pj4+ICB9DQo+Pj4+ICBzdGF0aWMgREVWSUNFX0FUVFJfUk8oaXJxKTsN
Cj4+Pj4gIA0KPj4+PiArc3RhdGljIHNzaXplX3QgZ3NpX3Nob3coc3RydWN0IGRldmljZSAqZGV2
LA0KPj4+PiArCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+Pj4+ICsJCQljaGFy
ICpidWYpDQo+Pj4+ICt7DQo+Pj4+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2
KGRldik7DQo+Pj4NCj4+PiBjb25zdA0KPj4gRG8geW91IG1lYW4gImNvbnN0IHN0cnVjdCBwY2lf
ZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOyIgPw0KPiANCj4gWXVwLg0KPiANCj4gVGhhbmtz
LCBSb2dlci4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

