Return-Path: <linux-pci+bounces-41231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6CC5C7F1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6F4A4E8801
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAF308F0A;
	Fri, 14 Nov 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kIiWGdKE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586A28727C;
	Fri, 14 Nov 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114787; cv=fail; b=EMBobI1McneCXzQ8kLcAN2/o2x9Zdt7nTK9PdGpAyMW+xIidEd7i4sghAnnCQZNIxIQnj0q/jmB0hhcpPqMFBHa+VzCVQxogr7kbhk344T0UxieiCusT57uv2mLYPz+iqHy1/CskE7Z28RUkBVNZq/002LrC6217RuAL146tJH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114787; c=relaxed/simple;
	bh=ZTYHxtvz+Dv3n1Y3wa5PdH3ZUsMrA1oLmZr5nT7tLbM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=iMILWBk0Sh492h8wEXaTIpPbbXnZ9X6ZawMO2+qMP7327n5O4hMLcZuDP7W9axsnOo75c2w6Iuf95AVahDOVNT2B1Vqkm3/KG1DirhFu8p0J5o6KC0+t5Eimy/VNkn4EFyWGHZXyCLFf/8lrPJisce1ww7xl8cwJex/fLxacNio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kIiWGdKE; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE9xrGV1963038;
	Fri, 14 Nov 2025 11:05:55 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7pad2s-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 11:05:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa1leu12xcA0ABb8LZNrPmFRHvCplSFdfkEY060PeJx8qxqE3OshqY9mgQbp+UXVndQJPHyu5KUOQw0HI5VDDhqrVAWMRDVH7JZOdyNJcJ59OcGDzKWo6tUAsR8zSxRvXkS5J8I/sqVvO5ty5bPVkYQ6HXciRsU8SKF7qlxFEvuLNkr53H1gEghQnPTi5Ry8muJvBFwaT4+XswI0ahRzTeSoU6tnRe7PLg5Wg6KREioceVxaaKIUOkYbjTnPjeXHEAHFwyAX747cts93xkN7YSVgzjh8BCXvLnv34h2gJTHZW1OmWrzkPA9ORbQk/KdXTLfVBTHBM+FZrSvsSg8Ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcr4yrX6nnsGYVULkq0XaYx9yoCi3BhpTZ6MGM5j9v0=;
 b=oyEWNs4w/q3Y4sRVufip7L89X0E/KptwsoxM5rB4JzKt15RawMRc+eaLQCI8WVxfx7KolwYwZl1YWUxRzifvHmaZNchCIdDjgxySuAX6Znl8yY8A1zgXTTEcXxNmRm83sr6pgvbjd2vbHP7LkriGVBF0JmsjL1ItPEWl8xa72kmF7pA5bRitUMcJrLLe6mHXOxRbdCYel6oD+cx1MEBRiMlIvhWnckRYKQB/eabQGag68yhEpcCrGHbihYNCDYo1VP6/zFUYT+ihyPV1mLCnwCcHi1ZuiBNUcIMeCnVF0gAmwivshLVQ5RbtrwRvfbQuYpCxhjXgJYiXVBP5LpKXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcr4yrX6nnsGYVULkq0XaYx9yoCi3BhpTZ6MGM5j9v0=;
 b=kIiWGdKEOa4mLwyNxCXXVPpdtnf+1mOfqhOKIpK6PYVDGP3VuXh43Jw+LxsTdqOzO67r0sNJzfpJ7Wct80P6oh3Qhm4ojOWyuXNFQ+oHIQyeHlHVgY/m4Y3XLEZOxIFbcXQac6ZN+Xxgi+QBcFVL/g51FRexJUlFvsSwGhpm425LW0FiNZB108n6j3FuVjO8Plpxik5wcb1MLJthiyS2RbjaqLJH0/drxL+0217FavTSIGHsGxkFMx5VCtWc6bC5asmoOuu6ajDolyeMk2XzmNCevr3ah1u9zjQGyKoYtQY9Fl09n52OgQQINEki7Z7hiXLOnreCNcJQ0Je0xSSm9A==
