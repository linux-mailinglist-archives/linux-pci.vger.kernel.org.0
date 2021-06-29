Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0423B741A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhF2OTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhF2OTQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 10:19:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96664C061766
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 07:16:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q192so17296027pfc.7
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f3OA1dbE+qUdV5an6bSR6AZUtN3k+/RtXxo9mlqVUD4=;
        b=giSyB9WUShwPd56VuIVkAfkBt51oAFRupZIVXyDbxohZNrT6uX/PGzO4YfcR6RXy2k
         zOoE9FnqYNNNW96vvxr1bPmxraitY/YRdE38PjpLqermFLgjcezEOfBQhnrhgGLPsm+f
         CQG1vwUpbeKG+RHT8FV7BQlX0VwMwVqiL+5I81G9bPoTOls0yp8tQBH/5g/2qknzQ9LP
         M0W0367iZ77m2J9ZALvSFTI9B3aW/fKx33tP08PU/jatdYErjUNbeb3BGZjQpYU7WeG6
         DZQbSIKryKZxXEKIk9HNZHVuX9QGC8N27FcFfBdaUyQzYZ5a4wmdfSssZuKrRBer787O
         bQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3OA1dbE+qUdV5an6bSR6AZUtN3k+/RtXxo9mlqVUD4=;
        b=U+XnXvpelCyayv2qJY8KnwEm/Fsq/rvFV7JN66DfnT0pg86iJhwcNZLVhaXShRfQJD
         oL0r9ICuJ8mVesqyXmfseB3N4WSa9wudiHfKnHiynr4CrxCl6nQhsm77xFYtao/I3U4O
         1aobCtFuWWWmF5bbjE9zhGoJUlEJnKnkDqifMXKiw4Cco2p6DzUK0qOZsmDWoxBHPOAo
         aNd3K/56JKUWsHCFVlURbryt1LF2bgR29Mo0k5GA/kF5QoYnWeZS+bU7WwcmUyxSVyUu
         5weBOVHylxQeUZJGkcc24EoQ7ho0PI/EEqaXckXqYAf06j1QXcllj74pQ9kM+pZjVZI8
         xeeg==
X-Gm-Message-State: AOAM531xi5HPJGT1faEKrN/Omz5wILZe7tjwlm9bSSeuSnl6V9fp5XDp
        b/LzLvgDd+znys9XS+Ghg/0G
X-Google-Smtp-Source: ABdhPJz6n3nDPMvA6az4RO6x+vwA2+2ZpH3IK3Jj/EID7/UDLLfvAlrM+x2LEg1Ff+/87fdn9cbU6w==
X-Received: by 2002:a63:500f:: with SMTP id e15mr11092658pgb.391.1624976207008;
        Tue, 29 Jun 2021 07:16:47 -0700 (PDT)
Received: from workstation ([120.138.12.32])
        by smtp.gmail.com with ESMTPSA id m2sm3676672pja.9.2021.06.29.07.16.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jun 2021 07:16:46 -0700 (PDT)
Date:   Tue, 29 Jun 2021 19:46:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        hemantk@codeaurora.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH v4 2/3] PCI: dwc: Add Qualcomm PCIe Endpoint controller
 driver
Message-ID: <20210629141641.GB3580@workstation>
References: <20210624072534.21191-1-manivannan.sadhasivam@linaro.org>
 <20210624072534.21191-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqLBuXvfEpMf4vo2YXsv3nprO-dkvzVp7LvWn+MYnAZvsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLBuXvfEpMf4vo2YXsv3nprO-dkvzVp7LvWn+MYnAZvsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 08:39:31AM -0600, Rob Herring wrote:
> (). On Thu, Jun 24, 2021 at 1:26 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > the Designware core with added Qualcomm specific wrapper around the
> > core. The driver support is very basic such that it supports only
> > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > for now but these will be added later.
> >
> > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > operation and written on top of the DWC PCI framework.
> >
> > Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > [mani: restructured the driver and fixed several bugs for upstream]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig        |  10 +
> >  drivers/pci/controller/dwc/Makefile       |   1 +
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 751 ++++++++++++++++++++++
> >  3 files changed, 762 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
> >

[...]

> A bunch of these defines are already in pcie-qcom.c. Make a header for
> the registers and common bits.
> 

The registers are shared but the offsets differ. By comparing, there are
just 3 registers that share the same offset. So I don't think it gives
any benefit in introducing a common header.

