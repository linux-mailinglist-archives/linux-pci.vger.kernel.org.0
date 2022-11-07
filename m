Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6691962006D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiKGVJj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiKGVJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:09:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9352CE28;
        Mon,  7 Nov 2022 13:06:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52F0EB81699;
        Mon,  7 Nov 2022 21:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3213C433B5;
        Mon,  7 Nov 2022 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667855160;
        bh=pefoyR60rzhiUzFe5oioggk7k8lK8qb9L2ld/HDcRMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fQ2aOX8nSDqYl9NL4OWckKxCqwu3HAkOdLfXKF6hsZ5pakk6YrtrGhOmpnEHVRjqx
         qfdWef6vd7kZpf0Q/2EwV+nPZTjIXMzOPSX4VAeCqAw0o+A8iqcKbXnP5Vy3lNM64G
         7h3T6YLgN6wPiKlix2S81DT2H6wuN8FmYZPMhy+HJovfjM16qP/nhV8XWoP4TKBu5P
         w/FJ3t0dkRo4T6T3YUAGdRAGuNuNiBulAaX/zU5ATLHia7/Z7suNuK5d14QJ4IXOjk
         UxeIbAUy5JDW+s8SenQv9DAgoxnl28T0mGrYCouAHoy9a1W6KRRpELWOWImCcrxYML
         ZCrYl25BiRVXw==
Date:   Mon, 7 Nov 2022 15:05:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, clement.leger@bootlin.com,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH RFC V3 2/2] PCI: Create device tree node for selected
 devices
Message-ID: <20221107210559.GA419452@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667575454-18706-3-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 04, 2022 at 08:24:14AM -0700, Lizhi Hou wrote:
> The PCIe endpoint device such as Xilinx Alveo PCIe card maps the register
> spaces from multiple hardware peripherals to its PCIe BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
> 
> For Alveo PCIe card, the card firmware provides a flattened device tree to
> describe the hardware peripherals on its BARs. The Alveo card driver can
> load this flattened device tree and leverage device tree framework to
> generate platform devices for the hardware peripherals eventually.
> 
> Apparently, the device tree framework requires a device tree node for the
> PCIe device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCIe is self discoverable bus, there might
> not be a device tree node created for PCIe devices. This patch is to add
> support to generate device tree node for PCIe devices. It introduces a
> kernel option. When the option is turned on, the kernel will generate

Specify the kernel option here.  These last two sentences should
probably be a separate paragraph because they say specifically what
this patch does.

> device tree nodes for PCI bridges unconditionally.

> It will also generate
> a device tree node for Xilinx Alveo U50 by using PCI quirks.

I think I would split the Xilinx Alveo U50 quirk to a separate patch
from the infrastructure and make this patch more generic.

> +config PCI_DYNAMIC_OF_NODES
> +	bool "Device tree node for PCI devices"
> +	depends on OF
> +	select OF_DYNAMIC
> +	help
> +	  This option enables support for generating device tree nodes for some
> +	  PCI devices. Thus, the driver of this kind can load and overlay
> +	  flattened device tree for its downstream devices.
> +
> +	  Once this option is selected, the device tree nodes will be generated
> +	  for all PCI/PCIE bridges.

PCI/PCIe

Actually, in this context (and in the commit log), you should just say
"PCI" because there's nothing PCIe-specific here.

> +void of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +	struct device_node *parent, *dt_node = NULL;
> +	const char *pci_type = "dev";
> +	struct of_changeset *cset;
> +	const char *full_name;
> +	int ret;
> +
> +	/*
> +	 * if there is already a device tree node linked to this device,
> +	 * return immediately.

s/if there/If there/

> +	 */
> +	if (pci_device_to_OF_node(pdev))
> +		return;
> +
> +	/* check if there is device tree node for parent device */

s/check/Check/

Follow the style of the file, which is "capitalize English sentences."
