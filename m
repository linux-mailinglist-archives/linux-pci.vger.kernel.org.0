Return-Path: <linux-pci+bounces-42976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DBECB770A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F10A530184E9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 00:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843F19DFAB;
	Fri, 12 Dec 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Veaf3cjw"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CD883F;
	Fri, 12 Dec 2025 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765498627; cv=fail; b=iMCYgaBiIeJZfiE8BO9ncsTtMdyvu0KBakaoeifHXeG8VsGpSPqpsgQeJ9HW+neAu1j8i/aEz5uplUxiIAIuK7+JZh2FGSLArLrOQYcuU82MgVdfS7z+yJRGCBy9kB9H4kaPMkEKVmrL+fG994xaTzV6Y5xbX4GklhjDSdR1UCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765498627; c=relaxed/simple;
	bh=ToBmVjz706ADgpbJ7Eq6N47OTYj0YDiHO3h6cYjBMmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVpb34GyWNXozr9rinERuQjNsqTlsMtzcmqwXmonUca+02hsEz/KubeI1cpEZcZMyD/oBpuhKJ4fSbC1+PafNo901AFOscX9zrFtkOoCOzwsjd+hSe/YtwKDsemEmw8NyzKtIAHq+LSej59AdJR4ajHlP0dOPorjE1oIXr+u5Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Veaf3cjw; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xne3JfgAEBp4hlq30R7RLaAF5gDGa005wj3y+ArD8vPj3G3D7BQ5QrEUak8phjMDNvEf6LDTJrqmL9yOiZfadQFzMZITbNEOcfXJbsSoIa9iufx1GdjShGss/pLFXP37h+nsv9t6K6lQeOE1DCIF6JarjO4Ss+LTJnGQE8pvFZJmz+2K1FLu+tZheiSVjh5XGsRsy1lKoQ4+EM+qGJgaMDzwCLbvhiGIKaFmLcff+AxYzj5dJB09bJDjnlmeWwzoidzNIXmBSZNb4fkhe6YL9dgwn2Ji/fATmJ2v9rISH3KO/1DfJozqLVX4ja3z1DcFprsW7EWJiGyj9yjF2Mn4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En4UAIVqQ0hTpxrn9jgOoSjC6vpUgqMcwxtM0GeoqhQ=;
 b=nl26E6U4qI/DxSsS+/S7UkIOZkPAjqcvYWdbL4PVt3EEB6cO8ujn1X4xrFCEl3Lr8OU5egi/zJGgqOXGrMFgenqKnGUF82Jv6V++VUXo8c7a3Rjwo0OeZlZ1sFqE6VEVgxARP6kC4ENdj2JUJM6cpBtY18C8x7RBM7JSXVQW++dYN3QEjKNsEX1RHb7Z1vZZ30lM0/ozU7osCLiVAGt8RVC9MaRM1B769TaFCUM5qIxVOvig7nXnJiemlFbfkaXHdmFRdTi+5Q6QMeJlYirzORQocggR9+6qwK2r1h7670ePrzHfc16+i0gouxDQtpvRAgq9oY/xFk+/D9+h1W0u+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En4UAIVqQ0hTpxrn9jgOoSjC6vpUgqMcwxtM0GeoqhQ=;
 b=Veaf3cjwUz/i+baOMGs5rvV4I0GjFc2BT5Mm2dmxoqvutOoKj7vOrnHE59L7bloPLwD3PquyvyEyx+M+BPmamVhcZ1eyjDzRRf/2UKVO/XPilU7kHTGs1aJusmwEu1PFpO9qIiKqNT4ziVy3DMoEwQMgGXA5pKWh1aGbFeP0TmDrUxAuZMSVA/PorAU7pOsNXuN6bDt1s+iUENwoRJnMs7/TfCV1QfovfjuwRol5+07jXBI9yy+zwA8gaGr6yBAqhynVWAW6N1DEtZ2gWpSg28271nMdIjQM+b5UccUibaS0xHe+45bmWdt+I5bbQykgfnbYoeo1l6TdngmEaITNlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.9; Fri, 12 Dec 2025 00:17:01 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 00:17:01 +0000
