Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCC77EF2B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 04:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbjHQCm3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 22:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347661AbjHQCmX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 22:42:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9484E40;
        Wed, 16 Aug 2023 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692240141; x=1723776141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b0hvnRtj7c2uqp+h9qOvxBa7aFoPHQTQcLU68J0GbGQ=;
  b=L5pchrA/XxPS//Q5XYklXcb5ae4+3k9SkGrCDkKoZMFuCBkU7Y/C+l0S
   G816rSGESu8yUFalX+7tcsCApKeGICPMfJHUq+gp24gYqJYwQ7ehOHxVU
   Wuew5y8chmOGvkAnCqkubb/uzb9DpdiTIkhrEDGjyJ5l6kF2M+samfAGW
   GNTo4opKPqVZjbqdUVdyVH1QnqD18OLPctHjOwfy/v6vVXHBKvWrzmkW+
   vwXRL7C1GOMGFfmmGBDtg20v5vKGB0yMj7DffKToABqALYtWdOZ7QnMi1
   JR8bRxVha4RtaJi9ksRm6/eLgBCC5b1QUwodhM+cFn+YUsDYCCuvWbBSU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439048682"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="439048682"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 19:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734481454"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="734481454"
Received: from gokunbor-mobl1.amr.corp.intel.com (HELO [10.255.229.16]) ([10.255.229.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 19:42:19 -0700
Message-ID: <404044b2-8e7a-4420-9c10-b2ca75d7e3aa@linux.intel.com>
Date:   Wed, 16 Aug 2023 19:42:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] ACPI: x86: s2idle: Post-increment variables when
 getting constraints
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
 <20230816204143.66281-4-mario.limonciello@amd.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230816204143.66281-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/16/2023 1:41 PM, Mario Limonciello wrote:
> There is no reason for the variables to be pre-incremented.
> No intended functional changes.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

I think you need to explain bit more in commit log.  Otherwise, looks good.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/acpi/x86/s2idle.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index ce62e61a9605e..7711dde68947f 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -123,13 +123,13 @@ static void lpi_device_get_constraints_amd(void)
>   			acpi_handle_debug(lps0_device_handle,
>   					  "LPI: constraints list begin:\n");
>   
> -			for (j = 0; j < package->package.count; ++j) {
> +			for (j = 0; j < package->package.count; j++) {
>   				union acpi_object *info_obj = &package->package.elements[j];
>   				struct lpi_device_constraint_amd dev_info = {};
>   				struct lpi_constraints *list;
>   				acpi_status status;
>   
> -				for (k = 0; k < info_obj->package.count; ++k) {
> +				for (k = 0; k < info_obj->package.count; k++) {
>   					union acpi_object *obj = &info_obj->package.elements[k];
>   
>   					list = &lpi_constraints_table[lpi_constraints_table_size];
> @@ -214,7 +214,7 @@ static void lpi_device_get_constraints(void)
>   		if (!package)
>   			continue;
>   
> -		for (j = 0; j < package->package.count; ++j) {
> +		for (j = 0; j < package->package.count; j++) {
>   			union acpi_object *element =
>   					&(package->package.elements[j]);
>   
> @@ -246,7 +246,7 @@ static void lpi_device_get_constraints(void)
>   
>   		constraint->min_dstate = -1;
>   
> -		for (j = 0; j < package_count; ++j) {
> +		for (j = 0; j < package_count; j++) {
>   			union acpi_object *info_obj = &info.package[j];
>   			union acpi_object *cnstr_pkg;
>   			union acpi_object *obj;
