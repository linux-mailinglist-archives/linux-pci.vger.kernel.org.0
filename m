Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E823A313302
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 14:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBHNL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 08:11:59 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:38265 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhBHNLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 08:11:51 -0500
Received: by mail-lf1-f52.google.com with SMTP id m22so22121545lfg.5
        for <linux-pci@vger.kernel.org>; Mon, 08 Feb 2021 05:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0+b5gxqNPJNWrAnejzYehpggD7XHAx7oZRdyZlNEzTo=;
        b=iofooGhXCj2C4W0GauEWahm/mCqj+H2tYuFXcn2qzj7Ppv+jX9NQ1iwyIzrtfPQR9E
         nDUaLRguzPx5qfMZMZPmhXQ1czgTXqZpLkCezlexxeDOmbu4MCshrNQhY53FkueeoNwA
         ayfiMFxNr/KmcaJGYK8MD2KkJa1/baSq4bszI3jynp+/5I3ZOGD9+bECq9YvQUeSIHVS
         b+OgAUZepN2lyI/SJgZNlYHhkTvu+Z8Tilbx58iwsGFhEwnOJMFJPrX/ph+SvGlhx0mU
         pGS9OqPxnbF2M7iRRUmCnGXEALrlgEbJyj6ERV3brlM0RL+Tq2iIBn3R9XY5+P7Hq96w
         09AQ==
X-Gm-Message-State: AOAM533KmEcljYn5tEybi5BJVlK711zXMMiM45/XfoU2e8HYe9RsFGUu
        AZRVrNzEjHk7x6mO5o6X7z0=
X-Google-Smtp-Source: ABdhPJyJrgoSBZIuC41bLp1cidOYHD3JHUeA3RbTakuAdRfsgyt0qEd7seIIi2UkyBGp0woVUscUag==
X-Received: by 2002:a19:7009:: with SMTP id h9mr9987648lfc.271.1612789868792;
        Mon, 08 Feb 2021 05:11:08 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x20sm2086063lfe.256.2021.02.08.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:11:08 -0800 (PST)
Date:   Mon, 8 Feb 2021 14:11:07 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Message-ID: <YCE4a4swLUTw6j9Y@rocinante>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
 <20210206033502.103964-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210206033502.103964-3-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

Thank you for all the work here!

Just a number of suggestions, mainly nitpicks, so feel free to ignore
these, of course.

[...]
> +#define VMCFG_MSI_RMP_DIS	0x2
[...]

What about calling this VMCONFIG_MSI_REMAP so that is more
self-explanatory (it also shares some similarity with the
PCI_REG_VMCONFIG defintition).

[...]
> +	VMD_FEAT_BYPASS_MSI_REMAP		= (1 << 4),
[...]

Following on the naming that included "HAS" to indicate a feature (or
support for thereof), perhaps we could name this as, for example:

	VMD_FEAT_CAN_BYPASS_MSI_REMAP

What do you think?

[...] 
> +static void vmd_enable_msi_remapping(struct vmd_dev *vmd, bool enable)
> +{
> +	u16 reg;
> +
> +	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> +	reg = enable ? (reg & ~VMCFG_MSI_RMP_DIS) : (reg | VMCFG_MSI_RMP_DIS);
> +	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
> +}

I wonder if calling this function vmd_set_msi_remapping() would be more
aligned with what it does, since it turns the MSI remapping support on
and off, so to speak, as needed.  Do you think this would be OK to do?

[...]
> +		/*
> +		 * Override the irq domain bus token so the domain can be
> +		 * distinguished from a regular PCI/MSI domain.
> +		 */

It would be "IRQ" here.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
