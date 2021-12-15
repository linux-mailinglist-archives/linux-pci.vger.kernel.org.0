Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8D47602E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 19:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhLOSEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 13:04:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33448 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhLOSEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 13:04:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7146FB8204E;
        Wed, 15 Dec 2021 18:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76DFC36AE2;
        Wed, 15 Dec 2021 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639591468;
        bh=18jlQXn8GsJk8ktn95iAp+RUAHkb8AwPmqEijKfXRdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gI+g2CiojBkA075/sn8fWSTAzaXiUZoj1aOW/54/l0zDa2lJEA4Jv7nMsfR3OVnbw
         aJqtv2iHxq6/UiJ+ia6z8+jpyeY2S7t1UDsLgsUwOlD9tNT4G+WGe+HIQz3TfuT+wd
         ny4g5rQAkRE+Cm66aL9BCTE73P35UnJ1CzujxWQLKxwRcwEToI/LRhqozZsaqIZI6s
         JUM2Q19CDpBSCOssAo6GN4NagFIzd1lgHGjZSYS12Yq7YQ+uKUwguzzbPQ84/K6XGS
         6Z5VR7YzrImR6OwBtHDOWJffBaeSeWVWPnaCAhMUpgXW6c50d4u4OYMNjG8hakhJOs
         5z3NoddqVDdZw==
Date:   Wed, 15 Dec 2021 12:04:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rajatxjain@gmail.com, jsbarnes@google.com, gwendal@google.com
Subject: Re: [PATCH] pci/quirks: Add quirk for Bayhub O2 SD controller
Message-ID: <20211215180426.GA702736@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208000948.487820-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 04:09:48PM -0800, Rajat Jain wrote:
> This particular SD controller from O2 / Bayhub only allows dword
> accesses to its LTR max latency registers:
> https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf

What happens if we use a non-dword access?  Unsupported Request?
Invalid data returned?  Writes ignored?

I guess word accesses must not cause PCIe errors, since we still do
them in pci_save_ltr_state() and pci_restore_ltr_state() even with
this patch.

The app note says 0x234 (Max Latency registers), 0x248 (L1 PM
Substates Control 1), and 0x24c (L1 PM Substates Control 2) are all
broken, but the patch only mentions 0x234.

I guess for 0x248 and 0x24c (the L1 PM Substates Control registers),
we're just lucky because those are dword registers, and all current
users already do dword accesses.

What if we instead changed pci_save_ltr_state() and
pci_restore_ltr_state() to do a single dword access instead of two
word accesses?  That kind of sweeps it under the rug, but we're
already doing that for 0x248 and 0x24c.

If we did that, we shouldn't need a quirk at all, but the hardware bug
is still lurking, and we should add a comment about it somewhere.

I guess setpci (and maybe lspci) could still do smaller accesses and
see whatever the bad behavior is.  Hmmm.  Maybe we just have to live
with that.

The app note doesn't actually say how to identify the part -- no
"affected Device ID", for instance.  Are we confident that the other
O2_* devices are unaffected?

> Thus add a quirk that saves and restores these registers
> manually using dword acesses:
> LTR Max Snoop Latency Register
> LTR Max No-Snoop Latency Register
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/mmc/host/sdhci-pci.h |  1 -
>  drivers/pci/quirks.c         | 39 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h      |  1 +
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 5e3193278ff9..d47cc0ba7ca4 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -10,7 +10,6 @@
>  #define PCI_DEVICE_ID_O2_SDS1		0x8421
>  #define PCI_DEVICE_ID_O2_FUJIN2		0x8520
>  #define PCI_DEVICE_ID_O2_SEABIRD0	0x8620
> -#define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
>  
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..b7bd19802744 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5857,3 +5857,42 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
> +
> +/*
> + * Bayhub OZ711LV2 SD controller has an errata that only allows DWORD accesses
> + * to the LTR max latency registers. Thus need to save and restore these
> + * registers manually.
> + */
> +static void o2_seabird1_save_ltr(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u32 *reg32;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (save_state) {
> +		reg32 = &save_state->cap.data[0];
> +		/* Preserve PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
> +		pci_read_config_dword(dev, 0x234, reg32);
> +	} else {
> +		pci_err(dev, "quirk can't save LTR snoop latency\n");
> +	}
> +}
> +
> +static void o2_seabird1_restore_ltr(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u32 *reg32;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (save_state) {
> +		reg32 = &save_state->cap.data[0];
> +		/* Restore PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
> +		pci_write_config_dword(dev, 0x234, *reg32);
> +	} else {
> +		pci_err(dev, "quirk can't restore LTR snoop latency\n");
> +	}
> +}
> +DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
> +			       o2_seabird1_save_ltr);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
> +			       o2_seabird1_restore_ltr);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..6ed16aa38196 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1717,6 +1717,7 @@
>  #define PCI_DEVICE_ID_O2_8221		0x8221
>  #define PCI_DEVICE_ID_O2_8320		0x8320
>  #define PCI_DEVICE_ID_O2_8321		0x8321
> +#define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
>  
>  #define PCI_VENDOR_ID_3DFX		0x121a
>  #define PCI_DEVICE_ID_3DFX_VOODOO	0x0001
> -- 
> 2.34.1.400.ga245620fadb-goog
> 
