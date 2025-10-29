Return-Path: <linux-pci+bounces-39729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B699DC1D6FE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 22:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242473AC959
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090F319857;
	Wed, 29 Oct 2025 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KrZj5EzZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997E319619
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773344; cv=none; b=gDaNJywQubXeJocoSMSBecLHxPuTHRCwHHG7SbtyWowfe6iopecMpp8E6Ur1oYtR2apVV7MIF8VbPkZ4EfXd/RL92jZ7MUKtVsGuBYoo3hPis78huh7PiwDmqHzqcsT2G3xwBCBSZ3DKgBvsjy1Zdn9bc4VjyQUL9VzkOqSKwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773344; c=relaxed/simple;
	bh=1q73q8W7QV7s9QGLym1kbIChQ8kYo8SE7G+pzVT/LkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+vsCsz4gdSyq7OqrOog9yXqk8wWUz0h674J2H48E2xKDt3Lyfz2qGhPXbPp+T3pzfmZFc8Vz40+F83h37QaX6aww5Oti6tn9372Pgy16Y9a4bciYr7z/oylTvwsVrqOVUwsyRcHSuE9lNeG/BJJVoLEHQZdqTs/uICvB4Mp2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KrZj5EzZ; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-945a42fd465so14470639f.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 14:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773342; x=1762378142;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ICGCWHoSY6sS/VxfMT7LYzSsa2Jc+4sPS/DX5o4HD4=;
        b=VxYVeNUZdgvwoVVg/MzSds8wWY5q3Gq3yZqWUpiJ4/VxNlrL5g8fhwpv/yhfwauL/T
         Dex9KOYPEgldxkp01kC1VYxtJUMDhdJUpm2GD+U9nZPaHW6IgoJ9AKJJXe5Bvf4TzvnN
         kWiij4ATddo+hddSXwva0UWrh2p06z19rzqeyIeUGfX3eCMgdb/bxGM+RH6XL4a4l/fG
         i9D5j2pkh8NtVRVOQ49AE3rGHjPtRiwr4PhAx4oQK5YL56Ipbf9B3LgB1WxYy8hc6znZ
         FPOEwGJy1ca3J3jWgjMxh+rLOlokjXHPH1O6MgSTvAZBENKXp19SSQh5ZcB5o/xIEPqP
         k6Ww==
X-Gm-Message-State: AOJu0Yy1w6Y37n6+y3Faqmvb0nAVsBWdZUv+QAxCTfGoCcdYT7Jd6CES
	kSLuYznFYibnFRtp3RCOOQHtHlYjhEC6OTcsOXlOsDVTeaaJM5+SVY6N8QrXkbR0moJNlNY90Aa
	iRbLUMEZ+xfFgRw2hxV5IrNpah3dQBpDXtdPYBx3kqGYkWMz4JA8sPlyYDW9R2nYy3UAMCwmaMe
	gCFj/eTEnNCCXzoUNwkGJs3ABSU5Oi1ytUy3srZbZQgun0lZEJoyFTsswAAd9IjqPpYdzMXgXsX
	F2CN7uh/CxQjiBD
X-Gm-Gg: ASbGnctQhrXrCDnm+AFpobaTVf3sj+F/wJRIIIk2M+lSJc2i6fxsQ5hXEWru6TmaJM9
	YOFI3FzbIPg5CvG5Kbm90AXvrb61lhON+EvkxjCGSSAMugHgqkAXCCWvJhX+WK6+4Yf1UBJb9U4
	+vqapeTrPELq5LkFpb5+C1Enb35I75/GZXf86HndCRs8YYITTDS8kmuoROfiL13o1VqzOq90ye8
	F/HMi8oYauSl+OWSRuE/UwfaEptn0MeliTARwgMCLKpsL0aEiJjFKto1y5zAQvTXgP4jL8rW4vX
	/gAUn+4BIg/ajTUROuuvg4Q/6KMeOC/6p1s3TYCRNOtARxwcu5gAF78gt3da2GBBFoF386faO4N
	dOHqSVGLQe0pEr54ge6/Oi6LyYOW4kZgK/NlqDCI5iLM1mVDMUXY61bOKn2UeA+U+Hn+lDZhU7p
	z50uONGXGSSlusZiTYDAmW25xPIXYuCh8PUjg=
