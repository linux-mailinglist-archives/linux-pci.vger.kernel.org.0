Return-Path: <linux-pci+bounces-41216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CDC5BD5D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 08:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776273BA15B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7A2F7AD4;
	Fri, 14 Nov 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dNLHxzlh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB515E8B;
	Fri, 14 Nov 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106387; cv=fail; b=tRLjlggvod2nTYfxJE4Y1qp2TF94ETw7POeuBh6rJjXfqsy38h7yiwg1uPD1DAiEFkID5AuXY9R7+Dht2kqwvcYDxnP0VCEVcLNhl1+0qr4ylh/kfUCDH2Xkn+D4Ph5p54QqViKUXAYEG7Sg5o7MFcu8/BRTjT5cjOvLMMuXYyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106387; c=relaxed/simple;
	bh=RKaFqM1zvj84dY+Rz3ny3TZI9L0ZWpyA/MRg7y6WRVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=b2Pq/LYH++DzZhCZCvgX20M0eAlDj6SPXSqeu7gw6YJ6omp7zleM1EX7K7gYvYm3k2o+HQhkMwU8oIO4J+aUR5uSbPazIpKEy54vetKHp5aHSmZSEA/w3zO0QBWHzcsfXy7z9NOMq5EpQ/03tlgircv5IN7f+yLQsnYtmEn66hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dNLHxzlh; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE7XaXp1689467;
	Fri, 14 Nov 2025 08:46:10 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7j1mr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 08:46:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqf6OYxCNWV381l/uZors4/gVEWZa0MyOGg16kNBmWZZV8kpQdrFVpyVmtYQs4ITSidTywStK9FsnrKTGhMf9Cgacb0lDsm+Ughcvj/pd0HqzvToeJucuVnd22vqWd6UjRbkwCe+tckXxTgGWFKj2z53kPBxEwY0X8b/Ypd7jSzbUA9nExgCyADzrsmzUPqqKKh2OAdLkitkrUXbJZzYFaZtB1fS1/aGVX/nRa10eL+8bJj8POkdSq4BeDA+t8Lr+W8CSdKkr65vra8U+NgmmHcbwOqm2nN9kcRmRcs4VK3xZngXVnJbyN7HExPpywmc8uquAfDF1Fl/IQUYxiwM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22bmImjJ5+Ac6HPAQVjZXfTfXAVtbXbfSMl2sscd34g=;
 b=xYpl/2BH2265nwf+1eTAnsCIVujkq5BueIiafdTF4+6wpVO19Evs/vi4it+OM1vCynu+jC9LlV+QVBdRpwwBmyKZYWUKrIFE9QgOompbiQCoRzfakXU4DPDHnQonFqXggAlbemoLkIWvxSVWOCJ5H/CFIOoSo3CFXHiR/81IMD2yq3Ga92RxIxwKU09ggnUi1VxfCDfGkw7mH31/AlaoN2Dkggr51KGPR0RQrzfapFUWeMa1AdTfNHQ15RxO4Xmag3fygW+kg2xQD49F8+oK2qOr7ljrbs+EzN4f+FnDcqbq1XvYQeisrYeunN6PmAYzc3ZlrHZDSrGcNl05e2XZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22bmImjJ5+Ac6HPAQVjZXfTfXAVtbXbfSMl2sscd34g=;
 b=dNLHxzlhGxZSHLPizQSqPfRUK3WVQ8+Q0w1rEY2W2iH2TS0mrFu6w+8pUm2klCR5nZXG9pQ51ffoDD/wwq2LOj1JTwI+gw2uNxbEvdZAQJNU6nzmy0X86rPbdbgKVbtuxyhO76lLQQOGUgNnTVvC7dR/XAm1mzE9erbOU3OXM0mmNUlS//zaNCW1HZ7jF2RoVAibL0XdqDA8fdtHRYf2kmhvtPJ7qgsHibF291Pp3tkfROsKCtsTGZNTyjjx3dXQvRP4zq0sGFzI16NM51GPoCnqIuq2omU9VkvPWLrlJ+LzjOftX+7q8WJVLc7LSe8oGj56wn4gy70BEPOm71Yfvg==
