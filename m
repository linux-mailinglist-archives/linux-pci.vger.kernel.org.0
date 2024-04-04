Return-Path: <linux-pci+bounces-5750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCC898FE1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 23:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E0D1F2197D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28894137760;
	Thu,  4 Apr 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM9pyfmo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468112D1EF;
	Thu,  4 Apr 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264840; cv=none; b=dUROtxlseNlud62hbdR5uamfBDgP1QAjd9OD5kcqIOLNdA+ozT6JiogQXmNPJKkhg4r8rF8M1HgxT4lKkAzVeb2DM4t0hBAAqhY5cJaX70jt78liTffBR3qLn2u8GpTVIMiY8G5SSa/QphDKAMnYHTjsSsS1b8T4aF7WTProafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264840; c=relaxed/simple;
	bh=Nh5PAPnh/cyeRNOqM3zD5P/mHqAKoD2Irkhju/9wvbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLpEWZ8P4fqqNibwKYs/ME1nnbmJlSF8dFbn98BD4F3dxzm++m1IIpuFPYIkZbI0vAYxfMGke614EiFbTJL4Lh1nzYfEi0mqggZSmPIYwbhv47N7JM2ojvvq+TgHx611cWXBjCHUhs1kfbVX7ea+nK0rV5i0qvuFPnQKvdGfqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM9pyfmo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2b41187aso513323a12.1;
        Thu, 04 Apr 2024 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712264837; x=1712869637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6HF0B/CHsg5srPKxaohvzFxybusLKwXIGfrSMwYSciM=;
        b=nM9pyfmoaS2gyZITyojQjSKkSB9P4gV4wFqcoJW2+mHzeQ72Ayr67vRUwbrBlr+508
         5FiiQq3SekG2FOtsPPd4wPKDDOUwGOa4YBJbMKu1aZi8SnyLUGMBt3Qf/FAC1zRc1ru8
         uFYltw8+zckRBL2VMgxtQvD/2kOQpdVrr6U8tKHUB94XT4zSGzwD7LulblUHlHBKe3ss
         GxZ2ZjWrrRbK0/Bj1081QIhgxnCjVXQmZxhtL+S/qa89/jCl6WlthRUsICeDWDMiTgvF
         gPm+gM754VvoWJqYrcRxZtbbopDqeZ3bsRX01L1mhNMV/m2UZygH6eNf8BXLstxxRZUV
         obTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264837; x=1712869637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HF0B/CHsg5srPKxaohvzFxybusLKwXIGfrSMwYSciM=;
        b=qMgFiq/nqqXrhwpkrwExoUWbsJqkXDyCAEo9b8Mx/ajYYtZiceU/WjG6kgEM3OV+CW
         T3OgCP2mE6AUuXSrsX+/ZH1cGvZmIB2DVXx754UI1iWd/0L9n8emnPLt+T72yq93gmTy
         tocyDb8ctwJPO6NwU41vAzLQaZnJiSxdIrcRdlHJlNZGPB3vxAGfJAYywhvi5G6/0T/+
         95K/VxAI7+ll3JKsiBZ4pgWMdM8Xyxhlhj/u1s8TivVNF3Uh8rfWPUUL8KkBjP0nu76K
         pg2S1kSSH66gsQwURhdt5bQ6Pd5kSadb3iafrYDk5PUkjVGdWeiMs9WQGtND+ticGLCd
         Mlyg==
X-Forwarded-Encrypted: i=1; AJvYcCWMGmaKA+e/995GlEOne3jTEtMvyd7aFNSq4091kqD3I5yXjgLYiCd8rLmEHsI8u7s+wILK7LGWu7kG4dmxQwOG36OfgklS1m70
X-Gm-Message-State: AOJu0YxuIZTjjQ1jvjLelpwb9LRYi5nhzN4TWmAHKmtFTFXtnboZX65R
	U2YU8NhT8/fU6uaFbJXmLG+48VYjk1H/PAM2JulQt1/tOuEtOxeo
X-Google-Smtp-Source: AGHT+IGC8j/pequCIPhN+3UBWbdtnIAI5fpmNyyNnbhocAmitdiidRmwIwDTEzCS06VWKFTikeFKCw==
X-Received: by 2002:a50:ab55:0:b0:56d:fc50:ec50 with SMTP id t21-20020a50ab55000000b0056dfc50ec50mr539861edc.13.1712264836646;
        Thu, 04 Apr 2024 14:07:16 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b917:8300:853f:3a79:973b:a77f? (dynamic-2a01-0c23-b917-8300-853f-3a79-973b-a77f.c23.pool.telefonica.de. [2a01:c23:b917:8300:853f:3a79:973b:a77f])
        by smtp.googlemail.com with ESMTPSA id k8-20020aa7d8c8000000b0056e1f4a8845sm41155eds.52.2024.04.04.14.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 14:07:16 -0700 (PDT)
Message-ID: <651f8a62-4fa5-4ae8-ba1c-ce8ab4e4e58d@gmail.com>
Date: Thu, 4 Apr 2024 23:07:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath9k: use unmanaged PCI functions in
 ath9k_pci_owl_loader
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <cd66af0c-835e-4222-b362-e2e9cafdeb40@gmail.com>
 <87y19ukuo3.fsf@toke.dk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <87y19ukuo3.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03.04.2024 23:23, Toke Høiland-Jørgensen wrote:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> Using the device-managed versions has no benefit here, because
>> resources are released as part of the asynchronous fw loading.
>>
>> Actual reason why I got here is that I was looking for places with
>> dubious use of pcim_pin_device().
> 
> Could you please expand the commit message to explain what this means in
> a bit more detail? That will be helpful to someone who wants to
> understand what the difference between these versions is and why this
> change makes sense, but who is not that familiar with how these internal
> bits are really supposed to work. Someone like myself, in other words :)
> 
Sure. I'll add some more context in a v2.

> -Toke
Heiner

