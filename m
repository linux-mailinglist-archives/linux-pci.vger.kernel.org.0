Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914FA620122
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKGV1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGV1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:27:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4BEDE5;
        Mon,  7 Nov 2022 13:27:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 196E86130A;
        Mon,  7 Nov 2022 21:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E2AC433B5;
        Mon,  7 Nov 2022 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667856460;
        bh=Y9ievI8xmiGIfwMRNVx6qBK1od74wXXSEXRcznQ0g04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FUFq9w6GPWRw7xk5f83wNH93Xc9Pafg4pOjKwkSnGhOdxprdH8hQ75gbJY20MvXR0
         0LuLwCOTizKdEBEc2myVmCsi5wIWdlkTM/lHg8FUU/gtnHk+hFbQHZ0qJc05MzK69m
         JGKhRcir88L8PLDB6jHfgbmI9CryzD7gPAqWkz8pZ/NKQ4bOtuppksiq3fTTfHpiCS
         eEBp/ojgnFGvf1YkkDCftUFwc7eiMIIvL7Ri0Y1zAa86BwdtwoBXiHziUCHucdFzyn
         EcrGao4s6brtUMWRDbGUp0ysu5Fv+25UpbshhsNGzgTSvSu7nmSeDQpCbNt/UjHNRE
         UvWows2gqkquw==
Date:   Mon, 7 Nov 2022 15:27:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] PCI: Consistently report presence of PCIe link
 registers
Message-ID: <20221107212738.GA421803@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2209100057070.2275@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 17, 2022 at 01:03:09PM +0100, Maciej W. Rozycki wrote:
> Consistently with commit c8b303d0206b ("PCI: Remove PCIe Capability 
> version checks") only consider the PCI Express capability's Link Control 
> 2, etc. registers present if the Link Control register is.
> 
> Before said commit with PCI Express capability versions higher than one 
> all link registers used to be considered present, however starting from 
> said commit Link Control, etc. original registers are only considered 
> present in devices with links, but Link Control 2, etc. registers 
> continue being considered always present even though likewise they are 
> only present in devices with links.
> 
> Fix the inconsistency then.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

While we figure out the rest of this, I squashed the first two patches
and applied them to pci/enumeration for v6.2:

  commit 503fa23614dc ("PCI: Access Link 2 registers only for devices with Links")
  Author: Maciej W. Rozycki <macro@orcam.me.uk>
  Date:   Sat Sep 17 13:03:09 2022 +0100

    PCI: Access Link 2 registers only for devices with Links

    PCIe r2.0, sec 7.8 added Link Capabilities/Status/Control 2 registers to
    the PCIe Capability with Capability Version 2.

    Previously we assumed these registers were implemented for all PCIe
    Capabilities of version 2 or greater, but in fact they are only
    implemented for devices with Links.

    Update pcie_capability_reg_implemented() to check whether the device has
    a Link.

> ---
> New change in v5.
> ---
>  drivers/pci/access.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> linux-pcie-cap-has-lnkctl2.diff
> Index: linux-macro/drivers/pci/access.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/access.c
> +++ linux-macro/drivers/pci/access.c
> @@ -350,6 +350,11 @@ bool pcie_cap_has_lnkctl(const struct pc
>  	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
>  }
>  
> +static inline bool pcie_cap_has_lnkctl2(const struct pci_dev *dev)
> +{
> +	return pcie_cap_has_lnkctl(dev) && pcie_cap_version(dev) > 1;
> +}
> +
>  static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
>  {
>  	return pcie_downstream_port(dev) &&
> @@ -390,10 +395,11 @@ static bool pcie_capability_reg_implemen
>  		return pcie_cap_has_rtctl(dev);
>  	case PCI_EXP_DEVCAP2:
>  	case PCI_EXP_DEVCTL2:
> +		return pcie_cap_version(dev) > 1;
>  	case PCI_EXP_LNKCAP2:
>  	case PCI_EXP_LNKCTL2:
>  	case PCI_EXP_LNKSTA2:
> -		return pcie_cap_version(dev) > 1;
> +		return pcie_cap_has_lnkctl2(dev);
>  	default:
>  		return false;
>  	}
