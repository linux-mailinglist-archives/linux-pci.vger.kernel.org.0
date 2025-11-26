Return-Path: <linux-pci+bounces-42166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37612C8BCB1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 21:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DD4E2711
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877C340A4C;
	Wed, 26 Nov 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BPEWPXMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0233F38B;
	Wed, 26 Nov 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188294; cv=fail; b=LS0WdVVopo2OC8CsY7/5gMbuGgALyctpbr3IqQ+a4EHGIb1+P7zLuHLvX/PPm8wNM4RzVdRVuUXq8KFIdzI1UFuOoBcR68SURPZu7auV/zmbPKwlvIKpYGquLEqbAbPYrpGlPhkGN1PDv1CjiLu/AYRtjnig5q7hgf1Q2GPIc/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188294; c=relaxed/simple;
	bh=C68HBTgas19TxotUr6AcZef1hJbfZ03LzLy+5psPPvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REY3al7+NVDk0C+byXIvrWlH9pbeQwZxuxzpjhvEDHF+tRpjnsxffCcT/MLxB2YCZlpVR+HQ9wA7OXN6OP86T5igei7FoJSmBCs0dtIgNyCmDIAwNqr0oOoh7ygL7S1hqi10gpIhFg0wLQ9HJafN9YxYq4+jpVOAeF8i3ARhNOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BPEWPXMq; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0d+YsU7YzReMVZ9TA8hzi3c0NcEq/euC0aTfvoj/tylNI1DD178oFAH/GUSAO6eulNkTd5Wuzqul9X6n69eVoVEqYADMaY+/ZEBkD5qXUkBlEYomjYsYSgJGti97Lc2t7Nlmw6TF7bQdBZscZb3q7sZKVFtfMRbHzYRKHqtbLAI+KzU8Lda6c+1jt1zxLoikUfF+vQxn9ZrMqWT3s5/tqnfrZ8yCJa3D+MV/d3vwqkMxktaOO6PTX0LZJ7N+xH/KakwDhOsvfIyuKT133ZHJbEwFisNMrelBeLXc5cvoMySuCItBzbdA9LoL+7G599AJFqeHDLIIa9DPay0POiM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGJQmXHDg08GiowiOL9d1vgAkNP8H5+hRyZ1aeSgEIs=;
 b=EmCMK5AGUHjce7TtaxqxPGH2EDeveiqQv3rl3bi9EReH5Llxfw3gmQeRFufW7dG5Q/s6bv6qbAehUcy26nSftqMctbzS38hXBDa6/CW763MUIGUfqk7gO5a8PWJjpcReHhulp7Sfm3myH5lqrHfj1fHHkyyYKu+s/124S9CjtEmBK4K+NjPyV6oYWLLy8v1lQCL6ytwahPofnSGCE63OX8PCbO1DGBm6m2lhofseuvfe36GC0AhZWBW6NYyXO4+pbvHg3yh36Ev852+B20VeaXhdtEBRK3tqPMJvdZjfPzuTdR8HEzUDBEIGDibvLXhldDlpUz6YD0FwrZte9UFOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGJQmXHDg08GiowiOL9d1vgAkNP8H5+hRyZ1aeSgEIs=;
 b=BPEWPXMqnSc/yu6i0WdMc0iRc7u9WrgpDXsU/bljU2M0Sk6WiznIHlZJ0S4FH6RVmQbjaFZkSEEy7w2LZzyRv2uFfxrhrjnQnKE2HkBTLvQ53oFdcW5YKXVbaeGtxQSPTbkAXIjwlhVAbnCGaTBzJMtywWcWSGdlXoYq9BJikXIjO0NNFA/2yYXEEKjQdWFPT09oD73PWzgh0m7XtKuXjI+DObv8rTAQVXvpzCa5dzxT2WyrzMH/ni7mfLa8m6O3NbvqqffP69vQ4mHuGFu79PRpvz/6dJ0Pxz5R3lL242a3e0uch/njrkGOSCVlswaq0Dr8G58iy59rJWbxCdvcRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 20:18:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9366.012; Wed, 26 Nov 2025
 20:18:07 +0000
