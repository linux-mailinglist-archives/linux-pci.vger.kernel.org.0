Return-Path: <linux-pci+bounces-6333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE058A76C7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 23:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2160284CAD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DAA6BFAB;
	Tue, 16 Apr 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQnFdUBo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582958203;
	Tue, 16 Apr 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302734; cv=none; b=ta4Br4PVsYQSnmW3XKKqVtNaoMmAfH5Ze95KJOgps7p5JL8lHOQ0QBsigz1olxgMfyUr8tISVnxaKtcYJMeb/oQVlFogBwtQ+5hWhSG6CQUual8uyFZfe9ZtgNI+XKbRkwE6NXc59cklACqaKe5911EnFrEtX3aHacf5qIp5/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302734; c=relaxed/simple;
	bh=eO98DY7CIz7eC1ApeDbKUP4UlrTAg7IIAn5q3LTWsbE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lpZ7bM5tkr4VdDAsbM6neYmUFjHh6buWZyMx7a85fvOEh0jGrEhg04KW4yqF8WUDT8UrWpnuAOZdK5dLvqzmSb5ZnzYQHJbPCyxffO8Eyt4waAlEA/NFjJZbrr62aNDjLJlM/EYeWg5Lf5O/swLRj5PyleWltAkRLp+SGiXz+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQnFdUBo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e696ee8fa3so88792a34.1;
        Tue, 16 Apr 2024 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713302732; x=1713907532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP41hdtXelUpwcI0aj34hpgq/euzrgZ/XyTOcECec+8=;
        b=BQnFdUBoi1vGSiFGT3BKG/bmM80DEwec7AiTay7gzXFgnHZAms7Z7UwiweTCSf4vJi
         p2aoSwSOdQwsvFASBdFw5S3NO5JWes+FH3o3yS/w8Shnng8pV2KTeHOKafprxUW/4tQC
         ibuXmuNfXHevsbDcvn40LG3cC3KKnVPtVnSN4+bQwcfYHvJEa058nmHd/hGw2N46s/XG
         Yu9y4lqq6jHIeJmuMKfiCP3G5S4dYpMEOk3XbDZDxYzRl5tZ1K6Us9HDlecSpa33DEJ5
         RaTbw9mtqYOWY4tXsEdyJnvwyGTAe6UNT3i0x4oQ853OeTz798tMcmsR4TtXjLk0dDuq
         PoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302732; x=1713907532;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP41hdtXelUpwcI0aj34hpgq/euzrgZ/XyTOcECec+8=;
        b=VYjVkLYeFsT2KJSst+/E4mekhMQJtqILivRli6e9M0SmqYVzqXsz8h0pIGaJoaijzh
         wM67e+RE7A07qbN4uqX1miKJkNbVh5JMWt4fnJ4CFzKcQvgCFKZADUDSwcPx21EyF81e
         +YUmR8ZFVdoXdL66uPX6xnFg2rUD3njT8vemmL/uPdC/gKC5Fpiny9DjFmM8rCaqdHT9
         i0GS80t/6kDm32CUE3H523fD9ciR+I7R+UJqDileg2SgVYXiQLCZQy4bSptTk/EpS5Yt
         os98MZy6vqukuGUMHRUYS/Udr/tFRo0CX4jGgl6B/0Y6dnlNhh2lAR8M81P3cQdDsv5w
         rmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIKFab3FjyC1zJJKN6ehOiWY0EEOgV5osLwlSqCHuMzECtkUokmbrylC16rxSJGGl28HsLUPIhxFOFmaxjZsHKDC35eH3xGtQIjz8IUF72CWxopL42Vn5cX8pPtB0+xgx489n2bqNi5cO8DXbpqhojE57sq5BzS8HQrhW3rmTky8cC9ShorAyYsVXSnqONioL8DIVuLFO2axALgq2I2OFkgmEBS0LX3PtT0qJ6C2RZaiFwWfiKhMOIsxUAwt4=
X-Gm-Message-State: AOJu0YytqYmZxrdyZ45RM/bfSjlO6sREwEJwsZgmm0aVmKAkIrj9LXAQ
	zYrSmuVpLE/8g2Ax5FlmKEWWGUuacNQlRDyTKpiLl3sm1IndoWcS
X-Google-Smtp-Source: AGHT+IEfDmYbKj3xvgd6fPThcAdO/OKuBg0B8gvdcmmOULb0La1dI1vNl5sTDa1HjyWzJle9WGCrLQ==
X-Received: by 2002:a05:6830:487b:b0:6eb:96b4:7018 with SMTP id dx27-20020a056830487b00b006eb96b47018mr429271otb.11.1713302731884;
        Tue, 16 Apr 2024 14:25:31 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id eg7-20020a0568306f8700b006eb84466e68sm793940otb.55.2024.04.16.14.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 14:25:31 -0700 (PDT)
Message-ID: <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
Date: Tue, 16 Apr 2024 16:25:28 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2
 PHY
Content-Language: en-US
From: "Alex G." <mr.nuke.me@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-7-mr.nuke.me@gmail.com>
 <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
 <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com>
In-Reply-To: <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

