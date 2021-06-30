Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C03B8814
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 19:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhF3R73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 13:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232409AbhF3R73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 13:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625075819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j17ZUUSZGulWGgyyHSuFgsNejV8FkteG4U/Pdv+OB54=;
        b=XoziuIEk8TkX7xNg1cLDde6YJAFelNpdjSsd7e12CtNZCuuzbZGNDMfp3J6kt1lgVzgl20
        SMF4egkkpGLkCsaeiGucqB9ECqkaEfpybZgBoUtmlRASbTZ4wD7OUn8dTeUrgDnmdPRPUz
        +Te5W/bNETksrenOZiI0O7HZorsSaSU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-tJ8gA5k7P6KlarORZIQZ6Q-1; Wed, 30 Jun 2021 13:56:58 -0400
X-MC-Unique: tJ8gA5k7P6KlarORZIQZ6Q-1
Received: by mail-oo1-f70.google.com with SMTP id x24-20020a4a9b980000b0290249d5c08dd6so1845773ooj.15
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 10:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j17ZUUSZGulWGgyyHSuFgsNejV8FkteG4U/Pdv+OB54=;
        b=eRfs1WKq3YgVlIXg4QKLaUWn9pJRpkuVMPgZaP+8HA0KcAHR7uQw0UgYkqwWJX8jLc
         pVLZaZBknEgUR/nhErXwgii3WMFyIHGRKboTf5j7EJp/bsRTmtBmwwlHrUNY2GUnrjqn
         AQ1bQpYqFPekSJ6WpnKWFLy6NB4xJjuovcmhGZnM9IXxYZ6bTtIUVbD6hFg5UO3efoAg
         8nn5T2Vs7q318L9Lj2M04hkH9B6TF9NuCi3IDcLKPUyCfxR6+l1h6ti8Q0/sWe17HhjC
         /kSRd9RRv9UthBtOMvXg6ewYsWimtzUTTKIMEbA2mAPuyAv+ia31t7SVSqLRtBUf/EDY
         xh9g==
X-Gm-Message-State: AOAM530ZLI0MDT7PizmKg227dK5vvA9wcuLHeL61L9i3arj7fUOPXkU+
        9dYxpNaZGbpDZUGGuHaIjN3pQCSB4Y5oiPknaCYuEZC80Nq2vyBHi7Odedh9nP81r/HNgyRWcvq
        nFOTBGrMO3DPpXuMJZKM4
X-Received: by 2002:a9d:518c:: with SMTP id y12mr10035283otg.186.1625075817298;
        Wed, 30 Jun 2021 10:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7XPsW3K6+aTVmcXybAeKhgh+Bp9+4iiKpLeT9su0tBtvVgAvewBQaz55o6BdWZb6UDyXgjg==
X-Received: by 2002:a9d:518c:: with SMTP id y12mr10035256otg.186.1625075816993;
        Wed, 30 Jun 2021 10:56:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o25sm4687865ood.20.2021.06.30.10.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:56:56 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:56:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210630115655.05958cfb.alex.williamson@redhat.com>
In-Reply-To: <20210629160104.2893-2-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
        <20210629160104.2893-2-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Jun 2021 21:30:57 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> Add has_flr bitfield in struct pci_dev to indicate support for pcie flr
> to avoid reading PCI_EXP_DEVCAP multiple times and get rid of
> PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr().
> 
> Currently there is separate function pcie_has_flr() to probe if pcie flr is
> supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not.  Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
> 
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

There are some non-trivial changes here vs previous, should probably
drop this.

> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>  drivers/pci/pci.c                          | 62 +++++++++++-----------
>  drivers/pci/pcie/aer.c                     | 12 ++---
>  drivers/pci/probe.c                        |  6 ++-
>  drivers/pci/quirks.c                       | 11 ++--
>  include/linux/pci.h                        |  7 ++-
>  6 files changed, 47 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> index facc8e6bc..15d6c8452 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	/* check flr support */
> -	if (pcie_has_flr(pdev))
> -		pcie_flr(pdev);
> +	pcie_reset_flr(pdev, 0);
>  
>  	pci_restore_state(pdev);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 452351025..28f099a4f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4611,32 +4611,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> -/**
> - * pcie_has_flr - check if a device supports function level resets
> - * @dev: device to check
> - *
> - * Returns true if the device advertises support for PCIe function level
> - * resets.
> - */
> -bool pcie_has_flr(struct pci_dev *dev)
> -{
> -	u32 cap;
> -
> -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> -		return false;
> -
> -	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> -	return cap & PCI_EXP_DEVCAP_FLR;
> -}
> -EXPORT_SYMBOL_GPL(pcie_has_flr);
> -
>  /**
>   * pcie_flr - initiate a PCIe function level reset
>   * @dev: device to reset
>   *
> - * Initiate a function level reset on @dev.  The caller should ensure the
> - * device supports FLR before calling this function, e.g. by using the
> - * pcie_has_flr() helper.
> + * Initiate a function level reset unconditionally on @dev without
> + * checking any flags and DEVCAP
>   */
>  int pcie_flr(struct pci_dev *dev)
>  {
> @@ -4659,16 +4639,35 @@ int pcie_flr(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
>  
> +/**
> + * pcie_reset_flr - initiate a PCIe function level reset
> + * @dev: device to reset
> + * @probe: If set, only check if the device can be reset this way.
> + *
> + * Initiate a function level reset on @dev.
> + */
> +int pcie_reset_flr(struct pci_dev *dev, int probe)
> +{
> +	if (!dev->has_flr)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pcie_flr(dev);
> +}
> +EXPORT_SYMBOL_GPL(pcie_reset_flr);
> +
>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  {
>  	int pos;
>  	u8 cap;
>  
> -	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> -	if (!pos)
> +	if (!dev->has_flr)
>  		return -ENOTTY;
>  
> -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> +	if (!pos)
>  		return -ENOTTY;
>  
>  	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);


How can has_flr encompass both methods of invoking FLR?  PCIe FLR is
not a prerequisite to AF FLR.


> @@ -5139,11 +5138,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	rc = pci_dev_specific_reset(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev)) {
> -		rc = pcie_flr(dev);
> -		if (rc != -ENOTTY)
> -			return rc;
> -	}
> +	rc = pcie_reset_flr(dev, 0);
> +	if (rc != -ENOTTY)
> +		return rc;
>  	rc = pci_af_flr(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
> @@ -5174,8 +5171,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	rc = pci_dev_specific_reset(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev))
> -		return 0;
> +	rc = pcie_reset_flr(dev, 1);
> +	if (rc != -ENOTTY)
> +		return rc;
>  	rc = pci_af_flr(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ec943cee5..98077595a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	}
>  
>  	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> -		if (pcie_has_flr(dev)) {
> -			rc = pcie_flr(dev);
> -			pci_info(dev, "has been reset (%d)\n", rc);
> -		} else {
> -			pci_info(dev, "not reset (no FLR support)\n");
> -			rc = -ENOTTY;
> -		}
> +		rc = pcie_reset_flr(dev, 0);
> +		if (!rc)
> +			pci_info(dev, "has been reset\n");
> +		else
> +			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
>  	} else {
>  		rc = pci_bus_error_reset(dev);
>  		pci_info(dev, "%s Port link has been reset (%d)\n",
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8..862d91615 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  {
>  	int pos;
>  	u16 reg16;
> +	u32 reg32;
>  	int type;
>  	struct pci_dev *parent;
>  
> @@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pdev->pcie_cap = pos;
>  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>  	pdev->pcie_flags_reg = reg16;
> -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> -	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
> +	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pdev->has_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;

We only set has_flr for PCIe FLR, so I think this effectively kills AF
FLR.  The ternary should be unnecessary here.

>  
>  	parent = pci_upstream_bridge(pdev);
>  	if (!parent)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d85914afe..1efdc4e5a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3819,7 +3819,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>  	u32 cfg;
>  
>  	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
> -	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> +	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
>  		return -ENOTTY;
>  
>  	if (probe)
> @@ -3888,13 +3888,10 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>   */
>  static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  {
> -	if (!pcie_has_flr(dev))
> -		return -ENOTTY;
> +	int ret = pcie_reset_flr(dev, probe);
>  
>  	if (probe)
> -		return 0;
> -
> -	pcie_flr(dev);
> +		return ret;
>  
>  	msleep(250);
>  
> @@ -5182,7 +5179,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {
> -	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
> +	dev->has_flr = 0;
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59..74f42a2cd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -223,10 +223,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
>  	/* A non-root bridge where translation occurs, stop alias search here */
>  	PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT = (__force pci_dev_flags_t) (1 << 9),
> -	/* Do not use FLR even if device advertises PCI_AF_CAP */
> -	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>  	/* Don't use Relaxed Ordering for TLPs directed at this device */
> -	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 10),
>  };
>  
>  enum pci_irq_reroute_variant {
> @@ -381,6 +379,7 @@ struct pci_dev {
>  						   bit manually */
>  	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
> +	unsigned int	has_flr:1;

There are more space efficient places to define this.  Thanks,

Alex

>  
>  #ifdef CONFIG_PCIEASPM
>  	struct pcie_link_state	*link_state;	/* ASPM link state */
> @@ -1225,7 +1224,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
>  void pcie_print_link_status(struct pci_dev *dev);
> -bool pcie_has_flr(struct pci_dev *dev);
> +int pcie_reset_flr(struct pci_dev *dev, int probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);

