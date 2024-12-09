Return-Path: <linux-pci+bounces-17952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B419E9D64
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D103618887F4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37036143C72;
	Mon,  9 Dec 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9l5Mbx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFE1552E7
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766393; cv=none; b=UNsqthN0+LahntLd9LUOrmRwqWbegqSQPyrrPZQd/SJSrA/H9El+AiJJ/y3VB/43l0TLgHZ6hYX4DUsEX/5kyHdoqeuHzworSkeYueUbWX+uvIxlL5vWoG/34y0TP+JDOOXfyvRNFTnNPdyepx20oJ4+9R81+AXZOxyaRRwT2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766393; c=relaxed/simple;
	bh=9b5qnojK+R2I8vIwqvTF89/RKbNf/+O+3Y2iKZaHEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecCBa4Mk3GyByzgpqEMQU7tGJm0GHl6NNdrQCLDPzqtp7vm49t1Dk63LoE+XNjY1HlDGp6iLIHI5INA6R1eGpwwqWFAdSZxkov/AK0ZdyZEYvoGJWUZa4t0D2iCjrWzpQzDLSR02AoP4PVVOhBW6UIAd6xiiEmX0Hxdr54FeTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9l5Mbx0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so12229145ad.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733766391; x=1734371191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAOCpxEOgR83Rnlqz7iMqvx61rBitZ69VRqbYwHS+Rc=;
        b=g9l5Mbx0IAtgftTI+Q+SoNj2czxw3Oz5V2zs/eZ/E6aN4uAgY1Xx+BoTehkOmeupxl
         4dgTyoEZ3/2z5hBsl8P72QeRRelS2bfdAyrvHFzsTBlxOcJL7FhYsDNxfcy5ntGoOJx0
         8CfC3bzyqCRU2kXfQ87wO4xVeyuXAJYQDveK/Wb15lJGZGbEXMkHYFaKHRt1ZQ7t3ejj
         kXOqWKDAgKJljxDo08UknpmXyJb5uGt+N6YvgnNyaGJBWH6EzRKRkAOIt31KBTRuoYSy
         q3tCsFYYdx8UyOUymB5GZchuv5h+er7jSw5NZfAa5VbREzk/0LYpS6QJG1rGDqDps31r
         fT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766391; x=1734371191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAOCpxEOgR83Rnlqz7iMqvx61rBitZ69VRqbYwHS+Rc=;
        b=YawVxPTzaiDU5I8yLXDxceAAy5b6VWQolCoJO/FiZoSiCt8kiTeRZHDvgI9Pn/ep8A
         jZ1z7z1ZR5eVasajbH7hlMrKXpF8RKUG7T9S0uX61O95JqGvC+7rxuahqu8B/3B6+4ri
         bnYiZ04C9LMYc9jJlzpuDg7tcg2bgID7n62ZieR/QMYuiA3sVx/2D049WyGiCgpnFOax
         UnS6cr1UHZFUYYsElvpc3Lvre1pGtMMQWFyqn/87xnYyQvyJ3ajKSx7GREM54Mf8LO88
         f9V/mkk8bVoCB6jinXgA4yu9WFxtMfC8RT+SjvmFJ61uzDOH+UFjw6JBy3uLdOdg7xYH
         SqLw==
X-Forwarded-Encrypted: i=1; AJvYcCXcRczOnpO+sM4QfM410p6EXChOhGTviLYarGCR14gachvHAM5HagQa14YgQyZBCueoQBtyxJ2CX18=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+x0GJCmarih6RqrDSj1tCLDk4Q/TAyQj6efjkoeHB+FPY/jO
	xdkpZ0IQrcaAr1LmNlHno+7wdq563AxFFpcSU33iVwoTe71B32H4xpw3KYRyig==
X-Gm-Gg: ASbGncsAbb2ptnR6noBfHLbX+bGAcXUPjTd7lrH0fl7kQAV6dWnvIJz9DQvWXJjlALg
	ZCrDfOdAb1ITSHiODDaW0c7BCD05DCbqBliqhXRncTAt++eIymKJpSc4nvtpVI2rGT3gNBvRUWN
	1c99MYfkwRYx7rRIB/ZuavZiNtMMIK5U4Oyb0f/i5WmY63WXkU3uK0s5dEPMqkn7owCFqJtqc/8
	2g9OduNY8laQ61H2W/aB58tPBENSTYXFK7wICkWhEIC95+EFcWHNJP9CLmH
X-Google-Smtp-Source: AGHT+IGYcoe+FhprYtOY5QbmM3hEAVJjajJ6eU5NQLH8UxHl9RKTkJmmcrvmifL2+jvrIcGP8dCaDg==
X-Received: by 2002:a17:903:230e:b0:215:b8b6:d2ea with SMTP id d9443c01a7336-21614d442e3mr220133805ad.15.1733766390920;
        Mon, 09 Dec 2024 09:46:30 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216360d145esm34989315ad.44.2024.12.09.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:46:30 -0800 (PST)
Date: Mon, 9 Dec 2024 23:16:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Message-ID: <20241209174620.6a53t5k2qgmgleix@thinkpad>
References: <20241126210443.4052876-1-briannorris@chromium.org>
 <20241129192811.GA2768738@bhelgaas>
 <20241201082108.qy2reqd56mvrd6ku@thinkpad>
 <Z0xAdQ2ozspEnV5g@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0xAdQ2ozspEnV5g@wunner.de>

On Sun, Dec 01, 2024 at 11:54:45AM +0100, Lukas Wunner wrote:
> On Sun, Dec 01, 2024 at 01:51:08PM +0530, Manivannan Sadhasivam wrote:
> > The idea of pci_pwrctrl_unregister() is to remove the pwrctl device when the
> > associated PCI device gets removed. When this happens, the pwrctl driver will
> > turn off the power to the corresponding PCI device
> 
> After pci_pwrctrl_unregister() is called from pci_stop_dev(),
> the device may be accessed by one of the calls in pci_destroy_dev().
> 
> E.g. pci_doe_destroy() may set the DOE Abort bit in the DOE Control
> Register if a DOE exchange is ongoing.  One cannot assume that no
> such exchange is ongoing merely because the device was unbound from
> its driver.  The PCI core may have legitimate reasons to perform a DOE
> exchange or generally access config space even after the device has been
> unbound.  And IIUC, those accesses will fail if pwrctrl has powered the
> device down.
> 
> Another example is pcie_aspm_exit_link_state(), which will adjust ASPM
> settings on device removal.
> 
> So it seems to me that the call to pci_pwrctrl_unregister() needs to be
> moved to pci_doe_destroy().  However I'm worried that will break the
> symmetry with pci_pwrctrl_create_devices(), which is only called in the
> !pci_dev_is_added() case.
> 

So I took a stab at both of your suggestions:

1. Moving the pwrctrl devices creation to pci_scan_device()
2. Moving the pwrctrl devices unregister to pci_destroy_dev()

Both seems to be working fine and it also allows creating pwrctrl devices for
the PCI bridges without any change (for which I was planning to add one more
patch earlier). But the devlink creation still needs to happen in
pci_bus_add_device(), which I think is fine.

Will post the patches tomorrow, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

