Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE01FBD47
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgFPRre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 13:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPRrd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 13:47:33 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DC62078D;
        Tue, 16 Jun 2020 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592329653;
        bh=nAI/EXqUGCFU6KYEC9NHmbC/B5dpZ6ul/4PG6MVXr+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Erm+poYvqcyDFKX5SnKcWjQucTKB8JxI7kkm62RnbC2A35qML7xh0SzVAf0/6GwE8
         pRgkAwwhXV+eVzaN+sM5yi6qqJMMri+iHaN6SroYp7ydmKeHqmC3Nb8BWGVxqgmUYB
         RMhMl8DGZyOmYDZ7qEKwT5oRTsO6t52w7DiOU+C0=
Date:   Tue, 16 Jun 2020 12:47:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI/AER: Do not reset the device status if doing
 firmware first handling.
Message-ID: <20200616174731.GA1969609@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521173134.2456773-2-Jonathan.Cameron@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sathy]

On Fri, May 22, 2020 at 01:31:33AM +0800, Jonathan Cameron wrote:
> pci_aer_clear_device_status() currently resets the device status even when
> firmware first handling is going on.  In particular it resets it on the
> root port.
>
> This has been discussed previously
> https://lore.kernel.org/patchwork/patch/427375/.

I don't think this reference is really pertinent, is it?  That patch
to b2c8881da764 changes pci_cleanup_aer_uncorrect_error_status() so it
doesn't clear PCI_ERR_UNCOR_STATUS in "firmware-first" mode.

But your patch only affects PCI_EXP_DEVSTA, not PCI_ERR_UNCOR_STATUS.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/aer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f4274d301235..43e78b97ace6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -373,6 +373,9 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
>  {
>  	u16 sta;
>  
> +	if (pcie_aer_get_firmware_first(dev))
> +		return;

This needs to be adjusted because pcie_aer_get_firmware_first() no
longer exists after 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
parsing for AER ownership").

This will use the _OSC AER ownership bit to gate clearing of the
status bits in the PCIe capability (not the AER capability).

I think that's the right thing to do, but it's certainly not obvious
from the _OSC description in the PCI Firmware Spec r3.2.  I think we
need a pointer to the ECN that clarifies this, i.e., sec 4.5.1 of:

  System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
  2020, affecting PCI Firmware Specification, Rev. 3.2
  https://members.pcisig.com/wg/PCI-SIG/document/14076

>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> -- 
> 2.19.1
> 
