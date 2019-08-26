Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA5D9C7F4
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 05:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfHZDbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Aug 2019 23:31:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:43629 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfHZDbE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Aug 2019 23:31:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 20:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="204421370"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2019 20:31:03 -0700
Received: from [10.226.39.5] (leichuan-mobl.gar.corp.intel.com [10.226.39.5])
        by linux.intel.com (Postfix) with ESMTP id E128B5807C5;
        Sun, 25 Aug 2019 20:30:59 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        eswara.kota@linux.intel.com
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        hch@infradead.org, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        qi-ming.wu@intel.com
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
Date:   Mon, 26 Aug 2019 11:30:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Thanks for your valuable comments. I reply some of them as below.

Regards,

Chuanhua

On 8/25/2019 5:03 AM, Martin Blumenstingl wrote:
> Hi Dilip,
>
> first of all: thank you for submitting this upstream!
> I hope that we can use this driver to replace the out-of-tree PCIe
> driver that's used in OpenWrt for the Lantiq VRX200 SoCs.
>
> a small disclaimer: I don't have access to any Lantiq, Intel or
> DesignWare datasheets. so everything I write below is based on my own
> understanding of the Tegra public datasheet (which describes the
> DesignWare PCIe registers) as well as the public Lantiq UGW code drops
> with out-of-tree drivers for an older version of this PCIe IP.
> thus some of my statements below may be wrong - in this case I would
> appreciate an explanation of how the hardware really works.
>
> please keep me CC'ed on further revisions of this series. I am highly
> interested in making this driver work on the Lantiq VRX200 SoCs once
> the initial version has landed in linux-next.
>
>> +config PCIE_INTEL_AXI
>> +        bool "Intel AHB/AXI PCIe host controller support"
> I believe that this is mostly the same IP block as it's used in Lantiq
> (xDSL) VRX200 SoCs (with MIPS cores) which was introduced in 2010
> (before Intel acquired Lantiq).
> This is why I would have personally called the driver PCIE_LANTIQ

VRX200 SoC(internally called VR9) was the first PCIe SoC product which 
was using synopsys

controller v3.30a. It only supports PCIe Gen1.1/1.0. The phy is internal 
phy from infineon.

After that, we have other PCe 1.1/10. products such as ARX300/390.  
However, these products are EOL,

that is why we don't put effort to support VRX200/ARX300/390.

PCIE_LANTIQ was also a name used internally in the product as in 
linux-3.10.x.


