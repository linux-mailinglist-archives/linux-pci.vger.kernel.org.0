Return-Path: <linux-pci+bounces-7612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FE8C857A
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10FF1F22FB3
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50E3D39B;
	Fri, 17 May 2024 11:21:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BE3D0B3;
	Fri, 17 May 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944904; cv=none; b=LSTF2kK4mcVD9S4veAq9D2gxsTkSLt1VmQFdrhgrAeUSOUjXnzHOwLJNm4kRAh/AT2dlrGyuL8adqYNOBUuVJKrhEaJMiYtvAQbUm3gnt1TSot8tCYLA9IckamIK8KQFs8suVRHGnTzSY3/wD7uEnhzOTiy7GO7B9kOQcXPjTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944904; c=relaxed/simple;
	bh=r9yApgmZbuFByJJ9p+oj7H1B539TR1bZFitaz6+3RGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQLJAH6HqPrZlZOIJJHurnwTC0ibzrQ1rI2/jVbTr8FYcdAMBxnFNm/JBK/ybEHf89l7Z8NgFn5pwfO6IRUJbm+RwD/ZGMhXElbgvu8tvb9HnkyyafiyYNAHqCl9ilysH3LpPodEwICbHfgp3l/Gms7khZQ4D/kM4tvVaR9sovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so4882425ad.1;
        Fri, 17 May 2024 04:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944902; x=1716549702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn+RIDUkf3/BZVVCviqN56NNCVH5vL0DPPQQRoSbg3g=;
        b=rUce2/RhU7i8RjPuf77F+/Nzb4BvYnYn2E/Vnf982Af1NAh8gHsaB7bwjLNxzT8pY8
         S/HAr6MpT6+awq1DPUUlwNqegDw43wXKLTCg89ZemQI2/8Pec3Z/IVe+U7JQyVqFE4My
         T846R58V3O7favxe6nNRn0JvlUTLnH0ee7mSw9N6/wRuAcpgTq+AIC7ZFb2aPrup9NjE
         Xl+2EuT8bvWwuu6kZsddX1KiqVEYw++6Ld+pf271Y9QHcgdshH/fUUGktOwrdreddLW6
         rNiCFb2D6IStxcehId3ukGD+JbDzp/4zNrTYOpjq1kSsZ2iyxHDwkQVOZva9TkWXFfW/
         aimg==
X-Forwarded-Encrypted: i=1; AJvYcCWimb8nLGSFmjyuuHSMx7LxI/6OLu6WEeSS0X4dEiJmFv9shAT30CtWzOCB0AJFfwIsYytoLQYunZKQEJJpIY56I5P3pgpAblwCbp8gYR5wpywjjRq9Ux3mTa67JUqXbyn6srLUX/38JUW1uxfmiHg9ruiEoU/KkQPSz3/0ifXH
X-Gm-Message-State: AOJu0Yy2SP1ejNcHoZBlKxrSkajVCC07IGuhwg8yrgU7b+bdr0aqukUN
	uxD82MiTm0RsXYdWrNjOKzCYw44hBQ1CPGn76JKMBFABS0TZfhYx
X-Google-Smtp-Source: AGHT+IFZFxWQm02AYDAYBE9xRx/6Hp6ZxJQsmgya1Nc5RoSrp2j2eI5OpH4MHv2En0GrntatXs4fZQ==
X-Received: by 2002:a17:902:e5c2:b0:1eb:2fb3:f9fd with SMTP id d9443c01a7336-1ef43c0cecbmr273809195ad.14.1715944902340;
        Fri, 17 May 2024 04:21:42 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2568a3sm154618455ad.300.2024.05.17.04.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:21:41 -0700 (PDT)
Date: Fri, 17 May 2024 20:21:39 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, stable@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: Re: [PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting
 ep_gpio
Message-ID: <20240517112139.GT202520@rocinante>
References: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>

Hello,

> Rockchip platforms use 'GPIO_ACTIVE_HIGH' flag in the devicetree definition
> for ep_gpio. This means, whatever the logical value set by the driver for
> the ep_gpio, physical line will output the same logic level.
> 
> For instance,
> 
> 	gpiod_set_value_cansleep(rockchip->ep_gpio, 0); --> Level low
> 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1); --> Level high
> 
> But while requesting the ep_gpio, GPIOD_OUT_HIGH flag is currently used.
> Now, this also causes the physical line to output 'high' creating trouble
> for endpoint devices during host reboot.
> 
> When host reboot happens, the ep_gpio will initially output 'low' due to
> the GPIO getting reset to its POR value. Then during host controller probe,
> it will output 'high' due to GPIOD_OUT_HIGH flag. Then during
> rockchip_pcie_host_init_port(), it will first output 'low' and then 'high'
> indicating the completion of controller initialization.
> 
> On the endpoint side, each output 'low' of ep_gpio is accounted for PERST#
> assert and 'high' for PERST# deassert. With the above mentioned flow during
> host reboot, endpoint will witness below state changes for PERST#:
> 
> 	(1) PERST# assert - GPIO POR state
> 	(2) PERST# deassert - GPIOD_OUT_HIGH while requesting GPIO
> 	(3) PERST# assert - rockchip_pcie_host_init_port()
> 	(4) PERST# deassert - rockchip_pcie_host_init_port()
> 
> Now the time interval between (2) and (3) is very short as both happen
> during the driver probe(), and this results in a race in the endpoint.
> Because, before completing the PERST# deassertion in (2), endpoint got
> another PERST# assert in (3).
> 
> A proper way to fix this issue is to change the GPIOD_OUT_HIGH flag in (2)
> to GPIOD_OUT_LOW. Because the usual convention is to request the GPIO with
> a state corresponding to its 'initial/default' value and let the driver
> change the state of the GPIO when required.
> 
> As per that, the ep_gpio should be requested with GPIOD_OUT_LOW as it
> corresponds to the POR value of '0' (PERST# assert in the endpoint). Then
> the driver can change the state of the ep_gpio later in
> rockchip_pcie_host_init_port() as per the initialization sequence.
> 
> This fixes the firmware crash issue in Qcom based modems connected to
> Rockpro64 based board.

Applied to controller/rockchip, thank you!

[1/1] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio
      https://git.kernel.org/pci/pci/c/fa562e9441e3

	Krzysztof

