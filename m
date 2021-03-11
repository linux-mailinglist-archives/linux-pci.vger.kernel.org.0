Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC1337AED
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 18:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCKRfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 12:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhCKReg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 12:34:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69BE264F90;
        Thu, 11 Mar 2021 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615484075;
        bh=iNN2zownLKbHetBsCygEAW1/v3+W5uETEqkoW22vGqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=agrMrkebeT9PSY05fmnsQZQ1qFj5ZUo2w9A7Tr3yAW/SE1BLeFHMZQ54WAMGbdPjT
         7CjAwF7Hn1GLjANBtsdQDfL+qeRhl6m5QHmljdhuK+u4124mq3++zF0iLae9q4KU9r
         F4Gj+B1znOTW2rbo5yOP4TO7KfUweT4ZzMGdoP4lcmUVxalCwVVGmlKQZcSnrZa42H
         DYvYAm6cneoyBmEYVn2jhkPbOKLeTg5U3X1rYiOKdVbSTHYtGH9ffkgi46xwwvUg5D
         34tSLrDQtzGdihPp97ACXWSR9JYostQgLKWL8DaGM2ceVquWxiXsQjMo1uOft8PJiZ
         hokHJnW7khpyg==
Date:   Thu, 11 Mar 2021 11:34:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Victor Ding <victording@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v2] PCI/ASPM: Disable ASPM when save/restore PCI state
Message-ID: <20210311173433.GA2071075@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128155237.v2.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 03:52:42PM +0000, Victor Ding wrote:
> Certain PCIe devices (e.g. GL9750) have high penalties (e.g. high Port
> T_POWER_ON) when exiting L1 but enter L1 aggressively. As a result,
> such devices enter and exit L1 frequently during pci_save_state and
> pci_restore_state; eventually causing poor suspend/resume performance.
> 
> Based on the observation that PCI accesses dominance pci_save_state/
> pci_restore_state plus these accesses are fairly close to each other, the
> actual time the device could stay in low power states is negligible.
> Therefore, the little power-saving benefit from ASPM during suspend/resume
> does not overweight the performance degradation caused by high L1 exit
> penalties.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211187

Thanks for this!

This device can tolerate unlimited delay for L1 exit (DevCtl Endpoint
L1 Acceptable Latency is unlimited) and it makes no guarantees about
how fast it can exit L1 (LnkCap L1 Exit Latency is also unlimited), so
I think there's basically no restriction on when it can enter ASPM
L1.0.

I have a hard time interpreting the L1.2 entry conditions in PCIe
r5.0, sec 5.5.1, but I can believe it enters L1.2 aggressively since
the device says it can tolerate any latencies.

If L1.2 exit takes 3100us, it could do ~60 L1 exits in 200ms.  I guess
config accesses and code execution can account for some of that, but
still seems like a lot of L1 entries/exits during suspend.  I wouldn't
think we would touch the device that much and that intermittently.

> Signed-off-by: Victor Ding <victording@google.com>
> 
> ---
> 
> Changes in v2:
> - Updated commit message to remove unnecessary information
> - Fixed a bug reading wrong register in pcie_save_aspm_control
> - Updated to reuse existing pcie_config_aspm_dev where possible
> - Fixed goto label style
> 
>  drivers/pci/pci.c       | 18 +++++++++++++++---
>  drivers/pci/pci.h       |  6 ++++++
>  drivers/pci/pcie/aspm.c | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h     |  1 +
>  4 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 32011b7b4c04..9ea88953f90b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1542,6 +1542,10 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>  int pci_save_state(struct pci_dev *dev)
>  {
>  	int i;
> +
> +	pcie_save_aspm_control(dev);
> +	pcie_disable_aspm(dev);

If I understand this patch correctly, it basically does this:

    pci_save_state
  +   pcie_save_aspm_control
  +   pcie_disable_aspm
      <save state>
  +   pcie_restore_aspm_control

The <save state> part is just a bunch of config reads with very little
other code execution.  I'm really surprised that there's enough time
between config reads for the link to go to L1.  I guess you've
verified that this does speed up suspend significantly, but this just
doesn't make sense to me.

In the bugzilla you say the GL9750 can go to L1.2 after ~4us of
inactivity.  That's enough time for a lot of code execution.  We must
be missing something.  There's so much PCI traffic during save/restore
that it should be easy to match up the analyzer trace with the code.
Can you get any insight into what's going on that way?

>  	/* XXX: 100% dword access ok here? */
>  	for (i = 0; i < 16; i++) {
>  		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> @@ -1552,18 +1556,22 @@ int pci_save_state(struct pci_dev *dev)
>  
>  	i = pci_save_pcie_state(dev);
>  	if (i != 0)
> -		return i;
> +		goto exit;
>  
>  	i = pci_save_pcix_state(dev);
>  	if (i != 0)
> -		return i;
> +		goto exit;
>  
>  	pci_save_ltr_state(dev);
>  	pci_save_aspm_l1ss_state(dev);
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
>  	pci_save_ptm_state(dev);
> -	return pci_save_vc_state(dev);
> +	i = pci_save_vc_state(dev);
> +
> +exit:
> +	pcie_restore_aspm_control(dev);
> +	return i;
>  }
>  EXPORT_SYMBOL(pci_save_state);
>  
> @@ -1661,6 +1669,8 @@ void pci_restore_state(struct pci_dev *dev)
>  	if (!dev->state_saved)
>  		return;
>  
> +	pcie_disable_aspm(dev);
> +
>  	/*
>  	 * Restore max latencies (in the LTR capability) before enabling
>  	 * LTR itself (in the PCIe capability).
> @@ -1689,6 +1699,8 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  	pci_restore_iov_state(dev);
>  
> +	pcie_restore_aspm_control(dev);
> +
>  	dev->state_saved = false;
>  }
>  EXPORT_SYMBOL(pci_restore_state);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a81459159f6d..e074a0cbe73c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -584,6 +584,9 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> +void pcie_save_aspm_control(struct pci_dev *dev);
> +void pcie_restore_aspm_control(struct pci_dev *dev);
> +void pcie_disable_aspm(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> @@ -591,6 +594,9 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>  static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> +static inline void pcie_save_aspm_control(struct pci_dev *dev) { }
> +static inline void pcie_restore_aspm_control(struct pci_dev *dev) { }
> +static inline void pcie_disable_aspm(struct pci_dev *pdev) { }
>  #endif
>  
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a08e7d6dc248..e1e97db32e8b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -784,6 +784,33 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  					   PCI_EXP_LNKCTL_ASPMC, val);
>  }
>  
> +void pcie_disable_aspm(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	pcie_config_aspm_dev(pdev, 0);
> +}
> +
> +void pcie_save_aspm_control(struct pci_dev *pdev)
> +{
> +	u16 lnkctl;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
> +	pdev->saved_aspm_ctl = lnkctl & PCI_EXP_LNKCTL_ASPMC;
> +}
> +
> +void pcie_restore_aspm_control(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	pcie_config_aspm_dev(pdev, pdev->saved_aspm_ctl);
> +}
> +
>  static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  {
>  	u32 upstream = 0, dwstream = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b32126d26997..a21bfd6e3f89 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -387,6 +387,7 @@ struct pci_dev {
>  	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>  					   supported from root to here */
>  	u16		l1ss;		/* L1SS Capability pointer */
> +	u16		saved_aspm_ctl; /* ASPM Control saved at suspend time */
>  #endif
>  	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
>  
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 
