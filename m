Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021707B7226
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbjJCUAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJCUAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 16:00:39 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8577B0;
        Tue,  3 Oct 2023 13:00:35 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 67D95100D943C;
        Tue,  3 Oct 2023 22:00:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 366763244C; Tue,  3 Oct 2023 22:00:34 +0200 (CEST)
Date:   Tue, 3 Oct 2023 22:00:34 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Message-ID: <20231003200034.GB16417@wunner.de>
References: <20231002180906.82089-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002180906.82089-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
> suspend.  This occurs because on some AMD platforms, even though the Root
> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
> messages and generate wakeup interrupts from those states when amd-pmc has
> put the platform in a hardware sleep state.
> 
> Iain reported this on an AMD Rembrandt platform, but it also affects
> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
> generates the PME. To avoid this issue, disable D3 for the root port
> associated with USB4 controllers at suspend time.
[...]
> +static void quirk_disable_rp_d3cold_suspend(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp;
> +
> +	/*
> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
> +	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
> +	 *
> +	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
> +	 * sleep state, but we assume amd-pmc is always present.
> +	 */
> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
> +		return;
> +
> +	rp = pcie_find_root_port(dev);
> +	pci_d3cold_disable(rp);
> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
> +}

I think you mentioned in an earlier version of the patch that the
USB controller could in theory be built into a Thunderbolt-attached
device and that you wouldn't want to apply the quirk in that case.

Yet this patch doesn't seem to check for that possibility.

I guess in the affected systems, the USB controller is directly
below the Root Port.  The pcie_find_root_port() function you're
using here will walk up the hierarchy until it finds the Root Port,
i.e. it's specifically for the case where there are switches between
the USB controller and Root Port (which I think you want to exclude).
I would have expected that you just call pci_upstream_bridge(dev) once
and check whether the returned device is a PCI_EXP_TYPE_ROOT_PORT.

I'm also wondering why you're not invoking pci_d3cold_disable() with
the USB controller's device (instead of the Root Port).  Setting
no_d3cold on the USB controller should force all upstream bridges
into D0.

Perhaps the reason you're not doing this is because the xhci_hcd driver
might have called pci_d3cold_disable() as part of a quirk and the
unconditional pci_d3cold_enable() on resume might clobber that?

Thanks,

Lukas
