Return-Path: <linux-pci+bounces-6911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1A58B8221
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2728B22D3E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4A1BED86;
	Tue, 30 Apr 2024 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW8dCX+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA01BED71;
	Tue, 30 Apr 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513902; cv=none; b=ELg/wn7FrO1EYxinMFOObejYiNN5uuhwKL/ZT3Hykx6zO2jRBaRYcpkm4vfiqmMVxYFE73LF7P69g4GN6KgeG0qipI32IjDJ4Bq0v8o6grNOeWoTwhIWdwztDhcJ/mWhx3mYcnI9Dq5RiD8A1B/nWUXhni9vUCtHsdrbBlsmLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513902; c=relaxed/simple;
	bh=AHo5pLY36JKBzhqxXOfYKgdr5geeUT2uUCRca3Y7Opo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se3IJ91C0NSNjy08lnyfjb2/RSfK386NtxDPsr8h7DUJ2n18xF/97OAoICHmkqRsPNKmMfRq157qayKbdCNw4bLJetH31XxseWZhQloTC82WCen6StMXvYyP090jqiBG9C6b2ccYla+2cx5CD6SAebAeWX+QIh997mOdiIg0+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW8dCX+p; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ad2da2196bso3384847eaf.3;
        Tue, 30 Apr 2024 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714513899; x=1715118699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6qd8lJvJh2hrhUBJz33E1gMQnbvjUgqj9rCB8sm/gc=;
        b=XW8dCX+piKvfvyXazO+X93xKA7b6f3V85JpHtSNqK9TiNce9b0u6ifAiGAzxX5w6K1
         rYLSESBVN3GwcLimGJ4wd/1mWEcJr2okcWplaAZNB4ztAAOgspFDRK8JjgIHVIWexaye
         gGNjv21UQN2j9O53UkBjbZ12IhO/7A93G48ZZQi/hLdR+Yp6TsX8SAAJAxDqadByYbjX
         XpPulkOeeTfyQ6i7mzTSyv0h3kNohZaPQknaQ16lmogTphynfuj/pednPe8mJnSH1Vra
         kDCtjd3XK87hzC2Tf4glJb3jIlhwACcao3vm3KIU02pNpjaVKTKBvYDqH0pAXNwLVlSv
         1f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513899; x=1715118699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6qd8lJvJh2hrhUBJz33E1gMQnbvjUgqj9rCB8sm/gc=;
        b=HRZMG7djou66s18fN7rfDy+/UjCxFP2u/aNTzclFtxnNZec7lTml5F15tHt+7rdWGR
         3n3JEQv3yp3Z6qVUYz/lsLYWMH56dp0DEC01fmMuMviEP0Cd0nK3m/vcwjhE2oqm+z5A
         rjupmWTlO3F+/TIFP4P2bTXK+mwPn5/CxOh4cZWV96YI0ZMyr6pfVZCYq5LbKabEH+hc
         cIqrDSMS2cW+gnQg5qNZo9xv6x016wS0h6TPpNz1yg2rQNUVSu4HDXM/sMXIo568By0G
         P/PQne2NoNc6RUFcMFmFi+GMYszehriQZfMtAGqizt3+257iniG7A5H36Sg6UoGfukIo
         t2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXEaNfEzsmw6fQVkKCkS6Ndgm6RvM5EQBQOBJ+ofU7bQFT+UQS8K0cpGagFtp0U8cSH1Wwyhgtd7Zgh6RlxNaLk7XgeUS715EGR0bv0jRSUENUbxS8fbnmYtWhmEAoVOf2Fz+lnOXuPUol2C4afaQpTNJb47AwZdPltkPTuJXLKA+/ilrkhMwF8Ge0Wtc6Lg7abklfY0L87IU7cPX1zGdGf57C9D26zkFTCEBryUZLk987DVXrqCM7HkffqEis=
X-Gm-Message-State: AOJu0Yy7omsQ31gHyn/GRfpQSlB7GZtrNHGN0YQasabW05anbMiRlJxL
	34FXtI66otstxXpCfiDf0JzrZQgTLh3YRqA761UYXEemaRPbPQDMc11SqzxOUr4=