>
> [...]
>> +#define PCIE_CCRID				0x8
>> +
>> +#define PCIE_LCAP				0x7C
>> +#define PCIE_LCAP_MAX_LINK_SPEED		GENMASK(3, 0)
>> +#define PCIE_LCAP_MAX_LENGTH_WIDTH		GENMASK(9, 4)
>> +
>> +/* Link Control and Status Register */
>> +#define PCIE_LCTLSTS				0x80
>> +#define PCIE_LCTLSTS_ASPM_ENABLE		GENMASK(1, 0)
>> +#define PCIE_LCTLSTS_RCB128			BIT(3)
>> +#define PCIE_LCTLSTS_LINK_DISABLE		BIT(4)
>> +#define PCIE_LCTLSTS_COM_CLK_CFG		BIT(6)
>> +#define PCIE_LCTLSTS_HW_AW_DIS			BIT(9)
>> +#define PCIE_LCTLSTS_LINK_SPEED			GENMASK(19, 16)
>> +#define PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH	GENMASK(25, 20)
>> +#define PCIE_LCTLSTS_SLOT_CLK_CFG		BIT(28)
>> +
>> +#define PCIE_LCTLSTS2				0xA0
>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED		GENMASK(3, 0)
>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_25GT	0x1
>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_5GT	0x2
>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_8GT	0x3
>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_16GT	0x4
>> +#define PCIE_LCTLSTS2_HW_AUTO_DIS		BIT(5)
>> +
>> +/* Ack Frequency Register */
>> +#define PCIE_AFR				0x70C
>> +#define PCIE_AFR_FTS_NUM			GENMASK(15, 8)
>> +#define PCIE_AFR_COM_FTS_NUM			GENMASK(23, 16)
>> +#define PCIE_AFR_GEN12_FTS_NUM_DFT		(SZ_128 - 1)
>> +#define PCIE_AFR_GEN3_FTS_NUM_DFT		180
>> +#define PCIE_AFR_GEN4_FTS_NUM_DFT		196
>> +
>> +#define PCIE_PLCR_DLL_LINK_EN			BIT(5)
>> +#define PCIE_PORT_LOGIC_FTS			GENMASK(7, 0)
>> +#define PCIE_PORT_LOGIC_DFT_FTS_NUM		(SZ_128 - 1)
>> +
>> +#define PCIE_MISC_CTRL				0x8BC
>> +#define PCIE_MISC_CTRL_DBI_RO_WR_EN		BIT(0)
>> +
>> +#define PCIE_MULTI_LANE_CTRL			0x8C0
>> +#define PCIE_UPCONFIG_SUPPORT			BIT(7)
>> +#define PCIE_DIRECT_LINK_WIDTH_CHANGE		BIT(6)
>> +#define PCIE_TARGET_LINK_WIDTH			GENMASK(5, 0)
>> +
>> +#define PCIE_IOP_CTRL				0x8C4
>> +#define PCIE_IOP_RX_STANDBY_CTRL		GENMASK(6, 0)
no need for IOP
> are you sure that you need any of the registers above?
> as far as I can tell most (all?) of them are part of the DesignWare
> register set. why doesn't pcie-designware-host initialize these?
> I don't have any datasheet or register documentation for the DesignWare
> PCIe core. In my own experiment from a month ago on the Lantiq VRX200
> SoC I didn't need any of this: [0]

As I mentioned, VRX200 was a very old PCIe Gen1.1 product. In our latest 
SoC Lightning

Mountain, we are using synopsys controller 5.20/5.50a. We support 
Gen2(XRX350/550),

Gen3(PRX300) and GEN4(X86 based SoC). We also supported dual lane and 
single lane.

Some of the above registers are needed to control FTS, link width and 
link speed.

>
> this also makes me wonder if various functions below like
> intel_pcie_link_setup() and intel_pcie_max_speed_setup() (and probably
> more) are really needed or if it's just cargo cult / copy paste from
> an out-of-tree driver).

intel_pcie_link_setup is to record maximum speed and and link width. We need these
to change speed and link width on the fly which is not supported by dwc driver common
source.
There are two major purposes.
1. For cable applications, they have battery support mode. In this case, it has to
switch from x2 and gen4 to x1 and gen1 on the fly
2. Some customers have high EMI issues. They can try to switch to lower speed and
lower link width to check on the fly. Otherwise, they have to change the device tree
and reboot the system.

