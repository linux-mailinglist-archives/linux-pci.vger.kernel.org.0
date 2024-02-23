Return-Path: <linux-pci+bounces-3950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270E861EF7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A142CB24632
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB6D149399;
	Fri, 23 Feb 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PURqn84J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC04146E9F
	for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723534; cv=none; b=QBxxdyyAuqq4wPLAshZWb/bgQT7XP9lKvejP0ZIZxtbMk1WycJ40Qq0oComDEBB3K3XYkNGq940JYdurTYOVY4Qqtrj3WXiUq+IVLLFnHA2UNBC0brfyZ7aBpsMnGIPa6CB95cauPL/merfypKEeqLvSv2MkZXxfk0Pt8r1K2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723534; c=relaxed/simple;
	bh=CNHDyfwlt03n62yBOKPS0AUUGIsNT/feFufpk7g6Ghw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeCJAZzLpeiVLms4U57B0TvFj145NryiVqbgm50kaJx6EV1H0ZgeAWWknmUNK6O64AdYrjuV2TJ2CUnbDOBjfVWLJ5LSbaGTeItqFSziMCbN0jzrrWXkq76EesMXtOfsVz6aYpZ9BS+BIr60vgz8gZEiLZ0J18NhQJluIqSXKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PURqn84J; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso176025066b.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723531; x=1709328331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YENr2GX006db0nPSIDpDV3ZqHJlP14oWdul/SVN/UQ8=;
        b=PURqn84JVz7Phvto1cT96UY2AUf7W8oyjvn9H4dscG5IJPOtbqKSI7HpviUacQw738
         xxZh0U4LwiVyY58CLn8iAHpzFbnP5CGltg6661LbaD6YxLwhmf6KehvsXVWr1EUMow9f
         0j6AmnTOX9h3rjWHQncm2pr1QDXb6+jZyvzsUhlD12Uguz4zTt/REFsve7Jh/qGzjNgK
         b8f6ReAsH3uhbcW+JofOh+JtcYYuG9NaHueeoUmkrqe1EYlUFqv2/B8VuptAv6BFckcM
         lfcM5bsB7GAl8AmHlFL+fFM3V/TcW+l26hBgd3bZVlT+liCMpyaARvjByRK6ky6CWKnV
         ODag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723531; x=1709328331;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YENr2GX006db0nPSIDpDV3ZqHJlP14oWdul/SVN/UQ8=;
        b=ItvuGTPRg727EGroCaNbOQ1GTJWSGjE9LQY63tH2nvYe/YIbUxgN7ZA+nwc+ld7k+E
         /AAk6WjssYKzacxmPM8sJjKSEt5a5YjPV/RzjabOvb1iAnKDQEv64dayFHDm1qo11wgA
         V7HGf5RSLzeuvmhnkypYjfZzBsZsxfHh02L59BKVFYSnlfjtaZbZVM1alvCahu94Ge1w
         oyIUkRXSjxSl9ybjV/ivNRTCqk/2lFbmSDDmuGp9sWDPyYXlE/X8Y+B1vOyXTM4y4YP3
         PhOtm7507rhvDG9zdtdm2LHpcI3ryg7YQUrNpgIrA/gCwJI+JJpHRTmULDaA4apXtar4
         Y1cA==
X-Forwarded-Encrypted: i=1; AJvYcCWOLkINKY30zlCo7aQvoXErnF+l1NpG4hljA1rzt1ki5crHdjNlEGuhOT3xYElQPNkr92O7qsXDK41olfLgukVCpft/Qha+ybRU
X-Gm-Message-State: AOJu0Yz1VwGmBsBxZ2T19RsQL+SUKWBvPMrgVb1kkMhOrR1ZIJilAXGD
	Bl66PCDmc10hpNXrRt0x5S6yP8oFAx9jC9pSg78/bjrFB5HkfvQpg3/d4JJVYLY=
X-Google-Smtp-Source: AGHT+IEmURTcq2H1CfKMg2jMpRWdTBeYNihNzBc2w7JG/0XDmDaIcor57QFET4qryhjNbNwmjTFAbA==
X-Received: by 2002:a17:906:78f:b0:a3f:c4e7:68aa with SMTP id l15-20020a170906078f00b00a3fc4e768aamr646932ejc.65.1708723531039;
        Fri, 23 Feb 2024 13:25:31 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id pv14-20020a170907208e00b00a3f45b80559sm2738150ejb.139.2024.02.23.13.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:25:30 -0800 (PST)
Message-ID: <9642b70a-6b7b-4561-9924-d11ad979d57f@linaro.org>
Date: Fri, 23 Feb 2024 22:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] arm64: dts: qcom: sc8280xp: add missing PCIe
 minimum OPP
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240223152124.20042-1-johan+linaro@kernel.org>
 <20240223152124.20042-6-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240223152124.20042-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 16:21, Johan Hovold wrote:
> Add the missing PCIe CX performance level votes to avoid relying on
> other drivers (e.g. USB or UFS) to maintain the nominal performance
> level required for Gen3 speeds.
> 
> Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
> Cc: stable@vger.kernel.org      # 6.2
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Please remember that we should remove these when OPP support
lands :D

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

