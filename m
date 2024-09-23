Return-Path: <linux-pci+bounces-13364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF0C97EAB4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD94280E14
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53C197A87;
	Mon, 23 Sep 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E2qmDCYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06970944E
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090895; cv=none; b=N6dcN0dMWSJE0vH6VFQKx1ahtYjbyqyZGeX9p1RYGlP48bc8ogJKAb2UaH1G4H5WCVyjZblUNDx9omvbhFqGFybK5L+5oDuCiWDMMJMLsoML5esizeh3h3maBzzhIPjJkwWcO+nSu53uzpRrPsyKBTFQvcJyEs9eiFUxnpXM9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090895; c=relaxed/simple;
	bh=ZYIUJSJHY0X6GASbH43baRFil7lffT/IRTBTSaj1FZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxU9JC9DR2hGqnklY9XVOKg6LUui8RjekjUbPRVSIpqiM0wa1klSyTHJVZRYeYCHhbXvd0DiTyGbcpKnZ59r5gImlWVp4WGDhN4Y7YqIyuk4hkUH5BTGnBjuiedaUyFSkFn5l1YJv5P2VrWGNbyhWLUXAjrkp56Cc2N+XaMCVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E2qmDCYs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727090891;
	bh=ZYIUJSJHY0X6GASbH43baRFil7lffT/IRTBTSaj1FZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E2qmDCYswf1FlpWFMUZ/DCi5wig/Bwqt7JMBv8rOE/4QnZLYWrQ5+A6hOk/uzjAgo
	 AG24Hw62qmCCNQCMtA3iDs+xzBas9dKNSGYv4d0Qswhr+2TTxyGv7XqxIrV3LYepGn
	 6Se8+juJ6TgRD/VZPKryU/It/bkFBwk4U0jNC7nrCvnhSJp4eHSF5VzQf3vjUVkJHG
	 ts+2Vw6+jyiG87iV9gkjhMRHX+2iLOTlee7fLIcX/LLs3cSOQemLELLIZqCr8xkl9N
	 UYVcjP+bc41dFQ4jDA5lMRvOnDUtVrMCv1SUBc2fgsdYByHVru7UH0CAYi8yNKtbJu
	 TjBHgqbx78WRQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 92D4D17E121F;
	Mon, 23 Sep 2024 13:28:10 +0200 (CEST)
Message-ID: <05ec0016-09e8-4e84-92d1-698b3c195ec8@collabora.com>
Date: Mon, 23 Sep 2024 13:28:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBQQ0k6IG1lZGlhdGVrLWdlbjM6IEF2?=
 =?UTF-8?Q?oid_PCIe_resetting_for_Airoha_EN7581_SoC?=
To: =?UTF-8?B?SHVpIE1hICjpqazmhacp?= <Hui.Ma@airoha.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, upstream <upstream@airoha.com>
References: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>
 <d8941149-9125-4fe2-a1c0-ab29223a0c87@collabora.com>
 <SG2PR03MB6341D9B41B5742BD45E09B46FF6F2@SG2PR03MB6341.apcprd03.prod.outlook.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <SG2PR03MB6341D9B41B5742BD45E09B46FF6F2@SG2PR03MB6341.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/09/24 12:06, Hui Ma (马慧) ha scritto:
> Hi Angelo，
> 
>           EN7581 doesn't support pulling up/down PERST by bit3 of PCIe MAC register 0x148(PCIE_RST_CTRL_REG).
> 
>           EN7581 toggle PERST in clk_bulk_enable function called by mtk_pcie_en7581_power_up function.
> 

Hello Hui,
please don't top post.

Anyway, are those bits unexistant on EN7581, or are those used for different
functions?

If those do not exist, and setting those bits will not produce adverse effects,
it'd be possible to avoid creating a different codepath and just add a comment
saying that the setting has no effect on Airoha EN7581.

Regards,
Angelo

