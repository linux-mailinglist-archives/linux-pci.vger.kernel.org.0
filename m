Return-Path: <linux-pci+bounces-9200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116F891537C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE3C1F21B8B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F119DFB0;
	Mon, 24 Jun 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yiJ7plHk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003319DF61;
	Mon, 24 Jun 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246142; cv=fail; b=iy7qPoPakhCTjZtwVZcdAq++7yL25tEy12tLymOlE5UouS2FaCQgWdnfEZu5C1Rbvxd4pkegoRP3koLatpk/XvJD3ci/dOSAksnSmEZeQJeFrgIJmBUDZYdMW8ngAt4odh+sZbD9ePwbT4K7fyfRiqKyhLZ6Wnnckh/t7v/Wt2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246142; c=relaxed/simple;
	bh=OpUTy/sWZmTSXm3fxKBq5Wdz3m5upUvCphh1YVtDhWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kDvotpUZPaT7AyWsA0HUtUgd1lJvFWQUXd60+5xcE/JchC46rxTVt+VApK8pmRL3Le/Fq1s5eJjfykeRYH5UDGpMKu35Xi27mUP/TU7GASmA3wRUTwdFzSoDceoSO6Q8dFWUdjMS8drjtyhzRa5XX98p0AtzLww3a73aPBXbGcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yiJ7plHk; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVqGlluhvqa0T+Z1UUiTEOIr/N/8clOmn0+GlzC/4fP+ADUc6PjjMl6XEndU/J45KVZOLoUOzz6HC3Ytckw11AGAopuWxK/nOdSq5WGGyeu5Sv7VVoWV9n2Dr4CtKotRfbaCdcJToiUvNvkxMTz18WxajXVQmn0sAJ2Nii7N5x4oKEDPX8k7u85I627U2pDH/hHgL/+9qQAUspA5+WamxyJ+pUfIMW3wSHV2GDbVeGSNBC/oJj60UYbibfXThk/8ibxQd8yl/gzgrE8IDEbhapf9psUvMolqvneHa2Wpc0TxvlOZfJxwj/z3c+UByUia7oob1imw8By9i1Hfuuy45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHMe7rvPqpZIXMLxD+JVWGbNXfZ+GtmfB1UBAVZaVCk=;
 b=GsOfnbNitPMCC4X6OWNGc/YduZpDRaV7ka6+OBuVPPZTNlFECBU3Qt82LoJZnaMgwoAym3MfGKXI4pBLz7mD1ReUF+5Tda3aA2/rqYilGaPq1GJMTeeMWH9bNP6T6+OKUNri68fHM4H4PRhz2zHJ72SYmZ4h2RXH/DoKVsKyMSqJ9iEf9z6ddpIziCfGYgI5uZlQEFGy/Z2kzgHnz4oI8g7dlAeRL+sLX1oT16BIjq7Zt0E2nc1G+z3XKmq/geIVCKpbQ9Sa50Z/LqVTdTYKtRNzxYkCMqEHf4MvVHXWi6Fk+Pddg0bKiFWWgDovCPUKA/i5J18kl6dEk4VylTRQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHMe7rvPqpZIXMLxD+JVWGbNXfZ+GtmfB1UBAVZaVCk=;
 b=yiJ7plHkkPomCtH1/heO2/Rf4C4+ARjswiQjXQK93NRPw8/5rDCGmqjSfRyS2pUEax97pMjkpTYIjG80R61iVfJuc174D4KZbukHcuZYLLOAlWIJm8P8GkxDovzhUvkojL8G6KCQaX3X79pWR1+jPt+wiWpHpFch16V9MTu8BpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 16:22:15 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:22:15 +0000
