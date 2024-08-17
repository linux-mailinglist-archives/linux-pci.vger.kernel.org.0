Return-Path: <linux-pci+bounces-11787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C3955811
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BE01C20BF3
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30914D28A;
	Sat, 17 Aug 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH1ybmn5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEB14A09C;
	Sat, 17 Aug 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900969; cv=none; b=epGI8sfAdB2p5QedYNeOj+RWpd5Gno//kfjsqG0mgj0nMFlBpiRqr4AW4UFQ4C8ydKAwNIyIv+ilkBhHwoh3pA/9m7zyxvhN0PiHYOXx/qu+E1tzUW71qBqiTJ5nftfG2niBN4qMnD7zBEAdGdeRkmXmQw0t3UrTs2Zpve8KpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900969; c=relaxed/simple;
	bh=kIz3WxiGw2b5pjKxeFQeh+US8XPzHOkBIlB6jxrVIQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmuQG9a0Pup4Nsy1u6LYj+2th/uxEQ43CMNIGiKKgpj7WbLTJIpFZnUV2B1Ab5KAHv5Uj9vrVkaJhqVKqCH52y6KAsJSRjnFZd4cpHgP5aJt950JVqCuxDS3s/Ukp99zlF/me+x1T10L5OzYDSVXw3nE7DiHYD5SH33W07hj0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH1ybmn5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2701a521f63so1193466fac.0;
        Sat, 17 Aug 2024 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723900967; x=1724505767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIz3WxiGw2b5pjKxeFQeh+US8XPzHOkBIlB6jxrVIQA=;
        b=AH1ybmn5vMGeJBvast+Na0ugdFY9Rsxvm+hM4ekNF6MDs9YcLa/x2v4f7Ytuh8d5tU
         JlGIx1F7pGJeDWYuExwa0IHwMDGjG8GtRA/eyueOOGZ60aLCn9p7oU1O0rVjjvSY1Rsj
         upp9wk0qA7PioKwmo4iAB1//bw8/bMrZR9b2pKwaRbl2D6G/mCDqzFsRHAiOA4gt5VWU
         LpFQJKSqBn1ewHt0rE7QDDB8pUk9D+4sDALH47463Hvjn1o/Ectf+F/wlKhz7E6iL1xe
         ME/Mr2QIyZ6DFqwjeIQMdSfxvaIJFV6KK5nKN1f3X1MSSbcpVZOMtkUYW8SMJ8C3BxuM
         i6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723900967; x=1724505767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIz3WxiGw2b5pjKxeFQeh+US8XPzHOkBIlB6jxrVIQA=;
        b=uIRuMC67ngoe2X9IWTGn+y0+QWS51hQ7LI1i+0+8f21KF8t3cC/6VAaCMLOFDF4R2e
         zjLthl/vcQyZyXXn5kCp4ZHOtrxr/vTQ6ylIx7o5GBeQoKkOm3xXQ6wEoKtuNNUkDvxH
         KY+KCFp+eeg4TiQrQYs2paYdiJY1E3ZtLDNyzDHIwmrJiHlWmNCgSF9ZI9iYNof5zkvs
         sNxsOsnAR1OTTDQGtzUEOqTPN+/FpErk7Ekbe1Dy6LYNnYtcUJlLObPZZ1+2oCvpVMmD
         4YKpM2Lik/e5/GCOMap7mZzCwTxy0BAZ6bnzZXFlja5nPyqIS1sAypG1wMRaYRgvWkm9
         Bo+g==
X-Forwarded-Encrypted: i=1; AJvYcCW3YVRqkVhwhTF3y8alQVtRtuAA/O+Y8LIZwhOew+NeYYNXSuUyLM7LRZYtNTQtpyFP+3h248iVzEenIzQvwgTFPnciqrzPZlKqx1vqwr0CoIBRZBSKwsxdNqRGhXohldljKtt0wGU5
X-Gm-Message-State: AOJu0YwD1GaSkesjxP0Bi7/QEZBv3Mo7lAhd0pXy2U9fw/9eCbRLsgVo
	CrUkZ2TuONaGBkORYJLe2BGbfcy7o8RSvde1b5LoiIfBtpYVMGp3MKZ9zgOPfJuGf7P7Ln4QMvs
	wL4dxw5f5RFNLQ5pw0cuiWX4KiWX09Q==
X-Google-Smtp-Source: AGHT+IHK2heb9nA7osGKnnkoacqf1MT3kEjpkSKOpqhsOVIrl2OikZXm+KXZVTW/PJAzQBHDVAM/Q8fNk01MNAk665Q=
X-Received: by 2002:a05:687c:2b94:b0:25e:12b9:be40 with SMTP id
 586e51a60fabf-2701c3df3d9mr6032787fac.25.1723900967163; Sat, 17 Aug 2024
 06:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625104039.48311-1-linux.amoon@gmail.com> <20240815161135.GE2562@thinkpad>
In-Reply-To: <20240815161135.GE2562@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 17 Aug 2024 18:52:30 +0530
Message-ID: <CANAwSgR+FLRHpU1sJ3PvNzpAKqMus6iygjQs6yv4kmukuvUGzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan,

Thanks for your review comments.

On Thu, 15 Aug 2024 at 21:41, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jun 25, 2024 at 04:10:32PM +0530, Anand Moon wrote:
> > Refactor the clock handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for enabling and
> > disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> > the clock handling for the core clocks becomes much simpler.
> >
>
> Why can't you just use devm_clk_bulk_get_all()? This gets rid of hardcoding the
> clock names in driver.
>

Sure, I will update the patch.

> - Mani
>
Thanks

-Anand

