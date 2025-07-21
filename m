Return-Path: <linux-pci+bounces-32682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA8B0CC38
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 23:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA607AE0CA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B60202F8B;
	Mon, 21 Jul 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJxJdAMt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD344C94;
	Mon, 21 Jul 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131927; cv=fail; b=od2wCEPoALMgRsU6pIG4UtOtHQHq2recW4HPDVo78QkbgJUN2eIzNC3BtXQMb+NWjGraNZcbBe70fRD/RzawhTjlpszhFRmCYnXBeeN1SmcsJEHAxhYzDr5i9MBRX9yBvHBSu2y+MYwn4ni2fdZmKKJiR36oSG5lRAOcgfapuT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131927; c=relaxed/simple;
	bh=BrjP753CSOEj2WeIBg++VVu41XTgQ2aPDDvY1bYCDOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MFwCAp7MYZLvcgbrmZa54GgG3o5z/A99kPkDW/inr2tfnPglsx+QCt7W+4bvzv/Q5w0A6mlHPD7fAL8GwQu9pR/inOOycjl0CjdLyIMQBHz2O2YuA5WnSs91XPyaZQLQVYRAYaSwumokzEpn795d82dUzP9WNm7CqH/PgQ1yf2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJxJdAMt; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvF6OY9ZNd6Dky3ZtuQRyxZNowT5UXXLp58PjoNpdlpyzv1uSe6WKocrhUpoLm1l0os+NH6DzbXZiTh6M4nzDkkRc7+dTafkZ+pFkCsDu2us96tUn4Z0OP1HyyggxWwyGOquf5k4WjXmZJdZmkkwydIG2rlZ15YXaOzzOw4ajSmvpoYhIsKKNyVSQRbQHMGbqSlsrQTncojlEZHB0fZBj/VQS9ET7JMnMPL5NK7LlU8Z0CckUv+TP/eBlcPYOI7a8z+xgr2Q+6rR1ZZd1MtKAIHR4Q54m1kJKW0xhQ0evAGKpnkCev9o3m5AKuJcAnpGMwl75zGREbYKrhFe6ymdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrjP753CSOEj2WeIBg++VVu41XTgQ2aPDDvY1bYCDOA=;
 b=G9I+3Kia7N4Pb+stwhmAr7Jc60SvsA8UaC61Rlz1mO9xWFfxiH4e9AjHhSBqSFd4sPR7ycNtC4AtfjscU6m+Lksf/DkEKW2VSpXUXqzP+hSM0eKDqieSimZQQtdnYnn07OaW3al3+e8utO2DFAARmYrTHAVkLC9oq2C2Q4EPeMGStIoYOwhmT8jOIrBtG1xxRIfM29leHTC1X019oJhaM1UPlWThWnfTmrDqYJ7iLhXR9GpazTUh5FPKl1LJDo+9ybLIhoG+wCXyb3aX60gRWtmqHZ4ZW4ATuWTHO7QYHwmvMUHn1AB1NTnzwErMKSWxwACB+5qwRlYiuM8GHWetTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrjP753CSOEj2WeIBg++VVu41XTgQ2aPDDvY1bYCDOA=;
 b=tJxJdAMtKngCBPp/NRfCik0cCzMTvLqmBAwRJucZZlOD4IsB0TKW2NH3f/a/hrWRgFBcwbuttMkzsWjHegmX/U3XadV/CK6vvSrSCb51dBs58/a+a4ZB55NOz1yOp1ZPfVDm3YOKhJneDAQ+dLbZXHrNBATUwRv3ab0mctGerqM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 21:05:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 21:05:19 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI/sysfs: hide boot_display definition when VIDEO=n
