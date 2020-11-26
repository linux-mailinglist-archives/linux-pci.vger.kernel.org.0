Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9D2C4DDC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgKZDsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 22:48:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:33794 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbgKZDsa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 22:48:30 -0500
IronPort-SDR: dabmerFzBicBv/qQ+4gjgghuu4+hsA9bO4jGy/dxX1dGxieg975Peeyh6WYSQbICsDVtPPk//h
 x2N4a1xmeWBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="171453597"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="171453597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 19:48:30 -0800
IronPort-SDR: kaWA40iUFSEOyPFaF4lr+3i1XMhlQj6214pmZbf4Wff2MmqUZmu1ngE3vg2+/FTvjgMbS/wBC0
 jfzjxNooUCLQ==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="333245246"
Received: from jjbeatty-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 19:48:29 -0800
Subject: Re: [PATCH v12 0/5] Simplify PCIe native ownership
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201126011816.711106-1-helgaas@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b1cb1ad6-e047-8c7a-0abe-b9feee844e59@linux.intel.com>
Date:   Wed, 25 Nov 2020 19:48:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126011816.711106-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is Sathy's work with a few tweaks on top.
> 
> I dropped the DPC pcie_ports_dpc_native changes for now just because I
> haven't had time to understand it all.  We currently ignore the
> OSC_PCI_EXPRESS_DPC_CONTROL bit, which seems wrong.  We might want to start
> looking at it, but we should try to make that a separate patch that's as
> small as possible.
Along with above patch, you also left following two cleanup patches. Is this
intentional? Following fixes have no dependency on pcie_ports_dpc_native change.

[PATCH v11 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
[PATCH v11 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
> 
> Changes since v11:
>   * Add bugfix for DPC with no AER Capability
>   * Split OSC_OWNER trivial changes from pcie_ports_native changes
>   * Temporarily drop pcie_ports_dpc_native changes
> 
> v11 posting: https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
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
>   drivers/pci/pcie/portdrv_core.c   |  9 ++----
>   drivers/pci/probe.c               |  6 ++--
>   7 files changed, 50 insertions(+), 24 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
