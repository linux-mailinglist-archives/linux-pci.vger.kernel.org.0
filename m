Return-Path: <linux-pci+bounces-3558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6785707C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441431C21D0B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9183613AA23;
	Thu, 15 Feb 2024 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jc1RevK1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CA13DBA4;
	Thu, 15 Feb 2024 22:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035726; cv=fail; b=ibHRXesOcoc0dpAJauNGY68tjsk/FgU0/Vl3sjryF3Tfn0OfchuKzSsC0F5tShKIto462LXnCf/zni/uBp94IFwwFPLenPt6o9bq6NLwnUN/ykhfqc4LSjJPWqTxztojA5ihFq0hrPHMuRNeXUR1ZqkqfrXwXdXtMO++5Bfy2E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035726; c=relaxed/simple;
	bh=sNF74B5YqtlIAksb7n4W6B2i6bSMU4rmosJE3/t1IFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ONG5NkMNJcHXAkNev6iTJsuAM3jSGAmh37bbctOwiyA3+tcBSpC1YAMpMBSIKMc3eWoUEF9WXUy+/ntDXgi8B5VmeKfeYB0UrwDQnxiVZAW6JPBuWIXeb6yCUKbfkAe/RqX2AAkNPC39oDBOje5AeyjgK4eaSPYKF7ggvvQwCjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jc1RevK1; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEmf9nNO3xLH60DzhqO22FFL7sTLbCg5I8YFWvS0vYRE4CbX2S3FS2zW9zF10+uCRz9QE1p9JT3/x5E3V9JWq+TdhOQDdVEFclfWwPt7wZ9EmxO1qIrPc9Mrh6lIwJKPW8NJgNxTd0/STIjI40+a0dj62VwKccMKBD7fIkDgoIDU8jZSX5NaTS9KFXC4qzQwOb2/bKsWrBMM8uaWaItuC/HibhmgWKL3cJtcK6+dRSJQX3nP4tyZBKNiR698bI+9oU433uJk2VvzL9ir0AMu6M6hJLFB+2FYYVbCkojnl3TsTo5bvi9qlkATqoTxMRicRz04+jmh9IvF4cf48Uo4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L5cBCP7VvwKs5aAxCWAW4GftMAdCUMt0nihGgQQZOk=;
 b=LINutwyeZwU4ehmO/C4X+Ku17UqsyRjAC5E1v+Izg32vlTFwBdt5GUU3Ej6pgH70a3QjQn3xLNp+ZQbhnZvTSRE0dztk1EUjMjqQERo65BoFB3N+dHc1zdMWwXy/bCdjkQSU7d58KC1EWiFoguKINZStMdO8jalyV6C2E2np6+sOYw7aEGNAUmN7lHYWiv1rQbH7osJ3HEvWM8sKbmgqePDAhqyVPXw6R0ODK5xCogjLEVuCQSGTIJHHcMv3Ctu+4pi1KyEDbS1MCHzRX2iW7K04QG6iAxWrs+lWtp6lLK8KX3xRZ6BgSfY+IxGuJMH6fI11ptyMfnVFkcFJm5/84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L5cBCP7VvwKs5aAxCWAW4GftMAdCUMt0nihGgQQZOk=;
 b=Jc1RevK1IPvDMewnAUa7QkYU+AbGS6sLAdXm2LVrDlyBob2XRKZmvLR6KNfHGOAoL3BczHtIs4fbxrjXcuibZHfXQ/XKJjX8CNRtxMTiX2yPB1UIo7H9mflvKGesTFFltjo1N+s7/Bk0Rohiu8WjfRDwX8F50Ww1Y/5qDnMZMMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 22:22:03 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 22:22:03 +0000
