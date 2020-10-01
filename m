Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCCF27FD21
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 12:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgJAKSH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 06:18:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2939 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgJAKSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 06:18:07 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C0459A1E552932A82A75;
        Thu,  1 Oct 2020 11:18:05 +0100 (IST)
Received: from localhost (10.52.127.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 11:18:05 +0100
Date:   Thu, 1 Oct 2020 11:16:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v7 00/13] Add RCEC handling to PCI/AER
Message-ID: <20201001101622.00003e48@Huawei.com>
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Sep 2020 14:58:07 -0700
Sean V Kelley <seanvk.dev@oregontracks.org> wrote:

> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> Changes since v6 [1]:
> 
> - Remove unused includes in rcec.c.
> - Add local variable for dev->rcec_ea.
> - If no valid capability version then just fill in nextbusn = 0xff.
> - Leave a blank line after pci_rcec_init(dev).
> - Reword commit w/ "Attempt to do a function level reset for an RCiEP on fatal error."
> - Change An RCiEP found on bus in range -> An RCiEP found on a different bus in range
> - Remove special check on capability version if you fill in nextbusn = 0xff.
> - Remove blank lines in pcie_link_rcec header.
> - Fix indentation aer.c.
> (Jonathan Cameron)
> 
> - Relocate enabling of PME for RCECs to later RCEC handling additions to PME.
> - Rename rcec_ext to rcec_ea.
> - Remove rcec_cap as its use can be handled with rcec_ea.
> - Add a forward declaration for struct rcec_ea.
> - Rename pci_bridge_walk() to pci_walk_bridge() to match consistency with other usage.
> - Separate changes to "reset_subordinate_devices" because it doesn't change the interface.
> - Separate the use of "type", rename of "dev" to "bridge", the inversion of the condition and
> use of pci_upstream_bridge() instead of dev->bus->self.
> - Separate the conditional check (TYPE_ROOT_PORT and TYPE_DOWNSTREAM) for AER resets.
> - Consider embedding RCiEP's parent RCEC in the rcec_ea struct. However, the
> issue here is that we don't normally allocate the rcec_ea struct for RCiEPs and
> the linkage of rcec_ea->rcec is not necessarily more clear.
> - Provide more comment on the non-native case for clarity.
> (Bjorn Helgaas)
> 
> [1] https://lore.kernel.org/linux-pci/20200922213859.108826-1-seanvk.dev@oregontracks.org/
> 
> Root Complex Event Collectors (RCEC) provide support for terminating error
> and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An RCEC
> resides on a Bus in the Root Complex. Multiple RCECs can in fact reside on
> a single bus. An RCEC will explicitly declare supported RCiEPs through the
> Root Complex Endpoint Association Extended Capability.
> 
> (See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. Cap.))
> 
> The kernel lacks handling for these RCECs and the error messages received
> from their respective associated RCiEPs. More recently, a new CPU
> interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities for
> purposes of error messaging from CXL 1.1 supported RCiEP devices.
> 
> DocLink: https://www.computeexpresslink.org/
> 
> This use case is not limited to CXL. Existing hardware today includes
> support for RCECs, such as the Denverton microserver product
> family. Future hardware will be forthcoming.
> 
> (See Intel Document, Order number: 33061-003US)
> 
> So services such as AER or PME could be associated with an RCEC driver.
> In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated with a
> platform's RCEC it shall signal PME and AER error conditions through that
> RCEC.
> 
> Towards the above use cases, add the missing RCEC class and extend the
> PCIe Root Port and service drivers to allow association of RCiEPs to their
> respective parent RCEC and facilitate handling of terminating error and PME
> messages.

I took a look at the combined result of the series as well as individual
patches I've acked.  All looks good to me.

Also ran a quick batch of tests with the non-native / no visible RCEC case
and that's working as expected.  Feels a bit odd too give a tested-by for
the case that touches only a tiny corner of the code, but if you want to include
it...

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #non-native/no RCEC

Thanks,

Jonathan

> 
> 
> Jonathan Cameron (1):
>   PCI/AER: Extend AER error handling to RCECs
> 
> Qiuxu Zhuo (5):
>   PCI/RCEC: Add RCEC class code and extended capability
>   PCI/RCEC: Bind RCEC devices to the Root Port driver
>   PCI/AER: Apply function level reset to RCiEP on fatal error
>   PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
>   PCI/AER: Add RCEC AER error injection support
> 
> Sean V Kelley (7):
>   PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
>   PCI/ERR: Rename reset_link() to reset_subordinate_device()
>   PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
>   PCI/ERR: Limit AER resets in pcie_do_recovery()
>   PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
>   PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
>   PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
> 
>  drivers/pci/pci.h               |  25 ++++-
>  drivers/pci/pcie/Makefile       |   2 +-
>  drivers/pci/pcie/aer.c          |  36 ++++--
>  drivers/pci/pcie/aer_inject.c   |   5 +-
>  drivers/pci/pcie/err.c          | 109 +++++++++++++++----
>  drivers/pci/pcie/pme.c          |  15 ++-
>  drivers/pci/pcie/portdrv_core.c |   8 +-
>  drivers/pci/pcie/portdrv_pci.c  |   8 +-
>  drivers/pci/pcie/rcec.c         | 187 ++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c             |   2 +
>  include/linux/pci.h             |   5 +
>  include/linux/pci_ids.h         |   1 +
>  include/uapi/linux/pci_regs.h   |   7 ++
>  13 files changed, 367 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/pci/pcie/rcec.c
> 
> --
> 2.28.0
> 


