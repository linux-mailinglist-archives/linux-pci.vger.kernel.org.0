Return-Path: <linux-pci+bounces-10193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E590292F47D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 05:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752381F237E8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 03:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8D10A0D;
	Fri, 12 Jul 2024 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TX6mUGMI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sRYey7fj"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4912B63;
	Fri, 12 Jul 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756211; cv=fail; b=KoZBy6kkYZtgIXJ/PE3lgHu0loaa3cGOZSlQBuWshinuEC2DMjBRJW7q/5Uzxlw5/uNN2WEy+M9NqRnAFJaVez9LrJJXs1ou+QpiEanvrmb3fnlzr3xXlh39JMt7uXaEe1buom9AFKbsbG2kZ6X21tE4z+pc1I7YsyieYp6gCts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756211; c=relaxed/simple;
	bh=TWuC9Jw1GaS7UDVCjYgzsjxT0ZdwPkS/v+g+tyl1788=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oT+BDGMx2pOM4kOWLVX0hnT11vG3WI69agP7Lm6YnSHENwa5JJNUevw3xA96OfMIPRk7fsT5CES+QQU/zlNZ5IXjm5+teuLFuy9x0aJwUE5Qlkq5hoVsq34KbeNxE5fwOUrYKlS3n3L8nvfCgnZRZSfFIHELNQjVJ1qhus0fNNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TX6mUGMI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sRYey7fj; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720756207; x=1752292207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TWuC9Jw1GaS7UDVCjYgzsjxT0ZdwPkS/v+g+tyl1788=;
  b=TX6mUGMIhuNhOp1mqTiCRY/vwI7srUL1NcUVWaYCSb9PeTg0jG2MuXOz
   q7IDbefHLNSQwPuZhF+ER5LcTLtpzg89QzpiQW3FhvNk0hRQyP1hGASGF
   JVDGYn/iyGMQRBTyEX7L97dv5LUZVTveM1CErisoHTpe7FfsdmBRDea64
   MXESUHNUjgFd2l0Y2P4+hpe6NJqc2/DIoMuucWSeRl259K27z+RECntXE
   fhkmHQBbnd4iOV0/s8gUxKlRRKAg4aTPPgYJH1zrebeSXv+D+IQ76RQ9c
   1Wqr6jpPtznbSfc+B9247hent26+dz0TjYzpHN9BJ6bH35WHEyTL58I26
   A==;
X-CSE-ConnectionGUID: SHdQjdMVQwaZpzVtL3QvAQ==
X-CSE-MsgGUID: V0EzEtM6Qb6pywI66mU6iw==
X-IronPort-AV: E=Sophos;i="6.09,202,1716220800"; 
   d="scan'208";a="21800394"
Received: from mail-westusazlp17012037.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.37])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2024 11:50:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0nk4TNE8HhNMiJvwm3FvxKjsF2pvQVYxVRdrfjPIGjNFxBXG6n8/ZJFbsWeKvMWOLAWxShf14GIsYFKjiLbdx7TUWLh0kP4fqxJ6kHucOu7UzvhKAaO4r7TOzT8vBQAAwqMCM+L6KY0i1fWRFiQzw90+OryYWkTrjUMbLSZEF9SHUUijpnzojIbj05ctYGKf70J6mgZ8JyXG3dlFAXprofq8mTfGA2Snfp+E7MgzFo92Hc9RSIAi50NwGcKz1bgUizXtZC6fUNUAbPDmWWGCX/CLI/riDbWr6r8jixNX/mIIpgOxhPf5lp2JGxFuaQ68H736tMr6P+m+BUDq4qWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWuC9Jw1GaS7UDVCjYgzsjxT0ZdwPkS/v+g+tyl1788=;
 b=dbRT9kzEA5NC1I0vJbfZA9YWFs0wY3ZH9thMevZTKxQebg/xZmjIDSlytu7jpvlpuoMbqY8URdkswJmzD83uNT9NATSrlzUV93boSvVluvH8WDMparHYP7sqnbuiTy+JztkpAt10BffcWR3TnVoHkoHZ+KeGP5ZknYZ9JZZFwek5n7DggtsmxvG6AH5gxPl62WddLWFB7eGCde4mnclC5kYeFG5O9+cB0FR7bdoLjbgHzbK4EZttyDAv8/loaBBmn0NnW3rznN7VCq7RgELyZ3uchGhbCL+dw8XIPvCVJ9YIFplWHRQLbuZRhaFlVfs6MMw5dYP/JgJVSVG09rTP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWuC9Jw1GaS7UDVCjYgzsjxT0ZdwPkS/v+g+tyl1788=;
 b=sRYey7fjoQKRXRRU8jocvOMWwWN4BPT5Zk7u2y5v7DF88Pgf+SKEI1t0H94rlUlIuB87/bjVQydDPgsDp09u0md7t2TOhUUismFUk2/l8GV7L3yHx2jpDMc9pbBizBa5Tw8Kvjn+qSIiaF+AXeBSQcd6LAwG0jQUP62PzllMqJQ=
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com (2603:10b6:a03:303::20)
 by BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 03:49:58 +0000
