Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3272B0B42
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfILJXi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 05:23:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:60957 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbfILJXi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 05:23:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 02:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="189938783"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2019 02:23:36 -0700
Received: from [10.226.39.17] (ekotax-mobl.gar.corp.intel.com [10.226.39.17])
        by linux.intel.com (Postfix) with ESMTP id 0C7965808A9;
        Thu, 12 Sep 2019 02:23:32 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Andrew Murray <andrew.murray@arm.com>,
        gustavo.pimentel@synopsys.com
Cc:     jingoohan1@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <35316bac59d3bc681e76d33e0345f4ef950c4414.1567585181.git.eswara.kota@linux.intel.com>
 <20190905104517.GX9720@e119886-lin.cambridge.arm.com>
 <3a3d040e-e57a-3efd-0337-2c2d0b27ad1a@linux.intel.com>
 <20190906112044.GF9720@e119886-lin.cambridge.arm.com>
 <959a5f9b-2646-96e3-6a0f-0af1051ae1cb@linux.intel.com>
 <20190909083117.GH9720@e119886-lin.cambridge.arm.com>
 <22857835-1f98-b251-c94b-16b4b0a6dba2@linux.intel.com>
 <20190911103058.GP9720@e119886-lin.cambridge.arm.com>
 <aefd143c-66d2-b303-d992-a55f75a91b2e@linux.intel.com>
 <20190912082517.GA9720@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <cd73e351-5633-bfa8-a4dc-77357d917a0b@linux.intel.com>
Date:   Thu, 12 Sep 2019 17:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190912082517.GA9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Andrew Murray:
Quoting Gustavo Pimentel:

On 9/12/2019 4:25 PM, Andrew Murray wrote:
> [...]
>>>>>>>>>> +static void intel_pcie_max_link_width_setup(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	u32 mask, val;
>>>>>>>>>> +
>>>>>>>>>> +	/* HW auto bandwidth negotiation must be enabled */
>>>>>>>>>> +	pcie_rc_cfg_wr_mask(lpp, PCIE_LCTLSTS_HW_AW_DIS, 0, PCIE_LCTLSTS);
>>>>>>>>>> +
>>>>>>>>>> +	mask = PCIE_DIRECT_LINK_WIDTH_CHANGE | PCIE_TARGET_LINK_WIDTH;
>>>>>>>>>> +	val = PCIE_DIRECT_LINK_WIDTH_CHANGE | lpp->lanes;
>>>>>>>>>> +	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_MULTI_LANE_CTRL);
>>>>>>>>> Is this identical functionality to the writing of PCIE_PORT_LINK_CONTROL
>>>>>>>>> in dw_pcie_setup?
>>>>>>>>>
>>>>>>>>> I ask because if the user sets num-lanes in the DT, will it have the
>>>>>>>>> desired effect?
>>>>>>>> intel_pcie_max_link_width_setup() function will be called by sysfs attribute pcie_width_store() to change on the fly.
>>>>>>> Indeed, but a user may also set num-lanes in the device tree. I'm wondering
>>>>>>> if, when set in device-tree, it will have the desired effect. Because I don't
>>>>>>> see anything similar to PCIE_LCTLSTS_HW_AW_DIS in dw_pcie_setup which is what
>>>>>>> your function does here.
>>>>>>>
>>>>>>> I guess I'm trying to avoid the suitation where num-lanes doesn't have the
>>>>>>> desired effect and the only way to set the num-lanes is throught the sysfs
>>>>>>> control.
>>>>>> I will check this and get back to you.
>>>> intel_pcie_max_link_width_setup() is doing the lane resizing which is
>>>> different from the link up/establishment happening during probe. Also
>>>> PCIE_LCTLSTS_HW_AW_DIS default value is 0 so not setting during the probe or
>>>> dw_pcie_setup.
>>>>
>>>> intel_pcie_max_link_width_setup() is programming as per the designware PCIe
>>>> controller databook instructions for lane resizing.
>>>>
>>>> Below lines are from Designware PCIe databook for lane resizing.
>>>>
>>>>    Program the TARGET_LINK_WIDTH[5:0] field of the MULTI_LANE_CONTROL_OFF
>>>> register.
>>>>    Program the DIRECT_LINK_WIDTH_CHANGE2 field of the MULTI_LANE_CONTROL_OFF
>>>> register.
>>>> It is assumed that the PCIE_CAP_HW_AUTO_WIDTH_DISABLE field in the
>>>> LINK_CONTROL_LINK_STATUS_REG register is 0.
>>> OK, so there is a difference between initial training and then resizing
>>> of the link. Given that this is not Intel specific, should this function
>>> exist within the designware driver for the benefit of others?
>> I am ok to add if maintainer agrees with it.

