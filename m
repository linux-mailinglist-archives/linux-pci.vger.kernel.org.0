Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D294524EB7
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354653AbiELNtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354649AbiELNte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 09:49:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829C4166D79;
        Thu, 12 May 2022 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652363368; x=1683899368;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qjMBz/WuYs6LU9b4QEA5S0bx7EgKrQZ/t/ZrZvdZ1tg=;
  b=mmUuY6WZOvKbvN2O63IklNzYi+/Yuri0dIQQT+CS3frDwFOEPZYhvutK
   mGmbbac1Vl5QAoJ9Rqhij3x6JBL9bY/tpB4tl1jQOckT71Brl30qm0CbJ
   BFqn3ylSEDLXkxOSBodSYaT4Ayx0YeCiNbkfm2OlF2xuW3UnXaZitwBEj
   Az+q3Eo+rgFHcmv5ddOOhv6CY7g6IaFWz5dufvh+BNfUo++oKOFHHfjGv
   EAUpYFcoUvkWsbEwfpGVh4z5mjzYsSR/8j0retp42cBljqdKiWmfvo00N
   1K1V0jt3snj2/9AUuB8TfIf4Y1ZK/XA9DjdOAZDgRGfyNounrG5v89vqN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356430224"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="356430224"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 06:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="670852749"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2022 06:49:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 12 May 2022 06:49:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 12 May 2022 06:49:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 12 May 2022 06:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnZnHxOc0Ed8Wc9oNYra5M4s2CVMQmkZalu13xAtpym52WbEMZa08cYWjmNgZGXuYatdZsZaDZdSX/2SDfhI1YgopVTd1Jbp8zG/vj0nTaRQbRG23kjW+KHpxbPJJlxD9p6AnVTZ0YPoTQQX5Z7GGeN3Camd8FiVVAlRi1lDMCF+lp0OP4FuQq+Vq9KSQheOgReJHYv7Z4kH75yzYxHt43MM4USlLe9at/WopGzm//K9/3V1vwBSiEJ7MekmbUhbFfiQne96peiFbhMv01vN8Xoz00EDs/WB1BFn5SqGcUgDRzLU1FUycMFSIIpTI8DoJq+8vBJ8Ifc4zLCqPAG1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4A5py4UUA77v7txZSD88UV8SNbgES87scrY8rbJW78=;
 b=M128kk+Z/03sekJLSufdi9dqtYKZNcoSJoGoCnrgRSN5Ez7x7RnbC+s9UMWiQZlv+5GmdH+Mj9uzmTZhrpD0x6e5Fzu1pB5zhgnDYwmk7YsNuAh7eEbfmxI4xiIHHYdyN76KaY/MF/Oz9YtA+DVWit22pKz8c396M8wgMZzqg+rGmQPHEsd2A+qPxJfztbB9L7aZXw6jYivoa/EPuzF82+NDG9rpgWDAQ3r8zYsLtJ09OHWjkeBi/E2Z6S/DfkYNu38O+H22Uk6R9ctmYoEbUTcGD17b2O3TxdRwrxT83P8DU1yuV4xWQBk00of0tGhyXuYik0zmmtCskeRMt5hCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BN6PR11MB1267.namprd11.prod.outlook.com (2603:10b6:404:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 13:49:25 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::f1bc:d359:9f17:14db]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::f1bc:d359:9f17:14db%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 13:49:25 +0000
Message-ID: <70d0c0d4-093f-ae8a-9654-5a433285ab12@intel.com>
Date:   Thu, 12 May 2022 15:49:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Content-Language: en-US
To:     Rajvi Jingar <rajvi.jingar@intel.com>, <bhelgaas@google.com>
CC:     <david.e.box@linux.intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220429210538.2270472-1-rajvi.jingar@intel.com>
 <20220429210538.2270472-2-rajvi.jingar@intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220429210538.2270472-2-rajvi.jingar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::16) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65146614-b0d1-4f5d-5233-08da341e39c3
