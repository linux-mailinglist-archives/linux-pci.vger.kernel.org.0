Return-Path: <linux-pci+bounces-17154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBAA9D4B00
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 11:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89E01F2256F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7D1CF7C7;
	Thu, 21 Nov 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZG0Lgk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9213C695;
	Thu, 21 Nov 2024 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185758; cv=none; b=L7qBTMrokTd7oCJjd9GpqBAMP6FoIcgAmnJcCPeqbe7oeq8ej1tQfYP1tbERkm8qcTBROh0o6TX1sgtAzLzLR67KuNcnGRKr8P63VfY45M84ci32aUfAen8+ECBmI6AjWSN/rUanY0I1CVVZiPHhb9y+vdIL4vEmkjyUL4/Shu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185758; c=relaxed/simple;
	bh=oAK0TJegtWW+lWIrhE+2a1Wu2HGKkfpJKCa24nmD05E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcQ3sEBoJbT3R0kruOux1EqxclBrkrWLIg4DCKi8ykWjU/3fLEvzE6rIMS4yzz/iXCP0cAokvV90bow8oMYHAt3JiDOvdubjAS0/H0KV+R0ob5mimfn/HTWFzyoNZYbx42wFLjsGd8Pkd5RAcFKl7KZlCJEAo9K1451RnSQjMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZG0Lgk0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da3b911b9so748253e87.2;
        Thu, 21 Nov 2024 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732185754; x=1732790554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5QMCNW5k4WGGyY3GhBYH58sgwcx1JQEoIPCRoein8s=;
        b=AZG0Lgk0PrUud95sq2PXPuPreq87lrttnXE53qfgipk+CMAQFX9mtfL5bb35bcUDk+
         DRVgz9VteWnMPnVmorFIUcb1fDOQifvLu3bqLNhiMoebvY0oNLvC6dgOvdmROO9cpcMU
         6gyCe5n2PHNmlw7KMCNvCgbVBlXfjEF7gXatrt+NshzpHV3ltmHje4F8TjF5A+uF5kas
         sesC2SvKdOePfkCmQWdnXY1BwCCr9qP8dZahNEiqGisQmaW0WJXu15/bn4ziqx4kM1lH
         leweBCFxAdgnkH1fHqrBuJfp5h8NEK41AHdgpX60u5LzJ5djRR8skwDyzjzV46NNh0wP
         yOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732185754; x=1732790554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5QMCNW5k4WGGyY3GhBYH58sgwcx1JQEoIPCRoein8s=;
        b=HfNjJJeC/h7z3MYcRsKo6re208rFrqwDsIe57GsrQZTzjV281YQOiOako9RQJXTGln
         BpUo14VUGN90lXZL90TL+RAwTxrm7IYY5Hr61qKq07fwpiDpUv9ONtd2UpUCvHwhl3Df
         yAUijhsVFlrRwhZ4xuR63bYxTu6VscOE1WmXdq/z10qLOT6APyGoN/MZNwlJdMS4EeNv
         QOOv3xQFRN2U+E4jfV5vB5GqQXwMrG25W7LQPA4H7NDMm+r6gUl7ciIuNF4p6Gzjh0cR
         yPAiM5WhRnHLwAOPWrTxtJmhtdbeT3P8IWOXE7ZTA2PJIPWCs4G88AdMv6+fKCzokTVm
         /E/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0LpD8lPI/wncGQgQ+5GNCgOWruuofxy5f7FrVDhQYgVoYUZVeSQdLH2zL70YpxFNPTsMYeAzU9LVPfiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kgRVEgiQX0IFgbMeAoiEtqCOp7WXU5yr9WwBXGnSViXNsvIB
	PazkcVAdiiQmUZIHHyhdgDcqSJyZAJ664hHhYmMhGML9mel0/W1w
X-Google-Smtp-Source: AGHT+IH4/s7Q9qGl45xJ3H+VuqI8cL6ZT/HGoYu1Q47EzlvxEACZcPoaGys06lcT0GbIo+FlnRaJ7w==
X-Received: by 2002:a05:6512:a8a:b0:53d:ccd5:606 with SMTP id 2adb3069b0e04-53dccd5073bmr595121e87.36.1732185753901;
        Thu, 21 Nov 2024 02:42:33 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd467175sm953549e87.116.2024.11.21.02.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:42:32 -0800 (PST)
Message-ID: <cdfab3ac-4506-4415-a70b-1eb867bb9d9f@gmail.com>
Date: Thu, 21 Nov 2024 11:42:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/pwrctl: Do not assume device node presence
To: Chen-Yu Tsai <wenst@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 stable+noautosel@kernel.org
References: <20241121094020.3679787-1-wenst@chromium.org>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20241121094020.3679787-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-21 10:40, Chen-Yu Tsai wrote:
> A PCI device normally does not have a device node, since the bus is
> fully enumerable. Assuming that a device node is presence is likely
> bad.
> 
> The newly added pwrctl code assumes such and crashes with a NULL
> pointer dereference. Besides that, of_find_device_by_node(NULL)
> is likely going to return some random device.
> 
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/a7b8f84d-efa6-490c-8594-84c1de9a7031@gmail.com/
> Fixes: cc70852b0962 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: stable+noautosel@kernel.org         # Depends on power supply check
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/pci/bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 98910bc0fcc4..eca72e0c3b6c 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -405,7 +405,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>   	 * before PCI client drivers.
>   	 */
>   	pdev = of_find_device_by_node(dn);
> -	if (pdev && of_pci_supply_present(dn)) {
> +	if (dn && pdev && of_pci_supply_present(dn)) {
>   		if (!device_link_add(&dev->dev, &pdev->dev,
>   				     DL_FLAG_AUTOREMOVE_CONSUMER))
>   			pci_err(dev, "failed to add device link to power control device %s\n",

Thanks for the fix,
Tested-by: Klara Modin <klarasmodin@gmail.com>

