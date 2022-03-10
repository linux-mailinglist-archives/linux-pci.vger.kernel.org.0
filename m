Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD14D51BC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiCJTgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiCJTgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:36:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F8155C00;
        Thu, 10 Mar 2022 11:35:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFB3611B9;
        Thu, 10 Mar 2022 19:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28613C340E8;
        Thu, 10 Mar 2022 19:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646940902;
        bh=RL5pztp2gZRHUHbTqmyhvO+U8YHRPoTBR9IFLcYrtXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uN0K75A8Ja2VXwbtF5rG0Dle9yTeH3e3vO0oQyZm4SGluKtUUaGMqenMCmCCEtzdH
         MZ2etMieW1A5TDtEWuYZghJepB9u7himDtCzQ/ouUeS/cyJ9AtesQoTMet99LuxIiR
         2xjcek279pVMOH0mB5QIwihQDHDOO0W73+50utARWtHl7VVyMJUiO548IsQjdaokYR
         fMgPr8zeNtsvl9SQD1o0Aot+wQOKoxFDUDqs0/h8D8vRU9eSqoD3IPu8EUI/BZbvtp
         N97pyRJNPPMAIrOkkd+UKYZdZEaBkoA3wvfbln4BAeppUjL/tPHtKPRzZBgHCUfxpI
         QPirlhCjNJ2Fg==
Date:   Thu, 10 Mar 2022 13:34:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V1 RESEND 1/4] pci: add interface to create pci-ep device
 tree node
Message-ID: <20220310193458.GA167650@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305052304.726050-2-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Run "git log --oneline drivers/pci/of.c" and follow the convention,
e.g., something like:

  PCI: Add DT Endpoint description interfaces

On Fri, Mar 04, 2022 at 09:23:01PM -0800, Lizhi Hou wrote:
> This patch enables PCIe device to uses flattened device tree to describe
> apertures in its PCIe BARs. The aperture address consists of PCIe BAR index
> and offset.
> 
> For this kind of device, the driver probe routine calls the new added
> interface to create a device tree node. This device tree node is attached
> under system device tree root. Then the driver may load the flatten device
> tree overlay and attach it under this node. And the node also contains
> 'ranges' property which is used to translate aperture address(BAR index
> and offset) to CPU address.

In the commit log, please say *what* this patch does and why we need
it.  The current text talks about how some interface might be used,
but doesn't specifically say what interface that is or that this patch
adds it.

It should also have a specific pointer to the relevant DT binding.

> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/pci/of.c       | 180 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  15 ++++
>  2 files changed, 195 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..198f08351070 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -605,6 +605,186 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  	return pci_parse_request_of_pci_ranges(dev, bridge);
>  }
>  
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +
> +static void devm_of_pci_destroy_bus_endpoint(struct device *dev, void *res)
> +{
> +	struct device_node *node = res;
> +
> +	of_detach_node(node);
> +}
> +
> +static int of_ep_add_property(struct device *dev, struct property **proplist, const char *name,

Please rewrap code and comments to fit in 80 columns like the rest of
the file.  There's a lot more below that I snipped out.

Bjorn
