Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F354D5179
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiCJT2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiCJT2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:28:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E914F28A;
        Thu, 10 Mar 2022 11:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888ED60A0F;
        Thu, 10 Mar 2022 19:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1532C340E8;
        Thu, 10 Mar 2022 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646940426;
        bh=cq4m75PSl/PZoVhBD9Cn+gsQ1zqz5E2ip47wizl6wRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pFPQS8/vCCA3HW9ICoay5pubWy9elfiojpUvxzNbNGnsiuV6/XPsctQtHADD0HRQr
         hKx2Bq0XQWvkCl3u/v+HwWYSovPzktVSfuv37iw+CgIFeFyp6zD6cHVm4GAscLCex2
         Wc1ALmOBGu4ukTOeZ+RQz6IRmDLeAES7U7W9WjPdcQ06OsZcXPz5HZRnSV9h1eWS7B
         qidphy2Z6mtcu+Oq67tFeQCk4cK8tG7OG+w4NRiMmEVcAgeTY5r60sLAVxyd9gneR6
         ckVz0nx4JsafMYEzb1aiVg1GcK0ffNVNLHvLAkT86MlgrmguK15bHASXFEJMAZA8Na
         G8Jacj/v9ZKCA==
Date:   Thu, 10 Mar 2022 13:27:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 RESEND 0/4] Infrastructure to define apertures in a
 PCIe device with a flattened device tree
Message-ID: <20220310192704.GA168467@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305052304.726050-1-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 09:23:00PM -0800, Lizhi Hou wrote:
> Hello,

Why is this a resend?  I see
https://lore.kernel.org/r/20220305051105.725838-1-lizhi.hou@xilinx.com,
which looks like it was posted just a few minutes before this.  I
assume this "RESEND" is identical?

> This V1 of patch series is to provide the required pci OF interfaces for
> the PCIe device which uses flattened device tree to describe apertures in
> its PCIe BARs. e.g, Xilinx Alveo PCIe accelerator. This requires a base
> device tree which contains nodes for PCIe devices. A PCIe device driver
> can then overlay a flattened device tree on the PCIe device tree node.
> There are two separate parts for this to work. First, not all system has
> a base device tree created by default. Thus, a patch to create an empty
> device tree root node has been submitted.
>   https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
> Second, PCIe is self discoverable bus and there might not be a device tree
> node created for PCIe device. This patch provides a new interface to create
> a ‘pci-ep-bus’ node under the base device tree root node. PCIe device
> driver may call this interface in its probe routine to create device tree
> node, then overlays its device tree to the node.
> For the overlayed device tree nodes, each node presents a hardware aperture
> implemented in its PCIe BARs. The aperture register address consists of BAR
> index and offset. It uses the following encoding:
>   0xIooooooo 0xoooooooo
> Where:
>   I = BAR index
>   ooooooo oooooooo = BAR offset
> The ‘pci-ep-bus’ node been created is compatible with ‘simple-bus’ and
> contains ‘ranges’ property for translating aperture address to CPU address.
> The last patch enhances of_overlay_fdt_apply(). The ‘pci-ep-bus’ device
> node is created dynamically. The flattened device tree may not specify an
> fixed target overlay path in front. Instead, a relative path to the
> ‘pci-ep-bus’ node is specified in the flattened tree. Thus, a new
> parameter is added to point the target base node which is ‘pci-ep-bus’
> node in this case. Then the entire overlay target path is target base node
> path plus the relative path specified in the flattened device tree.

s/pci/PCI/ (capitalize acronyms above, also in other subjects, commit
logs, and code comments)

s/PCIe/PCI/ (in most cases, the above is not PCIe-specific)

Please add blank lines between paragraphs to make this easier to read.

The above tells *what* this series does, but not *why* we need it.

Apparently you want to describe PCI BARs in DT.  Normally the PCI core
discovers devices and BARs using the PCI enumeration process (read
config space looking for a Device ID, read standard BAR locations
(unimplemented BARs are hardwired to zero)).  Obviously you know all
of this.  What we need here (and in the commit log for the relevant
patch) is some explanation about why this standard process doesn't
work and you need to do something via DT.

I'm guessing this is for the case where Linux is running *on* the
endpoint, so instead of enumerating devices from the perspective of a
PCI host controller, it's on the "other" side of the device, e.g., as
described in Documentation/PCI/endpoint/pci-endpoint.rst

So the commit log should mention that and explain why we need this new
DT support.  The endpoint support has been around for a while, so this
should explain what's different about Xilinx Alveo and why it needs
this new stuff.

Bjorn
