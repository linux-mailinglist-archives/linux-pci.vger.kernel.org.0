Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530D79B38B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbjIKVkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbjIKPgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 11:36:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B49E9;
        Mon, 11 Sep 2023 08:36:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAB6C40004;
        Mon, 11 Sep 2023 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694446577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ANDeLZjV5lzAaJjoCPyh76BQ46mQC+o7bmbGehRwMY=;
        b=X//OkO1AojU8koknd9JyYVKBEmbSLqFNl9OMqJS8PHtuhmXasUTxRa8dd4d432BoBRTAa3
        liY5GQszHTiWjz1YCdXghxRFaeAXGSeCDkfyR6aQYey1c/yvEWPjm+16dK+eDv89BWP7tL
        thlyLBEhWXqlsMO0EZQUsbi5wJLMnJ0W3TB73HdjYnmPjLPkxZdPbZznbdcu42ZCPSzyGO
        TwqcJkY0YxKFXCdci0kpINnBoVJxuqyPmXj11A4/Y2Y9JnUA1OCp4gjAzmObtaLwXOQmfr
        /L2yxRRMzThTPfumWfup1XLJeNwYthK0yvuv0qxs3uI/fJGeiuv7Z0oXwQmpLQ==
Date:   Mon, 11 Sep 2023 17:35:03 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
        <stefano.stabellini@xilinx.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <20230911173503.0db85e4b@bootlin.com>
In-Reply-To: <20230911154856.000076c3@Huawei.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
        <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
        <20230911154856.000076c3@Huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jonathan,

On Mon, 11 Sep 2023 15:48:56 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 15 Aug 2023 10:19:57 -0700
> Lizhi Hou <lizhi.hou@amd.com> wrote:
> 
> > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > the PCI core discovers devices and BARs using the PCI enumeration process.
> > There is no infrastructure to discover the hardware peripherals that are
> > present in a PCI device, and which can be accessed through the PCI BARs.
> > 
> > Apparently, the device tree framework requires a device tree node for the
> > PCI device. Thus, it can generate the device tree nodes for hardware
> > peripherals underneath. Because PCI is self discoverable bus, there might
> > not be a device tree node created for PCI devices. Furthermore, if the PCI
> > device is hot pluggable, when it is plugged in, the device tree nodes for
> > its parent bridges are required. Add support to generate device tree node
> > for PCI bridges.
> > 
> > Add an of_pci_make_dev_node() interface that can be used to create device
> > tree node for PCI devices.
> > 
> > Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> > the kernel will generate device tree nodes for PCI bridges unconditionally.
> > 
> > Initially, add the basic properties for the dynamically generated device
> > tree nodes which include #address-cells, #size-cells, device_type,
> > compatible, ranges, reg.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>  
> 
> I tried to bring this up for a custom PCIe card emulated in QEMU on an ARM ACPI
> machine.
> 
> There are some missing parts that were present in Clements series, but not this
> one, particularly creation of the root pci object.
> 
> Anyhow, hit an intermittent crash...

I am facing the same issues.

I use a custom PCIe board too but on x86 ACPI machine.

In order to have a working system, I need also to build a DT node for the PCI
Host bridge (previously done by Clement's patch) and I am a bit stuck with
interrupts.

On your side (ACPI machine) how do you handle this ?
I mean is your PCI host bridge provided by ACPI ? And if so, you probably need
to build a DT node for this PCI host bridge and add some interrupt-map,
interrupt-map-mask properties in the DT node.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