>
>> +/* APP RC Core Control Register */
>> +#define PCIE_RC_CCR				0x10
>> +#define PCIE_RC_CCR_LTSSM_ENABLE		BIT(0)
>> +#define PCIE_DEVICE_TYPE			GENMASK(7, 4)
>> +#define PCIE_RC_CCR_RC_MODE			BIT(2)
>> +
>> +/* PCIe Message Control */
>> +#define PCIE_MSG_CR				0x30
>> +#define PCIE_XMT_PM_TURNOFF			BIT(0)
>> +
>> +/* PCIe Power Management Control */
>> +#define PCIE_PMC				0x44
>> +#define PCIE_PM_IN_L2				BIT(20)
>> +
>> +/* Interrupt Enable Register */
>> +#define PCIE_IRNEN				0xF4
>> +#define PCIE_IRNCR				0xF8
>> +#define PCIE_IRN_AER_REPORT			BIT(0)
>> +#define PCIE_IRN_PME				BIT(2)
>> +#define PCIE_IRN_HOTPLUG			BIT(3)
>> +#define PCIE_IRN_RX_VDM_MSG			BIT(4)
>> +#define PCIE_IRN_PM_TO_ACK			BIT(9)
>> +#define PCIE_IRN_PM_TURNOFF_ACK			BIT(10)
>> +#define PCIE_IRN_LINK_AUTO_BW_STATUS		BIT(11)
>> +#define PCIE_IRN_BW_MGT				BIT(12)
>> +#define PCIE_IRN_WAKEUP				BIT(17)
>> +#define PCIE_IRN_MSG_LTR			BIT(18)
>> +#define PCIE_IRN_SYS_INT			BIT(28)
>> +#define PCIE_IRN_SYS_ERR_RC			BIT(29)
>> +
>> +#define PCIE_IRN_IR_INT	(PCIE_IRN_AER_REPORT | PCIE_IRN_PME | \
>> +			PCIE_IRN_RX_VDM_MSG | PCIE_IRN_SYS_ERR_RC | \
>> +			PCIE_IRN_PM_TO_ACK | PCIE_IRN_LINK_AUTO_BW_STATUS | \
>> +			PCIE_IRN_BW_MGT | PCIE_IRN_MSG_LTR)
> I would rename all of the APP register #defines to match the pattern
> PCIE_APP_*
> That makes it easy to differentiate the PCIe (DBI) registers from the
> APP registers.
>
> [...]
Agree.
>> +static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
>> +{
>> +	return readl(lpp->app_base + ofs);
>> +}
>> +
>> +static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
>> +{
>> +	writel(val, lpp->app_base + ofs);
>> +}
>> +
>> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
>> +			     u32 mask, u32 val, u32 ofs)
>> +{
>> +	pcie_update_bits(lpp->app_base, mask, val, ofs);
>> +}
> do you have plans to support the MIPS SoCs (VRX200, ARX300, XRX350,
> XRX550)?
> These will need register writes in big endian. in my own experiment [0]
> I simply used the regmap interface which will default to little endian
> register access but switch to big endian when the devicetree node is
> marked with big-endian.
>
> [...]

We can support up to XRX350/XRX500/PRX300 for MIPS SoC since we still

sell these products. However, we have no effort to support EOL product

such as VRX200 which also makes driver quite complex since the glue

logic(reset, clock and endianness). For MIPS based platform, we have

endianness control in device tree such as inbound_swap and outbound_swap

For VRX200, we have another big concern, that is PCI and PCIe has coupling

for endiannes which makes things very bad.

However, if you are interested in supporting VRX200, it is highly 
appreciated.

>> +static int intel_pcie_bios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>> +{
>> +
>> +	struct pcie_port *pp = dev->bus->sysdata;
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
>> +	struct device *pdev = lpp->pci->dev;
>> +	u32 irq_bit;
>> +	int irq;
>> +
>> +	if (pin == PCI_INTERRUPT_UNKNOWN || pin > PCI_NUM_INTX) {
>> +		dev_warn(pdev, "WARNING: dev %s: invalid interrupt pin %d\n",
>> +			 pci_name(dev), pin);
>> +		return -1;
>> +	}
>> +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
>> +	if (!irq) {
>> +		dev_err(pdev, "trying to map irq for unknown slot:%d pin:%d\n",
>> +			slot, pin);
>> +		return -1;
>> +	}
>> +	/* Pin to irq offset bit position */
>> +	irq_bit = BIT(pin + PCIE_INTX_OFFSET);
>> +
>> +	/* Clear possible pending interrupts first */
>> +	pcie_app_wr(lpp, irq_bit, PCIE_IRNCR);
>> +
>> +	pcie_app_wr_mask(lpp, irq_bit, irq_bit, PCIE_IRNEN);
>> +	return irq;
>> +}
> my interpretation is that there's an interrupt controller embedded into
> the APP registers. The integrated interrupt controller takes 5
> interrupts and provides the legacy PCI_INTA/B/C/D interrupts as well as
> a WAKEUP IRQ. Each of it's own interrupts is tied to one of the parent
> interrupts.

For MIPS base SoC, there is no interrupt controller for such APP registers.

