Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5337390AC
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 22:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjFUUWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUUWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 16:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A611994;
        Wed, 21 Jun 2023 13:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 535C76152D;
        Wed, 21 Jun 2023 20:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDBEC433C8;
        Wed, 21 Jun 2023 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687378955;
        bh=wA5g5vqAz0CqRF/kWtySTwYdMKrTR74vnbYfHqD6lQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nPrIgPxw4hmzj8K+wnjqnj+G+2uh6ZEhDO/yTNwnLVbkprYTe3gfdVFnY+rsrOwEY
         UV+yMBagiPafs4Mn68SMFdJ5MN/pI4D6lJ3gB0RSixCocSo6saBU0qWayuY8c+oB05
         A6Qq4V/t3xGLTLq4CbDqCgV1HmGkxNKtySwsrTg1yomgHpcCjJ9PaQEkjOmPo3tPjL
         706TYWQ1l1lKSjx8Dim9EjZxlPElfFK0sFRP5XeyB9KkcNpSEhjf9cmsUm7b9WZRTc
         JAM6xDMenVqFZ8xRGliOGlEBxbCKzdO2N4rjw3RgfZ9pNofN7bGzj/59kcjMg1tkoC
         /Jo95iKa+ed9g==
Date:   Wed, 21 Jun 2023 15:22:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 2/5] PCI: Create device tree node for selected devices
Message-ID: <20230621202233.GA115496@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687368849-36722-3-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, IIUC this patch does not actually create device tree nodes
for selected devices.  It looks like it:

  - Adds an of_pci_make_dev_node() *interface* that can be used to
    create this node

  - Creates such a node for *every* bridge

  - Does nothing at all for "selected devices" or the Xilinx Alveo

On Wed, Jun 21, 2023 at 10:34:06AM -0700, Lizhi Hou wrote:
> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
> 
> For Alveo PCI card, the card firmware provides a flattened device tree to
> describe the hardware peripherals on its BARs. The Alveo card driver can
> load this flattened device tree and leverage device tree framework to
> generate platform devices for the hardware peripherals eventually.

The Alveo details are relevant to the quirk patch but not to *this*
patch.

But the reason for creating a node for every bridge device *is*
relevant and should be included here, since that change affects
everybody that uses OF.

> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. This patch is to add
> support to generate device tree node for PCI devices.

s/This patch is to add/Add/

> Added a kernel option. When the option is turned on, the kernel will
> generate device tree nodes for PCI bridges unconditionally.

s/Added a kernel option/Add a PCI_DYNAMIC_OF_NODES config option/
(Be specific, and way what the patch does, not what you did.)

> Initially, the basic properties are added for the dynamically generated
> device tree nodes.

Make this specific, e.g., list the specific properties added.

> +config PCI_DYNAMIC_OF_NODES
> +	bool "Create Devicetree nodes for PCI devices"
> +	depends on OF
> +	select OF_DYNAMIC
> +	help
> +	  This option enables support for generating device tree nodes for some
> +	  PCI devices. Thus, the driver of this kind can load and overlay
> +	  flattened device tree for its downstream devices.
> +
> +	  Once this option is selected, the device tree nodes will be generated
> +	  for all PCI bridges.

Is there a convention for using "devicetree" vs "device tree"?  The
help message uses both and it would be nice to only use one or the
other.

> @@ -501,8 +501,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>  		 * to rely on this function (you ship a firmware that doesn't
>  		 * create device nodes for all PCI devices).
>  		 */
> -		if (ppnode)
> +		if (ppnode && of_property_present(ppnode, "interrupt-map"))

Maybe this deserves a comment?  The connection between "interrupt-map"
and the rest of this patch isn't obvious to me.

Also, it looks like this happens for *everybody*, regardless of
PCI_DYNAMIC_OF_NODES, which seems a little suspect.  If it's an
unrelated bug fix it should be a different patch.

>  			break;
> +		else
> +			ppnode = NULL;

