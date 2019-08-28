Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021C6A0342
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfH1NbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 09:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfH1NbG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 09:31:06 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0783322DA7;
        Wed, 28 Aug 2019 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566999065;
        bh=8tL/BwaMTgaHn8IHnFMvKIx3ug7jMnEVbHbcYLAdxW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+LTaOFEVrs4cfjga+T9CcPJG0KwVRlkDWGhI+aoFYodkIKUkQgLTVWay5WFUPKM4
         N2wxfgzW4kLHghyA/FASQ7WaBAvlVa25efCoEydHchkZMfLQSFkf7dR1dVM8r33ASn
         cK5lgQHVdUAjQTLRxoIjPs5flyjifhqrV3r6buso=
Date:   Wed, 28 Aug 2019 08:31:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Move PCI Express ASPM function prototypes and
 definitions to pci.h
Message-ID: <20190828133103.GC4550@google.com>
References: <20190827095620.11213-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095620.11213-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 11:56:20AM +0200, Krzysztof Wilczynski wrote:
> Merge PCI Express ASPM function prototypes and definitions
> from include/linux/pci-aspm.h into include/linux/pci.h.
> 
> Function prototypes to move are pci_disable_link_state(),
> pci_disable_link_state_locked(), pcie_no_aspm() and
> pcie_aspm_support_enabled(), and definitions to move
> are PCIE_LINK_STATE_L0S, PCIE_LINK_STATE_L1 and
> PCIE_LINK_STATE_CLKPM.
> 
> There are no functional changes.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

I replaced the leading spaces in the copyright lines with tabs to
match the others and applied to pci/aspm for v5.4, thanks!

