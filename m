Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBAF9DBE5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 05:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfH0DJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 23:09:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:39607 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfH0DJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Aug 2019 23:09:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 20:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="181569042"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2019 20:09:42 -0700
Received: from [10.226.39.5] (leichuan-mobl.gar.corp.intel.com [10.226.39.5])
        by linux.intel.com (Postfix) with ESMTP id 36BF1580444;
        Mon, 26 Aug 2019 20:09:40 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     eswara.kota@linux.intel.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, hch@infradead.org,
        jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, qi-ming.wu@intel.com
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
 <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com>
Date:   Tue, 27 Aug 2019 11:09:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Thanks for your feedback. Please check the comments below.

On 8/27/2019 5:15 AM, Martin Blumenstingl wrote:
> Hello,
>
> On Mon, Aug 26, 2019 at 5:31 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:
>> Hi Martin,
>>
>> Thanks for your valuable comments. I reply some of them as below.
> you're welcome
>
> [...]
>>>> +config PCIE_INTEL_AXI
>>>> +        bool "Intel AHB/AXI PCIe host controller support"
>>> I believe that this is mostly the same IP block as it's used in Lantiq
>>> (xDSL) VRX200 SoCs (with MIPS cores) which was introduced in 2010
>>> (before Intel acquired Lantiq).
>>> This is why I would have personally called the driver PCIE_LANTIQ
>> VRX200 SoC(internally called VR9) was the first PCIe SoC product which
>> was using synopsys
>>
>> controller v3.30a. It only supports PCIe Gen1.1/1.0. The phy is internal
>> phy from infineon.
> thank you for these details
> I wasn't aware that the PCIe PHY on these SoCs was developed by
> Infineon nor is the DWC version documented anywhere

VRX200/ARX300 PHY is internal value. There are a lot of hardcode which was

from hardware people. From XRX500, we switch to synopsis PHY. However, later

comboPHY is coming to the picture. Even though we have one same controller

with different versions, we most likely will have three different phy 
drivers.

