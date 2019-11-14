Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07EBBFD186
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 00:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNXZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 18:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKNXZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 18:25:35 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C5A20718;
        Thu, 14 Nov 2019 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573773935;
        bh=iYEYxa/KYnEGZnHkV/MPol/IXRLNQIV4TbRxYLhEIpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U4i9hKv58WqOCfNJZhT1ihvk7Gg8/2Ytz+o0V7vNiIb4XJ57ASjCx+5pzBL4Fl6jd
         ZeJNHcPIsT8oUWxx9IOXWOcLVI15SqVgiiOjJqZLQIssckk0QHuF2+SwD1Ya4VAfyL
         6jED2a6k4JpMr5VhsU+EQ3Ia2fR6iZ8zBTSxbTUo=
Date:   Thu, 14 Nov 2019 17:25:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] PCI: Add missing link delays
Message-ID: <20191114232515.GA13757@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112091617.70282-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 12:16:15PM +0300, Mika Westerberg wrote:
> Hi,
> 
> This is fourth version of the reworked PCIe link delay patch posted earlier
> here:
> 
>   v3: https://www.spinics.net/lists/linux-pci/msg88760.html
>   v2: https://lore.kernel.org/linux-pci/20191004123947.11087-1-mika.westerberg@linux.intel.com/
>   v1: https://patchwork.kernel.org/patch/11106611/
> 
> Changes from v3:
> 
>   * Add tag from Rafael.
>   * Hold pci_bus_sem when accessing bus->devices list.
> 
> Changes from v2:
> 
>   * Rebased on top of pci.git/pci/pm.
>   * Update references to PCIe 5.0 spec.
>   * Take d3cold_delay if child devices into account. This allows ACPI _DSM
>     to lower the delay.
>   * Check for pci_dev->skip_bus_pm in pci_pm_resume_noirq().
>   * Drop comment that mentions pciehp where
>     pci_bridge_wait_for_secondary_bus() is called.
>   * Use pcie_downstream_port() in pci_bridge_wait_for_secondary_bus().
> 
> Based on the discussion around v2 there is a potential issue when restoring
> PCI_EXP_LNKCTL2 (regardless these patches) that we may need to retrain the
> link. This series does not include fix for that since it is not yet clear
> how we solve it. I can do that as a separate patch once we agree on the
> solution.
> 
> I'm submitting these two now in hopes that we can get them included for
> v5.5 because there are systems out there that need them in order to
> function properly.
> 
> Changes from v1:
> 
>   * Introduce pcie_wait_for_link_delay() in a separate patch
>   * Tidy up changelog, remove some debug output
>   * Rename pcie_wait_downstream_accessible() to
>     pci_bridge_wait_for_secondary_bus() and make it generic to all PCI
>     bridges.
>   * Handle Tpvrh + Trhfa for conventional PCI even though we don't do PM
>     for them right now.
>   * Use pci_dbg() instead of dev_dbg().
>   * Dropped check for pm_suspend_no_platform() and only check for D3cold.
>   * Drop pcie_get_downstream_delay(), same delay applies equally to all
>     devices (it is not entirely clear from the spec).
> 
> Mika Westerberg (2):
>   PCI: Introduce pcie_wait_for_link_delay()
>   PCI: Add missing link delays required by the PCIe spec
> 
>  drivers/pci/pci-driver.c |  11 ++-
>  drivers/pci/pci.c        | 148 ++++++++++++++++++++++++++++++++++++---
>  drivers/pci/pci.h        |   1 +
>  3 files changed, 150 insertions(+), 10 deletions(-)

Applied to pci/pm for v5.5, thanks, Mika!
