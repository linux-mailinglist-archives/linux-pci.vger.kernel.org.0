Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAFF4F4715
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiDEU7G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457526AbiDEQDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 12:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941BCA
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 09:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D196181A
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 16:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE24C385A1;
        Tue,  5 Apr 2022 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649174513;
        bh=GE5uRBmpLRJMOqnbsnsU204Id1cXY6Y5vbAmBZ31xUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gYgDOD4ff0bPHyV22dHzf28Ez8dpgKrdtIUPGiMyr/HANIPPBLmIPDk+0T9ga9F9p
         Hq4rnP2YSINFzFoljvefZ0VMRVAIgzlD1JdA26VAON9ndkk7c7Lgj5aEPMU1YwPoo9
         pePIWxuGTCsgEaeK/Yw03eMeHszXlKqP1KNmMLVDt8tbGrE2rdyLL2CH3xaTJBDITQ
         /bl5qKto59e6RF3t02wLG/3cHEvN8ViBQ2NXtb4mQsEYlt/hncfBbvragCcr0cndVZ
         XzxiiUnZo5S6v8mHiE+tTAvjqFrl07MkSSrR7Q1fi4EcJ8l5Rg8PG77cmPo00D+mw1
         8k4+C36YOnYJQ==
Date:   Tue, 5 Apr 2022 11:01:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Quirk Intel DG2 ASPM L1 acceptable latency to be
 unlimited
Message-ID: <20220405160151.GA68831@bhelgaas>
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

Is there a plan to fix this in future DG2 hardware/firmware?
Obviously the point of Dev Cap is to make the device self-describing
so we can avoid updates like this every time new hardware comes out.

> Note this does not have any effect unless the user requested the kernel
> to enable ASPM in the first place (by default we don't enable it). 

I think this depends on the platform and kernel config, doesn't it?
If CONFIG_PCIEASPM_POWERSAVE=y or CONFIG_PCIEASPM_POWER_SUPERSAVE=y
I suspect we would enable ASPM L1 even without the parameters below.

> This is done with "pcie_aspm=force pcie_aspm.policy=powersupsersave"
> command line parameters.

s/powersupsersave/powersupersave/

This should affect "powersave" as well as "powersupersave", right?
Both enable L1.  "powersupersave" enables the L1 substates.

We *should* be able to enable/disable ASPM L1 using the sysfs "l1_aspm
file, too.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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
> -- 
> 2.35.1
> 
