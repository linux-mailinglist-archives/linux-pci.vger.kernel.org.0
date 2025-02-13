Return-Path: <linux-pci+bounces-21340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA86A33CF0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 11:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6857A3B15
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF86620E717;
	Thu, 13 Feb 2025 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2cV9Wio"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44539190477;
	Thu, 13 Feb 2025 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443747; cv=none; b=L6PaVbePKlelkWgWSsUIq6Xh6WsMn3TWPUyjQvEtzEy0cmmlVKcFdRQxpa2ZAWfel6BtUo70Yab89DeuN1ihaEPNcjsUUXojf83/t8JH3LM7lEUMu/zik8Q+zxwZZbfzn1dFkuKjLGq2Ntz0jutlQmP/4m3XwIfqaGilFYFMIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443747; c=relaxed/simple;
	bh=XJcMuzWHcfvIFulAAXufOZytkAhIQZd/BEnzBVlNqzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqH1gum7SzWHLQW+liDHCYJaM0qOrtJaIWpfbwmRZ5iTgIO/vKg16GeVM6FyO4h8TjZcEGZA7jl2Tk1+chmkGeCcHEGhjMEYl8l1awQdl3d/3ZCSCfl5iN6t4bJiByEmxyQXcsoabGFYtqQUPgKQ13rZHbFFkePIMyofRm/LKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2cV9Wio; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d28c215eso9160425ad.1;
        Thu, 13 Feb 2025 02:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739443744; x=1740048544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gAqXc8HUCVABGZPiT8WxinVa7t3RXf3lPMGTe4zgq4=;
        b=B2cV9Wio1fnZsCFO91/jAWT0RrxSqGUtJqs2SlI1utBaImRMqO1Ev97Irsr3FhLYgT
         Ce1xm+4SVlUYqxZbfW1i6GEq7E86vXMtLQM6tqr3a0+VnnXnxeQYT0Wp5UI/4TZeanw/
         JmsT8HNpaVJlOo1AlUdoIEVRCU3geMK7uJTZQyFDM0ffjyeAeVpwgposzSksU6vSk2AJ
         ruCp8olhYdrKno2Hb1LFqqWVgVVfYSifhtp1Cwq93MlhmaAfrJ1/rh9J2NYODsrkYV5k
         B7n66DW5pwTnhupEw4ObgxDJ+GKfmov2D9JBqtrp9iDVmIG5Cv2qzmBvYrWk7DUBkaKX
         URhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443744; x=1740048544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gAqXc8HUCVABGZPiT8WxinVa7t3RXf3lPMGTe4zgq4=;
        b=T6uP0CqLBWNrleQrLEsimq/+O0g5LFddJ6bzYVaIplUuzps3ASUYw3xNkG0Kiu6uNS
         x8iJROk0TVhihs19iXBoXNRMgijbK6gxD+FDosmNzbAUL144VerkLwxTubLuOHMm5w7Z
         ytD3wvSIRs1gyyklOyc4FAkTdJt777og5Ih7mARLlrIzosQ3IjuCBoG0LKAwMJ8tiPVF
         byBA4+txVJZ8G/o1cdW8BbvIkC61QZLp7T3HB3N7BlBglps3FOjTwtptmloc0k/iHswY
         z0etJCQJVw/VSMBHDZtxLMur5HIvqB5k9QW3kQA22x5YJQxmCLUMhtpn/xl4k31qX9Lq
         nL6g==
X-Forwarded-Encrypted: i=1; AJvYcCWOV2DP+gy580cvCTiBNVBgWhCsqXFXkC19ZjZ8Guej8+Gjt/29QFST42klGZ4TNdPzJVtcjhQXQgtjwDo=@vger.kernel.org, AJvYcCXsMj6Ve91bNHWVPiXosfp0O96zZtE9aX9HtyOJcjeP6VWHPXoLbXV4fNsPS+JEUcwq1OeTEoAYP81C@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnh58OXKR9E6znuk1wyrsShPTeZ4v+a2cHk3sZx+0ncH8mB+Q
	IX3ITCOouZz821EnYFFFYOZKN17sF3EuOeB7zlR1hHOPqykEzGNHPPpOMA==
