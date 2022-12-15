Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0964DD8F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLOPQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 10:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLOPQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 10:16:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A8C41;
        Thu, 15 Dec 2022 07:16:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C22C61E02;
        Thu, 15 Dec 2022 15:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2833C433D2;
        Thu, 15 Dec 2022 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671117365;
        bh=cBgSIru1pITsKCwDOtDk3RnfP0ZrdZbqDp9L2906qZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MyYLru0L9NgkTFyfkHQQTfIWdA6Cm2BUF3f/o/TOZ1O4gzqhxec5JsOhnPLKtEKoQ
         nqmgaTUlFmRpnaCYTamJhyQI+MhTAxGbi3jhdioAWdQ0jP4knDdHX27t+uOzlagUXb
         T3eWOVrsb1VkfW4g/83aAuH3HuQe34Q6ZwGBozEXWrIqYOelvGOCDdkuUYWZarcItP
         MyfRCqmOziVA1VVNT4SUCeD6jY0do3vcr+Egj0XT9T5v+jTQjsNMM/SJFRekF/zpYb
         ihO4GFmumhzBlI6//cflDpEj3vGBBqup1G+8dzX4VVYntq3+RVFQmQURC9si/syqMj
         e+gBcRzO2VK0g==
Date:   Thu, 15 Dec 2022 09:16:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ron Lee <ron.lee.intel@gmail.com>
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: Re: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Message-ID: <20221215151604.GA107336@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215091357.8738-1-ron.lee@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 15, 2022 at 05:13:57PM +0800, Ron Lee wrote:
> On Google Coral and Reef family chromebooks, the PCIe bridge lost its
> L1 PM Substates capability after resumed from D3cold, and identify that
> the pointer to the this capability and capapability header are missing
> from the capability list.

s/chromebooks/Chromebooks/
s/to the this/this/
s/capapability/capability/

This should say what problem we're solving.  I assume some devices
used L1 PM Substates before suspend, but after resume they do not, so
the user-visible effect is that battery life is worse after resume.

> Capabilities: [150 v0] Null
> Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ ...
>                   PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>         L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                    T_CommonMode=40us LTR1.2_Threshold=98304ns
>         L1SubCtl2: T_PwrOn=60us

I'm not sure what this snippet is telling me.  Based on the patch, I
guess before suspend, lspci would show:

  Capabilities: [150 v0] Null
  Capabilities: [200 v1] L1 PM Substates
  Capabilities: [220] <some other valid capability?>

but after resume, you see only:

  Capabilities: [150 v0] Null

Right?

> This patch fix up the header and the pointer to the L1SS capability
> after resuming from D3Cold.

The main problem here is that this patch covers up an issue without
saying what the root cause is.  Presumably this is a firmware issue.
Has that been identified?  Has it been fixed for future firmware
releases?

s/D3Cold/D3cold/ to match above.

Is there a bug report for this issue?  Include the URL here.

Is there a bug report for the firmware?

> Signed-off-by: Ron Lee <ron.lee@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Nits:

  - Use "Apollo Lake" to match Intel usage.

  - Below the "---" line, mention what changed between v1 and v2 (I
    see that you added the "#ifdef CONFIG_PCIEASPM", but you should
    save readers the effort of figuring that out).

  - For work-in-progress, the "Reported-by: kernel test robot" is
    pointless and I will remove it.  This quirk is not fixing a bug
    reported by the robot.

>  drivers/pci/quirks.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 285acc4aaccc..fc959be17a9d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5992,3 +5992,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +#ifdef CONFIG_PCIEASPM
> +static void chromeos_fixup_apl_bridge_l1ss_capability(struct pci_dev *pdev)
> +{
> +	if (!dmi_match(DMI_SYS_VENDOR, "Google") ||
> +		(!dmi_match(DMI_PRODUCT_FAMILY, "Google_Coral") &&
> +		 !dmi_match(DMI_PRODUCT_FAMILY, "Google_Reef")))
> +		return;
> +
> +	pci_info(pdev, "Fix up L1SS Capability\n");
> +	/* Fix up the L1SS Capability Header*/
> +	pci_write_config_dword(pdev, pdev->l1ss, (0x220 << 20) | (1 << 16) | (PCI_EXT_CAP_ID_L1SS));

This looks like it adds a link to another capability at offset 0x220.
What is that, and how do we know this is safe?

These registers are read-only per spec (PCIe r6.0, sec 7.8.3.1), but I
guess you have device-specific knowledge that they are writable?

> +	/* Fix up the pointer to L1SS Capability*/
> +	pci_write_config_dword(pdev, 0x150, pdev->l1ss << 20);
> +}
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_bridge_l1ss_capability);
> +#endif
> 
> base-commit: e2ca6ba6ba0152361aa4fcbf6067db71b2c7a770
> -- 
> 2.17.1
> 