> [...]
>>>> +#define PCIE_CCRID                          0x8
>>>> +
>>>> +#define PCIE_LCAP                           0x7C
>>>> +#define PCIE_LCAP_MAX_LINK_SPEED            GENMASK(3, 0)
>>>> +#define PCIE_LCAP_MAX_LENGTH_WIDTH          GENMASK(9, 4)
>>>> +
>>>> +/* Link Control and Status Register */
>>>> +#define PCIE_LCTLSTS                                0x80
>>>> +#define PCIE_LCTLSTS_ASPM_ENABLE            GENMASK(1, 0)
>>>> +#define PCIE_LCTLSTS_RCB128                 BIT(3)
>>>> +#define PCIE_LCTLSTS_LINK_DISABLE           BIT(4)
>>>> +#define PCIE_LCTLSTS_COM_CLK_CFG            BIT(6)
>>>> +#define PCIE_LCTLSTS_HW_AW_DIS                      BIT(9)
>>>> +#define PCIE_LCTLSTS_LINK_SPEED                     GENMASK(19, 16)
>>>> +#define PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH  GENMASK(25, 20)
>>>> +#define PCIE_LCTLSTS_SLOT_CLK_CFG           BIT(28)
>>>> +
>>>> +#define PCIE_LCTLSTS2                               0xA0
>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED                GENMASK(3, 0)
>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_25GT   0x1
>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_5GT    0x2
>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_8GT    0x3
>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_16GT   0x4
>>>> +#define PCIE_LCTLSTS2_HW_AUTO_DIS           BIT(5)
>>>> +
>>>> +/* Ack Frequency Register */
>>>> +#define PCIE_AFR                            0x70C
>>>> +#define PCIE_AFR_FTS_NUM                    GENMASK(15, 8)
>>>> +#define PCIE_AFR_COM_FTS_NUM                        GENMASK(23, 16)
>>>> +#define PCIE_AFR_GEN12_FTS_NUM_DFT          (SZ_128 - 1)
>>>> +#define PCIE_AFR_GEN3_FTS_NUM_DFT           180
>>>> +#define PCIE_AFR_GEN4_FTS_NUM_DFT           196
>>>> +
>>>> +#define PCIE_PLCR_DLL_LINK_EN                       BIT(5)
>>>> +#define PCIE_PORT_LOGIC_FTS                 GENMASK(7, 0)
>>>> +#define PCIE_PORT_LOGIC_DFT_FTS_NUM         (SZ_128 - 1)
>>>> +
>>>> +#define PCIE_MISC_CTRL                              0x8BC
>>>> +#define PCIE_MISC_CTRL_DBI_RO_WR_EN         BIT(0)
>>>> +
>>>> +#define PCIE_MULTI_LANE_CTRL                        0x8C0
>>>> +#define PCIE_UPCONFIG_SUPPORT                       BIT(7)
>>>> +#define PCIE_DIRECT_LINK_WIDTH_CHANGE               BIT(6)
>>>> +#define PCIE_TARGET_LINK_WIDTH                      GENMASK(5, 0)
>>>> +
>>>> +#define PCIE_IOP_CTRL                               0x8C4
>>>> +#define PCIE_IOP_RX_STANDBY_CTRL            GENMASK(6, 0)
>> no need for IOP
> with "are you sure that you need any of the registers above?" I really
> meant all registers above (including, but not limited to IOP)
>
> [...]
>> As I mentioned, VRX200 was a very old PCIe Gen1.1 product. In our latest
>> SoC Lightning
>>
>> Mountain, we are using synopsys controller 5.20/5.50a. We support
>> Gen2(XRX350/550),
>>
>> Gen3(PRX300) and GEN4(X86 based SoC). We also supported dual lane and
>> single lane.
>>
>> Some of the above registers are needed to control FTS, link width and
>> link speed.
> only now I noticed that I didn't explain why I was asking whether all
> these registers are needed
> my understanding of the DWC PCIe controller driver "library" is that:
> - all functionality which is provided by the DesignWare PCIe core
> should be added to drivers/pci/controller/dwc/pcie-designware*
> - functionality which is built on top/around the DWC PCIe core should
> be added to <vendor specific driver>
>
> the link width and link speed settings (I don't know about "FTS")
> don't seem Intel/Lantiq controller specific to me
> so the register setup for these bits should be moved to
> drivers/pci/controller/dwc/pcie-designware*

FTS means fast training sequence. Different generations will have

different FTS. Common DWC drivers have default number for all generations

which are not optimized.

DWC driver handles link speed and link width during the initialization.

Then left link speed change and link width to device (EP) according to

PCIe spec. Not sure if other vendors or customers have this kind of

requirement. We implemented this due to customer's requirement.

We can check with DWC maintainer about this.

>
>>> this also makes me wonder if various functions below like
>>> intel_pcie_link_setup() and intel_pcie_max_speed_setup() (and probably
>>> more) are really needed or if it's just cargo cult / copy paste from
>>> an out-of-tree driver).
>> intel_pcie_link_setup is to record maximum speed and and link width. We need these
>> to change speed and link width on the fly which is not supported by dwc driver common
>> source.
>> There are two major purposes.
>> 1. For cable applications, they have battery support mode. In this case, it has to
>> switch from x2 and gen4 to x1 and gen1 on the fly
>> 2. Some customers have high EMI issues. They can try to switch to lower speed and
>> lower link width to check on the fly. Otherwise, they have to change the device tree
>> and reboot the system.
> based on your description I imagine that this may be a "common
> problem" (for example: Nvidia Tegra SoCs are also used in portable -
> as in battery powered - applications)
> I don't know enough about the Linux PCIe subsystem to comment on this,
> so I'm hoping that one of the PCIe subsystem maintainers can comment
> whether this is logic that should be implemented on a per-controller
> basis or whether there should be some generic implementation
>
> [...]

