Return-Path: <linux-pci+bounces-3392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA88531B7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354AA2839BC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768355C10;
	Tue, 13 Feb 2024 13:23:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FCA5579B;
	Tue, 13 Feb 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830632; cv=none; b=tzl/2b6omMWq5jwL6wVjjJc+g+0vo4tBgxoW1xs7P04joZ8jdW/W1V3RHLP3UoVOLUg4I/rbpCp4im0cD6AxxqaCyc891sTq34G68NtedySMst2SdL9LCtf+hh26/YBpnxVrCwryww2pntkK2fG0nXWahTm+9WarVZNienILB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830632; c=relaxed/simple;
	bh=JYrClqaEUE94mLKu/RA3Zkg2J0lsGtHcSiCxxiT7H8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syL/SwEdx3MOHZKbqNx+fitEwBMD0HK+DDSUz1RnV4uimmIUr8HuAP2xdenYoAikRBn77Fo2G+bhSUWbbECIk3ijhdn1kxbaMAQNK6gKIhuDsudhlaC+QHGJXu9Kr5Ql7BrTGEkoiq2HrksPyGMhRTSLXBpvic2UDUATrSml13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED13CDA7;
	Tue, 13 Feb 2024 05:24:30 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8A23F762;
	Tue, 13 Feb 2024 05:23:47 -0800 (PST)
Message-ID: <f1b8c49b-0d13-4a3e-9696-75a370ac0e59@arm.com>
Date: Tue, 13 Feb 2024 13:23:45 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/16] PCI: imx6: Add iMX95 Endpoint (EP) support
Content-Language: en-GB
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, kw@linux.com, l.stach@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org, hch@lst.de
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-17-Frank.Li@nxp.com> <ZctGs2d9ccnmYysL@lpieralisi>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZctGs2d9ccnmYysL@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2024 10:38 am, Lorenzo Pieralisi wrote:
> [+Christoph, Robin - just checking with you if the DMA mask handling is
> what you expect from drivers, don't want to merge code that breaks your
> expectations]

I don't really understand how all the endpoint stuff fits together, but 
my hunch would be that setting the DMA masks in imx6_add_pcie_ep() might 
be more sensible, unless perhaps there's an implied intent to account 
for eDMA channels in root complex mode as well (and so assuming that 
eDMA and endpoint mode play nicely together sharing the same platform 
device) - as we've discussed before across various threads, setting DMA 
masks for a host bridge itself doesn't really make sense (and hence it 
leaves the gap where we can get away with co-opting them for the MSI 
address hack); it's any additional DMA-initiating functionality within a 
root complex which should own that responsibility.

FWIW it looks like the equivalent change for Layerscape *is* specific to 
endpoint mode, but I don't know how relevant that is to i.MX given that 
they're unrelated hardware configurations.

Thanks,
Robin.

> On Fri, Jan 19, 2024 at 12:11:22PM -0500, Frank Li wrote:
>> Add iMX95 EP support and add 64bit address support. Internal bus bridge for
>> PCI support 64bit dma address in iMX95. Hence, call
>> dma_set_mask_and_coherent() to set 64 bit DMA mask.
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>
>> Notes:
>>      Change from v8 to v9
>>      - update fixme comments
>>      - update BAR1 comments
>>      - Add mani's review tag
>>      Change from v7 to v8
>>      - Update commit message
>>      - Using Fixme
>>      - Update clks_cnts by ARRAY_SIZE
>>      
>>      Change from v4 to v7
>>      - none
>>      Change from v3 to v4
>>      - change align to 4k for imx95
>>      Change from v1 to v3
>>      - new patches at v3
>>
>>   drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>> index bbaa45c08323b..7889318f6555a 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -75,6 +75,7 @@ enum imx6_pcie_variants {
>>   	IMX8MQ_EP,
>>   	IMX8MM_EP,
>>   	IMX8MP_EP,
>> +	IMX95_EP,
>>   };
>>   
>>   #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
>> @@ -84,6 +85,7 @@ enum imx6_pcie_variants {
>>   #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
>>   #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>>   #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
>> +#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>>   
>>   #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
>>   
>> @@ -616,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>>   		break;
>>   	case IMX7D:
>>   	case IMX95:
>> +	case IMX95_EP:
>>   		break;
>>   	case IMX8MM:
>>   	case IMX8MM_EP:
>> @@ -1050,6 +1053,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>>   	.align = SZ_64K,
>>   };
>>   
>> +/*
>> + * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
>> + * ================================================================================================
>> + * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
>> + * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
>> + *        BAR1 should be disabled if BAR0 is 64bit.
>> + * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
>> + * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
>> + * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
>> + * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
>> + */
>> +static const struct pci_epc_features imx95_pcie_epc_features = {
>> +	.msi_capable = true,
>> +	.bar_fixed_size[1] = SZ_64K,
>> +	.align = SZ_4K,
>> +};
>> +
>>   static const struct pci_epc_features*
>>   imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>>   {
>> @@ -1092,6 +1112,15 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>>   
>>   	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
>>   
>> +	/*
>> +	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
>> +	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
>> +	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
>> +	 * above "dbi_base2" setting should be removed.
>> +	 */
>> +	if (imx6_pcie->drvdata->variant == IMX95_EP)
>> +		pci->dbi_base2 = NULL;
>> +
>>   	ret = dw_pcie_ep_init(ep);
>>   	if (ret) {
>>   		dev_err(dev, "failed to initialize endpoint\n");
>> @@ -1345,6 +1374,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>>   					     "unable to find iomuxc registers\n");
>>   	}
>>   
>> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
>> +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +
>>   	/* Grab PCIe PHY Tx Settings */
>>   	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
>>   				 &imx6_pcie->tx_deemph_gen1))
>> @@ -1563,6 +1595,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>>   		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>>   		.epc_features = &imx8m_pcie_epc_features,
>>   	},
>> +	[IMX95_EP] = {
>> +		.variant = IMX95_EP,
>> +		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
>> +			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
>> +		.clk_names = imx8mq_clks,
>> +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
>> +		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>> +		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>> +		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>> +		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>> +		.init_phy = imx95_pcie_init_phy,
>> +		.epc_features = &imx95_pcie_epc_features,
>> +		.mode = DW_PCIE_EP_TYPE,
>> +	},
>>   };
>>   
>>   static const struct of_device_id imx6_pcie_of_match[] = {
>> @@ -1577,6 +1623,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>>   	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
>>   	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
>>   	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
>> +	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
>>   	{},
>>   };
>>   
>> -- 
>> 2.34.1
>>

