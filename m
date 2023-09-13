Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4679DF24
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjIMEZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 00:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIMEZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 00:25:28 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7CEA0
        for <linux-pci@vger.kernel.org>; Tue, 12 Sep 2023 21:25:24 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7806A2800B489;
        Wed, 13 Sep 2023 06:25:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 562503FC2AD; Wed, 13 Sep 2023 06:25:22 +0200 (CEST)
Date:   Wed, 13 Sep 2023 06:25:22 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230913042522.GB1359@wunner.de>
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913040832.114610-3-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 12, 2023 at 11:08:32PM -0500, Mario Limonciello wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>  	if (target_state == PCI_POWER_ERROR)
>  		return -EIO;
>  
> +	/* quirk to avoid setting D3 */
> +	if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&
> +	   (target_state == PCI_D3hot || target_state == PCI_D3cold))
> +		target_state = PCI_D0;
> +
>  	pci_enable_wake(dev, target_state, wakeup);
>  
>  	error = pci_set_power_state(dev, target_state);

Would it be possible to just add the affected system to
bridge_d3_blacklist[]?

Or would that defeat power management of other (non-affected)
Root Ports in the same machine?

There's already PCI_DEV_FLAGS_NO_D3, would it be possible to just
reuse that instead of adding another codepath for D3 quirks?

Thanks,

Lukas