On 4/15/24 16:25, mr.nuke.me@gmail.com wrote:
> 
> 
> On 4/15/24 15:10, Dmitry Baryshkov wrote:
>> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com> 
>> wrote:
>>>
>>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
>>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
>>> being reused from IPQ8074 and IPQ6018 PHYs.
>>>
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>> ---
>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>>   2 files changed, 149 insertions(+), 1 deletion(-)
>>>
>>
>> [skipped]
>>
>>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem 
>>> *base, u32 offset, u32 val)
>>>
>>>   /* list of clocks required by phy */
>>>   static const char * const qmp_pciephy_clk_l[] = {
>>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
>>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", 
>>> "anoc", "snoc"
>>
>> Are the NoC clocks really necessary to drive the PHY? I think they are
>> usually connected to the controllers, not the PHYs.
> 
> The system will hang if these clocks are not enabled. They are also 
> attached to the PHY in the QCA 5.4 downstream kernel.
> 
They are named "anoc_lane", and "snoc_lane" in the downstream kernel. 
Would you like me to use these names instead?

e>>>   };
>>>
>>>   /* list of regulators */
>>> @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets 
>>> qmp_pcie_offsets_v4x1 = {
>>>          .rx             = 0x0400,
>>>   };
>>>
>>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
>>> +       .serdes         = 0,
>>> +       .pcs            = 0x1000,
>>> +       .pcs_misc       = 0x1400,
>>> +       .tx             = 0x0200,
>>> +       .rx             = 0x0400,
>>> +       .tx2            = 0x0600,
>>> +       .rx2            = 0x0800,
>>> +};
>>> +
>>>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
>>>          .serdes         = 0,
>>>          .pcs            = 0x0a00,
>>> @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg 
>>> sm8250_qmp_gen3x1_pciephy_cfg = {
>>>          .phy_status             = PHYSTATUS,
>>>   };
>>>
>>> +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
>>> +       .lanes                  = 2,
>>> +
>>> +       .offsets                = &qmp_pcie_offsets_ipq9574,
>>> +
>>> +       .tbls = {
>>> +               .serdes         = ipq9574_gen3x2_pcie_serdes_tbl,
>>> +               .serdes_num     = 
>>> ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
>>> +               .tx             = ipq8074_pcie_gen3_tx_tbl,
>>> +               .tx_num         = ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
>>> +               .rx             = ipq6018_pcie_rx_tbl,
>>> +               .rx_num         = ARRAY_SIZE(ipq6018_pcie_rx_tbl),
>>> +               .pcs            = ipq6018_pcie_pcs_tbl,
>>> +               .pcs_num        = ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
>>> +               .pcs_misc       = ipq9574_gen3x2_pcie_pcs_misc_tbl,
>>> +               .pcs_misc_num   = 
>>> ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
>>> +       },
>>> +       .reset_list             = ipq8074_pciephy_reset_l,
>>> +       .num_resets             = ARRAY_SIZE(ipq8074_pciephy_reset_l),
>>> +       .vreg_list              = NULL,
>>> +       .num_vregs              = 0,
>>> +       .regs                   = pciephy_v4_regs_layout,
>>
>> So, is it v4 or v5?
> 
> Please give me a day or so to go over my notes and give you a more 
> coherent explanation of why this versioning was chosen. I am only 
> working from the QCA 5.4 downstream sources. I don't have any 
> documentation for the silicon

The downstream QCA kernel uses the same table for ipq6018, ipq8074-gen3, 
and ipq9574. It is named "ipq_pciephy_gen3_regs_layout". Thus, it made 
sense to use the same upstream table for ipq9574, "pciephy_v4_regs_layout".

As far as the register tables go, the pcs/pcs_misc are squashed into the 
same table in the downstream 5.4 kernel. I was able to separate the two 
tables because the pcs_misc registers were defined with an offset of 
0x400. For example:

/* QMP V2 PHY for PCIE gen3 2 Lane ports - PCS Misc registers */
#define PCS_PCIE_X2_POWER_STATE_CONFIG2                    0x40c
#define PCS_PCIE_X2_POWER_STATE_CONFIG4                    0x414
#define PCS_PCIE_X2_ENDPOINT_REFCLK_DRIVE                  0x420
#define PCS_PCIE_X2_L1P1_WAKEUP_DLY_TIME_AUXCLK_L          0x444
#define PCS_PCIE_X2_L1P1_WAKEUP_DLY_TIME_AUXCLK_H          0x448
#define PCS_PCIE_X2_L1P2_WAKEUP_DLY_TIME_AUXCLK_L          0x44c
#define PCS_PCIE_X2_L1P2_WAKEUP_DLY_TIME_AUXCLK_H          0x450
...

Here, QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2 = 0xc would be correct, 
assuming a pcs_misc offset of 0x400. However, starting with 
ENDPOINT_REFCLK_DRIVE, the register would be 
QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE = 0x1c. Our offsets are off-by 0x4.

The existing V5 offsets, on the other hand, were all correct. For this 
reason, I considered that V5 is the most likely place to add the missing 
PCS misc definitions.

Is this explanation sufficiently convincing? Where does the v4/v5 scheme 
in upstream kernel originate?

Alex


