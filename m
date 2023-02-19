Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12D269BE83
	for <lists+linux-pci@lfdr.de>; Sun, 19 Feb 2023 06:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBSFHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Feb 2023 00:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSFHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Feb 2023 00:07:39 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C9F12F32
        for <linux-pci@vger.kernel.org>; Sat, 18 Feb 2023 21:07:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 63D8730003C71;
        Sun, 19 Feb 2023 06:07:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 50AA9E483; Sun, 19 Feb 2023 06:07:34 +0100 (CET)
Date:   Sun, 19 Feb 2023 06:07:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Yang Su <yang.su@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        shuo.tan@linux.alibaba.com
Subject: Re: [PATCH v2 1/3] PCI/PM: Observe reset delay irrespective of
 bridge_d3
Message-ID: <20230219050734.GA12326@wunner.de>
References: <cover.1673769517.git.lukas@wunner.de>
 <eb37fa345285ec8bacabbf06b020b803f77bdd3d.1673769517.git.lukas@wunner.de>
 <cc358ab3-0844-1341-7ae6-5af7110436f7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc358ab3-0844-1341-7ae6-5af7110436f7@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 18, 2023 at 09:22:37PM +0800, Yang Su wrote:
> I figue out the reason of pci_bridge_secondary_bus_reset() why not work
> for NVIDIA GPU T4 which bind vfio passthrough hypervisor. I used the
> original func pci_bridge_secondary_bus_reset() not your patch, your
> patch remove bridge_d3 flag, the real reason is bridge_d3 flag.
> 
> When I test the original func pci_bridge_secondary_bus_reset() in
> different machine node which all consist of the same type NVIDIA GPU T4,
> I found pci_bridge_wait_for_secondary_bus() bails out if the bridge_d3
> flag is not set, but I still confused why same gpu some machine node
> not set the bridge_d3 flag.
> 
> I find the linux kernel only two func will init bridge_d3 which is func
> pci_pm_init() and pci_bridge_d3_update().
> 
> If you know, please give me some hint.

It sounds like patch [1/3] in this series fixes the issue your seeing.
That's good to hear.

The bridge_d3 flag indicates whether a PCIe port is allowed to
runtime suspend to D3:

First of all, pci_bridge_d3_possible() decides whether the PCIe port
may runtime suspend at all.  E.g. hotplug ports are generally not
allowed to runtime suspend except in certain known-to-work situations,
such as Thunderbolt or when specific ACPI properties are present.

Second, a device below the PCIe port may block the port from runtime
suspending to D3.  That is decided in pci_dev_check_d3cold().  E.g. if
user space disallows D3 via the "d3cold_allowed" attribute in sysfs,
that will block D3 on PCIe ports in the ancestry.

If you're seeing different values for bridge_d3 on different machines,
even though the device below the PCIe port is always the same type of
GPU, then either pci_bridge_d3_possible() returns a different result
for the PCIe port in question (because it's a hotplug port or has
different ACPI properties etc), or one of its children blocks runtime
suspend to D3 (e.g. via sysfs).

Thanks,

Lukas
