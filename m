Return-Path: <linux-pci+bounces-40981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F85C51ADE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E43E4FAFE0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7702FD1D5;
	Wed, 12 Nov 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crb3PhBQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5A302176
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943079; cv=none; b=mSbOwcfRIFxjFvxjf7cAPUNtce8hFxnTbOYHztqZFkg9JWZLq01aXoToQ7sWXcVDvPcFoeRlG0pPWTDYLipgR3dJjGd7LIBhoLrlWbw2pO0XhEomb6XtrT+hGsNeXhKuMwCOzsq3eg2wAo0uHIOuFIiDYbraB6eWt7A9jPmFu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943079; c=relaxed/simple;
	bh=TSihLUp500EyLAY4SEa7kifFx2y3QU41/npOaDx+y2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2mwEWImd5ZT5vWrp2kkSzG8hjkR4l6NRKuBe5FoDAdA2rLlFzfJxp7kpLTIsoPgbwS2w8O7jp4QYWHmUdRz4KPEvVng08mHmueHbE056OuqljmUJfolR0ImnzFzp1BgWrpx1H9Kx5+66iwKKQOButp57wchW12T9/4AzoBEoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crb3PhBQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2960771ec71so834345ad.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762943077; x=1763547877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thRGHA7lZ4WvBhWmfKrR34oGBTmy7fpmtkgJ42jHEO0=;
        b=crb3PhBQyzm6KXbKhOXYVtQTvo3n08sBbdrnt9np5UTZzIdEJlADC74KV7flWmSL49
         GCyQnvIDZLEfEeAX1xh2OvqbBLryq9M8TF398fBIMzPxipwrULjCd6bxDMPkeksf2JMR
         tb70i+G2FEMMfJIStEdULo1WWlO5UeXuTdHmbrIdfCCZZCGX1CkEusSPgw/nVc0jMknH
         Kk6shyto9CICk8yBWHUBOESyhjT7MlPdd5z1kxB3YiTKeMod5KG7nLDE29CfZljdLBKa
         MvOz/tLq9eUUJ/vDGqTwrXDxGFpj6SU0P/7FWRHPg/0eHML40CZAOBKVLtF6AoMdKMPW
         OkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943077; x=1763547877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thRGHA7lZ4WvBhWmfKrR34oGBTmy7fpmtkgJ42jHEO0=;
        b=TxsoXM2cH9kIyAIe2nSH+oJewoKzkvxouuOMB9gtTOOT6hReFom5yRaJgdhvfabOav
         dGoj258psm1hfPtDaM8QLkCCTfnXEdMx4hlKW0InaYDg/TMsWBr7A6wHQfofd+7Df5Q6
         DVQboo1McMwkH23crbWqkuuzd/vpppgTzH2WthS4uul/Qr/r9GIVb42TM9W7yS4xefTL
         NxMltXeR3D6MA4T4dSIcFb7DvkrQ9DKAJxLJu/GKjk0ab/ceKS6ZM29i7L2nYxzbTDrM
         UCHc3YM8/rIYpHbbPq8akbEgjBwj77Mm3GVWwv/lMFnDfqDynIh5wO7La1+NDbzalAEC
         cJpg==
X-Forwarded-Encrypted: i=1; AJvYcCUwhp72yWCGKvcHegcQZ6GP80Gc6jkkhMmIPM6oEaESHKWZQTr94W9LK5r89NMa0UIfLKuWRtIlpVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8l2SEDjUg4X03aN2g4ASiwePU/w50WRDWpLx2/9O1Ye6WWhM
	11ZCi9TLt9CJmSzNpf6MZqORt4eREq5hBSw2YguH2k/f953/JcCZYZbssC+Rly/5csYE0VLUlaE
	86DtHRizdwAcI9necInh6iXAe0zukzZ4=
X-Gm-Gg: ASbGncstXq8yIb34qbgQjjh71GM/ehpQm+vQl9alFyKxRA88RmaYuVd/MN7zXzQ9lRX
	3Ahfg4kW76E2vSE0eU3iufX1XvraHMoU4+aNsuAcWKTac9j1zxyC8LmOeIMYbifvUnGU00xaLRj
	MkVoygpOQWtbE3j4+QqIsoFiNr0zwwKamFFoDYcrcs0VRgQco2W59iVYJXwUBgLCvkBAdIep0Us
	HozW5+HSn7AjHiFBCxHBVe1s2zl6Qe+369cfqCwW26Zzbt1BhDpWqYDBIbDwf02MQGS2Cx8AyD5
	474KDWHZkZuYAi8eypAKcQwZcxPxlEG4bGQ2+cd+fsvbUuGLGztlTNyAsFjXKYJ6x6ef5579Ugt
	5u58=
X-Google-Smtp-Source: AGHT+IFXdt0eC/TNJMhVwjtz0jzvWJqBrfAxSOIG+Uex6LRyLb1AH62t6/E7Goh+RdshjhJ2iPlgpXN/tE1L0o8I8Os=
X-Received: by 2002:a17:902:e84c:b0:296:53b:fcd3 with SMTP id
 d9443c01a7336-2984ede5835mr19538865ad.9.1762943077201; Wed, 12 Nov 2025
 02:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com> <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
In-Reply-To: <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:24:25 +0100
X-Gm-Features: AWmQ_blvUG-sHnAQM0zxhw6lztFvEbWamDmMnEK-LJSwP8G6De2JOOAOnCidHdE
Message-ID: <CANiq72=xZ08i3MFqXyxFG63gq29EUggoyb57SJWPNW-Y_VFqqg@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Marko Turk <mt@markoturk.info>, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:17=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.co=
m> wrote:
>
> Hmm, I can't find the initial patch in my Inbox. Even
>
> https://lore.kernel.org/rust-for-linux/aRRJPZVkCv2i7kt2@vps.markoturk.inf=
o/
>
> doesn't seem to have it?

It was only sent to the linux-pci list -- for situations like this,
you can click in the "[not found]" message at the bottom, and then on

    Message-ID: <20251101214629.10718-1-mt@markoturk.info>
    found in another inbox:

    ../../linux-pci/20251101214629.10718-1-mt@markoturk.info/

where that last line is a link to the other list that you can click to find=
 it.

I hope that helps!

Cheers,
Miguel

