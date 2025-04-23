Return-Path: <linux-pci+bounces-26616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27851A999DA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1271B80A0A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8C26A091;
	Wed, 23 Apr 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj1KmQko"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8E269AFA;
	Wed, 23 Apr 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442296; cv=none; b=qXKaRkiTGMyB6tD2Wpcrn0ZetXsl4kI+FUpqkEQXD6r6H061/m0a7LgU9tmnA7osKPPy7mSZh9Z71AoIqOsLTtHJiQWPV6622W+N4FeS7dFt9OglhB+uGZkG+1/wRU94lRCU5foSSZhur05pBLnSFr0jr/tzxe04uHUdDi/xM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442296; c=relaxed/simple;
	bh=aXqT5XtitnkldrsxEDaBFSlooYja5bwOiS4GDTCcI/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A61wHB2pVkHcUEx579UMMVU9TxseZEsy+QZ5apu4W3On3hyPoX8Y86V0Hd5KDWJWH6uMtroV/cRzPqxr68kjwdRjg/bp1djHFlu/BhFv0ITtrv9LC4rChcrNzrbRUWXXoGIZsE8c5QCAfPbp5l0pyjOQylM4PovHDfPno0JF/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj1KmQko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B22DC4CEEA;
	Wed, 23 Apr 2025 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745442295;
	bh=aXqT5XtitnkldrsxEDaBFSlooYja5bwOiS4GDTCcI/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nj1KmQkoMgx1HAbgBaidts15bsLXG72LDiXdT9T4D/0U3ALD99qH7TZoZlrZvqYdc
	 akkgJhegUxbAu1MnaWo9OmkeaqzDPTbWluxBLbhrl0XE8yDOTeIjhPRrCYQy3NXFxc
	 6HCTaBm4Z3ORL3ijoDIa8Eemh5FCCQ5OBC8NCX4g7Eu63UvD3KDXsMlvZD7jm52Hml
	 vDGlKZ1/aDTSjjxY0VxAAX95k+kxfxA9LS0vmRD0gsV2OnAS6C5ooKgK/Z5QQOQXKX
	 w8P7cO8DrvLmKJT0d77zcUFPzmRau+bWPSFhP4LUvk6OMazQ0nqZzlrFxnQs7MK3UH
	 BMt7MYRC6pSAQ==
Date: Wed, 23 Apr 2025 16:04:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with
 PCI_LINK_LBMS_SEEN flag
Message-ID: <20250423210454.GA455057@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>

On Tue, Apr 22, 2025 at 02:55:47PM +0300, Ilpo Järvinen wrote:
> PCIe BW controller counts LBMS assertions for the purposes of the
> Target Speed quirk. It was also a plan to expose the LBMS count through
> sysfs to allow better diagnosing link related issues. Lukas Wunner
> suggested, however, that adding a trace event would be better for
> diagnostics purposes. Leaving only Target Speed quirk as an user of the
> lbms_count.
> 
> The logic in the Target Speed quirk does not require keeping count of
> LBMS assertions but a simple flag is enough which can be placed into
> pci_dev's priv_flags. The reduced complexity allows removing
> pcie_bwctrl_lbms_rwsem.
> 
> As bwctrl is not yet probed when the Target Speed quirk runs during
> boot, the LBMS in Link Status register has to still be checked by
> the quirk.
> 
> The priv_flags numbering is not continuous because hotplug code added
> a few flags to fill numbers 4-5 (hotplug and bwctrl changes are routed
> through in different branches).
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> This will conflict with the new flags Lukas added due to the hp fixes
> but it should be simple to deal with that conflict while merging the
> topic branches.
> 
> v2:
> - Change flag value to 6 to make merging with the newly added HP flags easier
> - Renamed flag to PCI_LINK_LBMS_SEEN to match the naming of the new HP flags
> 
>  drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
>  drivers/pci/pci.c                 |  2 +-
>  drivers/pci/pci.h                 | 10 ++---
>  drivers/pci/pcie/bwctrl.c         | 63 +++++++++----------------------
>  drivers/pci/quirks.c              | 10 ++---
>  5 files changed, 25 insertions(+), 62 deletions(-)

Applied to pci/bwctrl for v6.16, on the assumption that everybody's
happy with this.  Thanks!

> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index d603a7aa7483..bcc938d4420f 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -131,7 +131,7 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
>  			      INDICATOR_NOOP);
>  
>  	/* Don't carry LBMS indications across */
> -	pcie_reset_lbms_count(ctrl->pcie->port);
> +	pcie_reset_lbms(ctrl->pcie->port);
>  }
>  
>  static int pciehp_enable_slot(struct controller *ctrl);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24..3d94cf33c1b6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4757,7 +4757,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
>  	 * to track link speed or width changes made by hardware itself
>  	 * in attempt to correct unreliable link operation.
>  	 */
> -	pcie_reset_lbms_count(pdev);
> +	pcie_reset_lbms(pdev);
>  	return rc;
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62..887811fbe722 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -557,6 +557,7 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  #define PCI_DPC_RECOVERED 1
>  #define PCI_DPC_RECOVERING 2
>  #define PCI_DEV_REMOVED 3
> +#define PCI_LINK_LBMS_SEEN	6
>  
>  static inline void pci_dev_assign_added(struct pci_dev *dev)
>  {
> @@ -824,14 +825,9 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  #endif
>  
>  #ifdef CONFIG_PCIEPORTBUS
> -void pcie_reset_lbms_count(struct pci_dev *port);
> -int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> +void pcie_reset_lbms(struct pci_dev *port);
>  #else
> -static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
> -static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
> -{
> -	return -EOPNOTSUPP;
> -}
> +static inline void pcie_reset_lbms(struct pci_dev *port) {}
>  #endif
>  
>  struct pci_dev_reset_methods {
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index d8d2aa85a229..ab0387ff2de2 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -38,12 +38,10 @@
>  /**
>   * struct pcie_bwctrl_data - PCIe bandwidth controller
>   * @set_speed_mutex:	Serializes link speed changes
> - * @lbms_count:		Count for LBMS (since last reset)
>   * @cdev:		Thermal cooling device associated with the port
>   */
>  struct pcie_bwctrl_data {
>  	struct mutex set_speed_mutex;
> -	atomic_t lbms_count;
>  	struct thermal_cooling_device *cdev;
>  };
>  
> @@ -202,15 +200,14 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  
>  static void pcie_bwnotif_enable(struct pcie_device *srv)
>  {
> -	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
>  	struct pci_dev *port = srv->port;
>  	u16 link_status;
>  	int ret;
>  
> -	/* Count LBMS seen so far as one */
> +	/* Note down if LBMS has been seen so far */
>  	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
>  	if (ret == PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBMS)
> -		atomic_inc(&data->lbms_count);
> +		set_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
>  
>  	pcie_capability_set_word(port, PCI_EXP_LNKCTL,
>  				 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> @@ -233,7 +230,6 @@ static void pcie_bwnotif_disable(struct pci_dev *port)
>  static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>  {
>  	struct pcie_device *srv = context;
> -	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
>  	struct pci_dev *port = srv->port;
>  	u16 link_status, events;
>  	int ret;
> @@ -247,7 +243,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>  		return IRQ_NONE;
>  
>  	if (events & PCI_EXP_LNKSTA_LBMS)
> -		atomic_inc(&data->lbms_count);
> +		set_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
>  
>  	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>  
> @@ -262,31 +258,10 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
>  
> -void pcie_reset_lbms_count(struct pci_dev *port)
> +void pcie_reset_lbms(struct pci_dev *port)
>  {
> -	struct pcie_bwctrl_data *data;
> -
> -	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> -	data = port->link_bwctrl;
> -	if (data)
> -		atomic_set(&data->lbms_count, 0);
> -	else
> -		pcie_capability_write_word(port, PCI_EXP_LNKSTA,
> -					   PCI_EXP_LNKSTA_LBMS);
> -}
> -
> -int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
> -{
> -	struct pcie_bwctrl_data *data;
> -
> -	guard(rwsem_read)(&pcie_bwctrl_lbms_rwsem);
> -	data = port->link_bwctrl;
> -	if (!data)
> -		return -ENOTTY;
> -
> -	*val = atomic_read(&data->lbms_count);
> -
> -	return 0;
> +	clear_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
>  }
>  
>  static int pcie_bwnotif_probe(struct pcie_device *srv)
> @@ -308,18 +283,16 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  		return ret;
>  
>  	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> -		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -			port->link_bwctrl = data;
> +		port->link_bwctrl = data;
>  
> -			ret = request_irq(srv->irq, pcie_bwnotif_irq,
> -					  IRQF_SHARED, "PCIe bwctrl", srv);
> -			if (ret) {
> -				port->link_bwctrl = NULL;
> -				return ret;
> -			}
> -
> -			pcie_bwnotif_enable(srv);
> +		ret = request_irq(srv->irq, pcie_bwnotif_irq,
> +				  IRQF_SHARED, "PCIe bwctrl", srv);
> +		if (ret) {
> +			port->link_bwctrl = NULL;
> +			return ret;
>  		}
> +
> +		pcie_bwnotif_enable(srv);
>  	}
>  
>  	pci_dbg(port, "enabled with IRQ %d\n", srv->irq);
> @@ -339,13 +312,11 @@ static void pcie_bwnotif_remove(struct pcie_device *srv)
>  	pcie_cooling_device_unregister(data->cdev);
>  
>  	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> -		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -			pcie_bwnotif_disable(srv->port);
> +		pcie_bwnotif_disable(srv->port);
>  
> -			free_irq(srv->irq, srv);
> +		free_irq(srv->irq, srv);
>  
> -			srv->port->link_bwctrl = NULL;
> -		}
> +		srv->port->link_bwctrl = NULL;
>  	}
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8d610c17e0f2..64ac1ee944d3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -38,14 +38,10 @@
>  
>  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
>  {
> -	unsigned long count;
> -	int ret;
> -
> -	ret = pcie_lbms_count(dev, &count);
> -	if (ret < 0)
> -		return lnksta & PCI_EXP_LNKSTA_LBMS;
> +	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
> +		return true;
>  
> -	return count > 0;
> +	return lnksta & PCI_EXP_LNKSTA_LBMS;
>  }
>  
>  /*
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.39.5
> 

