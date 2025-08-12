Return-Path: <linux-pci+bounces-33873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B605B22E88
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2005B18882AC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AA2F8BF8;
	Tue, 12 Aug 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFvvjqsy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C961A76DE;
	Tue, 12 Aug 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018303; cv=none; b=K2Fh6o8y18H+iOhRgsoBpsOMiFeiiPO/H5398kwT4UiPAQ0/NdA0DD2ajACW3IKIFTdeWuR6WfjrZonS7EQpLVkPu5+BzHPy2Al1HBcZ1kKot9d9YUvRrlS+ZhswCluQznYylAR1LompE2zQ/ScFkOrYtvOiyqno2qKQFCIJT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018303; c=relaxed/simple;
	bh=tTm/T4JRN/HERZIZ3VLZ5EgeyXpLsz7VKH4O9wed3sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCNoTEDIn5kjOlM3D1+mCkWd26csH4YhkIrV0uHXYK4eY1f9I7tUE3d8Nw0WAhHcc963KjE/mVFwAGpHTkeYszF+gKv7MjX3MNThkwbI/GeVJCHSKwSQXMN+7Iu6nBkDqGmxGVUgV9qfTaea1JFPtpcP8bzlhM/1ska8xsRuxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFvvjqsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EA9C4CEF7;
	Tue, 12 Aug 2025 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755018303;
	bh=tTm/T4JRN/HERZIZ3VLZ5EgeyXpLsz7VKH4O9wed3sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RFvvjqsyso8V5LN31kOLuBTnmSe+jxVxPUb9ANpeq3wgfgOTUcuDqELcIsLcyB2/E
	 2p/tfOI3TcatjuRglbUIr03JKTcuv6Bzp9OJQ+v3kya0swhfWvrJcZXZkKIHngCviS
	 5YnjjVXqBVRyURAfKozHHzAf0PNMo040AWhyn2C//wheXn+vcYDAFviTgaSYs8vr2G
	 Ms9Fvosp5m8g0N2Mv8zmPk6zsexopoy5UrqNLYlltdJqqgzU2agv9IauBlTJbruA4D
	 EE5mzus1tD7oBXD84NQ0zRwPHkVvNuMCd7PBnjYAoJX4Ua1wXOvs0pCcnfhZAhywnZ
	 HrBYxBt2Ht6pw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af98b77d2f0so1065096166b.3;
        Tue, 12 Aug 2025 10:05:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV++s5dKZsciXRzEy5ux5zs3CwH61a4hsYvAcDxpEGEgdOCbdoAAIEP02OYpVCdg4eBS/qHaFVAV/Aj@vger.kernel.org, AJvYcCXWvzgliFnk3hpIHMglqJG59KkLKw3167Nec6u4qgQmYbHySlD2JoLXwq/FatmoV14kVPx75mBjpSIV@vger.kernel.org, AJvYcCXnsMzrTh0alxpkcf3rNMg03L1V3UpdiWabu7e0ddGDJBMG+VHpalp3iIHsAMo+5jU70T+96XdtaVBJxFz/@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCk8E6eLNXsbQRcXPUCCyLwFbmpdPFbdtkrq3SDT0ShBsR92l
	mALTgiuucGcJ1+j+zFpr87Yopyj+BOAPHHIThcB+qMdQuXvtDFcua3QtKIEejhAA4xvPFT9Dsj3
	AnlG9PnLsRh08pg2eJevs1f1J2Ib+tg==
X-Google-Smtp-Source: AGHT+IFEoa4tlba107KUcmaKXIp6JOYHjwYjuPSz8H4SqTYk9RgSva5MazUnhA1P/IoiGLfpqgZnuyxmnoxsj1Dgv1g=
X-Received: by 2002:a17:907:97c4:b0:ade:44f8:569 with SMTP id
 a640c23a62f3a-afca4ec18dfmr3291466b.42.1755018301768; Tue, 12 Aug 2025
 10:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJms+YT8TnpzpCY8@lpieralisi> <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com>
 <aJrwgKUNh68Dx1Fo@lpieralisi> <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com> <aJtpJEPjrEq8Z78F@lpieralisi>
In-Reply-To: <aJtpJEPjrEq8Z78F@lpieralisi>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Aug 2025 12:04:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tPM7+W9u1k6Gf9_vzB2na_0kBMxN4O3FtTxub7GK_xw@mail.gmail.com>
X-Gm-Features: Ac12FXyQ-pfmrPqnZ0AOuFGYZ4csB3TC-QnSiCqdO5VXcnUBg2ZInOknVt5umAo
Message-ID: <CAL_Jsq+tPM7+W9u1k6Gf9_vzB2na_0kBMxN4O3FtTxub7GK_xw@mail.gmail.com>
Subject: Re: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>, maz@kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:17=E2=80=AFAM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Tue, Aug 12, 2025 at 08:53:06AM -0700, Lizhi Hou wrote:
> >
> > On 8/12/25 00:42, Lorenzo Pieralisi wrote:
> > > On Mon, Aug 11, 2025 at 08:26:11PM -0700, Lizhi Hou wrote:
> > > > On 8/11/25 01:42, Lorenzo Pieralisi wrote:
> > > >
> > > > > Hi Lizhi, Rob,
> > > > >
> > > > > while debugging something unrelated I noticed two issues
> > > > > (related) caused by the automatic generation of device nodes
> > > > > for PCI bridges.
> > > > >
> > > > > GICv5 interrupt controller DT top level node [1] does not have a =
"reg"
> > > > > property, because it represents the top level node, children (IRS=
es and ITSs)
> > > > > are nested.
> > > > >
> > > > > It does provide #address-cells since it has child nodes, so it ha=
s to
> > > > > have a "ranges" property as well.
> > > > >
> > > > > You have added code to automatically generate properties for PCI =
bridges
> > > > > and in particular this code [2] creates an interrupt-map property=
 for
> > > > > the PCI bridges (other than the host bridge if it has got an OF n=
ode
> > > > > already).
> > > > >
> > > > > That code fails on GICv5, because the interrupt controller node d=
oes not
> > > > > have a "reg" property (and AFAIU it does not have to - as a matte=
r of
> > > > > fact, INTx mapping works on GICv5 with the interrupt-map in the
> > > > > host bridge node containing zeros in the parent unit interrupt
> > > > > specifier #address-cells).
> > > > Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I t=
hink
> > > > of_irq_parse_raw will not check its parent in this case.
> > > But that's not the problem. GICv5 does not have an interrupt-map,
> > > the issue here is that GICv5 _is_ the parent and does not have
> > > a "reg" property. Why does the code in [2] check the reg property
> > > for the parent node while building the interrupt-map property for
> > > the PCI bridge ?
> >
> > Based on the document, if #address-cells is not zero, it needs to get p=
arent
> > unit address. Maybe there is way to get the parent unit address other t=
han
> > read 'reg'?
>
> Reading the parent "reg" using the parent #address-cells as address size =
does
> not seem correct to me anyway.

Right, the parent #address-cells applies to reg/ranges(parent addr) in
the child node.

> > Or maybe zero should be used as parent unit address if 'reg' does not
> > exist?
>
> zeros are used for eg GICv3 interrupt-map properties, I suppose that's
> a wild card to say "any device in the interrupt-controller bus",
> whatever that means.
>
> Just my interpretation, I don't know the history behind this.

They should be zero simply because a device's address never has any
influence with a device's interrupt connection to a GIC (or any SoC
interrupt controller).

Rob

