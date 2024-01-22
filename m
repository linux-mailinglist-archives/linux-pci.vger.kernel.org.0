Return-Path: <linux-pci+bounces-2408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55172835B07
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 07:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665A21C2233F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80031612B;
	Mon, 22 Jan 2024 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cOiaj8K2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B07641;
	Mon, 22 Jan 2024 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905373; cv=fail; b=WcHm4bP+jRN7aDxCE13sXUEPCBI7ePWpBLH+XndoArCSmnrH1d6ajbzg4x+1EpOwlM41Ftz7rnLXxBorYhHSfOnSzuxuCGSLKSNERLuhjW7ESLypB2FqlOrhBeuil+m9Gq1d87gmHsDSPOWGDoGO0OuJtgbOgFArBQIFndR3Fe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905373; c=relaxed/simple;
	bh=hdzwDsk14qB6pL+Ld3c8GFeYAxqZWeAzUBmUl9/QhUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExHFtURODHgE6ZyQa1+zENiLibWafOJnEcgc9JsswX4eatMePdzyhCW3/H+8KCaK65vyPTqXXPBWARx9vynBHcc1migKApkBGrNE8viB555BIpab9WLoHST63AEgu6T7wXmeCXvhZNcLUdysOVTAhgVCQ0czF3EbMhZ+J5TNkiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cOiaj8K2; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5DBsruXseLpU3zdRyLwerkzt9oJBnMDkFyWLO7s3D6DoOAaGN4X1HM3khozq7xDjVMHSxYQApfvyUZ5F2XGHqMzHdJWUJHxl590jOsAfCF2k/23FNBCWy+YKRmcWkIujuyrcjqE04ca6NL0/JKzOktglsTvxltvxc0+w7VMUHRgccmPpZ9TPslPD0whqe85ateAcbbhBobq8CiPuGgrbunY/wldj+UkHSKQa7NvD3Ga4Eb7uZqI/gzzyFFycBEleSSb1Sypc0GVZ6Tvp7ajcoIcBa0SHeFTfjw1/Z3/+LCIaVGOtekyb4LnPbDf3yTt3OuTqWowu3lLnUUMy5xR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdzwDsk14qB6pL+Ld3c8GFeYAxqZWeAzUBmUl9/QhUM=;
 b=CeFv5Yoyal/zmg2StmQCMYCsVtOf+S7DpvM/zF8g6RnOctIf0wc/bbvFNG6xYL+cbCopD75Byn6s+exYta4F9we2eaO19zfB//yowJm/2GyyM4VHKtrchKvIqtPXk3eRqQU9hNeHtsn3S2tE+e3ClNbVKNwTU6JIKF7U/U5tuoZfhaGByXIUHU/Cr89xCBZZNtEuBVRETwpqoBB7Ciihj93teyAJ0MNaC9458kd+ucaJR0vxPGMdqTWy5N/nrXbNk44GlQToxFSkukyQHU1pNLxPZ+3Qc28ZS3cJQp2Uv7dRpVUQ0zFWqFmXywT+13nRJVYA1f/om6+dhiQJYNS41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdzwDsk14qB6pL+Ld3c8GFeYAxqZWeAzUBmUl9/QhUM=;
 b=cOiaj8K2+zjpJX29tl2/oA9h7EJcNk6zXPr2akPIy6IyV8GsQkAMtERRDOndvE5u1qFE6jQq3eJ6/RNHxhqW216jtizy3JU/OyP9y6Znup4jZn3fuC3j41tJulpSB37lmLxwBS7I+eojnx4z2yFWdjnSgflhmeWkMc6FSzhSvZA=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Mon, 22 Jan
 2024 06:36:07 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::bafd:1985:94e6:ef33]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::bafd:1985:94e6:ef33%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:36:07 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen,
 Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Topic: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Thread-Index: AQHaP5+doYjSbLzTtkiUcLxinuNXV7DmALcA
Date: Mon, 22 Jan 2024 06:36:07 +0000
Message-ID:
 <BL1PR12MB58494E7F0735B26A44D7F683E7752@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240105062217.349645-1-Jiqian.Chen@amd.com>
 <20240105062217.349645-4-Jiqian.Chen@amd.com>