X-MS-TrafficTypeDiagnostic: BN6PR11MB1267:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB1267FF056110ECC82F1F6543CBCB9@BN6PR11MB1267.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lufJ+otzfh018er5klNu0eUqxgw808cRoka1Iv56RbyY6nVDHAp5LnzWHiaaWqeECC04wgbbethj6hfWCx2KiCrgq3hhlgslcjkoi+XfYB5Inlk4lwKoTNs9GUBue2OVjUlQ7mX5fZZ0Qy0J9J1en3jlVyfMCwPR23OjNWECsrF2X15An21TSjqF8Sr2+0jOoYxFhPkry/oG6DIDFnIIcKc31fnyx+JC31iqHY05R+TtxaKjkv/wX7mfEF2ETFSyv7TtOHRp/uB8t9AvrkRJAXvqGJlMzj19uxs+SmFd4ETf8HnhxZf7Crv5ioKoO/n3hdXEVDD7ICe3YAEDcH90py1x4xemYSzLYY93yHViBWkWjL/jGk7wsI/4IoIKbXETRCqDJVXrAN/rTZTEFAaTJT4WfDJfsKAs5plX8H0uvjt1ksuWEIbMqxixJHPwl5x5ZMrzU9ilS6ZG3TVbC9UO3MFXJubgPBYBmrNLxCgp0hIPoCggNeqYGJA7dSvw4cy3g6DgO9DVpHeHyUkluXFPkQXYInxixTyleN3/ESfCdfwuLuZUfVlonrLxisFbt2WpJb9Wwc6q0xzl05QsbUm6+zhxyJpGg8HvXoTW/zFnln9eAelcxBtFixbv3jcECBsgMaenSyoWJO+UDskvMNSXRh71LMCSR5jQR9WGZm/Dn+QQ9bOiU8BdF5pawRRlxjYhWrdVGmx0mSPIH6rqSepOER0zJGU5TUt6UJtgIauWfFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(4326008)(8676002)(82960400001)(26005)(86362001)(6512007)(53546011)(36916002)(5660300002)(6506007)(6666004)(2906002)(6486002)(83380400001)(31696002)(8936002)(508600001)(38100700002)(316002)(31686004)(36756003)(186003)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFNeVRFY2RQclUxYWl2bXJhVWZGZVBUTmFFOVFhQzh3ZTBJT1MxVmpudSt5?=
 =?utf-8?B?Vk5DWVNOTTFkK2JSWHU3OGJOMVVESWhqaGhzdk1IVDBCdmNRZWs2QjArZ3Va?=
 =?utf-8?B?Zi81RUFOT0s5NmIwSVh6WENIdjRhYXhGdVB1ODFtT0h6UkVjeXU4NVM0M1ht?=
 =?utf-8?B?YzJlZzJsTUdNdVdhVlNSWUw5eHlTZXI0NTkwZmlZVUNtOWNiclN2NzVrZ1JY?=
 =?utf-8?B?NVNUU3dNaUxrVTNWSjgrdkdpR091cWIrR0ZqYnc3QWlIUnphSzFvNWVaZVor?=
 =?utf-8?B?VlM3QnJBODEvQU9GakZhM3FqdTBxU1N3WFNoKzdYU0QvMjg4WEgrZkZndDdx?=
 =?utf-8?B?Qjd1ZURrWGw4cnJxMy81cG13SzBEeXYvcW4xdFYzcDNPZmVINGtzSFFnUnhn?=
 =?utf-8?B?cURqQU9kUlBDejFSYXJVZTNyVGM3cnZZcjVkNjltMGZjMnBRaVRXSHZJdmVu?=
 =?utf-8?B?U1BpRytrWVhhU1BJUTlsc2RnT1d3MDBPQVVmRVV6ZTN3RmNzcWZONkR6OVN4?=
 =?utf-8?B?VTVoVlk5VTdaWVFaOGcrVnNxMDNKMlFYZ056eVZVMUc5R0JqNGFWcnlnZGdM?=
 =?utf-8?B?Ti9NRmVRTWNoem5rYkVDTGxkdEc3OUhnZnNRdHpjdjBmLzByRXRGUU1hZmkw?=
 =?utf-8?B?VnlTY0hEMXJUaVlLK2hjNHZEb01najh1czg0NWJiVkRWVkd1aVpHc0hUQUJO?=
 =?utf-8?B?a2tKN1NzK2h2YzlQSjRNbk13N2xtZERHQVR2SkZkUWZpTUI5LzJ3OTVQWG5H?=
 =?utf-8?B?Y3MrZUdNbXFPUjRaOUlBcmx6dTl0L1Y0YWNVY01pajNFaTRqeGF2NWRwdkU1?=
 =?utf-8?B?bW51bUtBbVlYcWgxM2ZuRkk2cWg5S1JmOTV5ZVh1MWxtQ0NaM3hId1FEaitj?=
 =?utf-8?B?andpdzB3bGQrZXluaFFxUFc3ZHlZT3h6eXZrL3hpbmwveSttWnd2ZGdqN3JP?=
 =?utf-8?B?dlFySkowUndWU3lsbFhmUlJSTHdTMWFveW9HRUMxMmI0Ujl4NzNuZjRVUC9u?=
 =?utf-8?B?Vm50RUE4VXFQT3BFSFQ5MGFIRithWktYNlNua3RYaG1KdFJnZkJpdFhIR2x6?=
 =?utf-8?B?MmxpM21QVm9nUEpIOUFvWlVSSDlIM2xiZjNFSjBzQWZFaU1Kd3BIcUtKaWdX?=
 =?utf-8?B?L1cyK1pZdzhuc1J4UUhWTTFFSWNYNksyZE9rVlg3blZ5VHcvVStXS2lsSW0w?=
 =?utf-8?B?ZTBUQlNyRjFIUk5mSXNXeG1odE1lRmY0a3U1Wi94Nm5lK3R0T2NIbE02YzNH?=
 =?utf-8?B?LzVPVXlVUUszZm02SlJIT1RWY0xTeENxaVlVa291RzFPQzZKMVd0Z29xNHo3?=
 =?utf-8?B?SnJnL2NUUmErWW9idEIzNHRhYmt1QVVrNEdsTTc3NVYwdHY0QjhyblhPRG5p?=
 =?utf-8?B?SnppT3l1VGo5TFBqdGpQNCsvNEl0T3QxMm5BcEZoeTU2cVRKNGVhUHVSNkFh?=
 =?utf-8?B?d29TQWI5NUR1NEV6NHpXZlJrd2Z6d3V1Zjc5QlVpWTZFZGJaYlZOMVFaTGV2?=
 =?utf-8?B?KzJ2eDQ0T0xoNkhaUlpJQnAwM2JDd014MXJqSFdKWXh0QlhnV1BrR3BZcVFa?=
 =?utf-8?B?eFZXcjlaMEhmSytTV25wTnQ5Tzl5Wis4ZUFBR0pwNnN0KzBKMzh4enNuSXZF?=
 =?utf-8?B?UklkRkE3RUtrY0YzcjRDL3kxT3NhK256UUFETGY0TXFvWEd4Q3diVUdkQVhD?=
 =?utf-8?B?L1NzOS9sc0ZPbkxVdkUyakJXL3prNzVBTnhQVWJCcklXbVZTYjRJNDZlaFNo?=
 =?utf-8?B?V0ZtVDFSK1Mvc1gySGhndFZSZDBXM3JrdzBBc2JMVzlXQWY2LzdYOGNNaHNx?=
 =?utf-8?B?OXdaYjFRWjdoMnhtVEwyWnc4eFFORkpQM0FLL2UyZ0w5QTNsZXU5S0ZUdlpV?=
 =?utf-8?B?OS9ab1JRb2NMd09WODE2SHVsMVpNWThkdUNIYk5JN29JZHorR3BBamJsT0xp?=
 =?utf-8?B?K2wrbDJ6T2RTa2Jldk0zc3lLQzFJcnF5dUl6UkEwZVlqdFROY05kSEh1N1Zl?=
 =?utf-8?B?ZkRrRHRBNGtjNFIzMEZQVDRTSTYvZm82U1dha2xXL1JaWUE2TDBmOVYrVjla?=
 =?utf-8?B?MDBYVWNzNzIrSHIxWVI2ZEdzaVAxUm94REtaWUg1R3A1emdEWC9OU2dObzBC?=
 =?utf-8?B?KzlHRHFQRjNNZVlSU0k0eHNTK2NBbWlQVmtrelJiKzdoWGZhR0g2REc3c0dI?=
 =?utf-8?B?ek51R2ZuRkMyRGxkVFlocGx6RHp3T3l6UitwVVI1elpySTY2ZU82NHdGSEN0?=
 =?utf-8?B?eklqczcyRHNXOXpkRXN0RzUvREJMcnRzY0gvTnJaZklTUG8vZENMNS94ZWNM?=
 =?utf-8?B?V2gxa0piMkYzdDliS054QzN6dHhVdFdZSmkzNytTS1JabzhHYTN1ck9YRVFO?=
 =?utf-8?Q?RKfJe3GVkTOxz7Bs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65146614-b0d1-4f5d-5233-08da341e39c3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:49:25.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rget8k/rdKhopoRiFHyM5TVWSqyfTsBcHFCjEGYr4wYUAymyJi7qiRmVP9oO3enRbAg0R847QbGykDxxF/2WXAx3oW0XNn4xyOQ3vf+jfds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/29/2022 11:05 PM, Rajvi Jingar wrote:
