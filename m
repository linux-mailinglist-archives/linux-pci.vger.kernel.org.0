Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054592F3FB8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbhALWdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 17:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbhALWdL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 17:33:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC3782312E;
        Tue, 12 Jan 2021 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610490750;
        bh=HbhpXWVmhkkfnSvFBX49OI5jxpkPszC60LZh3cJi1Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bpj8BSauJKq3YXIavFPhJPoAz74GKaMOc/RTpP1iTffeuVvsdUAErdnV/Vew4NB/5
         sjZWaEqvcd5iqv60Gwp7oXKQNB6l6utqo8URcvUCSpwBHpaEILZd3fhtJVa7okanB5
         kLVMJHDc2fGIwwC0p/WJ29PitwS2cIaLxUUOI0A70LXWfPK0dOgBIHsu3N7feK1yCR
         0AEx3TcBXm0Q+To5+f8G8XpiBinPit0h6bsEcdH8YbTrOJxlWBCNrx1T+zDdD0I16F
         WISC61JQwEutfJAVaGhFynC5boos/XsitMbyPGHQmQRF+vicZnPzsYpkpXYTJCCjH8
         cgnvzpwyMUblQ==
Date:   Tue, 12 Jan 2021 16:32:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Victor Ding <victording@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Alex Levin <levinale@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Disable ASPM until its LTR and L1ss state
 is restored
Message-ID: <20210112223228.GA1857596@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112040146.1.I9aa2b9dd39a6ac9235ec55a8c56020538aa212fb@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Victor,

Thanks for the patch.  Improving suspend/resume performance is always
a good thing!

On Tue, Jan 12, 2021 at 04:02:04AM +0000, Victor Ding wrote:
> Right after powering up, the device may have ASPM enabled; however,
> its LTR and/or L1ss controls may not be in the desired states; hence,
> the device may enter L1.2 undesirably and cause resume performance
> penalty. This is especially problematic if ASPM related control
> registers are modified before a suspension.

s/L1ss/L1SS/ (several occurrences) to match existing usage.

> Therefore, ASPM should disabled until its LTR and L1ss states are
> fully restored.
> 
> Signed-off-by: Victor Ding <victording@google.com>
> ---
> 
>  drivers/pci/pci.c       | 11 +++++++++++
>  drivers/pci/pci.h       |  2 ++
>  drivers/pci/pcie/aspm.c |  2 +-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index eb323af34f1e..428de433f2e6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1660,6 +1660,17 @@ void pci_restore_state(struct pci_dev *dev)
>  	if (!dev->state_saved)
>  		return;
>  
> +	/*
> +	 * Right after powering up, the device may have ASPM enabled;

I think this could be stated more precisely.  "Right after powering
up," ASPM should be *disabled* because ASPM Control in the Link
Control register powers up as zero (disabled).

> +	 * however, its LTR and/or L1ss controls may not be in the desired
> +	 * states; as a result, the device may enter L1.2 undesirably and
> +	 * cause resume performance penalty.
> +	 * Therefore, ASPM is disabled until its LTR and L1ss states are
> +	 * fully restored.
> +	 * (enabling ASPM is part of pci_restore_pcie_state)

If we're enabling L1.2 before LTR has been configured, that's
definitely a bug.  But I don't see how that happens.  The current code
looks like:

  pci_restore_state
    pci_restore_ltr_state
      pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++)
      pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++)
    pci_restore_aspm_l1ss_state
      pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++)
    pci_restore_pcie_state
      pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++])

We *do* restore PCI_L1SS_CTL1, which contains "ASPM L1.2 Enable",
before we restore PCI_EXP_LNKCTL, which contains "ASPM Control", but I
don't think "ASPM L1.2 Enable" by itself should be enough to allow
hardware to enter L1.2.

Reading PCIe r5.0, sec 5.5.1, it seems like hardware should ignore the
PCI_L1SS_CTL1 bits unless ASPM L1 entry is enabled in PCI_EXP_LNKCTL.

What am I missing?

> +	 */
> +	pcie_config_aspm_dev(dev, 0);
> +
>  	/*
>  	 * Restore max latencies (in the LTR capability) before enabling
>  	 * LTR itself (in the PCIe capability).
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e9ea5dfaa3e0..f774bd6d2555 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -564,6 +564,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val);
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  #else
> @@ -571,6 +572,7 @@ static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val) { }
>  static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>  static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>  #endif
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a08e7d6dc248..45535b4e1595 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -778,7 +778,7 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>  	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>  }
>  
> -static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> +void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  {
>  	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
>  					   PCI_EXP_LNKCTL_ASPMC, val);
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
