Return-Path: <linux-pci+bounces-42800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54313CAE4CD
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 23:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A554B3088A01
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 22:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15DF2E92D4;
	Mon,  8 Dec 2025 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fUk4y46/"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F01D798E;
	Mon,  8 Dec 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765231997; cv=fail; b=JIj160ZV+KNqy4KuwwH6RslmliPOU9AprdBMGkdUav5nXhQD3i0e+VRx6757Iu/AGax6pPYuywNPr2W5iNVlBXz+ZVSGbxic14iG3E3CKY7MWkLqwBxp7SRssH6nuHYplLY14uM/5mZBPHztms1u6l2PUcRdLr2GYfEXCQj9HYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765231997; c=relaxed/simple;
	bh=VMEFN2N/l/2k/wZwsTQypT4YbZ+WRxRvnoJ1Hbwg5q0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eYFB9Dd+QoQ6xYd8mj8kgfJIR79j3A6ZneZEfyvEDBp+KSrwQaGv+O3QNOz2AkR1y2wOntJfd1guCw3giKrBkjwObpx+cKxPOkZ+GFBVHsQf9dZH/hOGbrNe8Bgx9cY240M6cSMPuCqr92bVTXyyTLTYmrQuRRnpXbYE5OBAXF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fUk4y46/; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntk3EqssLGml4vKVP+eFzeva55STWylyO4872ECZ+zNoj3kosyJkPuzopjG5+qSsnTXMW7oY7kLecnuLY2KHM25jIZR0UrwAhZWqs6ltg3HKgEHllH668sLFeiNICzt3oGgfl+i9bqnrod4TkPWG3K5efS54IjceLWGenBmogdDMe1h2L4Fq/LRLQ5MM+G+zc12tZTzv7dg2Grdyg8Mxs94fQ83bY5fCnrc0q3x1LbeaQeMNKQXW0/oaqJNwDInEMux4oxw4e82WD05sQ4DZS+gKkQPrhgr1wUpTR0Zr09KOkLYSJfs8090r/Nv0RRuWKyiGgIKH93pG6od9TwlMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+dCrxEKitXjK1hbK9oZAmqCO5mnaL9vVw0Bqn3wn50=;
 b=DbDm2v8/LU1BJzOLHwMKd/QSFznKyU8javPD7mFgNT5vL0MhkBdyTHHVcnaJLs4ZjDUQFxveUF978Pzwb/+g1GFLoG69dKzLc7ykgTVWhg0uiUiYKNh3eH+qLADL+dlOSw3k9OEst0mdBjrdoK0pkbZVD1huXpc4SIo16KSfd4Mje2OAwVBJZAFA+++ao8EFG6A3sH/wlOY90ixX1FrsJZK0OjUoCd+kcQpYCfSjeUVEK+BMWvz0Cuxl/oStGvUVZ0numNGQzTAIKR2DRnOK/2Lg3norPLlrb1kCv5l4okeA6CsmcxAYWb2/oFd47DaLBxSY74W4UkHOCZvjlliD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+dCrxEKitXjK1hbK9oZAmqCO5mnaL9vVw0Bqn3wn50=;
 b=fUk4y46/xRW+MeUKC6MfcgTom+4RL18lDuLwDk3BpKrOJJL9/OPdwZDpJf5z/yyW3Orzt3kxEHJZtKtyRoWvYrVx4f2/EMzMumQV1ZSrMXoFxjx/jJH1T2WZU2cKsZ81asf8N9mm0jZsfomiJi1tYrHFSl4J8jUUFJ7CnRrwGGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Mon, 8 Dec 2025 22:13:12 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 22:13:11 +0000
