Return-Path: <linux-pci+bounces-35534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E8B45D11
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954E41885A91
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56F31D741;
	Fri,  5 Sep 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cqn+RTfw";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="p0vnOdXL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F831D72F;
	Fri,  5 Sep 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087616; cv=fail; b=SB9v4bA4gc90Tkd2TfQR62c5f0dmJtQyL5plsVfx4NMFmni4nwuDhiMBe4Bk+zi8rQ6L/3Pq+YTd2xXGnwQ6QEmZiX7PBcXAjedkYjvPpSCtLAoMEsbAzvQzxPWRWKqEMJkTk4fseeK/FlTA4m4BqwUJpWAEOkXohpOkZ92p0l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087616; c=relaxed/simple;
	bh=CLn4R95xpcMQaF7j+1Zg3BK6GGwUQPubJXDIHaMMyHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TmCYSCxxt1yr45pIp01ZI25UVoG7v2K0dajzIWpeuf12uaff7NaQEOV6ct3o4b44cWrmAeodMrFxZwey1GvkpLKMp4lTLwz+Vn2DGbuvbPIXqnGVBnbb90efLahHcwngCbI2hklLTjsyquOUNZWJG7UxLL3GoKL55xnoo7TL25U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cqn+RTfw; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=p0vnOdXL; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585FEwJk020399;
	Fri, 5 Sep 2025 17:53:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uqSgHwJcM5a6UBG0RlBxGVuzV/M9wYyaI+Zixod5o1M=; b=cqn+RTfwk1Bjafpd
	YEJnRj5wT5JPJ5ef+Y7BxLFYctCJA/490XAofxper7+XAQ85NniGWEJakjugqbLy
	Utb4rWQhZoYcnLuC+20OdhyYaDXMBE/RUG6JDaUFNsLnLVXKsvDDHbzdtViSPSd8
	zl21WOf1NCgUjK8VvxSrXuHDAEA/0PhSoULD/QdZZ1cN7nfZqgPAxPX8xa62urQD
	PEBU/4RMp0xvCrK8gyOgDMcdrIsXtmlCsF3ufhPoszKzI0eay/Lqt+Sy1K+HnTIe
	cQvafQk+GZFhLSdwo5Ka0KMMXHv8Jrb5R+r3vIVqpv2f0Hv0B8dWRnjddoBOzGzg
	YgFKQA==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48ur6g2rgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:53:21 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtOLkGeoIZJrcWTAcak2GD6K8chr9TuFVXK44VlTLa2J+c20ckKpyQRaUxiDHaxXGtQwwdK61FM99htpnVSAaLfrasvIeq8ucMa87abvBDWz3NONzC9wa5LKagn9tEZ/02gVvvbbt6XzHsbW/15Hco4sMEb2ihhIQAOg+14c2JlZmKtg5z5m8WQeI+wo6TKtWEMVx/H3L2Z2gyLFht0YQJDXH8PcXq2rmwH76mvzIGNaIHfThnJAzLpDiLIBxmis7cMhUB4g5wU0p5m1BKKOCGDR8wHRePO2gtcq4uOmq2POg/Lei+8KhgKBRhla1knvsNJQrN5QGRxhESQjITHNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqSgHwJcM5a6UBG0RlBxGVuzV/M9wYyaI+Zixod5o1M=;
 b=Kh4uo2r29JXnJ1XpD1Eedj0YEZsYuQ+UcZl8Aswd0IytFPvSbb80LT7Hs6k8GATx2+poO/ezAe/GB0FRYkSnvYLN18k/x+n1fnwfKnxgoKf/7gBhnqZ7WfZMNkbBNofpdNNzx9iwkxkmKs5qWXnfOp2URUxgaf1Xf5tFrtjuNTc9jts+CksSzg5Rv5bVzR72OakN3w28K2KGbXJAch7z5Yxr5Aw+a/2GMTqHrmzcFN0TJt+Z04lHxpbDEkgwCtLkRh4VaoQrVZesNnH49BsdPdQVMx1aYrr5vpjPiu7tIGq5+glkAE5fN8M8ljkn9a1KKYdbvMBuL3gjjTcKlvoLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqSgHwJcM5a6UBG0RlBxGVuzV/M9wYyaI+Zixod5o1M=;
 b=p0vnOdXL0nUKc6Ghp7SHLqejPWmNNDEysSZZYc/7u1AJD511Yl5OoYDWiKdvn+OLN/2BIB88gsrijSxtAPSOseJEA09+ywrFAGyWYxgRy2usKnkppd67q2hK0609zbEmrs9kNAYGEKHw6f2cpqcAzHXkEsT/BAhx+VnnKUGWSq4=
