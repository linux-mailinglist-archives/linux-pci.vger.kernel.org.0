Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8033340EF0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 21:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhCRUQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 16:16:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:60195 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhCRUQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 16:16:27 -0400
IronPort-SDR: 4e1ffBRuk6G9Am0B8IQYtnIHyYvMDAnSaqkm1LemG5n924L20Q+O4HPSpWvvb0KSZC4BjKYUcE
 HOv8/e3T2H9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="251117470"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="251117470"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 13:16:27 -0700
IronPort-SDR: EwEraWEJEIpTTfJVg0kkwuvooGlh9zJEacRNNQcHC81j7mQFGD1L1BhySvhEw0rZHHaQyxSsk8
 UAwhsFjWaThw==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="413229688"
Received: from mrasekh-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.191.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 13:16:26 -0700
Subject: Re: [PATCH v13 0/5] Simplify PCIe native ownership
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e2438472-5367-f6fb-d8e0-f6a6273cbf82@linux.intel.com>
Date:   Thu, 18 Mar 2021 13:16:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 1/22/21 5:11 PM, Kuppuswamy Sathyanarayanan wrote:
> Currently, PCIe capabilities ownership status is detected by
> verifying the status of pcie_ports_native, and _OSC negotiated
> results (cached in  struct pci_host_bridge->native_* members).
> But this logic can be simplified, and we can use only struct
> pci_host_bridge ->native_* members to detect it.
> 
> This patchset removes the distributed checks for pcie_ports_native,
> parameter.
Any comments on this patch set?
> 
> Changes since v12:
>   * Rebased on top of v5.11-rc1
> 
> Changes since v11 (Bjorns update):
>   * Add bugfix for DPC with no AER Capability
>   * Split OSC_OWNER trivial changes from pcie_ports_native changes
>   * Temporarily drop pcie_ports_dpc_native changes (revisit it later).
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
> Bjorn Helgaas (2):
>    PCI/DPC: Ignore devices with no AER Capability
>    PCI/ACPI: Centralize pci_aer_available() checking
> 
> Kuppuswamy Sathyanarayanan (3):
>    PCI: Assume control of portdrv-related features only when portdrv
>      enabled
>    PCI/ACPI: Tidy _OSC control bit checking
>    PCI/ACPI: Centralize pcie_ports_native checking
> 
>   drivers/acpi/pci_root.c           | 49 ++++++++++++++++++++++++-------
>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>   drivers/pci/pci-acpi.c            |  3 --
>   drivers/pci/pcie/aer.c            |  2 +-
>   drivers/pci/pcie/dpc.c            |  3 ++
>   drivers/pci/pcie/portdrv_core.c   | 11 +++----
>   drivers/pci/probe.c               |  6 ++--
>   7 files changed, 51 insertions(+), 25 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
