Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C5576C56
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiGPHOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPHOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 03:14:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F5795B3
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 00:14:28 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9E2ZdJijEIiAA--.4504S3;
        Sat, 16 Jul 2022 15:13:59 +0800 (CST)
Subject: Re: [PATCH V16 5/7] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220714124216.1489304-1-chenhuacai@loongson.cn>
 <20220714124216.1489304-6-chenhuacai@loongson.cn>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <05be8921-8287-b939-bde8-983dbbfeac62@loongson.cn>
Date:   Sat, 16 Jul 2022 15:13:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220714124216.1489304-6-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxr9E2ZdJijEIiAA--.4504S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr48Zw4UXF15KF4UZr4xJFb_yoWxtFWfpa
        y5Jay2yr4Fqr98urn2va1kur1rZFn3C3yrCFW3GryIvFnxC3WYgryaqFnIva13ZFWkuFW7
        XrWDCryrCFs0kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j
        6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Huacai and Bjorn,

Actually, I don't think we have to fix the MRRS issue of 7A in this 
way(change core code of PCI). The reasons are:

- First, we don't know if other pci controlers have simillar issue, at 
least I don't see yet. I think if *only we* have the issue, maybe we can 
fix it in our controller driver rather than changing core code. And in 
future, if the issue is proved a common one, abstract it then by common way.

- Second, even though we limit the MRRS in pcie_set_readrq() according 
to the flag set in quirk function, some drivers(e.g. in 
drivers/rapidio/devices/tsi721.c, maybe other driver do this in future, 
I dont't know.) directly call pcie_capability_clear_and_set_word to set 
MRRS, which will still break the fix.

- Third, on resuming from S3, the MRRS stored in memory should be 
allowed to set to dev ctrl reg(because the reg has been reset during S3).


Fix MMRS in our controller driver by using self-defined config_write(), 
maybe like this:

static u32 handle_mrrs_limit(struct pci_bus *bus, unsigned int devfn, 
void __iomem *addr, u32 val)
{
      u32 tmp;
      bool runtime_flag = 1;
      int pos = pci_bus_find_capability_nolock(bus, devfn, PCI_CAP_ID_EXP);

#ifdef CONFIG_PM_SLEEP
       if (pm_suspend_target_state == PM_SUSPEND_ON)
             runtime_flag = 0;
#endif

       if (resume_flag && pos != 0 && (pos + PCI_EXP_DEVCTL) == reg) {
             tmp = readl(addr);
             if ((val & PCI_EXP_DEVCTL_READRQ) > (tmp & 
PCI_EXP_DEVCTL_READRQ)) {
                     val &= ~PCI_EXP_DEVCTL_READRQ;
                     val |= (tmp & PCI_EXP_DEVCTL_READRQ);
             }
       }
       return val;

}


static int loongson_pci_config_write32(struct pci_bus *bus, unsigned int 
devfn,
                                int where, int size, u32 val)
{
         void __iomem *addr;
         u32 mask, tmp;
         int reg = where & ~3;

         addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
         if (!addr)
                 return PCIBIOS_DEVICE_NOT_FOUND;
         val = handle_mrrs_limit(bus, devfn, addr, reg, val);
         writel(val, addr);

         return PCIBIOS_SUCCESSFUL;
}

And I still have to emphasize on the fix in this way: It's still does 
not work for pciehp. It's only used for addressing MRRS issue of 7A 
revisions which have no pciehp support.

And in future, for new revision, we just need to skip handle_mrrs_limit.

The way described here is just my immature opinion, we can discuss it
if required.

Thanks.

On 2022/7/14 下午8:42, Huacai Chen wrote:
> In new revision of LS7A, some PCIe ports support larger value than 256,
> but their maximum supported MRRS values are not detectable. Moreover,
> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> will actually set a big value in its driver. So the only possible way
> is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> 
> However, according to PCIe Spec, it is legal for an OS to program any
> value for MRRS, and it is also legal for an endpoint to generate a Read
> Request with any size up to its MRRS. As the hardware engineers say, the
> root cause here is LS7A doesn't break up large read requests. In detail,
> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> request with a size that's "too big" ("too big" means larger than the
> PCIe ports can handle, which means 256 for some ports and 4096 for the
> others, and of course this is a problem in the LS7A's hardware design).
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/pci/controller/pci-loongson.c | 44 +++++++++------------------
>   drivers/pci/pci.c                     |  6 ++++
>   include/linux/pci.h                   |  1 +
>   3 files changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 594653154deb..af73bb766e48 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -68,37 +68,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_LS7A_LPC, system_bus_quirk);
>   
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> +static void loongson_mrrs_quirk(struct pci_dev *pdev)
>   {
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> -	static const struct pci_device_id bridge_devids[] = {
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> -		{ 0, },
> -	};
> -
> -	/* look for the matching bridge */
> -	while (!pci_is_root_bus(bus)) {
> -		bridge = bus->self;
> -		bus = bus->parent;
> -		/*
> -		 * Some Loongson PCIe ports have a h/w limitation of
> -		 * 256 bytes maximum read request size. They can't handle
> -		 * anything larger than this. So force this limit on
> -		 * any devices attached under these ports.
> -		 */
> -		if (pci_match_id(bridge_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				pci_info(dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -			break;
> -		}
> -	}
> +	/*
> +	 * Some Loongson PCIe ports have h/w limitations of maximum read
> +	 * request size. They can't handle anything larger than this. So
> +	 * force this limit on any devices attached under these ports.
> +	 */
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +
> +	bridge->no_inc_mrrs = 1;
>   }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>   
>   static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>   {
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a8..79157cbad835 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6052,6 +6052,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>   {
>   	u16 v;
>   	int ret;
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>   
>   	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
>   		return -EINVAL;
> @@ -6070,6 +6071,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>   
>   	v = (ffs(rq) - 8) << 12;
>   
> +	if (bridge->no_inc_mrrs) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;
> +	}
> +
>   	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>   						  PCI_EXP_DEVCTL_READRQ, v);
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 81a57b498f22..a9211074add6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -569,6 +569,7 @@ struct pci_host_bridge {
>   	void		*release_data;
>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> +	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
>   	unsigned int	native_aer:1;		/* OS may use PCIe AER */
>   	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
>   	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
> 