Message-ID: <e195f42a-38df-459e-859a-adbc2ad1a66c@oss.nxp.com>
Date: Wed, 26 Nov 2025 14:17:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4 v5] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
 mbrugger@suse.com, s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
 ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Cc: cassel@kernel.org
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-5-vincent.guittot@linaro.org>
 <f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <f38396c7-0605-4876-9ea6-0a179d6577c7@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: deb4fba9-1eb7-43c8-5795-08de2d28e97a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW9JNk9oQzJUYTBNaE1vWklHREJ1WXM5V3loYWM4dDBqUktsL0Z4NHVob0lX?=
 =?utf-8?B?Yzh5cXJXdTFBT0hUZldsMlVCZWdheEptakpWc3FJSmdDMDE2Vjd4Zjk5ak5l?=
 =?utf-8?B?dktyeVpudWs3aUdCRzBpNncxb2MwV1lmRGVFdVN1KzA4RzRUQlZNMW93Tkxj?=
 =?utf-8?B?RWM4L1JEUWtGL3ZiTFVOZGc0b0VoUm43WmM1NUZCbW1kWGVFYlNpVFQrRm5n?=
 =?utf-8?B?TWVVaHNaUCtJZ0ViL3lOL3F3NzhhNkF6SFNUWG1GWFRIRStiaDlOc29uOFRn?=
 =?utf-8?B?aFNyT3lWK1RYaDFtRWFsWDFwQUE0cDFicUpGam9VL25hM0lzUWZYcUpoelFB?=
 =?utf-8?B?dkxwTjBhS28zczkxZHUrRHovRjBaV2lXem9PNWN3T1dhemR4QjJENU5YQVJy?=
 =?utf-8?B?VzVBK09hWk9OblpkbGVmVHAvWlZPWFRUZXFTK2FWZVlKUTE4dUFrNGJQKzlX?=
 =?utf-8?B?OFQrWC9VelU1UWUwRTYvRUdxUWxFTjVtcWh0VlJmQUZoUGRjMEJUbmZKMjVp?=
 =?utf-8?B?bmM0cTI4QlFTSi9RdWlJRjkyY3Z5MkoyblFTOWp6QlFVQXRoUkdKQ1dxNCtI?=
 =?utf-8?B?K1ZsZk1FSVJSMVdqNXk5M0tnb0ZSZU5xZjNNcHYxZDFxeGwzd3pDNk5yRHYv?=
 =?utf-8?B?bXk2ZEM1bElpS2MvMUlkdWdXK0lLMUtveFdxc1o4cWIyRGc4NDE5Z0d6Sm1k?=
 =?utf-8?B?cTU2MTg2QjJnaEtLVUhrWDJackFmcnVHZlFkVmJId0pXWWtaT1UwWHU0K290?=
 =?utf-8?B?K0s5SUtyaDU4K0xaZTk5WmdlZUF0dXVoeDZsWGhRL3RINkJPRkJ2TDJmSjZ5?=
 =?utf-8?B?K1hGNlVNVVNHcE85QU9lRmxmRGNnMnNtbWRHOTlPMzI2ck5xdXIvRTNkQWRY?=
 =?utf-8?B?YnN1aTJSRWdVL3I0K3ByMW5lMlMvaFhsTnE0T21qZy84Szc0TXdmSFd6WFpW?=
 =?utf-8?B?TFltZTFRekNDajFjZ2xERVpqUGIrdTBaN290VXJSZStxOXdOWXJlL1NraDd3?=
 =?utf-8?B?czBad1hpeVQxZnVrSnFnWkhvMUR6Z0kvbU44L3NPTnUyOXVnZzk2aDlGMUta?=
 =?utf-8?B?SXltaThUL2pZWG5NMUx4cTkrVmYyZEMwbm9tODFVeGxqd3dxWi8wRTFSYnBD?=
 =?utf-8?B?dEthcWk2Mkp4SWdOdyt1WWpnMXNsbzhqcFVrd0tGWTFPaFNJSjdoY2RkbVJV?=
 =?utf-8?B?K0tKL2FCRVJNenB5RXJ0U013WjdXRS91UkVub1dsTXdMRHBRT3pMdnFLVno4?=
 =?utf-8?B?dmt3RDBET0VkRWZrN0czN0pUTzRiNSsrNXlkOFpSRmprNXNwMGVQaXoreDVE?=
 =?utf-8?B?aVVKSi9PdDZYeDZBRnY4bGxZUU1IQlRJenprZklXWXNtYnM5dXNMa2l4MDFP?=
 =?utf-8?B?THZMN1FOUGxQMUVhWlYvZ1VjSG1yM09NUGJUWk42UnNqV2ptck5aaCtEbkpa?=
 =?utf-8?B?YTJBNlRCNFUrMm96WllJTXprNGJ6ekZ4MURGNnVLY0oxaGdHckZSaUdMcE5V?=
 =?utf-8?B?N2RiWCszLzlhWDk2VUZWUXZUU1pGR0VOVzhKNDdxbFQ4M3loNlJvSlpkb0dB?=
 =?utf-8?B?QlZwQVorcG9oamQvb1hlL2p2cVhEYkdXQ0lkNHVGNlZOQTM2U0pUNmp0Yklw?=
 =?utf-8?B?UTkwbi9mOW1XVHdGcmVJVFg4a0RiUHBkcGVVTlFoNWI1VUY0V2ZMV1hPVkF5?=
 =?utf-8?B?Wm9LeUlPUHJPTFR2RlE2VDZLNjFxeXVwNi9EQjdWRmx6SjBFeFd5OWg3a0Ux?=
 =?utf-8?B?b3BKWFF1Sk5UQUFTZE82aWgrMWNPNENBK2xWTUdra3lsTWxsNWJEWGo1WEd5?=
 =?utf-8?B?bVhlbXRpZ3VLVzYvUW9pMG5MaFc4Tk50aUYvVVErNDdqdm03ZVQ0T1c2WklS?=
 =?utf-8?B?Tis5TGVNYTg3bWhVNGhTR1BXdGVyODkwVGswK29kWnV5S0RYTXJkdlA0aCti?=
 =?utf-8?B?aG5UYVlrRE9qQVZlRFRVa0VOdHFreFJTNnR4MWM3ck5MeTd3QThKZlhYUnRX?=
 =?utf-8?Q?jbmE5pwd65VWAiyDQ9VGobMPFOWeLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0x6QTNXRWtHWjNhTjFvNkxoVDcycjFDTk5UY0VFSGROeVlseUdoMFpiN2NB?=
 =?utf-8?B?NktnemtURHNYV2p6Ynh5ek9BdHJ0MC9PMWVHdFo0OG90MjRkd1hQUGF5SVJJ?=
 =?utf-8?B?UklXQUk3VXA1UWlMb09IWS96WTRTMVdSdWJXVWpWYUthbGNaN3Y5UlY4UE5U?=
 =?utf-8?B?Sng4RVV1L2x0U3hvZUFDbndTUlkvRUIvM3dlOTdCOWhTbFMwRCtySVlOQ1Z4?=
 =?utf-8?B?YmFMSld0dEJZUUZlcWgxUkZ4WkEzRGZpN2p2cWhiS0pvUWdRSkhaMzZLZGRE?=
 =?utf-8?B?UGpUbFl3T29LMnRvLzhZTXVzK3pMR01wVnpuZUt6U1p0QWYrL0pBNlZDVkt5?=
 =?utf-8?B?ZjBtclNoRjF5Q0djSUwzMDlXNWxNQ1Y0VjMzc3pDejNXcXh4YlEvYk9CUWVp?=
 =?utf-8?B?eXpaTWkxemJaTTg1VUFTYWROTmhGZjY1ZkhYMk9lbjZibnN2dGQyUzgrMEh5?=
 =?utf-8?B?YVBxa3o3T3RhYnpNQVNLUVZiUmQ0L1Q3U3YzcHAzbm1zK3Z3TE9nNGU4Slc3?=
 =?utf-8?B?MDdTdmlETmliZG9XQ1lnem1uYjB0em54YXhTYTY5czlUNWsrMjdaUEhPZmR6?=
 =?utf-8?B?UHUwa0h4eDZSajVEZndxSkQ5MGlZWURDUDJEYkRpbVBnejhLTzh0cGdoMzZC?=
 =?utf-8?B?c2hLN2dabjNaUC9YVUxoMmZpeE00L0U0SGc0QXBNajZ4ZHg1Y1BiMERIYUla?=
 =?utf-8?B?MWtpWFFiY0NJUUxQT21hZjIzUzhGV1IxOHJ5ckdzQnlMa1dsZ3FaN2ZYMVUx?=
 =?utf-8?B?SXA4c1U5dEhlZnRuNjZXSlpqbno5VThFQWwrNDFxcTZva2hXVHJNY2N3dVpj?=
 =?utf-8?B?YlhQU0syWU5OV3hDcFZKZUg3N2tvSzhGWTBmTzlKQUJ5L0xVMEZISmF2L3pL?=
 =?utf-8?B?Z2w5RTRWejR0bTVGcTMxYU1aa0FyQmVwL2JadDBNaFFGbFg4aGhLZURHdE01?=
 =?utf-8?B?R2M2WkczTTVuTVBScWJDWDBCNWRneGhUMTdaQmwzdll5TThRZk9LVHdoRkl1?=
 =?utf-8?B?QU5oVjdKL3pwakUzSXZibmhyaSs3anZxaTAxR05BUzFJc21XOC90dTFzVTFx?=
 =?utf-8?B?UlZNY1lDVjlWbFN3K09aaHpBNzh2ekppbmRXRm1XbjU1djN5QXFRYjFzbW1T?=
 =?utf-8?B?YlBCMHBDYVNmcmJoVHlqcG5qMnpHZE5aVTlaMmwwSGYxVXBGVEloTmFGY09Z?=
 =?utf-8?B?VUxsaUFBaXEyUlQ2ck5PREpQc3hITEJBVFV2MFFjdXhMM1MzKzFQRm5vRXFM?=
 =?utf-8?B?WGJyUkFORE1GUUpUbWJ1WnRncU5ROVFIUlVDb3VXSHRsY1RISTE2b29VeHpK?=
 =?utf-8?B?ZGRFYXJaQk5XYnVRbXFNaVprOW03SjRlRkN1SEtidzFvZWRuOGNJcjU4ODFm?=
 =?utf-8?B?VXVPdlpvQlFvc3gvQjVlajZDd3Jsd1FFb01jZ1ZyOWZMYi9UZUdCSE9TaFRp?=
 =?utf-8?B?WE8zek1KWjRmSDRNbTRITlFLMmp5RkxMSzV2UUZ0cEtvb0w4c2J0a3VQajlJ?=
 =?utf-8?B?dGh1MUlUSisvSytDUlJwQ0VpQi91QWJMZnFuL3M2RG4rZFFZdE1GeTBJR0s4?=
 =?utf-8?B?djh5VzBEVWhCNzVyVWVyMmgrTUVxb2NrSnNqK1NLNWhsb0xuTXJxVmhWWDdv?=
 =?utf-8?B?MkRmRmtuVzB1YWV4UllXZ0prVzR6aEJIVklJZ05RVStWaTdWZ3NDdks1NnAw?=
 =?utf-8?B?SGwxUGxTNTI0VG9FcGlEci8zME5wdTN3ZmUwM2h1WnMyTlBLMnlCRTZBTTUx?=
 =?utf-8?B?aGtNTklvQWk0UnhhK2dPZkw5UGhFRmd3TkZ3YWh2c0U4WXo0NlkrT0Q4eDZ1?=
 =?utf-8?B?bzVPNVdHRHUwTzQzVTBiRjROOVl0K21UOGhZMnB0Ykx5WElpaTJPVnlBVlYz?=
 =?utf-8?B?SEsxbWY1dWpweTJSVGgrUXVaUDU0YVIwTHp3MzBwYWhXbDQ2VzRPNGNmTVdv?=
 =?utf-8?B?Q0J2YTR6Y0FybXlSL1dqSzRSNVd6TmhOdmgzSEZ2ZlRqOVhCcHJPaVBuYlBz?=
 =?utf-8?B?bzRUZERvVHlPY2hma1NUMC9wYUNEK2hZZVFGZlJrL0RVRTkwbEl5UDZKRkRo?=
 =?utf-8?B?TE96TjZrUEhtV0hlMWl1WkRLUWNsM21IN2tTUDVsQ1VMQTFRcEsvNU9pcjMr?=
 =?utf-8?B?WElaMkxHL2swREVNU1BSK2RRVEJvNUEyckYxcWFCQSt0R0dLQ1ZaTm0wUDhQ?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb4fba9-1eb7-43c8-5795-08de2d28e97a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 20:18:07.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmRKCyZHxEuaXekOPeHqquMdivY4EOC/8gBL47PMVNjVCa7CaOaCOeDU0KR2kGwcBLb0ENUg6m1iIh95BSdCczLXQ5JIpZ1XAC6K1zioxPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479

On 11/26/2025 1:42 PM, Ghennadi Procopciuc wrote:
> On 11/18/2025 10:02 AM, Vincent Guittot wrote:
>> Add a new entry for S32G PCIe driver.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e64b94e6b5a9..bec5d5792a5f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
>>   F:	drivers/pinctrl/nxp/
>>   F:	drivers/rtc/rtc-s32g.c
>>   
>> +ARM/NXP S32G PCIE CONTROLLER DRIVER
>> +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>> +R:	NXP S32 Linux Team <s32@nxp.com>
>> +L:	imx@lists.linux.dev
>> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
>> +F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
> 
> Hi Vincent,
> 
> Thank you for proposing me as the maintainer for PCIe on S32G.
> 
> While I consider myself reasonably experienced with the S32G platform, I
> am definitely not a PCIe expert. Therefore, I would prefer Ciprian
> Marian Costea (<ciprianmarian.costea@oss.nxp.com>) to maintain this
> component, given his expertise in PCIe on S32G.
> 

Hello Ghennadi and Vincent,

I am ok with Ghennadi's proposal.


Thanks,
Ciprian

>> +
>>   ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>>   M:	Jan Petrous <jan.petrous@oss.nxp.com>
>>   R:	s32@nxp.com
> 
> 


