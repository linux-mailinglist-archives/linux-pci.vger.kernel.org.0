Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1AA733770
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjFPRbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 13:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFPRbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 13:31:44 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0921FD7;
        Fri, 16 Jun 2023 10:31:41 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6E19B10029ADF;
        Fri, 16 Jun 2023 19:31:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3EA371DED81; Fri, 16 Jun 2023 19:31:40 +0200 (CEST)
Date:   Fri, 16 Jun 2023 19:31:40 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230616173140.GA6417@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230516101001.GA18952@wunner.de>
 <8ab986f2-6aa5-401a-aa21-e8b21f68eaad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab986f2-6aa5-401a-aa21-e8b21f68eaad@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 03:23:57PM -0700, Smita Koralahalli wrote:
> On 5/16/2023 3:10 AM, Lukas Wunner wrote:
> > On Tue, Apr 18, 2023 at 09:05:25PM +0000, Smita Koralahalli wrote:
> > > Also, while testing I noticed PCI_STATUS and PCI_EXP_DEVSTA will be set
> > > on an async remove and will not be cleared while the device is brought
> > > down. I have included clearing them here in order to mask any kind of
> > > appearance that there was an error and as well duplicating our BIOS
> > > functionality. I can remove if its not necessary.
> > 
> > Which bits are set exactly?  Can you constrain the register write to
> > those bits?
> 
> Hmm, I was mostly trying to follow the similar approach done for AER.
> pci_aer_raw_clear_status(), where they clear status registers
> unconditionally. Also, thought might be better if we are dealing with legacy
> endpoints or so.
> 
> I see these bits set in status registers:
> PCI_ERR_UNCOR_STATUS 0x20 (Surprise Down)
> PCI_EXP_DPC_RP_PIO_STATUS 0x10000 (Memory Request received URCompletion)
> PCI_EXP_DEVSTA 0x604 (fatal error detected)

I'd recommend clearing only PCI_EXP_DEVSTA_FED in PCI_EXP_DEVSTA.

As for PCI_EXP_DPC_RP_PIO_STATUS, PCIe r6.1 sec 2.9.3 says that
during DPC, either UR or CA completions are returned depending on
the DPC Completion Control bit in the DPC Control register.
The kernel doesn't touch that bit, so it will contain whatever value
the BIOS has set. It seems fine to me to just clear all bits in
PCI_EXP_DPC_RP_PIO_STATUS, as you've done in your patch.

However, the RP PIO Status register is present only in Root Ports
that support RP Extensions for DPC, per PCIe r6.1 sec 7.9.14.6.
So you need to constrain that to "if (pdev->dpc_rp_extensions)".


> > > +	pci_aer_raw_clear_status(pdev);
> > > +	pci_clear_surpdn_errors(pdev);
> > > +
> > > +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> > > +			      PCI_EXP_DPC_STATUS_TRIGGER);
> > > +}
> > 
> > Do you need a "wake_up_all(&dpc_completed_waitqueue);" at the end
> > of the function to wake up a pciehp handler waiting for DPC recovery?
> 
> I don't think so. The pciehp handler is however getting invoked
> simultaneously due to PDSC or DLLSC state change right.. Let me know if I'm
> missing anything here.

I think you need to follow the procedure in dpc_reset_link().

That function first waits for the link to go down, in accordance with
PCIe r6.1 sec 6.2.11:

	if (!pcie_wait_for_link(pdev, false))
	...

Note that the link should not come back up due to a newly hot-added
device until DPC Trigger Status is cleared.

The function then waits for the Root Port to quiesce:

	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
	...

And only then does the function clear DPC Trigger Status.

You definitely need to wake_up_all(&dpc_completed_waitqueue) because
pciehp may be waiting for DPC Trigger Status to clear.

And you need to "clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags)"
before calling wake_up_all().


> > > +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> > > +{
> > > +	u16 status;
> > > +
> > > +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
> > > +
> > > +	if (!(status & PCI_ERR_UNC_SURPDN))
> > > +		return false;
> > > +
> > 
> > You need an additional check for pdev->is_hotplug_bridge here.
> > 
> > And you need to read PCI_EXP_SLTCAP and check for PCI_EXP_SLTCAP_HPS.
> > 
> > Return false if either of them isn't set.
> 
> Return false, if PCI_EXP_SLTCAP isn't set only correct? PCI_EXP_SLTCAP_HPS
> should be disabled if DPC is enabled.
> 
> Implementation notes in 6.7.6 says that:
> "The Hot-Plug Surprise (HPS) mechanism, as indicated by the Hot-Plug
> Surprise bit in the Slot Capabilities Register being Set, is deprecated
> for use with async hot-plug. DPC is the recommended mechanism for supporting
> async hot-plug."
> 
> Platform FW will disable the SLTCAP_HPS bit at boot time to enable async
> hotplug on AMD devices.

Huh, is PCI_EXP_SLTCAP_HPS not set on the hotplug port in question?

If it's not set, why do you get Surprise Down Errors in the first place?

How do you bring down the slot without surprise-removal capability?
Via sysfs?


> Probably check if SLTCAP_HPS bit is set and return false?

Quite the opposite!  If it's not set, return false.


Thanks,

Lukas
