Return-Path: <linux-pci+bounces-5287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFD588EF57
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B58A1C289F9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0721350;
	Wed, 27 Mar 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJKj/KXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E0150983
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568231; cv=none; b=XNV9aEu+SVKrFgcXGDODYn2h2Z+PoZK2Nx9S5o/N5j9bMEpPRvb75WKhKOAI6xTUwCDhli26MjjToV4jOoxZ2EsOe+6gFdNr45XtkP4gUrOAwQV3ASpO6+KYj6E0GoklI15B3yj90tUo10HdR5pO7buXDKzhAsltHfBddqiDx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568231; c=relaxed/simple;
	bh=3oGmH2jG0eLuQD39ybBoUf/MFkybfkYMHfa6XQxQ3+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCQr/PF3cRybZ/3AJGmuZ1zyIaUC+ewCh9hwyGiB2dMGcxNHmhnBM2JW0mHlneIjYCKi4j6+LDCvBRrtUxtvT/S3EBDiPUsMhOPnda31HNwptM7gZ3/yixNIqz8hIPjV/MApqK5n0iD6IkOQXaolWix8OtLuifPanO+0kb4y/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WJKj/KXw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a472f8c6a55so25242466b.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711568228; x=1712173028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4T/B+VzBjIp5hRTTUsSLTcK3F2fOLlbjWnZQngFg5ZU=;
        b=WJKj/KXwQL49rnyqiIG3sWPvk2l05/wA+9/15kn/6cZPFrWKBsYHPqfI5iiQSHCmcp
         uXue/mO1KdD3la1LqpaHyeVb+K9LXgszaUp4cvJkrTIZXjHo7BXAEW1YkEq8Cl/gPNc6
         /oapSodGsnzsCeMLJKwt2hvvRBzB+EihW+/uWa0JI57nw7XsJkm7k7vSjMt5AxCHz3mz
         B1xZWvparkk9KLHKr87sz+vY9OjQpC01qSzQ34UFhkNR5Qz+Ds7TdwHaAa9c6E3Is/pl
         TY5coq61OadUY9fg6qCKeZ3q7rFo013N+baSFHngEB8kb0waeFgsCgQpkjT3BTY5U/bL
         RqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568228; x=1712173028;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T/B+VzBjIp5hRTTUsSLTcK3F2fOLlbjWnZQngFg5ZU=;
        b=krXeCkYiFBqLoQD7oNIQO8VSfPXAKaPmr9RTydtc/LHH3qlmPNTzoALVzxGFUu5E8K
         zZ++fnd1yHnJ1WCj4PvRyWzpxMGUqXCsaqepMMzxO9U+fs5je/bCv5OBv9/LAvw2Pfui
         /BsRzGFtlDqlylm54SBBKl4UzYjbxEZZS4rGB8Cx96iyu2wBk367t/RVxmlOh9hrVIwX
         I9VygDGd496HHU3p4wrzTi3RNW9EZIOoL8KAv5mX/mPAsvmktY1Ca3uaq+Ls7luQvDN/
         VMBs6kGakZz/UwD6eeUXeKAaiWTuttDtgXf7gUqtX51zASbNtDRp8Td2jejw2P4gvNzO
         /Rsg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8bHvq4fjFFd4t0z9VeAp7Xucf14r37XAd6MxYYFw85H/S4n/UJItCcsBO3dHl7PT+NQ5WSgSHnH4AEjV81fHboWOZBbAYwxB
X-Gm-Message-State: AOJu0YyoqKEU80S6TJ4YH0CbOtX+jh5WwKgUQmAxwelqKaOtpC1gyqEa
	RtWr43lJvSU4P8vysTgTzsI9VCjhFQRJfbwctZRBksuSMWPW5II8jb5YFshQbeM=
X-Google-Smtp-Source: AGHT+IFsk8GCWOEwMowsrVcmDSuO4DptdbCJiKVpNb2Akf6RhttP0MkwZhgNrWajwTPm3VPOQHv+TQ==
X-Received: by 2002:a17:906:5fd8:b0:a4d:f9b1:6e7d with SMTP id k24-20020a1709065fd800b00a4df9b16e7dmr286185ejv.76.1711568228023;
        Wed, 27 Mar 2024 12:37:08 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906265b00b00a471481ef3csm5715694ejc.124.2024.03.27.12.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:37:07 -0700 (PDT)
Message-ID: <653f43a4-c05a-4086-b87f-abed88dbb28b@linaro.org>
Date: Wed, 27 Mar 2024 20:37:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
 <20240210-topic-8280_pcie-v2-3-1cef4b606883@linaro.org>
 <39f28d21-e178-68df-c7b6-eef30f0584e3@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <39f28d21-e178-68df-c7b6-eef30f0584e3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.02.2024 5:12 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/10/2024 10:40 PM, Konrad Dybcio wrote:
>> Currently, we've only been minimizing the power draw while keeping the
>> RC up at all times. This is suboptimal, as it draws a whole lot of power
>> and prevents the SoC from power collapsing.
>>
>> Implement full shutdown and re-initialization to allow for powering off
>> the controller.
>>
>> This is mainly indended for SC8280XP with a broken power rail setup,
>> which requires a full RC shutdown/reinit in order to reach SoC-wide
>> power collapse, but sleeping is generally better than not sleeping and
>> less destructive suspend can be implemented later for platforms that
>> support it.
>>
>> Co-developed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]


>> +    if (pcie->soc_is_rpmh) {
>> +        /*
>> +         * The PCIe RC may be covertly accessed by the secure firmware
>> +         * on sleep exit. Use the WAKE bucket to let RPMh pull the plug
>> +         * on PCIe in sleep, but guarantee it comes back up for resume.
>> +         */
>> +        icc_set_tag(pcie->icc_mem, QCOM_ICC_TAG_WAKE);
>> +
>> +        /* Flush the tag change */
>> +        ret = icc_enable(pcie->icc_mem);
>> +        if (ret) {
>> +            dev_err(pcie->pci->dev, "failed to icc_enable %d\n", ret);
>> +
>> +            /* Revert everything and pray icc calls succeed */
>> +            return qcom_pcie_resume_noirq(dev);
>> +        }
>> +    } else {
>> +        /*
>> +         * Set minimum bandwidth required to keep data path functional
>> +         * during suspend.
>> +         */
> calling qcom_pcie_host_deinit(&pcie->pci->pp) above will turn off all the resources, setting BW to 1Kbps will not make sense here.

This is preserving the current behavior, it may be revised later.

See ad9b9b6e36c9 ("PCI: qcom: Add support for system suspend and resume")
that introduced it, in a perhaps overly 8280-centric fashion.

Konrad

