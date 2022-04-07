Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AFE4F8585
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiDGRJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiDGRJC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 13:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE812CE03
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 10:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2659061331
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 17:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55339C385A0;
        Thu,  7 Apr 2022 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351217;
        bh=Zyfq0AzuyIsUW5wL2mPZWfFCcFVATCGGT0nRWyAq25w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h1XERmpEr+7y8CYg4jOEzr3UITspRwt8SN+/AJb8jPkm2wlVTZADHX9Sq+vrKZ5X6
         Rscsv3vyWsmWs7iVJm7JLLPqjwzrFVelfo14ETw5A6nczMDvM//mIg6AT5i6hPwPGW
         aTJo8aoseMy1ttjp6l+YMosGUBkRG6O2Lqq2+/f4ncCJalTL9X2kNEKG+Gf8dG8yKG
         6A3nNQ5JZB76evjuQuugtXioR96KAwGxPK66lUPTvk4ChxwcClvURshYJL9seu9SnR
         VXQbrB5aN3h114MY50GLv+DXQXm7mEnp6vo5tY1ph7uRrge4L6PxbOUkdEVmSEWkVw
         /c6gtravVnfag==
Date:   Thu, 7 Apr 2022 12:06:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Quirk Intel DG2 ASPM L1 acceptable latency to be
 unlimited
Message-ID: <20220407170655.GA249049@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405093810.76613-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 05, 2022 at 12:38:10PM +0300, Mika Westerberg wrote:
> Intel DG2 discrete graphics PCIe endpoints hard-code their acceptable L1
> ASPM latency to be < 1us even though the hardware actually supports
> higher latencies (> 64 us) just fine. In order to allow the links to go
> into L1 and save power, quirk the acceptable L1 ASPM latency for these
> endpoints to be unlimited.
> 
> Note this does not have any effect unless the user requested the kernel
> to enable ASPM in the first place (by default we don't enable it). This
> is done with "pcie_aspm=force pcie_aspm.policy=powersupsersave" command
> line parameters.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I wordsmithed as below and applied to pci/aspm for v5.19, thanks!

Please double-check that I didn't screw up the FIELD_GET/PREP usage.

> ---
>  drivers/pci/quirks.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index da829274fc66..e97b5daa00eb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5895,3 +5895,47 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
> +
> +#ifdef CONFIG_PCIEASPM
> +/*
> + * Intel DG2 graphics card has hard-coded acceptable L1 latency that is
> + * too low which prevents ASPM to be enabled. It does support ASPM L1
> + * and tolerates higher latencies so quirk it to be unlimited.
> + */
> +static void quirk_aspm_accepted_l1_latency(struct pci_dev *dev)
> +{
> +	if ((dev->devcap & PCI_EXP_DEVCAP_L1) >> 9 < 7) {
> +		u32 devcap = dev->devcap;
> +
> +		dev->devcap |= 7 << 9;
> +		pci_info(dev, "quirking devcap for L1 accepted latency 0x%08x -> 0x%08x\n",
> +			 devcap, dev->devcap);
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f80, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f81, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f82, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f83, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f84, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f85, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f86, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f87, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f88, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5690, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5691, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5692, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5693, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5694, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5695, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a0, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a1, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a2, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a3, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a4, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a5, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a6, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, quirk_aspm_accepted_l1_latency);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, quirk_aspm_accepted_l1_latency);
> +#endif


commit 03038d84ace7 ("PCI/ASPM: Make Intel DG2 L1 acceptable latency unlimited")
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue Apr 5 12:38:10 2022 +0300

    PCI/ASPM: Make Intel DG2 L1 acceptable latency unlimited
    
    Intel DG2 discrete graphics PCIe endpoints advertise L1 acceptable exit
    latency to be < 1us even though they can actually tolerate unlimited exit
    latencies just fine. Quirk the L1 acceptable exit latency for these
    endpoints to be unlimited so ASPM L1 can be enabled.
    
    [bhelgaas: use FIELD_GET/FIELD_PREP, wordsmith comment & commit log]
    Link: https://lore.kernel.org/r/20220405093810.76613-1-mika.westerberg@linux.intel.com
    Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..41aeaa235132 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -5895,3 +5896,49 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
+
+#ifdef CONFIG_PCIEASPM
+/*
+ * Several Intel DG2 graphics devices advertise that they can only tolerate
+ * 1us latency when transitioning from L1 to L0, which may prevent ASPM L1
+ * from being enabled.  But in fact these devices can tolerate unlimited
+ * latency.  Override their Device Capabilities value to allow ASPM L1 to
+ * be enabled.
+ */
+static void aspm_l1_acceptable_latency(struct pci_dev *dev)
+{
+	u32 l1_lat = FIELD_GET(PCI_EXP_DEVCAP_L1, dev->devcap);
+
+	if (l1_lat < 7) {
+		dev->devcap |= FIELD_PREP(PCI_EXP_DEVCAP_L1, 7);
+		pci_info(dev, "ASPM: overriding L1 acceptable latency from %#x to 0x7\n",
+			 l1_lat);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f80, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f81, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f82, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f83, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f84, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f85, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f86, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f87, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f88, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5690, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5691, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5692, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5693, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5694, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5695, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a0, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a1, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a2, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a3, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a4, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a5, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a6, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
+#endif
