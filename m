Return-Path: <linux-pci+bounces-12410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F23963D23
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F21C22724
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B818755F;
	Thu, 29 Aug 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NkTyj2o/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B715B57B;
	Thu, 29 Aug 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916863; cv=fail; b=TPesK202ow3BvMvTpcVJGOOqgNU+BSyW/rh0IOy4YDN8ui7SS2Dluq6KkRw/V888CzGzAUGx9+BiweUS9Zat4jg/w8+Zu7mqc/370qmipv3R3V+lMuq+yBBRV6M6WQFH2AKpi7k0NIHrSj2wkFMINjqTL41+WpN5TomEkrcElv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916863; c=relaxed/simple;
	bh=53NNl/AHumPVV1xvSNDhNmk4hadZmgSs43tSMQe9Jdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmq41KHpjkl9WxJilKluoPkUg6dqhpQjNEb/GnOmCKkdY7dHUDjqTlD/ocmzPW1hAAl/HEpuibEesbLlcg5yIWoBJGXnLPk1b7lKs2LqmsLCR7qBbuSDze5+fXXs+nB5T3YLFkHn+5uvpCs8qNCBOBEyTRzYUqa6od8ASYTrSXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NkTyj2o/; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKW1galr5ORf1j8R5MbhQM/U0L1uD6xrxzMqUcDl8btpFOU/KWxGlTVrzDgRbExWy+jl6SnGUp3VTqgZcxkAVaHQa8qitP+H4y74tXALlFaq/9YhUeRPGcM8PM97H9MWEe7jT5jA1Is2jTJm4WnlwObiF/JOW2U6XuWaixaC9pKZPlr9FrlekJevkTSKFLooACH6UdjjXwDHlqi2VYzrlLbYZPES4FAyHl73t6/kA+bgz3UQ657Wr6MIyb+xYZPwdrKdL+RgxaRI/RAXCVQaBJJ9IUW1tapgD77v2arLyqUuI3MdJT2tL4652t7Vtfp9MFNaNtVz9R97KJlnvhyGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fig+XcQyGCrVm7dXCI7z3IDJdEXi0zxLaKnN85Bzqa8=;
 b=XlrXPiJ+q3Uy3bZxuZki6dyhC6E6dzCWYrTlWoOCeGuj2AA/br3HPi86RSr4JqidbcLtZqKh4uS0uRWxqZJ38RzpC2japNJ8SyKPr2XjVMfOfUM18xbk9tjOHdCSvfa9YBF14WrTWq2LpgBdUGc+1r3SEgb+yLPZLp/xhy5JPCQbhF5VHz3QBecYv8RiBk6u8QE2qJbVjtRTGRrPfHMhE71hwNt3Tas/DZWXFLDLI7yNsRu5E7ohkmNkbRt3AvhCYQPle5WoM3tK+Gqgmo9CIamDa3c6rGG8S4kPDCtDqP5TAdL5RE8WzsmJAiNA8eYTVIq4sZfG5xdPj93cRuaFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fig+XcQyGCrVm7dXCI7z3IDJdEXi0zxLaKnN85Bzqa8=;
 b=NkTyj2o/VOntSwcef10XkJ3KmgD7dUNBlEJyuDtZbRe5iPBori9aNkv52zW+gOXueEtydNzEJpB8rcdYYK4zsR//QKQ+pJfn2Ip/sLq9F19GFeYrpFncU2deoJ/AlhLkX5Myulo2qYmxsDqUyo6BlCFWmX7z8DD72qhW0fjeS1rXddVoHY9l8GuR6ONDiFARXE9xunHcud3kMUcuCuU3u6Tu5YTRFS27hf/BNsJ6eVviuToucNXYI2esoCSztSWmlpboKyy7jJS57VFAgh8z9K354L3j8hpmBSPGthjerODCePnrKUyIhDRKcO3cG+KXgJvEiqv0Iw9TI+jWL6QE6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 07:34:18 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:34:18 +0000
