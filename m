Return-Path: <linux-pci+bounces-27491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43BAB0A4C
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 08:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEF91BC407E
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32005269D16;
	Fri,  9 May 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsLS+Tml"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B75266599;
	Fri,  9 May 2025 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771069; cv=none; b=cFRjYRWJyxx2ZmiLWDG6Ws4AXwC9sdQfrKqDdp/WPsDaHfOjPF7ngGzp1/9opF6swINnUYfpyXYi/38/wZsjakh+G8L18bSoaIJYdVsCO++JU40kO+5l3O9f27+yzFyU++LezZ68/Ckwm5EikT4VmOhp0o4/UGgI0zLg8xCVthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771069; c=relaxed/simple;
	bh=9jqZE21+WSs8HvXVZ2Nk/t/5qvfZGOiRoifSYIH6bYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiI8KEpQiXTWbXdAW1QN8mKa9RZKKNsVPF12Bz1APbHukByIu31f6KPWQl3NcdliOjzS0XKOwhWSJHIBaJhH+lBDWsCqn+TWTaRS6uy093sb2+wEnpqgB1Vb1g+7fdCB/LA52gHwZoO9qKsqqi55SdK/AL5XDWh6G+NEkyc6Eeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsLS+Tml; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so4391108a12.1;
        Thu, 08 May 2025 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746771065; x=1747375865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT4nmiF3B+9Zf02ngFo5qPxLiB0Cnk6TGo7gdbEV7tc=;
        b=gsLS+Tml+tSuCMvLdmXt0QcYU9GuCMEmHjxHsBSvwRjhOAUwxAejbdvk0LvnXtw8RC
         PWv/M1YgAcUR8yl29y5WXTaXltx/T0DIjfIXErU5gjpsJ8aF5rB+obuLAAodTmaVQaRK
         V9kyc+jr4ap8rCkEDxMnugW+TXWtbf7ZKnbUW73ixNB9MDwf0doBkghhaKMjxBDkbGK+
         9gA+qj4/DWf0aR90rmPUUnvEsw84sysG7IsyvUKx44WWPfrSegUCmnzxSoF+mH6kv8Ek
         Ju+Kbr70AF0iW1oJZBR+ABFrA8uSYTapHc5ZmQJa8f17PQlT52YzjoMZFrtOybASKFeS
         x1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771065; x=1747375865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT4nmiF3B+9Zf02ngFo5qPxLiB0Cnk6TGo7gdbEV7tc=;
        b=swc64QgzvWYglM3EcabZt2gwCuHdptThIreMH63izVATzNVR939i54sJ1NYIgo2Jxn
         Nf4Slg5j+hKaDegURl3GlCdpKQazz5T1bZJdIACdaUcmB43j4muT9SXCLPGZLpDvB7qJ
         QcrTL0+H7o2onFSn4nSRjzh66DSqZ7gEg0CHPtSThc5RnRZptNP/ZL8vQQkVBIOSOheF
         mfdAGSr0gwxheWgAWUMkE1ghXmdFowOfulOjHo1n7zCJK01Z87FRqSCQpr5v79H/i+6+
         9UvU2T5apJQ10YsHy9lG87renU0Dn8OoMev7uUBpHD7pmYY8lKdm/YOtQWz0t5iHBqMl
         eY+w==
X-Forwarded-Encrypted: i=1; AJvYcCUagtM27LaJOwJHh+ho9xptMSVmU7V3z0KcV4WkcUSzfBJHl6XmQbFt+1OTq4m8tEE62hbyP8mVH/cBYhFU@vger.kernel.org, AJvYcCVB0rdGr32B1bv3HDzc1yqVo24RdHLHtei+sTst1W1eYdAmrw+cj8tHxL8JlnVQQEBrwX2dG4D98dUd@vger.kernel.org, AJvYcCVLG5rPAeR4aiW/jhVrDikqxCT7WvD+WoIjpRKWgIt62KkEMI19Nf/zwJRhuLN79Qo0IdZnWrOJPBT8KpPp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwt5nwlhhGJNeNHTv8HA3f09BvCKLU1kMvHq8F3Y7i5exmR+B7
	Is27MYYUoxsX2IojC3RFCaLocDUob7lAyotm9900U8YPBP0hcZwd
X-Gm-Gg: ASbGncsUQCxePfU+mqhGBxApW5SCJdE8rTPyojlhp1YfJJa+XgF4HhAJNkxwM794678
	PhK0jz3+mK5N2D5PBLHdKuq3MIgJ1TYDPm5Sov479dLQgch0MEcB+saLbrEBBXGPcBbnrMdxGdr
	RaiH4OiUEtiSKkJxebpkL2Ng6717iH0PfLkieqtI+AYXBIzTXdtyoOasPiqn1JcaYksgkMJLVu0
	zoKNqCKEaFggnDRJ0zWD2OHsZme4KGid44ARbIYRVmMuLM/+SNvHbhs6yIQ6SJ6a026IVoHXfwl
	wdmqQ8cwv3gz7xGP7864az3SAuBm+cg5um4bPR8qX6JRAu8Sib3xzS0zIMzyyjgT4hMa+uHauRt
	Cryc28WRLmqD1hW/xe/YBEFuoK65cd9kb17aNUwbz2B4GMIeH/I4=
X-Google-Smtp-Source: AGHT+IHV7Lb+Jz2vAFwguRkPg3xEv8RK1gYxrdSEajyR1uZCyO5I90pymBqse+1L9ASZRUyJgq24dg==
X-Received: by 2002:a17:906:6a22:b0:ad2:cce:8d5e with SMTP id a640c23a62f3a-ad21b16d4d8mr201457766b.7.1746771065029;
        Thu, 08 May 2025 23:11:05 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-69-236-239.eu-central-1.compute.amazonaws.com. [3.69.236.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219343c81sm101663266b.58.2025.05.08.23.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 23:11:04 -0700 (PDT)
Message-ID: <ec5bd8d1-c865-40ac-b03d-9e07875d931c@gmail.com>
Date: Fri, 9 May 2025 14:11:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] PCI/ERR: Remove misleading TODO regarding kernel
 panic
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
 <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/2025 3:10 PM, Manivannan Sadhasivam wrote:
> A PCI device is just another peripheral in a system. So failure to
> recover it, must not result in a kernel panic. So remove the TODO which
> is quite misleading.
> 
Could you explain what the result would be if A PCI device failed to
recovery from FATAL/NON_FATAL aer error or DPC event ? what else
better choice we have as next step ? or just saying "failed" then
go ahead ?

Thanks,
Ethan
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/pcie/err.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffcc94e15ba6e89f649c6f84bfdf0d5..de6381c690f5c21f00021cdc7bde8d93a5c7db52 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -271,7 +271,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>   
> -	/* TODO: Should kernel panic here? */
>   	pci_info(bridge, "device recovery failed\n");
>   
>   	return status;
> 


