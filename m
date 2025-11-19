Return-Path: <linux-pci+bounces-41649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD458C6F9E8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DAD24EFCB2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D42D24B4;
	Wed, 19 Nov 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EAs2POBt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443C286D73;
	Wed, 19 Nov 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565277; cv=fail; b=LgMfHsKD7Q/BoVUwt41NZZ160PTFAlwaxJZ9FSZ3PtItZ6vS0aU1rt4AuIwKAF+uC8ZVGipTHoJEh29ihkeBpatvzucG5M3y3d+23+Nfzep08TB/nuqXfH7Cj5EQ4ppKLRZ6VutmKN7QnBSVLdaWW1vHV/fzkWWmDmmI5s7clc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565277; c=relaxed/simple;
	bh=QtG5EkuvX3zXSnQhcCw/BqvI9Bkw6WKEEm5J8qVrxM8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Jl4sBmg9O5kLdk0L5qgwm4lN+M6BnFADzdX1N34j2+O0Ur3dWu/8o9wUoSnjV7vrVxQlvtYoYVYCqHQ/3+N4nFB5VSCFGvuiHCe7laXNyA/bAjTZ8+qdwhi8RtAr4XaM20B/Xm16B20jcWBUDF0NhW6RBTIo4/dI2QHOqJcN+FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EAs2POBt; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJF5s2l2649415;
	Wed, 19 Nov 2025 16:13:52 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4agraunwq1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 16:13:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jan4odkiMhQDrnSWQ8hsZE5KyT48TmUdRCOVk7B9k/+3w+gOF/F4Iqo2mgXPN0uEihteCkCuuTkPEAkZ8/kyzMJrJC1eZcoTsiD9SsFNAj13dZme86w5IznVBi9wrLLZ18MvoogPAzfi7qGzz0M2jKtmJysJyCbMztHR1QFqZW/ZkCy+x38MB9nAJHBQdiy/Kc+r43OfvQyTlV1VUmpsaaclzpaGPufEzCw34As3fKC3q6L8QMRodTTYXjT5wsQacUPb5dwYHbkEjJqhsVQZAX3gWsQTpdrWNzrI7SBoqBeCOvg1Q1C15QVAXHiYgTVqhjEvM9/yM/TBeesGgckWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blS/IAHVW455RioE1lmnr5QIeylw6cRgssNUOnNA8m8=;
 b=Nrv+Gl+41X/VfoYrwdveRxnzNpPa4bg8H2SM2a6i3tXV0F9oLFrZ9PVAcC2J2CJlhZ8AiNN7Zh86qO6H7WVJum+HToflvW33IeGz6xiskcHc3XFNk3ibXNWNR8KBKtR+/L7x1aJGznXPiS+ez7/z76chGdFdAwLEmYH1LtotSW6vrca/w8rf0Lb/jKgHm415XvawxfnX4kabq6GwPc4gBMMmdQwLQpGhf3t1pDzOVtTNyvm27MeAE39qLuDWaSigWRQeHetdtcwORQxwE9Qu3U4ZbXiCqL0dGMCnEMd15m0IrxFZtRru4RdCi9IWP9YaOFXg2AQNYYpTOB11PGXbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blS/IAHVW455RioE1lmnr5QIeylw6cRgssNUOnNA8m8=;
 b=EAs2POBtfQLxQUt96TmPvejx6R/pNR21V+ckW+m9XwzIEU7wCpgs/M/uTIWIvWZm/LTw1XCDYm3aEc9wvmp7dzZeSawfV4IhBqmTN/5Qv8locslxXs0n2lSq5kcFUeeDQt4tMpeQ084HC1J6V1oOmLzts3fkHZk3OJCoIzqnX5xH6gT4cw/dkRurhImh9jSc3om6YjmIdw9IiEgFb9e/jBymqgHcIl1Onxm4KHirDmxxJ+vIg/xUjfSHEiVxQkhjMNdoC5W+JteamrOsAFODTfyBYjk7luQVXvxMzUwLCRpgj9Y6zXDIcPv/94Fj8NILxEKtFrRKhWarxzBemxZdQA==
