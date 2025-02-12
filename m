Return-Path: <linux-pci+bounces-21301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DF2A32F39
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 20:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A71C1889BCD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60122260A5D;
	Wed, 12 Feb 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bpoxp/Ws"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F5253B4B;
	Wed, 12 Feb 2025 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387288; cv=fail; b=J/I492nGkI8N0bOTp0SbAL6JNyn3GNkdLS4LOHdXtDU3zTzBs5B+4zd1QLBoB8uOR24a3096B/jQYFA+VHdWkcXyurKDmwvcOBsjR8IrA7fFCGghnU5NDR9cbwQIAZizJoNFfLSCj3Noj+QpNTe8Tta/JUc0/WiLSUipsc+3PVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387288; c=relaxed/simple;
	bh=tcaXU3T3Q217sbrGvG6GELXbPpGIxEWShMO3gAmsol8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l1IrrG2vZ95ADSG6ryqIqZ5OwjaCGAS7w0uPJzgP6kDiF/HmpagdOwdbYyVYo8a/vEOq7Jaa0BMzIvc6bzgOySlbbe1PiWAXQTOKkrsFlSDWdOJA8L+DZCb4qaPKVjUQcELhRZgwqt4hGe5k/DGsx3R320NCm6i3Se9lL6g1Rhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bpoxp/Ws; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvjGi5tjiWHhzCr3uW8RzZZhFpX2J+t+7awoMjmJ+GS9/ZfqWr2XM04Bpz2fRGsyPMNT8oXoTtk5kIE3nIvQnWF5jqg3gM55IkhzBUiIVov3no9/Bcq57vR5nE75RMUVk4oflVF1SvX57oOqfNJ0l1T2+osxiW5g6v2skHdbE670JYbituGw/11LVxA+LReYAxstSVIX9WOCIXMExl/wmWq08kP2qCVvZ+euUa2LMBZaBeCXa8HnQ7r7MZ4htZ0J5sXlFACLXg0sSZn5fVXPjwibE92qSx3lDlM8r0Oxh1BKVNxdbs3cUkJaQKNZ5y+UnK4gJQMTzok70B+7aPONug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSYsHaOKe+NuiWx9DSzBTjT89it1FWruVbyCKbSa+3s=;
 b=xmavrJNy5VQGeWylvnhY3hA7ZQqwrrr1gwmt1bJTVrBPvuk3TPaSi0V4qFRsHDNbdLhhjD7pSI4Prt1aX19FE29r99s0iISRMAYnodDc4dgoecalfvskxyiAP1L3W5tcTZvzvTQd9JIypZOMn9QOAT/hk2UALMijthC8ywU98SKbmeXbUioItcbr49ulmJ0v+b/dKRe0cx40CJFP8bZEHAAMgKhoMInLSclYigMt1ZrVJ0EQwPRCxjhQhBqo6wQRxYHAg8kGZCIZppNVsgAuzIZECSy+0oOdQ+eajS6ypF9wWM/fm8CKtUnxj3meqs+1kLxf6sGALaAXgxwM5hKABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSYsHaOKe+NuiWx9DSzBTjT89it1FWruVbyCKbSa+3s=;
 b=Bpoxp/WstGfjieVbVqdk7YNbe1cFOAASvK80Y2PUT+46G2kp9xwF6UW0xj8TeMCBfPmVqp8n8oTt7+oAEqIeF/bdoiq3sKvC9cWadboQoZhtiPllhtGpVlSA8so0n7omyCDYOprWAJcKnQeWleLe2y117iiN0P9XBceYyFPokkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 19:08:00 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 19:07:59 +0000
