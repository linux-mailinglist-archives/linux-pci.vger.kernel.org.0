Return-Path: <linux-pci+bounces-13152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06604977A95
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF05286666
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC7F15575F;
	Fri, 13 Sep 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg9ry14w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935C1BC9F0
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214740; cv=none; b=MUHA0iBAt1t/8n9JZlY3gA9T6ztngTsGUEcXnLCPPNwqGbtyeM9Gy9aIkuQ8XQ1FPhvnXl2r3aDd3hKvrJgWLyZ4WRztKkpqhWgdgF8bMHVZSLO/CiD1oL3zcrBT+02Nj4nGOX0HxnibKsogYynS3W7GYo/k/PBNzXVnx1QGE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214740; c=relaxed/simple;
	bh=lNzSsQ4dHWEKB2GfotnWVYqYGlhuyLdAz/vGN5hyrYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7oy97W3G2G+IISohYLyyJXgkZlK/sL8DhQZbqMFUv5WsT5YlB5UjK09aWtyMuYeTugmPaZZN/L/IBbqzegp/ix4Q2JNpCCJAMTT4fxKFW4NxyMKjNV65AkRQxc//gI1GbUA11CMqKZ4BqAqPTRXg+v6vXjWAaypR1Z0/GjSnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg9ry14w; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so3055633a12.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726214737; x=1726819537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcDv/CHczbzjSZV5l7CYTqIQNZs80XJrVj+5sLVF2lQ=;
        b=kg9ry14wE/nYaywPESeUClP6rJ0GDkG89T358TLHwDZ5SENArWoytP4I8tf8WAqmNJ
         nGlGY3c9+U0OhkoTLMu2xoTnVSVF1sHFMPOdDeAwKfHwU5hJdwCmcosx3nbtpNgalOAZ
         SVEGQvaamFD6oZjCmzeJrb7sUwwoBjxIaKx6gcNJT0AOfT5MjerI/8ZGS88Dwgwgz3x9
         DVeKp6IUB/MaGj/MJWqW0jrGunfwIy+HzB2fZzT+/0aJEngXcwf8lF58TWvi96wh7s2d
         hw1mMLBXEVf7rir/AkJNF6VaPVVmkiE2kivrQpeFNzNkYFqBwWgIqVp4170RWBXeecRJ
         ff2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214737; x=1726819537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcDv/CHczbzjSZV5l7CYTqIQNZs80XJrVj+5sLVF2lQ=;
        b=dN//xyJziwatP7rpp2o+ZSbooHm8HIA17oJ78blXCSQNot9Bd7NcPFwXMCQOI1JFUE
         MTx1B8DUyuvI333lRYsB/khrH6/4OnPa1roaNyLWvjRJBlku6HAyReeOaQUfPKfxjFF6
         jqc+NxStTAZ0Tkpjy/TrAX/pNzcWirfLQDMNxyWGmQatlykkULt5xclLusSr4gJeBV/I
         9rjStluHKM59WsRNwSqNjaYIWlBtkQzdwE5T7y0JrU+UgeJZCheWbnIyXFdLUpERxkY/
         lF8Wxa0kqPuylIbwU1Zn8hl/ilzsquMHxy8gBxT3TA/wd7e98plsX2537ZZGHMwgWDff
         DLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeTfvj/DVP59W5W584d8IRB1poW1MRx2q/9DlkXQo1qx5CLqp6VKh/BHVW5vuFDG1kazQBg7MXCPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq7YVOAWE+jt2NnTHH+8HqWlo/nPoveGMKfjTe3nB5MZ54f/pf
	mer+dHtHFxJyqyHF/P6tF5lSTHY7oZ8Lms5Sb2sg/N0dwFKlI7F2dn/mID/IUsqx1BV6jCYwblW
	S10V2lu+TFTZW5G4zxDK61y73gDE=
X-Google-Smtp-Source: AGHT+IHhofCVXXSEe+Duf7LFIpJmTUry5zFsnyqY8ndE3ybsHhhPN5hqOK4NiTqKRy1Z/Waoy8eoESnT4cvJGxhYbbg=
X-Received: by 2002:a05:6402:3587:b0:5c4:22eb:5966 with SMTP id
 4fb4d7f45d1cf-5c422eb5c11mr763445a12.9.1726214736105; Fri, 13 Sep 2024
 01:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804012418.2630238-1-chenhuacai@loongson.cn>
In-Reply-To: <20240804012418.2630238-1-chenhuacai@loongson.cn>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Fri, 13 Sep 2024 16:05:24 +0800
Message-ID: <CAAhV-H6e4=xnd5LBppVua738So3z7O1t2yG9WCvETHgGajxRYQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: Prevent LS7A Bus Master clearing on kexec
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

On Sun, Aug 4, 2024 at 9:24=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn>=
 wrote:
>
> This is similar to commit 62b6dee1b44a ("PCI/portdrv: Prevent LS7A Bus
> Master clearing on shutdown"), which prevents LS7A Bus Master clearing
> on kexec.
>
> The key point of this is to work around the LS7A defect that clearing
> PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
> we may need to do that even after .shutdown(), e.g., to print console
> messages. And in this case we rely on .shutdown() for the downstream
> devices to disable interrupts and DMA.
>
> Only skip Bus Master clearing on bridges because endpoint devices still
> need it.
>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..b7d3a4d8532f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
>          * If it is not a kexec reboot, firmware will hit the PCI
>          * devices with big hammer and stop their DMA any way.
>          */
> -       if (kexec_in_progress && (pci_dev->current_state <=3D PCI_D3hot))
> +       if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->cur=
rent_state <=3D PCI_D3hot))
>                 pci_clear_master(pci_dev);
>  }
>
> --
> 2.43.5
>

