Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8A2D5641
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgLJJLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 04:11:35 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:42184 "EHLO
        8.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbgLJJLc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 04:11:32 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 04:11:31 EST
Received: from player696.ha.ovh.net (unknown [10.108.54.203])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4486B17C281
        for <linux-pci@vger.kernel.org>; Thu, 10 Dec 2020 09:46:45 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 53E0D18B5EA83;
        Thu, 10 Dec 2020 08:46:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G0021e0c2119-0cc2-4b96-b9e6-e90cfa33fc5b,
                    9D96FBD73EB20898266A9FB31776B13AC7912273) smtp.auth=rafal@milecki.pl
Subject: Re: [PATCH V2 2/2] PCI: brcmstb: support BCM4908 with external PERST#
 signal controller
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201130083223.32594-1-zajec5@gmail.com>
 <20201130083223.32594-3-zajec5@gmail.com>
 <812ab1ce-15e0-d260-97cf-597388505416@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <d27eec9f-f937-d0c3-1c33-6b6210effb1a@milecki.pl>
Date:   Thu, 10 Dec 2020 09:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <812ab1ce-15e0-d260-97cf-597388505416@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16173552164075703951
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudejledguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeekudehjeehffdufefhgffhgeejjeelteekveeuleevgeekhffhffeiheellefgveenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04.12.2020 19:21, Florian Fainelli wrote:
> On 11/30/2020 12:32 AM, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> BCM4908 uses external MISC block for controlling PERST# signal. Use it
>> as a reset controller.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> V2: Reorder BCM4908 in the enum pcie_type
>>      Use devm_reset_control_get_optional_exclusive()
>>      Don't move hw_rev read up in the code
>> ---
>>   drivers/pci/controller/Kconfig        |  2 +-
>>   drivers/pci/controller/pcie-brcmstb.c | 32 +++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 64e2f5e379aa..d44c70bb88f6 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -273,7 +273,7 @@ config VMD
>>   
>>   config PCIE_BRCMSTB
>>   	tristate "Broadcom Brcmstb PCIe host controller"
>> -	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
>> +	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || COMPILE_TEST
>>   	depends on OF
>>   	depends on PCI_MSI_IRQ_DOMAIN
>>   	default ARCH_BRCMSTB
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>> index 9c3d2982248d..98536cf3af58 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -96,6 +96,7 @@
>>   
>>   #define PCIE_MISC_REVISION				0x406c
>>   #define  BRCM_PCIE_HW_REV_33				0x0303
>> +#define  BRCM_PCIE_HW_REV_3_20				0x0320
>>   
>>   #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
>>   #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
>> @@ -190,6 +191,7 @@
>>   struct brcm_pcie;
>>   static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
>>   static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
>> +static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
>>   static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
>>   static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
>>   
>> @@ -206,6 +208,7 @@ enum {
>>   
>>   enum pcie_type {
>>   	GENERIC,
>> +	BCM4908,
>>   	BCM7278,
>>   	BCM2711,
>>   };
>> @@ -230,6 +233,13 @@ static const struct pcie_cfg_data generic_cfg = {
>>   	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>>   };
>>   
>> +static const struct pcie_cfg_data bcm4908_cfg = {
>> +	.offsets	= pcie_offsets,
>> +	.type		= BCM4908,
>> +	.perst_set	= brcm_pcie_perst_set_4908,
>> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>> +};
>> +
>>   static const int pcie_offset_bcm7278[] = {
>>   	[RGR1_SW_INIT_1] = 0xc010,
>>   	[EXT_CFG_INDEX] = 0x9000,
>> @@ -282,6 +292,7 @@ struct brcm_pcie {
>>   	const int		*reg_offsets;
>>   	enum pcie_type		type;
>>   	struct reset_control	*rescal;
>> +	struct reset_control	*perst_reset;
>>   	int			num_memc;
>>   	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>>   	u32			hw_rev;
>> @@ -747,6 +758,17 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
>>   	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>   }
>>   
>> +static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
>> +{
>> +	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
>> +		return;
>> +
>> +	if (val)
>> +		reset_control_assert(pcie->perst_reset);
>> +	else
>> +		reset_control_deassert(pcie->perst_reset);
> 
> This looks good to me now, just one nit, you probably do not support
> suspend/resume on the 4908, likely never will, but you should probably
> pulse the PERST# during PCIe resume, too. With that fixed:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Driver already does that.

Suspend forward trace:
brcm_pcie_suspend()
brcm_pcie_turn_off()
pcie->perst_set(pcie, 1)

Resume forward trace:
brcm_pcie_resume()
brcm_pcie_setup()
pcie->perst_set(pcie, 0)

Correct me if I'm wrong please.