Received: from AS4P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::10)
 by PA2PR10MB9136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:13:50 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::fb) by AS4P250CA0009.outlook.office365.com
 (2603:10a6:20b:5df::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:13:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 16:14:13 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 16:13:49 +0100
Message-ID: <7053f336-59c9-47cc-ac97-eb2f0916ac4f@foss.st.com>
Date: Wed, 19 Nov 2025 16:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH] PCI: stm32: Fix LTSSM EP race with start link.
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Lukas Wunner" <lukas@wunner.de>
References: <20251118212818.GA2591668@bhelgaas>
Content-Language: en-US
In-Reply-To: <20251118212818.GA2591668@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|PA2PR10MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dc7ddb-c9ef-483c-193f-08de277e3ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NENRMml5RzRjYWNBK00yTURRVCttTExVc1pPbWNLV2lGUVMwUFFXUTE2REE4?=
 =?utf-8?B?U3M1YkJFaThzVUpORHhvakNZVWQzZ3NrelpjVjVDNS96YXFId1pFWngxTnJa?=
 =?utf-8?B?S1NFM2RDL3l0eHE4VXhiT0txWEZnc25Nb3hHOU5IUjVsSDFzSnFDb2ZQbWNB?=
 =?utf-8?B?RWMrQVVwU0JoQ0U4Y1djMzBQRHZiVk11VVRra21CcnBna0NhQ1dnSmRLZ0dq?=
 =?utf-8?B?RlRNRVh0NVpHNVBoRDlqSVk1L3NYTG9XUDlXMmtTRmlDRU8rLzdjWndmL2tv?=
 =?utf-8?B?YVh6bVdyTE5NU3R2S29iZTNueFk3QU85V0NmVERtSER3VzNPYk4wY0dVanJR?=
 =?utf-8?B?cGVSUCtGdmY5MU9IZ1BpVGNGYVg5M2JYVFcwcmNGVzZDTGNhamhOYVczY2hu?=
 =?utf-8?B?RkRsZlE5dzAwd256TzFraUJOcnc5Tmo0UEpGTnR6UEdDaFdQYWdwWEkzc0Jl?=
 =?utf-8?B?dmg0b2hnME5OanEzTlZxYVBvMXdYK3o4ZlU1dTM3TTYveW9sczVKcW9hRUg0?=
 =?utf-8?B?a0hwQ1lsSUNpc3Y0azY2cUpMVUdVa09sN0RZQWtJYW5MeXk0b09Xa0RPUkFN?=
 =?utf-8?B?QmovVDRlNEpyRVpQVHpERHdFdWw1UXJRRjhGeVJPZ3B0NlF2UW9ObGd6bWZo?=
 =?utf-8?B?NktubE5HeEc1QUcyejFaZktCV1FYcytIMVUxOE9waGF0WXJyN2xCeEVaSmdO?=
 =?utf-8?B?NzhlU0FGM0FZOXYzWk91R0phQ2pnZzhxMGZSTHVZN1BSOG1EcFNLaHJ2THo4?=
 =?utf-8?B?Q0hqYWJ1RHZTNXJHN1FsWE5aVkF5a3V1WFFoYXpYN1lkWFhiOW9PR1RNNTZl?=
 =?utf-8?B?UUsveUVpYldjVWNkRXFFNEZrTllXQXc0TzJ4YVJ4Y0RrdXNKSnl5RHU0VlBK?=
 =?utf-8?B?SGlGRUt6NTY0RnJMZlJTRzV5WVo1eFlLcm8yblk4aWQ3eXJFdFM2VW9jU2lo?=
 =?utf-8?B?eFR6MFl4alBSVTJjZndjWFk2T0tXcFNtSEFHdTJlOG5maG5CV3VYdUJCS0l6?=
 =?utf-8?B?OWNRVTU1Tm82MVF0WTNWOGF5RXJWcXJHclQxZVJTa0c3dXhUc0NmQ2FWMktn?=
 =?utf-8?B?QVVGQUtON1VFOHE2RmVVQUxDU0M4aVNPNTBudldlalFQd3VYc280SldlUkNa?=
 =?utf-8?B?NUt1UkpBMEVDbXpHMUZaRHVzcGN3TGVuNWZobXlHQjBteCs4cWViNFBpb0dW?=
 =?utf-8?B?OXo2S2dxWDR6YVVZUFRrYmQzc29nVnBCbTZ1ZGNQdnVxeFdobFpjVTBjWkVl?=
 =?utf-8?B?QzNqWnhhV0dlQmJVRmZwSkJmWUdyM3RNK0NGUlFZQmxUek5TaTBveVNkVC9V?=
 =?utf-8?B?MkxFZWl2VFNhWEh1MTg5QVJISTNpNzlPZHFLRFJtQjEwTDRTakl1NFIxUVh3?=
 =?utf-8?B?SGJ4eHFLRHA5TTEzU2xWcUNyejZSdGFVNDg2MmhUVlB3WEZtcDZUZldwaGdQ?=
 =?utf-8?B?S2xxMC9KQXJnRnBSeXBielYvbU5NcUh2WWVGbUJZTlR5VW5sSUxvQnJpMkQ2?=
 =?utf-8?B?V3RwT0gzL2N5ZVhQV25VWk1ZNzA1TEl2MU1EcUNSdUVUS3Zzd1JESDh6Mjdz?=
 =?utf-8?B?NFJmQmF1bER2RHhueWZzSG1RWnBTNDEybDZaRm9zdWtsTkZETStseTZzNUN0?=
 =?utf-8?B?WWFnMG9Pem1yTWk1MXlPSVRWcWJRdmY0MkZUYWh0OFVQZ2VyTTBMQWFnWlpy?=
 =?utf-8?B?b1pINGd6U2ptaENpcWJtcVI4M2Qyb3VJYW90b0VHcEx6dTFSL29ZVTJTaVFv?=
 =?utf-8?B?UzVPNHRqYVJVNEdYK013U091a0FtbGwyWnlndnFOQ1ZnSlZjR2xNbHZWWG9D?=
 =?utf-8?B?UkFEV2JrYWcrMlNoSjUxZlQvTHgyNmxYMzBnZk1FR0NTbkZjYUVlMHcxeHpv?=
 =?utf-8?B?VWNMeEs0aWtZZDFpYkY0RFdickxGVXVOMmg1NFBteGNUQ2pDQktxMjlwdUxM?=
 =?utf-8?B?VzFqaTRrQzFzNkVTRURSZE1CcWwzVnpPeUtoNDd0VlJma3E5L1RHREdMemxu?=
 =?utf-8?B?TmV1TmZzRndxUkhKUFJwanpNY0Iwdzh3aHZRM2svNmFiaE1sN1ZyLzRKSzdW?=
 =?utf-8?B?RlRrMjdQdzRqSnZic2VvRHFtTld2YlpaTlZMRk5Dek0rdSt2MEc0YmJNWkRj?=
 =?utf-8?Q?PBjk=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:13:50.2467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dc7ddb-c9ef-483c-193f-08de277e3ea1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9136
