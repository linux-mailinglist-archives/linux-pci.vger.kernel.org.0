Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C529E6D751E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 09:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjDEHSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 03:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDEHSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 03:18:43 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797826BA;
        Wed,  5 Apr 2023 00:18:41 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4E8DA300097AE;
        Wed,  5 Apr 2023 09:18:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 43BA6E24E3; Wed,  5 Apr 2023 09:18:39 +0200 (CEST)
Date:   Wed, 5 Apr 2023 09:18:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] PCI: pciehp: Rely on `link_active_reporting'
Message-ID: <20230405071839.GA27005@wunner.de>
References: <alpine.DEB.2.21.2304042200040.37565@angie.orcam.me.uk>
 <alpine.DEB.2.21.2304042243250.37565@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2304042243250.37565@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 04, 2023 at 10:56:21PM +0100, Maciej W. Rozycki wrote:
> Use `link_active_reporting' to determine whether Data Link Layer Link 
> Active Reporting is available rather than re-retrieving the capability.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

I provided a Reviewed-by for this patch back in February:

https://lore.kernel.org/linux-pci/20230213135327.GA29595@wunner.de/

Please always include collected tags when reposting your patches.

I also noted back then that this patch does not depend on the preceding
patches in the series.  So please move it to the front of the series
so that it can be picked up despite the other patches still being
under discussion.  That way you reduce the size of any future reposts
of the series and make life easier both for yourself and reviewers.

Thanks,

Lukas

> ---
> NB this has been compile-tested only with PPC64LE and x86-64
> configurations.
> 
> No change from v6.
> 
> New change in v6.
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> linux-pcie-link-active-reporting-hpc.diff
> Index: linux-macro/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-macro/drivers/pci/hotplug/pciehp_hpc.c
> @@ -984,7 +984,7 @@ static inline int pcie_hotplug_depth(str
>  struct controller *pcie_init(struct pcie_device *dev)
>  {
>  	struct controller *ctrl;
> -	u32 slot_cap, slot_cap2, link_cap;
> +	u32 slot_cap, slot_cap2;
>  	u8 poweron;
>  	struct pci_dev *pdev = dev->port;
>  	struct pci_bus *subordinate = pdev->subordinate;
> @@ -1030,9 +1030,6 @@ struct controller *pcie_init(struct pcie
>  	if (dmi_first_match(inband_presence_disabled_dmi_table))
>  		ctrl->inband_presence_disabled = 1;
>  
> -	/* Check if Data Link Layer Link Active Reporting is implemented */
> -	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
> -
>  	/* Clear all remaining event bits in Slot Status register. */
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>  		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> @@ -1051,7 +1048,7 @@ struct controller *pcie_init(struct pcie
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
>  		FLAG(slot_cap2, PCI_EXP_SLTCAP2_IBPD),
> -		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
> +		FLAG(pdev->link_active_reporting, true),
>  		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
>  
>  	/*
