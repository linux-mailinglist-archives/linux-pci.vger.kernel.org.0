Return-Path: <linux-pci+bounces-37328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CDBAFA66
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4533A4D04
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BC277C94;
	Wed,  1 Oct 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DEtEplog"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB21DFDAB;
	Wed,  1 Oct 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307578; cv=fail; b=VODhk4hi47K8as5CD3K2o4+ZnpWpeWK8WXmqamz0IvwMrshf34/3q753UQWSoaErUsCde/7Ff3yGE2ESQ0p9FRHpj/9t4EAkyvJz6LR7YvyAoyRkWXOUZ1SC5tVPfMHtehmRhinZY/KoOr9lFN16a2S34eO64ZMONnE/59d2VX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307578; c=relaxed/simple;
	bh=f44b9OSkIykEM1fz3vgWkEs2UcxlrzHssBfH0vcH2z4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=aq/Ba1Ow8KsVdvt1HrnyB90YEUIh32aV9Misr1SKEON2HFF3aEdlM4qKSUJd/2Ow92jF226U0yf65uUaRx8IYJQXmRyzHT2ymvtK3rUP2pnHrr3g2YFg0GeufvnXvMRFpgLrMl1PjzKQDSM8tLAGTFkc/vT2PPyHaewQbc3MLuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DEtEplog; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917hlL1006877;
	Wed, 1 Oct 2025 10:32:42 +0200
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49etvjdat0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 10:32:42 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrU40vVIQlP4eAx6dcsXZaZu4Ct4l3aH0FXnLiVBVTmVa+OvgRECxP5LLkXBmAEPRjF2MWjjX6tyA7/mp9LYkBfd8mALz8XK1OvzKghfIo9FnTyyukQ4aUbT/U1w9y7HFuLSihVPhZogFKnjCZ0HS3LUHglhv7rAgRAbuCARRTFegyK6JbfJIrQmRhRt2awbUzOLpNS5+D9rFj378vtzeS+U4Ed1Gpbwk+7iAR5rCX+gFKY7Ncr0rilqOVgj+tHwAopzlzOk8hspP50z3kSFgbmzjd42Pjc4vexH4ll5AHEa07nosUL5JjDV3YGxY649+SwccAkLFFEXAc9gje+MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CGnVQkaMRX5bhJi4UbmSaGXBMpkOj4C1AHISE8deQQ=;
 b=r7om6SHuB+ogvxAE16szApskE7LkBiENEe11X3Zl58vL3p8lkkdSQ59FWvZxoR0xIaD/C26ysFT+gRkRyZE/wMYtBh/BCj3RCUmIHthjDHHjCtiEmTEfY28EDgLzgrdJU23vIxYlvSAdXXSAJhAUuMMgwMhaY7plgZ0aOk4PK8LzI+P/H1jMfGcQTHfdlAj7hPXjYqqHUgdGcA8Lm3JA9NYsKgT3s7odzGEytf2KUBW3WaCWAg324/L8YrcTara/50jksooEta4gzNTP7WleeDcay0nxecMqNnEPFcIG8QoeEtHgXUnOwa1+PZFAleL5qzaajCV/WX/Zfw0Mi8/Dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 164.130.1.43) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=foss.st.com;
 dmarc=temperror action=none header.from=foss.st.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CGnVQkaMRX5bhJi4UbmSaGXBMpkOj4C1AHISE8deQQ=;
 b=DEtEplogNyvmOyuino+FaqlQMQcsl8ZojuSgL8a9t+8aO1DLGP25S9drjaSbGx0WXihb1Lp1riKseGpMuT13xxJkie9m4/qKgfIyOtSsI9esbqkK/5R3tXu4+3gjNarc5FoV3qhSJ0X0wNQht0W0ksasrbtMk3nykvbW9y+h4ydYA28F9AUCjJa8stHeIHaSfTd30o4G6fVHOFWoFm9bcVFQpJ/QnCAz76Qjn/IBPEtTNYLn9fyeev+VUKFAEdCe2PbLOS1FmyGhldIGV0QgzG1GkKifwhC313gRIBsQTjaDs3cdxYTvtiwHBZSSAIIclI1Qn/9o+BwPC188i42K9A==
Received: from DUZP191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::14)
 by GV2PR10MB6456.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 08:32:39 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::46) by DUZP191CA0047.outlook.office365.com
 (2603:10a6:10:4f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 08:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 164.130.1.43) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=foss.st.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of foss.st.com: DNS Timeout)
Received: from smtpO365.st.com (164.130.1.43) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 08:32:37 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 1 Oct
 2025 10:30:20 +0200
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 1 Oct
 2025 10:32:36 +0200
Message-ID: <e2fb89ee-21fe-4500-aa84-41cc9abc010b@foss.st.com>
Date: Wed, 1 Oct 2025 10:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH] PCI: stm32: Re-use existing error handling path in
 stm32_pcie_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>
