Return-Path: <linux-pci+bounces-6546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6858AD89C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 01:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A32B24540
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824F1BF6DE;
	Mon, 22 Apr 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdbztOch"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B81BF6D9
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826752; cv=none; b=CL7Eo5RWOwNLTFNmVL2ofcBwTo/lALzeDbyE3xsfE1Oi9JUsDEyfJJYWNbmLkroFOB+fAx6AgvQ+JQu7PVEVGFj2bNG4468ar7IxCemaYTTOJgULlAcqTVhlRNTtWGshuWFdkmeb6EO2QvTvfX7YzuRsrXWJ3bi4qgNPvK17LLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826752; c=relaxed/simple;
	bh=A+pjZaVNLZlD4+785iXCBInD6tY2++kE/rsQCAPKzmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mddd8i9nnMr2W0Dyo+3rFC5TllvyhUxy4cIGTEDtyilSxllQn5TAQcan41/dDxHzJFevM5+NJHNPAL+tvUuDpmT+pJjKHB5dtdQc4ZKF9hEMEhyWrmc3glxeKdy3TB1BT95qRTjlrc+ee2qf8i++z0lI4S/NvxaqHhXU1qgiJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OdbztOch; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51aff651083so2605387e87.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713826749; x=1714431549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i01WWc8FrMY19HordvhidcNrQ81jJpkn1b3/nH/zGe8=;
        b=OdbztOchHf3JvCMpJveFDo4fuOqiK/LSD6pKRX+H5pZkD/tRLIziDHMtdD+ce3iaGz
         hH1JOSMyNGOZWgSLebbxMxF3YR5F0CywOBK+GPc6u8HwiukWDGsYy2nKC4KjDMVhYJjR
         +M4AKMPx6SHMk2eVxvrXDrw782KclyQd5qrQzQqEU+Q61W+rrmZ8F6XIawbiPRGGQqGb
         kq87zrf9E9+2cnmSkkDCIsD8VVSaSlWr/vyc60cOrBx96hSUqHdHNn+4V3DLjA6LuVL9
         Lce4X3IsVAykQ6/m0S02eLtpWsKeEF3jMXQfSsQY9gh90fi1xn6n50GI11vCqwYBfnx7
         ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826749; x=1714431549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i01WWc8FrMY19HordvhidcNrQ81jJpkn1b3/nH/zGe8=;
        b=fBNZqt8XlPptpXX6IAxJvejjd0mbiR/A+sP1enSTnc8h42euHvGtbOHJZ2b7xZ0BSl
         oX0LC5tiPIndFmnYb5Wd10irOkFKq2uFzNxiKMPUq7XSr+yzNzfbr4xYUw9Hibw5Eibr
         WyHoEvrpmSUVOobx2qUZeC+g1GGu7P6NC5mz8BJcE+eVYpSQ+5hEtav/dRGpmJvKXy7S
         Cu7u5ca1Xz1W5u3hWnqy52gp/NjA/AbkHPebETWTjIfdPWqAfsIxl5v5VrR/TUdaxyPZ
         oln2g9DkZepQ27xDeyvy8kGgD03r1W47RHslS/M/1glJpaSgoJCvyNy7TruIwjWOPN7K
         SpOw==
X-Forwarded-Encrypted: i=1; AJvYcCWtYahYjzVV8UfShs0az3eNSbes3w3KNDRTZudlSBFng6TQamix3rqiEkTHnNEr/5W5PA/HIbr1E/+qg+xaqGcV0dMphM92hJRa
X-Gm-Message-State: AOJu0Yzf9N/VIGW69Ie7/zNBoIPAKBiOogUoQL15d0iseKuSxCjQtojQ
	nCPusWpaLJp0jkgR/m3iNuusob6pzH3oRIww7fpcB5q5OYhi9gCtFJDcVbkXOMw=
X-Google-Smtp-Source: AGHT+IGM2GumwwiC2694i6yrlX+WVqY6Xo2siXBL73bwpoR1PZgNJjl6/DE+91yXjE9Has4vCfMkTQ==
X-Received: by 2002:ac2:455c:0:b0:51a:f362:ab2a with SMTP id j28-20020ac2455c000000b0051af362ab2amr4281198lfm.59.1713826748840;
        Mon, 22 Apr 2024 15:59:08 -0700 (PDT)
Received: from [172.30.204.103] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b00516c580b640sm1863304lft.13.2024.04.22.15.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:59:08 -0700 (PDT)
Message-ID: <3f595432-83ad-4513-a24e-87e8ed45eba6@linaro.org>
Date: Tue, 23 Apr 2024 00:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] PCI: qcom: Add equalization settings for 16GT/s
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
 <20240419001013.28788-3-quic_schintav@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240419001013.28788-3-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/19/24 02:09, Shashank Babu Chinta Venkata wrote:
> GEN3_RELATED_OFFSET is being used to determine data rate of shadow
> registers. Select data rate as 16GT/s and set appropriate equilization
> settings to improve link stability for 16GT/s data rate.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---

[...]

> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +	reg = GEN3_EQ_FMDC_T_MIN_PHASE23(0) |
> +		GEN3_EQ_FMDC_N_EVALS(0xD) |
> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA(0x5) |
> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA(0x5);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg = GEN3_EQ_CONTROL_OFF_FB_MODE(0) |
> +		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE(0) |
> +		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL(0) |
> +		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC(0);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);

Also, any chance we could get some explanations as to what these magic values mean?

Preferably in the form of a #define for each one

Konrad