X-Authority-Analysis: v=2.4 cv=G5AR0tk5 c=1 sm=1 tr=0 ts=691ddeb0 cx=c_pps
 a=o7m/8ZaAYAq52IfthuuB6w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xweDTYjZfx63Hl81KSYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: D6I8txULADiYh60UkT1OwtZpRKLEdxRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMiBTYWx0ZWRfX07KOckfBIZ2n
 CLymR3sIJSo6H1GDRYnbhJfzOx+zsSZrUJ5FQaV3xG3Hc9BJK/KTu2FRYxORlgHSnktTTTnk8VZ
 ylWBzp6yhIikN30dzueEtx9wx6usXsZRa85u47vs6uZJ38BovqR7YHIcjMfuqLw8zWrIUdkRr4s
 hHpm9fgcS4cibObPUT60n+PlDj0x6BFsND+IRWLqTx8qjc8uris73aMqo8ooWaN4tVVYp+BXiwP
 2Q8rDPPPHTOufqQmzTQmDfBz8+TIoo1B/q6FOPc1MqdqcilhWn+mAYRJG8Wt0ReJ+C8nCBx0eDk
 FabklofWz6dlJdmr+zq4y/Z0P3LrBZTF9N+AXTsLqNEGpKRFxG/JolP0Al5ElBChGl16hrG94HB
 66niSFuayi6wEfk6FYJAqSgIWBaE7Q==
X-Proofpoint-GUID: D6I8txULADiYh60UkT1OwtZpRKLEdxRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190122



On 11/18/25 22:28, Bjorn Helgaas wrote:
> [+cc Lukas in case I got the pciehp part wrong]
> 

> 
> To back up here, I'm trying to understand the race.
> 
> IIUC the relevant events are link training and register init.  In the
> current stm32 EP driver, link training can start when the EP userspace
> writes to the 'start' configfs file.  And the register init happens
> when stm32_pcie_ep_perst_irq_thread() calls
> dw_pcie_ep_init_registers().
> 
> So I guess the problem is when the EP userspace enables the LTSSM
> before the host deasserts PERST#?  And the link train may complete
> before stm32_pcie_ep_perst_irq_thread() runs?

The sequence also violated the spec (4.0, Section 6.6.1 "Conventional 
Reset"), because it allowed the endpoint to enter the Detect state 
before PERST# is deasserted

> 
> And the fix here is to delay enabling the EP LTSSM until after
> stm32_pcie_perst_deassert() calls dw_pcie_ep_init_registers()?
> 

> 
> I think we would prefer if the host would enumerate the endpoint
> whenever the endpoint becomes ready, even if that is after the host's
> initial enumeration, but I guess that's only possible if the host is
> notified when the link comes up.
> 
> The main mechanism for that is hotplug, i.e., pciehp handles presence
> detect and link layer state changed events, both of which are managed
> by the PCIe Slot register set.  Those registers are optional and may
> not be implemented, e.g., if a Root Port is connected to a
> system-integrated device.
> 
> But if they *are* implemented, I hope that pciehp makes it so no user
> intervention on the host side is required.
>


I suppose that hotplug cannot be implemented without some kind of 
presence detection signal from the EP (PRSNT#, ...) ? For now we have no 
  implementation to support this (from gpio or other).

However, using a PC host, I observe that when I resume the host from 
PCIe autosuspend, for example, with 'lspci', PERST# is deasserted, and 
the stm32 PCIe EP device is correctly enumerated without a manual 
rescan. So thanks to power management, a device can be enumerated 
asynchronously but when requested, not when ready.