> +void of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +	struct device_node *ppnode, *np = NULL;
> +	const char *pci_type = "dev";
> +	struct of_changeset *cset;
> +	const char *name;
> +	int ret;
> +
> +	/*
> +	 * If there is already a device tree node linked to this device,
> +	 * return immediately.
> +	 */
> +	if (pci_device_to_OF_node(pdev))
> +		return;
> +
> +	/* Check if there is device tree node for parent device */
> +	if (!pdev->bus->self)
> +		ppnode = pdev->bus->dev.of_node;
> +	else
> +		ppnode = pdev->bus->self->dev.of_node;
> +	if (!ppnode)
> +		return;
> +
> +	if (pci_is_bridge(pdev))
> +		pci_type = "pci";

Initialize pci_type = "dev" here instead of way up top:

  if (pci_is_bridge(pdev))
    pci_type = "pci";
  else
    pci_type = "dev";

> +	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));

> +static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
> +			      struct device_node *np)
> +{
> +	struct of_pci_range *rp;
> +	struct resource *res;
> +	int i = 0, j, ret;
> +	u32 flags, num;
> +	u64 val64;
> +
> +	if (pci_is_bridge(pdev)) {
> +		num = PCI_BRIDGE_RESOURCE_NUM;
> +		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
> +	} else {
> +		num = PCI_STD_NUM_BARS;
> +		res = &pdev->resource[PCI_STD_RESOURCES];
> +	}
> +
> +	rp = kcalloc(num, sizeof(*rp), GFP_KERNEL);
> +	if (!rp)
> +		return -ENOMEM;
> +
> +	for (j = 0; j < num; j++) {

Initialize i = 0 here so it's connected with the use:

  for (i = 0, j = 0; j < num; ...)

> +		if (!resource_size(&res[j]))
> +			continue;
> +
> +		if (of_pci_get_addr_flags(&res[j], &flags))
> +			continue;
> +
> +		val64 = res[j].start;
> +		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
> +				   false);
> +		if (pci_is_bridge(pdev)) {
> +			memcpy(rp[i].child_addr, rp[i].parent_addr,
> +			       sizeof(rp[i].child_addr));
> +		} else {
> +			/*
> +			 * For endpoint device, the lower 64-bits of child
> +			 * address is always zero.

For the non-OF folks (like me), can you say what the semantics of
parent_addr vs child_addr are?  I suppose maybe parent_addr is an
address on the primary side of a bridge and child_addr is the
corresponding address on the secondary side?

And PCI bridges don't perform address translation, so they are
identical?

> +			 */
> +			rp[i].child_addr[0] = j;
> +		}

> +int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
> +			  struct device_node *np)
> +{
> +	int ret = 0;
> +
> +	if (pci_is_bridge(pdev)) {
> +		ret |= of_changeset_add_prop_string(ocs, np, "device_type",
> +						    "pci");
> +	}
> +
> +	ret |= of_pci_prop_ranges(pdev, ocs, np);
> +	ret |= of_changeset_add_prop_u32(ocs, np, "#address-cells",
> +					 OF_PCI_ADDRESS_CELLS);
> +	ret |= of_changeset_add_prop_u32(ocs, np, "#size-cells",
> +					 OF_PCI_SIZE_CELLS);
> +	ret |= of_pci_prop_reg(pdev, ocs, np);
> +	ret |= of_pci_prop_compatible(pdev, ocs, np);
> +
> +	/*
> +	 * The added properties will be released when the
> +	 * changeset is destroyed.
> +	 */

I don't think it's meaningful to OR together the "negative error
values" returned by all these functions.  Presumably those are things
like -EINVAL, -ENOMEM, etc.  ORing them together is admittedly
non-zero, but yields nonsense.

> +	return ret;

> +static inline void
> +of_pci_make_dev_node(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void
> +of_pci_remove_node(struct pci_dev *pdev)
> +{
> +}

Pull these functions all onto one line, like other similar stubs in
this file.

> +#endif /* CONFIG_PCI_DYNAMIC_OF_NODES */

Unnecessary comment since this is all 10 lines.
