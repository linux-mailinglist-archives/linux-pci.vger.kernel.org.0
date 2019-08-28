Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC99F8CF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 05:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfH1DfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 23:35:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:4125 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfH1DfI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 23:35:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 20:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="332025708"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 27 Aug 2019 20:35:05 -0700
Received: from [10.226.39.5] (leichuan-mobl.gar.corp.intel.com [10.226.39.5])
        by linux.intel.com (Postfix) with ESMTP id B58895800BD;
        Tue, 27 Aug 2019 20:35:02 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     eswara.kota@linux.intel.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, hch@infradead.org,
        jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, qi-ming.wu@intel.com, kishon@ti.com
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
 <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
 <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com>
 <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <7c0fd56f-ecc5-40c2-c435-3805ca1f97c7@linux.intel.com>
Date:   Wed, 28 Aug 2019 11:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Thanks for your comment.

On 8/28/2019 4:38 AM, Martin Blumenstingl wrote:
> Hello,
>
> On Tue, Aug 27, 2019 at 5:09 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:
>> Hi Martin,
>>
>> Thanks for your feedback. Please check the comments below.
>>
>> On 8/27/2019 5:15 AM, Martin Blumenstingl wrote:
>>> Hello,
>>>
>>> On Mon, Aug 26, 2019 at 5:31 AM Chuan Hua, Lei
>>> <chuanhua.lei@linux.intel.com> wrote:
>>>> Hi Martin,
>>>>
>>>> Thanks for your valuable comments. I reply some of them as below.
>>> you're welcome
>>>
>>> [...]
>>>>>> +config PCIE_INTEL_AXI
>>>>>> +        bool "Intel AHB/AXI PCIe host controller support"
>>>>> I believe that this is mostly the same IP block as it's used in Lantiq
>>>>> (xDSL) VRX200 SoCs (with MIPS cores) which was introduced in 2010
>>>>> (before Intel acquired Lantiq).
>>>>> This is why I would have personally called the driver PCIE_LANTIQ
>>>> VRX200 SoC(internally called VR9) was the first PCIe SoC product which
>>>> was using synopsys
>>>>
>>>> controller v3.30a. It only supports PCIe Gen1.1/1.0. The phy is internal
>>>> phy from infineon.
>>> thank you for these details
>>> I wasn't aware that the PCIe PHY on these SoCs was developed by
>>> Infineon nor is the DWC version documented anywhere
>> VRX200/ARX300 PHY is internal value. There are a lot of hardcode which was
>> from hardware people. From XRX500, we switch to synopsis PHY. However, later
>> comboPHY is coming to the picture. Even though we have one same controller
>> with different versions, we most likely will have three different phy
>> drivers.
> that is a good argument for using a separate PHY driver and
> integrating that using the PHY subsystem (which is already the case in
> this patch revision)
Right. CombonPHY(PRX300/Lighting Mountain) and SlimPHY 
driver(XRX350/550) are in the way to upstream.
>
>>> [...]
>>>>>> +#define PCIE_CCRID                          0x8
>>>>>> +
>>>>>> +#define PCIE_LCAP                           0x7C
>>>>>> +#define PCIE_LCAP_MAX_LINK_SPEED            GENMASK(3, 0)
>>>>>> +#define PCIE_LCAP_MAX_LENGTH_WIDTH          GENMASK(9, 4)
>>>>>> +
>>>>>> +/* Link Control and Status Register */
>>>>>> +#define PCIE_LCTLSTS                                0x80
>>>>>> +#define PCIE_LCTLSTS_ASPM_ENABLE            GENMASK(1, 0)
>>>>>> +#define PCIE_LCTLSTS_RCB128                 BIT(3)
>>>>>> +#define PCIE_LCTLSTS_LINK_DISABLE           BIT(4)
>>>>>> +#define PCIE_LCTLSTS_COM_CLK_CFG            BIT(6)
>>>>>> +#define PCIE_LCTLSTS_HW_AW_DIS                      BIT(9)
>>>>>> +#define PCIE_LCTLSTS_LINK_SPEED                     GENMASK(19, 16)
>>>>>> +#define PCIE_LCTLSTS_NEGOTIATED_LINK_WIDTH  GENMASK(25, 20)
>>>>>> +#define PCIE_LCTLSTS_SLOT_CLK_CFG           BIT(28)
>>>>>> +
>>>>>> +#define PCIE_LCTLSTS2                               0xA0
>>>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED                GENMASK(3, 0)
>>>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_25GT   0x1
>>>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_5GT    0x2
>>>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_8GT    0x3
>>>>>> +#define PCIE_LCTLSTS2_TGT_LINK_SPEED_16GT   0x4
>>>>>> +#define PCIE_LCTLSTS2_HW_AUTO_DIS           BIT(5)
>>>>>> +
>>>>>> +/* Ack Frequency Register */
>>>>>> +#define PCIE_AFR                            0x70C
>>>>>> +#define PCIE_AFR_FTS_NUM                    GENMASK(15, 8)
>>>>>> +#define PCIE_AFR_COM_FTS_NUM                        GENMASK(23, 16)
>>>>>> +#define PCIE_AFR_GEN12_FTS_NUM_DFT          (SZ_128 - 1)
>>>>>> +#define PCIE_AFR_GEN3_FTS_NUM_DFT           180
>>>>>> +#define PCIE_AFR_GEN4_FTS_NUM_DFT           196
>>>>>> +
>>>>>> +#define PCIE_PLCR_DLL_LINK_EN                       BIT(5)
>>>>>> +#define PCIE_PORT_LOGIC_FTS                 GENMASK(7, 0)
>>>>>> +#define PCIE_PORT_LOGIC_DFT_FTS_NUM         (SZ_128 - 1)
>>>>>> +
>>>>>> +#define PCIE_MISC_CTRL                              0x8BC
>>>>>> +#define PCIE_MISC_CTRL_DBI_RO_WR_EN         BIT(0)
>>>>>> +
>>>>>> +#define PCIE_MULTI_LANE_CTRL                        0x8C0
>>>>>> +#define PCIE_UPCONFIG_SUPPORT                       BIT(7)
>>>>>> +#define PCIE_DIRECT_LINK_WIDTH_CHANGE               BIT(6)
>>>>>> +#define PCIE_TARGET_LINK_WIDTH                      GENMASK(5, 0)
>>>>>> +
>>>>>> +#define PCIE_IOP_CTRL                               0x8C4
>>>>>> +#define PCIE_IOP_RX_STANDBY_CTRL            GENMASK(6, 0)
>>>> no need for IOP
>>> with "are you sure that you need any of the registers above?" I really
>>> meant all registers above (including, but not limited to IOP)
>>>
>>> [...]
>>>> As I mentioned, VRX200 was a very old PCIe Gen1.1 product. In our latest
>>>> SoC Lightning
>>>>
>>>> Mountain, we are using synopsys controller 5.20/5.50a. We support
>>>> Gen2(XRX350/550),
>>>>
>>>> Gen3(PRX300) and GEN4(X86 based SoC). We also supported dual lane and
>>>> single lane.
>>>>
>>>> Some of the above registers are needed to control FTS, link width and
>>>> link speed.
>>> only now I noticed that I didn't explain why I was asking whether all
>>> these registers are needed
>>> my understanding of the DWC PCIe controller driver "library" is that:
>>> - all functionality which is provided by the DesignWare PCIe core
>>> should be added to drivers/pci/controller/dwc/pcie-designware*
>>> - functionality which is built on top/around the DWC PCIe core should
>>> be added to <vendor specific driver>
>>>
>>> the link width and link speed settings (I don't know about "FTS")
>>> don't seem Intel/Lantiq controller specific to me
>>> so the register setup for these bits should be moved to
>>> drivers/pci/controller/dwc/pcie-designware*
>> FTS means fast training sequence. Different generations will have
>> different FTS. Common DWC drivers have default number for all generations
>> which are not optimized.
> I am not a DWC PCIe driver expert, but it seems to me that this is
> exactly the reason why struct dw_pcie has a "version" field (which
> you're also filling).
> same as below: I'm interested in the DWC PCIe maintainer's opinion
>
>> DWC driver handles link speed and link width during the initialization.
>> Then left link speed change and link width to device (EP) according to
>> PCIe spec. Not sure if other vendors or customers have this kind of
>> requirement. We implemented this due to customer's requirement.
>>
>> We can check with DWC maintainer about this.
> thank you for the explanation.
> I am also interested in hearing the DWC PCIe maintainer's opinion on this topic
>
> [...]
>>> now I am wondering:
>>> - if we don't have to disable the interrupt line (once it is enabled),
>>> why can't we enable all of these interrupts at initialization time
>>> (instead of doing it on-demand)?
>> Good point! we even can remote map_irq patch, directly call
>> of_irq_parse_and_map_pci as other drivers do.
>>
>>> - if the interrupts do have to be disabled again (that is what I
>>> assumed so far) then where is this supposed to happen? (my solution
>>> for this was to implement a simple interrupt controller within the
>>> PCIe driver which only supports enable/disable. disclaimer: I didn't
>>> ask the PCI or interrupt maintainers for feedback on this yet)
>>>
>>> [...]
>> We can implement one interrupt controller, but personally, it has too
>> much overhead. If we follow this way, almost all modules of all old
>> lantiq SoCs can implement one interrupt controller. Maybe you can check
>> with PCI maintainer for their comments.
> if we can enable the PCI_INTA/B/C/D interrupts unconditionally then
> you can switch to the standard of_irq_parse_and_map_pci implementation
> (as you already noted above).
> in that case the extra interrupt controller won't be needed.
>
> I have no idea how to test whether unconditionally enabling these
> interrupts (in the APP registers that is) causes any problems though.
> that's why I went the interrupt-controller route in my experiment.
> if the hardware works with a simplified version then I'm more than
> happy to use that
We will enable these interrupts. simple is more easy to handle.
>
> [...]
>>>>>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>>>>>> +{
>>>>>> +    struct device *dev = lpp->pci->dev;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>>>>>> +    if (IS_ERR(lpp->reset_gpio)) {
>>>>>> +            ret = PTR_ERR(lpp->reset_gpio);
>>>>>> +            if (ret != -EPROBE_DEFER)
>>>>>> +                    dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
>>>>>> +            return ret;
>>>>>> +    }
>>>>>> +    /* Make initial reset last for 100ms */
>>>>>> +    msleep(100);
>>>>> why is there lpp->rst_interval when you hardcode 100ms here?
>>>> There are different purpose. rst_interval is purely for asserted reset
>>>> pulse.
>>>>
>>>> Here 100ms is to make sure the initial state keeps at least 100ms, then we
>>>> can reset.
>>> my interpretation is that it totally depends on the board design or
>>> the bootloader setup.
>> Partially, you are right. However, we should not add some dependency
>> here from
>> bootloader and board. rst_interval is just to make sure the pulse (low
>> active or high active)
>> lasts the specified the time.
> +Cc Kishon
>
> he recently added support for a GPIO reset line to the
> pcie-cadence-host.c [0] and I believe he's also maintaining
> pci-keystone.c which are both using a 100uS delay (instead of 100ms).
> I don't know the PCIe spec so maybe Kishon can comment on the values
> that should be used according to the spec.
> if there's then a reason why values other than the ones from the spec
> are needed then there should be a comment explaining why different
> values are needed (what problem does it solve).

spec doesn't guide this part. It is a board or SoC specific setting. 
100us also should work. spec only requirs reset duration should last 
100ms. The idea is that before reset assert and deassert, make sure the 
default deassert status keeps some time. We take this value from 
hardware suggestion long time back. We can reduce this value to 100us, 
but we need to test on the board.

>
>>> on a board where the bootloader initializes the GPIO to logical "0"
>>> the devm_gpiod_get() call will not change the GPIO output.
>>> in this case a 100ms delay may be OK (based on your description)
>>>
>>> however, if the GPIO was a logical "1" (for example if the bootloader
>>> set it to that value - and considering the GPIOD_OUT_LOW flag) then it
>>> will be set to "0" with the devm_gpiod_get() call above.
>>> now there is a transition from "deasserted" to "asserted" which does
>>> not honor lpp->rst_interval
>>>
>>> I'm not sure if this is a problem or not - all I know is that I don't
>>> fully understand the problem yet
>>>>> [...]
>>>>>> +static int intel_pcie_setup_irq(struct intel_pcie_port *lpp)
>>>>>> +{
>>>>>> +    struct device *dev = lpp->pci->dev;
>>>>>> +    struct platform_device *pdev;
>>>>>> +    char *irq_name;
>>>>>> +    int irq, ret;
>>>>>> +
>>>>>> +    pdev = to_platform_device(dev);
>>>>>> +    irq = platform_get_irq(pdev, 0);
>>>>>> +    if (irq < 0) {
>>>>>> +            dev_err(dev, "missing sys integrated irq resource\n");
>>>>>> +            return irq;
>>>>>> +    }
>>>>>> +
>>>>>> +    irq_name = devm_kasprintf(dev, GFP_KERNEL, "pcie_misc%d", lpp->id);
>>>>>> +    if (!irq_name) {
>>>>>> +            dev_err(dev, "failed to alloc irq name\n");
>>>>>> +            return -ENOMEM;
>>>>> you are only requesting one IRQ line for the whole driver. personally
>>>>> I would drop the custom irq_name and pass NULL to devm_request_irq
>>>>> because that will then fall-back to auto-generating an IRQ name based
>>>>> on the devicetree node. I assume it's the same for ACPI but I haven't
>>>>> tried that yet.
>>>> Not sure I understand what you mean.  As you know from the code, we have
>>>> lpp->id which means
>>>>
>>>> we have multiple instances of Root Complex(1,2,3,4,8), so we need this
>>>> for identification.
>>> sorry, I was wrong with my original statement, the name cannot be NULL
>>>
>>> I checked the other drivers (meson-gx-mmc and meson-saradc) I had in
>>> mind and they use dev_name(&pdev->dev);
>>> that will give a unique interrupt name (derived from the devicetree)
>>> in /proc/interrupts, for example: c1108680.adc, d0070000.mmc,
>>> d0072000.mmc, ...
>>>
>>> [...]
>> Right. We also use dev_name in our code. However, some people like numbering
>> the interface which is easier for them to remember and discuss. I link id to
>> domain so that we can easily know what is wrong once we have issues. When we
>> tell the address to hardware people and support staff, they are totally
>> lost.
> ah, this also explains why linux,pci-domain is a mandatory property
> (while it's optional for any other PCIe controller driver that I have
> seen so far)
Right. Imagine if you have 8 RCs on the board, how should we communicate 
with hardware /support people:)
>
>> Again, it is ok to switch to dev_name.
> both ways will work, I just wanted to point out that you can achieve a
> similar goal with less code.
> if the current solution works best for your support team then I'm fine
> with that as well
>
> [...]
>>>>>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>>>>>> +{
>>>>>> +    pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
>>>>>> +                        0, PCI_COMMAND);
>>>>> I expect logic like this to be part of the PCI subsystem in Linux.
>>>>> why is this needed?
>>>>>
>>>>> [...]
>>>> bind/unbind case we use this. For extreme cases, we use unbind and bind
>>>> to reset
>>>> PCI instead of rebooting.
>>> OK, but this does not seem Intel/Lantiq specific at all
>>> why isn't this managed by either pcie-designware-host.c or the generic
>>> PCI/PCIe subsystem in Linux?
>> I doubt if other RC driver will support bind/unbind. We do have this
>> requirement due to power management from WiFi devices.
> pcie-designware-host.c will gain .remove() support in Linux 5.4
> I don't understand how .remove() and then .probe() again is different
> from .unbind() followed by a .bind()
Good. If this is the case, bind/unbind eventually goes to probe/remove, 
so we can remove this.
>
>
> Martin
>
> [0] https://lkml.org/lkml/2019/6/4/626
