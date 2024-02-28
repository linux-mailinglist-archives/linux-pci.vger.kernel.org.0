Return-Path: <linux-pci+bounces-4183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5E86B127
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE4B25AE3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B01534F6;
	Wed, 28 Feb 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0uS9TbR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C31534EF
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128937; cv=none; b=rMN6moPI1/5GLylrfsYTC4raXZ1oLz8Uqiatqux8Ijh4ELX7QIyZYKCXYsFO5CfYJjdFIkZmbWF7t3dDNdGAM+/i1GGxdbLLZ7eyVMDXkVve58KLJ9+HEpi3H4vI2w3bdisAA4/Z37njwsxkGZTxaV0k4KdzsfjMpNpamHbItsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128937; c=relaxed/simple;
	bh=wttVcvvyazg/mrRyaOZJCd7pvncVIAniFlA3qhdMgGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksYci3hK+/rxGoniqWL5tdbCRDz00W8pFnVr3UAFTNYrL+sGWokQFTztpbMrQ6YKsRYqwvnBxAjR/p817ddwah3mvHACiB2ke+5Ygw/NN/PPveHVKLlY/l6JrOepcEe6XordOfwZvd35kx+MWmJCmRBogqM4CDi9qe3CrOBDFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0uS9TbR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so1714945a12.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709128933; x=1709733733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gqsun0Jf0TCpfJuW3oP8yfzJJU2GyOX68ENXwQM6Yxk=;
        b=u0uS9TbRBnfObH8J+wRAaEptmVgWgEsjCZ7ZFzwEXYttVQL/YkkX+xXy2xaDgmupPu
         bmUbImcHFkv/oLUWklwKJhKia6jJsUPQZs+f1z4BrqJvddgCL+BKR39cqrUD625He/Ey
         HpAoTv2VgBajTYOBEAVnWmIdKxjmN51cAzV0ePmOug25hmBvEQ1xuQvEZnYD4+XcIz//
         pkOR86Cl0Ju3z+5LSXjc8nNDG/axUvdCkR/5DmmJ9pCuQUYubDlb9PPmgbI9o57jgJe9
         xRTiYTtxTpbm36EtPU4y1MDEU3RezhtO6ifnvSQNGB45oj7gzaQ3UfJJJ+6gIcz0URTB
         DeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128933; x=1709733733;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqsun0Jf0TCpfJuW3oP8yfzJJU2GyOX68ENXwQM6Yxk=;
        b=ivDQ235nIKP9gHH9/YmuRXOqQh2vu+KSIz8LcMxivccYQclSPQ+IDkjWbaEMukO8vk
         3yYx1jhxxzlqTpombI0pdZG2PHHQXj/QuMbbewvqv1EKvu7e9CmIrxjZPrKJLyeXHHpH
         Y/Z8+G9w4jTFK26A+yEwxTDMM8qPn7OYxYNIddnJ2aucDCTf+s6MUJAzc7TLpqtp2rcU
         6/jra/ETA5QALdHJXo45K0g23rdpVuuXgVmPZODRz4C96krOxQdiAVulhCQ0N/pgrCto
         eXS29vIRKtDOGIp+xtWc3rsxckpOJBVjGIWhjEUB3fgDsRMiAESo1YUf3Z+QDWwou94b
         g2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVKIY4LlTv9Ggu8HTB+TLB1i+GqS/pdlcTGwvo39T7VlUH9S/mmnpB9+WQoECgb9SsXpTJ0SVpTq+oD4BgFfyGVycigSYxkFrB4
X-Gm-Message-State: AOJu0YxqqCXGaOpZybTBu3yamdsjH335DgwZwHYOKumQiqEhbr7tQRAX
	G45xyMBRHPvzYSKcRylUuoZ89eS31vSUfRkVHCnbxGswPNhc4JICuuSi0ugNeTY=
X-Google-Smtp-Source: AGHT+IG1hZN76cDl47gQqABc9WcgFOoCeTOSbBQcmL4NTFKwZe167xf9RQB9554+xQvwGICRvKIPQA==
X-Received: by 2002:a17:906:aac2:b0:a44:1008:a014 with SMTP id kt2-20020a170906aac200b00a441008a014mr1183556ejb.6.1709128933518;
        Wed, 28 Feb 2024 06:02:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vh3-20020a170907d38300b00a433634ba03sm1888598ejc.43.2024.02.28.06.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:02:13 -0800 (PST)
Message-ID: <5d3f4c6f-b7cd-4da0-83a0-ef7429a4a902@linaro.org>
Date: Wed, 28 Feb 2024 15:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Content-Language: en-US
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
 dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
 <866ea7ee-54c3-4a89-981e-64d6d3b46497@linaro.org>
 <7cd328e2-6847-973f-c38b-93d1e64d3771@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7cd328e2-6847-973f-c38b-93d1e64d3771@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 14:07, Mrinmay Sarkar wrote:
> 
> On 2/24/2024 3:49 PM, Krzysztof Kozlowski wrote:
>> On 23/02/2024 15:03, Mrinmay Sarkar wrote:
>>> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
>>> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
>>> the requester is indicating that there no cache coherency issues exit
>>> for the addressed memory on the host i.e., memory is not cached. But
>>> in reality, requester cannot assume this unless there is a complete
>>> control/visibility over the addressed memory on the host.
>>>
>>> And worst case, if the memory is cached on the host, it may lead to
>>> memory corruption issues. It should be noted that the caching of memory
>>> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
>>>
>>> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
>>> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
>>> needed for other upstream supported platforms since they do not set
>>> NO_SNOOP attribute by default.
>>>
>>> This series is to enable cache snooping logic in both RC and EP driver
>>> and add the "dma-coherent" property in dtsi to support cache coherency
>>> in SA8775P platform.
>> Please confirm that your patchset passes 100% dtbs_check.
>>
>> Best regards,
>> Krzysztof
> 
> I have run dtbs_check and it is passing.

Hm, last time I checked dma-coherent was not allowed.

Best regards,
Krzysztof


