Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E83048BD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbhAZFkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:40:18 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:43586 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbhAYPlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 10:41:21 -0500
Received: by mail-ej1-f49.google.com with SMTP id a10so18660156ejg.10;
        Mon, 25 Jan 2021 07:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyL4/WcGTvpdZCqJcJOECqlMmr535n6usxLfE/ynu/E=;
        b=OmKAX6AXDbIaHj6DxVhAjBDkt8kuosO27VpAuYtykF9a5Lk2bXbaxz/gz6cXTIry1W
         fZs+T1H+a7eVAMCpjZOgvOaZhBAPdq3pbkTC9OJSalFD6JY6HVhdLG4+xdq0qZ6GblyL
         LMKSiAm2LYhSaisDJqah165Yz1bS7uV+W8ceBh6oKQIcXz19UA8WlTtUyl3iO92AhhPn
         /Kzm64h4KBd9B0e5au146kgMiU15Ja2X4KRaG00bVPhHAkX6gYsRLwkuUq+rxBOztE+h
         fGvG6YLESO5CC3EK+Lyt7XH/d6EVrvfp8Th9r6z0oakizciRGkV5xFd+VPbKvyE0PfXN
         D1pg==
X-Gm-Message-State: AOAM5323AETr9sArthylyCGF496qdWuvUj9UCdAQQX5yP0Yllp3N8gGC
        9EKuevDxScD5S3r/rgQKaW1PCPKG2DCZDbbs
X-Google-Smtp-Source: ABdhPJxNL9mFYGBYTgwnzqwNNdcwYvxvlFDBQLNsO+Oqe40jZ1WlQMWAHq+CbRtCbi0fUFMKsd2yTQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr1488164wrx.302.1611587044960;
        Mon, 25 Jan 2021 07:04:04 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r16sm23200794wrx.36.2021.01.25.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:04:04 -0800 (PST)
Date:   Mon, 25 Jan 2021 16:04:03 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     daire.mcnamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com
Subject: Re: [PATCH v20 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <YA7d43I5V2ITG1H/@rocinante>
References: <20210122145137.29023-1-daire.mcnamara@microchip.com>
 <20210122145137.29023-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122145137.29023-4-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Daire,

Thank you for working on this!

[...]
> +static const struct pci_ecam_ops mc_ecam_ops = {
> +	.bus_shift = 20,
> +	.init = mc_platform_init,
> +	.pci_ops = {
> +		.map_bus = pci_ecam_map_bus,
> +		.read = pci_generic_config_read,
> +		.write = pci_generic_config_write,
> +	}
> +};
[...]

If you are using standard ECAM, and it looks like you do, then you can
omit the .bus_shift initializer, as since the e7708f5b10e2 ("PCI: Unify
ECAM constants in native PCI Express drivers") we use the proper shift
value automatically for you, if you don't provide a custom one.

Alternatively, you can use the PCIE_ECAM_BUS_SHIFT constant, to avoid
open-coding the shift value.

Krzysztof
