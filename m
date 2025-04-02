Return-Path: <linux-pci+bounces-25120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D554BA788EA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9AA1891035
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF1233153;
	Wed,  2 Apr 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQ3mseTD"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013056.outbound.protection.outlook.com [52.101.67.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8721B7F4;
	Wed,  2 Apr 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579574; cv=fail; b=mYF4h3kjI9NOEmnM7BjFz64dxfOH/kXmFcHZkn/g2p8t5pqYTrQDeBQLW9KhzNGE1JPFSWMfzJBizBb9sqNMPa8/HF8utLKVcgjE0poFhfuKlaj+eWgegkxNo7sw3hvzokTsaRTMVH73R35e8ghkm1tvLB2aLFiSrJ0gK2ZjgHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579574; c=relaxed/simple;
	bh=9/a+eX9mqT1e9HR7aEEiz4kJdWN7IqWUL/D/O2opu80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJn0QGtFGNmCmyma3suQe/aGtLRon6U0UWV/KqB8oJfq0+VqrgDv1W+G4oZsUGXx3P+jIU90oeQdE3OooGQ1XwqLRSVdWxsYA620TctlAYFNagAdvwES3eeOzW0g/kK1Zd2L+NxBuW6JgCvd+A6MeHHrZmWPwYMGwx+s7Ol0nE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bQ3mseTD; arc=fail smtp.client-ip=52.101.67.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tePw2nNk4dDCh8TdR30aaqupAjF7+RWVwwfa0Yi7zTb1tC0cbe0TsF1aijph41xMCVWkbvKF4fgOJ7rHr+vhl59HWAFvLV31FwGRrTlbOREdyRGpeur0xBWuuB1aah7Vy2wLO+LwnWzbPneNi5pMKUQLKmUdKh+1b+wS+pZL8YHP5rdziyiuYn021SqcKE+0bDcD1FdL4/Z8SrsagFAYqJeEto40UVmrO5S6ZT9zhjL/5nI9BoHCwro4d5ATpaEzUcsSQ9vV9B9clFlEvbEgNzM+46PquHHHZwoNQr35HnNC3a5SIhrGAXklU9G2QPJrafrvktyO4w1FvabcjqoqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/a+eX9mqT1e9HR7aEEiz4kJdWN7IqWUL/D/O2opu80=;
 b=Pu1XS5it5THsyMcptvTjZOj3B8/ZlznzTn/9JClvzle4n3RCI+5Y0R8WWb7HyN+UJQ3+t5INFT+jvq2MbeJ0m8gs/MiuwdGV1zQr4G4YertAp/1is+SrGptS6yEtg+IYMBHoqutcJhOrbYZzjn4c0+ZCFU3uAaOitY0gqaBm4Tv61b1LuTQBcWzRfWcLTUKCFT4eBoyQcaQBcsPbkXsMzPCWOY1hJX0TtNSjWO4qjkyxy+arhx2CT4aqCUfCGVrfMyEmg9BOvSR5PzjwDPrIUIxmDE04eWnXG1GI2Z3rEfdF0Y8SOMEG0EXnzMsn24jNPQzHZsv1i56UziJyDT/TEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/a+eX9mqT1e9HR7aEEiz4kJdWN7IqWUL/D/O2opu80=;
 b=bQ3mseTDB/i2uklqaZhWrDsW86HodiObpUIDnFa9dva6iKk9ojGp4AWmlTipkE6K3CT+6YvMZEk6/xAGZIyLIq0mumxG7j5NOyQwAqDiLfwaydC/qqOPUwLaGpR+QWY4uAdkSMAWjmhirXhHGPQPA2Ma1Yb3ddtyReG+fIQ33IL/VMOOKOYxylOOouzYNU2pD2sSo37AByOu52ObDnrL++FmnId9N98iDFhqyEtNDhs3Cuck3jmmDjzJ+9VnvO1ixAbLIdYPb1lvOVx/AL/FVpQrCppUx+rgfq7+EdT+cR56GzT+GrI5mp+6s9avtjUCes4bXtvkH86Ss6VEIJxZQg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 07:39:27 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 07:39:27 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] PCI: imx6: Start link directly when workaround is
 not required
