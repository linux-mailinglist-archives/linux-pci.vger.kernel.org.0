Return-Path: <linux-pci+bounces-4944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DC880E66
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CC1C20C6D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31639FEB;
	Wed, 20 Mar 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4FY7UXQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14610171C2
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926184; cv=none; b=oNOgg0Zn9eQFayCVlyataBZNG8Yy5LrNwVcW20YjaMo5GiCx1ilf7w7Ujjf11yKzIgztIqz2lAqTkxrJSxEfnYGi8TX42NyCSHktgRbDrggsxvYJmv+3LtdRBzjN71Fenae3diDfKT8D6+zQOEhNzhQUYgwGxzx39y4U1aSQtG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926184; c=relaxed/simple;
	bh=7qiN7s71pLRDxczBVXccvkevewv+cyZPsC3vo51G3Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arsy+s3jacHAXjW+hl1ADOooetb4wN3GLlyArMHoVDUtX+di0IjvTwDvWflrxRIX3fsVHO3/Ff78wYVXYc+1CzTfrSCPp1klDoKbFlbfyoj+0Y2nCDe5alQtZVg3Ilpv8kI2MljCatmTCA0zZDLvBLS/zhtzXxJG/L2grlDDfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4FY7UXQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78a13117a3dso57271485a.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710926182; x=1711530982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdemdKKmkbE2PfEGOheslqykPqKEOarSKu2X847Hkx8=;
        b=v4FY7UXQW3Mtc9KyH6RrZpUNB9nwSfCQPoOuxYGr8A5l+tD2bHiwypW9Xw5h4sBDTn
         +ZLgDDD9RbELlc2s2RXVIrwB3AS/ZEDSAKFCWuArJBv7K9TB+6xGQgpUzdCOa9jDppuy
         Y0A6cjG6hm/43/4wgKNFmPygckjfxjN9KJvhMLaKhbsJxQOWa/Hhy6YLm7CrU1VubI6U
         5g3teykGAfbNRA186AbUK3xj6WG9V8qFHJ23NkfZcyc5tXiQy7urq24V3B9VNn2aHWKt
         25AmqdXS7BuLJi+2TSYTgm6VnyUhwlZeQRkAi+O7bX8wnprKYi2jFyG1ibYqi4xO6hJO
         Z1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926182; x=1711530982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdemdKKmkbE2PfEGOheslqykPqKEOarSKu2X847Hkx8=;
        b=TiGJb5/aVExyKRB8GvS1WyKUvNXEhw/VOgd54wbwgonAi22Qhcg25xAR7Oe7Pk0hoK
         H3+Th9fdqOYX2Qa17gaEzz3VE2G+YmQ5JTUvCxx8mrFUPud3D9FlQuVSvOOqnLQvq42Q
         FCvmEItVh+urCBpSOXN1A0t4IO2BLfEImb+jI/oJENsYT4aYkRGBMBdCeexkchQNXQ/8
         tvB5cR438gtsBzGXiM/xVQUvmRbTKmt9dGXCOQbOkK4jzfhMvJMaAw6ei0UnDkjIrGTJ
         ptqz+xLO9+NRBDAoC0VMR17yDs2AlM8LiSBWh9TkTiiXgrsZuu9OSCsQEmcySM8kbk3+
         sAvg==
X-Forwarded-Encrypted: i=1; AJvYcCV/WBUBLSGrDvQNIgG9zgfb1GpqUxHiAXC0kM1Ts85Q6cuqtj61XZxRA8MBLHYiZKHJQNUsoC75CrF1KdAZBLBc5prEFWJFO8rQ
X-Gm-Message-State: AOJu0YwjcKupPl4MLSV4BaKBPWsiI5g1qRCb8D59ChQUpS1D8BJYDnmj
	X8WGNLYoMIYpzcgmSgNUcZEaP9NQ29fU7tx6vCqS7Nt5+oqDSO+BFTqf00SXJew=
X-Google-Smtp-Source: AGHT+IFH/DGAuG6UpXir+MFQEX93ggRvpCtCWJKypFfAYtegcd5mPZkmVf5EdY3Ii1gsDK1y5VGKng==
X-Received: by 2002:a05:620a:2402:b0:789:f0c6:a938 with SMTP id d2-20020a05620a240200b00789f0c6a938mr3353352qkn.15.1710926181995;
        Wed, 20 Mar 2024 02:16:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wh12-20020a05620a56cc00b00789f2660e88sm3706262qkn.68.2024.03.20.02.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:16:21 -0700 (PDT)
Message-ID: <cc5d4fc1-14e7-4a73-80bf-6375e44162a3@linaro.org>
Date: Wed, 20 Mar 2024 10:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Johan Hovold <johan+linaro@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
 <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
 <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>
 <Zfqb8jPK50vlqu5Q@hovoldconsulting.com>
 <baf9c1bd-84ef-4ecb-b229-51a83fe82c3f@linaro.org>
 <ZfqhCKoEL4XGRs7T@hovoldconsulting.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZfqhCKoEL4XGRs7T@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 09:40, Johan Hovold wrote:
> On Wed, Mar 20, 2024 at 09:24:54AM +0100, Krzysztof Kozlowski wrote:
>> On 20/03/2024 09:18, Johan Hovold wrote:
> 
>>> Perhaps you should not comment before reading up on the history of this
>>> series.
>>>
>>> This was all intended for 6.9, but merging was stalled for a number of
>>> reasons so here we are. The patches were also going in through different
>>> trees, so patch 4/5 is the first Qualcomm SoC patch.
>>
>> Again, well, you sent it at few days before merge window, so how do you
>> imagine this being applied for v6.9 and still fulfilling "few linux-next
>> cycles before merge window" requirement? Especially that arm-soc cut off
>> is much earlier :/. I talk about patch 5, of course, because that is not
>> a fix (at least not marked as one). Don't expect in general a arms-co
>> patch to be applied four days before merge window, thus the actual fix -
>> patch #4 - should be split.
> 
> At the time there was still hope that there may be an rc8, and the patch
> in question had been used by a large number of X13s users for several
> weeks, which is a lot more testing than the average Qualcomm patch
> receives, whether it's in linux-next or not.

OK, it does solve some parts of our discussion but does not solve my
earlier comment: Fixes should be separate series. Certain folks have
quite strict requirement on this. Try sending a fix with non-fix
(depending on fix somehow like here) to Mark Brown. He has even template
for such case...

> 
> And patch 5 depends on the earlier patches in the series so it belongs
> in the series, which was also initially posted long before the merge
> window.

The dependency is might not be good enough reason to combine fixes and
non-fixes into one series. Dependency should be explained (in 5th
patch), but it's maintainer's judgement and job to handle this.

And in all this, fact that Bjorn missed certain aspects and applied this
differently than you wanted, is another argument that this should be split.

Best regards,
Krzysztof