Message-ID: <8f8e1944-5315-4657-9ddc-7e6c65c6ac00@nvidia.com>
Date: Fri, 12 Dec 2025 09:16:47 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
To: Joel Fernandes <joelagnelf@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 airlied@gmail.com, dakr@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, zhiwang@kernel.org
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-5-zhiw@nvidia.com>
 <9cf6135e-43c4-4c31-acf5-03fbe32e2bae@nvidia.com>
 <20251209154114.09cf245b@inno-ThinkPad-X280>
 <20251211083618.GA2144309@joelbox2>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251211083618.GA2144309@joelbox2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:403:a::27) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: bea5aaa9-b22d-4274-70ac-08de3913c564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OThpczFOSDBVYnpqOUgwV2gxMnE4dGw1Q3JUWXk5UHR3Rkl3YXpTdWlZbFIw?=
 =?utf-8?B?c1BHMHBnOW1wbGh0T2llSG1rZExvVVg2MjgzN05ncWVpYk9mMXNGZlQrK3Fr?=
 =?utf-8?B?ektIU1FEUHRrQnNZdDRUQTlUQW1rZ2hWbExGTjZLVFBnMm9zQjdqY3ArRHcy?=
 =?utf-8?B?Zkt1RGtpQzJFV241eHBzeG5IN0JtdE51cDlCYmFkcTlHdlVDQmdlb1RaNDIz?=
 =?utf-8?B?cXRmK3h6MXgwQlpzU3VVN2t6bWVlYlpmNXUxYlBNbVdDcmo3alZuTXA3N2RK?=
 =?utf-8?B?djR3bDBJMUtZQnlDSk5GcTB2ZDB1bUltdU43b0lUVjZjbUZ1NUV2UW5oRG1M?=
 =?utf-8?B?L1MrKzZvRElTK3VyRmF4c0o1YkUwNnovOGszeEpiRXZDMDE4Z3AxUVZvU09t?=
 =?utf-8?B?dWxCTU14WDJuanZ2eDV4RnhMeXlrWnl6bmJwa2RCQlpWVFIzSGpJbGxscGpW?=
 =?utf-8?B?RVJ2cUF2MGNsWXAyckd6NEFLV1YzY3FUK2ZKVzNUL1BNVnJZSmF1eURzdklO?=
 =?utf-8?B?aWJpWElJdDJRT21JK2IzakgrR0F0eXczc09vTGFjRStSUkdKcUpMUURBMnND?=
 =?utf-8?B?eEtBRE5qQjRLY1JhOWRjelRYdGpINUNHMmM0dE5HNDJsMW1DVVJ2UkcwMmd6?=
 =?utf-8?B?OHUyT1VWVDBTbFcxMEhOenZZZ2x6TmtQci8zY2lKdW1Mcm1SU0hSTyt5R2Ni?=
 =?utf-8?B?d3BXdXJ1Ty8yYzJPL2haUEZFcjZxNWtGY3R6SFhhKzIxeFp6dzQ2S1R3YnlU?=
 =?utf-8?B?R3ZWZnpDKzFCNDR6UnpYWXFkMndIZWFFRDVlbDBDeDJQRm4yS1JQQ0E5SWk5?=
 =?utf-8?B?UktQeW1ONUJSQUpNU2FpcklYeUNHNUZRczFuNjZRNWJDMzRNeWZ5M3VHT1Np?=
 =?utf-8?B?eTN4NUpJeDExc2orMnFEakhudWJtTXpIb0RLbUp1Zmt4eTVKUkJhWUx4R2Vo?=
 =?utf-8?B?ekN1dERJcWxhSnZ0YVF4ejMwakMxclVUWkR1aHI2MFc1dFhUa2t4RDByZ0d0?=
 =?utf-8?B?Sk95V3RDMGxVV1FYOGF5WjJzajR1TDVSUWRNS0x6a2MybkJlOGxsYlJISG55?=
 =?utf-8?B?ZnN4Q0xxSU1US05DdGtmcGN5OUcrekxoNStoSngzZVlIZnVmSVJUT3VBQTNm?=
 =?utf-8?B?NUJjMzIxTk1aWWh3UHdkZ2huU1R4R0JNNno3ODBYL3RNdTNuNUdhWURoUHY4?=
 =?utf-8?B?UmZWc2J5aHJvL3FrL0YrR25MZlBMRlpKN0NlTnpkbnhEaGdWNWUrWERwNzdh?=
 =?utf-8?B?K0tHMTlSMGlsQzdMMU9jb1V1NVFvQ3pxaDdtLzROVFRjSlUxbjEwT2hqNkQv?=
 =?utf-8?B?NnlaQnRpR1g5V0pabEJrTFp5UVBkTUJ1VkYrbTlkQjRYTHNMS240eEFEb3Vn?=
 =?utf-8?B?dE5WMzNmNzNEOVRIamEzUko0RDNtOW95Z2daMW9EMTRIOXIvQ0V0eW16a0I3?=
 =?utf-8?B?RDZXREwxZ2pJbjRpTDlGc284UFRVSkRSaWxpekNFVUo5SzJUVHd5OGpiQkJ2?=
 =?utf-8?B?cVFLb1dEd0dOWXBmM3FZeFg5YklwZnFxOE1vMnVOcVNjakIwd3BxS0U4cHdj?=
 =?utf-8?B?RXdUSzVubXZyZkRaU1BMVStocVl1ajJVV3V5cE5mSmtRS3F3cnFRaXlmRktT?=
 =?utf-8?B?eGJENlYyS2piUWVGWVpaYnhxbWZWNU50SGJEQUFkU2Yrc3JMSUNsQlUyUVNk?=
 =?utf-8?B?RE9ROHp0QkJNdHN2djlxdUhDQ2ZCL3dhZHBXNW5rQ1JUVU1Tb3RkVWJ4TytN?=
 =?utf-8?B?SnJ1TWZURnJObEY5OEZoVnZvcDhINHB5TThwNWc1TUgxdkt3eWxPaHBMemlh?=
 =?utf-8?B?YXRCRGxpY1ZLazQvbWMrSDdKbUZRVkw1dTlqd1JMTnlZeGNkOG5qVFpJbitv?=
 =?utf-8?B?ZHdNQkJLQklaQXhUL3BhcDJxak90NEs1eGZpVUdyUU5Pc2ovSW1wV2R3Ymht?=
 =?utf-8?Q?YZVuf6f1UIheLu9sPHddHT2cLBh/Requ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU5HSkE5RDk0aGNBSEZPUXpqWjBBNFViRUZHUjlET3Z6by83RkdUeVFEVlIw?=
 =?utf-8?B?cDdCVUEvVkFudlVEaUFNNGZxbytDQmdMZTdTN1BBdUY0c2taNTl3SVdYMytt?=
 =?utf-8?B?YlJHa2lsTVJjUVlYYlNIZFBmcnRJWHA3cFh4ek5ZZ0xtTE1YT1RNT0J0VE5q?=
 =?utf-8?B?U1JOL0JRVzNTUjgwL1dhdFgrQjVZYWpES21sdWEzS2paSnNmcEpObXA0ZXVq?=
 =?utf-8?B?ZEFLZEpVZFFmOFA5bWtuTXJtRFZrdTYydHBLaS9DcXFBREV1eGwyZHJSeDk5?=
 =?utf-8?B?THpCL3UzaURHRnQzRHhtUVY2NVNTYW92WFhjeFF1R1ducVRzOEo0czdFMUds?=
 =?utf-8?B?YklOQTNQSk5rckhSWm41eHZMc3JHc21TaUd1K0pIczh5dXpvcWZtU1Y5a0g3?=
 =?utf-8?B?QjJ4VXlMKzFzelcvZDk1TG52YkgwdmtWS3JIUi9BU1RkV20yQmk5TUp5UXEz?=
 =?utf-8?B?ZmF6Z21GYW9DVkVIYzBVOUNTMmt4dmorVnllVGU4Rk5IbTRwbE9EVURBQkhD?=
 =?utf-8?B?ZFQwNE05VlJJTm5iT1U2NXl2TGlzU3BJak9sMFhpWHFud3FpT3p5YkIzZTFr?=
 =?utf-8?B?RVIzdyt6NUtUU3V0OXhYcnA4UmlhN2R5U21WOHJseTg3NisvbkVkdk5LZWVI?=
 =?utf-8?B?cTRGS2ExSWdOMGo3b0IydDA2SzVZZGpXTkhwbnBhT25GdmRZQ0NjcjIxV0Nm?=
 =?utf-8?B?U20weTNrYWlPOStubzJ4UWdsODUyMnJKRjltK0I1aEpIMFJnaWpoVjlhejEy?=
 =?utf-8?B?RDJKYTA4eE5uTnJ6Uk5EbTVTUTZydldtamNZTjlEdzRZdVlKOWlpMWFOMzZ0?=
 =?utf-8?B?U04vU2t5aXd5YWg3MG1tT01tY0s1N1d4QU0yVUFEeWR2ZHhXOCs3RWIwS0tp?=
 =?utf-8?B?QTFyNG80MFVsdG4wWG5KL01udk1lV1BoQzVrcXgxYmdTcW5SMlRHaXR2U3dp?=
 =?utf-8?B?OGV6U2dLWisrNVNRWE1JdlZKdmFZU29PRzFRbG1WRXVtNUZuUkdjd3pSZEtT?=
 =?utf-8?B?WkNvUVhPSkpVUnBkWWp3RzJWeDZqSEQwSUpkSmxIUkNxQU04azBnWkI4Rzhz?=
 =?utf-8?B?bTRSK3hla2FvOThvQ3p1aVZtZzdURjhEWXJpRzNERThLNHZzR2Iwd0FSd0k2?=
 =?utf-8?B?aTF6UGVlL0Q3RjRxdjJvbnlUeldzS2J6eW9XTjBpRHBDbjRJN3FTSFEvSlBZ?=
 =?utf-8?B?MW05OEtsRitteG5tbTJzZ1AxUHZyMGFQbjJrR21WM3ZkeE1HdXhrS3RUMkpa?=
 =?utf-8?B?Q1lMR2VwL2FXdEU4Mkg1Y2l3UkNFK3dDL29LL1hjZzVwN01mOFViaEdrTC9s?=
 =?utf-8?B?ZlpseXBIY2d5QjQ0Y05PYzdCS0ozaUt5cDA3dDFOU0lsRWJTU3c0TkFHNFI2?=
 =?utf-8?B?ekV2NktBYnErUWU4d0JjdlI1TjEvU2QvenllUUxBaDV1b1h5ZXRNRjRpNWRH?=
 =?utf-8?B?eGhkNEd4bEpQK0ZYNzMwYWt4WDhNM2dBWUlCV1UwSVdWREU4UkMyc0VjWUQ1?=
 =?utf-8?B?RHRMRFI4ZnZMMFpVK3kyWVJSZ0Rvb0JmRlVwcDA4S0VmdWpTSHhJTVZJa0Zh?=
 =?utf-8?B?L2lqcldaR3NPNUd2d21KSjRVdFQyLzlGaDI2ZElRQ1E4T21ZcDZDVFc0Qkxj?=
 =?utf-8?B?cy9Ca0ZzaGRYWW5QZkpKSm5LZzV2d0J3ejJvYnJxZnpTaVJneTVwODg1N3ZS?=
 =?utf-8?B?TUJ2UmFMeEM0bHVMUkg1ZVVlK2Jla0Y1Nk83aEZSM01CYzJRZ1R1akJubWpG?=
 =?utf-8?B?UnFpUDdMNjRvaUNBZEJiUDNKWHYydG83UFNuUVlmVU9DSG9zZE1UZWNyK0Ri?=
 =?utf-8?B?ZE9kSG5nSXdSRDBiU200d3FOeTZ3aTdvZG5JdkNKTmFCNzZuMXJuZXAzcHFO?=
 =?utf-8?B?ZzBaNjZ4bzVFbmdGa0NUaTlHNjI3TDZoSXlIMDF2eHV1T1FFNEJzNHVIMUpI?=
 =?utf-8?B?UE1NcVk5eW1QNk9ibFF6RktBVGFML0pUZWNkV29lMGdoa3I4MzI3OStHcm8v?=
 =?utf-8?B?UUNnYkhaZmg2K0tlUjNqcFBNSDIxYXlORGV4Uk9TdUR4dkpSNXhNNUYyTHVN?=
 =?utf-8?B?WWRqcE1GVVJ1L3Y5NTR5SGQrK0ZVdGR6SmlLUUowUVQ3emFWaWtUMWZYZGRt?=
 =?utf-8?Q?6tMc3Slr2CAUVx67XXyhEnV2S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea5aaa9-b22d-4274-70ac-08de3913c564
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 00:17:01.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUC9X9UrdWOnA+B6tkO6fgA1EBxzkQVTWJS1Knkm3r3Lrcmm8clIsiSSgSgznUhA85cewgAB7EkUcu6aLq1vnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008

