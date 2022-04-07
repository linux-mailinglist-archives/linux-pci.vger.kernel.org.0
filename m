Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4B4F87F2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiDGTTb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiDGTTa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 15:19:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA491E95E2;
        Thu,  7 Apr 2022 12:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68C06B82970;
        Thu,  7 Apr 2022 19:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5072C385A6;
        Thu,  7 Apr 2022 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649359038;
        bh=FFCCGVSnknPcSGQEt20l5gj9HymHETqLW15RaE75gKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=th/y6FLTxXotjaQlPStq/a162X1xZUWyGAW5XUrAx3JxehwphlWayv2XOPoJAU5t2
         dyjePnBC2PH9rXgLmzJJmEgQMxIB9jdmPDwHBYxaHlL/7z2IviRGedkqYeZ/lfePtW
         XOcki+N9ZjHQkOBlGlCOSHBkVcYkHYw+Mg/aBmMlPNZy/3UT/QMgIn9SrN83JB50d5
         fu+EoG1I7zYo95GdloqFvsmd5+bRhTJ6alXEwKqR/Uq/5vEy9fd4REq79+M+Q8Ffw1
         Gy8kVtqixjS2oQnc+kclYS/0J/z7DXI0wAGc+D+HK1Msvnv4lv9INJnMhzGmIqcAJy
         lpcZ3mWij8Q/g==
Date:   Thu, 7 Apr 2022 14:17:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
Message-ID: <20220407191715.GA254460@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325184609.4059963-1-rajatja@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject,

  PCI/ACPI: ...

would be consistent with previous history (at least things coming
through the PCI tree :)).

On Fri, Mar 25, 2022 at 11:46:08AM -0700, Rajat Jain wrote:
> The "DmaProperty" is supported and documented by Microsoft here:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

Here's a more specific link (could probably be referenced below to
avoid cluttering the text here):

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection

> They use this property for DMA protection:
> https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> Support the "DmaProperty" with the same semantics. This is useful for
> internal PCI devices that do not hang off a PCIe rootport, but offer
> an attack surface for DMA attacks (e.g. internal network devices).

Same semantics as what?

The MS description of "ExternalFacingPort" says:

  This ACPI object enables the operating system to identify externally
  exposed PCIe hierarchies, such as Thunderbolt.

and "DmaProperty" says:

  This ACPI object enables the operating system to identify internal
  PCIe hierarchies that are easily accessible by users (such as,
  Laptop M.2 PCIe slots accessible by way of a latch) and require
  protection by the OS Kernel DMA Protection mechanism.

I don't really understand why they called out "laptop M.2 PCIe slots"
here.  Is the idea that those are more accessible than a standard
internal PCIe slot?  Seems like a pretty small distinction to me.

I can understand your example of internal network devices adding an
attack surface.  But I don't see how "DmaProperty" helps identify
those.  Wouldn't a NIC in a standard internal PCIe slot add the same
attack surface?

> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> v5: * Reorder the patches in the series
> v4: * Add the GUID. 
>     * Update the comment and commitlog.
> v3: * Use Microsoft's documented property "DmaProperty"
>     * Resctrict to ACPI only
> 
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d0986bda2964..20603cacc28d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
>  	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
>  	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
>  		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> +	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
> +	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
> +		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
>  };
>  
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1f15ab7eabf8..378e05096c52 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1350,12 +1350,28 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  		dev->external_facing = 1;
>  }
>  
> +static void pci_acpi_check_for_dma_protection(struct pci_dev *dev)

I try to avoid function names like *_check_*() because they don't give
any hint about whether there's a side effect or what direction things
are going.  I prefer things that return a value or make sense when
used as a predicate.  Maybe something like this?

  int pci_dev_has_dma_property(struct pci_dev *dev)

  dev->untrusted |= pci_dev_has_dma_property(pci_dev);

> +{
> +	u8 val;
> +
> +	/*
> +	 * Property also used by Microsoft Windows for same purpose,
> +	 * (to implement DMA protection from a device, using the IOMMU).
> +	 */
> +	if (device_property_read_u8(&dev->dev, "DmaProperty", &val))

The MS web page says a _DSD with this property must be implemented in
the Root Port device scope, but we don't enforce that here.  We *do*
enforce it in pci_acpi_set_untrusted().  Shouldn't we do the same
here?

We currently look at three properties from the same _DSD:

  DmaProperty
  ExternalFacingPort
  HotPlugSupportInD3

For "HotPlugSupportInD3", we check that "value == 1".  For
"ExternalFacingPort", we check that it's non-zero.  The MS doc isn't
explicit about the values, but shows "1" in the sample ASL.  I think
we should handle all three cases the same.

The first two use device_property_read_u8(); the last uses
acpi_dev_get_property().  Again, I think they should all be the same.

acpi_dev_get_property() is easier for me to read because there are
slightly fewer layers of abstraction between _DSD and
acpi_dev_get_property().

But IIUC, device_property_read_u8() works for either ACPI or DT
properties, and maybe there is interest in using this for DT systems.
None of these appear in any in-tree DTs, but maybe it is important to
handle these in DTs?

If that's the case, this code would no longer be specific to ACPI and
should be moved to somewhere that's compiled even when CONFIG_ACPI
isn't set.

> +		return;
> +
> +	if (val)
> +		dev->untrusted = 1;
> +}
> +
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
>  	pci_acpi_set_external_facing(pci_dev);
> +	pci_acpi_check_for_dma_protection(pci_dev);
>  	pci_acpi_add_edr_notifier(pci_dev);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
> -- 
> 2.35.1.1021.g381101b075-goog
> 
