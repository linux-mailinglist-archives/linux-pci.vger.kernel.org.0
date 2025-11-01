Return-Path: <linux-pci+bounces-40009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53CC27C0F
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 11:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 083DE34A954
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A82D29CA;
	Sat,  1 Nov 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NThrswy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF544283FDB
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994095; cv=none; b=t4pStzxyafQIK6GWW5QdqWb9V8YcHsBH2AAITUqHvOn6B6EpeOb1r9xn/a36VTojB6aVg/i6BISrpbnQdJM8DqPFdqC9mz7Bxrf77zWInp8pT2RuuX7JTbduja206v6WlsTdYHzrWN9fGl26jL46MUyMlEht1SR3//GUVTu7EMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994095; c=relaxed/simple;
	bh=xzez+fchR72BquI7aMREthZ1SO2DLRmUDjwIbYO9kQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQbBZte1nKMvkilxCuTO6esnS8eerAjHPNC2TpRmJm2hSQmGSvcvgD+/H9u5pSGdWHG1LVmCZtZHrCt590u9cXu4wPcw+miYDpyHhhfhJUx2RQSWf1yoeqvSSYxQmlUD9c3Qr/Rj3Dp2mzFwDbE0G+u9IL+5kWlv2/3dXbbbpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NThrswy+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so5733866a12.3
        for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994092; x=1762598892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtLoHp0kEwq/bLHJArViyfu5fWlEi0xAxEhFmz0T09k=;
        b=NThrswy+wIz3JR7dQ5EI4mUVdOoPoo7rRLQmZFYXp9D61b76y1jc9YMpolQvR0cB7u
         7dEQjKatmW4Dz3Tfe8ph24F8+VSygQbmHudW0fZfgbOXQBBpAq87KrkwZvYq1xuat0jQ
         7Jt+85YH3Xg9e0yadg1XooRtdSzL6p8Q/mxLsMERxVV2lZXPAC1XsFh6sWREuqJG+287
         cVn18acrECtn2dLiBKobGs/79ppMQuKk4huK2SWIioIRdRA8NCBE/mPveeZlD5XayTwW
         g1SNRTeBbKN5AhGllbBxw9SOexE/rGtUagiim9EjMNitxXKK0uv2PZwBUsCB/5raYraI
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994092; x=1762598892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtLoHp0kEwq/bLHJArViyfu5fWlEi0xAxEhFmz0T09k=;
        b=n4rp0Nu0v+rEKu58G5hJ/wtr4JAe/qVf4b7E7mBPY4/vj0XMHyQQpSoVX1Azo6hi15
         IiolyWxubCjUirzxkDGfwh2Gc5cUzPofpsxnJrk6XkSokqzIU08xkxkLiHAwOMuor+Z/
         euOjwr7uUByvwc26nS75xgsNZqdRAkCkOBV3fPVe2gz4ABem8IB/HQ6TJ5QV5AujhdOP
         iRxO0qaRpPiUQlb2XxKr0mM/J0y/t8lUh6V9dWz/ESDeC8eyLxQzQngpc2wFVZxJl/Nc
         qHJ61kV8ck9VGDK0eUP4sxeoFf8GwawrvDtil69fUntBKpHfRh+sozURZg9EtcFDqzGl
         JChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAWLpXP1xpRhq3frz8FoodzzGOE/ghJ2vcrCtplAm4IYpuBwEe+UzQdOTDGfDD6yZMsSZ8mMNtYNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstVZ/um+YA6QsTotKmnnxPcGb4Oj9/rjtwdIDuX7pd2VIvKto
	NliWDt50LvmtS7wYAo1NGWmScPYlqhbOQNFcCxsVSwCdojUXeyqfPvDFpEEF6tAJZkegPnJ2n5d
	yxrHwo4l+qJEkH9LyMtLPJiDFDN9QTnB/VTVV
X-Gm-Gg: ASbGnctYGipaslFtK5FsYPvC4MELkx0c6wDxSMWwv6OJRf9tbHQXKXq9we5BLof1ikL
	inJ+xNxx+4x5HlmPTC1wNHefjOOncz2W5c9SUQ96bru5jwibCOU3YrmDF+7QYELCnfjhZXPtXPz
	RDbshZ6WC928U3ckLqqNL8c8Q3/34GYaVUbsD4OJY9tsU4XbjQUr8lu61BqAZdFo64MKIPUYb+x
	ELaiGIciyPeee6UNTIYgTbD7L0XugTx+iekmWcGkgIUi6DaAMF8+kgj4WeAcMZWzo2XNA==
X-Google-Smtp-Source: AGHT+IEwEAbpzczbirHeYPq9CirAqArt7tfqx1f1DuepotXx+VdlfMQPQPP7/cGb1j0Z5jLq9Qc9/0ubBl45KkLxH90=
X-Received: by 2002:a05:6402:518b:b0:639:dd3f:f265 with SMTP id
 4fb4d7f45d1cf-640771ceb67mr5718247a12.25.1761994091667; Sat, 01 Nov 2025
 03:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905112736.6401-1-linux.amoon@gmail.com> <176085588758.11569.7678087221969106036.b4-ty@kernel.org>
 <CANAwSgRjXS4V_Kpw5kaJnPA8f=18uN-MgfEQ5ErN3aFRqbJKfg@mail.gmail.com>
In-Reply-To: <CANAwSgRjXS4V_Kpw5kaJnPA8f=18uN-MgfEQ5ErN3aFRqbJKfg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Nov 2025 16:17:54 +0530
X-Gm-Features: AWmQ_bmhgMeWFkOeYmBpsEodWI1g24fEo-iGnLSXhllxCODvU7vKr_LfOJBB0YE
Message-ID: <CANAwSgSrisWFPPRkZ=ukCjui3_xzgrmLKz5F9iXnerUFktk5UA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan,

On Fri, 31 Oct 2025 at 12:27, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Manivannan,
>
> On Sun, 19 Oct 2025 at 12:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> >
> > On Fri, 05 Sep 2025 16:57:25 +0530, Anand Moon wrote:
> > > Replace manual get/enable logic with devm_regulator_get_enable_optional()
> > > to reduce boilerplate and improve error handling. This devm helper ensures
> > > the regulator is enabled during probe and automatically disabled on driver
> > > removal. Dropping the vpcie3v3 struct member eliminates redundant state
> > > tracking, resulting in cleaner and more maintainable code.
> > >
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
> >       commit: c930b10f17c03858cfe19b9873ba5240128b4d1b
> >
> I am looking to suspend or resume the issue. We probably need to
> toggle the regulator
> to maintain the power status on the PCIe controller.
> Therefore, dropping the patch is an option; I will add dev_err_probe
> for PHY later in the patch.
>
I found this series with the address system suspend support

[1] https://lore.kernel.org/linux-pci/20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com/

This patch will conflict with
[2] https://lore.kernel.org/linux-pci/20251029-rockchip-pcie-system-suspend-v4-3-ce2e1b0692d2@collabora.com/

So please drop my patch.

Thanks
-Anand

