Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8984EF2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfHGOkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 10:40:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:56257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbfHGOkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 10:40:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 07:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="165338496"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2019 07:40:01 -0700
Date:   Wed, 7 Aug 2019 08:37:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being used
Message-ID: <20190807143733.GA25621@localhost.localdomain>
References: <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <1893355.EP2830DdO9@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1893355.EP2830DdO9@kreacher>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 02:53:44AM -0700, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
> host managed power state for suspend") was adding a pci_save_state()
> call to nvme_suspend() in order to prevent the PCI bus-level PM from
> being applied to the suspended NVMe devices, but if ASPM is not
> enabled for the target NVMe device, that causes its PCIe link to stay
> up and the platform may not be able to get into its optimum low-power
> state because of that.
> 
> For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
> hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
> suspend-to-idle prevents the SoC from reaching package idle states
> deeper than PC3, which is way insufficient for system suspend.
> 
> To address this shortcoming, make nvme_suspend() check if ASPM is
> enabled for the target device and fall back to full device shutdown
> and PCI bus-level PM if that is not the case.
> 
> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
> Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for tracking down the cause. Sounds like your earlier assumption
on ASPM's involvement was spot on.

> +/*
> + * pcie_aspm_enabled - Return the mask of enabled ASPM link states.
> + * @pci_device: Target device.
> + */
> +u32 pcie_aspm_enabled(struct pci_dev *pci_device)
> +{
> +	struct pci_dev *bridge = pci_device->bus->self;

You may want use pci_upstream_bridge() instead, just in case someone
calls this on a virtual function's pci_dev.

> +	u32 aspm_enabled;
> +
> +	mutex_lock(&aspm_lock);
> +	aspm_enabled = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
> +	mutex_unlock(&aspm_lock);
> +
> +	return aspm_enabled;
> +}
