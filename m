Return-Path: <linux-pci+bounces-23985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2912EA65D3B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 19:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053487AAD12
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9211E1E02;
	Mon, 17 Mar 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W5dmuvfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030CF176ADB
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237438; cv=none; b=fd65Z41wv2nsdw2u5r4tjL8nYG/w2eeIXjww0wRqtYOj4XUbR77EeKKxYo1qUXubxFF64XUBGybqxUQh4vih+k6+uQe8DvY/i2MqPgHPsO3jFjUb0mWToAKnzd2kGEJj69ZOTYJWLRbbFJGoAMu+2BkPKIcRhD3dTF4MIDWDUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237438; c=relaxed/simple;
	bh=iWJ4xAGHyAnE6QbuCInfzYRvbLTef5OOVfOJYBo5i+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFaXTLIPiXmUJi2mhSim1eWJfqm4Kp9YWGJjzLfmOnXU72DsoGCJ82lPQvUI1GlFY84YRhEksTg2BQaKzsiRRJoBNsh8rn7KhnX/gHgXMkBEadrGQrV7bIDb8Iitas3Snd9W3GE71nI2Sj6/iUl3XH9rTf+Lgmxm1qSNSkNPXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W5dmuvfI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fe83c8cbdbso621875b6e.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742237435; x=1742842235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9YporYfSyQzR9fHjG0FSGyAoboGZe4a/zGZZOFS0qU=;
        b=W5dmuvfI/IIBtciftBFwehHACOIXudYVpuUFeVXSX7iu1VsU65VuvKOn60qdWydB3N
         BLFusKmTI+kGWN6jHuGTneG509Y7vm0UH76paHNfgPYkp65KP9fP2GEcFQda3qvlDwrz
         gAr2q8CUKbEDj0gzoogstJKyX0Udgn9jtlXGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237435; x=1742842235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9YporYfSyQzR9fHjG0FSGyAoboGZe4a/zGZZOFS0qU=;
        b=vnUBD7t2RTJNEumlkbVPV3QISaf87DSlftyQA3/ys9sc6SgBsTZVD6Es92mzY5/gPj
         shKIQzU8XOda52mpawJQMToBB1XKD2eRC88l6RdCKzQIH+vfDyYCRyA+KMNN/HHWSsxL
         Hj78cBHDOiS0TRDmoMlz1bQtY7FUDP/o6u1wxoY5Mgilhd/WxQxsypGKphd81H4zIliP
         qge9kuNPL0FH3Gki+8CSNOackYGG2GvY56vDONQN+9KSb+u4YNsszNzoR3cWKxvHHWn7
         1Ks1BHBxhn79qWb74znM0+I3RNW34gXE4D9HdNjFdkNWTnKXcS/K8qyzL8OFsh6etdkh
         g0kA==
X-Forwarded-Encrypted: i=1; AJvYcCVNh5N/w1acmuHGw524CAax1a9D8rLcRcDYt6fBFPHo6nSBqAP3ZUeUDH5cXGYKceCQpfL4mzfXoBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ57QhoajXLANPdS6H1XoepWLq/Em5EPZKAM0ST7zULjruyWVJ
	pyRREhwzZ2bvcjEFLDvmCeVkrJiNe6qoHm6ThAQr4WjuoRlCsK8LMBR4bE0urg==
X-Gm-Gg: ASbGncsYuoNasdTRUTBHCG72Y9KLzKp8b87MnTKZZs+3AZXDccmqdgNx9ojhbmbFFOU
	UDbzCRh+cnblR8OBwu1q6cFNSsEBl4rpIxRJ01j1VxcdDBzCLHR7Ua+U0617mTRjnyYNYBxlGW1
	ScnsTCvgNJiTNQONVEgjx9m8LTjzEur1bhN8qPDZiK4L/xMy/r1DtSzGtQGQq/+eD25AnnBL5RP
	oexFZxufIRfM5F1cLjqAD0gj5xmiGQkKo8u98MQl32OlB5GHthFmWhe442v8IHINM67i60BD2mr
	dZ7dUdDnBMvtEUtXWI2KY7EsW9QxYlUzb+q/6Yl3srj4PY2YL7dajFHIYKm2JQV5qA3BUDJk6aM
	KcWNiQBT7
X-Google-Smtp-Source: AGHT+IGxL8qq8K6CPc1NqDH20ecuw/Yp8JNEr5ICv2xc9Jo0XclrfeIZlq6cbKg4apj7kSkvgGBfPw==
X-Received: by 2002:a05:6808:2289:b0:3fc:11a6:7433 with SMTP id 5614622812f47-3fdf0646c85mr6999830b6e.36.1742237434979;
        Mon, 17 Mar 2025 11:50:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd452130fsm1887803b6e.14.2025.03.17.11.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 11:50:33 -0700 (PDT)
Message-ID: <60ee6fd4-1cc6-4d77-8359-9215e1d604c3@broadcom.com>
Date: Mon, 17 Mar 2025 11:50:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] PCI: brcmstb: make const read-only arrays static
To: Colin Ian King <colin.i.king@gmail.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250317143456.477901-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250317143456.477901-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 07:34, Colin Ian King wrote:
> Don't populate the const read-only arrays data and regs on the stack at
> run time, instead make them static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


