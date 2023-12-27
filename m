Return-Path: <linux-pci+bounces-1396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7703681EAE5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 01:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941E11C21510
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21CB373;
	Wed, 27 Dec 2023 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luAKczoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F723A6;
	Wed, 27 Dec 2023 00:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00909C433C8;
	Wed, 27 Dec 2023 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703636150;
	bh=GElhOP5S6nKROUOHTf3ELUO3ZW6l0S/29OFPIsyN3S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=luAKczoWx4T4Qys+2Oc2xRfIhVlHqLwsNuyw+WW9VVyCwtjleZT3vM/XNIh65LKa1
	 JhyB1JToiH3NKgubccu8wVw90crrIf2X7t0TVFo1Ae5jHxSXfsd9RJrnOwDyobPgkF
	 Lku4Y4UFW4NuJKwH8yPKqf09TvWTkKvrlNBB6fbzZ7aevagqoHLUF+e9jJuEPuLiB0
	 Gjr40AEUxo+bA6qOQUIlfY/J8Bz85othgDabe6+NliiQkKVq/lk+ELX9nuuhzDi7UI
	 Np4V/5rslt7WuVTBPD2EfcT/RqcBfe+zZ4gSd82DoDNUqHjarQASwwHxXcluhY70sd
	 bJE8MesiYAGpQ==
Date: Tue, 26 Dec 2023 18:15:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20231227001548.GA1484371@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>

On Thu, Dec 21, 2023 at 03:53:42PM -0500, Esther Shimanovich wrote:
> On Lenovo X1 Carbon Gen 7/8 devices, when a platform enables a policy to
> distrust removable PCI devices, the build-in USB-C ports stop working at
> all.
> This happens because these X1 Carbon models have a unique feature; a
> Thunderbolt controller that is discrete from the SoC. The software sees
> this controller, and incorrectly assumes it is a removable PCI device,
> even though it is fixed to the computer and is wired to the computer's
> own USB-C ports.
> 
> Relabel all the components of the JHL6540 controller as DEVICE_FIXED,
> and where applicable, external_facing.
> 
> Ensure that the security policy to distrust external PCI devices works
> as intended, and that the device's USB-C ports are able to enumerate
> even when the policy is enabled.

Thanks for all your work here.

This is going to be a maintenance problem.  We typically use quirks to
work around hardware defects, e.g., a device that advertises a feature
that doesn't work per spec.

But I don't see where the defect is here.  And I doubt that this is
really a unique situation.  So it's likely that this will happen on
other systems, and we don't want to have to add quirks every time
another one shows up.

If this is a firmware defect, e.g., if this platform is using
"ExternalFacingPort" incorrectly, we can add a quirk to work around
that, too.  But I'm not sure that's the case.

> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> ---
> Changes in v4:
> - replaced a dmi check in the rootport quirk with a subsystem vendor and
>   device check.
> - Link to v3: https://lore.kernel.org/r/20231220-thunderbolt-pci-patch-4-v3-1-056fd1717d06@chromium.org
> 
> Changes in v3:
> - removed redundant dmi check, as the subsystem vendor check is
>   sufficient
> - switched to PCI_VENDOR_ID_LENOVO instead of hex code
> - Link to v2: https://lore.kernel.org/r/20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org
> 
> Changes in v2:
> - nothing new, v1 was just a test run to see if the ASCII diagram would
>   be rendered properly in mutt and k-9
> - for folks using gmail, make sure to select "show original" on the top
>   right, as otherwise the diagram will be garbled by the standard
>   non-monospace font
> - Link to v1: https://lore.kernel.org/r/20231219-thunderbolt-pci-patch-4-v1-1-4e8e3773f0a9@chromium.org
> ---
>  drivers/pci/quirks.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..34e43323ff14 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3873,6 +3873,118 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>  			       quirk_apple_poweroff_thunderbolt);
>  #endif
>  
> +/*
> + * On most ThinkPad Carbon 7/8s, JHL6540 Thunderbolt 3 bridges are set
> + * incorrectly as DEVICE_REMOVABLE despite being built into the device.
> + * This is the side effect of a unique hardware configuration.
> + *
> + * Normally, Thunderbolt functionality is integrated to the SoC and
> + * its root ports.
> + *
> + *                          Most devices:
> + *                    root port --> USB-C port
> + *
> + * But X1 Carbon Gen 7/8 uses Whiskey Lake and Comet Lake SoC, which
> + * don't come with Thunderbolt functionality. Therefore, a discrete
> + * Thunderbolt Host PCI controller was added between the root port and
> + * the USB-C port.
> + *
> + *                        Thinkpad Carbon 7/8s
> + *                 (w/ Whiskey Lake and Comet Lake SoC):
> + *                root port -->  JHL6540   --> USB-C port
> + *
> + * Because the root port is labeled by FW as "ExternalFacingPort", as
> + * required by the DMAR ACPI spec, the JHL6540 chip is inaccurately

Can you include a citation (spec name, revision, section) for this
DMAR requirement?

> + * labeled as DEVICE_REMOVABLE by the kernel pci driver.
> + * Therefore, the built-in USB-C ports do not enumerate when policies
> + * forbidding external pci devices are enforced.
> + *
> + * This fix relabels the pci components in the built-in JHL6540 chip as
> + * DEVICE_FIXED, ensuring that the built-in USB-C ports always enumerate
> + * properly as intended.
> + *
> + * This fix also labels the external facing components of the JHL6540 as
> + * external_facing, so that the pci attach policy works as intended.
> + *
> + * The ASCII diagram below describes the pci layout of the JHL6540 chip.
> + *
> + *                         Root Port
> + *                 [8086:02b4] or [8086:9db4]
> + *                             |
> + *                        JHL6540 Chip
> + *     __________________________________________________
> + *    |                      Bridge                      |
> + *    |        PCI ID ->  [8086:15d3]                    |
> + *    |         DEVFN ->      (00)                       |
> + *    |       _________________|__________________       |
> + *    |      |           |            |           |      |
> + *    |    Bridge     Bridge        Bridge      Bridge   |
> + *    | [8086:15d3] [8086:15d3]  [8086:15d3] [8086:15d3] |
> + *    |    (00)        (08)         (10)        (20)     |
> + *    |      |           |            |           |      |
> + *    |     NHI          |     USB Controller     |      |
> + *    | [8086:15d2]      |       [8086:15d4]      |      |
> + *    |    (00)          |          (00)          |      |
> + *    |      |___________|            |___________|      |
> + *    |____________|________________________|____________|
> + *                 |                        |
> + *             USB-C Port               USB-C Port
> + *
> + *
> + * Based on what a JHL6549 pci component's pci id, subsystem device id
> + * and devfn are, we can infer if it is fixed and if it faces a usb port;
> + * which would mean it is external facing.
> + * This quirk uses these values to identify the pci components and set the
> + * properties accordingly.

Random nits: Capitalize spec terms like "PCI", "USB", "Root Port",
etc., consistently in English text.  Rewrap to fill 78 columns or so.
Add blank lines between paragraphs.  This applies to the commit log
(which should be wrapped to 75 to allow for "git log" indent) as well
as comments.

But honestly, I hope we can figure out a solution that doesn't require
a big comment like this.  Checking for random device IDs to deduce the
topology is not the way PCI is supposed to work.  PCI is designed to
be enumerable, so software can learn what it needs to know by
interrogating the hardware directly.

For cases where that's impossible, ACPI is supposed to fill the gaps,
e.g., with "ExternalFacingPort".  If this patch covers over a gap that
firmware doesn't handle yet, maybe we need to add some new firmware
interface.  If that's the case, we can add quirks for platforms that
don't have the new interface.  But we at least need a plan that
doesn't require quirks indefinitely.

> + */
> +static void carbon_X1_fixup_relabel_alpine_ridge(struct pci_dev *dev)
> +{
> +	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
> +	if (dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO)
> +		return;
> +
> +	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
> +	if (dev->subsystem_device != 0x22be && // Gen 8
> +	    dev->subsystem_device != 0x2292) { // Gen 7
> +		return;
> +	}
> +
> +	dev_set_removable(&dev->dev, DEVICE_FIXED);
> +
> +	/* Not all 0x15d3 components are external facing */
> +	if (dev->device == 0x15d3 &&
> +	    dev->devfn != 0x08 &&
> +	    dev->devfn != 0x20) {
> +		return;
> +	}
> +
> +	dev->external_facing = true;
> +}
> +
> +/*
> + * We also need to relabel the root port as a consequence of changing
> + * the JHL6540's PCIE hierarchy.
> + */
> +static void carbon_X1_fixup_rootport_not_removable(struct pci_dev *dev)
> +{
> +	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
> +	if (dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO)
> +		return;
> +
> +	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
> +	if (dev->subsystem_device != 0x22be && // Gen 8
> +	    dev->subsystem_device != 0x2292) { // Gen 7
> +		return;
> +	}
> +
> +	dev->external_facing = false;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d3, carbon_X1_fixup_relabel_alpine_ridge);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d2, carbon_X1_fixup_relabel_alpine_ridge);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15d4, carbon_X1_fixup_relabel_alpine_ridge);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x02b4, carbon_X1_fixup_rootport_not_removable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9db4, carbon_X1_fixup_rootport_not_removable);
> +
>  /*
>   * Following are device-specific reset methods which can be used to
>   * reset a single function if other methods (e.g. FLR, PM D0->D3) are
> 
> ---
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> change-id: 20231219-thunderbolt-pci-patch-4-ede71cb833c4
> 
> Best regards,
> -- 
> Esther Shimanovich <eshimanovich@chromium.org>
> 

