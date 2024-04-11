Return-Path: <linux-pci+bounces-6147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529308A1E38
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D42C28C966
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312EA4597E;
	Thu, 11 Apr 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD+uR9et"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCE3F9CB;
	Thu, 11 Apr 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858446; cv=none; b=rUC9d0TW2Kw7M6JrVNynXZdQ/U40aDh2I6B+3bjTV9RHK/AUa8ob60ke7gTThkyAgILdCivmthKFuO1I3OR5uvGCOePJb3qjqo31sLNckhzbf8V87awcHUG4GNFbB9/uw3doa+Bt0PbqFK6C50MBt7qMiYSDWOPeOwCJ8BieU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858446; c=relaxed/simple;
	bh=hzu/tgfoKXjQQl4hxSegoZdRQDXbBvEYoIa+xvPtr6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiMbhqvIU6M+6BuoLsbtPuRUCO4YIEW4G/58Jwqs8w1xyOIOHUIMyK6Z2Zy1QYkDuP8Je7W1UZCy/gEJ44d4z6txfTl0Zgp8dVKwodbvx2K8c8AHyE0qpZoX+vUmK34hRpyi1q4OyG888pP0gAjhwZxlBDZ4uh0U5GavZxRDDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD+uR9et; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a522ae3747so42057eaf.1;
        Thu, 11 Apr 2024 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858444; x=1713463244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKygXtwLt+wS+6rSBXso592J8xpcFDOvcPaDL6jZh3Q=;
        b=SD+uR9et6Kb/+yml+Yf9wTYW/FG6WhOaW17WaB4eZ7dHDxSJRHfPsSGav+M8beEQRj
         KRBw/fIKt+16leHTc+6iQKfnti1bb5+3DtcOlJk9JdRKvzV7N99fscgr08TGtU47AMDN
         YGNBbzOrY41JGpkbqzwYWDtgYygU+kWe6eCqNXG3m3TT3svGhaGhAbo6Ext8pBB+R51n
         Jm0Z/XcSwKus3iZQnw4zCXsnVoTBqxNAEDUU2BSIWjWduOx/v4xo3Q77oyQVq9/Eg8xS
         7A8zd1BtmqYlxoxldOsmPUw6Tuco6A9bt5omaM53IcCpcNrvG+FSwn3F1qnsWRGc16ut
         xFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858444; x=1713463244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKygXtwLt+wS+6rSBXso592J8xpcFDOvcPaDL6jZh3Q=;
        b=TEgs8OMUd1xJJkH7s/FIpk4KZOPto1MIQh79fFUoe9aAjDPoLKvGKn5EXgowbkkwNK
         d9gMfRJnU7AB92p1JfacfrisCcSuPeMCPOQgb+G2mDcIgKcw9InnXEmbFQsNlevqHSSd
         B5NVmOhjlPPzkFRaR2mhBYwRLPcVchBlGU/YoV/qQZdMDF4x4heFcCr8jFotNo1KVuik
         6XrnaWzACkemA1Zrn+NRu2pRMOejf/1lwmJywOT8Mnpv0AjxFqE+IsK0hlmpNxbKbODA
         +uu2YdgQ0+KolbpBLR3uNYb7O7iMw39HMB9YgUa6RW9s5SCyUqFm0f5JxAMquJaU4YbQ
         nlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOr8aOHAEQ/hVyHts5KaDOPl/ILk9yDemiRjM4zPzjws9yVHdtJtmxOijvIotElJToAj0fTXOGq19jrhmzEoATGFAotNP/zQ5lD4cLrbFLviO3rsMkKCzyNYTrCj91RNRtq7Srgs1pa5QyGUCRM6ixxHv2EA4sSdZzLa1eZuNCaEKj3A==
X-Gm-Message-State: AOJu0YxkhCjwwU0Oa6bsX03KyVh7L5Cg2aLyQ0+y6TlsfpWocEfUnYKM
	WDICsYudERdqBdDXuojwSsuhE+aZCmPYwaAEQAoSvR9Sv8pvYZHxCoefFd0yvPQ=
X-Google-Smtp-Source: AGHT+IHIfdBtJkYCx5rE45KA+2haYhADyvJn3GY3HPvd1BH3bdEIc+Uy9kKIPRg1ZCeBSxTh+j2QEQ==
X-Received: by 2002:a05:6820:270d:b0:5aa:344e:f419 with SMTP id db13-20020a056820270d00b005aa344ef419mr176666oob.2.1712858443708;
        Thu, 11 Apr 2024 11:00:43 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id di12-20020a0568201e8c00b005a4bcb155basm407718oob.23.2024.04.11.11.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 11:00:43 -0700 (PDT)
Message-ID: <bcb03c7d-f566-11cc-21e2-47e5c5a0776a@gmail.com>
Date: Thu, 11 Apr 2024 13:00:41 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe
 controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-4-mr.nuke.me@gmail.com>
 <dbee301e-2e31-4db0-877a-96c972ea4bca@linaro.org>
From: mr.nuke.me@gmail.com
In-Reply-To: <dbee301e-2e31-4db0-877a-96c972ea4bca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 15:08, Krzysztof Kozlowski wrote:
> On 09/04/2024 21:08, Alexandru Gagniuc wrote:
>> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
>> The only difference is that the "iface" clock is not required.
>> Document this difference along with the compatible string.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 34 +++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index cf9a6910b542..1915bea580d3 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - qcom,pcie-ipq8064-v2
>>             - qcom,pcie-ipq8074
>>             - qcom,pcie-ipq8074-gen3
>> +          - qcom,pcie-ipq9574
>>             - qcom,pcie-msm8996
>>             - qcom,pcie-qcs404
>>             - qcom,pcie-sdm845
>> @@ -397,6 +398,37 @@ allOf:
>>               - const: axi_m_sticky # AXI Master Sticky reset
>>               - const: axi_s_sticky # AXI Slave Sticky reset
>>   
> 
> Where do you constrain the reg?

I didn't realize that was also required -- the make checks should have 
picked this up too? I might be invoking the tests incorrectly.

I should add the ipq9574 in the same list as ipq8074-gen3 and ipq6018, 
correct?

Alex

