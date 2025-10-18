Return-Path: <linux-pci+bounces-38568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F4BECC0B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C49914E3C64
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2872D8DCA;
	Sat, 18 Oct 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQNVCMjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E91258ECF
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778351; cv=none; b=G3jCN9mJw7BGp3Qty+7Q8da5LnmghBjxjsuN3Mz3qFCz4vHAYRE31dcd6o6sh3wg3YT+CRK4fL7hoLHcZRrrjngLJ+1kGi7HXscOStbED/BjWvhfwzgKZvY0EQmTejXnA3m8cpUIPTcKsS7W0eDZ6vFxY6EiNV6KeLXbjLwS0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778351; c=relaxed/simple;
	bh=zMwAxL4eSaShVuEFgCEzSnNitMi745qrXYTua1HCAfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYtk5Te1piuTyxpMaQzGmaRvQuBuaMExdKnk2IcU7528PhErYhajdIIlL/QjT5MH0eSYjiJV3cEVwBBx0uIW9mg638pfYfiWhVEUbyp2FGdlJFP5mMaS4JYUNOQj2SrboXUXD3HmqAFxSFBjL3M8W622M0D70EUug/k6ivjh1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQNVCMjD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso5047427a12.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 02:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760778348; x=1761383148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6z6CG4Bzykdg3VlQO62kpKPKIN5Ed0HvWERMlLp9z1M=;
        b=AQNVCMjDhsiMoRIEKbUiUuY5x8HbHETJfFUQFW7ffMMjMMH6J3P8lSaLnq5BMl1KKv
         ZQ4+nEzo4c6k4ZqZOiMlv/Ny1uEu/X9+iMZRP6ty7FkO/zDjxld+kXKsI9uZj2MvKOfO
         HO88bI9cIiSyrh1ID7Aq48qiNvTN+le63qtRpTUDuhrK1eCBMpKiP9Ke+nY4TXSqKB4C
         OxPrQsnEeQaKZ9Tu+ztOOgTqF+/jAZcx6w72uXOJ0eQH45FdR3zcSMiDnXJRtRpnjYK+
         p7P62puVSFz4MMU2y7L3tK1Z/LiVdylPqvF76S9dZL9KLJL0mAyizcyUMEsStEXPRkcb
         c/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778348; x=1761383148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z6CG4Bzykdg3VlQO62kpKPKIN5Ed0HvWERMlLp9z1M=;
        b=XYRwFN9f21u5f1/7yMZdXmJEwSajhKfrnZx/WjBFonPo7JagnGqKcl5b6M3b7v0Bck
         OK/iwXxu1d5KpdWWG/jJ+RkFSKgjLgnVA4Eztv0HALkCCPDeENFruFTJLU5kTT1juYaw
         YtB7NK03EJYKIeOITrU3okOlhxoeoVUZIMdlDWXAQyO/StCf7TAXVr0tpmSQujyeqGi1
         WnmL+LVUxFuR7behzeiXcXfGYwDmUo4Tv8vpx3vGMnb89STfxaSX0OF4A1Lsh2RhYENY
         Vlh4+reeUA1srJ0E2qnsivl9gFPDcNi0X0xupBO2sk0jLshkH9YgGz+O/1mcXSFuIId8
         RNYg==
X-Gm-Message-State: AOJu0YxzydYmfgHFyu6/YmpwM5f1SuoPpo4/HTJs8Hw2F82w99JVWDvz
	+PML/y45BHGRYzJZE0yfWa4BUKB3uhli5CJFIZRvmp9nLc9DuxvlvjIU9UDinKGKzaMcpT1OfeJ
	yQJMvAdMcI+l0EihRxSAROyqQYydbUss=
X-Gm-Gg: ASbGncvC4fCR2SfR+fFp5eHKrb7j+X995Y3XV3JerCzK6Q8891y9LS6nuTK5FXI2tzf
	W0WyCwo7L/BphHmS0npKwHC9RqnDhy84QqSNAB/U4ipcYLmCrXZh4CqIgJNFgNEQzlKedUI7pAu
	YEaehoTMTnmbv+msC+xAJSkztG9AmYjr0+mKd1uklPJzgo3ZAzbOE3gRJuvI3fF3cmKHBL4rTTU
	cwqxfp3vv45hrVqkmRfx0wX0G3CCDgKVb4Ybr4geDkR34X3OO7+ZefU61Y=
X-Google-Smtp-Source: AGHT+IEhR89+OlZnqrJ1xToJ35S4hHteVi05MGdBYp0FB9E+H5DwaPu0w+LV/8y6BXwE5xnOmNRU6JE04b6xtGtpRL0=
X-Received: by 2002:a05:6402:4504:b0:63b:f48d:cf4a with SMTP id
 4fb4d7f45d1cf-63c1f578eaamr5362961a12.0.1760778348106; Sat, 18 Oct 2025
 02:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018061127.7352-1-linux.amoon@gmail.com> <071f563c-6d09-46ea-870b-a51e0522bfad@web.de>
In-Reply-To: <071f563c-6d09-46ea-870b-a51e0522bfad@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 18 Oct 2025 14:35:31 +0530
X-Gm-Features: AS18NWDj5t4J8Su9s5gXUOjbXZcv8D1D0shD_oUkWVHtMigAOGJ_VaoJUxZoA-o
Message-ID: <CANAwSgQEqv2a1MGkGtj8CpXSKOXv=_wV3afOgn=iri7uqnj1bw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Sat, 18 Oct 2025 at 13:09, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Ensure that the return value from dev_err_probe() is consistently assigned
> > back to return in all error paths within rockchip_pcie_init_port()
> > function. This ensures the original error code are propagation for
> > debugging.
>
> I find the change description improvable.
>
Ok, is this ok?

When using the dev_err_probe() helper function in rockchip_pcie_init_port(),
ensure its return value is consistently assigned to the return variable. This
guarantees that the original error code, whether it's a specific error
or -EPROBE_DEFER,
is correctly propagated up the call stack for proper error handling
and debugging.

>
> Would an other source code variant become more desirable?
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075
>
>         err = dev_err_probe(dev,
>                             reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS, rockchip->core_rsts),
>                             "Couldn't assert Core resets\n");
>         if (err)
>                 goto err_exit_phy;
No, the correct code ensures that dev_err_probe() is only called when
an actual error has
occurred, providing a clear and accurate log entry. For deferred probe
(-EPROBE_DEFER),
it will correctly log at a debug level, as intended for that scenario.
For other errors, it will provide
a standard error message.
>
>
> Regards,
> Markus

Thanks
-Anand

