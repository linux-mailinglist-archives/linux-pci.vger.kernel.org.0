Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B54496774
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiAUVlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 16:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAUVlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 16:41:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D53C06173B;
        Fri, 21 Jan 2022 13:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2593B82119;
        Fri, 21 Jan 2022 21:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45481C340E1;
        Fri, 21 Jan 2022 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642801279;
        bh=Ya9QmltnF011J5W22auNpqP93eEg1OWf3sm4BASbSCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JAXZLsyKUNsVg7Kb7i6o9uCQkM0HLgdRVy0VxsQVZsErPUHo3qtNKB6y0C9xcCajX
         HpHnwPm4M9hjclC7OeGxkaOh9x6/Hrqn8W135G+O3NJMp6yWaHALbQHhswRcW5axXM
         Elmug4+udT0KkYHO66eDiPnD1r+cl00X+XGC8ktgmyZx2EEKTbBqF+iJDzieaMD6I+
         ES2RBuUzgsITAYrg+NUBT81OHNRB6LuC9O9i9aEL/LzYB6PXU3MHSugrqULxCm0VsP
         F1asSAMNgS1rqDrquOwxDfvXGdDORcmSr2QHzwLm/Pye7NCvP/iQlYnClYCbhgtiwB
         sspFOonDeXF1Q==
Date:   Fri, 21 Jan 2022 15:41:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <20220121214117.GA1154852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120000409.2706549-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg, Jean-Philippe, Mika, Pavel, Oliver, Joerg since they
commented on previous "external-facing" discussion]

On Wed, Jan 19, 2022 at 04:04:09PM -0800, Rajat Jain wrote:
> Today the pci_dev->untrusted is set for any devices sitting downstream
> an external facing port (determined via "ExternalFacingPort" property).
> This however, disallows any internal devices to be marked as untrusted.

This isn't stated quite accurately.  "dev->untrusted" is currently set
only by set_pcie_untrusted(), when "dev" has an upstream bridge that
is either external-facing or untrusted.

But that doesn't disallow or prevent internal devices from being
marked as untrusted; it just doesn't implement that.

> There are use-cases though, where a platform would like to treat an
> internal device as untrusted (perhaps because it runs untrusted
> firmware, or offers an attack surface by handling untrusted network
> data etc).
> 
> This patch introduces a new "UntrustedDevice" property that can be used
> by the firmware to mark any device as untrusted.

I think I'm OK with this.  Write this last sentence in imperative
mood; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v5.16#n134
for examples.

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pci-acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..3d9e5fa49451 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  		dev->external_facing = 1;
>  }
>  
> +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +{
> +	u8 val;
> +
> +	if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
> +		return;
> +
> +	/* These PCI devices are not trustworthy */

Comment is probably superfluous since the code seems obvious without
it.

> +	if (val)
> +		dev->untrusted = 1;
> +}
> +
>  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
>  	pci_acpi_set_external_facing(pci_dev);
> +	pci_acpi_set_untrusted(pci_dev);
>  	pci_acpi_add_edr_notifier(pci_dev);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
> -- 
> 2.34.1.703.g22d0c6ccf7-goog
> 
