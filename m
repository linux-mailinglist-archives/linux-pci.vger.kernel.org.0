Return-Path: <linux-pci+bounces-8182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB268D7D29
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612C4B22B49
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392C57880;
	Mon,  3 Jun 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JLv4g9Ow"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570E50281;
	Mon,  3 Jun 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402684; cv=fail; b=cfaRxi9VSW0pOcfdQ51Km9Gw3jq+a0wHTI+U34T2iGIp+g4Ha4XletTmcIFjxGzV7xsP70mG+dlxVgenCsXE2gtyuB3qixuQt4RL+2qiI/keMjcWtQVJMLubBAFN4lMm7Obwku6aV68mzRbrH9t9s8afDF1j8ZGeJa/Zu85E+l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402684; c=relaxed/simple;
	bh=WGpuc5faMjxyVk6If0DwoAfh/rEOo0resPk8ZSpo9sE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B6KWeTV3QDoFwsg1u1wmeevq6z52/3k7REqQUwrn/7YiwFSBeQU7U6N09/jyKy9dqNZYu7xxRiXIA5UAC7A07dx9chlL8W1eTT+ac9ktHCEWkGUzcLmq9lPbolnftvXOPPMMFie/YaFaMWtZPVvrhl7+DNXOyWH9CLkIewxD+Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JLv4g9Ow; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H12c1r1IeZd2p40KgK+qE2ySyTZ/I02FK3oUzuPAtdgskukC9AJRUCJpdiz8ESi+HQpKR0GB8HS7DtyPcpVuyy/b2prI7CesSWC0CoP8dRJOuwHJT0ZFlpHMHvfhKOvd9VKz7MgB8E5E2qlDPP4VsBa6birExRl/OnDEThii+x45Vlmp1A7Mf24hH0MXjRvWnv7yxTqRcgL0RGfh8qcnJIsxTOZPYEOdYY6fN1CnFIiMZFZcfRnVo1OXG53t/IxxWOgqYNHGhfhITIr4CWkEg221dGRNqymrkPbxqdqAk1Zu/Jz+KIVXYrtG84lTM/VHycFDcnX2MVCPoVEOEiF2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YVeqfhWH/RR9cQbgjkG05WPpMEuTme6dmoBOQHxHjY=;
 b=hTqGam8jxLdAeBnkjvckKZQIfHsugsWrA3TB5Cyp0oPL4O0ou2lujvs0fzgayrB3Th1oUqHM4jMiMCvvEB5m+heUbNkdDDFJaYL687cq7Hx5n5TmBnZRj3/NnZUu6ELjdGmacGjjORbrS/7/gIBAKRtb1HcxRF/zipyqiFUyz6Bt/31rA5gdnpKd8oGUd2fqcSLRbMKo/7YfDPO73IAUJ/PtyojnKHThknNxl6hQWThcVf26lj4Bk5arzD3JI7j/3uVLON4fyn1ZKbl9SvQz6RlS/ZAFF+qTDtgPABVU4Vg2YEjinDUFb4USiNGlHhhoEJhVtYQLYVZMQ51bHPxmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YVeqfhWH/RR9cQbgjkG05WPpMEuTme6dmoBOQHxHjY=;
 b=JLv4g9OwboXBG3kr5XRZzfxpEnzZAMLRiCxlxtZRJ77kQXyBlaA2VD5nndoWsKb8BUjpIYhO1sG9mGX6P+o/v+fKUelUSaB0Wy+MhxFwztjukEf+xZEM1tNQKbAzOXvjY698Os0U5IwjC3g06ZDukeJZGHFI+OExQyTUdvMsy+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 08:17:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 08:17:58 +0000
