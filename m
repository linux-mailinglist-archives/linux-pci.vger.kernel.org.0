Return-Path: <linux-pci+bounces-21917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CDA3E26B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBF97A1D06
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3407E20CCE6;
	Thu, 20 Feb 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iOhC1x4C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7620485B
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072515; cv=none; b=TCHmDlaJKFQh+HzT5INm9qWB7fxRymyQJ1hVEohG0zsBl+ix8fZmJviQ1qTk7PjlE4DNSxB/DH9M7MEckcuLcZ9l+zYs8BAFkGhXcqeVrVKbOoKRzr7dOgh7XasPbP0UtPbN9Br0iFX8Q5gevIOVrnxRgQTvcqYMGaQJpXCgO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072515; c=relaxed/simple;
	bh=pSF+3Q0yOxZTxTMkcKGl8KlJQbXl8XaWL05HvaA1CXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZVaMkU84fYaWnSIwZy9IWLXdAJAOKVhSdkN/1m+8604peMpRrA5TNtfcqFnJRZkTJGtPC2Evvhg/P2+RpgspecmQRiCNkSWEpwCg7xe5KMh4iCjgzwKbOpgL0EdiPe7a1BVlQTS625p7o0EUv/2VUlZGsg760eJMbL9/tTmIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iOhC1x4C; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a01bcd0143so876710fac.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072513; x=1740677313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Se84fI0QvJHv7tBsVCkvI8sK3nuKMRhf8fQQM5TGP/Y=;
        b=iOhC1x4CfzXCUJEhNW1DQcc6T68RTB8q/wxtYltjitg5vxOF4t3ZUGPCxgY2YTpHl4
         LgZWlqFOL/u8ASxZHEw2gu/wD9n89x7qhf9P/NMZLl9p/I0fuhTa7dDOgU7P4t53BU0t
         umDTuIVNNLweFOFxUailzg5oHmyy86zr+nc5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072513; x=1740677313;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se84fI0QvJHv7tBsVCkvI8sK3nuKMRhf8fQQM5TGP/Y=;
        b=NV/7MjmgSH4khN7RxyeSFZxxJYC/FVR1sNojs1G/BEbCZflYHMfja6e5VrwdEHm2ax
         iBqXkiH8VWFrza43aoS6e4yQU/TzA3zn41NdkAgMYoH8bSS3wA/XVd6Enz9Fbq2I1Peh
         v+ZNynTvKBsbvfUdJxQAOOShUaTgzi3joQcihMkkKBQhSdtUKSWxgDv0lpmkSAsaiq7+
         6M91FiusJJTQpYqT+j/YO33pqr1zTMQDZyJ0+mHtnYTxIx7UBbXng1AM9hSnBlfaEft4
         vHekhfEiiaM6Rn1DNcOJCLQZHb+zE/jk6Jt95kJud1DegAzfWgTYmaRmRzvjPzG7vmT3
         ruXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzJbv/Z8Bym8n2dB21Hm9Ajk/dIWqGwB60N950oGBEqN1tgN+PLLtigbtJnIYe4PB2EO+jU4NETS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcHlUDLqifEJzFH+t7BU3FLuw0A5g5EFBEcHmsjD8C9YkZNlA
	ybAuMK3CQEDPiGBVr2J2+tMmOd+7ZnHj77hCBuAeW4t4F9qhPssQk2c7OhVl0Q==
X-Gm-Gg: ASbGncteDJZlUgWYf5PKpnXWWHQwTD7dTDpys/nTqBmpSEfkNRDwFhgX0XmZ3N30F4A
	iy7pFqozNdaF96P7YkyT932nfMRKpWaPon6VAKqJZuqdIehDpGfb4ckZ/ZrmBT+x4Q0mwUHa7Lq
	R2ZGgcT0zhCYoGWFZFPWLze1Ewbzq6iaHzM5c5q4YPVR2PYATpR6gRh15qvT9Jf/HnDJL+v3haD
	HTnlYDMRB7qxI1iwWSOVPvRjEsD73Zll0OGlTpPRrFYX1BPwgxlSZIpJWOFi0/6NP27A39sbK2R
	exisCBSKr3iUExK9JuOjb8GE/2zU1PfehvlHX5mvpCUC77cv2O5T3YVCNkIpezGUZXUHWxgedWo
	HcIpD
X-Google-Smtp-Source: AGHT+IHx2vbvGJAHIaFv9cg0KxSVcmogH7AF0Pu9XJIHUk15LcaEcO3igriQn9XHQKeAmlP5LjbZFg==
X-Received: by 2002:a05:6870:5688:b0:2bc:7c3d:1918 with SMTP id 586e51a60fabf-2bd1029003emr6698012fac.21.1740072512624;
        Thu, 20 Feb 2025 09:28:32 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95486cf40sm6433631fac.16.2025.02.20.09.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:28:32 -0800 (PST)
Message-ID: <110d6471-d7a5-43bb-b768-dcbfb0f029eb@broadcom.com>
Date: Thu, 20 Feb 2025 09:28:29 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI: brcmstb: Write to internal register to change
 link cap
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> The driver was mistakenly writing to a RO config-space register
> (PCI_EXP_LNKCAP).  Although harmless in this case, the proper destination
> is an internal RW register that is reflected by PCI_EXP_LNKCAP.
> 
> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

Likewise this needs to be shortened to 12 digits, with that fixed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


