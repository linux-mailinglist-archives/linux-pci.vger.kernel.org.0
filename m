Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71D667603E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 23:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjATWjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 17:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATWjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 17:39:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5479EA9;
        Fri, 20 Jan 2023 14:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674254338; x=1705790338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8tTIxTq12Tr6PrVCVg+lMpCapFAaeIchqs8eIF5MJ8A=;
  b=GHLBNzn3RNVFj+ptnWqPW4dv3jDo5PLl+g6LAQ9/IjbprPmWJ7eJOeo+
   Jq6p1UBTIRCSYlv9MOMvR3QBpnxH5a66UINU0oCCefomcKdgDTz2HCxbR
   APqkj/FiAGRocPohKHC7Le2alk1OQ5t5YqfbPgu8NKhEjmOo24+bh6ctQ
   rAoSxLMouhy4mZ5je9JGfE3RripKdj5t/5gqzRibt5stVVbUqiUNjGU94
   pArGp9G03nwjFDO/Ux4n18U3CQXAFkudJ0YY1qZtIH2GlEaYgHWO4RcGz
   xJ5bH26Sf6+RoFFEDvCNoe8q1Z+HiX/Td4HCodj1kN93ZIUfhExwHjJal
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390225965"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="390225965"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 14:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="729260998"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="729260998"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2023 14:38:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 14:38:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 14:38:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 14:38:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 14:38:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcHc0IUVKwbJQ6QFvFt7ooRLbXmjZ1v9dmoHQdTEqEsz1UoaZfYBkbAgitg7GSRmwCbHwhe7MiBb+S+oii3qRZVHM3z85CM7BVS2lEpMBd/xk5LoJpKa4YIU6ZgRPulUcnJ1ZeGzK4GgxOc4uXrJ174vhPn+QLeCdEMmtw62M0SefbrK/kQ5vqMvINZsgeRXpoRiavTDDlE4bk3dXRb0rjy90y7nbFPF0bYm6y/Anux7IQfcnUMP7CKmOoD7KUvHucBtpJ7IhmRxSLbUarrpnEfndtVLV4cBRpDbms4S6wjctp0cip2IRjtWLxCL//PxdF2kJ6iDs0cWc7hSiC7OeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT9n4haprKgtdVcJdLyknskeRgj6X7Yj9ZQIIjkkYsU=;
 b=TOdaRdHbBVFkM1sl9flP1BOIVgURG+223AELQgBG/iAmHaZ8iI/KmATurmH8SZr1m4Uv/8HpcSnZylWG8X8Qp1xbwlmS3g07futh0ugYJq3X60ykXOaXE7Zwa948aP3NAxN488MbLYQmBNCvIutqmcUCbIkKLc3zxs+OXZ/XD2dbpM1Ct+isoeYkYjoDjUgPiey3Yw3S5Pv6HEZtNRczjTeu7ExQ5/PFqM+g6hFJ41ACEGtxCPnuQCcKZ9GKGs+EcayOmiCndCU5o1fHoS4EKq2uDwxglhxvC+Nh4c0RokkSsJazq7TAoR0aUcGlui8bS7doqsiNtS/b8yq/pzil6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 22:38:48 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 22:38:48 +0000