Message-ID: <ce95bbac-2172-4edd-9f88-8599ff1b2780@amd.com>
Date: Thu, 15 Feb 2024 16:22:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] pcie/portdrv: Add CXL MSI/-X allocation
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com
References: <20240215215123.GA1311182@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215215123.GA1311182@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 555cac43-974d-4259-f819-08dc2e748910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SaTAAiDYDKsqhLME4RTGdNfDx/ROXNBGsWdE7qCBd9XoTtJkBgiIvG+fv5hstlu4TRlDWwWrEoPi5HTCws+N+8ShSb9OR1XnGmo/coWPQqqer0pAWla6BTGesbdoKLmSKk8uqneXeccfDZ9VlFKWj/q/2sE+Vunt03c/BJoFo8Ixyd4keUFRf1+e2DHQEAWymqAOg4FAwX2pwqY6VKb/5Bu11BlhxwcaF52dLgnNShCdR8VpQNdTqrUS0fXOE+6YPLPjlYr9NHmTgq9DnOctSy53Ejpth6bxmCDD4eeNNAwusA6I0XyPQqU1C7E6vJ3MPNvkultrsz+bx3CNQQRWVcdR9HErq2X14eE3hayi8Dub/7I/bI+v/Imj3xSlI0waiNqQxvZbRMgwZENtTfAL3kweEoIWOB7ykX4EbRSvrSjO6coxWpsWenyPVEBQ+Axp+hvQmgIMCFE5zVmfHNFu8rc+wSof8KseNZ+Yp4/oPjzbm5bEkJ5ldddQL+D6Lujbw4KPDZohIPkixIbM5knaP4KpPiH3ztnUsWGnbAtpjIuZ72O3yEq1JynvAwb1L/BI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(478600001)(2616005)(41300700001)(53546011)(31686004)(2906002)(66476007)(8936002)(4326008)(8676002)(7416002)(5660300002)(6916009)(4744005)(66556008)(66946007)(6486002)(6506007)(316002)(36756003)(26005)(38100700002)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Umg2eC83WTlZUzBZOEFNQ0tka1ZNbnZtUEY3OEdrQWZMSWxYQnlPRkgvQjBR?=
 =?utf-8?B?UmZka2dNT0Y4QjhTUmtrcWd0c2FKbFFOQm5wc3c4SWFXaC9XUkZyNjgrSExL?=
 =?utf-8?B?RnZ2TDI2Sml6MnF1OUxDQTJlSmpuRU1YYXlPZGQxZk5lZ2xPSnl5aUNGcXNh?=
 =?utf-8?B?WVdEdnY4NHJMRlJubGtKUllLQlJ5ZG03WE0rd3c2Z1Q3UGtMT1hqOHpqV1lV?=
 =?utf-8?B?eWxyQXROU0Rqb05NQ0dYZE1RTFlGbkhmQW5Iaks1eWJENS9EQno2ZlpUNGRU?=
 =?utf-8?B?eW0ycGVyRFFqRlFvUXZSZjNVVXV4L0pYcU1CTDZkV0ZDUUptOFoza2thb1hW?=
 =?utf-8?B?ODBkSG8wMTJRRUpvTW5mZlkraUV1d05uMkJPTmtud3JEQVcrazJyYlhBNE9u?=
 =?utf-8?B?VlNOSm9HaVBOS0F3WkJSUWVPMERkaXBLOVk5QjVCVzQyMzBFWVJGU2l0MUI4?=
 =?utf-8?B?RVZ3cWx2REJhUjBBNDhkUHlyenh2WllCOGlSMG5jV1NSNndxMEVYRUFDUXZa?=
 =?utf-8?B?WEFIcTNwaFd4RFlMR0I1NlNmNmxhTGl4SWgyd3dPTGpUWjE2ZkZpMFBwZEJk?=
 =?utf-8?B?UFcya1JlczRHekNYeXN5NUs2SjNZOHVhVkdJK0RaNWFyNUdvbUxsOWE1WnBr?=
 =?utf-8?B?SmVIVmpvYVZqdjNBMXRKUXRwdEZwOW5sQTR3d1FNN3ZDYWxMcElPemNNejll?=
 =?utf-8?B?TXF5NTk2RWFadE1WQ2ZSSTdlUEo2bEdIWjloVGtDRlZRbWZIaUR1V2xXMFpW?=
 =?utf-8?B?RUoxdWxtUWJ2eTYvZFVpT2RZbEVYVUtBcVhpdmhDcG96dzVPcnRPeDFMRTNo?=
 =?utf-8?B?OE5ra0ZhY0xjWFRjejV3eUx4TUNkVHBSZkJaRDQ4d3JyYmdLaElKTVEwdGZM?=
 =?utf-8?B?dFRYVWRwTnNnNXFJb08rVXh2eXllMWZvREw1bEVjVy9RVDRTb2RNdGVIaGU0?=
 =?utf-8?B?TVpPVURsZmM1Zm1YUm9FTzhsWHVZaU52Nm1qZVV1MDk5SVVnVGcvVzRPOHhU?=
 =?utf-8?B?aHAydkVLSDV5ZWs4WlhHTDVvYS9LeW1Ic3ZBSVk5bmxaa1ArRFFacXN2ZnRQ?=
 =?utf-8?B?di9HUFlSdHBUYWRncHVxU2hualM2Sm41YUVxdi9Zb2ZZeTBpYWQ0MjBORE85?=
 =?utf-8?B?bTlmRjloY1R6bnh4MmUvWVNIWWVRZlVVbndlVy82cW83eDNLVGdsNmd1R1hB?=
 =?utf-8?B?d1M4Ryt5aHQrQ3N5ZW1kYlF6RTNtcmF2K3Y4R1B5VkZUcUNPcEpTd0IvdkZK?=
 =?utf-8?B?c0FoZVpucnR6bWlHbStzOHNiOVVjS3RabkhUSWg4dHNXelo0S0o1cUJOczl3?=
 =?utf-8?B?cUZiVFhoM1BOSjVZY3d2Q2tjL3ZHUndoamJHSHlidWJlY1g4NkdRWnV2OW1E?=
 =?utf-8?B?bURzdVlNK3dYUzJLZDlUS0J3Ynhac1l3WVRJVGs3NFdpR0lvcjlHd2Z0K0ha?=
 =?utf-8?B?bWFueWZjN0NpMG9Pd0NGZVNZZDVPblc5MG5xTlJES1ZUQ2YzazBuNDVxYWxM?=
 =?utf-8?B?U01zMmVQZFRjR0ZVMGJCZmtwMmYyclplL0R3cm81ZC9pUW1GaVExd1A4dk1M?=
 =?utf-8?B?MTMwWXhvK1ZJL01hT21GcGpkRm9CYm4raDMvMUdjOG04Q294YmJNQzRsOXNr?=
 =?utf-8?B?eTZ5MzZnU1E5Vk5UZ2s4ZVkwUHNleElPM3k2cGJwUmJHYkt4Z2RpQ1hYcGtK?=
 =?utf-8?B?OWpxWDRTR0lBejRTcnF5aXljY2hhUzhyZkRVSGFnVWRTbFd3TVBFRWNvOXlR?=
 =?utf-8?B?YzgrRjM1OWw0WGtYQmd2b3ZIWDJsSWxhY3dmWkRKVHplS3VkS0phS1dPOGFq?=
 =?utf-8?B?UlZ6ajBsUmd2TU84L1FIeHFRYmdQRXYxL3MycGNIdjRmaVBPVnQyMWFEUUZu?=
 =?utf-8?B?cWZrNHMyS1QyMnlYY1dkaGJQSEtsZUphbWVlaGpBWGpGdTdkcnRhMGkveml3?=
 =?utf-8?B?S1g0RnA2amUxMThFeXpHVnAxdCsvNWcwSTVybTY2OHp1WW0xN05IandvbS9i?=
 =?utf-8?B?Uk83NXZaVUVUVGlHRHR4MXFjM2w2d2dBRGQwL25GdHA2czU1RjIwSlJiSTND?=
 =?utf-8?B?YTRDVGRnNTRMaFlJdHl6WEl4ZFlWdnZ0NGNCWVA2akFoMGk5b1dHOFJvaGJP?=
 =?utf-8?Q?cbg3thKqfdPewR3gx4EqPHrjj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555cac43-974d-4259-f819-08dc2e748910
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:22:03.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3A49HEvdbLbikeECthX8Hgn8x5OVBQB28gM5MfzwZWMenGpRNKDVsWPDE0Pu3DtNbR+M5+g5Ee58PE5xbEZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916



On 2/15/24 3:51 PM, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 01:40:47PM -0600, Ben Cheatham wrote:
>> Allocate an MSI/-X for CXL-enabled PCIe root ports that support
>> timeout & isolation interrupts. This vector will be used by the
>> CXL timeout & isolation service driver to disable the root port
>> in the CXL port hierarchy and any associated memory if the port
>> enters isolation.
> 
> Wrap to fill 75 columns.

Consider it done :).

