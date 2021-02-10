Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120C6315B6B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 01:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhBJAjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 19:39:08 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36873 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhBJAhF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 19:37:05 -0500
Received: by mail-lf1-f51.google.com with SMTP id w36so303513lfu.4;
        Tue, 09 Feb 2021 16:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wPsstsbynBD0muJOD6wturTyK6NppfQu4lyJkZAZfH8=;
        b=FFAWMir4d+LqcUx6Vvhcc8IojjqX86q+s6331nZ3/kjmoIb8EtQviOAsK/UhYnxAkd
         XorMJy718MWGo+9yDDStbifToulCliyAytAdiuLwUC23XZ4EJDeLYm5jsSygDB5ssBl0
         qpzcT/TZx84e02gAG8ukM/9kTC9zId/xeI0YCdz73kLO+GpL08T9hYsuFNov6eMKX5ku
         XBDvnDb6+ZazLSXvN/N0FkrvkPejp3W0nJbQD4JRK6zd3PMHh8D+boW6P5uytWupvpj5
         45D1G7EYGpmKzH6x7aiKGPnFDkYoVAgjEVMovMs2e4fXhZhBrn9OsLl0Semrg/PKAtUD
         fC2w==
X-Gm-Message-State: AOAM530M4YVNAqoWybWejEsiF/+aBrdm4i/qQ6jDa4bwZ3bAlvkf06V+
        pcUmnNxjCTA32mVP5ldQd5o=
X-Google-Smtp-Source: ABdhPJxrSG4l3RbglATBasrr8+6cW9tztKybjkr40jjnPmlVr/WsM/qvwRd01Fw0EML319v+qJ8PyQ==
X-Received: by 2002:a19:5f4c:: with SMTP id a12mr274761lfj.399.1612917382914;
        Tue, 09 Feb 2021 16:36:22 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v25sm52098ljc.92.2021.02.09.16.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:36:22 -0800 (PST)
Date:   Wed, 10 Feb 2021 01:36:21 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     srikanth.thokala@intel.com
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v7 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <YCMqhe4w1QFYoGhE@rocinante>
References: <20210124234702.21074-1-srikanth.thokala@intel.com>
 <20210124234702.21074-3-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210124234702.21074-3-srikanth.thokala@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Srikanth,

Thank you for all the work here!

> +config PCIE_KEEMBAY_HOST
> +	bool "Intel Keem Bay PCIe controller - Host mode"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	select PCIE_KEEMBAY
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in Keem Bay
> +	  to work in host mode.
> +	  The PCIe controller is based on Designware Hardware and uses
> +	  DesignWare core functions.
> +
> +config PCIE_KEEMBAY_EP
> +	bool "Intel Keem Bay PCIe controller - Endpoint mode"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_KEEMBAY
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in Keem Bay
> +	  to work in endpoint mode.
> +	  The PCIe controller is based on Designware Hardware and uses
> +	  DesignWare core functions.

It would be "DesignWare" in the sentences above.

[...]
> +static void keembay_ep_reset_deassert(struct keembay_pcie *pcie)
> +{
> +	/*
> +	 * Ensure that PERST# is asserted for a minimum of 100ms
[...]

Just a nitpick, so feel free to ignore, absolutely.  A missing period at
the end of the sentence.

> +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
> +	if (enable)
> +		val |= APP_LTSSM_ENABLE;
> +	else
> +		val &= ~APP_LTSSM_ENABLE;
> +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
> +}
>

Another nitpick, so also feel free to ignore, of course.

I wonder if calling this function keembay_pcie_set_ltssm or perhaps
keembay_pcie_ltssm_set would be more aligned with what it does, since it
turns the LTSSM support on and off, so to speak, as needed.  Do you
think this would be OK to do?

Krzysztof