I guess PCIe maintainer will not consider this. From the spec,

link speed change and link width change is initiated by device(EP)

instead of RC.

>>>> +static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
>>>> +{
>>>> +    return readl(lpp->app_base + ofs);
>>>> +}
>>>> +
>>>> +static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
>>>> +{
>>>> +    writel(val, lpp->app_base + ofs);
>>>> +}
>>>> +
>>>> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
>>>> +                         u32 mask, u32 val, u32 ofs)
>>>> +{
>>>> +    pcie_update_bits(lpp->app_base, mask, val, ofs);
>>>> +}
>>> do you have plans to support the MIPS SoCs (VRX200, ARX300, XRX350,
>>> XRX550)?
>>> These will need register writes in big endian. in my own experiment [0]
>>> I simply used the regmap interface which will default to little endian
>>> register access but switch to big endian when the devicetree node is
>>> marked with big-endian.
>>>
>>> [...]
>> We can support up to XRX350/XRX500/PRX300 for MIPS SoC since we still
>> sell these products.
> OK, I understand this.
> switching to regmap will give you two benefits:
> - big endian registers writes (without additional code) on the MIPS SoCs
> - you can drop the pcie_app_* helper functions and use
> regmap_{read,write,update_bits} instead

I am not sure if regmap_xxx can avoid endian issues. For MIPS, the behavior

also depends on CONFIG_SWAP_IO option. Anyway, we can switch to regmap

easily.

>
>> [...] However, we have no effort to support EOL product
>> such as VRX200 which also makes driver quite complex since the glue
>> logic(reset, clock and endianness). For MIPS based platform, we have
>> endianness control in device tree such as inbound_swap and outbound_swap
>>
>> For VRX200, we have another big concern, that is PCI and PCIe has coupling
>> for endiannes which makes things very bad.
>>
>> However, if you are interested in supporting VRX200, it is highly
>> appreciated.
> thank you for the endianness control description and your concerns
> about the implementation on VRX200
>
> with my experiment I didn't have any problems with reset lines, clocks
> or endianness (at least I believe so)
> let's focus on the newer SoCs first, support for more SoCs can be a second step
>
>>>> +static int intel_pcie_bios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>>>> +{
>>>> +
>>>> +    struct pcie_port *pp = dev->bus->sysdata;
>>>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +    struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
>>>> +    struct device *pdev = lpp->pci->dev;
>>>> +    u32 irq_bit;
>>>> +    int irq;
>>>> +
>>>> +    if (pin == PCI_INTERRUPT_UNKNOWN || pin > PCI_NUM_INTX) {
>>>> +            dev_warn(pdev, "WARNING: dev %s: invalid interrupt pin %d\n",
>>>> +                     pci_name(dev), pin);
>>>> +            return -1;
>>>> +    }
>>>> +    irq = of_irq_parse_and_map_pci(dev, slot, pin);
>>>> +    if (!irq) {
>>>> +            dev_err(pdev, "trying to map irq for unknown slot:%d pin:%d\n",
>>>> +                    slot, pin);
>>>> +            return -1;
>>>> +    }
>>>> +    /* Pin to irq offset bit position */
>>>> +    irq_bit = BIT(pin + PCIE_INTX_OFFSET);
>>>> +
>>>> +    /* Clear possible pending interrupts first */
>>>> +    pcie_app_wr(lpp, irq_bit, PCIE_IRNCR);
>>>> +
>>>> +    pcie_app_wr_mask(lpp, irq_bit, irq_bit, PCIE_IRNEN);
>>>> +    return irq;
>>>> +}
>>> my interpretation is that there's an interrupt controller embedded into
>>> the APP registers. The integrated interrupt controller takes 5
>>> interrupts and provides the legacy PCI_INTA/B/C/D interrupts as well as
>>> a WAKEUP IRQ. Each of it's own interrupts is tied to one of the parent
>>> interrupts.
>> For MIPS base SoC, there is no interrupt controller for such APP registers.
> let me try to describe the IRNCR register with my own words:
>
> a) it contains various interrupts for the controller itself (for
> example: HOTPLUG, RX fatal error, RX non fatal error, ...)
> these interrupts arrive at the controllers interrupt line (requested
> below using devm_request_irq).
> all of these interrupts are enabled when initializing the controller
> as they are valid regardless of which PCI interrupt type (MSI, legacy
> A/B/C/D) is used
>
> b) it contains bits to enable/disable the legacy PCI INTA/B/C/D interrupts
> these interrupts arrive at a dedicated interrupt line each.
> each individual interrupt has an enable bit in the IRNCR register and
> should only be enabled when when it's actually needed
>
> c) it contains a PCI WAKE interrupt
> it arrives at a dedicated interrupt line
> I don't know when it should be enabled or not (I don't even know if
> this interrupt is important at all)
>
> let's focus on case a) and b) because I don't know if case c) is
> relevant at all:
> case a) is implemented in the IRQ setup, this matches my expectation
>
> case b) is implemented in the map_irq callback. however, that only
> covers "enabling" the interrupt line. I cannot see the code to disable
> the interrupt line again.

