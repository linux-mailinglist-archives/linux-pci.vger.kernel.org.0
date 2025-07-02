Return-Path: <linux-pci+bounces-31315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2FAF640E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC051BC0A6C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF82376FF;
	Wed,  2 Jul 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3R8gV7j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B92DE705;
	Wed,  2 Jul 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492065; cv=fail; b=n68uk6gMJC7eFEFLuOeVAR3cRFZrZ0RfsXtRrtJsUXw3X4THk8DkRKoLZNtDhc3m8NIy6XXBQ1ojPZtv7AzR89/ZxxrnKP6qCeTEV+Cms7BtDz64sTxh6Diyd3o8Gds4Fipx3uYo/Mb20+Dv/k50aAY+k0+uENyQs95JPAZA50M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492065; c=relaxed/simple;
	bh=w+HyysvQPxiqEscx8Z1/LEjKtxewysCKiJzML7t2Zxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=giPN6/fNZs2kIHmDe9UnGrOC3SbQBRdblllTktKf/8wipg76TKPIeVdNwIuTza+BfCJ3njRYtS71miR3PYJ/QF91khyl7S0e8iDCr3Ql1KHq51fg7rLBxBxcdAKLdUZdkGzoE2eGyk+OmqqdiFtm52fsx8ICtKb+pTK/1MziFSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3R8gV7j; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czqb9fe3+p0dCzbpwUpgrkMXvr0gOmnlm9FykdjlyzfgeIBHrqlO7bhb+R5mFsb7KDpswY1I/n/A8qlihVf+ujkpe9MxnyfHyjcuyZwxi6USdq6jwGopI5PzjG5n3X/3s6oJKEN9MhSNoQ46o2DZRvE6CYqWlkUcNbStylvTBnFmJ8vNq2I4N2Dd4n9bnvXCqf8zvHWd92MWYznQG3doL7O8xEIUu4QfLhSsBY8lpcpC4bzBVSPZmZWgSg7GdYsi0q4SiY5JKyuchj95EMzk8RdIa3tvNg+QlAjCjKrGeImKWqo2H51fZtWtpgkHvlt62EnjGXudOEDAGMhJ+xW8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkRs0kf5zfIP0X9JBXoDoKmQR9wOEdaXzmohwrxAq7Q=;
 b=rvVC3AyxMhAcppwp3AyG1dSO40hmQ6VcOwORpgOdrvVTtSvCEzTmHTrZ9vp0UrUl85i3uVG30DTUiXXdTiCXO8phea6OnTupl9ElyRCV6a8q0iQjObELL32vQJRG45I0WWQNlIY/12DHTNKXm08ty9kvC/815OUDI2GHiBeytQyPupw6oxPLT8DOwyZEihpOq2n1Putdsr7I5dF7LzjZfHS1U9feUV8pD0T3OJqCqrdpZp8T19xraDno5Ddaz1u5SubJKtdNXtt938skN2prGv8lqcbl2Vhzkld5Xnf7BydfOM0oeEoJ+8kzoG3CAkK8f8LdAtCD0GGeSR8llzditw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkRs0kf5zfIP0X9JBXoDoKmQR9wOEdaXzmohwrxAq7Q=;
 b=d3R8gV7jGS6w4dYtSYeQP/Ymod/dGF1HJTcVgjGI1dj/xZVQF9GMp8SsLCU5ltIphq6ESJcRrFtHtJYuRksqIZDXU73MF9LNl9bWnwUVtNYBn0RPkmRCu6ltu+2IiDXrYqF14bfGEhuEfzhTfirA9RvrgyvhY8RdZccmqBv6nM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.19; Wed, 2 Jul 2025 21:34:20 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 21:34:20 +0000
