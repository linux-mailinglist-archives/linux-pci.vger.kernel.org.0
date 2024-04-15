Return-Path: <linux-pci+bounces-6295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712448A5C06
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946FC1C213B2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFD156659;
	Mon, 15 Apr 2024 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktxOt30M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D0811E7;
	Mon, 15 Apr 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211626; cv=none; b=mK4a9ysUIqyTlP/IBtPiBNGpDGGNqhmrRjgkMhU/wxlHLdwr8LZ34a3PuFkoxe+aX4jiTY6uSSJk1VsjdrM+GlQikgcu/U8EwocR1dpxzr9leNe/vCZUJ6MzF/jgNsnWvFBk7SgqzCSelAQ27LKt4ywioStQcG+Lvrl24ncVRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211626; c=relaxed/simple;
	bh=EvjfhVk/c8yZsy0HnC3NhQko6+kukkc1bdZ41WWDfgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMpJSF4oAwQ5+cekrCv+2bD0WyngNhSLfCxQWj++BwNVA7FqejY8ds1mXMzxiXeZAB1UNZFv65Wng/FENAb896yqDV0jcAMK2DfntfHIw031sSEzcvkm/1qf8Q7Q7qn9y0U+1++khf8cVrkBkIR7akScTiiA1GFSR5tICU7egbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktxOt30M; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c70999ff96so822176b6e.2;
        Mon, 15 Apr 2024 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713211624; x=1713816424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JifNvzD6ATOs7XbgsOAoHx6qPqu77eFLvyJBkWlhOM=;
        b=ktxOt30MtlT9T+60vAw+2pwCtaQ012E5NwJ5fqm0VS2HlNHoMkOjmpO0aIvYsuZ28j
         dCUricZsOmMS8bdJOP1LUDOoZ/iR73rLKipctTYzWL+FemRYhENW3K9n8jH+JDLRMKYX
         R3+LmK6/WK8w0wDbQBVgHaZttnBlAYfAXHuiN/+T0aGbOJuTd593q1UtUqvaYF3fQrTX
         9Efb0yaxoXjEay2fB2uT4fK2L3yDoKyOmrvtyBFv6y23MkkrnQPK3kGTMv3g0J6nD7wM
         YTzhppo3bna7OMT2UMnAaREFVussIdMlK+yd/KGD0sQy2+Y73swHgIraVuwVGwbw8Cgw
         QUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211624; x=1713816424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JifNvzD6ATOs7XbgsOAoHx6qPqu77eFLvyJBkWlhOM=;
        b=UgQXVZiAbnJ10ai+TmosaAnOjxbto9Iez5rbvsaBDlHzjBAsgV/ZyVKDsbAumTxvc/
         fZEPiecNoxVXjSI604G3ELh2FP8pI/66fmt2uBLI2xnTS6GRQLwJh52+olGHibe9Yfws
         LEid5GtxeWtD5W5+WxcFUH1iR/H70AVAANiAaJ/+Pqul3WAOb7u1hJNFux0OeiVklqoR
         do60GWQ5H7uLOP00f0XgEKFcr8bYJajjHSeWb0bWGtLMPV8s3n7CocSV7A9kn3jO0pMY
         6YrKzrdx1r0RkoTdbxdlHR4Zqsg+UXN4j12DLrQ+KgLO/GJKhyzjRoOZyiiWt0bLTJke
         iC7g==
X-Forwarded-Encrypted: i=1; AJvYcCX93rnrV9obXnDhqOF33LUFr+lT6mDgxCsMmbT/eCIYyu+P8vleuh6G3QOhbpJZVB1TKUIYju29lnqxCtOLELlIXm1pGmSKdz6Re9h0bZtxowoJePDGvrwUQiZqu0IeVRiLcsERhsQaEsYjlKVyv6DpRjM30GqBZwhGuCI8Pzp8mYGeFWfBvLKE/dlo/tEY32WpJuuGvgbFc98RN8U+y6Kh9xVjysGfb8NYuxPFGzNnArEJQIlWR8jbOGYXa1g=
X-Gm-Message-State: AOJu0YzaJda75D+WXQYEaQl4NnZDx/3MQ1lN43geI8mX+bhBCCH+aPG4
	VdvIWMRfJcwYpDvgNmwhTyIVX5ZENFge99+uIveVFIyrw2c3mFu7
X-Google-Smtp-Source: AGHT+IFy3N8X5eZmyOHaxpLK15msefQLyEskt5SJ1QGSSJgsfB/EzAOQUUeGT4MfulTZ3rIpNZyK2w==
X-Received: by 2002:a05:6808:b30:b0:3c5:e81a:b5b6 with SMTP id t16-20020a0568080b3000b003c5e81ab5b6mr11073891oij.59.1713211624554;
        Mon, 15 Apr 2024 13:07:04 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id e20-20020a05680809b400b003c5e679337esm1729084oig.47.2024.04.15.13.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:07:04 -0700 (PDT)
Message-ID: <3cfc26e6-5587-d4a2-f217-1a30169ad1a0@gmail.com>
Date: Mon, 15 Apr 2024 15:07:02 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/7] PCI: qcom: Add support for IPQ9574
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
 <20240415182052.374494-5-mr.nuke.me@gmail.com>
 <CAA8EJpqKWJBqDUacE0xTLzxny32ZTStiRgXsd2LBD=Hou_CRBw@mail.gmail.com>
From: mr.nuke.me@gmail.com
In-Reply-To: <CAA8EJpqKWJBqDUacE0xTLzxny32ZTStiRgXsd2LBD=Hou_CRBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/24 15:04, Dmitry Baryshkov wrote:
> On Mon, 15 Apr 2024 at 21:22, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>>
>> Add support for the PCIe on IPQ9574. The main difference from ipq6018
>> is that the "iface" clock is not necessarry. Add a special case in
>> qcom_pcie_get_resources_2_9_0() to handle this.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 14772edcf0d3..10560d6d6336 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>>          struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>>          struct dw_pcie *pci = pcie->pci;
>>          struct device *dev = pci->dev;
>> -       int ret;
>> +       int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
>>
>> -       res->clks[0].id = "iface";
>> +       res->clks[0].id = "rchng";
>>          res->clks[1].id = "axi_m";
>>          res->clks[2].id = "axi_s";
>>          res->clks[3].id = "axi_bridge";
>> -       res->clks[4].id = "rchng";
>>
>> -       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
>> +       if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
>> +               res->clks[4].id = "iface";
>> +               num_clks++;
>> +       }
>> +
>> +       ret = devm_clk_bulk_get(dev, num_clks, res->clks);
> 
> Just use devm_clk_bulk_get_optional() here.

Thank you! I wasn't sure if this was the correct solution here. I will 
get this updated in v4.

Alex

>>          if (ret < 0)
>>                  return ret;
>>
>> @@ -1664,6 +1668,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>          { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>>          { .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>>          { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>> +       { .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
>>          { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>>          { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>>          { .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>> --
>> 2.40.1
>>
>>
> 
> 

