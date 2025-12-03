Return-Path: <linux-pci+bounces-42558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4BAC9EB93
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 11:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F2DB4E1013
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930B2ECE92;
	Wed,  3 Dec 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gB9xeZn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FD29AAEA;
	Wed,  3 Dec 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758004; cv=fail; b=uommvU04pUMW1XI+ezfBSuehN9KEQ5lg3GWoVjHwXJ1/omIiRbOYrSeAya0KBEHi1eRQN+SOjEueTFxQhMq9BaZ317oJcaZtfgVsRb8MhMHykpBDD5SljQ3Q4LGstdXe41EBmuAVgCpcGz5d5spcKJF0JSkfvF9HEaDXn2bpEDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758004; c=relaxed/simple;
	bh=JtLVMAZOaS4QEHU4Vlj1KIYdwIunZ2kvw7KJt1VD6zM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=kKw+SCXFBRUgBMZd3bI9fH18XIUkSDiyuMGIbbz+WBIlIw9M9N3Bvu0nQibkQVPnZTIu5t60M3mSi/z0iwTuyQD0CzbYzfWtlMtJntJV2c1aVTOORLUNlVuC3p4cWSZwAxRIfedb6lL50jo/Zmcz5h4LRi4D/flL/3+jicirkcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gB9xeZn+; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3A3XIA1467141;
	Wed, 3 Dec 2025 11:09:13 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4asrfedx3k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 11:09:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOIyziN4qrwObu/Alu2hiZWRJVLPHAmoFIu6Z+aMx2/JuTIpXpfs8eS7ozV1m7yL/ykCJTYSa9Yks50HgamyhhZ5cnpMXtCGXdpy3JfMwsUW4G40tK2UAyhvXEE23h4w2nC8AqrRlPqmKpMU+m++UK5lvCVrOqDajmsMI+QEonbubcfr8aq9G3oY/VSRJJE0Vz8cYsWMPMXXc47IGNNNmGOFEniVzexcvZ5s38CH+W9fbIo2B88UsnCRdlPPCLZnS0AYAugBvVSrSIc88Ma43EFi7GgiOzrBtV96gaEWyYUXBkenhXdxmujiu9sxxPZ1axbEK6B7dX7WrBM3I7mY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMyLwWHrfU8UyGGScEnSFFAxnOdaEWmMp30Bj5kw1ds=;
 b=hfBZvbfC4aof6kScGxtwgShZWpt8XhjCR1M4+psyrRqEVDXkECnB1uACr8Vzhbrw1DjY4ZBuVcdSYNgBYiZgI6eyW3DMzJUCt+R7v5ds283l1zOp+TvItWrnKzJWFYDMxPqHZbPD0F1xHcOKYmTqyqxbm5ZRjxnwhZquHMffMVZ7S8dvGDqaibmCszVWHArc13mECeXx4fohmCKnakrttU/VQ05spn2Utl2LF98xL9krmj/W4gfEovxFfx/vuHFiiMDDPg4uuLGnWXQzLt7KNcxLvHV+GwSk9anayPQWoNCwqREHlVbo4nNN08IKdiqe5t2ewKQYDldefuTqYypx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=eswincomputing.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMyLwWHrfU8UyGGScEnSFFAxnOdaEWmMp30Bj5kw1ds=;
 b=gB9xeZn+xMhsFZ7P8EKlwNOvC09apGZVKoluVAxhbI8qLh8wnYZBEn/CEH3uXe8V8iwYKbFZs62mu/phJ37HT6L8lhonvtxDxQ5KhFTO5GXEroc6UpyEhNc5R+8NAo+zX4Vrx0cGm7i7RfOQrbtSue6ipgGE3xmtnZ79CYZLaaSEJ6vHjx+09eZBBevecS5gQmh6hydN0SAaS5pZQykLaz6hZaS13nscJaOFun3mmPQgRaSjLE/hZFbPW6K2JlGb2LtZQ/dNYnUoPxN8IM325VGF8hAzxZy0Klq1oLTwxCzMYlKH+Vrv37Dbwy1UEI6Y4O5/HMNuQKWFpYOvjqT49w==
Received: from DU2P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::25)
 by AS8PR10MB6030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:539::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:09:11 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::44) by DU2P250CA0020.outlook.office365.com
 (2603:10a6:10:231::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 10:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 10:09:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 11:09:47 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 11:09:07 +0100
Message-ID: <0d37ef61-4407-470b-975d-5f7a147f7f10@foss.st.com>
Date: Wed, 3 Dec 2025 11:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v7 3/3] PCI: dwc: Add no_pme_handshake flag and skip
 PME_Turn_Off broadcast
To: <zhangsenchuan@eswincomputing.com>, <bhelgaas@google.com>,
        <mani@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <p.zabel@pengutronix.de>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mayank.rana@oss.qualcomm.com>, <shradha.t@samsung.com>,
        <krishna.chundru@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <inochiama@gmail.com>, <Frank.li@nxp.com>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
        <pinkesh.vaghela@einfochips.com>, <ouyanghui@eswincomputing.com>
