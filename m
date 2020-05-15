Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243591D59E8
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEOTX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 15:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOTX0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 15:23:26 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755EB2070A;
        Fri, 15 May 2020 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589570605;
        bh=DGk67flq+KQe3MmfEiLhY8iGdN/JINkf7O8LuIKtC/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QxNVJun8XQkMcfEBoPrJvkAbnFg/av12VA2eolkC5G91Xr9t1NY2RYDqYdFNSPwKj
         r3FbdDfa//wLDxaUAiBnwLy3IDnKUADYGg7Av+k+PxCwo6wbUer1M125D9zfuU1QE0
         iEAewFBevpHo065mIOMJ4RZZaVdpC+BJj6AzISNA=
Date:   Fri, 15 May 2020 14:23:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [PATCH v2] x86/PCI: Mark Power Control Unit as having
 non-compliant BARs
Message-ID: <20200515192323.GA538104@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589537271-46459-1-git-send-email-lixiaochun.2888@163.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 06:07:51AM -0400, Xiaochun Lee wrote:
> From: Xiaochun Lee <lixc17@lenovo.com>
> 
> The device [8086:a26c] is a Power Control Unit of
> Intel Ice Lake Server Processor and devices [8086:a1ec,a1ed]
> are the Power Control Unit of Intel Xeon Scalable Processor,
> kernel treats their pci BARs as a base address register that
> leading to a boot failure like:
> "pci 0000:00:11.0: [Firmware Bug]: reg 0x30: invalid BAR (can't size)".

Do you have a spec that says these are Power Control Units?  The spec
I found for the C620 PCH claims these are all "MROM" devices related
to "Enterprise Value Add", "Intel Management Engine", and "Innovation
Engine" configuration.

I updated the commit log, added [8086:a26d] as mentioned in that spec,
added a stable tag, and applied the patch below to pci/misc for v5.8.
Let me know if that doesn't look right.

> The symptoms in Ice Lake processor is:
> "QU99 ICE LAKE ES1 HCC 24C 185W 3200 L-0"
> 
> The information of the device [8086:a26c] list as below:
> 00:11.0 Unassigned class [ff00]: Intel Corporation Device a26c (rev 03)
>         Subsystem: Lenovo Device 7811
>         Flags: fast devsel, NUMA node 0
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [80] Power Management version 3
> 
> The symptoms in Xeon Scalable Processor is:
> "Intel(R) Xeon(R) Gold 5117 CPU @ 2.00GHz"
> "Intel(R) Xeon(R) Gold 6252 CPU @ 2.00GHz"
> 
> The information of the Device [8086:a1ec] list as below:
> 00:11.0 Unassigned class [ff00]: Intel Corporation C620 Series Chipset Family MROM 0 [8086:a1ec] (rev 09)
>         Subsystem: Lenovo Device [17aa:7805]
>         Latency: 0, Cache Line Size: 64 bytes
>         NUMA node: 0
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [80] Power Management version 3
> 
> There are no other BARs on this devices, so mark the PCU as having
> non-compliant BARs, therefore we don't try to probe any of them.
> 
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> ---
>  arch/x86/pci/fixup.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index e723559..d9abc67 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -563,6 +563,9 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
>   * Erratum BDF2
>   * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
>   * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
> + *
> + * Device [8086:a26c]
> + * Devices [8086:a1ec,a1ed]
>   */
>  static void pci_invalid_bar(struct pci_dev *dev)
>  {
> @@ -572,6 +575,9 @@ static void pci_invalid_bar(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ec, pci_invalid_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ed, pci_invalid_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26c, pci_invalid_bar);
>  
>  /*
>   * Device [1022:7808]
> -- 
> 1.8.3.1

commit 1574051e52cb ("x86/PCI: Mark Intel C620 MROMs as having non-compliant BARs")
Author: Xiaochun Lee <lixc17@lenovo.com>
Date:   Thu May 14 23:31:07 2020 -0400

    x86/PCI: Mark Intel C620 MROMs as having non-compliant BARs
    
    The Intel C620 Platform Controller Hub has MROM functions that have non-PCI
    registers (undocumented in the public spec) where BAR 0 is supposed to be,
    which results in messages like this:
    
      pci 0000:00:11.0: [Firmware Bug]: reg 0x30: invalid BAR (can't size)
    
    Mark these MROM functions as having non-compliant BARs so we don't try to
    probe any of them.  There are no other BARs on these devices.
    
    See the Intel C620 Series Chipset Platform Controller Hub Datasheet,
    May 2019, Document Number 336067-007US, sec 2.1, 35.5, 35.6.
    
    [bhelgaas: commit log, add 0xa26d]
    Link: https://lore.kernel.org/r/1589513467-17070-1-git-send-email-lixiaochun.2888@163.com
    Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e723559c386a..0c67a5a94de3 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -572,6 +572,10 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ec, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ed, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26c, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26d, pci_invalid_bar);
 
 /*
  * Device [1022:7808]