Received: from AS4P190CA0041.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::15)
 by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 10:05:48 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::c4) by AS4P190CA0041.outlook.office365.com
 (2603:10a6:20b:5d1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 10:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 10:05:48 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 11:05:59 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 11:05:46 +0100
Message-ID: <b945e463-52ec-417c-8e6a-599c35a6727d@foss.st.com>
Date: Fri, 14 Nov 2025 11:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>, <chester62515@gmail.com>,
        <mbrugger@suse.com>, <ghennadi.procopciuc@oss.nxp.com>, <s32@nxp.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <Ionut.Vicovan@nxp.com>,
        <larisa.grigore@nxp.com>, <Ghennadi.Procopciuc@nxp.com>,
        <ciprianmarian.costea@nxp.com>, <bogdan.hamciuc@nxp.com>,
        <Frank.li@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
        <cassel@kernel.org>, Richard Zhu
	<hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Minghuan Lian
	<minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang
	<roy.zang@nxp.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
 <20251106000531.GA1930429@bhelgaas>
 <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
Content-Language: en-US
In-Reply-To: <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI1PR10MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: 852500f9-9776-49ac-05e2-08de2365624b
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WjBxWElmNXNwL3dNaDhpZXEzaVU0WDVpd3k2T2pUa01qQUc0bEp4WkFOZWFZ?=
 =?utf-8?B?U1ZsVWdVNlEzWXUzRWFqNTg0K2tEQkNJR1ZkczFWaFdGYnN1TW1wWjFSSFpt?=
 =?utf-8?B?UkxFcHJFUWQrZGNKd0R6Q2ptSGpYSGJPR0cvS3d5RmJKcGN3aDdjOTI4Mktj?=
 =?utf-8?B?ckZzOEJnREdCbzRIM25tajdnNW1zR0tPMjI5SGc3N2ZkcjFCeFk4d2lNQks2?=
 =?utf-8?B?ZC9SQXZnczkyZkJvVkNma0IzakMvS2F6TzdKTUFxSmZTWm5KS0l5ZUxxdW9w?=
 =?utf-8?B?TjVKVDZ2VFNRWklCWHdDL2p6V1FMUHlqeDl6V3B5Y2FrTUhHbkpPWit6bWRT?=
 =?utf-8?B?V3cxa1hXZXNFTFViay96SkxDQXhKMHQ0Nk0xM2srekVOaTZsd3lwYjIyb3Rt?=
 =?utf-8?B?RDJFdVYrbG1kbWpzVnFpNmU2UlYxMytGTEJDaitxa0JwT2llUWlNMUx0N1pq?=
 =?utf-8?B?cE9ldlRITWV0ZG53TU1LSTFmWTB2am1rRllZZE5qNkVOLzJtUWQvV1lTVW80?=
 =?utf-8?B?MllxK28xWmVNbWtuaFdkdWN6bHg3Mi9VVDhpdmwrM3UrN2ptZGtlaE1majJv?=
 =?utf-8?B?RWZ2Z0FDL0FWRjliTDQ2Z3lXVDhxNWpuY2NnQ1phRzVuVTNGT3A0MXNVcC9M?=
 =?utf-8?B?RFU3QVE0SzhKdkFBQkpuNExZbElTK29aRnNpV0cvdW96SlN4R3FkZzVNL1BW?=
 =?utf-8?B?SFJDdlIzRjcwTkdIK0xKVy9GQ2UzMVRJVU9lekt1Z1lKdFc4YjhGU0tKZGpM?=
 =?utf-8?B?aDF2a05RTTcwajJjaFF2QmhKenZ6eUxSWlk5TTdualhjek5RSDlUcnFvT3Fr?=
 =?utf-8?B?ZkhWNGJXYjRIZUNFbzBHOERSbjJyZk9EZnU3M3VTY3FsKzJzY1JzeUFKZm5z?=
 =?utf-8?B?K2V2eFgyd3lUYkRhemJiajZjL2VkUkk5Z2thUy9nTFVyT1FJbm9QL0hQall6?=
 =?utf-8?B?UUlyemU5QVpjdzJablZ4dDEwd1pDTE5rdk10c2JrTE9pM2lNOHMxV0V0UVQv?=
 =?utf-8?B?Nm13Z1MzeHA0TnpicVRuT2pyTHJVWDFSUXlmZWkyQURmSW5qTGpyeFJYSHd5?=
 =?utf-8?B?SzRFUDkxb1FlOEVoLytHTjUvcEdVRDNvaEhGSkJpN2lHd1pYRklSVzBETk13?=
 =?utf-8?B?dTMvaE1EcmdRNHczSlZ6OHc1UFIzSkphSnUyakYzS1ZFcnJpaXlHc3o0U1dn?=
 =?utf-8?B?YTdvYWs3N05VVk51KzlKTi9NZjVMM2R3bFB6QTJYVFI2QS9kOGVENG5Ic3dT?=
 =?utf-8?B?a2p0a2dDV0luZURzbjhWRTF6c1l5UndNaU9QeEM0d0N4czUwVW1EM3ZIK01z?=
 =?utf-8?B?WG94Rzk5a0NjNUVST3U0ZzQxTTdmalA0YlRDSEs0emZyWFVpaTMvUC9rc0lw?=
 =?utf-8?B?QXhLWkNFazdONHZXakcyc0ZmNVNsLzNsU2l1c1AxbWxOWXVQdGdqRW8rRitw?=
 =?utf-8?B?R0ZPUUx1RUNNM0NZeFduQ2k5S0V1bWwvVXN6VHdjMHpiWjBLNDAwemtEQ3kx?=
 =?utf-8?B?LzlyVzJ6QldVdjhBTm4rWnE2eEgzcys2UUZkSjIvay9DdTRXT2xINTZTcU5y?=
 =?utf-8?B?dytML0l5cXpxUE1INUsyUE50SlF1ZHQzdzRpUDg3Yi91dUNrdFNDTVg3Ukpp?=
 =?utf-8?B?OE0yekh4ZEZhb1dwampVWUFwZUNYMjRma1JCZHYwMlJjMEdxMm9TeXZ2Y2l5?=
 =?utf-8?B?VGNPZENnZzNVd0l4Vk54dFpwOHlNQVI1N1hOd1k4bHpuVFRqS1NDTjU3Qkdk?=
 =?utf-8?B?YXU3OXZ1bVMyM1VUZGV3d2VwejV6T2lycnZuYU5BbHgyc3JJZFUrNXI1VW9x?=
 =?utf-8?B?dk1pRUlXaDVtQS8zYmtNY3p1aFpINnQ5QU52RGZGemRaajZqUUo1Kzk1SkFZ?=
 =?utf-8?B?M2hUWDhScXNub0k4YVZwbktGaE9UL3JhS2FScGcydjJ5ZVQ5UkkraUVYQ3dC?=
 =?utf-8?B?Z2pGaHBtdXVFTDdhNXlBdDJhWUoxdEVraGI3aTJGWmFtb2pucitER3IyN1hG?=
 =?utf-8?B?OUY3aVQyT1A0YkhiNzBWQzU4emdLanMrYk8ybTVOQllHZzdSOENDcW0wOXdC?=
 =?utf-8?B?S1JaOXM4WDJOM2I4VGYzSzh6VnNvYVFySGtyempVT21mZG5CWWNMWmsweEx3?=
 =?utf-8?Q?z1c0=3D?=
X-Forefront-Antispam-Report:
 CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:05:48.0407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852500f9-9776-49ac-05e2-08de2365624b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA3OSBTYWx0ZWRfX1HS6PRSpdSSQ
 i3UVW4+d+S8QFHs0k7MZ8HXGvUj7QRR+lBW0O4j/SjRdd9ww+WcCHUK+E83eD2YHPx1D8WNd8Yx
 S1WgOhHz1AWz9ojcrGwYw9pnwdqybVTGrlHgnJrAUeB/9JnPYFOIOguNPQHVv6eGUpv4U6IkOn4
 o8Zpck6rVRobC5eGQaVyfPPoLIlBOksxk7T5d97X4ymPenJI4Rh6xWtkA8KmLVio+PJCnOc9qMb
 fkv2u2Vg9V0S20n2xM8zY6RwLJF28ycafs09U8nWp6GLDN3b9tCNGpm/qK6PU9BTLv4NMgZxbpp
 IwkFI0dZipiClWgUsf6FaXjzkqbDnJzfltyclSqUBDBLmBTNvHYrEcKufZCSCC3jD89+34EkwEw
 swrCPUXFIw/4DbrREbrkt2pbMq7NLg==
X-Authority-Analysis: v=2.4 cv=avi/yCZV c=1 sm=1 tr=0 ts=6916ff03 cx=c_pps
 a=qSOlZ4UaY7QPpvcjSAGktQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RA8ZoFPxCIQA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=sSKje8Brj290pxkRjLEA:9 a=QEXdDO2ut3YA:10 a=DXsff8QfwkrTrK3sU8N1:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-ORIG-GUID: Ya5xAF87Dkd9xZIFm3Kn7Lx6tTSf7t1j
X-Proofpoint-GUID: Ya5xAF87Dkd9xZIFm3Kn7Lx6tTSf7t1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140079


>>
>> The implication is that *every* user of dw_pcie_suspend_noirq() would
>> have to check for the link being up.  There are only three existing
>> callers:
>>
>>    imx_pcie_suspend_noirq()
>>    ls_pcie_suspend_noirq()
>>    stm32_pcie_suspend_noirq()
>>
>> but none of them checks for the link being up.
>>

stm32 supports L1.1, so we bail out before pme_turn_off() in 
dw_pcie_suspend_noirq()

> 
> If no devices are attached to the bus, then there is no need to broadcast
> PME_Turn_Off and wait for L2/L3. I've just sent out a series that fixes it [1].
> Hopefully, this will allow Vincent to use dw_pcie_{suspend/resume}_noirq() APIs.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com/

dw_pcie_suspend_noirq() path tested OK on stm32mp2.

Regards

Christian






