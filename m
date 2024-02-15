Return-Path: <linux-pci+bounces-3557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B785707B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE331F267A0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A713B284;
	Thu, 15 Feb 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D/u39coG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB113DBA4;
	Thu, 15 Feb 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035721; cv=fail; b=gteuKNaDrYM3sTUNMoSTwQdBjuUKTTk2eJVygn7WKyLWxfS+IOcqS+VDzcL8fGgfUtww7TCdtq+B38w051KzHUQFofZtCsaSrpQl9ioqolQXzaGYHH+ihZ2Z6qJ5JspByaqY9wqd5hzmM8YkHOQ4F1DDaafwrQ7zgRIuJWDU7V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035721; c=relaxed/simple;
	bh=Pbz1v0V/C5uJUVn4Ao9N46ULtaHLYY83loO0NrsZOoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jt5/aBO9nukGTw3LfQD3OfZVkuGjqP6GoG00ClpqVPpGZM1v9msLHEHr8IKcRDToIik9NlWygR9kljvcvNFMq4xaVoKl5Vfk2G1kTu0kiidj9pBliT/9SzV6iNP7f9TZ79r0Nskdq2Re9rcjICLCFlnnqzBwTircvfGaFaw0c8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D/u39coG; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve4Dqmul2M76O23w3jFHPTJISWh9NHTK4z7ZHjhnkiBC7SLOfoFbu2SMlr9dVUmrd3XQci33kPQUCh+y/Hp3+iwmauX5elFCOuuSNFCIZF8ZofkgGNY33UbQbz8oIyfMnuQVqbQboSP/4KyQoUP/t5yagZ9CYmS5kMh/3XpHmQp0DCJ+e5Uegj2ZD43SuZmvMCAcsdTHTXDOCdXbhjSUl4kg3sthJtHd5L3s30oRpoWE1l7sv3fuEMAztM4qLv6P6cOGjBStUMRDhjZgZkOkLJwSy0z1xUq9agRI7QYDhZ7Tn5EFjWtXwqoMZw/azsOBBTBD8y3fpHZs+fmr7v1fYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXUjL7OqYza8o9eVsYx9q187WFXrGYCebvfUUpEomME=;
 b=O9HirIPbkzPuLgqwER2Bd5Ch+MPmz4XAYp+I8J9thSP2JkH9q1lZUzKhG72JFShdx3ULdEO/NfX/CQZd1v6x2ZeliO1QIT/LEQIq88XUpbbt66Q98AoLJRziNr6CBOunFst4IzkQqwRdpDwdWZGWM3gDiIOA90ZZaRpeBsW/wUbleZQ7YuS0rLnBohPvjHqdiWl2UOeolMMOlwUvAWy/1fzfAbUUYY7RZek57p7frAbn+gH6ksjJG+WaiyaK/6EncnLyVynjRYvAQVgm2s2auLXqIcTCRdYvqYZyDtUpiNNytzW56AgCkUsVU5c+PgdPCIVg73Ii8iOFUZfEsrSjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXUjL7OqYza8o9eVsYx9q187WFXrGYCebvfUUpEomME=;
 b=D/u39coG9IwGP7ydt7HCZ1DbXWrpbQttfG4NqrKJs1waAZBR2wbFosh7IeKZkBs7a68/zhsztkNrUrrhfDq0OdThV2KM/LvtRBTCbFFyuCtXNxu7euxCsp9+DK9/uIFnVQTeO6cm7B7qUqsgUQf2aX16crnIBGBrtKiov1zoBLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 22:21:56 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 22:21:56 +0000
