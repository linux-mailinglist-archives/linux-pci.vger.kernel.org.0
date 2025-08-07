Return-Path: <linux-pci+bounces-33504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D5B1D0C2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 03:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CB31898AD8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B251E5B91;
	Thu,  7 Aug 2025 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFdezFu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029914D2B7;
	Thu,  7 Aug 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531707; cv=none; b=E3v3DvmbLKaC1QeKkK2hmZtwnbHTxG6ydbfZhGJfIYKxCCu3MnTTWn23d9XL2W7R0YDyFE3N9d58XP/qOsX9NXSr8yMimyc3en36/nUKnvMqzpCuspeHOq4dX/4aRZO1pcsAWg2g1J8TQ41DpjooBG1Z1m4FweiWlECBxBvstsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531707; c=relaxed/simple;
	bh=xIemcRtj/buSKba0olwitJryOOJRnALqFmIOZ32ilbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWRM5NZx3pevXkBaF4EZDzEFYGqljd6Izl5xDNkwPuA1b1CjJn9cFMqv0JWaMpyGiYLhz//c15UKM9fIz0zhBaz94X+CAvgwmiiWVY1Hs6wcj341IdiFz4TeLIJg42rlNjcZ8FLE14qSApjzJI49DMINxdhEoood/WoG2nJE58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFdezFu4; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so83783266b.2;
        Wed, 06 Aug 2025 18:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754531699; x=1755136499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujwRlQAOixxVFLF3P3Xei9KX9iGKrNXHg+2EQTVW5iw=;
        b=FFdezFu4vDoke3zMgaq9jvRR5jLPpVUOG9pIivD40wDUoo2J+zVpEozAcRwwdpnh1N
         Gr0rlgMSQJCEAGMs/ZyCWTSa6x7bWLXkxbuFjiR/zDkqRpmqiawiCGaR974CR6AYwnMU
         UiIrtssR/XWr1p5DlB2G3Eu++F5f4fBqF4lLUxRJXdD52k1KUeybN4TekGS/hQ9wq4S+
         kKlJDS1HcqyHV3RJlP7JH1iOQk9AkQeOtt3cGq5MuL/c3q3PLp0J8TaYtaHHc+m5VfOs
         RmH2dMOKYDJtMFS57JebTSYLgxmNZQtoNZYdgkOnBTBxJ8gfUXXdcCt2doHcZRyBEtKX
         57QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531699; x=1755136499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujwRlQAOixxVFLF3P3Xei9KX9iGKrNXHg+2EQTVW5iw=;
        b=NLzYIR7xm5kw5MkXXhsfCnAtjPeb9vSwuzWKMKXnjzvFOEUmYt0LOgM9JIQpcxAUpG
         Bq13VTQ1/BVqJNR7cJFKNywMNHRposzyEu0YN2MDWxBv+Y+k0E9MglDnhE6+l7NxJYyP
         i1pjj/2BmrUFUuNGYph1va0yeMv1QvQMvqT6TD7hYR6mYswol8pIbOeFnTIMzGD2YQRH
         DFfyNIoZHVurobQv3+hOdqysSvw1JrgC8SqEVw2W3NYS9Biwpa1Nx8u3fdGB6fMxh9yi
         SfmaT2WMz4CthPD6dkRAQUixDimdZSgeBoApV8N3/qkzyT7XImDQCyIrwd02u7pLodhO
         S6qw==
X-Forwarded-Encrypted: i=1; AJvYcCUBzJwQJGuM0MKuJtDV10f9VVoLYDQ4kuxtKX6SnIfHWqsb1svdsOBJJusxpPkugm07ZiOdZFh4rzDKOK0=@vger.kernel.org, AJvYcCXOueEfNSDCOWjGlR2oXUhi3MquqBDjSIpMn3swym3Jushn5jAPpTM0pDymLre6TskzjerZ0kmywA1H@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpPpj6DFkeqDygpFioyc7wF0xrmp6QbZ1nclZ8Fy2HJ1/2ALy
	J37E52IHbpuecIc+iy8nKiq3fAI27gozNDdJ2p4u+3D0cu06ZBDxaBjO
X-Gm-Gg: ASbGncsvyhIO0feiK/LJtyAsTH8vMzcfSUisk7yw5W4tXkEqXg8zJdrinHE8SXjr2Wl
	6UcmZTqd1uRG256umPT+SLCPTprNwabLFsyn1EqyZ3c73TqeD5X9ARpkp5oXvic72TyjTo+YvxT
	Vp+3/kLQRh6zdDfjZcGje3uqruJEkk5S4yKhA3i2OOQLwMjDMoUq9RE/qHEMHjLctWS229rKbvo
	r+GLcSD5JDwM4dKXjKcT+jaK4KpGvGJ6WG1cKDhSKnajnuPC4wklf7q367kPtxLV4+pU+0472zB
	42bZ6VQfUIoR0CyTPS5Vel/xDccj+1/aAdaEg7nyk23XY0FEcJl/V34NWnLBWrv4gReNqj/h+Fe
	e8zQWlS+dgLfjmy3D257DIJokxKP6LLSwqV705pPgW8vlp2iYvfzb1RiWpkBpOVRV0hcqC6hHLI
	N70WHdu2tPTsbVszb4
X-Google-Smtp-Source: AGHT+IHgp4Rd2zyE3rVGDEOZP4X8ktT3n+JKIRK0hV5+AIl4Hb6xONo2Qx5UAqKol8VAGYxnqlw+Wg==
X-Received: by 2002:a17:906:dc8d:b0:af3:9676:e9ec with SMTP id a640c23a62f3a-af9903fc6d2mr452862366b.39.1754531698948;
        Wed, 06 Aug 2025 18:54:58 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm1218337866b.116.2025.08.06.18.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 18:54:58 -0700 (PDT)
Message-ID: <9d53f097-7e12-4a4c-a2e9-e7b3f2f911a9@gmail.com>
Date: Thu, 7 Aug 2025 09:54:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
To: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Hongbo Yao <andy.xu@hj-micro.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jemma.zhang@hj-micro.com, peter.du@hj-micro.com
References: <aHCPTU03s-SkAsPs@wunner.de> <20250806213409.GA19037@bhelgaas>
 <aJPOmw2c8LGW2qN7@kbusch-mbp>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <aJPOmw2c8LGW2qN7@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/7/2025 5:52 AM, Keith Busch wrote:
> On Wed, Aug 06, 2025 at 04:34:09PM -0500, Bjorn Helgaas wrote:
>>>> However, the current 4 seconds timeout in pci_dpc_recovered() is indeed
>>>> an empirical value rather than a hard requirement from the PCIe
>>>> specification. In real-world scenarios, like with Mellanox ConnectX-5/7
>>>> adapters, we've observed that full DPC recovery can take more than 5-6
>>>> seconds, which leads to premature hotplug processing and device removal.
>>>
>>> I think Sathya's point was:  Have you made an effort to talk to the
>>> vendor and ask them to root-cause and fix the issue e.g. with a firmware
>>> update.
>>
>> Would definitely be great, but unless we have a number in the spec to
>> point to, they might just shrug and ask what the requirement is.
> 
> I agree, and I have similar problems with other arbitrary kernel timing
> decicsions. Specifically RRL where there's no spec defined number yet my
> patch to modify it has not received much consideration.
> 
>    https://lore.kernel.org/linux-pci/20250218165444.2406119-1-kbusch@meta.com/
> 
At least, with this patch, have a workaround in hand to make some device 
work.

Thanks,
Ethan



