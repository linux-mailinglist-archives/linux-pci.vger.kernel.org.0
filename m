Return-Path: <linux-pci+bounces-42923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B93CB46D8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 02:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B876305116E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8A826B764;
	Thu, 11 Dec 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4rDupcW"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2223EA83;
	Thu, 11 Dec 2025 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765416295; cv=fail; b=Ld1nATb5UDrAyJAWtgBrm3xvD8K6WO2Bf1tG0Z0sjB/RvKIWQH6tIkdunw54yj0JGs2s2n1jR/orQiAEgAPHDV+lcosYUGiEILbhSDgUeTDHbd3z+SjZLaUFTuL/SveixX2BUNd3wUqNrtbgePenRq/X27tjAwnUd/uu2IU+AmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765416295; c=relaxed/simple;
	bh=ez9h0pJLpAxzBBFz/v/Q2NFk6NAGSbMdp6wM1t/IrK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aTAJ0FWRIY9LAr9qg34BeJDfMsbJziTYhy/tPQwLp/FJ8H78Kx1VPrGQ0kkF6Nm15msPe7Kb38M2brp/CXcCRK+zRRHfKtaNR+UR0cvzcxczZpfCh5+6YBZfkj8Z194x3BrcpJBZbI977k1Kiz0+yzoMPglpg/fWFMqwW0rIISg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r4rDupcW; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tkf7K71HFYPXK+Mcx+PcpGbXB7f2eU+/hZm4qD1sf1fQstc+qfsjM3UIVXoUIY7dGSFWT8BaLl6fDOSFiTxGZz9Ozn3UjRmLXDm6vqjUEkxaOR38HXRnTLJjpfC5hEv6FdpsbqYV2e7HIfTtrJJSonnBaL1nEXHUPO61gzD++LDdg9+Z/04M0zIsFe9R5OSVo/0Ex9P/qhj0h3sKXdNOqTGtBIbF+NPOXdmLXniHKhZKYLbW9qAxPgfWWhaIsibNdpjBCbV466UUePWpDZ9j2inWiiy1CLx26yaTiBmqmSIz8ETMoV+1a2bCcm41XKUXAbzkO7+6AbneCVyV9N143Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez9h0pJLpAxzBBFz/v/Q2NFk6NAGSbMdp6wM1t/IrK8=;
 b=ayABOEg3cAD033XUwwvVx1peILOVYbMpys0Ed445LHr6imanoT5x9qKXLCdFSX9y4AIGZWLKNkPo+m2obaokw+7Z7UcFkB+/XidrvykXKp2JmInVuS1yYytLqmM4j98TNvCDGjchB7DMeDltiYVexto8st2n2+iv1BC0ZD5mvXX7j1iQ/xP0caGLbTTubRW+odgkO+rYacVWmquMmzOlghLVyfGc6YNCSbFJyCvsPG4BWMp0kN/hxPT2Y5G2t7ru8gNLnbOSYhUAdoz7uDQQoqB6Ftlq6icwM/m50rkxNyNuSOPaBxT2kd20DHW9MtNmomAycmnnPtpx4WqQCCnpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez9h0pJLpAxzBBFz/v/Q2NFk6NAGSbMdp6wM1t/IrK8=;
 b=r4rDupcWZRgwzAD7x3NZSj5gKmcY01NU2a76SnLeVO2RQTqEO/eY9tevPfsUBhqsJAqQ0QxAoClEb1Uc8W41GUHe8AXZEnlbR5Ze7X9zogDsgDEQL4B4mR6XOm4O7kLtFWndHGtWyGU0wjpBFuXNwrCf7iHJiVmLhWOedcZRNNIb+L8hfxswElKLx47LiUq9dreaM8o8sJ1ZIFc9j1taE65cvejJgAKhTOLWTGLjuc9Vn9IZmaA53APXSmx/OZPERMaTwcCE5ec4WOxNFPcx0BcEoGcjA9/WBbvQVmyBSS9dIjaD2XEyySmiRNeOTOZAW1gY1Es9IBYvDqQo8cs5nA==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 01:24:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 01:24:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
