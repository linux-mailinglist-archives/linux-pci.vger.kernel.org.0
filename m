Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89E161448E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 07:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKAGOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAGOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 02:14:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21912088;
        Mon, 31 Oct 2022 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667283270; x=1698819270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5zV37gjuf3zPHJxzwRwN4FjtyOGU0XzuSeOkPDRAlHg=;
  b=CxGQvBz0swmEWxtD4c1gb2JSzAJ+O3HOFyUdpAiwvKtPtENzDBJjmP3J
   lKjG+cY8AfDPgrgG8EWY5g3J0ADgHA6Ii15uqV8HSEjptHRL4fim8Kv5B
   Obl7AqGVpbIYzMMcGLM02SyjEA4kRe8dKr/8VdoGv3zhW2HqHsMDh3XX0
   d2TUXz6Hl1+SFMemHo5d09OdQliVlAPkBz4ByF3KnUy9Z/76fdWZvUaYi
   J2NsE+5PcX2bkApGRSZQ61/+7HckhMY47M/61urblQWWwOsEdDH1pEgi6
   LgHhiAQnnkUs0SBjvEB26ARp+F8d/Fqh11LaGtsTi/HW8sSXwxQlfMCAL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="288788445"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="288788445"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 23:14:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="723066342"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="723066342"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2022 23:14:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 23:14:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 23:14:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 23:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbhKG5SZm0bMiyTjuw2+3379dcxxD0NpJwMT3gUK8O5RTvDRKWU1wSIEEfofVZs9ia5IGvI6valn66j+yRBViJFUySHxN8fb0l3uJpK9MbSp6mZJ1+Qod1NPAj7gR9M2voY8JuywBoh337dmfsYNl8BiqteZaulQKC0+cv0/rvkBzZJD3UQ4RGm++7rIwvUBHwNLNNtXgZmC3y05WK6ahfO0bEbqb9eVEudcYWzukBRq8dl5gOOw14sy4QdDhac/8ZrmX1mPl+lbcvPAovIprtzT9+tLi6iLlsL1pnyNJKl0WzyHdGPytk0Lb4lKpMhU6nJhBfqJ8uovJYjgpwmzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zyYBBfw1VLIZPqn+Teb/ehdoK6jnvKyNRCggQ3d/ck=;
 b=VhSJriFPzGcLAixtflnZGabWYqr+EE4369s2xMMj2R+g914X0PZG0WzvLiVdPbwuVXspisLzn/oq3qsCHEfF6B4doxthVqyMGmif9kLBWcC0UttESxdmPSbRX+MdlEJj21CttSHsIZH3PH1mf85OH186LyYYy7dK5ahXWo6B/T3UntCrkVv9b3DEI0BlvE/iZmVtmDB8rFohQF4FEwASuQP17EdnzScry34GyAPGMyYWgT05cZT2Wjq4cZeuMOhaGUZRUx2weipajg6U5urOn+HsfrUD00WQZlawspDRiMUYtV3T+66i2ioGK+tFB5rwKR7r7UTmCbM+ZsKZbw/mZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Tue, 1 Nov
 2022 06:14:19 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::91c7:649d:3f24:3d15]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::91c7:649d:3f24:3d15%5]) with mapi id 15.20.5769.015; Tue, 1 Nov 2022
 06:14:17 +0000
Message-ID: <74063430-66c0-901e-68e7-574504bafd24@intel.com>
Date:   Tue, 1 Nov 2022 14:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/5] ACPI/APEI: Add apei_hest_parse_aer()
Content-Language: en-US
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <robert.moore@intel.com>, <ying.huang@intel.com>,
        <rdunlap@infradead.org>, <bhelgaas@google.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devel@acpica.org>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>
