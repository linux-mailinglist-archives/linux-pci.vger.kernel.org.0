Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C7731EBE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbjFORMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 13:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjFORMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 13:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3062710;
        Thu, 15 Jun 2023 10:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41856258F;
        Thu, 15 Jun 2023 17:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD5DC433C0;
        Thu, 15 Jun 2023 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686849151;
        bh=Yu7UFn8UHORJtbUOZaZaJhJoJKpKqCUxzownaFRaGWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mJLSuMyOMD6h3VD5kwr50W7vI/N8Lu5wfSO+xIG6HomBLTtrD7tVZKk5Rf6u6ujnd
         f3PgbZe70nppx3fUJAHICs246Y/dYL3Gw+Y7mNCaMxL123xu0JKR/zuOayDY9u02PP
         b3HQw1EBfF5FWh6M5AFekfDmu2dfw0w7MvPrddad5FzU8hbVhjFHOCfjwxidF5x89e
         sZ90wFzJunmYZky1Z2r8wvD8JR7WmnO2ZBNxDtQZdHrG0lfwP38ChsMVGo8BPWy6DM
         PkvwTYaCpFroW2alXBARthJdbGVEOCoTjmq0vAk+BE4fUPxX5pOi0PDsbVqLACH9Mt
         xV6UHb8q9ELOg==
Date:   Thu, 15 Jun 2023 12:12:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Message-ID: <20230615171229.GA1478685@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
> When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> enabled for that device. However, when the device is plugged preboot,
> ASPM is enabled by default.
> 
> The disparity happens because BIOS doesn't have the ability to program
> ASPM on hotplugged devices.
> 
> So enable ASPM by default for external connected PCIe devices so ASPM
> settings are consitent between preboot and hotplugged.
> 
> On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:07:04.0:    [ 7] BadDLLP
> 
> The root cause is still unclear, but quite likely because the I225 on
> the dock supports PTM, where ASPM timing is precalculated for the PTM.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..613b0754c9bb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
>  		/* Enable Everything */
>  		return ASPM_STATE_ALL;
>  	case POLICY_DEFAULT:
> -		return link->aspm_default;
> +		return dev_is_removable(&link->downstream->dev) ?
> +			link->aspm_capable :
> +			link->aspm_default;

I'm a little hesitant because dev_is_removable() is a convenient test
that covers the current issue, but it doesn't seem tightly connected
from a PCIe architecture perspective.

I think the current model of compile-time ASPM policy selection:

  CONFIG_PCIEASPM_DEFAULT          /* BIOS default setting */
  CONFIG_PCIEASPM_PERFORMANCE      /* disable L0s and L1 */
  CONFIG_PCIEASPM_POWERSAVE        /* enable L0s and L1 */
  CONFIG_PCIEASPM_POWER_SUPERSAVE  /* enable L1 substates */

is flawed.  As far as I know, there's no technical reason we have to
select this at kernel build-time.  I suspect the original reason was
risk avoidance, i.e., we were worried that we might expose hardware
defects if we enabled ASPM states that BIOS hadn't already enabled.

How do we get out of that model?  We do have sysfs knobs that should
cover all the functionality (set overall policy as above via
/sys/module/pcie_aspm/parameters/policy; set device-level exceptions
via /sys/bus/pci/devices/.../link/*_aspm).

In my opinion, the cleanest solution would be to enable all ASPM
functionality whenever possible and let users disable it if they need
to for performance.  If there are device defects when something is
enabled, deal with it via quirks, as we do for other PCI features.

That feels a little risky, but let's have a conversation about where
we want to go in the long term.  It's good to avoid risk, but too much
avoidance leads to its own complexity and an inability to change
things.

Bjorn
