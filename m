Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFF2632D13
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 20:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKUTjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKUTje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 14:39:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA9C6CB966
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:39:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 776C41FB;
        Mon, 21 Nov 2022 11:39:38 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53BEF3F587;
        Mon, 21 Nov 2022 11:39:30 -0800 (PST)
Message-ID: <1e5a085e-b040-0832-cfd1-d4f2986fb1fc@arm.com>
Date:   Mon, 21 Nov 2022 19:39:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] PCI: Add DMA alias for Intel Corporation 8 Series HECI
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Francisco Blas Izquierdo Riera <klondike@klondike.es>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
References: <20221121175419.GA122359@bhelgaas>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221121175419.GA122359@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-11-21 17:54, Bjorn Helgaas wrote:
> [+to Jarkko, Tomas, Alexander; can any of you confirm this behavior of
> the HECI device?  Are there any other HECI devices that should be
> included in this quirk?]
> 
> [+cc David, Lu, iommu list]
> 
> On Mon, Nov 21, 2022 at 05:40:37PM +0100, Francisco Blas Izquierdo Riera wrote:
>> PCI: Add function 7 DMA alias quirk for Intel Corporation 8 Series HECI.
>>
>> Intel Corporation 8 Series HECIs include support for a CRB TPM 2.0
>> device. When the device is enabled on the BIOS, the TPM 2.0 device is
>> detected but the IOMMU prevents it from being accessed.
>>
>> Even on a computer with a fixed DMAR table, device initialization
>> fails with DMA errors:
>>    DMAR: DRHD: handling fault status reg 3
>>    DMAR: [DMA Read NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x06] PTE Read access is not set
>>    DMAR: DRHD: handling fault status reg 2
>>    DMAR: [DMA Write NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x05] PTE Write access is not set
>>    DMAR: DRHD: handling fault status reg 2
>>    DMAR: [DMA Write NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x05] PTE Write access is not set
>>    tpm tpm0: Operation Timed out
>>    DMAR: DRHD: handling fault status reg 3
>>    tpm tpm0: Operation Timed out
>>    tpm_crb: probe of MSFT0101:00 failed with error -62
>>
>> After patching the DMAR table and adding this patch, the TPM 2.0
>> device is initialized correctly and no DMA errors appear. Accessing
>> the TPM 2.0 PCR banks also works as expected.
> 
> Francisco, is the DMAR patch *also* required?  We have several similar
> quirks for devices that use unexpected function numbers, but I don't
> remember any that require DMAR changes.
> 
> A kernel quirk requires no action on the part of users, so that's
> easy.  But I don't think it's practical for ordinary users to extract
> the DMAR, disassemble it, patch it, recompile it, and update the
> initramfs as described in your blog post.
> 
> Is there a way to add a kernel quirk to accomplish the same DMAR
> override?

Yes, in principle it's possible to quirk a reserved region for a 
particular device - like intel-iommu does for ISA bridges for instance - 
however figuring out exactly *where* to reserve might be a lot more 
tricky if it's not in a fixed place. The other possibility is to use 
.def_domain_type to quirk the entire device to use an identity domain - 
like for certain integrated GPUs - but that might depend on the scope of 
how much you want to trust it and whether there are also other devices 
in the same IOMMU group.

If anything I'm not sure that the PCI DMA alias quirk really sounds like 
the most correct thing to do, if the hidden function is doing its own 
DMA unrelated to whatever function 0 and its driver might do. If I'm 
understanding the situation correctly, a quirk for the ACPI TPM device 
in probe_acpi_namespace_devices() (assuming it doesn't have an ANDD 
entry already) might be more elegant (but admittedly more work).

Robin.

>> Since most Haswell computers supporting this do not seem to have a
>> valid DMAR table patching the table with an appropriate RMRR is
>> usually also needed. I have published a blogpost describing the
>> process.
>>
>> This patch currently adds the alias only for function 0. Since this
>> is the only function I have seen provided by the HECI on actual
>> hardware.
>>
>>
>> V2: Resent using a sendmail to fix tab mangling made by Thunderbird.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=108251
>> Link: https://klondike.es/klog/2022/11/21/patching-the-acpi-dmar-table-to-allow-tpm2-0/
>> Reported-by: Pierre Chifflier <chifflier@gmail.com>
>> Tested-by: Francisco Blas Izquierdo Riera (klondike) <klondike@klondike.es>
>> Signed-off-by: Francisco Blas Izquierdo Riera <klondike@klondike.es>
>> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: stable@vger.kernel.org
>>
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4162,6 +4162,22 @@
>>   			 0x0122, /* Plextor M6E (Marvell 88SS9183)*/
>>   			 quirk_dma_func1_alias);
>>   
>> +static void quirk_dma_func7_alias(struct pci_dev *dev)
>> +{
>> +	if (PCI_FUNC(dev->devfn) == 0)
>> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 7), 1);
>> +}
>> +
>> +/*
>> + * Certain HECIs in Haswell systems support TPM 2.0. Unfortunately they
>> + * perform DMA using the hidden function 7. Fixing this requires this
>> + * alias and a patch of the DMAR ACPI table to include the appropriate
>> + *  MTRR.
>> + * https://bugzilla.kernel.org/show_bug.cgi?id=108251
>> + */
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9c3a,
>> +			 quirk_dma_func7_alias);
>> +
>>   /*
>>    * Some devices DMA with the wrong devfn, not just the wrong function.
>>    * quirk_fixed_dma_alias() uses this table to create fixed aliases, where
> 
