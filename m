Return-Path: <linux-pci+bounces-35438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D5DB435B8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 10:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6463A82C2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C8E2C11D5;
	Thu,  4 Sep 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HQ3irstk";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="AaCZF1n2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8A63CF;
	Thu,  4 Sep 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974502; cv=fail; b=qbpfyf8ca/fjesr07g+u8sxbjndIZcV3DrSCFERxMLlRqdYIjOLhG0m9HdirjEwxhKflh/yOLJjRbscnVQFCD9CnxjXKuWIcgxsn21QZSjInMV1ApgfE39frL8/rXF6aLt2BvMCdKtnaEztD7P/5A6s2qa7zZllGrdlD/lm6Cmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974502; c=relaxed/simple;
	bh=oMVLeq7ytBjjl+Uv2hcQjUVj0rqMtQghYclYcu2PDQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kpyr33Ag6Yv8nH2Q+Pn6aMva4N8vFLXEah6Dspv+b0edC4XwTHu6gSDgQkETsAvryHcaNWUx+0OavxkSRxjXorb4AaP/i7ZCeWyRlP6jXjwJttpD/5i0/L9mJn164VRD50rERAjMSLl+KSl3M244LgxNaVgfQia8s9GGUiehUGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HQ3irstk; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=AaCZF1n2; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58488lZZ006600;
	Thu, 4 Sep 2025 10:27:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	LNDYRNMn4hyPVWV/UXN8nZ23zIc7fA9eDgUdJV7eBak=; b=HQ3irstksWCB/5iw
	BuBK739dIqvnU96PQHljyYviSqic5W78cEoipc0otGY8kd7x8zZLkHDh1PMWEKv+
	sRPrigqfQSmEQnTMGRVyxdIACMMFs9yxFuUd1wBfyMHxt1OZ5MxKqzbFp/czL5qO
	mBEsFwrnSntfFECBFOXbeSP0Q1q7D6pkuM8LEkijuJjJV+N2ze9HT7bFjgiJmDIr
	ajlBDc/vurL9yuhYsnKRkVsEnsKlWZ8J74vJ9vYFiuhloVuMNhEphv12VQGTGi8G
	pCx8/BYebD6VjQZTr4HhRyJwfR+SnFXCEEkLb13oIfuuT+vE0pOJlIZy0bxd5Y68
	OWbr0g==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upe7mg08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:27:40 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2V6FSi8CQhUphkiaojjkwqCLlpdzXrj2YzIXJwGJF6Vso0fkGNsMTYBrP4j9UfS1d2TbPp7LupTWKEbBmcuinovnT5KcqRbX2YpFuI1clZBaMH/uLX/ZbUokeEfiVaCNuce8T8vEyhTaM56Zio5TAzvWHX1smx+AuL5ogmudq9FKw52z16tpUn+HPPAnKfmOLbnXDvfbXE4BCCOVyhHijU7uulrh4/KrqGOyo6yzZ13kEDdEiSHMUKqgMFX5fY4n4WUAnPYjHwj3Vo/O9dEWlNlWyRSKwMPnGxSnUZAobsNJ//Hw6BWdxbJGNeDfvFen1SUCQV/58vMw3TfOtU4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNDYRNMn4hyPVWV/UXN8nZ23zIc7fA9eDgUdJV7eBak=;
 b=rb3V1vFVccL3993U+CC/w66+dz+JSFdOVOmKCGWLya+eUIWEfOC7eWC+quffU8zoxAFFloS013+ms5em4KMjw/E/+1/1C8UeQO3T0v2qko6zuEkF6fD92sEB+fqnrWjGMNYTEn609HXQXHNPfcONR2/CqXHzpj0qWd9ctmzeIG+6j5x4u8TlguSiqE3cS+j/YW2h/DfcQC5LutcJH07GaC7/2YH1rm1zByY8L6MuGQEfZaPQv/D/+u0P8qBZIc2uFfug7L70SUZPXJ6JjVjUFHKVX+VGBoyxUczxE1hh9u0T4x6b5dmzjtJ/YNtpKOhFSBj8nseDbBYNFuk36PrnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNDYRNMn4hyPVWV/UXN8nZ23zIc7fA9eDgUdJV7eBak=;
 b=AaCZF1n2sRdYEOndyLpwrrW8c3dmbCNeYKyzM9aEpCkrA84H6MCoj8XFX5g1MvixSKzYRmHPyowM9h642OZQbxm2C4w/cSBlh192q6DiCbMQXUyyR0D3jT5hcauTXGeNfhCMOLMVn39FO1MqoCnDfRFT8xHyNnIi8BSpDpnsJzk=
Received: from DB8PR03CA0019.eurprd03.prod.outlook.com (2603:10a6:10:be::32)
 by AS8PR10MB6176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 08:27:38 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::98) by DB8PR03CA0019.outlook.office365.com
 (2603:10a6:10:be::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 08:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 08:27:37 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 10:20:23 +0200
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 10:27:36 +0200
Message-ID: <d6acec91-1da8-4aca-9d51-f3c4bf9a7083@foss.st.com>
Date: Thu, 4 Sep 2025 10:27:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/11] Add STM32MP25 PCIe drivers
To: Christian Bruel <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <linus.walleij@linaro.org>,
        <corbet@lwn.net>, <p.zabel@pengutronix.de>, <shradha.t@samsung.com>,
        <mayank.rana@oss.qualcomm.com>, <namcao@linutronix.de>,
        <qiang.yu@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <inochiama@gmail.com>, <quic_schintav@quicinc.com>
