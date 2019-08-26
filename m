Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4349D7F9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 23:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfHZVQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 17:16:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33356 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHZVQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 17:16:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so12445240oto.0;
        Mon, 26 Aug 2019 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKMAVZIuSgGVDtxXvYyhn7GD+64SfvGUsQvFbXUt4wE=;
        b=lgNPPmo5n0Rfj8QT6SjW5sRvTOXI70wrynn06WZQFE50LzbiIL1pDOI9mhuJ695wZe
         dEBU5tAMX6KZv601jo5y9eB70dd3EQyoSjTFmPP2tR2dEQMw25p1jdvFzbm/DcFQkKHA
         H5PNT5bsEInbd9Wg8h8O9keGc6e4GYM+P3rSu9DfmpKHnojnehuUWtPNKduekN9+e7EZ
         ohPkWr6xNx14OGycYDMnnFs9eAqc6P4CH7GLy4GmYfICSRreRzwpObMPOEEdaU8e7JbP
         aLuSeQvpY/OJ/EXNaXA029fDY/t2O746lCuYBuxbjOjkJwwHWQA6Zkt50GgdgJk9piQp
         YeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKMAVZIuSgGVDtxXvYyhn7GD+64SfvGUsQvFbXUt4wE=;
        b=DIb9xxHGzJV1Lea+HXWKF6AmeuzQC9lJVmDAOKe2FcdoXdsbWoxbM+LxvXmrl8Bqaa
         FA/4YH95fCF7ukke6W+LrVNtWMUPc57eiavsP7TqX3jc2EFjekNrVS7cXEuvI62cDeBs
         scYnpFYoWGfbnQ18IUxQipP6pyN0PWf48sqSqg6L+9v3Bd2p0YMejJcNsFxiBUo0FuVM
         G1s9JNRSVQjl241m6Tjv8+86V5m9ds+O2gQRFEiDEj12oTilsqEolGXdmfwyUcG8fUFy
         gLXr8I3DsW5j434GRx6zLj0lN87KrnjACz1+e8oqC1zchEzPNlZollfmomJtJhDSZ+oI
         nD4w==
X-Gm-Message-State: APjAAAWDZA5LJu/rp1UIqzKVj9tnuYpPSfZ1Fq69r61mYa9kJOku0hzn
        nmNrET/0NyonSZCHKAzrMIZ0cgxa0x7DtUnRY8I=
X-Google-Smtp-Source: APXvYqx78Wx/0Z6guBExBZzvQBvgJXyk/rY363n8Jn9/kciaGY7u0bxbx8Eyd0yIUkodqiVR+0F9xrgj7zWp51E0bMI=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr17035197ote.98.1566854160077;
 Mon, 26 Aug 2019 14:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com> <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
In-Reply-To: <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 26 Aug 2019 23:15:48 +0200
Message-ID: <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Cc:     eswara.kota@linux.intel.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, hch@infradead.org,
        jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, Aug 26, 2019 at 5:31 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
>
> Hi Martin,
>
> Thanks for your valuable comments. I reply some of them as below.
you're welcome

[...]
> >> +config PCIE_INTEL_AXI
> >> +        bool "Intel AHB/AXI PCIe host controller support"
> > I believe that this is mostly the same IP block as it's used in Lantiq
> > (xDSL) VRX200 SoCs (with MIPS cores) which was introduced in 2010
> > (before Intel acquired Lantiq).
> > This is why I would have personally called the driver PCIE_LANTIQ
>
> VRX200 SoC(internally called VR9) was the first PCIe SoC product which
> was using synopsys
>
> controller v3.30a. It only supports PCIe Gen1.1/1.0. The phy is internal
> phy from infineon.
thank you for these details
I wasn't aware that the PCIe PHY on these SoCs was developed by
Infineon nor is the DWC version documented anywhere