CC: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "dakr@kernel.org" <dakr@kernel.org>,
	"aliceryhl@google.com" <aliceryhl@google.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "alex.gaynor@gmail.com"
	<alex.gaynor@gmail.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"gary@garyguo.net" <gary@garyguo.net>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "lossin@kernel.org" <lossin@kernel.org>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "markus.probst@posteo.de" <markus.probst@posteo.de>,
	"helgaas@kernel.org" <helgaas@kernel.org>, Neo Jia <cjia@nvidia.com>,
	"alex@shazbot.org" <alex@shazbot.org>, Surath Mitra <smitra@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)"
	<targupta@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, John Hubbard
	<jhubbard@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
Thread-Topic: [RFC 7/7] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
Thread-Index: AQHcZq3ICou07m2NR0qQln4XE6jvOLUVdFkAgAPn+oCAAlA02A==
Date: Thu, 11 Dec 2025 01:24:49 +0000
Message-ID: <E8245EE2-887A-447A-8576-DC845FD57DC1@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-8-zhiw@nvidia.com>
 <47c05bcf-7591-4148-8783-0c107b0c3c9d@nvidia.com>
 <20251209160515.6658881a@inno-ThinkPad-X280>
In-Reply-To: <20251209160515.6658881a@inno-ThinkPad-X280>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|PH7PR12MB8038:EE_
x-ms-office365-filtering-correlation-id: 07fe6a33-f752-4872-9960-08de38541401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVBSaTk0UXN0eXRSYWJOOFdjYnJwQUVuNTZ3K0JHTkVjemNZZ0J4WWdUbkh4?=
 =?utf-8?B?MUJKNDBYeW5hSTk2RkwxRnR3cHZ3Z3dlb0F2Zk9iVWxCcG5vRDV0MlJXSWcy?=
 =?utf-8?B?M0lYL0FHbHlOVGwrdmNWMU51UGZBM2NOYmlyd2hSN2pGNTdSeEE3Z09xNUFV?=
 =?utf-8?B?NlFydzNmci9jd2E1RzdlL0pWcE1ZODljTTZXaEJZSDE2VXh6RDdBRjBtdkxH?=
 =?utf-8?B?VmUwRkRVUzFBTG55U09sMG13cndhVm1vdzkvQTZqU21QQnYxaklydFNBNEhO?=
 =?utf-8?B?MW96MGxhL09LbmJ3QS8xVGZwMGdGUVBDL1hsalloazR3elJoZGhESGM3S0Jn?=
 =?utf-8?B?Ym5NZzJLWWRnTUFCZ2t4UnZBamtUSVRuV1pUYnMvc29nMVJldStaZmFOVkJL?=
 =?utf-8?B?Q0tXUE9xQ3dIckRpNzYweDZQZzZyaUtScUtjc1Z2YzZzT0h4bXNCWmE4MVZZ?=
 =?utf-8?B?UmdlYndsdnhhdW9nTmhmL3dQdGR6SUpTMFRoSVF2WEowbExEODNwa201L1Zv?=
 =?utf-8?B?TC9oMmZ6b2JINmp3K09HZklscWhTV0ZYYWsxOTNUbjNBUmdrVXVKSHFWYUJV?=
 =?utf-8?B?SDZSQmFNUnlkZWtnQ1ZBMSt3Q011S1QzZ1VXSDQ1TnFtckhFc09KdU9yWm9K?=
 =?utf-8?B?YVkrZkVESVFFSEpKVkpZZVRZY3hJQTR1ODlpWmFQemxiNXRiU084RXEwa2hq?=
 =?utf-8?B?MnJRdTBWb1NWRkVnU05zUjRUNjVWVlk1TS9qcmZDN2cxS2wyR3IwaWFZSHZO?=
 =?utf-8?B?ZGE4MTIrWDg2cFMwTnVXbnZ5d0FZMTBoYlNpS08raWNHZkFHQ1pYVGF6R0Fo?=
 =?utf-8?B?VklYWnJvWWNKODRGQ0pVTVRCUWZGUGRTczNvVmJ1Mm9zdXZlSmRZd2ZsemUr?=
 =?utf-8?B?V0hydVJRTGtGaktFVEx1S3RaZFprWW0rMENWQnA2R2dPTTJOcjNLMGtaRTc1?=
 =?utf-8?B?M01GdmJncXM3VUJMZi9mcEE2RkpXTERHbCtHNUlMdmx3T2VNNDN0WGIvTHZh?=
 =?utf-8?B?NzlPMmQrZ1lCeCtDRy9LY0ZVaTZKY0RoZWRpME9tUDltZ2drZDYwY2J5d21U?=
 =?utf-8?B?c2ZvVUtEMENPUm5zRHFRem0wUHgrQU5iTWRiQ1hUNkRJMHJpUUhnWko4Tmcx?=
 =?utf-8?B?bGkwREVRQ1J1WjlYTndFRDlPUmJ4Y1pKb0dTNGg3OUwxdDQvMGs0UEVUMjUy?=
 =?utf-8?B?NGJ6Kzl6OGFvb3hsVTVvZzgzcWs2L2tjNnhiM3lkVUxYMWc0dDc4aDNxeFF2?=
 =?utf-8?B?RGdBVnp1RmJvVEZPeDZ2V1d5eGcrTnJka0IrZWNyWTdrWW9qMEhsNit5eVFu?=
 =?utf-8?B?UytROGJuMlUrTXdLVXp6L2k0dEl4OUJUQy92MG1hSFlPZVdpYVYzbmxFYkhV?=
 =?utf-8?B?UTVYWG5hWUQzK0MrYXBQTWdoVjVxV1RGVUo4NGpmRWlTSjRUWElzSDdwekkv?=
 =?utf-8?B?UmU2UmEySHNwWUQxOUtSbVA2ejFNaWhtL1VrcndaTlRnbDhCbGVOMjM5aENo?=
 =?utf-8?B?TVdFR0FOYUs4WWxmakFITWd6QU1RaEtrTXZMaUZrV3huYW1oK2pLRDdOMStH?=
 =?utf-8?B?K1dBWmorQzl5cjlqUTNkRzBwRDFiYWV4ZXgrc1NBclVOcVpvS3lqcUZuN2ZK?=
 =?utf-8?B?dUpnaS9IMDNSNHFQbUtDcEp1K1pMQlE1dFByNWplNkcyQ1M2M2NqRklncm52?=
 =?utf-8?B?cGFtNDR4RjZKWmZjZ3ZLN0xvZXVacTMrRjRQeVN6T3dodXlqYUU4SjIzaUJ1?=
 =?utf-8?B?TmVoNWtYdUhPc2gvSG1KbGtEOGd2THgzM1Jqb3RRWFl2dDlNalFLRlI0ZDc3?=
 =?utf-8?B?OUh2K1UwOEVWVTdleUxnYWJ5NTlDQ0F2Z1FaM0FpN3dNV3dCOW1HbXVRMy9Z?=
 =?utf-8?B?MUxmYlVWajRDVzhTOThPMmtBVE1GNUVXbGFUd2xIa1JLNXJxQW4xcDJzQlo5?=
 =?utf-8?B?NmNnRzl0bVdBSHBES250OHlpcm04bUp2dTk0ZW9QaWxicDlnSERoR2NsWTdp?=
 =?utf-8?B?aUFLd3pqZ2NJWStGdmlDZUM1QWxyZmdDcGxXckcyWEs2KzFBZlpwT1I0ZnR1?=
 =?utf-8?Q?/XpTWt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vk1FL3hXd25FYW1hbnZyV0ltVkhGZkFub3ZKbUdja2FoTW1jQ2wwRXJTUVph?=
 =?utf-8?B?bXRqbTRDSmRCSk9ZQzZsbEYrNkNzYkM2ZEo0Z2ovMi9Cd2V4cmRFU0l6ZDZV?=
 =?utf-8?B?ZEZBZHVncnY3T0Z2cjlxVVdFaHhJaDV3bjk2ci9CcFQwNGk0L0ZIVTY1dzFF?=
 =?utf-8?B?b2E2eTJ3U0dYbXV1K1JGNXlCWG0vZCszeDBrOFFSS0trNDRHQm1sak1yK2ZI?=
 =?utf-8?B?UDJXK0VwZUNjU3VLUHlzOXpydmZlY3ViWlVadFlzb0g2a3N4dHJCT0FlSTBV?=
 =?utf-8?B?YU9qdzhCcm1VOVU3SFdtV25xajFQVnhMTHZIQnhFelphKzB1aDcrOFA5eDF1?=
 =?utf-8?B?MXh4WWExRGlDZDFNT1FXQzB3SThnLytaMG9ZZktUTUoreVVENko2ZTNBMHFB?=
 =?utf-8?B?NUZGY0o1Rkh6MU9vVEJIMlBKL1pYY1RoZnFNNGN6VmlZV2hYTWZCSSt1VytU?=
 =?utf-8?B?TEJrZ01kUzg0MklTcFJjUlA5cG9DK3FLR0VySE10UHpjTG9OUmFRM3cyTGll?=
 =?utf-8?B?UnFRS3FKYlRGem5HWFNEM1RDSjVxaS9YeG5oL1BxZ3VLT2NjQjVhN1ZCdEx5?=
 =?utf-8?B?RFg5UFBYRFBmMWJFL0tzUFprbXpyWGd2b3hBUjVyaG12cTVsSUlrdVU2N3Rj?=
 =?utf-8?B?QW1CUnFRdzhzRGhJWHY1R3FDRWJOL0pCa3NmNHJPSDdLSmFacjR6MjNBRWVE?=
 =?utf-8?B?TklxSkJubks3NkFIWGx4cXA1SENJOWljbGN6THh1b3d4WXl5V283Tk9VWTJ2?=
 =?utf-8?B?SW95TW1aTjlNSmVleG1valdiVCtXREl6anVRejRJSmF2QURhcnZzeE0rRUh6?=
 =?utf-8?B?NEVvcVRYdnZFb2s2cDVFbjJXVSs0bzFWUXZqd3Y1cHRTSEo2L1EvU2ZtUFFC?=
 =?utf-8?B?Mlo5bEtLNHVNMHBXR0NkOGF6VUpkT0RBS0JodGpBamtEeGtQdm5vbm1VU1ll?=
 =?utf-8?B?Z1FzdG15bjlvZmxVZ3QrZnV1cVpaMm11NXV2VmswWENuNWZkNE1ISkRqQjF0?=
 =?utf-8?B?UnV6YnRTV1RleTU5NGxLdTlGZVFvRHk2bjdnUDAvVlpHV2J6dEF4MFNBbFNr?=
 =?utf-8?B?aXNySWJOdXRzZTRZcUljZ29GWE1IN0sxaVRHUENwZG1sNkdHekJrK2tzUEJj?=
 =?utf-8?B?Yks0L3NGV3BFOGhOeXdLa1JRd0VnUnh6dWhIeFh2R1N4RkdjNjBlWjM1Znc0?=
 =?utf-8?B?OWpXZE9MWkdFSlNGTHA0YTBSZnhWZERKTzRvbnBIaktlM0JadHFvczRpQWg2?=
 =?utf-8?B?SjVtS1N0V3c4dTBrRHF5eWJPak1nUU9RUDdNZzFkVHFoNnNSQnF0RDdsS2Vv?=
 =?utf-8?B?NGRPelhoY3ozNXQrNWVrRFl2Y2h1VlZGblRGM3lYbGthbml6M1ljVDBBMWRP?=
 =?utf-8?B?Znl1TTA4VVZyeGQyQldhbXFzT0lSNElHNE5ia0ROU214WWZWT2xibTVzdTNB?=
 =?utf-8?B?S2pZUEI5akJwWWUyWXRoblZpVmNzRXptLzkrcmlNS1NiblNyZzZTc2k4cEEy?=
 =?utf-8?B?V0FHRUtnZEsyNlgwcExZcFVRbVVzbjRpb3FuYTRGaUltdkxSUStxdXB2aGhi?=
 =?utf-8?B?Ymo5Y3ZxSHpsdVJmdnk1QlpFbWZpMEcwemQ5Mnh2K0FUd2hzQXMzVFBjdFRn?=
 =?utf-8?B?aVh0TW1sT2I0cktiZDZsOWJwRzNMc2l0cFIvZTR2QzRZM2FRd2x5ZlV2dnBs?=
 =?utf-8?B?M0VLMUlsem5taytmeDhaNWRsd0hreTdVN1ZhVW5qUFVoWHlHQURRRGZuMGk3?=
 =?utf-8?B?WnNXL3NFN1Q4NkNiSHdtRGlRM3c0Ni9rQjQ5Q0J4ODVPcDMzNVpBb1ZHRmRH?=
 =?utf-8?B?TVVjRXgwR2JKaWUzeE5hVnFCZEZzUG83czZqUFVENXhwRHA5SGtabjdSZzFW?=
 =?utf-8?B?TldzR2tQb0pjSlhra3lyZ244Nm5FRlBqdWhZU09UbE9tS3N6RDlKb3NhNUJE?=
 =?utf-8?B?RGNCc0xSUmFGSEdIUnc1NzRMeVM2RHNZQ3BsUmtVbUUwVEs1YnRFcDk3TXha?=
 =?utf-8?B?S2dnVHl3OCtxTEFPMTFIdXhhSVFIT0hXN0VyOE43bGFOVHdGV3NKV2pjeEJp?=
 =?utf-8?B?U29pZ1UycUl0d1B5WXB1dmhMb2tIMkVJQ0pERUdncjFVYUlmaHBmSmxqWFFB?=
 =?utf-8?Q?kzLPtHpDb+tqMoggqn1x94vug?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe6a33-f752-4872-9960-08de38541401
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 01:24:49.6960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTlWGBvlpkJBGyMlhDjOjef8pqGW86D2q7UnEcWwzA4U/YPb9xYbIUZu1E4mMUCDunEyf9t8ZkR5ByQ8AebbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038

