Return-Path: <linux-pci+bounces-41392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D99C63FBB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 13:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C56134E043D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F32D47E4;
	Mon, 17 Nov 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FYjcdiWo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78836257854;
	Mon, 17 Nov 2025 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381129; cv=fail; b=msO2Zk7PsAdVahsZP8C6dCgqJCKr8+ChilPHiNWs+UVMTiejOf5rcEBJ6PRSzPxdKas094gmnhagWjMc3GgTq8ZkfHMUfvtMC/LdiYl1hLMQ9CasGbtb1fKDtbHhGmMHfdFVefURgN29kgoAB+gsH/JXBapcUHnmytbCivFX7p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381129; c=relaxed/simple;
	bh=LKSHXHM8pGlTWqMNRhfegORo+5g0sgtebOLYdO6YcC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=rOa0deWqzYhYZ+tryRzqpUO3FhCnVXLlUtFTEB9Rm3IVTCof8V39TRlrx4TNvavN6WO5DLCX5cQsq57C6pSBaGX9eXrz+F+TaG3wI+rTa5Ta0XI4bd/NNTDUzxdHulc3x8bsJBT67dtSVdg6cwejIRGosF6y3irVI/l43hWZWfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FYjcdiWo; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHC0k3R1177575;
	Mon, 17 Nov 2025 13:05:01 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aejg5pk9r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 13:05:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFLjVU8bAFtZU1zhaJorcI18p8t1BMNk6d+mPATiYs7mXo4OpP2sPaOnOH9TfhtsTiQvS1SXfmwMMBSSgJCCZ4dqY7/w6I1oOTbFJJD6vcURRB0BvNDpGnhW5osfLQm7gCHiLTcSPuNbeqjLK51oYfxeSzqoQmCdT2HwgKjosTmrd8W2pWQ8F6iA3gjIVHA5tjLqakgthoQlP/ExQEkdTb0Noz7/1Wajwc5Kk1TRkr8N+3Oa05NA/kw9NK4SHIKIi1qJjHjx2Est1ERO+sgSuN/xS+nWhqZbfkCrL4MapELWhPlWT/B9RIiwYOfFeUGDntXzwcWOGgVd6zV7926F2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGSqqm8SxRyVDFRa3GPqiY3XYYG8YhFQYMoIHVzoxjs=;
 b=gs3W9TSAhaqd2muTWxlpn+gF6CNhITxExFPxEYL+4Kr7QfhLtzY2PB2Gb008Nznb+9SWuH7K//R7gTKCNEsrrooeG7I/g287bkccp6syKXCMUURRPCXilNQOBhL3ITdAmaMiNLi+13sSrGEkp7YydFRkN4NI9QXQUbOOqbKEhjI2PyvbdKGeOFLoWWEZBCRe5Ahrijz7q9Hg7VYeotz2qHVEWajJ2NYM42SDVSnIPhgGCwQrCY8PGvP4YPz80e4wkWojtdgsUspVk5kZHh5tNhepnIK+1inAFBJoob9q/yVzjfxZFRixEB8NBqiWHKswJiV7VMCz2bw+Eva5b+nZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGSqqm8SxRyVDFRa3GPqiY3XYYG8YhFQYMoIHVzoxjs=;
 b=FYjcdiWocUyH/MjxU2oQf/vFFjWJJh3mmJeJF1Ivihig/4G1B4h2rIM4ipeXxbBfg6owuc0XLBTdPe4vDxBzdyrCRmt7pAncu6tJArQs5+LcCVwd2nc/QemqXmqQJLNQ7UmTmqXmjocwxot7wuPda23UL/wL5O2Qwt35sSlzMBIEnF71Qx+4QnmK6ijHBBF22TsRq4IGhun0MmNr5iu/neZyuzv3fJZYvAlAmfboXo3nq7Ni+fN666QAicMjFlfyqpJZRAbM57KGsyzGyNDSr7lpExjuTIrik81HpbEGcshm61NphXZ0wjyPZ1heXoUGIa7/U2xcBmvEbOT//sTB5A==
