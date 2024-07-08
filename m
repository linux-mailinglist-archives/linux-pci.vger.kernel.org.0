Return-Path: <linux-pci+bounces-9942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72092A694
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1EE1C21A45
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612A79FD;
	Mon,  8 Jul 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UTvoRLhm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D113D2BB
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454323; cv=none; b=GHfHnrOhiJcLbrYLEwC6XOYDaIsA5lt4575KzlQVDZUQD5aSI1R5/Bw1bf+zIlzV+JVUexqc3rJBlIk5wuslj46K4gXY1UaW0RAit22LgwBEibvjHAdzHO3tHIrY4u+eZyeUB3sDxPRQR6OZ6GNGBs3ow0qbE7NzPFe2SeaV8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454323; c=relaxed/simple;
	bh=N4zTgmOCGIZpptJHZvQ8M7KBia+dpv2NLYqoRSx/XWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObDoMjeAowZJwocJ5WdoezLwUnQc6mu3WUlRM4M6tbCmSpnq0ec9q4ueRSo3VgFCnYuVdYjAOdVH00pOlg00A24e+j+H5CFmz3SbP/FBvk8LWqfeEDTakzI8UzONdxVumxCPFKftoqEdfcgddrD/haTyNKe8oNj3qwCwpJ9tzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UTvoRLhm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c98db7a10cso2279196a91.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720454321; x=1721059121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4zTgmOCGIZpptJHZvQ8M7KBia+dpv2NLYqoRSx/XWI=;
        b=UTvoRLhmeabXH4PhdOqlXYm1QQ27y2e78+hVbczYQDdEkMid+140yz+Ped/V1D+Og4
         XZWhXDgGSC5AN4rMvKdS3ip73dIcRQ4t7IVrE+o4rFLhFyOL13DBXdPPN4UNpSDEQ+RN
         fNqKVTDneKY9SzA1isjR2jwVia6z3xtvMZLKG2U6RPsLlGS9y72LuRzzXtXX+YoC/UFD
         3+ROQAuQPk7eVfbx28ujhoeD1JB6D+kivLrCY92rk2oVL757AD5cpH7jqzBevOqwPADk
         HBdWndAVudRrw3cWY5jKRZ09BKKuaYGV/Cht2dQLGW3FnbdPynj/JFpe2OoThUhBfrQV
         uEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454321; x=1721059121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4zTgmOCGIZpptJHZvQ8M7KBia+dpv2NLYqoRSx/XWI=;
        b=kbV8T+Gvw2uPS+MvZeJVHnwMbY1QYNEupbBggUX262Wy4yhtvLngPzJxFMAzgomFUj
         icnlrgmcJCtLAMddpJukBPy96dbdbvBk1aHEZuLSF1RXkFE+/p+mq8/VngoW7EwUSlYZ
         1hwPkwQuOjpVJAe6LJ0jVI35vAae1wgxWeI18TIhwODe+o2alS5TCbVBCyND9NnL2Nxy
         czUjwnEahHenDsn+X2b3SqFfJf8/i8wmu5DEo6+1ShxDntj7PE8UPkneKvwfPySCgJqU
         nmM9ofSseOC7/TjidvFnVjKVB4gK4iGFjAlpqbzC1kCqroy7BbAtrq8wZyjqcOHHCOAX
         iB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs/oaC3xyLSu6osmDjNZU4ymHyFfNaSKR+AiEGHgV4xVAS5UmiyUP7z0tlfLLWbfKT8rR5rUz6y5Z7Y3cWf7o7wv0Mvub/VCPB
X-Gm-Message-State: AOJu0Yw7drT4wo31NNlt2PDskxZMwxxA2VS5oUHGXymplBLQhA9+KCUp
	5YLj7PDktlgNUx2KXf78AGIbimqsL3MCWmuIJTWpgOJXk/9MLoQv60CVbnLK2vaRpTt9EaPJILg
	07/c5rlzayONAD6wuu0c81kdo3UjtHhFFJ8ccgrIM/e68UkG0
X-Google-Smtp-Source: AGHT+IF3ZkVbj5QqPIPvybC5WDYIk62uSwnD5iCVAm2deAYTr18HzSAoct0EbVr0+z5tR7mNkI6qcJ9NrnOClyo7ftU=
X-Received: by 2002:a17:90b:2342:b0:2c9:a220:bab1 with SMTP id
 98e67ed59e1d1-2ca35c30b46mr117527a91.20.1720454321046; Mon, 08 Jul 2024
 08:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante> <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante> <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
 <20240708154401.GD5745@thinkpad> <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
 <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com> <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
In-Reply-To: <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jul 2024 17:58:28 +0200
Message-ID: <CAMRc=MdHSsctXYor2ycWqRJHCUciweRTie_TjW9h0yfN7wZhOA@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, 
	bhelgaas@google.com, amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:53=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 7/8/2024 10:49, Bartosz Golaszewski wrote:
>
> >
> > If you have CONFIG_OF enabled then of_platform_populate() will go the
> > normal path and actually try to populate sub-nodes of the host bridge
> > node. If there are no OF nodes (not a device-tree system) then it will
> > fail.
> >
> > Bart
>
> So how about keep both patches then?

No, it doesn't make sense. If CONFIG_OF is enabled then -ENODEV is a
valid error. I was wrong to apply the previous patch as it would lead
to hiding actual errors on OF-enabled systems.

Bart