In-Reply-To: <20240105062217.349645-4-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5112.namprd12.prod.outlook.com
 (15.20.7202.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB7558:EE_
x-ms-office365-filtering-correlation-id: ae13a4f5-8065-458b-c6d3-08dc1b146a41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pGzibaJgrQ2BofsPuj/NTC4ijCz+mm7vrbUEtWPSq6O9udm6pRcK0P+USpmpNbPhtUYj0bVYlCuusCb7I48aR4I6mEdgZLq8e/Djy6K3ioI84wpeSA+uzNat6poEhWDn4ySCufvMyeMlJYwlmkgBN+YYHtNYOCs2wdWuEjJ5OXzUPa5zVai70l79o1HPCyGMSMbequrV6AxWDLXK3HFpuCTl1bER6LQTEyI/CsC1ufdyHRsgl9sIkSg+SbEEFuGSVhR7lu4xpnjDNlaf31NHhZ7bbDAUYB5Gs0zrzi6IL7FV6+vRfET91B6M2RceyCznIIe9ZWlQmHjlomDu26QxLH2w7+6Cz8QAamxVdMHSLSuAg+FxTClAdHohEV0juKZu93SfiMyzCt1o0xaAljN4Mt2yksX7PcaNVDxLIPyqBSyyq4W4akgu8mVuYU2QpC+0xAPjkKIZ1h5m8ZIK54LrbAlCyrXZTx1xuj7fSHEXkv3kLDmO14lJIyeGm6g/Z7Qy8iTIQHdw0IM7Zp9eCIEE1vmU24sqM3xOiB74s0pcz0O2HdO5it8EsuDY7MRITlZfuttpWWDVyyvdh7kui7PyprGJWUwNjfkU5908V0o3kuMOL2z5jkdhxBt6WIkErma/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(55016003)(7696005)(6506007)(8936002)(8676002)(54906003)(478600001)(71200400001)(9686003)(66446008)(110136005)(76116006)(53546011)(66476007)(66946007)(64756008)(5660300002)(66556008)(52536014)(316002)(4326008)(83380400001)(122000001)(33656002)(2906002)(38100700002)(7416002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVFmNmZ5ZGRLSDIwQVJ5Qmlub1c3RjRDVGZHeUFRMzgzTUx0MjFyNnFRbmV5?=
 =?utf-8?B?MnVERktDUGN6S1UyRFZGSzFKRmdwbWt5UHB4bTZ3Wjg4VzlTZzJzYWlZTnA0?=
 =?utf-8?B?Skc2TWx0SlJ3SW9kWnYwak4vSUU4RG50bXk2TE1nVDltK0tOQUdtYUtkdmZm?=
 =?utf-8?B?ditxMnlRT2VjM3N4Ni84QzJoM0pzdUlqYzJYV1FGekd1RmlSL0hRS3NiWXp2?=
 =?utf-8?B?b1FNRVIzYXFhQ0N5blJiQ3NoTlFHczhQemhkSWowODRPbGw5d0Nuck5nb3dF?=
 =?utf-8?B?cmREN1p1c1NXSnBtVUdrOXZXSHo0S1VtUHlYVWhzL0dTTnQ1TEhGVmJVQVpZ?=
 =?utf-8?B?cExwVlVxZWV1czM2UGVVWm5FT1lBYXB4dlRuL1IxOXEzcG0xWmF5eFBHM252?=
 =?utf-8?B?R2swZlFFVmdBVGV4OFZ5SVZvTVRXQ3F4NXFEV3grdWhxbW4zY0hweHBSZnly?=
 =?utf-8?B?Mzl3RjhHZVR3bUZ4cWZsc0NKRmdGK3ZtZi9BODB0RXJhSFNTU1k1NDNqdnhQ?=
 =?utf-8?B?M0dTbFMxMG9iUmFJc0FWdGJzMXZTRWlKc1ZPblJTeUJVQmg5dytUckNLUHBx?=
 =?utf-8?B?SU81eUpMdWVMYWdzY28vYzJvckRkVGx0L0lRQWNjSXJ3TFJQK0prQ2RIVVFK?=
 =?utf-8?B?OTBBR1JIVHI1SjBlMGIzK0ptdXcrZkJDWk5UdE9hOVEwSjgxbkFkTzJzUVBx?=
 =?utf-8?B?RHpxT3pkb3FGSUpOQnFhNkRVYTJ2UGZTR0RzQ0pNTFExb0Jnd0EzNW41bXJZ?=
 =?utf-8?B?d0g0SXBwS29oQkRMbzBBeEkreWh0NnZEYUt5WTRmbUxvbk14YjE2bXN2aXhG?=
 =?utf-8?B?bUE4L0NhZ3Z5OGdxMzFOVXVoWlpPRjljRjcwNU1lOUFuVnF4QW5QSlhjdUhY?=
 =?utf-8?B?L3BSMWhxYzhvYUgrSGxLVEt0TzkxK0N3WTZQRHBWZVNJUFpISWVHd1hLR1FE?=
 =?utf-8?B?RGQ2ODQrak9LMHhxL1Bjd25YS1ZQV25iRE9LQmhESmdwQ01hcFA5U3U4YnQy?=
 =?utf-8?B?aTF6RkZXZjMyUDJuVjg2OWdnaVhIQjdxa21rajJnNjA2UnFtOUhxTGdINXI2?=
 =?utf-8?B?RDhmdDZHUVpkRUxFbERhNWloM3JWUXUzN1JhTVRmZWUvMXFkYTF6dkpvcit1?=
 =?utf-8?B?dTQ2TFVXeExzWnVReWpKbDBsbmF2SmNtZ3d6Vjlra1JzcHFyd202ZVNlTmNL?=
 =?utf-8?B?czExOHZvczl2cXViQzVuSFhCNVV3K3oxZXZqN3pzS0ZQTnQ2WGxKTFVxUVNI?=
 =?utf-8?B?cnBzTTYyVVRiSGpxUjVrRVhiOUxWcTlIeEo0UVlZb0N3RmVkTnVwNlBwVmNl?=
 =?utf-8?B?ZmRhVENGY1k5WEJiaFZNM2NjYjQ5RWNLMGFwdXNZWjc4N3gyc2VLWHp4UWV4?=
 =?utf-8?B?WVMvOWFGQmN1UkNpUDB1MlBvQ2hVdDV6Sk1TeW9EMkJhNTJRYW0zZWtOVTUv?=
 =?utf-8?B?N3JRNDVnOHZzUHZqaWRTUVR4aGpiRktKb3ViQ3NvSzBvVHcrTXpaM0hFRm9U?=
 =?utf-8?B?Wk5DSFVpaStPb2FqaEVyZHlhY3VHMEFzMFhqTUw3KytLYnhQTkxzbU13OUM0?=
 =?utf-8?B?dGxBZGphVzlMTDltcXZ2T0xtZWJEa1BtcXI5OG9SYitNKzFzSGNMWUIrbU1O?=
 =?utf-8?B?OExyQjhpUXdZZVRMYkZHK1JuQlhpVy83SDhKNGUyZzhNR0xmQU5aVWdnMjcw?=
 =?utf-8?B?cjhDSGNFZG51ZG1ncEQ0VjMyZ0RWYi9wSmhqdC83dlF3UW9iakc3eTc1VE5R?=
 =?utf-8?B?V2ZLQ0dCL0Y3SWs5UEVtRUV6WDJyQmxOUkI2Vnc0bk1oK2lialprYUtSeHVq?=
 =?utf-8?B?d1YwcDYvdkhqRzlDLzdMYTRnNktHRDB1T1V5M0QremdoZWJnZDJ4QWl5SWxS?=
 =?utf-8?B?eWQvRHJDMzlDa2hxcXBKVzNnQmZTR2tpOXZOVW96ekR0cFBudlNFZDZndnRI?=
 =?utf-8?B?UWpyM2xrK09lMDBLNEhNbU1PQm9KU2s3ZXJGZVMxWlVTVjdONkJUd0Z0R0ZB?=
 =?utf-8?B?bExKM2NEUWlCcGhPaEZyR3ppYVczQkRoMUpHSmhRd1ZVanMwQit5NTJyMGdR?=
 =?utf-8?B?YU82UFNCUzNWM0UzeG15VGQ0M2xYUGYyMnhOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <757C99A95E60414AB6B70EDE1A6F9E5E@amdcloud.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae13a4f5-8065-458b-c6d3-08dc1b146a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 06:36:07.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ose/pYXiKfHC/gH42HTRZ1RCU2fHfjt5g2zEPqE1iEUb00kHcAIavwZgeA7zRtig1j6+V2bPUUEWxNoyRsINlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

SGkgQmpvcm4gSGVsZ2FhcywNCg0KRG8geW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRoaXMgcGF0
Y2g/DQoNCk9uIDIwMjQvMS81IDE0OjIyLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+IFRoZXJlIGlz
IGEgbmVlZCBmb3Igc29tZSBzY2VuYXJpb3MgdG8gdXNlIGdzaSBzeXNmcy4NCj4gRm9yIGV4YW1w
bGUsIHdoZW4geGVuIHBhc3N0aHJvdWdoIGEgZGV2aWNlIHRvIGR1bVUsIGl0IHdpbGwNCj4gdXNl
IGdzaSB0byBtYXAgcGlycSwgYnV0IGN1cnJlbnRseSB1c2Vyc3BhY2UgY2FuJ3QgZ2V0IGdzaQ0K
PiBudW1iZXIuDQo+IFNvLCBhZGQgZ3NpIHN5c2ZzIGZvciB0aGF0IGFuZCBmb3Igb3RoZXIgcG90
ZW50aWFsIHNjZW5hcmlvcy4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogSHVhbmcgUnVpIDxyYXku
aHVhbmdAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVu
QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9hY3BpL3BjaV9pcnEuYyAgfCAgMSArDQo+ICBk
cml2ZXJzL3BjaS9wY2ktc3lzZnMuYyB8IDExICsrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4
L3BjaS5oICAgICB8ICAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGNpX2lycS5jIGIvZHJpdmVycy9hY3Bp
L3BjaV9pcnEuYw0KPiBpbmRleCA2MzBmZTBhMzRiYzYuLjczOWE1ODc1NWRmMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvcGNpX2ly
cS5jDQo+IEBAIC00NDksNiArNDQ5LDcgQEAgaW50IGFjcGlfcGNpX2lycV9lbmFibGUoc3RydWN0
IHBjaV9kZXYgKmRldikNCj4gIAkJa2ZyZWUoZW50cnkpOw0KPiAgCQlyZXR1cm4gMDsNCj4gIAl9
DQo+ICsJZGV2LT5nc2kgPSBnc2k7DQo+ICANCj4gIAlyYyA9IGFjcGlfcmVnaXN0ZXJfZ3NpKCZk
ZXYtPmRldiwgZ3NpLCB0cmlnZ2VyaW5nLCBwb2xhcml0eSk7DQo+ICAJaWYgKHJjIDwgMCkgew0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMgYi9kcml2ZXJzL3BjaS9wY2kt
c3lzZnMuYw0KPiBpbmRleCAyMzIxZmRmZWZkN2QuLmM1MWRmODhkMDc5ZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLXN5c2Zz
LmMNCj4gQEAgLTcxLDYgKzcxLDE2IEBAIHN0YXRpYyBzc2l6ZV90IGlycV9zaG93KHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gIH0NCj4gIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhpcnEpOw0KPiAgDQo+
ICtzdGF0aWMgc3NpemVfdCBnc2lfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICsJCQlzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gKwkJCWNoYXIgKmJ1ZikNCj4gK3sNCj4gKwlz
dHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsNCj4gKw0KPiArCXJldHVybiBz
eXNmc19lbWl0KGJ1ZiwgIiV1XG4iLCBwZGV2LT5nc2kpOw0KPiArfQ0KPiArc3RhdGljIERFVklD
RV9BVFRSX1JPKGdzaSk7DQo+ICsNCj4gIHN0YXRpYyBzc2l6ZV90IGJyb2tlbl9wYXJpdHlfc3Rh
dHVzX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQkJCQkgc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUgKmF0dHIsDQo+ICAJCQkJCSBjaGFyICpidWYpDQo+IEBAIC01OTYsNiArNjA2LDcgQEAg
c3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnBjaV9kZXZfYXR0cnNbXSA9IHsNCj4gIAkmZGV2X2F0
dHJfcmV2aXNpb24uYXR0ciwNCj4gIAkmZGV2X2F0dHJfY2xhc3MuYXR0ciwNCj4gIAkmZGV2X2F0
dHJfaXJxLmF0dHIsDQo+ICsJJmRldl9hdHRyX2dzaS5hdHRyLA0KPiAgCSZkZXZfYXR0cl9sb2Nh
bF9jcHVzLmF0dHIsDQo+ICAJJmRldl9hdHRyX2xvY2FsX2NwdWxpc3QuYXR0ciwNCj4gIAkmZGV2
X2F0dHJfbW9kYWxpYXMuYXR0ciwNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNpLmgg
Yi9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+IGluZGV4IGRlYTA0M2JjMWUzOC4uMDYxOGQ0YTg3YTUw
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvcGNpLmgNCj4gQEAgLTUyOSw2ICs1MjksOCBAQCBzdHJ1Y3QgcGNpX2RldiB7DQo+ICANCj4g
IAkvKiBUaGVzZSBtZXRob2RzIGluZGV4IHBjaV9yZXNldF9mbl9tZXRob2RzW10gKi8NCj4gIAl1
OCByZXNldF9tZXRob2RzW1BDSV9OVU1fUkVTRVRfTUVUSE9EU107IC8qIEluIHByaW9yaXR5IG9y
ZGVyICovDQo+ICsNCj4gKwl1bnNpZ25lZCBpbnQJZ3NpOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGlj
IGlubGluZSBzdHJ1Y3QgcGNpX2RldiAqcGNpX3BoeXNmbihzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0K
DQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

