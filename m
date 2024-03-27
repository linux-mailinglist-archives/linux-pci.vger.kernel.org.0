Return-Path: <linux-pci+bounces-5295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4900A88F0E3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE821C272DD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84866152DFE;
	Wed, 27 Mar 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pS5I75bz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA0138487
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574841; cv=none; b=fzlFqBwJLXijacXLJkqKCwawow0Q5kc4a8SUsGOkcyLAbFdVn9oLYmHBj2mH9BefOc9uBvBKJQMkP1gizmtMi5RTHkVOOHIohMkZORqtIlvaojM8vbPOSakbybT1Ubl6yfdCfCSCfnIn1ESmhN2LtlRFEACLnmwrqLZwP9jsM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574841; c=relaxed/simple;
	bh=yc5HwDxh0Cq57l5em6EJgDWkC64vTATP/bKHfpjFDTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j51NLfCfvTXVhFU3de8qjecTcC95td5U85eQYx7iImVReYcNeXwDIgsw7qCXrY0JeMaEam/UxEnMWqgpGtv4Td9o7YrdH2MFfOrO6M+hwXw9DZzMr9sHs/wVgUsWr6AnGOjJTrLe94GMSBsnf4gCf4rh8v5CkH7uqQhLJasfxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pS5I75bz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46d0a8399aso232437566b.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711574838; x=1712179638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+tGtRil4SrQkzoQjrHa8/2JGLOrwO/8SeqSS+CQSpY=;
        b=pS5I75bznfK9M0wDjAlmJcWT+OlqcjQlVyAvvGAQmvXTmCOwHTdSGTGNRDe026ZNmv
         KBGNmjeck/HN30dgNmRQtUOApAh8ecgJ4X2CfQcZn2L6GQoanAojyctqtc9rRz3c455b
         8oY0IgdgzzaHVcF1dupvVr8mgNqX4USovOVsERTyo7NPhEfXtZaeY85fJ9S/3RaDhQ/8
         gNwdz64SgJvtY9eZp3Qcm1B+loWkeBdNeFEMDWk/XB+JIYVl4glJctFz/K7rFuTD28eD
         Cs/pRnAUNDSsGoxbZ0tQyTqXcZ4Thlz55OA214TKo9Et16KueS+Cyl8IeaUkMYbNoxsS
         4vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574838; x=1712179638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+tGtRil4SrQkzoQjrHa8/2JGLOrwO/8SeqSS+CQSpY=;
        b=byARTbdIfrxdajfSdGtKubpJFsXsZ6MMwgPZy1ngiLsKgZb7bWA94PKqF5cz9QGVNs
         gRciT9Lj0KpUv5QI/bWCZF7CA0tkz2T0WYyXgdQzvucp2XTgc5URPn3qzjFzLfTyA8wN
         LUK/xkG07BUG/cYAXSLV52beE/gCIfa7Kdx20QiPkqMvvMFHIpRIqC4MiaYMQWx5aY+h
         kz7UGTUy8Pndtfkm6Vxv2kuSr1QMAmwDoCA2wHK0j/yPZrz/nMY2P6QoNHQBv5AusS3q
         I+FeUqrpBQ1T0vqxsqoKKVG+/ZUlmn676k/0vTKSnf9U1zFqgLJuI3S1UW+RfnhZ4ZGN
         aueA==
X-Forwarded-Encrypted: i=1; AJvYcCWWFoaCS00txA1Onfp1WQre56tZCtJR12ZbDTGuo1plH83zXAoepR42Lp9Zku6a2K9QthrbUNaOUDFMpqYAgzoPcJ+yPJWanPjG
X-Gm-Message-State: AOJu0YzE1aP1y0zALJgQ1qWkSXGdBQE6iSJqNSZaDS6CIZuMOY7UE7FW
	ce4OD4lKVZRLjWxkpRro2v6TRlYbfe/PdlEvNa/mxJELDUvFsehVbN5/BrDBz/Q=
X-Google-Smtp-Source: AGHT+IEIGpR3f17YdTWAAOTiogXj/c4pPIi1qELLH+nIQPdfM/SxKE08Tx3x1OZ6MeNR1E7mfSFDig==
X-Received: by 2002:a17:906:1682:b0:a46:a8b8:f4cf with SMTP id s2-20020a170906168200b00a46a8b8f4cfmr367819ejd.35.1711574838038;
        Wed, 27 Mar 2024 14:27:18 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709062b4200b00a4725e4f53asm5877732ejg.40.2024.03.27.14.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:27:17 -0700 (PDT)
Message-ID: <fc72ee13-db3d-423a-9ac2-15b13f42ef5e@linaro.org>
Date: Wed, 27 Mar 2024 22:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: qcom: properly implement RC shutdown/power up
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240327212050.GA1538555@bhelgaas>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240327212050.GA1538555@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.03.2024 10:20 PM, Bjorn Helgaas wrote:
> On Wed, Mar 27, 2024 at 08:49:09PM +0100, Konrad Dybcio wrote:
>> Currently, we've only been minimizing the power draw while keeping the
>> RC up at all times. This is suboptimal, as it draws a whole lot of power
>> and prevents the SoC from power collapsing.
>>
>> Implement full shutdown and re-initialization to allow for powering off
>> the controller.
>>
>> This is mainly intended for SC8280XP with a broken power rail setup,
>> which requires a full RC shutdown/reinit in order to reach SoC-wide
>> power collapse, but sleeping is generally better than not sleeping and
>> less destructive suspend can be implemented later for platforms that
>> support it.
> 
> Second try (first at
> https://lore.kernel.org/all/20240212213216.GA1145794@bhelgaas/):
> 
>   - Capitalize subject lines to match history (sorry, I didn't mention
>     the first time)
> 
>   - Drop or replace "properly" with something specific
> 
>   - "... minimizing power draw while keeping RC up at all times ...
>     draws a whole lot of power" doesn't quite make sense to me
> 
>   - Reword or explain "power collapse"
> 
>   - No COMPILE_TEST provision (maybe it turned out to be impractical?)
> 
>   - Magic delay numbers below with no citation or explanation.  Even a
>     short comment could be a hint about how to verify and potentially
>     change in the future.  A #define for readl_poll_timeout() would be
>     helpful as a place for a comment and because the name could
>     include "_US" to show the units.
> 
>   - Add "()" after function names in comments

Sorry Bjorn, I came back to this series after some time and didn't revisit
your message. I'll be sure not to forget the next time around.

Konrad

