Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5087113
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 06:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfHIEvS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 00:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfHIEvS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Aug 2019 00:51:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4972171F;
        Fri,  9 Aug 2019 04:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565326277;
        bh=UscCNqfBtTv94Eh7VjCme0SCZjD0JPyLgvJmYMx3GfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqS+ENNlfxRG+eOO2xNd79wvwo0vxI1wk8SJaRQxLjR3SQIZWfk8dVCPsUcUOo4ni
         7yu7DmxYPQ/NkxxDX5h/DpggLwcOvhCAMgsI8wEAf7ggVdqQJsYvLHGnTbmPz00is4
         nt3xfsVdRDXyJe4xM4KA9cbSGTF+Fo5DE2gxwu40=
Date:   Thu, 8 Aug 2019 23:50:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
Message-ID: <20190809045058.GE7302@google.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain>
 <2184247.yL3mcj2FRQ@kreacher>
 <1618955.HVa0YQSOW5@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618955.HVa0YQSOW5@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s|PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()|PCI/ASPM: Add pcie_aspm_enabled()|

to match previous history.

On Thu, Aug 08, 2019 at 11:55:07PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a function checking whether or not PCIe ASPM has been enabled for
> a given device.
> 
> It will be used by the NVMe driver to decide how to handle the
> device during system suspend.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> v2 -> v3:
>   * Make the new function return bool.
>   * Change its name back to pcie_aspm_enabled().
>   * Fix kerneldoc comment formatting.
> 
> -> v2:
>   * Move the PCI/PCIe ASPM changes to a separate patch.
>   * Add the _mask suffix to the new function name.
>   * Add EXPORT_SYMBOL_GPL() to the new function.
>   * Avoid adding an unnecessary blank line.
> 
> ---
>  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
>  include/linux/pci.h     |    3 +++
>  2 files changed, 23 insertions(+)
> 
> Index: linux-pm/drivers/pci/pcie/aspm.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pcie/aspm.c
> +++ linux-pm/drivers/pci/pcie/aspm.c
> @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  	NULL, 0644);
>  
> +/**
> + * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
> + * @pci_device: Target device.
> + */
> +bool pcie_aspm_enabled(struct pci_dev *pci_device)

The typical name in this file is "pdev".

> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> +	bool ret;
> +
> +	if (!bridge)
> +		return false;
> +
> +	mutex_lock(&aspm_lock);
> +	ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> +	mutex_unlock(&aspm_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
> +
>  #ifdef CONFIG_PCIEASPM_DEBUG
>  static ssize_t link_state_show(struct device *dev,
>  		struct device_attribute *attr,
> Index: linux-pm/include/linux/pci.h
> ===================================================================
> --- linux-pm.orig/include/linux/pci.h
> +++ linux-pm/include/linux/pci.h
> @@ -1567,8 +1567,11 @@ extern bool pcie_ports_native;
>  
>  #ifdef CONFIG_PCIEASPM
>  bool pcie_aspm_support_enabled(void);
> +bool pcie_aspm_enabled(struct pci_dev *pci_device);
>  #else
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
> +static inline bool pcie_aspm_enabled(struct pci_dev *pci_device)
> +{ return false; }
>  #endif
>  
>  #ifdef CONFIG_PCIEAER
> 
> 
> 
