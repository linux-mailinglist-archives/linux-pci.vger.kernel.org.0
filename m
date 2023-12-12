Return-Path: <linux-pci+bounces-786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E0D80E44C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 07:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32641C21AE6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C7AD59;
	Tue, 12 Dec 2023 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4MbVO5EH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2D5C7;
	Mon, 11 Dec 2023 22:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL2hDPAiyDCfmPjftH+tXaSGdQVZ71dCsIvZmxFT1UT5Rm5l/7VnoFZS8y/KAtHQGsIK5zy12du6J4TFyhAv0FJvcKwqyJWJCODUBcNUCoDJuF8jAruf+z1XCyCJ/sF7CP4dWOLImK77TzR2HNhBaoThqV2d/zcTBUw9AOnpUqtf/IXjYbnPy6TygM6hhIdpVjPl2ui83dJ8hgu76QMQEDjz68QLP5GbjgJMHCaG23G/wQ4hd3Q89XrbzGAufvOaqiI/nAHMezH/dQFP2CJnQuzSLn63zDqbCZBMlUO0Ip8B5HbTOKyF9k+o8NFxkMl7+4fN6tsv2kqBRIlssrj8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iu6RluXaBEiJug2WMv3mLeKzXJgvmpet/SzUcI2qXg=;
 b=YCDR4UjJGu15AsAb28JixxCPxO0RnHwgqYF7CmERSfokCMQR1rZ5AQCYWn4b4dRwNuuTEHnyWwSxqMaZvOvytG9yfw0NxcVF5nCYvtvQGoPGfd5VNT+s6MSiypLvD8TLK87JWqnHCgMtYa0xS0+ApWyXwCxIAfmqrpaZaui/1rOq7AsldR90uhvJ64bZuevztmFbbXoxZO5I7si62ngQwbO0Vrfpz3GnHOEzKTth1mf9x6nM6mq2Q3h2cmNh7rjoKpTuvbFXQVI5JnF6qHt/WO+r31jhjcMer+t1fdlGPSlpJ47gNF5HbfbY0cOC8y+DMSQVq28dxODsBNY951mKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iu6RluXaBEiJug2WMv3mLeKzXJgvmpet/SzUcI2qXg=;
 b=4MbVO5EHFCBXXrAx5oAtjNqtsAvmdXs91KaQh5/xPCIxDhCumxmC/dnn5gBN2qMz0p2EjVj9i1kE81rdQZpcUrBU4DCG1EhyUBP5z/CL3c0tH2xYZnC7H//DlQPhOTE0P1KZg+PsPdsmKNKw95FiqLIb5eJotCcoqsEruL7y/gk=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 06:34:28 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 06:34:28 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Topic: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Index: AQHaK4Q534ViUL7xiE2p4ymr6ObEurCkX+6AgAFU/YA=
