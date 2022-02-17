Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040814B9915
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 07:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiBQGQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 01:16:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiBQGQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 01:16:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132CF70FF;
        Wed, 16 Feb 2022 22:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D7F618D2;
        Thu, 17 Feb 2022 06:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA2C340E8;
        Thu, 17 Feb 2022 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645078585;
        bh=x9LumGLyCoei7LVkgVqdzVDy6ZEfi3UAUJ+V8cyp7Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SW2OTeo/ZzvnkqWDGOLOJoDA6YybFhfMrod8LY1IuZHUw1VpGR9ke3YwABProA2dc
         lizlm52z/OHBSHhisAN5YOcuB7IlyC03L1ytrUlBc8MMqfyjmJeW1Ql3rVUTtL9XHz
         4g4CvL6NzzvAhAgL621BV1+GyxSuni3Kq6dNeS7o=
Date:   Thu, 17 Feb 2022 07:16:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] PCI: ACPI: Support Microsoft's "DmaProperty"
Message-ID: <Yg3oNkwS3XSzmJAu@kroah.com>
References: <20220216220541.1635665-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216220541.1635665-1-rajatja@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 16, 2022 at 02:05:41PM -0800, Rajat Jain wrote:
> The "DmaProperty" is supported and documented by Microsoft here:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> They use this property for DMA protection:
> https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> Support the "DmaProperty" with the same semantics. Windows documents the
> property to apply to PCIe root ports only. Extend it to apply to any
> PCI device. This is useful for internal PCI devices that do not hang off
> a PCIe rootport, but offer an attack surface for DMA attacks (e.g.
> internal network devices).
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: * Use Microsoft's documented property "DmaProperty"
>     * Resctrict to ACPI only
> 
>  drivers/pci/pci-acpi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..660baa60c040 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1350,12 +1350,30 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  		dev->external_facing = 1;
>  }
>  
> +static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)
> +{
> +	u8 val;
> +
> +	/*
> +	 * Microsoft Windows uses this property, and is documented here:
> +	 * https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> +	 * While Microsoft documents this property as only applicable to PCIe
> +	 * root ports, we expand it to be applicable to any PCI device.
> +	 */
> +	if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
> +		return;

Why not continue to only do this for PCIe devices like it is actually
being used for?  Why expand it?

And what driver/device is going to use this?

thanks,

greg k-h
