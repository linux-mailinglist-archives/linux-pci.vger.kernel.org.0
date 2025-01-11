Return-Path: <linux-pci+bounces-19643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC9A0A0F7
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 06:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5088E188E22B
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346511547FB;
	Sat, 11 Jan 2025 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="bOfXdCai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B711154449
	for <linux-pci@vger.kernel.org>; Sat, 11 Jan 2025 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736572845; cv=none; b=MFQD9pz1dWpUrvJ7dL3E/66ftwDbUvOOKU9t18z0+wm8RtWKhNo1h710kBnm8iy9ZR62dr2gl0r/uSzzDMWhSMrg3tcEINI8uZv4fNdjTd/WITa08gjrGCcUpWfdOcPwMP4BhDavHpzheTwhVHC6mlbZM3M3kOdO51IjfBlCT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736572845; c=relaxed/simple;
	bh=XVHylNyHspfxsR5nvSnwfDtdr3rAkF+h/5oVprq5HmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDyNsIAGcXYJUFGAmnLRcJk1Wn8baCgENU4AncK4OqHo2fcoFPdDcWz2kINIaFU34CbA70K4xtwvv9A0nlG20LyVID+OPAi5VNc/TA/YMBkszV86coIPm2TNZ8fVz35gNRkT3ZyPjo+xphCvmk3d6eXMdny0dnGm/ju8Y95i24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=bOfXdCai; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso46121995ad.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 21:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736572843; x=1737177643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pK2F+RBTaMSDxoEAtE8SM5XYDPlI0601AzyscCoxm2I=;
        b=bOfXdCai1SgljamBeP8QyR/JOQ4FbYnxuK7GlXHkGsDCeuRp9U+8zmW3OJUq30S6B1
         SLa6ui19ir6Lii6Trn9iWYfLppdt2W2DT2w6uVPu0JmvrGjHdcHfvfUrxUEcU8uJkXXL
         xL/mJqYiE8jR0eGvLV3CTmAFFoj8P0gn+JzbOc8tBxXMdCQwURAHVbMQTA6y3sf/fsrC
         XgLfftoWAKAE0rZKBAgYfjfI7C5co3rTYyLJZD2h2FcVghQVngthc0nH6jU9roNHK12Z
         wgCM/ETTekDHCgV/LyvrzNM1jNLyws6i6E1Km7UE513DdwrEWS8JILzSAYFUjCM9ksyk
         jLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736572843; x=1737177643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK2F+RBTaMSDxoEAtE8SM5XYDPlI0601AzyscCoxm2I=;
        b=up9oHS2pzVn3nzeYpJ2YZbgXKjEOt4WHgpXemw7IqcFJkV34OU06m/6/QVM+iJ/6aN
         Goac9zsD6Ttr7qdSQLrPpdWrYNW+ywWuM28mZy6Mut/0I1i5WIYTrT5/kdBcWbke0fOk
         VRX6LTtnegdylJduWsWJTqiAmBiM80CFUtNyFVTwSKSFycjO8OF1nRs9TSvo8uIKccye
         x+1zUPdm+ZiUQdTgXCs31WRc5fWJMPphQiTx4obyk4v/fjRedGiZHHM5h/oAsVSnEzZ0
         ZXL/1sNu50H74xyRTwdsPQ8mhxCn7c/cL6WgjEkvtwRcny6tqmqyPbNvwwjbx3DBxeW2
         gOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJg2Sw6RHErRMoSem5tMS4MY5X8ItMW4lwePR8sgNxqRcW8cYfZlJ6U6XYPcXdAEYoWWK5icCQIW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KeBnLh9bPPiBDqXfTh90Y+3/ylD1XBQNINa5AzdMbA8ksAWP
	/RUGigzeuPgjXPcIviagO1uShFq2eXBgV8G4GU+w2ADWwJ3lz+hOPOJXVJve5BVExgslooKx10B
	iYZU=
X-Gm-Gg: ASbGnctUIo0YZS/mkLaxUFqJcdlVOKAMru56W5cWC+fW+tSNpfqT4GEbnrmctgrCzCN
	KfOM7nO8gOl6DLDzPjwulbdMifOiny1QMDLqr2S0sfHVcodoo9ukZon0SNwrQKgrVKGmtL7jQqS
	/lO3KesuXZQQjgKi2NAjZ7Lwz6J0KeNdH9Xh61BDm6LaMKiPoV8RYdvCPzb83TuoCRrSuldncxL
	1j2pLZjwzUBzdrTX7PG+iMqbg1n+id6N8t9aWnElGM4ChpUFjoIwKoFDoLrJuiyyGU=
X-Google-Smtp-Source: AGHT+IGBR3qO11ykBQufc7YwvifpdR2xYxMPWXbJI07PD0vx+LDE0o4MSNzVKFuQj6IitF6hcz/7jA==
X-Received: by 2002:a05:6a00:858a:b0:727:d55e:4bee with SMTP id d2e1a72fcca58-72d21f112c8mr16427488b3a.1.1736572842758;
        Fri, 10 Jan 2025 21:20:42 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a3c259314b1sm3095729a12.9.2025.01.10.21.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:20:42 -0800 (PST)
Message-ID: <5f689383-055e-4140-8b87-1f1fa92634e8@daynix.com>
Date: Sat, 11 Jan 2025 14:20:39 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix config_acs= example
To: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

It seems this patch has been forgotten for a while but it is still 
valid. Can anyone take a look at this?

On 2024/09/15 10:36, Akihiko Odaki wrote:
> The documentation used to say:
>> For example,
>>    pci=config_acs=10x
>> would configure all devices that support ACS to enable P2P Request
>> Redirect, disable Translation Blocking, and leave Source Validation
>> unchanged from whatever power-up or firmware set it to.
> 
> However, a flag specification always needs to be suffixed with "@" and a
> PCI device string, which is missing in this example. It needs to be
> suffixed with "@pci:0:0" to configure all devices that support ACS in
> particular.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ee2984e46c06..5611903c27a9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4604,7 +4604,7 @@
>   				  '1' – force enabled
>   				  'x' – unchanged
>   				For example,
> -				  pci=config_acs=10x
> +				  pci=config_acs=10x@pci:0:0
>   				would configure all devices that support
>   				ACS to enable P2P Request Redirect, disable
>   				Translation Blocking, and leave Source
> 
> ---
> base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> change-id: 20240911-acs-3043a2737cc9
> 
> Best regards,


