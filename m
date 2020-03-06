Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4B17B515
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 04:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFDrY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 22:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCFDrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Mar 2020 22:47:24 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6AC2072D;
        Fri,  6 Mar 2020 03:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583466443;
        bh=HWN0cJ/7eBbiS2NbRWxZ8Ad0n5AEIGc39pMj/iusQgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tGLAiXYNuL7Qs0W+S8Z1LWJ8hVsWCtnSbxl7kXkfUKqij4zdNzYqyKYyceTIg0O/v
         5AlYgrhVz1Y1d8PXjRr03w3ExbGw/mIkQHstJCox2HnfzUKX3APrsk1vfNL34OHLfk
         i5NYR0w/dMf6EkJjkPaP67/cPklBBIk+KqijRoOM=
Date:   Thu, 5 Mar 2020 21:47:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v17 11/12] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200306034718.GA117283@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae1d3285beeb81bbf85571a89b8f3d4451eae8f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Olof for pcie_ports=dpc-native question]

On Tue, Mar 03, 2020 at 06:36:34PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> +void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	acpi_status astatus;
> +
> +	if (!adev) {
> +		pci_dbg(pdev, "No valid ACPI node, so skip EDR init\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Per the Downstream Port Containment Related Enhancements ECN to
> +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-6, EDR support
> +	 * can only be enabled if DPC is controlled by firmware.
> +	 *
> +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
> +	 * determine ownership of DPC between firmware or OS.
> +	 * Per the Downstream Port Containment Related Enhancements
> +	 * ECN to the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> +	 * OS can use bit 7 of _OSC control field to negotiate control
> +	 * over DPC Capability.
> +	 */
> +	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native) {
> +		pci_dbg(pdev, "OS handles AER/DPC, so skip EDR init\n");
> +		return;
> +	}
> +
> +	astatus = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
> +					      edr_handle_event, pdev);

I think this is still problematic.  You mentioned Alex's work [1,2].
We do need to revisit those patches, but I don't really want to defer
*this* question of the EDR notify handler.  Negotiating support of
AER/DPC/EDR is already complicated, and I don't want to complicate it
even more by merging something we already know is not quite right.

I don't understand your comment that "EDR can only be enabled if DPC
is controlled by firmware."  I don't see anything in table 4-6 to that
effect.  The only mention of EDR there is to say that the OS can
access the DPC capability in the EDR processing window, i.e., after
the OS receives the EDR notification and before it clears DPC Trigger
Status.

EDR is a general ACPI feature that is not PCI-specific.  For EDR on
PCI devices, OS support is advertised via _OSC *Support* (table 4-4),
which says:

  Error Disconnect Recover Supported

  The OS sets this bit to 1 if it supports Error Disconnect Recover
  notification on PCI Express Host Bridges, Root Ports and Switch
  Downstream Ports. Otherwise, the OS sets this bit to 0.

I think that means that if we set the "Error Disconnect Recover
Supported" _OSC bit (OSC_PCI_EDR_SUPPORT), we must install a handler
for EDR notifications.  We set OSC_PCI_EDR_SUPPORT whenever
CONFIG_PCIE_EDR=y, so I think we should install the notify handler
here unconditionally (since this file is compiled only when
CONFIG_PCIE_EDR=y).

I don't think we should even test pcie_ports_dpc_native here.  If we
told the platform we can handle EDR notifications, we should be
prepared to get them, regardless of whether the user booted with
"pcie_ports=dpc-native".

It's conceivable that pcie_ports_dpc_native should make us do
something different in the notify handler after we *get* a
notification, but I doubt we should even worry about that.

IIUC, pcie_ports_dpc_native exists because Linux DPC originally worked
even if the OS didn't have control of AER.  eed85ff4c0da7 ("PCI/DPC:
Enable DPC only if AER is available") meant that if Linux didn't have
control of AER, DPC no longer worked.  "pcie_ports=dpc-native" is
basically a way to get that previous behavior of Linux DPC regardless
of AER control.

I don't think that issue applies to EDR.  There's no concept of an OS
"enabling" or "being granted control of" EDR.  The OS merely
advertises that "yes, I'm prepared to handle EDR notifications".
AFAICT, the ECR says nothing about EDR support being conditional on OS
control of AER or DPC.  The notify *handler* might need to do
different things depending on whether we have AER or DPC control, but
the handler itself should be registered regardless.

[1] https://lore.kernel.org/linux-pci/20181115231605.24352-1-mr.nuke.me@gmail.com/
[2] https://lore.kernel.org/linux-pci/20190326172343.28946-1-mr.nuke.me@gmail.com/