Thread-Topic: [PATCH] PCI/sysfs: hide boot_display definition when VIDEO=n
Thread-Index: AQHb+oLTUD8jqgqYIku8LoxP2NVlZrQ9EU6A
Date: Mon, 21 Jul 2025 21:05:19 +0000
Message-ID: <639fffd3-a251-4454-94a4-602fdaf481ae@amd.com>
References: <20250721210248.267962-1-rdunlap@infradead.org>
In-Reply-To: <20250721210248.267962-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB6663:EE_
x-ms-office365-filtering-correlation-id: 28e29158-8a5b-44b9-b6c7-08ddc89a4cef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkFleEpoUDJ2UWpGQmZIOGVLRFpPUHpzcUtHdDdUdTN5WGZzZzUyVFI0Y3I1?=
 =?utf-8?B?Y2Q3dDQyaEN1ZXRKSHI0bEw4R3lQbEdRbnZhcXg2aklhazBhSFJxUGsxYURL?=
 =?utf-8?B?aUtwVzZENzFVeVBqVUM2MTMvZ1dYYm9pQnZoV2Q2VGFaQXZJS3E0NnlBWnRi?=
 =?utf-8?B?SFA5TVpuRGRpQWtqdG9NQU14STZIZEFZQW0zWklGNWxKb3FqT3haYTFiT0ZB?=
 =?utf-8?B?UytUMHVLcjBxY1Zudmt5SXVRMzZ5eTExaE8wdjVYNks3TGx2VW02VzVSQ3h0?=
 =?utf-8?B?WDM0NTE3VzVzWTBoWUxzMXhmcUFYdVlPVnlKRUhsNDlXenNKRjMvd1VuNDNM?=
 =?utf-8?B?OWJmdlBNejFFVmFlK1ZFTC9oekdGN0dqbVN1dHMvNU9EN0VSMDFnek5ZaHgv?=
 =?utf-8?B?V0EwRnNtaURqSEpUdk5nZ3Z0MEMvYnNHY05SdnRoRHlWc3FLdU9PWFYrVlZt?=
 =?utf-8?B?MmJNQzVnRnU1TE40MUFvbWhhZHhNeG1JMUFqRlBlb0VxNUFDQXl3YXhFZGFu?=
 =?utf-8?B?NStqMjU5cDBtWVJrdU05Z3R1RkJGYTRSUUpiVVdTQWQrdHRoZk1iSlB1czUx?=
 =?utf-8?B?UXBQN05acFJwRGpuT21rY09UTkozN2dSVURNSDA2dmtqME9DdGlwTE81YkdH?=
 =?utf-8?B?VlJNTjBxOE5pMExUWTlkTEpzNlJZVjVwZFpiekoxc2FUNGljckU2c1VNNXN5?=
 =?utf-8?B?eCtSb1pwR0tzVTJBUENxRFZwUXkyMGIwWU5hdWo1bjlsNmd3SFRTRWFvRk15?=
 =?utf-8?B?MHNEL0tMdUJCayszQkgzbEsxQUNrWVpUbVpwMTNvZnVudjlFMjJpajhsZS9m?=
 =?utf-8?B?SmRray9SdnptSFl6ZGgwNDMxU0V5SmM3VzQ5Mk9RUTM2NHBGdFozS0FGaWFk?=
 =?utf-8?B?cEt2MjRxUHJVM09zcXVVTXkzVjY1OWNObldONjJoVzQ1Ry8waWZNbFZrUno3?=
 =?utf-8?B?d0I2cjZHSEVqYmxqbStjZTI3THRidlFlRGVzTHZ0eDZPNENQclowdEs4Q0VU?=
 =?utf-8?B?VG9Xa3BqaHdXSXplSTdKcXJ6MUZ2Y0NvRUhDOWpYNUk4a3NoK0VTbVR0eEJB?=
 =?utf-8?B?dHc0Y1Q4LzNlbEgrOUZGb3B3dmRIaXRCZGduVFFVcHB6d2w1MFREVFRpT3VX?=
 =?utf-8?B?OUpQN0pxMzV6TlhaMXcrQWlNUXgxYVBsRHNrWit3bU5IdnRTOUpFM2J6ZVhm?=
 =?utf-8?B?UHVkbS9xZjFXMEFHSll0S0Q2bFpTVzBmdG1UUnpUNzhOSmwzbkFNM3QxSS9r?=
 =?utf-8?B?Q0d2Y2tXU1dDVTBtUlF4b1FEdWxONjh4dkFBWjNGQ2loVy81d0xOd2JxYndj?=
 =?utf-8?B?bFR0V2FFb3hhMHUzbVpZbmxvdlFZR0FMWmlzcWRhRE9lWStoSGhvYUhBRTR2?=
 =?utf-8?B?TFY5dDRoMk1LVHkzSy9aalIzbnBXY1dIa3cyei9Ia2JBWHhndDZzbU96MFBY?=
 =?utf-8?B?OUtJd21yUDgvUlpwejZHWkxDMFFLbjhiL2c1b2ppMnM4ZVhlMW4rN1AzQ2Nq?=
 =?utf-8?B?cEJuSWwwV2JRS0NTOTNyS0J2RGhhVEp2WWxZM3RQcUR1bDJNb1RKV3g5aHlP?=
 =?utf-8?B?VGFab2J4YnFzd0wvMVc1M1dhcjZSbElQOTg2aUFHZHNkWktla1hrb3hUTzFn?=
 =?utf-8?B?TGtLSVJ2R0JIcGoyeERkWHNoZlFQYXZOSXZpNFpYeHNISitMNUtaQWxwakxS?=
 =?utf-8?B?UUExK3dDV3JtMkVjWTRrR0FlMUNQUXc4eXZHTEhFNmJTUUtWVDFQVnRvZms4?=
 =?utf-8?B?SHZobFR5WWlJWjkweHF3VzYyMVZOYW56M3VDQzBQSVp4bXdZS2tUcXl2ZHox?=
 =?utf-8?B?Wmd2QUp3OGg0WHlzUGlQMmdka1huT2tNbUhZYThUMnNxZUFFYjVlYS9lcmpE?=
 =?utf-8?B?OStLYTkrVWc4T3d4c0Y2VXN1dGRzV1VVWDYweWQvTWQ0RFF3WTgrMlp3Qi8w?=
 =?utf-8?Q?wgo9Zar2Tp61sPDikNZQKjlQoji8qNpd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWFLWFRmUWFNYk1DMUVvSllGeDgwWVZiVVRDNmZZRXlsRStMSVdhdUR6N1dN?=
 =?utf-8?B?WFNJdmhrZllpMnhwM3d6M2xYQTlONkVON0NUdy8xaC9LT1lKUnFDZ0JWcitS?=
 =?utf-8?B?aE1PYTMzcGs3dGhTRnNNRDZ5SjNsZGlONDF6akV1ZzB1eEhKMUk0K1JMeDkw?=
 =?utf-8?B?NjVBKzlMY0lJeVpJWjFacXRFRDBGSlBGUVhOM3d0WjVZUWhpVzVKTHhLSUJ5?=
 =?utf-8?B?WDVrSitFWVY2em0xY3BsbmRyaGtDelJYeWE1d3RWZTdkY0xwZVg2OFNZSGdP?=
 =?utf-8?B?VXhnZE8zeUdLTFFqN0VqRWthNHJ5U0ZvYnBoQkpaN1EwUlc1Z0hqVUhOaldW?=
 =?utf-8?B?cXpQckMrcTdoeG45ZTJuQVBrQmVwYllranlJUEpHc09NSklqWjY0QmpBOW83?=
 =?utf-8?B?VWZGdzk2OEZiUGNXdU5OWHpqeXc1Z1R3bU5yT3FJYmg2RXQrT0hnVTVjblJO?=
 =?utf-8?B?WWxxaWVHbnJNRCs4NUo5ZTcrZ3dWTldGN3R0cW5KTVNLWXV2Q1hjQkRBM2Q0?=
 =?utf-8?B?b1gvOFkvOXBSNkJwZkNrd01QbGhBSnN5N0RGZkZIaG43ZmU2NmJnWGZPNXdL?=
 =?utf-8?B?Yy85RkhRcGhGY0ExNy9VbzJNTzQ1NEI5dEo5Wll5akMyNURjeUh2Q084YkRU?=
 =?utf-8?B?ZGFsOGwrVmF3UlFueW0zTVlmNUVsUTNxeDlNM3p5dERZR0pvamhRcGNMekJu?=
 =?utf-8?B?NEEzRDRRbFVuM2hjWHplZTMrWnVENkRHU0syNzJVd2kvaVRwMExaQkVDK3B6?=
 =?utf-8?B?NkdNOVlJend4YkdTOVJyTlA5QzlrNjV5anN1LzB6cFMzTzQyZmVRajZUUFky?=
 =?utf-8?B?NTJtRkhGRnNOLytKY1BuR2VKV1NjSC9RNDRNbFpnWVdWY3d6ZjR1VEpCaU5J?=
 =?utf-8?B?cnFzZ2lDa0JqOUVaaHpwdGtVSG4yWjM3YndTR0lBSzQxMnZRMzVkS3ZkS1gx?=
 =?utf-8?B?Zkw4cUx1Um9JMFV0blU2R2JBVnJoZkMyb0JZNndOcFpEMjVIMXpUMldnNkIx?=
 =?utf-8?B?ZWlPN3AvbU9Fa3RQeEh0OVVxR1pudUUwRHFSUHVhcDhqck1KTEJhQWhSRi9J?=
 =?utf-8?B?eHBHV2dlNjUzQmI3NDVSeTVrMnNpNGk5a0VsWitxSVR2Y0lCQUgxekE4Wm5X?=
 =?utf-8?B?U0F2QTYvOW0zdTlRTFEyUUJkSTc0SWR4SE5nbUh0TTBORzRFR3B0NllidHJS?=
 =?utf-8?B?ZlhlNjdTalEveEoxa0w0bDRxTUduNmNydGpmUkJkMUh2K3k1dnZwWGkxWFlC?=
 =?utf-8?B?aUNwMDd0M1NMODdwZVhkVGdpZWVUcHppRnIxM2NpS0Z1K0tOUnpXa0xWcWpw?=
 =?utf-8?B?Sjk4Y3kxMnhzcWlIbmFnUGovUk9UZjZOUjB2NkI3Tk84R0M3eTBpeitncWdV?=
 =?utf-8?B?OVpET1dZZ1FSNGNYRjN6eXZRMk5NZlZVTDVDSkJKaER6R3NvZ3ZJWVlselJO?=
 =?utf-8?B?aUttOWcrUHY1NWh3Q2xTYmkyUFllQ3Z4c2FLSlhnMytDS3kzU3dKUDFGNkty?=
 =?utf-8?B?V2RuQ2Y5cGJCa2grSml6TzV4MkRuUTJDallRMFUwMDNwd25EZVhCNlJ2MjNJ?=
 =?utf-8?B?MEh4TVArTGdvcXVtTUptWHoyM252NUJGdlVYREZlQy9vODBvZTRyUGIveURD?=
 =?utf-8?B?NU1QbFB2RlZyRkNnaUtRWHJTWThxVEJRcW1vbjZtTHhwOUxvUnY0MjQyNHV4?=
 =?utf-8?B?ZEp1UUdra2xqQmpvc0tEMWpNSms1TUluNFdCQjRycEdleWY0R0pGcS9KeFFq?=
 =?utf-8?B?bGQ0VXRIVWEzNEIycms0YnZ4WjFSUUxSVTVGcjZlNG5BN3RaWDBJdnlGdmFP?=
 =?utf-8?B?RjZzSUorUkVFZ2dRVlQvdndnWkNtazFjVzFWVXNKSDdtMmtiTkFjaFdYRk1J?=
 =?utf-8?B?eEZxVjlZS2ZXYnEzakpmZUhSTWpkeTdHZ2J1bHRrR3UyU2w1TVllSTZ5aUFG?=
 =?utf-8?B?c21rVFNZM3JPQ01ObFZxTkFGWUkwamJIWTJ0M1R0NGR6TWw5RzRvOFU3UTlJ?=
 =?utf-8?B?YTBkMEEvYWlJUVY3LzQvVGxBYkxqNG1UTVhMWHF3SzRSYXkwWUpocEhTY2Fk?=
 =?utf-8?B?dW9lckxmK3BmNkpXRHdYRU5VMVJDUUxEVGErZDlGWHBIUi9CVGgyY1pJeGI2?=
 =?utf-8?Q?hfOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A10582DE7F358E48977397F655B08707@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e29158-8a5b-44b9-b6c7-08ddc89a4cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 21:05:19.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sisHR9F0K8Pmyi2J5UY9uxnY3dKzhrRFPMYvZaMPu1JQm9iyqWbSVd8MHTfOkEMdroGzE8zna99AD+SeISG4eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663

