Return-Path: <linux-pci+bounces-44341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A4D07CA0
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 09:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DDE03004D18
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98532D44F;
	Fri,  9 Jan 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT3fZCN+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447F324B23
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947094; cv=none; b=uspScRMAb3U0c8ajCk9RDDbBOBZeeASGYm/4z7/0OQq+kGwYGIf7CKGZKW0ox4Eo3b4a0ec/TkFCm3B5uBkXaFlVCJajUoYbwDGarBerC5ynv5iE1z7hyUczvq1cX9LuCP+E19tWK8d6tG/PSbud8dDBl6Bppzmz1UEsogxTsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947094; c=relaxed/simple;
	bh=dEyFVqvHZsM/T7Ag3IZ2215N3brk4mmUPfL174ammaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeRkDrDMMnxVj5VfB79cK1FbfZAzQOgHm29INPeC/HYt/h0kR9j2HB96g14i0DfJHSxbBu7qSWQoA73y70V3eLo3RmfVItnTUJFvI3QV1AsTZl0QsoFKRx5B+3VkAZLOsFp6KBbWJx40++kT4mWcmLq7vgppPHcYJgD1xjxvZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT3fZCN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC47C4CEF7
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767947093;
	bh=dEyFVqvHZsM/T7Ag3IZ2215N3brk4mmUPfL174ammaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oT3fZCN+6fnE22eFeMA65hvn87SOSIcxzcKsc3ZOWReL3dye1AebH+XF74ntzcpOu
	 TQEmqE9JkNdoWJCh4gxW1IJ09lKJ+Sgl7uFAKDyyLMIpyHM7bC71pS1IyNyRu6qnhu
	 SYLfdWSNYqQhHLFt1OmhmXfLo/hhGJO9E3U9pdkae/qZITEU2ucS3h/VgfOSBIKtrp
	 KdRh4qdD7hMBShRD1ig+268LRal8F+Yjk0VQtU96lEAUqa0gh+/FHtGpCUjtUOzqBA
	 qJgG2O+zyKq8ej0g4DdD9KRldtFw7R05Y5ZRrkHupTKY2YG7cvFL8CX5ffC9/OaegZ
	 xPg92BqXe10tg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b67388c9cso4832742e87.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 00:24:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiWKZ47s9JLMMRP/jxb6Yqy0UTq57eEExCXXzpApY+MAytt43c+Vvpx6f8aw65RPTwfw5GyEkQXOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CmOq6CIKXVg83wIZc48LzL+dyh9TwjwPyGHc0ZigHgX21G4X
	+4rrrcWRIX+aqPQM7IZzjMZvcjCJf5Zk4RIepJyRL2VS3RIUmBsQjZO1nFB+z8Cnla7eTfcBzv1
	sMLML1G68OucQX1lb9SWaFYzOzMMrl5+eJXAyMZ/VKw==
X-Google-Smtp-Source: AGHT+IFb3778h26coKfR7Nvws6l0GQMZVFs1XUj+Hoy99wx8rR2ltwt5y6KEWa8UzJHUp8s7ZDXS2QxbY1B6VjV+hCI=
X-Received: by 2002:a05:6512:3e1d:b0:59b:7312:37ac with SMTP id
 2adb3069b0e04-59b7312391cmr2553429e87.46.1767947092315; Fri, 09 Jan 2026
 00:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com> <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>
 <xd5uvfqcx3vcbcqerji556ejstmgvtci4chfzxclkzhizqmqxa@xusf2skt6xhh>
In-Reply-To: <xd5uvfqcx3vcbcqerji556ejstmgvtci4chfzxclkzhizqmqxa@xusf2skt6xhh>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 9 Jan 2026 09:24:40 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mdtn8xdxdRLpuvMZvgWjr1qEMfMo2uiavnP=g6-M0td1w@mail.gmail.com>
X-Gm-Features: AQt7F2pU28syTeOXFA0UCIYEnK9HX-GiYK-ZM7CSGKwofDj_pu-Fl_wcwzf_gvs
Message-ID: <CAMRc=Mdtn8xdxdRLpuvMZvgWjr1qEMfMo2uiavnP=g6-M0td1w@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:02=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Thu, Jan 08, 2026 at 01:15:12PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Jan 7, 2026 at 3:11=E2=80=AFPM Manivannan Sadhasivam via B4 Rel=
ay
> > <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> > >
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > >
> > > This driver is used to control the PCIe M.2 connectors of different
> > > Mechanical Keys attached to the host machines and supporting differen=
t
> > > interfaces like PCIe/SATA, USB/UART etc...
> > >
> > > Currently, this driver supports only the Mechanical Key M connectors =
with
> > > PCIe interface. The driver also only supports driving the mandatory 3=
.3v
> > > and optional 1.8v power supplies. The optional signals of the Key M
> > > connectors are not currently supported.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualc=
omm.com>
> >
> > This looks good to me, though there are some nits I may fix when applyi=
ng.
> >
> > I'll pick it up for v7.0 once the bindings are reviewed.
> >
>
> Ok. I'm expecting patch 1 to go through ATA tree, patch 2 through DT, and
> patches 3,4 through PCI tree.
>

I think it would make sense for patch 2 to go through the pwrseq tree
with an Ack from DT maintainers.

Bartosz

