Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687B745A6E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 12:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjGCKiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGCKiu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 06:38:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA98692;
        Mon,  3 Jul 2023 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688380728; x=1719916728;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=UYyaBD3mQxa2syPA7YwCMt4gRZSZiRGNyAZAEnSD7bQ=;
  b=LOkNuLpnlIjroPIWAaHoDK0dpJL59licL1NhLWGZH0/SmpWzUQahVgN8
   ffNwvVpkLD1FVPpYLSIfPDIhPLI0O11Ff+UqqKmX91PHSQt7xAz/9iMhN
   njQ/2JFsetn0Cy9rWogSD/1HHAfVJfjWUxRaSfQZ1HV8frev/sb8xmeJF
   DauXPPAhOFi55dSYmNu2AYcoIAyQTabLfGvflAJL0sEWTkCmZggFIPB/n
   qWBXhQP416+43dY92DQcGj1wtkPIsiPJeYFPFovVo+wJDMVcZPF4a4Zlw
   c2kOxYyyFLaW1h4Vp6n1ti4htWDh39cM+c+k20oq4yVX4GG58lND5rIv4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366332912"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="366332912"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="1049031371"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="1049031371"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2023 03:38:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 03:38:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 03:38:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 03:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcnvAT34JMeP/C2INXKjDfr6FUBgWJS8WbP8GoxXz20rBQwx8def86rlLEdcOdZ/+ArDi1u6A2xAwwiVjwIVgWDIM+Kmb0luD3I8jTAV8NcL0kaRAW4qH+crEPfZzBwT99W1uUJjyBup2wZsMd2dnWCvkEuhfCrX4RUbnVaZnXZRWvO2kT0y9cV4IR0xk1mOMBGjy1upUK70YBA+MKLU3jIVbKJitfhUz3H/rjE3qOLSvCiX+paWCLgfwdkWEQPjoqhJawkG+Cvk1TSk8ZDmGVjkHQRE9/FENB8zjEW+GXhT8jDp6ntNAw7ub6/8Q7zseclNIvmZA9QniUVLzeleVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUvvcPsAn2ChGam8ccwkPAI44YyQQFjF1ZpqrDsXt1I=;
 b=k82L7obs4IQj6Fya10mYX86FBh6v0FKfAAldqg4iRn2iZnQ1G3ULz7osPgDua0ZJkI4GkgDJKQntWVKzDS2MN18tAX50XdsRAo0qWNGTp61F2H9FgT+QBbFZZucNSnAeZR4MdfPVLuKIVDhUw/vovJJ/AY5+mRW57lL0pD+SB3+f2VNPNXBYpqiGmgo67gRHHYWp8ULdUDkPSoPvu+J71mL9LbXpxXY2Zp5ZTK1PzoYN9HrHnSglz5FNg9+Azdw5rGP7+53Unk3b3Yjm2Ps8ZWtbjmCFFwAHGBi8xt8WT5jY4VbFAWED2Iq5kNyvPzTCpzKoQNKfgJhG92s7la0SbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 10:38:44 +0000
