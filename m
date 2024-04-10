Return-Path: <linux-pci+bounces-6056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD289FEC7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C83286C3B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BC17F38F;
	Wed, 10 Apr 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBtxj2OZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304F17F382;
	Wed, 10 Apr 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770760; cv=none; b=RShdZXjITYFxp3cnHfyhk8YcSwCo6JZpmRY1SI80VnbUIMnZXt3QshnQm0FBaCYu0ZFpOv3gxuPFZddzxXhB4CrLd7a07enRb9mgPbb9FsiARF9bBZ1N1OKeyyf7RFJqjopbP+vjiooudV3x+ypXr9fN4PYU69dENxpCt3FeESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770760; c=relaxed/simple;
	bh=x3I0PG32EWs5ysmSjVFOVVlhXBghY3gSz+KQ0gj+ZWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUso1sX8Z4WJM9Ea/jgH35KdGtl+8vLAE8XtnFqeVSo9o21LkX+iWQgig6CaZML3AaQGcPbQE6A3AiIosaX9EloQayT37BBe6s6HX4uacwGp5b720YaeTJ+kSaSJhT4fHONN9UQu33UtsW3GvKkOFgPm1irAaQ1h+P6EOv1R1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBtxj2OZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e220e40998so45260725ad.1;
        Wed, 10 Apr 2024 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712770758; x=1713375558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NPMv8GLUCXK4Td/EyxaJKNQ0IFP4VwtrngII5FGwcg0=;
        b=JBtxj2OZEYhutDGbxW3wyDd3xOeE7tmfa+RtGHv+bO1kypYktFd+jQZ6g4rL//IadH
         UonqFntGx14opkH1sO8PbuEMqKHMJld4aJzAoxpri5QE25d9sTNEvk4b4RBdMUWO+zzh
         6JMAJjZW1g4Qyphc96+R+xMKe9rSryUutW9FF+TnDcmuzfG4ev6nH1U6YTaNWMcLB56w
         +dciMOEv8y/ZH4XjArLHsIEl+CHBcrp1NZmNXOtOtMsP3qZGC46ndqt2ytgkdK81v44+
         HazpDS0dtnC9HKa8MLAyqmpnsH4vWMbVQJyG5otAnk/gE2Tu4zpsZJk8JtUfXH58A1pQ
         dqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770758; x=1713375558;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPMv8GLUCXK4Td/EyxaJKNQ0IFP4VwtrngII5FGwcg0=;
        b=XjzCOklpwz1/0OVHRopRxPOIk9GzuGmon5L41duRPHwypC7jLslw523AP1ir5kotXS
         N6g2OUmqO2cXqVVfTOEZJQm5wF1BQhBY0jrvl5hQmRw61cEnSEbYSugfzbm3tdy/Dqdv
         1El5t/9M0Aa/wJ1x3RYkIVEp96cHiu2c8Cchf5q0yieVDDViNKWgbT+I6TV97QYyJugI
         ls56PQlKzWS622V7kIJ+vQsVBRX3VeoKCjsmf9j/SZipIyImkdDGOVOgRW0OeNTqkcbf
         ElAwhw2LouvVwRDBycrnwPbHV40wo5pIWduR/nX5Ba5bi5HoqcQ3WYImlQVIQ6MwTDy4
         h8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVcY7eHrttdJwvfvM/pk0ObtVNJXEXe7eKfJdRZ8Z9LDYazNGaHJtcaNpl5CVY0KmfF8C1/78ClLT9ov0MB3O25gEpLSlKcPgH2oUFWJLpTXJW3VSMIsomC1tL9g8BdcqUb
X-Gm-Message-State: AOJu0YydwsNBqYf2y8rCP4WCnk7c+Q1EqsUXbdri71XaKKGoh8w4MBrB
	zoaA0MvH0pRPeyXWKEU/sWdKMKLQDURq6pWwpoVGXTCDuPdSFM9K
X-Google-Smtp-Source: AGHT+IFHePBDKHw8qcrHph3ZJPJmhCb3KEuoOq8a7Htm2fMKb70YSE7hWTxSg+S39Xu6HC23qFWcEw==
X-Received: by 2002:a17:902:8503:b0:1e3:dad5:331a with SMTP id bj3-20020a170902850300b001e3dad5331amr3383350plb.59.1712770757941;
        Wed, 10 Apr 2024 10:39:17 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001e434923462sm5899581plb.50.2024.04.10.10.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:39:16 -0700 (PDT)
Message-ID: <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
Date: Wed, 10 Apr 2024 10:39:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>,
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
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240410103531.46437def@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/2024 10:35 AM, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 17:12:18 +0200 Jiri Pirko wrote:
>>>> For these kind of unused drivers, I think it would be legit to
>>>> disallow any internal/external api changes. Just do that for some
>>>> normal driver, then benefit from the changes in the unused driver.
>>>
>>> Unused is a bit strong, and we didn't put netdevsim in a special
>>> directory. Let's see if more such drivers appear and if there
>>> are practical uses for the separation for scripts etc?
>>
>> The practical use I see that the reviewer would spot right away is
>> someone pushes a feature implemented in this unused driver only.
>> Say it would be a clear mark for a driver of lower category.
>> For the person doing API change it would be an indication that he
>> does not have that cautious to not to break anything in this driver.
>> The driver maintainer should be the one to deal with potential issues.
> 
> Hm, we currently group by vendor but the fact it's a private device
> is probably more important indeed. For example if Google submits
> a driver for a private device it may be confusing what's public
> cloud (which I think/hope GVE is) and what's fully private.
> 
> So we could categorize by the characteristic rather than vendor:
> 
> drivers/net/ethernet/${term}/fbnic/
> 
> I'm afraid it may be hard for us to agree on an accurate term, tho.
> "Unused" sounds.. odd, we don't keep unused code, "private"
> sounds like we granted someone special right not took some away,
> maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK.

Do we really need that categorization at the directory/filesystem level? 
cannot we just document it clearly in the Kconfig help text and under 
Documentation/networking/?
-- 
Florian

