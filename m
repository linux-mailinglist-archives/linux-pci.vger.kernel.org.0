Return-Path: <linux-pci+bounces-22185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49020A41A33
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53A73B5FBF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FE92500B6;
	Mon, 24 Feb 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3lnJfF32"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188B24E4CF;
	Mon, 24 Feb 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391261; cv=fail; b=OD1RgedJUqPO1IyvKywAtBJD4F1Tf+NXaCBBO/harAaDvu5SrMLae/80Sf/deQgXPQImuqxbaFbOXhWtQxIqBR4Rj/TYfx3N8kW2VS7Ob54kakNGUhyOHfoEKcPVeAkAqtbIksCfhq64TB0UqJhDQlorbJynPNvKZMhv0SyoUv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391261; c=relaxed/simple;
	bh=wdJlR/zvaqMUytCgYocL7epjIxRJnNFhHdvGSpa58aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/Biqy4IreyMgBDdByvMsBLftN93JWNZtcvDzDVyAx3fT/TpiCFnuW/h/DdOPzKRCi+HKXjQ8POiWFKB5Me+ARtr3V/6rNjfPUCqFa7EioH2+RL/2P3isw8BnwCua+gEY6dC5U08BBE8TxsTu0Bchny5q8uzldWa3qkspT8bv+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3lnJfF32; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2obGFuj2bp8LbLOW2OU6mz0idSNhjkejUyLSJjJZxT3TJYBdcfwXTeiAulLaUrnJ3OM94XbWSKd6smONqIdIiLSanLUseICwhMJlgWhaeKTv3Ik+y48HZlmE8z3EaRLUgaIS1T5w9jwo0qZHU5RRjt03kXWMZVaCGbyCOkMUvQcHuo2hD3SxWHhtDRGWLzLZqwQaIhzN0AlrTp9myp+rK2+8FJxZTbwApEdSrzjcuIg1Pc37O+PIFmiy2WVS0FcVJcgjyZDAngiQkjCCdI+oFN+q24iCZqynwUv2EQT+kyxvP8oLR5V/x20+WS/cH0psuphKOF7kThNYslXw70oKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdJlR/zvaqMUytCgYocL7epjIxRJnNFhHdvGSpa58aQ=;
 b=sGM0J9Is2BlWbbcj6JZf62bApVFbDuE5BeQXGvFC+imy/hpj4bBpvoRiEOPxjY67Y+GIyxDJiIW9ZgQiDZzgrogpoV229VZPRWXsoegFzzbtdM4nVzH0/QsT8oAes34oCjEjPI4LIlh1cUlusEMP9EegeakJ2NoEDiIP3ews14iZRnaFHvKsgXKUGRze3UUgkpjmH7DTHatCs7eOzK5HPclrm5R4laiCPes5pPObDv3Q1WSuHlP3xTXe3fohqs+a26JESGZfqcYA9sxfJC25/FeXPp4VnwF+vHtiR1CGIcEaFb2jrN2DcArrX9ZuTQAmcprdOsRLA5dYTQPb69F5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdJlR/zvaqMUytCgYocL7epjIxRJnNFhHdvGSpa58aQ=;
 b=3lnJfF325+wtBBaLTjf1mhj+bGd0aS/4NZbq1qq/RCiu5AxJlZiMkNvLAa4lXMAccgiWAOf/YmoXjc2yQKRkK6Wm/D61BC8Jz1OivRnky0O1ZAIfSq7t5b9JGK2WMl7ff9Cc7Anhs8njVK7dWlxCRgcO1zUrwJcYtU2rGhq13PE=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 10:00:56 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 10:00:56 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Thread-Index: AQHbho+bOvyIQPF4WUK3tb5hxErFp7NWGPYAgAAfsHA=
Date: Mon, 24 Feb 2025 10:00:56 +0000
Message-ID:
 <SN7PR12MB720105B1595D96791B90A14E8BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
 <20250224074143.767442-3-thippeswamy.havalige@amd.com>
 <20250224080644.ldgltonirrtfzrgp@thinkpad>