References: <20251202090225.1602-1-zhangsenchuan@eswincomputing.com>
 <20251202090434.1653-1-zhangsenchuan@eswincomputing.com>
Content-Language: en-US
In-Reply-To: <20251202090434.1653-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AS8PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 3440d928-1ef9-4f1c-142c-08de3253ffda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1ZQTDdlb2I2a0tuNEtWQ2hmOTZZa3doY1dncjBuaTZKMFlZY1RhUnNlOGZX?=
 =?utf-8?B?c2NtZ0I5NEhReTN1UDZYczZOeWxqbkU1RmtSMzhnYy94OTRvOUlpeDNkWnVX?=
 =?utf-8?B?a1BRNEtqYnZHTnM5NE1nYkxlRXYwSFltdlRScmVxdU11YVNCQ3ZCU3IzOUZu?=
 =?utf-8?B?VzYyejNwY2NHeVk1NFZTNWtaVkpBRVB2TTBFUktYbVNrZVVFVktva093dDRq?=
 =?utf-8?B?OW9jMTRTaE9sSnpNUSsybDR6VUQ1VnhNNitMNjJ4MGR6STdqVm52cEQ5bmdR?=
 =?utf-8?B?WkxFRjJWcHF4OE9MK0U1ZGdmYTBrYWJLMCsyWjVYaTRnMzBTbTY0a2I3bW81?=
 =?utf-8?B?aHJMNGRQWmd2Z0M5MlRBemJQR3VGSm1Zc3djR21oZzlPemIvbDNoZkk1ckpx?=
 =?utf-8?B?K29ZRll0bVRWQjloUlRmdDRCZC8rSk9JWDJVck1YVitBR1JLaE5lalBYcnhl?=
 =?utf-8?B?QmFRVks2RGtIb1hiV1hpcWNBTFI1MGcvYVJ0R3p0OVZNWGFjc0FzT0owM1BW?=
 =?utf-8?B?TzN3aW9SQVVHQXlXWkEzcDFQYmFlOFdrdHpKSFlRMUZqV3FDSEhaYXRYL0Rh?=
 =?utf-8?B?SGVGN2Z0a1hqQ01oT0tJWjRPWmN3dnJ5V0xGcjZpWVQxbzJzVlFpbDdCTUxn?=
 =?utf-8?B?QU5uNTdWdm9uaExmTGphTGdxeW93YW1nYUVESjkxVXhHaXhLclZKUkh1eWJy?=
 =?utf-8?B?cVRoUm03OVptSVBiRWJZSmlyMXVRU01qNEx1MkUydFBaU0kwK01TY1kyblh5?=
 =?utf-8?B?cVo2S29MRGpNRFNDUzdFUmpLWEVSNGUxSW9sZHVwbE9SMHR1ZGkybStNT0Ft?=
 =?utf-8?B?WThOTTVIbjhhYno2b2t2dmlMZzNRNllYblIxMC92MU9oMm10bjJocy9FYXJh?=
 =?utf-8?B?L3JaSFAyNThORnB5enRXZUkra2Nibng5UElTL3A3Yi9hTS9GMXdZQS9kUzFs?=
 =?utf-8?B?SjA4emc2S1dNQytPWUcyVmxqeXBPa2pkSVVEMURuK1hCczRRQ2pHaGozSUFW?=
 =?utf-8?B?Q1U2QnZNenR0YkZpeElTZFQyQVVHQk82ZGRzaldwM3JzaUNjRkJBd1VyYkY5?=
 =?utf-8?B?YmVBRzdYd1BFT2NveW1DYWpaVGxxMVRlVjdBanpyTU9jZGJ4bU91WXowWjhL?=
 =?utf-8?B?elJJc2lkczVTWDEwVjJEU0FlMDdzVVNiUGdtNGExSkQyZ0hKZkhWM1VPcldi?=
 =?utf-8?B?ZlFtTENyTUpOOGNvOHl1ejA2N0JoNTJWSnYvVjNCVWltUzNMNkp5UGVmWGs3?=
 =?utf-8?B?MTJMVEhtb2lYaFpmQmdmbHlkc1pCSzBJTW5vOXgxdjNGa1lwaEpWdWh2YzU0?=
 =?utf-8?B?WVdJY0pZUG9ndzk3cjZ6dUNrZlY4dHExelhwcHdmL2RkMzhBT0NwWnMzSm5p?=
 =?utf-8?B?QzFmY2dZTnhNV1lvVjBJaW4wMXI4c3g0YTh2dDNDdWoxbmlkdGMzY0pMRzgz?=
 =?utf-8?B?R0dGYmdxTUg1SWJaRWlxSHNEVUlqNkk4NmZZSUtyQnFDR0tzMkk1bi9JbGhp?=
 =?utf-8?B?cFhwZDI1aUhKYW1lZTVjakw4cmwyVkVzaFVTRUxqZkIwTTcvU3pIVlRFRkZm?=
 =?utf-8?B?bTk4S3ZSWXpDK2U3YXYrMmRCbWtERHFTeXpTMUdrYkpQY1VITjFrditnRk16?=
 =?utf-8?B?UWlFeGdoYXJpYlk0VERsM3ZPSm5FYWFMMUh0UFpvUlVKb1k4QUI0empYVnFP?=
 =?utf-8?B?dm9SNlIzZTNJNW0vdHcwcURKbUdFeG1TNnJ3c3VKKzViQ2hlU1VqY3B6aUpC?=
 =?utf-8?B?ZVVrSFZyYTJmOVpodzFNNTVXcjRxaitTK3RvUVFxNzFyNTFhd2NrYUg2ZWV4?=
 =?utf-8?B?MzQxZ3lGeFVPOHlNdldocy85eXZuNWR3bWhlWHdoR2lrUCtpL2VrZHljVmZi?=
 =?utf-8?B?ajBrVmRiRGg4My90cHZRblZ1VW1HMzZCeTlGSGxGTFVUTFhkenhrWFVZOW0y?=
 =?utf-8?B?RHFab1lUMksvRm9UZlVhb3lSblZOZHhvbjR2c0t3bWJLb1o3eG5oVk5Odjh5?=
 =?utf-8?B?cWp2dGdZOStsZEtkZE5Pd1ovZHBVdmtYMEdyaU9kdURPL1RxL2trODlJeW8w?=
 =?utf-8?B?UWNsb1NwTVdEaTJEckxvNU4yUTNyTktlYy9hcjRPWDVFZEpTT2hkZjZ0cjZo?=
 =?utf-8?Q?P+p+UV1hOQO5S4od4DfXyGUGB?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:09:08.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3440d928-1ef9-4f1c-142c-08de3253ffda
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6030
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4MCBTYWx0ZWRfX339VPwECayEp
 aotHkLjuQqMs/B1c+Ozd7/7uoHdHGLMej8lzHN32GssN29Wk31obLlAmszA6vAqY9ZIWnhmCRii
 DcUCbvOmbLrPrvwzGpHTtXx4+74uUvoUDI0OlHab8IRgsO9VWDbMWbwBJTbtm1AJgXNsLaVzTEc
 PuCDonbpbCcXRi2PVK3KU6MlgnHRG0jUzD6KY0h5r0/IM4IGL+SdExC/Y0A7BqmlCHi4V+bfD36
 G89THX9b3pZD/rPwLE6rSvH28bO3VXXJ9CbKyOSiMjsmj0jXVrLaHRDd+vKMQuSOMynlXX4KQGX
 xskF6McdrfOyuBmpZ5l118gGq+ztbOdGjWpBdF+Tna/xecBtK9kOfuNuAoueHa1N+e1BxPSINds
 A0knWEx84X57pCTleOWh3pbfPuAJnw==