[...]
> >> +#define PCIE_CCRID                          0x8
> >> +
> >> +#define PCIE_LCAP                           0x7C
> >> +#define PCIE_LCAP_MAX_LINK_SPEED            GENMASK(3, 0)
> >> +#define PCIE_LCAP_MAX_LENGTH_WIDTH          GENMASK(9, 4)
> >> +
> >> +/* Link Control and Status Register */
> >> +#define PCIE_LCTLSTS                                0x80
> >> +#define PCIE_LCTLSTS_ASPM_ENABLE            GENMASK(1, 0)
> >> +#define PCIE_LCTLSTS_RCB128                 BIT(3)
> >> +#define PCIE_LCTLSTS_LINK_DISABLE           BIT(4)
> >> +#define PCIE_LCTLSTS_COM_CLK_CFG            BIT(6)
> >> +#define PCIE_LCTLSTS_HW_AW_DIS                      BIT(9)
> >> +#define PCIE_LCTLSTS_LINK_SPEED                     GENMASK(19, 16)
> >> +#define PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH  GENMASK(25, 20)
> >> +#define PCIE_LCTLSTS_SLOT_CLK_CFG           BIT(28)
> >> +
> >> +#define PCIE_LCTLSTS2                               0xA0
> >> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED                GENMASK(3, 0)
> >> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_25GT   0x1
> >> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_5GT    0x2
> >> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_8GT    0x3
> >> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_16GT   0x4
> >> +#define PCIE_LCTLSTS2_HW_AUTO_DIS           BIT(5)
> >> +
> >> +/* Ack Frequency Register */
> >> +#define PCIE_AFR                            0x70C
> >> +#define PCIE_AFR_FTS_NUM                    GENMASK(15, 8)
> >> +#define PCIE_AFR_COM_FTS_NUM                        GENMASK(23, 16)
> >> +#define PCIE_AFR_GEN12_FTS_NUM_DFT          (SZ_128 - 1)
> >> +#define PCIE_AFR_GEN3_FTS_NUM_DFT           180
> >> +#define PCIE_AFR_GEN4_FTS_NUM_DFT           196
> >> +
> >> +#define PCIE_PLCR_DLL_LINK_EN                       BIT(5)
> >> +#define PCIE_PORT_LOGIC_FTS                 GENMASK(7, 0)
> >> +#define PCIE_PORT_LOGIC_DFT_FTS_NUM         (SZ_128 - 1)
> >> +
> >> +#define PCIE_MISC_CTRL                              0x8BC
> >> +#define PCIE_MISC_CTRL_DBI_RO_WR_EN         BIT(0)
> >> +
> >> +#define PCIE_MULTI_LANE_CTRL                        0x8C0
> >> +#define PCIE_UPCONFIG_SUPPORT                       BIT(7)
> >> +#define PCIE_DIRECT_LINK_WIDTH_CHANGE               BIT(6)
> >> +#define PCIE_TARGET_LINK_WIDTH                      GENMASK(5, 0)
> >> +
> >> +#define PCIE_IOP_CTRL                               0x8C4
> >> +#define PCIE_IOP_RX_STANDBY_CTRL            GENMASK(6, 0)
> no need for IOP
with "are you sure that you need any of the registers above?" I really
meant all registers above (including, but not limited to IOP)

[...]
> As I mentioned, VRX200 was a very old PCIe Gen1.1 product. In our latest
> SoC Lightning
>
> Mountain, we are using synopsys controller 5.20/5.50a. We support
> Gen2(XRX350/550),
>
> Gen3(PRX300) and GEN4(X86 based SoC). We also supported dual lane and
> single lane.
>
> Some of the above registers are needed to control FTS, link width and
> link speed.
only now I noticed that I didn't explain why I was asking whether all
these registers are needed
my understanding of the DWC PCIe controller driver "library" is that:
- all functionality which is provided by the DesignWare PCIe core
should be added to drivers/pci/controller/dwc/pcie-designware*
- functionality which is built on top/around the DWC PCIe core should
be added to <vendor specific driver>

the link width and link speed settings (I don't know about "FTS")
don't seem Intel/Lantiq controller specific to me
so the register setup for these bits should be moved to
drivers/pci/controller/dwc/pcie-designware*

> > this also makes me wonder if various functions below like
> > intel_pcie_link_setup() and intel_pcie_max_speed_setup() (and probably
> > more) are really needed or if it's just cargo cult / copy paste from
> > an out-of-tree driver).
>
> intel_pcie_link_setup is to record maximum speed and and link width. We need these
> to change speed and link width on the fly which is not supported by dwc driver common
> source.
> There are two major purposes.
> 1. For cable applications, they have battery support mode. In this case, it has to
> switch from x2 and gen4 to x1 and gen1 on the fly
> 2. Some customers have high EMI issues. They can try to switch to lower speed and
> lower link width to check on the fly. Otherwise, they have to change the device tree
> and reboot the system.
based on your description I imagine that this may be a "common
problem" (for example: Nvidia Tegra SoCs are also used in portable -
as in battery powered - applications)
I don't know enough about the Linux PCIe subsystem to comment on this,
so I'm hoping that one of the PCIe subsystem maintainers can comment
whether this is logic that should be implemented on a per-controller
basis or whether there should be some generic implementation

