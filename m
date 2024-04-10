Return-Path: <linux-pci+bounces-6065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CD89FF53
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA3A1F29F94
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035C17BB23;
	Wed, 10 Apr 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goiAhOHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075417F371;
	Wed, 10 Apr 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772043; cv=none; b=f3/FVJZvuuXm0JFC9KeeqZAHkjuTmDmtHk1M3F4c+hJ2PStdiJ+CAW7cgkmWu6nMGFtnMM6AEtMINvi17cVU+EyrMqmjfru0g5D6cV2AmTMndBDaC9LG7C47+UmW1z+YU3PKB52HOjjTel2aZU1+coxYF90OLSHnaju5MBghGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772043; c=relaxed/simple;
	bh=dYe244uDkd1g1GT41OqyS2+BFWtaQ855RU7heJJ6Qy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRRyFe+2DKIiore0KgAxTr0hZr29mgyDNwhmvzvVXK8p28pKSEnlVVeS3ZDhtAzS6LrpvNwnj9S0dErbg5QgUcWux+HuaifjY9qs9OZUDVKJ7p5KFFUmdmCnWa/NsZi0Zek8AOYpv4bdI7FdiSMzN52QPy5XmObTLp6zoDLwkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goiAhOHo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so46865365ad.1;
        Wed, 10 Apr 2024 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712772041; x=1713376841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k77HEvl7+ygHejXWSm2a9OBOEPQtsGK4mgKlf7QIQF8=;
        b=goiAhOHocF7RAg0TZXmIkRrWRv+OfiYTAYM+PCEMI6zU4LhMbCF7z+Vbge67SfLU25
         lhh/BVzARSfKRkWNgKHccicu94Z2BJDSov3BbK4HMQ0bNlIe4QfpZjV9jdcMMqZgMEY4
         bXPB0KbSGe0DvcKD6HM/p3kn9c7Bq7XAZ3pMbZB2KfvsbvvDtB3fM+BWvaNgk7BCkcyn
         bfLSYUTURJIg6cYrAmAWKBED0xxP6i09MfDMXfeUsTuRWf2IZDzjNWcEQTJID3cfwDmR
         uqNvdKaVDlqnZHEd2B9eu34GwpW6MnYtQedVG94QoN6tqHeepsgwOrVCayQvt5m2Yq57
         sNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772041; x=1713376841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k77HEvl7+ygHejXWSm2a9OBOEPQtsGK4mgKlf7QIQF8=;
        b=ICKvs37HpuIWnSza4jQSw+m/EU1bZaO82RrVH9YAIzg1/xaRqYmWb3oezfM++Hr+9q
         OZvdclnn+QtqaDCiqLxF7yPf8EfXHK21iAGYlhCWUnq65NX4GCCHsyz3gQ7bBOxddq0z
         iziyYhQIc4RVN/vXgzCpaHQP6XEcQkG4OkkCVW2DgSsovOe3A0AZDaQkFFv9EdVgw8Ex
         ando+jrh3PWSoUXh9OoKHA2snrSdPitCeK43wPRfIEXtRR/bND29yIPvgksqVDsV3QvU
         LlVYpy1uiGah6rEiF6jpmvj9K4yBAUsSV3bSsevsg2LS+ej6T0sH29JxIwNdFo7qyVlU
         EeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgtJqO4aYh2Q/nry7Zdu6/6lGyTRRbjn58Ygf0HeVONXAtcwCpdsBWxJ/YnpNaofAb98oeAJ40qAxd7lwSbTUcSO+fXbZuJCgqzbsdKLK5Fh+whWz4qSsrGuaVAwCKxVQR
X-Gm-Message-State: AOJu0YybUtotVGeD/Ky5hUFSf+alKVRkkf2ZjdSsgcRkLuo5kf4skRep
	NMJhAiqyQTDsnepaEhbQMxaUqlIBDDYeG58Um5+mVYceqEh/kwGl
X-Google-Smtp-Source: AGHT+IFV+Sp8QEQjSn9gR1TaqzY5IHeKrnL8bBMB7NIg+jxH0F4qvpwdV6dTDooGQY33tYwAAr/NCA==
X-Received: by 2002:a17:903:444:b0:1e0:3084:6cb4 with SMTP id iw4-20020a170903044400b001e030846cb4mr2768803plb.17.1712772040757;
        Wed, 10 Apr 2024 11:00:40 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001dd59b54f9fsm11225654pln.136.2024.04.10.11.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:00:40 -0700 (PDT)
Message-ID: <d8433563-f867-428a-bd8a-9bfffe744da4@gmail.com>
Date: Wed, 10 Apr 2024 11:00:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, pabeni@redhat.com,
 John Fastabend <john.fastabend@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org> <ZhasUvIMdewdM3KI@nanopsycho>
 <20240410103531.46437def@kernel.org>
 <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240410105619.3c19d189@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/2024 10:56 AM, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 10:39:11 -0700 Florian Fainelli wrote:
>>> Hm, we currently group by vendor but the fact it's a private device
>>> is probably more important indeed. For example if Google submits
>>> a driver for a private device it may be confusing what's public
>>> cloud (which I think/hope GVE is) and what's fully private.
>>>
>>> So we could categorize by the characteristic rather than vendor:
>>>
>>> drivers/net/ethernet/${term}/fbnic/
>>>
>>> I'm afraid it may be hard for us to agree on an accurate term, tho.
>>> "Unused" sounds.. odd, we don't keep unused code, "private"
>>> sounds like we granted someone special right not took some away,
>>> maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK.
>>
>> Do we really need that categorization at the directory/filesystem level?
>> cannot we just document it clearly in the Kconfig help text and under
>> Documentation/networking/?
> 
>  From the reviewer perspective I think we will just remember.
> If some newcomer tries to do refactoring they may benefit from seeing
> this is a special device and more help is offered. Dunno if a newcomer
> would look at the right docs.
> 
> Whether it's more "paperwork" than we'll actually gain, I have no idea.
> I may not be the best person to comment.

To me it is starting to feel like more paperwork than warranted, 
although I cannot really think about an "implied" metric that we could 
track, short of monitoring patches/bug reports coming from outside of 
the original driver authors/owners as an indication of how widely 
utilized a given driver is.

The number of changes to the driver between release cycles is not a good 
indication between a driver with few users presents the most agile 
configuration, but similarly, a very actively used driver with real 
world users may see a large number of changes between releases based 
upon its use.

What we need is some sort of popularity contest tracking :)
-- 
Florian