Message-ID: <a9dfbb38-4108-47cf-8305-fa9b4eb9a87f@amd.com>
Date: Mon, 24 Jun 2024 11:22:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/9] PCI/AER: Export pci_aer_unmask_internal_errors()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-9-terry.bowman@amd.com>
 <20240620141142.00005cf0@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620141142.00005cf0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 67df2569-dbfe-4bd8-d343-08dc9469cf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkw0dHJsWGE0Y0dieDBhM3docVpvVUc4OTJaVGRxVXRTV1pBL1NCR2pKb2d6?=
 =?utf-8?B?UDZNZGZZZkRZd2dEM3BldUpwemlhUXkrWlh4WlpKUEFNVkRjNlJmVklqcGM4?=
 =?utf-8?B?bVlGajFVZG5JZTR6eUZ6THd1UlRQWHcxTWFzaWVLVHhZVzFWV0FrTzBpYVJx?=
 =?utf-8?B?RU5QRmVFUktIRkxjZFdMNVhLMmwvS2tkeHkzT2ZlNC9qcEY5VTloakkrN1BF?=
 =?utf-8?B?QUxQVUErcVJlUUlpaGpqS25lOHR2MGpad2RhaS9SMi9ZR3pvajBEVzNzajR3?=
 =?utf-8?B?ZW1KMklYRllFQ1gvR0RYU0YzZldYRWptbTM4TEhraG1GN1dYZHY0ZjZEd3E3?=
 =?utf-8?B?bC9YT2poQXBCWGxXamxUalV3WFlLV2tOWmJGT2EyazFKUXVXcDR2ajZ3d0Zt?=
 =?utf-8?B?bG4vQmxnZHJrelA0UnExSnRYdjF6TnNEM2FkeThKQkhTZ0YyNHVlaXFGaHM1?=
 =?utf-8?B?NGZTcFdTVDNmWHE5VHRsMmw0UDkvMHJ6MVY0cm96Z3lXTDFQTjZMY3hIcTgw?=
 =?utf-8?B?dDFzNXJ2U2ZzcDRBNERhVDU0cXYyWVd3ZWNmYkJiN3o5VHZqYWZMaDlvWnJY?=
 =?utf-8?B?Z2NZNzdCMjRQa1JTOXd2Qk9JY3d3U1ZiTTQvVGFKdmtRY2lQcFgwenRoK29S?=
 =?utf-8?B?WDVYL3F4TVRlTTluRVpBZWpzWUlqVWFYaHFWZWs2dHJqc3Q2UC9GeDhHajhR?=
 =?utf-8?B?MzFLU1lUQUJUQzlQc3pzQ2hoSWlFWnNEWHM3REpRMkhxaTRUcWtFWFF4RW5m?=
 =?utf-8?B?ZXhtUWdLZVJEN2pyR1prYy9maHFnWVNIaEtZSnJ6VVRDUGdvdFhSUk1SaDVy?=
 =?utf-8?B?QkdrNnJKYVJmZEtxNDRjMFZkS0daRXJza2lndGJzWUFBRlc3YVFidEVaRkM1?=
 =?utf-8?B?cVpXQ3FxQ0NKRk1rV01IbGtMWkxjYitHYXZQeTZIQmxoUGRTNUZxYUZUeElq?=
 =?utf-8?B?aXltdWxyNXVsNFp5elJjdTFTSHk0RXdsamNabDR0MnNPRnN0bnRNR3ZRQmlp?=
 =?utf-8?B?QmZXSHErdGlSbldmRzhZMWt1cDZBZk9xd2Rnb29va1lMSjhEbHI4UGh4bUFT?=
 =?utf-8?B?NG5RcjljVmlNM1ZtbjhaS1U5Q0gyZllNYzZLNzZBMWcvUkFCYXVwelVvSEFn?=
 =?utf-8?B?ZVA4Wk53TC9FQmJISlBGS05GalBQSGlrVXNYTVBGMlcxRFUvVW84bjlMUzZh?=
 =?utf-8?B?NjEreVhuaE1CdkFCaitpQzdHOWFLbnhQV3lYL3B4MFFsTDJ1YlY1RmFRRHd2?=
 =?utf-8?B?aVBnKzBOY1Yvb2RnZE9jbVFFcktpdWFRdmlGemxrRzJiV25rbVZwS05VaWE1?=
 =?utf-8?B?UDNZbEU0NVpEb20rczgwZ1VGOVh4VHZlSjVoNllxbnhkTE45NkJLK0s5MW5u?=
 =?utf-8?B?c3BndDl1NllYcnFOTWFUNXVSNGZRZllmZjg0dS90eVVXc1JRYmYreTF4Q2VQ?=
 =?utf-8?B?aGlrWkpDZEU2VXYwNFNnU1ZUT3FNdnkxL0V4OW1pTUhSUVdaOTNsVFFXcTBs?=
 =?utf-8?B?RE4vSUhpOGVtd0hyamJsekpIemlscC9KeGJqUUxlVFptY0l5T0FIazROak1F?=
 =?utf-8?B?S1B3TnRnYzdZeW1lVGpKRlNQQlI4akQwbUNrWDdwMGdrSmhXWlpKOXRuRXA1?=
 =?utf-8?B?TTJyN0Z3OEh5Z3ZNeTUvY01lSU5uWWVRaGNjQzhDY1QrNUFBb1BNTEdRQzBi?=
 =?utf-8?B?MktHS0pPeUN5ckRRSmlmSSt1bDVnc2o2TFQ5TEdCQmZzKzBBeStQYUg4ZFls?=
 =?utf-8?Q?H0wdvDJRquTgXcSEyFer4imYWiZfzcPPs06CNny?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFhxSHZuZXBCT21FUGhKbXlGM3VTMFFnOFVGRi9sMWhJMmhFc0dKVng3dVN4?=
 =?utf-8?B?M3lPWC9ySzg1dkFMc0xyclNuU1pEd3Vib0s4dHBYazNGRWxuV2x1WHM3eG1z?=
 =?utf-8?B?K0FhZjBOV3V5NTlQV20xaWlHRENZTk9aV1RRMGtobU4xeTF6R25hQ1R3Rnp2?=
 =?utf-8?B?b2tBVlY0REFRSzhOWGR2eDcydzgrNi9JSTJrTXBWMzZRb0R6TTFkU1dKNitM?=
 =?utf-8?B?RFF2R2ltYzNYQXlqcTgyK1YwL0kxY0FtY2NaeFp6YnpMb3FzU1g3UWV4R25j?=
 =?utf-8?B?K1c1MmhwcG85VEFqYmoyNXNRUEJ2MktSN0pVdXJKSFY4YTJhOElsWmljZnNq?=
 =?utf-8?B?U3JQYmxMQ2wwcDI1T0g0dlJ3RHBBcURZSk5WTkd1MWpYdG1SYTd3VWJienZu?=
 =?utf-8?B?eEkwYU9GRC9ud3dxZTg3U1dBZTFwc0lzaDNBenF3UUloZk5oaExSTC93SFJ6?=
 =?utf-8?B?bE4wdU4xdnR2TURySzJJNkxONDliVzZMbGxRbnZNeDF4ZjZhbHVscE9KOWl3?=
 =?utf-8?B?N1lIV1liaXJadEUyTnhmV0tJNzRydTYwRitORGFDRDNqbDhRS3BabU4raFZG?=
 =?utf-8?B?cWdvc2RuVmFGMkZkVFR0YXNTQ05QSDc1RytjR2hCRXhseDRrSzNUb1UxS2JX?=
 =?utf-8?B?M09XRkpRdXZocyt0bjNEeThIUzA4bXJkWFlSK1ZoWEVFRmZxcnVKT25hQ0N3?=
 =?utf-8?B?ZHEvRDNxVElpcGdDa1ZBNzlUbzdMSUwxZWhxZG4rd3kycXoyUTVtai9IL0g5?=
 =?utf-8?B?SUtXUDI2VFlhRVEvZ2tMc3o1U3RqZGlGYXJyK2xUaG1pNHlSVllZbktseG5G?=
 =?utf-8?B?WlJ3b2REQ2NqUDZsSllRS2ozYVJud1VSdFdDYWZUMjRhbkllQTVUbUljZmo1?=
 =?utf-8?B?RzNPVENPeWZTM3JEWWxCb3hWQk8za2h4WHliaGp6b2VWVVNZL0xMNFkyK2hE?=
 =?utf-8?B?Zk93TTlvdVkzcjVIaWlhdGVpSk5mdHhaNVMxRGJhaWpBZnJ1czBqRjU1R0JM?=
 =?utf-8?B?bkMwR281ZWxIMDBHaEVYdktQL0NPNG9NWHQ2TU1RMEhYUi9tcG55UkVNR0tM?=
 =?utf-8?B?VHA2R1I2d3hPWHFOY1RLWmNPOXduRm9Rck96cEpzK2k3VnhIYjB5TWdmbkNS?=
 =?utf-8?B?dXpYWmpxRlZzVWhjSTYxdGdobFY5ZWJnTERrQmk2dHNDeE5ZKzVPYzdxeDM1?=
 =?utf-8?B?OEdXbyt0dlg5WFhyZFJxV2kvT0ZzWldNR3M5T2RRN2xGMHBxKy93OXNXTUtI?=
 =?utf-8?B?VTh4RDRqOG5oT2huL1J4a3JCdHBFdzNPUkUzanVZZVRHcU9TeDB6a3ZsNWhN?=
 =?utf-8?B?b2ZNYlhFTVZpbTgxbFdXNE4rSEk5WGdSbEk5RUVCZ0Z5QnVkYnpvNTVrbUpt?=
 =?utf-8?B?dkpjS2poTzlMNjNQYkNqcDNMUmlhTHpDUXRIa0VCYllzalQzbGpwRVAzMVUr?=
 =?utf-8?B?elg3ay80MUhPQ05iOEk0dGZLUUh0YjVobi9aaFFCT2ZDbFo3ZmxLK2JTQlVM?=
 =?utf-8?B?M0Q5cS8zbG84ZWd6dnpRYVRSdmhMc2I1VEZqZkt1WUgrSks5L3lwRDd2ZW1v?=
 =?utf-8?B?elFydkh5SnpYWFZXazJCeHVSQzllamRNbzZ0NDZTMVJkOTFZeEJlNllieWdj?=
 =?utf-8?B?M2d6MGFoUXFDUWxJdExEejdXcDlyc3N6VUo3ektPUWJwVXYrVTdid2FDdWRB?=
 =?utf-8?B?cGQrMnFCZDloejJmK0N2ODcvaHUxZXBUNmxWR05UeHJjbFBsSnFCTXNEaUxW?=
 =?utf-8?B?akNYdEc4YVRWREdUc0hZcWNYcS9JSVd3ZjIxaGorL25pbk1kOG0xd2E5TUFI?=
 =?utf-8?B?dWNKSUdIUHQ3QjNnblgvZS93akgvc1JGaXZtTVNxSWpjSmloMlBvWDNOZ3di?=
 =?utf-8?B?UG9zKzF3ZVZEd3ZmYWs3bnJNNlJaSTZPbnlZdktFRkdmVzdGVXJjWTdtV1Ex?=
 =?utf-8?B?aVc1eXZ3KzRGdVdEajVoQll4alJTb2VuV0QrZFNnZkJVVXZUTzQrUWNNcDcv?=
 =?utf-8?B?aWRqWXJVaTBoYnNiOUd3VFErdlBWMFpYaEREVEREODlqYURKcjRwVnViR1E1?=
 =?utf-8?B?RDBvcDhhTVhJemloTGR5eVQvV0VCTnhUZTJQT1pqOU0rNDBBaXkvU2hVWXYv?=
 =?utf-8?Q?2G5+CCgdbpt7/olsaflmuFf7O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67df2569-dbfe-4bd8-d343-08dc9469cf5e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:22:15.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7E9IXvy9u37dFsYUIChNOx4wLZTopD2Sp46IMRVCJ7tzYtoic7sWFmN+SJnyqJdFVNQ2vyZDSiAVcnXt6fAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