[...]
> >> +static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
> >> +{
> >> +    return readl(lpp->app_base + ofs);
> >> +}
> >> +
> >> +static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
> >> +{
> >> +    writel(val, lpp->app_base + ofs);
> >> +}
> >> +
> >> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
> >> +                         u32 mask, u32 val, u32 ofs)
> >> +{
> >> +    pcie_update_bits(lpp->app_base, mask, val, ofs);
> >> +}
> > do you have plans to support the MIPS SoCs (VRX200, ARX300, XRX350,
> > XRX550)?
> > These will need register writes in big endian. in my own experiment [0]
> > I simply used the regmap interface which will default to little endian
> > register access but switch to big endian when the devicetree node is
> > marked with big-endian.
> >
> > [...]
>
> We can support up to XRX350/XRX500/PRX300 for MIPS SoC since we still
> sell these products.
OK, I understand this.
switching to regmap will give you two benefits:
- big endian registers writes (without additional code) on the MIPS SoCs
- you can drop the pcie_app_* helper functions and use
regmap_{read,write,update_bits} instead

> [...] However, we have no effort to support EOL product
> such as VRX200 which also makes driver quite complex since the glue
> logic(reset, clock and endianness). For MIPS based platform, we have
> endianness control in device tree such as inbound_swap and outbound_swap
>
> For VRX200, we have another big concern, that is PCI and PCIe has coupling
> for endiannes which makes things very bad.
>
> However, if you are interested in supporting VRX200, it is highly
> appreciated.
thank you for the endianness control description and your concerns
about the implementation on VRX200

with my experiment I didn't have any problems with reset lines, clocks
or endianness (at least I believe so)
let's focus on the newer SoCs first, support for more SoCs can be a second step

> >> +static int intel_pcie_bios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >> +{
> >> +
> >> +    struct pcie_port *pp = dev->bus->sysdata;
> >> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >> +    struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
> >> +    struct device *pdev = lpp->pci->dev;
> >> +    u32 irq_bit;
> >> +    int irq;
> >> +
> >> +    if (pin == PCI_INTERRUPT_UNKNOWN || pin > PCI_NUM_INTX) {
> >> +            dev_warn(pdev, "WARNING: dev %s: invalid interrupt pin %d\n",
> >> +                     pci_name(dev), pin);
> >> +            return -1;
> >> +    }
> >> +    irq = of_irq_parse_and_map_pci(dev, slot, pin);
> >> +    if (!irq) {
> >> +            dev_err(pdev, "trying to map irq for unknown slot:%d pin:%d\n",
> >> +                    slot, pin);
> >> +            return -1;
> >> +    }
> >> +    /* Pin to irq offset bit position */
> >> +    irq_bit = BIT(pin + PCIE_INTX_OFFSET);
> >> +
> >> +    /* Clear possible pending interrupts first */
> >> +    pcie_app_wr(lpp, irq_bit, PCIE_IRNCR);
> >> +
> >> +    pcie_app_wr_mask(lpp, irq_bit, irq_bit, PCIE_IRNEN);
> >> +    return irq;
> >> +}
> > my interpretation is that there's an interrupt controller embedded into
> > the APP registers. The integrated interrupt controller takes 5
> > interrupts and provides the legacy PCI_INTA/B/C/D interrupts as well as
> > a WAKEUP IRQ. Each of it's own interrupts is tied to one of the parent
> > interrupts.
>
> For MIPS base SoC, there is no interrupt controller for such APP registers.
let me try to describe the IRNCR register with my own words:

a) it contains various interrupts for the controller itself (for
example: HOTPLUG, RX fatal error, RX non fatal error, ...)
these interrupts arrive at the controllers interrupt line (requested
below using devm_request_irq).
all of these interrupts are enabled when initializing the controller
as they are valid regardless of which PCI interrupt type (MSI, legacy
A/B/C/D) is used

b) it contains bits to enable/disable the legacy PCI INTA/B/C/D interrupts
these interrupts arrive at a dedicated interrupt line each.
each individual interrupt has an enable bit in the IRNCR register and
should only be enabled when when it's actually needed

c) it contains a PCI WAKE interrupt
it arrives at a dedicated interrupt line
I don't know when it should be enabled or not (I don't even know if
this interrupt is important at all)

