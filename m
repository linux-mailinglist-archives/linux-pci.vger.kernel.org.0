Return-Path: <linux-pci+bounces-12910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B29496FC3C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 21:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35880282476
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04F1D54EE;
	Fri,  6 Sep 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="En+x/y/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27921D4146
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651479; cv=none; b=jGOEi2CkhZ+q9HXaESI/JkwVoYdIkAXLP5VR3AmokGEBsQxb8zY1G43agjCvNLpbOlGVaGfMd36vttX8NUgB33J/q5OuYHRxY4Xa85rruPGuQajWuhDlJQEnJrLaFsP7tHLe/2ktR/DMW7ZUNBhAKa7uvPjBie+kfoZwS0hu9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651479; c=relaxed/simple;
	bh=u3Y5D/+gpkhZzI8ZoXxXzfOitDJC2EmkGKgvFyP1vZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRv/cPGyDfJrZjgW0pbUhMdQssXHSAS8Q5eRX0r8lH1TvhFVi68RF3tNuigU3AFcvt2Pv0ZQ+vrK30OVbU8afFZZ1zUidfPaqCWuSJIfxxYC6j9awOH1lzC8YhaSHNSVxqp0wxoDQexEf8BxfIc/SSZ3jg6C+BLKAV8YTQEG3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=En+x/y/6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8682bb5e79so337182866b.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2024 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725651475; x=1726256275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1DNin4wGyQ1SCVZ550URK3Tt4AeA7yoOiOf5NxikEA=;
        b=En+x/y/6bAbp2D6NGXw53ht3TWJ2584JXSUPd4x76+W1Fmmx5jNuBrlZNXF5oBifCk
         GLKytZnfw+663gyvRpC12r6n0E+0EX5oe2sjni39cRNe/nbslkQOSmAScm2+qmCVrmXY
         XIe4qMl6lzPj0tSVQ4MRng0c3moguJh49xACI2JIaQA8ntG4nrkKKA6sbhjMtuOAXD6x
         0KIGO496QGqn+bP4fXahCwoX4E6TbHYxZaK79MpuLpLVeYTcHzvSucAmeo8sTORzta63
         vqYDV/o/CLL9UM4eBzkTK8RDPNLYS2g5AShdZHleN9YZ4kJY+yifoxhuZWabr4clxIWW
         s+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651475; x=1726256275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1DNin4wGyQ1SCVZ550URK3Tt4AeA7yoOiOf5NxikEA=;
        b=E5rGO6BpMseLG1BewZoGJTiI+9Fu/92r6dEzKSjmumZ01mDbTlxWnfMNbGFCibcLrk
         z2RxbcfiJrz4cVfKX/JlPT2gmTxe6p3bPV8IF3wzGtTnuKKdPXcpa/dyqm+U4dlBM428
         ggLRpXdjKRyG/YNh+N1Z49+Wxfj4I6VIda81QJ+U05feVPmiNsOo86R5WxgvUOuLtJra
         q5VpSX06HpVXwtjFWI36TdeWyuPmQppsZtPUbGe0FJY69LUowGulzf3buTHuSbIMg4Em
         tVUbuY+nCVxyxAj/mdb6Ej36soLxXGa7BqRUQ/YwlO+E9Ih0M2t5BTUSmeJc1vm4SlDo
         KulA==
X-Forwarded-Encrypted: i=1; AJvYcCXR4D+gWmit9kNY9pojcH0G38reSwkPm1BwciiTh+0xJMmavrvy6V2d7jAevwaH8W2CdNGJCeqVbyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKNEMgvWvzmSEqGY+TVFD1lW4+Q+ybaRN+7+TJpojBi3+1eF3
	b+akKFHYNDS3k1laFHPttqvp3/2Lo6T9v3U27pqPW3/G6dazhKpOO18aYkZGwqYkGtGvagzFJzK
	1RkTnz5QBqof8pEL5eeyo2v77CdtXHM7myFuUUA==