Message-ID: <385c9342-6232-4b1a-8600-eacb63c82919@amd.com>
Date: Thu, 15 Feb 2024 16:21:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] pcie/cxl_timeout: Add CXL.mem error isolation
 support
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com
References: <20240215214921.GA1310551@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215214921.GA1310551@bhelgaas>
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
X-MS-Office365-Filtering-Correlation-Id: cac93bb3-c082-461a-2241-08dc2e748519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+22B1myzk7jVbU0cUsK5V7VdnRJuJGlZ+O2bw8Qva5mLOeGKSvDPSxYdOIqEjxp1CBT6gzl0KYFe7hOjpg9YvgA3tp8CkDw8dk33odVgXPTpMNmNQ0pen8qltL5goWcDtwh3lmqot3drm/xEZ1yvL2QN60Nrjo/CYuaAgqyatMZxkGShLVapjUGnf8Ca9vY+8LTwAsI1Am3TN5jytQR2rJTHhoTpQEKYySWpkVeOQdKRXS5P8qjaKGinAsTdZmSbRmMdEtP5ZQJqwfjhMVDlbdRqH9qdTwgyihrYCT8JxjDqZGA64KqLVZ7sUor97M7WWWOIiihNQdxMuEcVLkqGyOd7gAf8D/NpWbN4nFocPsH6e/ALT3dpPhokOsOUlzcMzFUA1Hv6brfyu2HRnRyKkjUMEJM2tj+6w+H9PlZUcX02EQkXOGuWruLAtvP51NTRc3IADXEPzG3/sANFCy4x7iMper2LizpGTR3n+pgMq+eMt6rwvxCpulnmWS9cwSN96Wemw2mCFnv9S7mfZ9VrjBSutaIuz++JORXzpNbfxVhFeRg94jU3E5l6Ycvqs+Fn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(478600001)(2616005)(41300700001)(53546011)(31686004)(2906002)(66476007)(8936002)(4326008)(8676002)(7416002)(5660300002)(6916009)(66556008)(66946007)(6486002)(6506007)(316002)(83380400001)(36756003)(26005)(38100700002)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjVjTU5EOTFvWEhJa3MycWN0TDZSOEwxMmw0MmwwMHlKazdIQXdkOERPV1pU?=
 =?utf-8?B?WkFpeFd4VWkycUpGZEE2WmcrMVVDclFZUXpJMFlSYmhHUUtmbTRJeVVHS2RZ?=
 =?utf-8?B?U2Rsd1dzUFNlNjhhYWh0a1pJS2ZYR1Y1SWhpYWtmbGNFdHVmNkU0MnRCaHh4?=
 =?utf-8?B?UHplZXZldUowaGtxOHVXQXNiZ3hxMlhMcFQ5cGlpVkJqNkt6YmttN2xodmhy?=
 =?utf-8?B?SVpsVVprOWpVNzhjUlZJQXU2a05Gd0N6OHNDYzQzdFRrcmcrd1hEeTVRaFlp?=
 =?utf-8?B?UEhJREpUaGVnL01QVFdwYWN4cXJ4eHlMbWJvaTRYSHErakl3MWhObzZ2S3JY?=
 =?utf-8?B?YWwweTl0ODFzZ2cybTBxcFB5MmkzcW9tOW9mb2tGV3pScURjUlM3QmFWR1Nk?=
 =?utf-8?B?VCtlQWozOWdNc2xzVmp3ZmNrRkMxL0xpaTdwRklhL0ZmUkE3ZDBQUjRJQzhR?=
 =?utf-8?B?M0VxZUpaNWJDQ0FaSk1ZS1RpQlYrcCsyNWNySjduRjd0VnlOa0IrMVhqSDFz?=
 =?utf-8?B?cUM2akpIaHEraXZNcWxXLzJvbTlPc2ZBOHkrNTVPTkR1UGUydFNqYUJqQU1k?=
 =?utf-8?B?aUtxSFhzQzh3aFVQYUlJWUx1U1kwSHJWREFBK3R2WFFRbTVvRnlJSCs1OHhD?=
 =?utf-8?B?c2J4L21tYVBUV3JrWnBDVFNVOE5lMXNTQXl0cUNHcExic3RSaC9mdmh4MkQw?=
 =?utf-8?B?YVMrWXdHYnpZa2RySTBxRzFJNEN6bi9oOVFwNDAxMDFUbmlOeG9zTVV6V291?=
 =?utf-8?B?Z05Gekc4aEdaT2VQeEJqUDNlYTVMWGcxa3FydldkL1J2YmRpQ2lZUm11LzJv?=
 =?utf-8?B?bU1lKzMzUmI0VzVCbWl2a2VkQ05GK1VTVDBEZFlpeE5jM2pOcTFkOWFjbE84?=
 =?utf-8?B?ZzlCWHF1K0NvOVhDbisxSjVtdTZQWXY0S1Q2VDN5TzBRNGpPSHA4S2FkdEQ1?=
 =?utf-8?B?dmlhTEpzaGJ1czUyUU4rRTBOcEJubldPcndoeXdzaGVqOTdmekxTNFRyNU9p?=
 =?utf-8?B?RlVqNkdSVWlKTVRpTHRBYWZDdVp2UVl6UHp4ak5IUzhRcGZiem5VaVFZQ24z?=
 =?utf-8?B?WjlGMGF5K0dUdzNlQUpiRk8rdUpOQUhlakFVTDVqYTByT2dlNEF4Vldsd2Uw?=
 =?utf-8?B?RUlqS0I4aHgzQm50ZTRFd2hJRGRtb1QzVUsxY0hYTUU5QjUyNWlWL1g3WTI3?=
 =?utf-8?B?dElrWTZYcURBUk9LeVpOT2libGF3ZUR5dkRkd1IrdGw4U0h2MkhHdUV4RXZ6?=
 =?utf-8?B?Q1FOMXIwRXlJZ0hBNVk0U241cUFLK0RFaDR1REREYzFUd0puRXMvUkw5NEly?=
 =?utf-8?B?WGdHL2hObDRlTStFUllRcU51b3JaV01mZ05qMkxXL3piL2NLUDc5enBEb3h5?=
 =?utf-8?B?SWo0TWQ5aGlxamZSZTBRREZvZE5iQjQwRFk2WHBpbUVUVTkxaGNXVjhUYlRW?=
 =?utf-8?B?Q2hLMERhVUxtZGE1S2F5aldYVGlrbnhIcGVUNmV5WXBlQkpaSmdqQmVmcmpo?=
 =?utf-8?B?MHhtbnhaQWp5c25OSVRaajhDSHNZRkhNUkYrcEZEZ0RKNityazQvVFZLakhh?=
 =?utf-8?B?Z0xFbkU3aTJ1OW5ocHk1aG5WUWtLS3RLTjRuYXlic2RkT0NmOGpzb1lBYWQ2?=
 =?utf-8?B?Z1orRlZJM1FBWElpYXo4b2RqQUl1SFhxWXB2bzJqTjFkRjhiZnlha0lrTjMv?=
 =?utf-8?B?alM0U29OS2pJWjJjMGF6cUVCZ0duN3ZzL29wbGYxWUVScWtYYkhLOEtSL2RL?=
 =?utf-8?B?TE9JZWdNbmxjOUdLS1VtNzZtTzNSMSt4VVpsUkFaQUIrRkhWWUdrdVpvWTB1?=
 =?utf-8?B?RmNvOU1yVkJ5ZFdkUVp0aU1lZkpDWVB1M093czk2UnBjbGl3TGJ5RnpYVEw1?=
 =?utf-8?B?aXdac1NtenZZTDdqUWtDdThIa2dvOThkeHJQdzNUL1ROUnZZTXNMREw2T0Jw?=
 =?utf-8?B?dTcyMTd2WUZhTm0xTGNLNXNITXp1Z0ZCbmd2NnNGcmUzNXR3Ry95QUk5UFZN?=
 =?utf-8?B?Q1Z4OUQrOHBCNFBaZkRkdG8yZHVPVDAzQ0Y3RVI0WDNocHJQeXdvcFRGVjYw?=
 =?utf-8?B?c2szSXgzOU10bUsxcTliTlc0YWlJV0NtL3RveW1SbHNXbVNGUWJZN093NnFs?=
 =?utf-8?Q?YblQAXejRUB5ViK1eBwdTp8Gh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac93bb3-c082-461a-2241-08dc2e748519
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:21:56.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1G87/ri+dmlQAMEF7Y1ymzk8yNnu1+f1HrR1zzSWLWtQXVo1lyHOwrkRdg02wd3yG/lRMt2Z/J7ye5bBAPeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916



