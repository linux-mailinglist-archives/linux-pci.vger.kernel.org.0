Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04F178D79
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 10:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgCDJd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 04:33:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:14299 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgCDJd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 04:33:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="352054757"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Mar 2020 01:33:24 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 04 Mar 2020 11:33:24 +0200
Date:   Wed, 4 Mar 2020 11:33:24 +0200
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v6] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20200304093324.GI2540@lahna.fi.intel.com>
References: <20200303101052.133631-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303101052.133631-1-kherbst@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Mar 03, 2020 at 11:10:52AM +0100, Karol Herbst wrote:
> Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> states.

I think it is good to explain bit more here why this fix is needed.

> v2: convert to pci_dev quirk
>     put a proper technical explanation of the issue as a in-code comment
> v3: disable it only for certain combinations of intel and nvidia hardware
> v4: simplify quirk by setting flag on the GPU itself
> v5: restructure quirk to make it easier to add new IDs
>     fix whitespace issues
>     fix potential NULL pointer access
>     update the quirk documentation
> v6: move quirk into nouveau

This information typically goes under the '---' line.

> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@intel.com>

I have few minor comments but regardless,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205623
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 56 +++++++++++++++++++++++++++
>  drivers/pci/pci.c                     |  8 ++++
>  include/linux/pci.h                   |  1 +
>  3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 2cd83849600f..51d3a7ba7731 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -618,6 +618,59 @@ nouveau_drm_device_fini(struct drm_device *dev)
>  	kfree(drm);
>  }
>  
> +/*
> + * On some Intel PCIe bridge controllers doing a
> + * D0 -> D3hot -> D3cold -> D0 sequence causes Nvidia GPUs to not reappear.
> + * Skipping the intermediate D3hot step seems to make it work again. Thise is
                                                                        ^^^^^
Thise -> This

> + * probably caused by not meeting the expectation the involved AML code has
> + * when the GPU is put into D3hot state before invoking it.
> + *
> + * This leads to various manifestations of this issue:
> + *  - AML code execution to power on the GPU hits an infinite loop (as the
> + *    code waits on device memory to change).
> + *  - kernel crashes, as all PCI reads return -1, which most code isn't able
> + *    to handle well enough.
> + *
> + * In all cases dmesg will contain at least one line like this:
> + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> + * followed by a lot of nouveau timeouts.
> + *
> + * In the \_SB.PCI0.PEG0.PG00._OFF code deeper down writes bit 0x80 to the not
> + * documented PCI config space register 0x248 of the Intel PCIe bridge
> + * controller (0x1901) in order to change the state of the PCIe link between
> + * the PCIe port and the GPU. There are alternative code paths using other
> + * registers, which seem to work fine (executed pre Windows 8):
> + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> + *  - 0xb0 bit 0x10 (link disable)
> + * Changing the conditions inside the firmware by poking into the relevant
> + * addresses does resolve the issue, but it seemed to be ACPI private memory
> + * and not any device accessible memory at all, so there is no portable way of
> + * changing the conditions.
> + * On a XPS 9560 that means bits [0,3] on \CPEX need to be cleared.
> + *
> + * The only systems where this behavior can be seen are hybrid graphics laptops
> + * with a secondary Nvidia Maxwell, Pascal or Turing GPU. Its unclear wheather
                                                             ^^^         ^^^^^^^^
Its -> It's
wheather -> whether

> + * this issue only occurs in combination with listed Intel PCIe bridge
> + * controllers and the mentioned GPUs or other devices as well.
> + *
> + * documentation on the PCIe bridge controller can be found in the
> + * "7th Generation Intel® Processor Families for H Platforms Datasheet Volume 2"
> + * Section "12 PCI Express* Controller (x16) Registers"
> + */
> +
> +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
> +
> +	if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
> +		return;
> +
> +	switch (bridge->device) {
> +	case 0x1901:
> +		dev->parent_d3cold = 1;

I think it is better to add

		break;

here.

> +	}
> +}
> +
>  static int nouveau_drm_probe(struct pci_dev *pdev,
>  			     const struct pci_device_id *pent)
>  {
> @@ -699,6 +752,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto fail_drm_dev_init;
>  
> +	quirk_broken_nv_runpm(pdev);
>  	return 0;
>  
>  fail_drm_dev_init:
> @@ -737,6 +791,8 @@ nouveau_drm_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
> +	/* revert our workaround */
> +	pdev->parent_d3cold = false;
>  	nouveau_drm_device_remove(dev);
>  }
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 951099279192..6ece05723fa2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -860,6 +860,14 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	   || (state == PCI_D2 && !dev->d2_support))
>  		return -EIO;
>  
> +	/*
> +	 * Power management can be disabled for certain devices as they don't
> +	 * come back up later on runtime_resume. We rely on platform means to
> +	 * cut power consumption instead (e.g. ACPI).
> +	 */
> +	if (state != PCI_D0 && dev->parent_d3cold)
> +		return 0;
> +
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (pmcsr == (u16) ~0) {
>  		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 930fab293073..3e5938b91966 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -340,6 +340,7 @@ struct pci_dev {
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>  	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
>  	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
> +	unsigned int	parent_d3cold:1;	/* power manage the parent instead */

Just to be consistent with the other comments, start with a capital
letter:

	unsigned int	parent_d3cold:1;	/* Power manage the parent instead */