Received: from DU7P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::16)
 by AS2PR10MB7105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 12:04:50 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::7) by DU7P250CA0008.outlook.office365.com
 (2603:10a6:10:54f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Mon,
 17 Nov 2025 12:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 12:04:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 13:05:02 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 13:04:48 +0100
Message-ID: <367c8b88-79e7-4e8d-bf70-9d283696aba2@foss.st.com>
Date: Mon, 17 Nov 2025 13:04:47 +0100
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
References: <20251114185928.GA2335574@bhelgaas>
Content-Language: en-US
In-Reply-To: <20251114185928.GA2335574@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|AS2PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee365c5-0a86-41ab-be65-08de25d18252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3BTYkEzcndUemtGNE1ETXRBUGlnRHZnQnlkWlU5WXBVK0toektxQ3NyZk1p?=
 =?utf-8?B?MVZWdk1sbjRHcWlzUm04YXN3aHNBclFvRnI1YVBhWGNBQzkva2NEUTJqZjRY?=
 =?utf-8?B?cDQya3NqTEE2YzJvSEZVMldrRms2SmtIRDdCRTcrU1I1dTZ2T2VOM0VDWGRL?=
 =?utf-8?B?Yzhzd3FQZ1dMVWF3VEFiMnp2UGRCeEN0VXZVY04wK21taEdsT0FxOVorNmpI?=
 =?utf-8?B?WFlibjhmZFdIY3hNN1BWWjJvQnhwN25IekNHYnh2aWR6NWVKZm1tcmpOM0Rw?=
 =?utf-8?B?b216SEVVMTJpNTFoVDlPTFlSUDRWNUNTNHRHWmxKaUVtaFdpNUpEbyt5NHRx?=
 =?utf-8?B?elEvOEFvYys5dHVKUHl1WE15bXYyMElWWXF6bEFTejFyK3JpVk1tTWt3ME13?=
 =?utf-8?B?SnhUMU56S3FTTElsVFJGSDBQdU9MR1RsbWFQOFJGMldSUjR1UGtaRENJZWxK?=
 =?utf-8?B?ZTBQODYzOGdZMWpEcWZ3Y3NUaGxTUjFJM1JVNmlYd05NU3N0WGJzcjI2Y09P?=
 =?utf-8?B?cmQreFV5UEs1U2U2VHlMWGNGRyt4R3R6SHNGVDRzeVpoSTlPQTlVOGZ5YjVV?=
 =?utf-8?B?b2pjNlhBSXVvYjgzdVNKZnhlQ2kwRUlyYTdBT1U1TVNJbEpSN2xtZmlCci9o?=
 =?utf-8?B?QkpoaWVhSFBycmFYdTZqUjdST2Z6bkdKTEVUK0d5Nlc5L3MzSCt5Rm5XREJS?=
 =?utf-8?B?NmttTkhYbUVKV0VMOHlNN0FMUmNkeFRSZzluNHpxN3dUNXJSWFJ4UGpoR011?=
 =?utf-8?B?VGFzWFVwRks5SEtnM2hCdzV6bzlid0ZuL3R1VXhQT2lCMmI4WnhtVXY1RWN6?=
 =?utf-8?B?cm45WDlZNkN6dzdmWWVsWlNFbm9NTnN4dWVYbUFwSTlQZm1XamliOHdDYkkz?=
 =?utf-8?B?cnFZZGIvbXA3dzdxckpoMHBKMTd4TWJrYmtWNHMySzV3TDcrRGt0YjlmQkxp?=
 =?utf-8?B?Zk1HZGN6Q2FXS2U0cmNOd24xTnRkRmV0V0lIVElIS3hWQ2pFUG1pTVZnVWhp?=
 =?utf-8?B?cStYUTVzZE9qbW0vYkhGdzFhdHdFa1piZ3BVTmRrUzRKU0p6eDRYU2d1VnFI?=
 =?utf-8?B?ZDhRVFdHWURnRTZFWWxSK2NpUVJBaHJlZmdqYXdlWlU3aHZoajRFeVZtbVdH?=
 =?utf-8?B?R09uajNReUpFWlVic0t1YXNiQnV2dlhZU1Q2WWI0K3p1czFuWG9Ia09jZi9P?=
 =?utf-8?B?UUg2QlBPVEl3czJmSDNodVEwZy82bUs2RWtObHVsb2pIS0NYeW03ZHVVTWxt?=
 =?utf-8?B?c3d4bWlNU3lMV0RkQ0o1ZlR4K2tBZGc5VUEzdjBUeGFhS1lkVW52Z0RjZmFD?=
 =?utf-8?B?eHBCZ1p0VW5oR2crZUZ6RCtPeDBra3Z0OFdMSE1tamphc2ZXbjJqZHJzVWhQ?=
 =?utf-8?B?dEhNRkQ4b1l0YTIvQlRCRGdTMU9KUXV6Y1dFTUc1TnNSZ1BpZXdVVXZGQ2Na?=
 =?utf-8?B?aDJabWxwdmJQR0pkeUY0Ymt3K3lDWWxiSm51dlhuQzNGdWZzckpsRWNxQytD?=
 =?utf-8?B?eGxzM1pQbG9XZEhTbUZRS3BNWmI0UkE4UnpQVlpMZlZFWXhnTUZrNTV4MnJV?=
 =?utf-8?B?OUlMQ2xJT0trWUdKazZwQmpkRW9BSkRkYnBDbUNqZGN0QWRiajVDZEQzbnhr?=
 =?utf-8?B?Y1lXWG9tNXp2Y1FraGlQT2ZwQUdHZ3ozeUVYa1ZISmtyL2NLT3FJNFl5NnU2?=
 =?utf-8?B?R3loOXRvMG96V2lIanFuUURKMmptNS9UTUhRNUhhcGVzNXQwdUMzdXZYSHQr?=
 =?utf-8?B?UlAwemZnWVNWeUZXb3ByNENNWjJpQmMxY3JtVEtSSTNLSXhJekR6ZEZNdkxJ?=
 =?utf-8?B?SUY5VldTY1pSS2NrWG9nOTgrYXdoU05SVUdTZDZySU5NcUxKOXR3a1hGYlor?=
 =?utf-8?B?T0M4WU9OWDA5Uk5uelNxbFNkRmJzYXg4aWc1aUxqWG55aEtNSTFPTWZGZFY2?=
 =?utf-8?B?YVQvdnU0cEJzWFNseDZGbjJrVVdacXFkbGpJU3JqdHllRVZxejg2Y2Y2SDNG?=
 =?utf-8?B?bk52azB4OElQcG5CRnZaYTZuRUw4NkxaV1VZc0ppcnFCNkJMR1FUK0ZuWXl0?=
 =?utf-8?B?Zm5nT3lSb0RzU3E3Rms4ZGNiRlRiZCtmaStRRld1UGhqR0Y1eUptZXF6VS9t?=
 =?utf-8?Q?D2PM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:04:49.6933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee365c5-0a86-41ab-be65-08de25d18252
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7105
X-Proofpoint-ORIG-GUID: Q59Q_omy-wDtHzD7BI0Zi9koIALPwJWJ
X-Authority-Analysis: v=2.4 cv=ItcTsb/g c=1 sm=1 tr=0 ts=691b0f6c cx=c_pps
 a=pq8L1Hysopxh+HaxTYr/pg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=-0lt0-r5wVL_f7ZdPqkA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Q59Q_omy-wDtHzD7BI0Zi9koIALPwJWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEwMiBTYWx0ZWRfX99zRF5lli/Ae
 tHeSyX0KFAYeePsnDgDbw/+k2VYpalO+ZiTDxqwzC1ANlOEbcKSa6rYkEI3IzElI8yOkl4Qhf3f
 GDIvm7bDV23IIHAPG+dzBlo6+hJWOFKatj+YPBOd2IBaj/pHtBDhOYtxPleFNDWeQROw9+5kpWv
 N/RMDKY0qgw6Oy8r5+tEDN2OMw+cbzTaEDuTB7WonUljQ5qr3tCkn1p7prmWxYhkCu4pHfGK/K6
 vjbORljHCMfW5OUoOfYkJppcp/shFQlLmeFZqR73vC7xD60nnJTt9BNOsCwITO8aSWz6tlVEYr4
 hNAgLNX191v/jtk4UBYPBmDw8MpI2Qmf5eOQez4V7UEThSdMAjEGdpI2q45VFz63ydRdb4c2Kmu
 xVx6UR/NTEz3twWh5VTmnoS5jDQ//A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170102



On 11/14/25 19:59, Bjorn Helgaas wrote:
> On Fri, Nov 14, 2025 at 08:45:52AM +0100, Christian Bruel wrote:
>> If the host has deasserted PERST# and started link training before the link
>> is started on EP side, enabling LTSSM before the endpoint registers are
>> initialized in the perst_irq handler results in probing incorrect values.
>>
>> Thus, wait for the PERST# level-triggered interrupt to start link training
>> at the end of initialization and cleanup the stm32_pcie_[start stop]_link
>> functions.
> 
> I've seen this kind of thing in other drivers, and I wondered whether
> it was safe because the host asserts and deasserts PERST#
> asynchronously, independent of anything the endpoint is doing.
> 
> I assume it's possible that the host deasserts PERST# before this
> driver has the stm32_pcie_ep_perst_irq_thread() thread set up.  If
> that happens and the driver doesn't see the PERST# interrupt, does
> everything still work correctly?

yes it does. the PERST# interrupt is level-triggered and, if already 
de-asserted, fires only when enabled (it is NOAUTOEN) with start_link.

At that point, the host can enumerate by performing a manual rescan or 
rebind the PCIe driver, restarting the entire probe sequence.

Tested the pcie_epf_test driver with various power-up sequences: full 
power-up the host or device first, and stop or standby PM suspend/resume.


> 
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-stm32-ep.c | 38 ++++++------------------------
>>   1 file changed, 7 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
>> index 3400c7cd2d88a279c49ef36a99fc7537c381c384..d0654bb43759bb8d0f0d7badbf7bdae839241fcf 100644
>> --- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
>> @@ -37,36 +37,9 @@ static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
>>   		dw_pcie_ep_reset_bar(pci, bar);
>>   }
>>   
>> -static int stm32_pcie_enable_link(struct dw_pcie *pci)
>> -{
>> -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> -
>> -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> -			   STM32MP25_PCIECR_LTSSM_EN,
>> -			   STM32MP25_PCIECR_LTSSM_EN);
>> -
>> -	return dw_pcie_wait_for_link(pci);
>> -}
>> -
>> -static void stm32_pcie_disable_link(struct dw_pcie *pci)
>> -{
>> -	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> -
>> -	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
>> -}
>> -
>>   static int stm32_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> -	int ret;
>> -
>> -	dev_dbg(pci->dev, "Enable link\n");
>> -
>> -	ret = stm32_pcie_enable_link(pci);
>> -	if (ret) {
>> -		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
>> -		return ret;
>> -	}
>>   
>>   	enable_irq(stm32_pcie->perst_irq);
>>   
>> @@ -77,11 +50,7 @@ static void stm32_pcie_stop_link(struct dw_pcie *pci)
>>   {
>>   	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>>   
>> -	dev_dbg(pci->dev, "Disable link\n");
>> -
>>   	disable_irq(stm32_pcie->perst_irq);
>> -
>> -	stm32_pcie_disable_link(pci);
>>   }
>>   
>>   static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> @@ -152,6 +121,8 @@ static void stm32_pcie_perst_assert(struct dw_pcie *pci)
>>   
>>   	dev_dbg(dev, "PERST asserted by host\n");
>>   
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
>> +
>>   	pci_epc_deinit_notify(ep->epc);
>>   
>>   	stm32_pcie_disable_resources(stm32_pcie);
>> @@ -192,6 +163,11 @@ static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
>>   
>>   	pci_epc_init_notify(ep->epc);
>>   
>> +	/* Enable link training */
>> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
>> +			   STM32MP25_PCIECR_LTSSM_EN,
>> +			   STM32MP25_PCIECR_LTSSM_EN);
>> +
>>   	return;
>>   
>>   err_disable_resources:
>>
>> ---
>> base-commit: 31115ecec74fe5c679a149d7037009f26b3aa8a9
>> change-id: 20251113-perst_ep-0b57b9679cf9
>>
>> Best regards,
>> -- 
>> Christian Bruel <christian.bruel@foss.st.com>
>>