> > +
> > +/* ELBI registers */
> > +#define ELBI_SYS_STTS                          0x08
> > +
> > +/* DBI registers */
> > +#define DBI_CAP_ID_NXT_PTR                     0x40
> > +#define DBI_CON_STATUS                         0x44
> > +#define DBI_DEVICE_CAPABILITIES                        0x74
> > +#define DBI_LINK_CAPABILITIES                  0x7c
> > +#define DBI_LINK_CONTROL2_LINK_STATUS2         0xa0
> > +#define DBI_L1SUB_CAPABILITY                   0x234
> 
> These are all standard PCIe config space registers. Use standard
> defines and the offsets are discoverable.
> 

Okay.

> > +#define DBI_ACK_F_ASPM_CTRL                    0x70c
> > +#define DBI_GEN3_RELATED_OFF                   0x890
> > +#define DBI_AUX_CLK_FREQ                       0xb40
> > +
> > +#define DBI_L0S_ACCPT_LATENCY_MASK             GENMASK(8, 6)
> > +#define DBI_L1_ACCPT_LATENCY_MASK              GENMASK(11, 9)
> > +#define DBI_L0S_EXIT_LATENCY_MASK              GENMASK(14, 12)
> > +#define DBI_L1_EXIT_LATENCY_MASK               GENMASK(17, 15)
> > +#define DBI_ACK_N_FTS_MASK                     GENMASK(15, 8)
> 
> Standard DWC DBI registers. Use defines in pcie-designware.h and
> really any code touching these registers belongs in the common DWC
> code.
> 

Looked into this part and found that most of the DBI settings can be
skipped as the reset state is same.

In v5, there will be only DBI_CON_STATUS register in this driver for
reading the D-state in IRQ handler. I can't find any info about this
register in the PCI spec. And by judging from its location (between
PM capability register and MSI capability register), this seems to be
Qcom specific.

> > +
> > +#define XMLH_LINK_UP                           0x400
> > +#define CORE_RESET_TIME_US_MIN                 1000
> > +#define CORE_RESET_TIME_US_MAX                 1005
> > +#define WAKE_DELAY_US                          2000 /* 2 ms */
> > +
> > +#define to_pcie_ep(x)                          dev_get_drvdata((x)->dev)
> > +
> > +enum qcom_pcie_ep_link_status {
> > +       QCOM_PCIE_EP_LINK_DISABLED,
> > +       QCOM_PCIE_EP_LINK_ENABLED,
> > +       QCOM_PCIE_EP_LINK_UP,
> > +       QCOM_PCIE_EP_LINK_DOWN,
> > +};
> > +
> > +enum qcom_pcie_ep_irq {
> > +       QCOM_PCIE_EP_INT_RESERVED,
> > +       QCOM_PCIE_EP_INT_LINK_DOWN,
> > +       QCOM_PCIE_EP_INT_BME,
> > +       QCOM_PCIE_EP_INT_PM_TURNOFF,
> > +       QCOM_PCIE_EP_INT_DEBUG,
> > +       QCOM_PCIE_EP_INT_LTR,
> > +       QCOM_PCIE_EP_INT_MHI_Q6,
> > +       QCOM_PCIE_EP_INT_MHI_A7,
> > +       QCOM_PCIE_EP_INT_DSTATE_CHANGE,
> > +       QCOM_PCIE_EP_INT_L1SUB_TIMEOUT,
> > +       QCOM_PCIE_EP_INT_MMIO_WRITE,
> > +       QCOM_PCIE_EP_INT_CFG_WRITE,
> > +       QCOM_PCIE_EP_INT_BRIDGE_FLUSH_N,
> > +       QCOM_PCIE_EP_INT_LINK_UP,
> > +       QCOM_PCIE_EP_INT_AER_LEGACY,
> > +       QCOM_PCIE_EP_INT_PLS_ERR,
> > +       QCOM_PCIE_EP_INT_PME_LEGACY,
> > +       QCOM_PCIE_EP_INT_PLS_PME,
> > +       QCOM_PCIE_EP_INT_MAX,
> > +};
> > +
> > +static struct clk_bulk_data qcom_pcie_ep_clks[] = {
> > +       { .id = "cfg" },
> > +       { .id = "aux" },
> > +       { .id = "bus_master" },
> > +       { .id = "bus_slave" },
> > +       { .id = "ref" },
> > +       { .id = "sleep" },
> > +       { .id = "slave_q2a" },
> > +};
> > +
> > +struct qcom_pcie_ep {
> > +       struct dw_pcie pci;
> > +
> > +       void __iomem *parf;
> > +       void __iomem *elbi;
> > +       void __iomem *mmio;
> > +       struct regmap *perst_map;
> > +
> > +       struct reset_control *core_reset;
> > +       struct gpio_desc *reset;
> > +       struct gpio_desc *wake;
> > +       struct phy *phy;
> > +
> > +       resource_size_t dbi_phys;
> > +       resource_size_t atu_phys;
> 
> These 2 are never used.
> 

oh, that's a left over. will remove.

> > +       resource_size_t mmio_phys;
> > +       u32 mmio_size;
> 
> 'mmio' is a horrible name. It's all MMIO. Is this 'addr_space' used by
> other EP drivers?
> 

No, this is the BAR region used by the device. This region is called
MMIO in the hardware as it relates to the MHI bus and has the registers
for MHI. Calling this region by some other name will induce a confusion
since the MHI spec has been referencing this region as MMIO.

> Just save a pointer to the resource if you need these. Or retrieve the
> resource in the one place you need it.
> 

Okay

> > +       u32 perst_en;
> > +       u32 perst_sep_en;
> > +
> > +       enum qcom_pcie_ep_link_status link_status;
> > +       int global_irq;
> > +       int perst_irq;
> > +};
> > +
> > +static void qcom_pcie_ep_enable_ltssm(struct qcom_pcie_ep *pcie_ep)
> > +{
> > +       u32 reg;
> > +
> > +       reg = readl(pcie_ep->parf + PARF_LTSSM);
> > +       reg |= BIT(8);
> > +       writel(reg, pcie_ep->parf + PARF_LTSSM);
> > +}
> 
> Same function as qcom_pcie_2_3_2_ltssm_enable().
> 

