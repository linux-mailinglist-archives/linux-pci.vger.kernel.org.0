Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972659B3CD
	for <lists+linux-pci@lfdr.de>; Sun, 21 Aug 2022 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiHUMq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHUMqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 08:46:25 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E7717A8E
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 05:46:24 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B23B1300002D0;
        Sun, 21 Aug 2022 14:46:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A5BE81EEF2; Sun, 21 Aug 2022 14:46:21 +0200 (CEST)
Date:   Sun, 21 Aug 2022 14:46:21 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] PCI: pciehp: Enable DLLSC interrupt only if
 supported
Message-ID: <20220821124621.GA23239@wunner.de>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-2-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818135140.5996-2-kabel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 03:51:30PM +0200, Marek Behún wrote:
> Don't enable Data Link Layer State Changed interrupt if it isn't
> supported.
> 
> Data Link Layer Link Active Reporting Capable bit in Link Capabilities
> register indicates if Data Link Layer State Changed Enable is supported.
> 
> Although Lukas Wunner says [1]
>   According to PCIe r6.0, sec. 7.5.3.6, "For a hot-plug capable
>   Downstream Port [...], this bit must be hardwired to 1b."
> the reason we want this is because of the pci-bridge-emul driver, which
> emulates a bridge, but does not support asynchronous operations (since
> implementing them is unneeded and would require massive changes to the
> whole driver). Therefore enabling DLLSC unconditionally makes the
> corresponding bit set only in the emulated configuration space of the
> pci-bridge-emul driver, which
> - results in confusing information when dumping the config space (it
>   says that the interrupt is not supported but enabled), which may
>   confuse developers when debugging PCIe issues,
> - may cause bugs in the future if someone adds code that checks whether
>   DLLSC is enabled and then waits for the interrupt.

Honestly I'm not sure this change adds value or is necessary:

advk_pci_bridge_emul_pcie_conf_read() unconditionally sets the DLLLARC
bit, so the change doesn't have any effect for aardvark.

Same for mvebu_pci_bridge_emul_pcie_conf_read().
There are no other drivers using pci-bridge-emul.

Apart from that, it is legal to set the DLLSCE bit even on PCIe r1.0,
which did not define Data Link Layer Link Active Reporting yet.
(It defined the bit RsvdP.)  Thus there's no reason for developers
to be confused.

We're also never depending *exclusively* on DLLSC events in pciehp,
we always react to either of PDC or DLLSC, whichever comes first.
So I don't see enabling DLLSCE on unsupporting hardware as a
potential source of error.


> [1] https://www.spinics.net/lists/linux-pci/msg124727.html

Please always use lore.kernel.org links as they will likely outlast
3rd party archives:

https://lore.kernel.org/linux-pci/20220509034216.GA26780@wunner.de/


> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
[...]
> +	pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &link_cap);
> +

Unfortunately this new version of the patch does not address
one of my comments on the previous version:

"The Data Link Layer Link Active Reporting Capable bit is cached
in ctrl_dev(ctrl)->link_active_reporting.  Please use that
instead of re-reading it from the register."

(Verbatim quote from the above-linked e-mail.)


> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -841,6 +841,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
>  	struct pci_dev *pdev = php_slot->pdev;
>  	u32 broken_pdc = 0;
>  	u16 sts, ctrl;
> +	u32 link_cap;
>  	int ret;
>  
>  	/* Allocate workqueue */
> @@ -874,17 +875,21 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
>  		return;
>  	}
>  
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
> +
>  	/* Enable the interrupts */
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
>  	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
>  		ctrl &= ~PCI_EXP_SLTCTL_PDCE;
> -		ctrl |= (PCI_EXP_SLTCTL_HPIE |
> -			 PCI_EXP_SLTCTL_DLLSCE);
> +		ctrl |= PCI_EXP_SLTCTL_HPIE;
>  	} else {
>  		ctrl |= (PCI_EXP_SLTCTL_HPIE |
> -			 PCI_EXP_SLTCTL_PDCE |
> -			 PCI_EXP_SLTCTL_DLLSCE);
> +			 PCI_EXP_SLTCTL_PDCE);
>  	}
> +	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
> +		ctrl |= PCI_EXP_SLTCTL_DLLSCE;
> +	else
> +		ctrl &= ~PCI_EXP_SLTCTL_DLLSCE;
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);

Note that the pnv_php.c driver is relying on DLLSC here if PDC
is broken (see PNV_PHP_FLAG_BROKEN_PDC).  By not enabling DLLSC,
you may break hotplug altogether.

pnv_php.c is a PowerPC-specific hotplug controller, but you're not
cc'ing the driver's maintainers, which are:

$ scripts/get_maintainer.pl drivers/pci/hotplug/pnv_php.c
Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Nicholas Piggin <npiggin@gmail.com> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Christophe Leroy <christophe.leroy@csgroup.eu> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))

Thanks,

Lukas