X-Google-Smtp-Source: AGHT+IFcCZ4Fqw4AV0owtTSzIsxksX/zl97yekyXgSAkIVcmoM0Z79Xjx77p+dv6zse/AeqPA5OoQo/nnh3n54TEomI=
X-Received: by 2002:a17:907:25c8:b0:a86:89ea:ee6c with SMTP id
 a640c23a62f3a-a8a88667d31mr312984466b.30.1725651474130; Fri, 06 Sep 2024
 12:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>
 <20240829212235.GA68646@bhelgaas> <AS8PR04MB86760487CB68BC5AA90634AD8C972@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2e9__ftVct0zY56HGTkUyF_QEpEDN6_n5uCXCnQwo6Ng@mail.gmail.com> <ZtHv+LN8jypZgpZT@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtHv+LN8jypZgpZT@lizhi-Precision-Tower-5810>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 6 Sep 2024 12:37:42 -0700
Message-ID: <CAJ+vNU1=XqwpzREwo_aNoRwZrMMRpxw_9qvrUW=iU=5u5PjReg@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Frank Li <Frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:14=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Aug 30, 2024 at 09:03:09AM -0700, Tim Harvey wrote:
> > On Thu, Aug 29, 2024 at 6:50=E2=80=AFPM Hongxing Zhu <hongxing.zhu@nxp.=
com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: 2024=E5=B9=B48=E6=9C=8830=E6=97=A5 5:23
> > > > To: tharvey@gateworks.com; Hongxing Zhu <hongxing.zhu@nxp.com>; Luc=
as
> > > > Stach <l.stach@pengutronix.de>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Subject: Re: legacy PCI device behind a bridge not getting a valid =
IRQ on imx
> > > > host controller
> > > >
> > > > [+cc Richard, Lucas, maintainers of IMX6 PCI]
> > > >
> > > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > > Greetings,
> > > > >
> > > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy P=
CI
> > > > > device and the device is not getting a valid interrupt.
> > > >
> > > > Does pci-imx6.c support INTx at all?
> > > >
> > > i.MX PCIe RC supports INTx.
> > > Add pci=3Dnomsi into kernel command line, can verify it when one endp=
oint
> > >  device is connected.
> > > Based i.MX8MM EVK board and on NVME, MSI or INTx are enabled.
> > > logs of MSI:
> > > root@imx8_all:~# lspci
> > > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
> > > 01:00.0 Non-Volatile memory controller: Device 1e49:0021 (rev 01)
> > > root@imx8_all:~# cat /proc/interrupts | grep MSI
> > > 221:          0          0          0          0   PCI-MSI   0 Edge  =
    PCIe PME
> > > 222:         14          0          0          0   PCI-MSI 524288 Edg=
e      nvme0q0
> > > 223:        382          0          0          0   PCI-MSI 524289 Edg=
e      nvme0q1
> > > 224:        115          0          0          0   PCI-MSI 524290 Edg=
e      nvme0q2
> > > 225:        521          0          0          0   PCI-MSI 524291 Edg=
e      nvme0q3
> > > 226:         53          0          0          0   PCI-MSI 524292 Edg=
e      nvme0q4
> > >
> >
> > Richard,
> >
> > off topic but I've seen in the IMX8MMRM a claim that it supports MSI-X
> > but I have not seen this to be the case as you are showing above with
> > an nvme that would clearly use MSI-X if available.
>
> IMX8MM should support MSI only.
>

Hi Frank,

Thanks for clarifying this; I don't know why the IMX8MMRM and IMX8MPRM
indicate they support MSI-X.

I have the hardware in hand now as well as the out-of-tree driver
that's being used. I can say there is nothing wrong here with legacy
PCI interrupt mapping, if I write a skeleton driver that uses
pci_resister_driver(struct pci_driver) its probe is called with an
interrupt and request_irq on that interrupt succeeds just fine.

The issue here is with the vendor's out-of-tree driver which instead
is using pci_get_device() to scan the bus which returns a struct
pci_dev * that doesn't have an irq assigned (like what is described in
https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci-devices-m=
anually).
When using pci_get_device() when/how does pci_assign_irq() get called
to assign the irq to the device?

Best Regards,

Tim