Message-ID: <acbba34c-5195-4e35-81ca-8d19d057fdb8@amd.com>
Date: Mon, 3 Jun 2024 10:17:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] arm64: zynqmp: Add PCIe phys
To: Sean Anderson <sean.anderson@linux.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, Markus Elfring
 <Markus.Elfring@web.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
 <20240531161337.864994-8-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240531161337.864994-8-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0257.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8f978e-fa1f-4f24-b189-08dc83a5ada7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHJkekpKRDUzNjZXbXEyYjFwL3ExL3RDUk9uaklscDdCT0xBZVBtTS9Ramoy?=
 =?utf-8?B?anE2VG1JVWJ3d0R2QlNRSDlGVVhzUDdXWXJsbm5vc2dDN0xUTUhNbWNoQkQx?=
 =?utf-8?B?Q3Z5bkRSSWJSZEgvQVliVHAxaXByQm1pRUQvclBmMGoxUnYvdGk1ZU01TGVX?=
 =?utf-8?B?SlNnZy83OTQycDRiWml4bXNrZXRGUlFtSDViaUJoRWtQdEJjZ2Vuakp3OHRl?=
 =?utf-8?B?Q2NhMVdnSUVlalZrYktGZTNqWVNUMDFEQk9IUHk2VDNIRkREdEU3WVBKYWRF?=
 =?utf-8?B?RGpCTVIyK2lSSEY4aXVQK1hlbUYrbDJIK2o5aHNINkZlQkYzYWhPblRCTkh6?=
 =?utf-8?B?UEVqeWhJY0o3T2xaN2V3eWVqWG1ZUXhLVVlXRUdZVVpvZzlCL2xPL2lPRUtp?=
 =?utf-8?B?Y0NTL0lRQmFkT3ZoU1kwaFhiQjdJd1EzcnpkU2YzbzNMaEpuWGZMdE9GNlJ2?=
 =?utf-8?B?NzcyUDducFhvWkdWTEM3SXZDbVcwbVRGRVlpamNVTnBwNkZGMmlIclRCZzFV?=
 =?utf-8?B?eW1XSSt0UC9UeUdqQVEzSHhzUmp0TGE4WjlseDM4aCtXK2tyT0l2ODVpeG15?=
 =?utf-8?B?N2FKeXNaYTczSFpyT0svK3ptY25MdEZTd2dXbGRyejdiWXlCUVFrQzBwRDla?=
 =?utf-8?B?ZDlJTTlUc1B0NGl2bU9nNXNvb1QvVWt6a29BZDhQbWNSZWQrSitPT1dLR1BS?=
 =?utf-8?B?Qzh2S2RhUEprUlR5dkVjakN2c25RODlNQVFtNVhVTEc0SFZPTWpzM2EzaGd4?=
 =?utf-8?B?d2VDVGxXNUdadlNvZW5RUDFkMG1qMVIvR0FpTWtCQXFtQUJZRDNPSjF3dkxH?=
 =?utf-8?B?cko3ZXNJeGxUK0Q0RGFLbVBzYjBxUDFkYy9NRUk5U2o1QVE3OTZPcXdOc2NR?=
 =?utf-8?B?cUovUEVVbGhyNWYvcG54aVlEbkQ3a2N1ZTJHM05hUHQraituQjJmNHZidk5q?=
 =?utf-8?B?aW91K2o4bG91Rmxsd1ZHN2FZQWZBL0pLK0hVVGRON0pTeEtEZTVRaTVUQzJp?=
 =?utf-8?B?SGRrTXdoUEtoUUp3bXl5Nnlqa3BxYm1tNFB0TlFhZkhqUERpQnhobElpa1kx?=
 =?utf-8?B?TkM1REZOWHFCeHpaVjRTekE2UG1BVlkvSUNmaWhpTThKWWJiR25kSzRmY0Iw?=
 =?utf-8?B?Zm53WTlxYUVpL2ZRRkRaV0tqN0Npam1qbTJDRGE3aWNtWXo4WGhmNDdKL0hh?=
 =?utf-8?B?UG5JZ0dVK3VVKzdnZTlRNzZ4ZGxKVmI0MDlidEVpcFdiR1g0OG9OYlBTN3p3?=
 =?utf-8?B?VzcwT1hBT25CNi9wT1VjcC9LVGdQVWd6dXNwb25ZQWdoRDFpSWJIcEwwbUFO?=
 =?utf-8?B?WVkxVllJc3BrV2JQanVPY3dRY2o4Qlc2cVJqdDJMQ1ZJdnFZNUpZRFRxYkpI?=
 =?utf-8?B?L3FzekYrbUdZWEtPbCtWM3FzMVFxMzc2MlBqN2hzUjhObHFZM2U0aER6RGNs?=
 =?utf-8?B?WTlITHFEckJDZXhiUWE2WVkrWEFXQ253WnV3bGsvNzdtWXI5TGFRZ0prcUho?=
 =?utf-8?B?NFBOSFR3WnM5cXQ5ZWRCc3ZsbE52ZGJhQ2crVmFEQWE1M1JONGJJeGxFNmFL?=
 =?utf-8?B?TFNqWGlyYUc3UjFjbm0vdmNLdU1CNHJXNURFclRpZWpWTkZvYnIrNWJzQjFP?=
 =?utf-8?B?YVdpSzdUM1N3N0NIRldvOFkzRENJaW9jODBpQStZMVVxcXIyY2ZZc2xmNUZR?=
 =?utf-8?B?a0Q1b1g2Y25CdGhUVVZYVGR3VE10L2duOUc0Yk5aQ2xCZTdYQ2pDTEVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VStmNEc1R3dPaG1Id0E2MHpVT0JTUjZFc0pNaE90Wml0aEJBSnFoaXhRL01R?=
 =?utf-8?B?bkorSTUyVGFnak5MR2FvU1lNZGFseDRxNVY1YUhtQVluNWs1ZkZ2cGh6NHZW?=
 =?utf-8?B?NGZQUHcycGZrL2lJc0Faa2U4WmVUdXZVa1JnMlBDbWFqQ2xGRFkxQnp1NzFk?=
 =?utf-8?B?VVJKdEtYQk1JdGlnZDNqcVBVcWNCdEtXY2wzVXdNVitpb0NwVFAvVXZWZ042?=
 =?utf-8?B?WG41cnc0VHZNazZ6MnJJU3lMT1lUTnR0ZUgwNkNpWXlVR0FzeTUzQlgrS3Yz?=
 =?utf-8?B?ZzdYeU5aQjVWY0RockJXQVlzTkpOUk4yVWxZTkNINWVNYzVaSk9yTFlndFdK?=
 =?utf-8?B?NytMY1YrVHcwcUVMUXpnaytXT0xaWWw1MUFkSjU0bFJSUllXU3J0cTgrZ0pv?=
 =?utf-8?B?cXNYWjVHZm95dzJFWU9KcGdCWEtJb2dOdGhRMys3Q0NwK2JhcEFlSU80dVhE?=
 =?utf-8?B?Ym9kYXh4TlNyNTNhNFgrak9mbHY4TFFRQlEybTY4b2t2Y04yT2xyUTdtcVBi?=
 =?utf-8?B?ZXBJcmxxTVlQaE5mM3ZWQlExZmhHMCtvQUxSQzRyRzZxNDNKMFZwUkhxQytz?=
 =?utf-8?B?S0Yrdk1ac3VOUUF0bGVjdGZsUk9HZTFrVkNQc1pKNWhCOHJCYURDSEtkalRD?=
 =?utf-8?B?eVFac0NnSU9ia0JWNDJtdUxhbFBTNnhueVk1V0c2LzR5TWFHaUJLdnFRL1JZ?=
 =?utf-8?B?U3NQdWNRcmg0UkNmR0dwUGNUMXdhY0Faa2lsaDJuQ1JFY2ttUDdoMEk0YXI2?=
 =?utf-8?B?b3NCc3hoekszOWhtZFk1VWUvV2RCREtYdFhQWXo3ZzJoZndEMzB6THhXbFZW?=
 =?utf-8?B?dktyN0lpWVo5b05WSGZtamNBdHA3aSt1Q3lmZmFvWE1Makd4emd4K2JHWlp0?=
 =?utf-8?B?S09HcnpyMjhsZjJYZnFPNjFCNWxkVmNObHAxSTg2WDZVNkdGOGZ2YnBPT0l3?=
 =?utf-8?B?RTB5QzNlQkU0ajI0ZUplN2pEUmJXQVZyc1VUdWN2MGpjdDVkbnlFS3NxM2ZW?=
 =?utf-8?B?V0VqcjZhNDM3bzNIM1prckJzUW9WQkNoWUVNS0M2clR3MDRITHZ0Z0xUNVRo?=
 =?utf-8?B?M1hsWVQraEI0R0lYdlpCOUVpSU1zVllIQ2RaMGl1LzFTbnZBbzZvTkVrV2tS?=
 =?utf-8?B?NnBxRndWaE1VeUphdmhSU0ZUNTlQTXgyQ002a0xNcHdwQWRRdFBCOUNBVEJK?=
 =?utf-8?B?d0k0cFdqVTUxQkZRdEQvdVNIZU1pR2FPOC9EajFJRmptWm9Nc0Z3ZXdyRzNi?=
 =?utf-8?B?MTJaMy9zVXB4dmYwVWMyWjg3NXh2QUNiTDNnZ0RNN0xmVHhMRFh6ZEpEc0t6?=
 =?utf-8?B?U3N2ODhReG50VE5VVktHNk9LaEcxYy9mRklwRFdvUFg4eVFGYm1jelBQdDdY?=
 =?utf-8?B?Rk9OUVhhZ3lOMkFQMU91bG50bE13ZjNqSDA1enI5NkpqTTVGYlN3NWp3TGRP?=
 =?utf-8?B?U0RxcS9KdVRIM0wvNDlyR05SRjljZU56aW5Ma1JBTUdJM1lOb0JhallVeS9W?=
 =?utf-8?B?dWlBU0pnVUdTWEVHQ1RueVAxb0xTNStwV2xPd0l3VnFiQmdtQnJVSGIyTDU2?=
 =?utf-8?B?VWN0VkxJYU5LV2dQLzhDdlpYeWdrY1VmdjZXUTZlaDNoZTlLWTlMQjRQNFYv?=
 =?utf-8?B?bFAxUFhoWjNVZVZIdXBKTC9IU0ZNV2tETlZBcTFLWUhoMDdoYSs1RXZXNWlI?=
 =?utf-8?B?Nm1tUEE4NUtUNWxMdTQycjVyVFJTTU8rRDRyVnNvejNWakhRTUtZZjJkRlR2?=
 =?utf-8?B?WVJzTHVmWVhBTzRybkxxNlVaa1NEZXd1TXBkNUlwQnpZQklTSnZkTTdNS0x5?=
 =?utf-8?B?RG9sWFJXcnd6N0tqY1dTQUpwaDI3d2NtcCs4a01yVHA5aDVyM25YNlQ5Mitr?=
 =?utf-8?B?YWx2bGIzK1pteDdBd1JMYXVLTFF5QWxDaGdXdU5kOEhUV2JmRnJkMXpTQlRJ?=
 =?utf-8?B?T2trU1AwTkR0U01obFdxZFNTQXpDOFoydHpWRWtNRXJCSjR6ZG1hYm1BVkF1?=
 =?utf-8?B?ZnM2bVpJVjFteGx6OWtkR3ZOTnpwVkFuclBzcmdqc1JwbTRLVWJOVHZ5MlZn?=
 =?utf-8?B?dTJvbW5KUjBJUHU0R2JpZHAyL2lEQms3M05rTWI3azBqajJQWXJVbnBmUXl5?=
 =?utf-8?Q?7WUJOeSdD93jbbaklqfUITQ6W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8f978e-fa1f-4f24-b189-08dc83a5ada7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:17:58.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C36SMKkK+g2RUKPU/EHLVjhlVAguFK3wE1p56N9a0u462IuSF9/bOUfuLZZNsPxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321



On 5/31/24 18:13, Sean Anderson wrote:
> Add PCIe phy bindings for the ZCU102.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Tested-by: thippeswamy.havalige@amd.com
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Remove phy-names
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index ad8f23a0ec67..d2175f3dd099 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -941,6 +941,7 @@ conf-pull-none {
>   
>   &pcie {
>   	status = "okay";
> +	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>   };
>   
>   &psgtr {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

