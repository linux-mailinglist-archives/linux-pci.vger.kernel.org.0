Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F01491263
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbiAQXfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 18:35:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55558 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiAQXfY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 18:35:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6137361161;
        Mon, 17 Jan 2022 23:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87EC36AEC;
        Mon, 17 Jan 2022 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642462523;
        bh=CG+ko5k4iKpnY2/XJKntUVk4Bn9sNOrY8wvLENM2z6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hqxRKUBZPezjTfKyzhW2wlyfaju0sSB0B26HK1Y4VXiiupvkGa9OpUSlaBy57EcY8
         Tk5fNzPaeKwlrI1eL0x2uisjINtDgFSKeGTjXQssjLbXd2Q48+tiTW00CPPCZW9PWy
         l9TRD2sfp0mZ7BXZbNwb9l3CAyoJNShOoJvU5RLz91yj7L4gaJlGPT+YaWsRBvuEmb
         pPompIqvblYsZgH97BlXvJQQrB8NicJ4KyzVNkgZWIV+vd4xO28o0Ij6BrMHhK7qWw
         HfzL9M+WPwOZSqbjyTUo7iK8c3B4+iJCSv0Y+a+W1GGgEQkDj4uzTklMWAX1DwjyaL
         XRYzfRZF7fmQw==
Date:   Mon, 17 Jan 2022 17:35:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
Message-ID: <20220117233522.GA815664@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kai-Heng, Lukas, Mika, since they were cc'd or commented on [0] below]

On Mon, Jan 17, 2022 at 11:51:54AM +0100, Heiner Kallweit wrote:
> Currently PCI core forbids RPM and requires opt-in from userspace,
> apart from few drivers calling pm_runtime_allow(). Reason is that some
> early ACPI PM implementations conflict with RPM, see [0].
> Note that as of today pm_runtime_forbid() is also called for non-ACPI
> systems. Maybe it's time to allow RPM per default for non-ACPI systems
> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
> was published in 2011.

Let's reword this to use the positive sense, e.g., something like
"enable runtime power management for non-ACPI and ACPI 5.0 and newer."

This feels like a potentially significant change that could cause
breakage.  

  - How would a user recognize that we're doing something different?
    Maybe we need a note in dmesg?

  - If a system broke because of this, what would it look like?  How
    would a user notice a problem, and how would he or she connect the
    problem to this change?

  - Is there a kernel parameter that will get the previous behavior of
    disabling runtime PM as a workaround until a quirk can be added?
    If so, we should probably mention it here.  If not, should there
    be?

> [0] https://lkml.org/lkml/2020/11/17/1548

Please use an https://lore.kernel.org/r/... link instead.

Let's mention bb910a7040e9 ("PCI/PM Runtime: Make runtime PM of PCI
devices inactive by default") as well to help connect the dots here.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 428afd459..26e3a500c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
>  	u16 status;
>  	u16 pmc;
>  
> -	pm_runtime_forbid(&dev->dev);
> +#ifdef CONFIG_ACPI
> +	/* Some early ACPI PM implementations conflict with RPM. */
> +	if (acpi_gbl_FADT.header.revision > 0 &&
> +	    acpi_gbl_FADT.header.revision < 5)
> +		pm_runtime_forbid(&dev->dev);
> +#endif
>  	pm_runtime_set_active(&dev->dev);
>  	pm_runtime_enable(&dev->dev);
>  	device_enable_async_suspend(&dev->dev);
> -- 
> 2.34.1
> 
