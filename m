Return-Path: <linux-pci+bounces-13004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D9973E01
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294521C23874
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52E199FA4;
	Tue, 10 Sep 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IbWMxR4A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBDE193071
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987811; cv=none; b=K3g7kEZg6v449YPVfRkXwp6T84RY6efSDUAnfb9q4vCraaUe00JGlD15WWD7Xg3Krh/dUOtx5JHlxb+FTAe32Qj1B+Zo4kRacblxzylrt9CNzLcdydCDZ+eBDcwnmdI0ppMRkgSMLwqyBahZrtSZwCtFb3MuibNiz3GBxtcLtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987811; c=relaxed/simple;
	bh=zAJ/5M7w5yX9e+ArLHHbp1g+c2QO2wFeKfp5Y/ivU80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goIhqw5GOE2q9CzqeQUsx5eySGF3Sdmznv93dtZz1zDBOzWzmWwqXQqMA990KQYlT+2bOlJ7sE1AlPd4k/tXxNTlwdg+zxKo6VNUIqU1B+CdiUYRZGigWMDPWZmc6d9jrVIPkLwbprJJVZLc7Yc4YIjV1K+Do2PnI4CwH0yt0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IbWMxR4A; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c54b1f52f7so7483226d6.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725987809; x=1726592609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gheUMWeH9Qzz6WwLA+wiORmVemB9F4fEPXa58k7pmII=;
        b=IbWMxR4AITieUal0fcJh9rxfVvwlHL9Psq2tkzeG8rn7daiqYWWcyKCZl9uS+Y4j4s
         UiMZfzhMQqjirb/cJd9ICZkIW4GVh5UkMsdfPsILyS6ac5sEOklGr9REfz9riXxtWrF7
         wTENmWjhdeQrQ35xeRf8Wm5EGTfRkne1iNsl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987809; x=1726592609;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gheUMWeH9Qzz6WwLA+wiORmVemB9F4fEPXa58k7pmII=;
        b=Zx3MDGtrPEtqPGvlmbZQj7zV+Et095oOF8aQx2sUrm9dOxrLMruRYbDH4za50Kw4PU
         DWYIYOO95zsoEzFlsW9OWgq8/uovHkCwpvECLNZCQgEik4O5RC/vEBfsIKkTX4ipzcoT
         gPmjMASFSLKN2CMzc2t63kmVsnXG9bz3a56yIxAiuKdD+hEHVm7RwyqG3PBcCMLwAvOB
         W351VDwUxu/I+t2gnFVV/v4jc37u9y1yR5ugCv7eTnrDoMre9RWSz6nw+50tauN99sGW
         3P3mfrCXF057ckfq3dWk18UFN5e6ZHuMQtZnUjGnT1s10Kr2WmU2LgbS4+5hMWtgnhuP
         thiw==
X-Forwarded-Encrypted: i=1; AJvYcCVH/f83SQdKZLZILmDmSj63mmc958mogtDY8xvpaELEwR/6ugdjsR0h3HUY++ayXVRWfjGb84ocCX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7N7uKhBB/4LoXQsOKQj1Av3KrSnNITy2qnTc8LiCh5wIKcHO
	IpOEHI7e3YohVB3WZXt6dWEqdZ62JMpN9FQsr4mfXl4yZCPBvFgor6Ey+YfP8A==
X-Google-Smtp-Source: AGHT+IHUk8CEiKJjAZAGXbqbnYC6HyCT8S7FvU6wbEDuSLkYf0CV56ihXkcB8SyqW5lEA9kGmcPKwA==
X-Received: by 2002:a05:6214:3281:b0:6c3:5946:ea0b with SMTP id 6a1803df08f44-6c55f9eae55mr1123566d6.11.1725987808381;
        Tue, 10 Sep 2024 10:03:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534348d6bsm31813256d6.73.2024.09.10.10.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:03:27 -0700 (PDT)
Message-ID: <ee33d93b-5721-4de3-a192-f50f01adb2b1@broadcom.com>
Date: Tue, 10 Sep 2024 10:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 08/11] PCI: brcmstb: Add bcm2712 support
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-9-svarbanov@suse.de>
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
In-Reply-To: <20240910151845.17308-9-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 08:18, Stanimir Varbanov wrote:
> Add bare minimum amount of changes in order to support
> PCIe RC hardware IP found in RPi5.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

