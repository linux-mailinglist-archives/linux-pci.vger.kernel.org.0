Return-Path: <linux-pci+bounces-41229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A704C5C5BC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1C2235AB98
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2053090E2;
	Fri, 14 Nov 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cwdiEFfN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54431308F16;
	Fri, 14 Nov 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113169; cv=fail; b=ovvHUfNlfZKndyZZHWWdbFSQ7ER9X9Qsto9XcRUDFJm+cXsaOzDqbixGDXrq+dw4emjB629vr9FIvpf2MH9thnUDU82HV1ZP91ZFi6ZN+iNbsDW48MnuclfRk+NO7Kn9rlSYNlT0UXYHuSP8ATIqCYUbUqAopKyuaaKi07lpZz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113169; c=relaxed/simple;
	bh=ogBCCg+Q+Z6K9H7uVD0nRcSqkygXMbn6UnA/ZY5+1N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QF0M070XlAA1k0NE5v7Zl2lz/0Gi76wpf5WWZGZpH8+hZFzG3Cv2TpvHHB8AdJv+qx5PrKaX4iWqiRnzf1RrHjHyhebwOHqAXcgmCT5TtzIK5VwM4ifvbC/sU+lpLAzQ51iG2EmRWJM4dKINB5fvhW6L8ewBLyUUGDVJcmZbgM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cwdiEFfN; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE9ESiF1874939;
	Fri, 14 Nov 2025 10:39:08 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7pa94y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 10:39:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE4LhXc8Be90VSv6m0LJgepAKF43MogsfZX1w3vKn4Vvynbrkeh9callYsonu05U9i4U+1D0OhQUCmAhcrRyBcrFJAmySGExnEg1xRVrKSdzecXxxVf+u3CGTRDLMa4HGF7aulT00kjeBlGLcU3LzCrY9ViNoeYp2hnpLma6viqm9k4XTTUOdl4gklcfrMtW4JV7mNQD1D93VUTtpwP44EqOilIHaCDq+G1QRjzCJBU2OKN78li3Xa0EJkW45WCfTulxnxH7XmZ8ZqzDxCRDntQZthRD/tcagOsYej/GP2jDS362pZVdqsE51o82KNCeYK303DoL6dcBMspC5jjIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHTrIA/ZZhz+Ue+PTBDziXRfTQLjO5Bl47i4ax8PxhE=;
 b=jv3v7jjU/9xEeSTICFM89K/+nINUjlBsA9TAHviyB6sd8DEkeK32CM3NQTHZK8L3cF9DKiJ/abVexPasuRu03N221r2oZcVj0j4IMooknV6x5oEQm42YQAvRUVocNaWd93NXrsQKPaByAMOgYCmmVDJcm5hPZlqmAeb0vth6RpDO2OXwdZEe5oyClG/vmWVbHhFP2tkshjTiPc0jHZx9uhxHNJSo8ri/b8+1cXI7qoZKajlLRWXxVFUhrY5pHNMJ+pz+wORyYp8Cr67cmpxP0I6snty0NdrseSd76tzCzb/p9/CEeJM1cd48F9BBkz1E2hHNtM0BF7ZKQ3rvjazahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHTrIA/ZZhz+Ue+PTBDziXRfTQLjO5Bl47i4ax8PxhE=;
 b=cwdiEFfN3jRYmL3EuVIEAp8vM5scv9dk/pcybUKIGfpoMUJkI2fIC39+sXX25PTD7z9fnV0EuZBwfqAOM/+FMx16+u4ZtMKHEgoMqhQkjM3DawiEbSsTzGOQCXGnJ531M4nBqo8kaCkUKf7j/Me3/tzQLB24HLP4v8RB6CAlY1CSmOIJPBGJibVUcxN/+uh/3b4dZ083md86G8g0vpgh+x2xIxboD1i7mhhysbmsDI1MXKrTojigChBpQiD5rYPT5pEu1d2j9c9jw74gSXfYBOLVmTZryzGr3U7bkLKn0Qjaf8/caMQr84z843AG3Tw0E6BJn9kZarUvL196IwtqeQ==
