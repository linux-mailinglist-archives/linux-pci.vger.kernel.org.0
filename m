Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82087B7432
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjJCWlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 18:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjJCWlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 18:41:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886AA7;
        Tue,  3 Oct 2023 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696372875; x=1727908875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jEjP4/KRbB5pAwPIew+ewI8xFuK/0gawtKr5bxApLj0=;
  b=Ke106aMGkpVHCxXOUy7VaD+fkaYYTOFa2siAcxannKodfGrN1Fvipj9U
   BOuM4McYUui7tvBqReAvXrsl9n2cM2s3bbChhv6YF9CI7RCda0EOkeGp9
   halTtL08p9zMnHDhB9W0eMUCzeotiBHkpNWGALyfIvIm2YKlBmrHMs7rz
   b3m+jXisCkEq/6KhGTxM1QYXGnfAFEuvnSw9wORSmXvaM0dLgi6xUGodz
   50Baa5T9+S4SdFjnyHiK0H42bydDFx1PW0jAk+VpGgoS+8K2zb1YT1YeE
   TXO/u4pD42f++MbhM/NJxmR8qDnY9C9/7zTw//ia6bYEjptbabd9NKyn6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447167885"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="447167885"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 15:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821419364"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="821419364"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 15:41:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 15:41:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 15:41:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 15:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCyKbFned8OHupsum2+hqXHQ82MbsNUiod2CBN/kCnRQkCMjf0Zi/uzEHTq8msLqltN/WG/CtNC/Q4wXAa7NDKIMQeKT6VrCkjnMbW15TcqzZ3fTxJgnUEm25nDZGH8nluSvZzraFp8a28QUGMmXPXG4tbeGEDBEYHPy0HJ3gbSp9CvazlQgn9ZmpaU6LhgJGxikMJmRSCAj24L1e+TstFnPEhEDcZ9WAzkWwZ/iBGbrYcbQA1ITkrwxZZGl9ExzDZ0vz+JSdcEfACyqxVbJLzCk70sctQmM3ZZ+bjHHDdjyP6u9MQWt6nQLidIhzXVp35J/NXZGOl7EWfgtQmPh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HxcT0sVXA/n7KMIY+U5sHUw0m9xUWSqYM2QEydRipc=;
 b=gRuvx+7HC4nGQSbhkd+WDVYggVZTjgP16+8b1MeQsMqkKcOj85lPYmDHPhspAe+RHuaK0w4eEwoF1a/WbgAPtln50l4c7Xh13q/FdpBZx2qp3gtK7BBmhsjaEIzPPjGZy22Inrps3QBZKVbdljRkNss3b8nw1+BRYdNVuU9IiSNpW7BO/DUSrhth5IGhJXat1DPsbB4X1KCGOfA0nA8/sYIwWFTS4CTecgAv8SLbddr3NT4DBJxuFZ9inlG2DmqnvCwKGXJWarmfp+RuVIaRF34etAH2cafm5JKBozibVNSSmsVEnjizV24p97JBqODwu9R+R3Wa0eKgySFtoVSi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 22:41:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 22:41:12 +0000
Message-ID: <9f339067-2d59-80ab-4a8a-51781c623fd5@intel.com>
Date:   Tue, 3 Oct 2023 15:41:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net v2] ice: reset first in crash dump kernels
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        <intel-wired-lan@lists.osuosl.org>
CC:     <linux-pci@vger.kernel.org>, <pmenzel@molgen.mpg.de>,
        <netdev@vger.kernel.org>, <jkc@redhat.com>,
        Vishal Agrawal <vagrawal@redhat.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231002200232.3682771-1-jesse.brandeburg@intel.com>
