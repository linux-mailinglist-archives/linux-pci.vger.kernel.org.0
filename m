Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEC50FBCC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiDZLTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349490AbiDZLSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 07:18:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13A6D38BE7;
        Tue, 26 Apr 2022 04:15:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB8B023A;
        Tue, 26 Apr 2022 04:15:46 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99EA53F5A1;
        Tue, 26 Apr 2022 04:15:43 -0700 (PDT)
Message-ID: <030f48f4-44d7-c04c-a194-5f4999873ebe@arm.com>
Date:   Tue, 26 Apr 2022 12:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Content-Language: en-GB
To:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220426000640.3581446-1-rajatja@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220426000640.3581446-1-rajatja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-04-26 01:06, Rajat Jain via iommu wrote:
> The "DmaProperty" is supported and currently documented and used by
> Microsoft [link 1 below], to flag internal PCIe root ports that need
> DMA protection [link 2 below]. We have discussed with them and reached
> a common understanding that they shall change their MSDN documentation
> to say that the same property can be used to protect any PCI device,
> and not just internal PCIe root ports (since there is no point
> introducing yet another property for arbitrary PCI devices). This helps
> with security from internal devices that offer an attack surface for
> DMA attacks (e.g. internal network devices).
> 
> Support DmaProperty to mark DMA from a PCI device as untrusted.
> 
> Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> v6: * Take care of Bjorn's comments:
>         - Update the commit log
>         - Rename to pci_dev_has_dma_property()
>         - Use acpi_dev_get_property()
> v5: * Reorder the patches in the series
> v4: * Add the GUID.
>      * Update the comment and commitlog.
> v3: * Use Microsoft's documented property "DmaProperty"
>      * Resctrict to ACPI only
> 
>   drivers/acpi/property.c |  3 +++
>   drivers/pci/pci-acpi.c  | 21 +++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 12bbfe833609..bafe35c301ac 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
>   	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
>   	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
>   		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> +	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
> +	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
> +		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
>   };
>   
>   /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 3ae435beaf0a..d7c6ba48486f 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1369,12 +1369,33 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>   		dev->external_facing = 1;
>   }
>   
> +static int pci_dev_has_dma_property(struct pci_dev *dev)
> +{
> +	struct acpi_device *adev;
> +	const union acpi_object *obj;
> +
> +	adev = ACPI_COMPANION(&dev->dev);
> +	if (!adev)
> +		return 0;
> +
> +	/*
> +	 * Property also used by Microsoft Windows for same purpose,
> +	 * (to implement DMA protection from a device, using the IOMMU).

Nit: there is no context for "same purpose" here, so this comment is 
more confusing than helpful. Might I suggest a rewording like:

	/*
	 * Property used by Microsoft Windows to enforce IOMMU DMA
	 * protection for any device that the system might not fully
	 * trust; we'll honour it the same way.
	 */

?

Personally I think it would have been more logical to handle this in 
pci_set_dma_untrusted(), but I see some of those implementation aspects 
have already been discussed, and Bjorn's preference definitely wins over 
mine here :)

Thanks,
Robin.

> +	 */
> +	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
> +				   &obj) && obj->integer.value == 1)
> +		return 1;
> +
> +	return 0;
> +}
> +
>   void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>   {
>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>   
>   	pci_acpi_optimize_delay(pci_dev, adev->handle);
>   	pci_acpi_set_external_facing(pci_dev);
> +	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev); >   	pci_acpi_add_edr_notifier(pci_dev);
>   
>   	pci_acpi_add_pm_notifier(adev, pci_dev);