CC: <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|AS8PR10MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f77061a-bf9c-472b-c766-08ddeb8ce806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzFrSC84YmVlc1Nsem9hSDNtRWVMY29yTVVqb3l2aGd6bkFITmVyWDd2aFY3?=
 =?utf-8?B?eUd5VEIraHhzcEY3SGJndGhjVnpkWVlxS0FyYUllL1JTRWlCdGk3RUFVY01L?=
 =?utf-8?B?eERKR01ib2RlcTFQQU02SUphRnRxVlZTSDc2VVEzUVpGNHJYM3FkR0RZMTV5?=
 =?utf-8?B?aEhHKy9vOEM4bU9hNlhhcTErS1Rncm9TazdHdjBIMHlSbkp4aWovWCtYaUxy?=
 =?utf-8?B?MjVaT3gyMGVlbFJ1dmVxbWtuWVZ5T3JLNFh6Y0dqa3pVVEc4QmJlc2ZWYWpY?=
 =?utf-8?B?QUxwdzA4Z3V3Y1djOXdtOFlVeUVoKzBMeGdldVFzLzBBaERSdDQvdXdqNlNY?=
 =?utf-8?B?NElySVBZM3dlenhMcnZHUGtPaCtnYTJJZENHSlc1bWQrZ0FsQlAyUzJQcFYz?=
 =?utf-8?B?RzErRDBvL1NWV0JvL2FXSlNKcXZqUjJSMmk1c0lYc3lNRFJmbFlTS2MvcHVO?=
 =?utf-8?B?aWlpbEhUaFBPVmVzUmNnUFNkUjZQVkNtRzRDZVd2NkU4QVBZTzE0YnFEN1Uy?=
 =?utf-8?B?SzRTcUxkUTdPQjBXbEI2SllwcC9BRVdiRHRuQ0lhTDA2ODBzRCswZzIyNEpY?=
 =?utf-8?B?T3YvWXZtZFU1QjRtbXhHZUZWWE9MUmJIRUhDU08yY0RRQ2lvamdYdjZ5M2ZG?=
 =?utf-8?B?Q1B2ZFA1bjErbmNRYUlEdVY1eldLdGFMSU9tRHJvQ1ExVCt6S1hFcURZZVly?=
 =?utf-8?B?a2JkTzZvbWdHcW9zaThHRVEya2c0SGdhdUo3NWhjRDlWQlFQZDJiUkNZZVJR?=
 =?utf-8?B?Um0vbEl6RHpIaXJheE9PbDBUVERtME81WVlxelg3NEtWMUplVThVYjdyT2xl?=
 =?utf-8?B?OXlzVkE1dFF1anVHTXlib0ptSDEvZm1WcWVhMmhweVZJU0dsYnZsa09jckpr?=
 =?utf-8?B?OEQ2L0ZtMktSSW91QjVGRDRkWDdnb1lBQUI0dFJ2aGZ3ek93WkZNV2xuSXM1?=
 =?utf-8?B?anlpbWJrWXVJWG5MendOVnFOaWxFNGpXcUJwbDd1N2F0cU5Uck1yNVQvSXY2?=
 =?utf-8?B?cXlIRTZBbGFnZDVrOVRLMDBXYi9MYkV5YlN0R0M2SkhUY011Y2c4Y3NMTkx2?=
 =?utf-8?B?MDBIcmxWa0NsQ01yQmtYbVk5NExCY0pxc3dJakgzR2FRQzcvWGpnVlpLQnVS?=
 =?utf-8?B?TjNHMDRzRlQyS25iS01rbTk3NEJhQ1kvc0l0OW0wZ3Fub2toUm9QYXRNNXdP?=
 =?utf-8?B?STE1MzRwbVNZOGNjMW5nekpLS21GMVhqeUo1R0dkWnVxUkZobCs2dXc3bjBG?=
 =?utf-8?B?a1dXN09Fa0hlZUtrZTZjalhxb01KTWFPVFNjc3BnejlLQUlJSG9GWGxjWTFl?=
 =?utf-8?B?THpIUTBkdFp1cFBrWmxlTmtaWU1zbXZPQ1hub2hnbFZJaEFVUzI3Y0JDQmFi?=
 =?utf-8?B?a3BnTVovUlY0NTlqU25mc3VySHJVU2ZVZnpFMjRad1JXbmRGall5S1M0Z0R2?=
 =?utf-8?B?Z1ErQ2xvWjlDWjVYQXN1SEs1TTEreE9DeWM3V2dZaytJejFkclYxSlpRQnFh?=
 =?utf-8?B?Njh6OXp0T0NPK1p5YU51RE1zSmlJWkY1UVpzVm4yNGlGTkw0RDhpT1FmVm9E?=
 =?utf-8?B?Zi9PMXp2N1JNTDIwc0dXZ3hmNDJHYWM0bXBFc0JOOXA3aDVoU25aZDE0aURY?=
 =?utf-8?B?Mm51YUZBOWRvaWxyNFhLaTZpUGVvMjFEcjJadC9OSnlibEtxZ2VKMEN5Smtm?=
 =?utf-8?B?dXJnVjhnZ3ZJcGNtSzR3Q3VvOHRqMzMvYVJSNyt2QlhLNWNVUVB3R0crVWpZ?=
 =?utf-8?B?SWlVdFEyWHJtbVJ5T0tGbitMVnlCMWMxU04wYU9BS1FQV2pzWGlTY0hGNGFi?=
 =?utf-8?B?eHRoWlA1ZXRTQlljaGIvUFp5TDZoUzh6TkRtQUtZZS93N0R6VERKSDNLZlIv?=
 =?utf-8?B?eWpjME5aMVJ5RWl3MzdTYmlMdlJ2eTJRSnZUYktBUnNDWllCNitnalY1aEZs?=
 =?utf-8?B?OHBUV0xiOW92dWc4TnI2elg5d0lJa1FSRnZKRndwbnlMeWhQUS9LNGtRaW9q?=
 =?utf-8?B?R0wvb1dQVFVSeUdURWE4ZFc1ZDlhNndGRVlNK1ExMyt2b0pPV1pQUUh6UFlx?=
 =?utf-8?B?RklSR0FKTUI5OEV6T3ozU0I1MS9aYzAxbzdQUT09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:27:37.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f77061a-bf9c-472b-c766-08ddeb8ce806
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6176
X-Proofpoint-GUID: rqgO1ltUNRBY-HTj590O55CLH_niWc6a
X-Proofpoint-ORIG-GUID: rqgO1ltUNRBY-HTj590O55CLH_niWc6a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDIyMCBTYWx0ZWRfX4GuZXUuHfwqg U0E/cqv9sLpNzBzC5e43IIlo7tVG7DjyrT9/MB9kBjmxaOhNp4XzPy5hA6Kvm+BAMC2vFZqWQfS RMWuEvB9sjcAA+YQTGWVwpVwYss68D5TGT8jKPxb7dnZkMwDkaurUhgCgI/Lsn12bjtLGSFJzAr
 3Uq/j9elxipt7W/DRRCYmk2/qQTEeajhh4LGd+HuSxA5yb0//dgrvzHgZ8apTlPIIpatXoB6YkL keAXjkc/EpTDFb21JUkn7zfxHUr2dOaQH+wEqxKYs7L+jmoo1cLehGsOIJaRiIYvjhDXNFmWNEe i/ZdE4UorEsrBedhaUk0y5zs2rMkjfv8PQZWxagaSwDU0rQmFnwo3rcQ/Rl7KBQhP6BFTFTYpRh /62Ot/E8
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=68b94d7c cx=c_pps a=6EwHhcPr6SQIsPQpIcuDPA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=ycXS4Ko-rP-ybcqW0P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290220

