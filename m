Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA760862C6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfHHNPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 09:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733043AbfHHNPi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 09:15:38 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C4C21874;
        Thu,  8 Aug 2019 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270137;
        bh=vFhZxVY8zznG2dSrxO7puCCAQ9KAh4AjZjZKA0nhTAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlMKMIrSlU6rvR+VXzY7/b5hTw+vgLbYitjwCvgf/5bMZmb+I9tIWmlPXVfLBBMaP
         PhegZYaNpANzQ9Pn7T34U2Ssj37aRI2b76KQ2vUqIZK9/OtHeNT9JNljA4J6KR96We
         n7MoKycWieK/kffMTmTVhIwawhbfkEj7SbA0UGMQ=
Date:   Thu, 8 Aug 2019 08:15:36 -0500
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
Subject: Re: [PATCH v2 1/2] PCI: PCIe: ASPM: Introduce
 pcie_aspm_enabled_mask()
Message-ID: <20190808131536.GE151852@google.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain>
 <1921165.pTveHRX1Co@kreacher>
 <3714448.mG7dE8Q3Fs@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3714448.mG7dE8Q3Fs@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 08, 2019 at 12:06:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a function returning the mask of currently enabled ASPM link
> states for a given device.
> 
> It will be used by the NVMe driver to decide how to handle the
> device during system suspend.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
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
> +/*
> + * pcie_aspm_enabled_mask - Return the mask of enabled ASPM link states.
> + * @pci_device: Target device.
> + */
> +u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> +	u32 ret;
> +
> +	if (!bridge)
> +		return 0;
> +
> +	mutex_lock(&aspm_lock);
> +	ret = bridge->link_state ? bridge->link_state->aspm_enabled : 0;

This returns the "aspm_enabled" mask, but the values of that mask are
combinations of:

  ASPM_STATE_L0S_UP
  ASPM_STATE_L0S_DW
  ASPM_STATE_L1
  ...

which are defined internally in drivers/pci/pcie/aspm.c and not
visible to the caller of pcie_aspm_enabled_mask().  If there's no need
for the actual mask (the current caller doesn't seem to use it), maybe
this could be a boolean?

> +	mutex_unlock(&aspm_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pcie_aspm_enabled_mask);
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
> +u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device);
>  #else
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
> +static inline u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
> +{ return 0; }
>  #endif
>  
>  #ifdef CONFIG_PCIEAER
> 
> 
> 