X-Google-Smtp-Source: AGHT+IEMCzRz6kEld2agsocEs9oXJlAbV8/puZl41rD7HXcGF3oDVGHqmJxg9MvKi2vPBBnNrTFJ2b2dspXe
X-Received: by 2002:a05:6e02:2286:b0:429:b49:7351 with SMTP id e9e14a558f8ab-432f903701amr55194575ab.19.1761773341828;
        Wed, 29 Oct 2025 14:29:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-431f6899fe3sm14522125ab.25.2025.10.29.14.29.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 14:29:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-89090e340bfso61477685a.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761773340; x=1762378140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+ICGCWHoSY6sS/VxfMT7LYzSsa2Jc+4sPS/DX5o4HD4=;
        b=KrZj5EzZjtnQgBYkrL/X4sW175XFTQzbRcU69uR0kPKimLwOAxZKmBbmJv0taLyBzc
         bQG5b9CkuEBo0UAP0iBVeoteZU7AohXQiyeEhmNCWZ2iCvkTmnyIallK+DwHRujFLrps
         TZLtNOVxpdDYla8uGaR/HbRfLq5UMno5r5YC0=
X-Received: by 2002:a05:620a:691a:b0:8a2:71d1:30d7 with SMTP id af79cd13be357-8a8e4fef282mr717643685a.37.1761773339812;
        Wed, 29 Oct 2025 14:28:59 -0700 (PDT)
X-Received: by 2002:a05:620a:691a:b0:8a2:71d1:30d7 with SMTP id af79cd13be357-8a8e4fef282mr717640785a.37.1761773339364;
        Wed, 29 Oct 2025 14:28:59 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fd8fdsm1124711285a.14.2025.10.29.14.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 14:28:58 -0700 (PDT)
Message-ID: <225baaa9-2c7c-4755-a999-3ecadc026509@broadcom.com>
Date: Wed, 29 Oct 2025 17:28:57 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI: brcmstb: Add panic/die handler to driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Cyril Brulebois <kibi@debian.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20251028180708.GA1523449@bhelgaas>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <20251028180708.GA1523449@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/28/25 14:07, Bjorn Helgaas wrote:
> [+cc Ilpo]
>
> On Mon, Oct 20, 2025 at 12:18:48PM +0530, Manivannan Sadhasivam wrote:
>> On Fri, 03 Oct 2025 15:56:05 -0400, Jim Quinlan wrote:
>>> v3 Changes:
>>>    -- Commit "Add a way to indicate if PCIe bridge is active"
>>>      o Implement Bjorn's V1 suggestion properly (Bjorn, Mani)
>>>      o Remove unrelated change in commit (Mani)
>>>      o Remove an "inline" directive (Mani)
>>>      o s/bridge_on/bridge_in_reset/ (Mani)
>>>    -- Commit "Add panic/die handler to driver"
>>>      o dev_err(...) message changed from "handling" error (Mani)
>>>
>>> [...]
>> Applied, thanks!
>>
>> [1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
>>        commit: 7dfe1602f6dc96f228403b930dbe0a93717bc287
>> [2/2] PCI: brcmstb: Add panic/die handler to driver
>>        commit: 47288064f6a6ce99c3c1fd7b116011b970945273
> I deferred these for now because there are some open questions that we
> should resolve first:
>
>    https://lore.kernel.org/r/20251020184832.GA1144646@bhelgaas
>    https://lore.kernel.org/r/2b0f9620-a105-6e49-f9cb-4bac14e14ce2@linux.intel.com

Sorry about the delay Bjorn.  Hopefully I've addressed all comments with 
today's V4.

Regards,

Jim Quinlan

Broadcom STB/CM