References: <e69ade3edcec4da2d5bfc66e0d03bbcb5a857021.1759169956.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
In-Reply-To: <e69ade3edcec4da2d5bfc66e0d03bbcb5a857021.1759169956.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|GV2PR10MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 813b33e7-190a-4afc-d102-08de00c51434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWR5YzR0UTkwK1RnNnBmK1hnbU5GS0psUFpiekxSZWRzWThqZDdkbFRQT0d1?=
 =?utf-8?B?SnNqWVBCT1ZOUHE2a2thUm52QUVIM1FiTWVaWEZuczBPWDhPOEZOZ3FpS1Iz?=
 =?utf-8?B?YXNhUVUwMXUzYk9qNGd5OVk4VjhwcFJ0dGcxVHNlaVVPcEt2dE1naU9WMVVR?=
 =?utf-8?B?R1pESUx3MitwRjh0c3NwU1pzVHkwczVublhNbzZrM2UwYXE3V3RpeGttY0xP?=
 =?utf-8?B?WkZKNXVTQkVhdGxPQWxyMm5QSFJKVW9TdGs1WE96UHFVdUw2MmdMbTY2aVc2?=
 =?utf-8?B?UmZNRWIvSnRLemhEWWowTzVPVEVUd1U5OGF0VlQ5TWhvY3Rrd1VIbGE4dlYy?=
 =?utf-8?B?NjlZSlVXelhaaHlrdjVhbktyRGI0Mzd2anFzVHB2OVplY09HalRCeUFkU291?=
 =?utf-8?B?NjB5dlJWYmhGZ1NsM0tSSGNHOTBsQVhXdDhTWW0wVG9xYUk5OGxsNHFHS1or?=
 =?utf-8?B?OEJDN1RJTDJKcXpzSXpPUzd0S25mS24razU5TldxVk56bU11NFBiMW1ZUXVS?=
 =?utf-8?B?RnAzMGVWVEZodTA5MjBxbU1qc1JibzJySXdqV1M4ampYbE1JZW1CalRXcFJh?=
 =?utf-8?B?aUd1eXI1bjdXNVpqeUdhc3JPOW8zK2JHNXpIZTFsMDcrY2FsQUN1OElZOGsr?=
 =?utf-8?B?TWRCakJ1VGVhMGV2WVV6STNKSmdiT3ltOWpaNEZYb1VJWnZQOVczdm55R0tk?=
 =?utf-8?B?VUpEcVhJMjNkUVdibHQ1NmhORTdHOC9vQUZtSHNOYVJQMU1vVDVWMGFpT2dO?=
 =?utf-8?B?QlBQRHdJMG1wYmRvV1FiQmJxM0Z0SHhGZFBnby83ZVhwNXN5a1hIdS91TGQv?=
 =?utf-8?B?STJSQmdZdEQ4RlVrZDJLZkR0YWRBR0ZoY3g0RTVwc1RHN2VXQktJcVo2UTdC?=
 =?utf-8?B?eE5tdzNENDkxZWt0MVZhY1JnM0cxdFhzbjdxRHVFcUNWcVg0RVFMb2NJNG85?=
 =?utf-8?B?blRKMktqZmtydTNvNTNoWEY5SkZQeXNsbDRjYlhaajBjV0dxSTZMNU0xN3h0?=
 =?utf-8?B?S2dFTDExRnloMG0xTTkzSDRybW01Z1lHZ2poblViUm5BdlZnSWwxY2tsNTF5?=
 =?utf-8?B?bm9DOW1DSktnTkJHV1V3T05STG44cXVkVVpHb0NIejJtMllHZlZaZ0xkanow?=
 =?utf-8?B?dWVsNDAwMU82OGdhckl6dXZqdjA3cUVXeDZtcXc0N1ZsOC8xVHBFNDlFQnNB?=
 =?utf-8?B?eVdPRlViT2k5aHVGaTVPaTlRRHcyRFRIcnZBZ0dkWStXNC9IS0EyVWlMcHQ5?=
 =?utf-8?B?bEM4YzAwczlITTh1QnUvVlNsUVd0RmxaWkR2cEp3MDFsZ2U4Tms3TTJsbHNB?=
 =?utf-8?B?bUMrODRCeTcyK1RHdUhncnM3ZmxHbk52T1ZjWXdLQmNyVU5nMjFyV0JyWG5v?=
 =?utf-8?B?QnVXQTFlK01Zd1JGMngzUi8zRDZEbFNRVUpONHZ1c2xOYURmWFBOT1p5eHow?=
 =?utf-8?B?aEIvLzZvWTR6Y2dnak4zZFVLREZpRUFIUlgrcUI5OEVrL1JONzJWQ3NuVW42?=
 =?utf-8?B?Q0hyc050bnFlVG9DUzliYVhQVVFaSU0zamkrdDYrK0VSQ1VCY1Nuem52T3J5?=
 =?utf-8?B?VDVkUjNzQWE1QTBaQUIvWDdSeTNnbmJzRHhWZk9GNStJbXVINzdnaXozeHFi?=
 =?utf-8?B?VFZaNnU0Znl6ckRkL0hQdW53R0VCamVrczErbW44V3c3ZWw1K25ITmpIenJO?=
 =?utf-8?B?QStjeHNSUlplMWp3OXNaUVl4TzRNc1lSZmVKZFpJMklWbGNYaGI0cVVXcWRR?=
 =?utf-8?B?NmlzbDdjSnNSTVRnd2t6WGJNaUdDQWFlb2R5S3pjM2Y1RUVtelUyQUNCazFx?=
 =?utf-8?B?T3BoWGs0NXB5a2lJeitaOGZkWGRrM3Z6TTlQMDFuczhJSHZRVFZDMERMRXFl?=
 =?utf-8?B?czZGeCtzT09saHZBTW0xMTZ2K2tkR3U0eitGUXMyWmZ3aktUNVBaUGNBQVEw?=
 =?utf-8?B?SEN3K3huaTVqUXZGTE1GbHNhVW1USnhLQ012SjY0SElUMzBZalBzekpRZ2dS?=
 =?utf-8?B?Mm4vcHBFVFhaRER4Qi8wb2dCcWZSSjFOUVp2bWRFOGRwdThJeEJ4R2RENUdw?=
 =?utf-8?B?ZVVvMFZmYTR2VndZNDNVZ0dFTjhQV0hoNWkwOVpRdlh2TS96UDlqT0lVejJa?=
 =?utf-8?Q?FkJw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 08:32:37.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813b33e7-190a-4afc-d102-08de00c51434
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6456
X-Authority-Analysis: v=2.4 cv=OvpCCi/t c=1 sm=1 tr=0 ts=68dce72a cx=c_pps a=dfNKJ7ui8O3ZpShtseK5KA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=qYLaA9J871Yo4zmPblsA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: PtI4WisbNDg7_tiPwD_GBRQWCYkBQGtC
X-Proofpoint-GUID: PtI4WisbNDg7_tiPwD_GBRQWCYkBQGtC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDAwNSBTYWx0ZWRfX/2sH8HDLB7na itCELVbT1y45/qFFlh6iFd7jl4YJxVA9zRgV03C3bZXJg5nBbS08AExagI1rEeslnSeNuv3+nzC sY/tYABaCTQ65L7B/krlDpoPJRSXoEHdbkKDUxHf5AfCsQ+fAvmeg4bKrPUEO+nUYHxyIElWwL9
 thCW9dqdIYu42sZMzIyG3RJ8Ml++HbAQAFA1vfFAFuJ7okfTW+dtyzKCRY8/AAIMbRZ5llRckYN 2+Smv1im21jAOV47ZPIjHrD7TdXh/r3fi5D2TJp3qFrMr9Q/ek4XGYszJ23AQCtAQ0mkoaz90at J/x8zYlqm/Ou4+VfB2/ODT/SRd8ENgnZV3JVkVAhpDF2pU4UgbLsEJ+CiGVZnANGKvxaYPGRkDs
 G4/g+SKDdJzXq84Z9LbVrHhalnr3+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509280005