They are directly connected with centralized PIC(ICU for VRX200/ARX300, GIC

for XRX500/PRX300, IOAPIC for lightning mountain).That is why we don't

implement the interrupt controller here.

>
> my solution (in the experiment on the VRX200 SoC [1]) was to implement an
> interrupt controller and have it as a child devicetree node. then I used
> interrupt-map to route the interrupts to the PCIe interrupt controller.
> with that I didn't have to overwrite .map_irq.
>
> (note that this comment is only related to the PCI_INTx and WAKE
> interrupts but not the other interrupt configuration bits, because as
> far as I understand the other ones are only related to the controller)
>
>> +static void intel_pcie_bridge_class_code_setup(struct intel_pcie_port *lpp)
>> +{
>> +	pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN,
>> +			    PCIE_MISC_CTRL_DBI_RO_WR_EN, PCIE_MISC_CTRL);
>> +	pcie_rc_cfg_wr_mask(lpp, 0xffffff00, PCI_CLASS_BRIDGE_PCI << 16,
>> +			    PCIE_CCRID);
>> +	pcie_rc_cfg_wr_mask(lpp, PCIE_MISC_CTRL_DBI_RO_WR_EN, 0,
>> +			    PCIE_MISC_CTRL);
>> +}
> in my own experiments I didn't need this - have you confirmed that it's
> required? and if it is required: why is that?
> if others are curious as well then maybe add the explanation as comment
> to the driver
>
> [...]

This is needed. In the old driver, we fixed this by fixup. The original 
comment as follows,

/*
  * The root complex has a hardwired class of PCI_CLASS_NETWORK_OTHER or
  * PCI_CLASS_BRIDGE_HOST, when it is operating as a root complex this
  * needs to be switched to * PCI_CLASS_BRIDGE_PCI
  */

>> +static const char *pcie_link_gen_to_str(int gen)
>> +{
>> +	switch (gen) {
>> +	case PCIE_LINK_SPEED_GEN1:
>> +		return "2.5";
>> +	case PCIE_LINK_SPEED_GEN2:
>> +		return "5.0";
>> +	case PCIE_LINK_SPEED_GEN3:
>> +		return "8.0";
>> +	case PCIE_LINK_SPEED_GEN4:
>> +		return "16.0";
>> +	default:
>> +		return "???";
>> +	}
>> +}
> why duplicate PCIE_SPEED2STR from drivers/pci/pci.h?

Great! even link_device_setup can be reduced since pcie_get_speed_cap is

implementing similar stuff.

>
>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>> +{
>> +	struct device *dev = lpp->pci->dev;
>> +	int ret = 0;
>> +
>> +	lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(lpp->reset_gpio)) {
>> +		ret = PTR_ERR(lpp->reset_gpio);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
>> +		return ret;
>> +	}
>> +	/* Make initial reset last for 100ms */
>> +	msleep(100);
> why is there lpp->rst_interval when you hardcode 100ms here?

There are different purpose. rst_interval is purely for asserted reset 
pulse.

Here 100ms is to make sure the initial state keeps at least 100ms, then we

can reset.

