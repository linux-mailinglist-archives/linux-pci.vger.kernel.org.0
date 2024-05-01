Return-Path: <linux-pci+bounces-6958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB9D8B8D46
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F181C20C50
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096212FB03;
	Wed,  1 May 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgVT7UJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11212F59D;
	Wed,  1 May 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577846; cv=none; b=boBzqf2JRJuAO8qe4Ghoxm3YntwdfnBRXRKe6s19jukBsgFkpfDy+lPhHNObyiIsx6ovptTK2n3uHzRfHxjQO83hKH1t3ypHgTYjeq1c0GyepxBE/u66k1ROKG7uldA58W069/+5SpDc1dUoTdTYdm5IcnzJP2lYJscW0t38FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577846; c=relaxed/simple;
	bh=0ITTtdbueCZGJrgUVAPhbmZom/wxQK/QStVSF6LAPcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fQHFcFNq3Awgzcf74f1UCY79OUJU2DbDkeBzJcwA1RQ3T54wPXe0mKyFyZ0KBo4I+3ZqYo1OiVxSHXw5s0H1LPP1vsKYSEq1oGK6jOcop1mwuoJi3YwJIRe4Q5lHhzqK8JAQsbv6pFqzYUSiE4VS3zf1GMJduze3kl5L+yNf1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgVT7UJ4; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23d1ea835a5so675424fac.2;
        Wed, 01 May 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714577843; x=1715182643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34HSQZWtjbxbUcY2p0ZqE9phbqtru1lcKIiAiKLyg88=;
        b=AgVT7UJ49zKpKZtb4b2Czf0iaqtmD0XT5b8AtI6Z0XkQ48aOC2fbSjl+g0WBbOA0wr
         6KpTZf3xyJt26fPugjR936lmSSEjNdxfsVkKUkLaqMMcCmu1x6tS5EMLJmGfn1wV5fiO
         Lby8TNeE+WcMPvYLiYMqhTkJjikdeYBrfc9HqcPPkZBAvu1a0SMRJ/NXYxPSLOmnYQIg
         uREqxJ9B4OBv4tDVI9XjDt0U7Ttml115zj+QiClcc57pN7frONx3sWjlMmLYrJFOA18L
         HyOz6jzmMP1VU1FEsrRYPd1e2fXgaRUIobB/kagQzE9HD+fv5YTt1WD+13dkSx6ulXll
         BQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714577843; x=1715182643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34HSQZWtjbxbUcY2p0ZqE9phbqtru1lcKIiAiKLyg88=;
        b=ThkqwG726xzGKKDfvd4F8zUA6JJYIxjzp3xD+bPsVzcYLsFWMwwQVjqO+enzvbEdw5
         RHb79zWBP/54ZbEDKMkCc1adNnlTy/CY04sY2n/148WdulsRKS6GaN0AodKcg0x/e0tA
         soG7hybxaPxLyoiX4AtmySmaWR+1L2SJzWDgulHP5Hi4EDfYseRozaY49kinMNZDci9t
         ZRX+8fjYYeSdA0IBmB7qg3C/vOouIzgnk+L2Dp8r4h3NGj9J7tY+t92zYbN341Hi+Wis
         cGz9Y+t3JbVXUueCO68sbkJB+mSf14Tz4ZPxwl6JcNe/2kzc5CsXq3rq4L4yl4n7C0vD
         wnqA==
X-Forwarded-Encrypted: i=1; AJvYcCVRaPw2YBXSlEmxwjl9DXQNz1gpcPPXDBREOi05lgbkjyV3ZbccQOm9qfvrKPxbC2g95Ns+58YoCbDgqoso7yQJdkoN0QJEf9HS02EyFnEK+q+lUoVJO623WXFbhbp5rDrIFIZbUMd1KgdKN4Q8vkUO0A3tCT06Ezf8wmhQ0EOJneg7ANWTZISj+eN7sZNqdgUFzkEEnZy6skr4j4WIB2vEcLkF07GkZPhqdw262nWbOobdcbC/n71LVIphSn4=
X-Gm-Message-State: AOJu0YzY++MsikVrXUCBVqGLiSO2IgM2tQQXlYs2EDU8qTt2cRnxAXKO
	cWeXBoqPpqQGxsnB9wrYONFpPd0cX0+a5eLUID3gjFkh6fWYqWBK
X-Google-Smtp-Source: AGHT+IHdOGltmMEfyguF/4cAMA+Sgnkaw7abyq40kS29fkMPdziQpNXQgqEnnEGTcu54RFw7h8jJWw==
X-Received: by 2002:a05:6870:b296:b0:22e:8d62:fa75 with SMTP id c22-20020a056870b29600b0022e8d62fa75mr2938064oao.44.1714577843194;
        Wed, 01 May 2024 08:37:23 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id qw2-20020a0568706f0200b002397a883e7csm5033024oab.12.2024.05.01.08.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 08:37:22 -0700 (PDT)
Message-ID: <47665254-fe22-4369-8b10-087ca928e97f@gmail.com>
Date: Wed, 1 May 2024 10:37:20 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 0/8] ipq9574: Enable PCI-Express support
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <ea1c925f-1696-4491-a792-1b9165447dad@kernel.org>
Content-Language: en-US
From: mr.nuke.me@gmail.com
In-Reply-To: <ea1c925f-1696-4491-a792-1b9165447dad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/1/24 5:22 AM, Krzysztof Kozlowski wrote:
> On 01/05/2024 06:28, Alexandru Gagniuc wrote:
>> There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
>> addresses pcie2, which is a gen3x2 port. The board I have only uses
>> pcie2, and that's the only one enabled in this series. pcie3 is added
>> as a special request, but is untested.
>>
>> I believe this makes sense as a monolithic series, as the individual
>> pieces are not that useful by themselves.
>>
>> In v2, I've had some issues regarding the dt schema checks. For
>> transparency, I used the following test invocations to test:
>>
>>        make dt_binding_check     DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>        make dtbs_check           DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
>>
>> Changes since v3:
>>   - "const"ify .hw.init fields for the PCIE pipe clocks
>>   - Used pciephy_v5_regs_layout instead of v4 in phy-qcom-qmp-pcie.c
>>   - Included Manivannan's patch for qcom-pcie.c clocks
>>   - Dropped redundant comments in "ranges" and "interrupt-map" of pcie2.
>>   - Added pcie3 and pcie3_phy dts nodes
>>   - Moved snoc and anoc clocks to PCIe controller from PHY
>>
> 
> Three postings within short time... Allow people to actually review your
> code. Please wait 24h before posting new version. Include entire
> feedback and all tags. Explain why you ignore/skip some tags.
> 
I'm sorry for the confusion. It's the same patch version, v3 being two 
weeks old.

Due to a tooling failure, the first attempt to send resulted in a 
double-posting, and missing cover letter. It was so bad that I felt I 
needed to re-post with the RESEND tag to clarify the intent and prevent 
further confusion.

Alex
> 

