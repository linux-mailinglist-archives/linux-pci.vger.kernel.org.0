Return-Path: <linux-pci+bounces-14414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F199C00C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA63281D76
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6738E76034;
	Mon, 14 Oct 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TetSeC6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64033C9
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887551; cv=fail; b=g/Y2SsEGZXW6XsoF5/WG3irvjojrqtTbOd4BCklgmFbpuwhrhsQrObN7SITOQD+0NKgUQt3lq8hDtW0/T/vF76+giBJw3vC3OOK2zm67cQJ0kNJiJfNQS5NnCbV/gMSK7qevu59yRQLos+Vpxa3Y5VgweKAsbZS6lywK/x6JA6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887551; c=relaxed/simple;
	bh=SrfEb4PIHdvmEIsvoMB8QMLife9cea8365YL/dnXikw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1Pfo62pzpA+VKFsLLki5gQcsOnDGNeRSgdsD+nPJa7HkYDsi7KoPXzoFNOf6YsVxuD9yUVfnJhSLyYwC4J8f/16PGT6HnvSQ//oC7mheqsLIBlKQbB2aZMJqHo5DSbeQr1zcxkl2KNgEyN79476HZoaQZCHK/N4BFuxpeojFks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TetSeC6f; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3lmmk6tpbCsdyqDir5MObOl90/D8RoVKFfZNOchUDZVaXau8V+HBKkj7g57m77YK4JL5PVe+hWhxQMZil+gFw1bRE/mn0P4XhAYddqh0iV6oaJoQP5Fwq15/D1GP56EWMfNU3whklM3SwbA5YNW8D0YH/jUx/fwKhyLIiQCeDB8/nj0OXXDsHJZZTvDe0rE069qKP3UQuu32xpck5IGyA3JWavQzMAtp1JJGP+7S53GY2jy6hTSrrVzl2M9Bn2LyvNgjTVYc1XKYPFnde+MS69Iqypm2a9rqu0Te5YKm3at5jppba0Mp3k2XtLHOG7oS+ID4CbP4ReMIk3cBDzY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrfEb4PIHdvmEIsvoMB8QMLife9cea8365YL/dnXikw=;
 b=Q11ULoMJCfGyC6taWzA5qicVfb7HqIb/EVMOjDnwgsr/PnBklLRNxTcayfHUn7iDr7tlSayNfyw/g2+TmWJFqgxppc4OPXI6GVSfGNOCX/r1qKeAh+KKESedrv7FAE2bd5D4kTfaOS+++5i8ySuQIuC9iudrSqlgwOq4WnEM/4UE/G6ZV02L8bL8HdeskdDFfVl2j/iyfIHdq7z9EToNey1fZ8axhXKlHkhq+YCZEz7I5ZJi0npzWG5Ud44wsteqKawcJbM0Br3iY/AhkQPnEVoAd/C3u99a93eiuq+9n88xPnB3mVl0eFdc7zt0ri6jDT944yM5TIWW7990v2e+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrfEb4PIHdvmEIsvoMB8QMLife9cea8365YL/dnXikw=;
 b=TetSeC6fJyODJLgbquuF+Mb/SmPmysUK+hFR0kgP5X6mKKNhgfPDxcRZV+yaQn6JwcwbXLCqg54X2Z7NPCWZlao6zZCj/A9aaDS9lEgEBK3Mop43ismy8xUmJdIZCB10v/06h4ET69N2SOgEwbfu+5T/SJ8UJBJkoXKdW3ozprtNgySQFOzJL4+wjamori8gWV7VFhgKvCnGANQLuT+ywyfODbFUfGhRShdmP//LoTmkKXm4I7nq25FDFZBWvnjvRGxBgZ3cJ8lVxU5thcQakc1giQj2xf92JEblGFcOcnCHSLZ4sdJIAJRwadAd2WYPpZAcYavR7T8AOsgM0mid+A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:32:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:32:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Rick
 Wertenbroek <rick.wertenbroek@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Keith Busch <kbusch@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Thread-Topic: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Thread-Index: AQHbG9l9rIdUba5SN0K30JMoj9qdrbKFzfgA
