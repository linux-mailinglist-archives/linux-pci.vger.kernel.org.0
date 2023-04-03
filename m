Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6F6D54C5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjDCW3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjDCW3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 18:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7E3C20;
        Mon,  3 Apr 2023 15:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DBF461ACA;
        Mon,  3 Apr 2023 22:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56056C433D2;
        Mon,  3 Apr 2023 22:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680560934;
        bh=dUz9bFHM1/W08SV+atyctj1Gbnb27waf243Vro09vkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bU3/Sp0CaIXSC7j9aCciJcpVaFoq2U8kY0wmG5H/7jUJNHpa44QRNsEC+u/BmmnZX
         SRf+0KDek5cZX/1iQhgSPNk9nMJXSphlnnU0vHntzfyvxXUtc6nF/rISvjBJS4YT3+
         mqhnFo9jSOTJLwGnyV5UaeD+AAcm7TQB5Ays9FkzDQ/TOwydRWTp0I60rIHKcG6otW
         D+k7MnRUxLBGImH1ffgZ3Z0gFIT4MyFJbeU/9mv0eboyJPu7q3E4WlEYAP6Hxbs19Q
         w6DccQEPu0C5JdU05pdYYMKM1Fmdzz22P6Z3z3APjB2e3VKns7k8SABHFR23cGIQfZ
         EnovVP1jztJqg==
Date:   Mon, 3 Apr 2023 17:28:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ron Lee <ron.lee.intel@gmail.com>
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: Re: [PATCH v3] PCI: Fix up L1SS capability for Intel Apollo Lake
 PCIe bridge
Message-ID: <20230403222852.GA3471710@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206143540.15325-1-ron.lee@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 10:35:40PM +0800, Ron Lee wrote:
> On Google Coral and Reef family Chromebooks with Intel Apollo Lake
> SoC, the PCIe bridge lost its L1 PM Substates capability after resumed
> from D3cold. This patch save the capability header and the pointer
> offset to the L1SS capability after this bridge initialized, and
> recover them every time resuming from D3cold.
> 
> Link:https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com/T/#u
> Signed-off-by: Ron Lee <ron.lee@intel.com>
> ---
> Change from v2: traverse the capability link list to find the L1SS capability header
> and pointer offset to the L1SS capability, save them after the bridge initialized and 
> restore them after resuming from D3cold.
> 
>  drivers/pci/quirks.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 285acc4aaccc..4e1c8c4c7e9a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5992,3 +5992,44 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +#ifdef CONFIG_PCIEASPM
> +static u16 pos_to_l1ss;
> +static u32 l1ss_header;
> +static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *pdev)
> +{
> +	u32 header;
> +	int pos = PCI_CFG_SPACE_SIZE;
> +
> +	while (pos) {
> +		pci_read_config_dword(pdev, pos, &header);
> +		if (PCI_EXT_CAP_NEXT(header) == pdev->l1ss)
> +			pos_to_l1ss = pos;
> +		else if (PCI_EXT_CAP_ID(header) == PCI_EXT_CAP_ID_L1SS)
> +			l1ss_header = header;
> +
> +		pos = PCI_EXT_CAP_NEXT(header);
> +	}
> +}
> +
> +static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *pdev)
> +{
> +	u32 header;
> +
> +	if (!pos_to_l1ss || !l1ss_header)
> +		return;
> +
> +	pci_info(pdev, "Fixup L1SS Capability\n");
> +	/* Fixup the header of L1SS Capability if missing */
> +	pci_read_config_dword(pdev, pdev->l1ss, &header);
> +	if (PCI_EXT_CAP_ID(header) != PCI_EXT_CAP_ID_L1SS)
> +		pci_write_config_dword(pdev, pdev->l1ss, l1ss_header);
> +
> +	/* Fixup the link to L1SS Capability if missing*/
> +	pci_read_config_dword(pdev, pos_to_l1ss, &header);
> +	if (PCI_EXT_CAP_NEXT(header) != pdev->l1ss)
> +		pci_write_config_dword(pdev, pos_to_l1ss, pdev->l1ss << 20);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
> +#endif

What do you think of the possible revision below?

  - Moved to arch/x86/pci/fixup.c since this is x86-only.
  - Save prev cap offset & header, L1SS offset & header.  This means
    we can fix up even when CONFIG_PCIEASPM is not enabled, we can
    restore the entire previous cap header (not just the link), and
    should be safe since only one device per system should match the
    Device ID.

Bjorn

commit e082cb8ab59f ("PCI: Fix up L1SS capability for Intel Apollo Lake Root Port")
parent 52589007b243
Author: Ron Lee <ron.lee.intel@gmail.com>
Date:   Mon Apr 3 16:30:16 2023 -0500

    PCI: Fix up L1SS capability for Intel Apollo Lake Root Port
    
    On Google Coral and Reef family Chromebooks with Intel Apollo Lake
    SoC, firmware clobbers the headers of the L1 PM Substates capability and
    the previous capability when returning from D3cold to D0.
    
    Save those headers at enumeration-time and restore them at resume.
    
    Link: https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com/T/#u

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 615a76d70019..ad0dfb22b4a6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -824,3 +824,61 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
 
 #endif
+
+/*
+ * When returning from D3cold to D0, firmware on some Google Coral and Reef
+ * family Chromebooks with Intel Apollo Lake SoC clobbers the headers of
+ * both the L1 PM Substates capability and the previous capability for the
+ * "Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1".
+ *
+ * Save those values at enumeration-time and restore them at resume.
+ */
+
+static u16 prev_cap, l1ss_cap;
+static u32 prev_header, l1ss_header;
+
+static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *dev)
+{
+	int pos = PCI_CFG_SPACE_SIZE, prev = 0;
+	u32 header, pheader = 0;
+
+	while (pos) {
+		pci_read_config_dword(dev, pos, &header);
+		if (PCI_EXT_CAP_ID(header) == PCI_EXT_CAP_ID_L1SS) {
+			prev_cap = prev;
+			prev_header = pheader;
+			l1ss_cap = pos;
+			l1ss_header = header;
+		}
+
+		prev = pos;
+		prev_header = header;
+		pos = PCI_EXT_CAP_NEXT(header);
+	}
+}
+
+static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
+{
+	u32 header;
+
+	if (!prev_cap || !prev_header || !l1ss_cap || !l1ss_header)
+		return;
+
+	/* Fixup the header of L1SS Capability if missing */
+	pci_read_config_dword(dev, l1ss_cap, &header);
+	if (header != l1ss_header) {
+		pci_write_config_dword(dev, l1ss_cap, l1ss_header);
+		pci_info(dev, "restore L1SS Capability header (was %#010x now %#010x)\n",
+			 header, l1ss_header);
+	}
+
+	/* Fixup the link to L1SS Capability if missing */
+	pci_read_config_dword(dev, prev_cap, &header);
+	if (header != prev_header) {
+		pci_write_config_dword(dev, prev_cap, prev_header);
+		pci_info(dev, "restore previous Capability header (was %#010x now %#010x)\n",
+			 header, prev_header);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
