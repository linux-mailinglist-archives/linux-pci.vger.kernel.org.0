Return-Path: <linux-pci+bounces-6297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D678A5CE9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 23:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762311F22999
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29756156F2C;
	Mon, 15 Apr 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPJ9KN6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CF156236;
	Mon, 15 Apr 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216352; cv=none; b=UI2L3HPSv+zzlmMxNT2SIxhipvqab/U6Jsry0HPDM3UXW0aHBCktdVp3+ifDeGGmJLsKvHPs7KoG1h9hAVpGP+ASnWVJ+PCnfURQtw81TQ7U9lc3YsLv7EfTQ3BTfdRjUlLEGHQM56PDdiDGjDKfPg6IBjjBGiMj4v8wnpA33zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216352; c=relaxed/simple;
	bh=xDX9qwIGAqnxwZvcmlu1AWdO+expzOyzESC+Fa4D8aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXlHoESN2Bm777Q3qEDHxa6GSach2FltB+KOo423iP7Ju3cFSzoespg8haBAaLbSFrvYNksZbRtEmiTOtNle4ZNZQG3XdhFGbWvomq/Z5hiEHzjH4Qx+KujUXw+VePMzWLbTiHGCqGZBCexFr0GYvQaw+KUIrRxoH/pi4nSEuJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPJ9KN6N; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c70ef25e19so641711b6e.3;
        Mon, 15 Apr 2024 14:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216350; x=1713821150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnRyb1KC+1OBK62QHuW79588BJIAAupCpTaTbO7XI1c=;
        b=GPJ9KN6NTAyYLzxxokgqxpDFNYq08tLfEorB1Y9ujzYPwgNKLJSVlHPJswHEZxE+dS
         CbpKXd6SAGGht4ehPTkMfxaPI2pYqzCxOWRO6jqTJ07LAmY9OTGT27+t+yKamHX4/knw
         ZTfmMchWBoVIfvprL2j667YtCueUfGALbGz5bZdsilF4cRPew1Ym15AVuYw/VC6UYPOJ
         HcZVwoocCscuiTHQVwBCOwNOz7dI8oCjSmLK9Cylw6g0eRySVDaKQQ72oRHJobo35b9c
         L8plfmrUbPmYKIs+YZqlH2UOPiX325ZPg1xNDAFNO2nu0LOgA/mHf7E+5G4gfyb6wJgS
         nhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216350; x=1713821150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnRyb1KC+1OBK62QHuW79588BJIAAupCpTaTbO7XI1c=;
        b=MdACqbEvaITeb246+bX7wi80dOQQeoBqx5Z6E5W43Acs1ZhV3H0M2IG3GkPDuS8X9Z
         t21NTeYmugbHU7/Qde1ksIbTs/Pqy4d1X6cVFsLEpq5p/0tddnE5v4NSnl2QKnz7L/g7
         ets2kI03JdJC3LftmkIFaRy5ox9HVMhSP4FtEiwMXhITyB8xo0yVYfEXqxm6KEfMKPjn
         AWUhdEYbciXbnbhHxggw+eB3ywLw/2BhJjrJAuNxa0WhMTBoG2FhYiFY2m8geyvndKDl
         0hIpOdiMxSISsLDim2Bjr7lOjGk1pqrMXbuTUuxFRaCkqHFZWrmz1UCbDU+A1TcnptOr
         1klA==
X-Forwarded-Encrypted: i=1; AJvYcCXmUmSlbY7xFZmbQlVH+SMGCJV1YHRu+IuaoI4n1zKvn2IPYPB1aHBOa+cbKMhrIqc9QPARlgJl1dlNJvBB3/QdukT0LVN9+24zSbQUPKbaIRe1MgY5lwegNA52RxloA6t+vg0SiGM7fU4SCv0GEm9UuX2rEaAj12SyrjNFpAqiVHBeGCRv648QifJd/FRdS7ckt1QOjFgFHq3P9G5fJfzTxYq7yxDcjlC8zLZ8aS1/woxqyHKN4eSnEoYJjvc=
X-Gm-Message-State: AOJu0YyogEzsHbM+FT/Sjbkqh1rxLrP8UQ4NjbGGh9UXIKzeekmlzY1o
	5pHdrTD5tDcKkl8sG9v/gq7vTP79uSsQydkDwhW9Mhj1OpE+3hPB
