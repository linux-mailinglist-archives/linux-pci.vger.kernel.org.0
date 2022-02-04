Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B504AA45F
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 00:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiBDXcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 18:32:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36458 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiBDXcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 18:32:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D2DB83972;
        Fri,  4 Feb 2022 23:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B27C340ED;
        Fri,  4 Feb 2022 23:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017542;
        bh=GR4dOo1Lfdor0ypIQE86E4qvS3wJM1AIXoiFnVPF5CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kd2LxVPMtefRU+J6mZuTfmxv1ztG9Zjqq3Jdt/WMKDQn1pyoksiDaauoevWiQ9oaY
         Z0kt3n+FQsWwURS6zDAhAl1HL2j7HfE5I1GRdmzjxW2VmfpRiojzRgc6xWEnxv9oj3
         +H0sBZRXIBN+S8csXLa4k7k5V7dzX2SzycdVL1IYJPzAVSk22ecB2D4OBkeXpyMQQV
         Yb1qHozcXAPysFIfA1JsVcgx5rTvvSkNQNBQWdNNqbnnPf5BWDCMotW5Mgj2Ktmd/J
         G6qzzYNFFVFkKyyQz8nNFHQs/BdwfnFPScTBCm/4GsvGb6HK+9KK7jGpDc3rxW2KjQ
         9zgM1bkfwn4kA==
Date:   Fri, 4 Feb 2022 17:32:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Message-ID: <20220204233219.GA228585@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124122107.12148-1-abhsahu@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, hoping for your review :)

Wonder if we should add something like this to MAINTAINERS so you get
cc'd on power-related things:

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..3d9a211cad5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15422,6 +15422,7 @@ F:	include/linux/pm.h
 F:	include/linux/pm_*
 F:	include/linux/powercap.h
 F:	kernel/configs/nopm.config
+K:	pci_[a-z_]*power[a-z_]*\(
 
 DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
 M:	Daniel Lezcano <daniel.lezcano@kernel.org>
]

On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
> Consider the following sequence during PCI device runtime
> suspend/resume:
> 
> 1. PCI device goes into runtime suspended state. The PCI state
>    will be changed to PCI_D0 and then pci_platform_power_transition()
>    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.
> 
> 2. Parent bridge goes into runtime suspended state. If parent
>    bridge supports D3cold, then it will change the power state of all its
>    children to D3cold state and the power will be removed.
> 
> 3. During wake-up time, the bridge will be runtime resumed first
>    and pci_power_up() will be called for the bridge. Now, the power
>    supply will be resumed.
> 
> 4. pci_resume_bus() will be called which will internally invoke
>    pci_restore_standard_config(). pci_update_current_state()
>    will read PCI_PM_CTRL register and the current_state will be
>    updated to D0.
> 
> In the above process, at step 4, the ACPI device state will still be
> ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
> invoked. We need call the pci_platform_power_transition() with state
> D0 to change the ACPI state to ACPI_STATE_D0.
> 
> This patch calls pci_power_up() if current power state is D0 inside
> pci_restore_standard_config(). This pci_power_up() will change the
> ACPI state to ACPI_STATE_D0.
> 
> Following are the steps to confirm:
> 
> Enable the debug prints in acpi_pci_set_power_state()
> 
> 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
> 
> Before:
> 
> 0000:01:00.0: power state changed by ACPI to D3hot
> 0000:00:01.0: power state changed by ACPI to D3cold
> 0000:00:01.0: power state changed by ACPI to D0
> 
> After:
> 
> 0000:01:00.0: power state changed by ACPI to D3hot
> 0000:00:01.0: power state changed by ACPI to D3cold
> 0000:00:01.0: power state changed by ACPI to D0
> 0000:01:00.0: power state changed by ACPI to D0
> 
> So with this patch, the PCI device ACPI state is also being
> changed to D0.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/pci/pci-driver.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 588588cfda48..64e0cca12f16 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
>   */
>  static int pci_restore_standard_config(struct pci_dev *pci_dev)
>  {
> +	int error = 0;
>  	pci_update_current_state(pci_dev, PCI_UNKNOWN);
>  
>  	if (pci_dev->current_state != PCI_D0) {
> -		int error = pci_set_power_state(pci_dev, PCI_D0);
> -		if (error)
> -			return error;
> +		error = pci_set_power_state(pci_dev, PCI_D0);
> +	} else {
> +		/*
> +		 * The platform power state can still be non-D0, so this is
> +		 * required to change the platform power state to D0.
> +		 */
> +		error = pci_power_up(pci_dev);
>  	}
>  
> +	if (error)
> +		return error;
> +
>  	pci_restore_state(pci_dev);
>  	pci_pme_restore(pci_dev);
>  	return 0;
> -- 
> 2.17.1
> 
