Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E74D4414
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 10:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiCJJ7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 04:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCJJ7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 04:59:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3480F94DB
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646906304; x=1678442304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXLE0VNpdfwl4ckIdvfJ729llKp52AAOXcdFCoL8WVE=;
  b=BFwVBPNjfyQdaxilsFKAoMqbgkKen208/2zZYKBAa+HfMHUUicbbp3Y/
   QVYJz5cfK2CSRGhxIVQvfauYzoh17MvPYIS29ae9OifB5KicWoT2WKwHI
   mGE/QqYSa2Uqs7tAjWiVI7oUCT3gLxFz3Vbw/8OxoH8Lgkn3W6jDxZpbc
   qMwkmnXbzjWKXvjVJrPBEYmK3LwJPEzeoRokSCX1sUevLUoZSBNJn56MK
   ZRtgm9MKxDMN2W5sXglwB5J768iX8OrcF+OE+fNcBlsThP826bv/yZ1W+
   CNcf6lMOsHDc+QOU+f21EvigzhaEIQmOmda4YM+omYnb5BkGzltm2VL5J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255400349"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="255400349"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 01:58:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="510834816"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 01:57:13 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 10 Mar 2022 11:56:06 +0200
Date:   Thu, 10 Mar 2022 11:56:06 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Sanju.Mehta@amd.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Message-ID: <YinLNvaH7+yv88QX@lahna>
References: <20220309224302.2625343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309224302.2625343-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Rafael

On Wed, Mar 09, 2022 at 04:43:02PM -0600, Mario Limonciello wrote:
> The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
> bridge to be able to wakeup from D3.
> 
> This however is static information in the ACPI table at BIOS compilation
> time and on some platforms it's possible to configure the firmware at boot
> up such that `_S0W` will not return "0" indicating the inability to wake
> up the system from D3.

Ideally the BIOS should not allow this to happen in the first place but
yeah we've seen all kinds of weird behaviour in the past so just need
to deal with it :/

I wonder if it makes sense to log this situation?

> To fix these situations explicitly check that the ACPI device claims the
> system can be awoken in `acpi_pci_bridge_d3`.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/pci/pci-acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..9f8f55ed09d9 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	if (!adev)
>  		return false;
>  
> +	if (!adev->wakeup.flags.valid)
> +		return false;
> +
>  	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>  				   ACPI_TYPE_INTEGER, &obj) < 0)
>  		return false;
> -- 
> 2.34.1