Thread-Topic: [PATCH v3 1/6] PCI: imx6: Start link directly when workaround is
 not required
Thread-Index: AQHbn439fTkbxcJYKk+eXyFsevnDJLOP8XOAgAAFuoA=
Date: Wed, 2 Apr 2025 07:39:27 +0000
Message-ID:
 <AS8PR04MB8676752D7F3A11679FFA485B8CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-2-hongxing.zhu@nxp.com>
 <kskqytb67s6qpt2jfn6sry4oj3zq46y5hizyzxxvehtjtqtj6r@qmtfepjzjrpk>
In-Reply-To: <kskqytb67s6qpt2jfn6sry4oj3zq46y5hizyzxxvehtjtqtj6r@qmtfepjzjrpk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB10775:EE_
x-ms-office365-filtering-correlation-id: fca8c70a-d918-4607-b7be-08dd71b97f6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXpaZVVYQkxnYUhRclJPM3FKYXRqV3QremR2bWZZNHF0MVV0cTdZbmRhK01i?=
 =?utf-8?B?bE5NUnJPUnM4bXlYb3NxaER2UHp2YUhONWtxeVdNWXVlT0FualVDSzJIZmh2?=
 =?utf-8?B?UmpaeUd2SitWeUhFbllPSG5DMURjT2xGZlNKMlV0Zk9SdHl1S3cwNThyNDdy?=
 =?utf-8?B?OEhtczE0TjhXWGkwazRDbTg4Vk43ZlJPUTh1Qi9iOHVGM01KVFBYdTV2alRW?=
 =?utf-8?B?UDc5ZVhnbmhQSDVSWjNwVzFKdHp6RWFHNjJDeGR2clI4OU9JS2lpYUFUc3V5?=
 =?utf-8?B?SkpIMWRSWUY1akVyTHUzWjUvUHFXSUc4TDNWVlByaFpYT3pjNXBHQTFvOGs3?=
 =?utf-8?B?eWF5eTNqcElPbDA2NXFrT2t0Rkg2TTFWMTNtVlRXK0FXQzBySGFmdTJTQzZ1?=
 =?utf-8?B?VmRYbzlmcVovSVZWOEl5eSsvNjAyQm8yVHRPRVBrcnkyT3k5a1NCTVozQm5i?=
 =?utf-8?B?SUoxVzlZRHZjK3hOUlIrRGVQWmh1QTlKdGVzMGNOQnIvMWpoTUNFK2ZwZU5F?=
 =?utf-8?B?VmxJS3RhYkNucEwvb1JxMTRhTFNHajZwaEZlNkVmcEgwR2NDMndmbHNGMDRz?=
 =?utf-8?B?TytDZVZLcllUdUF3V0pTSGwzalE0Vys5QWtteDluejNJeXFUQzdBdTYzRHA0?=
 =?utf-8?B?a3N5Q0xOUjJWcXVtZEI0N25ydDNWcXZTSFJCUGJRUERwU3JnOFN5MlhyaDJG?=
 =?utf-8?B?TGd5TTAva09ZNUZ4OU9PTkZmRWk4U2NZaEhFbndjY05RSmJaS1RuNDI2YUdW?=
 =?utf-8?B?RWNNT1o1YzdIUjVnOHZ1cEhiZ1dzMkNWcnUyWk9vaTlHSFlQbUpXTjF1U1RK?=
 =?utf-8?B?WC9FOWtPWmlVQUp1RVJrOHJRbGUrNjZvUHUrc3AwcTRyNkNsWEdkM1lzUVpJ?=
 =?utf-8?B?L1JWY2o1T1dEQThsRTVMZUVOVWFTWmVkU1EvQmxvNEo4Nks1NFB2RlJmc3lo?=
 =?utf-8?B?ZTN4V2xmU2xHcmt5eU9yREdHb1JKR09NTmQxdHNxdCsvejAzM3JlQkxKSGJ5?=
 =?utf-8?B?OUM4Mi94NGxCNEJldFFkREZ2SjZOdkZsaGZQc2VsekFBMWtTMXZzS29KdDRI?=
 =?utf-8?B?OFhGSXo2S3VOUlBrSnMxSmNPUHprT29GZDdiS2pZMy94bTVoK1hNMTVRRXBZ?=
 =?utf-8?B?ZFMxYjQ1WGdUOU16akZBSDlYZm9QQ3VmWHNhaEt6REtwT1d4NCtaSmliTEJi?=
 =?utf-8?B?ZHBQaVM3a0FnMk9FMDg3UlBkcXcwM0txRDhnbWRydUJ4MCtyb3dycEtyTU0w?=
 =?utf-8?B?SnovTUwwV0tUdWJJZGNvSmJ1U2VWNm5IRkluSnp4VXd1eTFkc0JrMkdGQUwz?=
 =?utf-8?B?TEFXRXFHWk4wdFNWNC9yVnNoQzE3Q1lnVEYwenpPTSs0bVlUNDhMRHFnb2gx?=
 =?utf-8?B?ZENoT21mdUhmVXhkUlNNWGJaZk5hM1dvc2U5dmJGWEJCZFd5YzBWVHVyYXZu?=
 =?utf-8?B?L1FQakxMOXBIQ1I2MkY5N2w0bjFKS1ZQVTBYUTBjd0JDOWt1RFNhckYydDJI?=
 =?utf-8?B?R1hydTk2ekR2N0tTSzNRVEIrekYzR1dvQ2U3MDQ4bFBYUXd3dGpSeVJhbjhj?=
 =?utf-8?B?eWI2TWh6WmhYcXNVQVhMYVRmUkpZYm5vSEhoZGNmUkJ0N2FtQm94czlySVRj?=
 =?utf-8?B?dXliNkF0TEpJZ25sWUQ3ODcyWjROUkNpcmNwUktuZ0FYSEpBNlV4SDcxeHpM?=
 =?utf-8?B?TERjNTMzaGFFd1BHMHZRYWVsMlpmblNyYWJLQjVqdnAxbTNIZDRIdFlmNVNm?=
 =?utf-8?B?SDBTckh2TnJQa3hXek1EaHdHYWdYOVdGYTg5VzZ4UnF3UEZLRzFzM3VYUHIy?=
 =?utf-8?B?WURFcTRHaWNZSHd6Q0szNXRJTjRtMnZZQnJzaStCMjNmaUdxQkR3TXowT28y?=
 =?utf-8?B?N3l4M0t5QUYydnJvZXRXaW0xVHZIM0pMRjZuUmxKTDJmQngwVDJETllTSVJM?=
 =?utf-8?B?TXdRdXB1eUQxNTVTQ2VibldERHRId0hwR1QzSHl3a1JialQxNExjemI1L2tS?=
 =?utf-8?B?S2xrNS9PQnNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym05MXdvVlpWUjM3UjFocGg2dGhTWXZUMXM3WkphLzRQUmhWVzVHUEpEaUtN?=
 =?utf-8?B?VEtRT1FNMzJIVEtFaXRjb0xOMDArWHpyTFBxK1BKeFhkUExyd05HZC8yekph?=
 =?utf-8?B?ZGYyNmdBaDV2aFJuY0dBajRvSUlacVVMNU0ySUFTRVZPM3FKaFhMRXJSK2Y0?=
 =?utf-8?B?K2lKU2pyNHd2eTdndk51VWltb2pLNjBXWGZWRWRZMmJvd0FhbUZBUmw0eDFQ?=
 =?utf-8?B?ZUhNVFk2Qjk5dlhwQVZaVStVdllZT1lMWDV3TitGbDJxSE5MdUhCeSs2enVJ?=
 =?utf-8?B?eHNSYlUyNDFjcFhJY05YRHBlaUw5WUEvUzY0Z2lXN2NyVkhJa3poYWJ0RkRh?=
 =?utf-8?B?b21Vd3pzTU95KzJPY25aMk1CeHBTdTJONFNxR3Erb05WWEhGckpTdDlpVVE3?=
 =?utf-8?B?TXdPU0p5R29DbFA0YmtuUURFR0FsUnhjZDQ3Ri9MMllrdzFMa3EwVHVOSE0x?=
 =?utf-8?B?Y3pYZGRYQXJUWWhIeW1NcGZRaEk1S0JyazhYaVdoQmFZNHgrZ1VrVmxmR2FJ?=
 =?utf-8?B?cXJBdHNoZ2EwTEU4YWtJaHRmR2JQM1h0VjBoYTlDUzVKVGxNd3I2enRZcWV0?=
 =?utf-8?B?aXdicXJlMFpVNmpzK1J4bjNsMlltQm5lcWQ1RUNmWmU4N2RsR0tyS0Z5UmE0?=
 =?utf-8?B?a0FlRVNRaTd0OUZSYnBjT0pIMVJzZTRUdkY2a2l1cGJIWkgwQ2FTck03WnVS?=
 =?utf-8?B?b1ExMjF5SXNKTmtBREN5QnBIK1NDUFN3aFFuMnFWb09relZoZzlqZkY4U0VD?=
 =?utf-8?B?SWlsTGVvK3RXUkhjN3lNK284blcvUVpJVVFnRXZDekd1a1hFa1dERnJrendp?=
 =?utf-8?B?Tk14VkdqK2RGUDgxL1NSeTkrRWZpdlhlRUpHZitrYnFnV2RFOThKMlBLRzBQ?=
 =?utf-8?B?WCtsY2t4bzZhSHp4YTZDYlhCNllxWGl4cFdqVmdSVXlDTkkxT1NhVnVhL0J2?=
 =?utf-8?B?eWEwdHBIR1RLVnpUOU1ucllZaWdMaW9rNS9ubTFxd1Y1MzNXWmh0NmRFbXc3?=
 =?utf-8?B?dTRlVCtzNm4xaVJXM2VqZHZEdllHN256bUJYMGc5UWVDaGJVUm1WeGtSRERr?=
 =?utf-8?B?MDdvcVAwQ3gybHFUZ01oT1VveE9PZ2dpZUJNbkhCNmdPSkk0T0svck1FcDdS?=
 =?utf-8?B?OVdqYzVPZTRkVjN4OCsxdHQyTUpoT0hQVnFmamNXNTZDK1VoalhXNzd6cjNi?=
 =?utf-8?B?ckNId1pQZTRJQnIwSlJMOTlwT2hlbWM3U2E1cExvWEdOdnZlV0ZRNlkxM3hn?=
 =?utf-8?B?TVdVdjhGakFVV3ZlT2xvejVGZjhhSURjeGxoVk9pVlV0UkJsQ0hzR2NKeUNm?=
 =?utf-8?B?WWNySUZKejU4aFUyRDErNzhndzhZOW0zZUhqbUM0ZWNCanZqVUVHekkrMVly?=
 =?utf-8?B?Qmh1TExKeHV2WEhaWUpjSVJBVmlPNEdraTYycjlGVjQydkJTTEtjOWZ5K2Rv?=
 =?utf-8?B?Ri8zOGh0RHI0WHpRTndSdXhEV3htWUhxVTVrRTFYZUdzb3A5Tys4SXBxQS9o?=
 =?utf-8?B?cDAySTR1UnI5aDFQdHIzVlpZMERvMWN4eSs3dTNBNUJwSGR4UDlsNEJiUnhZ?=
 =?utf-8?B?TWdlcVRjTjl2S20vaVhRd01nYUx5MzBOVHdLcXh4NnBJZk0rWGJFajlQY292?=
 =?utf-8?B?dmQrMEJGdzVmQzVDUXNoeGc0OEZ4ZUVTSmtUOWNCemhrWU45MUFPQ0ZieWZy?=
 =?utf-8?B?NXFhTTlYSWNZOFN0NUZDTnp4eXY1U3o0Nm1QQW55eFprY252dEpOM1IvSHND?=
 =?utf-8?B?YVlzNWRpckpXUWZ1RXFqKytYVXUwbjQydmJxNWlOV1A5eVgzZTZmTUlobFlt?=
 =?utf-8?B?RkV3VTdKYzd6ZW9URFJwRFcrU0VDbmdSYXkvSlhhc2xHcitXNlFPa2ZKNTUv?=
 =?utf-8?B?S013VWh1Ui8vRWEzSVBZR1hCUTUwVVZCcjg0WHhENUVGdG5uaEo1Um1PMU41?=
 =?utf-8?B?aVlSTVNNOEVseTZJOVZrWmZ6TFhLTkJ6V3R1NkJpNTJiQmhIeVpuUENKYXNt?=
 =?utf-8?B?VUkzTW02UnZicTBzdncwY0hqYjFhZlY2V3dvZ1kzcG9JTG1lcFB3czQvUC9w?=
 =?utf-8?B?THVQUEUwbE8zVkg3c0NEdTd3VTRsL0d3TW94Ymx5YVBKY0VhcFVuMDdrcnhl?=
 =?utf-8?Q?qws27wlm6e/f2fMk8owtFumay?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca8c70a-d918-4607-b7be-08dd71b97f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 07:39:27.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aO6waRMNdMKR45joO97r1gJC6S7dP2JClWQ2A9U7773nk/g/MWzyuNwUBkfAkl8a/Lz0YsJcsKmVvoGeXpj6Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDLml6UgMTQ6MjcNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzZdIFBDSTogaW14NjogU3RhcnQg