Date: Tue, 12 Dec 2023 06:34:27 +0000
Message-ID:
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com> <ZXdNf0HWs4nAVPeF@macbook>
In-Reply-To: <ZXdNf0HWs4nAVPeF@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5302.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MN0PR12MB5881:EE_
x-ms-office365-filtering-correlation-id: aeeb7023-f2b3-4204-a52c-08dbfadc63e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J2cAnZHATms4qo0JgdM6susZknShCqRjEPqT4A+t7Hi5Xmgd21yh5qO7H3mpieA+eigvrN+2rzU7G6YHhJHS+jSjYfPxy27Z2I1znNRS3aHVCTK6ONRfnUG6FdBUcgaz2j3OL10W3gc8IsbqwQfO/PlY+Bds+PUGj1eF35SjZp6hHPkfDIcDiHzMI55r0CzQ2fr8z0DHMvAsAuUlyM08YYmtf+zb1zGD1TyUtFxVmm9fMc8D3Ei3CgxarZghwvdhXdcz2WC+IjYNstDX4RHxcIoZdFEHko1gzzgGXbyOSxrKEWp80BYSlgivmnxc1SzVJ1PC/0mmhNqbTqhoz/JdVNBoKHHPD2axMCLLUHOIua/VyOqxtGc3qGj8sVTUUxwNWyV6wRcfZ340i9s5UhMRGA8jgGbUQi3IGR0taA9gzOoA4OGFbhVYVK+xM6BXLJ/pd7twzp+NFabee17FVIqq8BxP+Kla2DAkSv+qBAoMEYJLTgNaARf2EIPBs+JQZJpyS738Be7XG9aIQlJyZpW23SaOVRpWBIMmC77X1DDaVbjJw+uyzTcQq9k69IuAr+E8WxqB2kOGsXTDa/FKAWXMdhE8KpjRxvUNBovEl2Lz8oBdb3SaPD+axum1kCEvZZXJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(83380400001)(26005)(38070700009)(33656002)(122000001)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6506007)(7696005)(53546011)(71200400001)(9686003)(52536014)(66446008)(54906003)(64756008)(6916009)(66946007)(66556008)(66476007)(478600001)(55016003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXllZkpXYzQ1Z0IxckQxenUrd3RnSVpKWnhwZXkvWTZBSkg3YTk4QUlSZHNz?=
 =?utf-8?B?akt6Q3MrM1c4S1JqRXZxL2FHVDhvViswdlhUbHM0OGZsRWhKK04xOXlJamNE?=
 =?utf-8?B?SElrdnlHWU9SaVpRRUFmR2kwTFF3TUpPRExkRWhYNUwwSFlZYmlESDAydE9T?=
 =?utf-8?B?eFBoYm56UTkvbHB1a09Kdm1BN041alRRNHNpVmpSdTFNTkZrUXdtOEp2M1M2?=
 =?utf-8?B?dzdRd1BQdWZuK3VZSHY2Qk9xUmd1YmJzSnR4cTVBaFlpdEJJZEVrWUlVVHh5?=
 =?utf-8?B?VDlQaEsvV2gxZHp0MXE4T0QyWFdXSUZBbEJQVVhlZWd3N3A5SkhQSTlJQi93?=
 =?utf-8?B?MENhQW1pS0l2YXVNK1BESlAwR292SDdFVkZoYzI1dUY4L1crSlNnYjRnWUpp?=
 =?utf-8?B?Mi8xTFJLZktwVk1ZUEx4eTZCMXhVaGtBM2ZUWjNmSU81U0hkV3BzV1VwNGtG?=
 =?utf-8?B?dkJ5RjBUK2pNbll4emhQTzV6WjJ5em1GQ04zRnJweXhhRkZobndKcFZmZE9a?=
 =?utf-8?B?cWlsbU1SMHFqZ3RZNXp4ZVVkVE4rdnhRLzF3ZUJWRWFLK0JpdS82UjVqcEtO?=
 =?utf-8?B?MHpFaStjYUpVaC9XeERRZ2Z1RjNlZWQxUVAzbXpKVHg5eTdrcENUQllqOVlo?=
 =?utf-8?B?czd4SHZuc3BYVW5qUzV6VjZIYTFtL1poMXo1Y2pwTWpQdW9CUHZXUlVFenBQ?=
 =?utf-8?B?OFlqU1Bnb2gyY1hYSHVqSUJOUTNhbmpWR1MwZkw1TGYrWWJqM0c1QmQ3czVS?=
 =?utf-8?B?VWxSemt3ZGhLMG1ORkVCSHh5QjBPa29oaFg4bjM3d0hvaU1aOUpmV0lMSDh3?=
 =?utf-8?B?MWZUUGd2b0dkSjRrbGhLNTRrMVR1dE41UTVLbVBZSDUzNVJ4NTVwdkovSWla?=
 =?utf-8?B?TzJrODE0ZVh4T2ZKK2d2d0NEc0gzbTc3Tm00SDBWK3dMRmd1dDdMbXNpYkFQ?=
 =?utf-8?B?bXFoRFFpTklOTHBqK1F5RlJpeFJUaFlWN1FORlFJYkpaUTM5RFdkNExLQ21Q?=
 =?utf-8?B?MkhCUHdORVR6MVBiMzlZbG8zYit0SHNGckdndHpIbnlZWXZCWm05dzNIT2xj?=
 =?utf-8?B?aFQvY0FlYmFzNTRLaFJsRHlVTEV6Z3NjQXpqdUsvdFYrSjFLZW0zeG9XNVhR?=
 =?utf-8?B?R2tSaGhyRXFpL0N0NHlaanhzS052RmlFTFMzV2U1WUZIaWtic2s3S2xBVDdM?=
 =?utf-8?B?L3ptWTJZaGU2VDRFZUxSbkNMdHFzSjZwMm9LMkNnMW1IT216czIyelV0L05U?=
 =?utf-8?B?VGZqQzRrZTF3VnUwZGVKOHl1d1RlaTdtcm1ZR1ZHM1hYNWFZV0Q5R2hyNTdj?=
 =?utf-8?B?MVd5VEdDMnpqQ1FORWRvYVphZmp6MGdrNThmd2pQdkJQUTlzdUhSS21VMy9V?=
 =?utf-8?B?MEhNaC81MTRyYWppaERZczVFMlRxMzFidDRWVmg3bHIwK2tGUWU5ajc4a3Vo?=
 =?utf-8?B?MER5dnpYWWRlSlBiUGlEK296YzF3dHAyYmxXWVNIOUZ0WGJ3OTNJdzFKT0RW?=
 =?utf-8?B?V3BEMUtTeTRFVUZQMDFncmRjRGtqazQrM3RqQmthdmgzeDQ3dnhmN0lCb1Zn?=
 =?utf-8?B?Ly81YU0vZUxJUE42elhiVkhHaWsyNi9Wd0pwTy9ucE5ncWt4Q2s0a2g0dW5F?=
 =?utf-8?B?MHh2UDRrU0EramlNUEJjWFVGSkgzemJBMk5kb3pNUEcwbnoxVGxNeGtERktQ?=
 =?utf-8?B?ZnBUYW9WLzFUNFNXYUh3YmlQbFNZZm0xTXYwQlMzTXhNUkE4L1FkclRrS3F1?=
 =?utf-8?B?cmZDdzRSWWVSMjhlQkorUnptTFNOT1IrZldRMHE3TkR6a25VVkxrdE5aSHNu?=
 =?utf-8?B?ejJrNHRlTXZhcGdPNWZwdWlXNUhSVUx4VUp5eXRFWnJlOG5wUUdqZDJZbUVN?=
 =?utf-8?B?djhsK05nSXJGbzJxaXFlUTRSa004Vjl4bTA1ajU0WW9kSE5YYzNMSG5wSW1U?=
 =?utf-8?B?c3lwNEdTa1F0eTA1aVhDY08vUUhlUWN3RFB6MjZlN3gxWVloc0hUczA2Vmdn?=
 =?utf-8?B?V0t4ZWlSUWFSU1JaLzE3SG1ZRHNHQU1ReTdQRUp2aXgzbHRXUVFZd25jbnFy?=
 =?utf-8?B?N0o4M3lnK0ZOdDVRT0JiMjlJNDZ3cTV2cWc2QU85bmhVKzAxcVFBOE9MYllh?=
 =?utf-8?Q?Fyi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42675C500BA60646A2A94AEEFCF1A83D@amdcloud.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeb7023-f2b3-4204-a52c-08dbfadc63e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 06:34:27.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9S+sBtWX7rRx0VT6Xb8j5FP/1n+VpoakYkRWBEz3G7a8U05IfIM7nM1f4feCZQTnp60/nf0Y1Kvur1+uBBKo1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

DQpPbiAyMDIzLzEyLzEyIDAxOjU3LCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPiBPbiBNb24s
IERlYyAxMSwgMjAyMyBhdCAxMjoxNToxOUFNICswODAwLCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+
IFRoZXJlIGlzIGEgbmVlZCBmb3Igc29tZSBzY2VuYXJpb3MgdG8gdXNlIGdzaSBzeXNmcy4NCj4+
IEZvciBleGFtcGxlLCB3aGVuIHhlbiBwYXNzdGhyb3VnaCBhIGRldmljZSB0byBkdW1VLCBpdCB3
aWxsDQo+PiB1c2UgZ3NpIHRvIG1hcCBwaXJxLCBidXQgY3VycmVudGx5IHVzZXJzcGFjZSBjYW4n
dCBnZXQgZ3NpDQo+PiBudW1iZXIuDQo+PiBTbywgYWRkIGdzaSBzeXNmcyBmb3IgdGhhdCBhbmQg
Zm9yIG90aGVyIHBvdGVudGlhbCBzY2VuYXJpb3MuDQo+Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBI
dWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENo
ZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2FjcGkvcGNpX2ly
cS5jICB8ICAxICsNCj4+ICBkcml2ZXJzL3BjaS9wY2ktc3lzZnMuYyB8IDExICsrKysrKysrKysr
DQo+PiAgaW5jbHVkZS9saW51eC9wY2kuaCAgICAgfCAgMiArKw0KPj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGNp
X2lycS5jIGIvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0KPj4gaW5kZXggNjMwZmUwYTM0YmM2Li43
MzlhNTg3NTVkZjIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiAr
KysgYi9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiBAQCAtNDQ5LDYgKzQ0OSw3IEBAIGludCBh
Y3BpX3BjaV9pcnFfZW5hYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiAgCQlrZnJlZShlbnRy
eSk7DQo+PiAgCQlyZXR1cm4gMDsNCj4+ICAJfQ0KPj4gKwlkZXYtPmdzaSA9IGdzaTsNCj4gDQo+
IEl0IHdvdWxkIGJlIGJldHRlciBpZiB0aGUgZ3NpIGlmIGZldGNoZWQgd2l0aG91dCByZXF1aXJp
bmcgY2FsbGluZw0KPiBhY3BpX3BjaV9pcnFfZW5hYmxlKCksIGFzIHRoZSBnc2kgZG9lc24ndCBy
ZXF1aXJlIHRoZSBpbnRlcnJ1cHQgdG8gYmUNCj4gZW5hYmxlZC4gIFRoZSBnc2kgaXMga25vd24g
YXQgYm9vdCB0aW1lIGFuZCB3b24ndCBjaGFuZ2UgZm9yIHRoZQ0KPiBsaWZldGltZSBvZiB0aGUg
ZGV2aWNlLg0KRG8geW91IGhhdmUgYW55IHN1Z2dlc3QgcGxhY2VzIHRvIGRvIHRoaXM/DQoNCj4g
DQo+PiAgDQo+PiAgCXJjID0gYWNwaV9yZWdpc3Rlcl9nc2koJmRldi0+ZGV2LCBnc2ksIHRyaWdn
ZXJpbmcsIHBvbGFyaXR5KTsNCj4+ICAJaWYgKHJjIDwgMCkgew0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL3BjaS1zeXNmcy5jIGIvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMNCj4+IGluZGV4
IDIzMjFmZGZlZmQ3ZC4uYzUxZGY4OGQwNzllIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9wY2kv
cGNpLXN5c2ZzLmMNCj4+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5jDQo+PiBAQCAtNzEs
NiArNzEsMTYgQEAgc3RhdGljIHNzaXplX3QgaXJxX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0K
Pj4gIH0NCj4+ICBzdGF0aWMgREVWSUNFX0FUVFJfUk8oaXJxKTsNCj4+ICANCj4+ICtzdGF0aWMg
c3NpemVfdCBnc2lfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiArCQkJc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsDQo+PiArCQkJY2hhciAqYnVmKQ0KPj4gK3sNCj4+ICsJc3RydWN0
IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+IA0KPiBjb25zdA0KRG8geW91IG1l
YW4gImNvbnN0IHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOyIgPw0KDQo+
IA0KPiBUaGFua3MsIFJvZ2VyLg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