Date: Mon, 14 Oct 2024 06:32:26 +0000
Message-ID: <702e9570-cb93-4bc2-8b72-72ececd67ed9@nvidia.com>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-3-dlemoal@kernel.org>
In-Reply-To: <20241011121951.90019-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB6690:EE_
x-ms-office365-filtering-correlation-id: 29b8f4e6-d90d-4e72-25f6-08dcec19f874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3FQUTdmU09SOEEvSUVTcmFteGhOLzNYRHRRS04vNFRkMHhzOHQ5aUtNblFK?=
 =?utf-8?B?dVh4RDl3WjJSU0xSWkJ6Z3czQ3pLQVh4ODNwN2lvclVyTVFWV2J4a3J1cmJN?=
 =?utf-8?B?R09nSm16K1orN3ZHakg0YWVDbGd3Y0hZQWpSWG5yYUdKUXlIQnhKM3I5bXEz?=
 =?utf-8?B?WHVmUmxxMjNieFdpejY4UFh1S0EzTVdCTzRCNnAyVU9sWGZlNmk4ci91OXYx?=
 =?utf-8?B?b29lcVJqWTRvcjR5bmhSa0NNcFI5WU9DSjFhNkF0enJMSUdyMXR6WnZ1QkQy?=
 =?utf-8?B?Z3JPSDBLL2cwMFp0eVErN2g1S3YzeDVBdUJXQWpSMDdka1RWeU9ORVB6TnRD?=
 =?utf-8?B?cjVXdmQxSDkwMXZnaW1RUDlhWm44YVBFVElwTjEyQmhLQXVUT3NkYm1MK1FZ?=
 =?utf-8?B?eWhBRkowam0zN3hiYk9MK3FWTE9qWGtIVzBlVFA5OWFhOGo3UFMyeEtpNFVn?=
 =?utf-8?B?UDFsUVF6Q0RUKzI4KzlQYkZWZmlCeFlNVjFiUXZJeXdpbUpGU1lyaElWaEpL?=
 =?utf-8?B?QVcybDlDTlN4RmVrcGxJVEVpcGZsclZBTnpZTlJRT1M1c3lYMkpGTklEVHkw?=
 =?utf-8?B?U3N0V3hzdnE1MUhIRGhwWjJpWGlINWpubW9wUWp0V2huVGVMaytpbGlIbmYv?=
 =?utf-8?B?ZFo4RXI3SGpyeElwWU1PQytNKzJxd0RJelgycFJxcm5ta0pDSDdWR282bjls?=
 =?utf-8?B?dEVvWmZaalNxOU9hYVVicUxISU9EREUwODJJV3RTSjg0OGF2NHVISHhXOHN6?=
 =?utf-8?B?eElPUUZ1K2xhYTFSVnBDYnIxNEh5M29SRXZEWStsUWJGZFpFSGVwd1VRckRu?=
 =?utf-8?B?ZzVJZW53WkpnUmxpcWFFZHI1MnpiQWpXVDVxck02R1Y3cDRWZCtYNzJMaVJu?=
 =?utf-8?B?R285QkdXSFhjcXRPQ0R4RVF6Q3FXM0o5eG94bkNxNEphREw0cFdVNzdseUp0?=
 =?utf-8?B?N29ra0ZmcW51a25kRDRrZnRBekh4Z3ZVTlU0dWZ5dkZzaUY3cXZwQlE2ajB6?=
 =?utf-8?B?VURWaU1RSGVzVG53Y3gvVmZzMlBoYkVRc2tvZUlhM0NVTmUyR29Xa3llSnYv?=
 =?utf-8?B?WGVFTW9PZ1FXVkpuRU10TnkvUG85Yi9SQlFoMWNpNCtBZWtKVTdoRERJYjU0?=
 =?utf-8?B?RTVNQ2s5UzZRSmk4ZlJ6eWFrdWhCVWw0ZFB6MVVNNXQ5NEMzbE9aNW41aUQr?=
 =?utf-8?B?S3Nld0w1SGkwZzhySmQ1eVB4K21HTzdVdmY3YkR4Z2p1YVNMZGxFSzVuNW1L?=
 =?utf-8?B?UzBkdHo0am5lVzFMa2l6V0JBTGVUeXVIU3c5Z0lNMHdKRFdvcWV4aWpMTkFW?=
 =?utf-8?B?UG1CREliWEFGbCs2cnc4NUxUVzE4eU53ZUhxOWJJTGkzZWNrVy90RDEzeG93?=
 =?utf-8?B?VElZRE9xRWk4SVVGaGVsdUFCTzRrbDBTdkNTZWRSam9ZSWRHK2J5cTZ4dkhF?=
 =?utf-8?B?K1ZIMFVNTWt0dmdDb0hMVXlwNXFqYURTMm51WVBCckkyRUdpckNOc0tZZlZF?=
 =?utf-8?B?WHFycHBJdXQ4bm1vUkxtcXhyMm5NYjFQVmVqWkdyR0ZUYWVmS1NVeWxlNXRZ?=
 =?utf-8?B?bVVNRDk3RC91bGVTbjM1djI5Y1E1dFFwVUtYSWM1ZzQ5bFZLM2M1Y3VwOTVp?=
 =?utf-8?B?WHlxeEd5M2M5YUprYU84Y0tzdDcrVURZN0NYS1BYMmU5VjJzdjVnbStBOVhZ?=
 =?utf-8?B?MnRCRTEwckNlZHlPaU5ya1FJZWRaaElYbC9PM3pQWjFOandpV2luMGxsazRM?=
 =?utf-8?B?Wk5vU1RFWEZIYTNjdVNVWUZTRmJxRHp4bG1mZWx3ZzhKQ2lNN2NlY1I1Y0NK?=
 =?utf-8?B?TkdVeFBQTW9LUlhmbnV6UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2NuRmF5VmRLRlNacVhRVzlISHVBUzQ1SFl0VGtOVFFJSjhXdURXTDNYZEdI?=
 =?utf-8?B?VGJFRHJHa21qNXMyaUVjazBlR1lRSXFucEdYdDdlY1ZXZ0NmUmFPNHMvb1gw?=
 =?utf-8?B?RHRvZEdqWVM3elE0V3NrOXZDVmZieGJrWUVjR0oyOVVZeWJZbm52a2w0blVw?=
 =?utf-8?B?Ymc1V2dRd04yK2h1RTZrUHZSL0VZSjRKd2thUWlaa0RqQU5HL1dhYVBrS3Ry?=
 =?utf-8?B?QWdOSU40Yk50TFJZdVBTYmp1ODd3cS9xQVRRQkpaRUp0RGc2UFRrMnM2S3Bj?=
 =?utf-8?B?MlU4Y3JseDJvbU5YTWpoNk9ObmpYODNROHN4THFLeHhnS1hnMmhnNERQczI4?=
 =?utf-8?B?ck14QTBWZW1OZTU5d1BnSGdLVmpZclVidmJTN1NMSkJXbTlEdG1kYXBDdXhU?=
 =?utf-8?B?V1VXTmR1NkhXd0JLZHhJSzZHUEVraGUvMm9sd29zWmgzTkpjNU9NQzlEdDM4?=
 =?utf-8?B?WkNjY0luOXpJaTY0b0EvenlIOUF0Q1R4THZERXoyVFZlZFJJQS9pR255aE81?=
 =?utf-8?B?Qk1BSTVnYnViN3ptaVRXeTNhZXgrTHhWbFlsejloRFFHT0pyRDN3enF4dlV1?=
 =?utf-8?B?OTNLL1lHV3I5cVhyUWtVeHE1MWpFQ293eTFVelNwZFdycFB6TFdZQ2I2dzBo?=
 =?utf-8?B?TWZsWDJkbWtjSDdCK0oybkFicmU2WkNQVFgrSDlpR1RLSWluUU5QK1pHS3lT?=
 =?utf-8?B?MjNuRkVGMEJ6WDdUU3lUcGlWUkVaQ0JiWW5lK0RObWtsTjMvSnhlVTFnRGhT?=
 =?utf-8?B?SXI2L3VZdFk5eit2T2oyTWlENzdoSFMrU1QxZWxNZU5JbmxYL0l2S0s5MTl6?=
 =?utf-8?B?YU1HRHMyMWpacFl5ZjJEMG5ZR0oraGxLVnRlRWxtNmQzdUNKbU5nVUtxNk9Q?=
 =?utf-8?B?VEErUXRya1lweXhFN05idnE4VE9WQWQxbkJXdTZ6MllwRXREU3ZMTmViY3NP?=
 =?utf-8?B?VzltVUZ2OTVVeFhxMUZUL3NnM0llUXZhVXd3aUJOZFFGUVhqa1FQRU82Mlc3?=
 =?utf-8?B?ZnRUbEJpWjllb3pVY0IvZEJET05uMjA4YWJkcm44Ny9JUDR3UFB0WG4xaFFl?=
 =?utf-8?B?UmpGemtQb0JCMGdXQkV4YTZIdVUwazRZamRvRGZPVkx6OHdROEZkMkNnSWxI?=
 =?utf-8?B?TWVVMVpsUTBFNlBwaXpwR1Zyd1VMRFBwY1JKdWNpQWxPS1U5djRzWjhsQkxr?=
 =?utf-8?B?MjFLdEFZOE1TV2dFTkt6bEsyRisvUEpYb200eElXUnVwUm9uWWhINWdpU285?=
 =?utf-8?B?V1V0Mk1UamVDS1ZuZkhTbnVRdnNwdktoWXdTT1J2dGNrdUJCOElvdjZvYlFi?=
 =?utf-8?B?UVRaSmVWczh4YzVTdU41MzJQZ2J6NjBVS2YvWmxuYzRFaWtFclJqVW5UQ2Rx?=
 =?utf-8?B?ZWYwaFYxUGNNMHVTdzJBczVEbm1KNDRtTjJWN2dRU1VRWGNmYVhqWTBuL21G?=
 =?utf-8?B?SXRuL09iTXAvaHJJRDNUWjFSZ1Q3bTV0OXoxbERFbXFyS0E3WFRuSnRVMk9u?=
 =?utf-8?B?NTVMZTh3R25ZNTc1WW1yK3dqUERKRlBzVTU0cmR1ZVBQU250Wnh6NE51VGFy?=
 =?utf-8?B?UVJjWVg4OGwxRWRpdUI1L1h0RVJTYUFFbGxDb0VtcXRJWksrczZ2UVNvMVFl?=
 =?utf-8?B?ZVkwdzV5S09MdHRTSEJoWE9vY1dDVmViL1ZPWTEzUDRqMEZSRmlzTEZLWXpw?=
 =?utf-8?B?a2s2MS9wb3NaVW81ZHdaSWlLWEhMU3pKRjR1VVdkajFxb2RYWkd5VzJlRi9B?=
 =?utf-8?B?Z2JqTGxORFY5czNJTllNM1ZBMWo2NUgyTVNvR2Z3R0lTQ01LTDZVS29lNmh6?=
 =?utf-8?B?c1BJbHFQNFU3L2NsVHE1YTFtNEg1d2IxSjllR1h6WlhmY3ZUMmhFeEt5SzJL?=
 =?utf-8?B?bkRlVzZBTUxrdkY2WDgrMTFtS2tyV1JBTHlkcVlHQXRSSmNjKzU3aUpNanZG?=
 =?utf-8?B?a2txQnp2K1ZNeVdMaEMzRlFZdmlQV3MxTllGMFQ0eHVKTElFWG1RV2lDWEc1?=
 =?utf-8?B?SFBWRU4rTkg1Mm0xSisvcHZ2VUQxak1PZkd4YzN6TkIwQk1rbkdBNzVycmc1?=
 =?utf-8?B?aERjUkZDTlZsQzhMeTFTSDhYYVc0NWxDWGZVM3VJTXVkSXdOK280VFhucFFk?=
 =?utf-8?B?dmQ5cDRIdXM5THNraWkwR0o0RWJ4eHhydkV4OXVqZEYzSmVjVEZ0c0IzRXJO?=
 =?utf-8?Q?jjm8nA3biN/aazQhqzFncRJQ3TzVkRvYUQW7bt8dJI/y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4809732302826F499737D2EBD0B5F261@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b8f4e6-d90d-4e72-25f6-08dcec19f874
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:32:26.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaMhjKHG+z/f2qzRaRKFjWvUSi1Rnikdpaq+FcByN4SSIfaFC8Yn60hbShsi7MVmWOIK5QRAhS2z/Ws9NTvbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

