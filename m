Return-Path: <linux-pci+bounces-6490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09668AB5B3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 21:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD0B1F22A34
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986D13C913;
	Fri, 19 Apr 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNp84dBc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAEF9D9;
	Fri, 19 Apr 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555880; cv=none; b=bDHa08iCdSBV+5sV1uYA3ytGNqhCRT2+gjWV6WqK4AbIZKjDtoUf8dlSUZYv4aiagp07fw9NRAZuatPlX7XLseWto7wz/yaVURzRP66l1I2E5RwRbcUfrvSMak0eKlvT3ClkRE1GkOykYOovcACO6YlAhogKod+iL4BubMGIr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555880; c=relaxed/simple;
	bh=i6tzshrxouG4GHxMCjPCZ87XlDWmHs+s+JkYc1k6C5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2grB+2yRu8wrSe1q9jvVHVhZuXnu/0aWT7Oq3IdMvL2D86M+on7jJ6T11PsPj9jy4SztaCgt2j3dUttFH1bAMc5pU60pEEFopv1UIEg2Yx6Mx/UVWzCR2RUPS3k/1Kn4/xbJZOikpgX+g6YwFCTGzjc4w6jgxPmU6mEY4df7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNp84dBc; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-234cbd333f5so1834193fac.0;
        Fri, 19 Apr 2024 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713555878; x=1714160678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1BGAYuhr6Jr83/QJyI90NsvCbuHw5i7BYScCO/Al8w=;
        b=lNp84dBcDBEr/EjjhROvauRjF71umYQluS9htGInZG9izurctc5NzdZycay4cc/j7Y
         NDGBMq80kPp1TbnDMl6WGhyfmy5iPE7hGZ8BqmyJ/gKSq5kAU0qtaqPjBLedW177v1bq
         YBafYmHVdTWUQnnzGTIV+hfkN3Bx0LhVwg6cpdtFd5I5MAcCRyH2xJ24v77JJKgF6BSQ
         fa2A3XqSNetx5nHqgULfZHCuLWa+jt/LYK7+pYNG5t301Q4RSLvCUBumjlV1wGkV8Ief
         MGoKaNXSP97k+xsKEKdzu7pbbzEPFVLafhjTaleOGo4pugDFr72aZioiYH8XBHkGC9yC
         gJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713555878; x=1714160678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1BGAYuhr6Jr83/QJyI90NsvCbuHw5i7BYScCO/Al8w=;
        b=LKwmfFhxexRXrgvleBhaQq+4sbl0JmIOXKePGP+vw0u/Z9WZez1nVMxT1wZ1cuZZM/
         cQMTDc9v6PTALIrAe5hT8VMFu0aS/KKP2aP/8kUak9em1+fbkjz+GSqfANmgml0oiVG9
         7zIABO4e6li/AfjrIWaf9v7RddXiiMDlE3YDwMDtvS1PuEyBA8tNYyNEyuXqqMSf45Kd
         dTtbFsZHUesye37Gvcyv+1q2AUUsiqIND4itez1mjZyVnCNpdKNpOYrY90ldywqG1yY7
         WTZa4WGZL/ouTnmoSeGVvfo4enwdf3Dttrr3AyXd48Xky2TvIuMDa3BSIyP5f2+jRpYy
         9XwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfySUW8U3+/hufKOrUMSXUj/RFQCvGOAUZGf8QZrNVhu0XD9curRjVpxyBjb+U13xCz3XuwjP4lxWYNu5VpVzuxq0ri9Lsl+1CG/JfWXDPqeXj07EdV9lWM7SwN55d9kSCHniRsXlR0WlJJi+07UrWFouij075yuJTFtZfvmdMDsuwhLP1CutJw9CErDsTqMEUgQ9QYobuwJLBt5oW/BB49hwie6VGFa98ks21pDBtZsZX5uo83C02QdVr17Q=
X-Gm-Message-State: AOJu0YwgsaN9ovjsoE9Xl/HaYFR7NVanOfY//+sa+lTwqF7uCBnRbv+F
	vET1M787+2P+ZTpH98r+CfZkRw9xI0qFUsKHyQD7+lvIwU71jcag
X-Google-Smtp-Source: AGHT+IHseVtPGmY+lrtZnP4ORatX7mqfP+JxbR+E+KFQHqu5qkdPApEXoEstZaCDMmG0pP6LwJb0sA==
X-Received: by 2002:a05:6870:3119:b0:235:45b9:dfca with SMTP id v25-20020a056870311900b0023545b9dfcamr1177207oaa.18.1713555878592;
        Fri, 19 Apr 2024 12:44:38 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id pq4-20020a0568709c8400b002349fc4cdedsm940798oab.49.2024.04.19.12.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 12:44:37 -0700 (PDT)
Message-ID: <102f209c-3367-86ac-c583-73103d5510a9@gmail.com>
Date: Fri, 19 Apr 2024 14:44:36 -0500
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-5-mr.nuke.me@gmail.com>
 <CAA8EJpqKWJBqDUacE0xTLzxny32ZTStiRgXsd2LBD=Hou_CRBw@mail.gmail.com>
 <3cfc26e6-5587-d4a2-f217-1a30169ad1a0@gmail.com>
 <20240417070616.GB3894@thinkpad>
From: mr.nuke.me@gmail.com
In-Reply-To: <20240417070616.GB3894@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mani.

On 4/17/24 02:06, Manivannan Sadhasivam wrote:
> On Mon, Apr 15, 2024 at 03:07:02PM -0500, mr.nuke.me@gmail.com wrote:
>>
>>
>> On 4/15/24 15:04, Dmitry Baryshkov wrote:
>>> On Mon, 15 Apr 2024 at 21:22, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>>>>
>>>> Add support for the PCIe on IPQ9574. The main difference from ipq6018
>>>> is that the "iface" clock is not necessarry. Add a special case in
>>>> qcom_pcie_get_resources_2_9_0() to handle this.
>>>>
>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 14772edcf0d3..10560d6d6336 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>>>>           struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>>>>           struct dw_pcie *pci = pcie->pci;
>>>>           struct device *dev = pci->dev;
>>>> -       int ret;
>>>> +       int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
>>>>
>>>> -       res->clks[0].id = "iface";
>>>> +       res->clks[0].id = "rchng";
>>>>           res->clks[1].id = "axi_m";
>>>>           res->clks[2].id = "axi_s";
>>>>           res->clks[3].id = "axi_bridge";
>>>> -       res->clks[4].id = "rchng";
>>>>
>>>> -       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
>>>> +       if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
>>>> +               res->clks[4].id = "iface";
>>>> +               num_clks++;
>>>> +       }
>>>> +
>>>> +       ret = devm_clk_bulk_get(dev, num_clks, res->clks);
>>>
>>> Just use devm_clk_bulk_get_optional() here.
>>
>> Thank you! I wasn't sure if this was the correct solution here. I will get
>> this updated in v4.
>>
> 
> Please rebase on top of [1] and mention the dependency in cover letter.

I am very hesitant to depend on another patch series. Is it okay if I 
include your patch in v4 of this series?

Alex