You are right. We don't have disable the interrupt line for A/B/C/D.

For PCI intx A/B/C/D, SoC only need to enable it (level trigger interrupt),

To clear the interrupt, we have to clear the source. Actually, all INCR

interrupts are level-triggered interrupts.

> now I am wondering:
> - if we don't have to disable the interrupt line (once it is enabled),
> why can't we enable all of these interrupts at initialization time
> (instead of doing it on-demand)?
Good point! we even can remote map_irq patch, directly call

of_irq_parse_and_map_pci as other drivers do.

> - if the interrupts do have to be disabled again (that is what I
> assumed so far) then where is this supposed to happen? (my solution
> for this was to implement a simple interrupt controller within the
> PCIe driver which only supports enable/disable. disclaimer: I didn't
> ask the PCI or interrupt maintainers for feedback on this yet)
>
> [...]

We can implement one interrupt controller, but personally, it has too

much overhead. If we follow this way, almost all modules of all old

lantiq SoCs can implement one interrupt controller. Maybe you can check

with PCI maintainer for their comments.

>>>> +static void intel_pcie_bridge_class_code_setup(struct intel_pcie_port *lpp)
>>>> +{
>>>> +    pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN,
>>>> +                        PCIE_MISC_CTRL_DBI_RO_WR_EN, PCIE_MISC_CTRL);
>>>> +    pcie_rc_cfg_wr_mask(lpp, 0xffffff00, PCI_CLASS_BRIDGE_PCI << 16,
>>>> +                        PCIE_CCRID);
>>>> +    pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN, 0,
>>>> +                        PCIE_MISC_CTRL);
>>>> +}
>>> in my own experiments I didn't need this - have you confirmed that it's
>>> required? and if it is required: why is that?
>>> if others are curious as well then maybe add the explanation as comment
>>> to the driver
>>>
>>> [...]
>> This is needed. In the old driver, we fixed this by fixup. The original
>> comment as follows,
>>
>> /*
>>    * The root complex has a hardwired class of PCI_CLASS_NETWORK_OTHER or
>>    * PCI_CLASS_BRIDGE_HOST, when it is operating as a root complex this
>>    * needs to be switched to * PCI_CLASS_BRIDGE_PCI
>>    */
> that would be a good comment to add if you really need it
> can you please look at dw_pcie_setup_rc (from pcie-designware-host.c), it does:
>    /* Enable write permission for the DBI read-only register */
>    dw_pcie_dbi_ro_wr_en(pci);
>    /* Program correct class for RC */
>    dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>    /* Better disable write permission right after the update */
>    dw_pcie_dbi_ro_wr_dis(pci);
>
> so my understanding is that there is a functional requirement to set
> the class to PCI_CLASS_BRIDGE_PCI
> however, that requirement is already covered by pcie-designware-host.c
I will task Dilip to check if we can use dwc one.
>>>> +static const char *pcie_link_gen_to_str(int gen)
>>>> +{
>>>> +    switch (gen) {
>>>> +    case PCIE_LINK_SPEED_GEN1:
>>>> +            return "2.5";
>>>> +    case PCIE_LINK_SPEED_GEN2:
>>>> +            return "5.0";
>>>> +    case PCIE_LINK_SPEED_GEN3:
>>>> +            return "8.0";
>>>> +    case PCIE_LINK_SPEED_GEN4:
>>>> +            return "16.0";
>>>> +    default:
>>>> +            return "???";
>>>> +    }
>>>> +}
>>> why duplicate PCIE_SPEED2STR from drivers/pci/pci.h?
>> Great! even link_device_setup can be reduced since pcie_get_speed_cap is
>> implementing similar stuff.
> removing code is always great, I'm glad that this helped!
>
>>>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>>>> +{
>>>> +    struct device *dev = lpp->pci->dev;
>>>> +    int ret = 0;
>>>> +
>>>> +    lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>>>> +    if (IS_ERR(lpp->reset_gpio)) {
>>>> +            ret = PTR_ERR(lpp->reset_gpio);
>>>> +            if (ret != -EPROBE_DEFER)
>>>> +                    dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
>>>> +            return ret;
>>>> +    }
>>>> +    /* Make initial reset last for 100ms */
>>>> +    msleep(100);
>>> why is there lpp->rst_interval when you hardcode 100ms here?
>> There are different purpose. rst_interval is purely for asserted reset
>> pulse.
>>
>> Here 100ms is to make sure the initial state keeps at least 100ms, then we
>> can reset.
> my interpretation is that it totally depends on the board design or
> the bootloader setup.

Partially, you are right. However, we should not add some dependency 
here from

bootloader and board. rst_interval is just to make sure the pulse (low 
active or high active)

lasts the specified the time.

> on a board where the bootloader initializes the GPIO to logical "0"
> the devm_gpiod_get() call will not change the GPIO output.
> in this case a 100ms delay may be OK (based on your description)
>
> however, if the GPIO was a logical "1" (for example if the bootloader
> set it to that value - and considering the GPIOD_OUT_LOW flag) then it
> will be set to "0" with the devm_gpiod_get() call above.
> now there is a transition from "deasserted" to "asserted" which does
> not honor lpp->rst_interval
>
> I'm not sure if this is a problem or not - all I know is that I don't
> fully understand the problem yet
>>> [...]
>>>> +static int intel_pcie_setup_irq(struct intel_pcie_port *lpp)
>>>> +{
>>>> +    struct device *dev = lpp->pci->dev;
>>>> +    struct platform_device *pdev;
>>>> +    char *irq_name;
>>>> +    int irq, ret;
>>>> +
>>>> +    pdev = to_platform_device(dev);
>>>> +    irq = platform_get_irq(pdev, 0);
>>>> +    if (irq < 0) {
>>>> +            dev_err(dev, "missing sys integrated irq resource\n");
>>>> +            return irq;
>>>> +    }
>>>> +
>>>> +    irq_name = devm_kasprintf(dev, GFP_KERNEL, "pcie_misc%d", lpp->id);
>>>> +    if (!irq_name) {
>>>> +            dev_err(dev, "failed to alloc irq name\n");
>>>> +            return -ENOMEM;
>>> you are only requesting one IRQ line for the whole driver. personally
>>> I would drop the custom irq_name and pass NULL to devm_request_irq
>>> because that will then fall-back to auto-generating an IRQ name based
>>> on the devicetree node. I assume it's the same for ACPI but I haven't
>>> tried that yet.
>> Not sure I understand what you mean.  As you know from the code, we have
>> lpp->id which means
>>
>> we have multiple instances of Root Complex(1,2,3,4,8), so we need this
>> for identification.
> sorry, I was wrong with my original statement, the name cannot be NULL
>
> I checked the other drivers (meson-gx-mmc and meson-saradc) I had in
> mind and they use dev_name(&pdev->dev);
> that will give a unique interrupt name (derived from the devicetree)
> in /proc/interrupts, for example: c1108680.adc, d0070000.mmc,
> d0072000.mmc, ...
>
> [...]

Right. We also use dev_name in our code. However, some people like numbering

the interface which is easier for them to remember and discuss. I link id to

domain so that we can easily know what is wrong once we have issues. When we

tell the address to hardware people and support staff, they are totally 
lost.

Again, it is ok to switch to dev_name.

>>>> +static void intel_pcie_disable_clks(struct intel_pcie_port *lpp)
>>>> +{
>>>> +    clk_disable_unprepare(lpp->core_clk);
>>>> +}
>>>> +
>>>> +static int intel_pcie_enable_clks(struct intel_pcie_port *lpp)
>>>> +{
>>>> +    int ret = clk_prepare_enable(lpp->core_clk);
>>>> +
>>>> +    if (ret)
>>>> +            dev_err(lpp->pci->dev, "Core clock enable failed: %d\n", ret);
>>>> +
>>>> +    return ret;
>>>> +}
>>> you have some functions (using these two as an example) which are only
>>> used once. they add some boilerplate and (in my opinion) make the code
>>> harder to read.
>> Yes. If we plan to support old MIPS SoC, we have a lot of clocks. The
>> code is from old code. We can remove this wrapper for new SoC. Later we
>> can add them back.
> if multiple clocks are needed then I suggest using the bulk clock
> operations (clk_bulk_data)
> so I still think these functions should be dropped
>
> [...]

It is ok to remove and if necessary, we can add it back for old SoC or use

clk_bulk_data.

>>>> +static ssize_t
>>>> +pcie_link_status_show(struct device *dev, struct device_attribute *attr,
>>>> +                  char *buf)
>>>> +{
>>>> +    u32 reg, width, gen;
>>>> +    struct intel_pcie_port *lpp;
>>>> +
>>>> +    lpp = dev_get_drvdata(dev);
>>>> +
>>>> +    reg = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
>>>> +    width = FIELD_GET(PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH, reg);
>>>> +    gen = FIELD_GET(PCIE_LCTLSTS_LINK_SPEED, reg);
>>>> +    if (gen > lpp->max_speed)
>>>> +            return -EINVAL;
>>>> +
>>>> +    return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
>>>> +                   width, pcie_link_gen_to_str(gen));
>>>> +}
>>>> +static DEVICE_ATTR_RO(pcie_link_status);
>>> "lspci -vv | grep LnkSta" already shows the link speed and width.
>>> why do you need this?
>> In most embedded package, lspci from busybox only showed deviceid and
>> vendor id.
>>
>> They don't install lspci utilities.
> I think the PCI maintainers should comment on this as I'm not sure
> whether this is something that should be implemented driver-specific
> (why not make it available for all drivers?)
>
> [...]
I can't comment on this:)
>>>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>>>> +{
>>>> +    pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
>>>> +                        0, PCI_COMMAND);
>>> I expect logic like this to be part of the PCI subsystem in Linux.
>>> why is this needed?
>>>
>>> [...]
>> bind/unbind case we use this. For extreme cases, we use unbind and bind
>> to reset
>> PCI instead of rebooting.
> OK, but this does not seem Intel/Lantiq specific at all
> why isn't this managed by either pcie-designware-host.c or the generic
> PCI/PCIe subsystem in Linux?

I doubt if other RC driver will support bind/unbind. We do have this 
requirement

due to power management from WiFi devices.

>
>
> Martin
