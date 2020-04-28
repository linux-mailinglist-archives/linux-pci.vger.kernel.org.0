Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4581BB278
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 02:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD1ACQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 20:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgD1ACQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 20:02:16 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7435F2078C;
        Tue, 28 Apr 2020 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588032135;
        bh=3H0OviquW4GQzxAjPMvMp3gxIMeyYsjLwtRWBBjV6ag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gs86Jngqxtq5khk4f0zk7SrMeD9ZD4cIcUQwOe9CsvmoZdf57rkkoSBcaZ1u1YSUR
         fkeOqmfyTggZWAqxStkGTHPRetMN9FI399gw9iuI6VvWTAXlc42ChOXBc2yjiHBw9e
         B5haNSPFo6mj5R8J3aqCJUWRv/K2zl3QcEq2yQVw=
Date:   Mon, 27 Apr 2020 19:02:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Jon Derrick <jonathan.derrick@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200428000213.GA29631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67af2931705bed9a588b5a39d369cb70b9942190.1587925636.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon, Alexandru]

On Sun, Apr 26, 2020 at 11:30:06AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently PCIe AER driver uses HEST FIRMWARE_FIRST bit to
> determine the PCIe AER Capability ownership between OS and
> firmware. This support is added based on following spec
> reference.
> 
> Per ACPI spec r6.3, table 18-387, 18-388, 18-389, HEST table
> flags field BIT-0 and BIT-1 can be used to expose the
> ownership of error source between firmware and OSPM.
> 
> Bit [0] - FIRMWARE_FIRST: If set, indicates that system
>           firmware will handle errors from this source
>           first.
> Bit [1] – GLOBAL: If set, indicates that the settings
>           contained in this structure apply globally to all
>           PCI Express Bridges.
> 
> Although above spec reference states that setting
> FIRMWARE_FIRST bit means firmware will handle the error source
> first, it does not explicitly state anything about AER
> ownership. So using HEST to determine AER ownership is
> incorrect.
> 
> Also, as per following specification references, _OSC can be
> used to negotiate the AER ownership between firmware and OS.
> Details are,
> 
> Per ACPI spec r6.3, sec 6.2.11.3, table titled “Interpretation
> of _OSC Control Field” and as per PCI firmware specification r3.2,
> sec 4.5.1, table 4-5, OS can set bit 3 of _OSC control field
> to request control over PCI Express AER. If the OS successfully
> receives control of this feature, it must handle error reporting
> through the AER Capability as described in the PCI Express Base
> Specification.
> 
> Since above spec references clearly states _OSC can be used to
> determine AER ownership, don't depend on HEST FIRMWARE_FIRST bit.

I split this up a bit and applied the first part to pci/error to get
it into -next so we can start seeing what breaks.  I won't be too
surprised if we trip over something.

Here's the first part (entire original patch is at
https://lore.kernel.org/r/67af2931705bed9a588b5a39d369cb70b9942190.1587925636.git.sathyanarayanan.kuppuswamy@linux.intel.com).

commit 8f8e42e7c2dd ("PCI/AER: Use only _OSC to determine AER ownership")
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Mon Apr 27 18:25:13 2020 -0500

    PCI/AER: Use only _OSC to determine AER ownership
    
    Per the PCI Firmware spec, r3.2, sec 4.5.1, the OS can request control of
    AER via bit 3 of the _OSC Control Field.  In the returned value of the
    Control Field:
    
      The firmware sets [bit 3] to 1 to grant control over PCI Express Advanced
      Error Reporting.  ...  after control is transferred to the operating
      system, firmware must not modify the Advanced Error Reporting Capability.
      If control of this feature was requested and denied or was not requested,
      firmware returns this bit set to 0.
    
    Previously the pci_root driver looked at the HEST FIRMWARE_FIRST bit to
    determine whether to request ownership of the AER Capability.  This was
    based on ACPI spec v6.3, sec 18.3.2.4, and similar sections, which say
    things like:
    
      Bit [0] - FIRMWARE_FIRST: If set, indicates that system firmware will
                handle errors from this source first.
    
      Bit [1] - GLOBAL: If set, indicates that the settings contained in this
                structure apply globally to all PCI Express Devices.
    
    These ACPI references don't say anything about ownership of the AER
    Capability.
    
    Remove use of the FIRMWARE_FIRST bit and rely only on the _OSC bit to
    determine whether we have control of the AER Capability.
    
    Link: https://lore.kernel.org/r/67af2931705bed9a588b5a39d369cb70b9942190.1587925636.git.sathyanarayanan.kuppuswamy@linux.intel.com
    [bhelgaas: commit log, split patches]
    Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ac8ad6cb82aa..9e235c1a75ff 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -483,13 +483,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
-	}
+	if (pci_aer_available())
+		control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
 	/*
 	 * Per the Downstream Port Containment Related Enhancements ECN to
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f4274d301235..efc26773cc6d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -318,30 +318,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
-
-static bool aer_firmware_first;
-
-/**
- * aer_acpi_firmware_first - Check if APEI should control AER.
- */
-bool aer_acpi_firmware_first(void)
-{
-	static bool parsed = false;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= NULL,	/* Check all PCIe devices */
-		.firmware_first	= 0,
-	};
-
-	if (pcie_ports_native)
-		return false;
-
-	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
-		aer_firmware_first = info.firmware_first;
-		parsed = true;
-	}
-	return aer_firmware_first;
-}
 #endif
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
@@ -1523,7 +1499,7 @@ static struct pcie_port_service_driver aerdriver = {
  */
 int __init pcie_aer_init(void)
 {
-	if (!pci_aer_available() || aer_acpi_firmware_first())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 2d155bfb8fbf..11c98875538a 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -125,10 +125,4 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
-#ifdef CONFIG_ACPI_APEI
-extern bool aer_acpi_firmware_first(void);
-#else
-static inline bool aer_acpi_firmware_first(void) { return false; }
-#endif
-
 #endif	/* _PCI_ACPI_H_ */