this is the only function shared between RC and EP drivers...

> 
> > +

[...]

> > +
> > +       /* L1ss is supported */
> > +       val = dw_pcie_readl_dbi(pci, DBI_L1SUB_CAPABILITY);
> > +       val |= 0x1f;
> > +       dw_pcie_writel_dbi(pci, DBI_L1SUB_CAPABILITY, val);
> > +
> > +       /* Enable Clock Power Management */
> > +       val = dw_pcie_readl_dbi(pci, DBI_LINK_CAPABILITIES);
> > +       val |= BIT(18);
> > +       dw_pcie_writel_dbi(pci, DBI_LINK_CAPABILITIES, val);
> 
> Lots of magic values that need defines.
> 

Will add defines for all of them

> > +
> > +       dw_pcie_dbi_ro_wr_dis(pci);
> > +
> > +       /* Set FTS value to match the PHY setting */
> > +       val = dw_pcie_readl_dbi(pci, DBI_ACK_F_ASPM_CTRL);
> > +       val |= FIELD_PREP(DBI_ACK_N_FTS_MASK, 0x80);
> > +       dw_pcie_writel_dbi(pci, DBI_ACK_F_ASPM_CTRL, val);
> > +
> > +       writel(0, pcie_ep->parf + PARF_INT_ALL_MASK);
> > +       val = BIT(QCOM_PCIE_EP_INT_LINK_DOWN) |
> > +               BIT(QCOM_PCIE_EP_INT_BME) |
> > +               BIT(QCOM_PCIE_EP_INT_PM_TURNOFF) |
> > +               BIT(QCOM_PCIE_EP_INT_DSTATE_CHANGE) |
> > +               BIT(QCOM_PCIE_EP_INT_LINK_UP);
> 
> Move BIT() into the defines.
> 

This has been done because QCOM_PCIE_EP_INT_* are defined as enums and
shared with the IRQ handler. But I'll change these to defines with BIT()
macro and will use if() condition for matching the events in irq
handler.

> > +       writel(val, pcie_ep->parf + PARF_INT_ALL_MASK);
> > +
> > +       return 0;
> > +}
> > +

[...]

> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> > +       pci->atu_base = devm_pci_remap_cfg_resource(dev, res);
> 
> The DWC core does this for you.
>

Oh yeah. I added this for getting the atu_phys address that needs to be
written to some PARF registers. But in v4 I removed that logic and
forgot to remove this.

> > +       if (IS_ERR(pci->atu_base))
> > +               return PTR_ERR(pci->atu_base);
> > +       pcie_ep->atu_phys = res->start;
> > +

[...]

> > +       pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
> > +       irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
> > +       ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->perst_irq, NULL,
> > +                                       qcom_pcie_ep_perst_threaded_irq,
> > +                                       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> 
> IRQ_TRIGGER_* should come from the DT.
> 

How? We can specify the triggers in "interrupts*" property but here the
IRQ is obtained from the GPIO. So I'm not sure how to specify the
trigger in DT.

Thanks,
Mani