Received: from SN7PR11MB7539.namprd11.prod.outlook.com
 ([fe80::1552:870f:2326:abf3]) by SN7PR11MB7539.namprd11.prod.outlook.com
 ([fe80::1552:870f:2326:abf3%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 10:38:44 +0000
Message-ID: <c836bf88-d961-040d-b15e-52feb8e11f8d@intel.com>
Date:   Mon, 3 Jul 2023 13:37:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     <mika.westerberg@linux.intel.com>, <helgaas@kernel.org>,
        <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Subject: Ask for a regression issue of vfio-pci driver with Intel DG2 (A770)
 discrete graphics card from Linux 6.1
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::7) To SN7PR11MB7539.namprd11.prod.outlook.com
 (2603:10b6:806:343::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7539:EE_|DS0PR11MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec54fbd-f9d6-4947-a75c-08db7bb1ac9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTksgkH1N+0nTLpVM/j42+F5fpQeu2wDxhm1YD2SQeC98oD2nDW/NAuxCO/RtaaMEE7PAoBfu6Z/1sJ3+a/m6kksJYkeI+AqB9bQ80SIK2Zv2ts4mkzIOrGqrhWpBe6IIFLSeqh/5k5V7Qqb/3ZFpyXHUm8zjG8Cjc0cMTb3qQXj0s/BNX7bWweMm75l9J1dQgztcU9jmwBut2n1Df1ZSc7/EwdlQjNXWbSUVVIB1jj5qVRiQhGs+ehrShDS0KgrVYojflBVQr66ur/S15vRyZui6SSa7M2g3bhRLbZvu9JTGtGh8tqjgZS2AkocLcPEMoiQnDOVDwN9K3q4NOGQc2A0ugRNLwWQ0ghO2g/i7NUQKG05u90vEcPJ46YDTBmTm2FRD6Cecg4ldWkH/DMJ94GHRbVUhtIkfn8wt98bZxOdht1ds8weWQGJUvFhZp+AJDe/ZsnBs/h+Shu6hxxRbsVtGyCfAF++hkmsd8iZeV/6rJsux/vUqzHU3tew2gjbhniC3NcTz4n06oxjVvuuHlOHbTe2/p+Vr0W99a9SGcOHTCOI4KjLEaj3HA4FukgILcc4DOvjMnuT9xgaebENNOWvUam/aBnu/rfzuJ9j5z3rB6P4/IKcoh8iGLZUcVzCVvNwTS5twT6UUBEVB7bOHU83M826WEq0l1HRR7pp9qWFXEO3dnUIBPZp81M5i1Tc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(30864003)(2906002)(478600001)(26005)(41300700001)(86362001)(966005)(6486002)(8676002)(8936002)(31686004)(5660300002)(31696002)(36756003)(316002)(66476007)(38100700002)(66556008)(66946007)(4326008)(6512007)(6506007)(82960400001)(2616005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2RWQmY4bkQ4cllIS1Q2Y21TOHVFNEZ3WE0vUEJyNXpXOEMwRW5NVHBsZFBY?=
 =?utf-8?B?MUNoTmcxUlVkUFFHMG9HQ1hNUVIwakdUWXp5UTIzUzJOQzNnZlZsa2pOZHYz?=
 =?utf-8?B?eVYyQS9pdUVBTkJjY2duUFoyV2FaenQ0UjJnOWJxYnN1VmJSbjBPZ2lxUlM4?=
 =?utf-8?B?S0ZZSTJ2Wjc4eFR2ZzNaSGVhOC9IQW85NTVHNnRzTmlERzFxbmZmZmNEVDdF?=
 =?utf-8?B?K09qMG8vVG9hUE05MjRGckc0S3ZPK2NVRS9tOHhHT1V0NDlrNFEzNnQwVnVv?=
 =?utf-8?B?YWVGeEZtcU9VNFhCQkZHWEpBWU55SWN2b0FTMVpQTU9CZ3MxY2dDREM5ekgv?=
 =?utf-8?B?Ym9OYnQxZ0tiOUxTdGVjeUUvWUViN2R0Q3N4RjBVdDBJVUY3b3IrL2JTdHdW?=
 =?utf-8?B?MjV3REFqdzhrcUpJOHVMbHhMQUlGaVEzU1dHa1Z6UXlMajA4YlJGYWtRUlNa?=
 =?utf-8?B?TW5DMkkvcVc0ZWFUWDBvYnUzbW1EV2RJSm1qOUFxSlNFdGxhL1kySUp3VDRV?=
 =?utf-8?B?cEFrcWtLYXZEeVd1d0pUQ00vTnl4UHJsbFZJVVlPQ0tIR1o0YVBMZXFZQmdI?=
 =?utf-8?B?Z1I5dXgwaVlZdnNiT014eEpVM2NraExnN1lPTVZ4MW1hRExQdnN6VEM3cExz?=
 =?utf-8?B?aVBXdEpaR2NmT3A2OWNJTXhDRFdzakoxVGZ6dWE4Ny84QmZueXgwTkhKRCsv?=
 =?utf-8?B?alFocTNuQllMRFcwWmR6K3Y1aCtodVd6eHlkdHlIbXc5UU5kTE1Ec1I1Yk12?=
 =?utf-8?B?dEFGWUsxdUdqaXpKSEJzR0ZCcE53RFkyOEUxZjhiRXlrLy9ieko2dHcwdjgr?=
 =?utf-8?B?cGV5ZC95dm1rTTRFTFpvYlBEMURIdWZYUFpYNGJHZVUrODdiMDJtWDQyTmNr?=
 =?utf-8?B?Y3ZtbmNERFlEMzlZRFJGWTJSTVpnTHFBSnRYQzdYMXpMcFJsV0xXR0dWU2R4?=
 =?utf-8?B?ZnZ6ZXQ1ek0rdDZXQ2J6NE9vczg4M3FVWGw0bDNlT2swV3FlS29iYlpPOXZQ?=
 =?utf-8?B?WjNjWURIY2Zwa05qK3M0UVphZ3ZCTENxeVBxMWpnakhDUWoyL0tsSkNoSmU0?=
 =?utf-8?B?UkxKKzlIeFRTSDdkVGphZjVqNDloTVczaWo0cVdEM0xOS3krM3NpQVlmMzEx?=
 =?utf-8?B?NkF2bUZvYTZZMndZSFpBNlBFQWg1bFpKRitMOXJ0ZWFVR3c3VGhsRGtjVUVY?=
 =?utf-8?B?ZElrZ01uWUFWVHJqNDJ3dW1lUWtuNlppRzhCYkpBeDZqOGdEcDl4eDNvRUN1?=
 =?utf-8?B?QnFCSHJBREphTWVKcUl5SnlpNjBGN2VXbTN1bHFkYytBQjFseG9IejUvaXVP?=
 =?utf-8?B?WDVVYjlFQituNGwxUmVZZDhYbFVTcWloN1BpOXh4RjhjZmZJSmxlMnhmNHZJ?=
 =?utf-8?B?c0xKcWpyTTJLbGNzbUtwcVZFZGF1UDdXSXJkZzRUSzdKODE3Uitlbk9ZSmtp?=
 =?utf-8?B?K2FuQk9WMW00VWpNbjZ5WElTQWJGbVNtLzNxNWs3UVY0VjBmODRxQUQvWk15?=
 =?utf-8?B?c1lGa2JYdXRGYXAyTStza0hiMXl2TXpXZCs2S0c4WkJ6anBZcHFLSU1QTmxo?=
 =?utf-8?B?T1FwVWxqV1BxYXNDUWVNdTRJR1NhclhGMGdOakFRUVp6ZCtwc1crSkZWcExQ?=
 =?utf-8?B?TU15OHlwbFFqckpBbG1ZcWwrVXFSNE5YR294MC9IKzZpK0xKS2twQ050RGIv?=
 =?utf-8?B?aER0dVh0Z0VXbGhQVlJMcGJyYVo1SHBSV25uUklWRkltejdKOFN5NXhUZDFq?=
 =?utf-8?B?anVDeDJFYVErRzRTYkQvWkY2bThvdmE4c3NYSEMvZis2SktVSUNBUmJRQ2tx?=
 =?utf-8?B?cm95RlJORy9FWEZ3Mzh6RWdHL1ZPcFZzK2JQUXkrZlR4cUcxaDNoeTF6TVkv?=
 =?utf-8?B?SFR3VVlPUWZZdEs0ZjJ4OUJlMmF6ckVpVkpFVVo3TG1DRHR6clpKZVdMalYz?=
 =?utf-8?B?cU9UTXVKNkNWeFNmb2lqdzNlTCtyZGdDWGhCM2xsQXl0MEo5aGxNU1NGOW5M?=
 =?utf-8?B?STc0NmUzbkliUXQwUjQ1enJ3UVVuL3BaT1BOaHBQeVQxZkxzSk9RcDZJeEtN?=
 =?utf-8?B?STErZ0VTT2hDbktqQmF3dGZaWUY1aEtVRG9ldG5TV1kvZllVUmNkNzBITkRx?=
 =?utf-8?B?OVVsMUc5QnAyelBBc1hDYjYwclM4SlQwejRBY1VNMlJYUURRZHNJb2p1b0NN?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec54fbd-f9d6-4947-a75c-08db7bb1ac9d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 10:38:44.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6T5WZbTm+gqHveMIydaHup2Tf37WbCXRKWLKk1E6M2BfnxXmqr0COh+gTLeF0cG1pZNehFq268xLfEDChVSph5lqLKfCPLhtAbYm8Nzj3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Since Linux 6.2 kernel (same happens in Linux 6.4.1), loading vfio-pci 
driver to a specific HW (Intel DG2 A770) target does not work properly.
(It works fine on Linux 6.1 kernel with the same HW).

The configuration and hardware information used is described in [1].

Starting with the Linux 6.2 kernel, the following log is output to dmesg 
when a problem occurs.
...
[ 15.049948] pcieport 0000:00:01.0: Data Link Layer Link Active not set 
in 1000 msec
[ 15.050024] pcieport 0000:01:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[ 15.051067] pcieport 0000:02:01.0: Unable to change power state from 
D3cold to D0, device inaccessible
[ 15.052141] pcieport 0000:02:04.0: Unable to change power state from 
D3cold to D0, device inaccessible
[ 17.286554] vfio-pci 0000:03:00.0: not ready 1023ms after resume; giving up
[ 17.286553] vfio-pci 0000:04:00.0: not ready 1023ms after resume; giving up
[ 17.286576] vfio-pci 0000:03:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[ 17.286578] vfio-pci 0000:04:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
...

And if you check the DG2 hardware using the "lspci -nnv" command, you 
will see that "Flags:" is displayed as "!!! Unknown header type 7f" as 
shown below. [2]
The normal output log looks like [3].

This issue has been occurring since the patch below was applied. [4]

d8d2b65a940bb497749d66bdab59b530901d3854 is the first bad commit
commit d8d2b65a940bb497749d66bdab59b530901d3854
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Dec 9 11:01:00 2022 -0600

     PCI/portdrv: Allow AER service only for Root Ports & RCECs


Rolling back the [4] patch makes it work on boot with the latest version 
of the kernel, but the same problem still occurs after "suspend to s2idle".
This problem existed even before applying [4].

Suspend has been tested with the following command.
$ systemctl suspend -i

$ cat /sys/power/mem_sleep
[s2idle] deep


Here is the log that is issued when testing suspend to s2idle. [5]


Br,

G.G.


[1] Env:

NUC: intel-nuc-13-extreme-kit-nuc13rngi7 
(https://ark.intel.com/content/www/us/en/ark/products/229784/intel-nuc-13-extreme-kit-nuc13rngi7.html)
(MB: Z690, CPU: RPL-S i13700k)

PCIE Card: Intel A770 GPU

Add boot parameter: intel_iommu=on iommu=pt

$ lspci -nn |grep DG2
03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc 
A770] [8086:56a0] (rev 08)
04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller 
[8086:4f90]


$ cat /etc/modprobe.d/vfio.conf

options vfio-pci ids=8086:56a0,8086:4f90
softdep drm pre: vfio-pci

[2]
03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc 
A770] [8086:56a0] (rev 08) (prog-if 00 [VGA controller])
	Subsystem: Intel Corporation Device [8086:1020]
	!!! Unknown header type 7f
	Memory at 93000000 (64-bit, non-prefetchable) [size=16M]
	Memory at 6000000000 (64-bit, prefetchable) [size=16G]
	Expansion ROM at 94000000 [disabled] [size=2M]
	Kernel driver in use: vfio-pci
	Kernel modules: i915

04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller 
[8086:4f90]
	Subsystem: Intel Corporation Device [8086:1020]
	!!! Unknown header type 7f
	Memory at 94300000 (64-bit, non-prefetchable) [size=16K]
	Kernel driver in use: vfio-pci
	Kernel modules: snd_hda_intel


[3]
03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc 
A770] [8086:56a0] (rev 08) (prog-if 00 [VGA controller])
	Subsystem: Intel Corporation Device [8086:1020]
	Flags: bus master, fast devsel, latency 0, IOMMU group 19
	Memory at 93000000 (64-bit, non-prefetchable) [size=16M]
	Memory at 6000000000 (64-bit, prefetchable) [size=16G]
	Expansion ROM at 94000000 [disabled] [size=2M]
	Capabilities: <access denied>
	Kernel driver in use: vfio-pci
	Kernel modules: i915

04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller 
[8086:4f90]
	Subsystem: Intel Corporation Device [8086:1020]
	Flags: fast devsel, IOMMU group 20
	Memory at 94300000 (64-bit, non-prefetchable) [disabled] [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: vfio-pci
	Kernel modules: snd_hda_intel


[4]
commit d8d2b65a940bb497749d66bdab59b530901d3854
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Dec 9 11:01:00 2022 -0600

     PCI/portdrv: Allow AER service only for Root Ports & RCECs

     Previously portdrv allowed the AER service for any device with an AER
     capability (assuming Linux had control of AER) even though the AER 
service
     driver only attaches to Root Port and RCECs.

     Because get_port_device_capability() included AER for non-RP, non-RCEC
     devices, we tried to initialize the AER IRQ even though these devices
     don't generate AER interrupts.

     Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
     GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
     failed, and portdrv failed to claim the switch port at all.  The 
GPU itself
     could be suspended, but the switch could not be put in a low-power 
state
     because it had no driver.

     Don't allow the AER service on non-Root Port, non-Root Complex Event
     Collector devices.  This means we won't enable Bus Mastering if the 
device
     doesn't require MSI, the AER service will not appear in sysfs, and 
the AER
     service driver will not bind to the device.

     Link: 
https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
     Link: 
https://lore.kernel.org/r/20221210002922.1749403-1-helgaas@kernel.org
     Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a6c4225505d5..8b16e96ec15c 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev 
*dev)
         }

  #ifdef CONFIG_PCIEAER