let's focus on case a) and b) because I don't know if case c) is
relevant at all:
case a) is implemented in the IRQ setup, this matches my expectation

case b) is implemented in the map_irq callback. however, that only
covers "enabling" the interrupt line. I cannot see the code to disable
the interrupt line again.
now I am wondering:
- if we don't have to disable the interrupt line (once it is enabled),
why can't we enable all of these interrupts at initialization time
(instead of doing it on-demand)?
- if the interrupts do have to be disabled again (that is what I
assumed so far) then where is this supposed to happen? (my solution
for this was to implement a simple interrupt controller within the
PCIe driver which only supports enable/disable. disclaimer: I didn't
ask the PCI or interrupt maintainers for feedback on this yet)

[...]
> >> +static void intel_pcie_bridge_class_code_setup(struct intel_pcie_port *lpp)
> >> +{
> >> +    pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN,
> >> +                        PCIE_MISC_CTRL_DBI_RO_WR_EN, PCIE_MISC_CTRL);
> >> +    pcie_rc_cfg_wr_mask(lpp, 0xffffff00, PCI_CLASS_BRIDGE_PCI << 16,
> >> +                        PCIE_CCRID);
> >> +    pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN, 0,
> >> +                        PCIE_MISC_CTRL);
> >> +}
> > in my own experiments I didn't need this - have you confirmed that it's
> > required? and if it is required: why is that?
> > if others are curious as well then maybe add the explanation as comment
> > to the driver
> >
> > [...]
>
> This is needed. In the old driver, we fixed this by fixup. The original
> comment as follows,
>
> /*
>   * The root complex has a hardwired class of PCI_CLASS_NETWORK_OTHER or
>   * PCI_CLASS_BRIDGE_HOST, when it is operating as a root complex this
>   * needs to be switched to * PCI_CLASS_BRIDGE_PCI
>   */
that would be a good comment to add if you really need it
can you please look at dw_pcie_setup_rc (from pcie-designware-host.c), it does:
  /* Enable write permission for the DBI read-only register */
  dw_pcie_dbi_ro_wr_en(pci);
  /* Program correct class for RC */
  dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
  /* Better disable write permission right after the update */
  dw_pcie_dbi_ro_wr_dis(pci);

so my understanding is that there is a functional requirement to set
the class to PCI_CLASS_BRIDGE_PCI
however, that requirement is already covered by pcie-designware-host.c

> >> +static const char *pcie_link_gen_to_str(int gen)
> >> +{
> >> +    switch (gen) {
> >> +    case PCIE_LINK_SPEED_GEN1:
> >> +            return "2.5";
> >> +    case PCIE_LINK_SPEED_GEN2:
> >> +            return "5.0";
> >> +    case PCIE_LINK_SPEED_GEN3:
> >> +            return "8.0";
> >> +    case PCIE_LINK_SPEED_GEN4:
> >> +            return "16.0";
> >> +    default:
> >> +            return "???";
> >> +    }
> >> +}
> > why duplicate PCIE_SPEED2STR from drivers/pci/pci.h?
>
> Great! even link_device_setup can be reduced since pcie_get_speed_cap is
> implementing similar stuff.
removing code is always great, I'm glad that this helped!

