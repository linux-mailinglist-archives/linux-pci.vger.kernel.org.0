Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1C6FFCD3
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 00:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjEKWsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjEKWst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 18:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0C5583
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 15:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7351633CB
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 22:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF9BC433EF;
        Thu, 11 May 2023 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683845321;
        bh=nMxyaThUTIgxsea5AHPPTFQvv3Qk/mhawE/zc6qeB+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ApUQj7DWPwLdoXXjLNkHs2cm+t3zk1ktCPNa7Lb/mWa9x0OAF87RyL3f3uwNe1Vdn
         K51w3TdLdkK0MZpDd2bRNFOzPBNSCWZimT1PPLMn80ktmhWDW8SMf6gfyTj5CI3Vv1
         M0AIBVwZ1NOh0xLWYYmHswyeajQjJvm7df22eGFmiEg9E38OT20t9mutxD/Ryu67W0
         iw07CWD5Z69x72KyxiFqNEH6p00v9bk6vv2gDfB+1Iq0DDo7/in7rpq4BZqOGdxqFV
         AbOoklfeOFIOEOThLiLl6/AiCH2ZkLKlEPfimQlh+22WrnAABD6iOx4Bem0ewQfrVC
         GpdmhcW9JZWaQ==
Date:   Thu, 11 May 2023 17:48:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Apply PIO log size quirk to Intel Ice Lake Root
 Ports too
Message-ID: <ZF1wxzk9oS8u/2Rj@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511121905.73949-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 03:19:05PM +0300, Mika Westerberg wrote:
> Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
> Ports") added quirk for Tiger and Alder Lake Root Ports but missed that
> the same issue exists also in the previous generation, Ice Lake, Root
> Ports.
> 
> For this reason apply the quirk for Ice Lake Root Ports as well.
> 
> Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=209943
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-linus for v6.4, thanks!

I edited the commit log slightly:

    PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

    Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
    Ports") added quirks for Tiger and Alder Lake Root Ports but missed that
    the same issue exists also in the previous generation, Ice Lake.

    Apply the quirk for Ice Lake Root Ports as well.  This prevents kernel
    complaints like:

      DPC: RP PIO log size 0 is invalid

    and also enables the DPC driver to dump the RP PIO Log registers when DPC
    is triggered.

    [bhelgaas: add dmesg warning and RP PIO Log dump info]

> ---
>  drivers/pci/quirks.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0304fc97c22..8206228a95e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6006,8 +6006,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency
>  
>  #ifdef CONFIG_PCIE_DPC
>  /*
> - * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
> - * RP PIO Log Size of the integrated Thunderbolt PCIe Root Ports.
> + * Intel Ice Lake, Tiger Lake and Alder Lake BIOS has a bug that clears
> + * the DPC RP PIO Log Size of the integrated Thunderbolt PCIe Root
> + * Ports.
>   */
>  static void dpc_log_size(struct pci_dev *dev)
>  {
> @@ -6030,6 +6031,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1d, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a21, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a23, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
> -- 
> 2.39.2
> 
