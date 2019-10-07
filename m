Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4851CEF1C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 00:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGWeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 18:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbfJGWeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 18:34:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD78206C0;
        Mon,  7 Oct 2019 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570487670;
        bh=LGBSGuz5q9yo8hI9Okbu1av/OqHVYJvDjRBLyWdeHjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l+VHYoudpyoV9iaA3IzzJYmS6Xzj05+MpEYQxm0RayzX19zv2bvuOo1THZKU44DF0
         +/RKCBHtGlDq0ii3iA7U7ajRxB4C4h0kF6M54zbmqTza1xkHLgFRZLMgxVEyQGgCe8
         ErahbP+R9O9kkCL6iBNowjUgn9RLtJi/JXtbCF9A=
Date:   Mon, 7 Oct 2019 17:34:28 -0500
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
        Linux PCI <linux-pci@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
Message-ID: <20191007223428.GA72605@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618955.HVa0YQSOW5@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Heiner]

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

Why do we need to acquire aspm_lock here?  We aren't modifying
anything, and I don't think we're preventing a race.  If this races
with another thread that changes aspm_enabled, we'll return either the
old state or the new one, and I think that's still the case even if we
don't acquire aspm_lock.

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
