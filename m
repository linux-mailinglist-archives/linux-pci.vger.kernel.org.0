Return-Path: <linux-pci+bounces-37100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6FBA4163
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113DF17BE04
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8E1B4F1F;
	Fri, 26 Sep 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJvGYY1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37A189B84
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896294; cv=none; b=Iq1K37TMdk5e0xzmkCofD8C/oZ/GnjChGHlemPVYAJvxmf0Y5pYaYtVRlGy0bQFBf20rICIZUqfNgcTLgLWtD1GA+2t3TF6scdchKR5s15JIEYbp+6ohC9CanlJ9qbpAHbwKAQVtjUtj/hEO6fYCweFDEhu2qdDokt0N+xL6b/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896294; c=relaxed/simple;
	bh=ovRK5c7wZT8POELugcGy2OQZLq61t1b/lN/zUBC5q+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRDticZVD4+LqGYqFEHGQ6+1HTsxIcKc1nLltji8J52lO1xhOlITVaLS7XSafnk3bf3lLdQesBawkqbF3IPBmqDrKbYE0+kXd286YWW94o12lSZzothWUjCyrJdsiGyDtjxmF8YQ4iJyTdOjgkaio37eqYcOJkWM3QrRVc/ucLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJvGYY1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2231C2BC9E
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896294;
	bh=ovRK5c7wZT8POELugcGy2OQZLq61t1b/lN/zUBC5q+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LJvGYY1H2Ar5fYVu2W9DinOLbtd2vFvo5wcY5kL9J3oapMmum4o9C5hq8ROOUx8aW
	 IIPepmzcBFFYIU1xx4T1PdQqq8w5nzu4m3BW/xd8L1+Ujxz3ynJpW1XetZUgHEyj0n
	 h+WeDoskvMFDAextzTbW5m74OfmGcDAzvvfapv8eVho5WSlg6H4blwLViSH+/TBKGb
	 qifZi7Hfjj6wCNTtqizUwQuFs80I5V9jtG7pQA+kesVh9Iu+jbRQsscti7Ifrss2f+
	 0xmVf7YRlGpNKRVTzMKBbIjkXP1ir5Vsmv1xqGbMBdMh9gdXoHHMrF4Tx3dj6nD1mm
	 s5M+NXeTpQDlA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so4129722a12.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 07:18:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeJDy2YgFreNxTBDmUuS5TBGpvnWlU+WrSwpSY4PEYsablVaJ+4NxTj5XxN9KaLxiQEQf6JBi/Sos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOfeyV2vrCwCGfU+U7vmgBEWLutPc01p5418ZuyhzsMgmmUPr
	8HmSmd3WgfkJEyT7r7CZtNr5sdR7Zwd8N+BlkR3zxwsOyl336ijFPksWnOgyiR3T+qC7XvhJZfZ
	+GfJa18vXmfXE3WiocR+09QEyg06Erg==
X-Google-Smtp-Source: AGHT+IE5CRm41wAWa2CrClw2VSy83ReWu352foMXpDkXsta+N2WvoCGKuTDsi9qX3wkbts1/ms47yyeQSn9EBlyrs5E=
X-Received: by 2002:aa7:da45:0:b0:62f:97ab:6062 with SMTP id
 4fb4d7f45d1cf-6349fa942c5mr5046024a12.32.1758896292321; Fri, 26 Sep 2025
 07:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_JsqJMibSgsEFeUvHswVy6zsHMn7ZXkpbhch06oQxPY9NocQ@mail.gmail.com>
 <20250925191520.GA2175949@bhelgaas>
In-Reply-To: <20250925191520.GA2175949@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Sep 2025 09:18:00 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++S5C+9xFsXBJyaRfS5uO_2c+VtCMKJfRg2_ERHyRAgQ@mail.gmail.com>
X-Gm-Features: AS18NWAk7P-VFFKYhli2Rr8XOPLqBnC-mvDYbm-Fwop3vyyqN_Q7TWJokqE9yg8
Message-ID: <CAL_Jsq++S5C+9xFsXBJyaRfS5uO_2c+VtCMKJfRg2_ERHyRAgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:15=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Sep 22, 2025 at 09:52:21AM -0500, Rob Herring wrote:
> > On Fri, Sep 19, 2025 at 10:58=E2=80=AFAM Vincent Guittot
> > > Add initial support of the PCIe controller for S32G Soc family. Only
> > > host mode is supported.
>
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
> > >           in order to enable device-specific features PCIE_TEGRA194_E=
P must be
> > >           selected. This uses the DesignWare core.
> > >
> > > +config PCIE_S32G
> > > +       bool "NXP S32G PCIe controller (host mode)"
> > > +       depends on ARCH_S32 || (OF && COMPILE_TEST)
> >
> > Why the OF dependency? All the DT API should be available with !CONFIG_=
OF.
>
> We have lots of similar OF dependencies.  Do we really want it to be
> possible to build a non-working driver in the !COMPILE_TEST case?

We do. IMO, they should all be removed. The only real purpose it
serves is hiding drivers on non-OF architectures. But the whole point
of COMPILE_TEST is to *not* hide things. (CONFIG_IOMEM dependencies
are similar and really only hide drivers on UML.)

>
> Maybe we should retain the OF dependency but only for !COMPILE_TEST,
> like this:
>
>   config PCIE_S32G
>          depends on (ARCH_S32 && OF) || COMPILE_TEST

That's completely redundant because ARCH_S32 is only enabled on ARM
which selects OF.

Rob

