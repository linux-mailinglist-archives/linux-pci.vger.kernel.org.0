Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE12DF883
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 06:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgLUFHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 00:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgLUFHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2020 00:07:46 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19DC061282
        for <linux-pci@vger.kernel.org>; Sun, 20 Dec 2020 21:07:06 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id x26so4734149vsq.1
        for <linux-pci@vger.kernel.org>; Sun, 20 Dec 2020 21:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2sv3VkK2By/nwrygpkYVYn6xWRD6GwhccQNwKSBn4w=;
        b=lG0l2N+YGGhJ5oCJ9JR6Pg+HbQ76IrvYULahKaWv4R8NzZPMc70xVFw1uC6D2pNUqs
         3VTIRjsfE2A1L9rfCR8h9hz12sovUmCiwHhuITtvbB9nqEAXk6qgaQsY8monhGNhiN+l
         h4DplYe0I1Vbviao54AAS+oWIvnsilSn6wWFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2sv3VkK2By/nwrygpkYVYn6xWRD6GwhccQNwKSBn4w=;
        b=BeA6I0lq0jvmp3nMGRmTdTWzxvOncIvGdDqgkvv2UHKvUj+tkn223/po6OyhmEwzPU
         kX9kOjlmxbZB0h0MuOHmyn/c8T+ND2qosPFcU3h4UYEXK+iFstBDw0J2msC9umonw9f2
         +PhcJimSZZHEj2Dw+e+iAA9jBLsSF7ETwC8e11LQqVr9p4avLdler8LcxVOcvOXccyBT
         ZG4AQehsJEAdBPQ1rPADqzIRzC8P6IAWWKsXG1ZA0nMbq6jv2DlAeUfmARuuHjgn0Nu3
         yYPaEvA3ezkpAFuNvVEd2juK/tg0/pJ2uX6YuD0rZorCGM2C8gKB2AEut37QntdVDJNL
         12jg==
X-Gm-Message-State: AOAM532VVxkC3O4T5CcAKbtASzE3avfsPdcR9qPa72dhvnW4Inm27anJ
        adsWXV2CsGYNKAjkhm8Q/uLuKldU0+AjNejbWMsBYU016wJn+g==
X-Google-Smtp-Source: ABdhPJyIouX3buCUZ98Imsh5w5akAiycF/we7iirOQojEj+Pe8P9M9Aglq/IXG0MUde1d3b37rDVQIfcviqjMwgt26Q=
X-Received: by 2002:a67:6182:: with SMTP id v124mr11122635vsb.16.1608517105056;
 Sun, 20 Dec 2020 18:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20201202133813.6917-1-jianjun.wang@mediatek.com> <20201202133813.6917-3-jianjun.wang@mediatek.com>
In-Reply-To: <20201202133813.6917-3-jianjun.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 21 Dec 2020 10:18:14 +0800
Message-ID: <CANMq1KCSWf4PDMVhxFiLHOHe3dFqZbq1gzn4ph8aApVMX56MDg@mail.gmail.com>
Subject: Re: [v5,2/3] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        qizhong.cheng@mediatek.com, sin_jieyang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 2, 2020 at 9:39 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> MediaTek's PCIe host controller has three generation HWs, the new
> generation HW is an individual bridge, it supports Gen3 speed and
> up to 256 MSI interrupt numbers for multi-function devices.
>
> Add support for new Gen3 controller which can be found on MT8192.
>
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

FWIW, I looked at Rob and Bjorn's comments on v4, and they seem to
have been addressed (with one small nit highlighted below).

