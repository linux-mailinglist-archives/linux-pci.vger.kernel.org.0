Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581C23105E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgG1REf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 13:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1REf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 13:04:35 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F16D2074F;
        Tue, 28 Jul 2020 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595955874;
        bh=MgYgMrmuz6zcIhySKtmmbw6L/GdzegrD2SqtRH5ZIS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=00vkpUZs0vJ/iMqiL1dkU+pXCdQ1Ki9u9KyB999+sNTzLEMkauNvrPSKbjyMCVfzH
         QkKGHrgTobJwJ8Cs66vczwZRVy/2zkVzL7ywu8yAINIJjJrAYQONq8N0xT6mHjtldz
         eG+no87CowdU8XWzaj0+Mxc6qM0e553xkyFxRZFw=
Date:   Tue, 28 Jul 2020 12:04:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: Re: [RFC] PCI: vmd: Enable ASPM if BIOS requests it
Message-ID: <20200728170431.GA1843639@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728161321.38229-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 12:13:21PM -0400, Jon Derrick wrote:
> VMD domains are not ACPI-managed devices and do not have the necessary
> ACPI hooks to enable ASPM. However if the BIOS has requested ASPM
> enablement, we should try to honor that request regardless. This patch
> adds the ASPM support to VMD child devices if requested by the FADT
> table.

ASPM is enabled by software but the actual link state transitions
between L0, L0s, L1, etc are done autonomously by hardware.

There should be no functional difference between ASPM being disabled
vs being enabled.  The only difference should be power consumption and
some latency.

There are no ACPI hooks required to enable ASPM.  The
ACPI_FADT_NO_ASPM bit tells the OS that "it must not enable OSPM ASPM
control" (ACPI v6.3, sec 5.2.9.3).  AFAIK there is nothing in ACPI
to request that the OS *should* enable ASPM.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
> ---
> 
> Hi,
> 
> My knowledge on these kinds of power modes is limited, and we are having
> trouble bringing the Root Port child device out of L1 with this patch.

Presumably this patch helps something.  Do you mean you're having
trouble *without* this patch?

> Can you help me understand the correct flow for bringing the Root Port
> device out of L1 with kernel flow, and what I might be missing here?

I don't understand the issue yet.  L1 is a state of the link, not of
an individual device.  The devices on both ends of the link, e.g., a
Root Port and an Endpoint or Switch Upstream Port below it, negotiate
to determine the link state.  This all happens in hardware without
software involvement.

The only software influence is to enable hardware to select certain
link states.

>  drivers/pci/controller/vmd.c |  9 ++++++++-
>  drivers/pci/pcie/aspm.c      | 19 ++-----------------
>  include/linux/pci.h          | 17 +++++++++++++++++
>  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 76d8acbee7d5..f1b058efb642 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -14,6 +14,7 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/irqdomain.h>
>  #include <asm/device.h>
> @@ -601,8 +602,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 * and will fail pcie_bus_configure_settings() early. It can instead be
>  	 * run on each of the real root ports.
>  	 */
> -	list_for_each_entry(child, &vmd->bus->children, node)
> +	list_for_each_entry(child, &vmd->bus->children, node) {
> +#if IS_ENABLED(CONFIG_PCIEASPM)
> +		if (!(acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM))
> +			pcie_config_aspm_link(child->self->link_state,
> +					      ASPM_STATE_ALL);
> +#endif

pcie_aspm_init_link_state() is called from pci_scan_slot() and should
be doing ASPM configuration without help from VMD.  If that's not
happening, I would instrument pcie_aspm_init_link_state() to make sure
it's being called and to figure out if there's something there that
prevents ASPM config for children of the VMD device.

>  		pcie_bus_configure_settings(child);
> +	}
>  
>  	pci_bus_add_devices(vmd->bus);
>  
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 253c30cc1967..04cdb0b5a672 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -25,22 +25,6 @@
>  #endif
>  #define MODULE_PARAM_PREFIX "pcie_aspm."
>  
> -/* Note: those are not register definitions */
> -#define ASPM_STATE_L0S_UP	(1)	/* Upstream direction L0s state */
> -#define ASPM_STATE_L0S_DW	(2)	/* Downstream direction L0s state */
> -#define ASPM_STATE_L1		(4)	/* L1 state */
> -#define ASPM_STATE_L1_1		(8)	/* ASPM L1.1 state */
> -#define ASPM_STATE_L1_2		(0x10)	/* ASPM L1.2 state */
> -#define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
> -#define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
> -#define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
> -#define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
> -#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
> -				 ASPM_STATE_L1_2_MASK)
> -#define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
> -#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
> -				 ASPM_STATE_L1SS)
> -
>  struct aspm_latency {
>  	u32 l0s;			/* L0s latency (nsec) */
>  	u32 l1;				/* L1 latency (nsec) */
> @@ -748,7 +732,7 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  					   PCI_EXP_LNKCTL_ASPMC, val);
>  }
>  
> -static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
> +void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  {
>  	u32 upstream = 0, dwstream = 0;
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> @@ -798,6 +782,7 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  
>  	link->aspm_enabled = state;
>  }
> +EXPORT_SYMBOL_GPL(pcie_config_aspm_link);
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7a40cd5caed0..1c41781b160a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -377,6 +377,22 @@ struct pci_dev {
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
>  #ifdef CONFIG_PCIEASPM
> +/* Note: those are not register definitions */
> +#define ASPM_STATE_L0S_UP	(1)	/* Upstream direction L0s state */
> +#define ASPM_STATE_L0S_DW	(2)	/* Downstream direction L0s state */
> +#define ASPM_STATE_L1		(4)	/* L1 state */
> +#define ASPM_STATE_L1_1		(8)	/* ASPM L1.1 state */
> +#define ASPM_STATE_L1_2		(0x10)	/* ASPM L1.2 state */
> +#define ASPM_STATE_L1_1_PCIPM	(0x20)	/* PCI PM L1.1 state */
> +#define ASPM_STATE_L1_2_PCIPM	(0x40)	/* PCI PM L1.2 state */
> +#define ASPM_STATE_L1_SS_PCIPM	(ASPM_STATE_L1_1_PCIPM | ASPM_STATE_L1_2_PCIPM)
> +#define ASPM_STATE_L1_2_MASK	(ASPM_STATE_L1_2 | ASPM_STATE_L1_2_PCIPM)
> +#define ASPM_STATE_L1SS		(ASPM_STATE_L1_1 | ASPM_STATE_L1_1_PCIPM |\
> +				 ASPM_STATE_L1_2_MASK)
> +#define ASPM_STATE_L0S		(ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)
> +#define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
> +				 ASPM_STATE_L1SS)
> +
>  	struct pcie_link_state	*link_state;	/* ASPM link state */
>  	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>  					   supported from root to here */
> @@ -1577,6 +1593,7 @@ extern bool pcie_ports_native;
>  #define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
>  
>  #ifdef CONFIG_PCIEASPM
> +void pcie_config_aspm_link(struct pcie_link_state *link, u32 state);
>  int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
> -- 
> 2.18.1
> 
