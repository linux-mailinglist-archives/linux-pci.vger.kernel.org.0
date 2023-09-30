Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30C7B3FAC
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjI3JY3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Sep 2023 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjI3JY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2023 05:24:29 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E9DD
        for <linux-pci@vger.kernel.org>; Sat, 30 Sep 2023 02:24:25 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C945E30026C42;
        Sat, 30 Sep 2023 11:24:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BCD0D4102E; Sat, 30 Sep 2023 11:24:23 +0200 (CEST)
Date:   Sat, 30 Sep 2023 11:24:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v20 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230930092423.GA6605@wunner.de>
References: <20230920032724.71083-1-mario.limonciello@amd.com>
 <20230920032724.71083-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920032724.71083-3-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 10:27:24PM -0500, Mario Limonciello wrote:
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[...]
> + * When AMD PCIe root ports with AMD USB4 controllers attached to them are put
> + * into D3hot or D3cold downstream USB devices may fail to wakeup the system
> + * from suspend to idle.  This manifests as a missing wakeup interrupt.
> + *
> + * Prevent the associated root port from using PME to wake from D3hot or
> + * D3cold power states during suspend.
> + * This will effectively put the root port into D0 power state over suspend.

IIUC, the quirk matches for a Root Port, then searches for a
USB controller below the Root Port, and if found, searches for the
Root Port above again to clear or reinstate the PME bits.

That seems like a roundabout way of doing things.  Have you
considered matching for the USB controller's Device ID in the quirk,
then checking whether the Root Port above has the Device ID which
is known to be broken?

Also, since pci_d3cold_enable() / pci_d3cold_disable() are now fixed
(can no longer be interfered with from user space), you might want to
consider using them alternatively to clearing PME bits.  They don't
require access to config space.

Thanks,

Lukas