Message-ID: <8768d54b-80fd-46a9-b760-a84af06ca29d@amd.com>
Date: Wed, 2 Jul 2025 16:34:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Shiju Jose <shiju.jose@huawei.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
 <rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-8-terry.bowman@amd.com>
 <8b09bb6b1c4d4363996368b67a574e1d@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <8b09bb6b1c4d4363996368b67a574e1d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: fe473456-15bd-4d38-b0e1-08ddb9b0342a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmxKODd0R0ZtcDRQTzVidUh1RUJIcmFwK2M1R0ozSnJaUGxCeVpKV2lvenQx?=
 =?utf-8?B?ekVYY1NkTUFvQnNrQTcvaENsd2NjZVVEOG5oelgyekNDYmtQMnNWcVBCalRo?=
 =?utf-8?B?dlJXQ29jQnhHVDNwRjRrUjRYYklHZm9KL1hXd0x1alhneWRxU0hBNEN0VWFQ?=
 =?utf-8?B?UnJHUGIrZU50ZDVRU0tqNmo4dlVMckY1MFdJWUY3am1BRnZtaWF2M0pSK1p6?=
 =?utf-8?B?WEVpd1AwWlZXbWZkUnpZQ0hhRkhNM0F2WmI3RHpRNkRLVkgxNFBkL05nTnk2?=
 =?utf-8?B?a0pEOWlmTmxWM2x0Zlkzbk5LNW1YVWxmb1JCYUhsZkZ2cEl6U1kreWpzSDBS?=
 =?utf-8?B?cU5sY3pwb2E5TTdOdmRUMCt6bFlZZkU2YzY1TjYybWczUk9vdHdhVStoRXFh?=
 =?utf-8?B?dzlTeDROd3pQZk0rUUxGVUZYYkRuY0xvRTlraEF5T1lmaUFvVkdFQ0ZWK2h3?=
 =?utf-8?B?ODl1aUhLbmNuOWJUc3RzVUw4b3VhOGhMOTNqRGx4enJIRnFOS3lDNlNvUU9k?=
 =?utf-8?B?a1U3NGkvd2hhTlZvaHJnWFFQY0lVUS9CY2IyeTFudi8xVkluV0xHYkNHWTIv?=
 =?utf-8?B?RVdJT0VOVnZxQ2ZnZGVFV0M4eGZFaGhwNDZwdkh2V2xNckVoL1VINjhZcE9E?=
 =?utf-8?B?VW9HcTdHM3JWd25janBHY0trd0Y4QmVySHpOU0pDTEYycDltQk1Ua0lOUE5R?=
 =?utf-8?B?T2VTcmtDUGY3UHJFNUFYeVdTWmZUUGhpZjJYanJNS3p2Z3hmM0JxMnduRTZI?=
 =?utf-8?B?K21FU01McGM4aWhXcEtRQTBDeDNJVmdWOFJ4cEpIWitVamFZZlY1QTg2ZWxn?=
 =?utf-8?B?azJzZHl1S29HdFpSdW00ZmVEa3B2b045ZDZZZmc5WlpMblhYbnVSWTFkM0gx?=
 =?utf-8?B?a1gzbWsyT1JYeDZLQmxHcy91MGR6YnRubmcvbVMwWmJZRURVcVNvT2NSNWdS?=
 =?utf-8?B?S3FsUGNnQWM2YnVJVjlGZDJKRDR2NnhBbmIzam9GZ1ZuTGg4WTBDeFJ1UGMv?=
 =?utf-8?B?SnorOEVhaitzY0twRm9qUmVxenRlQ05UOVhWeXVEWHk3dExGOGFtVXpieEtG?=
 =?utf-8?B?QnZOb0pZdlB2VCtjdE5lbzlpQkErdmRLbDRFeUxqd2ZQT1NSY1hRN05IQm5P?=
 =?utf-8?B?cncxYlRGTkhPcVRZRUZ2MmROZTVNUDg1cG9FZFBsamtjUS9EemtPMUVnVU5m?=
 =?utf-8?B?U0FDWnh4VWtoSGlKSzloUENFNGVoa0tGalNNVUdDcnFlTm9QRkpSZUdaNFN4?=
 =?utf-8?B?MTVyMzNsR2hhWk9GRnloUE1zUFJOMnZBSkhraTlpVVhCOHA5RUdhaE1Vdk56?=
 =?utf-8?B?eTFwN1IxY0xZblNsT1lhclVDb0wvaE16L1lNYUlYaFBWdTlqcVljNVd6aHJq?=
 =?utf-8?B?NExsZFBKb0lhM0lZS08zS2w2YnRYVHd4RDNQT0RiQmtpV0pML3dMMnFSbkp5?=
 =?utf-8?B?VmhMNTJVUHFPY0MwMTdOSitmRFZCbzRVSmZTblR3eXU2OEMyVnd1WTdtMjl0?=
 =?utf-8?B?N1QrNnhWTXJZbGdua09SQVNDRUJXeXc0N3Fzb083TVVOZFRHSkFNcWZqT0xy?=
 =?utf-8?B?RVFSRlFQbFdXVDVmVCtkeEdLTlJrN2pjMWh0NEFFWG1IMlVCd0RoanJIalVp?=
 =?utf-8?B?LzljbFF5bGgwV3NmL0JJdkhkdG9LRk5neWNpNUs2YXYzeFlQMUY1ay9vUVk3?=
 =?utf-8?B?TTQxdCtsTVVwYXJ1ZkFuQlRZLzBYSmpLZWdIZUliZVhyQWhYT1FaWmxmWTdz?=
 =?utf-8?B?amQyRDgxZjJQa1dWQy9GOUlmSUtGYS9lQ0JmV0t6NDNhdEpSMFNWQ2d6N1lX?=
 =?utf-8?B?TENldGNvVi9rYUNZYlAwc3MrSUpVZElYcHFCaTdJcFM2RDVaNEJmb2xNeTR4?=
 =?utf-8?B?OFRQMXhHVUpaUjMxbkx5VTJLaC8xZ2VtRGo2RDRuVy9zazh5dkhyeDRuU21t?=
 =?utf-8?B?RFdxUU9samNoTkJaUDJsbkwreUNXR2kvSTJ6SnFDVFJkVGVwaXRON1E1b1dp?=
 =?utf-8?B?aE91a3h5UjFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG1GNjZjTFdDK3d0dEhvMkdabTAzclgzc21xUk1wQ3FvNDArUW1RRVNudXBk?=
 =?utf-8?B?V0hybVplcmdMTzdtY0szYlVOWFNHTHQzRjNQRkkyKy96TVlObG5vYndKWkk5?=
 =?utf-8?B?YmxjZjBxVGZMZmhXSHJoWjJwaWMwL3dXNEJKZFpEMVZ3ckV6Nkg4MFBZWEdK?=
 =?utf-8?B?VHc0ZitQa05YdDE5QUlsSTRFUXdKQWRVT1RtNzdrMHNVZVBNUVFxTEhwV3hl?=
 =?utf-8?B?ak1MdjNIdFdBVVJqNFJkelFEVzZRRXY4ZTdZdGNQVTdxUytNUnEvS0ZkcGx2?=
 =?utf-8?B?MnZtRy9TdW40eDN2YUlFbU1jSm8rcFJZeCtVbUpxanBDYUpuOXgyMVhiNkha?=
 =?utf-8?B?UHNrTVVWRjNMUmllc0p1YndhdE5VRE1xZ1M5anBON0dVUktQQVp3dlE2SGc2?=
 =?utf-8?B?R0sxT1VwTmdkbWpPN21kN0g2ZUR0dyt0V1E1WTZsNWQwUE1wS29SaThQbmRU?=
 =?utf-8?B?TUtCcEF2RFVBZDVPYzhuWms4SmNCaGVCV0dKa1pmTHFkeHVldGJuQzQray9v?=
 =?utf-8?B?RHRpb29ESTNPaTlpNmorYjdaTWgwVGtXU0JOTGhjR0xyZTUyUm5GUWpSTGRr?=
 =?utf-8?B?Zkh3TkFQZWNFd1NEMGIyVGMzS0hZVDJSNks5UUgvalpMTmViMHJ0TzZIZG5D?=
 =?utf-8?B?amR4WmluNGdoWkRQQnBienYxV2VLMnJxTmNuYlFHeGtRc091eElqNGNrd3NS?=
 =?utf-8?B?UGNWTUpEZElKV1p3dUxCV20vZFg4UFV3TE5Bdjl4NTQwYWJBaE9lOVFmOVhG?=
 =?utf-8?B?ajBzZHlzYk9mbnl5S2xhN256S2lINXYrTm9Nc1BqTE9rL3dPTERDMWxlcVBI?=
 =?utf-8?B?Y3pvM1RUaEloS1d1UllZcDNFUENQS1NLVzZHcnpocjVranlaWWVsQ0o1SzR6?=
 =?utf-8?B?UHB5bmtBWlEyMTQzNzRTaVByVUdoVVp1aVJDWUdJSDgybER6VVk2bllnM3E3?=
 =?utf-8?B?SGxnUUFpU1FoMUpHWTFNeTZucFZ2RkN0bVNCamhjMjBSdmZnRUVYZGxITmRo?=
 =?utf-8?B?eVZIVS8vaGt0TGN0bUxIa2ZuanViYW1xWUpBTjZVRVkxNUFMY3cwaTBONGJB?=
 =?utf-8?B?Q3NwemsyTGsrSUFHaENwZ09vVXJITElyOWd0NUh2N2xxZjJLcWFQT2lrMTZq?=
 =?utf-8?B?NG0wYmdEdUl3U0hMUWJyckxEZXRWQnNNSTZGTC9rWFRwMXNqaXZwRWJaQWdh?=
 =?utf-8?B?anpQOGd5a21yY2JodExHbW5Ed20wd1RmZFRQUDR5Y0VSYUVDR2xxMzljS3ND?=
 =?utf-8?B?d2NoUlZqVjRGdHFtdlJUWkhuZWR3UUd1Vmpnc0JTMkh2Qzd1MzAvYnRyNWR3?=
 =?utf-8?B?U0N0WFprYWFPQUttbHFuSTV5ZXgrRVhwRE1KL25pSW9uUm1TRTlXUS9lOHVY?=
 =?utf-8?B?UmpNdHF1OHBFQnRNUWlobjExc09zTkh2VVdIaHQ5SnJNUERidis2MDNTUkZ3?=
 =?utf-8?B?Z3U2VjEvbGloR291MnBZRkt6NzhvQk5OditpYXpSeU9VOXBEclUvd1lXU2tu?=
 =?utf-8?B?eDRrTnd5VU5NekN5b1hrVmxJbTQxZi9XeW9WOUNtM05UR1pJQTM4Z1ZBeDdZ?=
 =?utf-8?B?VnNRcDJQK0JXL2Qwb3lwY29GTWlLTDlna2hHdDVIYVpZcWZITnV1bDVOUExr?=
 =?utf-8?B?NjdES3NiTG52amVDUjE5WGZTWjFDOURYNnF1VzJsNGwvbnpkSDZJSDdNbUZK?=
 =?utf-8?B?M29kOVBuSW0xeks4eHV1bnVuejRneWhyY2JyTnZka2RYZmd4OEJqNC9iK08z?=
 =?utf-8?B?aVhGWk8wZzFCa1lUVDk1cFU5MTM0ZW5ZREVyZDZTME84aURFZHRSa2xSREFS?=
 =?utf-8?B?Y0llQ295WEN1WnBIL3NEb2c2RTE1SFdxQ2VUdDZoRGxjTnlocS9SR09Cb2Ey?=
 =?utf-8?B?cExKZmFGekJtK2tCdThKQmdHOXZWVjVSTDBmOHlqRjFWOVZIZUQwME5KSSt5?=
 =?utf-8?B?Z21TUWRFQ0hsZkhuYVJaQU9OMWsrU2p2ZXU3K3lRM0JnWTNvRFBKUjZqVUF6?=
 =?utf-8?B?YjIxdksramVGWUZUcTNkdVZEcC9XeENEU1pWenJtWE5YMThaM1h2ZDFGNkU0?=
 =?utf-8?B?czJtaldnNTR5cWlvMFgzUjhGVGhad1Z5TnBQUmFyNnY1b0dOK3RZSlFwRDVV?=
 =?utf-8?Q?0AUdLaRDmC1QshCszmXTHJMEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe473456-15bd-4d38-b0e1-08ddb9b0342a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 21:34:19.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI69LRIRbEy2HHD4FXHiptRCDapJ1vgQYDJemelufJRrHedoEgBFZ5rHPd2nThjkbCKMpkSxzrtNusLvIHqC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184



