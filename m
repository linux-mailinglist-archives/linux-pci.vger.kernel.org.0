Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054554AC7D3
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiBGRsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 12:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384311AbiBGRgy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 12:36:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FB7C0401D5;
        Mon,  7 Feb 2022 09:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5717B815C6;
        Mon,  7 Feb 2022 17:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C3CC004E1;
        Mon,  7 Feb 2022 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644255410;
        bh=/7YN1m76qf4snYDMVXR15LGTPvRjVN/AzA2qo6qhVtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sIIeoPL8OANAhj44U1X2u3zQNXXTY1oNGPK1fQdVT33tNkvktg0GpxHLyNj3K0x0Y
         wtLfKFRIAPZAXgk6+w5ADLpkcGocrbN7xLd3pMhnGVkDs7MLXNgdzQHEBb+dHjMOCA
         lPu5UbwA4JkRzAAZglw0pPUuwOTIVReV56CBlvm1GdMxqXbvCjeYYGxm1aKC3/xnlE
         LVAsPetTzl99KaBACPC+Q4vhd2QS7IScea5Vt041eaunVaLh9tAUgXN4J26/cEi2V1
         gqn18+3Cut7ljOd6vFbBscsv+wvwpDnmq2ODyZpbafGo39RxgCSfqrEsbZ3+4IsH09
         yhC3Bq8NCI8wg==
Date:   Mon, 7 Feb 2022 11:36:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, krzysztof.kozlowski@canonical.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 09/10] PCI: Disable MSI for Tegra234 root ports
Message-ID: <20220207173648.GA402391@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205162144.30240-10-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 05, 2022 at 09:51:43PM +0530, Vidya Sagar wrote:
> Tegra234 PCIe rootports don't generate MSI interrupts for PME and AER
> events. Since PCIe spec (Ref: r4.0 sec 7.7.1.2 and 7.7.2.2) doesn't support
> using a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root
> ports service drivers registering their respective ISRs with MSI interrupt
> and to let only INTx be used for all events.

s/rootports/root ports/ to match other usage here.

This argument matches that in 8c7e96d3fe75 ("PCI: Disable MSI for
Tegra root ports") [1], but that's not quite what sec 7.7.1.2 and
7.7.2.2 say.  Those sections talk about what happens when both MSI and
MSI-X are disabled:

  If MSI and MSI-X are both disabled, the Function requests servicing
  using INTx interrupts (if supported).

but they don't say anything about what happens when MSI or MSI-X is
*enabled*.

I think a better citation is PCIe r6.0, sec 6.1.4.3, which says:

  While enabled for MSI or MSI-X operation, a Function is prohibited
  from using INTx interrupts (if implemented) to request service (MSI,
  MSI-X, and INTx are mutually exclusive).

Can you please update the comment in the code and this commit log to
cite PCIe r6.0, sec 6.1.4.3 instead, and to clarify that these Tegra
devices always use INTx for PME and AER, even when MSI/MSI-X is
enabled?

Why do these Tegra quirks use DECLARE_PCI_FIXUP_CLASS_EARLY() instead
of just DECLARE_PCI_FIXUP_EARLY()?  quirk_al_msi_disable() uses the
_CLASS version because the same Device ID is used for non-Root Port
devices.  Is the same true here, or could these use
DECLARE_PCI_FIXUP_EARLY()?

There are many quirks that disable MSI, and they're a mixture of EARLY
and FINAL.  They should probably all be the same.

[1] https://git.kernel.org/linus/8c7e96d3fe75

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/quirks.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d2dd6a6cda60..3ac5c45e61a1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2747,6 +2747,15 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
>  			      PCI_CLASS_BRIDGE_PCI, 8,
>  			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229a,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229c,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229e,
> +			      PCI_CLASS_BRIDGE_PCI, 8,
> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>  
>  /*
>   * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
> -- 
> 2.17.1
> 
