Return-Path: <linux-pci+bounces-3906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258E860A9C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 07:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10AB1F2481D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 06:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C5125A7;
	Fri, 23 Feb 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wS1vEOBZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFB101E3;
	Fri, 23 Feb 2024 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668496; cv=fail; b=ej//zfQshXpy4J/js3tXtf3rQ7mx4uoZdVSohTi7u9ziKEkhcbiZrbSy4kVjWhyPDA0erfZ0A3XzJtP4xID+cAC5EMU1v0avj8duqT08b2BynI7m73MXpG6326FnhJjnr3ODpuAOgjO1YRh3ZBEjIhoTs7Zy+ptNl6X8aMCixpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668496; c=relaxed/simple;
	bh=cSFXgVI8MFKZIpnZrwxrAEdKHoKZxwuw+/OdAizMT1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fzXFYM049/jTTAbmFwf5yBjJpO1WzzzoVIssRi4zhpK50PreiKjOz073GO6RSD1oNAV4hfbjbNmDXUetUm/omvmLBiazAvXb0q2Zb7dwmDzllZ03/eLTaErcLzscuBa1Ye9wU7G3owLU9OCId79+XOhbqRGlEd5kLa9oAZ7xIq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wS1vEOBZ; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY59rj+7x5HW36sWPw/J3xYxeYQloT0GzS84344OmSVws9YG8vKeudJGnrc6E6BwB7l/5xGN0hShNqSVRKSV33Q3pIqZ4nSmQf0CProBlgMC2ZyECiTWVfSazWBC/jw9ntgnZbsS6u+sAWo1htpGknFiMAULBnnEWRXayGdk+YBGqV3G6qC+axHNxS8XIATwjUYTVe9gKX5YwIKMho56Ny9oOyQ77lIWZDLc3isL1wb2k70IXQ1WexQ4eJIpcO6tmONBEHn8WG6Pj6wljbZbu3a/sMi+A8/rDx/gWmC6t6D++UnLQ8hM3M5weZumzKgqjXZt1nqoOI/lHckr+HvoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSFXgVI8MFKZIpnZrwxrAEdKHoKZxwuw+/OdAizMT1s=;
 b=aXixU3jO30f2RWfZCIn15FNHmqOia2J0mOtlMRyXIGXPw8ZISnp249Qiy7zcEjwQE0IFHKWLbJWWm8gB9ize5uojNowvBcenLvAyY5zN6qv3q9DsOs5+sTAwfEWW/NRy0x4wuF2oCzcQIVXDeFFcFUOofMU6rsvrUv13D/t/s4e1uV8orqBSFaYA9Urn6KE6riS2BUCKvFvKJ5KeXwzRgmrcunY+ys9aRavmD9tWVXmlD6TzQKH9BeFSKmMsdmnOcl4aZ3YX2/2376g650yXPudc4Djoxn+jB9eXUJafpTFoZ10hfxRkgf8w2I3GasJk01G+BDPo9R3lwxosty2dFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSFXgVI8MFKZIpnZrwxrAEdKHoKZxwuw+/OdAizMT1s=;
 b=wS1vEOBZNMzUX7EHxoJsFmtS0OfzlVAZv7vPj+i10LH08B+4+7kIqrgtdpp7K0NOVI9zcApp2y2+iqD7Ja0QjUUPmz1d7TsDtncx4pI3dP4JvODI8s6y6ODb0JorhzNZkU7a7UOM4JxvHMhSDOWmjXZQBRKz1Ou1NXi+gEyqi4A=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 06:08:08 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%5]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 06:08:08 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>
CC: Juergen Gross <jgross@suse.com>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Hildebrand,
 Stewart" <Stewart.Hildebrand@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v4 2/3] xen/pvh: Setup gsi for passthrough
 device
Thread-Topic: [RFC KERNEL PATCH v4 2/3] xen/pvh: Setup gsi for passthrough
 device
Thread-Index: AQHaP5+cDtnYXqI88Ey+AFMsAvIGlrEXXeWAgADmGoA=
Date: Fri, 23 Feb 2024 06:08:08 +0000
Message-ID:
 <BL1PR12MB58492E9C5247A711D3C26AFAE7552@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240105062217.349645-1-Jiqian.Chen@amd.com>
 <20240105062217.349645-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2402221622000.754277@ubuntu-linux-20-04-desktop>