-       if (dev->aer_cap && pci_aer_available() &&
+       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
+           dev->aer_cap && pci_aer_available() &&
             (pcie_ports_native || host->native_aer))
                 services |= PCIE_PORT_SERVICE_AER;
  #endif


[5]
[   71.995824] PM: suspend entry (s2idle)
[   72.000793] Filesystems sync: 0.004 seconds
[   72.153926] Freezing user space processes
[   72.156234] Freezing user space processes completed (elapsed 0.002 
seconds)
[   72.156244] OOM killer disabled.
[   72.156246] Freezing remaining freezable tasks
[   72.157616] Freezing remaining freezable tasks completed (elapsed 
0.001 seconds)
[   72.157619] printk: Suspending console(s) (use no_console_suspend to 
debug)
[   73.756457] ACPI: EC: interrupt blocked
[   75.103988] ucsi_acpi USBC000:00: ucsi_handle_connector_change: 
GET_CONNECTOR_STATUS failed (-5)
[   84.052478] ACPI: EC: interrupt unblocked
[   86.085388] pcieport 0000:00:01.0: Data Link Layer Link Active not 
set in 1000 msec
[   86.085523] pcieport 0000:01:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   86.086984] pci 0000:02:01.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   86.087005] pci 0000:02:04.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   88.335403] vfio-pci 0000:04:00.0: not ready 1023ms after resume; waiting
[   88.335427] vfio-pci 0000:03:00.0: not ready 1023ms after resume; waiting
[   89.375444] vfio-pci 0000:04:00.0: not ready 2047ms after resume; waiting
[   89.375471] vfio-pci 0000:03:00.0: not ready 2047ms after resume; waiting
[   91.615418] vfio-pci 0000:04:00.0: not ready 4095ms after resume; waiting
[   91.615439] vfio-pci 0000:03:00.0: not ready 4095ms after resume; waiting
[   95.882059] vfio-pci 0000:04:00.0: not ready 8191ms after resume; waiting
[   95.882081] vfio-pci 0000:03:00.0: not ready 8191ms after resume; waiting
[  104.202062] vfio-pci 0000:04:00.0: not ready 16383ms after resume; 
waiting
[  104.202066] vfio-pci 0000:03:00.0: not ready 16383ms after resume; 
waiting
[  121.482058] vfio-pci 0000:04:00.0: not ready 32767ms after resume; 
waiting
[  121.482067] vfio-pci 0000:03:00.0: not ready 32767ms after resume; 
waiting
[  155.615409] vfio-pci 0000:04:00.0: not ready 65535ms after resume; 
giving up
[  155.615412] vfio-pci 0000:03:00.0: not ready 65535ms after resume; 
giving up
[  155.633757] i915 0000:00:02.0: [drm] GT0: GuC firmware 
i915/tgl_guc_70.bin version 70.5.1
[  155.633761] i915 0000:00:02.0: [drm] GT0: HuC firmware 
i915/tgl_huc.bin version 7.9.3
[  155.636177] i915 0000:00:02.0: [drm] GT0: HuC: authenticated!
[  155.636860] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[  155.636860] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[  155.637228] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[  155.661583] nvme nvme0: Shutdown timeout set to 10 seconds
[  155.663188] nvme nvme0: 24/0/0 default/read/poll queues
[  155.674267] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[  155.823379] ucsi_acpi USBC000:00: possible UCSI driver bug 1
[  155.823390] ucsi_acpi USBC000:00: failed to re-enable notifications (-22)
[  155.833326] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[  155.833358] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x0
[  155.833367] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[  155.833377] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x960
[  155.942363] ata6: SATA link down (SStatus 4 SControl 300)
[  155.942537] ata5: SATA link down (SStatus 4 SControl 300)
[  156.030241] mei_hdcp 
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 
(ops i915_hdcp_ops [i915])
[  156.030830] OOM killer enabled.
[  156.030831] Restarting tasks ...
[  156.030894] mei_pxp 
0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 
(ops i915_pxp_tee_component_ops [i915])
[  156.031827] done.
[  156.031837] random: crng reseeded on system resumption
[  156.036058] PM: suspend exit
[  158.962881] wlp0s20f3: authenticate with 4c:ed:fb:a0:7f:6c
[  158.966647] wlp0s20f3: send auth to 4c:ed:fb:a0:7f:6c (try 1/3)
[  159.001337] wlp0s20f3: authenticated
[  159.001858] wlp0s20f3: associate with 4c:ed:fb:a0:7f:6c (try 1/3)
[  159.002882] wlp0s20f3: RX AssocResp from 4c:ed:fb:a0:7f:6c 
(capab=0x11 status=0 aid=1)
[  159.010807] wlp0s20f3: associated
[  159.159528] IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s20f3: link becomes ready
[  287.875205] vfio-pci 0000:04:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[  287.936500] vfio-pci 0000:04:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[  289.414087] vfio-pci 0000:03:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[  289.475297] vfio-pci 0000:03:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