Message-ID: <7600b0ac-673c-4e1e-a9ee-d56efe386f99@amd.com>
Date: Wed, 12 Feb 2025 13:07:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-4-terry.bowman@amd.com>
 <67abd04519e67_2d1e294f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67abd04519e67_2d1e294f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: a03b655f-4a95-4b82-85c8-08dd4b9890ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdSUmZNanBjUUtMeFNSc0hIaVViSU5VVG90em1Pak42REFyaWVkN1hobENa?=
 =?utf-8?B?R1luQmV5RnBaL0VOc0hka1BGTGkyUmlSb3hWYUcrVEFLL2d4M3ZGMHFlT2xv?=
 =?utf-8?B?cmtGemFTd3VpSk1JMTArQXZKMFpaWmhQT0Vpdk9PNDlmNFZaZ1BuRFdydUV5?=
 =?utf-8?B?cFBpWkM3V0hyeWpPWXNLWjR6N2dUSWllOEdwT3p3Q1l1NEE2NjJTUmJpb3cx?=
 =?utf-8?B?ZUFQRTNPNXppM2RWcnVia3ZHbUxqcU9PMDV6SjNZc293eVJhWUlGd1JjZ01u?=
 =?utf-8?B?c1dWV2pDMlE3ZXpON2NXQTBpUm5kOSsyUGNwMk1qNXZIQ2pVYnkrVUVkaVh0?=
 =?utf-8?B?bkVNaEdha25ZaUZBNjE5bFlkM0JTOTRDQWpVR1psOWhaNTRmWDZ3K2hjNm9x?=
 =?utf-8?B?cnozSGNPaEc1OE9iVFhWSS93NDhKTWgvZ0tIbFl4eFBqTGhDU2FlV0c5SXJX?=
 =?utf-8?B?OTVITUgyVEhzS2hDd09lVEw4OG9GbXhuRHF1eHR0Vzd5ZVFuZ09tZE9RRDVZ?=
 =?utf-8?B?Ti9OSU9JZ2RlTHRTR20yemkzOFZjSFYxZFlObklSTnVpc2dDZnJBUERMNG1I?=
 =?utf-8?B?R0Z4ckkwNjNwdGVLbVY2WmdtU3NxOU01ZFhoeGZydWtNMUtoK1ZQem4rakVQ?=
 =?utf-8?B?QlpuL2s1ay9HaXl1bGNqVmlIcU1oVHdkWlZ0Y1pqeVFXa1d6NW03NHBRZFhW?=
 =?utf-8?B?RVczN3FpOTNZQlNjMW9IMVh3YTdTY2lpcS9YSGR1aVhDZnVscHFtSDhCaW5U?=
 =?utf-8?B?MGcrdTFCeUpSQ0xvcytrZitnZDMxTzZtMUxlQjdxd3F6aVNwbkNUc1RQT0Fi?=
 =?utf-8?B?elpSTVFYVHVVKzYzdU40RGppOFdUYTJqc2NzcE1tMmhVa1l3YSsyZDhPUU9V?=
 =?utf-8?B?K1k1d1pBQnBmem9WaDhIdEVPNWpsdGt4WHZhMDd0RHAwc0JmanFNQVQ4UGpy?=
 =?utf-8?B?VndNWW1GaTBITDlVbEtVdkpMVnVJeWJxNGpic3hoQVpuaFltakJjRUhkTHhk?=
 =?utf-8?B?b051ODdMV1JBaW9zaUExSEhUVVprV09TTXhDcExuUG11SnJmY2g5VUNzQ0lS?=
 =?utf-8?B?bGxsdVhwa085SkxvcG9WTnhLeG5WeGFRWXZLd09WcDFNVTVXNjJPcmE5ZTFO?=
 =?utf-8?B?dGVVMnhBR3huOWdhZXBFOHdRckEvaUQ0UkY5c2dqVnU1NWtDSXh1d0lRZFN4?=
 =?utf-8?B?MnRrZXVWL1R2Zk1JNGZaajJnL1VQNnRQaGhFNnJLcHcyeWdQdDhmS2RhV3Fh?=
 =?utf-8?B?Y1JPSnp2QndvL3hvYVpLUnAzTHVQdWpqUElYemROWGF6UklJdU1handxTnVq?=
 =?utf-8?B?NHNOT1VjSGYrSlFtQWcwU2pvVjlmME5idElhZUsyM2M1dUplUU1lMi9KYVJ2?=
 =?utf-8?B?M0d4dWZiQUEyRml4S2pUU0RoUDZMcFpJMzd1bFl1ZUd2WnY2S2xwNGxxMEFl?=
 =?utf-8?B?V1F6a2lodm0xdy9xSWl6VWlUNjZ5UVRmQVVERG96Q3pwQ3RsMlFpYWhSaHhF?=
 =?utf-8?B?SUJNMFRRMkRtTnFJT2MxV3ZEdE1OdG1nUjJheE51R2lZVmdPUHNRTi90anVn?=
 =?utf-8?B?Wmoxd3hnY0g3RzZKUmJVbEpOS0Y0Q3o2VG5EZDloc2h1MUpOZHdkSkVMUnZP?=
 =?utf-8?B?MHhrdHlXM0Y0NWVuV3l2VUs5RkdydCs0eTMwa29jU1BzRUxBbmx4RXdHVHp6?=
 =?utf-8?B?cTByMWhDR2VEYXhxNTVxeUNMSHR6UncwN01OMDZrM0trQ0gvbVNvV0VXcUFQ?=
 =?utf-8?B?WUpnR055cml3ajc5bDk1WmF2ZHlJRVp1b1pvU21wNU1QOXJEcmhnM2g3Y2p5?=
 =?utf-8?B?NTM1L0p4UVhOZ2wwaW5rcXZDVGs0T3dsTktTSTZqTzNXSEZ6YzlOdmpEWEhu?=
 =?utf-8?B?WHErWUx2aEhNRnhIWGRySjB6cjRUTG9vbDRncWlzL1FrdzVYd3dtK2luZGFa?=
 =?utf-8?Q?6HvEUQKARo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1RQYnRDQjlNT0Q0d0kvMnBmNFgxTUx5SllhK1FLMTlMUUFmS0JXM1NBQVBX?=
 =?utf-8?B?VWtjL01KKzM5SlM2Ukd2RjVFbzNlRng1NjBYTlNwcHdsNnZWUTYyOXo5T2xZ?=
 =?utf-8?B?U1hmdzVnOER2dFhBKzN4ZjZwS2VuOStua2V0SjE3YkN3azJhVFE5M0MwNis0?=
 =?utf-8?B?SXpsZWxVL3lRWFlMZDNUb25UQW1rRGJjZDFYTnhXYmxrZ29VNXF2QTExV0Qr?=
 =?utf-8?B?bW8yZTloVUxpWk1vU0lDTVVGaGpjd3piZjMzcDdScUxXOWR2NHlRVFRGQXB1?=
 =?utf-8?B?cDg4TlJtYkh5ZEZkdS9vcUdZNkxIQjF6ZVZ2Ym9SUWVtQWllNlY4RWE0NVo3?=
 =?utf-8?B?aUlPV3pHRHhrUlIwaVBNa3BJQmhPaG9NU3BCRFQwbUY0WHNYeDZCYlBvNmVE?=
 =?utf-8?B?WGdXY0ZjaXVtMmxud2Z2VUp0V3dhc3R5YXpBSTMzMlF3RUlET3d2SzdwcGd4?=
 =?utf-8?B?eDNwRVoyeTRRMmZlVmhyVmFGaWdKZmlxdVo2QXM0eW9BOEN6dEZqbk1KUC9z?=
 =?utf-8?B?UnBDZE1sNWNJUnM0Y3BVSUtrcFpjMmpodVNObUxveko4UUFPR2IvQi9mbnI5?=
 =?utf-8?B?SGVaazFLZjdEOGxMZnhXUHZZT2NXS2JKdjM2bzRyNW8zNFMyMTcrSE95U0F0?=
 =?utf-8?B?VC9zZTFwa0dqOUc1L0N2L2o5MWRQb2xDUW1LRWZaWnRJR205N2hOYWRSSzZB?=
 =?utf-8?B?dzYvaWFoMmF6amJkc1E1bkdHdGs1M1kyZjYyTkRtQmo3QnFzOEI2WVh2Qkl0?=
 =?utf-8?B?VEw5YnExZytONUt4NzdtWHFnYTQ0MzlFTmZlZ2pqd0V2Z29KaGc0MGdKSTVM?=
 =?utf-8?B?cjlSNENhTHg1T3BqQXJ4VXZOSk9DOUtHUDJIYlM5TmJRa1BDY1FkQjNFc3lv?=
 =?utf-8?B?cVZxWDlLK2RCMzVvRk9NZnVScEdOOXZtR2JlMEtYRjJRbDRGYzlHbzd4a1Z6?=
 =?utf-8?B?dDRORzNpLzZhRmJIQ1FMWmk2dGhPSUk1aWJQY0paY3ZLZnJrbjk5ZTNQRmta?=
 =?utf-8?B?UEI0UTJ5K2NJTUI3TTBtcUthb0d5VnE1Rlp4emxrRisvMVJVdGFwNWg5bmZm?=
 =?utf-8?B?cmxXamdCQzlYRnc2ZERCMnVndDNiZkRDUXR2My84WGxMSGhYdnUxR29mb3ZR?=
 =?utf-8?B?dDA1YUw0SnVwU3RQckw3cHRreVZZVHBxcmwvSUxEQ1lZeHR1OWRxRjY4RmFw?=
 =?utf-8?B?YTU0ZmtnTW0wazNpS1dPTnVKcjF5RjJ3RFovY2M1TmhPSjVSSlpNbUFrSkto?=
 =?utf-8?B?SXpCSUE4QUxPZ3dONFJUa1EybEU1UStOSUt3YWV5UXJ4Mk9CNE1QeWpmVENL?=
 =?utf-8?B?OTRncTlYSFIyM0lHbzJPYkhMWHdpcmNTTmdXbktPYVB5UnBUWUt6MUU1TDZM?=
 =?utf-8?B?Zm5NRG9xOTUzNUs5Mit3RkV6dDlwQ1E4cU8vOGtzSk85Sm9Vc1lhRGJuU2V2?=
 =?utf-8?B?NjkyOUEyUnhodXhuWE9jSVhYUU5vY3N3c0s3T2V3dGhoMGZYYmpOZTJKaGRG?=
 =?utf-8?B?K0xRb2pzNnFBN3kxOFBLUFl4MysyTEFtY1FZczM0WnQvTFRWejZoajlYaXNl?=
 =?utf-8?B?ejV1YWYyRGRrc2dJYkhMWllCWTllaHhod1EvTjJ6d21sV2wwOWNNSFVOUW1k?=
 =?utf-8?B?NzRiWHJrc3VWLzJmYlVucXdjTHpCTHdJcnZ5c0lpR3ZxSi80STBzR1RIdEdh?=
 =?utf-8?B?aFpZaEFORXY2V0txam1LSFVFSzVWczYzV1NZMDMzeGlCRHdOQ1dSM0p2VGtT?=
 =?utf-8?B?cFBPK0lVbFRqU0xXaUdzaVk5QlY4Y3oxSmtMVnpOMTdETVZDbGxiaUU3ZExi?=
 =?utf-8?B?RGZkNnZYbk5pSmwzYk9ZYlhUVVRlNUJKQUZyczRMalc2ZXdPSlJySGJ2UU44?=
 =?utf-8?B?LzZmeUY3enhBQ3BodERCVVNpN295Qzh5WXBldTB1dTZHaVZJUHZkSzRIV0Uy?=
 =?utf-8?B?VFM1My9SaDJ5YjJIMHZ0cmlleDY1UHhvQ0U2RGpvZHlDRTdzd3RyaFp5R1Qw?=
 =?utf-8?B?YzRVdGpBZTJjK09ucmhmVHNNbjdtSzBzUWpkcWxZa1JlaVQ4aFNPVGFZaDQw?=
 =?utf-8?B?bm45bjV4SkpXZlNzUjBCMnllVTM0Qko2Sm1tZGtoYlRzWXplRzlOR1BjRHNC?=
 =?utf-8?Q?jPEz5ppHR5q5guJe6t8/Nwt+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03b655f-4a95-4b82-85c8-08dd4b9890ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 19:07:59.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8CgvLg7PirITWaJuQno/pZeRTa+H1NFqgX7J4YPqfibBS5Qj0tnwR/fAuvLqUWuSEhz9TIUQ0d7y5rxG16eXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868



