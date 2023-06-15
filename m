Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDE73201C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFOSfz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFOSfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 14:35:54 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114FE4D;
        Thu, 15 Jun 2023 11:35:53 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id F2257100D5865;
        Thu, 15 Jun 2023 20:35:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CA5EAD4F48; Thu, 15 Jun 2023 20:35:50 +0200 (CEST)
Date:   Thu, 15 Jun 2023 20:35:50 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: pciehp: Make sure DPC trigger status is reset in
 PDC handler
Message-ID: <20230615183550.GA9773@wunner.de>
References: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 14, 2023 at 11:25:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> During the EDR-based DPC recovery process, for devices with persistent
> issues, the firmware may choose not to handle the DPC error and leave
> the port in DPC triggered state. In such scenarios, if the user
> replaces the faulty device with a new one, the OS is expected to clear
> the DPC trigger status in the hotplug error handler to enable the new
> device enumeration.

You're clearing the DPC trigger status upon a PDC event, yet are saying
here the purpose is to reset port state for a future hotplugged device.

A PDC event may be synthesized, e.g. to trigger slot bringup via
sysfs, so using a PDC event to clear DPC trigger status feels wrong.
pciehp_unconfigure_device() seems like a more appropriate place to me.


> More details about this issue can be found in PCIe
> firmware specification, r3.3, sec titled "DPC Event Handling"
> Implementation note.

That Implementation Note contains a lot of text and a fairly complex
flow chart. If you could point to specific paragraphs or numbers in
the Implementation Note that would make life easier for a reviewer
to make the connection between your code and the spec.


> Similar issue might also happen if the DPC or EDR recovery handler
> exits before clearing the trigger status. To fix this issue, clear the
> DPC trigger status in PDC interrupt handler.

I was about to ask why the code is added to dpc.c, not edr.c,
and why it's not constrained to CONFIG_PCIE_EDR, but I assume
that's the reason?  Because it "might" happen for OS-native DPC
as well?


> +/**
> + * pci_reset_trigger - Clear DPC trigger status
> + * @pdev: PCI device
> + *
> + * It is called from the PCIe hotplug driver to clean the DPC
> + * trigger status in the PDC interrupt handler.
> + */
> +void pci_dpc_reset_trigger(struct pci_dev *pdev)
> +{
> +	if (!pdev->dpc_cap)
> +		return;
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +}

This may run concurrently to dpc_reset_link(), so I'd expect that
you need some kind of serialization.  What happens if pciehp clears
trigger status behind the DPC driver's back while it is handling an
error?

Thanks,

Lukas
