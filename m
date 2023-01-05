Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86B65F189
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjAEQ4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 11:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjAEQ4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 11:56:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359763727D;
        Thu,  5 Jan 2023 08:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF6F4B81B50;
        Thu,  5 Jan 2023 16:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F96DC433D2;
        Thu,  5 Jan 2023 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672937802;
        bh=7tc21u/mJwi7G11AK6MRIZWAXhvEEkRIab0Zxf68F+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E32D3tUUsJHdLsR9EkFw7rjw8/bVapN/RF8R90nNXlBSTU/l5w+3tX22bOHRFW3Pw
         zzJQJ9eErtHplJx+MXkQ5XYCZ04zMAjm5natweJALS3U2WAZ7Q8oCM7mZwS0DWJNT1
         LA8MiEBzWnNRMzhPNqYLqm7m4TKVT+bGzsFsgElu4eC6PhmZnQaSAuoPnJLuOIuGgT
         9/iA0G5GXhcKA+I+sCWF7PXsrahqUau82/EhNTD8FKRSmZWqlZfcFyxxEwcITRYK05
         tkqLX40vCDap7BFZIkGc38MxMdbqRBcg0hHn/602LQekTgs3HgB5+TVVxghiLOfAlA
         +jfgqWXJg1//w==
Date:   Thu, 5 Jan 2023 10:56:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V4 1/9] PCI/CXL: Export native CXL error reporting control
Message-ID: <20230105165639.GA1150637@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212070627.1372402-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 11, 2022 at 11:06:19PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL _OSC Error Reporting Control is used by the OS to determine if
> Firmware has control of various CXL error reporting capabilities
> including the event logs.
> 
> Expose the result of negotiating CXL Error Reporting Control in struct
> pci_host_bridge for consumption by the CXL drivers.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

FWIW, for probe.c and pci.h:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changes from V3:
> 	New patch split out
> ---
>  drivers/acpi/pci_root.c | 3 +++
>  drivers/pci/probe.c     | 1 +
>  include/linux/pci.h     | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b3c202d2a433..84030804a763 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1047,6 +1047,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>  		host_bridge->native_dpc = 0;
>  
> +	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
> +		host_bridge->native_cxl_error = 0;
> +
>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>  	 * exists and returns 0, we must preserve any PCI resource
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f4e88a44e8b..34c9fd6840c4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -596,6 +596,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
> +	bridge->native_cxl_error = 1;
>  
>  	device_initialize(&bridge->dev);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1f81807492ef..08c3ccd2617b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -577,6 +577,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
> +	unsigned int	native_cxl_error:1;	/* OS may use CXL RAS/Events */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> -- 
> 2.37.2
> 
