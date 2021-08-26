Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609913F8708
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbhHZMMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 08:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234332AbhHZMMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 08:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A4146108F;
        Thu, 26 Aug 2021 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629979895;
        bh=BryUrSxyT2TT6tSSSqTo2t7ZRd6bMgSUrWrQMLXF2ac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BDBj7holoBi9ZiJTRkXbmYMWcK+xMo0nardzLXT7i4MOjGqW0dAn0wmbvp8j+6+zZ
         Fg21bazC0VEsUwoBuNDFR7MEh0AJL6UIE4plthN2FY2JPr7F65JZQaFsK2OfaVV83G
         9dljEGkyMnbI/J2mdZLjesaHEFOQbDWYfFDy0S5rtW5cpQWVyydKqnvINGVsIYNpGJ
         kS7/2Nc9DJDRdljYSibSd+MdpnaYU355yAM55ScDuTlpaJpP8QZIk1UB4WCa/a78gP
         GPv4+6mUzgVsnYdaDNSxhBIhfcQDngB4CSRoWeir3QsyAr7EwkbjAZm55tjrs2fTJh
         ZdT6vBvMMV0mw==
Received: by mail-ed1-f44.google.com with SMTP id d6so4303848edt.7;
        Thu, 26 Aug 2021 05:11:35 -0700 (PDT)
X-Gm-Message-State: AOAM531qVCzQeytGnkJiSRizBOTdFdv1nq7l24Mu0Z3JxpGl0UGz/knK
        iV4oAvdbsgMw6oIDR5eGM928sxgatcYn+VbJ0g==
X-Google-Smtp-Source: ABdhPJwYLeRflBPMuNkJZH2Kt3TECicrmcHUV9lHeboJn3XtLXvVEYg6HgPyTCS/Hgqjxpjz5VLMtu4/5uEZEvNSCgg=
X-Received: by 2002:aa7:c49a:: with SMTP id m26mr3990849edq.258.1629979893809;
 Thu, 26 Aug 2021 05:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20210811083830.784065-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210811083830.784065-3-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 26 Aug 2021 07:11:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tGAOo-9oKGF=B=3hCjiECBwxDujQu9drwCXK6u8J0BA@mail.gmail.com>
Message-ID: <CAL_Jsq+tGAOo-9oKGF=B=3hCjiECBwxDujQu9drwCXK6u8J0BA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI: visconti: Add Toshiba Visconti PCIe host
 controller driver
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 3:38 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> controller is based of Synopsys DesignWare PCIe core.
>
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>
> v5 -> v6:
>   - Remove unnecessary commit log.
>   - Fix split line of visconti_add_pcie_port()
>
> v4 -> v5:
>   - Remove PCIE_BUS_OFFSET
>   - Change link_up confirmation function of visconti_pcie_link_up().
>   - Move setting event mask before dw_pcie_link_up().
>   - Move the contents of visconti_pcie_power_on() to visconti_pcie_host_init().
>   - Remove code for link_gen.
>
> v3 -> v4:
>   - Change variable from pci_addr to cpu_addr in visconti_pcie_cpu_addr_fixup().
>   - Change the calculation method of CPU addres from subtraction to mask, and
>     add comment.
>   - Drop dma_set_mask_and_coherent().
>   - Drop set MAX_MSI_IRQS.
>   - Drop dev_dbg for Link speed.
>   - Use use the dev_err_probe() to handle the devm_clk_get() failed.
>   - Changed the redundant clock name.
>
> v2 -> v3:
>   - Update subject.
>   - Wrap description in 75 columns.
>   - Change config name to PCIE_VISCONTI_HOST.
>   - Update Kconfig text.
>   - Drop blank lines.
>   - Adjusted to 80 columns.
>   - Drop inline from functions for register access.
>   - Changed function name from visconti_pcie_check_link_status to
>     visconti_pcie_link_up.
>   - Update to using dw_pcie_host_init().
>   - Reorder these in the order of use in visconti_pcie_establish_link.
>   - Rewrite visconti_pcie_host_init() without dw_pcie_setup_rc().
>   - Change function name from  visconti_device_turnon() to
>     visconti_pcie_power_on().
>   - Unify formats such as dev_err().
>   - Drop error label in visconti_add_pcie_port().
>
> v1 -> v2:
>   - Fix typo in commit message.
>   - Drop "depends on OF && HAS_IOMEM" from Kconfig.
>   - Stop using the pointer of struct dw_pcie.
>   - Use _relaxed variant.
>   - Drop dw_pcie_wait_for_link.
>   - Drop dbi resource processing.
>   - Drop MSI IRQ initialization processing.
> ---
>  drivers/pci/controller/dwc/Kconfig         |   9 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-visconti.c | 333 +++++++++++++++++++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c

Reviewed-by: Rob Herring <robh@kernel.org>
