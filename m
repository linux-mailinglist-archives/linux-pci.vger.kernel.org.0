Return-Path: <linux-pci+bounces-3302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29484FE8F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 22:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DAA1C22E82
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2151B942;
	Fri,  9 Feb 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trQ6dcth"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BD20DE3
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513274; cv=none; b=DaVjetn48DGAcItmqggftBnHR81ixMyhx/WtHQwDDuqMjPvCsoGaySHkQOrZIL3BVmQJ/l3KxFmIPdEESTiwM94DXBi5Kiu5tWNe+p5+fwkpZkQDR41miY24ZJ4lXjo9pbacYqzlFD8YpOlddDBzc/WcEJUmT7A5O1XHg9kxie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513274; c=relaxed/simple;
	bh=/4PvF6Tyb1ttF395L3gJlZpQ1YM5myFip1eEfl36e0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0B6TUXjYgfDj/kq3hQBAU+AMRpEPnCeyAGibKbFSQ92M+RCMD8JoFWv9eXGddfjgYjiUImuGVAPFTYxPkDomjZ4PJVBObvpvATJfTYDKkcnNOeDcDW5TY3OLDbOjHvH/Py7+3spZBIcfzv00ay5fQJ2fTUZ4I0jxI1SWE5JLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trQ6dcth; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0a0873404so15413561fa.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 13:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513269; x=1708118069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EW1CDRbIEpLF8e19KgnZEiq7iXVg7C616XZKbJYbY0=;
        b=trQ6dcthAhcs9XIk9aI4Rz2cqYMlNr5wCmBgrM4tnU24PkxIsJ/BttFcc5+ElusTTR
         WtJT9hILrRygTs/AlDl4dyIHcCNXL72b6XBmoqZWWK0lfYBUTEImEVjIXz23ij54jjSr
         id31dc4ft/OIpynuQnRUOkXW27ZqaxmIzR+enmhlTosWnKEAs+sNZKU40ma8axG2dAVk
         fPLL9Gr5doiIk0mAxGQmerKQ1Giw8uqy/xb/BL+iLk5doo7kBu2rS2LZ40lyyZ+ZJqNc
         FU7xWc6tPF2Hw7jZ/KUzZRgywDiWkjaqJGPSvuKvy40gIOql99A7OySDPlVvjSSNQyKr
         Rqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513269; x=1708118069;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EW1CDRbIEpLF8e19KgnZEiq7iXVg7C616XZKbJYbY0=;
        b=ZhITE39EACoJciOoFxXR+FRa93XgGLckNQFVS+dALMVEJrf973B3DfbIw+/f3xuUIH
         VcsqQuvqe4WvEU9TvPNXEQA3dCKxIXLUJ1D7NFchJ/vr31e2eETUpJgC2/KIz8vf/g09
         R4msTm19LyQ7HMC5cJsEG53HaDaB82KaKdoOQzlIvFIGwu9uTn4tfAaG/ig4ysPM5yE9
         W9IND7yeygoAWc7zfFdf5D96blpn2oGvcvrJCO19SYdqnYmW3F8VA0M4t+hSF6L41BIr
         /pi08m0yqM1Qy0X+C+M6NuFm3PGKWCVr9Lvcdj5QE2but4kxPAX4hXFkqVtuN6H+PhpI
         MBiw==
X-Gm-Message-State: AOJu0YyJ1kMitnH7FK+8T14QOyKC5HIYKGrcdmVqBtQZx+DtaOTvoMAb
	j56IP3gJ34hCZAYao0R7V3UEQzZAZciTJjd2skzTHg5U2v3WHWhM2GmblocYrAs=
X-Google-Smtp-Source: AGHT+IERL9gI6gwl5IKFoX2LFUUFiGchsQS6j1nPZSDT/LjNQFedLL5+aL/SUvBpyHArN+tP8vp2mw==
X-Received: by 2002:a05:651c:199f:b0:2d0:9a6e:80 with SMTP id bx31-20020a05651c199f00b002d09a6e0080mr150223ljb.43.1707513268970;
        Fri, 09 Feb 2024 13:14:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhmor25wMXZG/moYNVgx/bGZybxE8qQR8IDlnfNj4UQnVA1FzdRz5EncLGwD70beDLK1KacUH4ktzFf+Vs2zo0R/plzZY4yTji5eCXM1YA7gkWEBBBG/HgBQ3bGDD7hQcflSsEQ7xrNsrhrkbnaUka95X5TUI1Fn0m4FbM8P2v2MMz+q1epx46L0xGFfWHNXbtVuRcsRtNiEUX4UI66J6bLw4s6P72A7/bkhgYVt0/TdgVCT7j4noRpzvy8XGbHWRJNJoU0ld/Yb6/4wbe5a+ui21DSzTFBvKSqGaobX4pR60lJl1cjv9+YdDXuEbq6CHMRarF9Yftgxnh7cbaKldB/bRZTeFoKgYma9GPZVXYN0l4yyPEc/Au3ek+mfs/Q4JqigEGMemQnSX44Bg58KjZHwEluJXQIhm1+a2Z1db954J84RHLAJpUe2zrIGe9ws4El7Tx5c4JLF5DVmP+/YwkAWhGfdf6nNWIXjufANCdrUsr4XVBA+HOGAtckEbzkIlx5SG/eYcI9S+tHN1+5PcCu713meA3ul4eoIyA94rTrONYG6u/Wi9oOm0a6sN4g7rZIliFfiu7vpFFpJZ0E33YNzkr1+zLaCT7e8HN5CV7FMcZqq6JskO5usHX+3rkrCNztl9cNMR0DyD8uLOxFtH3dz81FoHpL9XROVKeab4VVUvEfjJrA7LngBTdKyDO
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7d890000000b0055ef7742204sm98897edq.97.2024.02.09.13.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:14:28 -0800 (PST)
Message-ID: <8a7b63a8-0583-43cf-9876-8a964c8b77ee@linaro.org>
Date: Fri, 9 Feb 2024 22:14:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
 vireshk@kernel.org, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7> <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
 <610d5d7c-ec8d-42f1-81a2-1376b8a1a43f@linaro.org>
 <20240202073334.mkabgezwxn3qe7iy@vireshk-i7>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240202073334.mkabgezwxn3qe7iy@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.02.2024 08:33, Viresh Kumar wrote:
> On 01-02-24, 15:45, Konrad Dybcio wrote:
>> I'm lukewarm on this.
>>
>> A *lot* of hardware has more complex requirements than "x MBps at y MHz",
>> especially when performance counters come into the picture for dynamic
>> bw management.
>>
>> OPP tables can't really handle this properly.
> 
> There was a similar concern for voltages earlier on and we added the capability
> of adjusting the voltage for OPPs in the OPP core. Maybe something similar can
> be done here ?
> 
I really don't think it's fitting.. At any moment the device may require any
bandwidth value between 0 and MAX_BW_PER_LINK_GEN * LINK_WIDTH..

Konrad