> For the PCIe devices (like nvme) that do not go into D3 state still need to
> disable PTM to allow the port to enter a lower-power PM state and the SoC
> to reach a lower-power idle state as a whole. Move the pci_disable_ptm()
> out of pci_prepare_to_sleep() as this code path is not followed for devices
> that do not go into D3. This fixes the issue seen on Dell XPS 9300 with
> Ice Lake CPU and Dell Precision 5530 with Coffee Lake CPU platforms to get
> improved residency in low power idle states.
>
> Also, on receiving a PTM Request from a downstream device, if PTM is
> disabled on the root port, as per PCIe r6.0, sec 6.21.3, such a request
> would cause an Unsupported Request error. So it must first disable PTM in
> any downstream devices.
>
> Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   v1 -> v2: add Fixes tag in commit message
>   v2 -> v3: move changelog after "---" marker
>   v3 -> v4: add "---" marker after changelog
>   v4 -> v5: move pci_disable_ptm() out of the pci_dev->state_saved check.
> 	   disable PTM for all devices, not just root ports.
> ---
>   drivers/pci/pci-driver.c | 28 +++++++++++++++++++---------
>   drivers/pci/pci.c        | 10 ----------
>   2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 8b55a90126a2..400dd18a9cf5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -813,6 +813,7 @@ static int pci_pm_suspend_late(struct device *dev)
>   
>   static int pci_pm_suspend_noirq(struct device *dev)
>   {
> +	unsigned int dev_state_saved;
>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>   	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>   
> @@ -845,16 +846,25 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   		}
>   	}
>   
> -	if (!pci_dev->state_saved) {
> +	dev_state_saved = pci_dev->state_saved;

If pci_dev->state_saved is set here, the device may be in D3cold already 
and disabling PTM for it will not work.  Of course, it is not necessary 
to disable PTM for it then, but this case need to be taken care of.

> +	if (!dev_state_saved)
>   		pci_save_state(pci_dev);
> -		/*
> -		 * If the device is a bridge with a child in D0 below it, it needs to
> -		 * stay in D0, so check skip_bus_pm to avoid putting it into a
> -		 * low-power state in that case.
> -		 */
> -		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
> -			pci_prepare_to_sleep(pci_dev);
> -	}
> +
> +	/*
> +	 * There are systems (for example, Intel mobile chips since Coffee
> +	 * Lake) where the power drawn while suspended can be significantly
> +	 * reduced by disabling PTM as this allows the SoC to reach a
> +	 * lower-power idle state as a whole.
> +	 */

