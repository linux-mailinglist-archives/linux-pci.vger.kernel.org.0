Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465CB31ED0D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhBRRN2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 12:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233913AbhBRQwD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 11:52:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47B1E64EB3;
        Thu, 18 Feb 2021 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613667008;
        bh=92qqsNKNLtQETmYq95JpSvV7z/qtYNHIl+uuhSbp41U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ha/QTsAIoUVp9c44+GpGrnWclaUGHIhd29nH8xrV1yz1URHEFONOiaMOpm82sNNfM
         1b7fUrjk0tVZGc5lnza6WvRTAqpSysWcauDvEPeQRWS2JlELbX/40TDGMROlLKCgmw
         8vOOT9C5HhwHLTMyUteJ7yytgxTcwXtk8ScIYmWg0+1pFQKRKrrtFxvexBaE3u/PY8
         qSOh16p1wxThaFAdpW75VooJvGCecUcD4nwOH6iasCI1M/wWz2na8vveAnOzvx5uAJ
         +Q0crPP+4O4atc5UpW6XyKmJRiq14xZ9SyRCpeUuj45oAAmOkh4/fCymsKScOObW56
         e1Iaipe1Q8MGA==
Date:   Thu, 18 Feb 2021 10:50:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     mingchuang.qiao@mediatek.com
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        lambert.wang@mediatek.com, kerun.zhu@mediatek.com,
        mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        rjw@rjwysocki.net, utkarsh.h.patel@intel.com
Subject: Re: [v4] PCI: Avoid unsync of LTR mechanism configuration
Message-ID: <20210218165006.GA983767@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204095125.9212-1-mingchuang.qiao@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 05:51:25PM +0800, mingchuang.qiao@mediatek.com wrote:
> From: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> 
> In bus scan flow, the "LTR Mechanism Enable" bit of DEVCTL2 register is
> configured in pci_configure_ltr(). If device and bridge both support LTR
> mechanism, the "LTR Mechanism Enable" bit of device and bridge will be
> enabled in DEVCTL2 register. And pci_dev->ltr_path will be set as 1.
> 
> If PCIe link goes down when device resets, the "LTR Mechanism Enable" bit
> of bridge will change to 0 according to PCIe r5.0, sec 7.5.3.16. However,
> the pci_dev->ltr_path value of bridge is still 1.
> 
> For following conditions, check and re-configure "LTR Mechanism Enable" bit
> of bridge to make "LTR Mechanism Enable" bit match ltr_path value.
>    -before configuring device's LTR for hot-remove/hot-add
>    -before restoring device's DEVCTL2 register when restore device state

There's definitely a bug here.  The commit log should say a little
more about what it is.  I *think* if LTR is enabled and we suspend
(putting the device in D3cold) and resume, LTR probably doesn't work
after resume because LTR is disabled in the upstream bridge, which
would be an obvious bug.

Also, if a device with LTR enabled is hot-removed, and we hot-add a
device, I think LTR will not work on the new device.  Possibly also a
bug, although I'm not convinced we know how to configure LTR on the
new device anyway.

So I'd *like* to merge the bug fix for v5.12, but I think I'll wait
because of the issue below.

> Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> ---
> changes of v4
>  -fix typo of commit message
>  -rename: pci_reconfigure_bridge_ltr()->pci_bridge_reconfigure_ltr()
> changes of v3
>  -call pci_reconfigure_bridge_ltr() in probe.c
> changes of v2
>  -modify patch description
>  -reconfigure bridge's LTR before restoring device DEVCTL2 register
> ---
>  drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 13 ++++++++++---
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc25d213..6bf65d295331 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1437,6 +1437,24 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +void pci_bridge_reconfigure_ltr(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCIEASPM
> +	struct pci_dev *bridge;
> +	u32 ctl;
> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (bridge && bridge->ltr_path) {
> +		pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
> +		if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
> +			pci_dbg(bridge, "re-enabling LTR\n");
> +			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> +						 PCI_EXP_DEVCTL2_LTR_EN);

This pattern of updating the upstream bridge on behalf of "dev" is
problematic because it's racy:

  CPU 1                     CPU 2
  -------------------       ---------------------
  ctl = read DEVCTL2        ctl = read(DEVCTL2)
  ctl |= DEVCTL2_LTR_EN     ctl |= DEVCTL2_ARI
  write(DEVCTL2, ctl)
                            write(DEVCTL2, ctl)

Now the bridge has ARI set, but not LTR_EN.

We have the same problem in the pci_enable_device() path.  The most
recent try at fixing it is [1].

[1] https://lore.kernel.org/linux-pci/20201218174011.340514-2-s.miroshnichenko@yadro.com/

> +		}
> +	}
> +#endif
> +}
> +
>  static void pci_restore_pcie_state(struct pci_dev *dev)
>  {
>  	int i = 0;
> @@ -1447,6 +1465,13 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  	if (!save_state)
>  		return;
>  
> +	/*
> +	 * Downstream ports reset the LTR enable bit when link goes down.
> +	 * Check and re-configure the bit here before restoring device.
> +	 * PCIe r5.0, sec 7.5.3.16.
> +	 */
> +	pci_bridge_reconfigure_ltr(dev);
> +
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5c59365092fa..b3a5e5287cb7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -111,6 +111,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> +void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
>  
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..ade055e9fb58 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2132,9 +2132,16 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  	 * Complex and all intermediate Switches indicate support for LTR.
>  	 * PCIe r4.0, sec 6.18.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    ((bridge = pci_upstream_bridge(dev)) &&
> -	      bridge->ltr_path)) {
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +					 PCI_EXP_DEVCTL2_LTR_EN);
> +		dev->ltr_path = 1;
> +		return;
> +	}
> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (bridge && bridge->ltr_path) {
> +		pci_bridge_reconfigure_ltr(dev);
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_LTR_EN);
>  		dev->ltr_path = 1;
> -- 
> 2.18.0
