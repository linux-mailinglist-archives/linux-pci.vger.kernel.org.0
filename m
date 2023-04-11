Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA136DE384
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjDKSIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjDKSIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 14:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D272BD;
        Tue, 11 Apr 2023 11:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F5662A97;
        Tue, 11 Apr 2023 18:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B49C433D2;
        Tue, 11 Apr 2023 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681236490;
        bh=72azhK5a4Tm/QmKpsinq8I4kCaXD/G/VL613SGoswso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=COsl7hYIeE07a2xkdxFTWGNh8u40vqAvQ0Frcb6sdYYGAx2IrY8BKDH95mnUfNZuB
         hRS/W3sNpHU+smmQfTYA45Tce1WSdjGPiUIHbcmFOAoP79fjfraAgtTxaQBWd/p/RG
         DY4bqXn/DTB3BlYAvPSxDoTaPXo7I1RSMClUbSWGrVoTgtQWehymQd44AxgyHNH+Cg
         vSiTQs0WqZpXpc7NhI6rIJJegpTJaJPnXGZjxXaXX+qGW/Xv4dkGMEEFxfm+gJVkO+
         2G2LH0D8WSwRp3A+HhmXTLXsY3h4XW7SEoOwvsSln8XM/vu+Hf292zyLx3sQQX4hd7
         5UR6GvLArscRQ==
Date:   Tue, 11 Apr 2023 13:08:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ron Lee <ron.lee.intel@gmail.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lmajczak@google.com, rajatja@google.com,
        Ron Lee <ron.lee@intel.com>
Subject: Re: [PATCH v4] PCI: Fix up L1SS capability for Intel Apollo Lake
 Root Port
Message-ID: <20230411180808.GA4164437@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411160213.4453-1-ron.lee@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 12:02:13AM +0800, Ron Lee wrote:
> On Google Coral and Reef family Chromebooks with Intel Apollo Lake
> SoC, firmware clobbers the header of the L1 PM Substates capability and
> the previous capability when returning D3cold to D0.
> 
> Save those header at enumeration-time and restore them at resume.
> 
> Link: https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com/T/#u
> Signed-off-by: Ron Lee <ron.lee@intel.com>

Applied to pci/aspm for v6.4, thanks!

> ---
> Changes from v3: 
> - Move to arch/x86/pci/fixup.c
> - Save prev cap offset & header, L1SS offset & header at enumeration-time
>   and restore them at resume
> - Remove CONFIG_PCIEASPM directive
> - Stop traversal if L1SS capability was found
> 
>  arch/x86/pci/fixup.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 615a76d70019..28335aaa6c33 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -824,3 +824,62 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_fix_64bit_dma);
>  
>  #endif
> +
> +/*
> + * When returning from D3cold to D0, firmware on some Google Coral and Reef
> + * family Chromebooks with Intel Apollo Lake SoC clobbers the headers of
> + * both the L1 PM Substates capability and the previous capability for the
> + * "Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1".
> + *
> + * Save those values at enumeration-time and restore them at resume.
> + */
> +
> +static u16 prev_cap, l1ss_cap;
> +static u32 prev_header, l1ss_header;
> +
> +static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *dev)
> +{
> +	int pos = PCI_CFG_SPACE_SIZE, prev = 0;
> +	u32 header, pheader = 0;
> +
> +	while (pos) {
> +		pci_read_config_dword(dev, pos, &header);
> +		if (PCI_EXT_CAP_ID(header) == PCI_EXT_CAP_ID_L1SS) {
> +			prev_cap = prev;
> +			prev_header = pheader;
> +			l1ss_cap = pos;
> +			l1ss_header = header;
> +			return;
> +		}
> +
> +		prev = pos;
> +		pheader = header;
> +		pos = PCI_EXT_CAP_NEXT(header);
> +	}
> +}
> +
> +static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
> +{
> +	u32 header;
> +
> +	if (!prev_cap || !prev_header || !l1ss_cap || !l1ss_header)
> +		return;
> +
> +	/* Fixup the header of L1SS Capability if missing */
> +	pci_read_config_dword(dev, l1ss_cap, &header);
> +	if (header != l1ss_header) {
> +		pci_write_config_dword(dev, l1ss_cap, l1ss_header);
> +		pci_info(dev, "restore L1SS Capability header (was %#010x now %#010x)\n",
> +			 header, l1ss_header);
> +	}
> +
> +	/* Fixup the link to L1SS Capability if missing */
> +	pci_read_config_dword(dev, prev_cap, &header);
> +	if (header != prev_header) {
> +		pci_write_config_dword(dev, prev_cap, prev_header);
> +		pci_info(dev, "restore previous Capability header (was %#010x now %#010x)\n",
> +			 header, prev_header);
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_pci_l1ss_capability);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pci_l1ss_capability);
> -- 
> 2.17.1
> 
