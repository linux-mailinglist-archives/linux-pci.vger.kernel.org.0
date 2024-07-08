Return-Path: <linux-pci+bounces-9920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B8929FC1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9BB25C73
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B197407A;
	Mon,  8 Jul 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx/Eu68I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339555E58
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432571; cv=none; b=C+bpVI/io2viYK8XzRtm8jJ8lRW57nlyEuc9MGwxsTghUd/hnzSd+yXV/rUAu8kRmwReiVj+linHBubYUqTla5z2tg+Z5je26Sv4kvhG50tALPOl+H78dzFBdb0VRF8PYW5t26Zuob0rttjF17R2dY0e1FzFguaEIyUchYfBTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432571; c=relaxed/simple;
	bh=mLp3WBFRwG6lcPVCDP82jgIllOcTXUaIOucccBoUcjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2JiqoQe666+zF1hg6h5eqpErteG0H4zZHdkQpcfanZC2P38la2d92q9ckeMTtgIS1S8CtDgqEhbUW1uIzDzGApIdNTk/KU03jbutDn9BKfM6XFKXpQ37PvJ5XgzmiehQVcXHIwHgt5bFBbZETFxFCxpawLzwcjZlH7onMXlkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tx/Eu68I; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65011d9bd75so31058017b3.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720432568; x=1721037368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzask05GQU8+vHRdoPweB0hXQfqpLpGhajhE6Nvpc0w=;
        b=tx/Eu68I1OGK5mQEAlvkzM9bANkmt22ZWAheYkevjgBzne+VqO3ltckvV4+7J7YVYw
         J3yc5/mSYYqeOhyh9wtwQzVamdNjTdUSbjEmDWo+kolr3JIQ3XQCPJDicls5IP0ykADc
         wR7IRT1mJH7vfcgDDUrSfeva+d3FGK9+5aepADJAkxQFMUkb3DjsVJ4SFdvdB5UkMo7k
         0Ax2fssTggtKvZVHnFw+giUE7yrDvTXsBqncBrkZXEvA/ZnGFlmNn0vj4yii5r9sxLDo
         nF52/Eb9W4GyLSR34AEw1ess3Iv8UcVis4F+YOBlEv/BzcziJ/RGkrCO9/+Dcy6mXQ/k
         DR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720432568; x=1721037368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jzask05GQU8+vHRdoPweB0hXQfqpLpGhajhE6Nvpc0w=;
        b=eHzeWQOOjjc7WNq4L2K0sTGJ6pOYBzFEcwQPlWqOVg2TLpJ2ogl0mFhQiZGkiJiAQs
         071f/xzbqP62F/I3fvu+nOZFmo87BQRbs/H9rjyJayfQM0FVm0YfntwponM3wfEzgy3H
         GUIfgikXyIn8c7BtqUXCaiyqcdRTTzapp8xleSiljB5pETqAtmT502aAMKOpieLbT5Hh
         m5E4dEcdBXcZbSMKSQ1faSemi9KMcG5d0e2NrojoF8E84F5D0T5F+XoHzk3NCfjT65ht
         cVjswob2PnbP8DYuRWZtB8FLkkK7P+ukPrJWHa6Nh6ejA8Hd0jB3Xbg4MCDRJDXnYhnG
         cIQA==
X-Forwarded-Encrypted: i=1; AJvYcCUiI8Asc6DXGzOv4XixtGfclbHImwDd5SQu84DQ36zpLOI3okQ4YgG00Vp0iVZQ2tzfUqtE3ndiuhaIRe3AYg4KsL/0Sj1qUJtf
X-Gm-Message-State: AOJu0YxB9xJwezbSh5RxzIXWn1pebcqM5mceXPHrHI7/L50VQm/ePDqu
	82Q0raeYYaEv+A9HL3ohPwB+b2eJ0K9pfKHyshtpkrT74WAPVt6YBTrBIB4KQWTxvXsdSRe78e0
	Y3DdeB1pu4dbGo2TsdSWXaVOIBY4WJ2ToHvaybg==
X-Google-Smtp-Source: AGHT+IFjoQwu9LtRrNfNBaFbkc9SMl6CbmKGiqSj2aiwjk0wpQu4CIFn3QaaaSqZApTI7iBXbh6+zrGgoFtAav+hDMA=
X-Received: by 2002:a81:ad17:0:b0:650:9d94:7982 with SMTP id
 00721157ae682-652d7e4b048mr125673257b3.46.1720432568114; Mon, 08 Jul 2024
 02:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <172043242741.96960.2619738362693641818.b4-ty@linaro.org>
In-Reply-To: <172043242741.96960.2619738362693641818.b4-ty@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 8 Jul 2024 11:55:57 +0200
Message-ID: <CACMJSetUL3E4k_h6rUziRiDZCFhFk59D9EXNSoE=WLkA5ELuVw@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, bhelgaas@google.com, 
	amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 11:54, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
>
> On Sun, 07 Jul 2024 20:38:28 +0200, Bert Karwatzki wrote:
> > If of_platform_populate() is called when CONFIG_OF is not defined this
> > leads to spurious error messages of the following type:
> >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> >
> > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] pci: bus: only call of_platform_populate() if CONFIG_OF is enabled
>       (no commit info)
>

The commit is here[1], not sure why b4 didn't pick it up.

Bart

[1] https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=pwrseq/for-next&id=10a0e6c2a8fc0d4b7e8e684654e920ea55527f3b

> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