X-Gm-Gg: ASbGncsHSmT3XC0DQFDiQFZBa4L6aZ3CqUbcPwpFjU/hzSNOoLWtIJmhAEjRpF4L+Ce
	AxM82xDfb15gLMY0x4017w2+iBBoIOeqSi9eBXzcw3mu9gpnfAbAoDrzgyeH2+HCwOvYL+F3yN2
	i0/CVG1TWiAdmMh0J7D+3tHuidD3E+Rx6y4BTuLMuJs7axKCyomuR8BoszFzYSTaJmA9M31R9oj
	9TDXBgLYZ1a5Lmvmb1wGWkSQO5gZpiAicn3UbeQ7Mh6CIMpk27VqLj5QkDSF7OTa4SqehfdJUg3
	0XrXexHdkXedpx/KP7xDxJeP+p+FgrZhREQt2G0BBDU87CdtLGAmQgKnZzE=
X-Google-Smtp-Source: AGHT+IHPI73iqJAhygL+ckoDjjYEVJ+PufLrEnm/87ssHD8ijoBVNGHMmXX1kXE88O++SXm+YNWUKg==
X-Received: by 2002:a17:903:22cd:b0:220:c63b:d945 with SMTP id d9443c01a7336-220d1ed1d7amr49577425ad.14.1739443744433;
        Thu, 13 Feb 2025 02:49:04 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e? ([2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585708sm9752485ad.217.2025.02.13.02.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:49:04 -0800 (PST)
Message-ID: <922bc558-4d5e-4e8d-bf9e-99fe0babfa5d@gmail.com>
Date: Thu, 13 Feb 2025 16:18:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
To: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <Z6qFvrf1gsZGSIGo@kbusch-mbp> <20250211210235.GA54524@bhelgaas>
 <Z6u-pwlktLnPZNF-@kbusch-mbp>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <Z6u-pwlktLnPZNF-@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/25 02:48, Keith Busch wrote:
> On Tue, Feb 11, 2025 at 03:02:35PM -0600, Bjorn Helgaas wrote:
>> This is kind of a complicated data structure.  IIUC, a struct
>> pci_saved_state is allocated only in pci_store_saved_state(), where
>> the size is determined by the sum of the sizes of all the entries in
>> the dev->saved_cap_space list.
>>
>> The pci_saved_state is filled by copying from entries in the
>> dev->saved_cap_space list.  The entries need not be all the same size
>> because we copy each entry manually based on its size.
>>
>> So cap[] is really just the base of this buffer of variable-sized
>> entries.  Maybe "struct pci_cap_saved_data cap[]" is not the best
>> representation of this, but *cap (a pointer) doesn't seem better.
> 
> The original code is actually correct despite using a flexible array of
> a struct that contains a flexible array. That arrangement just means you
> can't index into it, but the code is only doing pointer arithmetic, so
> should be fine.
> 
> With this struct:
> 
> struct pci_saved_state {
>   	u32 config_space[16];
> 	struct pci_cap_saved_data cap[];
> };
> 
> Accessing "cap" field returns the address right after the config_space[]
> member. When it's changed to a pointer type, though, it needs to be
> initialized to *something* but the code doesn't do that. The code just
> expects the cap to follow right after the config.
> 
> Anyway, to silence the warning we can just make it an anonymous member
> and add 1 to the state to get to the same place in memory as before.
> 
> ---
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a37..e562037644fd0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1929,7 +1929,6 @@ EXPORT_SYMBOL(pci_restore_state);
>   
>   struct pci_saved_state {
>   	u32 config_space[16];
> -	struct pci_cap_saved_data cap[];
>   };
>   
>   /**
> @@ -1961,7 +1960,7 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
>   	memcpy(state->config_space, dev->saved_config_space,
>   	       sizeof(state->config_space));
>   
> -	cap = state->cap;
> +	cap = (void *)(state + 1);
>   	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
>   		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
>   		memcpy(cap, &tmp->cap, len);
> @@ -1991,7 +1990,7 @@ int pci_load_saved_state(struct pci_dev *dev,
>   	memcpy(dev->saved_config_space, state->config_space,
>   	       sizeof(state->config_space));
>   
> -	cap = state->cap;
> +	cap = (void *)(state + 1);
>   	while (cap->size) {
>   		struct pci_cap_saved_state *tmp;
>   
> --

Thanks for the clarification. I now see that the original use of a 
flexible array inside 'pci_saved_state' is correct. Would you like me to 
resend the patch with the modifications you suggested?