Hi Jonathan,

I added a response inline below.

On 6/20/24 08:11, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:10 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> AER correctable internal errors (CIE) and AER uncorrectable internal
>> errors (UIE) are disabled through the AER mask register by default.[1]
>>
>> CXL PCIe ports use the CIE/UIE to report RAS errors and as a result
>> need CIE/UIE enabled.[2]
>>
>> Change pci_aer_unmask_internal_errors() function to be exported for
>> the CXL driver and other drivers to use.
> 
> I've perhaps forgotten the end conclusion, but I thought there was
> a request to just try enabling this in general and mask it out only
> for known broken devices?
> 
> Admittedly that's a more daring path, so maybe I hallucinated it!
> 

I remember there was discussion. A quick search for PCI_ERR_COR_INTERNAL and 
PCI_ERR_UNC_INTERNAL doesn't find any default enablement. 

Regards,
Terry 

>>
>> [1] PCI6.0 - 7.8.4.3 Uncorrectable
>> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
>>              Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pcie/aer.c | 3 ++-
>>  include/linux/aer.h    | 6 ++++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 4dc03cb9aff0..d7a1982f0c50 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -951,7 +951,7 @@ static bool find_source_device(struct pci_dev *parent,
>>   * Note: AER must be enabled and supported by the device which must be
>>   * checked in advance, e.g. with pcie_aer_is_native().
>>   */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  {
>>  	int aer = dev->aer_cap;
>>  	u32 mask;
>> @@ -964,6 +964,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>>  
>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4b97f38f3fcf..a4fd25ea0280 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -50,6 +50,12 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>> +#else
>> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);
> 