X-Google-Smtp-Source: AGHT+IFVx8xuKRS2VgjDQ5gszpCC9VDV/CVDiERN6wC4LXmwFjfelkaJR7tB/uZCbmijCe/eZtORlA==
X-Received: by 2002:a05:6808:2a69:b0:3c7:76c:c279 with SMTP id fu9-20020a0568082a6900b003c7076cc279mr6166827oib.14.1713216349788;
        Mon, 15 Apr 2024 14:25:49 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id n4-20020aca2404000000b003c60db822e7sm1774266oic.4.2024.04.15.14.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:25:49 -0700 (PDT)
Message-ID: <6726fa2b-f5fe-10fb-6aab-f76d61f0b3cd@gmail.com>
Date: Mon, 15 Apr 2024 16:25:48 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2
 PHY
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
From: mr.nuke.me@gmail.com
In-Reply-To: <CAA8EJpqY1aDZMaeqBULEOD26UeGYbLd8RsA16jZw7zXJ7_oGPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/24 15:10, Dmitry Baryshkov wrote:
> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>>
>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
>> being reused from IPQ8074 and IPQ6018 PHYs.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>   2 files changed, 149 insertions(+), 1 deletion(-)
>>
> 
> [skipped]
> 
>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>>
>>   /* list of clocks required by phy */
>>   static const char * const qmp_pciephy_clk_l[] = {
>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "anoc", "snoc"
> 
> Are the NoC clocks really necessary to drive the PHY? I think they are
> usually connected to the controllers, not the PHYs.

The system will hang if these clocks are not enabled. They are also 
attached to the PHY in the QCA 5.4 downstream kernel.

>>   };
>>
>>   /* list of regulators */
>> @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x1 = {
>>          .rx             = 0x0400,
>>   };
>>
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
>> +       .serdes         = 0,
>> +       .pcs            = 0x1000,
>> +       .pcs_misc       = 0x1400,
>> +       .tx             = 0x0200,
>> +       .rx             = 0x0400,
>> +       .tx2            = 0x0600,
>> +       .rx2            = 0x0800,
>> +};
>> +
>>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
>>          .serdes         = 0,
>>          .pcs            = 0x0a00,
>> @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>>          .phy_status             = PHYSTATUS,
>>   };
>>
>> +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
>> +       .lanes                  = 2,
>> +
>> +       .offsets                = &qmp_pcie_offsets_ipq9574,
>> +
>> +       .tbls = {
>> +               .serdes         = ipq9574_gen3x2_pcie_serdes_tbl,
>> +               .serdes_num     = ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
>> +               .tx             = ipq8074_pcie_gen3_tx_tbl,
>> +               .tx_num         = ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
>> +               .rx             = ipq6018_pcie_rx_tbl,
>> +               .rx_num         = ARRAY_SIZE(ipq6018_pcie_rx_tbl),
>> +               .pcs            = ipq6018_pcie_pcs_tbl,
>> +               .pcs_num        = ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
>> +               .pcs_misc       = ipq9574_gen3x2_pcie_pcs_misc_tbl,
>> +               .pcs_misc_num   = ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
>> +       },
>> +       .reset_list             = ipq8074_pciephy_reset_l,
>> +       .num_resets             = ARRAY_SIZE(ipq8074_pciephy_reset_l),
>> +       .vreg_list              = NULL,
>> +       .num_vregs              = 0,
>> +       .regs                   = pciephy_v4_regs_layout,
> 
> So, is it v4 or v5?

Please give me a day or so to go over my notes and give you a more 
coherent explanation of why this versioning was chosen. I am only 
working from the QCA 5.4 downstream sources. I don't have any 
documentation for the silicon

Alex
> 
>> +
>> +       .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
>> +       .phy_status             = PHYSTATUS,
>> +};
>> +
>>   static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>>          .lanes                  = 2,
>>
> 
> 
> 
> --
> With best wishes
> Dmitry

