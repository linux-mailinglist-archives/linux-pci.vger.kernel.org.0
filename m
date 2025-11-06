Return-Path: <linux-pci+bounces-40479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2DC39F8D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617914FC70F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3A30F94B;
	Thu,  6 Nov 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yX+mw0YY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0530F811
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422803; cv=none; b=CkHMoY0QdqK+kOS5dwVMGJ3byl+X0SRnmd8mNZqRQg4NkNAk4KTbZZ3sdQRhhMANVH7ptChEgYtXqjwOAezbD4R+fpgO/4wkGTS1oY8OUSHNXNdUNQ63/PBcMOz/SW/xcQw253UxX+N0pYfrIl0LL7dYu0EASR6kRqaTVeSvle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422803; c=relaxed/simple;
	bh=N4gdAIjGWxxVJdRrTQ/TDeMEBNndKgzj5Pz6LBK5c3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzTo9fJAlMS5QYYqAKgJzhaaMRGnKo2QfuIKZZJZyHEAPELvMfBrJzS77/lLjog1dTDCigkXg55sArMfsrpzzbkdgT5W/Ab8+oZjyKRGgANHvdhOZFREu+pmkumo1MSKuscs4SuL1PcgHD942WYIUhuUiv+li/wQm9kqE5jZwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yX+mw0YY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-591c98ebe90so687928e87.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762422797; x=1763027597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+8daSNDhd8lCt1K2wrPTUKlaXsPe2T2RLhKmIvnqVQ=;
        b=yX+mw0YYFPOTgc8GfGwpdbFkSZYXsAYZlefjKKw0sscN6FDJryqCuFep07C4O06unQ
         DXPMRtYbGnIGNrTveyvcY3AE3PDoe5ovfnrFZ5AvXBvo6iuwYvOBbqBhEZGvplm8RBPa
         pGj8pOvSqCh3MkoLvvJMkgSDCrbNH4j4OUoXUiePWNjVzLO0YPQEftrRWL5g7K1L7OAP
         uVrGSkr9mT/Rh1THyfiQQW+kpOWAVSLf8g7qTxb+g98VAD/Fd2Ij2Jp7KU+734GEzTYo
         3IuIv+Pno1zwBvu0Fm3ozggoWhT4+Bzwz9wQG7Ch80iT/76NlKh0X1OL9ryhYQGHImqs
         FdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422797; x=1763027597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+8daSNDhd8lCt1K2wrPTUKlaXsPe2T2RLhKmIvnqVQ=;
        b=xLMvNOOVMshI9IkXVY1qQS9i1yrbWSC604owsb9k5x5GfCO2aDB2jX7fybCy5yzuKu
         tiQtgTvAuWVOf2RsEOEQ9ZDO9rYbbuW5RD3BmNZtWvHRTCnjMdB+xmD2s8Z3k9To8CcM
         wtgDwXcNc04MhI5xlzz0b+Xbp3njYBG61hGq0YfgHDCACPYiDy9ggv/7SBWmuRSNWJqb
         LKtxGhAB4ruVbfeIoPDgg7ApqgI88CVMRE1GF5jDKMpfXyFtwldgsYPfyCQS2O+s/VnC
         6zX4hj+xAjRJYsgvg/Ee9ICJFcfg/8FwrcG7cEb7ZcYEMiaiURCGQuhL+ZaYTj4vxctK
         3mpA==
X-Forwarded-Encrypted: i=1; AJvYcCWf0SbfUPMIeMgZBrbJT5b/REaiDR1FBVPWus+FCJCc4ivzOjYdvvG/L1BzcB2ax7csT1YuWVtmwyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNOK0p/ffXn6Mq2moTHPIMEuRgQx0BoM5nMtVRHfKMYkfx5Lc
	KBCwONtF7B2MDBWUW3ARpun/WWXNIJMjDSJe9qI828Lo4XO4vdLhonh9UrQglPBRlEby+HTrow+
	0XNUlYlsATQMirfpECzzGeKAxScGs5gVN56WloQWJFA==
X-Gm-Gg: ASbGncuniG0o8EEaz66Co2WAmXFmzVJEZGH4GlCmZLamfp2c/rc4RKOgy8jg/NyuPQ1
	KG2KybsF0eCSI74PQpr8tqPDfPF8gbyVdnmSBK3/5QHPA0Ww7rFyYdDOQqbcgtEn5BOuOKnDu4h
	p+SVxFZJEm0zRYMrXfyyMs/ScbJlcDfk2vhaiFVs+sWh6mwoCYlSMo7zUSXMKsf2Qlm12ugVuNh
	uA5dUlOhd+LMedV+kMX5RfBQygwrkxz15APqIJSZsCi5mvGY6BAOz4ZGv7PxWK5LwYfJYRCWKBU
	l2zpmcxT1yfW8u13hTIgZPGqCA==
X-Google-Smtp-Source: AGHT+IHz/5foCKSm3S9RfxluGx4ispy4/FNi/RkKhEaxDVuTO2V4C8WM/HWqTc8S86iGy7YIhRyz7B1MEYUoV8eOsQA=
X-Received: by 2002:a05:6512:61b3:b0:55f:701f:933 with SMTP id
 2adb3069b0e04-5943d7dd53emr1995534e87.41.1762422797277; Thu, 06 Nov 2025
 01:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com> <CAMRc=McB4Zk8WuSPL=7+7kX4RJbdFBNReWZyiFnH8vfVx3DxAg@mail.gmail.com>
 <tc2r2mme4wtre7vb7xj22vz55pks4fbdabyl62mgutyhcjxnlx@qn4jvx3jqhie>