References: <20221027031518.2855743-1-LeoLiu-oc@zhaoxin.com>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20221027031518.2855743-1-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: a48ba291-cd4f-4fdd-46f7-08dabbd04eb6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhSox4u2FNP2PruwuhKnim0HwR1Qxjp8zpGzDxee7k3V8GAS3i9B0eJWqyfdfuk9px80gXk9YEkAMQr/1Nyw+V+LbRKIR0kaEJ+izoXUE9QZ29kjBkRJLg2U3y6dJIsoP7Teun8kIgRxVkdo6mtDclRthDeMoPj+7N6knLE0B7icC1NSeAcmpuB1G6qr8SCwekZJua9ZoniZH5GqGizLGPWgxrE9pIbBpC+6AkwIMo5gGK+pRfBYT5w/wv6aZTI/kfK5AMYBNYqAFazfr4LR45tbvl82p1X+Hzo5lkP2Qdmeo8GoEIAqpy3AdutYDp9emCX9pU2HneqZ5vAoocaK0d1J8oS37/rmzr15yVJ3CNtCGZ6/ZRIzInVXeaE9grUkPSBoWdAjXl22xHJ+lTkhqrR1GgCFLSVk0EhMTcm4Ikdtpw/xuwTZfEeijKlxvUQg2ZQnrxc3RppU0CMl12K2tsH9icFoWdkICD7ADE/y3wmSpfwRZ0KRqO0M3v/xk8wDHOGEnYEG/4M9eRiKJN+FHgk1F5+rJoeNT+i0iDb5d1c2MSM8Aity9/G5XJhk9xeCUMclxEd12YsRuvD5r8u5Z1MPtDfWJG1sCVdZUO0o+VKO0XPjUJQQqx9EW0sH80Fa6Xsj1eDLHdBpQMiKRSdXZFa7vK17knLfohv7ea7j8tmsN9W7ix/Kiruwa/NiscKlOmo9ZjAld9PGf+km8cBVS6vf4vGwWdHHtyY9nPAfGC+/v2Hl9RiKBbmcdiiokhqTL6ibTa1w96KIYomOgZB+5kkvHaDF8b2IphaUye/lhP/w8Vq4Ycp1HAzMVKC2s6Xq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(82960400001)(38100700002)(921005)(36756003)(31696002)(86362001)(6486002)(2906002)(6666004)(66476007)(66556008)(478600001)(8936002)(7416002)(66946007)(41300700001)(5660300002)(8676002)(26005)(6512007)(6506007)(186003)(316002)(2616005)(4326008)(36916002)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjBHbEVzTmNHeSt2V2JMVkhkb3pJWHM2RVVNK0szcjBsNTZzN3h2ZUtwdE01?=
 =?utf-8?B?d0dsRjlTUSsyU2xQY0lHdXRncXRWMG91ODE2L0laWStwdHM2STZKU1psSWxD?=
 =?utf-8?B?bGNDeEtsampzS1ViSlR6OE91OVdkUm5Td2hGdllTcE5sTDRGbzgyK291U0FS?=
 =?utf-8?B?SHhzS2FKRzVsM3l0WjFib1RWVUJtOHZHZmNPczZ3OGVWM2xWNVdCTDU2UXoz?=
 =?utf-8?B?VHlkNWp3Wnlvc0ZZclJaZlo2V0VtendNc0RqcWQzWGcrQUh6QkdXcjZUclVp?=
 =?utf-8?B?WFhQSzlGdXR0OHRXNFVodHEwY1JBTmloZSs4Z1pFTmMyM0syLzl4MnNpR3la?=
 =?utf-8?B?VWpPbHBicjNLSDZZZGJiM1oyTGhmeVEzMG04ZE5FVktOVDRtRXAvclJScnZH?=
 =?utf-8?B?TlZYM2Y2WVpsbGlYY1pGYUh4UXc2NVBwS2lxcVpod0NBYmVRVmYyZUZnYjhz?=
 =?utf-8?B?cWQ0RTJFa0pKenQ3L0xkM1ZPWkRDbFI2cHhBalBkcDN4V1RTdE4zUVVpVTMz?=
 =?utf-8?B?Yld0c3FtcTl5Z01PdGVPayt6NnlNYmZoZ3A1S0RhektIa040ZnBTNUNiZzFq?=
 =?utf-8?B?VDYzRXBwNlFFcEZZeWNESXk2TXdFQVN3bzBhd2RNZnJneFE5WGZhbE1LOTVK?=
 =?utf-8?B?M01Kb3Y4bHFXcUt1YktNYkhoZFIxdEM0NzlFSjNLQzU4TjJGb1orZmtHTzhi?=
 =?utf-8?B?SnNXTFAwMGhzQ3l6TDFUa0xUUW1ZKytWY0JpbDNqbVdKaXRpWFRWOENONWxa?=
 =?utf-8?B?TUl2emFyVXVmVEdrb2Z4Umh1SFRCRldTRzdoSkliQ29zYzlwY0ozbDExcHBE?=
 =?utf-8?B?QmQ3cEd0K0xEMVJ2bERhVWdJMEhkQU5sMHNTVGl5N1BlbktIN2RjdzllTU95?=
 =?utf-8?B?ZmJCd1lpcEZDS0lMaTRHeHQ5bE5IUGg1cVoxOFQxakNSMFh6THZBcEpuNHE2?=
 =?utf-8?B?RjBnR2F4WGFINExxY0swWDFQNVl5d2krTWhRdXpDbEhrc3lzQmtmVmlDTVly?=
 =?utf-8?B?WWg3cmtobTlVVDRFWVVsRzJ0SnVKSHU4ZHNoUDlPL3VGekhCK0tWcWp5cDBq?=
 =?utf-8?B?RG5JVmsycHA5N0xLRnJjRUhYdWxYTmFaZERWSW9BUHFyNnNhTXRycDVLUVpl?=
 =?utf-8?B?Uk00Z2luSDlnS1RTTWRMTzJxYnRCa0R6RG9uMnNHWUtEbEg3SUJWL1c3RnpG?=
 =?utf-8?B?clJQa1BVSHlNZndnU054cU8wMy8rcmx3Z1F2R0NFTE1QSTRDM2FKUTFKNDZk?=
 =?utf-8?B?ZEprQm56L3dONnU3OVNpQmxxaUxTU0pqQTVZcHVadlh4NWxubmtBWEQrZlZk?=
 =?utf-8?B?dVFzbklxdC9vK01ZVFpzSzVSYnQ1THl1bGJ1cGQxSVhhTERTQ0NYa1hleCsr?=
 =?utf-8?B?OXB6Mm4vYXpkaUg3YUZYRlc2ZEJpTVFPZzdjOEdQOHd5MW1KanhjcS95MWoz?=
 =?utf-8?B?TDNRdTRreVpWckV2ZEtQalA4NUZVZkx4UUlxUHdaU3JJYStyK0tJY2NrSmpX?=
 =?utf-8?B?Tnd5blJZM3JSeUt2bTQzYmtRVzkvZmVTVFZwSkh0djE4R2s2VU0yRVAwSlJ5?=
 =?utf-8?B?K1h3VHpLUktRMjVyS0ZINWNoWGFMeTBqZ3hQTlFVbzU2SU9lbUNRY3daSmd1?=
 =?utf-8?B?VlpCMVhEVUVLRCtROHZGRTFNUUFzSmtBcVJZV1NNWTMzRkV6cGZSYjhWYXh5?=
 =?utf-8?B?Z2NGUzlzaEk1dlhqRjREM0VEYzVmNkZ0eTNIWlBpVnpYSjNMUTgvREZNOWNi?=
 =?utf-8?B?clpSdHk1RHkrMmI4Sjk0TnNQbE1NSE9aVFZPZ2EzSUtOQWNtYTVBV1kxYXFa?=
 =?utf-8?B?amtDSXVRanZzWlI0YWxCaEM0dUFxVGkyTmE1Wk5YM3IwSTZRanh5OVd4eGlX?=
 =?utf-8?B?WWZlNHJ3aHdHQXEwSmorQXdINUV5eFNsN2s5c0thVUp3VVFzbFhjNjgyUHpo?=
 =?utf-8?B?WGZHK21tSEhodkl1SEFBbm5UOEFXUVRnbDA3R3I0eE9FN2E2cVRScHZkQ0F5?=
 =?utf-8?B?VW91Q2NmNW55RzhpZ3lPZ1pwdnRvUENGdnYrbzJ6MldyRWJuZWZ3UzJLalVB?=
 =?utf-8?B?Vm83dm5hODFob2JwRHI3d25jY3ZsN2tGaG9sai9MS3ZwTURUaDdQYkF6Qlor?=
 =?utf-8?Q?Yt1SVd0Svi/QRGO6W+Cs9KKi9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ba291-cd4f-4fdd-46f7-08dabbd04eb6
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 06:14:17.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CryLyysbwT4XUkKLx02PcURYcajybXxGzggIauGY1CZTlVdNTYaB2f5dgqAuiHdS7ud0iCmRY8n0OHpko1sa+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/27/2022 11:15 AM, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> apei_hest_parse_aer() is used to parse and record the PCI Express AER
> Structure in the HEST Table.
> 
> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/acpi/apei/hest.c | 119 ++++++++++++++++++++++++++++++++++++++-
>  include/acpi/actbl1.h    |  69 +++++++++++++++++++++++
>  include/acpi/apei.h      |   7 +++
>  3 files changed, 194 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..0bfdc18758f5 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> +#include <linux/pci.h>
>  
>  #include "apei-internal.h"
>  
> @@ -86,7 +87,48 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  	return len;
>  };
>  
> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +static inline bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
> +{
> +	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
> +		hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
> +		hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
> +		return true;
> +	return false;
> +}
> +
> +static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
> +				struct pci_dev *dev)
> +{
> +	u16 hest_type = hest_hdr->type;
> +	u8 pcie_type = pci_pcie_type(dev);
> +
> +	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
> +		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
> +		(hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
> +		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
> +		(hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
> +		(pcie_type == PCI_EXP_TYPE_PCI_BRIDGE || pcie_type == PCI_EXP_TYPE_PCIE_BRIDGE)))
> +		return true;
> +	return false;
> +}
> +
> +static inline bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
> +		struct pci_dev *pci)
> +{
> +	return	ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
> +			ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
> +			p->device                 == PCI_SLOT(pci->devfn) &&
> +			p->function               == PCI_FUNC(pci->devfn);
> +}
> +
> +static inline bool hest_match_pci(struct acpi_hest_header *hest_hdr,
> +		struct acpi_hest_aer_common *p, struct pci_dev *pci)
> +{
> +	if (hest_match_type(hest_hdr, pci))
> +		return(hest_match_pci_devfn(p, pci));
> +	else
> +		return false;
> +}
>  
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
>  {
> @@ -124,6 +166,81 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>  	return 0;
>  }
>  
> +/*
> + * apei_hest_parse_aer - Find the AER structure in the HEST Table and
> + * match it with the PCI device.
> + *
> + * @hest_hdr: To save the acpi aer error source in hest table
> + *
> + * Return 1 if the pci dev matched with the acpi aer error source in
> + * hest table, else return 0.
> + */
> +int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +	struct acpi_hest_parse_aer_info *info = data;
> +	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint = NULL;
> +	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port = NULL;
> +	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge = NULL;
> +
> +	if (!hest_source_is_pcie_aer(hest_hdr))
> +		return 0;
> +
> +	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT) {
> +		acpi_hest_aer_root_port = (struct acpi_hest_aer_root_port *)(hest_hdr + 1);
> +		if (acpi_hest_aer_root_port->flags & ACPI_HEST_GLOBAL) {
> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
> +				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		} else {
> +			if (hest_match_pci(hest_hdr,
> +					(struct acpi_hest_aer_common *)acpi_hest_aer_root_port,
> +					info->pci_dev)) {
> +				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		}
> +	} else if (hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT) {
> +		acpi_hest_aer_endpoint = (struct acpi_hest_aer_endpoint *)(hest_hdr + 1);
> +		if (acpi_hest_aer_endpoint->flags & ACPI_HEST_GLOBAL) {
> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
> +				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		} else {
> +			if (hest_match_pci(hest_hdr,
> +					(struct acpi_hest_aer_common *)acpi_hest_aer_endpoint,
> +					info->pci_dev)) {
> +				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		}
> +	} else if (hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE) {
> +		acpi_hest_aer_for_bridge =
> +			(struct acpi_hest_aer_for_bridge *)(hest_hdr + 1);
> +		if (acpi_hest_aer_for_bridge->flags & ACPI_HEST_GLOBAL) {
> +			if (hest_match_type(hest_hdr, info->pci_dev)) {
> +				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		} else {
> +			if (hest_match_pci(hest_hdr,
> +					(struct acpi_hest_aer_common *)acpi_hest_aer_for_bridge,
> +					info->pci_dev)) {
> +				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
> +				info->hest_matched_with_dev = 1;
> +			} else
> +				info->hest_matched_with_dev = 0;
> +		}
> +	}
> +	return info->hest_matched_with_dev;
> +}
Hi Leo,

What do you think of that we could use a switch structure to instead these hest_source_is_pcie_aer() and if-else.

thanks
Ming

> +
>  /*
>   * Check if firmware advertises firmware first mode. We need FF bit to be set
>   * along with a set of MC banks which work in FF mode.
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..7f52035512b2 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1385,6 +1385,75 @@ struct acpi_hest_aer_bridge {
>  	u32 advanced_capabilities2;
>  };
>  
> +struct acpi_hest_parse_aer_info {
> +	struct pci_dev *pci_dev;
> +	int hest_matched_with_dev;
> +	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint;
> +	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port;
> +	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge;
> +};
> +
> +/* HEST Sub-structure for PCIE EndPoint Structure (6) */
> +
> +struct acpi_hest_aer_root_port {
> +	u16 reserved1;
> +	u8 flags;
> +	u8 enabled;
> +	u32 records_to_preallocate;
> +	u32 max_sections_per_record;
> +	u32 bus;		/* Bus and Segment numbers */
> +	u16 device;
> +	u16 function;
> +	u16 device_control;
> +	u16 reserved2;
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +	u32 root_error_command;
> +};
> +
> +/* HEST Sub-structure for PCIE EndPoint Structure (7) */
> +
> +struct acpi_hest_aer_endpoint {
> +	u16 reserved1;
> +	u8 flags;
> +	u8 enabled;
> +	u32 records_to_preallocate;
> +	u32 max_sections_per_record;
> +	u32 bus;		/* Bus and Segment numbers */
> +	u16 device;
> +	u16 function;
> +	u16 device_control;
> +	u16 reserved2;
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +};
> +
> +/* HEST Sub-structure for PCIE/PCI Bridge Structure (8) */
> +
> +struct acpi_hest_aer_for_bridge {
> +	u16 reserved1;
> +	u8 flags;
> +	u8 enabled;
> +	u32 records_to_preallocate;
> +	u32 max_sections_per_record;
> +	u32 bus;
> +	u16 device;
> +	u16 function;
> +	u16 device_control;
> +	u16 reserved2;
> +	u32 uncorrectable_mask;
> +	u32 uncorrectable_severity;
> +	u32 correctable_mask;
> +	u32 advanced_capabilities;
> +	u32 uncorrectable_mask2;
> +	u32 uncorrectable_severity2;
> +	u32 advanced_capabilities2;
> +};
> +
>  /* 9: Generic Hardware Error Source */
>  
>  struct acpi_hest_generic {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524..8a0b2b9edbaf 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -33,10 +33,17 @@ void __init acpi_ghes_init(void);
>  static inline void acpi_ghes_init(void) { }
>  #endif
>  
> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
> +
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> +int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
>  #else
>  static inline void acpi_hest_init(void) { }
> +static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  int erst_write(const struct cper_record_header *record);
