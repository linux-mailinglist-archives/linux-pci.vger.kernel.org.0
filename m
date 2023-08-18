Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9B780DDC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377314AbjHROUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377481AbjHROT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 10:19:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4AA3AAC;
        Fri, 18 Aug 2023 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692368394; x=1723904394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6t+2wqAcIleaGbYchZEYFST4Lvi86RbDwXOifd8hTFU=;
  b=CgYnSPMbMfVIb6P1sH0Y4f3sHl+saJLfOmGxHnqKKGhQrqN0IMFhzOkm
   1oWCMrnPUl15sk3MeVYH66D890gcbueM+Lxfvv5EMO24YzcXNMG6zJrC7
   lCNmBB2MRDbpsPlYIedlL2BRxnxj6TY6DQsbOVCrIjwMl2IGWuhbZTppD
   sjdN8fQMRSIL2bbbP+UGVG4J90IJEhBl/wd9IkSPii1CHmC2QR6u4trlN
   drPipUofmzHvSXoqB6gq6PYs+X/BnF9gBwC4smr1ZuVK/Qjta0syeSG16
   Q3ImUA+YpWcYLNmNKh1hkPtWycofVPh/fOby0D1fI6ATe/0d+xumbonTa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="372011627"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="372011627"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 07:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="684903682"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="684903682"
Received: from bcottam-mobl1.amr.corp.intel.com (HELO [10.252.133.219]) ([10.252.133.219])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 07:19:53 -0700
Message-ID: <c752ce85-13e2-44d3-8729-4ce296572069@linux.intel.com>
Date:   Fri, 18 Aug 2023 07:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        stable@vger.kernel.org
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-2-mario.limonciello@amd.com>
Content-Language: en-US
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230818051319.551-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/17/2023 10:13 PM, Mario Limonciello wrote:
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
> 
> Iain reports that USB devices can't be used to wake a Lenovo Z13
> from suspend. This is because the PCIe root port has been put
> into D3 and AMD's platform can't handle USB devices waking in this
> case.
> 
> This behavior is only reported on Linux. Comparing the behavior
> on Windows and Linux, Windows doesn't put the root ports into D3.
> 
> To fix the issue without regressing existing Intel systems,
> limit the >=2015 check to only apply to Intel PCIe ports.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Looks good to me.

Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> v12->v13:
>  * New patch
> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0c..051e88ee64c63 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3037,10 +3037,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return false;
>  
>  		/*
> -		 * It should be safe to put PCIe ports from 2015 or newer
> +		 * It is safe to put Intel PCIe ports from 2015 or newer
>  		 * to D3.
>  		 */
> -		if (dmi_get_bios_year() >= 2015)
> +		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +		    dmi_get_bios_year() >= 2015)
>  			return true;
>  		break;
>  	}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
