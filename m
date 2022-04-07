Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340424F83C1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiDGPpF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 11:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiDGPpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 11:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69627939BF;
        Thu,  7 Apr 2022 08:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F32E461D47;
        Thu,  7 Apr 2022 15:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E46C385AA;
        Thu,  7 Apr 2022 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346179;
        bh=gB6qi54d2h5pYe5VdRbfcHtzEy9P9t7ZoE/wMPpDl2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=etCiQjRp5QAY7KYYzDp64vznmp799wma5cIcAVeOXg8cJLNIpXU/fZuRwxtBwpAq1
         nw/GgudlPiHkWnYEB5Xt7dsC/+sgYBeA2zW/sSgYtEbkJg2Lgoa0qgLOwnH07WssoX
         wSYsVG4zaqb9J3EV64p1yGTJGMynE81igFF/K/r8FIhlYbg54ii3zknJBTXeXkZVyg
         p0hKWuDAV83RwJ9CHPrCzMJJttjzwDeKb5ydwVCq+rdvGt/m/D+AsRFVFmPUwTz7ao
         e0Q6v6R4yqqn9+DuchK/BXLyfuKiVEHWpdEKrnou6cBd/E69gAV3UJqJseYUnZLbDA
         ipVRNk5AeB0oA==
Date:   Thu, 7 Apr 2022 10:42:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/ACPI: Decouple the negotiation of ASPM and other
 PCIe services
Message-ID: <20220407154257.GA235990@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407131602.14727-1-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael]

On Thu, Apr 07, 2022 at 09:16:02PM +0800, Yicong Yang wrote:
> Currently we regard ASPM as a necessary PCIe service and if it's disabled
> by pcie_aspm=off we cannot enable other services like AER and hotplug.
> However the ASPM is just one of the PCIe services and other services
> mentioned no dependency on this. So this patch decouples the negotiation
> of ASPM and other PCIe services, then we can make use of other services
> in the absence of ASPM.

Why do you want to boot with "pcie_aspm=off"?  If we have to use a
PCI-related parameter to boot, something is already wrong, so if
there's a problem that requires ASPM to be disabled, we should fix
that first.

If there's a known hardware or firmware issue with ASPM, we should
quirk it so users don't have to discover this parameter.

> Aaron Sierra tried to fix this originally:
> https://lore.kernel.org/linux-pci/20190702201318.GC128603@google.com/

Yes.  My question from that review is still open:

  But Rafael added ACPI_PCIE_REQ_SUPPORT with 415e12b23792 ("PCI/ACPI:
  Request _OSC control once for each root bridge (v3)") [1], apparently
  related to a bug [2].  I assume there was some reason for requiring
  all those things together, so I'd really like his comments.

  [1] https://git.kernel.org/linus/415e12b23792
  [2] https://bugzilla.kernel.org/show_bug.cgi?id=20232

Rafael clearly said in [1] that we need to:

  ... check if all of the requisite _OSC support bits are set before
  calling acpi_pci_osc_control_set() for a given root complex.

We would still need to explain why Rafael thought all these _OSC
support bits were required, but now they're not.

_OSC does not negotiate directly for control of ASPM (though of course
it *does* negotiate for control of the PCIe Capability, which contains
the ASPM control bits), but the PCI Firmware spec, r3.3, sec 4.5.3, has
this comment in a sample _OSC implementation:

  // Only allow native hot plug control if the OS supports:
  // * ASPM
  // * Clock PM
  // * MSI/MSI-X

which matches the current ACPI_PCIE_REQ_SUPPORT.

So I think I would approach this by reworking the _OSC negotiation so
we always advertise "OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT"
if CONFIG_PCIEASPM=y.

Advertising support for ASPM doesn't mean Linux has to actually
*enable* it, so we could make a different mechanism to prevent use of
ASPM if we have a device or platform quirk or we're booting with
"pcie_aspm=off".

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/acpi/pci_root.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6f9e75d14808..16fa7c5a11ad 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -37,8 +37,6 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  }
>  
>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> -				| OSC_PCI_ASPM_SUPPORT \
> -				| OSC_PCI_CLOCK_PM_SUPPORT \
>  				| OSC_PCI_MSI_SUPPORT)
>  
>  static const struct acpi_device_id root_device_ids[] = {
> -- 
> 2.24.0
> 