In-Reply-To: <20250224080644.ldgltonirrtfzrgp@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SN7PR12MB8818:EE_
x-ms-office365-filtering-correlation-id: cd8345fa-7188-4d5a-b2f5-08dd54ba21eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVhDNUdIVEptQlozbGI1VEViU3dzQXQwbEE3cUN5MjU2aGR6TStEVC9mS0Iy?=
 =?utf-8?B?aVpqYzRLZW9XWmhGdDFiTk40dEFOcVBxMi84TnVObENhVU5UeHNkS1JpU2o2?=
 =?utf-8?B?MWRYRlhKejNlekVWditqR3BETkhQSzlCaFZhVW54T2FUK2E4SXZNMG1ObjdH?=
 =?utf-8?B?b0kxMlZnWEFheng5cVc1UDlWVzAyZUsvL3A4TXJSVXlqSmxVeWNQcm9QZGxp?=
 =?utf-8?B?VkxobTRHQVdzdVhZU3dzdjhDV0d6eEJvMDJwTkVQNmxPaXB2cE40THdGTUpN?=
 =?utf-8?B?alBmejRzYVZNeEhNN2FCcm9yS2l3NU41aGZSQUVKUENxaVVZbVREM1Avc1NB?=
 =?utf-8?B?V0FlbEUxVXVsN3JJNE1LQi9lOU92bkhObm94MnlsYUVlVzcwNmdIQmNDSUdi?=
 =?utf-8?B?K1M4czhsZDU2clZzWVVrOFNvUjE5blBPQmZiaTBZQ01zOVBHdlBtdGR3Mytz?=
 =?utf-8?B?Vjl1YmlYblF6bk5CeldqblhFV29Ob2djc0tUT285bjdvOFFpY0R5elR5S2o5?=
 =?utf-8?B?NjczWENRWUh6NG51OU5TejIrZll5TGFBT1Y4THZtR0tEMmh6R2h0dGFSVHYy?=
 =?utf-8?B?dGtnRjJRWEhjVUI0Y1FsTndZNHE1bHJ6VmlVMnp0RGZZcVhjSjhFSkk3SFov?=
 =?utf-8?B?OGhxNjZSZkUvZWZpeXRpWG9EMjlBVUlGUmNOSG5IZHlrcWlmTlFzbnNKRlpT?=
 =?utf-8?B?aWVVMW56Wm5JVmdySEFINVRmcUFLR3lrUnpMK25QSXJoTWFJbzFPb2ViN2ZP?=
 =?utf-8?B?eGRwelYvaGR2OVpJejU3d0RwSEZuYm1mZmducHgzNER3ZlZuM28xUjBOelB2?=
 =?utf-8?B?ak1HMVMwK3VEeWZpWDFldXVYNm5iWm4wZ0JZQnk3dWpBMlJ4bFREa3V0a0hL?=
 =?utf-8?B?L1Yya0d3dEJBL1BnVkIvTHR1S25CQmw0WDBjLzVUK0hJZnUwcVBxejh4TnBN?=
 =?utf-8?B?QW42akE5MXVYZUdSaUZSTkQ3V0RGaytYMkhJTzRSNUZGN1ZBWkhoSzVaa0Vm?=
 =?utf-8?B?RDRQQmhDZ2Y5V3JwSjZRelNhQmFXU2p5WnM3TTZEQTBDRm9LaUs2UkgvNko5?=
 =?utf-8?B?Rk1JRnh6dkdHdVhUZnRmaytrQnRHajFZdjVlejhPdVd4MVVRYVIxRXp6Rlkx?=
 =?utf-8?B?NXU3OWh1WVlIUFVnb2NYT21BVnR4dFNPb0lvRVNjTEgzZlhvdithK1RTWGoy?=
 =?utf-8?B?ZXBQZEs4bTdGcnBvVGFhM0xHRWVFenVlWVRKU29XZlgwWkMvRHpKM2dBSVdp?=
 =?utf-8?B?aE1PSFFJNVpGSUVML0U1Z3FoMFZBelIyYmgxd0VjMSswaUZQNldZTmRkMklZ?=
 =?utf-8?B?aEx5OThsMnVoMURhaHI1T0M3U2FqVGpvR2traXlrekNONXVVemkvZ1ZRU0d2?=
 =?utf-8?B?VWVySlkzRjRFMzJidzdvZFpTVC9WZWROYnU0ZHJKTkplMlNQYkNtNWlSRGtY?=
 =?utf-8?B?ZE9vbE51aDRUcGJkZWZvUWloTEI2VURtWVg4b3d3S2Z0ZGZ5TmhRVG42MUVj?=
 =?utf-8?B?akk4cFJRNVNxU2o2cjJncUhOM0I5ZGJMTDMrcURLb1pXVmxOQ1F0M2x2QlE1?=
 =?utf-8?B?L2lBTmJUOVNQMEJSZjRrOE5NR1RaQ2hhNDJsVmhLK09JWEU4Ymc2ZE9aUkhY?=
 =?utf-8?B?MWdCWGUwSDZ5aGpWRnc5V1BtbVN1bm1YcXRIT2djczB3a0F2Zm5jcVUwYTJN?=
 =?utf-8?B?bDFiaVIxQlVpSFhLZGsva0FoMFh5amlSTldaVVpHWU5WSHIyeFBaeWYxOEkr?=
 =?utf-8?B?YkhhQndvdWpuV2F4QVExVjIveFZVaCs3WUpUYXRLQlJjMUloQlR3M1cvTW5k?=
 =?utf-8?B?bGxFVDN4SmRCQnVWYm9Oa3cwMFoxYWJLTzFKKzYvOFBJTzhVY3kzR0lYOXp4?=
 =?utf-8?B?YzF0azY0QXVnMlNnT3hxTWMxN044czk3S2lURHRDRnh3d3BYNm5yM1pLZVlW?=
 =?utf-8?Q?ij8D47gq+IJZXDyndkJLnDdib8jHxVxz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDEyRVpzYUJTbnF4c1N1SjVLOHFYRFNnak9vc1UzOTNZa0R5Y0NoYjNqTVFK?=
 =?utf-8?B?Mjh3M2pKeDQzeDZiWTJBekFTTjJtR2lJTFQzekNTTGhNZzc3WVF3T29YeU55?=
 =?utf-8?B?aGhQN2tUZlpZL1RXU3N4ay9ER1pWTFI1alB0Z1hMTUQvYkZpOTJ0QTgvNld2?=
 =?utf-8?B?Vk1rZG9pdW42MkdsODN0TVV2WGpjMVlIaEh4amYxY2Y4b1E4WEs0RFpGU3R1?=
 =?utf-8?B?RlQ4aGw2UFhBcDcyZG9pc25kTzNDYVdEa29yTEpudTJWbWdwN05MTFlaUVFz?=
 =?utf-8?B?VFc2TmNzd0t1Yko3UG9pbUp4SGRPUk1BNzhrZjRpVFNRTTBkcytzb1BaSEVT?=
 =?utf-8?B?RjF4SWFnbThYN2NmTldxM09zYkFQakZlM0M2RmxsYk11Z0JrN25GWS80a2Vq?=
 =?utf-8?B?RVllL3hhZ2hnOC9FWFBoL3RUMzcyMXBKQyttTnlpT1lDejFtdXd6Rm9wQkdu?=
 =?utf-8?B?YTNQNEt1dTJPSWUycTE5MDZtZ0JDeHp0c2ZtRjdOVzRWMkNpbFpzUUFoTXJi?=
 =?utf-8?B?ZHVaSXVWMzgwTUtKQmFYYjVJNk5ZeExpYWtQWEJ5UmIyZElZSTdOZGxISTN4?=
 =?utf-8?B?eXhXelpoZEk4aHhXcVM4VlQyc2M5RHRiaVoydG5jTXEvZUh4eW0vaWtlcWVw?=
 =?utf-8?B?UVhrdFNwaUZwb2VoNG5YYzBOR00xclQ3WjdkdHV0a01wNEl4akVETDFmYks2?=
 =?utf-8?B?U3NRY1EyRlNnSFZ5dkVsVk5iVUZPM25mS21HUnFvOFkyWXlzSWlrWkFndGlX?=
 =?utf-8?B?eENpaXVMd0o4KzU2RklGdklHRDZESXZUcG9LWDNzdFh1bS9YL01FdTZoNkgz?=
 =?utf-8?B?UWhIdWRTZlh2OHJUTkJVblNxUWhPZXZ4TS9uTVFsM1hQa0pEamRkY3hnSDdq?=
 =?utf-8?B?bGcwR3RrdWpXOFRiaERNTW1CelpFWUhHSlQ3T3RBS0RvMXZVRXo5djZYRW9y?=
 =?utf-8?B?OExvQmJ4Q2lGVjRtb21pY0JUTHJmZEtidmlVVmZreWhpaXhCNitWSUtMa2gz?=
 =?utf-8?B?djc3RmxONjlWTW93NHhnNFFYNUIyZVZkWS93VW44LzI1VGgwdU4xK1Y0UDM2?=
 =?utf-8?B?M29uT2FPdEVCMS96WElZVkd5Mmw1YTI4b2ZvU0YrZ2R4QzlSVytGODEyeUxM?=
 =?utf-8?B?YjdCOVFOaFlmQ0V2RXJEN3Fjd0pzR2pCZjh4Y3pWdnl4WElGY2RRU2lWTGps?=
 =?utf-8?B?ckdnTm9GNEhJTkdsbXRtaVJ5SlBYeTFJZ3F0b045MkFMeWxqQ2ZzNUM3dUJt?=
 =?utf-8?B?ZFJ4dVgrRE9QdEhZck9EV1ZOenQ1YTBoZnJ0Wk9JRDlXcVVudVFTUEtRT3VL?=
 =?utf-8?B?aE0yWWNqSjhsTXZBYXphYjZrUlAyN2RONWo4dWtEcG93czBLQlFlWWZtQjNn?=
 =?utf-8?B?RGxyaFNkSkZGTXJNc09ydWs2UmFRdm1PSm03bDB6bU5qNTV0RkUwVjRuUkRR?=
 =?utf-8?B?WnljOW0yaVBTbDUyNTk0ajM0WmRzZVBDUVZxUVhEZjBsbWxOUnpzOGZwZWZq?=
 =?utf-8?B?MGFRSHhWNm9QeFRYbzNkVWVHZGNkK09JYUJPN1NHalZkT1hkbk9YWWhaKzRU?=
 =?utf-8?B?UlF1eFNVejhUNkIzTXZHcHNZTEhEY2NUUDk0Vnp1aC95cXh0NlBwZEQxL1JI?=
 =?utf-8?B?Y3A4aHdCc05DSnBXUDZackNYZDVUbGdzWW1SQnd2Y0NVOHlLdEJZYU5uV2tU?=
 =?utf-8?B?NytDZkZkQ3dWR1VJS09tZjNGTHQvN3pBWTEyUUpjdUFWejRMSTV6VTNWN3Fo?=
 =?utf-8?B?NkhFL1pQYWxTVnhzU2lKWDRvRHF6aWxpRnFxb2lIUEVCaVVJM3lLbXJraFVQ?=
 =?utf-8?B?NTAwUDJpNVg1Y2x5TnVpSElxOFhyYlhjbmUxUU5hMkUxdUU4eXRtbjFLNldq?=
 =?utf-8?B?cjJwNmpLZmpBR1FJVllEY2NUR0djc1c3cEhYenhWb2tPeU1KQnBZbGNVZG5Q?=
 =?utf-8?B?aElLaWgvbjFiRnBsMlE1WnNxUll3VUhDaG5NVmlPUzNhQ3oyMHNuM1h4L25H?=
 =?utf-8?B?anNkNDZtd2FmQm1QUzliOEtZT1lsUjdMd3Z1MHhoTS9CaU1hblpGcUZScWJO?=
 =?utf-8?B?RitLSEdPaEdRQmZSK3YrOTIwQXkwcDNvM2F2VFRQaXNwM21lNy84U0haZ3ds?=
 =?utf-8?Q?Lg/Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8345fa-7188-4d5a-b2f5-08dd54ba21eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 10:00:56.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iw/7cce1Zi5EOV2yHLppUCCBfNffjsHq2mXkVLy+o57cJHqS7k6JXui5ZdsqSgocn+dOR2g1El4hVanDRW5DOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818

SGkgTWFuaSwNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgJiBJIGxsIHVwZGF0ZSBiZWxvdyBjb21t
ZW50IGluIG5leHQgcGF0Y2guDQoNClJlZ2FyZHMsDQpUaGlwcGVzd2FteSBIDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5u
YW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPiANClNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjQsIDIw
MjUgMTozNyBQTQ0KVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhpcHBlc3dhbXkuaGF2YWxp
Z2VAYW1kLmNvbT4NCkNjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5v
cmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNv
bm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaW1laywgTWlj
aGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdvZ2FkYSwgQmhhcmF0IEt1bWFyIDxiaGFyYXQu
a3VtYXIuZ29nYWRhQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gUENJOiB4
aWxpbngtY3BtOiBBZGQgc3VwcG9ydCBmb3IgVmVyc2FsIE5ldCBDUE01TkMgUm9vdCBQb3J0IGNv
bnRyb2xsZXINCg0KT24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgMDE6MTE6NDNQTSArMDUzMCwgVGhp
cHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6DQo+IFRoZSBWZXJzYWwgTmV0IEFDQVAgKEFkYXB0aXZl
IENvbXB1dGUgQWNjZWxlcmF0aW9uIFBsYXRmb3JtKSBkZXZpY2VzDQo+IGluY29ycG9yYXRlIHRo
ZSBDb2hlcmVuY3kgYW5kIFBDSWUgR2VuNSBNb2R1bGUsIHNwZWNpZmljYWxseSB0aGUNCj4gTmV4
dC1HZW5lcmF0aW9uIENvbXBhY3QgTW9kdWxlIChDUE01TkMpLg0KPiANCj4gVGhlIGludGVncmF0
ZWQgQ1BNNU5DIGJsb2NrLCBhbG9uZyB3aXRoIHRoZSBidWlsdC1pbiBicmlkZ2UsIGNhbiBmdW5j
dGlvbg0KPiBhcyBhIFBDSWUgUm9vdCBQb3J0ICYgc3VwcG9ydHMgdGhlIFBDSWUgR2VuNSBwcm90
b2NvbCB3aXRoIGRhdGEgdHJhbnNmZXINCj4gcmF0ZXMgb2YgdXAgdG8gMzIgR1QvcywgY2FwYWJs
ZSBvZiBzdXBwb3J0aW5nIHVwIHRvIGEgeDE2IGxhbmUtd2lkdGgNCj4gY29uZmlndXJhdGlvbi4N
Cj4gDQo+IEJyaWRnZSBlcnJvcnMgYXJlIG1hbmFnZWQgdXNpbmcgYSBzcGVjaWZpYyBpbnRlcnJ1
cHQgbGluZSBkZXNpZ25lZCBmb3INCj4gQ1BNNU4uIElOVHggaW50ZXJydXB0IHN1cHBvcnQgaXMg
bm90IGF2YWlsYWJsZS4NCj4gDQo+IEN1cnJlbnRseSBpbiB0aGlzIGNvbW1pdCBwbGF0Zm9ybSBz
cGVjaWZpYyBCcmlkZ2UgZXJyb3JzIHN1cHBvcnQgaXMgbm90DQo+IGFkZGVkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogVGhpcHBlc3dhbXkgSGF2YWxpZ2UgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFt
ZC5jb20+DQoNClJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4u
c2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KDQpPbmUgY29tbWVudCBiZWxvdyB3aGljaCBpcyBub3Qg
cmVsYXRlZCB0byAqdGhpcyogcGF0Y2gsIGJ1dCBzaG91bGQgYmUgZml4ZWQNCnNlcGFyYXRlbHkg
KGlkZWFsbHkgYmVmb3JlIHRoaXMgcGF0Y2gpLg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZS4NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBBZGRyZXNz
IHJldmlldyBjb21tZW50cy4NCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
eGlsaW54LWNwbS5jIHwgNDAgKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC1jcG0uYyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gaW5kZXggODFlOGJmYWU1M2QwLi5hMDgx
NWM1MDEwZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxp
bngtY3BtLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC1jcG0u
Yw0KPiBAQCAtODQsNiArODQsNyBAQCBlbnVtIHhpbGlueF9jcG1fdmVyc2lvbiB7DQo+ICAJQ1BN
LA0KPiAgCUNQTTUsDQo+ICAJQ1BNNV9IT1NUMSwNCj4gKwlDUE01TkNfSE9TVCwNCj4gIH07DQo+
ICANCj4gIC8qKg0KPiBAQCAtNDc4LDYgKzQ3OSw5IEBAIHN0YXRpYyB2b2lkIHhpbGlueF9jcG1f
cGNpZV9pbml0X3BvcnQoc3RydWN0IHhpbGlueF9jcG1fcGNpZSAqcG9ydCkNCj4gIHsNCj4gIAlj
b25zdCBzdHJ1Y3QgeGlsaW54X2NwbV92YXJpYW50ICp2YXJpYW50ID0gcG9ydC0+dmFyaWFudDsN
Cj4gIA0KPiArCWlmICh2YXJpYW50LT52ZXJzaW9uICE9IENQTTVOQ19IT1NUKQ0KPiArCQlyZXR1
cm47DQo+ICsNCj4gIAlpZiAoY3BtX3BjaWVfbGlua191cChwb3J0KSkNCj4gIAkJZGV2X2luZm8o
cG9ydC0+ZGV2LCAiUENJZSBMaW5rIGlzIFVQXG4iKTsNCj4gIAllbHNlDQo+IEBAIC01NzgsMTYg
KzU4MiwxOCBAQCBzdGF0aWMgaW50IHhpbGlueF9jcG1fcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcG9ydC0+ZGV2ID0gZGV2Ow0KPiAgDQo+IC0JZXJy
ID0geGlsaW54X2NwbV9wY2llX2luaXRfaXJxX2RvbWFpbihwb3J0KTsNCj4gLQlpZiAoZXJyKQ0K
PiAtCQlyZXR1cm4gZXJyOw0KPiArCXBvcnQtPnZhcmlhbnQgPSBvZl9kZXZpY2VfZ2V0X21hdGNo
X2RhdGEoZGV2KTsNCj4gKw0KPiArCWlmIChwb3J0LT52YXJpYW50LT52ZXJzaW9uICE9IENQTTVO
Q19IT1NUKSB7DQo+ICsJCWVyciA9IHhpbGlueF9jcG1fcGNpZV9pbml0X2lycV9kb21haW4ocG9y
dCk7DQo+ICsJCWlmIChlcnIpDQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArCX0NCj4gIA0KPiAgCWJ1
cyA9IHJlc291cmNlX2xpc3RfZmlyc3RfdHlwZSgmYnJpZGdlLT53aW5kb3dzLCBJT1JFU09VUkNF
X0JVUyk7DQo+ICAJaWYgKCFidXMpDQo+ICAJCXJldHVybiAtRU5PREVWOw0KDQpIZXJlLCB4aWxp
bnhfY3BtX2ZyZWVfaXJxX2RvbWFpbnMoKSBzaG91bGQgYmUgY2FsbGVkIGluIHRoZSBlcnJvciBw
YXRoLg0KDQotIE1hbmkNCg0KLS0gDQrgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k
4K6+4K6a4K6/4K614K6u4K+NDQo=

