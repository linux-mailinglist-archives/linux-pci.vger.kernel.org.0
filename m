Return-Path: <linux-pci+bounces-32044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F7B0378B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 09:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA73AED7A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D91A5BB1;
	Mon, 14 Jul 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b="ZAzUu6mT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E4226D10;
	Mon, 14 Jul 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476913; cv=none; b=pkaOeYCnGc88MT4el11ibXXrIXgCaAtIrchcaiBgkDbQAsTZd832+0sMXMhkwOs+y0etifgSuU8uqtBkmu+EcE5p6s2raA41J3pLV4LSPJ02BDnGYLaXn3wFU37WpCVe2u+cU8BLxxD2jaANpDmRcEKMFiLAJOEXteTD7X8WkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476913; c=relaxed/simple;
	bh=pT3B4LvfDX/MI3J6lEc9pWSE+5SEOgad6IB0H01Ds/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwbDwm/Xx8078mTeWMnDtsJB1/EcDCk1QuFrS2LMV3vMU+2zh9vnS3zqNZckqIjFV/9uTjIqK5q9s+6L5GUfUxp1Gpu69G2SKL/4R4Y+qTZodlOKC+GE8Mwyc6AOKT67U5qw1YxJm7QVr8iOE1hsj52Dk60I8d6rUsM0UeSpTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b=ZAzUu6mT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flawful.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553b5165cf5so4882271e87.0;
        Mon, 14 Jul 2025 00:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476908; x=1753081708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tvj3gb3g5xG1uLM/RcM8g7BKLGsZeoiyqFNvZ44VmfY=;
        b=ufeL7jCw4p1coL2ifPfBDnZnerLOS+s/WXIbXpIWOTG3HARBADeXWawtKAjqpgaDnG
         3y2iXN8lv8AtvBQQAkAZHtS8WHXxU3FvODIeZPbY/XFM18GAAUidWu9pIiYdPdYyuTIN
         /YJQ1g0/BcC3M4O8jYwCbBk+E2OtmAWex/DlJx0mmrldmo9FFSgF0kDPJzPLlTnDHRjA
         RKhQWGvP3JCDJL6yX3pSmOLZcaWpj/d9r77h/Hz6Vs5N6by+pGUXvdXC2cUmQPXx5YXu
         0BuqQs2oto4JIlsGLi8/RK5eJAFZ9oRIkDvIkOx2TN+cNBONyMt9NeyF5Zq6VIh1DcGz
         PKFw==
X-Forwarded-Encrypted: i=1; AJvYcCXGoRyyotOr03WPDf0Vhof4jL6v/kPDAgIJViq2ACV6jFVIGRxrDG2Pip599HlIBwqqiLyK9qYspc+xlUY=@vger.kernel.org, AJvYcCXNDDgZfoQEO6dw8mAF3/rTM8zmRP6alv1tnN8ozkNcoeBy5ivDpXWgyr6XhOv4fjySrqBeP0RUgqHe@vger.kernel.org
X-Gm-Message-State: AOJu0Yztt97UemVEZhEJlGWFPwXfPf4Y4tO5FnciL2C9aoX2lmvBvYA4
	FVv8HWqcUd822Nz9eUy0wOqKi/Y/Gl3wcf2on7BDZ2G8ySCshFZyYBbg
X-Gm-Gg: ASbGncvaWJJwK6/8j33Q95HV55/etmSSgaxzjrNHH1PUsHnIYm97k+NsqzSKpl4bkRo
	s3+KFXbI6jGKp4iy8bcWFvT4dJiVeJc2CZDYXfYou1TBe4IwWik2Ic/ljSk+T5X3wStP3RV9yLv
	RT3eL0JVWGyGzJ/16s5VUgQyn/OK6lPXaHzTXZMxNPfUi9pAkWdrpE7XR3u2ydGTHiMrZ7fpjov
	mkXLvXH8++p3JAa7HyFujJJ3YfNZIZjzFFbTtL/0cYV3K3+chDoFb9DRfEffbu9mXcnH3K76lQl
	AUedTwuzG8BJuFmkod+5Ctcx0++d4WAzkRhFdQjuBmGBf4rgyJf8qTXzGMoYr7tTkvGuoDDsXGR
	qqA50VLk3hI+qOZXIHDdQHDYGyFameGqLc9RRHhgOcMvSf0rRRSA=
X-Google-Smtp-Source: AGHT+IHZExcglefkFbZyxQyZmTQW7ESvjfFFcOrkVbfQH5yCY2A1BKdqYldJd9CQjXY0nM8bm5Zx/Q==
X-Received: by 2002:ac2:4f05:0:b0:553:2e4a:bb58 with SMTP id 2adb3069b0e04-55a057c3822mr3294856e87.9.1752476907492;
        Mon, 14 Jul 2025 00:08:27 -0700 (PDT)
Received: from flawful.org (c-85-226-250-50.bbcust.telenor.se. [85.226.250.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b8c5ccsm1838327e87.258.2025.07.14.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1752476905; bh=pT3B4LvfDX/MI3J6lEc9pWSE+5SEOgad6IB0H01Ds/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAzUu6mTAghiqz+sb/0NN+t3i5vbtH2Gm0D/k79j8IW1KdAXdxYqI+TyyNvO+m+pR
	 j++AqOsMDVLapns9fbPJiEwAc2serysN51fUe8tpkJZIZy9wdzXjyUNGHnmK480yHa
	 vYQWoBPspdSwe8tejxapHU8TtFlYMxZaUKsgcIBw=
Received: by flawful.org (Postfix, from userid 1001)
	id 4F1AE2C0F; Mon, 14 Jul 2025 09:08:25 +0200 (CEST)
Date: Mon, 14 Jul 2025 09:08:25 +0200
From: Niklas Cassel <nks@flawful.org>
To: David Bremner <david@tethera.net>
Cc: wilfred.opensource@gmail.com, alistair@alistair23.me,
	bhelgaas@google.com, cassel@kernel.org, dlemoal@kernel.org,
	heiko@sntech.de, kw@linux.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, lpieralisi@kernel.org,
	mani@kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
	wilfred.mallawa@wdc.com, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
Message-ID: <aHSs6ZF8rQIqEOyR@flawful.org>
References: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>
 <87cya6wdhc.fsf@tethera.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cya6wdhc.fsf@tethera.net>

Hello David,

On Fri, Jul 11, 2025 at 07:48:31PM -0300, David Bremner wrote:
> 
> What is the current status of this patch (and the pre-requisites) with
> respect to mainline linux?
> 
> I'm wondering if it might be relevent to the problems [1] I've been
> having with rk3588 resume, but it isn't clear to me what I need to apply
> to e.g. v6.16~rc1 to test it.

This is the prerequisite series:
https://lore.kernel.org/linux-pci/20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org/

However, Bjorn gave some comments on it, and Manivannan has said that he
will send a new version.



That said, if you have problems with suspend/resume, perhaps you want to
try this patch instead:
https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/

I don't know if Shawn intends to send a new version or not.


Kind regards,
Niklas