Received: from AM0PR02CA0200.eurprd02.prod.outlook.com (2603:10a6:20b:28f::7)
 by AS5PR10MB8271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 15:53:18 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::df) by AM0PR02CA0200.outlook.office365.com
 (2603:10a6:20b:28f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Fri,
 5 Sep 2025 15:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 15:53:17 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 5 Sep
 2025 17:50:59 +0200
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 5 Sep
 2025 17:53:16 +0200
Message-ID: <0b8b8cde-d273-442c-8537-3fa95885476b@foss.st.com>
Date: Fri, 5 Sep 2025 17:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: stm32: clean up some error handling in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
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
        <kernel-janitors@vger.kernel.org>
References: <aLqZhL-DV4LOnHlD@stanley.mountain>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <aLqZhL-DV4LOnHlD@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|AS5PR10MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 83046136-2576-457d-4b69-08ddec9454da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YngyMlBKRHkzT3JERnYyZWRncWorMnNUMWtJMzVXbXM5T0orUmYyaHFwSnFv?=
 =?utf-8?B?NkV3cEFGczlQUzAydkJnbnF1dXJpWk8zMWpXSXBBRTEyTHZkeE1TSkhyMG95?=
 =?utf-8?B?UUNYbXNmNHRYWXg3N0c0Wm1sbmpVbk9KU2gzR1hzdUQ3VEZCOURlSzFwZjYx?=
 =?utf-8?B?azBaTzFNNFZETURBam1lQXpYd3N2K0Y0MDNjREt4cEJBZ1ZGNjBUVFdUZjV2?=
 =?utf-8?B?c3BQTVBwRUhEUUdyU251WDFQbkdHTkhHM3JkanpqeFVwNXMxSldiYW10MkY5?=
 =?utf-8?B?RXZZR1Z0aVhGNnZXUk82Sll3YXBvWVVRaU9TZVJjckl0YkkwdlBnaWFBSVJI?=
 =?utf-8?B?YUZ5aUdwWnFwc3lmUjdCM3pZZVNzZlk3Ryt0VHNKbWc0b2hFSVNFOUtGdHZI?=
 =?utf-8?B?Vm84MEF0ckJ4OUw5cWVpVFNzdGk2LzFEYU9tNUxtdUdlZEVoVmhGSWxxQVBG?=
 =?utf-8?B?MWp2WmNxejN5MVFWa0toZ3lkMGxhSkhTRDU5ODlzdlJrd1hsSmE0T0htVUwy?=
 =?utf-8?B?ZlFBY0pGakRXNmlpQzNVcExZQWp0RlhUY042OERkNkNWN2hxOXk0aWZ3a2Yx?=
 =?utf-8?B?Ui83Z0xTaWp2MFRLYWNuT0dqbkNMV3dLdGdsRUtZRFBucWdZbXFwRm9nR0xV?=
 =?utf-8?B?NmoxTWE1anAxWUdnMGtyYVlvMklyYlFNU3V6NE9SZk5iNG5ReFNOYldEVzhs?=
 =?utf-8?B?RXNsc0NyVE9BUDNKb29QWGVPb2Zra3pZWmFWQ1BhUlhYM1pmdXprUHpKbG5q?=
 =?utf-8?B?UnIwUTZvSVovdzVZa1o4enBpYlhBWVByWG91eitWdnBYMCtrZUZjY0xzcnlv?=
 =?utf-8?B?MGcxbmFsUHpmdWFzME4xRlVwK28vYm1JTUtUdXpZcUJqRHhQaEtLVE9UL2tB?=
 =?utf-8?B?bmVac0VNRjE2SmpxWjBKY3A5eEd4UVJQOUx0VHEzeG5NaHlleUFrMDJpRGk3?=
 =?utf-8?B?R3ZZWG1yckEyRWV4YzhLUGsyQ2R4VDN2a283YVVMRW1mMytaTkx5TXVjaGF4?=
 =?utf-8?B?UHZHYkljL1BPQjJ5QUUxeGZXNW90bllJTjhDUEFwQm1WakhVeElPa09BRnNN?=
 =?utf-8?B?QjJNVWVxbEdNeFQ2KzdYVm4vdzZXQXpMRHRPN29SV0FxR0ROVVY1MUJRUW9V?=
 =?utf-8?B?aXprTTh3bzR0MWNqRkoxZThONHNTUUcxVldCcmlHSkZtbzdQcFJjU2VTR3ow?=
 =?utf-8?B?emtDR1o5ZVpacmVsZ082NXFOUE53SDVtYnRDZjVWbWxuaE1qSk82MmRLSGdO?=
 =?utf-8?B?Z2NiSHhvZUw1UnhRSGREcjdPdVhZNXAvQnRYVzB0aW8rR25jd0hQdVhEbnpU?=
 =?utf-8?B?QXJETnpLV3F1OUhjY2h0cGpPdnFWOUhndXVvaEFOKzZGbDRxNlFVY3YyR0RK?=
 =?utf-8?B?QTlqb0cxeEs4VlFEUGdabUt4TGt5SDd5dTY0QWlISktZRUpjMWhzYXVKZ0Ru?=
 =?utf-8?B?TU50VXMrMTZKRUZhYTZqQWpteGFqemlCNS92WGtVc2RBYzAzNVZEcmNpWXFx?=
 =?utf-8?B?UTlleWU3SUV2dFg5R1dPN2pxUUowLzUzekJhVnJrOFZlb2RPSXZBdnh3Q09u?=
 =?utf-8?B?WkgxSWNuWkhOOHFBdlZzWEpua2o3VXUzOHQvOVU4a0prSVFZM2prbU5nOG05?=
 =?utf-8?B?dTFxOUlpNGZLY3ppaG52dzhIQ25IQ1JFZmQ5cWZNL1MxWlFmUXlRWnpNL09N?=
 =?utf-8?B?QVVMQnhNMmtEbWUrRnlkQitKVHZYeG1kMGE1N3pRRUQyeVBlczB0YmxYellG?=
 =?utf-8?B?MWNFUjhqWmlKT2UzbGZkT2FNRTYvVWJVN0g2bTllTTZBV09BMnY5YVpMcWpn?=
 =?utf-8?B?RDlNaFFweVVYa053NXAzN2VBRm5kMk1udzdEVU9qbE54SXNCZkNNeFlWdnRv?=
 =?utf-8?B?VUIwVTJISVRJQjQ1clBXemE2NStjYlRNdVlLZGluUlQ3NXd0QkJ6MTJVaGFS?=
 =?utf-8?B?S29OODhCNXc5U3NHK3d4V3hRZEI1SDlsNWNTRklJVHdFbUJtTzB5OFFpaEUz?=
 =?utf-8?B?RUdTb01WcEZFWnI0YWRzRjhuM3RwUzdpQ1d5L1pFeTlGR0NDaTVGY1VnLyti?=
 =?utf-8?Q?50ZvjT?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:53:17.8547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83046136-2576-457d-4b69-08ddec9454da
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8271
X-Authority-Analysis: v=2.4 cv=Ts3mhCXh c=1 sm=1 tr=0 ts=68bb0771 cx=c_pps a=Wm5aeSjH12BsbKEBP/jB+g==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8 a=q1KfpsaXvnDjR4ywVUkA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: lBPMWtHuKhwXcpyGlvsqmY5fgawXkqt-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOCBTYWx0ZWRfX+yf93QAAyxYk BhrRkxgA3FQzCra1MrBDnbtRlxc8MmqlIcuK1O/GazA6E1eGG5BQR66vJmufqKrE/GgiO29X1DL vh6zW0G6h/SMtT9Wvt7AoIfv9mDJu34L+kk72l5EtGRHsZtd0f2CwMnKmFX6hUb963cIveOwgvQ
 y1EvioZ2pU3Isq0x05l5VP/rv1s6/qJf0qvUkPm5Cre2+qh1Y/hpCXQtObopS3JQOnGepy29eru k3/itiLRGI0OA2VknqPNsNKD1Lm+AYQi2oCM+elOseHrq/ixI3QmmjarKw5c4YS+Vw+PLeCkIxY 5OE5Uze77SPn5nsB9U3Gaold5tp2IQY6+ACjYzFzdgj8IohU2/9C9ia+E/GiyXTUy39nDDVbvYU Cz50AZR3
X-Proofpoint-GUID: lBPMWtHuKhwXcpyGlvsqmY5fgawXkqt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300018



On 9/5/25 10:04, Dan Carpenter wrote:
> Smatch complains that the other error paths use gotos to clean up and
> these two don't.  Generally, the implication with that warning is that
> the error handly has been ommitted.  In this case, the error handling is
> fine, but we can avoid a bit of code duplication by using gotos to clean
> up.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
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

Acked-by: Christian Bruel <christian.bruel@foss.st.com>

thank you

Christian




