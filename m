Return-Path: <linux-pci+bounces-42165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F6C8BB0C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365053A71B1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F333F8DC;
	Wed, 26 Nov 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IJZUgyCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3069311969;
	Wed, 26 Nov 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186191; cv=fail; b=naOeQvpm6oVMvszjsTrdyIOOLaNb6qfpBBQcSYuQmX6ndgYv0Xq/stI5olGMJTdL+hMam2zyHuwPhp5Ij4cv4tggSYVKL9qG5mljQfprKDDVTcLZIiY9ArMMSIoKUHfSJs03SFnk6bOOgIHJtbDDlNviH6JQdA49lVxMRiMdhiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186191; c=relaxed/simple;
	bh=ZEdDLbStlNu+RjMbcnmy8asFY6t7UOr4H/SwDxjJjLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nw72hzl9u/8nazYXzmNvHB1h2CzoBM8OKopXIlFM8GEO4T1IBS06R32MOXj9EYa2S+2L02nnceOOYoLRVycVKhTXmXdwC3kGci7vWhB5OTuMxI6J8gYE+zoSlFftM6c8GKvcsqw+G5jeUT1S/qNvU9faqqeLfiTgit1ha8OYEh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IJZUgyCa; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMklfARzdoUsMMgpxLyT3ak4nvyNKF0QzjexUExef6u/Q+0HYoOpATNjRygMkivZAmVx/bCAZT11CZWn1eM+fKsyUi4cRx8oF5UDd5lN/ZslVTE2KDtb5vG0lqTr1Am5IlWBMyplWm9h6oVJgZ4BPN3tAjF0MzKghB2FxWIivK+Hb9x/DL/mNCQVw/ENj5ZdHzCy8WwWjctdtrTOuP1fdn7pni0AIrsF8RNzqGuDqmHpoI7e0QK9eIl2HB5VVJqNU3L+zA4bZikrM7bFvsksbh/rMbVgGoZbxu2TtSybwnQXs5vDeUp0zIj0gzctNrswc0eFwAqnweWmUu4PNeCtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaG+j5sxiF4efnKmizh9hodyhROzHgwI2tCbvUmkeUo=;
 b=yCrHKv0OuZNKC7tH6fpSC2Vqw3grusLVSwtn3JbIvsiSaZ6h8IMuflx4zAicFf78mF2JhNEYCGhGYbtuGjBo7FI8iZq1kODvxWVv38wjcVRHphLusY+hBXnlzlC/efxfukIo2HrGTzkxpxpjCJj5qoYikUlYY1QQnRbW5qxktV/BABwR3t4MEKCiamicdWXqhkQ24C3M5cx7eIC8EvD8Pc1JpzkwEEdSfGVCtc7lMgx/ShIiBQWcUMvnbjPNeNlwEHbZhoGt8ebIWM9IeVlaYKRk0YinQDcG5t9GgwnQa3avWiDgFC9Yee6lQ99nGM0SSSGRV93FSPHGQtoI0QED2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaG+j5sxiF4efnKmizh9hodyhROzHgwI2tCbvUmkeUo=;
 b=IJZUgyCabC6rgprDpR2GwmqS+YUxvaCMOpzzA0PIhzVM05qW7dvv1FNd8M9dcC3qlbMWe8/+Vi4Eu0bagLOnjaUI7bQCrCeUuuLYKlRAGw+/d9CWOlrUaZZ/iROut0atuAg8B6/ATC7YWds8l0WIMvsFk9qJxy9LSAGHJY+eKbZbYvshxm6Dyjba8qV7OAWAEK6VA0pvmPwiy5e8Xi8QZxZkUY0oZKwqBZTyCX97s30++JEi6sxHPL2PrN0B15BZvV+HzEVQqG1fmqiybtfc5PHDWLtowmallijlQWSAxeudEetjWCNrsk1XA2q/9xD++pryhh0Evk3upMH/HArpRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DB8PR04MB6779.eurprd04.prod.outlook.com (2603:10a6:10:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:43:05 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::eab4:5469:3643:fa12]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::eab4:5469:3643:fa12%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 19:43:05 +0000
Message-ID: <f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com>
Date: Wed, 26 Nov 2025 13:42:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v5] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
Content-Language: en-GB
To: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
 mbrugger@suse.com, s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
 ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, ciprianmarian.costea@oss.nxp.com
