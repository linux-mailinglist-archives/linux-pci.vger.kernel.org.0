Return-Path: <linux-pci+bounces-9890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6818C9297C9
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9648B1C20994
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0201CA9F;
	Sun,  7 Jul 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaOXG0ST"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C141CD18;
	Sun,  7 Jul 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720354793; cv=none; b=EencTWZ1DorVQAq0qQpeg5TeLV1NxQ7VwNnMjgotYpic9q5t/sKq9eN2EoGoT0gWJaV3kEKdU5zpB44lhUVs26Ry3MLmGQZzTetGWnNqsILGrP062wGtD3HkMRXerSojZjJeaBbfscuoNEEY8hA7qOgkQMt/v8VL2/6haX5d3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720354793; c=relaxed/simple;
	bh=TTinsDE4smSpvNcHlbFfLij37NEbey2ls5gXMN5Ij6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsxzcfQ3vJrxO+M8U8D06VnnyqCM2v+EAOLTtZWPy+joArd+xYq1dHuXItSeYinmGh1sw4KxleobuLTJjvfy+AwqoXWHMDVfxYAycS+qYJ+FYZo7/gdSqlYeUnRnLkRAtrcz0KTQiudBG6pgtYPpiQxVDyVHpUClgUSlUUZF8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaOXG0ST; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36798779d75so2590679f8f.3;
        Sun, 07 Jul 2024 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720354791; x=1720959591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z63j0IG6G2cLyHZPR3eZOhNl0P7RDBh+11mDqsiSP0=;
        b=YaOXG0ST+yAHowhlv8m1fS+Soth5V7nEJ6WqP1feo5KQVYLvICLGIqJa9PLz1JYffM
         vvZTPOMLZToup4S7fh9cgOuHUsuSxvApiiPPthCXFcy56MDC8NGoiWx6tY39xUvg1/Sy
         rWk5OWd7/o6sxAgM2RYiPJG1jcwFoTy7qTFUi07fhhRpoi9JB6wiT91lbDc9c5vj7IwD
         5qIln1vCYwkw1PSAoEbE4Ws2SBPEmVUvPRqiGYZRM6tNlQdD/4cBSU8eWT/k/HUXIZ2l
         lv/N9NsiaiTKB4oxRNa8VpN248KUFJZiHl0DaKqXTBAoHlMvPBjQgMcvKXRfpwb8qpfg
         1OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720354791; x=1720959591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0z63j0IG6G2cLyHZPR3eZOhNl0P7RDBh+11mDqsiSP0=;
        b=vYvYyOJp/XD+D4ZQ340n2k+mnkQ5vS8IOZGmNAIQAKJBmk4z0k8KDsUVDIYIwBeKLh
         nc1IPeWpbmX4bD60yADK4DNcMgvNssWbVCgfDEy4or+RenIzUZb9ANfDp99r1QrTpvCW
         e/wBNelGKkAdNiEL8o7L5bdXbGrorEt9z+8T4RMbg1K8VzXZlCYvpky4mCFNLkkeZ6nA
         PNQDHniTZLf9CgQMdWMFxUrwkXP8kaKGGk9E9HjAgpNpH/lVIS+L2q511lRB/A6akttx
         NnZqKHL5H0kWqWyxdYF5U+4O/Th6OW1+QBryx9ltJV5LcTpXSKi9WZWi+pAsTSmN2OIy
         PJrA==
X-Forwarded-Encrypted: i=1; AJvYcCUVIQTz//eOOVeyhTFNIgKo+y/T3ScwxifmsgMImdHDAdnX5ZzR2EZA5+Dtehv/J2Oc8gFm0m3rNuqsmbOaDqBklllvmPd7MbvI6Or+SrnHHYOwVuPZBgS5x0gnXgpq+AB4qpaOjF52
X-Gm-Message-State: AOJu0YwrO1BeGIH0yrOZpcHqHyDfCfNE3U3B44yLaor0wSCiwHFoVYE3
	1i7WFEKjp+UhCvmpuLU9UXTDu7bk5xCWDcp5PVrVFjbdZp2doCg2
X-Google-Smtp-Source: AGHT+IHUZLv8St8zNkkEQ7sFBF4FWyP/9+6rSpupCI9t8UeY97py1DIm2Uqs23QOakOT6qe/RC1hMA==
X-Received: by 2002:a5d:4745:0:b0:367:8de4:84ef with SMTP id ffacd0b85a97d-3679dd31158mr7631345f8f.30.1720354790536;
        Sun, 07 Jul 2024 05:19:50 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:954a:86d6:a384:2fbf? (2a02-8389-41cf-e200-954a-86d6-a384-2fbf.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:954a:86d6:a384:2fbf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd6b4sm25128202f8f.17.2024.07.07.05.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 05:19:50 -0700 (PDT)
Message-ID: <0608fa9e-9ada-43a6-888d-fab6ed06bfb8@gmail.com>
Date: Sun, 7 Jul 2024 14:19:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: kirin: use dev_err_probe() in probe error paths
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
 <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>
 <20240707065358.GA3809216@rocinante>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240707065358.GA3809216@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/07/2024 08:53, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
>> Use dev_err_probe() in all error paths with that construction.
> 
> Thank you for this nice refactoring!  Much appreciated.
> 
> [...]
>> -	if (ret > MAX_PCI_SLOTS) {
>> -		dev_err(dev, "Too many GPIO clock requests!\n");
>> -		return -EINVAL;
>> -	}
>> +	if (ret > MAX_PCI_SLOTS)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Too many GPIO clock requests!\n");
> 
> Something that would be nice to get consistent: adjust all the errors
> capitalisation to make everything consistent, as appropriate, so that it's
> either all lower-case or title case.  A mix of both often looks a bit
> sloppy.
> 
> Do you think this would be something you would be willing to clean up in
> this series too?  Especially since we are touching this code now.
> 
>> -	if (!dev->of_node) {
>> -		dev_err(dev, "NULL node\n");
>> -		return -EINVAL;
>> -	}
>> +	if (!dev->of_node)
>> +		return dev_err_probe(dev, -EINVAL, "NULL node\n");
> 
> Perhaps -ENODEV would be more appropriate here?  Also, the error message is
> not the best, as such, I wonder if we could make it better while we are at
> it, so to speak.
> 
> 	Krzysztof

Sure, I will add that to v2. I have seen that typical error messages in
other drivers for this error are "OF node not found", "Device node not
found" and "This driver needs device tree". Given that "OF data missing"
is used in this driver, I will go for the first one of the list, unless
something different is preferred.

Best regards,
Javier Carrasco


