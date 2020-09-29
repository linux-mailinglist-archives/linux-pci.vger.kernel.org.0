Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E767827D96B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 22:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgI2U6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 16:58:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:27949 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbgI2U6e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 16:58:34 -0400
IronPort-SDR: OWW/iFqVRDzvM04O8p/SvD8ztkLA43YfAuS13cJxyPamTLspycvurFUP0aH8UQg+bJAUGicnJT
 xR0WCuNZZbsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="247019252"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="247019252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:58:34 -0700
IronPort-SDR: KN3cTVRkNoKQ4clAAfGsFNEd5ONRm9U1jTghmt3NPGHDnlVLN0q8SGNpTpAzMl32yJu8UrRN80
 bJHZ/0jnfBdg==
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="312349115"
Received: from apickett-mobl.amr.corp.intel.com (HELO [10.255.228.142]) ([10.255.228.142])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:58:33 -0700
Subject: Re: [PATCH v9 0/5] Simplify PCIe native ownership detection logic
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.nkuppuswamy@gmail.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b88d3549-717c-8208-0900-c85db8788618@linux.intel.com>
Date:   Tue, 29 Sep 2020 13:58:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 9/27/20 6:11 PM, Kuppuswamy Sathyanarayanan wrote:
> Currently, PCIe capabilities ownership status is detected by
> verifying the status of pcie_ports_native, pcie_ports_dpc_native
> and _OSC negotiated results (cached in  struct pci_host_bridge
> ->native_* members). But this logic can be simplified, and we can
> use only struct pci_host_bridge ->native_* members to detect it.
> 
Did you get this patch set or do I need to send it again?
> This patchset removes the distributed checks for pcie_ports_native,
> pcie_ports_dpc_native parameters.
> 
> Changes since v8:
>   * Simplified setting _OSC ownwership logic
>   * Moved bridge->native_ltr out of #ifdef CONFIG_PCIEPORTBUS.
> 
> Changes since v7:
>   * Fixed "fix array_size.cocci warnings".
> 
> Changes since v6:
>   * Created new patch for CONFIG_PCIEPORTBUS check in
>     pci_init_host_bridge().
>   * Added warning message for a case when pcie_ports_native
>     overrides _OSC negotiation result.
> 
> Changes since v5:
>   * Rebased on top of v5.8-rc1
> 
> Changes since v4:
>   * Changed the patch set title (Original link: https://lkml.org/lkml/2020/5/26/1710)
>   * Added AER/DPC dependency logic cleanup fixes.
>   
> 
> Kuppuswamy Sathyanarayanan (5):
>    PCI: Conditionally initialize host bridge native_* members
>    ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
>    ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
>      is set.
>    PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable
>      logic
>    PCI/DPC: Move AER/DPC dependency checks out of DPC driver
> 
>   drivers/acpi/pci_root.c           | 37 ++++++++++++++++++++++---------
>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>   drivers/pci/pci-acpi.c            |  3 ---
>   drivers/pci/pcie/aer.c            |  2 +-
>   drivers/pci/pcie/dpc.c            |  3 ---
>   drivers/pci/pcie/portdrv.h        |  2 --
>   drivers/pci/pcie/portdrv_core.c   | 13 +++++------
>   drivers/pci/probe.c               |  6 +++--
>   include/linux/acpi.h              |  2 ++
>   include/linux/pci.h               |  2 ++
>   10 files changed, 42 insertions(+), 30 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
