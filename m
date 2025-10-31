Return-Path: <linux-pci+bounces-39910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C1C24269
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A036F3BD26E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBC330B0A;
	Fri, 31 Oct 2025 09:20:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022099.outbound.protection.outlook.com [40.107.75.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523B32571D;
	Fri, 31 Oct 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902416; cv=fail; b=jy440OQYJS/SEhXTwi9n2NyC/1yvom3RgYz9gCz6w+OfM27RQwWmBUSqcAr3ZVVkinZF3zqW0WZtUVGlNTLzSpBVwckYYOCKYOtP5szDrnLuj82t+T4ARMAa9aSSo962TR5qLLNaNlRmfw4822nkXv56WKKlAVcJ9g7ffkrEsIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902416; c=relaxed/simple;
	bh=xW6h0hVB0BmOd9wydt8RmlsdpQPuJZbIK/CVus0Whlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=je+GrgNQSiRGjQjiB0ZmrE5p3Gg/sRqV/5PHX1kFOvK8Jz1JLSdXhfd7L3EUAHLuXekNlazF3P0OdpJmtA+7Xa3leyMTwG733idoRqyuxOSPYZ0R1rjdPhOvPgUC6DfVfri3igtftj1t2ZXzM/F61sCW8ZndPtLSuoeoTGVHyBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfUs1CfFP7+97/lHaehF1Pj9Zt1hK0OUgIbdoetr1eylYt4krVVnBb4/SuopU7rPWbOz2+LMfrRPVkkTLfd6HxNiIiDW5sRk39iEeuiuEPWpMn+gQQUk760ivA0cbVbRwA4c6zD/x6kX3c/vAjhLRZ+f0LSbGaxO5jQa3XM34dEa6v9VafObZAyP9bVpqAXEVNphTbvQipsEL00Y4Fsh7bsm6IcX7BIi9ZfU8/8Fs6dAST75uAVsOthefHyUsq+Hh7/XmtF+XjkZ54L4y6A6Azv1tk+u5QLwR1cuP2A/t5iNbjJOLl9kHGYNkFHCcByFeQg80WfpsQMhwpBmjMTmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL1WaevMRRv6VlULj2zhnfT0+lj9e7IOSkkkKfMIhqk=;
 b=NJqe1QW107qgG6by2lbhgNnAptJvUTHvluWSYpwn6RA7cTRkE259F1OPlNIz51ErCTvOk6tXSulmEqoCPwlZ5tsD4nHizShig00KV/4F81d6h4LCK9Wgvgw1oyJm0WNSFOvg0WfiVamfEsk0vKX1QJU5W4aZYPGVMyu2DwfsmK/+N6W4DFLmJWiEtOI6Ol54Nlm/hbp9AXoJOn2sdTGJZYUEMj6dsJXW3qIThcMIjfadwDGokh3CPyCiMNWlmi1nceHxXzXn8vAEN2xZS/PAH1kewBQlbtCqaj20+IvFZR24nfiauWxX46Qe08mcM/O7eSVy6YYFCgKAoUTRYIG/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22) by
 PS1PPF77E02AF72.apcprd06.prod.outlook.com (2603:1096:308::256) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.16; Fri, 31 Oct 2025 09:20:10 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::d3) by SG2PR04CA0160.outlook.office365.com
 (2603:1096:4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 09:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 09:20:09 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5849841C0145;
	Fri, 31 Oct 2025 17:20:08 +0800 (CST)
Message-ID: <b6f8d7cf-bbd0-42eb-8d73-5715a614ae98@cixtech.com>
Date: Fri, 31 Oct 2025 17:20:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-5-hans.zhang@cixtech.com>
 <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|PS1PPF77E02AF72:EE_
X-MS-Office365-Filtering-Correlation-Id: ffeaecda-4990-4fc5-d413-08de185eb001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NStLNzBEWitib1lhdUorQlh5UWFjWFRFNWNCeUZ4bURaSWEveGNYQ2NMQnc5?=
 =?utf-8?B?aFVmMUFSZXh2SndVR3N1ZU5pTnFKekdONzBjbTJnRENpdWdzT0xob2FZSERY?=
 =?utf-8?B?R1p6SnVJckdwY0NROGNKNThEajIzWmRsWGJWSk9pdWNlbjBSejFyUEJZQTBr?=
 =?utf-8?B?MTUwMWo1SEJ2cnVCYXRqbVA0NjJIbWdDS3FpQ2w5VEtiQmRiZ29lQ1huYThv?=
 =?utf-8?B?REVHbStpczlpR2ZsQ3BzbG5tVTc3dzdSNmhUeXJkUUM0cFpkc2tvL1E5YUN1?=
 =?utf-8?B?RmNUS2dNdyt1REFQaG1NMTZYUUp2Ujlpc0EwSzdkOHUzL3dRMjMrcWRTenIz?=
 =?utf-8?B?MDEyRHJFTmExNG5oT3oyekdPTlhLS20rOW5NdktrL09KVE53VTJsdG1tVTVu?=
 =?utf-8?B?RTRQaFB2WjRlQUJyV09qclBpY3hXekp5SEFXVkxvVDNadGNCd2RrUnR4Q3RI?=
 =?utf-8?B?SVg1ZHBOWkJQcERPQnFSVGViRVNoQlFuZDJ5WFhJb1Iyb1pnelVWT2ZkVzBB?=
 =?utf-8?B?WjZYOW4zK3BNMjRuangxdWpqVE4zWE5yM0k1NUQrSTBGbkFIbHZiUFlVdEdQ?=
 =?utf-8?B?ZEZTQnpsSGFSb1piQ1RVRnBGVU42Z0NRbC9jcEhjNzRWbEZ3WGNUUmozaDRp?=
 =?utf-8?B?S2RENFFHaTNKZWN5WW1haTVmay8xUmkrQzdrcWdFTytXYnJjaVlLQlo2cWNv?=
 =?utf-8?B?L0lsNzdmckwvdTYwd3E4aGZzM0VQNmJQcjFwWnNnQ285MXZmeFJZUUloYVVD?=
 =?utf-8?B?aXU3WXVKYVZYSWk3SUM5Ukp4dHlFSXBmRGFieFFZZ2pwNkd3NjA3TUxHRFov?=
 =?utf-8?B?NFNQa2laQVhPWk9JdnBYOUl2UkJjeEM4cnB2OHpOd2krUmtyTGp2OGx2NEdx?=
 =?utf-8?B?cUMwd25XNHA1cStYUG9PQnc2eGEySjNVVjVkRXc4MGhObGZDN2NZY3EwWCsx?=
 =?utf-8?B?VnMyV2xpVXpKTlpoUzFhYkgvUGNObmtYdkZCMFIxUy9uQldnbXZjVktlRzJz?=
 =?utf-8?B?cVJkbW9VRld3UlRXemkrQm9kSUZLeEI0RWc0WUhaK3FBcDBVS1Y4TWxKZWcx?=
 =?utf-8?B?eEdBdjZHcmdINVJZbkQ3SjlWY0ZIdHpnbHI0Z1FFR08wN1F4MEVyZmJsYUJV?=
 =?utf-8?B?MTErT29TS2h6NTlEaHIwaTMxL1B1cERDYithckxaNDRqQytPTVBqbjExMFJP?=
 =?utf-8?B?M3VlMjlpMlhiU0ZZVDZtaWhHN3RXS2hhaEFrbUtpUytkelMzaXlQTUl6ZTlL?=
 =?utf-8?B?YkdjMnBqeGErYnJnbXBHQWlabkgxL0ZlK3dVMHlYRE9YeEpBZXBkZUlLVjMr?=
 =?utf-8?B?MkdOTXdYSHZBaU9qSjBDbUc0M3B0YkE5ZmhGZmFmL0p6WGpyVTZjVFVZRnlK?=
 =?utf-8?B?cDRQM3RuRytHTXk4Nmo0cFdqZ1NxNVdzbldRUHVnYnExTS9GQy9jbjUxWW8y?=
 =?utf-8?B?OHFaMzdOMlkzVFpzNDhkekFmSEkwTTVuVExVNGU1cy9KRmlEVGJYNTBNQzM3?=
 =?utf-8?B?YmNPemprNVdtZUdKZXlNQVZzSy9PQ2lDWnFGdG1teTlaRkZVbXNpK0hFS0lT?=
 =?utf-8?B?c3VHY0JMVjBDTjU1bk9qNmZmTUd2VHUwbXd4U3VwcnZTT0JCbzczeGlvWVcz?=
 =?utf-8?B?Ujl6eU9odEFWZS9hRHRXb2VkdllXOG5hUS96clc2RWR2dlpmYmp2Rm52blFz?=
 =?utf-8?B?MDVQNUpoU09jeTk2ckNQTGJSM3kyODZmb3RjQ1NsTW15QWM1TEtHUVpPQ2M2?=
 =?utf-8?B?cmFweWg1Zk5WOEFud0FSTy84U21FeXROOFhFT2lrTUUzYU1CUWZ3ZWlZWjNx?=
 =?utf-8?B?QVZiVEpnUXBmZVE2QTE2ZWNORTdRRVpZbmNkRDkycTgrUHoyRU9NbTNIRi9P?=
 =?utf-8?B?SG1vTEs1cFl3VUcxMUt2T2xyS2ZVdmpGZEhOREhEaG05YTJPcjQ2bnUzeTNX?=
 =?utf-8?B?QmRycG1aWThTVkg1anJqdTBuL3hVT2JMWW1nNUdrbnpwblBDeit3RHBOTTBu?=
 =?utf-8?B?UU9oRVNlSkwvaFdFb3U2ZnVlTTJZRzFYYUI3R2xtcFJpbE56bEdmQU5XMElM?=
 =?utf-8?B?T1VPUkJnbmVhQmVGNEt0aVBRTTdQNnNGWE1PYU9BTlN2Y0k3Z0ZBRVkrUXBi?=
 =?utf-8?Q?GCHw=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:20:09.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffeaecda-4990-4fc5-d413-08de185eb001
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF77E02AF72



On 10/31/2025 5:11 PM, Manivannan Sadhasivam wrote:
>> +
>> +static int cdns_pcie_hpa_host_wait_for_link(struct cdns_pcie *pcie)
>> +{
>> +     struct device *dev = pcie->dev;
>> +     struct cdns_pcie_rc *rc;
>> +     int retries, ret;
>> +
>> +     rc = container_of(pcie, struct cdns_pcie_rc, pcie);
>> +
>> +     /* Check if the link is up or not */
>> +     for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>> +             if (cdns_pcie_hpa_link_up(pcie)) {
>> +                     dev_info(dev, "Link up\n");
>> +                     return 0;
>> +             }
>> +             usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>> +     }
>> +     if (rc->quirk_retrain_flag)
>> +             ret = cdns_pcie_retrain(pcie);
>> +     return ret;
> If 'quirk_retrain_flag' was not set, you are 'ret' will be uninitialized.


Hi Mani,

Thank you very much for your reply.

When the robot gave a warning, I replied as follows:

https://lore.kernel.org/linux-pci/293858b1-db91-4525-b8b3-c98c7837ec73@cixtech.com/

Will change.


Please ask Manikandan to explain any other questions to Mani.


Best regards,
Hans


