Return-Path: <linux-pci+bounces-3958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF78620FE
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 01:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1973228862A
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E464A;
	Sat, 24 Feb 2024 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLMTI8JS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051A38B
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733254; cv=none; b=Q6PwhFUnmxxmEBNxxMI2k5NsriYEW+z542c9pBhB0/wkHjD/6OFveJtGLZWoueSvFHa+bCTjFbuHS5zqxa85w+cbFLxdTcIsIiKwIt8UQcfemu7NjpCt+YDVgcQ8/hhJGs2/cQUBsz8Y6Z7fmPbrVkwqC7tQZ09TbzmilDKquNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733254; c=relaxed/simple;
	bh=2o21MVF3HyO3lY0XRfIs2jlh9WAVsOYPA8puXNidXdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNnHI4ny061cFPVP1fo7l9z3O2GXYGoAXawgU9LFu/bgWlKAty32Ix8cqtQOFTCEQFCBWxkWonjszvsTz4XXvibk84MYm6APYkuah+mIp6bfTX15+A++TZFhNWZesTxUcLktFYRsRnCkqVM4G4+IZ3xTX4Q+rD9MfxZIpH6AiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hLMTI8JS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so2533620a12.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708733251; x=1709338051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SOHcP8DrDhZ2e1SgGmWFGExWevqxMGqoGRYxVcIJl8=;
        b=hLMTI8JSpC6OyOCpDQqlWMeZMs2/xNJ+McMAZDnKJd+QLq/X/JhT90b5QJqGZlidyi
         MEI7Daan/CrTW/ifqAmmwkO87/aTRs6UTY29pZX7sXPI9vV2DE3AmDMkEMC/kEAidGFF
         IoQNJ6xTVOyLn59kduEdwnQa/2UXkJv8YZUKa+JuecC+eIugIJlVz0gOUbNZObD5RUYH
         D4NDAjLDunMTn24GV+NRYhDDz3Xk7aJdol+x8CqhRGPuEgJUoWlc1Kxb749WkdxhZhbp
         vvPv67SDxgvW3q7J1bMzI+WXfCS9Ddw9zP24WG9DZuHIRS7/NwYUw+zfpAtvXohAexef
         4kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733251; x=1709338051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SOHcP8DrDhZ2e1SgGmWFGExWevqxMGqoGRYxVcIJl8=;
        b=KiUuRidW+aAwi0nXsUwg+ip7MS+3pF5JSOwFUt3Dad4bEe6wAoaw51btGo7LvDNOqF
         ExnIrvbBlPpraodaTHWcBCHEerrY5rbvy0ScKLYCEZfwqvieiTS14rVMxyrnFb4Rtx6p
         mMmGWU6aa77N5Na+cpQbNKdOgaKRxUfA7TOXuR4T1HGU91a07vyE6iDJ8fU+4eBNkAoU
         57vhncnIWXj5T6Uvjyz4LcBsCbqg5YAgBDPD/5RAEPjLU3ntFdrG6sVWvyo/xxYM7d6q
         XPtN8VFeuKJVLH95rqVUSqwf7Sqyk/HEkgeYb8vsGHHLNkHaFazRnx8keVWNvhys+Ksd
         ICaw==
X-Forwarded-Encrypted: i=1; AJvYcCUs7YCiANwkFejid2KoVI178IipwGt1GUOk/8ktwVD/OAvFQuAaj/XYk3Z1lBGKKCuVWGs5gJae3DenEdYNbnDK0Cm0FbJZAo/r
X-Gm-Message-State: AOJu0YyAyvsRA+DdPRBitJ7KPEj4TQVUw4eQTOqJHza4ycR6gQ4Q614+
	s/HiDgjNbRlU01DiocMFtY0H/0Kw1jEmP4Ibd2NR/WSpS1qOa8SLlpjLlTgZcKw=
X-Google-Smtp-Source: AGHT+IEIadmHk63HemoRWWxsA7Fy0W6ljpj9vbzDd37Xdks0UbSJKjAuyBp4GlqH/FgPBWYb2ydAGg==
X-Received: by 2002:a05:6402:528c:b0:565:26e7:4987 with SMTP id en12-20020a056402528c00b0056526e74987mr1257577edb.5.1708733250749;
        Fri, 23 Feb 2024 16:07:30 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z6-20020a50cd06000000b00563918a48cfsm40041edi.40.2024.02.23.16.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 16:07:30 -0800 (PST)
Message-ID: <640775cb-3508-4228-aa94-2e4b7b6b2b6d@linaro.org>
Date: Sat, 24 Feb 2024 01:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P
 EP
Content-Language: en-US
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org
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
 <1708697021-16877-3-git-send-email-quic_msarkar@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1708697021-16877-3-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 15:03, Mrinmay Sarkar wrote:
> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that there no cache coherency issues exit
> for the addressed memory on the host i.e., memory is not cached. But
> in reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.
> 
> And worst case, if the memory is cached on the host, it may lead to
> memory corruption issues. It should be noted that the caching of memory
> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> 
> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 89d06a3e6e06..369954649254 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -45,6 +45,7 @@
>  #define PARF_SLV_ADDR_MSB_CTRL			0x2c0
>  #define PARF_DBI_BASE_ADDR			0x350
>  #define PARF_DBI_BASE_ADDR_HI			0x354
> +#define PARF_NO_SNOOP_OVERIDE			0x3d4

Any reason for this to be unsorted?

Konrad

