Return-Path: <linux-pci+bounces-41522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B64C6B3B7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4BD4E4514
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B08A2DC79B;
	Tue, 18 Nov 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UJ55nrRs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6A2DBF48;
	Tue, 18 Nov 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490884; cv=fail; b=iNEJUA+Y3MlgpmSzIEriQ9xo4B4r87FrVgTZuvA4n6brqmu8yOcrMh20TEMTJw3Nrc23Hfg1Cp4xvacQ5GznRFAVO6zcXOkUGDpNQS79kY1fm1yBrKTFXU4eIIQzVBqwhB3AgCzhH0DbBy4CYXOla5FIjpID99G8fDIUbcDrGv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490884; c=relaxed/simple;
	bh=N/tjCxik1upotQfirneOtD5/CHTXkIfthKbYZZ+RoQg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NgPuVNi/65UZJBK+01AzhHLvh7alezGe/GeHzkdeTOEcR8NiCqwgqJXE9/gso0eD11kjs2HOkxbEkeuspZKjQXC9J8Kn4lxpzlTCnTJqe/eUH2hrLWv7q5lGJvS4Ew+pHNVuBUiFAk7rnUeVnog2fDZhcY4mUm3pGr1BLspGwis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UJ55nrRs; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIIUKcX356267;
	Tue, 18 Nov 2025 19:34:11 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4agvrb08g7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 19:34:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/5PB8aoOX/EJNLbWtvoTEQCg3L4P8xGZ96jP0zeciZBgeYNHYYD7TOecnYqDqXBWQYI5Qb7mYOMpYP85zY5XOkWT73yrB+Qmbmm+G8O7zSOHz8y4DTjk4g6bq3OWt2ukd6xDQPL2mji4ptuyjSZ8Gtb2drkFY1HHwKHOGkJ4IdtOnukjs3exYoGv4ntEp7jjM87jQ8nPVu9Zs5S/UWeLhLhaXwvkJEWMtDngmdFUUhiB/Yd0ha0bKbNJE7TpFn8MC1gwJIHoFq/rkvbumQUdCC+oBvEA2s9SKGfeDuD4DwC0RxDWsF7gyYFinbKa+SOKwkbSfUw9hXDur/Yrp3cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqoeLXGEX3+IlWwbAZ3PUIrXrsPc6VkDNi4BisPvHis=;
 b=eSbwhJAGnuEQ9ZeJMIRXSv0DX6csTsUIiXnIUfjjfy3ZC9FB4LPQ7jqe5ZrAMMv+yIH7rzA8Ms/pkvZObW9FwSit5PI9/LduVwgv6kL/KZhMRBSjMS2YHLz+8IS0a9918qcV720tbAHxTa5wNKQ7/+koBf2BVOZaXE924xztQ0oegIBNDwJouRR8hNNBw4tMhe1ThxrPKdVWYXxKQQFRfySEkv/XfAnq7kDYY8ep9LTWuY5l7dTQ92AJuEpKz4jepOckBGVIkVPw89GEg7YULzvjzJemmVQO0UHm9Kz8OtcDpN3dUN/l8mb6WX5GYxfa7QSsHMh9HGJEmygXv9j1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqoeLXGEX3+IlWwbAZ3PUIrXrsPc6VkDNi4BisPvHis=;
 b=UJ55nrRsrzJbZZPy0SEq/aun2btIVfSE+1F2uVcdxGRImZxOAKoTCXUTMjWLieWxQMHzXFvXBCERRKGAemfb8nveBtyLM4PTzf1aRwGBn4hvxrZqqBQXrV8qixOelFnqxdoAKwIYcp7ok3Wj3FwaAfpdYXdyYK4dirjawGfQYCZ9pn0BIBSORWoL1P99KJUQfOAOVLdekO/n5qrZ84D11R7YgTgdv5DNXduNwK4e6X7n/QBAtoV5wUbRZ7qkbNujxGj5FNVM9VCT8Mpvr2cVNLxxVVMwNkLdMGWGEL1BP9mu6UJA/c8pvMqkj6H2MAK4TBlqWJaxG9RsXXIL0uY+Ew==
