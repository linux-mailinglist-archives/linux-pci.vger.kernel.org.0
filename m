Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F477ED3E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbjHPWhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346882AbjHPWgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:36:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEAC1B2;
        Wed, 16 Aug 2023 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692225407; x=1723761407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l1mTJmkp/kRwh+y4bLd5HMMSqSBCJpk7nRJ+5MwFhoU=;
  b=CE2/7hdUwRnfQHYn0FnREXd6MK7aWpgmXiptCQItfhHpjOhujv4NANk7
   mB1uzUOMyQ8ZeaGE6LunJ82aYt6Fglvi4bMrthDlE0OZbCNI/K/mvMm4L
   sF9/+jbOuPy7XSuJTGuJctHw2ydYlly7ssmk+2v/P6GC0A7l0LXjVMj6r
   61T43WPU3gV0Pl7YuNKasYQW4ODZI09n4OgJRJFudzGJOvyGIE/Yyp++q
   mdoiCUNCDuvqLU9PEPRT2ZPXMX8GoTm27EDccVWwIpXESJ9iO7U2jSYOw
   chPCD6mzrIr60NOVjKmc77qNQ2vfp+O42sT0e+tJJejJzkJ282iRuROvN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375422278"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="375422278"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 15:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908162810"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="908162810"
Received: from gokunbor-mobl1.amr.corp.intel.com (HELO [10.255.229.16]) ([10.255.229.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 15:36:46 -0700
Message-ID: <fd7b559d-4a3a-4938-937b-bfcd5a7b315b@linux.intel.com>
Date:   Wed, 16 Aug 2023 15:36:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/9] ACPI: Add comments to clarify some #ifdef
 statements
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230816204143.66281-1-mario.limonciello@amd.com>
 <20230816204143.66281-2-mario.limonciello@amd.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230816204143.66281-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/16/2023 1:41 PM, Mario Limonciello wrote:
> With nested #ifdef statements it's sometimes difficult to tell
> which code goes with which statement.  One comment was wrong,
> so fix it and add another comment to clarify another.

I would explain what is wrong clearly in the commit log. I see this file has
many #ifdefs without comments. Do you want to fix them all?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v9->v10:
>   * no changes
> ---
>   include/linux/acpi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 641dc48439873..0d5277b7c6323 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1117,10 +1117,10 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
>   					  size_t size)
>   {
>   }
> -#endif /* CONFIG_X86 */
> +#endif /* CONFIG_IA64 */
>   #else
>   #define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
> -#endif
> +#endif /* CONFIG_ACPI */
>   
>   #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
>   int acpi_dev_suspend(struct device *dev, bool wakeup);