DQo+IE9uIERlYyA5LCAyMDI1LCBhdCAxMTowNeKAr1BNLCBaaGkgV2FuZyA8emhpd0BudmlkaWEu
Y29tPiB3cm90ZToNCj4gWy4uXQ0KPj4+ICsNCj4+PiArICAgICAgICAgICAgZGV2X2RiZyEoDQo+
Pj4gKyAgICAgICAgICAgICAgICBwZGV2LmFzX3JlZigpLA0KPj4+ICsgICAgICAgICAgICAgICAg
IlNFQzIgTUJPWDA6IHs6I3h9LCBNQk9YMXs6I3h9XG4iLA0KPj4+ICsgICAgICAgICAgICAgICAg
bWJveDAsDQo+Pj4gKyAgICAgICAgICAgICAgICBtYm94MQ0KPj4+ICsgICAgICAgICAgICApOw0K
Pj4+ICsNCj4+PiArICAgICAgICAgICAgaWYNCj4+PiAhcmVnczo6TlZfUEdDNl9CU0lfU0VDVVJF
X1NDUkFUQ0hfMTU6OnJlYWQoYmFyKS5zY3J1YmJlcl9jb21wbGV0ZWQoKQ0KPj4+IHsNCj4+PiAr
ICAgICAgICAgICAgICAgIHJldHVybiBFcnIoRVRJTUVET1VUKTsgIA0KPj4gDQo+PiBTbyB1bmRl
ciB3aGljaCBzaXR1YXRpb24gZG8geW91IGdldCB0byB0aGlzIHBvaW50DQo+PiAoIXNjcnViYmVy
X2NvbXBsZXRlZCkgPyBCYXNpY2FsbHkgSSBhbSBub3Qgc3VyZSBpZiBFVElNRURPVVQgaXMgdGhl
DQo+PiByaWdodCBlcnJvciB0byByZXR1cm4gaGVyZSwgYmVjYXVzZSBib290KCkgYWxyZWFkeSBy
ZXR1cm5zIEVUSU1FRE9VVA0KPj4gYnkgd2FpdGluZyBmb3IgdGhlIGhhbHQuDQo+PiANCj4+IElm
IHlvdSBzdGlsbCB3YW50IHJldHVybiBFVElNRURPVVQgaGVyZSwgdGhlbiBpdCBzb3VuZHMgbGlr
ZSB5b3UncmUNCj4+IHdhaXRpbmcgZm9yIHNjcnViYmluZyBiZXlvbmQgdGhlIHdhaXRpbmcgYWxy
ZWFkeSBkb25lIGJ5IGJvb3QoKS4gSWYNCj4+IHNvLCB0aGVuIHNob3VsZG4ndCB5b3UgbmVlZCB0
byB1c2UgcmVhZF9wb2xsX3RpbWVvdXQoKSBoZXJlPw0KPj4gDQo+PiBwZXJoYXBzIHNvbWV0aGlu
ZyBsaWtlOg0KPj4gDQo+PiByZWFkX3BvbGxfdGltZW91dCgNCj4+ICAgICB8fA0KPj4gT2socmVn
czo6TlZfUEdDNl9CU0lfU0VDVVJFX1NDUkFUQ0hfMTU6OnJlYWQoYmFyKS5zY3J1YmJlcl9jb21w
bGV0ZWQoKSksDQo+PiB8dmFsOiAmYm9vbHwgKnZhbCwgRGVsdGE6OmZyb21fbWlsbGlzKDEwKSwN
Cj4+ICAgICBEZWx0YTo6ZnJvbV9zZWNzKDUpLA0KPj4gKT87DQo+PiANCj4gDQo+IFRoaXMgaXMg
dGhlIGlkZW50aWNhbCBpbXBsZW1lbnRhdGlvbiB0byBPcGVuUk0gWzFdLiBBY2NvcmRpbmcgdG8g
dGhhdA0KPiBwYXJ0cyBvZiBjb2RlLCBJIHRoaW5rIHRoZSBzY3J1YmJlciBydW5zIGluIHRoZSBi
aW5hcnkgYm9vdGluZyBwcm9jZXNzLg0KPiBXaGVuIGl0IHNpZ25hbHMgdGhlIGZpcm13YXJlIGJv
b3Rpbmcgc3VjY2Vzc2Z1bGx5LCB0aGUgc2NydWJiaW5nIHNob3VsZA0KPiBiZSBkb25lLiBMZXQg
bWUgY2hhbmdlIHRvIGFub3RoZXIgZXJybm8uDQo+IA0KPiBbMV1odHRwczovL2dpdGh1Yi5jb20v
TlZJRElBL29wZW4tZ3B1LWtlcm5lbC1tb2R1bGVzL2Jsb2IvYTViZmIxMGU3NWE0MDQ2YzVkOTkx
YzY1ZjQ5YjVkMjkxNTFlNjhjZi9zcmMvbnZpZGlhL3NyYy9rZXJuZWwvZ3B1L2dzcC9hcmNoL2Fk
YS9rZXJuZWxfZ3NwX2FkMTAyLmMjTDQ5DQoNClN1cmUsIGl0IHdhcyBqdXN0IG1pc2xlYWRpbmcg
aW4gdGhlIHBhdGNoIHRoYXQgd2XigJlyZSByZXR1cm5pbmcgYSB0aW1lb3V0IGVycm9yLCB3aGVu
IHRoZSBlcnJvciBpcyBzb21ldGhpbmcgZWxzZSAobGlrZSBzY3J1YmJlciBmYWlsZWQpLiBUaGFu
a3MgZm9yIGNvcnJlY3RpbmcgaXQuDQoNCiAtIEpvZWwNCg0K