X-Google-Smtp-Source: AGHT+IHW6bYHhn8CohYrr9D+kQrfwgZyt3rb3ReMqW6TPOXzhq+u1mceFtChWghqHxrVWoqCKD1mtA==
X-Received: by 2002:a4a:98c7:0:b0:5af:c4b3:7c6d with SMTP id b7-20020a4a98c7000000b005afc4b37c6dmr691177ooj.5.1714513899564;
        Tue, 30 Apr 2024 14:51:39 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id bw12-20020a056820020c00b005ace4142e7esm5575325oob.46.2024.04.30.14.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:51:38 -0700 (PDT)
Message-ID: <9d9c569b-2e9c-4fd3-9a1a-50f198bd0884@gmail.com>
Date: Tue, 30 Apr 2024 16:51:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2
 PHY
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
 <4a7b1e1d-ac68-4857-8925-f90c9e123fd1@gmail.com>
 <CAA8EJppGW=qyk2P6Z_S=dp0njsCjqZaXjw8qU4MY1HOZR-N=4A@mail.gmail.com>
 <Zi88Hdx6UgBo/gti@hu-varada-blr.qualcomm.com>
 <CAA8EJpq+Bbws8yH5Xq7rHyA+-=DaCcfEcgUa5RUt2+LWQW0kKg@mail.gmail.com>
 <ZjCQM24T2XIJ6GAR@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: mr.nuke.me@gmail.com
In-Reply-To: <ZjCQM24T2XIJ6GAR@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 1:31 AM, Varadarajan Narayanan wrote:
> On Mon, Apr 29, 2024 at 01:55:32PM +0300, Dmitry Baryshkov wrote:
>> On Mon, 29 Apr 2024 at 09:20, Varadarajan Narayanan
>> <quic_varada@quicinc.com> wrote:
>>>
>>> On Wed, Apr 17, 2024 at 12:50:49AM +0300, Dmitry Baryshkov wrote:
>>>> On Wed, 17 Apr 2024 at 00:25, Alex G. <mr.nuke.me@gmail.com> wrote:
>>>>>
>>>>> Hi Dmitry,
>>>>>
>>>>> On 4/15/24 16:25, mr.nuke.me@gmail.com wrote:
>>>>>>
>>>>>>
>>>>>> On 4/15/24 15:10, Dmitry Baryshkov wrote:
>>>>>>> On Mon, 15 Apr 2024 at 21:23, Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
>>>>>>>> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
>>>>>>>> being reused from IPQ8074 and IPQ6018 PHYs.
>>>>>>>>
>>>>>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>>>>>> ---
>>>>>>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>>>>>>>>    .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>>>>>>>    2 files changed, 149 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>
>>>>>>> [skipped]
>>>>>>>
>>>>>>>> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem
>>>>>>>> *base, u32 offset, u32 val)
>>>>>>>>
>>>>>>>>    /* list of clocks required by phy */
>>>>>>>>    static const char * const qmp_pciephy_clk_l[] = {
>>>>>>>> -       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
>>>>>>>> +       "aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
>>>>>>>> "anoc", "snoc"
>>>>>>>
>>>>>>> Are the NoC clocks really necessary to drive the PHY? I think they are
>>>>>>> usually connected to the controllers, not the PHYs.
>>>>>>
>>>>>> The system will hang if these clocks are not enabled. They are also
>>>>>> attached to the PHY in the QCA 5.4 downstream kernel.
>>>>
>>>> Interesting.
>>>> I see that Varadarajan is converting these clocks into interconnects.
>>>> Maybe it's better to wait for those patches to land and use
>>>> interconnects instead. I think it would better suit the
>>>> infrastructure.
>>>>
>>>> Varadarajan, could you please comment, are these interconnects
>>>> connected to the PHY too or just to the PCIe controller?
>>>
>>> Sorry for the late response. Missed this e-mail.
>>>
>>> These 2 clks are related to AXI port clk on Aggnoc/SNOC, not
>>> directly connected to PCIE wrapper, but it should be enabled to
>>> generate pcie traffic.
>>
>> So, are they required for the PHY or are they required for the PCIe
>> controller only?
> 
> These 2 clks are required for PCIe controller only.
> PCIE controller need these clks to send/receive axi pkts.

Very interesting information, thank you!

Dmitry, In light of this information do you want me to move these clocks 
out of the PHY and into the PCIe controller?

Alex

> Thanks
> Varada
> 
>>>>> They are named "anoc_lane", and "snoc_lane" in the downstream kernel.
>>>>> Would you like me to use these names instead?
>>>>
>>>> I'm fine either way.
>>>>
>>
>>
>>
>> --
>> With best wishes
>> Dmitry

