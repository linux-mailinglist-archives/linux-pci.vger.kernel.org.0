Return-Path: <linux-pci+bounces-134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2697F4BF1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DAD2813C0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5044A99B;
	Wed, 22 Nov 2023 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkYWOhe1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0741B9
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 08:06:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5098e423ba2so9771292e87.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700669195; x=1701273995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mnjxkuXcJXDP3gMcUiN4SEisCT0v2zuVwcrjlWRarE=;
        b=bkYWOhe1zQAxdhDha/XA7tBEed59jgBW3wP4X9ukDhRoY0aImCgkA3W9s1LslC0fij
         DfoGyN69GDgIKeXo1ENUVrmaOlVCBNq3QAVsk9fwjrXWur9R0f+xeSOGWLK0J191MsdB
         uo50wp2ii1/ndUVB1pPr46vShUtgrE8+JBxuvo5DCYuIEDd+3JBLjwlaE0UALpbiWAmb
         bHlusiIQ216XekhfmNe21lZNXTXdxUAa2e79TesKG2TRbj8eoLx82cBi83v9olNoA0bA
         gvY7z9NQ41AXNkoYZpC015c1tF7FzgEq77/GuR22IDgxZ4vR4wrn07jfMAD/BDXjV5vT
         KqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669195; x=1701273995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mnjxkuXcJXDP3gMcUiN4SEisCT0v2zuVwcrjlWRarE=;
        b=lnYftDVtF2oF4itZMYbU6TLZ9btdmAAIzSr3gpPEUucTD4BTpwzjGUt+Nn9jwZg3bB
         xMsgO8+soa6CvO5hmo0a2OJ2GyGPGAWgbQoaOLxBTHXBV8ElgInXB6VkX18m4TizpNhZ
         qvvjW7iAHU5RbkmRgN/fTHxhgU7aONM3yQi0ETRlq7XX0gl7hAzRQ/F1XPcF4g+TxJD+
         V+jOk8hLdfie0D9AJzZ9s4jpumARSEKD1xEdpsL4/ynTL7C4cnpgKazJiTQDj0HUiM9H
         PxZ/r0wcqwoQQbPjoGdCnUmKsPcVXm3UXdO69u7IZNjPR6hvHEdtX76XHcBySSLY/H76
         cGjw==
X-Gm-Message-State: AOJu0Yxq+lurT1vc9dT2wnqHa73spDI2l2st8aN1uFw3ljgGwM6kPygM
	Lq/6w+sjL/N+ghDEBsN0cFGW4A==
X-Google-Smtp-Source: AGHT+IGaNfHxXIOdW9aMrIlLdqSxyYzkqVLUEMRqiJsmE52M/h5sAhBTzkEagJpEnoMpbW++YBXC0Q==
X-Received: by 2002:a05:6512:3ca9:b0:503:38f2:6e1 with SMTP id h41-20020a0565123ca900b0050338f206e1mr2232652lfv.5.1700669194676;
        Wed, 22 Nov 2023 08:06:34 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b0050943cf9cdbsm1878694lfp.307.2023.11.22.08.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:06:34 -0800 (PST)
Message-ID: <c1d14c70-6fee-48c3-81b1-cd6d422e31d7@linaro.org>
Date: Wed, 22 Nov 2023 17:06:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Content-Language: en-US
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mani@kernel.org, robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
 dmitry.baryshkov@linaro.org, robh@kernel.org, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
 quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: *



On 11/21/23 15:38, Mrinmay Sarkar wrote:
> In a multiprocessor system cache snooping maintains the consistency
> of caches. Snooping logic is disabled from HW on this platform.
> Cache coherency doesn’t work without enabling this logic.
> 
> This series is to enable cache snooping logic in both RC and EP
> driver and add the "dma-coherent" property in dtsi to support
> cache coherency in 8775 platform.
> 
> To verify this series we required [1]
> 
> [1] https://lore.kernel.org/all/1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com/
> 
> v3 -> v4:
> - added new cfg(cfg_1_34_0) for SA8775P in both RC and EP driver.
> - populated a flag in the data structures instead of doing
>    of_device_is_compatible() in both RC and EP patch.
> - update commit mesaage and added reveiwed-by tag in commit message
>    in dtsi patch.
This series looks good now, thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

