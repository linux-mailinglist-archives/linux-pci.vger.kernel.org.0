Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0992F3FDB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405879AbhALWjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 17:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:32984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405867AbhALWjN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 17:39:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D902E230FC;
        Tue, 12 Jan 2021 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610491112;
        bh=Not6rzcsIHJAa5JJsg07kmYgInRoBPbOBQd5ATdCk6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uYTdY3h2pRt38dQQxdL/y2FNEX07l8/XvnnXqouJMvgjXTi5RmWeAh/0+eFNnrlzk
         JlsFbjtRwuLzXjgBKpd2RH1rW3FOUJWCDL4PpXRxtRfg6w18o75omVkZvM8m5rd1SN
         kdU/w/W0Y8Mkc24JJD1rmA50J1SUmJZ//LwVynagTRY7U0Vbpw9BjDthkmPE2B86hs
         7sB81ogR8YJ179HSvHR31rA/Q4HRoGAW08rRE++cuga3EiY9aRZVCWn9jnS888sxcg
         Ih0E3msf6agu14NBBBq1RW/BC+oi3VkVb7+OXmhQstWSRSwK9RWcZ3KuECKXa2WRiw
         TEMb9103fNT1g==
Date:   Tue, 12 Jan 2021 16:38:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Victor Ding <victording@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: Disable ASPM during a suspension
Message-ID: <20210112223830.GA1858627@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112040146.2.Ic902bbd9f04e2d82ac578411e7fafc77b6c750e2@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 04:02:05AM +0000, Victor Ding wrote:
> GL9750 has a 3100us PortTPowerOnTime; however, it enters L1.2 after
> only ~4us inactivity per PCIe trace. During a suspend/resume process,
> PCI access operations are frequently longer than 4us apart.
> Therefore, the device frequently enters and leaves L1.2 during this
> process, causing longer than desirable suspend/resume time. The total
> time cost due to this L1.2 exit latency could add up to ~200ms.
> 
> Considering that PCI access operations are fairly close to each other
> (though sometimes > 4us), the actual time the device could stay in
> L1.2 is negligible. Therefore, the little power-saving benefit from
> ASPM during suspend/resume does not overweight the performance
> degradation caused by long L1.2 exit latency.
> 
> Therefore, this patch proposes to disable ASPM during a suspend/resume
> process.

This sounds like an interesting idea, but it doesn't seem like
anything that's really device-dependent.  Drivers should not need to
be involved in PCI configuration at this level, and they shouldn't
read/write registers like PCI_EXP_LNKCTL directly.

If we need to disable ASPM during suspend, I'd rather do it in the PCI
core so all devices can benefit and drivers don't need to worry about
it.

> Signed-off-by: Victor Ding <victording@google.com>
> ---
> 
>  drivers/mmc/host/sdhci-pci-core.c |  2 +-
>  drivers/mmc/host/sdhci-pci-gli.c  | 46 +++++++++++++++++++++++++++++--
>  drivers/mmc/host/sdhci-pci.h      |  1 +
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9552708846ca..fd7544a498c0 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -67,7 +67,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
>  	return 0;
>  }
>  
> -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>  {
>  	int i, ret;
>  
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9887485a4134..c7b788b0e22e 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -109,6 +109,12 @@
>  
>  #define GLI_MAX_TUNING_LOOP 40
>  
> +#ifdef CONFIG_PM_SLEEP
> +struct gli_host {
> +	u16 linkctl_saved;
> +};
> +#endif
> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -577,14 +583,48 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> +static int sdhci_pci_gli_suspend(struct sdhci_pci_chip *chip)
> +{
> +	int ret;
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	struct gli_host *gli_host = sdhci_pci_priv(slot);
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL,
> +			&gli_host->linkctl_saved);
> +	if (ret)
> +		goto exit;
> +
> +	ret = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
> +			gli_host->linkctl_saved & ~PCI_EXP_LNKCTL_ASPMC);
> +	if (ret)
> +		goto exit;
> +
> +	ret = sdhci_pci_suspend_host(chip);
> +
> +exit:
> +	return ret;
> +}
> +
>  static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>  {
> +	int ret;
>  	struct sdhci_pci_slot *slot = chip->slots[0];
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	struct gli_host *gli_host = sdhci_pci_priv(slot);
>  
> -	pci_free_irq_vectors(slot->chip->pdev);
> +	pci_free_irq_vectors(pdev);
>  	gli_pcie_enable_msi(slot);
>  
> -	return sdhci_pci_resume_host(chip);
> +	ret = sdhci_pci_resume_host(chip);
> +	if (ret)
> +		goto exit;
> +
> +	ret = pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> +			PCI_EXP_LNKCTL_ASPMC, gli_host->linkctl_saved);
> +
> +exit:
> +	return ret;
>  }
>  
>  static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> @@ -834,7 +874,9 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
>  	.probe_slot	= gli_probe_slot_gl9750,
>  	.ops            = &sdhci_gl9750_ops,
>  #ifdef CONFIG_PM_SLEEP
> +	.suspend        = sdhci_pci_gli_suspend,
>  	.resume         = sdhci_pci_gli_resume,
> +	.priv_size      = sizeof(struct gli_host),
>  #endif
>  };
>  
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index d0ed232af0eb..16187a265e63 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -187,6 +187,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
>  #endif
>  int sdhci_pci_enable_dma(struct sdhci_host *host);
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
