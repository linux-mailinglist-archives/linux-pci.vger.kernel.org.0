Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC15F2244DD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 22:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGQUBd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 16:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgGQUBd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 16:01:33 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8822070E;
        Fri, 17 Jul 2020 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595016092;
        bh=LRG+TGJORIulFB++nyK9lTvfOFTTv5C3kISOBY0t8iY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zbdANefNPLVv8nIfgk4x2+yKpY+DKoqe/iY0UEd+WkavWu+Sv7JNbUKqARbr8c1TZ
         G8s2Lye+J1A8LrECic1Quzyv5PRIBUWk3V4v62AsvqZ/V9YJVGckT1uX532g8ZMPVk
         mpoBDZ/eCfTeJaV4/xSBPneb57mBo9jsz516fguA=
Date:   Fri, 17 Jul 2020 15:01:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v2] PCI/AER: Do not reset the port device status if doing
 firmware first handling.
Message-ID: <20200717200129.GA671299@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622113523.891666-1-Jonathan.Cameron@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Austin, _OSC expert]

On Mon, Jun 22, 2020 at 07:35:23PM +0800, Jonathan Cameron wrote:
> pci_aer_clear_device_status() currently resets the device status
> (PCI_EXP_DEVSTA) on the downstream port above a device, or the port itself
> if the port is the reported AER error source.  This happens even when error
> handling is firmware first.
> 
> Our interpretation is that firmware first handling means that the firmware
> will deal with clearing all relevant error reporting registers
> including this one.

IMO "firmware-first" is meaningless to the kernel.  I see the bit
defined in the ACPI HEST records (ACPI v6.3, sec 18.3.2.4), but there
is no indication of anything the OS needs to *do* with it.  It does
not influence the result of pcie_aer_is_native().  So I don't want to
mention it in the subject or commit log.

But I think what the _OSC negotiation for AER ownership is relevant,
and that's what your patch tests, so I think this is the right thing
to do.

So I applied this as below to pci/error for v5.8, thanks a lot!

Oh, I also propose a preliminary patch (posted and cc'd to you) to
rename pci_aer_clear_device_status():

  https://lore.kernel.org/r/20200717195619.766662-1-helgaas@kernel.org

commit d6c8d24e3d5d ("PCI/ERR: Clear PCIe Device Status errors only if OS owns AER")
Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Mon Jun 22 19:35:23 2020 +0800

    PCI/ERR: Clear PCIe Device Status errors only if OS owns AER
    
    pcie_clear_device_status() resets the error bits in the PCIe Device Status
    Register (PCI_EXP_DEVSTA).
    
    Previously we did this unconditionally, but on ACPI systems, the _OSC AER
    bit negotiates control of the AER capability.  Per sec 4.5.1 of the System
    Firmware Intermediary _OSC and DPC Updates ECN [1], this bit also covers
    other error enable/status bits including the following:
    
      Correctable Error Reporting Enable
      Non-Fatal Error Reporting Enable
      Fatal Error Reporting Enable
      Unsupported Request Reporting Enable
    
    These bits are all in the PCIe Device Control register (the ECN omitted
    "Reporting", but I think that's a typo), so by implication the _OSC AER bit
    also applies to the error status bits in the PCIe Device Status register:
    
      Correctable Error Detected
      Non-Fatal Error Detected
      Fatal Error Detected
      Unsupported Request Detected
    
    Clear the PCIe Device Status error bits only when the OS controls the AER
    capability and related error enable/status bits.  If platform firmware
    controls the AER capability, firmware is responsible for clearing these
    bits.
    
    One call path leading here is:
    
      ghes_do_proc
        ghes_handle_aer
          aer_recover_queue
            schedule_work(&aer_recover_work)
      ...
      aer_recover_work_func
        pcie_do_recovery
          pcie_clear_device_status
    
    [1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
        2020, affecting PCI Firmware Specification, Rev. 3.2
        https://members.pcisig.com/wg/PCI-SIG/document/14076
    [bhelgaas: commit log]
    Link: https://lore.kernel.org/r/20200622113523.891666-1-Jonathan.Cameron@huawei.com
    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d3ea667c8520..34bfea5c52b3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -245,6 +245,9 @@ void pcie_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
 
+	if (!pcie_aer_is_native(dev))
+		return;
+
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
