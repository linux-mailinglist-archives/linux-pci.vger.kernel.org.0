Return-Path: <linux-pci+bounces-2129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F382C75A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 23:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A128851F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23A18057;
	Fri, 12 Jan 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqw1iPxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637618045
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28b1095064so773361166b.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705099027; x=1705703827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0leS6hZ0DcZYl4DKzwe7v8pus4rqe1fDKXfntZRCqTg=;
        b=dqw1iPxvpYN9NH+wq9oJMl1pId9u400cfxeXrZdeHZrt2YDF0QeUC+ZN1VLn/9rQpd
         uWZmxztyzsawbjd//0VmhpRMFEwBnNmKA0laGPNF/OACeTSdApK8tFkC3OYKVOnSqbox
         O15mkhVK9NEY7Ylv455Q60v/ig7jRRy87V92Uw6hwFUslOzoF+s2tmriuyR+Ez+N1pxX
         VmsEGaxR8ZSQjxRMIvkydJPZV85BfCsjQOeRkc1206H7qvtjoRYrNnMiOpPJc9NEbohj
         KMJMEXLwLQppPzNFIG7zeulMNB65AZCryrI8u13qziwGa9d6oUOpoRBhUwPqFgz/WUgt
         c+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705099027; x=1705703827;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0leS6hZ0DcZYl4DKzwe7v8pus4rqe1fDKXfntZRCqTg=;
        b=BB2+cL8n7s/Py9X7M1si/Prfqv9kLqICJPl8fZqqbTVfxKb96gXeg69YpuagVfjZi5
         1u0JytkRdOXl/K4PxpWijvMYHv5UwmxmGD+VltPeStLDXDBb9hvCrPvobjlZJ/pkvtVN
         Fc/KHneY7Ef2H9yv5yjfREhKoMJAgQSJOKx+9vQyERO4SCirWrUl30x3usQYtYcUsayV
         7c8cEhZgyVLfiSsglEsbYUEVfgRmBfn3GqJpaZZq+lVHeWzqV2JnvidfogrnEHgX6hfU
         C801ae/UPfVMYVApa3IRrFR3jmoPHseD7JbNUe5lLg05UvA+XhIcCt1R5Oijluqi6os2
         jZ6w==
X-Gm-Message-State: AOJu0YyTW8wwfWxFe/2z1QI/qjPN5Z9CJzhFW/gmHkCkjfH3s/YqO9lB
	WH2Frj5iBEGrZArqKpHxQFSMmWrRLSyB4A==
X-Google-Smtp-Source: AGHT+IFYfL+XbWBb98zkfcqsCfe55RxOOq99xlv4gLhqJrYEridFURPMKn+2U5mwNzzeZSOYqQAVfg==
X-Received: by 2002:a17:906:c094:b0:a2c:4b7e:2c27 with SMTP id f20-20020a170906c09400b00a2c4b7e2c27mr574752ejz.250.1705099026524;
        Fri, 12 Jan 2024 14:37:06 -0800 (PST)
Received: from [192.168.174.25] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id i2-20020a170906090200b00a2a04c9226asm2184486ejd.194.2024.01.12.14.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 14:37:05 -0800 (PST)
Message-ID: <c278d89d-4eba-4ea7-8cf5-6b1de90dedbe@linaro.org>
Date: Fri, 12 Jan 2024 23:37:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
 quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.01.2024 16:59, Johan Hovold wrote:
> On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
>> CPU-PCIe path consits for registers PCIe BAR space, config space.
> 
> consits?
> 
>> As there is less access on this path compared to pcie to mem path
>> add minimum vote i.e GEN1x1 bandwidth always.
> 
> gen1 bandwidth can't be right.
> 
>> In suspend remove the cpu vote after register space access is done.
>>
>> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
>> cc: stable@vger.kernel.org
> 
> This does not look like a fix so drop the above.
> 
> The commit you refer to explicitly left this path unconfigured for now
> and only added support for the configuring the mem path as needed on
> sc8280xp which otherwise would crash.

I only sorta agree. I'd include a fixes tag but point it to either 8450
addition or original driver introduction, as this is patching up a real
hole (see my reply to Bryan).

> 
>> @@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>  	 */
>>  	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>>  	if (ret) {
>> -		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>> +		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
>>  		return ret;
>>  	}
>>  
>> @@ -1597,6 +1612,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>  		pcie->suspended = true;
>>  	}
>>  
>> +	/* Remove cpu path vote after all the register access is done */
>> +	ret = icc_set_bw(pcie->icc_cpu, 0, 0);
> 
> I believe you should use icc_disable() here.

Oh, TIL this exists!

Konrad

