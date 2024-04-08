Return-Path: <linux-pci+bounces-5909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128A89CDD6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 23:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8697B22587
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6631487ED;
	Mon,  8 Apr 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgt4hJF5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B6146D74;
	Mon,  8 Apr 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613138; cv=none; b=VKG0H6vEPafixxG2anErUR88ZYTt5W1C/Q3oZP5f2+jeLdpGWdbkwAxRf1sFj+e+C5ZQ4kqg2jt9P7nqywIoM1Hsv8kYRlDCKfQKhG6SupYTFAHWT8RdVtCLmiGXd+7OTosvi4tpbm3mvq86YaFxumG84Nob4hAEgLqPCr3VLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613138; c=relaxed/simple;
	bh=hb9SYQFj2t1P28x3CX/m54HgTRWoaz+drxkpDylTfDw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JXYkLbs2sXAcfQPYvbDgre96sHcwxezrsC/pM0ZUPc/laZ4DGA4g4e8PGONjAcw6CLv/aHcK3N5HSXyiweoDkAG/zdUyJRFf0KAEXddwJRBJOh72rPhqwb1n4dEATUJtsPKwgh07MM50PfRs62TqafkTOeEqbIYmXCYzt3lhf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgt4hJF5; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so1160353241.0;
        Mon, 08 Apr 2024 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712613135; x=1713217935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzpOdXd2P0az+B4oPxEYqAXzG6a93+7qUz8cfvKLvLU=;
        b=cgt4hJF5lUZoGE2BMK9KKgRBSsjq3Ovre2W5U2518DbOD7MIgQhobPjKICP0nljO6/
         3DzifBrLJxEaa9NCTIA5rftls6XDu11fiDcPShaiifgr2/pMCfqsL0hgK6Vq4LXn9xh1
         P1lxS++3OI/nlpXmt0zh5rcl7WHd20pYzTNGDGUaoypcs+uQX3ouqlF8kqxIh4GH0fkG
         g2xSLM28qUoBNqqHUs9IVc3hGVoDNF3dHCoFqYely7MyjKErGPCRYP69g7ZRQL92MKOb
         kafAuMSr4SD70q8aERxKXg0mjjaB6CHCo+Jesjo/cqjmK8GoVldx660P2z/9WrVkr02d
         PoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613135; x=1713217935;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzpOdXd2P0az+B4oPxEYqAXzG6a93+7qUz8cfvKLvLU=;
        b=VFp9jbuKzi9h2xYU5LvjnckDdxkPbHjPo0CmEb/JAKI+hQA4Jn3IP6W4OCacvr86Pg
         L5vfeMxS+k3JPmKXZkax9BrdKVq8YuPD81gBw3bYHjpm7m/75e8k0re9x8Ml//uBf3QV
         ihj0JE1tLv6c1yC/9Pa0bXcpYCmzC/F4ycYxXRdcuCyum1u5KSHwWJPbdwHZTBb1DHAB
         SE5PkyFUHZVMtP4rA9ty8Z2kJ02FvyL1eolaUqOiQMox4oPqibQxV90W88oamjbhy6V8
         ABSloUWi1bnA34tGsUUNBzGb9enLNwXKMPP0c7tkFJb7SNcaetkhGEjcm4XPuI/eReCY
         MkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAKTB9iBYEcviYa+GEbh4YtxkOvJoXeiZlwc/4z3A5kFAA1jhyJfN7LmMumKmF2AOpjCn+hb+45w/GoGtLLhjNuWeu03ion3o0KtKkj1IHtS3GzAmiYhjTeE7h2WxVG1/T
X-Gm-Message-State: AOJu0YxotNDn+FRDdtX11Vx6zF4dngBtD9V81zxh/PQFg9tsk9uCuL2w
	FVZqxKqxD9BiWxGlHe5hsw74l7dOPyIsTA19oBnBwxOD7vXqA89W
X-Google-Smtp-Source: AGHT+IHO9B9Y+hNiUlJchmPGO1bfla/oVAYbPDtR59a/yutgGUGcgccRztyGfHpnEXp0JW+cccfCVQ==
X-Received: by 2002:a05:6102:292b:b0:479:e377:2c2d with SMTP id cz43-20020a056102292b00b00479e3772c2dmr8776468vsb.32.1712613135444;
        Mon, 08 Apr 2024 14:52:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p5-20020a0cfac5000000b006987272f5cbsm3456831qvo.71.2024.04.08.14.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:52:14 -0700 (PDT)
Message-ID: <ab38046a-a56d-43c9-85de-157e88ad2053@gmail.com>
Date: Mon, 8 Apr 2024 14:52:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
 pabeni@redhat.com
References: <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <73ef7e23-d09d-42ec-8a11-0a42b8b6e459@gmail.com>
In-Reply-To: <73ef7e23-d09d-42ec-8a11-0a42b8b6e459@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 14:49, Florian Fainelli wrote:
> On 4/8/24 13:43, Alexander Duyck wrote:
>>>>
>>>> Also as far as item 3 isn't hard for it to be a "user-visible"
>>>> regression if there are no users outside of the vendor that is
>>>> maintaining the driver to report it?
>>>
>>> This wasn't the case. It was change in core code, which broke specific
>>> version of vagrant. Vendor caught it simply by luck.
>>
>> Any more info on this? Without context it is hard to say one way or 
>> the other.
> 
> Believe this is the thread in question:
> 
> https://lore.kernel.org/netdev/MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com/

And the follow up:

https://lore.kernel.org/netdev/14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com/
-- 
Florian


