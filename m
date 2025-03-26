Return-Path: <linux-pci+bounces-24759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1EA71621
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94DF188DA6E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12A1DC997;
	Wed, 26 Mar 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="kfP5lyuM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2097.outbound.protection.outlook.com [40.107.22.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72315199A;
	Wed, 26 Mar 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990276; cv=fail; b=UVHYmmtQ9GCqAj6k4AfyMudur/WtsLxGgyKcECyIjfstlJb2d7SOwmgYwWEdtyeyJQaxIXlpp1WBctpAfHqwA0BkDaRSA9rx9fegBbZ1aVbZz9JewAhq7sIztboWcPpwOkCkQZjJBb9lX1wjhylRRuN7UR7swN/NE4vG89y9cVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990276; c=relaxed/simple;
	bh=a5buKVMymFTIbqXsaG+njaJbGPnqN5Vln0TtyrMZiqI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lyMgxGTDJP/3vZ8w7yARo4Hj1l7WyHB+vbi+pYXGvfM6R8x5HhWVoJrfasieJbSlcymOJ2APPKW7nrR05fJVC/NL0AOJ2cNFVADaVjfAV6T0hV2gmZ8C+G6FqnjZS10aNVOs2f59TMgazRjNgry0b3KTb5xhS0Rr7aUp9JeHIdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=kfP5lyuM; arc=fail smtp.client-ip=40.107.22.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpoh/flVT+nkDcELNFSyRkpZOPU2FlsEcUQaTHf8cw1j0HP7a4L3/OwtH4Uthp/gBFKVISTZAmJlLv8HSmROA/w0Cqj/e+RarnQGKXPrqDBz82/M7nOhK8YbMwumOvj9LPjHxKGxpiuNP6Vaj4iZfBky0ZCEfxT9jlahCfUzqF87tWsXJPBmHWh9smNWzIgDGWaxafhHK4qh3xxr8nF7y8QHQMi1a/q5XV1Am5l7tB7Zrkk27VTzoNXwvOqt4lQmwxtp4l2sxXNRJgNeVpoZhx5k1sGREHDqqZG5cALbB7GevO3XkwoQ+HB38QtZknCxxAT+gc1uAKuKnWgUunWupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUGLKnk4daE6DnFs4uV49R6bd9nBV9eBJxg88+KUxZo=;
 b=As5WKgzkcxYKXtaKRUcE5FbN7cHjya9CWphS6Oup/14gdZJH+HBzjJ+7/JcQlKWdQz5Ap4gZcKfx0a1gykewUj3nWc3E3AV8KG1jDRA4rGLJRcM7Z05dwkZS7V0Uq2WgclqRaOx2GsFYrXQ5ExHf2S/5SI912S1lhVN1UBsQKPqzZjEQ1wSOD844hKOOv0rItM8GMry7InDQP7QPI2mxTJ3v5iwtYFxc5FDeX1mmoJdirCc++Ac0mxtrVkBDzz2gJnvfwPmo+zlBTkmYCrlbVIhANYJqG9JWs9I7JSd1JzxtawBswvmMbtlG8nVuUwhLq7MXwXu9DgrcgJ4sXREKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUGLKnk4daE6DnFs4uV49R6bd9nBV9eBJxg88+KUxZo=;
 b=kfP5lyuMzC6V6tq1RpCuFBWj+++lP4BQxSiovW4vK9eBOvXd1f8rSv7E8d2PgyFXGK7etjP2Na3sfpLxDpXKcFCdyhBfocFZRAdirPfBaUPCoiybyyRaj1DQZqcQLJ7gvqOmiW7+/5evVWqVlFSZsEWQheVDYthwbf6m14qX97fOyz0G1Rrz5J5uuiQrMXW5N028FYKwBFTU5+zWz0km9FlafMkT+ii+ZISxFU32l4KkZV0O8EgDTa+h8F5NZXXIi9C8JyrNhaL3fByTyyWKy4AE1/kF8+urJJK7mCfpOWflPU3HlSoomM1t/OyPTIDRK7R4vKmoXClM9whGd3prhQ==