>
> [...]
>> +static int intel_pcie_setup_irq(struct intel_pcie_port *lpp)
>> +{
>> +	struct device *dev = lpp->pci->dev;
>> +	struct platform_device *pdev;
>> +	char *irq_name;
>> +	int irq, ret;
>> +
>> +	pdev = to_platform_device(dev);
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(dev, "missing sys integrated irq resource\n");
>> +		return irq;
>> +	}
>> +
>> +	irq_name = devm_kasprintf(dev, GFP_KERNEL, "pcie_misc%d", lpp->id);
>> +	if (!irq_name) {
>> +		dev_err(dev, "failed to alloc irq name\n");
>> +		return -ENOMEM;
> you are only requesting one IRQ line for the whole driver. personally
> I would drop the custom irq_name and pass NULL to devm_request_irq
> because that will then fall-back to auto-generating an IRQ name based
> on the devicetree node. I assume it's the same for ACPI but I haven't
> tried that yet.

Not sure I understand what you mean.  As you know from the code, we have 
lpp->id which means

we have multiple instances of Root Complex(1,2,3,4,8), so we need this 
for identification.

this irq in old product called ir(integrated interrupt or misc interrupt).

>
>> +static void intel_pcie_disable_clks(struct intel_pcie_port *lpp)
>> +{
>> +	clk_disable_unprepare(lpp->core_clk);
>> +}
>> +
>> +static int intel_pcie_enable_clks(struct intel_pcie_port *lpp)
>> +{
>> +	int ret = clk_prepare_enable(lpp->core_clk);
>> +
>> +	if (ret)
>> +		dev_err(lpp->pci->dev, "Core clock enable failed: %d\n", ret);
>> +
>> +	return ret;
>> +}
> you have some functions (using these two as an example) which are only
> used once. they add some boilerplate and (in my opinion) make the code
> harder to read.

Yes. If we plan to support old MIPS SoC, we have a lot of clocks. The

code is from old code. We can remove this wrapper for new SoC. Later we

can add them back.

>
>> +static int intel_pcie_get_resources(struct platform_device *pdev)
>> +{
>> +	struct intel_pcie_port *lpp;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	lpp = platform_get_drvdata(pdev);
>> +	dev = lpp->pci->dev;
>> +
>> +	lpp->core_clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(lpp->core_clk)) {
>> +		ret = PTR_ERR(lpp->core_clk);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get clks: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	lpp->core_rst = devm_reset_control_get(dev, NULL);
>> +	if (IS_ERR(lpp->core_rst)) {
>> +		ret = PTR_ERR(lpp->core_rst);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get resets: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = device_property_match_string(dev, "device_type", "pci");
>> +	if (ret) {
>> +		dev_err(dev, "failed to find pci device type: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (device_property_read_u32(dev, "intel,rst-interval",
>> +				     &lpp->rst_interval))
>> +		lpp->rst_interval = RST_INTRVL_DFT_MS;
>> +
>> +	if (device_property_read_u32(dev, "max-link-speed", &lpp->link_gen))
>> +		lpp->link_gen = 0; /* Fallback to auto */
>> +
>> +	lpp->app_base = devm_platform_ioremap_resource(pdev, 2);
> I suggest using platform_get_resource_byname(pdev, "app") because
> pcie-designware uses named resources for the "config" space already
>
> that said, devm_platform_ioremap_resource_byname would be a great
> addition in my opinion ;)
Agree.
>
>> +	if (IS_ERR(lpp->app_base))
>> +		return PTR_ERR(lpp->app_base);
>> +
>> +	ret = intel_pcie_ep_rst_init(lpp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	lpp->phy = devm_phy_get(dev, "phy");
> I suggest to use "pcie" as phy-name, otherwise the binding looks odd:
>    phys = <&pcie0_phy>;
>    phy-names = "phy";
> versus:
>    phys = <&pcie0_phy>;
>    phy-names = "pcie";
Agree.
>> +static ssize_t
>> +pcie_link_status_show(struct device *dev, struct device_attribute *attr,
>> +		      char *buf)
>> +{
>> +	u32 reg, width, gen;
>> +	struct intel_pcie_port *lpp;
>> +
>> +	lpp = dev_get_drvdata(dev);
>> +
>> +	reg = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
>> +	width = FIELD_GET(PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH, reg);
>> +	gen = FIELD_GET(PCIE_LCTLSTS_LINK_SPEED, reg);
>> +	if (gen > lpp->max_speed)
>> +		return -EINVAL;
>> +
>> +	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
>> +		       width, pcie_link_gen_to_str(gen));
>> +}
>> +static DEVICE_ATTR_RO(pcie_link_status);
> "lspci -vv | grep LnkSta" already shows the link speed and width.
> why do you need this?

In most embedded package, lspci from busybox only showed deviceid and 
vendor id.

They don't install lspci utilities.

>> +static ssize_t pcie_speed_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t len)
>> +{
>> +	struct intel_pcie_port *lpp;
>> +	unsigned long val;
>> +	int ret;
>> +
>> +	lpp = dev_get_drvdata(dev);
>> +
>> +	ret = kstrtoul(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val > lpp->max_speed)
>> +		return -EINVAL;
>> +
>> +	lpp->link_gen = val;
>> +	intel_pcie_max_speed_setup(lpp);
>> +	intel_pcie_speed_change_disable(lpp);
>> +	intel_pcie_speed_change_enable(lpp);
>> +
>> +	return len;
>> +}
>> +static DEVICE_ATTR_WO(pcie_speed);
> this is already configurable via devicetree, why do you need this?
On the fly change as I mentioned in the beginning.
>
>> +/*
>> + * Link width change on the fly is not always successful.
>> + * It also depends on the partner.
>> + */
>> +static ssize_t pcie_width_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t len)
>> +{
>> +	struct intel_pcie_port *lpp;
>> +	unsigned long val;
>> +
>> +	lpp = dev_get_drvdata(dev);
>> +
>> +	if (kstrtoul(buf, 10, &val))
>> +		return -EINVAL;
>> +
>> +	if (val > lpp->max_width)
>> +		return -EINVAL;
>> +
>> +	lpp->lanes = val;
>> +	intel_pcie_max_link_width_setup(lpp);
>> +
>> +	return len;
>> +}
>> +static DEVICE_ATTR_WO(pcie_width);
> is it needed because of a bug somewhere? who do you expect to use this
> sysfs attribute and when (which condition) do you expect people to use
> this?
>
> [...]
On the fly change as I mentioned in the beginning.
>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>> +{
>> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
>> +			    0, PCI_COMMAND);
> I expect logic like this to be part of the PCI subsystem in Linux.
> why is this needed?
>
> [...]

