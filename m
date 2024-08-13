Return-Path: <linux-pci+bounces-11639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695C950965
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA671C20D4D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375349654;
	Tue, 13 Aug 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cnOfXv6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF621A071B
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564004; cv=none; b=jKIvlDWUtcgQCkxvjEpAR+xNVANeIsYCMAGdNrhcE2uq2TrZANJ4jNRXS70raOBuJq/wLzVMgQM5QE7gU0sVAIeFz5mxQ+7V9f3PasGYIYLINcJOsS99cowM7dch6y+ycoje67dOz6xHHwszkcMs6qe6s9ixLCs4RXY3+FycjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564004; c=relaxed/simple;
	bh=eaF+Q+f6PW4tsPCgEjcUQTZOn/4J5QHsSMyZx8+9qkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1K8XuwECIJY95REY8bNlx7F+TlSPX/TWg6+XLy+15zptShnNZYaLfZpWnjyNvYNjVzbAP6el/YnUbBsqNOF9an5K+9Huz7yxl2GMFI+17Ugu5GjsHNjqSpSesjPrHumPntOMahImc8VDYXApcBhvlLTRECs5K/U5fxSWKLfs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cnOfXv6k; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45007373217so54659531cf.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723564002; x=1724168802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=++YSOjyZMXbe1wAluzwgevPbXLeZ5uo/v260/AM6Gic=;
        b=cnOfXv6knyY4fbkQ6l0YSXbQVqJ3Wbe9/OYnJ/BLTAoeAIU3BdumoMJyewB28rVUWR
         5EzRrbz6a3EnkiK60WeNjN7RdRskWEhmKomJoDgc4Xu8aGxxBbVLwWhGxbb0G76UE9t4
         D4vonucXY9t8ygkSs9GthwF47n9A6T4Jl4kSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564002; x=1724168802;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++YSOjyZMXbe1wAluzwgevPbXLeZ5uo/v260/AM6Gic=;
        b=wYBx9Qo8kybaKChstdihXcm1loW01aQa7iHtAUYefyyn+7LnXBLK/L0bu6vGn04oWB
         vWdhls8xYe6cV9Blw8Gd9H2R+gPKQsK4AW98/fTzIexr7BRz7DQ/lLZiajArbqj0I8cR
         Hn5WrofdJoSq9lOZ9vc1nuH3w3jTMx7sNc3prRhL8oUlY6sx6RYMbDdUy0Oesx24gmZM
         997dkXEVV2G7YWSiWsr6H4UDZYL7k8aPPAKOSjYd3K2Kz9q7gUSmfmc9YdS6Y9InC9Ay
         8uW7WnkmVQDnztY1SLWMlvkVH2wbDuSwqmIBnkhPNIMVI+e46F2z2gX7T2tBA6geB9+k
         aJfg==
X-Gm-Message-State: AOJu0Yw2I1SeiCIzDggFAY1rhwItLN0KO39r7YmHC1dnZMBGsyv53Htt
	mG7gnZA1/WD75lHGgwQ2GwSEKeF+rGANc4HFK+B6SPJMMqb/hilFCriEjOalvw==
X-Google-Smtp-Source: AGHT+IGkStcl0cgGwD7BIT5v8v/xi6NxvajfeBBm2HxbGhhOZv5efzloZ1Hy2b+0//ab34m8Yu8ctw==
X-Received: by 2002:a05:622a:5c8d:b0:453:17ce:8f72 with SMTP id d75a77b69052e-4535ab50b96mr1791851cf.11.1723564001602;
        Tue, 13 Aug 2024 08:46:41 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a7f12sm33110141cf.20.2024.08.13.08.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:46:41 -0700 (PDT)
Message-ID: <c59c91d6-c48e-49d5-8daf-3a4ddd5d4c4d@broadcom.com>
Date: Tue, 13 Aug 2024 11:46:39 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: Use bridge reset if available
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-5-james.quinlan@broadcom.com>
 <9c22a495-7b89-4df6-b57b-cb0f39b09c30@suse.de>
 <CA+-6iNy2f3zNsSZcFBHnEoTSqDHx34+ijZrLWhnC5bfF=S3nQg@mail.gmail.com>
 <7b8b4b5f-4dc4-4099-b793-d10f2761d364@suse.de>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <7b8b4b5f-4dc4-4099-b793-d10f2761d364@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 18:28, Stanimir Varbanov wrote:
