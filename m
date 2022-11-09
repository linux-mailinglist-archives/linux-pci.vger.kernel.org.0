Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC6623793
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 00:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKIXgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 18:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiKIXgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 18:36:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB11900A;
        Wed,  9 Nov 2022 15:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A58FD61D26;
        Wed,  9 Nov 2022 23:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D9C433D7;
        Wed,  9 Nov 2022 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668036960;
        bh=xDaxbcsvS5ooeLilCDV2eAZ/B+4PrNvT4W6swBS6lEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eksR+SPp/aGE7EDrxbFI7LiRn8uucTy4DAXqhXbf9V9fZPcCwI97bPBuJXIdtOMeF
         QqQOm7DP4m/jQGkp/XAW8Lb9WCx+xtkjKiIOMbAC0jJbbIxNXrW3YIIEK7MpP3+Tw/
         afsdoIB/DmF26A79pJuqmFKDwjD3wHuWEfQb7J9vK0+s4OcZqFlhqhIkebE8XA0z4h
         49nIyMh/XfhqplAV+RAxzA/35BexnLw35iUkzUjPAJNDiSRtFRCyIxHANlD8i/8ZiR
         5HVmAu6vcpq1nVdqDmtA2ZdsMNWNIuZOVUocI9YXXwBgIQQj+/8k4thDAcFg2H94Mz
         80rcoY+RtBRlA==
Date:   Wed, 9 Nov 2022 17:35:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
Message-ID: <20221109233558.GA581582@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-10-rrichter@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 09, 2022 at 11:40:59AM +0100, Robert Richter wrote:
> From: Terry Bowman <terry.bowman@amd.com>
> 
> ACPI includes a CXL _OSC support procedure to communicate the available
> CXL support to FW. The CXL support _OSC includes a field to indicate
> CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
> to RCD and RCH Port registers.[1] FW can potentially change it's operation

s/it's/its/

> depending on the _OSC support setting reported by the OS.
> 
> The ACPI driver does not currently set the ACPI _OSC support to indicate
> CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.

Eight instances of "support" above seems like it might be more than
necessary.

I don't know the history, but OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT and
OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT seem like sort of weird names
since they don't match the spec at all ("RCD and RCH Port Register
Access Supported" and "CXL VH Register Access Supported").

> [1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/pci_root.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c8385ef54c37..094a59b216ae 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
>  	u32 support;
>  
>  	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
> +	support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
>  	if (pci_aer_available())
>  		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -- 
> 2.30.2
> 
