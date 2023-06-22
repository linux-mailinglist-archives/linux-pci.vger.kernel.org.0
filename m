Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C273AB83
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 23:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjFVVXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 17:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFVVXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 17:23:03 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE1F1;
        Thu, 22 Jun 2023 14:23:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 945FE100F00EF;
        Thu, 22 Jun 2023 23:22:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 65C8017F1E; Thu, 22 Jun 2023 23:22:59 +0200 (CEST)
Date:   Thu, 22 Jun 2023 23:22:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230622212259.GA11993@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230622090403.GA21721@wunner.de>
 <15248fe6-9b82-7135-4bb7-73667aaec604@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15248fe6-9b82-7135-4bb7-73667aaec604@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 02:02:03PM -0700, Smita Koralahalli wrote:
> On 6/22/2023 2:04 AM, Lukas Wunner wrote:
> > On Wed, Jun 21, 2023 at 06:51:51PM +0000, Smita Koralahalli wrote:
> > > --- a/drivers/pci/pcie/dpc.c
> > > +++ b/drivers/pci/pcie/dpc.c
> > > @@ -292,10 +292,68 @@ void dpc_process_error(struct pci_dev *pdev)
> > >   	}
> > >   }
> > > +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> > > +{
> > > +	u16 reg16;
> > > +	u32 reg32;
> > > +
> > > +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
> > > +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
> > 
> > Make this read+write conditional on "if (pdev->dpc_rp_extensions)"
> > as the register otherwise doesn't exist.
> 
> I'm checking for pdev->dpc_rpc_extensions inside
> dpc_handle_surprise_removal() before calling pci_clear_surpdn_errors().
> Should I recheck it once again here?

Yes.


> > > +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> > > +	pci_write_config_word(pdev, PCI_STATUS, reg16);
> > > +
> > > +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
> > > +}
> > 
> > A code comment might be useful here saying that in practice,
> > Surprise Down errors have been observed to also set error bits
> > in the Status Register as well as the Fatal Error Detected bit
> > in the Device Status Register.
> 
> And probably move this code comment below to where this function is called
> inside dpc_handle_surprise_removal()..?

No right here would be good because that's the piece of code to which
the code comment would pertain.


> > 	if (!pcie_wait_for_link(pdev, false)) {
> > 		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
> > 		goto out;
> > 	}
> > 
> > here, similar to dpc_reset_link() and in accordance with PCIe r6.1
> > sec 6.2.11:
> > 
> > 	"To ensure that the LTSSM has time to reach the Disabled state
> > 	or at least to bring the Link down under a variety of error
> > 	conditions, software must leave the Downstream Port in DPC
> > 	until the Data Link Layer Link Active bit in the Link Status
> > 	Register reads 0b; otherwise, the result is undefined."
> 
> And include the above comment in code..

I'd say that's optional.  dpc_reset_link() doesn't have a code comment
for that either, so...

Thanks,

Lukas
