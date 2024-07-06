Return-Path: <linux-pci+bounces-9884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85D2929530
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8AC1C20C1C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177A2AD39;
	Sat,  6 Jul 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKnH4/X6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517601CFB9;
	Sat,  6 Jul 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720296733; cv=none; b=LHlUv7d6knvDkU3hnqVCLv06Y48nsRO7FIZ6w1Fx74n+OY9Ofs43Tad5zXC2qZ5LbkgFgpJeKHe8oERBa/8fphnziMYlBmV166bwtMLwVIeN3dU5A3mcu0UxZrPHucYqGTG7Y9Agi827Y3LviOBymnNbUFFYd5eLdomUsUOUi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720296733; c=relaxed/simple;
	bh=zhFGziJYik4MooPjWk3nhAc4A5/9t9zs3dRYsFbiA8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ca9rhzwO4JNvWC8YyzZO0g7Z70CISxgDo7MW0sqKsW4RVy97csow2HART9VDXGrNLo3yf40Kr3SzWMG7PBKfKjspgpgUz84MWAOm6fsZenV33oh8N2acv/v67bfsBN51x7dXaku1/3Ly8qWWEczergBxt48TEAaaSzm22vp2fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKnH4/X6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367a464e200so1253948f8f.2;
        Sat, 06 Jul 2024 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720296729; x=1720901529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0Tkq1RhYtD+dPdZ1x927Pce+CrXDfqDHb1+eRYOEuM=;
        b=aKnH4/X6Jf86tnbRzmjz0QFt8CBrEwzXT1Oxa9GzKe1fyfCoE9n7HGNsSae9JaoGeX
         thu0O5qofNRHrQpk5x8A+2M3NY1vmkqZrrAiu5m/iOKFPYtjv2PgCkv47WYJMXIhePwn
         7jROX5dUs+Qfsc5xPoB3Qn+T0jamYaAFwW4vGJyTf3sxaBrHvOxlE4C01H1u+9lPKY7b
         C+jqhm61K+3X44Jcx2LH2hXa/UOWiuye65u0x1P7xcnwRUHMBLYKODgeXQEOZZJgHBfo
         51SLr+PhMwbTKvD1l77wBaoGkuxBNc0/OEBxfFOlyPkvtVb/ffCMmMNEfhBpQrp/JRTI
         Z2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720296729; x=1720901529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0Tkq1RhYtD+dPdZ1x927Pce+CrXDfqDHb1+eRYOEuM=;
        b=avoiAYtF6UC3/Q+bBD469hASW7QgV0k6I5q7p9KcpLkMvwcTjLDjertjmkbQbzQEZT
         C4DgUf0jmLFKC/l7ie5lLDIRO4w4vD97nvDd10SxSq7tNb1d1Xfd9KItBjHfsnyEZ4yw
         xUUryeOFQvlf581/kjwmv4pAbVzAzgsx29ZHM3FW+MypTZx4YUZ4RwZ4yDPHLCeCZaki
         UjZdyY5sy3cET1vPU9pMo9ofb9VyZdbvfFZKcy7N1i923dJSFNS8ZzsuM4aC9u7RCS/S
         zEkaoMoTfNb7y3lqXgv2dLHaXjUhXSvmddGjP3C0Azfe49jBhVM/fGw4IKzibS4xqMuj
         mrjA==
X-Forwarded-Encrypted: i=1; AJvYcCVsuKm9DvWkUFjP3FPpf7ppOJ7Y9W6zS/tYattA7r5ltwR3d2cIZW+Umk9+KVhTEJ3wjLaT681x95MdVaNeyl+Alghqzfck/jviHhAy
X-Gm-Message-State: AOJu0YzJZQWFn+efgyDtWksned+CdLGv5daCfcUg6/4bShG58WMjMHa/
	R7zBMFUJgyXlYV88uz+t2pmpBblsfb/o9DQpWaX7l8etMrIvpkWU
X-Google-Smtp-Source: AGHT+IGZ2bFkf/q6BV0KgNDt/DSZ4y/lSF+hy2lCq4nHCNJvsafdc+BeSyjaXbkAN3pPx9NDHUguPQ==
X-Received: by 2002:a05:6000:124b:b0:367:4384:a572 with SMTP id ffacd0b85a97d-3679dd194abmr5265789f8f.9.1720296728367;
        Sat, 06 Jul 2024 13:12:08 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:3749:bcad:5b9f:8492? (2a02-8389-41cf-e200-3749-bcad-5b9f-8492.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3749:bcad:5b9f:8492])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367938a6e97sm9636984f8f.109.2024.07.06.13.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 13:12:07 -0700 (PDT)
Message-ID: <13aaab26-6b9b-498b-b3b4-1f4bd4256b49@gmail.com>
Date: Sat, 6 Jul 2024 22:12:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: kirin: use dev_err_probe() in probe error paths
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
 <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>
 <d42b25da-44d9-465f-b651-134c2179981b@wanadoo.fr>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <d42b25da-44d9-465f-b651-134c2179981b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/07/2024 21:47, Christophe JAILLET wrote:
> Le 06/07/2024 à 17:07, Javier Carrasco a écrit :
>> dev_err_probe() is used in some probe error paths, yet the
>> "dev_err() + return" pattern is used in some others.
>>
>> Use dev_err_probe() in all error paths with that construction.
>>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
> 
> ...
> 
>> -            if (ret < 0) {
>> -                dev_err(dev, "failed to parse devfn: %d\n", ret);
>> -                return ret;
>> -            }
>> +            if (ret < 0)
>> +                return dev_err_probe(dev, ret,
>> +                             "failed to parse devfn: %d\n", ret);
> 
> Hi,
> 
> with dev_err_probe(), there is no more need to add 'ret' explicitly in
> the message.
> 
> CJ

You are right, thank you. I will remove that from the original message
for v2.

Best regards,
Javier Carrasco

