Return-Path: <linux-pci+bounces-12681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34BD96A564
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA4CB21C69
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB118DF77;
	Tue,  3 Sep 2024 17:27:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AE18BC22;
	Tue,  3 Sep 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384425; cv=none; b=hon5wSXhC78SY9HZhDELXjJ+bNo97qCQO2zShR1vN+ubDgURePCQFY6Md8hBp3L/vkBPRxIZdousbBIuO4XVrJ87PTB7CEHdqzrVa48bTeitb+9aRns92Q13RdMi133AZzU+zcGyujdu6qqWK1oQY8+6zEEEGLXCTFnVR6pwp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384425; c=relaxed/simple;
	bh=8ZdETe01MiGFSirXtXpyRZv+12EZ41iU1Xl4Uoi73HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vElI5HVuATVeaVy63ygHALKhNiAwGAGUCT7IsGHyJaN5TdHzM+JfTOi9tOxmL03sRhywxKyYPkYVewf6Bk+0QdifSCL0hJP/VL9IEoTvasI/o4NDjlZeEnNpPZbihCnMMiarzh7MwI4PUU7QB1gjoHXO6r/rDl383Ygc1Le4oJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so4805325b3a.0;
        Tue, 03 Sep 2024 10:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384423; x=1725989223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK9LhMqmY8b61UhUQHd15GQzEH3KrI6nivBCkPiL/iI=;
        b=b6IZjbvCQ4L3xxRttiE3f+MZU12eG/fBhwU4yyFJdVeW7Ct7tqYLbwgRtfzqdOp0Ct
         1P+NIBrF6dUJbKT13E8ZT+T5Vm/BhP2Z53832QEnc23o0knLasFqZpU8ahiiLib4EU5B
         1xTgYaqViBu9dHGn0jVvzujflCNCtC6SUArYtSltdrTP/seGTxTINl3/yxqgLokTeAMj
         FMmLUXaz/2tlUjaBnr+jcWTSar5pbzzWoiugkDmNGuRnz2eoNYkYZeMU/HbhsFxLMjqc
         B959X+uVPZT91H/BU+6C1OGeNt4lr1i6Qmq1yhlsE3sdBVxpfjuz24+9P07n+OnNIsqv
         0SSw==
X-Forwarded-Encrypted: i=1; AJvYcCXF6uRhsX38ebAoUxZxVzh9b8XFMeIA9G63tHM+audn746zYG1ymbCjxR8eJ3CcU8UJcbnTLFgLaMp2@vger.kernel.org, AJvYcCXvab0rN2xIJRG3fH9743Afm3BAaukicl9VyvrOJsRuNioBbo6GHLI6S4wZ5cPvGv5V/d34bzw9nRz2kHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ExrMss9+7Q5F6f7LzCpq/6Ns3SQwZzT44DrWBXqYSsnTjIsU
	R0x21x1ML44nN9qtC7pTyNpBuV/PfyArvCkW+KRP61/K/ijIVfKX
X-Google-Smtp-Source: AGHT+IHVsC39zTt24vONpcuA61t0th3t0mAHpOCLQNJzp3nJKOCh5DdTR0XF+xGGOUw1xxX9Q+j28Q==
X-Received: by 2002:a05:6a00:a0d:b0:707:ffa4:de3f with SMTP id d2e1a72fcca58-7173b618a17mr15439542b3a.17.1725384423445;
        Tue, 03 Sep 2024 10:27:03 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b4db7sm114603b3a.207.2024.09.03.10.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:27:02 -0700 (PDT)
Date: Wed, 4 Sep 2024 02:27:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240903172701.GA2873479@rocinante>
References: <20240903144613.GC1403301@rocinante>
 <20240903171743.GA255170@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903171743.GA255170@bhelgaas>

Hello,

[...]
> > > > >  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> > > > >  {
> > > > > -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > > > -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > > > +     if (val)
> > > > > +             reset_control_assert(pcie->bridge_reset);
> > > > > +     else
> > > > > +             reset_control_deassert(pcie->bridge_reset);
> > > > >
> > > > > -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > > -     tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > > > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > > +     if (!pcie->bridge_reset) {
> > > > > +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > > > +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > > > +
> > > > > +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > > +             tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > > > +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > > +     }
> > > >
> > > > This pattern looks goofy:
> > > >
> > > >   reset_control_assert(pcie->bridge_reset);
> > > >   if (!pcie->bridge_reset) {
> > > >     ...
> > > >
> > > > If we're going to test pcie->bridge_reset at all, it should be first
> > > > so it's obvious what's going on and the reader doesn't have to go
> > > > verify that reset_control_assert() ignores and returns success for a
> > > > NULL pointer:
> > > >
> > > >   if (pcie->bridge_reset) {
> > > >     if (val)
> > > >       reset_control_assert(pcie->bridge_reset);
> > > >     else
> > > >       reset_control_deassert(pcie->bridge_reset);
> > > >
> > > >     return;
> > > >   }
> > > >
> > > >   u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > >   ...
> > > >
> > > Will do.
> > [...]
> > 
> > You will do what?  If you don't mind me asking.
> 
> Can you just do the rework on the branch, Krzysztof?  I think that
> will be easier/quicker than having Jim repost the entire series.

Will do. That was the idea, I believe.

	Krzysztof

