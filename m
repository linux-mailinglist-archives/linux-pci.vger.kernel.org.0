Return-Path: <linux-pci+bounces-34136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4F6B2912C
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF8E16D31C
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731C249F9;
	Sun, 17 Aug 2025 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOYP4rV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9113C0C;
	Sun, 17 Aug 2025 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755398774; cv=none; b=bdxJFaz+gHidM1gnZPFXDuv6mXFkfsNtMWOBHAVkjTc86sbasHsNE15KRzK1bYUvyAxr6Qj3xhZ97CrqKLihtQl2LmA5tAo8Q0WNdP8G6IoAf+FcFub9wjt6CT8zmCTy4+iFaf+7a46esHLG+jw7UAtLq25SQlJWXZgIbkVvI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755398774; c=relaxed/simple;
	bh=PThytG6PMf0HxRu2JoQkF35MgVDyyHyOVZU+o5cCL2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRt4cJWq1rJK0bYg3EKTHO/XQgrfIKpzdQHTRX9SNc9UUyrYo1ay7tWMQR+U2LmBu7gXj2KG5MvHkGEBUROD3EvgbYb8XRqFG9fIMLyGcNW8FBszJEldG2knoVbsPY1JGtsFivtTsD9k+gEyVtHp8YT1yXsiNRxQTv22SjlVbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOYP4rV/; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso4407632a12.2;
        Sat, 16 Aug 2025 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755398771; x=1756003571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gezwu8vdaP0tcVdxztG2M2ZkIYiPiwl0RgBAY2ELK6k=;
        b=jOYP4rV/J0D8ouN5MGR/Y+RLiU+oBcfY4ioKRIn426h4z58MCtNK5Qmya9AO6lrfBZ
         bP75opren5FzkLHXXjTjZhFEX25Ws9+jrJvz8pxfGS1b3nCBLKAndnrIJdOfrkDYqRct
         9BW3EMKqGvvXuG5DiAmcpjyGAl+8cWRVZIUA1i/pevXR3+7jb9vgbDNIy0ueE3eFPpSJ
         1Rg61uOZZzzppjRVaeqPCqCMWAoVl2jMDzDrWXdV51ZlDAXX0W87ohkvvsrqUlS/tIHu
         LycKJkgFsjYGetli1AH8yXLmTOhfkI01BPgMW6t4lzkinywnQW3Co9n3knq+rfFVsZPp
         eNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755398771; x=1756003571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gezwu8vdaP0tcVdxztG2M2ZkIYiPiwl0RgBAY2ELK6k=;
        b=vFPpHQPhhIb0IL+KPWfDk6/lUlflFYVgxDVuYt1aMSryw59N2MAG1P73YLTdYwuk69
         QNi52Dr0jQjGw9V3Zc2+vfk7bd69/34kH6P/kf1DGZGvR2qqP5pNtgaJaCq/OrXzVy21
         bSJUx+M0PkqQTq3SyRbm+L8aYLVRgBq/pqU92HW5FzjCxX7qrWGVqLulDK3cDEZe8s4W
         aycChFFINGEvzxloiRy2Gc58swpyhrpi1WP27fnLsmusP1ETqrN/yzVjTm8fEvbnniyS
         Cg6sGXjG1zns5yjH3lPwenLrRb1Vetq6WpFmuhjHyTqgfTACRJCebdC038OWnd/zMFH4
         YJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyu0oz+9Wc3VS5a/89iMCHuiEusyc7EtK878EKs0rU7C1HTdX/QuZ1hDeA0oOz+UoJhDRYBKfJVADPxMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5F5hrfQ4Z15LnS7wDZX9zVLdijRC+cS3eEYLTGIgvk1/v2NhB
	ZXCPl1lPVkDkefbKYPqFuIjaHhFXHLv22fYPnI7XBtWgk8Z6A/x3Htua
X-Gm-Gg: ASbGnctoug/vflWK8y3mGvuKtd9gT3ObfFLwNjFXJekzloEHu73GR/L1Rk4+btWDC/N
	uy77I51Vc959veZf3MKC5Qmwf19Sbl2353NhWXFwwXQOQIa10D+UmfmR95beWsPAzLN0McV6UAw
	5DlSz9adaSioN15x8rmlfL7tAI49OWbFxE17T5u8NDMEtgNETtBFYoZGlwxiC8zScs+TQwyWSLH
	kln+Wie3EuqHw0QkbL+NyX+SvfEAbj1GoDWro09x2++XY0amWm3mitiWv3IL7+193BxbqPYY411
	EHfmeUivnEiAeBR6r82dcdQRTkaPpM+NgwrNAA/1etd8ur7XKSJTEvgCikIKCPY4J3HRTS+UiOK
	zelpDLjttMtulCfFIzVFl/FYxkv72eMLsU7W7A98pgKahxb2Jyc66/2fquDTkxD5RcY8NQtnbpa
	I78PLOsDaG9CYMeVXe+QOWH8K4UYWrH53vKrhqAwg=
X-Google-Smtp-Source: AGHT+IFxixfhpAPab7BmK2NcVETFGBTZimxoHCnHm0G13zJ6CzHH+13zxMx+rEAdnCIXpeiM23z2ew==
X-Received: by 2002:a05:6402:2708:b0:618:adff:66e5 with SMTP id 4fb4d7f45d1cf-618b054dbd5mr5654974a12.17.1755398770612;
        Sat, 16 Aug 2025 19:46:10 -0700 (PDT)
Received: from [26.26.26.1] (ec2-63-179-65-141.eu-central-1.compute.amazonaws.com. [63.179.65.141])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae6bcsm4318331a12.37.2025.08.16.19.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 19:46:09 -0700 (PDT)
Message-ID: <64025ba8-948a-4d91-8fc6-a1ede807ca8d@gmail.com>
Date: Sun, 17 Aug 2025 10:46:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
To: Rui He <rui.he@windriver.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prashant.Chikhalkar@windriver.com, Jiguang.Xiao@windriver.com
References: <20250814093937.2372441-1-rui.he@windriver.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250814093937.2372441-1-rui.he@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/2025 5:39 PM, Rui He wrote:
> For preconfigured PCI bridge, child bus created on the first scan.
> While for some reasons(e.g register mutation), the secondary, and subordiante
> register reset to 0 on the second scan, which caused to create
> PCI bus twice for the same PCI device.
> 
> Following is the related log:
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0d]
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0e-10]
> [Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: PCI bridge to [bus 0f-10]
Could you help to attach a 'lspci -t' about the topology ?
bridge 0000:0b:01.0 and 0000:0b:05.0 have the same subordinate
bus number, that is weird seems they aren't connected as upstream
and downstream, but siblings.

Does the device behind the bridge 0000:0b:05.0 work after the
second scan (TLP are forwarded) ?>
> Here PCI device 000:0b:01.0 assigend to bus 0d and 0e.
> 
> This patch checks if child PCI bus has been created on the second scan
> of bridge. If yes, return directly instead of create a new one.
> 
> Signed-off-by: Rui He <rui.he@windriver.com>
> ---
>   drivers/pci/probe.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca76..ec67adbf31738 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1444,6 +1444,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   			goto out;
>   		}
>   
The bridge should was marked as broken=1 already, bailed out earlier, 
wouldn't get here with bridge forwarding was disabled. no further 
configuration anymore. what is your kernel number ?


Thanks,
Ethan> +		if(pci_has_subordinate(dev))
> +			goto out;
> +
>   		/* Clear errors */
>   		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>   