Received: from DU2PR04CA0247.eurprd04.prod.outlook.com (2603:10a6:10:28e::12)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 11:57:49 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::89) by DU2PR04CA0247.outlook.office365.com
 (2603:10a6:10:28e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Wed,
 26 Mar 2025 11:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 11:57:49 +0000
Received: from AM0PR02CU008.outbound.protection.outlook.com (40.93.65.3) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 26 Mar 2025 11:57:48 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 11:57:47 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 11:57:45 +0000
Message-ID: <cad53d39-26f8-49fa-9fb2-94261e74cced@topic.nl>
Date: Wed, 26 Mar 2025 12:57:44 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: xilinx-pcie: Add reset-gpios for
 PERST#
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84s?=
 =?UTF-8?Q?ki?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-kernel@vger.kernel.org
References: <20250325071832.21229-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7424060c-f116-40af-8bb3-d789f371b07a@emailsignatures365.codetwo.com>
 <20250325071832.21229-2-mike.looijmans@topic.nl>
 <20250325-victorious-silky-firefly-2a3cec@krzk-bin>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20250325-victorious-silky-firefly-2a3cec@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM0PR04MB6897:EE_|DU2PEPF00028D0A:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e5e9e1-cada-436e-b569-08dd6c5d6e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QTE1Q0ptcmt6cVhNZGVwbXUzZTlmalVyQ3hya2dSdjdISWEyV0JGNXB1Vkpj?=
 =?utf-8?B?MTVqYWVNWWpOS2pnWVVPRGNRM3pkV2dxVnpTZW41K0pBaVpMTForeXlCbmpB?=
 =?utf-8?B?S0s5WHVLaWFnVFoyZXpKOTJ5eHYxVXY0OWZLRmFLS1BXNG9YTUpwTHFRNmww?=
 =?utf-8?B?RHY3VEYrSFNNMlBlVnNMbm40dEMwNFBpei90S1NRYmE4WDVrbVZESHA2M2Jp?=
 =?utf-8?B?MEFwVDQ2eUVWREwzdms2T1c0NDVtUGM4VGE4NlZDZTNzRlFNRklRUXNGL29T?=
 =?utf-8?B?Tm1DeDdvckNReVNwaWtIMTdKRHhhS256V201VGtWRFMrcVROQzhzREIvOU9M?=
 =?utf-8?B?Z1hxQVVPUzhHaElERmhaTXJUd3VqUzFnOEhrYVBqSWxXVy9VZUFXb0FuVDZk?=
 =?utf-8?B?TUhveDBBSERhZm9jS2gvcXVSeEphVVM1UkQxSWVBbDVXcldGSGFZeHE4YXpk?=
 =?utf-8?B?S1FkZklaQ3F2UzVRQUtqQXFtVlczUEd3RDBKaWZZZm1rdU54TUNsa2ZIOXdS?=
 =?utf-8?B?ajRSTFhiaWxOcy9kbU56TlR4allkSHJwTHR2UWx6MlNCRnk1Y3pDUXBNWXZ1?=
 =?utf-8?B?UFB1c2lWbXFsN2I2QXVGbWlYS29xRXpYb1Q3dFE4Ky8vVkp5dVF0RjZwRUxS?=
 =?utf-8?B?RGtMWnhRQ2VaQWN1S0xMSDgybW1Ydm55ME04WVJQZnpkditQVnV0NXpvNUtr?=
 =?utf-8?B?eEtaYXA1Ym1RYlI3dkk4MWxMcWNNV3pYY08xbVptdkxQSGpISWdLTEwybElz?=
 =?utf-8?B?aVRsL0tsbHh0bmlabGlMUi9pSm9raDJUdjJWOE9VclhCcEJiNERTanhtRmlp?=
 =?utf-8?B?dzdKaFhKY2lnUjV4Nkc5L3lSeUF5NEZINHZUVWRRam9laks2ZWtUZHUzLy9P?=
 =?utf-8?B?d2ZiNHl2UzdTTzA2Rk8yNU5OZnRZdjRvbTdVNjByMDFEdzBFY3pPTGRObmZQ?=
 =?utf-8?B?Tkp2VTh2SzZTMjdxMFk0RVRBeUJDdWhPMjBpUHZUUU1XOFRjRHVhSnVRa0lD?=
 =?utf-8?B?UGtJQXFXNGMwWUJndTBhbHhQMUcyR2l2VEZuUkhYZXZiNXk2bVBUSkgxWjVX?=
 =?utf-8?B?bzdDclBDaGlzY2cvOE1WQUozb2IzZ1VtTksrYUVKb0h1aTRhcEFxdkFVTkJZ?=
 =?utf-8?B?SWI5enl3WE5zTHJNZlVtZkU0RGZSeFg5UjdWZWlKM1NxdDNuZTZ6NDQ2QURN?=
 =?utf-8?B?cTdhTUdNSlRyRFhhdTUwYWFjYytMYnVqMENYejZabjBYTnI1SjdKcy8yWlQv?=
 =?utf-8?B?V05KOEU2UUZzQUEzUU9iY0M0bWJIRk1JVjJqSEU1K2docWlORjRWbjB4dmFN?=
 =?utf-8?B?cFAyd1loUHNOUkJFeS8xMHNydmNrdTQ1VmE5YmVEcDdaU1dCc0srVTN2M0tk?=
 =?utf-8?B?TmlTSVZJLzV3K293N2RkY0Q4b0liNkNscFNCK2pIc2JNc1RVU3piaFZhSS9N?=
 =?utf-8?B?UzVuZGpzSks0Y1hTRXRCZHBEd21ZZEN5cWVZNFgzKzBabzViSyt2MUhxMVo2?=
 =?utf-8?B?bUlmS0RlTlpjdEh3WXRpNGRtZTljVnV1UjBuMmJQS2N2ZnBvTFB0SG5pN1Uy?=
 =?utf-8?B?WExSSUI0YlRtRGxkc3YweSt0eG5vUC9ZNG95ZStmVTVkT0ZYbHNPUTFQNy9T?=
 =?utf-8?B?S1Rzc3ZmQ2hQQ1gxM2lmT2dkLzhuWUgyT01lRVhBWEdqQmxPSkpzNW5ScnZq?=
 =?utf-8?B?MlIzN2ZIYWhOeE1DZVFtQUY0TDJJTkc0VUkwK0w4WUFqbVdlY3FaVTR0ZGdV?=
 =?utf-8?B?Z2xIRGJzcks5OVdDZ0tjL1NoaTRRbU53alVESVdVWENwRUk3RVlXSEJrSG1v?=
 =?utf-8?B?WGtjQS9JdnZjYXpqSDlNNkxJTXhzaFZYVUoyOGtuR1ZvTWUyLzByNUtad3R3?=
 =?utf-8?Q?cNtbQaPfFufC7?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
X-CodeTwo-MessageID: b6219cfe-861d-4242-bcb5-11335ffb1030.20250326115748@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2a2975a4-e249-4c11-b4a7-08dd6c5d6bcf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cldaWFBxdlhmZ2wvUEtMU2VnT3RUK0krK1FIQTRCbDJBRzlQTEtGNFZTUzdz?=
 =?utf-8?B?eWxleVQ5TkdHaDNmSUQrRGdiTVdqZXFsc1BGZUlnOC93Y2Z5d21KYUFTcEdD?=
 =?utf-8?B?K1ppRHJQSDlrYXVWRzNTUnRhVzZ6Q3lUM3BUR2JDM2FvblBVVlc2akh4Rm9U?=
 =?utf-8?B?YUJrRnczQk5lVyttMXVOS01Ec3I5a0tUa05IcHNIVTRodmxoM016ZlN3dUpU?=
 =?utf-8?B?eCtXaUlpakFCdzlMNDgrVGNQL29vVDZGUDNKT21zeXNIUUtOTUNiVmpDSkpU?=
 =?utf-8?B?aTUzVTI1NEJQZDFpR3VySjE4U1J1ZzJqa2kzMDBJaU9sUUwvUlZDUGhjUjVx?=
 =?utf-8?B?NjA1bUZ4bHJKYWZSODAvd09ndDZlazdnUnlHQ1dGbHlyd0xLVkhTb2pEeGdl?=
 =?utf-8?B?c0pKRTFQNkQxUHo1bjV5VXlPWGg1dTB3T3VFOGhaM0JDdk5lZWZrSnpJTHI3?=
 =?utf-8?B?bll1Ti8ySWdET1Nzd3pqMTZvbmY1SDhnZkdJMVBiQmVjQmJhYlpZK2VaQjFQ?=
 =?utf-8?B?dmtJM0pHbGhIVzVuNks4MXVpS3BBdVk2N3ByWWI2cVlQdEVIUE5iN0xvNXo0?=
 =?utf-8?B?a2lwUmpiREtmMkZmRlMveHVPQ1YyNTRHOTBQWXA3NlMyRkdKaGd0UGdvNXVZ?=
 =?utf-8?B?ajFuK3ZycXU5SkRuTERsUmVWWDVITURsZ21TVXg2VXRLaEJhM3d6MVE5TVMw?=
 =?utf-8?B?NlpraStEMWY1anBYQzFsZkNtMlpXLzdhU0xwdW40V3lwQkprK00yTGNJQi9W?=
 =?utf-8?B?Y05qTnRyTjdMZC9YSldyRHQ1MHdPUGhFb08xZi94enJHOGF0b01XbEZHTWM0?=
 =?utf-8?B?ZmMvUWxPZWpTZ3pDSkZpNEkycTROc2gxdlorYXlhTi9WQWZzUFlOQ3NoeSth?=
 =?utf-8?B?N1VGbEFUNmdPVkVaZS9zakU1NVNCYnRXRnUrVDhZbkt2TkJXdXhJajNtakR2?=
 =?utf-8?B?WHM4cWI2bkFyYmxOSnVkaFR2bm0zYkNxeVFkQ2RXYmY0cWNULzZGdHIwaXAz?=
 =?utf-8?B?RHBzanczYXR5d3cwRDFWeWQzNVhnRmplSFB4N2hQTXNLenh0NmV0b01vaFZ1?=
 =?utf-8?B?eVFobWZnSGYzWXdPc2JBWTk1a0NmNkE4Mm5yRlo5d0d1bXNyQVpoSytMOGJC?=
 =?utf-8?B?TUFVM0k4ZHJVQ3JnalB6eVI0NHR4dDg3Z0xlT2xNdU13UTYxWVhGWC8yL3Zw?=
 =?utf-8?B?UHZFMkxCR1ArWm8vb3RWdjdwVTVreEp1QzI0MzZacTJ3RG9VVTFHOUpZQXlq?=
 =?utf-8?B?YlIrRW1mVVBmMys4akUzeEVGTjlLdlBmQzJzUkhLMFFkQUZNdjBRU2gvTGE5?=
 =?utf-8?B?VHpXckdLRGRFZEtsTkM0cjVreDcxdG1RV2MxY3JBWFpMc0VjUHV6YlhxWENR?=
 =?utf-8?B?ZVdQUmo4S2FvYlRWM2ZwYmNBV3FubFdlWGJDMVB1MGlxaDdNSWRZUkc5OWc0?=
 =?utf-8?B?SHRlSlBYRmtrRlZnYVBBWVFTRWkzdSthcDFTMnRrZGY3TG1FRkxHUUFwZURl?=
 =?utf-8?B?a1lWZFpUWDRuK1FKbkNuWkhtT1VMSGZuT3Y5TW5DeUxDcGtIdUV0T1dMdUxp?=
 =?utf-8?B?Tm1iV3Z3TWM5SjlPTVRpdmwyRGJCTGt5NktuUzVyT1kwTTlCU3F0MmZUU3Ex?=
 =?utf-8?B?dHNyR2dNRUs3NHRPdVRhOTFkNnl4QkRtd1BzYW8rM1VCWmY4ZVhPZWxMUU85?=
 =?utf-8?B?bHFEck4vdktJdjY0THJJMzlGbjF0dWFhckFhNEFDalFMZU40R0FtKzJ0U1oz?=
 =?utf-8?B?elR2OFhDNWFDcEQ4Mi9WWmpjOE1jdnFQMXpXbG8vZ3VIaEZjQkR5OE1vWEFm?=
 =?utf-8?B?dElKblZZenFUZnI5eVh3dUxPY0gyOWkyV3dDRktGMk1ZT09xcVNFMkI0L0lE?=
 =?utf-8?B?eWZpNThCM1ZOT0UrbE1WWUtiMGtUL0k3ZE1JeDNibEk3SWw3ajBTY2EzdUtr?=
 =?utf-8?Q?cuWD0VOS9xs=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 11:57:49.0931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e5e9e1-cada-436e-b569-08dd6c5d6e33
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

On 25-03-2025 09:17, Krzysztof Kozlowski wrote:
> On Tue, Mar 25, 2025 at 08:18:26AM +0100, Mike Looijmans wrote:
>> Introduce optional `reset-gpios` property to enable GPIO-based control
>> of the PCIe root port PERST# signal, as described in pci.txt.
> Drop pci.txt, we don't use TXT bindings anymore.
>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>> Changes in v2:
>> Add binding for reset-gpios
> So what was in v1? Empty patch?

Feedback on v1 was that I had to add bindings documentation...


>>   .../devicetree/bindings/pci/xlnx,axi-pcie-host.yaml          | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.ya=
ml b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
>> index fb87b960a250..2b0fabdd5e16 100644
>> --- a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
>> @@ -28,6 +28,9 @@ properties:
>>             ranges for the PCI memory regions (I/O space region is not
>>             supported by hardware)
>>  =20
>> +  reset-gpios:
>> +    maxItems: 1
> Why do you need it? It's already there, in PCI schemas, isn't it?
>
> Why is this patch needed?

Apparently not needed then, sorry for the noise.



>
> Best regards,
> Krzysztof
>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