T24gMTAvMTEvMjQgMDU6MTksIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KDQpuaXQ6LSBwbGVhc2Ug
Y29uc2lkZXIgZm9sbG93aW5nIHN1YmplY3QgbGluZSBhcyBudm1lZl9jcmVhdGVfY3RybCgpDQog
wqDCoMKgwqDCoCBkb2Vzbid0IGV4aXN0cyA6LQ0KDQogwqDCoMKgIG52bWUtZmFicmljczogZXhw
b3J0IG52bWZfY3JlYXRlX2N0cmwoKQ0KDQo+IEV4cG9ydCBudm1lZl9jcmVhdGVfY3RybCgpIHRv
IGFsbG93IGRyaXZlcnMgdG8gZGlyZWN0bHkgY2FsbCB0aGlzDQo+IGZ1bmN0aW9uIGluc3RlYWQg
b2YgZm9yY2luZyB0aGUgY3JlYXRpb24gb2YgYSBmYWJyaWNzIGhvc3QgY29udHJvbGxlcg0KPiB3
aXRoIGEgd3JpdGUgdG8gL2Rldi9udm1lZi4gVGhlIGV4cG9ydCBpcyByZXN0cmljdGVkIHRvIHRo
ZSBOVk1FX0ZBQlJJQ1MNCg0KSSdtIG5vdCBzdXJlIC9kZXYvbnZtZWYgZXhpc3RzIEkgdGhpbmsg
eW91IG1lYW50IC9kZXYvbnZtZS1mYWJyaWNzDQphYm92ZSA/DQoNCj4gbmFtZXNwYWNlLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KDQpX
aXRoIGFib3ZlIGZpeCwgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

