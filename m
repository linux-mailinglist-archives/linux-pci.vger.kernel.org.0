Return-Path: <linux-pci+bounces-17069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9119D2507
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 12:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9360C281CE2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5E1C876F;
	Tue, 19 Nov 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDODpBOB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42981C9EB0
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016379; cv=none; b=Vod7ujlNUL1wZBFfR286dMuAjj89gct3cKsDclNruuS2+hAp/ydPKHd/CNid3UiNVi1MaSLBbLh/p2w5SwgiWrQi7UiuqXooaP0uFtPCxjMQ35qlxkRCTMiDGMlc8j3igj2pLm6r8QGx963xl0vjiVaKHpM3pTg6h/SfqmsPl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016379; c=relaxed/simple;
	bh=pWCDzRw5vH5fKpbb4a2tJWUrUMbVGyhU+LitZzLKPe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FwqWKU1qJtRWPc2hknSBf81peO4Wd/SGPEbbiBZw9FibiHbFOsqfideTHYEgrH4xS/oWe3FEqyhUrifEiW5dcWgWDU5bCC3xr4pkRdQFO3e0wX2JNc8S6rUujI5jvvbgHmoLurNaamxnpk8pM/pous5zHic5dtj0QAjLUKbRzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDODpBOB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb51f39394so8884921fa.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732016375; x=1732621175; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWCDzRw5vH5fKpbb4a2tJWUrUMbVGyhU+LitZzLKPe8=;
        b=TDODpBOBTteGpw87ft8SBjdwJYc/QePxOV8OJn6+/2JJHuSBTP6Gg38lgma9DnOVpj
         4FQj30jX73N4c4kGcEdAhExqix2UC2sdrIeKusoFcQrC0KDWKu4KGVPliInqFO7ARYex
         661rO8I7gIfYq4xjOVz/wdJkjXUEGiDRc6tIbbN7G8T5ndteLwlv9Sz/ghaSnjd6oObH
         pDySjtjJAbS5WMyoAVX5Ra3Sg56qkqqvhJFnRFjy1gcvwZL4qXF4P73yTe6pO2NdZMhT
         FYnxrXJeHiYARuUAnriN+6VL+RGzOXg+wBVdhBa2bukTwyhMab5VBLCFtq5Jb7X12BFM
         n4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016375; x=1732621175;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWCDzRw5vH5fKpbb4a2tJWUrUMbVGyhU+LitZzLKPe8=;
        b=tCzmd8sdvAsn8V6ZCYX9mrPXWj/acXyFQ3a7i1lzknBgkKpKUSG5c1nycyycTIiuE7
         LudvyWrvOc6rzwHSeg7fxsir/6WZtll0ij6MCXJQzo9aajjmLo0lEohXxd1O3Ekm65pD
         OlxskdDzfPdNCqMX+NnR1Yc7e5H2Dv4zLg/RWaDh128n6tI8JSG9depRsm6Bo3oclEDE
         JdM0fnhGXjMvmq5tls7PKF9TnDD5dWJRgzI1a1rSPsEZTb2u6GL7wh6ZQxnjSHpoVA+p
         VXeiPVlQUQdmPSfd0yRw4W6DEElo2WX0TLBSAMtKhgh27FBQVWtdXEGu63/eg/u4lSvR
         KJkg==
X-Forwarded-Encrypted: i=1; AJvYcCXvU+Y0liqqCr15OM7i9vx33d6aZ018XxsDKCZtE0R3URaXl95jFoDnJKFnDCBjZLgn1mEwo+vy3Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnlSLkSFEQxICuHqwIRyVVX47t0zcZeY/ycCi0TzbisycVRUD
	SfMeD+WKX+ZbCFKR9baAnIEAAb9hutegXCzxNnpb5/sOzXo+POkbhHSOiWqUC88Dg1VGTpkPgfc
	E1zHuIgKFhN2C3FzZrmqgUCcL5aa67w==
X-Google-Smtp-Source: AGHT+IHy0PtwVM5dGFKYmgnlghdQ8dAjQxRo4mbauE+A/qFfocUGYcdeGf2wAdReJQQ4WBThVJ2xfVrPx8MEC30RPKM=
X-Received: by 2002:a2e:bcc4:0:b0:2fb:4b0d:9092 with SMTP id
 38308e7fff4ca-2ff608e48b9mr81108511fa.1.1732016374438; Tue, 19 Nov 2024
 03:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8UZ2Yxo+M2vP8bwaN5869HN0rrje2d+gqe7EPghX35OCQ@mail.gmail.com>
In-Reply-To: <CAHP4M8UZ2Yxo+M2vP8bwaN5869HN0rrje2d+gqe7EPghX35OCQ@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Tue, 19 Nov 2024 17:09:22 +0530
Message-ID: <CAHP4M8X2S+NgXizNeKy5E9dMfDOkgkumhGTxPQ=5NnAxk_kOjw@mail.gmail.com>
Subject: Re: Query regarding mechanism of reading-from/writing-to PCI-device
 from kernel-space VS user-space
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone.

Will be grateful for any pointers ..

Is it that the __iomem__ attribute merely a legacy thing now, with it
being a no-op?

In other words, vanilla-dereferencing will work in both userspace and
kernel-space, with the cpu-system-agent taking care of routing the
transaction to the mapped device?

On Sat, Nov 16, 2024 at 3:12=E2=80=AFPM Ajay Garg <ajaygargnsit@gmail.com> =
wrote:
>
> Hi everyone.
>
> First, setting up context; kindly correct me if I am wrong :)
>
> In kernel-space :
> -----------------------
>
> *
> We use ioremap to map a BAR-area physical-memory into kernel's
> virtual-address space.
>
> *
> We then need to use *special* accessor-functions (ioread/iowrite and
> friends) to ensure that the I/O is propagated through fine via path
> kernel-virtual-memory <=3D> BAR-physical-memory <=3D> device
>
>
> In user-space :
> -----------------------
>
> *
> We mmap() a sysfs-file, which causes the kernel to map a userspace VMA
> to the same BAR-area physical-memory (using remap_pfn_range() or
> equivalent).
>
> *
> We then use *vanilla* dereferencing to read/write via path
> userspace-VMA <=3D> BAR-physical-memory <=3D> device.
>
>
> Now, my queries are regarding the usage of *special*
> accessor-functions in kernel-mode, versus *vanilla* dereferencing in
> user-mode.
>
> a)
> Firstly, is my assertion true? :)
>
> b)
> If yes, then how is the path userspace-VMA <=3D> BAR-physical-memory <=3D=
>
> device possible via *vanilla* dereferencing in user-mode?
>
>
> Will be grateful for insights ..
>
> Thanks and Regards,
> Ajay

