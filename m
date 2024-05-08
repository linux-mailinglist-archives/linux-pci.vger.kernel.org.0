Return-Path: <linux-pci+bounces-7253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755CD8C02A9
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CD41F23FCB
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2111CAA9;
	Wed,  8 May 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf8SNRKh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD379F6;
	Wed,  8 May 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188208; cv=none; b=AeAgD5KgqqwciPmIt7XJFkC7Pm6NYCEwbdnUFYWnJgwSJsKGK1/3lnc5plzIcE5ePErfNaGfVfDMKiJ6x6HtxrSnzISEEuaxqO5Tozfwmg1jFpHpQDhjZhBP5tTcAZ0ElXuZszOWZHOy0MFaAUvM9bH/N6DYSyX9HBFsrBexAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188208; c=relaxed/simple;
	bh=kbeunpMSITny5luugMdBxfupTWkQtM3EwE3HVl8RXss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZMvZCMgl7gwebGl+4tCeVRpBCyQOir45Ta7XFkStktmLAislIJbfOl+ksddFxyri3XqCjHqx2WK4j3Ga8vT65d0YHxK6YlO8f9rBIQdMNgWe1VW2GbLgMmjVHlX0Dy3YofZr1pgriFKU1XYcXo3KlQWTjGBU314LebyLbIfxIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf8SNRKh; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23f55e2e908so6568fac.3;
        Wed, 08 May 2024 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715188205; x=1715793005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnfoPIfYoKS2yj9dWrB2Bm7sN1KAr4/Uj2UFG5/Y+uE=;
        b=Uf8SNRKhlvQkcioFwlWuBrqJ5l1MlnW9GAhr/XGoV4AXFwEWI9awYQopsgDig1fSdQ
         XEzRodq2BmaQ4jOtZ+6/BiCpitHYsQDGDnnIMJNhfEQUfNr4e6deyJ0Ae7/tyGLRyxyP
         /AVU7qtGU0uSPMkcNUUOuJQ2xuaKtgHaAJOqWglh3ILvXTT1qgWICuwNsM4cw2Ylcxa3
         VMbkn+n+XDgsPdTI7rztdjZuleR20Iw9O42TN+GooPa6hdivgiztT4muGMUuGohudeEe
         j3kAWdLOxwcn4H5zc3jzsaPDqwHiItwlFob67kgtEXEPWs+/IXkJkpMhLoj3Qs2Hzkam
         eXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188205; x=1715793005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnfoPIfYoKS2yj9dWrB2Bm7sN1KAr4/Uj2UFG5/Y+uE=;
        b=gwGC610777N3CH0Py2TGbqFGoW/QO6xcBcv4upa+7nR7/nhIGOTYAPY3Z5CYjjgf0E
         8CHbk+ejL1mnaFjtAjt6eQay+B0FxfVlRtyIKop7tFIczy5mCZ1/RcuTC05k6vvRjsPp
         2Y4qu2F54iDEodPdgp3xZgPJhUmg7ZlpjnHY3nT7zNKbrGqVd9ni7qUl5A1+jckdMBBQ
         fw4kSX2UscqMHRCjOShgZowmbVYruh+ioRjbB3Dh/iwJDoMQ8RwUtyjNsGF6ALy/VFFr
         IvQ9JIa/G6+FjJnsBm8UE/XZT0UXgzzF4c5ApnAv216JKIBcBYTZxZMFQAJbXPiEHdKO
         kyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAQqspI3qdLyMaVzmkmM7JC31KWNwTPtEx4pY7AaEE343SnUxJl8VV0qAXIEHt9kl9MEFSkaGl4nNKbf/WpLoaYOCe10tB7cnivYRNNsOZAhdSYFeK8oJkVuig89AtKjXiZlCBzEAlGUZHPmcJ2nU89sKr/nbPo0pNaT8gvql1228Q9a8bJ4RM8BZDXSBduLRXfK2xmNx7TIFrVMZnlknVQ1uOoikogE5Cr9j0t8t8QG1qfTalPyCahwDRRi8=
X-Gm-Message-State: AOJu0Yx0TT5mF08YWpRkxo9rb8z9R86hEoIN6QA4/32CNzvFcECFVnP3
	Zxws8B7zBP7uY0R0berXSpbpruL//z+dV3lpHPciu578cLK/KS61
X-Google-Smtp-Source: AGHT+IHhy1QdaK8wxtjp6E+xo3gR/HOstaZfXmZpR7oXzX9YW0REQY+LknB+sjCBs/ondJxCa7FRbw==
X-Received: by 2002:a05:6870:530a:b0:233:56e5:ff99 with SMTP id 586e51a60fabf-24097c7122fmr3440543fac.23.1715188204005;
        Wed, 08 May 2024 10:10:04 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id pi22-20020a056871d11600b0022eae2de4ecsm3029084oac.51.2024.05.08.10.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:10:03 -0700 (PDT)
Message-ID: <c3f99ece-7f66-4c6f-a262-4d8894154ae9@gmail.com>
Date: Wed, 8 May 2024 12:10:01 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 0/8] ipq9574: Enable PCI-Express support
To: Devi Priya <quic_devipriy@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
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
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <569087fe-e675-41a4-b975-2d01d95b6d3c@quicinc.com>
Content-Language: en-US
From: mr.nuke.me@gmail.com
In-Reply-To: <569087fe-e675-41a4-b975-2d01d95b6d3c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/24 1:16 AM, Devi Priya wrote:
> 
> 
> On 5/1/2024 9:58 AM, Alexandru Gagniuc wrote:
>> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
>> addresses pcie2, which is a gen3x2 port. The board I have only uses
>> pcie2, and that's the only one enabled in this series. pcie3 is added
>> as a special request, but is untested.
>>
>> I believe this makes sense as a monolithic series, as the individual
>> pieces are not that useful by themselves.
> 
> Hi Alexandru,
> 
> As Dmitry suggested, we are working on enabling the PCIe NOC clocks
> via Interconnect. We will be posting the PCIe series with
> Interconnect support [1] shortly.

I am generally very hesitant to depend on unmerged series, as this can 
cause undue delays. In this particular case, I considered that both 
series can continue to stay independent, with the ability to convert the 
PCIe users to the new clock scheme when the time is right.

> [1] - 
> https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/

What changes would be needed to this series to make use of this? How 
does one use the "interconnected" clocks?

Alex

> Thanks,
> S.Devi Priya
>>
>> In v2, I've had some issues regarding the dt schema checks. For
>> transparency, I used the following test invocations to test:
>>
>>        make dt_binding_check     
>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>        make dtbs_check           
>> DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>
>> Changes since v3:
>>   - "const"ify .hw.init fields for the PCIE pipe clocks
>>   - Used pciephy_v5_regs_layout instead of v4 in phy-qcom-qmp-pcie.c
>>   - Included Manivannan's patch for qcom-pcie.c clocks
>>   - Dropped redundant comments in "ranges" and "interrupt-map" of pcie2.
>>   - Added pcie3 and pcie3_phy dts nodes
>>   - Moved snoc and anoc clocks to PCIe controller from PHY
>>
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
>>    arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes
>>
>> Manivannan Sadhasivam (1):
>>    PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks
>>      from Devicetree
>>
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    |  37 ++++
>>   .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |   1 +
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 178 +++++++++++++++++-
>>   drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++
>>   drivers/pci/controller/dwc/pcie-qcom.c        | 164 +++-------------
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 ++++++++++++-
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
>>   8 files changed, 469 insertions(+), 141 deletions(-)
>>

