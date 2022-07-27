Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7F58287F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiG0OXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiG0OXm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 10:23:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE81ADA0;
        Wed, 27 Jul 2022 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658931821; x=1690467821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QDqJWX3QsIY+mVrjQjqamt6AMbOAQVyx8v1KjAUsHEM=;
  b=KZ2SzJxwlUVPQEowgw/NnnmY3vF4gaL9UpHW79AyAIiilzyR+/zXGtRB
   yZSQ9T0ZrXMzas2tHL88mjt9j9rH7h3SMv6UycGxMQv6TqZuzPx5CjHrb
   VV1sRox5/D3m3/itnTD9MYBfml3MOr1+GBV3D3icMAXhcy4VKlcgffA17
   +xvk8ZCxsleE3pteEJpVdZs7BAW/bwxipeM8tkJPd0XaqItiDYTTv9J7G
   o+A6NXHkF/KH9LRzg82aquGyrsDGRfiK6h73azVzaIXt/cWs9ZSBknak1
   +kkfvAkHgeH98ceMRHLzpSHSGKsD3tsCTE1VQD5uqdoUEvYCoc/A1tWQj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275120443"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="275120443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:23:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="726942897"
Received: from jkasten-mobl.amr.corp.intel.com (HELO [10.209.24.156]) ([10.209.24.156])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 07:23:40 -0700
Message-ID: <3dc43f00-0b01-1b02-74dc-6938f6db6e29@linux.intel.com>
Date:   Wed, 27 Jul 2022 07:23:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1] PCI/DPC: Skip EDR init when BIOS disable OS native DPC
Content-Language: en-US
To:     Xiaochun Lee <lixiaochun.2888@163.com>, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
References: <1658919957-53006-1-git-send-email-lixiaochun.2888@163.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1658919957-53006-1-git-send-email-lixiaochun.2888@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 7/27/22 4:05 AM, Xiaochun Lee wrote:
> From: Xiaochun Lee <lixc17@lenovo.com>
> 
> ACPI BIOS may disable OS native AER and DPC support to notify OS
> that our platform doesn't support AER and DPC via the _OSC method.
> BIOS also might leave the containment be accomplished purely in HW.
> When firmware is set to non-aware OS DPC, we skip to install
> EDR handler to an ACPI device.

No, EDR is used when firmware controls the DPC.

When the Firmware owns Downstream Port Containment, it is expected to use
the new “Error Disconnect Recover” notification to alert OSPM of a
Downstream Port Containment event.

> 
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> ---
>  drivers/pci/pcie/edr.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b47..97a680b 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -19,6 +19,17 @@
>  #define EDR_OST_SUCCESS			0x80
>  #define EDR_OST_FAILED			0x81
>  
> +static int pcie_dpc_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	if (!dev->dpc_cap)
> +		return 0;
> +
> +	return pcie_ports_dpc_native || host->native_dpc;
> +}
> +
> +
>  /*
>   * _DSM wrapper function to enable/disable DPC
>   * @pdev   : PCI device structure
> @@ -212,6 +223,11 @@ void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
>  		return;
>  	}
>  
> +	if (!pcie_dpc_is_native(pdev) && !pcie_aer_is_native(pdev)) {
> +		pci_dbg(pdev, "OS doesn't control DPC, skipping EDR init\n");
> +		return;
> +	}
> +
>  	status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
>  					     edr_handle_event, pdev);
>  	if (ACPI_FAILURE(status)) {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