Received: from SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc]) by SJ0PR04MB7872.namprd04.prod.outlook.com
 ([fe80::3c90:f146:c39c:33cc%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 03:49:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>
CC: "sameo@rivosinc.com" <sameo@rivosinc.com>, "graf@amazon.com"
	<graf@amazon.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jglisse@google.com" <jglisse@google.com>, "ming4.li@intel.com"
	<ming4.li@intel.com>, "gdhanuskodi@nvidia.com" <gdhanuskodi@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, "seanjc@google.com"
	<seanjc@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "david.e.box@intel.com"
	<david.e.box@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"dhaval.giani@amd.com" <dhaval.giani@amd.com>, "aik@amd.com" <aik@amd.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"pgonda@google.com" <pgonda@google.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 13/18] sysfs: Allow bin_attributes to be added to
 groups
Thread-Topic: [PATCH v2 13/18] sysfs: Allow bin_attributes to be added to
 groups
Thread-Index: AQHayyvE2Fi5N7LPj0OqjbObXEg9prHyhsWA
Date: Fri, 12 Jul 2024 03:49:57 +0000
Message-ID: <cc2b830506f851fed4deb84953ce6a88c8445384.camel@wdc.com>
References: <cover.1719771133.git.lukas@wunner.de>
	 <16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>
In-Reply-To:
 <16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7872:EE_|BY5PR04MB6327:EE_
x-ms-office365-filtering-correlation-id: 796633a1-71a8-4ccf-3d63-08dca225b2ee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1g4MU5sblQ0RmRmT3NiKytCUXhER2hXLy9kOVpyWllWWTZQb0cyNGZMUm1O?=
 =?utf-8?B?Y0pmdFAwM1huZ09Wa2FSRmhLYmh1Nll0UkR4UWZ3eEtENTZENzA3U1M1aStQ?=
 =?utf-8?B?RWFIdW9kM3QvNk85UEdRSDhRa1g5bGhubVNydXEwQ3N5c1V2KzR2WUgzSHZQ?=
 =?utf-8?B?YW1zNHh2bE1ZdkJPNk9YVjBGNVZhUkJjSzhUdHNCUk4rUU1sTW1pYi9GYW90?=
 =?utf-8?B?TTE2QlFTNnJ6TUZOVUJpODRhZ3lwcUNxNzllMzBsRW1NdjRBMG9QMmhoc0t0?=
 =?utf-8?B?S1k2OVJONm1pL1FiaE83cFZFaExScEI3WVAwdFlQRXdiWi9YcUs5b2dWcWFE?=
 =?utf-8?B?U3d2QXRKbHk2N3k5dTFGWHBnK3E0TTFJL01JTGF4cXRCcUsyZENDakZpcjVp?=
 =?utf-8?B?U1BiVFRYMndENWNYTDQvcVFxU2EwcTVNM0VURHFWTTJyRHZxdmFaNUlxbVow?=
 =?utf-8?B?MnkzZnpMSmdoVW1GUVVTNkRQODVKd3NGVXBpZmI2amlxckJ5TW40cWR2MXBj?=
 =?utf-8?B?VlJOK2hNS3RVSUFiczdvcnd1cHJ2TlFvYUVJZHByY1ltdzRTWHl5ZGhIcjFN?=
 =?utf-8?B?Snk1dW1iWnZHT1FOdlg4TlV1RWJXdk51bzJ3WGFXZDd5UGRqRnAwSGRRbFE5?=
 =?utf-8?B?YXF2c1A0U2Q4ZmNWaUVqNVlNYWRmZkRtQXk0RnpJZitTcnQ3aGNIbWczN3hY?=
 =?utf-8?B?NmtrQXYvaFNEemgzRkVFZ3BTL0dsVGdPODFvN2U5N2ROcVRSaXNpRXhVVE5W?=
 =?utf-8?B?cGNyL0VmNnFJMHZzcWdET051V3lvK3pqZkdtYk5oSEtPYUtpbE1Eek83aXR3?=
 =?utf-8?B?WS8yVnp0cmxqYWEvUmRUQ3VGZUJCS3hhbEFRK1B0STBPQlp4dFMzeXcxN0Vy?=
 =?utf-8?B?d2dDWXdUWDZqS1p4bXJsWTI0MlQ4K003NWc0ZExrK1JyeE0rRXNHZFBrRjlB?=
 =?utf-8?B?RTVRSVZCUnZ1UXZINEZBaEdLSE4vR2lXamFMa0pqMDk1Q3d1d1oxeWd4S1ZF?=
 =?utf-8?B?Zkt5WFFBa1NpQk00VysxMTBULzlmdmlONFQ2R3Z3dXZqNWpCT0tHMm05aHE2?=
 =?utf-8?B?d3hUcjhyUlgrTmZWWWdpdGRmQkNGb2lHNjNqQ2lwOFRacjU0T25haS9kMHlu?=
 =?utf-8?B?cXpEL0RNWjQxYzZkZFRCREk2WnhhT2tPanhoeEFRaEpFNENhVldycnFPc3lp?=
 =?utf-8?B?ckVtTUkyZ2hiTEVrNWl4SUNqZzFJWE1BSVVLdHd3RzlxYTBPMGJucXY4TEdH?=
 =?utf-8?B?NWdDcDgzZUVWemxCZktnYmZWK29BNE13WFR4VTdtK2htbkRzSHNZQnBHRVBV?=
 =?utf-8?B?bUhzeEw5b0N3alBPWTQwd09VWW1Cb3c3THBndGJsN0NPYXUvMjNlQjY1KzR3?=
 =?utf-8?B?TTFpZkpvODh0Vk1mcWFJSWwvR1MrdTQ3c3pjWG9ocURxZEVWNUpNUFZUaWxw?=
 =?utf-8?B?OHlwQ0prbWNpc1Z5OUlvVVRCVCtHQUxGbUdiZkMrd1R1SmNqdmcwYXVkYkMx?=
 =?utf-8?B?M3RHODZNSFdNQzh0OW9JV2ZlUGRkNEd6M0hKVlhKZ0V2dk1QMDJnejBXTjdr?=
 =?utf-8?B?dk1Ia1luT0g4SW0rSnk1TFRsTkRIZkY3VkVFNXphbVlCeXRqVDE0Y0lsMFc1?=
 =?utf-8?B?a2FKcEpoNEwxSnBlUmdoRW1lbWpLVk9TVE9wYTdXNVM2a2R0djREaU1nM1Ra?=
 =?utf-8?B?VlFLdUE0ZnVqUG5keXplbjVmaHNRa3RMOWZ5aDFIeXpjWHZnYUZ1bEtIL3Yw?=
 =?utf-8?B?TGZud1R2aUM1TTJSMzdxL2VOYjB3WWFLbElvdDQvT2ZjY2tkeGE2cW95aWNH?=
 =?utf-8?B?V2RCRWgwSE5TOGhkYmhYbEF3b2lqMC9mM0RyODFFcWRMMVQxUTh2TmMvaWhR?=
 =?utf-8?B?TzQ2YlNuK0p2Y3dVR21OcldwNmNTSXRxd0tpclh3eVZuM1dXRjE1QVVZMjRI?=
 =?utf-8?Q?i4kby4TJGbU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7872.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1Nkb2paQ3FWTDFzUVZJdlJrWklMaU5QRjRDb1UxRUNPeWVVRUQ5WjNmcUdr?=
 =?utf-8?B?RExpYmR6cnZ6Q0xLOWpyRXYxcUh6bzdRa2I4VUtGcVUvMURZSkx5MUh1bXJq?=
 =?utf-8?B?Z2tKdWpCVzVGU2xqYmhhUjZLdHFVUlkzN1dyVGllM1VPQlVLTE1ENUVYWnA5?=
 =?utf-8?B?cy9iUi8yLzIvNi8wTVFyZDAzNmhlVHd5WnJoTXZuRFpnV0l4djVGNklHWkxt?=
 =?utf-8?B?cEZqT3lWZWlwUDZ5V25pamJaQUJVTUpXRE1wbVl5eTFpSWRqUm5XYlNZMWtZ?=
 =?utf-8?B?c25BWHU3NGFoRDRtRUlHZGRaeks0RWJNTXhNQ1Z3ZFZyeEd3bU01cm00YzJU?=
 =?utf-8?B?MEVsT0ZGY1BWaVlHUklPZVBxUXAwdmxKTU54bTVJclUreWZXbC9Gbm5QdG1T?=
 =?utf-8?B?Y1IzL1lOUEp6cGlLaVNabHJ6RjJYQ3R4NlJtVmI1Y2UvamthN2ZBTzduQ0Zq?=
 =?utf-8?B?M0J1YVg5YlBoNjZIRUtSOE1uVmRhbGIxYkdmYzZkSFhaTXVxOXVXY0gwSXB6?=
 =?utf-8?B?bko4MzV6UExQWDlkdHlNbTI0Qk1ZUnJPdlZYbUdxSFdMTnA5N3BHSzMyQTNM?=
 =?utf-8?B?OVh5K1JTcFJHVnFqZkZHUXplbkRKSWU1UXIyNEpvVFp2Z1BYWm01YnZpY0pk?=
 =?utf-8?B?STY0Q2E1MnFJdXlvR2h3TGlRYU5aMnIzZE0yNU9ra0FJbGVjY3dvSWdaYlgw?=
 =?utf-8?B?Tzl6ZFJza28xYng3NHZ6S0dleC8yZjI1T2cxekxENHFlWXBYTk9SMmcrK1hC?=
 =?utf-8?B?eWUyM09vRVJPQnQ1cEVDbEFyKzN3cHEvZFVvbXFwM1BKdSt0YUovaElzM0Fm?=
 =?utf-8?B?dStTVTQ0Q0ZhdU5vVHlsZjRVSnpteUM2WVlpR3ZPVEJwWnpVT3J1UGhUTjla?=
 =?utf-8?B?QmxMN1Rod3QwK1l4MWZERzZWa05QRU0rQjB1d1V2Nm44RXJNUVk0T1pFK2VZ?=
 =?utf-8?B?NG5XcjNOaVJUZWdmSzZCMHJlUGlZSXJaNEJvcDJXeUxYVXA5YnVZQUkzMHM2?=
 =?utf-8?B?Q2hOdDE3OEh4Y3ZZNlRGTEp5SUJRdkcvc2hkcUxXcDJ5cmtMbEphKzROSVM2?=
 =?utf-8?B?NkNPL0tZNGJMTFZtTk04WlZKTVo3OUVKQjdoWit3ZENsQUE5TTdEbG9hMldk?=
 =?utf-8?B?a2Z2WFVqa0szbEFXa1hKWGZuODVTN2Uza01KL2toTTEwZGk0T3BRRzNUUWZF?=
 =?utf-8?B?dEtVcnFGNEFPZU9uMEZmS2JMQlNzQTBqK2hxMVBxZ3dvOHBiNC9scE1EaWV2?=
 =?utf-8?B?QThjaHl0dDE0REFTL3RXVS9sZm84a0hvTWtSNURXdXN4SjAzZllERWFzWExI?=
 =?utf-8?B?RnpXTHM5Q0JlU1BidnVzRTFhVHNXS2dIRFRtbTd2ZXhMSW1IbzFpSXEwR2ZQ?=
 =?utf-8?B?WHVTNWNpZjRXRjZwT2hXNTFBYXVHMjY1NWhycTExc0FiM0JCM3NzTE5YVkxt?=
 =?utf-8?B?SHd5ckR5NStITXFlTmhsN28wOURSVk51cG9FZ0x5UWdJN2xGNkNTN01ZVnow?=
 =?utf-8?B?alEvb3BZRjlkK3Z2cWtJYmdJMExndDV3MHVwbUUzUGcrUkl4dkc5STlyaGZu?=
 =?utf-8?B?cW1MN1c0TktjOXNpN3FnVDFYeUNJSitSbzRTMlJ6RTdmSTdmWm1NNkE3RFpl?=
 =?utf-8?B?S25jZmZOUnBrSkhNTmp4ZHZqTytldXRteWgzdXBOa01rWkVrdHhhTkxlUkRZ?=
 =?utf-8?B?S2xJTXM5VllnR1ZXMUFQeXd3aXBmZ2tHSngyWFJ2V0JmRUZsTWFHeFNnYzhQ?=
 =?utf-8?B?MW5nRUhhYlNOZHdRdHNrVENacXdndCtuSHQ4SElmWVNUQnkxZDFYVGZiL2dn?=
 =?utf-8?B?RmY2WlduT0VlVzBXM3djQUJEcjFwZ0JHTEtUNkZaZ0tEeld0UGhMdTZ5eWNU?=
 =?utf-8?B?Sk5pdDVBRlJ1ODRjSGJaSHBGL0haZi92Q2NLeXFCMFJJOU02cVUvb3ZvQmUz?=
 =?utf-8?B?cHh5N1BJMlBwSFVRUU5vV1h5N1dvaklzUll4ZkxMYXJmRFV6LzJnR2g3QWRC?=
 =?utf-8?B?cFZ3RllYZnZxSy80ZVAxWjVQbXNZcDRKcTB1WWJwNFdUNDRXaFgwTVFLR3Rw?=
 =?utf-8?B?V2ZUUldlQWdkQXpxQ3JaNjFmTXZ1aUZDaVd5OTl6eGFCenZxWThxZk9OcWFM?=
 =?utf-8?B?L0EzTzlwQnp5ckloNkV5SFA2anNuc1RtTktBai9VZ3p5NXlVUTVlS1RLYlVF?=
 =?utf-8?B?QnMzdUZBWVZIT1dQQXBnYldvcitZS05kT3cvY2l0U2VHOW5jRVV5SkpNOWk0?=
 =?utf-8?B?SUZRc3ZwSGpsT08wVlRWY3VOcHZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E331A557944204FA3D774ACF4210E45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	da2MGrMgfA9KMs8h+oXAHudUDyMjHCca1UGjuYRB6sdNIjiG160b3ac9LMxk79g3rjN5CnIqEbfj4G+LsPVHKRbu6ydUAbuj1WspKuvD9HTzD4CHosr7+Co00aV7hLdzAk08W7Ud7JZkxmO6qGUaYnG+wjp2SS7JUznGqdsD9DyvePPPURdsDsOepkHr8Vp2YE8Op0rUh2kB65RfPCENhMbAr5kEPgObmxjCdgwRdJQER3BoOQ8Nmid16GEvc+Qg4C1qhS/XjeSLiSUOkC185OCYh8bUdFM3VcH3WeKjnVBaW5FkLxHTLrKiMot5WeV6mWdpU2PBkCzz2EbtQLrsf4t4IvCHmJupgWoGtucEWFnFdrClY5osank3ZciRBQh0tG2OVHNIGh02U1Oiq/Xk2y6ELG6bmbjeneT5Iaj0s0mnaOIw+5W6J1xXJFrq6pWTrk+9A7c7/ZbL3x27iF8/AWCtgjBbW5SL7AFYhlZsxiyaKq3D1pWKpGRiCuXGuZ2Hi0esvRfR3jEF/KgjL5QesQ0mDasFzDn3Ug86rGxm0O9eEXOchKVB0JUH3/ygcImya74xTDgpzYA3Jgh4yIj/zdG7VVbzsHjUAMRv40UJiNvTPs8HUWBGfCHFATswCMCa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7872.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796633a1-71a8-4ccf-3d63-08dca225b2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:49:57.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pseJk7dl18uz8vjVif96p1dpWi9I2kNFOK2+eaBR96S1mJimz/EplgWcdgboaP7aFoGoXOQ6lgYVqMMYr/JwPnJLpFl/hZBhTmZPWCIX1gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6327

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDIxOjQ4ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IENvbW1pdCBkZmE4N2M4MjRhOWEgKCJzeXNmczogYWxsb3cgYXR0cmlidXRlcyB0byBiZSBhZGRl
ZCB0byBncm91cHMiKQ0KPiBpbnRyb2R1Y2VkIGR5bmFtaWMgYWRkaXRpb24gb2Ygc3lzZnMgYXR0
cmlidXRlcyB0byBncm91cHMuDQo+IA0KPiBBbGxvdyB0aGUgc2FtZSBmb3IgYmluX2F0dHJpYnV0
ZXMsIGluIHN1cHBvcnQgb2YgYSBzdWJzZXF1ZW50IGNvbW1pdA0KPiB3aGljaCBhZGRzIHZhcmlv
dXMgYmluX2F0dHJpYnV0ZXMgZXZlcnkgdGltZSBhIFBDSSBkZXZpY2UgaXMNCj4gYXV0aGVudGlj
YXRlZC4NCj4gDQo+IEFkZGl0aW9uIG9mIGJpbl9hdHRyaWJ1dGVzIHRvIGdyb3VwcyBkaWZmZXJz
IGZyb20gcmVndWxhciBhdHRyaWJ1dGVzDQo+IGluDQo+IHRoYXQgZGlmZmVyZW50IGtlcm5mc19v
cHMgYXJlIHNlbGVjdGVkIGJ5DQo+IHN5c2ZzX2FkZF9iaW5fZmlsZV9tb2RlX25zKCkNCj4gdmlz
LcOgLXZpcyBzeXNmc19hZGRfZmlsZV9tb2RlX25zKCkuDQo+IA0KPiBTbyBjYWxsIGVpdGhlciBv
ZiB0aG9zZSB0d28gZnVuY3Rpb25zIGZyb20gc3lzZnNfYWRkX2ZpbGVfdG9fZ3JvdXAoKQ0KPiBi
YXNlZCBvbiBhbiBhZGRpdGlvbmFsIGJvb2xlYW4gcGFyYW1ldGVyIGFuZCBhZGQgdHdvIHdyYXBw
ZXINCj4gZnVuY3Rpb25zLA0KPiBvbmUgZm9yIGJpbl9hdHRyaWJ1dGVzIGFuZCBhbm90aGVyIGZv
ciByZWd1bGFyIGF0dHJpYnV0ZXMuDQo+IA0KPiBSZW1vdmFsIG9mIGJpbl9hdHRyaWJ1dGVzIGZy
b20gZ3JvdXBzIGRvZXMgbm90IHJlcXVpcmUgYQ0KPiBkaWZmZXJlbnRpYXRpb24NCj4gZm9yIGJp
bl9hdHRyaWJ1dGVzIGFuZCBjYW4gdXNlIHRoZSBzYW1lIGNvZGUgcGF0aCBhcyByZWd1bGFyDQo+
IGF0dHJpYnV0ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1
bm5lci5kZT4NCj4gQ2M6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+DQoN
ClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+
DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgZnMvc3lzZnMvZmlsZS5jwqDCoMKgwqDCoMKgIHwg
NjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gLS0NCj4gwqBp
bmNsdWRlL2xpbnV4L3N5c2ZzLmggfCAxOSArKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDc4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL3N5c2ZzL2ZpbGUuYyBiL2ZzL3N5c2ZzL2ZpbGUuYw0KPiBpbmRleCBkMTk5NWUyZDZjOTQu
LjkyNjgyMzI3ODFiNSAxMDA2NDQNCj4gLS0tIGEvZnMvc3lzZnMvZmlsZS5jDQo+ICsrKyBiL2Zz
L3N5c2ZzL2ZpbGUuYw0KPiBAQCAtMzgzLDE0ICszODMsMTQgQEAgaW50IHN5c2ZzX2NyZWF0ZV9m
aWxlcyhzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqIGNv
bnN0ICpwdHINCj4gwqB9DQo+IMKgRVhQT1JUX1NZTUJPTF9HUEwoc3lzZnNfY3JlYXRlX2ZpbGVz
KTsNCj4gwqANCj4gLS8qKg0KPiAtICogc3lzZnNfYWRkX2ZpbGVfdG9fZ3JvdXAgLSBhZGQgYW4g
YXR0cmlidXRlIGZpbGUgdG8gYSBwcmUtZXhpc3RpbmcNCj4gZ3JvdXAuDQo+IC0gKiBAa29iajog
b2JqZWN0IHdlJ3JlIGFjdGluZyBmb3IuDQo+IC0gKiBAYXR0cjogYXR0cmlidXRlIGRlc2NyaXB0
b3IuDQo+IC0gKiBAZ3JvdXA6IGdyb3VwIG5hbWUuDQo+IC0gKi8NCj4gLWludCBzeXNmc19hZGRf
ZmlsZV90b19ncm91cChzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gLQkJY29uc3Qgc3RydWN0IGF0
dHJpYnV0ZSAqYXR0ciwgY29uc3QgY2hhciAqZ3JvdXApDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGJpbl9hdHRyaWJ1dGUgKnRvX2Jpbl9hdHRyKGNvbnN0IHN0cnVjdA0KPiBhdHRyaWJ1dGUgKmF0
dHIpDQo+ICt7DQo+ICsJcmV0dXJuIGNvbnRhaW5lcl9vZihhdHRyLCBzdHJ1Y3QgYmluX2F0dHJp
YnV0ZSwgYXR0cik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19zeXNmc19hZGRfZmlsZV90
b19ncm91cChzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gKwkJCQnCoMKgwqDCoCBjb25zdCBzdHJ1
Y3QgYXR0cmlidXRlICphdHRyLA0KPiArCQkJCcKgwqDCoMKgIGNvbnN0IGNoYXIgKmdyb3VwLCBi
b29sDQo+IGlzX2Jpbl9hdHRyKQ0KPiDCoHsNCj4gwqAJc3RydWN0IGtlcm5mc19ub2RlICpwYXJl
bnQ7DQo+IMKgCWt1aWRfdCB1aWQ7DQo+IEBAIC00MDgsMTQgKzQwOCw0OSBAQCBpbnQgc3lzZnNf
YWRkX2ZpbGVfdG9fZ3JvdXAoc3RydWN0IGtvYmplY3QNCj4gKmtvYmosDQo+IMKgCQlyZXR1cm4g
LUVOT0VOVDsNCj4gwqANCj4gwqAJa29iamVjdF9nZXRfb3duZXJzaGlwKGtvYmosICZ1aWQsICZn
aWQpOw0KPiAtCWVycm9yID0gc3lzZnNfYWRkX2ZpbGVfbW9kZV9ucyhwYXJlbnQsIGF0dHIsIGF0
dHItPm1vZGUsDQo+IHVpZCwgZ2lkLA0KPiAtCQkJCcKgwqDCoMKgwqDCoCBOVUxMKTsNCj4gKwlp
ZiAoaXNfYmluX2F0dHIpDQo+ICsJCWVycm9yID0gc3lzZnNfYWRkX2Jpbl9maWxlX21vZGVfbnMo
cGFyZW50LA0KPiB0b19iaW5fYXR0cihhdHRyKSwNCj4gKwkJCQkJCcKgwqAgYXR0ci0+bW9kZSwg
dWlkLA0KPiBnaWQsIE5VTEwpOw0KPiArCWVsc2UNCj4gKwkJZXJyb3IgPSBzeXNmc19hZGRfZmls
ZV9tb2RlX25zKHBhcmVudCwgYXR0ciwNCj4gKwkJCQkJwqDCoMKgwqDCoMKgIGF0dHItPm1vZGUs
IHVpZCwgZ2lkLA0KPiBOVUxMKTsNCj4gwqAJa2VybmZzX3B1dChwYXJlbnQpOw0KPiDCoA0KPiDC
oAlyZXR1cm4gZXJyb3I7DQo+IMKgfQ0KPiArDQo+ICsvKioNCj4gKyAqIHN5c2ZzX2FkZF9maWxl
X3RvX2dyb3VwIC0gYWRkIGFuIGF0dHJpYnV0ZSBmaWxlIHRvIGEgcHJlLWV4aXN0aW5nDQo+IGdy
b3VwLg0KPiArICogQGtvYmo6IG9iamVjdCB3ZSdyZSBhY3RpbmcgZm9yLg0KPiArICogQGF0dHI6
IGF0dHJpYnV0ZSBkZXNjcmlwdG9yLg0KPiArICogQGdyb3VwOiBncm91cCBuYW1lLg0KPiArICoN
Cj4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGVycm9yIGNvZGUgb24gZmFpbHVyZS4NCj4g
KyAqLw0KPiAraW50IHN5c2ZzX2FkZF9maWxlX3RvX2dyb3VwKHN0cnVjdCBrb2JqZWN0ICprb2Jq
LA0KPiArCQkJwqDCoMKgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsDQo+ICsJCQnCoMKg
wqAgY29uc3QgY2hhciAqZ3JvdXApDQo+ICt7DQo+ICsJcmV0dXJuIF9fc3lzZnNfYWRkX2ZpbGVf
dG9fZ3JvdXAoa29iaiwgYXR0ciwgZ3JvdXAsIGZhbHNlKTsNCj4gK30NCj4gwqBFWFBPUlRfU1lN
Qk9MX0dQTChzeXNmc19hZGRfZmlsZV90b19ncm91cCk7DQo+IMKgDQo+ICsvKioNCj4gKyAqIHN5
c2ZzX2FkZF9iaW5fZmlsZV90b19ncm91cCAtIGFkZCBiaW5fYXR0cmlidXRlIGZpbGUgdG8gcHJl
LQ0KPiBleGlzdGluZyBncm91cC4NCj4gKyAqIEBrb2JqOiBvYmplY3Qgd2UncmUgYWN0aW5nIGZv
ci4NCj4gKyAqIEBhdHRyOiBhdHRyaWJ1dGUgZGVzY3JpcHRvci4NCj4gKyAqIEBncm91cDogZ3Jv
dXAgbmFtZS4NCj4gKyAqDQo+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBjb2Rl
IG9uIGZhaWx1cmUuDQo+ICsgKi8NCj4gK2ludCBzeXNmc19hZGRfYmluX2ZpbGVfdG9fZ3JvdXAo
c3RydWN0IGtvYmplY3QgKmtvYmosDQo+ICsJCQkJY29uc3Qgc3RydWN0IGJpbl9hdHRyaWJ1dGUg
KmF0dHIsDQo+ICsJCQkJY29uc3QgY2hhciAqZ3JvdXApDQo+ICt7DQo+ICsJcmV0dXJuIF9fc3lz
ZnNfYWRkX2ZpbGVfdG9fZ3JvdXAoa29iaiwgJmF0dHItPmF0dHIsIGdyb3VwLA0KPiB0cnVlKTsN
Cj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHN5c2ZzX2FkZF9iaW5fZmlsZV90b19ncm91cCk7
DQo+ICsNCj4gwqAvKioNCj4gwqAgKiBzeXNmc19jaG1vZF9maWxlIC0gdXBkYXRlIHRoZSBtb2Rp
ZmllZCBtb2RlIHZhbHVlIG9uIGFuIG9iamVjdA0KPiBhdHRyaWJ1dGUuDQo+IMKgICogQGtvYmo6
IG9iamVjdCB3ZSdyZSBhY3RpbmcgZm9yLg0KPiBAQCAtNTY1LDYgKzYwMCwyMCBAQCB2b2lkIHN5
c2ZzX3JlbW92ZV9maWxlX2Zyb21fZ3JvdXAoc3RydWN0IGtvYmplY3QNCj4gKmtvYmosDQo+IMKg
fQ0KPiDCoEVYUE9SVF9TWU1CT0xfR1BMKHN5c2ZzX3JlbW92ZV9maWxlX2Zyb21fZ3JvdXApOw0K
PiDCoA0KPiArLyoqDQo+ICsgKiBzeXNmc19yZW1vdmVfYmluX2ZpbGVfZnJvbV9ncm91cCAtIHJl
bW92ZSBiaW5fYXR0cmlidXRlIGZpbGUgZnJvbQ0KPiBncm91cC4NCj4gKyAqIEBrb2JqOiBvYmpl
Y3Qgd2UncmUgYWN0aW5nIGZvci4NCj4gKyAqIEBhdHRyOiBhdHRyaWJ1dGUgZGVzY3JpcHRvci4N
Cj4gKyAqIEBncm91cDogZ3JvdXAgbmFtZS4NCj4gKyAqLw0KPiArdm9pZCBzeXNmc19yZW1vdmVf
YmluX2ZpbGVfZnJvbV9ncm91cChzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gKwkJCQnCoMKgwqDC
oMKgIGNvbnN0IHN0cnVjdCBiaW5fYXR0cmlidXRlDQo+ICphdHRyLA0KPiArCQkJCcKgwqDCoMKg
wqAgY29uc3QgY2hhciAqZ3JvdXApDQo+ICt7DQo+ICsJc3lzZnNfcmVtb3ZlX2ZpbGVfZnJvbV9n
cm91cChrb2JqLCAmYXR0ci0+YXR0ciwgZ3JvdXApOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9H
UEwoc3lzZnNfcmVtb3ZlX2Jpbl9maWxlX2Zyb21fZ3JvdXApOw0KPiArDQo+IMKgLyoqDQo+IMKg
ICoJc3lzZnNfY3JlYXRlX2Jpbl9maWxlIC0gY3JlYXRlIGJpbmFyeSBmaWxlIGZvciBvYmplY3Qu
DQo+IMKgICoJQGtvYmo6CW9iamVjdC4NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3lz
ZnMuaCBiL2luY2x1ZGUvbGludXgvc3lzZnMuaA0KPiBpbmRleCBhN2Q3MjVmYmY3MzkuLmFmZjFk
ODFlODk3MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9zeXNmcy5oDQo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvc3lzZnMuaA0KPiBAQCAtNDUxLDYgKzQ1MSwxMiBAQCBpbnQgc3lzZnNfYWRk
X2ZpbGVfdG9fZ3JvdXAoc3RydWN0IGtvYmplY3QNCj4gKmtvYmosDQo+IMKgCQkJY29uc3Qgc3Ry
dWN0IGF0dHJpYnV0ZSAqYXR0ciwgY29uc3QgY2hhcg0KPiAqZ3JvdXApOw0KPiDCoHZvaWQgc3lz
ZnNfcmVtb3ZlX2ZpbGVfZnJvbV9ncm91cChzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gwqAJCQlj
b25zdCBzdHJ1Y3QgYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyDQo+ICpncm91cCk7DQo+ICtp
bnQgc3lzZnNfYWRkX2Jpbl9maWxlX3RvX2dyb3VwKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiAr
CQkJCWNvbnN0IHN0cnVjdCBiaW5fYXR0cmlidXRlICphdHRyLA0KPiArCQkJCWNvbnN0IGNoYXIg
Kmdyb3VwKTsNCj4gK3ZvaWQgc3lzZnNfcmVtb3ZlX2Jpbl9maWxlX2Zyb21fZ3JvdXAoc3RydWN0
IGtvYmplY3QgKmtvYmosDQo+ICsJCQkJwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYmluX2F0dHJp
YnV0ZQ0KPiAqYXR0ciwNCj4gKwkJCQnCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmdyb3VwKTsNCj4g
wqBpbnQgc3lzZnNfbWVyZ2VfZ3JvdXAoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+IMKgCQnCoMKg
wqDCoMKgwqAgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqZ3JwKTsNCj4gwqB2b2lkIHN5
c2ZzX3VubWVyZ2VfZ3JvdXAoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+IEBAIC02NjAsNiArNjY2
LDE5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiBzeXNmc19yZW1vdmVfZmlsZV9mcm9tX2dyb3Vw
KHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiDCoHsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgaW5s
aW5lIGludCBzeXNmc19hZGRfYmluX2ZpbGVfdG9fZ3JvdXAoc3RydWN0IGtvYmplY3QgKmtvYmos
DQo+ICsJCQkJCcKgwqDCoMKgwqAgY29uc3Qgc3RydWN0DQo+IGJpbl9hdHRyaWJ1dGUgKmF0dHIs
DQo+ICsJCQkJCcKgwqDCoMKgwqAgY29uc3QgY2hhciAqZ3JvdXApDQo+ICt7DQo+ICsJcmV0dXJu
IDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzeXNmc19yZW1vdmVfYmluX2Zp
bGVfZnJvbV9ncm91cChzdHJ1Y3Qga29iamVjdA0KPiAqa29iaiwNCj4gKwkJCQkJwqDCoMKgwqDC
oCBjb25zdCBzdHJ1Y3QNCj4gYmluX2F0dHJpYnV0ZSAqYXR0ciwNCj4gKwkJCQkJwqDCoMKgwqDC
oCBjb25zdCBjaGFyICpncm91cCkNCj4gK3sNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBpbmxpbmUg
aW50IHN5c2ZzX21lcmdlX2dyb3VwKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiDCoAkJwqDCoMKg
wqDCoMKgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmdycCkNCj4gwqB7DQoNCg==

