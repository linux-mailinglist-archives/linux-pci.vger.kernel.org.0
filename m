Return-Path: <linux-pci+bounces-24044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A331DA6748F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 14:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3993B2F70
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B520AF7C;
	Tue, 18 Mar 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLwe5yQC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B62F37
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303368; cv=none; b=fPDivYaaehYKph8FuI2llSkLj34SyiwocxoBq5XPqMWrAhtvHQ1zHhxvME+FEU9isZptOghMbHa6p+1IxH8hMtuynfQacS+ocfrD3FSEbDADQ6vrhvlUIuemvJYoGI333g4G/x8jDg4ERTiDwSk2igmj8FkxIviWdwf4SDVDYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303368; c=relaxed/simple;
	bh=b1QJS+wUU86PJfdjdg95OYXaCmb8RomGjog1qklmYwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeEJIjBMI38G6qTUKjqQa2w1/WcR8suZqF/nI1Jn9DVPR+eYmOz0g3MGPyiv8yfiShrsJlWpvX15z46NzAzqAR6TL+w9XYBRYOaEq/MD0tHJ7ODfam48IUg0oUYFU+IpaAUziqkJokhwRv4SnWpSDDa+/sVBNfu5O06GzAkcLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLwe5yQC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c05fd126cso52949841fa.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742303361; x=1742908161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLF2+GjN11c65uuWrIt4s8Uf0L2Flyd74x2vmpisKmU=;
        b=kLwe5yQCSzNx6NGIcFWO0Uf9/CImTcJSNTaSgJdLphUB7zHx2uRJfH1i8O6Rg5rDl6
         oMKrnirSAQE3D626bRLLw9mT6vgwxtvxkg5x7e2Xw9GyyX6Q614Q7Yi2pHYLkCa+rmNf
         vFoj69tgPT6njM6TuHw6c6Ff8tRM502O1hDdnh0KMI9LzvGM+aUM3vIZF/Bnwnecvf3D
         A5UkU/1O7az4coY4DeFtfiGRVGid8zOgOUyY/dMqP8ZARBs5x3URzsSdyUU3Rr3jnfFz
         i2Tt3HmWSthUb9O8MZ5ErKgF/Vv2dkCV9H21n8l43BXqjD9dBAhCzLWdvQU+78I/36FX
         d+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303361; x=1742908161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLF2+GjN11c65uuWrIt4s8Uf0L2Flyd74x2vmpisKmU=;
        b=W09la7QtMLUQTW+UXrJcVI1KvTvqbtdhX2g2Zi7ncz3LBfDbpv7dw/T4/J3WNXFLJi
         +p5jRIy1whvv5vPZAaMgxb9Rbkh3DTDVwACtMa8N3boRXCeupPSawDEI0uiizs3o60E9
         I5TkTn7EEmYxAF0I1V+Kv0gQP+KSqy31Sb46qsvnyskCb7wjxhVK95mWYsc3W2UmRrvE
         PoH4aUNb1Lx7UQ1RbONUU6BGn/BANWmmhlNbQHsUyRKg0hRtBfAiLS5+YIwM+wdlUFIU
         WiI4I9mYAsrz6djggk1k1LVhOK6daC8sc7q6xinLrlPvNee2Wo3E1mmAZBAbawdNhcMq
         C64A==
X-Forwarded-Encrypted: i=1; AJvYcCUH653y1LMyPsveTm8HwNfMB6VhH6AFh9OmhaMY5RcLktVYampOQ5Lr+fcLbsnxHhFdx/bWDHOGUOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcBKtD/B5TUT9o2lHFuBfBPJnAmp97QoD0zsY5geTYh464myV
	eR0f1bS4SLFyLBTo0FSEkYyTszsXpb1lEDZZu0Qjr307X1Qb2DgcihRp6LzAcyMRE+7lKGCa7OL
	8v3sIF7Qm1TGYV+Ax0E5CJactINJ8a9U7xr4jO1wc