Content-Language: en-US
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20231002200232.3682771-1-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA1PR11MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e00db5-be9f-4e3d-b1ac-08dbc461d818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sil69ZUOUmQSdNCoUhv8XaXhLxjXIGBjFCh2AwhkVU958+EikL5QX7NQnI8VFQwjN8GLaqkBNwjfbmJAg5VCpiTzFjo88+9QkZEK6zIsgWwV1Z2/I+q/leoAb6D0L+2sv+52ojssaf/SI7sxjHRYeY456MQstuLJbM4HefyQyJKICLUTwXFSpBoq8GKQv6zo6s7C5TCxAX/osbarnyZuOVAGke1W/RfKfdmFIm6X6/mfPb03+0mciljIBsvGxFQvYz457hSHOOBHiYWiPsPsZsvbffI4Rt8J4nhGzCYy4OH1SY+bFH/9g6vLTPMeoGMn1a9V4UbFGV8oQh55JH0fF9O5tFxF4mBiSeKx2CBYAoNgWDgUV4wOCcf4taTGgz57uCYt7CN5nHK5r52CHvtQFuhKBTUW1v7vFm11OTOBlk40rR+AS2UHoOBXhrjsloJxxotpKkL1QLmQEAmgd3TbsgtbRAdUn4gsqLLWBdQ43yw6tGKEd4UMuRKnYU4axbNsK/2bix9+UG+qKNkeZk8k/zdYAD5K1UxtWE43Wg86diHFvTPFFuzf1XkAQJ56bErsOr9oEWJRvIDVcc2KV0h1Y28hc6ZF6UovnM09aReKDiGBqON9sGeri6yB725rRjqiYvq6ihnKpg6S+Vpe92ibAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(83380400001)(31696002)(86362001)(36756003)(82960400001)(38100700002)(316002)(53546011)(66946007)(54906003)(66476007)(66556008)(6512007)(6506007)(107886003)(41300700001)(2616005)(6486002)(478600001)(6666004)(31686004)(4326008)(8676002)(26005)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aisxY3ZDT083QjZNVWpHRExXT1hhbFp5WUlJdkxUODVHVDBULzl1QU94bHZ5?=
 =?utf-8?B?aXlEYW8zMVUyNm5PWnc3dE83WUhrOG4rVGg1azZQejAzcmh4SkpWZWp5MTJD?=
 =?utf-8?B?aEFVNk9yMS9ucWhLK1FXci9OZGkxSDVGMC8wUmlUdVZFY2F0MWY4M1FJandl?=
 =?utf-8?B?YWZXTGE3blJxOGhUeTZqRG1TVHZHYWdTclphZXJzelp4MnlKUnM2dXFiR0Zw?=
 =?utf-8?B?Qk5BTFRZK05TQXErWG1Oc2s5VjBqcmtJczJWcVRCeE5Rd2Y2RjFDb2E1VkVR?=
 =?utf-8?B?OUU2Y3NvdEpST2hCU00ya1o5b2N1TlZDUUVFL0JRUThQcEc4YlRNRDVUOXFM?=
 =?utf-8?B?c3dlbWJSSndnTGxLSDZNZTVRaDhORjBuNlVuMXVXd1RPUmh1bUI0RHl3dTJZ?=
 =?utf-8?B?Njk3Vzc3QjNuWGNYNkw5RVJ6eDJ3R1EvTDB3bm13QXgzNW5ONm1BSWNvdWNJ?=
 =?utf-8?B?VGNyM0I5emJCb3oxYm1PNWZrWFYvejAyV0FnUzZuRkVkbEY0U05zSEkydElp?=
 =?utf-8?B?UkIwVEkyWlJEZmpXQTZaNU5HS0NEQituU05Uck1ITmlMK05CMjlCNFJST2ZC?=
 =?utf-8?B?NDluODF2QUk0Y2hrcFRQVExhS2UxOWlLUWdJRHc0b1pRUWszOGpRYmxPb0xO?=
 =?utf-8?B?b2U2SFVTVzZsdWs4ejEwSk11anhhS3hLVG5NU2gra2s2dGdZUWNEOGI2SHlt?=
 =?utf-8?B?b2lybVlFQjNFSmgvRHhqQU9IOXYwWERwZmhNTGJyT2IweUdFdlhiZWlaM3di?=
 =?utf-8?B?MGh2T3B4ditCN2tVTTRrU25jczM1U3BCREVrSktpbGUvQm1PbkJ5bTBNcUZx?=
 =?utf-8?B?YXhkTVpIT2hWZXJNN3BDRVlyaG5FMHdwWU5qcHp0WGYzQmhQaHplS3NIdlRD?=
 =?utf-8?B?YUNNdnJqRXBmYWhYOFN2U1ZzRWFwSG9BQkMxVWx1cnJ3dmErb3Q3cjZSY1VI?=
 =?utf-8?B?YXJsNjM4bU8vSUh6eFNrUmJRRmVFMXRQWnUyNnVSdWVQTGRPS3lCOFhjRDl5?=
 =?utf-8?B?eFRTREtsTmZrZ2g4RlJ2TS9VVXk1eG5sZEpkemV3NDRBM2dYMmR4YkhPUnRu?=
 =?utf-8?B?Q0E5RFdjMStOZGkxUWdsOEo4MEY2Y3VSRWFBK1lDTDJkSG5sNjc0YVJwRmdl?=
 =?utf-8?B?N1BWWDdEeEVUZGpMMk5NS0R6QXFTR1dnSTdaU0tmbXpTTHNYdjhoRUU5UVZ0?=
 =?utf-8?B?endRcllQVTNMNnNhM0Z0ekxFbnArWTlIRlAwdkNSaFZDK1lSVzErd1RHQUFz?=
 =?utf-8?B?S2dzUzdUVEdoQWhNQkFUcWtabFlqTkw1MGFvVlB1c3dhRTE2UmdkZk9wdWRI?=
 =?utf-8?B?UWRQUG9LTEllTXBPcDJKRnlKTStFSUxBUHR0VW9VTVA1Z1RDREM2by9CeDJS?=
 =?utf-8?B?cnNyTEkzenRyeFJyNyt4aURlOVdsZGduWDlQZ3Fxem9oSnNzTk5RTkdWTzJs?=
 =?utf-8?B?bHJaNndiTEFHSHJ5aGg4QUtUY1JQWXBabDMxVHk1RksvVkE0RFVMSmFaWVE3?=
 =?utf-8?B?NHptMzBTRFBwQzQ3cUxoWEpsM1VVaWx0cXhReHRMeVBXRXZLeGcrZ3hRYWZy?=
 =?utf-8?B?d200d3crVXo5dml0RVhUOXFlS1JtUTZ2WVRuTGVJSC9QNmhmNGNtTVpTRmV1?=
 =?utf-8?B?TW1RZU1PRW1zM1creTZyTFRRTVVUazFsbzVvZERlL0Vla0ZTNjh2SjF6THRK?=
 =?utf-8?B?TlkyZ1FmckRJaW8wREc3UFcxSDV2YWNwNHFTOUJDTUM1Q2FpNk9FdEVGN1dm?=
 =?utf-8?B?NjFMY3NxU0NLMmg4c09iOFVTUXM2T2NEdTh5ZlhETjlxZTI4cEFoV0Z4czhT?=
 =?utf-8?B?LzBacCttc3pySlBKYThtQjVBVk9YSVY3ejd0RFFuQ0x1eEt6VWpvRFE5VTMw?=
 =?utf-8?B?Q245blR3eEIxT25uY3dPTVkvQ0cvNWUvdmVmRDYrWDhkaW15cG9tbzAzYU4y?=
 =?utf-8?B?Rm9ZMUY5V0prSEQwdEo4RzU0Y2p5RGdTN3lmSFRzbGRXQndEamoyRktKOU5Q?=
 =?utf-8?B?MnB6REZnVlZYTGx5aEMvUis2REVoa0FDZGFScnpqN2lJV1BuZEVJMGlvK3oz?=
 =?utf-8?B?OEdJVVVSKzk0STJWWi9qZDVWNDh6MHVjeGkwVjlnRUJBclZHTUcrbVY3alQ2?=
 =?utf-8?B?eE9sdTFNcFpaT3hncHltSGRvWGpDbktKcW1nbDQ1azZnU2d2Uzh6MVBabjNU?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e00db5-be9f-4e3d-b1ac-08dbc461d818
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 22:41:12.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bl4i1wq3aL5oSwVJGQpQ1MlS72jANcKee+VGC/esiD8Kg6m7fIAPx7Eq4u08jDvJc43QTz/ZswZ7W7PZcePRXCPWrPJD5wEsSajwguo/adg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/2/2023 1:02 PM, Jesse Brandeburg wrote:
> When the system boots into the crash dump kernel after a panic, the ice
> networking device may still have pending transactions that can cause errors
> or machine checks when the device is re-enabled. This can prevent the crash
> dump kernel from loading the driver or collecting the crash data.
> 
> To avoid this issue, perform a function level reset (FLR) on the ice device
> via PCIe config space before enabling it on the crash kernel. This will
> clear any outstanding transactions and stop all queues and interrupts.
> Restore the config space after the FLR, otherwise it was found in testing
> that the driver wouldn't load successfully.
> 
> The following sequence causes the original issue:
> - Load the ice driver with modprobe ice
> - Enable SR-IOV with 2 VFs: echo 2 > /sys/class/net/eth0/device/sriov_num_vfs
> - Trigger a crash with echo c > /proc/sysrq-trigger
> - Load the ice driver again (or let it load automatically) with modprobe ice
> - The system crashes again during pcim_enable_device()
> 

This is missing a Fixes:

> Reported-by: Vishal Agrawal <vagrawal@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: respond to list comments and update commit message
> v1: initial version
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index c8286adae946..6550c46e4e36 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6,6 +6,7 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
>   #include <generated/utsrelease.h>
> +#include <linux/crash_dump.h>
>   #include "ice.h"
>   #include "ice_base.h"
>   #include "ice_lib.h"
> @@ -5014,6 +5015,20 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   		return -EINVAL;
>   	}
>   
> +	/* when under a kdump kernel initiate a reset before enabling the
> +	 * device in order to clear out any pending DMA transactions. These
> +	 * transactions can cause some systems to machine check when doing
> +	 * the pcim_enable_device() below.
> +	 */
> +	if (is_kdump_kernel()) {
> +		pci_save_state(pdev);
> +		pci_clear_master(pdev);
> +		err = pcie_flr(pdev);
> +		if (err)
> +			return err;
> +		pci_restore_state(pdev);
> +	}
> +
>   	/* this driver uses devres, see
>   	 * Documentation/driver-api/driver-model/devres.rst
>   	 */
> 
> base-commit: 6a70e5cbedaf8ad10528ac9ac114f3ec20f422df
