Return-Path: <linux-pci+bounces-4355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D085186ECF3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3287B24479
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8B5EE97;
	Fri,  1 Mar 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeMzM+rv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD645EE85
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709335856; cv=none; b=gzwLtl9yBZzlwjGrorCKZUyzZF0RdCrd01Aym6Tt2Plz7uD7veUpRYT1v7e7z4Gp5jzqEFRMrSegW86ECzKMeDfAQaKWT0bS2c2VLD8uLw5e1wux2lPBtAIdpkPVe+Kwr4OtjOOXlUIM7ee0kEY/Y2cgcHAFYFPZ21Ugd6Q++SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709335856; c=relaxed/simple;
	bh=oTsgYtX6Gj6AhaTLdGdnpkbEZbL/21pDgLzc4k6zfiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odUJ29Cw6kzFUtN7SeDbc6muCJ2UvpJc6VlGGL2wavHUwLHk3L+OG8DKOwimRTfBabMh1vXWduLCU+TBGpTudjbiPHhDvPtAmbt8cizGN1BY3ByF8fR4lmDw6eCXv0zGba4LGYFDd7UXs+3nZc9jBxXQ9MFoN+qkFKItfpRsMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeMzM+rv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so3884124a12.3
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 15:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709335853; x=1709940653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0+xGO5lvcaJBILqVTCrQfSCz+TNmrxj1N9SZBn9ddo=;
        b=XeMzM+rvepU5E2D2JgTwo1kOurrSQ+z+Hi4Ce86cBgWiEGOi1mBZCCrMqQkxlGcW4E
         Qxs7bV9gFIPUSMuyGR19XuLGjC9u7hK9gRMVZSTHtbgvkve7NtnBAHlG8QF+DLm8IaYh
         CMZllTi4x+TgNfWkqC+6LLOnTodcuGckIXZkdHThDW6rFDJnBbIhUDa7nq1cm8VTzbl+
         8jp6OciMeeRlDfLZp0a4/cdmn9EOjd6YY6sj0AJG8W4JO1QDqJ6S+KTGFM1wDl32k4jS
         kMfysVH7UR3UgjrLhtkRvhbYtXmHlm5KWnajXXoHskBfRHneU9VuXohE2LWV6GFEtjGn
         McOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709335853; x=1709940653;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0+xGO5lvcaJBILqVTCrQfSCz+TNmrxj1N9SZBn9ddo=;
        b=RSzuDv24AvB4Q4nErLE/3CWvxFwtoNLPQkKeX4wTrQCw78eT9xB6nDNhufsjoejGFc
         LScMHW46WDTKZFxBEqHzWrJPEwBtrqHTLxXayEhovm6YJIRVv5ciZv5qJknAwzBJ+rtM
         wBlcFxAy7bCNerFl26enCzO5SC3YBZvFE1gtaOZeolvLMVJ9xUg2G2g0N1c75z8tSTrU
         +dI3Cdu3eerImmWLb6O4wtXbxRGO+fbY1w8CLn+NyfDhUArTi+6WN5wAkVSMzsLey281
         20nXSJ2bSbnYsscGzfVz6naLCaBK3wi0JNTvMoqpX/1XvSi3liXDd4FQSocN79SxdbzA
         LZJg==
X-Forwarded-Encrypted: i=1; AJvYcCUiVacPt0wrVg2bzEeDcyeJw5+qZtWEeGw5SOdYPM+CnYyqco4kaEwwGQvtGoaEwDXfaMMq7ESMli3cqQVjlrPN6I8+/jWHSJm6
X-Gm-Message-State: AOJu0Yxmzwoi788f/kICAu4qRC3gk1QRTR/nC8jtzKRV9HvVTW3wU/H8
	b+Ix6+PmlhSdq7B6sJZIdM9Z4wTiZ1lrtzI/jXlVnNNbydxe4vk+JbkF9IlDQ+g=
X-Google-Smtp-Source: AGHT+IExL+5hOMeIbqveJaAAJ57Xl60U2dXp/DpxIsvmvzGELA0l6Eqydv4PvM0FA09j4SusZSjAiA==
X-Received: by 2002:a05:6402:1848:b0:566:a7c0:c8e8 with SMTP id v8-20020a056402184800b00566a7c0c8e8mr2537923edy.12.1709335853144;
        Fri, 01 Mar 2024 15:30:53 -0800 (PST)
Received: from [192.168.216.32] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402001200b00566d43ed4dasm916955edu.68.2024.03.01.15.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 15:30:52 -0800 (PST)
Message-ID: <7e573e8f-a311-4d72-a0f9-1e6f0ce94b4b@linaro.org>
Date: Sat, 2 Mar 2024 00:30:49 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] PCI: dwc: refactor common code
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 agross@kernel.org, andersson@kernel.org, mani@kernel.org
Cc: quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240301051220.20917-1-quic_schintav@quicinc.com>
 <20240301051220.20917-2-quic_schintav@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240301051220.20917-2-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.03.2024 06:11, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common repository. This acts as placeholder
> for common source code for both drivers avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---

This "conveniently" conflicts with your colleague's patches..

https://lore.kernel.org/linux-arm-msm/20240223-opp_support-v7-3-10b4363d7e71@quicinc.com/

Konrad

