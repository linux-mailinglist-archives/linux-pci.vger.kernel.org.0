Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84A12865E8
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgJGR2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 13:28:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:7786 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbgJGR2x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 13:28:53 -0400
IronPort-SDR: K0HIRN/KUmkODLSWpTxVne3OH/b885xBH1cORRpNKIkshKiihbSY9Phg4KQ5dCIh9fItQH9g2K
 TSZXShCO5ETg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="144411819"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="144411819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 10:28:51 -0700
IronPort-SDR: 0e/WL67OF1SS3EUzmvW2mir+firZR9ovDYD8JbaZS63+sZHvwi1Am/7iTu3v5+y1B01G4PiStF
 BEp+pd2EnllQ==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="311835366"
Received: from jdelcan-mobl.amr.corp.intel.com (HELO [10.254.64.135]) ([10.254.64.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 10:28:51 -0700
Subject: Re: [PATCH v8 2/6] PCI/DPC: define a function to check and wait till
 port finish DPC handling
To:     Ethan Zhao <haifeng.zhao@intel.com>, bhelgaas@google.com,
        oohall@gmail.com, ruscur@russell.cc, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, xerces.zhao@gmail.com
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
 <20201007113158.48933-3-haifeng.zhao@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Message-ID: <4bedeb35-942e-5ad3-9721-62495af1f09a@intel.com>
Date:   Wed, 7 Oct 2020 10:28:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007113158.48933-3-haifeng.zhao@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/7/20 4:31 AM, Ethan Zhao wrote:
> Once root port DPC capability is enabled and triggered, at the beginning
> of DPC is triggered, the DPC status bits are set by hardware and then
> sends DPC/DLLSC/PDC interrupts to OS DPC and pciehp drivers, it will
> take the port and software DPC interrupt handler 10ms to 50ms (test data
> on ICS(Ice Lake SP platform, see
> https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server)
> & stable 5.9-rc6) to complete the DPC containment procedure
This data is based on one particular architecture. So using this
to create a timed loop in pci_wait_port_outdpc() looks incorrect.

I still recommend looking for some locking model to fix this
issue (may be atomic state flag or lock).
> till the DPC status is cleared at the end of the DPC interrupt handler.
>
> We use this function to check if the root port is in DPC handling status
> and wait till the hardware and software completed the procedure.
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> ---
> changes:
>   v2：align ICS code name to public doc.
>   v3: no change.
>   v4: response to Christoph's (Christoph Hellwig <hch@infradead.org>)
>       tip, move pci_wait_port_outdpc() to DPC driver and its declaration
>       to pci.h.
>   v5: fix building issue reported by lkp@intel.com with some config.
>   v6: move from [1/5] to [2/5].
>   v7: no change.
>   v8: no change.
>
>   drivers/pci/pci.h      |  2 ++
>   drivers/pci/pcie/dpc.c | 27 +++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..455b32187abd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -455,10 +455,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
>   void pci_dpc_init(struct pci_dev *pdev);
>   void dpc_process_error(struct pci_dev *pdev);
>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> +bool pci_wait_port_outdpc(struct pci_dev *pdev);
>   #else
>   static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>   static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>   static inline void pci_dpc_init(struct pci_dev *pdev) {}
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev) { return false; }
>   #endif
>   
>   #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index daa9a4153776..2e0e091ce923 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -71,6 +71,33 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>   	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
>   }
>   
> +bool pci_wait_port_outdpc(struct pci_dev *pdev)
> +{
> +	u16 cap = pdev->dpc_cap, status;
> +	u16 loop = 0;
> +
> +	if (!cap) {
> +		pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");
> +		return false;
> +	}
> +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
> +
> +	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> +		msleep(10);
> +		loop++;
> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	}
> +
> +	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +		pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop*10);
> +		return true;
> +	}
> +
> +	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> +	return false;
> +}
> +
>   static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>   {
>   	unsigned long timeout = jiffies + HZ;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