On 12/11/25 5:36 PM, Joel Fernandes wrote:
> Hi Zhi,
> 
> On Tue, Dec 09, 2025 at 03:41:14PM +0200, Zhi Wang wrote:
>> On Sat, 6 Dec 2025 21:32:51 -0500
>> Joel Fernandes <joelagnelf@nvidia.com> wrote:
> [..]
>>>> 0x00000004); +
>>>> +            let val = bar.read32(0x88000 + 0xbfc);
>>>> +            info.b64bitBar2 = u8::from((val & 0x00000006) ==
>>>> 0x00000004);
>>>
>>> Please no magic numbers, please use proper named constants with
>>> documentation comments explaining the values.
>>>
>>> Also BAR reads here need proper register macro definitions/access.
>>>
>>
>> That is true. :) But this is because there is no register definition in
>> the OpenRM code/non OpenRM code as well. I have no idea about the name
>> and bit definitions of this register.
>>
>> Suppose I will have to find some clues from some folks then document
>> them here when going to patches request for merged. :)
> 
> 
> I think these magic numbers are PCIe config space related. I found a couple of references [1] [2] [3]
> 
> [1]
> In Open GPU docs, I see 0x00088000 is NV_PCFG but this is on Turing, lets
> confirm what it is on other architectures (if not common, should it go
> through a HAL?).

