Return-Path: <linux-pci+bounces-40662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B3C44B8C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 02:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 099A7345E32
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A92433A6;
	Mon, 10 Nov 2025 01:25:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023129.outbound.protection.outlook.com [40.107.44.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3341448E3;
	Mon, 10 Nov 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762737924; cv=fail; b=b7L+fNbkMjFYHvc2Ya/pSxTLNNMQ9a8JkwmkPHJ/zqTi6hvfHu/OyJDxanX25vYG975wiHr8HpAulaUoAQTEbQg8XnKNDve9Xomyz6kW1DDox7JEZcrM0P9VhgzZly9RVwzzcooiyAkSvatrE5ls8Ihq8KEY45GbSdukDLfR7/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762737924; c=relaxed/simple;
	bh=158+CvfCjyJbDrUkksgqu8oTRlHVfZoK5R//+/DH6YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aM58m3fIDeKWBE3Z2zcuUpoG3rly7dytVc7N5qQnba5PFGsQhSGSXJ9+wEi5hZ6DFeX0U8ErzCYU0phw7jOZDfx5tqOiif2OOiW+UgeR9gAKV7fMU5rW1/yvpo6dw/AbSZlWRPX8H8+w7tb0ZCT/303COMuYeuW8Wh/8NhrzrqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKtIZXFO8dxq+093f7nzYOqWzGdMuttPwwKdVINpV3Z3xyxsdUo01qk7RbEOWzLhW+6Jhm6IcejeLmPisy/A9BRxqkpO91VG5/hz9lL9T+FvIeDJx9oj8MdwXgQVdeurFzNiLSHqv0zBG9yhWIwxEjPGH5hcIChJ9k1fm1hzpeZAIcOpyayW6ZbgaIUcFA0cneTQTwjyG5d+wd+KD7UHtoR86NqZQL16FL6HsLVC0gt/xTf2I/HATLsT6HYm5oACCE4NKxTmkRwStT6d2QsH8Uosoq8lqZI4suIDUvyfYX2WaT5yAJFlWCJhLW4Vkv35vdRkXSrzl9XDp6U0jeEcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWjPOyH7amipU1r6BzVCjG82zpKGj3ajdiX9K6C3qX8=;
 b=pQmiFcJZ5RDRulZDYaMLyT1Ii5rWliuxKwxrb+8qVTKZT49WxSCT6ihafwaGrj69bwMP8xb5PuBqRpVnQQyHV3frP7EpdHi3sVbVOEHPj4u95K/Zm0xvvcqeSfgxqO9ZtbqVKG8kizKxaD1u2iBvdo3uJbmEYByosCH769vmlR8tK+Jz37RpoHjDxUCtU8L2euIiokW00QK8uMnqpcVsHDeQVQlPwXSAbx7OI65edcpqDQkrDNBacEmLkNty0zAZBJzRAH2evWZivDUYwFtPjEEAuxVVot1aV4MpdU1nNu/XugwGYyPFl7Tyc62/m9gHH+UV3a+LDNRsStqU7ihDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PSBPR02CA0009.apcprd02.prod.outlook.com (2603:1096:301::19) by
 PUZPR06MB6066.apcprd06.prod.outlook.com (2603:1096:301:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 01:25:14 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::6) by PSBPR02CA0009.outlook.office365.com
 (2603:1096:301::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 01:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 01:25:13 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 236E740A5BD4;
	Mon, 10 Nov 2025 09:25:12 +0800 (CST)
Message-ID: <8f24da57-9700-4429-8947-36b27211476a@cixtech.com>
Date: Mon, 10 Nov 2025 09:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to
 a separate file
To: Manivannan Sadhasivam <mani@kernel.org>, kernel test robot <lkp@intel.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251108140305.1120117-4-hans.zhang@cixtech.com>
 <202511092106.mkNV0iyb-lkp@intel.com>
 <xiaf3qvskwrqr7riradv6jnt5jmwcgenfr6mss5wtlddmxuwoa@ke2kdaq6adqz>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <xiaf3qvskwrqr7riradv6jnt5jmwcgenfr6mss5wtlddmxuwoa@ke2kdaq6adqz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|PUZPR06MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: f6677bd3-035e-4cf9-658d-08de1ff7ff4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG0rMWRKc3VNNUxCZERLWVkyaFhFQmZwZ2ZVelZuKzAxaGt2M0h2cmYzY3Zq?=
 =?utf-8?B?SVB2dUhYeU1RT0N2bDE4b0lWVjhpNW1HK3BvWUtyVThyMExjNkJpVytndHJm?=
 =?utf-8?B?dXk1Vk9FUFBlSVYyOUtmbEJYZW5tSjBXRVVwWEl4VVZ4am1pKzhqT0hFU3RX?=
 =?utf-8?B?Y0hnQm56UjhTd3U3TTJsVytSMzd3eTFiZ0pVYU9pZy81VGVqUDBoa2hRZUpY?=
 =?utf-8?B?bmtmWitHS3BCaFB1RTFrcysxVHM2elFaVkJJWTE2S1NVMWR5dmZCZk94TElu?=
 =?utf-8?B?TGU1M2NocityeWlaRG9IT1hNd0dGT1Z0MTVPbW9IdGNVMVRTWi96YnhER09Z?=
 =?utf-8?B?UTFVYzlyM1g5NzRaQXJReXRvcHpaYVIrQzlMVTJrYlRramxoZXBOM29Ybmk0?=
 =?utf-8?B?YWhkLytRYWhSekFWRXEvS1RNMXRLWHV4cU9HSW16eFpOcHNmaWtFTTZYbnpH?=
 =?utf-8?B?dlpoQlZPaVIvNmMxQ2lEZ3djamVyMEpmaWkvTGdkVVNGZUw4MjUvNXRMMkRB?=
 =?utf-8?B?dmFoR3VDcVIwMFh6MXl4cWt4WXVyUmFJREVWcDF1TWZPK2hFYUYraTJ1NmpK?=
 =?utf-8?B?bHdnSk0wQnA0V3pXa3VMRmF5cE04RU9seUZqdmhuUURtczdjZzd1d1B1V1Ra?=
 =?utf-8?B?dHdOeHVlbHlQZWRBNDFnY0FuY3R1S1dpNUVGaFdWOEVlS1JCeExmUnRNRVF3?=
 =?utf-8?B?Y015K3NISEVzTnVvSEV3QmFXZVdOcHNiZ1NYUko3YW50K3puYU1tK2FrSFB1?=
 =?utf-8?B?ajArTGJSWGV6dHZ1S2xQOWhseS93M1JoN3Q3cjNKUEVrY0FJdmttYjExOGhn?=
 =?utf-8?B?YlhNNGo3ejhDOU03eHlJOFRGTWsvK1IvOWRFd29neUZITWJDOWxlck9odHEy?=
 =?utf-8?B?elpmNWhOTjlYNkQ0bXZBYXlnN0NabjkzcVV3cEpRc09BZmtoNnlOQmdqOHE5?=
 =?utf-8?B?TTEwWk40TWhUKzhLd2xVMDdCSWY5WEU3KzN5a28zYXNBNEpCOTJNSUpkQmhp?=
 =?utf-8?B?c3dZWEVaRlk3dTBUUERzdGI3aXhHRU0vU0ZlNm1kemV1VE1TeTJUNkdBRXZj?=
 =?utf-8?B?bTlmbGlBSDBFNWlXYXA0UnBqYk5Cd0FnK1MxZytPNUlVNlFkdHNVTFJnNTE1?=
 =?utf-8?B?UklRSnlmRmtlM0JYNTBLVWMzSURZM3hacEFjSEg4U251M3prOWZZSlF0bGtv?=
 =?utf-8?B?aU41YjBmdjZ5YlYySHpNbU1PTkRsc0ZtbDBnblVyS084N2JyTjVwR21wQmdS?=
 =?utf-8?B?TW5pYXdqRzk0RENXZDkvTGUxc1lhbWF1ZENYWEVpZDlSNGZYVndkTFBiQWRY?=
 =?utf-8?B?Z0RSMzFaT3ZGeE4vd1BlaWxIY1l2YU5vUFIycWlqNjBDQ0JuVy80UWVHWHVl?=
 =?utf-8?B?MzZhTmcxY205Mm04REFMbUljbTF1eWVwN2RDcFArcC9JQ3ZOWC9yRk00bFdE?=
 =?utf-8?B?YVhNQ1p1eWx5OXYxYk1oOG80Q2JyVDhjeDhBK2t5SS9SK1BLYnNva1UySXN6?=
 =?utf-8?B?Uis2TCtqSUF0MmxCcEMwUVNsdjFSQnVMVEFHTC9HRFB2TWVqTjR0d1VINmNY?=
 =?utf-8?B?TUhsWWEzNHNiVERrOWliNGtCNEh4cEg2UVF6WkJWRzNMUWt4ZEpLUnZyVVFV?=
 =?utf-8?B?SmFsWXVockFZRW1nN0t1RG4ram5NdWxyQ1U2WTY5U1E1UjNSLzMxN3cwSlR1?=
 =?utf-8?B?Qk13WllNUGhKdHozZm80R3N2RHJrR0JHMVlTQUdvRU5paUV1cDhKVUs1MG5p?=
 =?utf-8?B?UXVxOTFmVXZuYlF6aHRneWROVHJmdVUrajRXTFZTclh3bVFEWUc0ajNwUmFv?=
 =?utf-8?B?b3VpV1AybVVvNHkzRFFCOFZkcjNhV3FTSFZra3AycE9FM1hNR1lVTlhVTy8z?=
 =?utf-8?B?c1hFV2lnL3NOZlJoUXlMQVcrbzdTZ1YxckhsaHRXeFgrODlkTktkWEdiZVAx?=
 =?utf-8?B?OXN3Ym14QWM2TEY3MHV1QkFmVEFlRzFhQlUrVytPcW9VVkVWb0Y4WWdLNnIz?=
 =?utf-8?B?QnRNelJpa29jck15NzM1Y3dPUmxNcWdhdXBVMVZvVlBEbm5WbjZwMXZDRnpw?=
 =?utf-8?B?cmxhNDBKM2Z3bGpiSGZTeDI1Q3FkcC9wdUZYS2JBeS92akR4N1FUWmRUSmlz?=
 =?utf-8?Q?PL43XcXVOeVfTlqqvbWLJICoS?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 01:25:13.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6677bd3-035e-4cf9-658d-08de1ff7ff4a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6066



On 11/10/2025 1:01 AM, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Sun, Nov 09, 2025 at 09:59:50PM +0800, kernel test robot wrote:
>> Hi,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on 6146a0f1dfae5d37442a9ddcba012add260bceb0]
>>
>> url:https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/ 
>> PCI-cadence-Add-module-support-for-platform-controller- 
>> driver/20251108-220607
>> base:   6146a0f1dfae5d37442a9ddcba012add260bceb0
>> patch link:https://lore.kernel.org/r/20251108140305.1120117-4- 
>> hans.zhang%40cixtech.com
>> patch subject: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to a separate file
>> config: i386-randconfig-014-20251109 (https://download.01.org/0day-ci/ 
>> archive/20251109/202511092106.mkNV0iyb-lkp@intel.com/config)
>> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/ 
>> archive/20251109/202511092106.mkNV0iyb-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot<lkp@intel.com>
>> | Closes:https://lore.kernel.org/oe-kbuild-all/202511092106.mkNV0iyb-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/pci/controller/cadence/pcie-cadence-host-common.c: In function 'cdns_pcie_host_bar_config':
>>>> drivers/pci/controller/cadence/pcie-cadence-host-common.c:188:23: warning: variable 'pci_addr' set but not used [-Wunused-but-set-variable]
>>       188 |         u64 cpu_addr, pci_addr, size, winsize;
>>           |                       ^~~~~~~~
>>
>>
> No need to repost the series, just to fix this warning. If there are no more
> comments, then I will fix it up while applying.
> 

Hi Mani,

Thank you very much.


Best regards,
Hans


> - Mani


