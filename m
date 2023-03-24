Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F86C83D2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 18:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCXRzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjCXRzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 13:55:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D019681;
        Fri, 24 Mar 2023 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679680476; x=1711216476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wlFhDNeen738iaHwrEF8/B3x9yROQYaB9OzQKIbfUBA=;
  b=VHSt0U31n6FI7VHXRbZsns9e/1bDD4ucocWbNTGadVgbM0RA12vhcj4b
   YX66pWSGl8w6L3LLN2c+VhgSzLmT76vgjJ8yrpUHGC0uc0oj7pfJU3W0D
   ZpWR6L/tJy9gKw4TTjKGTVuGXBY5J07PiqN7023bHd3W8jK69b9kc2OT5
   WlqHVjP7/lM3syPAk0s/nrrCgP37baywtZG0YwvwvdNU63VrvMiKwV2dg
   Ik63w/wF3q302+4YU5TgK8K4YIs9c6s3D9e0Ly/j61LiT7+eOQr5b35AI
   66hS9AODm22DHdodtts74tRQHG+R2nqtrC7O3xk4FZ0p2eGiTpW0GvCVs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="337348113"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="337348113"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 10:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="682766254"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="682766254"
Received: from bahessel-mobl.amr.corp.intel.com (HELO [10.209.94.88]) ([10.209.94.88])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 10:53:16 -0700
Message-ID: <4931b27f-08ba-dc4e-ed65-6eb58e340f08@linux.intel.com>
Date:   Fri, 24 Mar 2023 10:53:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Any comments on this patch?

On 3/15/23 4:54 PM, Kuppuswamy Sathyanarayanan wrote:
> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
> OS owns AER") adds support to clear error status in the Device Status
> Register(DEVSTA) only if OS owns the AER support. But this change
> breaks the requirement of the EDR feature which requires OS to cleanup
> the error registers even if firmware owns the control of AER support.
> 
> More details about this requirement can be found in PCIe Firmware
> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
> If the OS supports the Error Disconnect Recover (EDR) feature and
> firmware sends the EDR event, then during the EDR recovery window, OS
> is responsible for the device error recovery and holds the ownership of
> the following error registers.
> 
> • Device Status Register
> • Uncorrectable Error Status Register
> • Correctable Error Status Register
> • Root Error Status Register
> • RP PIO Status Register
> 
> So call pcie_clear_device_status() in edr_handle_event() if the error
> recovery is successful.
> 
> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v1:
>  * Rebased on top of v6.3-rc1.
>  * Fixed a typo in pcie_clear_device_status().
> 
>  drivers/pci/pcie/edr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b479b97a..87734e4c3c20 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  	 */
>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>  		pci_dbg(edev, "DPC port successfully recovered\n");
> +		pcie_clear_device_status(edev);
>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
>  	} else {
>  		pci_dbg(edev, "DPC port recovery failed\n");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