Received: from DB8P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::32)
 by AM7PR10MB3142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 07:46:07 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::11) by DB8P191CA0022.outlook.office365.com
 (2603:10a6:10:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 07:46:06 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 08:46:16 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 08:46:05 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Fri, 14 Nov 2025 08:45:52 +0100
Subject: [PATCH] PCI: stm32: Fix LTSSM EP race with start link.
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251114-perst_ep-v1-1-e7976317a890@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAC/eFmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0Nj3YLUouKS+NQCXYMkU/MkSzNzy+Q0SyWg8oKi1LTMCrBR0bG1tQA
 vLg6dWgAAAA==
X-Change-ID: 20251113-perst_ep-0b57b9679cf9
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>
CC: <linux-pci@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christian Bruel <christian.bruel@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|AM7PR10MB3142:EE_
X-MS-Office365-Filtering-Correlation-Id: 582aa1ad-9180-4fde-42f9-08de2351de84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDlUTk9naE8yTzBwcFhCaXN2bS9iNWx6Wk9mWUg4VUtHbzNNcFl1cUdYUVk1?=
 =?utf-8?B?cVE2SGZ0WlZMVjJ4dWhzT002U3NnQUJKN0g2N1UrOHRxaFJ0VXpiVHIrVmdj?=
 =?utf-8?B?U1l2MEZKSHVMM1ZERktzM3lmME1LNEZOS1VVQWMxVzdlUnUvaUNYU0tQeS9x?=
 =?utf-8?B?Y2IyRlF6aDlaRkhseURSUVJuSHR6TTlIajhyZTl0TFBUVFhHM21ybVlCR2Rh?=
 =?utf-8?B?RTluVEVPZ09rMEdQem1LL0Iva3FaTkNwZWV5VVV1VmFITThxRm1sd2xxZGVJ?=
 =?utf-8?B?bFNhUUdFWDJ5OWsyb0tFeisyMmxwYmNDUzFFa0szeXpVUHg5NldreFE2WkFh?=
 =?utf-8?B?Wk5zQklVT2RBdHA3SUo3b0l3NEVvL2JlYlhkajI4RGxCdjFEWE8yVko3WmR6?=
 =?utf-8?B?OHZvQWhjSHI0N1pyR0Jxc0JvYXBqVUcyUlB2UTBPRmVzbE9mRTJYL3JlekNn?=
 =?utf-8?B?ZTByenI0WUMrUWY3cmdGeHgrM1VkdHNRSUtkRTRsSWIzUGJ4aG10QVRyUFVT?=
 =?utf-8?B?UW5aTTR1L2I3bEd4ZGxhb1dNUENMeGlLOHZLVmt4R3o0Um12QkJFbGJwc1FV?=
 =?utf-8?B?ZzYxNEZHZHRYQkpJMlVqbVdibS9waHJtQ0MvcU1mK1EvM2Qzek1NaG5KeUlu?=
 =?utf-8?B?SmJ2RDlyRGNBcDN0aksvSU11WTA0YlNKS2x1YmJrYU00TWNUSDR1T1dIWkxK?=
 =?utf-8?B?RXV0NER5RjRkNmF5YWU0eExmTHJ6ZEhxeWc3Vm1nNVo0eXVhTllHUlBtbERt?=
 =?utf-8?B?VXYxNEd6akFvaDU3QVN6ZVNqTFE5TEQ1am1qWk1ZbHUrVThaZWltSy9FZk45?=
 =?utf-8?B?VStXeE5uQ1ZockY1QzZBQmIyMXd0OE56dkZPRHNsVHZRdWcremhGRVlOQVdk?=
 =?utf-8?B?RXBxVmY5eWNiNDE3TmxYQnJEWTIyaFBTSmdvWGEvdk9zWUJKK21hN2VIeW1E?=
 =?utf-8?B?aEp5K2UxQXBhQ2Vha0xXTERhUVVSWTZ1ZUxQbmo2ckJ6RUFjbDFPUGVmdUkz?=
 =?utf-8?B?NjJ2ejd3ejdmZ3E3bWZQSys2R09aV0QzMDk0Q05LZjJ0blVodUhmMy9Zeitu?=
 =?utf-8?B?NWZUTTQveFQ4UEhlKy93M3dKWXB4bDNjMmRCVUJVM0ZTemFKblB5ZU85OE8v?=
 =?utf-8?B?TTRGZUVTNzhnKzBHM1JOUFFmb1hEclhCQ3FIRHZ5SU04WHNveW05UDRTQ3pN?=
 =?utf-8?B?d1llZDZ6cWc4UWx5WS8wYm5XcmVZS05VNG5kcWhMMm1sUmQ2OVFnTXhTKzdn?=
 =?utf-8?B?UWVaR0FSOVNtTmRZam4vUHZhNkxKaEMwZzU4TmVJbzBvZHQ0WE41eHVDbkpD?=
 =?utf-8?B?akpmdlBMd1lFMW8zdEZTMUJPSTJFOXVRNFYxandJM3Fib3NYanZzMzBLNys1?=
 =?utf-8?B?cEV4TVRsNEMzYjl5RGxWMnVPbmw2K3ZZSjhSYzRIYlJhcGEyblJlZFgyb1dX?=
 =?utf-8?B?K1Y2ZUdoTWlzSTdtRENWT3FvQlNSZTJuZ0FPQTVQTG1aNUJFc0d1TC9VRzU4?=
 =?utf-8?B?Q0Zid0lsQU5XYzc1dzJmQmZKOXV5SHhVZEZsUE1lWTB0NGUrWnFXMk9hdFd3?=
 =?utf-8?B?amNDOXBKQ3pwdEU5NVJsL0UrOTljSDl4OUw2ZzNxQVdWaUV0U0M0V1VuWWJa?=
 =?utf-8?B?cm90Z29XYkllblNnZXp3SHBFWE5RTGtMakp6RDJCbWRwNS9kVG1mbUhwY1J5?=
 =?utf-8?B?b3JGcnBTa0xKWkdqb21wcnVNZlFkU1l3eXRtczNnSVNtSUFWZ3crZGxacU1I?=
 =?utf-8?B?YWVpb29BS2tmZnhKbTBBMmlZRVpxckdFOFRsS0szTGh3NEczeXRBWTExQW1l?=
 =?utf-8?B?UlFOdGllV3cySEVnNFRpK1lBVFRvMVh3aG9HZCt1N0RHSncvYW1hVDAxVTRO?=
 =?utf-8?B?Ujk1UmxReTF6QTdlQmp4UGxoTTVDYzU4bGdVRDJ5djBtamNnMU9SQ1hSWkRz?=
 =?utf-8?B?SGRJTklHUnpKZFFUYXFJSUxwNWhmU1JFa2FSM2pka08vRXhycEFIU01tNVR1?=
 =?utf-8?B?L2NnNnpUZys2eTM0VkE1eTFlL2lyb2I0Tk4rNE5Vb1F2cG1FdnMxdno3aHE0?=
 =?utf-8?B?b1hXME1qR0JhcWg0aGtjVWtVM095UFRRdFAzM2RPTS9KMyt3Qm1wNVJQbjd2?=
 =?utf-8?Q?HAZw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:46:06.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582aa1ad-9180-4fde-42f9-08de2351de84
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3142
X-Proofpoint-ORIG-GUID: Kfowze3cVYpml5vQzR2vq7YHWYEDczO7
X-Authority-Analysis: v=2.4 cv=DPqCIiNb c=1 sm=1 tr=0 ts=6916de42 cx=c_pps
 a=1PHydY8sO1AsXBlMK61GcQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=kg8jcdQ32g1nc73lLdwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA2MCBTYWx0ZWRfX4klsyH19fKS5
 2pVbJSQdj7GzQoEQKKQBwxA2kybavo0GbVr2jqrtLNwMw3eJ2RLu7Aq+s/qTUmKAyEJpjRqsGEb
 SPELIqRAJfzPs4xETp2xYo3SXY8jmhlvZhXkjbWwucp3Gb4jAOrlO75kB444p89v+Q1xcMFB/I/
 cTgetZoBK3wP5iHvjMSiQCmrcH05gjjHrz0UKMENUjzvuwZ/KJyA4NNBqScZnboRQaujqmiWF+y
 xIauW1QUdTmQ95Iu/bPIYiam+r/F89kpuD5kTX6LqwaoeaCxqge2NjNx8EzLM8Iva3j+SM8pqTj
 t+aJSrmayBHoaXGGtC3hjFisJzcTm7yDSR4fUqHQK8QMA0dvjMuWDiBxyOdtqhhTbPO/PQYzDji
 WX93e6JdV/FqoFpN/mt7CNT6QRYAiA==
X-Proofpoint-GUID: Kfowze3cVYpml5vQzR2vq7YHWYEDczO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140060

If the host has deasserted PERST# and started link training before the link
is started on EP side, enabling LTSSM before the endpoint registers are
initialized in the perst_irq handler results in probing incorrect values.

Thus, wait for the PERST# level-triggered interrupt to start link training
at the end of initialization and cleanup the stm32_pcie_[start stop]_link
functions.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/pcie-stm32-ep.c | 38 ++++++------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
index 3400c7cd2d88a279c49ef36a99fc7537c381c384..d0654bb43759bb8d0f0d7badbf7bdae839241fcf 100644
--- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
+++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
@@ -37,36 +37,9 @@ static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
-static int stm32_pcie_enable_link(struct dw_pcie *pci)
-{
-	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
-
-	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
-			   STM32MP25_PCIECR_LTSSM_EN,
-			   STM32MP25_PCIECR_LTSSM_EN);
-
-	return dw_pcie_wait_for_link(pci);
-}
-
-static void stm32_pcie_disable_link(struct dw_pcie *pci)
-{
-	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
-
-	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
-}
-
 static int stm32_pcie_start_link(struct dw_pcie *pci)
 {
 	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
-	int ret;
-
-	dev_dbg(pci->dev, "Enable link\n");
-
-	ret = stm32_pcie_enable_link(pci);
-	if (ret) {
-		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
-		return ret;
-	}
 
 	enable_irq(stm32_pcie->perst_irq);
 
@@ -77,11 +50,7 @@ static void stm32_pcie_stop_link(struct dw_pcie *pci)
 {
 	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
 
-	dev_dbg(pci->dev, "Disable link\n");
-
 	disable_irq(stm32_pcie->perst_irq);
-
-	stm32_pcie_disable_link(pci);
 }
 
 static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -152,6 +121,8 @@ static void stm32_pcie_perst_assert(struct dw_pcie *pci)
 
 	dev_dbg(dev, "PERST asserted by host\n");
 
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
+
 	pci_epc_deinit_notify(ep->epc);
 
 	stm32_pcie_disable_resources(stm32_pcie);
@@ -192,6 +163,11 @@ static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
 
 	pci_epc_init_notify(ep->epc);
 
+	/* Enable link training */
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_LTSSM_EN,
+			   STM32MP25_PCIECR_LTSSM_EN);
+
 	return;
 
 err_disable_resources:

---
base-commit: 31115ecec74fe5c679a149d7037009f26b3aa8a9
change-id: 20251113-perst_ep-0b57b9679cf9

Best regards,
-- 
Christian Bruel <christian.bruel@foss.st.com>