Message-ID: <6a1821b9-1e71-4cd0-8b82-13a76dc7958d@amd.com>
Date: Mon, 8 Dec 2025 16:13:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251208180412.GA3419469@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251208180412.GA3419469@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:c0::22) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4eeab1-0c2b-4678-8591-08de36a6f9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWxoUWp5bXd0NndKSWgxaHYvM0hNalJpaXhKejFYVW92RVFleThEbjJhMWNK?=
 =?utf-8?B?ejZlT2lWOTRQc2QwUFZaNXRsWWxHWDNhSHJVT1hlUUlraWVDRUJGUE16TlhC?=
 =?utf-8?B?YW54UGc5VEhhVDRVNGczTTlIZnBYakxCMTdTalU1YkgvQ2Q4b082ckdubGp2?=
 =?utf-8?B?R1JvUWU4ZzRQdzVvbHRUL0I4Y1NFaFRPY2JTQlhucXhGaUd4T2o4WFMvckk3?=
 =?utf-8?B?d2pGcEwrd3RneUpkWG9pN1dza1g5emZBbU9OUlpaL29IN3JVQkxpSVB0M2VG?=
 =?utf-8?B?ZlRTRGQzMno2czJzd1d4NlRVQmtLakJMdzFlVGJnRFlDTUtNWlczK1VESGdi?=
 =?utf-8?B?cUQxQTdCclQ0RDJxTnJHUzBJa3pGeHREaGdleW1HUCtwRVcrQXd6eW91cnRO?=
 =?utf-8?B?cTB0cVg3TlNtZUE3K2Q5Z3dGVXJEZE16OGVoTDBmb3FIUWJUVWJvOVRCaE9l?=
 =?utf-8?B?YjZEOWo2dlk2Z05tc1FDRWxOWlFxZXhXRUVqRnlGNjlCMXhzWU9vQldPVDlw?=
 =?utf-8?B?ZWp5ZXgvelM5SE5oK2h5WCtGRW9kbDJMSGFqeCt6Y3JpK3Qra08zaXVGUlUy?=
 =?utf-8?B?dWJ3N1Rnc0djN1ZZcWhqYkJFTTVoZ1VyS0JaL214dE5DWWZLbW1JWElhTHVH?=
 =?utf-8?B?Q0FjSlIyZHF3ckhkYnM2Q2d3Qlo3eWpzaFlic1Q0WTZnakg1dkRmemMwd2VH?=
 =?utf-8?B?bm9sT0hJR0haVnJIYmd1ZDBQN1RGWDV2RWo0TTBFVXVWMmtBTEszVHVWQktq?=
 =?utf-8?B?SVlXQ3BzTkhQL1UyTS9SQXltTXRUQkloeU9kZ2J0elZ6V3IxaCtSOGl6RnR3?=
 =?utf-8?B?eU1tMkpxYm95ZDRMSmhpYlBWN1ZLS0QwOW9QcDVha3R5WkRXUzh6MUdTRzRv?=
 =?utf-8?B?ZGhoK0srd3ptWEtuMHpjanJ3RU10T1lEUDZMdFVDeTIrR0wySC96V3E3eGF0?=
 =?utf-8?B?ZnhVUUd3aGtmcVpLcTBXOGk5OGg3MlpiMGlKU2xoZDMyQ0NiNTBwUUpPaVIv?=
 =?utf-8?B?RDRtOXJiNmZ5blY5QjhUcDE4MHRPa0M4emdNaGptZ2J4eDkzcXB2a2lIWUln?=
 =?utf-8?B?c3BrUVk5V3dBWnp0T1hBVnJTMW40dEk4NkF4bmFRWXdvUU5NSkRSTzRQMTZD?=
 =?utf-8?B?WSs0bzNHQWhYRlFxeVFBK01ZM2ZMenRPaW1rWnVxUHJ6ZlQ2d3FEZXl1Ulk5?=
 =?utf-8?B?Ni9TZVJaWEowaHBJRUk4alpGRHZLY0tBNjdONEthT0FEbVlxRnF1NWY3UHUz?=
 =?utf-8?B?aUpRbWxoNnI4MEpFOElpYTE5MFRXY0JFdVJ5cm9oaEdYVk1NaitkVW1yN2JQ?=
 =?utf-8?B?bStyQmJDRG1MRWFUZnZiQ29ZWWVsN3hJM09Yb2wwa1lqd0lKWnZsemVHcmNJ?=
 =?utf-8?B?UmpzUmpNTGs1d04xakpzRm9qdm41UklRbmRHeDVzUG91UzNxWUFjbmI4eG5y?=
 =?utf-8?B?WmNoOFZUMGJkRjJ2czYrSDJla1JJQUZHY2ZNTTNqTUpJVjJSeHI5eWpzbGFy?=
 =?utf-8?B?YTZobkNxeXc4Y0ZzVVdmcHhIOEQ0cXRUN0ordjc4NUVxSjBKTlI4VXlqOGxZ?=
 =?utf-8?B?UVZ6RW54NEI1QnE2c0lwYjhGSzNyT0wzN0hPS0piTFByRXJWRlNxOWpqOWN4?=
 =?utf-8?B?ajFUMC9MdFJ5b2hNNlpTSUt6OXJrQkhVdURJR1MrdVVESk16L2dIdlpaTUZC?=
 =?utf-8?B?YndSc3lHVUExKy9CemdXaVFaMnA5UWt6Vi9ubDVvbFdXd1pGakk5S29FVU9D?=
 =?utf-8?B?d1ZoNTFnMVhFV2k5U01NV3REVlVMY2x5N1kyS0gwNU1JQkE0cng1UDQ5U1lL?=
 =?utf-8?B?bVJEY1pQVG5IZG9zNWg5RmpNOUd0SHoxS1N1UzBVbFhFcjVLR2VSWURIT1gz?=
 =?utf-8?B?KzRuNndIY1pvdTNOK2l0ZmVSanV4UGVmdjdIQjB1OHhBOHF3S0hadUZndFI3?=
 =?utf-8?Q?ZO/nP869e9PVv65u9z5EJ9KJvNuvA9m+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZMQ2FHSS9oa05SbVh6aUZ6OFYwdG5NMVFBSWVzVHhXQ1hsN01xaDVycjlW?=
 =?utf-8?B?eFFnQVdsUlFxSG5NSm9jNWhWdnM1bEdQcnZYT2srOEVKNmozbG9EZnhIZkc2?=
 =?utf-8?B?SnYzMWZ5eG9MaDJBbDZyL3hxdGdZSFNESkp2S29UdTRsMkFlQWhuMTFPdFBv?=
 =?utf-8?B?N3FWMUNQdzMrOHRoSXJaOG9sV0tHRmJ5NmVsVkV0WlVEZFB3MEdNbGRWZXpG?=
 =?utf-8?B?WVRFUWJsbS83MkRibEtVL0tMR1VDM1Iwd0hvbkRkUm0rbkhOM2RGRjc1WC85?=
 =?utf-8?B?NkFWbVhGS2tpTEY5c1l5R05KT25QNEdMSDRSbWpET3J0cjcwWHlCeDZ6N0hT?=
 =?utf-8?B?RkVJZDEvZWNhY2hMendqdHZvZHFJQmRLS3loQnJwUXdNaTU5eWFVWGhJQ1gv?=
 =?utf-8?B?L215OVE3dUFUVGRFNS9aVEkva21wUnNzTU1DWFFnODMyMzh4N0tqU2R0ZG5H?=
 =?utf-8?B?c0lDd1kvQzQrNzFVRjM2dG1UNFRwekFSOUZ1M1JYTEVMZFhlR0czaE5vWEdq?=
 =?utf-8?B?TmhQN1pPTDNXdnBGSU5wTzJIVnpSK0I5OXZLVXlWdzhmN0UyYTkwZ3FkU2I3?=
 =?utf-8?B?WHdIdnFoMk10UXVhelRmKzQ3Q2J6czNXd3Bvd1hwcjI2bUgwY2tTMkU4WVlo?=
 =?utf-8?B?QzkzM2cvYVJtdGlOVzEwQ3JGbXhzMjBEaG9vaWtQb2xCYk83Y0QrNVNlVExC?=
 =?utf-8?B?TUdCTUxOQXdaeUxhWkFXWHRPWGV1MnV5cjVXWVM5ekJLak52WG9xbFZ2RWNT?=
 =?utf-8?B?VnVPSERXNWpLOUdTMUNJQW9tRC9Ic0tORHFkbmpxSktxcmdYcTM1U2E0U2ZF?=
 =?utf-8?B?T0lpeDROQzkybVhnOHZxa2Q3MGRlSU1OdkorM045NXpMOEhSNHdqOExpbWVl?=
 =?utf-8?B?ZTd1UlozcmJzcDkzU2xpc2VpQ3hTZkZFR0lTNHhZUHRPeEw2TWFFWGswMnQ1?=
 =?utf-8?B?U0U3REtnUDRMNXFodEFaT05pdXNGZWVMeTUxaVl4My9SUktYallHT2NlYlY2?=
 =?utf-8?B?OTNvbmM2cGkrMCtWeG9qQUFoQUdxWWJ3SDRERUh5T1pobWt3Rk5naWlCWFVl?=
 =?utf-8?B?UU5GSXV1N0lIdGdWaWZYN0UxUnRSYTBJTWF0SWREckRnUU5waktTTGplWXNi?=
 =?utf-8?B?TGZIUUFVeVN1c3ZUWWJiTDlZTGh3UzRNeGplVTFUWVRYYVFEeHZoTlhoQWpm?=
 =?utf-8?B?YXRmNWpMQlhYRFlLTHhwcUYwT1NQeTdnVTU3RnF2TGl1Z3RINlAvMUc4aXVH?=
 =?utf-8?B?TWVzejdVL29hVmg2YytnZFc0SHQ5Zjc5dEJ3dG5aSzlRODVCN0hpeGxwUzBa?=
 =?utf-8?B?QVJBbzNKL0J4cE5xNXJZS3lqVFhxeUZzRk5zelE3Qy9BdndhaFZZditicmdP?=
 =?utf-8?B?Z3BFWlBSNzUyM1YrZDhZa0t1Wmtyb2pkanZIWGo2cmRrdS8yVklmZ2VvNTcw?=
 =?utf-8?B?Y2cvNFZpdjNMeGV1TDY5eDA3Zm84RnRjUkJhL2RwbE0ra0djRGdnTUpIQWpZ?=
 =?utf-8?B?SllJU25hb1g0WXNOMWFQK2M3aXQzMVNNZGhIRytoV1FUKzlZQVE0ZVNhRklZ?=
 =?utf-8?B?SkFCMy9NOHhWR25uRVN6UTl1SWx4NUxubk5MZzExZUUxUld6NFdtbTgvZHRE?=
 =?utf-8?B?aDVkYVpoQVZNRVJSRWlzbkg1VlJNTUFDcWNWSklGN05aQVBrSExyckFWbDg2?=
 =?utf-8?B?OVlKcTQ1bWdCRWorL0F2MEdlcjhRbngyMENyUnBrdUpiMFIyVnNKOVRKTTR3?=
 =?utf-8?B?bmR1aHU4QzJQYmkzdjlhc2RKRE1TRjlyMDBYbmlQOThPd0NUVmhVbHNFOVN2?=
 =?utf-8?B?Zm40VGNTN0pWQzUwTHI5TlBMVUVmeVdhQmwramN0TVFURHFHaDFiaGFkZUE5?=
 =?utf-8?B?b2x6UGs5ZGg3czNkOHpMc2hhUVJOVHFrbXpRb3BoTUI3YUNtVGluSkVNMzM3?=
 =?utf-8?B?RkJxVFJ3bFBzRVpLSG9YZnA1amtNTUREZDJka0JTTFZiajlJMkM4cHpDYmRD?=
 =?utf-8?B?cnYxZjhjK2NaL1RQM1pTOVczdTd6cDlTUWVYQ1U2SW5XY3Bkd3BNSHltenRl?=
 =?utf-8?B?OVJ5RmluS3AvTDh1a0RiakdQeWVHMnYrZ3VVcFEya2c2Z0FvSWIxZWdCOVlo?=
 =?utf-8?Q?6wXYQLDAg1GjtHpsDG6KvKvXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4eeab1-0c2b-4678-8591-08de36a6f9bf
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 22:13:11.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjKuebXQXkqmRQR6BggqpKKFDM0MOvASEus2LSfYZ23NGI75WKpbZ+bST7jmuKbU7TijD19tXqK0gHIbYKIz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