On 6/27/2025 7:27 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Terry Bowman <terry.bowman@amd.com>
>> Sent: 26 June 2025 23:43
>> To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com;
>> bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
>> ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
>> rrichter@amd.com; dan.carpenter@linaro.org;
>> PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
>> Benjamin.Cheatham@amd.com;
>> sathyanarayanan.kuppuswamy@linux.intel.com; terry.bowman@amd.com;
>> linux-cxl@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>> Subject: [PATCH v10 07/17] CXL/PCI: Introduce CXL uncorrectable protocol error
>> recovery
>>
>> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs as
>> fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Export the PCI error driver's merge_result() to CXL namespace. Introduce
>> PCI_ERS_RESULT_PANIC and add support in merge_result() routine. This will be
>> used by CXL to panic the system in the case of uncorrectable protocol errors. PCI
>> error handling is not currently expected to use the PCI_ERS_RESULT_PANIC.
>>
>> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the first
>> device in all cases.
>>
>> Copy the PCI error driver's report_error_detected() to
>> cxl_report_error_detected().
>> Note, only CXL Endpoints and RCH Downstream Ports(RCH DSP) are currently
>> supported. Add locking for PCI device as done in PCI's report_error_detected().
>> This is necessary to prevent the RAS registers from disappearing before logging
>> is completed.
>>
>> Call panic() to halt the system in the case of uncorrectable errors (UCE) in
>> cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use if a UCE is
>> not found. In this case the AER status must be cleared and uses
>> pci_aer_clear_fatal_status().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>> drivers/cxl/core/native_ras.c | 44 +++++++++++++++++++++++++++++++++++
>> drivers/pci/pcie/cxl_aer.c    |  3 ++-
>> drivers/pci/pcie/err.c        |  8 +++++--
>> include/linux/aer.h           | 11 +++++++++
>> include/linux/pci.h           |  3 +++
>> 5 files changed, 66 insertions(+), 3 deletions(-)
>>
> [...]
>> void pci_print_aer(struct pci_dev *dev, int aer_severity, diff --git
>> a/include/linux/pci.h b/include/linux/pci.h index 79326358f641..16a8310e0373
>> 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -868,6 +868,9 @@ enum pci_ers_result {
>>
>> 	/* No AER capabilities registered for the driver */
>> 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* System is unstable, panic. Is CXL specific  */
>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
> Extra space is present after casting?
>> };

Hi Shiju,

I see the existing PCIE_ERS_RESULT entries have a space before the number.
For example,

PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
                                                         ^

I do see that I had an extra space in my comment that I will fix.
Please let me know if you agree or if I'm missing something?

-Terry
>>
>> /* PCI bus error event callbacks */
>> --
>> 2.34.1