On 2/11/2025 4:33 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices and CXL port
>> devices.
>>
>> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
>> presence. The CXL Flexbus DVSEC presence is used because it is required
>> for all the CXL PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
>>
>> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
>> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
>> CXL Extensions DVSEC for Ports is present.[1]
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>     Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> ---
>>  drivers/pci/pci.c             | 13 +++++++++++++
>>  drivers/pci/probe.c           | 10 ++++++++++
>>  include/linux/pci.h           |  5 +++++
>>  include/uapi/linux/pci_regs.h |  3 ++-
>>  4 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 869d204a70a3..a2d8b41dd043 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5032,6 +5032,19 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>>  					 PCI_DVSEC_CXL_PORT);
>>  }
>>  
>> +inline bool pcie_is_cxl(struct pci_dev *pci_dev)
>> +{
>> +	return pci_dev->is_cxl;
>> +}
>> +
>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>> +{
>> +	if (!pcie_is_cxl(dev))
>> +		return false;
>> +
>> +	return (cxl_port_dvsec(dev) > 0);
> At first I was concerned that this adds a capability list walk during
> error handling, but patch 17 takes pcie_is_cxl_port() out of the
> handles_cxl_errors() path.
>
> It is still used in the aer_probe() path which means enumeration can
> potentially race a CXL link up event.
>
> I think this is fine for now because the CXL core has the same top-down
> vs bottom-up race, and the CXL SBR code also shares the same race
> problem.
>
> A follow-on change needs to arrange for cxl_port_probe() to
> enable/disable internal errors, because that path knows that a link has
> been negotiated with an endpoint and that the CXL link details should be
> stable.
>
>> +}
>> +
>>  static bool cxl_sbr_masked(struct pci_dev *dev)
>>  {
>>  	u16 dvsec, reg;
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index b6536ed599c3..7737b9ce7a83 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1676,6 +1676,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>  		dev->is_thunderbolt = 1;
>>  }
>>  
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS);
>> +	if (dvsec)
>> +		dev->is_cxl = 1;
>> +}
> Similar race problem here as it is premature to check for this DVSEC on
> disconnected ports.
>
> For now, lets add a comment to include/uapi/linux/pci_regs.h along the
> lines of:
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..32df7abdd23c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1208,7 +1208,13 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/*
> + * Compute Express Link (CXL r3.1, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.1, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>
> ...to at least remind our future selves that there is work to do here to
> make the implementation robust against hot-plug scenarios.
>
> With that you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Ok, I will add the comment.

Would you like for me to add the enable/disable internal error logic to cxl_port_probe()? I can but want to confirm.

Thanks for reviewing.

Terry