Hi Christophe,

On 9/29/25 20:19, Christophe JAILLET wrote:
> An error handling path is already available, so use it instead of hand
> writing the same code.

This fix is pending:

https://lore.kernel.org/linux-pci/0b8b8cde-d273-442c-8537-3fa95885476b@foss.st.com/

Bjorn, Manivannan, gentle ping

thank you

Christian

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/pci/controller/dwc/pcie-stm32.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
> index 964fa6f674c8..96a5fb893af4 100644
> --- a/drivers/pci/controller/dwc/pcie-stm32.c
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -287,18 +287,16 @@ static int stm32_pcie_probe(struct platform_device *pdev)
>   
>   	ret = pm_runtime_set_active(dev);
>   	if (ret < 0) {
> -		clk_disable_unprepare(stm32_pcie->clk);
> -		stm32_remove_pcie_port(stm32_pcie);
> -		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
> +		dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
> +		goto err_disable_clk;
>   	}
>   
>   	pm_runtime_no_callbacks(dev);
>   
>   	ret = devm_pm_runtime_enable(dev);
>   	if (ret < 0) {
> -		clk_disable_unprepare(stm32_pcie->clk);
> -		stm32_remove_pcie_port(stm32_pcie);
> -		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +		dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +		goto err_disable_clk;
>   	}
>   
>   	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);