In-Reply-To: <tc2r2mme4wtre7vb7xj22vz55pks4fbdabyl62mgutyhcjxnlx@qn4jvx3jqhie>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Nov 2025 10:53:05 +0100
X-Gm-Features: AWmQ_blH3MiJVFlUuNcpfEa7K-SsRQSsEcKjg_SUhi3TbJQz3x1oYieu6QgbyHI
Message-ID: <CAMRc=McDYL_B+hFtLekevtB2XpUkaMN1dsDNeefvR+ppj4whFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:46=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Wed, Nov 05, 2025 at 05:21:46PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 5, 2025 at 10:17=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@oss.qualcomm.com> wrote:
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
> >
> > I'm assuming you followed some of the examples from the existing WCN
> > power sequencing driver. Not all of them are good or matching this
> > one, please see below.
> >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualc=
omm.com>
> > > ---
> > >  MAINTAINERS                               |   7 ++
> > >  drivers/power/sequencing/Kconfig          |   8 ++
> > >  drivers/power/sequencing/Makefile         |   1 +
> > >  drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++=
++++++++++
> > >  4 files changed, 154 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa377=
2a0c6802f99a98ac2de 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20474,6 +20474,13 @@ F:     Documentation/driver-api/pwrseq.rst
> > >  F:     drivers/power/sequencing/
> > >  F:     include/linux/pwrseq/
> > >
> > > +PCIE M.2 POWER SEQUENCING
> > > +M:     Manivannan Sadhasivam <mani@kernel.org>
> > > +L:     linux-pci@vger.kernel.org
> > > +S:     Maintained
> > > +F:     Documentation/devicetree/bindings/connector/pcie-m2-m-connect=
or.yaml
> > > +F:     drivers/power/sequencing/pwrseq-pcie-m2.c
> > > +
> > >  POWER STATE COORDINATION INTERFACE (PSCI)
> > >  M:     Mark Rutland <mark.rutland@arm.com>
> > >  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequenc=
ing/Kconfig
> > > index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3c=
d0c07db34c82f9f1e31 100644
> > > --- a/drivers/power/sequencing/Kconfig
> > > +++ b/drivers/power/sequencing/Kconfig
> > > @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
> > >           GPU. This driver handles the complex clock and reset sequen=
ce
> > >           required to power on the Imagination BXM GPU on this platfo=
rm.
> > >
> > > +config POWER_SEQUENCING_PCIE_M2
> > > +       tristate "PCIe M.2 connector power sequencing driver"
> > > +       depends on OF || COMPILE_TEST
> >
> > The OF dependency in the WCN driver is there because we're doing some
> > phandle parsing and inspecting the parent-child relationships of the
> > associated nodes. It doesn't look like you need it here. On the other
> > hand, if you add more logic to the match() callback, this may come
> > into play.
> >
>
> For sure the driver will build fine for !CONFIG_OF, but it is not going t=
o work.
> And for the build coverage, COMPILE_TEST is already present. Maybe I was =
wrong
> to enforce functional dependency in Kconfig.
>

Given what you said below for the regulator API, let's keep it as is.

> > > +
> > > +static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
> > > +                                struct device *dev)
> > > +{
> > > +       return PWRSEQ_MATCH_OK;
> >
> > Eek! That will match any device we check. I'm not sure this is what
> > you want. Looking at the binding example, I assume struct device *
> > here will be the endpoint? If so, you should resolve it and confirm
> > it's the one referenced from the connector node.
> >
>
> I was expecting this question, so returned PWRSEQ_MATCH_OK on purpose. I =
feel it
> is redundant to have match callback that just does link resolution and ma=
tches
> the of_node of the caller. Can't we have a default match callback that do=
es just
> this?
>

To be clear: the above is certainly wrong. Any power sequencing
consumer would match against this device.

To answer your question: sure, there is nothing wrong with having a
default match callback but first: I'd like to see more than one user
before we generalize it, and second: it still needs some logic. What
is the relationship between the firmware nodes of dev and pwrseq here
exactly?

> > > +       if (!ctx->pdata)
> > > +               return dev_err_probe(dev, -ENODEV,
> > > +                                    "Failed to obtain platform data\=
n");
> > > +
> > > +       ret =3D of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx=
->regs);
> >
> > Same here, you already have the device, no need to get the regulators
> > through the OF node. Just use devm_regulator_bulk_get()
> >
>
> I used it on purpose. This is the only regulator API that just gets all
> regulators defined in the devicetree node without complaining. Here, 3.3v=
 is
> mandatory and 1.8v is optional. There could be other supplies in the futu=
re and
> I do not want to hardcode the supply names in the driver. IMO, the driver=
 should
> trust devicetree to supply enough supplies and it should just consume the=
m
> instead of doing validation. I proposed to add a devm_ variant for this, =
but
> Mark was against that idea.
>

What was the reason for being against it? Anyway: in that case, would
you mind adding a comment containing what you wrote here so that
people don't mindlessly try convert it to the regular variant in the
future?

Bart