Something like this should suffice IMV:

if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)

         pci_disable_ptm(pci_dev);


> +	pci_disable_ptm(pci_dev);
> +
> +	/* If the device is a bridge with a child in D0 below it, it needs to
> +	 * stay in D0, so check skip_bus_pm to avoid putting it into a
> +	 * low-power state in that case.
> +	 */
> +	if (!dev_state_saved && !pci_dev->skip_bus_pm &&
> +	    pci_power_manageable(pci_dev))
> +		pci_prepare_to_sleep(pci_dev);
>   
>   	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
>   		pci_power_name(pci_dev->current_state));
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..f8768672c064 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2660,16 +2660,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>   	if (target_state == PCI_POWER_ERROR)
>   		return -EIO;
>   
> -	/*
> -	 * There are systems (for example, Intel mobile chips since Coffee
> -	 * Lake) where the power drawn while suspended can be significantly
> -	 * reduced by disabling PTM on PCIe root ports as this allows the
> -	 * port to enter a lower-power PM state and the SoC to reach a
> -	 * lower-power idle state as a whole.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		pci_disable_ptm(dev);
> -
>   	pci_enable_wake(dev, target_state, wakeup);
>   
>   	error = pci_set_power_state(dev, target_state);

And the restoration of the PTM state on errors in pci_prepare_to_sleep() 
is not needed any more.