bGluayBkaXJlY3RseSB3aGVuIHdvcmthcm91bmQgaXMgbm90DQo+IHJlcXVpcmVkDQo+IA0KPiBP
biBGcmksIE1hciAyOCwgMjAyNSBhdCAxMTowMjowOEFNICswODAwLCBSaWNoYXJkIFpodSB3cm90
ZToNCj4gPiBUaGUgY3VycmVudCBsaW5rIHNldHVwIHByb2NlZHVyZSBpcyBvbmUgd29ya2Fyb3Vu
ZCB0byBkZXRlY3QgdGhlDQo+ID4gZGV2aWNlIGJlaGluZCBQQ0llIHN3aXRjaGVzIG9uIHNvbWUg
aS5NWDYgcGxhdGZvcm1zLg0KPiA+DQo+ID4gVG8gZGVzY3JpYmUgbW9yZSBhY2N1cmF0ZWx5LCBj
aGFuZ2UgdGhlIGZsYWcgbmFtZSBmcm9tDQo+ID4gSU1YX1BDSUVfRkxBR19JTVhfU1BFRURfQ0hB
TkdFIHRvDQo+IElNWF9QQ0lFX0ZMQUdfU1BFRURfQ0hBTkdFX1dPUktBUk9VTkQuDQo+ID4NCj4g
PiBTdGFydCBQQ0llIGxpbmsgZGlyZWN0bHkgd2hlbiB0aGlzIGZsYWcgaXMgbm90IHNldCBvbiBp
Lk1YNyBvciBsYXRlcg0KPiA+IHBsYXRmb3JtcyB0byBzaW1wbGUgYW5kIHNwZWVkIHVwIGxpbmsg
dHJhaW5pbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxt
YW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gDQo+IE9uZSBvYnNlcnZhdGlvbiBi
ZWxvdyAobm90IHJlbGF0ZWQgdG8gdGhpcyBjaGFuZ2UpLg0KPiANCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDM0DQo+ID4gKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAy
MCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+ID4gaW5kZXggYzFmNzkwNGUzNjAwLi41N2FhNzc3MjMxYWUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtOTEsNyArOTEsNyBA
QCBlbnVtIGlteF9wY2llX3ZhcmlhbnRzIHsgIH07DQo+ID4NCj4gPiAgI2RlZmluZSBJTVhfUENJ
RV9GTEFHX0lNWF9QSFkJCQlCSVQoMCkNCj4gPiAtI2RlZmluZSBJTVhfUENJRV9GTEFHX0lNWF9T
UEVFRF9DSEFOR0UJCUJJVCgxKQ0KPiA+ICsjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfU1BFRURfQ0hB
TkdFX1dPUktBUk9VTkQJQklUKDEpDQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19TVVBQT1JU
U19TVVNQRU5ECQlCSVQoMikNCj4gPiAgI2RlZmluZSBJTVhfUENJRV9GTEFHX0hBU19QSFlEUlYJ
CUJJVCgzKQ0KPiA+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFTX0FQUF9SRVNFVAkJQklUKDQp
DQo+ID4gQEAgLTg2MCw2ICs4NjAsMTIgQEAgc3RhdGljIGludCBpbXhfcGNpZV9zdGFydF9saW5r
KHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAl1MzIgdG1wOw0KPiA+ICAJaW50IHJldDsNCj4g
Pg0KPiA+ICsJaWYgKCEoaW14X3BjaWUtPmRydmRhdGEtPmZsYWdzICYNCj4gPiArCSAgICBJTVhf
UENJRV9GTEFHX1NQRUVEX0NIQU5HRV9XT1JLQVJPVU5EKSkgew0KPiA+ICsJCWlteF9wY2llX2x0
c3NtX2VuYWJsZShkZXYpOw0KPiA+ICsJCXJldHVybiAwOw0KPiANCj4gV2hpbGUgbG9va2luZyBp
bnRvIHRoZSBjb2RlLCBJIHJlYWxpemVkIHRoYXQgd2UgY291bGQgc2tpcCB3YWl0aW5nIGZvciBs
aW5rIGR1cmluZw0KPiB0aGUgd29ya2Fyb3VuZCBpbiBhdGxlYXN0IG9uZSBpbnN0YW5jZToNCj4g
DQo+IGBgYA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXgg
NWYyNjdkZDI2MWI1Li45ZGJmYmQ5ZGUyZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiBAQCAtODc1LDExICs4NzUsMTEgQEAgc3RhdGljIGludCBpbXhfcGNp
ZV9zdGFydF9saW5rKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ICAgICAgICAgLyogU3RhcnQgTFRT
U00uICovDQo+ICAgICAgICAgaW14X3BjaWVfbHRzc21fZW5hYmxlKGRldik7DQo+IA0KPiAtICAg
ICAgIHJldCA9IGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiAtICAgICAgIGlmIChyZXQp
DQo+IC0gICAgICAgICAgICAgICBnb3RvIGVycl9yZXNldF9waHk7DQo+IC0NCj4gICAgICAgICBp
ZiAocGNpLT5tYXhfbGlua19zcGVlZCA+IDEpIHsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IGR3
X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfcmVzZXRfcGh5Ow0KPiArDQo+ICAgICAg
ICAgICAgICAgICAvKiBBbGxvdyBmYXN0ZXIgbW9kZXMgYWZ0ZXIgdGhlIGxpbmsgaXMgdXAgKi8N
Cj4gICAgICAgICAgICAgICAgIGR3X3BjaWVfZGJpX3JvX3dyX2VuKHBjaSk7DQo+ICAgICAgICAg
ICAgICAgICB0bXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5L
Q0FQKTsNCj4gQEAgLTkxMywxNyArOTEzLDEwIEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfc3RhcnRf
bGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyX3Jlc2V0X3BoeTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAg
ICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0gICAgICAgICAgICAgICAvKiBNYWtlIHN1cmUgbGlu
ayB0cmFpbmluZyBpcyBmaW5pc2hlZCBhcyB3ZWxsISAqLw0KPiAtICAgICAgICAgICAgICAgcmV0
ID0gZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7DQo+IC0gICAgICAgICAgICAgICBpZiAocmV0
KQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9yZXNldF9waHk7DQo+ICAgICAg
ICAgfSBlbHNlIHsNCj4gICAgICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgIkxpbms6IE9ubHkg
R2VuMSBpcyBlbmFibGVkXG4iKTsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIHRtcCA9IGR3
X3BjaWVfcmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktTVEEpOw0KPiAtICAgICAg
IGRldl9pbmZvKGRldiwgIkxpbmsgdXAsIEdlbiVpXG4iLCB0bXAgJiBQQ0lfRVhQX0xOS1NUQV9D
TFMpOw0KPiAgICAgICAgIHJldHVybiAwOw0KPiANCj4gIGVycl9yZXNldF9waHk6DQo+IGBgYA0K
PiANCj4gZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgaW4gRFdDIGNvcmUgc2hvdWxkIHNlcnZlIHRo
ZSBwdXJwb3NlLg0KR29vZCBzdWdnZXN0aW9uLiBUaGFua3MuDQpJIGNhbiBhZGQgYW5vdGhlciBw
YXRjaCB0byBvcHRpbWl6ZSB0aGUgd29ya2Fyb3VuZCBwcm9jZWR1cmUgd2l0aG91dA0KIGZ1bmN0
aW9uIGNoYW5nZXMuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IC0gTWFuaQ0K
PiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+Cu
teCuruCvjQ0K