Gustavo Pimentel,

Could you please let us know your opinion on this.

[...]

>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	u32 val, mask, fts;
>>>>>>>>>> +
>>>>>>>>>> +	switch (lpp->max_speed) {
>>>>>>>>>> +	case PCIE_LINK_SPEED_GEN1:
>>>>>>>>>> +	case PCIE_LINK_SPEED_GEN2:
>>>>>>>>>> +		fts = PCIE_AFR_GEN12_FTS_NUM_DFT;
>>>>>>>>>> +		break;
[...]
>>>>>>>>>> +
>>>>>>>>>> +	if (device_property_read_u32(dev, "max-link-speed", &lpp->link_gen))
>>>>>>>>>> +		lpp->link_gen = 0; /* Fallback to auto */
>>>>>>>>> Is it possible to use of_pci_get_max_link_speed here instead?
>>>>>>>> Thanks for pointing it. of_pci_get_max_link_speed() can be used here. I will
>>>>>>>> update it in the next patch revision.
>>>> I just remember, earlier we were using  of_pci_get_max_link_speed() itself.
>>>> As per reviewer comments changed to device_property_read_u32() to maintain
>>>> symmetry in parsing device tree properties from device node.
>>>> Let me know your view.
>>> I couldn't find an earlier version of this series that used of_pci_get_max_link_speed,
>>> have I missed it somewhere?
>> It happened in our internal review.
>> What's your suggestion please, either to go with symmetry in parsing
>> "device_property_read_u32()" or with pci helper function
>> "of_pci_get_max_link_speed"?
> I'd prefer the helper, the added benefit of this is additional error checking.
> It also means users can be confident that max-link-speed will behave in the
> same way as other host controllers that use this field.
Ok, i will update it in the next patch version.


Regards,

Dilip

>
> Thanks,
>
> Andrew Murray
>
>>>>>>>>>> +
>>>>>>>>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
>>>>>>>>>> +	if (!res)
>>>>>>>>>> +		return -ENXIO;
>>>>>>>>>> +
>>>>>>>>>> +	lpp->app_base = devm_ioremap_resource(dev, res);
>>>>>>>>>> +	if (IS_ERR(lpp->app_base))
>>>>>>>>>> +		return PTR_ERR(lpp->app_base);
>>>>>>>>>> +
>>>>>>>>>> +	ret = intel_pcie_ep_rst_init(lpp);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>> Given that this is called from a function '..._get_resources' I don't think
>>>>>>>>> we should be resetting anything here.
>>>>>>>> Agree. I will move it out of get_resources().
>>>>>>>>>> +
>>>>>>>>>> +	lpp->phy = devm_phy_get(dev, "pciephy");
>>>>>>>>>> +	if (IS_ERR(lpp->phy)) {
>>>>>>>>>> +		ret = PTR_ERR(lpp->phy);
>>>>>>>>>> +		if (ret != -EPROBE_DEFER)
>>>>>>>>>> +			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
>>>>>>>>>> +		return ret;
>>>>>>>>>> +	}
>>>>>>>>>> +	return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	phy_exit(lpp->phy);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	u32 value;
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	if (lpp->max_speed < PCIE_LINK_SPEED_GEN3)
>>>>>>>>>> +		return 0;
>>>>>>>>>> +
>>>>>>>>>> +	/* Send PME_TURN_OFF message */
>>>>>>>>>> +	pcie_app_wr_mask(lpp, PCIE_APP_MSG_XMT_PM_TURNOFF,
>>>>>>>>>> +			 PCIE_APP_MSG_XMT_PM_TURNOFF, PCIE_APP_MSG_CR);
>>>>>>>>>> +
>>>>>>>>>> +	/* Read PMC status and wait for falling into L2 link state */
>>>>>>>>>> +	ret = readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
>>>>>>>>>> +				 (value & PCIE_APP_PMC_IN_L2), 20,
>>>>>>>>>> +				 jiffies_to_usecs(5 * HZ));
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
>>>>>>>>>> +
>>>>>>>>>> +	return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	if (dw_pcie_link_up(&lpp->pci))
>>>>>>>>>> +		intel_pcie_wait_l2(lpp);
>>>>>>>>>> +
>>>>>>>>>> +	/* Put EP in reset state */
>>>>>>>>> EP?
>>>>>>>> End point device. I will update it.
>>>>>>> Is this not a host bridge controller?
>>>>>> It is PERST#, signals hardware reset to the End point .
>>>>>>            /* Put EP in reset state */
>>>>>>            intel_pcie_device_rst_assert(lpp);
>>>>> OK.
>>>>>
>>>>>>>>>> +	intel_pcie_device_rst_assert(lpp);
>>>>>>>>>> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY, 0, PCI_COMMAND);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	intel_pcie_core_rst_assert(lpp);
>>>>>>>>>> +	intel_pcie_device_rst_assert(lpp);
>>>>>>>>>> +
>>>>>>>>>> +	ret = phy_init(lpp->phy);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>>> +
>>>>>>>>>> +	intel_pcie_core_rst_deassert(lpp);
>>>>>>>>>> +
>>>>>>>>>> +	ret = clk_prepare_enable(lpp->core_clk);
>>>>>>>>>> +	if (ret) {
>>>>>>>>>> +		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
>>>>>>>>>> +		goto clk_err;
>>>>>>>>>> +	}
>>>>>>>>>> +
>>>>>>>>>> +	intel_pcie_rc_setup(lpp);
>>>>>>>>>> +	ret = intel_pcie_app_logic_setup(lpp);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		goto app_init_err;
>>>>>>>>>> +
>>>>>>>>>> +	ret = intel_pcie_setup_irq(lpp);
>>>>>>>>>> +	if (!ret)
>>>>>>>>>> +		return ret;
>>>>>>>>>> +
>>>>>>>>>> +	intel_pcie_turn_off(lpp);
>>>>>>>>>> +app_init_err:
>>>>>>>>>> +	clk_disable_unprepare(lpp->core_clk);
>>>>>>>>>> +clk_err:
>>>>>>>>>> +	intel_pcie_core_rst_assert(lpp);
>>>>>>>>>> +	intel_pcie_deinit_phy(lpp);
>>>>>>>>>> +	return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static ssize_t
>>>>>>>>>> +pcie_link_status_show(struct device *dev, struct device_attribute *attr,
>>>>>>>>>> +		      char *buf)
>>>>>>>>>> +{
>>>>>>>>>> +	u32 reg, width, gen;
>>>>>>>>>> +	struct intel_pcie_port *lpp;
>>>>>>>>>> +
>>>>>>>>>> +	lpp = dev_get_drvdata(dev);
>>>>>>>>>> +
>>>>>>>>>> +	reg = pcie_rc_cfg_rd(lpp, PCIE_LCTLSTS);
>>>>>>>>>> +	width = FIELD_GET(PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH, reg);
>>>>>>>>>> +	gen = FIELD_GET(PCIE_LCTLSTS_LINK_SPEED, reg);
>>>>>>>>>> +	if (gen > lpp->max_speed)
>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
>>>>>>>>>> +		       width, pcie_link_gen_to_str(gen));
>>>>>>>>>> +}
>>>>>>>>>> +static DEVICE_ATTR_RO(pcie_link_status);
>>>>>>>>>> +
>>>>>>>>>> +static ssize_t pcie_speed_store(struct device *dev,
>>>>>>>>>> +				struct device_attribute *attr,
>>>>>>>>>> +				const char *buf, size_t len)
>>>>>>>>>> +{
>>>>>>>>>> +	struct intel_pcie_port *lpp;
>>>>>>>>>> +	unsigned long val;
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	lpp = dev_get_drvdata(dev);
>>>>>>>>>> +
>>>>>>>>>> +	ret = kstrtoul(buf, 10, &val);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>>> +
>>>>>>>>>> +	if (val > lpp->max_speed)
>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +	lpp->link_gen = val;
>>>>>>>>>> +	intel_pcie_max_speed_setup(lpp);
>>>>>>>>>> +	intel_pcie_speed_change_disable(lpp);
>>>>>>>>>> +	intel_pcie_speed_change_enable(lpp);
>>>>>>>>>> +
>>>>>>>>>> +	return len;
>>>>>>>>>> +}
>>>>>>>>>> +static DEVICE_ATTR_WO(pcie_speed);
>>>>>>>>>> +
>>>>>>>>>> +/*
>>>>>>>>>> + * Link width change on the fly is not always successful.
>>>>>>>>>> + * It also depends on the partner.
>>>>>>>>>> + */
>>>>>>>>>> +static ssize_t pcie_width_store(struct device *dev,
>>>>>>>>>> +				struct device_attribute *attr,
>>>>>>>>>> +				const char *buf, size_t len)
>>>>>>>>>> +{
>>>>>>>>>> +	struct intel_pcie_port *lpp;
>>>>>>>>>> +	unsigned long val;
>>>>>>>>>> +
>>>>>>>>>> +	lpp = dev_get_drvdata(dev);
>>>>>>>>>> +
>>>>>>>>>> +	if (kstrtoul(buf, 10, &val))
>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +	if (val > lpp->max_width)
>>>>>>>>>> +		return -EINVAL;
>>>>>>>>>> +
>>>>>>>>>> +	lpp->lanes = val;
>>>>>>>>>> +	intel_pcie_max_link_width_setup(lpp);
>>>>>>>>>> +
>>>>>>>>>> +	return len;
>>>>>>>>>> +}
>>>>>>>>>> +static DEVICE_ATTR_WO(pcie_width);
>>>>>>>>> You mentioned that a use-case for changing width/speed on the fly was to
>>>>>>>>> control power consumption (and this also helps debugging issues). As I
>>>>>>>>> understand there is no current support for this in the kernel - yet it is
>>>>>>>>> something that would provide value.
>>>>>>>>>
>>>>>>>>> I haven't looked in much detail, however as I understand the PCI spec
>>>>>>>>> allows an upstream partner to change the link speed and retrain. (I'm not
>>>>>>>>> sure about link width). Given that we already have
>>>>>>>>> [current,max]_link_[speed,width] is sysfs for each PCI device, it would
>>>>>>>>> seem natural to extend this to allow for writing a max width or speed.
>>>>>>>>>
>>>>>>>>> So ideally this type of thing would be moved to the core or at least in
>>>>>>>>> the dwc driver. This way the benefits can be applied to more devices on
>>>>>>>>> larger PCI fabrics - Though perhaps others here will have a different view
>>>>>>>>> and I'm keen to hear them.
>>>>>>>>>
>>>>>>>>> I'm keen to limit the differences between the DWC controller drivers and
>>>>>>>>> unify common code - thus it would be helpful to have a justification as to
>>>>>>>>> why this is only relevant for this controller.
>>>>>>>>>
>>>>>>>>> For user-space only control, it is possible to achieve what you have here
>>>>>>>>> with userspace utilities (something like setpci) (assuming the standard
>>>>>>>>> looking registers you currently access are exposed in the normal config
>>>>>>>>> space way - though PCIe capabilities).
>>>>>>>>>
>>>>>>>>> My suggestion would be to drop these changes and later add something that
>>>>>>>>> can benefit more devices. In any case if these changes stay within this
>>>>>>>>> driver then it would be helpful to move them to a separate patch.
>>>>>>>> Sure, i will submit these entity in separate patch.
>>>>>>> Please ensure that all supporting macros, functions and defines go with that
>>>>>>> other patch as well please.
>>>>>> Sure.
>>>>>>>>>> +
>>>>>>>>>> +static struct attribute *pcie_cfg_attrs[] = {
>>>>>>>>>> +	&dev_attr_pcie_link_status.attr,
>>>>>>>>>> +	&dev_attr_pcie_speed.attr,
>>>>>>>>>> +	&dev_attr_pcie_width.attr,
>>>>>>>>>> +	NULL,
>>>>>>>>>> +};
>>>>>>>>>> +ATTRIBUTE_GROUPS(pcie_cfg);
>>>>>>>>>> +
>>>>>>>>>> +static int intel_pcie_sysfs_init(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	return devm_device_add_groups(lpp->pci.dev, pcie_cfg_groups);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>>>>>>>>>> +{
>>>>>>>>>> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
>>>>>>>>>> +			    0, PCI_COMMAND);
>>>>>>>>>> +	intel_pcie_core_irq_disable(lpp);
>>>>>>>>>> +	intel_pcie_turn_off(lpp);
>>>>>>>>>> +	clk_disable_unprepare(lpp->core_clk);
>>>>>>>>>> +	intel_pcie_core_rst_assert(lpp);
>>>>>>>>>> +	intel_pcie_deinit_phy(lpp);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int intel_pcie_remove(struct platform_device *pdev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
>>>>>>>>>> +	struct pcie_port *pp = &lpp->pci.pp;
>>>>>>>>>> +
>>>>>>>>>> +	dw_pcie_host_deinit(pp);
>>>>>>>>>> +	__intel_pcie_remove(lpp);
>>>>>>>>>> +
>>>>>>>>>> +	return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	intel_pcie_core_irq_disable(lpp);
>>>>>>>>>> +	ret = intel_pcie_wait_l2(lpp);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>>> +
>>>>>>>>>> +	intel_pcie_deinit_phy(lpp);
>>>>>>>>>> +	clk_disable_unprepare(lpp->core_clk);
>>>>>>>>>> +	return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>>>>>>>>>> +
>>>>>>>>>> +	return intel_pcie_host_setup(lpp);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int intel_pcie_rc_init(struct pcie_port *pp)
>>>>>>>>>> +{
>>>>>>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>>>>>> +	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	/* RC/host initialization */
>>>>>>>>>> +	ret = intel_pcie_host_setup(lpp);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>> Insert new line here.
>>>>>>>> Ok.
>>>>>>>>>> +	ret = intel_pcie_sysfs_init(lpp);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		__intel_pcie_remove(lpp);
>>>>>>>>>> +	return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +int intel_pcie_msi_init(struct pcie_port *pp)
>>>>>>>>>> +{
>>>>>>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>>>>>> +
>>>>>>>>>> +	dev_dbg(pci->dev, "PCIe MSI/MSIx is handled by MSI in x86 processor\n");
>>>>>>>>> What about other processors? (Noting that this driver doesn't depend on
>>>>>>>>> any specific ARCH in the KConfig).
>>>>>>>> Agree. i will mark the dependency in Kconfig.
>>>>>>> OK, please also see how other drivers use the COMPILE_TEST Kconfig option.
>>>>>> Ok sure.
>>>>>>> I'd suggest that the dev_dbg just becomes a code comment.
>>>> Ok
>>>>>>>>>> +	return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
>>>>>>>>>> +{
>>>>>>>>>> +	return cpu_addr + BUS_IATU_OFFS;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static const struct dw_pcie_ops intel_pcie_ops = {
>>>>>>>>>> +	.cpu_addr_fixup = intel_pcie_cpu_addr,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
>>>>>>>>>> +	.host_init =		intel_pcie_rc_init,
>>>>>>>>>> +	.msi_host_init =	intel_pcie_msi_init,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static const struct intel_pcie_soc pcie_data = {
>>>>>>>>>> +	.pcie_ver =		0x520A,
>>>>>>>>>> +	.pcie_atu_offset =	0xC0000,
>>>>>>>>>> +	.num_viewport =		3,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static int intel_pcie_probe(struct platform_device *pdev)
>>>>>>>>>> +{
>>>>>>>>>> +	const struct intel_pcie_soc *data;
>>>>>>>>>> +	struct device *dev = &pdev->dev;
>>>>>>>>>> +	struct intel_pcie_port *lpp;
>>>>>>>>>> +	struct pcie_port *pp;
>>>>>>>>>> +	struct dw_pcie *pci;
>>>>>>>>>> +	int ret;
>>>>>>>>>> +
>>>>>>>>>> +	lpp = devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
>>>>>>>>>> +	if (!lpp)
>>>>>>>>>> +		return -ENOMEM;
>>>>>>>>>> +
>>>>>>>>>> +	platform_set_drvdata(pdev, lpp);
>>>>>>>>>> +	pci = &lpp->pci;
>>>>>>>>>> +	pci->dev = dev;
>>>>>>>>>> +	pp = &pci->pp;
>>>>>>>>>> +
>>>>>>>>>> +	ret = intel_pcie_get_resources(pdev);
>>>>>>>>>> +	if (ret)
>>>>>>>>>> +		return ret;
>>>>>>>>>> +
>>>>>>>>>> +	data = device_get_match_data(dev);
>>>>>>>>>> +	pci->ops = &intel_pcie_ops;
>>>>>>>>>> +	pci->version = data->pcie_ver;
>>>>>>>>>> +	pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
>>>>>>>>>> +	pp->ops = &intel_pcie_dw_ops;
>>>>>>>>>> +
>>>>>>>>>> +	ret = dw_pcie_host_init(pp);
>>>>>>>>>> +	if (ret) {
>>>>>>>>>> +		dev_err(dev, "cannot initialize host\n");
>>>>>>>>>> +		return ret;
>>>>>>>>>> +	}
>>>>>>>>> Add a new line after the closing brace.
>>>>>>>> Ok
>>>>>>>>>> +	/* Intel PCIe doesn't configure IO region, so configure
>>>>>>>>>> +	 * viewport to not to access IO region during register
>>>>>>>>>> +	 * read write operations.
>>>>>>>>>> +	 */
>>>>>>>>>> +	pci->num_viewport = data->num_viewport;
>>>>>>>>>> +	dev_info(dev,
>>>>>>>>>> +		 "Intel AXI PCIe Root Complex Port %d Init Done\n", lpp->id);
>>>>>>>>>> +	return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static const struct dev_pm_ops intel_pcie_pm_ops = {
>>>>>>>>>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
>>>>>>>>>> +				      intel_pcie_resume_noirq)
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static const struct of_device_id of_intel_pcie_match[] = {
>>>>>>>>>> +	{ .compatible = "intel,lgm-pcie", .data = &pcie_data },
>>>>>>>>>> +	{}
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static struct platform_driver intel_pcie_driver = {
>>>>>>>>>> +	.probe = intel_pcie_probe,
>>>>>>>>>> +	.remove = intel_pcie_remove,
>>>>>>>>>> +	.driver = {
>>>>>>>>>> +		.name = "intel-lgm-pcie",
>>>>>>>>> Is there a reason why the we use intel-lgm-pcie here and pcie-intel-axi
>>>>>>>>> elsewhere? What does lgm mean?
>>>>>>>> lgm is the name of intel SoC.  I will name it to pcie-intel-axi to be
>>>>>>>> generic.
>>>>>>> I'm keen to ensure that it is consistently named. I've seen other comments
>>>>>>> regarding what the name should be - I don't have a strong opinion though
>>>>>>> I do think that *-axi may be too generic.
>>>> This PCIe driver is for the Intel Gateway SoCs. So how about naming it is as
>>>> "pcie-intel-gw"; pcie-intel-gw.c and Kconfig as PCIE_INTEL_GW.
>>> I don't have a problem with this, though others may have differing views.
>> Sure. thank you.
>>> Thanks,
>>>
>>> Andrew Murray
>>>
>>>> Regards,
>>>> Dilip
>>>>
>>>>>> Ok, i will check and get back to you on this.
>>>>>> Regards,
>>>>> Thanks,
>>>>>
>>>>> Andrew Murray
>>>>>
>>>>>> Dilip
>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Andrew Murray
>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Andrew Murray
>>>>>>>>>
>>>>>>>>>> +		.of_match_table = of_intel_pcie_match,
>>>>>>>>>> +		.pm = &intel_pcie_pm_ops,
>>>>>>>>>> +	},
>>>>>>>>>> +};
>>>>>>>>>> +builtin_platform_driver(intel_pcie_driver);
>>>>>>>>>> -- 
>>>>>>>>>> 2.11.0
>>>>>>>>>>
