Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DA376D2F
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEGXLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 19:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhEGXLP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 19:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F8ED6147F;
        Fri,  7 May 2021 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620429015;
        bh=lQ/DXz8whGATwK5S38i5+uNShDs0+C7PD1gQbx0Ub7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eXsu2wjhuksxMlgmYmCkI/j1g7AIEGu1KzfpawvrCh6KjI1rSkTIZvmSCaU07ajnm
         S/XKuJY8FptPs4qRdrfmBjA0YKYq/HiFIB5RG+7kNagsh61Kv1AmsenI8JmDvga5hD
         S5S7ObtoBStaOowdq9wIPUf4JBFNShDUA7DJkK8z4H5mTqVYi//hDLBBXiCD+peis7
         0yGvUXQIpB0fKQ0EsK8Jj7ECoJfLdp7IfHPna6PPzLliphxhybrWMpScEuiIamKxbh
         jI6wHDhbD4fylwtZ+VJhrNPZiP+LBKiOl6Ww7Quj/J8dKm4R3JuoncbBGHR+tS8Ss3
         OM2/mGl6vSp5A==
Date:   Fri, 7 May 2021 18:10:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-acpi@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, linuxarm@huawei.com,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210507231013.GA1548806@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/doe/DOE/ in subject.

On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:
> Introduced in a PCI ECN [1], DOE provides a config space
> based mailbox with standard protocol discovery.  Each mailbox
> is accessed through a DOE Extended Capability.
> 
> A device may have 1 or more DOE mailboxes, each of which is allowed
> to support any number of protocols (some DOE protocol
> specifications apply additional restrictions).  A given protocol
> may be supported on more than one DOE mailbox on a given function.
> 
> If a driver wishes to access any number of DOE instances / protocols
> it makes a single call to pcie_doe_register_all() which will find
> available DOEs, create the required infrastructure and cache the
> protocols they support.  pcie_doe_find() can then retrieve a
> pointer to an appropriate DOE instance.
> 
> A synchronous interface is provided in pcie_doe_exchange_sync() to
> perform a single query / response exchange.

Re-wrap above (and commit logs of other patches) to fill 75 columns.

s/pcie_doe_register_all/pci_doe_register_all/
s/pcie_doe_find/pci_doe_find/
s/pcie_doe_exchange_sync/pci_doe_exchange_sync/

> +config PCI_DOE
> +	bool
> +	help
> +	  This enables library support for the PCI Data Object Exchange
> +	  capability. DOE provides a simple mailbox in PCI config space that is
> +	  used by a number of different protocols.
> +	  DOE is defined in the Data Object Exchange ECN to PCI 5.0.

"ECN to the PCIe r5.0 spec."

"PCI 5.0" sounds like a conventional PCI spec.

> + * pci_doe_exchange_sync() - Send a request, then wait for and receive response.
> + * @doe: DOE mailbox state structure.
> + * @ex: Description of the buffers and Vendor ID + type used in this
> + *      request/response pair,

s/,/./

(Or omit the periods altogether on these function and parameter
one-liners, as most of drivers/pci does.  Most of these descriptions
aren't sentences anyway, I think it's fine that they're unterminated.)

> +static void pci_doe_init(struct pci_doe *doe, struct pci_dev *pdev, int doe_offset)

Indent to fit in 80 columns like the rest of drivers/pci/.

> +static int pci_doe_register(struct pci_doe *doe)
> +{
> +	struct pci_dev *pdev = doe->pdev;
> +	bool poll = !pci_dev_msi_enabled(pdev);
> +	int rc, irq;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_CAP, &val);
> +
> +	if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
> +		irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
> +		if (irq < 0)
> +			return irq;
> +
> +		rc = request_irq(irq, pci_doe_irq, 0, "DOE", doe);

I expect there may be many devices with DOE.  Do you want some
device identification here?  E.g., on my system I see things like this
in /proc/interrupts:

  dmar0
  nvme0q0
  snd_hda_intel:card0
  ahci[0000:00:17.0]

> +++ b/include/linux/pci-doe.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Object Exchange was added to the PCI spec as an ECN to 5.0.

"... was added as an ECN to the PCIe r5.0 spec."