> ---
>  drivers/acpi/pci_root.c                       |  1 -
>  drivers/char/xillybus/xillybus_pcie.c         |  1 -
>  drivers/net/ethernet/intel/e1000e/e1000.h     |  1 -
>  drivers/net/ethernet/jme.c                    |  1 -
>  drivers/net/ethernet/realtek/r8169_main.c     |  1 -
>  drivers/net/wireless/ath/ath5k/pci.c          |  1 -
>  .../net/wireless/intel/iwlegacy/3945-mac.c    |  1 -
>  .../net/wireless/intel/iwlegacy/4965-mac.c    |  1 -
>  .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 -
>  drivers/pci/pci-acpi.c                        |  1 -
>  drivers/pci/pcie/aspm.c                       |  1 -
>  drivers/pci/quirks.c                          |  1 -
>  drivers/scsi/aacraid/linit.c                  |  1 -
>  drivers/scsi/hpsa.c                           |  1 -
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c          |  1 -
>  include/linux/pci-aspm.h                      | 36 -------------------
>  include/linux/pci.h                           | 18 ++++++++++
>  17 files changed, 18 insertions(+), 51 deletions(-)
>  delete mode 100644 include/linux/pci-aspm.h
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 314a187ed572..d1e666ef3fcc 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -15,7 +15,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/dmar.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
> diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
> index 02c15952b103..18b0c392bc93 100644
> --- a/drivers/char/xillybus/xillybus_pcie.c
> +++ b/drivers/char/xillybus/xillybus_pcie.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/module.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/slab.h>
>  #include "xillybus.h"
>  
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index 34cd67951aec..6c51b1bad8c4 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -13,7 +13,6 @@
>  #include <linux/io.h>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/crc32.h>
>  #include <linux/if_vlan.h>
>  #include <linux/timecounter.h>
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index 0b668357db4d..57e8aea98969 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -14,7 +14,6 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index e1dd6ea60d67..a8f373e49505 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -28,7 +28,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/prefetch.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/ipv6.h>
>  #include <net/ip6_checksum.h>
>  
> diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
> index c6156cc38940..d5ee32ce9eb3 100644
> --- a/drivers/net/wireless/ath/ath5k/pci.c
> +++ b/drivers/net/wireless/ath/ath5k/pci.c
> @@ -18,7 +18,6 @@
>  
>  #include <linux/nl80211.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/etherdevice.h>
>  #include <linux/module.h>
>  #include "../ath.h"
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index b82da75a9ae3..4fbcc7fba3cc 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -18,7 +18,6 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index fa2c02881939..ffb705b18fb1 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -18,7 +18,6 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index f5df5b370d78..4c308e33ee21 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -62,7 +62,6 @@
>   *
>   *****************************************************************************/
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/interrupt.h>
>  #include <linux/debugfs.h>
>  #include <linux/sched.h>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 45049f558860..dd520fe927db 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -14,7 +14,6 @@
>  #include <linux/msi.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/module.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/pci-acpi.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e44af7f4d37f..ad6259ec51a6 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -18,7 +18,6 @@
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
>  #include <linux/delay.h>
> -#include <linux/pci-aspm.h>
>  #include "../pci.h"
>  
>  #ifdef MODULE_PARAM_PREFIX
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..9ac1a7564c9e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -20,7 +20,6 @@
>  #include <linux/delay.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/ioport.h>
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
> diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
> index 644f7f5c61a2..4a858789e6c5 100644
> --- a/drivers/scsi/aacraid/linit.c
> +++ b/drivers/scsi/aacraid/linit.c
> @@ -27,7 +27,6 @@
>  #include <linux/moduleparam.h>
>  #include <linux/pci.h>
>  #include <linux/aer.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 1bb6aada93fa..ac39ed79ccaa 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -21,7 +21,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/types.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 717ba0845a2a..27fdbc165446 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -51,7 +51,6 @@
>  #include <linux/workqueue.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/interrupt.h>
>  #include <linux/aer.h>
>  #include <linux/raid_class.h>
> diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
> deleted file mode 100644
> index 67064145d76e..000000000000
> --- a/include/linux/pci-aspm.h
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - *	aspm.h
> - *
> - *	PCI Express ASPM defines and function prototypes
> - *
> - *	Copyright (C) 2007 Intel Corp.
> - *		Zhang Yanmin (yanmin.zhang@intel.com)
> - *		Shaohua Li (shaohua.li@intel.com)
> - *
> - *	For more information, please consult the following manuals (look at
> - *	http://www.pcisig.com/ for how to get them):
> - *
> - *	PCI Express Specification
> - */
> -
> -#ifndef LINUX_ASPM_H
> -#define LINUX_ASPM_H
> -
> -#include <linux/pci.h>
> -
> -#define PCIE_LINK_STATE_L0S	1
> -#define PCIE_LINK_STATE_L1	2
> -#define PCIE_LINK_STATE_CLKPM	4
> -
> -#ifdef CONFIG_PCIEASPM
> -int pci_disable_link_state(struct pci_dev *pdev, int state);
> -int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> -void pcie_no_aspm(void);
> -#else
> -static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
> -{ return 0; }
> -static inline void pcie_no_aspm(void) { }
> -#endif
> -
> -#endif /* LINUX_ASPM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9f28..f07f52175606 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -6,12 +6,18 @@
>   *	Copyright 1994, Drew Eckhardt
>   *	Copyright 1997--1999 Martin Mares <mj@ucw.cz>
>   *
> + *      PCI Express ASPM defines and function prototypes
> + *      Copyright (c) 2007 Intel Corp.
> + *              Zhang Yanmin (yanmin.zhang@intel.com)
> + *              Shaohua Li (shaohua.li@intel.com)
> + *
>   *	For more information, please consult the following manuals (look at
>   *	http://www.pcisig.com/ for how to get them):
>   *
>   *	PCI BIOS Specification
>   *	PCI Local Bus Specification
>   *	PCI to PCI Bridge Specification
> + *	PCI Express Specification
>   *	PCI System Design Guide
>   */
>  #ifndef LINUX_PCI_H
> @@ -1565,9 +1571,21 @@ extern bool pcie_ports_native;
>  #define pcie_ports_native	false
>  #endif
>  
> +#define PCIE_LINK_STATE_L0S	1
> +#define PCIE_LINK_STATE_L1	2
> +#define PCIE_LINK_STATE_CLKPM	4
> +
>  #ifdef CONFIG_PCIEASPM
> +int pci_disable_link_state(struct pci_dev *pdev, int state);
> +int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> +void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  #else
> +static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
> +{ return 0; }
> +static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
> +{ return 0; }
> +static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  #endif
>  
> -- 
> 2.22.1
> 