X-Proofpoint-GUID: UJMfGJJ5adh0BxQeASrZh__NJAmQY0lO
X-Proofpoint-ORIG-GUID: UJMfGJJ5adh0BxQeASrZh__NJAmQY0lO
X-Authority-Analysis: v=2.4 cv=YfywJgRf c=1 sm=1 tr=0 ts=69300c49 cx=c_pps
 a=ufeuPVXaArrw0WPMXmQESQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=h4SL0BZ7AAAA:8 a=ZkzY4X2Sm2FNxxC4ElsA:9
 a=QEXdDO2ut3YA:10 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030080

Hello,

On 12/2/25 10:04, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> The ESWIN EIC7700 SoC lacks hardware support for the L2/L3 low-power
> link states. It cannot enter the L2/L3 ready state through the
> PME_Turn_Off/PME_To_Ack handshake protocol. To address this, add a
> no_pme_handshake flag skip PME_Turn_Off broadcast and link state check
> code, other driver can reuse this flag if meet the similar situation.

What about testing !PME_SUPPORT in the PM Capabilities Register,
or just re-use the struct pci_dev pme_support flag ?

Regards,

> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>   drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 372207c33a85..8302bc7a6cbf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1168,6 +1168,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>   		return 0;
> 
> +	if (pci->no_pme_handshake)
> +		goto stop_link;
> +
>   	if (pci->pp.ops->pme_turn_off) {
>   		pci->pp.ops->pme_turn_off(&pci->pp);
>   	} else {
> @@ -1194,6 +1197,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   	 */
>   	udelay(1);
> 
> +stop_link:
>   	dw_pcie_stop_link(pci);
>   	if (pci->pp.ops->deinit)
>   		pci->pp.ops->deinit(&pci->pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 31685951a080..e8057db303d0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -549,6 +549,7 @@ struct dw_pcie {
>   	 * use_parent_dt_ranges to true to avoid this warning.
>   	 */
>   	bool			use_parent_dt_ranges;
> +	bool			no_pme_handshake;
>   };
> 
>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> --
> 2.25.1
> 


