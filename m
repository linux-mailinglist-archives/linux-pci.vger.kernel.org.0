Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D366632B87
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKURyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKURyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:54:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BAA26FE
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 09:54:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F1161374
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 17:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C840C433C1;
        Mon, 21 Nov 2022 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669053261;
        bh=U9GAbtKpbOcEGLHkAF6EWI2FRUiJLfEVdQD+b+Wb5eU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MPrAh8ZzZd5mogOZOqsn73sV9OB8etDQMMfVPvDn7qqBCG0Pv0oFPe+tylGqoNdT8
         vvumMWJt6KxxzTDfLholqVEuICF0jlm9xIqTNwBgxxjv4lBuki605job3dhGRfnp6q
         dYlzfEwiMM8p9hjJvAWFFQ0X4sbgomgwKp/AQThQPTayINHxa8v8EVVv1mDoanQ4e0
         P1sruwrhrEVqvferJMRlqoIwpSw5m9q+gfUdYVegVIhuY1LA5+HaXzrohpnRKUbwwb
         ft75ZpQTmbhb8ij3McoAHidQ2QCTqO7lzyuk2iC+xl5ODpUkoV11qT6+qTjDWgRYb1
         y2Bgrl7x5drgw==
Date:   Mon, 21 Nov 2022 11:54:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Francisco Blas Izquierdo Riera <klondike@klondike.es>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v2] PCI: Add DMA alias for Intel Corporation 8 Series HECI
Message-ID: <20221121175419.GA122359@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121164037.8C73110BB536@smtp.xiscosoft.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Jarkko, Tomas, Alexander; can any of you confirm this behavior of
the HECI device?  Are there any other HECI devices that should be
included in this quirk?]

[+cc David, Lu, iommu list]

On Mon, Nov 21, 2022 at 05:40:37PM +0100, Francisco Blas Izquierdo Riera wrote:
> PCI: Add function 7 DMA alias quirk for Intel Corporation 8 Series HECI.
> 
> Intel Corporation 8 Series HECIs include support for a CRB TPM 2.0
> device. When the device is enabled on the BIOS, the TPM 2.0 device is
> detected but the IOMMU prevents it from being accessed.
> 
> Even on a computer with a fixed DMAR table, device initialization
> fails with DMA errors:
>   DMAR: DRHD: handling fault status reg 3
>   DMAR: [DMA Read NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x06] PTE Read access is not set
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [DMA Write NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x05] PTE Write access is not set
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [DMA Write NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x05] PTE Write access is not set
>   tpm tpm0: Operation Timed out
>   DMAR: DRHD: handling fault status reg 3
>   tpm tpm0: Operation Timed out
>   tpm_crb: probe of MSFT0101:00 failed with error -62
> 
> After patching the DMAR table and adding this patch, the TPM 2.0
> device is initialized correctly and no DMA errors appear. Accessing
> the TPM 2.0 PCR banks also works as expected.

Francisco, is the DMAR patch *also* required?  We have several similar
quirks for devices that use unexpected function numbers, but I don't
remember any that require DMAR changes.

A kernel quirk requires no action on the part of users, so that's
easy.  But I don't think it's practical for ordinary users to extract
the DMAR, disassemble it, patch it, recompile it, and update the
initramfs as described in your blog post.

Is there a way to add a kernel quirk to accomplish the same DMAR
override?

> Since most Haswell computers supporting this do not seem to have a
> valid DMAR table patching the table with an appropriate RMRR is
> usually also needed. I have published a blogpost describing the
> process.
> 
> This patch currently adds the alias only for function 0. Since this
> is the only function I have seen provided by the HECI on actual
> hardware.
> 
> 
> V2: Resent using a sendmail to fix tab mangling made by Thunderbird.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=108251
> Link: https://klondike.es/klog/2022/11/21/patching-the-acpi-dmar-table-to-allow-tpm2-0/
> Reported-by: Pierre Chifflier <chifflier@gmail.com>
> Tested-by: Francisco Blas Izquierdo Riera (klondike) <klondike@klondike.es>
> Signed-off-by: Francisco Blas Izquierdo Riera <klondike@klondike.es>
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org
> 
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4162,6 +4162,22 @@
>  			 0x0122, /* Plextor M6E (Marvell 88SS9183)*/
>  			 quirk_dma_func1_alias);
>  
> +static void quirk_dma_func7_alias(struct pci_dev *dev)
> +{
> +	if (PCI_FUNC(dev->devfn) == 0)
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 7), 1);
> +}
> +
> +/*
> + * Certain HECIs in Haswell systems support TPM 2.0. Unfortunately they
> + * perform DMA using the hidden function 7. Fixing this requires this
> + * alias and a patch of the DMAR ACPI table to include the appropriate
> + *  MTRR.
> + * https://bugzilla.kernel.org/show_bug.cgi?id=108251
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9c3a,
> +			 quirk_dma_func7_alias);
> +
>  /*
>   * Some devices DMA with the wrong devfn, not just the wrong function.
>   * quirk_fixed_dma_alias() uses this table to create fixed aliases, where
