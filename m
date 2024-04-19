Return-Path: <linux-pci+bounces-6491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8538AB5B9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 21:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AE3283678
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF813C916;
	Fri, 19 Apr 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOpu8SZX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3A130AC9;
	Fri, 19 Apr 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556070; cv=none; b=lY/541etLHNAROF3eIf8Mp7Mz/mLXx7J8k8TixnLavwYZvGnjN89O4srUoq4/v+/yI+WASdNJpoMmv6LxdC0evsqeKOopfPnMgQ7NBWCL8si1O7MVakEFYE240ES96o0yotXgi/TJlsvqtnSLWS0QgbQzrwJyo/zGyAYcOSz7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556070; c=relaxed/simple;
	bh=vxSFVWoszOg906Gyk6e2+rg6u4xyer5LWjUtQqFZhNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f1KNo9Nr2g8VKrW83Gth+RgVZNExPZ4QTIPEXqByE66yi5ABYAASKT9AGxgD0R8by/G+2fByc94c0CS9Jh1jn2cT0ARa6LZimiwN8g2peHEJo6oONhnft88c1P20u+uIXEi4UzvtUVUoiv5mws/DG74uBTTAV3vyIj3wAo45STs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOpu8SZX; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ac90ad396dso1268780eaf.3;
        Fri, 19 Apr 2024 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713556068; x=1714160868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4vt7WxL+lftWXnOyyq6W0xqoiKJI7AgK/HIHDISMe0=;
        b=NOpu8SZXcwvPIbK3/1xUCupyJHZX+O68gp9sHL+/KE2+N3UWDEACxLhY66f50RGBd0
         FqVACxxc8v9OLRUW0ChodI8QTFMl2SoPGq7tfuic3tlnZ+lEbmM324smIspzpd9usP17
         oXR/2Mbtm2rNf7Up02ru1mEp/Hn3eY6br6y1AJfkGmr1zqrFgZDFSvfFBE9HxmOEgaHU
         yxpeWBbEAWUwnWVcUVhpw9eH7Psv39yYbXQXHKms0LSWuaZHZsXI2IRX/xDdVJF7e3oI
         t1Ds3wN9PRW7JyVsqDVliXGMUTjpNn34iF7os58PTCyQHWK3mz1BvysBJz/ybjAw2WFb
         tKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713556068; x=1714160868;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4vt7WxL+lftWXnOyyq6W0xqoiKJI7AgK/HIHDISMe0=;
        b=YcPPzfcxy/1XfTN+F2IQklst1LrVsXegP+TphBHfG4BeG/QfxgyQHkXrikM5Vcrrgq
         rtw9g2tR3IdGtgn0o+lWYqrOlR/PIKlFqiegYyssey8P5L1so2r/F6Bwx3DyQOxmb6O+
         mcMolCWUUTx1A4S7BIoP9PpXvmgnNHrT9s/pAlCKaiKftUuSgeqoNP5hHO8bVUUirdjx
         wYqUHLHqTf1h4RvY/cex+XLjFvE3RtQJ9d/mEdoawC4wXV9MKjxF808dVQSWlP36DT9N
         b1ulfUUt5pMX9zBXy8r3rFLRH36UxNPaRuYZkZYjEF3hK9JwAWIyKqQAYOrkdKTBgkVI
         cbSg==
X-Forwarded-Encrypted: i=1; AJvYcCVregBbHh9PGRnum3mxLMrkm4uoOXb9y//qxPioXGIdRTp4DlRIzUdDVCSZBACZyYS5llxJ551D06DCcllt5PlbH5tOVsph9TMxbRSMzj0xwwzLouwBr6b5QlHgwx5SVN137WrwmvivHXzpLpp84qMPooBgfb0ml55zLkEIvNY8PtWXNWmO2TiOJ1G9UE9Q7MxrSg3r9Fg+qORIOHqo6n+XoCnG2xfhr9O0EPVPU7D/4lvwdQOGSLmK+FpmqAg=
X-Gm-Message-State: AOJu0Yy8CBHyPf2G9pnugdYcFYI3fXhwMdp2Nhdy9GxansF0nvFlji4q
	UOgGJUSclCQTyic9ewC4K7oq4jqdXtaa7qcHkMfUlz++dUzmzz2Y
