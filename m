Return-Path: <linux-pci+bounces-5030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751F88760C
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 01:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C8C1C2101A
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D1399;
	Sat, 23 Mar 2024 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnQGaRKO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D47F
	for <linux-pci@vger.kernel.org>; Sat, 23 Mar 2024 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153501; cv=none; b=G/hcs/A24NEQy/xS8YbZTulObpmAIn/bPigO4l2OW4SOvKvQQOEmgLrx1yMPCLAHuQgh1Gs9M6ojVgnwSLwHs8DQ9cT8JCZtbFnwh++VjSeTl7KjqN7AgsMsbdc+nwAkguaIrX4kPrB4ju2ThLKEI9QgCCDJxIGipsJtgGjGyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153501; c=relaxed/simple;
	bh=2IgoiS6fEsuMMVpTO+9mS82/M+P0thoXjVZ4pMqyv1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMJfZkG4Uu1A9UaMn97uJ5nc+6u/ND54+q4JpECxPw/GOcu3i7ni8U6fiA+f53W3J8DN8c8aYBp+qQr91xNXPLUgF0rlYKIz+z/vMRUQh164VZDvqIIpEswguJSNtD+K8z+v8I9xaTOejJxy/p1+XRHhacAJBOCBrjXrHoyYsWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnQGaRKO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so466844866b.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 17:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711153498; x=1711758298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CU1sm29g1dOZBLr1kiQ8rHPkvQL6SRoe1JFaExHcjiE=;
        b=HnQGaRKOnjrGqYZXndBZdM9WxLDj+kllAWigVYuonM5OMCmu0MpSXIUNlJy1dbzSub
         HT0nS17ne81NZ7TMEpWUFcuUb2ZCpjGyqX8ZmRgY8C/gIP3had3fWsR7hJOvkXPbFFrx
         22bIzoAcW8b74dts3HBRGsXUVObs40bVUFyq0KIrHMNIDRC7jY7LWg06aY8bQ5dV2TM4
         b0AcDGGtZq4k62FhuzcWleSFBAYho7WdvqChPRk7S3OHRmC5PqbgPrfUxA+OLwNQVPbd
         1rnYpDvb86IXcRnVoadoxYAxzt0PkRzPVEiUGt78m0MAiHv+qfvAd4P5kmdFr4j6kCFr
         kjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711153498; x=1711758298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU1sm29g1dOZBLr1kiQ8rHPkvQL6SRoe1JFaExHcjiE=;
        b=VwKYrZ+BYpKkiuvJ8wQETSXyKvQKkHnhans4c7yQUQURe1z41/fAnbhTRKOYR2QWAw
         8dyk/NWjq570Qa+FT5jHObnjenmT8l8JuLADHbojpahvEpwSKq1ym6DZmCV3FQRXVn/N
         dLeEm7M5GlIFjVu/8sitiS10fUcwSqyftoH7negP8Frxvv6lEODzam2obb/euRxEv23B
         E5/1fwODc/2Pfu4VAkuSW1GqvxBbpFP6jEXRth12MRr6xU/kA4ppQEPvN6J7Z6dIoGhQ
         5/bvnoG9J+koLZJDA+XQFWo4TflsXJPtHZ88JSuuQPT6R+mRN9gcuaoprhV+l/eStlF5
         yFIA==
X-Forwarded-Encrypted: i=1; AJvYcCWni6wTQycwpPBNv1pJCAgcsHRjasYeSXm+OOlxI7IkuY4ReJHJ3LEniHsxjoWDOEt1jT1RuarFCsDuLlto7vl6J8hzgHMcAcJe
X-Gm-Message-State: AOJu0Yy9dvBuihmGtGK6FyIzBKetGnhwabO57k3PTWf3GfEcsJbskQL5
	VCmSFbK1h6btSBZvCVxPHVh437pOkP5ax6tl4KpRqY50SFKgACtVVEeklZ+HZ6Q=
X-Google-Smtp-Source: AGHT+IEQppiRQhOl7QbGFFWAEgIlqXQKQYJ+u0fMDVSiiM1GOinVq92D5HNGxHZIwhq9tVUcwtickg==
X-Received: by 2002:a17:906:1398:b0:a47:1911:f9bd with SMTP id f24-20020a170906139800b00a471911f9bdmr424363ejc.14.1711153498202;
        Fri, 22 Mar 2024 17:24:58 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b00a46a27794f6sm343830ejc.123.2024.03.22.17.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:24:57 -0700 (PDT)
Message-ID: <4bc4c4d1-f2b3-4b08-a211-0b05c5838ef0@linaro.org>
Date: Sat, 23 Mar 2024 01:24:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add rx margining settings for gen4
Content-Language: en-US
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
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
 <20240320071527.13443-4-quic_schintav@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240320071527.13443-4-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.03.2024 08:14, Shashank Babu Chinta Venkata wrote:
> Add rx margining settings for gen4 operation.

Why are these necessary? What do they change?

> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 23 +++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.c   | 35 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.h   | 11 +++++-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c    |  4 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c       |  4 ++-
>  5 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 064744bfe35a..ce1c5f9c406a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -206,6 +206,29 @@
>  
>  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>  
> +/*
> + * GEN4 lane margining register definitions
> + */
> +#define GEN4_LANE_MARGINING_1_OFF		0xb80
> +#define MARGINING_MAX_VOLTAGE_OFFSET_MASK	GENMASK(29, 24)
> +#define MARGINING_NUM_VOLTAGE_STEPS_MASK	GENMASK(22, 16)
> +#define MARGINING_MAX_TIMING_OFFSET_MASK	GENMASK(13, 8)
> +#define MARGINING_NUM_TIMING_STEPS_MASK		GENMASK(5, 0)
> +#define MARGINING_MAX_VOLTAGE_OFFSET_SHIFT	24
> +#define MARGINING_NUM_VOLTAGE_STEPS_SHIFT	16
> +#define MARGINING_MAX_TIMING_OFFSET_SHIFT	8
> +
> +#define GEN4_LANE_MARGINING_2_OFF		0xb84

The file

drivers/accel/habanalabs/include/gaudi2/asic_reg/pcie_dbi_regs.h

defines registers with exactly the same names at exacly the same offsets.

If this is a DWC-common thing, it should go to DWC-common code.

Konrad