T24gNy8yMS8yNSA0OjAyIFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IFdoZW4gQ09ORklHX1ZJ
REVPIGlzIG5vdCBzZXQsIGRlZmluaW5nIHRoZSAnYm9vdF9kaXNwbGF5JyBhdHRyaWJ1dGUNCj4g
Y2F1c2VzIGJ1aWxkIGVycm9ycy93YXJuaW5ncywgc28gaGlkZSB0aGUgZGVjbGFyYXRpb24gYXMg
aXMgZG9uZSB3aXRoDQo+IG90aGVyIGNvZGUgdGhhdCB1c2VzIHRoaXMgdmFyaWFibGUuIEJyYWNr
ZXQgdW51c2VkIGNvZGUgaW5zaWRlDQo+ICNpZmRlZiBDT05GSUdfVklERU8vI2VuZGlmIHRvIHBy
ZXZlbnQgb3RoZXIgYnVpbGQgd2FybmluZ3MvZXJyb3JzLg0KPiANCj4gaW5jbHVkZS9saW51eC9k
ZXZpY2UuaDoxOTk6MzM6IHdhcm5pbmc6ICdkZXZfYXR0cl9ib290X2Rpc3BsYXknIGRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC12YXJpYWJsZV0NCj4gICAgMTk5IHwgICAgICAgICBzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSBkZXZfYXR0cl8jI19uYW1lID0gX19BVFRSX1JPKF9uYW1lKQ0K
PiBkcml2ZXJzL3BjaS9wY2ktc3lzZnMuYzo2ODg6ODogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1h
Y3JvICdERVZJQ0VfQVRUUl9STycNCj4gICAgNjg4IHwgc3RhdGljIERFVklDRV9BVFRSX1JPKGJv
b3RfZGlzcGxheSk7DQo+IA0KPiBkcml2ZXJzL3BjaS9wY2ktc3lzZnMuYzo2ODM6MTY6IHdhcm5p
bmc6IOKAmGJvb3RfZGlzcGxheV9zaG934oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1mdW5jdGlvbl0NCj4gICAgNjgzIHwgc3RhdGljIHNzaXplX3QgYm9vdF9kaXNwbGF5X3Nob3co
c3RydWN0IGRldmljZSAqZGV2LA0KPiAgICAgICAgfCAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fg0KPiANCj4gRml4ZXM6IGM0ZjJkYzFlNTI5M2MgKCJQQ0k6IEFkZCBhIG5ldyAnYm9v
dF9kaXNwbGF5JyBhdHRyaWJ1dGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJk
dW5sYXBAaW5mcmFkZWFkLm9yZz4NCg0KSGkgUmFuZHksDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNo
LiAgU3RlcGhlbiByYWlzZWQgdGhpcyBsYXN0IHdlZWsgdG9vIGFuZCBpdCdzIA0KYnJvdWdodCB1
cCBzb21lIG90aGVyIGludGVyZXN0aW5nIHRvcGljcyBhcyBwYXJ0IG9mIGZpeGluZyBpdC4NCg0K
SSBoYXZlIHR3byBvdGhlciBhcHByb2FjaGVzIG9uIHRoZSBtYWlsaW5nIGxpc3QgcmlnaHQgbm93
IHdhaXRpbmcgZm9yIA0KcmV2aWV3Lg0KDQoxKSBNYWtlIGEgc3RhdGljIHN5c2ZzIGZpbGUuDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyNTA3MjEwMjM4MTguMjQxMDA2Mi0x
LXN1cGVybTFAa2VybmVsLm9yZy9ULyN1DQoNCjIpIE1vdmUgb3V0IG9mIFBDSSBpbnRvIERSTS4N
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDI1MDcyMTE4NTcyNi4xMjY0OTA5
LTEtc3VwZXJtMUBrZXJuZWwub3JnL1QvI21lNDM1NmIzYTE3MmNiZGFmZTgzMzkzYmVkY2UxMGYx
N2E4NmUwZGE3DQoNClRoYW5rcywNCg0KPiAtLS0NCj4gQ2M6IE1hcmlvIExpbW9uY2llbGxvIDxt
YXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNA
Z29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IEFsc28s
IGEgcXVlc3Rpb246DQo+IFdoYXQgZG9lcyB0aGlzIGRvIGluIHBjaS1zeXNmcy5jPw0KPiAjaWZu
ZGVmIEFSQ0hfUENJX0RFVl9HUk9VUFMNCj4gI2RlZmluZSBBUkNIX1BDSV9ERVZfR1JPVVBTDQo+
ICNlbmRpZg0KPiBJcyB0aGVyZSBzb21lIGhpZGRlbiBtYWNybyAocHJvYmFibHkgdXNpbmcgc3Ry
aW5nIGNvbmNhdGVuYXRpb24pDQo+IHRoYXQgdXNlcyB0aGlzIGRlZmluZSB2YWx1ZT8gVGhhbmtz
Lg0KPiANCj4gICBkcml2ZXJzL3BjaS9wY2ktc3lzZnMuYyB8ICAgIDMgKysrDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gLS0tIGxpbnV4LW5leHQtMjAyNTA3MjEu
b3JpZy9kcml2ZXJzL3BjaS9wY2ktc3lzZnMuYw0KPiArKysgbGludXgtbmV4dC0yMDI1MDcyMS9k
cml2ZXJzL3BjaS9wY2ktc3lzZnMuYw0KPiBAQCAtNjgwLDEyICs2ODAsMTUgQEAgY29uc3Qgc3Ry
dWN0IGF0dHJpYnV0ZV9ncm91cCAqcGNpYnVzX2dybw0KPiAgIAlOVUxMLA0KPiAgIH07DQo+ICAg
DQo+ICsjaWZkZWYgQ09ORklHX1ZJREVPDQo+ICAgc3RhdGljIHNzaXplX3QgYm9vdF9kaXNwbGF5
X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiAgIAkJCQkgc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gICB7DQo+ICAgCXJldHVybiBzeXNmc19lbWl0KGJ1Ziwg
IjFcbiIpOw0KPiAgIH0NCj4gKw0KPiAgIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhib290X2Rpc3Bs
YXkpOw0KPiArI2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIHNzaXplX3QgYm9vdF92Z2Ffc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPiAgIAkJ
CSAgICAgY2hhciAqYnVmKQ0KDQo=