> ---
> This patch dependents on "PCI: Export pci_pio_to_address() for module use"[1]
> to build as a kernel module.
>
> This interface will be used by PCI host drivers for PIO translation,
> export it to support compiling those drivers as kernel modules.
>
> [1]http://lists.infradead.org/pipermail/linux-mediatek/2020-December/019504.html
> ---
>  drivers/pci/controller/Kconfig              |   13 +
>  drivers/pci/controller/Makefile             |    1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1039 +++++++++++++++++++
>  3 files changed, 1053 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c
>
> [snip]
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> new file mode 100644
> index 000000000000..d30ea734ac0a
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -0,0 +1,1039 @@
> [snip]
> +static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
> +                                   resource_size_t cpu_addr,
> +                                   resource_size_t pci_addr,
> +                                   resource_size_t size,
> +                                   unsigned long type, int num)
> +{
> +       void __iomem *table;
> +       u32 val = 0;

You don't need to init val to 0.

> +
> +       if (num >= PCIE_MAX_TRANS_TABLES) {
> +               dev_notice(port->dev, "not enough translate table[%d] for addr: %#llx, limited to [%d]\n",
> +                          num, (unsigned long long) cpu_addr,
> +                          PCIE_MAX_TRANS_TABLES);
> +               return -ENODEV;
> +       }
> +
> +       table = port->base + PCIE_TRANS_TABLE_BASE_REG +
> +               num * PCIE_ATR_TLB_SET_OFFSET;
> +
> +       writel(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1), table);
> +       writel(upper_32_bits(cpu_addr), table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
> +       writel(lower_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
> +       writel(upper_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
> +
> +       if (type == IORESOURCE_IO)
> +               val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
> +       else
> +               val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
> +
> +       writel(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
> +
> +       return 0;
> +}
> +
> +static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
> +{
> +       struct resource_entry *entry;
> +       struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
> +       unsigned int table_index = 0;
> +       int err;
> +       u32 val;
> +
> +       /* Set as RC mode */
> +       val = readl(port->base + PCIE_SETTING_REG);
> +       val |= PCIE_RC_MODE;
> +       writel(val, port->base + PCIE_SETTING_REG);
> +
> +       /* Set class code */
> +       val = readl(port->base + PCIE_PCI_IDS_1);
> +       val &= ~GENMASK(31, 8);
> +       val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
> +       writel(val, port->base + PCIE_PCI_IDS_1);
> +
> +       /* Assert all reset signals */
> +       val = readl(port->base + PCIE_RST_CTRL_REG);
> +       val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> +       writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +       /* De-assert reset signals */
> +       val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> +       writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +       /* Delay 100ms to wait the reference clocks become stable */
> +       usleep_range(100 * 1000, 120 * 1000);

Any reason not to use msleep(100)?

> +
> +       /* De-assert PERST# signal */
> +       val &= ~PCIE_PE_RSTB;
> +       writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +       /* Check if the link is up or not */
> +       err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> +                       !!(val & PCIE_PORT_LINKUP), 20,
> +                       50 * USEC_PER_MSEC);
> +       if (err) {
> +               val = readl(port->base + PCIE_LTSSM_STATUS_REG);
> +               dev_notice(port->dev, "PCIe link down, ltssm reg val: %#x\n",
> +                          val);
> +               return err;
> +       }
> +
> +       /* Set PCIe translation windows */
> +       resource_list_for_each_entry(entry, &host->windows) {
> +               struct resource *res = entry->res;
> +               unsigned long type = resource_type(res);
> +               resource_size_t cpu_addr;
> +               resource_size_t pci_addr;
> +               resource_size_t size;
> +               const char *range_type;
> +
> +               if (type == IORESOURCE_IO) {
> +                       cpu_addr = pci_pio_to_address(res->start);
> +                       range_type = "IO";
> +               } else if (type == IORESOURCE_MEM) {
> +                       cpu_addr = res->start;
> +                       range_type = "MEM";
> +               } else {
> +                       continue;
> +               }
> +
> +               pci_addr = res->start - entry->offset;
> +               size = resource_size(res);
> +               err = mtk_pcie_set_trans_table(port, cpu_addr, pci_addr, size,
> +                                              type, table_index);
> +               if (err)
> +                       return err;
> +
> +               dev_dbg(port->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
> +                       range_type, table_index, (unsigned long long) cpu_addr,
> +                       (unsigned long long) pci_addr,
> +                       (unsigned long long) size);
> +
> +               table_index++;
> +       }
> +
> +       return 0;
> +}
> +
> [snip]
> +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
> +                                             msi_alloc_info_t *arg)
> +{
> +       struct msi_desc *entry = arg->desc;
> +       struct mtk_pcie_port *port = info->chip_data;
> +       int hwirq;
> +
> +       mutex_lock(&port->lock);
> +
> +       hwirq = bitmap_find_free_region(port->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
> +                                       order_base_2(entry->nvec_used));
> +       if (hwirq < 0) {
> +               mutex_unlock(&port->lock);
> +               return -ENOSPC;
> +       }
> +
> +       mutex_unlock(&port->lock);
> +
> +       return hwirq;

Code is good, but I had to look twice to make sure the mutex is
unlocked. Is the following marginally better?

hwirq = ...;

mutex_unlock(&port->lock);

if (hwirq < 0)
   return -ENOSPC;

return hwirq;

> +}
> +
> [snip]
> +static void mtk_pcie_msi_handler(struct irq_desc *desc)
> +{
> +       struct mtk_pcie_msi *msi_info = irq_desc_get_handler_data(desc);
> +       struct irq_chip *irqchip = irq_desc_get_chip(desc);
> +       unsigned long msi_enable, msi_status;
> +       unsigned int virq;
> +       irq_hw_number_t bit, hwirq;
> +
> +       chained_irq_enter(irqchip, desc);
> +
> +       msi_enable = readl(msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> +       while ((msi_status = readl(msi_info->base + PCIE_MSI_STATUS_OFFSET))) {
> +               msi_status &= msi_enable;

I don't know much about MSI, but what happens if you have a bit that
is set in PCIE_MSI_STATUS_OFFSET register, but not in msi_enable?
Sounds like you'll just spin-loop forever without acknowledging the
interrupt.

> +               for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
> +                       hwirq = bit + msi_info->index * PCIE_MSI_IRQS_PER_SET;
> +                       virq = irq_find_mapping(msi_info->domain, hwirq);
> +                       generic_handle_irq(virq);
> +               }
> +       }
> +
> +       chained_irq_exit(irqchip, desc);
> +}
> +
> [snip]
> +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> +{
> +       struct mtk_pcie_port *port = dev_get_drvdata(dev);
> +       int err;
> +       u32 val;
> +
> +       /* Trigger link to L2 state */
> +       err = mtk_pcie_turn_off_link(port);
> +       if (err) {
> +               dev_notice(port->dev, "can not enter L2 state\n");

Rob suggested dev_error here.

(and IMHO, or lot of the other dev_notice above should probably get dev_error)

> +               return err;
> +       }
> +
> +       /* Pull down the PERST# pin */
> +       val = readl(port->base + PCIE_RST_CTRL_REG);
> +       val |= PCIE_PE_RSTB;
> +       writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +       dev_dbg(port->dev, "enter L2 state success");
> +
> +       clk_bulk_disable_unprepare(port->num_clks, port->clks);
> +
> +       phy_power_off(port->phy);
> +
> +       return 0;
> +}
> +
> [snip]