Cc: cassel@kernel.org
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-5-vincent.guittot@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20251118160238.26265-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::13) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DB8PR04MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: d85c4944-a43f-4b04-51ea-08de2d24043a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUZWMk0zaU1uWlppaG9EYmw5N2N0Q09oWVBRT3dveUxyMVlaekppMU1NYXBq?=
 =?utf-8?B?MThDUS9sQ3JWRUJNUjU1NlRTYStJSmZ4dUdlS0xTTEpDa3F5MEcyR1k4RmVI?=
 =?utf-8?B?Zlh1TGNlQzVKQUhHRzlxV2Z3ZGNkSGsycUJxa0t5TzFSd2s0NzBhMnhzbjhW?=
 =?utf-8?B?UzhlTnpiVURXY0RDNnp6WGtUampFT1RSTmhiVUFyNU9MWWxpSk16NGx4cVAx?=
 =?utf-8?B?S29NbkYrNWRSK0RycEdrQjJyekdmcFNwTWJ3T0FCbnA0Lyt5aXZEWUpmc3Jo?=
 =?utf-8?B?dDVxQ3VLRlVpM1hDZ1FZNFphMVpCdHBqMEg1MmQ3ZCtBWnZ6UzQ4dVpQNlpj?=
 =?utf-8?B?am00TVNvdDUwWkpyS0JtYXh3a1ZacW9HS0lUY0lnL1dqcldEZElnM2ZDSU9E?=
 =?utf-8?B?dTNWWmkweU5aYjExMU5SLzlOUklGa2hXbUQ2NnhUVmNZdmRjdEZvenJuLzZE?=
 =?utf-8?B?OERJM0NlTG9lU0I3dkM1VE1uN2pPRHllelhNQU1VN3VaNGQ5UVdJNDRobUpD?=
 =?utf-8?B?cW1ldXYrd2RsSHJCUTlBNVVOcXY0aG81MTRJK1F0bXFKTS9YTTR1VzJadjRm?=
 =?utf-8?B?anV0ejdQTnZWeDlUUkZhQVAvdVJSVlkrL3JZM1FqSzBPTFczenIrQXZxdW5n?=
 =?utf-8?B?dUprTUZSK3NZWUt6SGZHVHQxYzlrengvMkM1aFgySVZpOVNtRkpDdVQvL2NL?=
 =?utf-8?B?Wit1SGZRTE1VNDVPY3UrQjFRRG5kOFpUMTlBU0FIRFU5UXhYVUZlNnBYejZr?=
 =?utf-8?B?MzlwM0QvNi9QQXVHUUNCMWcySWdpMXZvUTcrbENFNFFDUWhTZ3oxeEFQSWtD?=
 =?utf-8?B?dTE0U25FWkxRUWdKWmlqMWIzbm9xR2N3bEw1cEtNMGdMU1R1SUdqMjR1OURT?=
 =?utf-8?B?T3prSGFhcjd3bHNZdVdIaWZYSFIyZ1BiZzdPdDZsQVptRjJDTGJQNjBxY014?=
 =?utf-8?B?WERpRjhSM2cxYjNrejMzTEFkTGt4WVRHajBIdkpVTnBMNUNmdjd2cWtQVTJN?=
 =?utf-8?B?TE4vbU9UcU9EWXBhaVdSUzBybU9QMjI4ZzVPTXFsR0V1NnRuZXhxdU9LWkJk?=
 =?utf-8?B?cWQreFMzSU9QcmE5c2hKdUFETHRZNGhNa3pGMjM1bGlpYkxTL1J6M3B4aXQ1?=
 =?utf-8?B?TnJDa0dKOVpvZitldjdGbGIrVU5mT21yRVd1dnFGNGdCMDhwMUtCYUhOU3lJ?=
 =?utf-8?B?V2ZhaTRiaXRhVW1DclVkOVhQTjJjZ3MveVpRKzB0WmRpTjRwRXN4MmUydG14?=
 =?utf-8?B?TGppK0c4d2M3cnRHWnZoenJUK1FSU01hUzFoaDZ3UzM3SjdFcDBNbk5DQkZq?=
 =?utf-8?B?WnpvWUpOaUpzaEV4SW9LOFdzR0FNNEtYNTlDVlh2MHBIRHZoMDdpWFJ4Nlp4?=
 =?utf-8?B?MEpPV3ZxOGxjRmNVKzY3OHhQNjNFMVdJaXNNSjNxQmpuM1haZHZJYnFlZU9p?=
 =?utf-8?B?TFFGVEJ4cDhjckExaFRhVHNIejNIazdBUzFHUEgvcVdWd1VEVVFUa0lJSHVR?=
 =?utf-8?B?RkxsQVZKeVlFSzV3V0RTSk5uTEQ3QmlXditkTWVSUWV0ekRRSFpPZDI1REtZ?=
 =?utf-8?B?WVlCOXNNWDRzTVpRNlZQdlVFK2pVUG9CbndyNWErZlB0RXVnaEswZitwL2JW?=
 =?utf-8?B?VWhJNkVQSlZVS1R5SGUrUlEwUTM5bmJWTFZZTGdpSkR4eHRBRThYRG51dGtK?=
 =?utf-8?B?OHJoTzF6VklRS2d4d2JHbFZBcmhOZEVzZy9SZXgwYkFxMmE2RGlMVHFETkM3?=
 =?utf-8?B?dTFpemcwVTFodnEyaWpTaFQ4bDJRY0xXcjJjSzQwN3dTTFVsamR5UndicXdl?=
 =?utf-8?B?MUVvalZZK0dxcEhlQ1d0YUl1ZTgzS280T0ZVMWV1OVV6MUIydWUzNFFtZzJt?=
 =?utf-8?B?Y0IvWnUyd2RuZnNiTHBteW4zb0ovUFFxcW1FNDMwZTBaYWd3S0xiOER5cE9x?=
 =?utf-8?B?emlmMGJLd2xrWjhlOFhabWQ4YnZqcHhVRkJhTWRmR2U4bzlsbUVPVElWTzM1?=
 =?utf-8?Q?yT1CnzuViv5/Egm5GpS03UoI3LXoU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU5LeE5TaEhwZVBucnJKTjFGSkJSNVR2QjNyejk2d0dtRGgydE5uSEVxU0hV?=
 =?utf-8?B?THVEa3pMMjRwUitEOHBiREFPd0dzOTNXaEZtbzBrcVN5NUxlMTEreTV2ZTcx?=
 =?utf-8?B?cDZISGtuSTFtMStwSnJLby9KZWxaTW1jOEVsd0hkamduZ2FOMXZJcmVnenBR?=
 =?utf-8?B?aG1JREVVZXJsSjF0N2VIOElSVTZkbklIbUQzaUE1Ny84NnYvTmdVNjhxWDFo?=
 =?utf-8?B?enRGUVFhNFVFM09YOXBBNVErWnBCK01zUmhHWGdhWXZKR3hzbC9xdlFpcVJZ?=
 =?utf-8?B?ZzZjMnFEeWw3UXd2VGV5OEZlb2hLSEpJQzFKYWx5Yko3SnlwK2VCeUVyTDA4?=
 =?utf-8?B?VjZQb2FYNmY1RmloQlZBcmxld1RRaC9iZmVLTUNleXRGMGRKaHFXTEtwZ0dt?=
 =?utf-8?B?a1llVUUzN25EemNKa1N6bWM2dDA4THZTdFNoUUZHdUV0T0NwOFhVUmgva2tC?=
 =?utf-8?B?YzNNK2phN1NxdXg2bVpiVU9GWjkwZkROY1lvUWFEYUVZKzhiMXZWVUFOVFRh?=
 =?utf-8?B?K3JIU2lBUUN4OGdTUzVzOFZqM1FRWnZmL1ViK3FxbXZZNzRqS255eWJKMVpS?=
 =?utf-8?B?bkROSXk3Yzd2S2JjNTZXakE2R3pBZVRpZU9BRGtCNGdPM0x5aGJNc0svaWN5?=
 =?utf-8?B?Nk91ZEZ2Skl5OVJuV2lTOFh5Rml6T01YSnVqVERxb2txS3RoSGhrNTNJZERp?=
 =?utf-8?B?Z3ppYjlHQStNZUNKTThSb2F4aWdwWjRabWdoMU1NYm5xTG5NeWN0NHhUN2Qw?=
 =?utf-8?B?SnN0a1RmcytUUEcycUdNbmVpN25ieThqckF2ZGdlSUJQTVZmWGlIVE9LaHdy?=
 =?utf-8?B?aVV4NFlnNmRHQWZ5bUtJWnc2b3pmVWltSDloZ1JicFl3WW5WKy9kY1pwZm93?=
 =?utf-8?B?dWc0aVJQMzFNSFR4YWVuWTdydWtzbjdZVW55cm9HYk1XbHVHYVpybW5CQjZB?=
 =?utf-8?B?cHh1SVlvMTdRa1AyeHNmWUgybTM0LzZEZ0VSM3VFOW5QNWV3K1hZNmtmbVJM?=
 =?utf-8?B?S0JCWUNPNVcxMmVocy8zYUJQeHZlQ0hlL2pVNkU1YmR3UGRVY09Nd1VzdGRh?=
 =?utf-8?B?OXY1S3JWejZ6MXhMcmM5WGx1bVllOEhtOWpNdVVITFNLR3JZZjgrWmx0czln?=
 =?utf-8?B?M2I1NE9kWG90NWJoK3QrVERjSnRIaWt1b3ZPMTR2ZTVWb3VNYlVMdUhuMkJt?=
 =?utf-8?B?T01RNWthRVNBMWdOSStuOFJjYXMwaHFwTS9ySzVYUjVaU1JQS1VWdTZnVVRM?=
 =?utf-8?B?MTVNalRaTlJaY3ZhNWxKbU1MVkFqbm95b3RUVTd3eEZNQ1Fyd1hvVVN0VHFp?=
 =?utf-8?B?czlGUkx3ZlF0bG9adWIrbFJ6a01ZdDdLN2hPYmRNS0swNmxGWWtDcSt3c1E3?=
 =?utf-8?B?KzV0UXVzZXlzOXNqWjZvMExmUlM5ZEo5WFI2OEYzWkJ3OGp0MERvQ0VwNlhT?=
 =?utf-8?B?bERuNW1kTFVmRklBZnFNVXlIcDVsNmlMYmJkNXVCL1RDODMwSDJEUVJDVlov?=
 =?utf-8?B?ZXNkclM2Wm51V3AzU3lGdTRmRVpQWnVWSU9QNkJWYTI0TlNKb2U3dXYwb04v?=
 =?utf-8?B?TkNjMDdRVjJLUEQ5U2FwbkQ5OWNqL1hac0ROYVF6VStabXhzNHQ4WFRHN0dF?=
 =?utf-8?B?b1prb2ZiQ2JEWFhQTzZUWTRVRGVxQTIxbmJZSWg2QzZCUVZhOHZuK3U3ZWFq?=
 =?utf-8?B?TjhBbWZUWXk1SGVSTUNYcmdla0Q5TjNEVEIzaG1qaWd5VUxQWUJ2ZlplcTVS?=
 =?utf-8?B?Nks5YlQwWUYrVWkzQ3Y2UWtlKzk4S0EzUmkwem1teW5LME5oaldwekFFMkpH?=
 =?utf-8?B?bjN3bytqWXBnTGwvY0p0bFRVdVRweUhsTXdJeUdobGVyNFlyZXgxMHM5Y1VM?=
 =?utf-8?B?NWorNjNvY2Q2S2czVzZRS1cyR1JqRkErbDdPL0p3ZDBVdkR2VTA2cFJZMFYx?=
 =?utf-8?B?dlp3WXlBS1VYV3ZwbWhSUFBiemE2MFVJSklsMDBIWWxvckwyQ1ZvbW50a01l?=
 =?utf-8?B?ZC9JdTY0Y0NtOU5pYUx3WmtabmE5cUtaTTcwQ0tHcTlVVkpSZmtyb0diSEYz?=
 =?utf-8?B?ckdCSHlTa3A4bkVYZlFuOGpjZ2FIeXFBODNwQmlHSHpOcHlUOUFzeWVVcndL?=
 =?utf-8?B?UFVyU0NGNTFyK2I4QkdWak14Qk1ENzFNb2g5UlBTU1JTMjl2ejRJMjMzak5y?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85c4944-a43f-4b04-51ea-08de2d24043a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:43:04.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImD4EYAbZ2X2WHVAko9TcgGVfQaO8gYFdkDaBFZmVQjIGpQhWXBLhw3Gd4p4HUFu4vqqLN4F4EoWbcO0gdq5CzFuvN/JDfTVJIpTxwHwxsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6779

On 11/18/2025 10:02 AM, Vincent Guittot wrote:
> Add a new entry for S32G PCIe driver.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64b94e6b5a9..bec5d5792a5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
>  F:	drivers/pinctrl/nxp/
>  F:	drivers/rtc/rtc-s32g.c
>  
> +ARM/NXP S32G PCIE CONTROLLER DRIVER
> +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> +R:	NXP S32 Linux Team <s32@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> +F:	drivers/pci/controller/dwc/pcie-nxp-s32g*

Hi Vincent,

Thank you for proposing me as the maintainer for PCIe on S32G.

While I consider myself reasonably experienced with the S32G platform, I
am definitely not a PCIe expert. Therefore, I would prefer Ciprian
Marian Costea (<ciprianmarian.costea@oss.nxp.com>) to maintain this
component, given his expertise in PCIe on S32G.

> +
>  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>  M:	Jan Petrous <jan.petrous@oss.nxp.com>
>  R:	s32@nxp.com


-- 
Regards,
Ghennadi

