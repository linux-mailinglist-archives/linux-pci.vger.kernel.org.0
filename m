Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38522461146
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhK2JvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 04:51:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:16524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245350AbhK2JtD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 04:49:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="234659730"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="234659730"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 01:40:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="743594870"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2021 01:40:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 01:40:44 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 01:40:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 01:40:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 01:40:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAWJTryLaPzIcDxpMLmRAWaxI+c4Wj+eICMMKJNmvqxi97E9lXiCfkN7wRGIJ6X23R/usN4OmNVJMvg4hVMxOEHREb7hcm//yacb2gZ0lUJED/T71W11SGDSfaCZYWxDj0du2o2GCRvUwFI2Rujklrh4oxcYZaoXSi5c+XTPovyFBCrJCHay2Xf7sMKnWSYMiaRvGE8u7cH4mX8UyUUH/2teWYhdyYjR8p8OQzNWhOVk+VZk/DFbhq9W0yg4FsGSvtf526FQZ1xMzRKBENRkylJJZmmyGv7epSyG8IUYLJNAWpVDWhH05Sx3z2/tGF+ncXPH8nbOBHSuubHsebODmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghiQwRO0xKo/9T0gJTviWQ7KRTWhGC3jol29Zoehql0=;
 b=hm3SgEIN9YNXK+gt7xXTgemjjawNGqgkGKXzRvNZQOx+ZTuejF4JAx7X+/st/osgTTSglddDRLcTeiCPwtKut16lh6YyOXgrhaU2vK5N4dj3CGEBF0aN63BIpw+tCuIxR/pP+80JGHGA92n/45LinX/Bo8xsmoSb54PqeumRV1CJFrzqF3h8e9FOOnEESL2vAs4T0XZmH6kJiL6nEEEZubEsHaERWZl0i7ZuI/vInI9GeZPZzS4OXrAPzfbfqharMBwXlFSYC6UXz7awUk678I7f8ubgVR7uZOmcb99NHRjEH+4mhn7ffj/KluP7G1sAZlOUgS+sS+gCQzgMyzAC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghiQwRO0xKo/9T0gJTviWQ7KRTWhGC3jol29Zoehql0=;
 b=fGRL/Tlo7WNnbHEHVej6hyWIE2rQhqF2mbUg/Du3DPbrpKBB0x0HBu34c4eubbriR2jo6l6e9Hf6wq5Gamonv6V12kzEWb4Muogw27/SY8KWPLzCjF3xpnfPYH+2mQ3vY7lFr3TOGsLuSpAzWuXK3aAJguKhAJL2S3t4Z1Gos7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5581.namprd11.prod.outlook.com (2603:10b6:a03:305::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 29 Nov
 2021 09:40:33 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4690.019; Mon, 29 Nov 2021
 09:40:33 +0000
Message-ID: <e13da0b9-51c9-5507-9d51-677af2e088c2@intel.com>
Date:   Mon, 29 Nov 2021 17:39:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 17/23] cxl: Cache and pass DVSEC ranges
References: <202111280254.IoqCZcvv-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202111280254.IoqCZcvv-lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202111280254.IoqCZcvv-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.142.18) by HK0PR03CA0097.apcprd03.prod.outlook.com (2603:1096:203:b0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 09:40:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0e52bca-2795-478e-5337-08d9b31c4a08
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5581:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB55816C06CEFBDE77CFC6C45EFB669@SJ0PR11MB5581.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqGvCh/2ss+Ans8WtfISPiUDYmp5+qooUtj98bHvgs1FT45IjyC538KYs3PSwZ2ZX80FQdWMJUsHNbielDE/qn3/9VDaWUJ2Oguo9O7RcR5KgVfoyiZf28TNti58TAT++MS8u/sb8gwVMlG7MQLvhIUK8Ad7pNHpz17LflQkVGVoIeYAuk+ZMVKU0+sGHOupTW62kIfpEMDrXaJIOCNV+EyK8dZOmOjxlVGj3R4n2D2wEVtkEIkn+f4vcGqsNyYQ5UDwc/mdLoO1ivEoKX1ohh2x1BHOYErbwi560ilhQW8AC4WHOZarvpFDfsk7gla6BZ+uyySHr4jqbPURSrcST5LcioMVv+4FFgsUmvsmZIerLxl9Yucnm81uVD4BgO76ObwChBv+QLPCjCKZ1Thxo8dVWgNoUcxcTVoCg5dcg/Qi7vcD6kyH5zc3t1MhJpF8skJaF1o3Z/m7AyQTFfslFndEfup1+ARBlNXw45GY+Z6dMon1KXxcRm2h7qeDyF9X+KeiR62X92QYS/UwUBZu2LYZt/GPCxogiPu1Z1lel2rj/JbHe3Z7MkqhwdG0T9nSmk8NKKYr9+VeC4avsF6pANC+mxjoagWfFdUCY+/b+jT7b8fx8h2ylUPEHSh5XFo5wSkz6+1+BqpghkchfwAtQjDTK/Ydm0m28ouqntAGQb0XeEx8hhdC151GPmiiFpQm76ZXhfOJpbQbzAbxWK5KeeSGUNk/Md1aUOx7X3608jN3gRaEtOfDavEFjW3jdUddirpSoIAqbaP7aYcY6fcGObQRlOn6sBuoFK6ld7kRNKSoeLrpJVSKfvzShrUqoMKCLyOMZ5VlFcrixxUoSIQAiTNZf7t1n53Y5DGvL3us0QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6862004)(5660300002)(2906002)(186003)(83380400001)(16576012)(966005)(37006003)(38100700002)(6636002)(6666004)(8936002)(316002)(66476007)(66556008)(8676002)(956004)(82960400001)(31686004)(2616005)(36756003)(86362001)(26005)(4001150100001)(4326008)(31696002)(508600001)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9KMnhidjVNUENnMWc1UUxBM1NhMFZKVFVyQ09wRlZCSFFaS2QrL0NmUHly?=
 =?utf-8?B?bi9YazBVRlhsTHVoT2JhbVJ4NXh5dnd2WVJuV1RnQmNVODR4UW1xcENHc2JY?=
 =?utf-8?B?K29JTVRTcTA1a1BrenpBRkhiYm85dUF2bTJmWTZ6K2JuUWhNSE1TUG53ZWhE?=
 =?utf-8?B?SUZCV1VJeUgyOGcvZWd1Skt3dW9BQXZEWTFJdCtDL0R6MXpLRDJBVHd6aVNu?=
 =?utf-8?B?c0JMcG5ZUFo5SmI1Zy9jbnVFWHJEQTJjWVFEcUwxNDdyT2VGQWEvOE9QbTVr?=
 =?utf-8?B?ZHVMVVpaQUNrRGo0eDdPVW11MDZWMHZoeThNVlhFYW5zZndWNGUwMzRtUnNK?=
 =?utf-8?B?KzRtWUs1ZFlqV3NBUk81cFBiRlducm9zWno3bUJldENkenpzWEZzNlNOOUtE?=
 =?utf-8?B?TzdmZUZUU0JvQmRLdFpaVklKMythcm1EUnd1LzlhZlJKUVpLeUU4azFrRUVS?=
 =?utf-8?B?aU51WmNlV2VXNzRrY3Zhb0haRGl5aDFjRXpxeG9FNXo3K0dDblBFTHVUVm9o?=
 =?utf-8?B?UG1Kb09SRFZRS0FTeitFUHRXTGpBYlBkM3Q0TFJrNGI4bEg3bnFmSUdXbEJj?=
 =?utf-8?B?UDJkSlNnSDlJbENVVkVpcVpENmkrcHppT0QvQWU5RHk2QmhKb204elNrMS80?=
 =?utf-8?B?dVkwUGF0Tks1NVhFcTlKbWh0c1RaT01DYlRpSkxMVmdjSkhldzNpMThGQ3dC?=
 =?utf-8?B?QWUyR0Y3cDZKdEIzVVpXQi85N0sxeXF3YXc5MWh5RXhKRU90M0hkWW5PWEly?=
 =?utf-8?B?a1ZNVHZxZEYwK0N5UkVlYm5XQ3paekRjUXdYbFc4ejFLangvRE0rK1NxekNB?=
 =?utf-8?B?c3EwUHB5SmNiRnQ0bEEzQkRyTnhJTzFwbWtNS2xXUTVsNXBQUkk0cUdnM3ZN?=
 =?utf-8?B?ZHRSelg3RThqUU1XRUs3N1czUEZwNGxRNDlmbVlZd29rSmllcEVjYUpaVEhv?=
 =?utf-8?B?T0htblBUOFVVendEMUJ3allUSmVRYTdScDhTUVZBTGo2Qm1HdzlNUkNDZXZY?=
 =?utf-8?B?YnNQbWJkdSsvb1c5dEtOVGpxYytDRGdkSlMwMDkrMnlLOXgwYXF5YUhGayth?=
 =?utf-8?B?KzdvcTM4MjIrT3cyeUtmVmYwWnN3L1JubnR5Uy9FbWN2VGFHM0ljWnZkVzRQ?=
 =?utf-8?B?MzJ0ZkVjQngyeGZ1eDdaQnFTdWdNM21HMTBJMVd0TjlRdGtmdWRsZTZFSmI5?=
 =?utf-8?B?cUJuc2NlUjEvYityVVFWbXd4ZGxrQWNtVGE4U0FWK2xKc1ZLVjFtUHNNcWU5?=
 =?utf-8?B?ZUpPZERZY1JQZ1NjVW5FSGJDV09nalR1bUpKSnNKelNlOWJIVjI1aTFVSGNy?=
 =?utf-8?B?RlhrYVVScXFtSmtWbmw4N1c4RHpmYVlrRTNGZ0JPcmhkMFhKNWxhNlVXUDFX?=
 =?utf-8?B?dWUraHFtYThvM2lMc05vdzJ0bDFPYVdRMlowL2xtRUFwaWUzelRLNXRoYjhz?=
 =?utf-8?B?R3BSdTVzek5XYjNCR3JYMTFaNDFqRWorY1JlMUZvMEo5QTNDYXgyNmFPUFZ1?=
 =?utf-8?B?RzQ1cFFQUEpud2kzTG1Kd3RreDU3T1NvaDNXYnNORlBDYkdwc2doMEpaQ3Np?=
 =?utf-8?B?aE9DOFNmZmlKMUUrMTI2dnR3TEZDWlVRU3FnZWU5QXV5emZzWnUvbm5iSDlh?=
 =?utf-8?B?RndpbmV2QWpEOWpHcURVQ1ZhSHB1Rm9qcEU1Y2cvVUI5VHlqenlCL1hRNTI4?=
 =?utf-8?B?c2pZckV6ZFBPZWF4dTNRcDVvZTFoL3F4Y05LaWRqTWJGejl6WkxyU0hsNnov?=
 =?utf-8?B?eUpyV1NxdGZCNjJaN3FOaThDYm43Tzl1dlIyYU1KTzF6SHhaR2ZkRTJ6QkY3?=
 =?utf-8?B?dXpuTzJzbzRObGkrOENEcE82VlZqY0wza08wM09TVzY3QjhhMlVyZ3ZkN3Zk?=
 =?utf-8?B?QjNmWlI3ZnBLOS9pNmZ1UysxUFpnbjYwa1dxN2tINGlsdDFxR2NzU2JtMDNX?=
 =?utf-8?B?T2Jkc1NUYU1ldmJNK2c3eEVtSndiTVY4QlcxRVB5bFlTLzBsU0cyaHk3UjlD?=
 =?utf-8?B?QU1nTnIwbHV5RlpqQzNFZThDUE5HRmNTakMrdXI1dnBJWStTdk5qN09jQVpX?=
 =?utf-8?B?VDg5dXp2eCtQRjFBWnlDdEhxQ1ZOQysrVWU3ZzIyOU50STBYeGtoOFJjcmpX?=
 =?utf-8?B?NzZvMVlWMHBRck1NQXd1cUpYbHh3YUFZaDlQS3NKNnhxYmlFSTFWcXVDcGlq?=
 =?utf-8?Q?ypKvx1NI5KGjTZzN7MhmYQ0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e52bca-2795-478e-5337-08d9b31c4a08
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 09:40:33.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhhDfwImMGOZqbQ+CCiWaEJCaOyARz9D/lagnukQycOoixf5Pn0MrZHeMu36y9o3KIX4TmY7oavwaICo8CCI6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5581
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ben,