Message-ID: <ea85cb02-a13d-f232-8ebd-c13893fc00c4@intel.com>
Date:   Fri, 20 Jan 2023 14:38:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 10/12] PCI: hotplug: implement the hotplug_slot_ops
 callback for fpgahp
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tianfei Zhang <tianfei.zhang@intel.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <lukas@wunner.de>,
        <kabel@kernel.org>, <mani@kernel.org>, <pali@kernel.org>,
        <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <jgg@ziepe.ca>, <ira.weiny@intel.com>,
        <andriy.shevchenko@linux.intel.com>, <dan.j.williams@intel.com>,
        <keescook@chromium.org>, <rafael@kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <lee@kernel.org>, <matthew.gerlach@linux.intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119013602.607466-11-tianfei.zhang@intel.com>
 <Y8lFgKZGKYrM02Wm@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Y8lFgKZGKYrM02Wm@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:303:8f::26) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e9223-b1b9-43cc-5700-08dafb371874
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhEzTbuFM9KTTj09mOQ8eXea7qJRe4AZ/a8Mf1Goxzx8U/L2JV2/5pCZfhn4w4OvdpLPugBJBnlesVpdcAsEFaVnsdwLnu/zbXQ466q79PPFBsECuaGQlzpE4JqOwUXEwv89RivR1xiv+AGLi8tV5Wk+XoaamxIkcJZjflzQkyqvc6nbtqB0qcFmKOWd2gzuVJ1pRH78m6pT1NZXrTfevdIg2ioaWNpHzfkLLXzKHpnlm+HBmUFl+8p1U32msRVe9dnzYNDQdjq44PMC+5tYrCGAkR9tDYPVJQyxTHo80oatwR8eYHMqdQiIpVJeGtxEFalqOkIsAdYbr4k4YSx1EIN+uEbkvHzAefcXmZf24mK0UeOl0zkN85gYT6zHSY+tZIlpGcCVZckEPY+2Z+S+2DU00dV1sJYH7U6+DfBRKQd2LH37khSzaRI+OhlZxmUgVWUlDpXfHm9od61/Af4ZY6ND85wsGrbHqKvgmfpKhkhzT4h9n3g/tkWkuVUfqHRly1CdpFtOBlL1Qqm3JC3XUsM509e2JJ+4Rzs0b8F+8XJ+vLUihu9D/K2z5Z6eLkvr1BLFm+ajqoGNHUV4iKuft/I7SJeCoXlWyVmC1CCEHI3g4gJU7zmXMHLq/iB2ieXStV+xYxViDvUUy8gYmjZWmjcbhuTmUnbnELzA+JngpyUGh5InfBhm4ef4Cpw3qOvfqPN3Sv5ep6lnxRYaH/VxEpv3DMO3VIjxkWtXgqxac2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(6512007)(186003)(66556008)(26005)(66476007)(8676002)(66946007)(4326008)(36756003)(478600001)(6666004)(6486002)(6636002)(316002)(110136005)(53546011)(41300700001)(31696002)(2616005)(5660300002)(6506007)(31686004)(83380400001)(8936002)(7416002)(38100700002)(82960400001)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3dKaVF6Y0cybVVialpMbHRCTTJ0R2x1R1RuWElNLyttSWhUcnhqLzhBZW5j?=
 =?utf-8?B?VGhCUklPM3VLQVVKL1h0eFZ2RDJzUUdER2ZQa1VGSzF6UjFYMko0dkF3aW5z?=
 =?utf-8?B?eVdaZjlnNzBUbTVLcTUvNGhXTFp3TG5mU0pRVEpVWEFwK0s0TnhzMGNFaHZu?=
 =?utf-8?B?d2pZL0YwMWx5WHg3ZzB6RGtvQWJHc0RIaEZqQUJyS2d0NlAzM2VFRXg4YmN5?=
 =?utf-8?B?aW9zazBLTGNob0dXcEJUa2RFSDNveTdKa1gxNDgyRndDWTB5UkVxaXJQeUNs?=
 =?utf-8?B?eEVrVllRdkZheTdiLzI3Yk5acDVKYWE3dnFHOWhXR0RRVkpPMlpYN1k1Y0Jm?=
 =?utf-8?B?L1dkK0ZWMnlBSlNjUGZqSDU5Y3BsL2FQb0VpMGljNjY4STZSaFBxSC9yM0V3?=
 =?utf-8?B?L0doZkZaRWlkRUZNL3lBVmdWNDJBZTh3VEIrb3FINjR4bXBqNVBhNnJvOC9C?=
 =?utf-8?B?eElKTjdvYURtRm1YcWJLS3J2VjlXVFNCV0FUNzVZbFhtM0s1TE1RVURNazdB?=
 =?utf-8?B?a09udHFsZzA4MGN0N2xMYnhqM3Y2eDZMd2E2d0VxQWJpNHFDbGFYZkJsYlRB?=
 =?utf-8?B?VWtDemc2ZVRuSGRzRXd2QmFNQ3RIbFFWOTA2ekh4VDM4MFB1NE9qUFJsUzRv?=
 =?utf-8?B?ck5CeFg0bzgreUNQV0VWSVROTGNkQkVBTU9iUmJudC9ENXNpbnhQMWZhVG5E?=
 =?utf-8?B?TWNPTDNZeFAxeXVPSE5vMFdmOHIxZXNURkE1WmdIOTZQRXBKUnlZUlpKZFZS?=
 =?utf-8?B?aU5qd2JobGl5U200UWRiUVM4MHlKV0kveTM5UTg4YlhuVk9rK0ttTEMrNUNr?=
 =?utf-8?B?OEw2Tmp2eXB1U1hLbG9VYldHdjVtZXNQNE14YmN2VVozY1NLOUhZRW55V0RP?=
 =?utf-8?B?SlhUZndCU0RoUUtuaVlGWThDQjVnYTVodDhIbHVKb29SMERoZ3hBMkhiUndM?=
 =?utf-8?B?STVtZllLb20zc0M5VTVKQ2VaNlBYTVBPK2s4NlVVZkQvWTJ0QzlYNE5zL1FR?=
 =?utf-8?B?N21RNjMxaHRabUVhVG1hMVIwQmZUY25kc2QwVHpaVFZCL2VHdGRYelBJSnAx?=
 =?utf-8?B?MXhVeXJwTjZ2bTdoUnNWMDFaaXZVWGRWdXJIS2NPNHVscmFHYVM1NHZSUkJL?=
 =?utf-8?B?RlNRalhPQkppVWVHR0FYVkNwdDRuM0FzcDZHYWJmVW1ySkorcEdVaEljWndh?=
 =?utf-8?B?RVNQOTRPUEgzTTd5a1ZFU0FRVWo5Z3dSM0dqUlYwaTZ2R000czJ0clVPS1ZH?=
 =?utf-8?B?YjRUeThsbjkvZW9hdi92S0JUYkgyT0tjZE5jSnFRU0Jqc1RNb1BEaGpQelBG?=
 =?utf-8?B?UG9kTmFFQVNEYk5yVTEvR3VZY1FIQ0VNbldxdjNKR0RlYkQvemxaZUhIckRW?=
 =?utf-8?B?bEVmd1h1bERYcjZNVGRGcWJZQVU1S2FLbVhMYW1aUzVSMkVrMWFvTUZjbXkr?=
 =?utf-8?B?Q1BENFN5YVJyTEp4ODQwcnlWWmhJbTJSOHIvNFVVeUhJOHMrWHBwTFJtanQ4?=
 =?utf-8?B?eGlWZFlNZlJmUXRla3IvNmlJc0dScVhLTmNSWGxENmErT002alBiNWcreWt0?=
 =?utf-8?B?Q1UxOUNpZHdHczNLUjFqS05GVXNEbUJIUE5IZHNjWks1RFRYTFBBc1pMM0RM?=
 =?utf-8?B?aFJnYnpCdXBaT3lGN2VYNG93Q1lrOURZMXMxYlQ1T2VHS2J6Yk9yMHpPaXIy?=
 =?utf-8?B?WjZ6eHhzY091WVA4cytkZE5LZ1pVUzYrZ1Zadm14NVBEL21VZ3g3d3cwbURq?=
 =?utf-8?B?U3Y4RStOQzJpTERDcXV6aGFhYTBGR3FBeUxoL25jQTRnK3AzOHdyN2pDM0F0?=
 =?utf-8?B?Qzc1OUQ4OS9Ya3dTV21BdUd2dXRJQUNGbGR2Z0tQbjUzVi9XdFZUNU1yUUJk?=
 =?utf-8?B?WVBDTW9ubVV6QnV0ZG9TWnZQaVU4UXBWbXJMdTdjQzU5WktPMEE0T055aHhX?=
 =?utf-8?B?bWlRaHRJWHpKS0JhU2o2ZkU2SGxIN3Vra1hiKy80L1RTZkV0UjNRYmptRGU2?=
 =?utf-8?B?NU05Uzd4bkhldXg4em85RjNEcE5zRUN4Z2ZQVERrbWlwR0krOXJFd3J1cXNF?=
 =?utf-8?B?c3FVL1BrUEFrbUFIbHF1YnRvTU44RCthWjQ0QzNuZzNZSy9MRGVEVnFvck9w?=
 =?utf-8?B?Y0o2cnZ4NXdtUmROK3lMN0NmS2NBL0NIemJ4ZnYzbXhrc1hKc0NiZ0xzamoy?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e9223-b1b9-43cc-5700-08dafb371874
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:38:48.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fU08oridhR1TVfPJMOMFvvxwYdInczfiwE1FrJBacfAa/pOR8FQeSQEvNIJuRIMIGmkHKbdvMIGEBeJrH5Jz9HbrxoUTKaiRnJGfJi8X30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/19/23 05:28, Greg KH wrote:
> On Wed, Jan 18, 2023 at 08:36:00PM -0500, Tianfei Zhang wrote:
>> Implement the image_load and available_images callback functions
>> for fpgahp driver. This patch leverages some APIs from pciehp
>> driver to implement the device reconfiguration below the PCI hotplug
>> bridge.
>>
>> Here are the steps for a process of image load.
>> 1. remove all PFs and VFs except the PF0.
>> 2. remove all non-reserved devices of PF0.
>> 3. trigger a image load via BMC.
>> 4. disable the link of the hotplug bridge.
>> 5. remove all reserved devices under PF0 and PCI devices
>>    below the hotplug bridge.
>> 6. wait for image load done via BMC, e.g. 10s.
>> 7. re-enable the link of the hotplug bridge.
>> 8. re-enumerate PCI devices below the hotplug bridge.
>>
>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>> ---
>>  Documentation/ABI/testing/sysfs-driver-fpgahp |  21 ++
>>  MAINTAINERS                                   |   1 +
>>  drivers/pci/hotplug/fpgahp.c                  | 179 ++++++++++++++++++
>>  3 files changed, 201 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-fpgahp
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-fpgahp b/Documentation/ABI/testing/sysfs-driver-fpgahp
>> new file mode 100644
>> index 000000000000..8d4b1bfc4012
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-fpgahp
>> @@ -0,0 +1,21 @@
>> +What:		/sys/bus/pci/slots/X-X/available_images
>> +Date:		May 2023
>> +KernelVersion:	6.3
>> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
>> +Description:	Read-only. This file returns a space separated list of
>> +		key words that may be written into the image_load file
>> +		described below. These keywords decribe an FPGA, BMC,
>> +		or firmware image in FLASH or EEPROM storage that may
>> +		be loaded.
> No, sysfs is "one value per file", why is this a list?
>
> And what exactly defines the values in this list?
>
>> +
>> +What:		/sys/bus/pci/slots/X-X/image_load
>> +Date:		May 2023
>> +KernelVersion:	6.3
>> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
>> +Description:	Write-only. A key word may be written to this file to
>> +		trigger a new image loading of an FPGA, BMC, or firmware
>> +		image from FLASH or EEPROM. Refer to the available_images
>> +		file for a list of supported key words for the underlying
>> +		device.
>> +		Writing an unsupported string to this file will result in
>> +		EINVAL being returned.
> Why is this a separate file from the "read the list" file?

The intended usage is like this:

$ cat available_images
bmc_factory bmc_user fpga_factory fpga_user1 fpga_user2
$ echo bmc_user > image_load

This specifies which image stored in flash that you want to have activated
on the device.

An existing example of something like this is in the tracing code:
available_tracers and current_tracer

Would it be preferable to just create a file for each possible image,
and echo 1 to trigger the event? (echo 1 > bmc_user)

Thanks,
- Russ

> That feels wrong.
>
> thanks,
>
> greg k-h