bind/unbind case we use this. For extreme cases, we use unbind and bind 
to reset

PCI instead of rebooting.

>> +int intel_pcie_msi_init(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +
>> +	dev_dbg(pci->dev, "MSI is handled in x86 arch\n");
> I would rephrase this to "MSI is handled by a separate MSI interrupt
> controller"
> on the VRX200 SoC there's also a MSI interrupt controller and it seems
> that "x86" has this as well (even though it might be two different MSI
> IRQ IP blocks).
>
> [...]

Agree. For X86/64, MSI is handled by X86 arch. We don't need to

implement another MSI controller separately.

For MIPS based SoC, we don't use synopsys MSI controller. The MSI still

connects with central interrupt controller with MSI decoding (we can name it

as MSI controller)

>> +static int intel_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	const struct intel_pcie_soc *data;
>> +	struct intel_pcie_port *lpp;
>> +	struct pcie_port *pp;
>> +	struct dw_pcie *pci;
>> +	int ret;
>> +
>> +	lpp = devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
>> +	if (!lpp)
>> +		return -ENOMEM;
>> +
>> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> +	if (!pci)
>> +		return -ENOMEM;
> other drivers have a "struct dw_pcie	pci" struct member (I assume
> that it's to prevent memory fragmentation). why not do the same here
> and embed it into struct intel_pcie_port?
Dilip should explain this
>
>> +	platform_set_drvdata(pdev, lpp);
>> +	lpp->pci = pci;
>> +	pci->dev = dev;
>> +	pp = &pci->pp;
>> +
>> +	ret = device_property_read_u32(dev, "linux,pci-domain", &lpp->id);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get domain id, errno %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pci->dbi_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pci->dbi_base))
>> +		return PTR_ERR(pci->dbi_base);
>> +
> as stated above I would use the _byname variant
Agree.
>
>
> Martin
>
>
> [0] https://github.com/xdarklight/linux/blob/lantiq-pcie-driver-next-20190727/drivers/pci/controller/dwc/pcie-lantiq.c
> [1] https://github.com/xdarklight/linux/blob/lantiq-pcie-driver-next-20190727/Documentation/devicetree/bindings/pci/lantiq%2Cdw-pcie.yaml
