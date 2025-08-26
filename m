Return-Path: <linux-pci+bounces-34781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04AB371E3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E061A7B4C8E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B2828135B;
	Tue, 26 Aug 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5EtV3+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FED3FC7;
	Tue, 26 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231418; cv=none; b=dkRj1H8YSl/jWvh0Z2Z90YBVBeaJcytr8RJk+RqsBaeNQ5BNSMfFVY759c5li8UMBkMu0yO6+k2ntQYSaOS4rdTGi4Mx9Zd+ZSc3HU+zxybchTxkOOc1HVrYwyJ0/yV/vD+kp8IbZLDsdKvQHa0m3WgpHSS/QXDkyOh5OUopV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231418; c=relaxed/simple;
	bh=17myaOucjERvvCYetBrODAaniWqJVYpmzWDGRJFfxns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unxar/OYIbd604wsHpeDzZlGkzHC4zhlAeX4kT1QfmRNP60NoJwxL75CZbiNnstYseqDu8R7pY2p9v7QU+Xguol8r/A7hW9Pz6UaSOPU758OY5yqcDte/PUshMD42VsKnl3/vT2NonCg1A8+rprO6ddDZ6ZtCP/VRObMeq8wg5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5EtV3+G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61caa266828so615713a12.1;
        Tue, 26 Aug 2025 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756231415; x=1756836215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rUih/4lq6tnOgfr3RSjG1K+akGbQyygeUk2CvNWRAr0=;
        b=N5EtV3+GeGwpygMLlzR38e0wVI+B3yQjvgbQklsN1MnmylxjdhmBxmP5xUeFXl0xW1
         +T6rg8ZKCD6fm0mt6IsR7b5dc0rBLnXx5aLE7brLEa1i2YsY1w4hx1l0Eqpj0eUlDQaw
         uSWp0iP/gPjgLPAH20dOoQEIv33NiZKgkCnF1NOJ5+YdyHjY84NEcXVQkxRD3hnkNsfC
         Jsi1y/+/xmRXUJ2y+fuyX5vMJ1lQPK/I4qeHIVLE+canEEfC+x6tmWearuzQkEA8fDVq
         VzTB/TFlwytfPih5uRb+yuray8V++3OPtPoS0TYCZq8RvVRTNMjZUaBF1SYhEwfChQy1
         fGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231415; x=1756836215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUih/4lq6tnOgfr3RSjG1K+akGbQyygeUk2CvNWRAr0=;
        b=KP4g/BFT1g8d6OORPZIE9IzCK9Y1TXhvjJuC9qUquXJOcyjdcWOce0UKWR8b2ey67Y
         b3JR5AmqkHgMNGO6ugv6AG94WKxi6BO/vI/EmHUP7UVaGPwssa2xCovIoq7oSg2Jrt6v
         qhZ3eBvwnYRtp8PCdkD9clul1RmfzHLeHRUb14t92X4Y85rgJmNDaljvb34Tb1UfOH97
         dpeIjGLbTWMp+9dFRSWzKJUdugStQhCr4dL+3OBq6Am84qAes71zdI+gbn11JKcYGNIA
         p0AGx/APOSreD5SGfZYDRJ4VTnnL4RfZm12xR64gET5Mf4vmCBnaezjIm8ZiHJFxNV4i
         Avuw==
X-Forwarded-Encrypted: i=1; AJvYcCUjWpky/LSq9j74qs3x7ILn/IJEfNjA8zh6aJ9y01mzCmq25UzYo3KlVSaoyc2K5egu+GgLSAx62rhg6eM=@vger.kernel.org, AJvYcCXDVBQlIVDq5rF6tLwlHRSnD39CY5Ib/pdZno6UbrY2Z3UeWQ+2jGRLg1NzSWh7xyBSxVv4gcT8Pw4t@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXbUMb/O/TZk6dtgIlcRL/oB/exnuJ9eH47gu4L3MEXPsxPW0
	WuLioXxG4TXTooNNDlS9aCprOkUSv4yWoYV9wXqMxNibq+odlxSUp5FhOfplk1GWP12F/g/ioRv
	vApfM7SRsAFEKoVU0VeIgX6kCYJymw9Y=
X-Gm-Gg: ASbGnctq1kNSe24if+vN0xxHJbOJVt741Db+9a8fxgIUfEc+/m0kpvVX8jbyvs1HXoS
	3zg5AgGnUVSjnc0kazfaVzN2NJuHK2N3B83TKkWAMIhHVQ3SvmyAMjCzu9oFTmKslWsK9uOa7KC
	H9In1C/Y6IHd2ZdPS9WSMhfyiKt4WvMuaAVbC0CBkwZDqclLmGXGVjHU8Uzy8txMAB99feAQovy
	0R5+Q==
X-Google-Smtp-Source: AGHT+IE9D3uV3O0AkBCtQGWW/BuLVVhjA+61hBXGztTm2gMKf6RV2BKFcvRXelm5EhRQCgd59rw9gYWMAZ1Ovg/hOsE=
X-Received: by 2002:a05:6402:13d4:b0:61c:4436:a0eb with SMTP id
 4fb4d7f45d1cf-61c4437049dmr10667543a12.26.1756231414744; Tue, 26 Aug 2025
 11:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826114245.112472-3-linux.amoon@gmail.com> <20250826162545.GA838376@bhelgaas>
In-Reply-To: <20250826162545.GA838376@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 26 Aug 2025 23:33:17 +0530
X-Gm-Features: Ac12FXwDBctjOyvYp2uVgs2NDXgVDXZ-H6655E6yBb5_sW-RQZ-uWCVz6yCJ-KE
Message-ID: <CANAwSgS7g-J75wqyei3KXQuVjMRYE0WWnfkwDMdFG4FFNGJKGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: dwc: histb: Simplify reset control handling
 by using reset_control_bulk*() function
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Thanks for your review comments.

On Tue, 26 Aug 2025 at 21:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> In subject, remove "dwc: " to follow historical convention.
>
Ok
> On Tue, Aug 26, 2025 at 05:12:41PM +0530, Anand Moon wrote:
> > Currently, the driver acquires and asserts/deasserts the resets
> > individually thereby making the driver complex to read.
> >
> > This can be simplified by using the reset_control_bulk() APIs.
> >
> > Use devm_reset_control_bulk_get_exclusive() API to acquire all the resets
> > and use reset_control_bulk_{assert/deassert}() APIs to assert/deassert them
> > in bulk.
>
> Please include a note that this changes the order of reset assert and
> deassert and explain why this is safe.
>
I feel the device tree follows the same order as defined in the array.

     resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
     reset-names = "soft", "sys", "bus";

Ok I will update this in the commit message.

Thanks
-Anand