X-Gm-Gg: ASbGncs2IwZ6yIN677RRfgXo1p8DlCfSwg5p0PoIDE8sboGfDBrdxod2Vb5p7/h1Ziy
	+saMDHOiQVQwVCaBcbdy2sw+Hqp4Xa1JfA3oZgm69sM2WAhYUh44tTjr1QVYMXpT/NZxzx4rAoh
	ZPnRTMhi6N3MW3y508CoI2JhyP
X-Google-Smtp-Source: AGHT+IEJJqc/WSnH7CO5OIbdJTYCkUm+pTMkXoenIN9rSSS8qPEAnI8ylrlji0pjM9c6VpxqMjEy1le2sWn/cTpG2Wk=
X-Received: by 2002:a05:6402:254a:b0:5e7:b02b:381f with SMTP id
 4fb4d7f45d1cf-5e8a0bf326dmr15244236a12.30.1742303349767; Tue, 18 Mar 2025
 06:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121114225.2727684-1-chenhuacai@loongson.cn> <20250314195949.GA792185@bhelgaas>
In-Reply-To: <20250314195949.GA792185@bhelgaas>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 18 Mar 2025 21:07:10 +0800
X-Gm-Features: AQ5f1JpIQmtmilDfPXiHwAVSigX04_ir6K2oPHbNaZQfzUcpG3ERJW--z2f9mGw
Message-ID: <CAAhV-H7c9jkXqwn2STdYq-1g4jVELjKL5jaO2aASFAETW5FLHw@mail.gmail.com>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bjorn,

Sorry for the late reply.

On Sat, Mar 15, 2025 at 3:59=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jan 21, 2025 at 07:42:25PM +0800, Huacai Chen wrote:
> > The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> > MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> > keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> > only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> > is wrapped around (the second 4KB BAR space is the same as the first 4K=
B
> > internally). So we can add an 4KB offset (0x1000) to the BAR resource a=
s
> > a workaround.
>
> It looks like usb_hcd_pci_probe() only uses BAR 0 in the OHCI case, so
> I assume this OHCI controller has a single 32KB BAR?
Yes.

>
> And you're saying that in that BAR, the 0x1000-0x1fff offsets are
> aliases of the 0x0000-0x0fff area?
Yes.

>
> And this causes some kind of problem because the OCHI driver looks at
> offsets 0x60 and 0x64 into the BAR and sees something it doesn't like?
Yes.

>
> And this quirk adds 0x1000 to the BAR start, so the OHCI driver looks
> at offsets 0x1060 and 0x1064 of the original BAR, and that somehow
> avoids a problem?  Even though those are aliases of 0x0060 and 0x0064
> of the original BAR?
Yes.

>
> > +static void loongson_ohci_quirk(struct pci_dev *dev)
> > +{
> > +     if (dev->revision =3D=3D 0x2)
> > +             dev->resource[0].start +=3D 0x1000;
>
> What does this do to the iomem_resource tree?  IIUC, dev->resource[0]
> no longer correctly describes the PCI address space consumed by the
> device.
In the iomem_resource tree the whole 32KB is requested for the OHCI control=
ler.

>
> If the BAR is actually programmed with [mem 0x20000000-0x20007fff],
> the device responds to PCI accesses in that range.  Now you update
> resource[0] so it describes the space [mem 0x20001000-0x20008fff].  So
> the kernel *thinks* the space at [mem 0x20000000-0x20000fff] is free
> and available for something else, which is not true, and that the
> device responds at [mem 0x0x20008000-0x20008fff], which is also not
> true.
>
> I think the resource has already been put into the iomem_resource tree
> by the time the final fixups are run, so this also may corrupt the
> sorting of the tree.
>
> This just doesn't look safe to me.
OHCI only uses 4KB io resources (hardware designer told me that this
is from USB specification). So if the BAR is [mem
0x20000000-0x20007fff] and without this quirk, software will only use
[mem 0x20000000-0x20000fff]; and if we do this quirk, software will
only use [mem 0x20001000-0x20001fff]. Since the whole 32KB belongs to
OHCI, there won't be corruption.

Huacai

>
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_OHCI, loongso=
n_ohci_quirk);