On 2/15/24 3:49 PM, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 01:40:46PM -0600, Ben Cheatham wrote:
>> Add and enable CXL.mem error isolation support (CXL 3.0 12.3.2)
>> to the CXL Timeout & Isolation service driver.
> 
>> @@ -341,7 +366,8 @@ static int cxl_timeout_probe(struct pcie_device *dev)
>>  	struct pci_dev *port = dev->port;
>>  	struct pcie_cxlt_data *pdata;
>>  	struct cxl_timeout *cxlt;
>> -	int rc = 0;
>> +	bool timeout_enabled;
>> +	int rc;
>>  
>>  	/* Limit to CXL root ports */
>>  	if (!pci_find_dvsec_capability(port, PCI_DVSEC_VENDOR_ID_CXL,
>> @@ -360,6 +386,18 @@ static int cxl_timeout_probe(struct pcie_device *dev)
>>  		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
>>  			rc);
>>  
>> +	timeout_enabled = !rc;
> 
> This ends up being a little weird: mixing int and bool, negating rc
> here and then negating timeout_enabled later, several messages.
> 
> Maybe could just keep rc1 and rc2, drop the pci_dbg messages and
> enhance the "enabled" message to be something like:
> "enabled %s%s with IRQ", rc1 ? "" : "timeout", rc2 ? "" : "isolation"
> ("&" left for your imagination).
> 
> Or something like
> #define FLAG(x) ((x) ? '-' : '+')
> "CXL.mem timeout%c isolation%c enabled with IRQ %d", FLAG(rc1), FLAG(rc2)
> 

I thought it was janky as well. I tried something really quick using ternaries
and it looked weirder :/. But I agree with you here, I'll take another stab at it.

>> +	rc = cxl_enable_isolation(dev, cxlt);
> 
>> +	if (rc)
>> +		pci_dbg(dev->port, "Failed to enable CXL.mem isolation: %d\n",
>> +			rc);
> 
> "(%pe)"
> 
>> +	if (rc && !timeout_enabled) {
>> +		pci_info(dev->port,
>> +			 "Failed to enable CXL.mem timeout and isolation.\n");
> 
> Most messages don't include a period at end.  It just adds the chance
> for line wrapping unnecessarily.
> 

I'll remove them.

