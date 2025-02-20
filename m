Return-Path: <linux-pci+bounces-21920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F9BA3E286
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23708162B05
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F8213248;
	Thu, 20 Feb 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MzPKDhfF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9732116E1
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072621; cv=none; b=Umazm26EHS9FS1BF3NEcfOoJBYOj/Cd/ct1lFVoRBGdPzfplArF5Xh/vXYtYp/bAoFoajQ154BKiGU5J0y9PyayiSXsAAsWd3hfWbgWKCVWPI5klabHnG4dqCnk3bIltmZ0TEGLQd/lQBMvWpSHgwG538KculoySonpDMo0r2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072621; c=relaxed/simple;
	bh=Cr+YfiHUjEM91VeNCc/IQ4E67yLsjVF91rajsF1SabQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTwFIW+4dMLZb63vcasSPR+x5JX8Nk66wnQUeKxStzkhaIzf7TzVksjb13jlaoWQ1f/4UBSuXM+XYAWnSEtphBQOn6VM+M+23SX1LBgJmtVAuz971Oy2V2r734ZqzFnO/UcUCIQllV1VEYPd30D1vkpGBlMyviki0MmHhv3UHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MzPKDhfF; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2a8690dcb35so311584fac.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072618; x=1740677418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P53/KIPJfrzEGuva0GsD1NlBE3MhvRVPB9M6JxDtYlQ=;
        b=MzPKDhfFhy2MqC6DjfEKwhS5OCuYxxB+zdQ9b6nbbrhezog1bckDantj/hZJJD9Ze2
         23/1A3U/1sweFPR08FeXw1U7QJAcCI0l2v39uJWkXqlzyN4ySN/w8uLyMN4SmXm1VCgx
         7I0qjt3Nx2ssoTprWrE6NZJ9WIJqHiOol3II0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072618; x=1740677418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P53/KIPJfrzEGuva0GsD1NlBE3MhvRVPB9M6JxDtYlQ=;
        b=W/9BjovgV+CQ35gxGMCZWFi162ucQffIpi1o7CCsFQgjNxBYA7ZwbB36058GdAN6f5
         z83OtSIccdDvKUkk+yC2VgiCJ+U64XY39OkGj9IYizCfqvf23vKF+HV8zsWbRa3AiJwm
         sPIjjGb6W3gCLJm01UOyzJLgPxyRPji3+h7TJyH3+8Up9a84sOJP8xpqy0mN5nWl/k4n
         cqqyKBKVrhaXXEqa4L84m487lcJfVxYCmq0Wlbw1pYGT57c59Daoj5ExD02b1HfJ+YmP
         t8kDzks10yMSCYRd6rOkcXMQ0gnZUfD3U9kvKhGnYvNLH+6A/ACPA+NNTIKCwvOkQmAD
         r0ng==
X-Forwarded-Encrypted: i=1; AJvYcCW8duFB7fbyCiYgk6hwgYizQXAOlZtBAv8WQAQkN4sZSlswJxitR2mn3czkVJBD/ptASZN+udUq388=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3pzquxja2MtZFPsoc5N4EhPqt0uBAHQI5sw8r3vWEpeJ7pHdA
	HeeiV65ma/THF/PsVPdXRSuB/BEcLV1DmC29aJ2KNMvLWxRWRGF8E7vSYVxlpA==
X-Gm-Gg: ASbGncsd7g8keMNkrKP7CshIs3HIenfoKWN0/AbVQTnxtgXEYZ3+ja6YM+1sNxAfjQp
	G+MwJQSGzVDGGBXwlsCDmOYahC5o9pAho1QnlbmeF18BeTbYgoqtCPxC/Rt4gqzfCkO+/E6ewyQ
	nzuG/6aMgccbF1/1k5gZ8379xwcEhWqHJ6BS/+ElWqQKj/dd2OVukOQzRyF21rPrCBx44zJHNIE
	SLuLJtei4R3dTmSidqYc2EZoC3UtPYF9miBIgeCIpBozTqnOtd4hEafXUDH2UasOsVH4LB568F+
	ej5tnp/s/rBWJCwOIZpAXoz5XHNtgk+DgEI2uHI1PfFoVW0tlIpLLek/2vREOGFcD8htoijFXSZ
	I2EH1
X-Google-Smtp-Source: AGHT+IHw53AD66TKeGeMiB8+rYPW86zzfv0+S/8Z29ElnOO82punMyMQt7RDXRZ5XmCphUXfk9aEGw==
X-Received: by 2002:a05:6870:8a2b:b0:29e:3c14:2bb0 with SMTP id 586e51a60fabf-2bc99d41a60mr18203220fac.30.1740072618592;
        Thu, 20 Feb 2025 09:30:18 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95481ab73sm6402536fac.8.2025.02.20.09.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:30:17 -0800 (PST)
Message-ID: <213fd5f9-405d-403c-8ebb-a2b371f0ab22@broadcom.com>
Date: Thu, 20 Feb 2025 09:30:15 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] PCI: brcmstb: Fix potential premature regulator
 disabling
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-6-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> Our system for enabling and disabling regulators is designed to work only
> on the port driver below the root complex.  The conditions to discriminate
> for this case should be the same when we are adding or removing the bus.
> Without this change the regulators may be disabled prematurely when a bus
> further down the tree is removed.
> 
> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


