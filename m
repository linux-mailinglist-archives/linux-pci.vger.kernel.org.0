Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7969D619446
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKDKPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDKPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 06:15:42 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ABE2A26C;
        Fri,  4 Nov 2022 03:15:38 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 17CFA100B0552;
        Fri,  4 Nov 2022 11:15:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E63B23269D; Fri,  4 Nov 2022 11:15:36 +0100 (CET)
Date:   Fri, 4 Nov 2022 11:15:36 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Message-ID: <20221104101536.GA11363@wunner.de>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 12:07:18AM +0000, Smita Koralahalli wrote:
> The implementation is as follows: On an async remove a DPC is triggered as
> a side-effect along with an MSI to the OS. Determine it's an async remove
> by checking for DPC Trigger Status in DPC Status Register and Surprise
> Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
> treat the DPC event as a side-effect of async remove, clear the error
> status registers and continue with hot-plug tear down routines. If not,
> follow the existing routine to handle AER/DPC errors.

Instead of having the OS recognize and filter Surprise Down events,
it would also be possible to simply set the Surprise Down bit in the
Uncorrectable Error Mask Register.  This could be constrained to
Downstream Ports capable of surprise removal, i.e. those where the
is_hotplug_bridge in struct pci_dev is set.  And that check and the
register change could be performed in pci_dpc_init().

Have you considered such an alternative approach?  If you have, what
was the reason to prefer the more complex solution you're proposing?


> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	u16 reg16;
> +	u32 reg32;
> +
> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
> +
> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
> +}

I don't understand why PCI_STATUS and PCI_EXP_DEVSTA need to be
touched here?


> +static void pciehp_handle_surprise_removal(struct pci_dev *pdev)

Since this function is located in dpc.c and is strictly called from
other functions in the same file, it should be prefixed dpc_, not
pciehp_.


> +	/*
> +	 * According to Section 6.13 and 6.15 of the PCIe Base Spec 6.0,
> +	 * following a hot-plug event, clear the ARI Forwarding Enable bit
> +	 * and AtomicOp Requester Enable as its not determined whether the
> +	 * next device inserted will support these capabilities. AtomicOp
> +	 * capabilities are not supported on PCI Express to PCI/PCI-X Bridges
> +	 * and any newly added component may not be an ARI device.
> +	 */
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> +				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ));

That looks like a reasonable change, but it belongs in a separate
patch.  And I think it should be performed as part of (de-)enumeration,
not as part of DPC error handling.  What about Downstream Ports which
are not DPC-capable, I guess the bits should be cleared as well, no?

How about clearing the bits in pciehp_unconfigure_device()?

Thanks,

Lukas
