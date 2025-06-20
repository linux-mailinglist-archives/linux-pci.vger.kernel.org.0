Return-Path: <linux-pci+bounces-30245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87EFAE1670
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B607ABC53
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2FA238D53;
	Fri, 20 Jun 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FtnlciiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA123817C;
	Fri, 20 Jun 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408597; cv=fail; b=eLMcqlaTllGhmzd3cJLH5e7WiJDM7e0pks5lpK3r063WtP3tV8lXic7iNTJ1uLw0bvSwEceudPD1hw3ouKx/nCTZyOk8gwL0yJasfmhmRIqCbjXiVtOjXYmNPVqcFrJLmDsSj95Y++HMG7PQuStG8O6mL6A6UcA8JqaFtX6Yo4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408597; c=relaxed/simple;
	bh=mP0HaM+lg3cCGfSvgLntK8LUXVPfamZ3M529eVwqKlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h4B3efS2o6uHCapD21xPKtgcYelgHABS2SQOt0lFv0oJsqav2FRonnKS1SAR7FBkKQ2o/mcz0bCnX2KV12UEsIyhc/qFjRQqJlBim8I3bQfLXcMLYpleCBo1WFWRdTmTn0yoKaSPIlRHiXSuSwyyVMKn9CARmMKp4dkdz4B4gOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FtnlciiC; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK8xCgbIq0H+VsYLPJbVWAIzHjan8MSGBHfKUFykrCuAZansTXvRICq3nNuoXanGSDQjqAVozafYv+FIYhRnGN8lnEqcnalMcnUuIKKBfV5xDCKhX6GIBzmT6UW69eAD0IrSK2U5ZB4hjg5pVSGCnnCqGSZ1AKKa1Wxp1qN0D9gO4zEMQWeAE+XIQCVHRpchvMpyBeAFT8MZOxOkN2uCoEI1rGa28ABjgLIoLygC8+BPUG0mCuBTwFCAlKZho4m9hi7yd2MsRlXL0Z6kUREXHkcWNz9rOV5vlfpiwY1ZR1NJlxxaeAm202VmMsXayywvFXjzqvL+Z3B6xm/vTpd8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP0HaM+lg3cCGfSvgLntK8LUXVPfamZ3M529eVwqKlk=;
 b=ovE3D2dYdj5tFhOpid62ZmpocdjHiueroLMJTTzLQjLYwp5U2q8ZhdftFn/BxUS8ARV5c8qFIFrW1Flq+NlS03WTmC3qynIAt2XY7iia1auD+qjmK7UXvAoPbR50v/kJLrFISLRQDn9dLe73URRmYbPKj+taHXMTxHiE8zpDPCC2q4OT9PEMEtj+jDaYw83NiBDAD9PkiGRojnfdYG5u3BJYd6/VdZIOhUqpAuEqukksp5EVYgZ36w9Jc2lAmEhaFQFEBw0SF6HQnhcIS0dFq9uk3mZfSbHOINwSlph9A+fXl+RGwqA/0PTNqDkXdQoKW9KMy3uLWal2xWXA5vHHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP0HaM+lg3cCGfSvgLntK8LUXVPfamZ3M529eVwqKlk=;
 b=FtnlciiChgx/f36scg/EDO7lzyYst1ZQhiDYPiWGUuUEnMGkMfPrWUuXKKQLszRfPxVZnZivYmZGHxDHZzEgfxPX1TW8iGFyrzshf2WTfCUAExYryxs+bDHr8qrb2pwvMGIqz4lt70qnAwXp2vHO0evyzad2CS3FUMU6ws9vt0RklebNmhJSWZM0WOR8wPaEy4zZQvEAykTD+8lLuvuzp85sFCeQFlYeWOnNLhZ00OlSU6/Icfli5tq7JrW7PZcqXz5kyPowvI+utWbX60cKr03TfNwzWes6nDgcJ+ZI5WO5pJYpeinhSBkTbjI4V7SJfaz9fG15dkpEzBL2/MDHKw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB7083.apcprd06.prod.outlook.com (2603:1096:990:6e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:36:32 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 08:36:32 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
CC: "elbadrym@google.com" <elbadrym@google.com>, "romlem@google.com"
	<romlem@google.com>, "anhphan@google.com" <anhphan@google.com>,
	"wak@google.com" <wak@google.com>, "yuxiaozhang@google.com"
	<yuxiaozhang@google.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: [PATCH 4/7] ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST ctrl pin
Thread-Topic: [PATCH 4/7] ARM: dts: aspeed-g6: Add AST2600 PCIe RC PERST ctrl
 pin
Thread-Index: AQHb3BN4PATbP2tR2USdEpp9iFmCKrQA2TSAgArrYvA=
Date: Fri, 20 Jun 2025 08:36:32 +0000
Message-ID:
 <SEYPR06MB5134ACA6FB6BE2C0B3D9A4B89D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
 <20250613033001.3153637-5-jacky_chou@aspeedtech.com>
 <9be50674-357d-45d8-9117-b66922b46d25@kernel.org>
In-Reply-To: <9be50674-357d-45d8-9117-b66922b46d25@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB7083:EE_
x-ms-office365-filtering-correlation-id: 47f0c46e-fad3-4a22-b682-08ddafd58f62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N294a3lJelZabW9wVnkrdjduVmx5RDFsQUhqeWJGNTRMek92VWhvL1lZNWNm?=
 =?utf-8?B?NXl4Vis4Z2VJeUQ0d2VSOHVZOWlWOE9xWE9RK1doc3kyWDBMR3FxMnhjU3F3?=
 =?utf-8?B?Z2tpM1ptMGFyVW1ZSmFBTGpGTXkwM0llcTVXSjBZbTc5OG5EOEphM2FVV0M3?=
 =?utf-8?B?ZnBYUUxmQUFCdVFUc0x4cUZ3V1FENEZiMDdoRWs0VGdrby83Wld0Z3VSSG5R?=
 =?utf-8?B?cmlBKzVTN3hqcElGbWRNSkhYZ1ZLVEo3cTVicTg4L0NFeUZaUEV2T1dFczk1?=
 =?utf-8?B?REJRZERwbHpQV2JZRmN2KzZYQVlOMGRGclZQeXlicUs3V1NnQm94emQzYTZE?=
 =?utf-8?B?dXhiRU55SGxFK3g4N0lKVmhqdGk2OGgvcXE0My9Cb3BGOW9GM1U0VzBpVnpq?=
 =?utf-8?B?UDZEOEZxc25qdXNLa2ZaL24zUGduVXlBd3Rod245b2dJZy9wSTh5ZkxSUmJT?=
 =?utf-8?B?YjJkVUsveHZOMXNvS2FlZXM2MVI5cTJGSkp6bFdGUUFHSUE5aEhGVHYyb0VG?=
 =?utf-8?B?VUEvSEhQSXZZNko2cWVLK0VnM1REdVJlSmdLMEI1S3l1ZzFTa1lsZTNzZHli?=
 =?utf-8?B?RjBlVGxsRitBT29UN0hNbkhFS3BmRFBQZnpRS29aM0hVcGtnN01zUldYVHVF?=
 =?utf-8?B?Zmk0Z0RaN3ZPYkRFZ1hDU2JBbGpVYzBsWk9tUXBlM2ZNZW8rTGJUWWk5Y2R4?=
 =?utf-8?B?RHVVRGxmcVdpNTNZQTEwRHJXSjV4L3FuOUJYZm9yYWNBbTQxa1hZbkh5WXB2?=
 =?utf-8?B?NVJtZitudUNodmF6cWRYQTQ3NGhXSkpDRVhmbmgxTkJ6bTlWTzBFYVI1U2Jq?=
 =?utf-8?B?ZnRTYmROR0ZHWkVGQkJUcU8xVExFZStna280NzNGYmFHSEdoRy94STcwZS9o?=
 =?utf-8?B?Q1NpZlRVdkF3RzlVVWxwdUlQNldFQmxpU1NXcnNGM2JYQlEyeXU4L2pEZ1py?=
 =?utf-8?B?c1ZUbUg2a1JCam8vdDh0YlBXWkNjQk1ndFlydVdteFExa3A5ZERqb3ltSms3?=
 =?utf-8?B?Qm1JUzE5cy8yRDY4aFl1UnZoZHZZcGtOZ2lteVNUY0p5b0o4WFRSN1h1L2N6?=
 =?utf-8?B?d1JxL1RTaE9DV1ZjU2pJMkJRYmo3eW9kNGpSUTFSblNMQzRPMHlxb2QzYzc0?=
 =?utf-8?B?TG9hbW5ESDdHQnFKRXRubU5FN0NCaVozOVRLclFSZUd3bkxOU1pDekRVbjBk?=
 =?utf-8?B?T1ZuQXBHTTRXVFc0QWgxOXJ0eHUraHdnL0M3MS91eFRQdktYT1ArM01ndUFm?=
 =?utf-8?B?L1dxK1JzRDg2UDZNdG1LZFFGZzBwL210K25rVlRuUklNNGRrdFhrSDE4MXVp?=
 =?utf-8?B?ZGZRdTF1ZTdSeW4zbDZtbUNMWG93MzJpVWRqSXBMOXgrbXdOVm1sUTJJK05E?=
 =?utf-8?B?OU1LcnJhOU00WjAvQmpEVUd1cVYvZDg4N2JGSnErcG05UjhqYmVDWVFsZ3Y1?=
 =?utf-8?B?MXloNVNWSUpRdlBsZzBiMEp0eGVPekZIa2FlZkMwSjlCQ3o0RnJmM1FiVVk5?=
 =?utf-8?B?Q2d4cUdlMFdZbUZ3OVRhYVZPRnh6VzZhZElZNXJwYUEwS1krcmQrbFFvcDIr?=
 =?utf-8?B?R0lubFdPY3Rvb3hzMklENVBYbXRodmRaVGhXdmlUbWlmNkRVQitVR1JDcVJM?=
 =?utf-8?B?Y05ZTmpJRGpOSm05STVJZENxZHFrWElsMkRVNXh6U0FwL3lDYzhDckJXRGdt?=
 =?utf-8?B?cENRUjRHSUtZdDVtVjFWZ0wxOW9WbGFzQVFIaFdVREt6MDNHeWZKRllBdEFy?=
 =?utf-8?B?bjlQaHNBbTYvMUh6dzlvMW13Mlh5TmxGcy9VVEtlbHJTNHJWQXZoUHhvY2Fk?=
 =?utf-8?B?N0NDMjBiaGhja1NoREZ1SERvREt2QWlGUWZ4QzM2cDRBSW5hVkFzTi9OeVd1?=
 =?utf-8?B?dFBnMUZZTlNPWU9kcTZreWdLNGRHY1A0TTFnS3JWRm1yNHR1WWtYTC9CZzRI?=
 =?utf-8?B?OGNHZ09NdHZtYVpuMVRKdmtrZk1ucWY2V0JQcnZ1TkhJSEdWSE9EQlJtbjQ2?=
 =?utf-8?Q?pYVsWn/Vu9JGot1KxNii301FPlEgcw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3hBQVBoaUh2ek9EeWFSNUpESG15VWc2NUtqWE9ocU9WelEveldPRFQzSnNY?=
 =?utf-8?B?Zkw0RUlMcUl4dzBKSFZSaEJVVkVnNytYT0lTeTJpNVdoU1grdm9qY2t3YjUr?=
 =?utf-8?B?SjNRSmpqLy8zUzFBUjdKdmN5Tno4bW9GN3FaVGU3Z09yYU4wV0VBdWtsaUpC?=
 =?utf-8?B?akFVcHAydVVnbWIzQm9GM0lyeDI0MVNXOFFIRGkrRmFnL2xEbzA2dUs5ZHV3?=
 =?utf-8?B?V3ROcEdqM1lVQjBpcUFXRTBYSDF6eHR0WEdLclNTcVl0aXBLQ1R4WlVpcitp?=
 =?utf-8?B?K2Z1aGRjbFpMZ3MxaWFYa29QaERCWU9MTmlIcnByaHlHV0hJUG5yYUxvUG1m?=
 =?utf-8?B?eDN2QTdPbzMwSksvU1F2OU90WHp1T211WHlUQU1WQXRna0ttWWwrYnZhcncw?=
 =?utf-8?B?L1QxYjc4TXB4Qmd4dDJVaGd2cDVPVUlYdkdGVlZoRGc1S0RRbmpEU01tN0FH?=
 =?utf-8?B?ZlFzclhycHBEZFdVTkJsd3pnMjYzVGV2ZE9jYUhjVHF4MXVEOHVEVG42TUtU?=
 =?utf-8?B?anRDOUNGVlc0ZThWcW5XanJoUVB5TjkwODVIOC9nWlJ6Z2E4TzVGVFZuVzMx?=
 =?utf-8?B?eXFPc3RoUmNveW1QR0x4dXNzQ2VjOENpaDJRMFZZakovNm9Yb2E0SDJQR3o4?=
 =?utf-8?B?VUtWL1NNVnh5NEdkMXB4ZnIyMGNqK1RIZlU0UlNSTWZyNzBCOXB6TkdRTmFw?=
 =?utf-8?B?WWtzRGkrWC9tUnlxbG5DMW5aRzA3b0lUOGIvRmwwQUhpZHJONjlkdXM0bHJ4?=
 =?utf-8?B?Tk13aDh6QmV1UCttNFU2K2pHY29jRjRDVjk1Q1Y1RTVyZEh1Sk9rbGxRdnV5?=
 =?utf-8?B?cHFTemNqcXUzVWJ3Y3JaemJEbkZSZVhaR1I4ODNhcE1kQm1uOGRWdFdjdXM0?=
 =?utf-8?B?QmpCeXZCV2FHbnFOcml0TStLaVBUcFUwaEJvMjBFcXk5Y3QyWGpoYVUwc1Jh?=
 =?utf-8?B?bTZtem1yT1k3dW4yRVpnckFIUG9ONDAzZmxKRmtwUEFDSmNBZ0lGMnBjVDhi?=
 =?utf-8?B?YnY4NEE3RUk0SkgxOHlaNWROdWZsY2UydlVWM2MzcmFBT2JkVGQ3MWF6ZlhK?=
 =?utf-8?B?R2VyYW9XTndWUDZqQ1Rvdm9kaEVIWnJpNHgzWkMza3hVMG9icTdCUnNYQWFh?=
 =?utf-8?B?MWZLMUlYdjM2eVMyMTNoS2hBZERpcnRFcDU1bTNaRVFyNG5LSUp5Rmt3clhQ?=
 =?utf-8?B?RTFHOUxrOVRjdlBPdS9PaFk2TExZTzBadEVrOWV4SXE2RVNDdkVsZERYWHBX?=
 =?utf-8?B?WEFLLy9qTitlTW16dWVvZnRncDFyK2llL2FRMUs4M3BJRkUxNWdpeU5XOXVM?=
 =?utf-8?B?MFh5YVdRSmhjMVQwMWtMcEg4b2x2YjE2MWJSSDYyUU5sTG9QZDM4V2JiYlQz?=
 =?utf-8?B?Q3E3UXVYRXFtREExY09MeVdPQ0NIRmliWjcxZVJnMXl3M2lZUlVFTkZXNEZM?=
 =?utf-8?B?YUhPV3RSRHFjRUlRZnNiT29VbnRPVWR2V3haUVkvQUFQdzJMYlFUdUwrcFNV?=
 =?utf-8?B?aGgvck40eXNIT3BOcXUvOWJvblZpK0RJR0diYjFJMUFaaDVYdlpGanpUT3lS?=
 =?utf-8?B?Z2dLVHlld05URkIySWo3VFJqTldadEZCcnBlTUtpYXZMSjZ3VFBDdHI1Z04w?=
 =?utf-8?B?VldqcWFTbFZhRjJGVkNXM0doMVA4K1haTVlhOThDYWZpOEVvVjB0dVVoSzFv?=
 =?utf-8?B?QXhuMnROR0hoMHBkbXFvbmhDVGNMUTgyZmV2eWZ6TGFQZU93N3lIQUo0eHpO?=
 =?utf-8?B?djNTNWJKWmlnOTY1elRMSkxtYWt4VUNEekZLaTNSbDZPNG0xM3BoRURrODE3?=
 =?utf-8?B?MTd1RXRKNVJMbXFzcUN5Mmd4WURTcFFEK0FIVTV2aFkxTVI3QUcvRHEyTGpa?=
 =?utf-8?B?OUdPSHo2SE9Mam51OXhVTFFGNmM4aUxQT0pPMmdEZkR1Vm5XbW5ZVlJEeWtO?=
 =?utf-8?B?UnZlVXQ0TC8zT2ZYVVNwU3F1d0Q3em4rd1VjNG1hWGVhM3VFVURXSVBHSmNx?=
 =?utf-8?B?a21XRWpUSWYxT3B0S3VsNGFIMmdzMjAza0VLVEMzREl2RmoxUDR0Unk0MUly?=
 =?utf-8?B?KzdCb2VXOVExQmpFL3BHWUNaNUZ1bEZwZUw4Z3RxNnV3U1N5YnV5dExHd05m?=
 =?utf-8?Q?sow4qcXEJX4dCZxmH9MCo0u/b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f0c46e-fad3-4a22-b682-08ddafd58f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 08:36:32.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl1tnAUMeXPfyzFTc0EXH49IfCAMTrz0GTKBOji1koYfGzPZyfY/F0CNJxK6mwvnf48J+2R7tphO1+PJb8QrRKMAA86TJPAk2BEtsYSE348=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7083

PiA+DQo+ID4gICZwaW5jdHJsIHsNCj4gPiArCXBpbmN0cmxfcGNpZXJjMV9kZWZhdWx0OiBwY2ll
cmMxX2RlZmF1bHQgew0KPiANCj4gDQo+IE5vIHVuZGVyc2NvcmVzIGluIG5vZGUgbmFtZXMuIEZv
bGxvdyBmaW5hbGx5IERUUyBjb2Rpbmcgc3R5bGUuIFlvdSBoYXZlIGJlZW4NCj4gdG9sZCB0aGF0
IGluIHByZXZpb3VzIHBhdGNoc2V0cyBhbHJlYWR5Lg0KPg0KDQpBZ3JlZWQuDQoNClRoYW5rcywN
CkphY2t5DQoNCg==

