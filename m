Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F842BBCF7
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 05:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgKUE1C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 23:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgKUE1B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 23:27:01 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A70E20882;
        Sat, 21 Nov 2020 04:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605932820;
        bh=gEATBb+DQrKj2BE7dJdalbyOAhad9Yp1pFfW39/l+4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SaZlUOfLMXbiv5Tb1ZbtlR/U2s6OsNysQcE+mWwh+7Snildi+xYeme+Z7J4Sd67zz
         fn49ZQ790B0SJyqlETJ7uM4Q5UvpjL6DEGowRuQHKOXdxwDXa0Gf3OUMGwrg2X7mmy
         bxjQ9+yBvifqYW75+Bjj4KkIgNfchwTBjPCeat5Q=
Date:   Fri, 20 Nov 2020 22:26:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/15] Add RCEC handling to PCI/AER
Message-ID: <20201121042658.GA299315@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121001036.8560-1-sean.v.kelley@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 04:10:21PM -0800, Sean V Kelley wrote:
> Changes since v11 [1] and based on pci/master tree [2]:
> 
> - No functional changes. Tested with aer injection.
> 
> - Merge RCEC class code and extended capability patch with usage.
> - Apply same optimization for pci_pcie_type(dev) calls in
> drivers/pci/pcie/portdrv_pci.c and drivers/pci/pcie/aer.c.
> (Kuppuswamy Sathyanarayanan)
> 
> [1] https://lore.kernel.org/linux-pci/20201117191954.1322844-1-sean.v.kelley@intel.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/
> 
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
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #non-native/no RCEC
> 
> 
> Qiuxu Zhuo (3):
>   PCI/RCEC: Bind RCEC devices to the Root Port driver
>   PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
>   PCI/AER: Add RCEC AER error injection support
> 
> Sean V Kelley (12):
>   AER: aer_root_reset() non-native handling
>   PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
>   PCI/ERR: Rename reset_link() to reset_subordinates()
>   PCI/ERR: Simplify by using pci_upstream_bridge()
>   PCI/ERR: Simplify by computing pci_pcie_type() once
>   PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
>   PCI/ERR: Avoid negated conditional for clarity
>   PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
>   PCI/ERR: Limit AER resets in pcie_do_recovery()
>   PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
>   PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
>   PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
> 
>  drivers/pci/pci.h               |  29 ++++-
>  drivers/pci/pcie/Makefile       |   2 +-
>  drivers/pci/pcie/aer.c          |  89 +++++++++++----
>  drivers/pci/pcie/aer_inject.c   |   5 +-
>  drivers/pci/pcie/err.c          |  93 +++++++++++-----
>  drivers/pci/pcie/pme.c          |  16 ++-
>  drivers/pci/pcie/portdrv_core.c |   9 +-
>  drivers/pci/pcie/portdrv_pci.c  |  13 ++-
>  drivers/pci/pcie/rcec.c         | 190 ++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c             |   2 +
>  include/linux/pci.h             |   5 +
>  include/linux/pci_ids.h         |   1 +
>  include/uapi/linux/pci_regs.h   |   7 ++
>  13 files changed, 393 insertions(+), 68 deletions(-)
>  create mode 100644 drivers/pci/pcie/rcec.c

Good timing, I was just tidying up v11 :)

Anyway, I applied this to pci/err for v5.11, thanks!

Now I see a Tested-by from Jonathan above; this cover letter doesn't
become part of the git history, so probably I should add that to each
individual patch, or maybe just the relevant ones if there are some
that it wouldn't apply to.  I'll tidy that up next week.

Minor procedural things I fixed up already because I think they're a
consequence of you building on a previous branch I published: patches
you post shouldn't include Signed-off-by; you should add your own when
you write the patch or are part of the delivery path, but you
shouldn't add *mine*.  I add that when I apply them.

I also removed the first Link: tags since they also look like they're
from an older version.  You don't need to add those; I add those
automatically so they point to the mailing list message where the
patch was posted.