Message-ID: <d215ba71-c652-4c2c-aa19-7c7613a9dd4d@siemens.com>
Date: Thu, 29 Aug 2024 09:34:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: dts: ti: k3-am65-main: Add VMAP registers
 to PCI root complexes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
 <988ddd76b742240d42aa2733ad92c6e7b82a3f0e.1724868080.git.jan.kiszka@siemens.com>
 <bsxsk3zy5wyao7ljdf37idff4jf5g3gsp7amkywbm7z55vrt4j@fz4x4vjkfehm>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bsxsk3zy5wyao7ljdf37idff4jf5g3gsp7amkywbm7z55vrt4j@fz4x4vjkfehm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: dd31b9b0-cec2-4c92-5c09-08dcc7fcfda5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnNFMnYveE5BcXNvN1RRS1podGJ4SFRaaVMvbDQra1huMFlxRXBuZTZiNFg3?=
 =?utf-8?B?ZitENEVjL1dzUmh5dmVTekJnN2R2TmErWXhid25VOG9yQXN3UFc4QXlPVm4v?=
 =?utf-8?B?ZGJkQlUrS21FN0N6MDNsS0JoUUNJc08rTW83SUt3cjV3MEMxVEJ2d3R4RWIv?=
 =?utf-8?B?MHB2ekNlaUJ6bjFodUdsUDVXbXlsOWwvN3FGeE80TklnOCtQQ0J0YVBRaXFP?=
 =?utf-8?B?Y0FuTHBhUVFTTlpHQXJWbEhuQlV1SmpCRlpsZjBGRjZLbXZyYzNFR1AzcjN4?=
 =?utf-8?B?TTRUYk8yQ3hqMWRGYjNPWXlZUHZJaDBwQVhLT201VTROQnNDdlFKekJIZ1h0?=
 =?utf-8?B?eTBDNFlyYkJRYmdyNlNXOUdJZzNyVVlENkFZVi92OHBwbjZ6OUNwSmFGWFNm?=
 =?utf-8?B?T2QwVWc5RWx6Z2JPSm51YTAxa0dVellKbDBpRkVMRHV5MGJMTkRudFFKVkhM?=
 =?utf-8?B?TTExSi9iZHNkTC8yMXdXcHJNRS9NUElxdjdnNFdrbzhUa2JiMnRieWxIbmFP?=
 =?utf-8?B?YUVtSFQzU3hJaUVkZHY4S2s2RVNJUEROb0tNNnNWWGhsTUpQOFJyekdUZGFF?=
 =?utf-8?B?MmRPT3ZrNlB0UnA0NXc0cmFPSXY1dnFGQitoWnhleUdMVzhUUmFqUXEwN3Rs?=
 =?utf-8?B?RWx1NUFZcW1tK0ZBYlh4VnJzeWkvN1I0dkVLV2dIMnNoZXMrMWk4THNUcktn?=
 =?utf-8?B?K3pacU0xQnpyd3J5cnh6ckFWM0dOZEVQajJsNklBYjgwTXJmRWk5S281b1J5?=
 =?utf-8?B?a1NxNmRiR09KbHd6RjFYejQ2VkdoM3E4RVlWY3RFWE1iTzRPTkdKeHVYRlhC?=
 =?utf-8?B?TWxJRDZ5cytDY1pvZ2oyYUprSXBEbHU0a3RzYWs1UTdtQUI4cXpERXpEcG03?=
 =?utf-8?B?ejk0UkdRSXZVU2RCSitrL2kxWDhzVjlNUXVHOGFOdi9QSW54bHZ2dUxmRHpk?=
 =?utf-8?B?Z0o2clp0d1plVXJLak5GdWlhVWREQU11OEE3ZjNvSXg5ek8wamhXdlpOSUN3?=
 =?utf-8?B?V25Xb00zL0FLM1lJc2ZiZ21aSGt5RVJELzNVakJwbVlhS1pBN01JaUphQm9t?=
 =?utf-8?B?bFhnTnN3VG15REVsNzdIc3BmLzlxNFZnWWJKWEwydUEwU2RZSUVlZGtNVzN3?=
 =?utf-8?B?cXcyWDl2TFk2TW9qUTlEdStpK29PN2tua1JlUmV5b0lQd3U0VDBrRFdOYm1k?=
 =?utf-8?B?MjhCbk9JUjNoeFpPMWp2QWNPV3hTeUxSZTZ2VktaWTRpYUx4eWdnNGp2Y3di?=
 =?utf-8?B?b2UrYUN0NTUwRmxZTlJFTGR4bXNuclUwOTk0dEttajlKVkdFRDVDajJ1RTIv?=
 =?utf-8?B?YndIVzVtczdUalVrSUphQ0lhRnRHMUE2N3l0c1ROVWJNb1NsaVF5VjFUQUxz?=
 =?utf-8?B?STNOWnZjSGJyeGlIdmpGZWNUZlorYWFRdldQUnV0a25MOGF4WmpFaDBER21n?=
 =?utf-8?B?d1ZNWmlyNVdVTkZqczdDZ1pxaXlQSWtsVTRzZGVrK1JxdGc5QWFDWmFMei96?=
 =?utf-8?B?TUoreHhGNHpnQnJDSFFsNlA1WE5xT04zc1E1aFBLU2JSTDdIMnlQcnB4dWhl?=
 =?utf-8?B?TXdnM3Byc2x4aisrZTF3bDJtZWhJbzNwaGJhSjhLV2pXd0xIeXZRa3dyU2dX?=
 =?utf-8?B?WElId1BROEF1ZlNwTjEwaDVVT3RkbkpEUjVGRnlhQjR1cWdnZTUxcGU0dE1S?=
 =?utf-8?B?NWpibjBCMERUQUlzVG9zWFhncVFteFp6b1VFdldzSys0VzVxb3FTTEJPandF?=
 =?utf-8?B?dGNpazUzRUtpWEZpekZ0d1VpTGFYL3lxY1JhYkY5NXdUcFdOM3ZTSnZic1Nx?=
 =?utf-8?B?UmxWcjdjVk9HVHdhMVdMQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEtJMzVqNVYvUmthT3haSy9lajl0TmcydVhYcmdaZHltZXFUR2YvMVZsc002?=
 =?utf-8?B?MUlyNUpKYTJzT2RzbFBGaEw0bWNoOXNqbjVWbUVaUlNPSVdERDIycU1tKyt4?=
 =?utf-8?B?ZVhqUXVoNDJTeVlxTWZjWjZqRnVndUJrMUNvY1JDZHNvTHFsZnFic1kvTzdS?=
 =?utf-8?B?OTVwRGFPaEdmS1VDcW0wTE00RzZGdERhb3ZiWm1rVExNWUZpS2E1clpJdzl1?=
 =?utf-8?B?T0pmQmtLMVQ1L1lKNGQycEJTSXYzalBHUXNGVW5LeFkyckFrTW15b24vTjJj?=
 =?utf-8?B?K2NFMWFYTTNBNkYvYkw3TUlNRGZEMUlPeGY3eFJQQ2FVc2tLQ0NJd01IcFFw?=
 =?utf-8?B?T1I1cy9OQ2Iyd0lEODBYK1QrRzdac0U2ekRJbmw2Z3UzZU0vMlFHMm5LUkFz?=
 =?utf-8?B?K0VSTXBDY0l0OUJYTG5EUGdXOCsweWdNbU1rczRGR0NTejdoNW5ZTEdZbUgy?=
 =?utf-8?B?SVpzWWp1QXQ3UmtKWEJ6NklueVR5ODhOd2o0ekpvUkhLcXZySllSYzM4QkdZ?=
 =?utf-8?B?V1pMTWh5b3RTUW1jNk54dmV5aUE4d04yN1d2bVRkSzlHMitHdzh3akdWSm9s?=
 =?utf-8?B?S2tWMjBWQlJTLzVDNGY5YytDREV5cURKQ2xQMXFUaXRKd3U2M0N3NjZ2cEdC?=
 =?utf-8?B?aTdremQwUHJLNFJXVXBkdTdVZ2JvdURFL2J1U3RyWGJYZ3JQSkV5OGVkZCtK?=
 =?utf-8?B?NkFybWJQSmJhRG52aEE1NnU1d09aRy84WnIzdVRyc1A0QTJncEQ2TEhZVkpp?=
 =?utf-8?B?TXc0M2N2UXB1THJSaWpiRjhsdlo4clhxVXoxd0M2cTNScEVibjdPdUNmY2Qr?=
 =?utf-8?B?M1VtbUF2REhkN0N5R003RERnU0NoRzd5YVZmZFFNSkJyaW1NMUVqNnQ4YkMx?=
 =?utf-8?B?cE9xUFBDSlpuMU5oWWt6UnlUSC9TL0VUTzkwK21jYU05eVlTOHprOVhMeThn?=
 =?utf-8?B?K0txN1ZlakF4SHJYdVVYZk1CRndFRW81WDNGZ0dyczRudUlBbmxiNm1ZUXNH?=
 =?utf-8?B?U0R1TU0zZFNranFOMVNrQWdlUG9XRklqWDlGbGpXbjhzeEJxTUZ4QlBYM2lY?=
 =?utf-8?B?YnJaT1NOR3ZGNlZvMGdFRW1Qb0ZqMUZ0aitLckpFeWp3K2dyaDV1RDRFUml3?=
 =?utf-8?B?bzk2bkJuMjZ5Rlh0VFUvZWVnenkzRFpBZW1sRUdSQWdHVStZcGRhbVlDSE9h?=
 =?utf-8?B?SElGMnNTWEw4aWhNTjEvZlQ4NSs5Sml5WTlHZ2pUQTJTUzZxV3hIbUhZeTJX?=
 =?utf-8?B?SzQ3VUZFaCtUSEcrUmJVTWU3VjNsQ2JWWklveFd5bEJ0YTFxckthR0tnN2dS?=
 =?utf-8?B?anhYTFZRUlNlcmlOS1FHYVlqL2hMckpLdnRDMGhGMVpqeEUvNjJoOW1SYXhO?=
 =?utf-8?B?Tml2L0dOb0g1WlhCeGZmQklCSXY3UGpzZEtOdWlhY1IwSGZRZU90eTE3LzVo?=
 =?utf-8?B?L2thWkZZbStPVnJubG1lQUxOWTVHT0dVUTZLQk40MTZBaFBDVk11ZG40bEF4?=
 =?utf-8?B?TUFET1ErWWt6ZzlrSVBUTkFQUnVKVkVkc1dkb1luSDhJMzR1UkhKcWRSV1F4?=
 =?utf-8?B?OGU1c1JLYnZ4cmFmUjNSdkJhM01YeUFXeGkzWFJ6ZFV1TmpjQWdObDgrVHdQ?=
 =?utf-8?B?amlpVEZiSWtxeTFRMEQ0VFIyQmhEQ2hFcDVCOGluTUh3SXBGMDNidEZ4cElL?=
 =?utf-8?B?dkdUakIwYzNzUWtZS25aTmFnUjZUZ0JKUDMrQjVPYkJpQjNxV1RnNjZmMVgw?=
 =?utf-8?B?UmJwbGdUZXZ3b0pndTdPVE1xWGdrbGF2L1d2OTMycXVDM2YyQjJwODEwSkI0?=
 =?utf-8?B?OVV1K2JLZlByWmt6eFcvaWNDSXd2Mko3clhRSTRMbHRvOXhES1oxcmlLbHlq?=
 =?utf-8?B?eEhuanZZMU5vdzlmUFRVK0l3ZVVXWXpOcitxRVF4MEp6Y1lrNkgzaU1RZFJ3?=
 =?utf-8?B?d2txdFRYMHpNaGdoRlhkTzlsYXBGSzhPTGVQOTVGM1ZxRllMdGhhSmZpTk4v?=
 =?utf-8?B?L0JMdW1JOS9WSTVrb3dtcklRWEJJMlNMV21wQTk1dnFrTzAyWVhJL0d0MVQw?=
 =?utf-8?B?WnhzZU44TjdZb2UrKzRXYitOUnVzTk85Y1JBa2RyejNRRmFvSXZxOWFGeWxU?=
 =?utf-8?Q?QAUQAq/C8fbepZR13r51SRs7t?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd31b9b0-cec2-4c92-5c09-08dcc7fcfda5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 07:34:18.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6x2tKIS7EQBPoagY/RYU+a+azRYq34FzXOMVJltwiVTnZ9Gpd3+qCRdOgPMLRMg4gQcLuA+MDIikb7HqymDSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6876

On 29.08.24 08:12, Krzysztof Kozlowski wrote:
> On Wed, Aug 28, 2024 at 08:01:17PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Rewrap the long lines at this chance.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
> 
> You still have DTS packed in the middle of driver changes, suggesting
> dependency.
> 
> Such ordering does not make sense, because entire DTS goes separate tree
> and branch. It only complicates stuff because if you have dependency,
> which you cannot have, it won't be that easily visible.
> 
> You already got the same comment.
> 
> Please fix your driver to remove dependency and ABI break, and then fix
> the patch order.
> 

Could you be a bit more precise in your review, please? Should I also
pull the last patch to front, or more all DT changes into a separate series?

The PCI driver will not fail unless you ask it for the new feature
(CONFIG_TI_PVU) AND provide an incomplete DT (DMA pools, but no VMAP regs).

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