It changed on Hopper. My Hopper/Blackwell series handles this.

thanks,
John Hubbard

> 
> https://github.com/NVIDIA/open-gpu-kernel-modules/blob/a5bfb10e75a4046c5d991c65f49b5d29151e68cf/src/common/inc/swref/published/turing/tu102/dev_nv_xve.h#L4
> 
> and 0xbf4 is SRIOV capability headers, per the same header file:
> NV_XVE_SRIOV_CAP_HDR10
> 
> Also the bit definition is not documented in that public header, but I find
> from internal sources that what you're trying to do with the "& 0x6" is
> determine whether the VF BAR is capable of 64-bit addressing:
> 
>   Bits [2:1] is VF_BAR1_ADR_TYPE and = 2 means the BAR is capable of 64-bit
>   addressing, and = 0 means 32-bit.
> 
> I wonder if the format of these capability headers are present in the PCI
> specification? It is worth checking, I find some very similar mentions of the
> value 2 being 64-bit in https://wiki.osdev.org/PCI as well.
> 
> [2]
> In Nouveau I found the 0x88000
>    drivers/gpu/drm/nouveau/nouveau_reg.h +684
> 
> With a bunch of ids and such which is typical of what is in config space:
> 
> #    define NV50_PBUS_PCI_ID                                0x00088000
> #        define NV50_PBUS_PCI_ID_VENDOR_ID                  0x0000ffff
> #        define NV50_PBUS_PCI_ID_VENDOR_ID__SHIFT                    0
> #        define NV50_PBUS_PCI_ID_DEVICE_ID                  0xffff0000
> #        define NV50_PBUS_PCI_ID_DEVICE_ID__SHIFT                   16
> 
> Perhaps this is something pdev.config_read_dword() should be giving?
> 
> [3] This one I am not sure off, but the link
> https://envytools.readthedocs.io/en/latest/hw/bus/pci.html says that on NV40+
> cards, all 0x1000 bytes of PCIE config space are mapped to MMIO register
> space at addresses 0x88000-0x88fff. This matches exactly the magic number in
> your patch.
> 
> Also, I wonder if we need to determine if the BARs can be 64-bit addressed, do
> we have requirements for BAR sizes > 4GB for vGPU and if not, do we need to
> determine the BAR size addressability?
> 
> Also, shouldn't the PCI core subsystem be automatically determining if the
> BARs are 64-bit addressable? Not sure if that belongs in the driver. It would
> be good to understand how this is supposed to work.
> 
> thanks,
> 
>   - Joel
> 