Thanks for your patch! Perhaps something to improve:

[auto build test WARNING on 53989fad1286e652ea3655ae3367ba698da8d2ff]

url:    https://github.com/0day-ci/linux/commits/Ben-Widawsky/Add-drivers-for-CXL-ports-and-mem-devices/20211120-080513
base:   53989fad1286e652ea3655ae3367ba698da8d2ff
config: x86_64-randconfig-c007-20211118 (https://download.01.org/0day-ci/archive/20211128/202111280254.IoqCZcvv-lkp@intel.com/config)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://github.com/0day-ci/linux/commit/cfdf51e15fc8229a494ee59d05bc7459ab5eecd8
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review Ben-Widawsky/Add-drivers-for-CXL-ports-and-mem-devices/20211120-080513
         git checkout cfdf51e15fc8229a494ee59d05bc7459ab5eecd8
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/cxl/pci.c:483:3: warning: Value stored to 'size' is never read [clang-analyzer-deadcode.DeadStores]
                    size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
                    ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/size +483 drivers/cxl/pci.c

1d5a4159074bde Ben Widawsky 2021-04-07  454
cfdf51e15fc822 Ben Widawsky 2021-11-19  455  #define CDPD(cxlds, which)                                                     \
cfdf51e15fc822 Ben Widawsky 2021-11-19  456  	cxlds->device_dvsec + CXL_DVSEC_PCIE_DEVICE_##which##_OFFSET
cfdf51e15fc822 Ben Widawsky 2021-11-19  457
cfdf51e15fc822 Ben Widawsky 2021-11-19  458  #define CDPDR(cxlds, which, sorb, lohi)                                        \
cfdf51e15fc822 Ben Widawsky 2021-11-19  459  	cxlds->device_dvsec +                                                  \
cfdf51e15fc822 Ben Widawsky 2021-11-19  460  		CXL_DVSEC_PCIE_DEVICE_RANGE_##sorb##_##lohi##_OFFSET(which)
cfdf51e15fc822 Ben Widawsky 2021-11-19  461
cfdf51e15fc822 Ben Widawsky 2021-11-19  462  static int wait_for_valid(struct cxl_dev_state *cxlds)
cfdf51e15fc822 Ben Widawsky 2021-11-19  463  {
cfdf51e15fc822 Ben Widawsky 2021-11-19  464  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
cfdf51e15fc822 Ben Widawsky 2021-11-19  465  	const unsigned long timeout = jiffies + HZ;
cfdf51e15fc822 Ben Widawsky 2021-11-19  466  	bool valid;
cfdf51e15fc822 Ben Widawsky 2021-11-19  467
cfdf51e15fc822 Ben Widawsky 2021-11-19  468  	do {
cfdf51e15fc822 Ben Widawsky 2021-11-19  469  		u64 size;
cfdf51e15fc822 Ben Widawsky 2021-11-19  470  		u32 temp;
cfdf51e15fc822 Ben Widawsky 2021-11-19  471  		int rc;
cfdf51e15fc822 Ben Widawsky 2021-11-19  472
cfdf51e15fc822 Ben Widawsky 2021-11-19  473  		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, HIGH),
cfdf51e15fc822 Ben Widawsky 2021-11-19  474  					   &temp);
cfdf51e15fc822 Ben Widawsky 2021-11-19  475  		if (rc)
cfdf51e15fc822 Ben Widawsky 2021-11-19  476  			return -ENXIO;
cfdf51e15fc822 Ben Widawsky 2021-11-19  477  		size = (u64)temp << 32;
cfdf51e15fc822 Ben Widawsky 2021-11-19  478
cfdf51e15fc822 Ben Widawsky 2021-11-19  479  		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, LOW),
cfdf51e15fc822 Ben Widawsky 2021-11-19  480  					   &temp);
cfdf51e15fc822 Ben Widawsky 2021-11-19  481  		if (rc)
cfdf51e15fc822 Ben Widawsky 2021-11-19  482  			return -ENXIO;
cfdf51e15fc822 Ben Widawsky 2021-11-19 @483  		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
cfdf51e15fc822 Ben Widawsky 2021-11-19  484
cfdf51e15fc822 Ben Widawsky 2021-11-19  485  		/*
cfdf51e15fc822 Ben Widawsky 2021-11-19  486  		 * Memory_Info_Valid: When set, indicates that the CXL Range 1
cfdf51e15fc822 Ben Widawsky 2021-11-19  487  		 * Size high and Size Low registers are valid. Must be set
cfdf51e15fc822 Ben Widawsky 2021-11-19  488  		 * within 1 second of deassertion of reset to CXL device.
cfdf51e15fc822 Ben Widawsky 2021-11-19  489  		 */
cfdf51e15fc822 Ben Widawsky 2021-11-19  490  		valid = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_INFO_VALID, temp);
cfdf51e15fc822 Ben Widawsky 2021-11-19  491  		if (valid)
cfdf51e15fc822 Ben Widawsky 2021-11-19  492  			break;
cfdf51e15fc822 Ben Widawsky 2021-11-19  493  		cpu_relax();
cfdf51e15fc822 Ben Widawsky 2021-11-19  494  	} while (!time_after(jiffies, timeout));
cfdf51e15fc822 Ben Widawsky 2021-11-19  495
cfdf51e15fc822 Ben Widawsky 2021-11-19  496  	return valid ? 0 : -ETIMEDOUT;
cfdf51e15fc822 Ben Widawsky 2021-11-19  497  }
cfdf51e15fc822 Ben Widawsky 2021-11-19  498

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