> Hi Jim,
>
> On 8/12/24 18:46, Jim Quinlan wrote:
>> On Fri, Aug 9, 2024 at 7:16 AM Stanimir Varbanov <svarbanov@suse.de> wrote:
>>> Hi Jim,
>>>
>>> On 8/1/24 01:28, Jim Quinlan wrote:
>>>> The 7712 SOC has a bridge reset which can be described in the device tree.
>>>> Use it if present.  Otherwise, continue to use the legacy method to reset
>>>> the bridge.
>>>>
>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>> ---
>>>>   drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>>>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>>> index 7595e7009192..4d68fe318178 100644
>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>> @@ -265,6 +265,7 @@ struct brcm_pcie {
>>>>        enum pcie_type          type;
>>>>        struct reset_control    *rescal;
>>>>        struct reset_control    *perst_reset;
>>>> +     struct reset_control    *bridge_reset;
>>>>        int                     num_memc;
>>>>        u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>>>>        u32                     hw_rev;
>>>> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>>>>
>>>>   static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>>>>   {
>>>> -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>>> -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>>> +     if (val)
>>>> +             reset_control_assert(pcie->bridge_reset);
>>>> +     else
>>>> +             reset_control_deassert(pcie->bridge_reset);
>>>>
>>>> -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>>> -     tmp = (tmp & ~mask) | ((val << shift) & mask);
>>>> -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>>> +     if (!pcie->bridge_reset) {
>>>> +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>>> +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>>> +
>>>> +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>>> +             tmp = (tmp & ~mask) | ((val << shift) & mask);
>>>> +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>>> +     }
>>>>   }
>>>>
>>>>   static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
>>>> @@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>>        if (IS_ERR(pcie->perst_reset))
>>>>                return PTR_ERR(pcie->perst_reset);
>>>>
>>>> +     pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
>>> Shouldn't this be devm_reset_control_get_optional_shared? See more below.
>>>
>>>> +     if (IS_ERR(pcie->bridge_reset))
>>>> +             return PTR_ERR(pcie->bridge_reset);
>>>> +
>>>>        ret = clk_prepare_enable(pcie->clk);
>>>>        if (ret)
>>>>                return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>>>>
>>>> +     pcie->bridge_sw_init_set(pcie, 0);
> ^^^ this was missing in v4

Hi Stan,

You are correct and I was remiss in not mentioning this in the cover 
letter.  After my changes on V4 I discovered that my driver failed the 
rebind in my unbind/rebind test and this line was required.

>
>>> According to reset_control_get_shared description looks like this
>>> .deassert is satisfying the requirements for _shared reset-control API
>>> variant.
>>> Is that the intention to call reset_control_deassert() here?
>> Hi Stan,
>> Now I'm not sure I understand you.  All of the resets (bridge, perst,
>> swinit) are exclusive, except for the "rescal" reset, which is shared.
> ... the call of pcie->bridge_sw_init_set(pcie, 0) from brcm_pcie_probe()
> was missing in previous v4 and I'm wondering what changed in v5.
>
> And because of _shared reset-control description [1] I decided (wrongly)
> that the bridge reset could be _shared_.
>
>> On the exclusive resets I am using reset_control_assert() and
>> reset_control_deasssert().  On the shared reset I am using
>> reset_control_rearm() and reset_control_reset().   Why do
>> you think the calls I am using are incongruent with the shard/exclusive
>> status?
> I'd argue that rescal reset is not correctly used in brcm_pcie_probe(),
> see [2] and according to [1] "Calling reset_control_reset is also not
> allowed on a shared reset control."

This is interesting because in reset/core.c [1]  the comment says that 
"reset_control_rearm", which is clearly used for shared resets, must be 
paired with calls to "reset_control_reset".

Regards,

Jim Quinlan

Broadcom STB/CM

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/reset/core.c?h=v6.11-rc3#n412

>
>
> [1]
> https://elixir.bootlin.com/linux/v6.11-rc3/source/include/linux/reset.h#L338
>
> [2]
> https://elixir.bootlin.com/linux/v6.11-rc3/source/drivers/pci/controller/pcie-brcmstb.c#L1632
>
> ~Stan