Received: from AS4P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::13)
 by VI0PR10MB9217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:39:05 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::b8) by AS4P191CA0022.outlook.office365.com
 (2603:10a6:20b:5d9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 09:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:39:04 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 10:37:34 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 10:37:21 +0100
Message-ID: <ba695c7d-32fa-4412-9029-26d9a0e73b11@foss.st.com>
Date: Fri, 14 Nov 2025 10:37:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] PCI: stm32-ep: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>
References: <20251112085620.1452826-1-andriy.shevchenko@linux.intel.com>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20251112085620.1452826-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|VI0PR10MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b8f2e2-9a1f-41a8-cba4-08de2361a644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dldvZjVMdnNLbkxpWDRaVllXbGxMOEdMdnlNQjNkdmxiYUxOQ3pvTFp2TTIx?=
 =?utf-8?B?SFQ5NlRxSG9hOHJHSW4vblgrdXZubHNDQXo4UCt4QmhSTXlGV0ZPK2RxN1U3?=
 =?utf-8?B?dlRNZk9yTXVwM1VxOC9lM3BYSXc2N1gybnZ4R3hJVmFiMHNDd0hXNE9BWS9o?=
 =?utf-8?B?SENYblVBaXkrZ2VhbVZpb0V3Z0hqblNEdERpZGRvRGtjSFJxaXkzN21UR256?=
 =?utf-8?B?bGh2cis5a21hdDc1N1ViSExQY2R3SFBFenc4V2hybzNQYmhjZUM5cnppQ1M5?=
 =?utf-8?B?elF3b0RQWUk3aUV3YmdNTmdVYzBLZWJrWTFGbk1lb0F4RXJ5VFZGckJUZDEy?=
 =?utf-8?B?ZjZJN3Y5UjNEcVI5bEkycDBZZEV2WDdoMHcvREtxeTJpSEhsRElsV2JJcEsy?=
 =?utf-8?B?ZXV1bUFsNFM1MUtlUE1ta3VIR0x5QmNYWVVjVTJ0WnhyNkV3WUYveDI1NHFC?=
 =?utf-8?B?L1VyeU82OWdOUUV0ekY1Z01CejBvSWx4Wm13Snp4bEdwNHhqekloeitUTitu?=
 =?utf-8?B?RTcvWS9OSjZ5SUdobEVVUlVaMzd6WnV0L2tpN045YUlhNjJuS3M5VU9FRXA5?=
 =?utf-8?B?UFhNRDBLWUs1UTJCZEx3YkF3MmRDTzY1NzdneDdBZmpOS0ZUVjYvSnFMU3Av?=
 =?utf-8?B?OWErRk5vQ0lQQzlXMURtbHBTREJVWTg0UXg5WWpWaG5YeWtJZjA4TWZkRGl3?=
 =?utf-8?B?R2pHQkdBN052TFhwN2ZJT2JWMXRkSnVCamFqWjhtbHc3VlFJWHhLV1pnRjF6?=
 =?utf-8?B?eFArNEpDK3V3R09aaXpMTTcrdU1keUIvdGNHRVhZQ1VRUzlzUWJKTVVKenlC?=
 =?utf-8?B?d3hFTWxzaWlFdElFcWxLU0tMYk5DNnBvV0ZVS1FPQXQ3STdxOWJlbndYZzFX?=
 =?utf-8?B?YWxSQkdYemY1WG1wNGhJdVNxazAramJUazVWQ01nSlhlWEMyeFNDaE4yKzNW?=
 =?utf-8?B?aHkvY3BDa2hoaHFwRUxwNXduQktzMXdIU3MvcXM3OUlkV0NlclkxK3pMRVVa?=
 =?utf-8?B?OUM1L2t5VjBtS3VrRUJKY0Uxd1FkRGpVelZiVk9MeGVFWEsxUGlhMmVsQitD?=
 =?utf-8?B?Z1hGVkpKTWVXNktCK3dtT1RoWloyb0JIYnR6WFZCL0FpSW52Tm1yLzNSUkgy?=
 =?utf-8?B?WnlJemxNZXRYbk90NlF5MEJ6WHV0UHlNZGJhbUp3UFlwU0ZGY1N4Y3dvVE1w?=
 =?utf-8?B?NGhoZUJpbEpScVFGU3l2MS9wZUF2Y0laR1hDTnRQSUxwKzloa2hyZmZDKzBq?=
 =?utf-8?B?aG9DUkdBZjNxa3RSWDhwZmlxNmJwaEwxR2ZCcm9pa0p0S3ljb3NoZmpJUzVH?=
 =?utf-8?B?YXRCazBObTdvWndPTUxlVVhWYXd2L1kvVERaOTZPT0FoejlBdFhCc0FFOVdU?=
 =?utf-8?B?TE44N1JyZ1ZuOFlpcllEMW5kNkZmQlRnMUdlWVBDeS9lejZmam9tK1NlL2FZ?=
 =?utf-8?B?a3crdUVhZHI0WE1MYmREb2RldUR5WWM1bHpUdWYvVVlHeXVmdnQ2cjFrV3hJ?=
 =?utf-8?B?d21UVFRzeng2aEhkLy9pZnpYNXk5NFRaVWJTcmNZVmlDaHpSYUFCbUxXRVFJ?=
 =?utf-8?B?OTZJK0tITEJCclBXMTdMWUR1R2N4VXJFZnZvaktmME50Njk5TW9RRGc0YVl3?=
 =?utf-8?B?cFhKV1cxbWhOS0N3cVN2V3RCbUcyOGFwOUlURmNPR0YvVXpCcmE2RFIwQ3pM?=
 =?utf-8?B?c2lzaVpwaUt0V3hhbEJUbHFmN1AzSW9vdURxOXRpZExBdW1IZTdTNHN3dWhY?=
 =?utf-8?B?L3o3RFY1KzV3T1BocDY1VXdRYWZoWlRaK3N2OHgzL0dOQ3RGWGdIMGx6SEh1?=
 =?utf-8?B?VjRyQ0xvWFA3Sk5BdVF1R0JXK0hXekg3NXZwaHRwbXJmM050UUM4MHpqYkNK?=
 =?utf-8?B?ODF6d3RhaHBWUmVEOHFFbEwvVERiQ1RHakpBNzFqTUFObzRLT0xOR0VVbi9u?=
 =?utf-8?B?RnZtUTF4NWtBVXRpODlCNk1GTktOY2tmcVdEb21lSElXQlpuL2hKRFdYMEZm?=
 =?utf-8?B?VWVIUmtyVmdOTm5uTWtkMGFveitaSlpHbWQ5RitQTXU4aUwwVHBMNENtV0F5?=
 =?utf-8?B?MFhKTDBtdDkvRFlpOUxkMFNMOFNic3FHUmMxbGlqSXdzL2hCVnVFMFFVWUhx?=
 =?utf-8?Q?15nA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:39:04.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b8f2e2-9a1f-41a8-cba4-08de2361a644
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9217
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA3NiBTYWx0ZWRfX8eXVla5eh7v2
 fhog8TagOSRqSxdzawWrqicR9WFg5J+XelM8Uz+mFKNSf0DYQ3us5wLCtwrxhng0Zuz8tLtn/+9
 nDSaRbrYuEI1ehRXOqpV/dqtDK3aABYcY4yNvNCGQdN6zVGduL1L7VRMyjtUK3ou2RmeVOoJiXU
 m3nemjpIvzJfhH7Ngjewk8Gs7ivDNbEk1DCgrVkHkvMfYAQ/RE6hOV/wY2MkvA+/yyKXpHKXq2y
 Cqw4+uYU1xSEK33/liWdRuxV0oTcUeGr1W1acOCx0NvbsIp5NfKQQBTLUr9WJffshAz5KqUoDPM
 gdrWvbwgZBaRGcGXQovnIXRAUPwg/ppAefIEEBZk+nTXHFNXJGFGhS8t/3Wex7xSbvhDOGtpNGe
 99lRaTWgy5KnsuCIVOgqWvtXX6ytEg==
X-Authority-Analysis: v=2.4 cv=avi/yCZV c=1 sm=1 tr=0 ts=6916f8bc cx=c_pps
 a=BZvBpOJ3R6NwyQWCxJuAzg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=X7L7FT1YXr2pfEN7NscA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: 63urpa-oYLNSOuFfXw_m2QZ6F-BZ6N73
X-Proofpoint-GUID: 63urpa-oYLNSOuFfXw_m2QZ6F-BZ6N73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140076

Hello,

On 11/12/25 09:56, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> In this case replace of_gpio.h, which is subject to remove by the GPIOLIB
> subsystem, with the respective headers that are being used by the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pci/controller/dwc/pcie-stm32-ep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> index 3400c7cd2d88..2b9b451306fc 100644
> --- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> @@ -7,9 +7,9 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/of_platform.h>
> -#include <linux/of_gpio.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>

<linux/gpio/consumer.h> is already included from pcie-designware.h

However, if it is still required for IWYU, could you kindly include it 
in pcie-stm32.c as well while you are working on it?

Thank you very much

Christian