On 12/8/2025 12:04 PM, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 11:02:41AM -0600, Terry Bowman wrote:
>> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
>> accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
>>
>> Change DVSEC name formatting to follow the existing PCI format in
>> pci_regs.h. The current format uses CXL_DVSEC_XYZ and the CXL defines must
>> be changed to be PCI_DVSEC_CXL_XYZ to match existing pci_regs.h. Leave
>> PCI_DVSEC_CXL_PORT* defines as-is because they are already defined and may
>> be in use by userspace application(s).
>>
>> Update existing usage to match the name change.
>>
>> Update the inline documentation to refer to latest CXL spec version.
> 
> Regrettably, r3.2 is no longer the latest ;)
> 

Yes, I'll update.

>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1244,9 +1244,64 @@
>>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> -#define PCI_DVSEC_CXL_PORT				3
>> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> +/* Compute Express Link (CXL r3.2, sec 8.1)
>> + *
>> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
>> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
>> + * registers on downstream link-up events.
>> + */
>> +
>> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> 
> I think PCI_DVSEC_HEADER1_LEN() could be used instead of adding a new
> definition.
> 
>> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> 
> Can you use "CXL r4.0, sec 8.1.3" and similar so it refers to the most
> recent revision and matches the typical style for PCIe spec references?

Yes, I'll update all spec references to point at CXL r4.0 and specific section.

-Terry

