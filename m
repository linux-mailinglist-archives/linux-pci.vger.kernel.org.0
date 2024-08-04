Return-Path: <linux-pci+bounces-11238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E403946BE8
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 03:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92121F21763
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD99D370;
	Sun,  4 Aug 2024 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc90Yl7K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F13AD2D
	for <linux-pci@vger.kernel.org>; Sun,  4 Aug 2024 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722734541; cv=none; b=t1a4kSSOoIYZvK7NSlS3jPUxTCaSczaK5EgTKbnT5gSZvH0MMiuseHLKow57K2LwPTgbRFCadIpMrN52tK3T53JtLO/6oxif13Cblam9j/9w0Z7cqTc035iy8FbyHiT3e1hIUwlx4g0ypFi3wK5HIa4y1V5LHiz84kUhzm58hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722734541; c=relaxed/simple;
	bh=K+veezj80USIdI14d06D0105ImW4+LrI0v7OsJ0ImfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0+n3/CQuCC0wRFtlEwCDKyfxDcBxgTbV/WyOZIqYDAMQRuAt2+hVgqJnXqQvFl1nSbfTAUyWUd1Ph0qTgPW7g0a0f34kSV9MzF8XL5SSlFBmhCUEIh02LxBp8EtnzrKQpMOIbDrC/WF5q7XEg1wQC315w3I4S5UyawUom5JqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc90Yl7K; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso9990062a12.0
        for <linux-pci@vger.kernel.org>; Sat, 03 Aug 2024 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722734538; x=1723339338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2qGqAl0wSCI4awLRqR9GvVYYTfUtPgY2hKtL4z0aAk=;
        b=Pc90Yl7Kbi33jh/enAoNHq5HFmOSoctit0innokQrWjaim17bPt1Eyb8Rj+ORNuTFO
         yxvyjIA/hNLmvK0NlS9HWYSw6Zw18ITupPA/bNyacm4Dp/3SrGisjGKCAAsU0fJBm8Bv
         ZoboMLQaPDf+c+RrgmJaGQ0LdfkdVqBhW0aDPxjHRTWz3YUoX3W7L93maozSu+xjSoB6
         hwXzcPY0B8yqNXrlf/NH5je7tHm3nSeM8c51JQsLcYhI6r7XohsVGiGGr6a6Q/GBn3T/
         lBubd1CKTwcuOyap9SJ4YfFStw2X3xps5nRvC8xgXyFU+PRSkt+56z6qmI3oXNVEtCoU
         oTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722734538; x=1723339338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2qGqAl0wSCI4awLRqR9GvVYYTfUtPgY2hKtL4z0aAk=;
        b=KOkerS4EBlT1IW+IX1U3s2lySReYjuHjb5+j3fC/q87DMMatCTE0QiP923jbreOhz+
         btpf9whVcIGhQnNpdu575bjJTdgujLH76U2T+AZxLIrDlWHdkfj6cyPadAt6C2OUH+3d
         w878X4qbzrvsbi+AN42/qhl9D59hcSSAJ6eavpglXiJy35r+N2iNDAURnBlZCxb+bz+n
         tRQysxPAhLFDPj4QRKbEDbUz3jJr/bc/CR7C2qg2pluE+UWiATd+sv3qf1gQmncKjeuV
         fwyHVCx3Zu5CW/W8OEl+vVKUlzkG/pBup4dcydsyb9Avqr5Ws77H+ionMTT1EDFfglhT
         oovg==
X-Forwarded-Encrypted: i=1; AJvYcCUQzEZQaUlxB3RLhg87XaiguWKFEamxomaof23koRTOVS5seRiQlGI+OIPQd+FfpViw9ehRFSc+51n9qM/u+6wUABE6a/GFowks
X-Gm-Message-State: AOJu0Yzd3H+q59yOvgtxE9iElT+xnpLZZdd8VfRtsmXQwd8D0zhHBlm8
	9ndefueCtLHWbJLxZqWDr6J1MH9wQKhQgFGWZ7XKIs7myMzFmOl7DF31NVkGapNA4GBt8mHsb5W
	AkfEfOu7RWzIyNZKhXLs77Vs640ooGa5fxj8Xgw==
X-Google-Smtp-Source: AGHT+IHWppU19wjheINYlnfcY5CzDuFXA0P0olEC0oons/YvJlKTog4uDfBOYbJM1Pkyw0U7MoEgVWXKMnrIuVvZf/Y=
X-Received: by 2002:aa7:dac1:0:b0:58b:12bd:69c8 with SMTP id
 4fb4d7f45d1cf-5b7f56fc0ecmr4898690a12.36.1722734537551; Sat, 03 Aug 2024
 18:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726092829.2042624-1-chenhuacai@loongson.cn> <20240801231245.GA127499@bhelgaas>
In-Reply-To: <20240801231245.GA127499@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 4 Aug 2024 09:22:06 +0800
Message-ID: <CAAhV-H4++uTpLS8faC3CwgHHw8THuVXwZMVpGjAPxcJh_UDFCQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Prevent LS7A Bus Master clearing on kexec
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>, 
	Xuefeng Li <lixuefeng@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:12=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, Jul 26, 2024 at 05:28:29PM +0800, Huacai Chen wrote:
> > This is similar to commit 62b6dee1b44aa23b39355 ("PCI/portdrv: Prevent
> > LS7A Bus Master clearing on shutdown"), which prevents LS7A Bus Master
> > clearing on kexec.
> >
> > Only skip Bus Master clearing on bridges because endpoint devices still
> > need it.
>
> I think we need some explanation here and a hint in the comment below
> about why this is needed.
>
> I guess the point is to work around the LS7A defect that clearing
> PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
> we may need to do that even after .shutdown(), e.g., to print console
> messages?
>
> And in this case we rely on .shutdown() for the downstream devices to
> disable interrupts and DMA?

Yes, this is the key point, I will add the above information to the
commit message.

>
> s/62b6dee1b44aa23b39355/62b6dee1b44a/
OK, thanks.

Huacai
>
> > Signed-off-by: Ming Wang <wangming01@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pci-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index f412ef73a6e4..b7d3a4d8532f 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
> >        * If it is not a kexec reboot, firmware will hit the PCI
> >        * devices with big hammer and stop their DMA any way.
> >        */
> > -     if (kexec_in_progress && (pci_dev->current_state <=3D PCI_D3hot))
> > +     if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->cur=
rent_state <=3D PCI_D3hot))
> >               pci_clear_master(pci_dev);
> >  }
> >
> > --
> > 2.43.5
> >