X-Google-Smtp-Source: AGHT+IEDlJm01IwxYEhd4mG2VdxP367p99wmW6HIUobwNqmHPXu3dYCDLfA/eRy045Ex9WRUvDBIcQ==
X-Received: by 2002:a4a:98ce:0:b0:5aa:3e8e:e1f with SMTP id b14-20020a4a98ce000000b005aa3e8e0e1fmr3384337ooj.5.1713556068066;
        Fri, 19 Apr 2024 12:47:48 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a06c2000000b005a49df78628sm966302ooj.39.2024.04.19.12.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 12:47:47 -0700 (PDT)
Message-ID: <c498f5b9-df07-0802-800c-67c18dcf3e67@gmail.com>
Date: Fri, 19 Apr 2024 14:47:46 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/7] ipq9574: Enable PCI-Express support
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
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
 <4a83afeb-8e82-4f95-b44e-74d39d55f448@quicinc.com>
From: mr.nuke.me@gmail.com
In-Reply-To: <4a83afeb-8e82-4f95-b44e-74d39d55f448@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kathiravan,

On 4/19/24 09:28, Kathiravan Thirumoorthy wrote:
> 
> 
> On 4/15/2024 11:50 PM, Alexandru Gagniuc wrote:
>> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
>> addresses pcie2, which is a gen3x2 port. The board I have only uses
>> pcie2, and that's the only one enabled in this series.
>>
>> I believe this makes sense as a monolithic series, as the individual
>> pieces are not that useful by themselves.
>>
>> In v2, I've had some issues regarding the dt schema checks. For
>> transparency, I used the following test invocations to test v3:
>>
>>        make dt_binding_check     
>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>        make dtbs_check           
>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>
>>
> 
> Alexandru,
> 
> Thanks for your contributions to the Qualcomm IPQ chipsets.
> 
> I would like to inform you that we have also submitted the patches to 
> enable the PCIe support on IPQ9574[1][2] and waiting for the ICC 
> support[3] to land to enable the NOC clocks.
> 
> [1] 
> https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
> [2] 
> https://lore.kernel.org/linux-arm-msm/20230519085723.15601-1-quic_devipriy@quicinc.com/
> [3] 
> https://lore.kernel.org/linux-arm-msm/20240418092305.2337429-1-quic_varada@quicinc.com/
> 
> Please take a look at these patches as well.

I think I've seen [1] before -- I thought the series was abandoned. 
Since we have the dt-schema and applicability on mainline resolved here, 
do you want to use this series as the base for any new PCIe work?

Alex

> Thanks,
> Kathiravan T.
> 
> 
>> Changes since v2:
>>   - reworked resets in qcom,pcie.yaml to resolve dt schema errors
>>   - constrained "reg" in qcom,pcie.yaml
>>   - reworked min/max intems in qcom,ipq8074-qmp-pcie-phy.yaml
>>   - dropped msi-parent for pcie node, as it is handled by "msi" IRQ
>>
>> Changes since v1:
>>   - updated new tables in phy-qcom-qmp-pcie.c to use lowercase hex 
>> numbers
>>   - reorganized qcom,ipq8074-qmp-pcie-phy.yaml to use a single list of 
>> clocks
>>   - reorganized qcom,pcie.yaml to include clocks+resets per compatible
>>   - Renamed "pcie2_qmp_phy" label to "pcie2_phy"
>>   - moved "ranges" property of pcie@20000000 higher up
>>
>> Alexandru Gagniuc (7):
>>    dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
>>    clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
>>    dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
>>    PCI: qcom: Add support for IPQ9574
>>    dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
>>    phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
>>    arm64: dts: qcom: ipq9574: add PCIe2 nodes
>>
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 +++++
>>   .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  36 ++++-
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  93 +++++++++++-
>>   drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++++
>>   drivers/pci/controller/dwc/pcie-qcom.c        |  13 +-
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
>>   8 files changed, 400 insertions(+), 7 deletions(-)
>>

