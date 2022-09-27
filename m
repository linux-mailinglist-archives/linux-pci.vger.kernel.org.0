Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225935ED05A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 00:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiI0WlC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiI0WlB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 18:41:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499CCE62CF
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 15:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2BAFB81D8E
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 22:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697DDC433C1;
        Tue, 27 Sep 2022 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664318456;
        bh=oeBUAtOvBMAr8nvb+I7ydT8FTCVTIOQdHqv4NyV1CYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g5y/T3Qdg1yH0sJqQ+/Mlon8hS2/utlYCFvuG4iVXAIMKPRVf3VEJCSNnGaLZvcQW
         a8d+nQkB75A6Fw0pjITIFwRYHSvvHN2PgzocsIz6CK7mjwbAMSzRObwY2BSrW1rMbI
         NGe655ZXER0DkKSwzvgQER7kry46tZ500jMomtvc93VSu66Ixnc+10PV1YAvIuOHbC
         HfaKoO6czP6maebc6jNQPsPMsGMGeEDa9CupYTTQ8U4cK1IP3B+8OKsQdWgOgtLs8I
         DdIuyqOrzvgX5CXPqOrY2qj3cZabr5ogSbvSqYslBvLt99rBCitlev/97I5BPAYkF0
         8KONDtMAYUvXQ==
Date:   Tue, 27 Sep 2022 17:40:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>, oohall@gmail.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Quirk PIO log size for certain Intel PCIe root
 ports
Message-ID: <20220927224054.GA1739368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816102042.69125-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 01:20:42PM +0300, Mika Westerberg wrote:
> There is a BIOS bug on Intel Tiger Lake and Alder Lake systems that
> accidentally clears the root port PIO log size even though it should be 4.
> Fix the affected root ports by forcing the log size to be 4 if it is set
> to 0. The BIOS for the next generation CPUs should have this fixed.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209943
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 13 ++++++++-----
>  drivers/pci/quirks.c   | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3e9afee02e8d..ab06c801a2c1 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -335,11 +335,14 @@ void pci_dpc_init(struct pci_dev *pdev)
>  		return;
>  
>  	pdev->dpc_rp_extensions = true;
> -	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> -	if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> -		pci_err(pdev, "RP PIO log size %u is invalid\n",
> -			pdev->dpc_rp_log_size);
> -		pdev->dpc_rp_log_size = 0;
> +	/* If not already set by the quirk in quirks.c */
> +	if (!pdev->dpc_rp_log_size) {
> +		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> +		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> +			pci_err(pdev, "RP PIO log size %u is invalid\n",
> +				pdev->dpc_rp_log_size);
> +			pdev->dpc_rp_log_size = 0;
> +		}
>  	}
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4944798e75b5..260d8b50f68d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5956,3 +5956,40 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
>  #endif
> +
> +#ifdef CONFIG_PCIE_DPC
> +/*
> + * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
> + * log size of the integrated Thunderbolt PCIe root ports so we quirk
> + * them here.
> + */
> +static void dpc_log_size(struct pci_dev *dev)
> +{
> +	u16 dpc_cap, val;
> +
> +	dpc_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
> +	if (!dpc_cap)
> +		return;
> +
> +	pci_read_config_word(dev, dpc_cap + PCI_EXP_DPC_CAP, &val);
> +	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
> +		return;
> +
> +	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
> +		pci_info(dev, "quirking RP PIO log size\n");
> +		dev->dpc_rp_log_size = 4;

Just to clarify here, I originally thought this was only a cosmetic
fix, and the "DPC: RP PIO log size 0 is invalid" could be ignored.

I guess it's true that it can be ignored, but it *also* means that
dpc_process_rp_pio_error() will not dump the RP PIO Header Log even
though these devices support the RP Extensions and implement the RP
PIO Log registers, right?

> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a29, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> +#endif
> -- 
> 2.35.1
> 
