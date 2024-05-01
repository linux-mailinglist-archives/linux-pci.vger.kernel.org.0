Return-Path: <linux-pci+bounces-6980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA18B9215
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 01:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE431C20FDC
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 23:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB65168AE4;
	Wed,  1 May 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEwmYYd2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663B165FDB
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605232; cv=none; b=DHer1I/FscJS8iHwMriNjeeLUNdUYGTeaYmnnkyRrudlp0anccWC0lCWaW8Ac78S/QB4DHCt2YsMmLaVaanAraNazqLWJnvmYvCSfLzl9G8KBOiBV4stvAwWgPy8NDJqrZbM20ZtIAExOFxOaJ0n0W9cTnAWe74k1aOA8iFtkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605232; c=relaxed/simple;
	bh=Jp5j7VAsVFbBco8tSe/QBTxiO2L2qNjnlYyph8TEINU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVZuS66agtJm3utClr+rMDSN1dmDZJQ6QPeo1hqn9uGbkztOqX7A+jd0PzoRdwgtrGRPezJozuSsSx067z6Ki2sVkyqU56K6UDvsQctyzW+98wTeNiU3e9QO8u7GgAGieLHgVc5r3TV7VMKSwiHWxeKHKgaVB4NAEfwXgSfNL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cEwmYYd2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5200202c1bso939272966b.0
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714605230; x=1715210030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp5j7VAsVFbBco8tSe/QBTxiO2L2qNjnlYyph8TEINU=;
        b=cEwmYYd2eGJgJo8DYjDWvcCGv68Hzs4IBBDJLGfc5AePnC/yv22daJGjG9GHwE3udW
         yoURiL9o8leCa6nAv0ha07JBpthMs1aDWuh3livgDgxLxwGVbHBwHBlXrFqusx97fa5x
         7AxLoQWnTGGMgvc7UaLaUOX65p4AMIGRAYUw5H3nZZTSxZL0OuTgc+5fOob/caZRUxun
         srw5Vr1e4ezGkzS5oU1fNaDxXvxc7Iwz/R8ejkUyKPc05zbo476UbPbf0Ch3RNj+ls9a
         oZlrMKCUNq/qd4D3eBo4AhvOv/Ui2WRqWegVVMNx5iccjji7CVHGUn0zri6IuPEllqsY
         ALkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605230; x=1715210030;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp5j7VAsVFbBco8tSe/QBTxiO2L2qNjnlYyph8TEINU=;
        b=H9n/Jb4/NI7+5YW+6J9v/wBrN7TymtnndBRd5eVE202sLgWXoRYja6MbhR+L+GbtPY
         Un3BF7e9rCgsVuquRnQfp8113XRdO8TEXXtPz9HCGZMTcm5uK2bjYpsDIu6gfhhOY/2L
         uttGD3f/sQ5DNwqk71w689LzNH8ws/JmZt5utBmJKHwgSN8IGL5lyHBh5AHUAwWjECFJ
         ZTQotRU7N26Y6XIpmwEd6S+M+OMB1D3xuqOSneeiWExXFcjVmJMF5vivPFmJY4/8TLxY
         Ic2MZhLuw7t5WnG8UgoAtuAWWxoBJbV07KoYNiuH3agkxGYhx1M8sODshglIMydLFd0t
         KEiA==
X-Forwarded-Encrypted: i=1; AJvYcCUU4CqF7BV2b2EygTNRT/LlMLv2Nx5+2QRF7flE9Bh0hFKE2vLh2MrsYRjIGio+fn+8TGxUcwmnqhGkt5QBIwbp/2KBFqXsEZRy
X-Gm-Message-State: AOJu0Yyem+ouzGztkW92UyVb61OtiY1EYmUtZLvamW9/MUNMmFjD9ZSM
	MrwtHKVEsZZIFjtEjkthQNCoceCu6t5kQbL0vN9YRbUTLB1UpVE+mVSptFXNL6s=
X-Google-Smtp-Source: AGHT+IExWqXN6g2T7SY8JNtnknwKEW5mG45BY2T0TJuAt/4o10r4NoWhLjn9eNQ+drkTypV8TMBiTw==
X-Received: by 2002:a17:906:e08:b0:a55:5ff4:ff4f with SMTP id l8-20020a1709060e0800b00a555ff4ff4fmr238868eji.71.1714605229754;
        Wed, 01 May 2024 16:13:49 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id u14-20020a170906b10e00b00a5534758ef7sm17073698ejy.148.2024.05.01.16.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 16:13:48 -0700 (PDT)
Message-ID: <5a9a0c90-d191-49e1-8cd5-1d45c82040ac@linaro.org>
Date: Thu, 2 May 2024 01:13:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add rx margining settings for 16GT/s
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 agross@kernel.org, andersson@kernel.org, mani@kernel.org
Cc: quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-4-quic_schintav@quicinc.com>
 <02ae9e6b-b652-433e-b36d-e6106d4fbcd1@linaro.org>
 <53c0e508-60fe-ee5d-cb2b-a5392c330377@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <53c0e508-60fe-ee5d-cb2b-a5392c330377@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[...]

>>>   EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>>>   +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
>>> +{
>>> +    u32 reg;
>>> +
>>> +    reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
>>> +    reg = MARGINING_MAX_VOLTAGE_OFFSET(0x24) |
>>> +        MARGINING_NUM_VOLTAGE_STEPS(0x78) |
>>> +        MARGINING_MAX_TIMING_OFFSET(0x32) |
>>> +        MARGINING_NUM_TIMING_STEPS(0x10);
>>> +    dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
>>
>> Since this is DW-common, why is this inside the qcom driver?
> Though this register space is in dw-common specific, these settings are purely vendor specific . These settings are determined by systems team on vendor hardware, as these settings are used as margin to compensate signal variance due to various physical factors(like connection length, retimers etc).

Okay, so:

1. is the register layout vendor-specific too? i.e. are the bitfields DW-common?

2. will these settings work on all Qualcomm devices, regardless of SoC/board/
retimers used etc.?

Konrad

