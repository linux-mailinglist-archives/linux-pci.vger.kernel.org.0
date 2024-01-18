Return-Path: <linux-pci+bounces-2318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C737831A23
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF15528517F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71DF25116;
	Thu, 18 Jan 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qRGqsq+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96424B5F
	for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583504; cv=none; b=GCvfmQMwGr/JTjqhzPvB7gP6/roGIcPWftWHBs2iyQzuDhK4brYdb5HyHThTeqevanzHhHrNvCkbyqmXat/Drqd1B5DsQj4nIwfrxDz1A6CCsXpGznDpwLr739+PE/VFj0zvbj15ttDVBsIE/V/uQrC1uFIhNSlEmxvPGM4psE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583504; c=relaxed/simple;
	bh=n++XuhRB4EVG1dnVu6UFfzLPoEhlNslsnkhQrRbhM9k=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=YVX0RtRtUwDX2lv5350lb4fHm6jx+cMDsGMC63InPaA8VRMGwur6spZd4ktbh5nQ7BZls4XSGTc8jS4ssqqCRoxPeJ3cxtCnCUUKxofYy/2j90ld3W2B0B0GBdp5LthcKYgpchzN2k45aDhZOum/vDKN8XSaMyAbOiCyukwsg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qRGqsq+1; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b7480a80ceso438212e0c.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705583501; x=1706188301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHW8mrwPYeD3SY8y17cH7gnw3XovI7cNYSvj0nnf3+8=;
        b=qRGqsq+1bJuMzygpcPUnex5SggsPvLRZYTJseFdBGyl4S/GAZKSuc7bdKJ4EjIdPmO
         hdJbXf83QFKgssHvoAAGG1ZyqA9VDp1iB5g/O1pI+5UQvDmBCffzWB9C4FkEJyXknb98
         Ez0ibwxLiYz6GZ0QwMFqKfE0SPZlmRIKIZifWQ2sQrJ6buPgp1eHUrtQiUxRrKE0LXLf
         zHVOuqd704GbXXI28ckuPnx5KtXwNCjiGA+Xo3bonHuN+rwkj+srZUVeG31S8zky+GxE
         8OsymlU/9SdFKfojInsqMLnOYxQvE8J2YHnaNHmTl7QbL5IOG5UfKpFP2uT9RyllV1Ke
         ilMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705583501; x=1706188301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHW8mrwPYeD3SY8y17cH7gnw3XovI7cNYSvj0nnf3+8=;
        b=Jm/uwxyyCN8NZp/VuFOs0+IV7m/ejpJ7zznB+iG7irAjILhF4mIjPnqUvyP2+uN28x
         pyRoQAsmwmys/5oeh+LTxPCfwlHwIybqBa+VQtiFHsttB1CUVkhr0JLlWFulM6pPiznO
         FQK+MEkMnLbCnADI3jrImjpeeLRuofO5BDHt/tKSyRJfJ2QVt49gr+hvji7cgnE4/TJ1
         gPpw9/C943jyywyhFktfch+jwMzmx1BfZ9FUNhO8+nemKy0JlOHVnn+Op31webHg8DSS
         0RG3UD1A4FBBJuHq6G2Dv/OkYx5ahX3SiV9W9JLoDC26FgubKJ6o+3PnIB/disHNxLIi
         LpXw==
X-Gm-Message-State: AOJu0Yz7ulTwiCdprdKjYOzjFmrhK4NbW5RQ1qOTMwkopK8h+Tv5X/v2
	GIn7nBUplq3DqB13tj0LkWCLNFjsSTOMWTLiBIwPLpaKhE33+E1Oq90aWq6KhoI+0lhxfekf9kF
	JMIVzPY0k+kO/E9l4x47iRDhVK9gfzhW+zAHg/g==
X-Google-Smtp-Source: AGHT+IGTGw8HnvT5D8+nH/KgquXG/RE7XEsMEneP3Lg56sqfViwsfnFVV4sR0gvqRyQwQNymy/UlduMSCG1+S/3he4Q=
X-Received: by 2002:a05:6122:128b:b0:4b7:2c46:32bb with SMTP id
 i11-20020a056122128b00b004b72c4632bbmr1337533vkp.13.1705583501195; Thu, 18
 Jan 2024 05:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <20240117160748.37682-5-brgl@bgdev.pl>
 <65a7feb3ea48f_3b8e294bf@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65a7feb3ea48f_3b8e294bf@dwillia2-xfh.jf.intel.com.notmuch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jan 2024 14:11:30 +0100
Message-ID: <CAMRc=McUdR5oVEpbwXF+Sc1OaEtYH-UCv0ScFwrbGyWtyh8W0A@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: create platform devices for child OF nodes of
 the port node
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:22=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > In order to introduce PCI power-sequencing, we need to create platform
> > devices for child nodes of the port node. They will get matched against
> > the pwrseq drivers (if one exists) and then the actual PCI device will
> > reuse the node once it's detected on the bus.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [..]
> > diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> > index d749ea8250d6..77be0630b7b3 100644
> > --- a/drivers/pci/remove.c
> > +++ b/drivers/pci/remove.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/pci.h>
> >  #include <linux/module.h>
> > +#include <linux/of_platform.h>
> >  #include "pci.h"
> >
> >  static void pci_free_resources(struct pci_dev *dev)
> > @@ -18,11 +19,11 @@ static void pci_stop_dev(struct pci_dev *dev)
> >       pci_pme_active(dev, false);
> >
> >       if (pci_dev_is_added(dev)) {
> > -
> >               device_release_driver(&dev->dev);
> >               pci_proc_detach_device(dev);
> >               pci_remove_sysfs_dev_files(dev);
> >               of_pci_remove_node(dev);
> > +             of_platform_depopulate(&dev->dev);
> >
> >               pci_dev_assign_added(dev, false);
>
> Why is pci_stop_dev() not in strict reverse order of
> pci_bus_add_device()? I see that pci_dev_assign_added() was already not
> in reverse "add" order before your change, but I otherwise would have
> expected of_platform_depopulate() before of_pci_remove_node() (assumed
> paired with of_pci_make_dev_node()).

The naming here is confusing but the two have nothing in common. One
is used by CONFIG_PCI_DYNAMIC_OF_NODES to *create* new DT nodes for
detected PCI devices. The one I'm adding, creates power sequencing
*devices* (no nodes) for *existing* DT nodes.

So the order is not really relevant here but I can change in v2.

Bartosz

