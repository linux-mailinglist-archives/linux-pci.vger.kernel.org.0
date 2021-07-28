Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94D3D9961
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 01:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhG1XVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 19:21:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:49461 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhG1XVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 19:21:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="199985445"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="199985445"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="499061461"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2021 16:21:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 28 Jul 2021 16:21:40 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 28 Jul 2021 16:21:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 28 Jul 2021 16:21:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 28 Jul 2021 16:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeEvsFPUpY7tVhsABnySM6QzEd1XEAvuVe0Ahl4adlOHNz1EpMRNAOYooZKi2ONS2HurPt+7BnX3javhcZl4pM2UVUXA4U56qjEcxFvYgKbjuC0DUo/5l97xIFv9vblx3tPTX2EWnvqazUUylgwmolqIWsLOxQP1jXRlps+d/j+XWeqB2hWpmIQzCyCQwj1kOSPePHoHPamDkx0yYiaUcAdphBgG0a2l8Qo8ZBs0mrqhAT7qg6p9XIUIIH6DZ9OI4tIpcO0DsuyPmrt9mCS3RC1E7A97LH4kUW2Wbm6ng/D3e66b95FhjvpGbwZZvb9q4LrEDbYVCcnyyCpRrgHjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHU+uKwzxJ5EPCGtSBZrSi45+NbFQpnf92zAaJWhqqc=;
 b=Eo0o5q2bJjK7Riyju3FWmGEJysp+j1tHI/C1hTfFBY+GXB6ybin1wW7BJlxO2sPx93z9Q7djFRrRQxaSmXXtjI168GVsWrbKrTRa4naub9jU1kijt4AraL5bLBIVfryyJJdmuX/H4RkmfWZ8hpRO/p2UtwnuirZvR7iVsHIvKhjN7cafNWTQ/oD5y4i7jSjW0TFlw41cTmR07tjktpvRIWKBXRvGSGS1mIN7yyOCvSftO5WQcS5Hq+K5tuyiZmYVJ0dPxG62M0t+nUKIJqNjStQlVPCUv83ESOG0sB5nTbyNACClTjLlNgK8rTcAs8vZUUMZ2cvr1s4crUYMDRC3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHU+uKwzxJ5EPCGtSBZrSi45+NbFQpnf92zAaJWhqqc=;
 b=sMPoXdKkRQS9cVK8i2bTjw0GPLQce+qOFbKx5OHxvAMCBSw5HhiPlk4mk/NrKM3P75ney0ne7BHVNuOGk6pqmyMjw45USUGeik2oPgLKsYtxS9LzsxyGCb0f45ca4RBfUWBslUf51ZSFl07seEZPcLZufhfSbl+p5NiYvLsleYM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2746.namprd11.prod.outlook.com (2603:10b6:5:c9::10) by
 DM6PR11MB4171.namprd11.prod.outlook.com (2603:10b6:5:191::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 28 Jul 2021 23:21:38 +0000
Received: from DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::c996:e6e3:47bd:92a9]) by DM6PR11MB2746.namprd11.prod.outlook.com
 ([fe80::c996:e6e3:47bd:92a9%7]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 23:21:38 +0000
Subject: Re: [PATCH v3] PCI: vmd: Issue secondary bus reset and vmd domain
 window reset
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210728214639.7204-1-nirmal.patel@linux.intel.com>
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
Message-ID: <6833bc78-b935-95bf-6cea-03e9f0ca5004@intel.com>
Date:   Wed, 28 Jul 2021 17:21:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210728214639.7204-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To DM6PR11MB2746.namprd11.prod.outlook.com
 (2603:10b6:5:c9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.123.78] (192.55.52.194) by BYAPR07CA0011.namprd07.prod.outlook.com (2603:10b6:a02:bc::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 23:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cbe3ab7-f28e-4dd6-2c45-08d9521e7322
X-MS-TrafficTypeDiagnostic: DM6PR11MB4171:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4171976825BEB0B9914E89C698EA9@DM6PR11MB4171.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5WuGY9IEKFdWJcFRtLmEnwRUJ3bXpJI8VkLAXL8GF0X71Tig/eeBUHaQNQeJ2s6WC1mAmHVIAZj9uw/Scx5whr3asx7hdvSsMcMd3azV2aGukCsNd9Q34ZSyAUyL0608SR/Zv+jHJIEEwJVQOnziX+ImsgkePfdEWuVxcQUdXhkgIUSxdsxYhAJw2WM3/2Jl2pcQwDfSw9zKcT54GrnEzAgLuOQ+a4n7kX8VNJrA7GS/HVmQ/P+lep4TnUkr9OgL8JTbgeHq5ZSbCvJLdo8wrZPIYvRpDJ/2XfLvxg4hlRA21b50V143+Xh4XYU7ht2GzHKXUWCwW+djD2dTdTdJQN+bEzHQVfS/dQ2tpBwdDExrMkz6/mgSI/OGg6hxvDYKGWwWC1HAV5qzDSuR0bEEmYNT/8d4njw2vsRZLIHnwZ/gYpNIPYVq9zQBJktWeT9jq9zjRp/aEq9E0w+rIf1xu0dW5arK8W2Lk/SGsxLf3fsKcnpacdLKjTA/Lh/hJGstP9C+mWWoFIeVt2ilCXi+oYWx4tEbNYiWDx5AqpgMNqkaFkDZwqMZsjIfyuouM0DDE6E2GUNHWNyS7E/KLLUB5qVXfJBM24xluPkTKHdDjvlC2G4tAI7T8pQiXIH3YJxLIYdywGopk58EX55OvijqTAK6EA8HTHGXfnhueUpQVsrf+sFUgQ+TtDutINfTRSYlMrzp/xmmsfSG9CvUA1EM5rPiptu6FYJ0C4ZQnKBOsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2746.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(66946007)(26005)(53546011)(956004)(186003)(6486002)(2616005)(8676002)(110136005)(316002)(5660300002)(8936002)(38100700002)(478600001)(16576012)(86362001)(31696002)(2906002)(36756003)(66556008)(31686004)(83380400001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0J1ZUcvdTFORnBGZmZyVFVSd3c5MHl3SkVqMHpEWkdGVGYwL1Q1bkVOK0lX?=
 =?utf-8?B?aWxqRXVKeWV3Y2EvY2toWEJzbjJXYTl6UmR5ZmlvR0t2SlJYcXhuRDJZUVo4?=
 =?utf-8?B?WUJ0MXBFZHdIcjRHbFBpdWI2YjdOU0M0QnE5c0NNU0xvcEtzdkhrWlZRdmRQ?=
 =?utf-8?B?U3RGSDIxZ0JXVlh6c1k5NEJFRS8xY0Q4R0UxUit2K1dWWTlyQngxNWcrSUgv?=
 =?utf-8?B?U1piajJBdUErUWFTRU9VOXRCazBWZC84dVU4Ti9SUU9xUEpoZlRDRXZGb0xT?=
 =?utf-8?B?SmNLYUZvNlZ1NExrRHFwSFJiZHJmRWp6TVZ5b1o1ODVvdHo5Y0dnREUzY2RS?=
 =?utf-8?B?ejI0WEszWFJ5bnBEL0JZWkY0ZWVhbFAyekdtKzRRaFpFbGVPZmpZamErMEov?=
 =?utf-8?B?eUdFQ1BSeERpTHpnTUxBVGpoSDBhWTBtc1NVTWVGRXB3cC9NeUpZM2FDK0tm?=
 =?utf-8?B?Yld4UXhFVnlCcUlKYjh2dFc2TFd3UmVjbk5vZHA4RDZZYTZFdXhLVzlOaDA4?=
 =?utf-8?B?Umw5OGNhdVR5V1NxSExiY1hROUkvZWRVYXFLVkhMZlU1ZGRHRDRJaUtaeS81?=
 =?utf-8?B?SGF6b0hUZjBDaDl6MnhHcUo3Tmp2ZzlkbnZNN2ZWRW1uTC9LdkxpeEJvbFRX?=
 =?utf-8?B?SUNTd20zeUwwNFF0Z1Z3WGhXM2pGNERsbXlMeXRMWVhCNXdkbEFhL0RSTU9t?=
 =?utf-8?B?TCszUEFyUEZyeGhwVG5yblFWckxDN1lJcDBXelNEWTRIcVhLRVFzY0doa3pX?=
 =?utf-8?B?c3ZlREZUa0VKckxFSkRGYzBzSnNaTnA0QXJheHFxVHI5RllUejhQNzBQcXhE?=
 =?utf-8?B?Z2NwMjcvbmZzV3lweS9JaVFJZWJ3OFVIR3VocEQ2TnBNRlkzdmUyd090YXhD?=
 =?utf-8?B?Ym4yTWh4SzcwMGYvVFZJSDZUMkVwTkpRVFlxbG1tR3ZpSS9MMENEbmZxd3kz?=
 =?utf-8?B?MWp2bkpFWGFoYmVTYTZrWkxjQU9La1lWKzNUQzViQ0pKWnkzR2JWMjlvV2VF?=
 =?utf-8?B?MWJvVW1RSlRzYklKTjZuMWNrOFFzN0Z1ZnV1YWFESlBycFFaUDhMaGwwMmQ3?=
 =?utf-8?B?R2pyWTF4UlJkZStvRWE3L1NHKytPR3lFcVlxRk1MdG80R0YwU3prTFBCT25C?=
 =?utf-8?B?YkdWc2dSRGV1WjZ6U3FDVU8rL1gxWUF1WDVZcUp3VEpDQ3hVVlNQajI2ZWpn?=
 =?utf-8?B?NGlDWk1EdVpmczFCMUlRamtoSjJ6WnZITXkxQkJ5WlFqSjVlNUgzM0pNd0hp?=
 =?utf-8?B?MWs0bTBieXJVSWRLUW5HUnA4SVZKZFJqS3JiSU1TNzcxcXJxQm53VG9mWjV3?=
 =?utf-8?B?NFR4MERwalNOY3V4VDFObFZqRDE4QXd2OGs2MG4rVHVCK3h1dTZWNmo5NVhX?=
 =?utf-8?B?NEVsTjJOSlFlK1kxYmhtZVljMWhjZWVMRzR4ZlNKbGZQdnBQQS9FUnBTK2d6?=
 =?utf-8?B?RXpGUm5jL213Qm9vZHFTdXB2eDJ2akV2T2VsYnplUVhXRkJDOTE5dkRxQWhW?=
 =?utf-8?B?bWs2blJLOEhpRWRBVmROMVlvUjZmOGtWbnd2cGliRUVZVUJSWFVqNy82OCsy?=
 =?utf-8?B?ZmhBNHROb21KWDZSbWx5WlMvdmVVSEJoVWlqUnNvbmVvZk5kdTN3UGJVZGtl?=
 =?utf-8?B?NW12MkV1S203ZXRuRTlaU3FhSmN4cmVNa015bG01a2t2eTJ2THhCZDRrVjIv?=
 =?utf-8?B?VHlUQzZQWEE2TFBmQjRRa0xkL1FkTkxYOXdjZkM4WitBTm5UcWlkU2dUeWMx?=
 =?utf-8?Q?YxnDx2Gec2TpPThM7oUC5IN8pl7uP+g9//szAvl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbe3ab7-f28e-4dd6-2c45-08d9521e7322
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2746.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 23:21:38.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDJtqDOJ6FxZclaeGhyiiehzY8qTvEASsKiehh1h8oJX/jP7jVGmJ4I+SYDOf3uOAXn5HvuOIGsCR7UFOvhWZz8UarF8h7cg/3Po9OyG12I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4171
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Nirmal

On 7/28/2021 3:46 PM, Nirmal Patel wrote:
> In order to properly re-initialize the VMD domain during repetitive driver
> attachment or reboot tests, ensure that the VMD root ports are
> re-initialized to a blank state that can be re-enumerated appropriately
> by the PCI core. This is performed by re-initializing all of the bridge
> windows to ensure that PCI core enumeration does not detect potentially
> invalid bridge windows and misinterpret them as firmware-assigned windows,
> when they simply may be invalid bridge window information from a previous
> boot.
> 
> During VT-d passthrough repetitive reboot tests, it was determined that
> the VMD domain needed to be reset in order to allow downstream devices
> to reinitialize properly. This is done using setting secondary bus
> reset bit of each of the VMD root port and will propagate reset through
> downstream bridges.
Can we better combine these two paragraphs?


> 
> v2->v3: Combining two functions into one, Remove redundant definations
>         and Formatting fixes
Below the dashes please

> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Not yet :)

> ---
>  drivers/pci/controller/vmd.c | 63 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e3fcdfec58b3..e2c0de700e61 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -15,6 +15,9 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/delay.h>
> +#include <linux/pci_regs.h>
> +#include <linux/pci_ids.h>
Do you need to include pci_regs.h and pci_ids.h?


>  
>  #include <asm/irqdomain.h>
>  #include <asm/device.h>
> @@ -447,6 +450,64 @@ static struct pci_ops vmd_ops = {
>  	.write		= vmd_pci_write,
>  };
>  
> +static void vmd_domain_reset(struct vmd_dev *vmd)
> +{
> +	char __iomem *base;
> +	char __iomem *addr;
> +	u16 ctl;
> +	int dev_seq;
> +	int max_devs = 32;
> +	int max_buses = resource_size(&vmd->resources[0]);
> +	int bus_seq;
> +	u8 functions;
> +	u8 fn_seq;
> +	u8 hdr_type;
> +
> +	for(bus_seq = 0; bus_seq < max_buses; bus_seq++) {
> +		for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
No need for max_devs - just open-code '32'


> +			base = vmd->cfgbar
> +					+ PCIE_ECAM_OFFSET(bus_seq,
> +					   PCI_DEVFN(dev_seq, 0), PCI_VENDOR_ID);
How about:
			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus_seq,
				 PCI_DEVFN(dev_seq, 0), PCI_VENDOR_ID);


> +
> +			if (readw(base) != PCI_VENDOR_ID_INTEL)
> +				continue;
Now that it's iterating all of the bridges in all of the buses, should
it be limited to Intel devices?


> +
> +			hdr_type = readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK;
> +			if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +				continue;
> +
> +			functions = !!(hdr_type & 0x80) ? 8 : 1;
> +			for (fn_seq = 0; fn_seq < functions; fn_seq++)
> +			{
> +				addr = vmd->cfgbar
> +						+ PCIE_ECAM_OFFSET(0x0,
> +						   PCI_DEVFN(dev_seq, fn_seq), PCI_VENDOR_ID);
Can you do the same as above here? Putting PCIE_ECAM_OFFSET on the same
line as vmd->cfgbar? Also could you change bus from 0x0 to 0?


> +				if (readw(addr) != PCI_VENDOR_ID_INTEL)
> +					continue;
Is this necessary?


> +
> +				memset_io((vmd->cfgbar +
> +				 PCIE_ECAM_OFFSET(0x0,PCI_DEVFN(dev_seq, fn_seq),PCI_IO_BASE)),
Needs a space after the commas, and please use 0 instead of 0x0.


> +				 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> +			}
> +
> +			if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
> +				continue;
> +
> +			/* pci_reset_secondary_bus() */
> +			ctl = readw(base + PCI_BRIDGE_CONTROL);
> +			ctl |= PCI_BRIDGE_CTL_BUS_RESET;
> +			writew(ctl, base + PCI_BRIDGE_CONTROL);
> +			readw(base + PCI_BRIDGE_CONTROL);
> +			msleep(2);
> +
> +			ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +			writew(ctl, base + PCI_BRIDGE_CONTROL);
> +			readw(base + PCI_BRIDGE_CONTROL);
> +		}
> +	}
> +	ssleep(1);
> +}
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> @@ -747,6 +808,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  
> +	vmd_domain_reset(vmd);
> +
I'd remove this blank line

>  	pci_scan_child_bus(vmd->bus);
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
> 