> 
> 
> 
> 
> 
> 
> 
> -----邮件原件-----
> 发件人: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 发送时间: 2024年9月23日 17:42
> 收件人: Lorenzo Bianconi <lorenzo@kernel.org>; Ryder Lee <Ryder.Lee@mediatek.com>; Jianjun Wang (王建军) <Jianjun.Wang@mediatek.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczyński <kw@linux.com>; Rob Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Matthias Brugger <matthias.bgg@gmail.com>
> 抄送: Christian Marangi <ansuelsmth@gmail.com>; linux-pci@vger.kernel.org; linux-mediatek@lists.infradead.org; linux-arm-kernel@lists.infradead.org; upstream <upstream@airoha.com>; Hui Ma (马慧) <Hui.Ma@airoha.com>
> 主题: Re: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha EN7581 SoC
> 
> 
> 
> Il 20/09/24 10:26, Lorenzo Bianconi ha scritto:
> 
>> The PCIe controller available on the EN7581 SoC does not support reset
> 
>> via the following lines:
> 
>> - PCIE_MAC_RSTB
> 
>> - PCIE_PHY_RSTB
> 
>> - PCIE_BRG_RSTB
> 
>> - PCIE_PE_RSTB
> 
>>
> 
>> Introduce the reset callback in order to avoid resetting the PCIe port
> 
>> for Airoha EN7581 SoC.
> 
>>
> 
> 
> 
> EN7581 doesn't support pulling up/down PERST#?!
> 
> That looks definitely odd, as that signal is part of the PCI-Express CEM spec.
> 
> 
> 
> Besides, there's another PERST# assertion at mtk_pcie_suspend_noirq()...
> 
> 
> 
> Cheers,
> 
> Angelo
> 
> 
> 
>> Tested-by: Hui Ma <hui.ma@airoha.com<mailto:hui.ma@airoha.com>>
> 
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org<mailto:lorenzo@kernel.org>>
> 
>> ---
> 
>>    drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++++++++++++-----------
> 
>>    1 file changed, 28 insertions(+), 16 deletions(-)
> 
>>
> 
>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> 
>> b/drivers/pci/controller/pcie-mediatek-gen3.c
> 
>> index 5c19abac74e8..9cea67e92d98 100644
> 
>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> 
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> 
>> @@ -128,10 +128,12 @@ struct mtk_gen3_pcie;
> 
>>    /**
> 
>>     * struct mtk_gen3_pcie_pdata - differentiate between host generations
> 
>>     * @power_up: pcie power_up callback
> 
>> + * @reset: pcie reset callback
> 
>>     * @phy_resets: phy reset lines SoC data.
> 
>>     */
> 
>>    struct mtk_gen3_pcie_pdata {
> 
>>             int (*power_up)(struct mtk_gen3_pcie *pcie);
> 
>> +    void (*reset)(struct mtk_gen3_pcie *pcie);
> 
>>             struct {
> 
>>                       const char *id[MAX_NUM_PHY_RESETS];
> 
>>                       int num_resets;
> 
>> @@ -373,6 +375,28 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
> 
>>             writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
> 
>>    }
> 
>>
> 
>> +static void mtk_pcie_reset(struct mtk_gen3_pcie *pcie) {
> 
>> +    u32 val;
> 
>> +
> 
>> +    /* Assert all reset signals */
> 
>> +    val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> 
>> +    val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> 
>> +    writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> 
>> +
> 
>> +    /*
> 
>> +    * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> 
>> +    * and 2.2.1 (Initial Power-Up (G3 to S0)).
> 
>> +    * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> 
>> +    * for the power and clock to become stable.
> 
>> +    */
> 
>> +    msleep(100);
> 
>> +
> 
>> +    /* De-assert reset signals */
> 
>> +    val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> 
>> +    writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG); }
> 
>> +
> 
>>    static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> 
>>    {
> 
>>             struct resource_entry *entry;
> 
>> @@ -402,22 +426,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> 
>>             val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> 
>>             writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> 
>>
> 
>> -     /* Assert all reset signals */
> 
>> -     val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> 
>> -     val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> 
>> -     writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> 
>> -
> 
>> -     /*
> 
>> -     * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> 
>> -     * and 2.2.1 (Initial Power-Up (G3 to S0)).
> 
>> -     * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> 
>> -     * for the power and clock to become stable.
> 
>> -     */
> 
>> -     msleep(100);
> 
>> -
> 
>> -     /* De-assert reset signals */
> 
>> -     val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> 
>> -     writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> 
>> +    /* Reset the PCIe port if requested by the hw */
> 
>> +    if (pcie->soc->reset)
> 
>> +             pcie->soc->reset(pcie);
> 
>>
> 
>>             /* Check if the link is up or not */
> 
>>             err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val, @@
> 
>> -1207,6 +1218,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
> 
>>
> 
>>    static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
> 
>>             .power_up = mtk_pcie_power_up,
> 
>> +    .reset = mtk_pcie_reset,
> 
>>             .phy_resets = {
> 
>>                       .id[0] = "phy",
> 
>>                       .num_resets = 1,
> 
>>
> 
>> ---
> 
>> base-commit: f2024903cb387971abdbc6398a430e735a9b394c
> 
>> change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> 
>>
> 
>> Best regards,
> 
> 


