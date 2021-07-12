Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70A43C66C8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 01:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGLXMQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 19:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230522AbhGLXMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 19:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626131364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQP+qtN0tfA18/8MgoFuBtUXbYJF/jq+trCW5RaJtbg=;
        b=Kd/DaHhdi9wf75KpEeUYr9tVdWnZ6iC0H9SIlOmiQt9e1BTQQoKtw3U6FQRn6mImM+vr1c
        LP2HgVlmxj6Q/HaW84HkX3VhTS+xderHGW3MLGbZVoVSLktkhFJztdPLUIFaXWM4wgU+lh
        IkpyJlLjN5f9BX4vAowdSr9gV7EZdtY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-BjnP8AMsOFy79dbyxZvyVw-1; Mon, 12 Jul 2021 19:09:23 -0400
X-MC-Unique: BjnP8AMsOFy79dbyxZvyVw-1
Received: by mail-oi1-f198.google.com with SMTP id w2-20020aca62020000b029024073490067so14066795oib.21
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 16:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQP+qtN0tfA18/8MgoFuBtUXbYJF/jq+trCW5RaJtbg=;
        b=e/5StxdVC22/4bAbKPHZG58qDlNqinOWCWW0ozS8WTK5Tpa6uIEzEKqHngCKXUL4MN
         nNSKpvhVKus7GXKEnfOT6iAtFg12dA223wx+Qx94brY8rSGTSvfcKu3m4ui/BLexVqKb
         oWJwvFiHUMWf+0pOySKem9wuA56IpQf1firCJRqwj1UtUMAHquCjeDQobEe7zGaQmRLo
         rUMxc9mjoGjj2c77sDWpGpQKwfFNBTaa/JBQgnclYwa0eJM4YQAhi37Z2LT+kYtA1gmy
         8OR7XG6NbCz6ICmNpYROh63qDCN3abQuTqfVWzCq6J1gr+5ioWOIG0rS9Uf0kLED0Ygz
         V/pQ==
X-Gm-Message-State: AOAM530XvlaJbxLqFMRSdpjYAOii2CeZ5tlfbecXTPNRdnOaPzwt52mE
        nA3MKgm5JmEs3gAfHD2CM5xQ92is2JQUlbIJoqpRfaYHHIvKA9eFHlz56ociGGI6b6nn44187hn
        AQm/WeNJ+HHMnSB865vNb
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr1057054otr.339.1626131362476;
        Mon, 12 Jul 2021 16:09:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwhcTOde2jQsNFlY8x8e8K/8yPXg4c8JBdQ4xOIMyXytc1XHrpEbyrJWE+VOYiElovegOVvg==
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr1057038otr.339.1626131362199;
        Mon, 12 Jul 2021 16:09:22 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id g1sm3330802otk.21.2021.07.12.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:09:21 -0700 (PDT)
Date:   Mon, 12 Jul 2021 17:09:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 7/8] PCI: Add support for ACPI _RST reset method
Message-ID: <20210712170920.2a0868ac.alex.williamson@redhat.com>
In-Reply-To: <20210709123813.8700-8-ameynarkhede03@gmail.com>
References: <20210709123813.8700-1-ameynarkhede03@gmail.com>
        <20210709123813.8700-8-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  9 Jul 2021 18:08:12 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> From: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> The _RST is a standard method specified in the ACPI specification. It
> provides a function level reset when it is described in the acpi_device
> context associated with PCI-device. Implement a new reset function
> pci_dev_acpi_reset() for probing RST method and execute if it is defined
> in the firmware.
> 
> The default priority of the ACPI reset is set to below device-specific
> and above hardware resets.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
>  drivers/pci/pci.c      |  1 +
>  drivers/pci/pci.h      |  6 ++++++
>  include/linux/pci.h    |  2 +-
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index dae021322..b6de71d15 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -941,6 +941,29 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
>  				   acpi_pci_find_companion(&dev->dev));
>  }
>  
> +/**
> + * pci_dev_acpi_reset - do a function level reset using _RST method
> + * @dev: device to reset
> + * @probe: check if _RST method is included in the acpi_device context.
> + */
> +int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
> +{
> +	acpi_handle handle = ACPI_HANDLE(&dev->dev);
> +
> +	if (!handle || !acpi_has_method(handle, "_RST"))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> +		pci_warn(dev, "ACPI _RST failed\n");
> +		return -EINVAL;


Should we return -ENOTTY here instead to give a possible secondary
reset method a chance?  Thanks,

Alex


> +	}
> +
> +	return 0;
> +}
> +
>  static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  {
>  	const struct fwnode_handle *fwnode;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d5c16492c..1e64dbd3e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5115,6 +5115,7 @@ static void pci_dev_restore(struct pci_dev *dev)
>  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ },
>  	{ &pci_dev_specific_reset, .name = "device_specific" },
> +	{ &pci_dev_acpi_reset, .name = "acpi" },
>  	{ &pcie_reset_flr, .name = "flr" },
>  	{ &pci_af_flr, .name = "af_flr" },
>  	{ &pci_pm_reset, .name = "pm" },
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 990b73e90..2c12017ed 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -705,7 +705,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
>  int pci_acpi_program_hp_params(struct pci_dev *dev);
>  extern const struct attribute_group pci_dev_acpi_attr_group;
>  void pci_set_acpi_fwnode(struct pci_dev *dev);
> +int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
>  #else
> +static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
> +{
> +	return -ENOTTY;
> +}
> +
>  static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
>  static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f34563831..c3b0d771c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -50,7 +50,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 6
> +#define PCI_NUM_RESET_METHODS 7
>  
>  /*
>   * The PCI interface treats multi-function devices as independent

