Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D188CB1C23
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfIML2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 07:28:49 -0400
Received: from foss.arm.com ([217.140.110.172]:41924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfIML2t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 07:28:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 301F828;
        Fri, 13 Sep 2019 04:28:48 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE3A3F59C;
        Fri, 13 Sep 2019 04:28:45 -0700 (PDT)
Date:   Fri, 13 Sep 2019 12:28:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>, bhelgaas@google.com
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andrew.murray@arm.com,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, alisaidi@amazon.com,
        ronenk@amazon.com, barakw@amazon.com, talel@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/7] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Message-ID: <20190913112841.GA8153@e121166-lin.cambridge.arm.com>
References: <20190912130042.14597-1-jonnyc@amazon.com>
 <20190912130042.14597-5-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912130042.14597-5-jonnyc@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 04:00:42PM +0300, Jonathan Chocron wrote:
> The Root Port (identified by [1c36:0031]) doesn't support MSI-X. On some
> platforms it is configured to not advertise the capability at all, while
> on others it (mistakenly) does. This causes a panic during
> initialization by the pcieport driver, since it tries to configure the
> MSI-X capability. Specifically, when trying to access the MSI-X table
> a "non-existing addr" exception occurs.
> 
> Example stacktrace snippet:
> 
>   SError Interrupt on CPU2, code 0xbf000000 -- SError
>   CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-14847-ge76f1d4a1828-dirty #33
>   Hardware name: Annapurna Labs Alpine V3 EVP (DT)
>   pstate: 80000005 (Nzcv daif -PAN -UAO)
>   pc : __pci_enable_msix_range+0x4e4/0x608
>   lr : __pci_enable_msix_range+0x498/0x608
>   sp : ffffff80117db700
>   x29: ffffff80117db700 x28: 0000000000000001
>   x27: 0000000000000001 x26: 0000000000000000
>   x25: ffffffd3e9d8c0b0 x24: 0000000000000000
>   x23: 0000000000000000 x22: 0000000000000000
>   x21: 0000000000000001 x20: 0000000000000000
>   x19: ffffffd3e9d8c000 x18: ffffffffffffffff
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: ffffff80116496c8 x14: ffffffd3e9844503
>   x13: ffffffd3e9844502 x12: 0000000000000038
>   x11: ffffffffffffff00 x10: 0000000000000040
>   x9 : ffffff801165e270 x8 : ffffff801165e268
>   x7 : 0000000000000002 x6 : 00000000000000b2
>   x5 : ffffffd3e9d8c2c0 x4 : 0000000000000000
>   x3 : 0000000000000000 x2 : 0000000000000000
>   x1 : 0000000000000000 x0 : ffffffd3e9844680
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>   CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-14847-ge76f1d4a1828-dirty #33
>   Hardware name: Annapurna Labs Alpine V3 EVP (DT)
>   Call trace:
>    dump_backtrace+0x0/0x140
>    show_stack+0x14/0x20
>    dump_stack+0xa8/0xcc
>    panic+0x140/0x334
>    nmi_panic+0x6c/0x70
>    arm64_serror_panic+0x74/0x88
>    __pte_error+0x0/0x28
>    el1_error+0x84/0xf8
>    __pci_enable_msix_range+0x4e4/0x608
>    pci_alloc_irq_vectors_affinity+0xdc/0x150
>    pcie_port_device_register+0x2b8/0x4e0
>    pcie_portdrv_probe+0x34/0xf0
> 
> Notice that this quirk also disables MSI (which may work, but hasn't
> been tested nor has a current use case), since currently there is no
> standard way to disable only MSI-X.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  drivers/pci/quirks.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

I will prepare this series for upstream but I would like to have Bjorn's
ACK before pushing it out since you updated this patch following his
review.

Thanks,
Lorenzo

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2e983f2a0ee9..c1077e806291 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2977,6 +2977,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
>  			quirk_msi_intx_disable_qca_bug);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
>  			quirk_msi_intx_disable_qca_bug);
> +
> +/*
> + * Amazon's Annapurna Labs 1c36:0031 Root Ports don't support MSI-X, so it
> + * should be disabled on platforms where the device (mistakenly) advertises it.
> + *
> + * Notice that this quirk also disables MSI (which may work, but hasn't been
> + * tested), since currently there is no standard way to disable only MSI-X.
> + *
> + * The 0031 device id is reused for other non Root Port device types,
> + * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> + */
> +static void quirk_al_msi_disable(struct pci_dev *dev)
> +{
> +	dev->no_msi = 1;
> +	pci_warn(dev, "Disabling MSI/MSI-X\n");
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_msi_disable);
>  #endif /* CONFIG_PCI_MSI */
>  
>  /*
> -- 
> 2.17.1
> 
