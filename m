Return-Path: <linux-pci+bounces-12419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE2964060
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A428A1F22FC7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D403E18E77F;
	Thu, 29 Aug 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLA3aMAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BF18E74E;
	Thu, 29 Aug 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924345; cv=none; b=sq0S/WK8N8KGK91W/7pxZmVS+xH3hY+EJAhL63tJ7CIVynFRejzej4N4lrori55k0TAnCL4g/NchRMuwAkkJkPUuC2SC+/uTeYkw7KmYSpg35lE1JblBbnCq/Lg1NMph5Y9Z7wgEZ+ugAseQ7ht2S1qQlD0vutOz7DF3lbAxzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924345; c=relaxed/simple;
	bh=QWSike9VpwQyStGczi0sxlL099ZlneJb2gi1J/Ddo8A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bgPpbcrZ4bX5Ov5nM/OvMEeGHiPFW0ycuV/DFu1kJcQQRpVQF7B3x8XQ0Wfr3US9Af/O4sEdCbcZT31nlPuriWvlcztLvB8ll61ynOu+m805C+pZzztwepLBBDe/+8L8jlmbhUOp+c4DcEMgIK1+SKKbYcMT3NVcXAuartMdloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLA3aMAO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f4f8742138so5214361fa.0;
        Thu, 29 Aug 2024 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724924342; x=1725529142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hbF3uMnM7NmwPcRt6ZaNxjqp4u1ebyZqTFRyY9sGTo=;
        b=GLA3aMAO+Iqu28/in5dzl3Jqsfz7AiBrvre5Ksq+No/6Qv3+aB4xVuzt1zgQgSMwxq
         UW+o1Vf5hlllLVeJ95hBXcYZVSaxAI0tUpJeZ5eXChtscJ3eYnLGjaEc+aNRhXBA/7cQ
         bbTWp5tgKyz26kJWu+oQMBXUC3/0BVBEy5SNHEjlE+53wJrNByukduiknZjqfg02Ne4p
         7NCentAH4IHd5inCj6gm9+Hxtm5a0nFYhO0mkHYXEWqdjFLrLmVKXofVNXuWQ+L8k0Gt
         pVz/ifRBKK7Y8LyMuhgUkFdi/AylwjQ4CGa20PIMF69y8i444966A1TIHYxYlNiPI8lq
         Urvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924342; x=1725529142;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hbF3uMnM7NmwPcRt6ZaNxjqp4u1ebyZqTFRyY9sGTo=;
        b=LyIAW2F6zWb7GExMjvoGQ8aWK0JXb2kjtE8J//XQdH1JlksVli6N4kw9Uqn4D2y+Zb
         yvrs3oY6QLyM8+lFUHz+L/PF7eY8S7tc4qUBBFcdtpVbSGdEwHleZ+ltekeFtI1TSVoT
         kn5H32iwAvGOEM8afo4wCyT6NFWwuBLzD2JuyQpgogHpoytyDD1i1zZwj+FdcVQrlWUy
         NE4q4txQsxaVaJjN9jIcSEGxp2tC9WhenTdFgW3F9BpYoacKr1abjPF4ZDtCSzwDztq5
         DiUjk75uDOFYnfTYKx9EKeMVP7Hnj/P4v8ZpUNj1mZ8MLxnPk+PfpDnz5UUSf1QjXwSk
         W9QA==
X-Forwarded-Encrypted: i=1; AJvYcCVFfxHTHauRzsldkO8Zw4W2X+yOfDnXBrmNz9XHVvbRHAMy6hJ63E5DY4ny51AHo5b7+JhJPBdqC0mU@vger.kernel.org, AJvYcCVVra0aSOgZhGwP6h2CXP0G4jbqq+3o7hLhjeZeA4/LQsoVLOAqX2T5sPrxrvPYvROy28XBnwAKP/YRfEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2V1iz89+wvh/L06JoXGCbdC1v9niP/pw5X+wIFsjVvI/4cD6a
	XQ3idfIEwJt9YwiTaE8vV8EVpBLLlVC7bDt5DXqvjfnLmDg+XaDW
X-Google-Smtp-Source: AGHT+IEl3gdYEee1AFWa2qjbOMcMGHCyHZVZXt92+u4wIHzgP73YdKmvKxD+7CNkAiMz6DGvnkoN2A==
X-Received: by 2002:a2e:be89:0:b0:2ef:2450:81f3 with SMTP id 38308e7fff4ca-2f6105b5720mr17354741fa.6.1724924341444;
        Thu, 29 Aug 2024 02:39:01 -0700 (PDT)
Received: from [192.168.1.105] ([178.176.75.17])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f37dc3sm1316491fa.59.2024.08.29.02.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:39:00 -0700 (PDT)
Subject: Re: [PATCH] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
To: WangYuli <wangyuli@uniontech.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, bhelgaas@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, guanwentao@uniontech.com, zhanjun@uniontech.com,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Wang Zhimin <wangzhimin1179@phytium.com.cn>,
 Chen Zhenhua <chenzhenhua@phytium.com.cn>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
References: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <99754b01-51a0-29d3-6022-4e25130ff36a@gmail.com>
Date: Thu, 29 Aug 2024 12:38:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 8/29/24 10:30 AM, WangYuli wrote:

> The resume operation of Phytium Px210 xHCI host would failed

   Fail?

> to restore state. Use the XHCI_RESET_ON_RESUME quirk to skip
> it and reset the controller after resume.
> 
> Co-developed-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Co-developed-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Signed-off-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Co-developed-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
> Signed-off-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
> Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Co-developed-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
> Signed-off-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
[...]

> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b5705ed01d83..af967644489c 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -55,6 +55,8 @@
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
>  
> +#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
> +
>  /* Thunderbolt */
>  #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
> @@ -407,6 +409,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM ||

   Hm, ||, not &&?

> +	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
> +		xhci->quirks |= XHCI_RESET_ON_RESUME;
> +
>  	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
>  			pdev->device == 0x3432)
[...]

MBR, Sergey