Hi Christian

On 8/20/25 09:54, Christian Bruel wrote:
> Changes in v13:
>     - Rebase on pci/next
>     - Replace access to dev->pins->init_state by new
>       pinctrl_pm_select_init_state().
>     - Document pinctrl PM state API.
>     - Group GPIO PERST# de-assertion with PVPERL delay. (Bjorn)
> 

...

> 
> Christian Bruel (11):
>    Documentation: pinctrl: Describe PM helper functions for standard
>      states.
>    pinctrl: Add pinctrl_pm_select_init_state helper function
>    dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
>    PCI: stm32: Add PCIe host support for STM32MP25
>    dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
>    PCI: stm32: Add PCIe Endpoint support for STM32MP25
>    MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
>    arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
>    arm64: dts: st: Add PCIe Root Complex mode on stm32mp251
>    arm64: dts: st: Add PCIe Endpoint mode on stm32mp251
>    arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board
> 
>   .../bindings/pci/st,stm32-pcie-common.yaml    |  33 ++
>   .../bindings/pci/st,stm32-pcie-ep.yaml        |  73 ++++
>   .../bindings/pci/st,stm32-pcie-host.yaml      | 112 +++++
>   Documentation/driver-api/pin-control.rst      |  57 ++-
>   MAINTAINERS                                   |   7 +
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  20 +
>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  59 +++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  21 +
>   drivers/pci/controller/dwc/Kconfig            |  24 ++
>   drivers/pci/controller/dwc/Makefile           |   2 +
>   drivers/pci/controller/dwc/pcie-stm32-ep.c    | 384 ++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-stm32.c       | 360 ++++++++++++++++
>   drivers/pci/controller/dwc/pcie-stm32.h       |  16 +
>   drivers/pinctrl/core.c                        |  13 +
>   include/linux/pinctrl/consumer.h              |  10 +
>   15 files changed, 1189 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>   create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
>   create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> 

DT patches (8 to 11) applied on stm32-next.

Cheers

Alex

