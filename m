Return-Path: <linux-pci+bounces-1499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3E981F8D1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC3B23821
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96079F4;
	Thu, 28 Dec 2023 13:25:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDA8465;
	Thu, 28 Dec 2023 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6D4BB2800B4BE;
	Thu, 28 Dec 2023 14:25:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5E0F428F35D; Thu, 28 Dec 2023 14:25:17 +0100 (CET)
Date: Thu, 28 Dec 2023 14:25:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Esther Shimanovich <eshimanovich@chromium.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20231228132517.GA12586@wunner.de>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

[adding Mika and Mario to the list of recipients, original patch is here:
https://lore.kernel.org/all/20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org/
a lot of folks are on vacation, replies might not be sent before Jan 8;
full quote without further comments below]

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
> 
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

