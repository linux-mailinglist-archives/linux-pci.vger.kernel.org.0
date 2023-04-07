Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6927B6DB670
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDGWZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDGWZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 18:25:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1BAD0A;
        Fri,  7 Apr 2023 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680906318; x=1712442318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UdvXQ75I/R9Zf31H9+8pVsLjueazsxmKA7kvddj7SM0=;
  b=f6tZ39V0rQ70454J4ES4X3MPXMjbT+DVyiHyI6/EpHDPosNQkP8tGjOQ
   YPvPIrMwz0YsKLt88xNPbZjoSowA0x8b1CaIG2j07r+uArAodxZiL78ne
   rbsRkk2vmRv9KFBgeidzyIXXHOKyLQYsbHqtJ8OyRpUpNjLgl+mA71WVx
   oxc4PtmCUVC53q9eBdnaJDvRnKxQILIWTdXTGYXc8kDsYYYjOc9RdQHSq
   stJg47FMgjv33mTAt8LXDMMxEk0osqJ9kpSZTukC2Eawnu8n8D3JlvoQX
   Fj9Qc1y+0AMXQ/CZbt/8GWlrjxqAzebMLPMv0HMKCNeosRTvIUB5CD9Ka
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="370914187"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="370914187"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="756852854"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="756852854"
Received: from ssingh6-mobl2.amr.corp.intel.com (HELO [10.212.218.166]) ([10.212.218.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:25:17 -0700
Message-ID: <9b8c23fd-f1b0-1687-052a-9c6b7d70f34d@linux.intel.com>
Date:   Fri, 7 Apr 2023 15:25:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
References: <20230407215259.GA3825733@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230407215259.GA3825733@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/7/23 2:52 PM, Bjorn Helgaas wrote:
> On Fri, Apr 07, 2023 at 04:51:44PM -0500, Bjorn Helgaas wrote:
>> I'll post a follow-up patch to add a couple comments there,
>> too.
> 
> Comments I propose:
> 
> 
>     PCI/EDR: Add edr_handle_event() comments
>     
>     EDR documentation is a bit sketchy.  Add a couple comments to
>     edr_handle_event() about the devices involved.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 87734e4c3c20..135ddb53661c 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -151,9 +151,17 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
>  		return;
>  
> +	/*
> +	 * pdev itself is still present, but one or more of its child
> +	 * devices have been disconnected (ACPI v6.3, sec 5.6.6).
> +	 */

Maybe add info that pdev can be a root port or a downstream port?

>  	pci_info(pdev, "EDR event received\n");
>  
> -	/* Locate the port which issued EDR event */
> +	/*
> +	 * Locate the port that experienced the containment event.  pdev
> +	 * may be that port or a parent of it (PCI Firmware r3.3, sec
> +	 * 4.6.13).
> +	 */
>  	edev = acpi_dpc_port_get(pdev);
>  	if (!edev) {
>  		pci_err(pdev, "Firmware failed to locate DPC port\n");


Otherwise, looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