> >
> >> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
> >> +{
> >> +    struct device *dev = lpp->pci->dev;
> >> +    int ret = 0;
> >> +
> >> +    lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >> +    if (IS_ERR(lpp->reset_gpio)) {
> >> +            ret = PTR_ERR(lpp->reset_gpio);
> >> +            if (ret != -EPROBE_DEFER)
> >> +                    dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
> >> +            return ret;
> >> +    }
> >> +    /* Make initial reset last for 100ms */
> >> +    msleep(100);
> > why is there lpp->rst_interval when you hardcode 100ms here?
>
> There are different purpose. rst_interval is purely for asserted reset
> pulse.
>
> Here 100ms is to make sure the initial state keeps at least 100ms, then we
> can reset.
my interpretation is that it totally depends on the board design or
the bootloader setup.

on a board where the bootloader initializes the GPIO to logical "0"
the devm_gpiod_get() call will not change the GPIO output.
in this case a 100ms delay may be OK (based on your description)

however, if the GPIO was a logical "1" (for example if the bootloader
set it to that value - and considering the GPIOD_OUT_LOW flag) then it
will be set to "0" with the devm_gpiod_get() call above.
now there is a transition from "deasserted" to "asserted" which does
not honor lpp->rst_interval

I'm not sure if this is a problem or not - all I know is that I don't
fully understand the problem yet

> >
> > [...]
> >> +static int intel_pcie_setup_irq(struct intel_pcie_port *lpp)
> >> +{
> >> +    struct device *dev = lpp->pci->dev;
> >> +    struct platform_device *pdev;
> >> +    char *irq_name;
> >> +    int irq, ret;
> >> +
> >> +    pdev = to_platform_device(dev);
> >> +    irq = platform_get_irq(pdev, 0);
> >> +    if (irq < 0) {
> >> +            dev_err(dev, "missing sys integrated irq resource\n");
> >> +            return irq;
> >> +    }
> >> +
> >> +    irq_name = devm_kasprintf(dev, GFP_KERNEL, "pcie_misc%d", lpp->id);
> >> +    if (!irq_name) {
> >> +            dev_err(dev, "failed to alloc irq name\n");
> >> +            return -ENOMEM;
> > you are only requesting one IRQ line for the whole driver. personally
> > I would drop the custom irq_name and pass NULL to devm_request_irq
> > because that will then fall-back to auto-generating an IRQ name based
> > on the devicetree node. I assume it's the same for ACPI but I haven't
> > tried that yet.
>
> Not sure I understand what you mean.  As you know from the code, we have
> lpp->id which means
>
> we have multiple instances of Root Complex(1,2,3,4,8), so we need this
> for identification.
sorry, I was wrong with my original statement, the name cannot be NULL

I checked the other drivers (meson-gx-mmc and meson-saradc) I had in
mind and they use dev_name(&pdev->dev);
that will give a unique interrupt name (derived from the devicetree)
in /proc/interrupts, for example: c1108680.adc, d0070000.mmc,
d0072000.mmc, ...

[...]
> >> +static void intel_pcie_disable_clks(struct intel_pcie_port *lpp)
> >> +{
> >> +    clk_disable_unprepare(lpp->core_clk);
> >> +}
> >> +
> >> +static int intel_pcie_enable_clks(struct intel_pcie_port *lpp)
> >> +{
> >> +    int ret = clk_prepare_enable(lpp->core_clk);
> >> +
> >> +    if (ret)
> >> +            dev_err(lpp->pci->dev, "Core clock enable failed: %d\n", ret);
> >> +
> >> +    return ret;
> >> +}
> > you have some functions (using these two as an example) which are only
> > used once. they add some boilerplate and (in my opinion) make the code
> > harder to read.
>
> Yes. If we plan to support old MIPS SoC, we have a lot of clocks. The
> code is from old code. We can remove this wrapper for new SoC. Later we
> can add them back.
if multiple clocks are needed then I suggest using the bulk clock
operations (clk_bulk_data)
so I still think these functions should be dropped

[...]
> >> +static ssize_t
> >> +pcie_link_status_show(struct device *dev, struct device_attribute *attr,
> >> +                  char *buf)
> >> +{
> >> +    u32 reg, width, gen;
> >> +    struct intel_pcie_port *lpp;
> >> +
> >> +    lpp = dev_get_drvdata(dev);
> >> +
> >> +    reg = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
> >> +    width = FIELD_GET(PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH, reg);
> >> +    gen = FIELD_GET(PCIE_LCTLSTS_LINK_SPEED, reg);
> >> +    if (gen > lpp->max_speed)
> >> +            return -EINVAL;
> >> +
> >> +    return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
> >> +                   width, pcie_link_gen_to_str(gen));
> >> +}
> >> +static DEVICE_ATTR_RO(pcie_link_status);
> > "lspci -vv | grep LnkSta" already shows the link speed and width.
> > why do you need this?
>
> In most embedded package, lspci from busybox only showed deviceid and
> vendor id.
>
> They don't install lspci utilities.
I think the PCI maintainers should comment on this as I'm not sure
whether this is something that should be implemented driver-specific
(why not make it available for all drivers?)

[...]
> >> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
> >> +{
> >> +    pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
> >> +                        0, PCI_COMMAND);
> > I expect logic like this to be part of the PCI subsystem in Linux.
> > why is this needed?
> >
> > [...]
>
> bind/unbind case we use this. For extreme cases, we use unbind and bind
> to reset
> PCI instead of rebooting.
OK, but this does not seem Intel/Lantiq specific at all
why isn't this managed by either pcie-designware-host.c or the generic
PCI/PCIe subsystem in Linux?


Martin
