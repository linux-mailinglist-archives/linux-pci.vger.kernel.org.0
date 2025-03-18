Return-Path: <linux-pci+bounces-24043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F4AA67484
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 14:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B664F7A43E9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6623CE;
	Tue, 18 Mar 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiM6xnjg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3228EC
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303271; cv=none; b=c5SZj48Xr+RbBCvn5sdN3rnTTWiqFi87hfg3Pyd0ZgT2U0fKpnsBnD/Pos8JfRc8fJug++glV587FGg8O3iiyXYmzBsyLaiCiYe/Vm/qGpwkWcKWQxvjULo1rh5AILAIluutRAzU35F3uDmZQTHijaz/Qd9SQ2iW0AmjzRMZbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303271; c=relaxed/simple;
	bh=b1QJS+wUU86PJfdjdg95OYXaCmb8RomGjog1qklmYwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzt4pNddYkT9NaHZ8gcffY7ODVFSGLFfv4CkJkGHHoTswKuRB/XxMI3tJgXSiekJHBOYLk6NL6qnetx+skodSz3PZdA0yhecrC+dHIgLPiiZsvuikOAlkSVlRIOEEtwmQMZ2YzbZpguMqyvB0DbQNceJO/cIWgWhow9E1jQib10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiM6xnjg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4768f90bf36so46708061cf.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742303268; x=1742908068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLF2+GjN11c65uuWrIt4s8Uf0L2Flyd74x2vmpisKmU=;
        b=MiM6xnjgCwn1yGwEWxarZUlZrwtPak9S5hcTH0imHgrgf7Uhq2brlXqkqaAHgeds+p
         NzZ3O0p7Kd0VYeCEwQMEo12gInjxdAa4yXuYWg8HDI8YRbfEzERCrzTEEgFJYV91FaKg
         3DVlvUwK+J+J5RStDzFqnb20mRgq3A6P4JJR/TAEREXe7ckj/dkf9vfhffFgwLVLWaGE
         HlZrXaKcj9OuJHGKUCBY/HESKYkN7QDInmdj4ZvNwf8OwzutC1AlT0PbzTttmChVnRw5
         Dvh+xMV2+7no20aCZ0TNyhKuxxLz/NdBlCQkd9qJnlzrm7M69goAKU6fnJ8sCgoL65lo
         3gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303268; x=1742908068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLF2+GjN11c65uuWrIt4s8Uf0L2Flyd74x2vmpisKmU=;
        b=BRiWRNJvNSeKOOVjqbvT0qlLEQf3dRV331ilWD9MHDW1XH1fqYL52yPr1+Zlx9hRLK
         zvVawUqKG014jkEJIASD9mUsWuG1IIJZP3JOkz+bEvUOpBRzMikQtJ9lJRIx7BOgOVmP
         Lp2q2MLp6BBYAsrDnRCeeY+70XmoswBlIEbMEfx1rK+H2gcpprO1fwfNqNoSSdX5VLbl
         zr8bItBjoAKzIRX6Ydtfj17g/guAhPyg0Y2X9N81gcxITxrXXI4zFPvmf5KgLWgx3Wj/
         oL02m3JS5AmIZo8YXTEFLvHhzbRkGIO33gEiuG8FoPILpY1JM+lf1XXAg7s/qaXp1463
         94MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbFOZ5L5pNgJiHKaJkv0Z46qXVAGB1S122doczJ7lTmLmmOin2eYtXMeaUn4id0QKLAsw0R63YNv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5SPl+i7h9aY/gieqVDuaPgOPejnXHE5PplKTtIXUfz3GHErr
	hkbImncwCg2k7e/enwMLYIYcgmJY1u8ens6ac1Ftpb4gTPeNA7Bwg/NGMLR69v5fBIwa6007lV5
	IDtauQ7D/JhG2/Ylkt6C/zAC9HBA=
X-Gm-Gg: ASbGncu/CP+KVL7aiiP3nhVRNYPLWWEO6LUqQPR3BVbzOqDOhtMcTYmdpOpH4l0WIJC
	3VDgM/or1PLhEtFjHwRfgW5y5YD4bLQUpC3HnqDJgQnTy++7jjKkvdOYpds2ZGnbuH7TAQoF0hi
	MA+9u18XZj/zpqS7j/0NLT+eKR
X-Google-Smtp-Source: AGHT+IEBJV8GNccLIGwKiaqB6Vz2nIsx9WsE6o1ut05Qv6wavP+RTZXmbAyLJsH0IWKsxWrfv/1oFpC2NlsvT5zLb28=
X-Received: by 2002:a05:622a:1193:b0:476:639e:edf1 with SMTP id
 d75a77b69052e-476c815b8aemr264112801cf.23.1742303267742; Tue, 18 Mar 2025
 06:07:47 -0700 (PDT)
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
X-Gm-Features: AQ5f1JoNOAoKAvzVCzzN1x1ig2Lp6ipMUpIZm0PSxE1iVuqOUhr1ttS0IKruHXo
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