Received: from DB8P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::13)
 by GV1PR10MB7571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 18:34:06 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::fc) by DB8P191CA0003.outlook.office365.com
 (2603:10a6:10:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Tue,
 18 Nov 2025 18:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 18:34:05 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 19:34:18 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 19:34:02 +0100
Message-ID: <67dbd8f6-2efe-4a73-a611-9081f364d2d4@foss.st.com>
Date: Tue, 18 Nov 2025 19:34:01 +0100
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
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251117200020.GA2518034@bhelgaas>
Content-Language: en-US
In-Reply-To: <20251117200020.GA2518034@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|GV1PR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: ec880010-7064-425a-d80f-08de26d10db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlFkMlNDdEt1NTFRcFNkOXRMdjFULzFOUHZlQldHSXZmN2JPWmlFbnlmOVBW?=
 =?utf-8?B?VGhFbW9LbmpoWTJWVHlFY3ZHQlFreWFaZCs4TmtLZ0Erb25iMTQ2d3NNcjh5?=
 =?utf-8?B?UGFqdnYrL1VpOFpDdTFFZ2EzUCs1Y1F1amZsYXFGYWhRY01mcG9MUlp3bHE4?=
 =?utf-8?B?ZDRQdWZpK21zbTRFTkp3bkNvU0hXK09XTlpHcXRRSXJZU2E1SG5vTFdVUDVp?=
 =?utf-8?B?RFArMFJHZGNKdjF5ckVQK3ozRnE0L1JQRGpoY0hXKzVpL2I4a3FQcFJCNTdE?=
 =?utf-8?B?UHk0QnRlOUpNZkxmSDArR1lpelUyTnV4U0hSdWtnU2F6dFRqUGM0eVVEbDAy?=
 =?utf-8?B?VW9WMG5XaFpZcWx5RFZIOFFtOXByb2Z0ZFBPUEl6UFN4dUEzOFljT3BDaE1J?=
 =?utf-8?B?TkhmUWIxenV5SXFSWkozallFNTZvdWJ4THBLdk12QjBwV2p4WmlyVmVwQmtl?=
 =?utf-8?B?TGQwWTdtUGp0K1ZsdnFyNXQwNGE1Rnd5S3krQ1lQWUhOVWVlTEtpQ0x5Znhh?=
 =?utf-8?B?T3RLVUlTZCtQTTJ0OTBFRzNsTmZ0ZHBDenZYYWxJNFhYV2EwMjRDcTBNOXpT?=
 =?utf-8?B?UVdSNE5DVW5seVNObW1WRHl3eUNWWU5CYXc0eWQzSEFYRzAzVFJGbWpVaGlT?=
 =?utf-8?B?STEyUVZLdngyRTd3VUp5Vmpwc0JlaXdQMm52L1JteldaZ0dsYTkyUVRzNmRv?=
 =?utf-8?B?cEg5LytldmtYK2QzWGRHaXF0b2hGa1Y5d0dKbVFJZnNiSitXWGkvMXZFMmcz?=
 =?utf-8?B?eEpMUldsbjQvcytCb1dnRUl0K0Y0WDRZNVpFRWVBaCtpbExwclZIV1owekZB?=
 =?utf-8?B?Qk9WYW15eFdOSjRsaWhkT2Fad21mZmovSXVhUEJmaWg2WDFDU2hEVVNvWnM0?=
 =?utf-8?B?WFFhYjJ1b3NJcGR0aVhaYWdTZTFLWm9OU0pyMzZXODNjb3RMNkJva1BOQ3c3?=
 =?utf-8?B?Mnp3dXFmWmU4bFJTMDY2Q2p5U3BjanZOUUF3MmtXMDlzSS8wcHRJNG9LL1FJ?=
 =?utf-8?B?dVBXQkcyTjJuekFQVDhydHVMZS9IcEx1VUZjZ2Z5ZVZ5YVBSd0YvbmN2UjNE?=
 =?utf-8?B?TFUrVTlsWXdtZCtGYUZsdnZvTmlSSjJSemh4eDNHR2kvbWZHak56Q2dWRjND?=
 =?utf-8?B?ZG5QRFZFa1R1UjBJUXVTTWRKTE9CclRQZHFtQzFBUCtuZ3BFRUh6Vytkb1Ny?=
 =?utf-8?B?VWJlZ1UvYXZnK1B3ZEdYRE5ydDJWd01pb0x4cmJaTDVVQVJlMXhPd2QwT3RY?=
 =?utf-8?B?Q1FqVlBMR0pabGNZNzBxZXhVVjdDak5CVktoMFNJTEM4T0FBM1ZQd20rY0kx?=
 =?utf-8?B?Y2dzRXhUcE5rM2svVUg0Wk13MURlV3p4N0xsMjFsUjQ5OVlJMTJhVXM3bHpR?=
 =?utf-8?B?eG4xNFAwNFpSMnNxNnN1OHhzOXpqYzRQbVUyLzF2dTBiRWJIQ2RaM2RtZGpQ?=
 =?utf-8?B?dkp2SDExY1JVaEJNZ1dxYnovOHlZaXJKS3ZnaU1KenVvYjBrZzN0VjI5OHlV?=
 =?utf-8?B?Y3libktJWFA1cmlFN2FSWVB6a29NbFVERmpVMVE2dlhYOHFoR1hLYXpmTXAx?=
 =?utf-8?B?Mkl4YlhnTExKOGJPS1p6ZGJhcWpCcGJNbG0rQklGWk1uNEIrOWI0RFgwSTBu?=
 =?utf-8?B?M2VqbllWZ0RFdEFHeHFyZXhURXQwMGN3MkNKUEZ3OXhMUUozdEdYck1hS2di?=
 =?utf-8?B?cjhzWjNxOUhOSCtIbDlnRVJmM2s1Q0NjVVcySWE4bG1yOU96MEZpZ0FvNFJt?=
 =?utf-8?B?SW5HbWVNVndpOXY2LzAwWlNmblFLdG5RdTBZamF5eWx4bWV3L1NvMHRkVXQw?=
 =?utf-8?B?T0VzVGI2RmJyd1ZWNmFPUUU3TmgyWHEwUXl0OWRVUE9zejhSZktXK1pCRlUr?=
 =?utf-8?B?RFNqT2J0S0k1UkVoSUthQUJ6TUhhTStkZDMxYXJqQTFYVUNXaVBqbVFnVkN6?=
 =?utf-8?B?Mzh3K2t2anJVL1EyZ1ltYWl6aDNGZVczcTBlSVc0M3NFQnViODJrcnluMjU2?=
 =?utf-8?B?MGd2cG5CT09IdzJWLzV3dTBaZlk5aXdyTDNnYnc4MHJicEQzNFJnaDduSHFj?=
 =?utf-8?B?ME5ZVytQcERPK2Zzd0ZIVVlaa0RLZm1Cb0k4UzY0V1Z2K25uWWcwSEE4S2Iv?=
 =?utf-8?Q?BjWY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:34:05.2027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec880010-7064-425a-d80f-08de26d10db4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7571
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0OSBTYWx0ZWRfX/cSIXhwpS49S
 H58R9LBWczNAuMPf7EURTIFYRg+jrCQk+4znGP2nTlTmrBTRfkwAGQJvwxDFREQu64V6ppdGoLf
 17s7hethE6xUhUOax1j8iArXxxgxCOK0abUOx/E8BZEGfno0fyGzeL2Az4dh1v/auLFJuh3s0Xy
 2M58KRqz649fmlJqaiexNwLNv7ivN2SkdBk8PP1MWMTxgguoarKLxE/XPiMXcuoKGRnJ8GpjTNO
 f76rw8CPvyaBqOE8jK/r6L5tXnFrcxj/8c4Vtany7IqAHBzOwOlWYj1OKCu8IV9DKUHYAefOFnB
 GaTRa/r25t/qCJhFxRzrYJOJx8qEzMEKGcsQSFC2ORsGLN+JPRlUYEAOFohZdaXnf3U75lly0mO
 /R4PhFVgwvbs85yE/OriCQhMxdyvYw==
X-Authority-Analysis: v=2.4 cv=SaL6t/Ru c=1 sm=1 tr=0 ts=691cbc23 cx=c_pps
 a=4X+iVNKrLEFvYFcl14eRNw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=KlQPxW_TAIvn8hAYAncA:9 a=QEXdDO2ut3YA:10 a=X8_hmcNjPp8A:10
 a=VmwSssl72cIA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: o4gfqP86EB7qQp-5ecozdyxwVyLTJFro
X-Proofpoint-ORIG-GUID: o4gfqP86EB7qQp-5ecozdyxwVyLTJFro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180149



On 11/17/25 21:00, Bjorn Helgaas wrote:
> On Mon, Nov 17, 2025 at 01:04:47PM +0100, Christian Bruel wrote:
>> On 11/14/25 19:59, Bjorn Helgaas wrote:
>>> On Fri, Nov 14, 2025 at 08:45:52AM +0100, Christian Bruel wrote:
>>>> If the host has deasserted PERST# and started link training before the link
>>>> is started on EP side, enabling LTSSM before the endpoint registers are
>>>> initialized in the perst_irq handler results in probing incorrect values.
>>>>
>>>> Thus, wait for the PERST# level-triggered interrupt to start link training
>>>> at the end of initialization and cleanup the stm32_pcie_[start stop]_link
>>>> functions.
>>>
>>> I've seen this kind of thing in other drivers, and I wondered whether
>>> it was safe because the host asserts and deasserts PERST#
>>> asynchronously, independent of anything the endpoint is doing.
>>>
>>> I assume it's possible that the host deasserts PERST# before this
>>> driver has the stm32_pcie_ep_perst_irq_thread() thread set up.  If
>>> that happens and the driver doesn't see the PERST# interrupt, does
>>> everything still work correctly?
>>
>> yes it does. the PERST# interrupt is level-triggered and, if already
>> de-asserted, fires only when enabled (it is NOAUTOEN) with start_link.
>>
>> At that point, the host can enumerate by performing a manual rescan or
>> rebind the PCIe driver, restarting the entire probe sequence.
>>
>> Tested the pcie_epf_test driver with various power-up sequences: full
>> power-up the host or device first, and stop or standby PM suspend/resume.
> 
> Help me think through this.  I guess the interesting case is when the
> host boots first and enumerates devices before the stm32 endpoint is
> ready, right?
>
> I suppose the endpoint LTSSM is initially disabled, so the link is
> down, and the host enumeration didn't find anything?

yes. When the device is not started (start_link) dw_pcie_wait_for_link() 
fails and pci_host_probe() only register the root port:

         /*
          * Note: Skip the link up delay only when a Link Up IRQ is present.
          * If there is no Link Up IRQ, we should not bypass the delay
          * because that would require users to manually rescan for devices.
          */
         if (!pp->use_linkup_irq)
                 /* Ignore errors, the link may come up later */
                 dw_pcie_wait_for_link(pci);

        ret = pci_host_probe(bridge);

> 
> Where does the link come up?  I see the pci_epc_start_store() that
> eventually leads to stm32_pcie_start_link(), which enables perst_irq.

The link appears when explicitly requested by writing '1' into the bound 
endpoint device driver sysfs 'start' once the device is configured.

see https://www.kernel.org/doc/html/latest/PCI/endpoint/pci-test-howto.html

But how pci_epc_start_store() is iterated from the configfs_write_iter() 
mechanism is beyond my knowledge...

> Since you requested perst_irq with IRQF_TRIGGER_HIGH, and PERST# is
> deasserted, does that trigger stm32_pcie_ep_perst_irq_thread() and
> call stm32_pcie_perst_deassert() to enable the LTSSM?

perst_gpio is active low. So requesting the perst_irq with 
IRQF_TRIGGER_HIGH triggers when deasserted.

This parts is quite confusing (for me) because gpiod_get_value() 
correctly returns 0 when the gpio is de-asserted, when the irq API does 
not know about active low so we must use TRIGGER_HIGH

> 
> When the link comes up, if the Downstream Port supports hotplug and
> pciehp is enabled, it might notice the link-up event and treat this as
> a hot-add?

yes, I just tried with a host pc with hot-plug enabled. lspci found the 
stm32 EP, as you anticipated

> 
> Otherwise the user would have to manually rescan to notice the
> endpoint?

indeed, this is how I proceed when the host does not support hot-plug,

thank you,

Christian

> 
>>>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-stm32-ep.c | 38 ++++++------------------------
>>>>    1 file changed, 7 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
>>>> index 3400c7cd2d88a279c49ef36a99fc7537c381c384..d0654bb43759bb8d0f0d7badbf7bdae839241fcf 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
>>>> @@ -37,36 +37,9 @@ static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
>>>>    		dw_pcie_ep_reset_bar(pci, bar);
>>>>    }
>>>> -static int stm32_pcie_enable_link(struct dw_pcie *pci)
>>>> -{
>>>> -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>>> -
>>>> -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>>>> -			   STM32MP25_PCIECR_LTSSM_EN,
>>>> -			   STM32MP25_PCIECR_LTSSM_EN);
>>>> -
>>>> -	return dw_pcie_wait_for_link(pci);
>>>> -}
>>>> -
>>>> -static void stm32_pcie_disable_link(struct dw_pcie *pci)
>>>> -{
>>>> -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>>> -
>>>> -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
>>>> -}
>>>> -
>>>>    static int stm32_pcie_start_link(struct dw_pcie *pci)
>>>>    {
>>>>    	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>>> -	int ret;
>>>> -
>>>> -	dev_dbg(pci->dev, "Enable link\n");
>>>> -
>>>> -	ret = stm32_pcie_enable_link(pci);
>>>> -	if (ret) {
>>>> -		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
>>>> -		return ret;
>>>> -	}
>>>>    	enable_irq(stm32_pcie->perst_irq);
>>>> @@ -77,11 +50,7 @@ static void stm32_pcie_stop_link(struct dw_pcie *pci)
>>>>    {
>>>>    	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>>> -	dev_dbg(pci->dev, "Disable link\n");
>>>> -
>>>>    	disable_irq(stm32_pcie->perst_irq);
>>>> -
>>>> -	stm32_pcie_disable_link(pci);
>>>>    }
>>>>    static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>> @@ -152,6 +121,8 @@ static void stm32_pcie_perst_assert(struct dw_pcie *pci)
>>>>    	dev_dbg(dev, "PERST asserted by host\n");
>>>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
>>>> +
>>>>    	pci_epc_deinit_notify(ep->epc);
>>>>    	stm32_pcie_disable_resources(stm32_pcie);
>>>> @@ -192,6 +163,11 @@ static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
>>>>    	pci_epc_init_notify(ep->epc);
>>>> +	/* Enable link training */
>>>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>>>> +			   STM32MP25_PCIECR_LTSSM_EN,
>>>> +			   STM32MP25_PCIECR_LTSSM_EN);
>>>> +
>>>>    	return;
>>>>    err_disable_resources:
>>>>
>>>> ---
>>>> base-commit: 31115ecec74fe5c679a149d7037009f26b3aa8a9
>>>> change-id: 20251113-perst_ep-0b57b9679cf9
>>>>
>>>> Best regards,
>>>> -- 
>>>> Christian Bruel <christian.bruel@foss.st.com>
>>>>
>>


