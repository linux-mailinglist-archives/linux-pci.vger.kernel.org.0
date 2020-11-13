Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187D32B279A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMV7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 16:59:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:27846 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKMV7V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 16:59:21 -0500
IronPort-SDR: 7Ozt3vzOdvrKHqJy5BM1iHlHdIcjC1N+3g/M6STnBlZqFIZk/w/cEddRwE1ZW/gDH+L/0QcpGX
 oZ6MDgF7T4VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="167960059"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="167960059"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:59:20 -0800
IronPort-SDR: 2doTmgaMPgKiG8rX2ERNX997i15GrFOVVteLJjoJDMDzviPPBp+uC59VFFKaBUkpXRddjIL8QB
 kFbmOLPsnKvg==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="355680607"
Received: from matownse-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.99.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:59:20 -0800
Subject: Re: [PATCH v11 0/5] Simplify PCIe native ownership detection logic
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, knsathya@kernel.org
References: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2f89d5ba-4588-dfdd-2f97-a58ad029ccbf@linux.intel.com>
Date:   Fri, 13 Nov 2020 13:59:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 10/26/20 7:57 PM, Kuppuswamy Sathyanarayanan wrote:
> Currently, PCIe capabilities ownership status is detected by
> verifying the status of pcie_ports_native, pcie_ports_dpc_native
> and _OSC negotiated results (cached in  struct pci_host_bridge
> ->native_* members). But this logic can be simplified, and we can
> use only struct pci_host_bridge ->native_* members to detect it.
> 
> This patchset removes the distributed checks for pcie_ports_native,
> pcie_ports_dpc_native parameters.
Any comments on this series?
> 
> Changes since v10:
>   * Addressed format issue reported by lkp test.
> 
> Changes since v9:
>   * Rebased on top of v5.10-rc1
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
>   drivers/acpi/pci_root.c           | 39 +++++++++++++++++++++++--------
>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>   drivers/pci/pci-acpi.c            |  3 ---
>   drivers/pci/pcie/aer.c            |  2 +-
>   drivers/pci/pcie/dpc.c            |  3 ---
>   drivers/pci/pcie/portdrv.h        |  2 --
>   drivers/pci/pcie/portdrv_core.c   | 13 ++++-------
>   drivers/pci/probe.c               |  6 +++--
>   include/linux/acpi.h              |  2 ++
>   include/linux/pci.h               |  2 ++
>   10 files changed, 44 insertions(+), 30 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