In-Reply-To:
 <alpine.DEB.2.22.394.2402221622000.754277@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN0PR12MB6150.namprd12.prod.outlook.com
 (15.20.7292.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SJ2PR12MB9161:EE_
x-ms-office365-filtering-correlation-id: 47e91f7c-7d66-45e2-cb69-08dc3435ceaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ETwzAr0X4aGYjLqDF8XV8DW6480QDADpDxXXGrfwzpKexkDGCsBW5MDMCbTnFFdUYuTKBcJfO1IBtVrum14nAiGscOTNpPz1QRqugL/3967VQbyly2MPJF2+as0LGCu5ljByL648B3CTuDjDi6FEFI4UZYX/avNsxNc1KL8XMqrRW5PfcLSPkO/eGQnjScSHodBGxdq66G0BuDObbYxakbx0o4xGOJTmQ3IUctTdrdzGSO8V32TJRMLMaTJS6cs6Bj6Q9yVHIeypV+RqZlmTUDqWfob/24u6W119+CSXNC5nhflMaENRc6cTdEWycD1QurWSstTFkHzNnldZHigSF1AF9QN+5RhZFay7hPc8NFqiOdqQPJceZDTgZYnGsG8dvpiQGZuuPaiNRN4olNUDs6tXpE+TbpGhDVHzlUsxoyz57TYm7zCQWkdUeCSWcvGjXEhCapY9aG4Sjh5YaclPSIasV4ClImFOG9MXZVbIcPEL22tzvD6sqXGq+TaZR5btJgeTd34T7G7eZo1trvZJTStjLtaN3Rxh+7kPtw4Pd538+ru8od/FXjCUE47J4O0RgAlQKs/XLjjl7odRAG3VeuV4BSERauhxbpM0T20BOM7kTzsS6hns+9jlTziNY4oc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NytmeTBhS0FYc3FIQlNseTlUdHVXRGhYbUtWZVplVEk4dy83RlZaZHpRakNT?=
 =?utf-8?B?OC9rRGwyZlVJSkhlL3RPd2JERlRjMGkwVzV0NjVGOXM3dTJYWGFYdGZkV1Jq?=
 =?utf-8?B?enRDKzBRNGFFYVdQUUpaS0JaeEtNNkdJeHpYQ0RwTDZMaWtQNTRtb3BaUURH?=
 =?utf-8?B?ZzZjR1VyNEFwK0xsZlhGUVN5UEpyK295a3o0Z3NpK2oxSlBWd25kMk9KVk5Y?=
 =?utf-8?B?SnhQY1Y4bkp3aXR3dUNxVSsxVGhESHVyZEd1RzBZQjNTcDUxZTQ3a2VNb1JQ?=
 =?utf-8?B?TFRFb3ZQVEd3RGkxZFV0akRBdFVRRXplblZkd09RMzRxS0dSMTAxYjdjTjgz?=
 =?utf-8?B?bjdKazk3VW83Z0hvSEUyTTVSYW45azh2aHRWWHMyeWpEYkZQWmxrZlpDTWxC?=
 =?utf-8?B?Ukdmd3Y1Y2k5N04wNDNuMUxKSlRxZDlGMnpHanArOGszTlNiM1ZBbXQvNm5r?=
 =?utf-8?B?eUVuR1J3ZWVlYjduZVQxalZ0d2ZSM2R5d1NUa1ZaTDdRQWJBcy84K2hndms1?=
 =?utf-8?B?QlVFZG5ib1dibFlHTURmbTBZR3pMbitoVTBSMkFlVzVmR0hHQzhsSTBFWjhF?=
 =?utf-8?B?aEVVaXdaaXRZS0NWZ0VKVEZzdlJFWUhPdllVb1M1elJFK2RWMUtTYXlCWndF?=
 =?utf-8?B?eElHOEFxV0o3ODc4aWtEVVhtNzRLODNPZi9tRHFnUWhrczZsOFdCMHRkaEpT?=
 =?utf-8?B?d3Nhb2xJV2NGMmlZb3JsOWc3M0IxSXZQNS9LbEJ3Z0JzZVAxQS80YWJMSUl4?=
 =?utf-8?B?WkJSUGpMdUJYdGk4TUlrZERoaHZMWXhFNy9CeW1ORTU0VDVQTk5aZDNycjZi?=
 =?utf-8?B?dWtNbDZHbmRDYkNnTWhLNkFBZ25La200Qk5FQkpGbC8zSVJnTGx5Q2lmZmVX?=
 =?utf-8?B?Yk0xM0NISFhpNmM4RnNLWnFFTDRBQUxsNXNBSjBFV3hTSElkQ1hGcE5scGxB?=
 =?utf-8?B?U0xCQWV4c2NrWm9qZXU2bmF6SFQzajFMNUxFVVdBS0RlbHgvbVZnYXhUNENI?=
 =?utf-8?B?K1RacnFHWDRHaVNBd2txeUdFK2JRdUlUWE1jM25yMVhLUVN2cUdoNlJ0REFj?=
 =?utf-8?B?eUYzVXdvOEsxM0d4Y0FnK1B6YnNzL25wcGh0bTJFY04xNThvbVNzT3I4T2Qw?=
 =?utf-8?B?ZG54RllhSjQ2N2JqSk0xOEorcUdoeENySzFzZFhibk5FZDdLT2x0VE9uSjdL?=
 =?utf-8?B?UEFUdFc2OEJnR3V1VEhSS2pFS2lUd0kzdUI1bGJwYTNVd2UrOEhDMllzb0tD?=
 =?utf-8?B?N1V2L05xQ1RJSUg1WEhwd2J1dkwxSW1xdW5hNlZlMUZLM1VrT2lZaWlKVmxp?=
 =?utf-8?B?ZG9HNDRlbkJtM0FXb05WbFRuTXBQbnVub1BtaTRwRHVpdk1iRE0vWFZvK1lz?=
 =?utf-8?B?cG9xMmFEcjUrQmdacWk2Z2czNmJ4MzhlYlNnZm1sZ3FQeE9zcmVoU0FLNWhL?=
 =?utf-8?B?TEpHTWExT0hPeU1Zd2pXUGFjRER4REo1VlZpZDdKaVo3c1NZcTdNbG4wajRN?=
 =?utf-8?B?dlJoY2xhTmlFVERWenQrdTJ5eG1CaGpuM2Z2TTBzdFBqejZZVS9rNi9vSG9j?=
 =?utf-8?B?SG8yK0tubWxFdVNmZnNoRnd5cytHTEtiNXcyTHF0MGhMcEVKWEtVZUlNTXZN?=
 =?utf-8?B?emlUSVpaQ1IxVkhSdUNHcWM3SW9vTmJnTFJRSjlMU29KN0xiSzdZUWVGNHpa?=
 =?utf-8?B?TzIyWGpSNm56ZnJGZnZGbHAyaHdWVk85b2U0VEwwRVl2Qm1hWWZIRWpTQzdz?=
 =?utf-8?B?MVEvUTlISGVvWmVwejZNTnNReHFQaVQ5UXcreW95RzRxcEM1Y2swM0pZYUtn?=
 =?utf-8?B?c01BckdHb28rYnVtdVJxcGRNL2dNajVwZUtrNGVLRzJTRXBHdEZaR1BwNUZy?=
 =?utf-8?B?TUVwWEI3SmRwVXZBVGYxTHJzVjM5b0VBeWg3QjBRcGtSM2ZMWVNxVkxvTUcr?=
 =?utf-8?B?ZTVxUDdQcytieEJacVRGU1pkcWlYSzgxWE8wM1ZEWVEzQkswQkxNSEg5VVR6?=
 =?utf-8?B?SVdadE5PaUNmS3NPY0RUVzJTd0p4QWIvQmNmQXBQWHBtc3ZBbWRZbCt1V01R?=
 =?utf-8?B?MmlRTStLL3lEbFc2cnZEN3BQVTQyR2NKeUlkeW1qMEI5THdpaFQyMG1UZXda?=
 =?utf-8?Q?UjGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10FED9D7D2B42544B6FEAC7926674405@amdcloud.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e91f7c-7d66-45e2-cb69-08dc3435ceaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 06:08:08.4794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJ004It+mnhP++1uIsPAcgwIRrsM3NR0yl0px3q0vvSGydPduBWFb1FJJdp8MUkmjtTK+u9foZQ60TNuMpjx+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

T24gMjAyNC8yLzIzIDA4OjIzLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+IE9uIEZyaSwg
NSBKYW4gMjAyNCwgSmlxaWFuIENoZW4gd3JvdGU6DQo+PiBJbiBQVkggZG9tMCwgdGhlIGdzaXMg
ZG9uJ3QgZ2V0IHJlZ2lzdGVyZWQsIGJ1dCB0aGUgZ3NpIG9mDQo+PiBhIHBhc3N0aHJvdWdoIGRl
dmljZSBtdXN0IGJlIGNvbmZpZ3VyZWQgZm9yIGl0IHRvIGJlIGFibGUgdG8gYmUNCj4+IG1hcHBl
ZCBpbnRvIGEgZG9tVS4NCj4+DQo+PiBXaGVuIGFzc2lnbiBhIGRldmljZSB0byBwYXNzdGhyb3Vn
aCwgcHJvYWN0aXZlbHkgc2V0dXAgdGhlIGdzaQ0KPj4gb2YgdGhlIGRldmljZSBkdXJpbmcgdGhh
dCBwcm9jZXNzLg0KPj4NCj4+IENvLWRldmVsb3BlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdA
YW1kLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQu
Y29tPg0KPj4gLS0tDQo+PiAgYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYyAgICAgICB8IDkw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGRyaXZlcnMvYWNwaS9wY2lfaXJx
LmMgICAgICAgICAgICAgfCAgMiArLQ0KPj4gIGRyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9z
dHViLmMgfCAgOCArKysNCj4+ICBpbmNsdWRlL2xpbnV4L2FjcGkuaCAgICAgICAgICAgICAgIHwg
IDEgKw0KPj4gIGluY2x1ZGUveGVuL2FjcGkuaCAgICAgICAgICAgICAgICAgfCAgNiArKw0KPj4g
IDUgZmlsZXMgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYyBiL2FyY2gveDg2L3hl
bi9lbmxpZ2h0ZW5fcHZoLmMNCj4+IGluZGV4IGFkYTM4NjhjMDJjMi4uZWNhZGQ5NjZjNjg0IDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYw0KPj4gKysrIGIvYXJj
aC94ODYveGVuL2VubGlnaHRlbl9wdmguYw0KPj4gQEAgLTEsNiArMSw3IEBADQo+PiAgLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICAjaW5jbHVkZSA8bGludXgvYWNwaS5o
Pg0KPj4gICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcGNp
Lmg+DQo+PiAgDQo+PiAgI2luY2x1ZGUgPHhlbi9odmMtY29uc29sZS5oPg0KPj4gIA0KPj4gQEAg
LTI1LDYgKzI2LDk1IEBADQo+PiAgYm9vbCBfX3JvX2FmdGVyX2luaXQgeGVuX3B2aDsNCj4+ICBF
WFBPUlRfU1lNQk9MX0dQTCh4ZW5fcHZoKTsNCj4+ICANCj4+ICt0eXBlZGVmIHN0cnVjdCBnc2lf
aW5mbyB7DQo+PiArCWludCBnc2k7DQo+PiArCWludCB0cmlnZ2VyOw0KPj4gKwlpbnQgcG9sYXJp
dHk7DQo+PiArfSBnc2lfaW5mb190Ow0KPj4gKw0KPj4gK3N0cnVjdCBhY3BpX3BydF9lbnRyeSB7
DQo+PiArCXN0cnVjdCBhY3BpX3BjaV9pZAlpZDsNCj4+ICsJdTgJCQlwaW47DQo+PiArCWFjcGlf
aGFuZGxlCQlsaW5rOw0KPj4gKwl1MzIJCQlpbmRleDsJCS8qIEdTSSwgb3IgbGluayBfQ1JTIGlu
ZGV4ICovDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgaW50IHhlbl9wdmhfZ2V0X2dzaV9pbmZv
KHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+PiArCQkJCQkJCQlnc2lfaW5mb190ICpnc2lfaW5mbykN
Cj4+ICt7DQo+PiArCWludCBnc2k7DQo+PiArCXU4IHBpbiA9IDA7DQo+PiArCXN0cnVjdCBhY3Bp
X3BydF9lbnRyeSAqZW50cnk7DQo+PiArCWludCB0cmlnZ2VyID0gQUNQSV9MRVZFTF9TRU5TSVRJ
VkU7DQo+PiArCWludCBwb2xhcml0eSA9IGFjcGlfaXJxX21vZGVsID09IEFDUElfSVJRX01PREVM
X0dJQyA/DQo+PiArCQkJCSAgICAgIEFDUElfQUNUSVZFX0hJR0ggOiBBQ1BJX0FDVElWRV9MT1c7
DQo+PiArDQo+PiArCWlmIChkZXYpDQo+PiArCQlwaW4gPSBkZXYtPnBpbjsNCj4gDQo+IFRoaXMg
aXMgbWlub3IsIGJ1dCB5b3UgY2FuIGp1c3QgbW92ZSB0aGUgcGluID0gZGV2LT5waW4gYWZ0ZXIg
dGhlICFkZXYNCj4gY2hlY2sgYmVsb3cuDQpXaWxsIGNoYW5nZSBpbiBuZXh0IHZlcnNpb24uDQoN
Cj4gDQo+IFdpdGggdGhhdCBjaGFuZ2UsIGFuZCBhc3N1bWluZyB0aGUgWGVuLXNpZGUgYW5kIFFF
TVUtc2lkZSBwYXRjaGVzIGFyZQ0KPiBhY2NlcHRlZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBTdGVm
YW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+DQpUaGFuayB5b3UgdmVyeSBt
dWNoIQ0KDQo+IA0KPiANCj4gDQo+IA0KPj4gKwlpZiAoIWRldiB8fCAhcGluIHx8ICFnc2lfaW5m
bykNCj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gKwllbnRyeSA9IGFjcGlfcGNpX2ly
cV9sb29rdXAoZGV2LCBwaW4pOw0KPj4gKwlpZiAoZW50cnkpIHsNCj4+ICsJCWlmIChlbnRyeS0+
bGluaykNCj4+ICsJCQlnc2kgPSBhY3BpX3BjaV9saW5rX2FsbG9jYXRlX2lycShlbnRyeS0+bGlu
aywNCj4+ICsJCQkJCQkJIGVudHJ5LT5pbmRleCwNCj4+ICsJCQkJCQkJICZ0cmlnZ2VyLCAmcG9s
YXJpdHksDQo+PiArCQkJCQkJCSBOVUxMKTsNCj4+ICsJCWVsc2UNCj4+ICsJCQlnc2kgPSBlbnRy
eS0+aW5kZXg7DQo+PiArCX0gZWxzZQ0KPj4gKwkJZ3NpID0gLTE7DQo+PiArDQo+PiArCWlmIChn
c2kgPCAwKQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArCWdzaV9pbmZvLT5nc2kg
PSBnc2k7DQo+PiArCWdzaV9pbmZvLT50cmlnZ2VyID0gdHJpZ2dlcjsNCj4+ICsJZ3NpX2luZm8t
PnBvbGFyaXR5ID0gcG9sYXJpdHk7DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+ICsN
Cj4+ICtzdGF0aWMgaW50IHhlbl9wdmhfc2V0dXBfZ3NpKGdzaV9pbmZvX3QgKmdzaV9pbmZvKQ0K
Pj4gK3sNCj4+ICsJc3RydWN0IHBoeXNkZXZfc2V0dXBfZ3NpIHNldHVwX2dzaTsNCj4+ICsNCj4+
ICsJaWYgKCFnc2lfaW5mbykNCj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gKwlzZXR1
cF9nc2kuZ3NpID0gZ3NpX2luZm8tPmdzaTsNCj4+ICsJc2V0dXBfZ3NpLnRyaWdnZXJpbmcgPSAo
Z3NpX2luZm8tPnRyaWdnZXIgPT0gQUNQSV9FREdFX1NFTlNJVElWRSA/IDAgOiAxKTsNCj4+ICsJ
c2V0dXBfZ3NpLnBvbGFyaXR5ID0gKGdzaV9pbmZvLT5wb2xhcml0eSA9PSBBQ1BJX0FDVElWRV9I
SUdIID8gMCA6IDEpOw0KPj4gKw0KPj4gKwlyZXR1cm4gSFlQRVJWSVNPUl9waHlzZGV2X29wKFBI
WVNERVZPUF9zZXR1cF9nc2ksICZzZXR1cF9nc2kpOw0KPj4gK30NCj4+ICsNCj4+ICtpbnQgeGVu
X3B2aF9wYXNzdGhyb3VnaF9nc2koc3RydWN0IHBjaV9kZXYgKmRldikNCj4+ICt7DQo+PiArCWlu
dCByZXQ7DQo+PiArCWdzaV9pbmZvX3QgZ3NpX2luZm87DQo+PiArDQo+PiArCWlmICghZGV2KQ0K
Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArCXJldCA9IHhlbl9wdmhfZ2V0X2dzaV9p
bmZvKGRldiwgJmdzaV9pbmZvKTsNCj4+ICsJaWYgKHJldCkgew0KPj4gKwkJeGVuX3Jhd19wcmlu
dGsoIkZhaWwgdG8gZ2V0IGdzaSBpbmZvIVxuIik7DQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKwl9
DQo+PiArDQo+PiArCXJldCA9IHhlbl9wdmhfc2V0dXBfZ3NpKCZnc2lfaW5mbyk7DQo+PiArCWlm
IChyZXQgPT0gLUVFWElTVCkgew0KPj4gKwkJeGVuX3Jhd19wcmludGsoIkFscmVhZHkgc2V0dXAg
dGhlIEdTSSA6JWRcbiIsIGdzaV9pbmZvLmdzaSk7DQo+PiArCQlyZXQgPSAwOw0KPj4gKwl9IGVs
c2UgaWYgKHJldCkNCj4+ICsJCXhlbl9yYXdfcHJpbnRrKCJGYWlsIHRvIHNldHVwIEdTSSAoJWQp
IVxuIiwgZ3NpX2luZm8uZ3NpKTsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsNCj4+ICt9DQo+PiAr
RVhQT1JUX1NZTUJPTF9HUEwoeGVuX3B2aF9wYXNzdGhyb3VnaF9nc2kpOw0KPj4gKw0KPj4gIHZv
aWQgX19pbml0IHhlbl9wdmhfaW5pdChzdHJ1Y3QgYm9vdF9wYXJhbXMgKmJvb3RfcGFyYW1zKQ0K
Pj4gIHsNCj4+ICAJdTMyIG1zcjsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGNpX2ly
cS5jIGIvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0KPj4gaW5kZXggZmYzMGNlY2EyMjAzLi42MzBm
ZTBhMzRiYzYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiArKysg
Yi9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiBAQCAtMjg4LDcgKzI4OCw3IEBAIHN0YXRpYyBp
bnQgYWNwaV9yZXJvdXRlX2Jvb3RfaW50ZXJydXB0KHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+PiAg
fQ0KPj4gICNlbmRpZiAvKiBDT05GSUdfWDg2X0lPX0FQSUMgKi8NCj4+ICANCj4+IC1zdGF0aWMg
c3RydWN0IGFjcGlfcHJ0X2VudHJ5ICphY3BpX3BjaV9pcnFfbG9va3VwKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIGludCBwaW4pDQo+PiArc3RydWN0IGFjcGlfcHJ0X2VudHJ5ICphY3BpX3BjaV9pcnFf
bG9va3VwKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBwaW4pDQo+PiAgew0KPj4gIAlzdHJ1Y3Qg
YWNwaV9wcnRfZW50cnkgKmVudHJ5ID0gTlVMTDsNCj4+ICAJc3RydWN0IHBjaV9kZXYgKmJyaWRn
ZTsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jIGIv
ZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0dWIuYw0KPj4gaW5kZXggNDZjNDBlYzhhMThl
Li4yMmQ0MzgwZDJiMDQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9w
Y2lfc3R1Yi5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+
PiBAQCAtMjAsNiArMjAsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51eC9hdG9taWMuaD4NCj4+ICAj
aW5jbHVkZSA8eGVuL2V2ZW50cy5oPg0KPj4gICNpbmNsdWRlIDx4ZW4vcGNpLmg+DQo+PiArI2lu
Y2x1ZGUgPHhlbi9hY3BpLmg+DQo+PiAgI2luY2x1ZGUgPHhlbi94ZW4uaD4NCj4+ICAjaW5jbHVk
ZSA8YXNtL3hlbi9oeXBlcnZpc29yLmg+DQo+PiAgI2luY2x1ZGUgPHhlbi9pbnRlcmZhY2UvcGh5
c2Rldi5oPg0KPj4gQEAgLTQzNSw2ICs0MzYsMTMgQEAgc3RhdGljIGludCBwY2lzdHViX2luaXRf
ZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiAgCQkJZ290byBjb25maWdfcmVsZWFzZTsN
Cj4+ICAJCXBjaV9yZXN0b3JlX3N0YXRlKGRldik7DQo+PiAgCX0NCj4+ICsNCj4+ICsJaWYgKHhl
bl9pbml0aWFsX2RvbWFpbigpICYmIHhlbl9wdmhfZG9tYWluKCkpIHsNCj4+ICsJCWVyciA9IHhl
bl9wdmhfcGFzc3Rocm91Z2hfZ3NpKGRldik7DQo+PiArCQlpZiAoZXJyKQ0KPj4gKwkJCWdvdG8g
Y29uZmlnX3JlbGVhc2U7DQo+PiArCX0NCj4+ICsNCj4+ICAJLyogTm93IGRpc2FibGUgdGhlIGRl
dmljZSAodGhpcyBhbHNvIGVuc3VyZXMgc29tZSBwcml2YXRlIGRldmljZQ0KPj4gIAkgKiBkYXRh
IGlzIHNldHVwIGJlZm9yZSB3ZSBleHBvcnQpDQo+PiAgCSAqLw0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvYWNwaS5oIGIvaW5jbHVkZS9saW51eC9hY3BpLmgNCj4+IGluZGV4IDRkYjU0
ZTkyOGIzNi4uN2VhM2JlOTgxY2MzIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9hY3Bp
LmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYWNwaS5oDQo+PiBAQCAtMzYwLDYgKzM2MCw3IEBA
IHZvaWQgYWNwaV91bnJlZ2lzdGVyX2dzaSAodTMyIGdzaSk7DQo+PiAgDQo+PiAgc3RydWN0IHBj
aV9kZXY7DQo+PiAgDQo+PiArc3RydWN0IGFjcGlfcHJ0X2VudHJ5ICphY3BpX3BjaV9pcnFfbG9v
a3VwKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBwaW4pOw0KPj4gIGludCBhY3BpX3BjaV9pcnFf
ZW5hYmxlIChzdHJ1Y3QgcGNpX2RldiAqZGV2KTsNCj4+ICB2b2lkIGFjcGlfcGVuYWxpemVfaXNh
X2lycShpbnQgaXJxLCBpbnQgYWN0aXZlKTsNCj4+ICBib29sIGFjcGlfaXNhX2lycV9hdmFpbGFi
bGUoaW50IGlycSk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS94ZW4vYWNwaS5oIGIvaW5jbHVk
ZS94ZW4vYWNwaS5oDQo+PiBpbmRleCBiMWUxMTg2MzE0NGQuLjE3YzRkMzdmMWU2MCAxMDA2NDQN
Cj4+IC0tLSBhL2luY2x1ZGUveGVuL2FjcGkuaA0KPj4gKysrIGIvaW5jbHVkZS94ZW4vYWNwaS5o
DQo+PiBAQCAtNjcsMTAgKzY3LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fYWNwaV9zbGVl
cF9yZWdpc3Rlcih2b2lkKQ0KPj4gIAkJYWNwaV9zdXNwZW5kX2xvd2xldmVsID0geGVuX2FjcGlf
c3VzcGVuZF9sb3dsZXZlbDsNCj4+ICAJfQ0KPj4gIH0NCj4+ICtpbnQgeGVuX3B2aF9wYXNzdGhy
b3VnaF9nc2koc3RydWN0IHBjaV9kZXYgKmRldik7DQo+PiAgI2Vsc2UNCj4+ICBzdGF0aWMgaW5s
aW5lIHZvaWQgeGVuX2FjcGlfc2xlZXBfcmVnaXN0ZXIodm9pZCkNCj4+ICB7DQo+PiAgfQ0KPj4g
Kw0KPj4gK3N0YXRpYyBpbmxpbmUgaW50IHhlbl9wdmhfcGFzc3Rocm91Z2hfZ3NpKHN0cnVjdCBw
Y2lfZGV2ICpkZXYpDQo+PiArew0KPj4gKwlyZXR1cm4gLTE7DQo+PiArfQ0KPj4gICNlbmRpZg0K
Pj4gIA0KPj4gICNlbmRpZgkvKiBfWEVOX0FDUElfSCAqLw0KPj4gLS0gDQo+PiAyLjM0LjENCj4+
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

