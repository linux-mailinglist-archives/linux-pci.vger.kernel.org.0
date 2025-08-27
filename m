Return-Path: <linux-pci+bounces-34905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDEBB37F6F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3942F204F7B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505763126C7;
	Wed, 27 Aug 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjHORgGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1A2FA0F2;
	Wed, 27 Aug 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288795; cv=none; b=C9dPo+EA2STmSmtsZSlBw2vqTwYd9RzvL5C6JNyib0sOnlNSorB1Oahg7L1zamu6DxL/F9hXqd8RJP3c8c864Pu3AeFdb+uPjcTkgFIu2Z3HSAdV9aOhNMM5Svy8m6lt81cap19zyqxVPwcImsEoPPwiZgNoOVb8NfL2bRWbECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288795; c=relaxed/simple;
	bh=HO+wVcG+k0tLmm7J3j7XWsC1MHeaTAOdGMMxm4TQ9js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFu2iR6ghWXCv0o7Avldi+99lLe2r+qXcv1ZoOAmFepwE+8s3LppoihH3Bt72L1G0r6NcnKA+Iy2qj6XqXMX9+HtaGpyer5+ZG9l0Jbm8TRlTFiwuZ2SBO2BA2whzqpqdJlxtjgdXhmbzOVQHCweKPXpnPtDbBPOabmXXMNjEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjHORgGz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso9863881a12.1;
        Wed, 27 Aug 2025 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756288792; x=1756893592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fxBxr3hHJjyLt2bIRYFFQXgXRmE5FqrhXrL9E/WXTgg=;
        b=KjHORgGzOdMaEBx5yFsK3h6NHgvq/IHHmgQ3yHdoVem/mJX4ra3KYpjJ2JBOstgVEW
         LxSrjq9MYS6xc/ZPk2QIcw/T9SWYKpxyHFQVbvpB9yRRL05YF0864c0Ad4gZ1Jt8mwPa
         wemOpI4gkgdlQxvV7PFyWxMd+Bmp4OwQRrfmkjzZBm1aGXDXDDOiDrnO4T7ZSOEe+H26
         rA9bJ6Ti8BKd9hrPkDJNWKZ62CnZkA6bzJQft/gxJun7c5RjlAZOq6mQ7vJK8PsdEmoC
         aH5WwrBMv824GsOspMzQ16zrZUeKfuwFaPmyIDDVeWKwUHxxlMA8wgeioYKRp8AdzzSL
         93rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756288792; x=1756893592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxBxr3hHJjyLt2bIRYFFQXgXRmE5FqrhXrL9E/WXTgg=;
        b=YN8yX9imynjB6OjDn6fY7cpv84tUfkDvU8jxlzysZRLRW1T7crMtM8UW6OZL2duOJj
         YE4H3k87fnY3FDJwETMXUQGWKIx0UaK6uGs42Fh0CthTBayTenHF11opL5myTvoMYU84
         Ws07E96eowJqeS2ffTusA3wS27LqoEBdpNuoHm76EPBlEgGgFEKDbtjaSQedKZ3QaBnK
         OxBMzVFGAEf7tI3o4gU2iUhZSvRqZrT3cIvx92xpo8TnfRt5Qb6qfO0/9wss7GSFdJEj
         iMH2JeLGCOUru5nKYBTBcOnYT9J/jo/um6C7eeJFKdVaVn/fJY5oSNUSl7Ycy2pISoZx
         zMQw==
X-Forwarded-Encrypted: i=1; AJvYcCVnUcsmar7RNtj+D14IBQamrNUIr/GNfyR5lUQqOCvy4tpZ+ZnNR4zY65Zzpl5GwOyuYXHqDRRKcBXC@vger.kernel.org, AJvYcCX5pdiQ7vDRfc8atSoAjvA1nS6U2Gvg6H2dMP7am9jck2KqKNovN6ZzTo9oDDWWlFVZpPKOEZdjacyoUYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNq32ycck2oLQ7RPO6OrX37HSu2gjp+7sYz6ptWUwGCWcH7Fgu
	r8u+HyikCMPmvRfBbCIhFUweRDfdw/XxpabatUjwwuSankorabiqGT1QiwIMwh2n9ARMsL1391e
	X9g1RshhZaj5GloCUMR6RFHWltt6ydV30ew==
X-Gm-Gg: ASbGnctcJwmL+3zqICJyeGJoh/LJ2/oSKTVjVN8LN2Nt8z62h6Y53S4pVdx/x3MpQ8J
	lOHgDa+kjJlLEv3T07pCjP3ZCAcPprDmt8ClDnk76NArIiyJNzc8MAZYvjflUtulaLUQfxZpBqu
	u2cP5BFc/5XpDSOf/efX8xqlZ8Ebfi8WiBLdwqSg7hqG0O1WGI8fGyQTybQRqCn1v+X8FBb1Ptx
	oFa/w==
X-Google-Smtp-Source: AGHT+IFY/2chlF/m6PUeu4B6up9HulLe6mC/2JW2ndlbEfDVY0aAkEIK5MXPDQyR2jq35vLhk4+OXMYlVusIeHqMrzg=
X-Received: by 2002:a05:6402:3508:b0:61c:bfa7:632 with SMTP id
 4fb4d7f45d1cf-61cbfa70734mr70674a12.34.1756288791649; Wed, 27 Aug 2025
 02:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAwSgTLS+fNTUrx4F5G_5BrFwoq9vixDAFervqokDgJxPhP2Q@mail.gmail.com>
 <20250826190255.GA851588@bhelgaas>
In-Reply-To: <20250826190255.GA851588@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 27 Aug 2025 15:29:35 +0530
X-Gm-Features: Ac12FXxHQksPZAjPmUKDEWp9ugmJhTkMsyE6LOtd45gPiiouMs7xERQOjaACBlw
Message-ID: <CANAwSgRHrzHeWeS777SHBz9LQB+xxyX4TToWwp-qKHamzaxPww@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: histb: Simplify clock handling by using
 clk_bulk*() functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Wed, 27 Aug 2025 at 00:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 26, 2025 at 11:32:34PM +0530, Anand Moon wrote:
> > Hi Bjorn,
> >
> > Thanks for your review comments.
> > On Tue, 26 Aug 2025 at 21:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > In subject, remove "dwc: " to follow historical convention.  (See
> > > "git log --oneline")
> > >
> > Ok I will keep it as per the git history.
> >
> > > On Tue, Aug 26, 2025 at 05:12:40PM +0530, Anand Moon wrote:
> > > > Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> > > > the clocks individually thereby making the driver complex to read.
> > > >
> > > > The driver can be simplified by using the clk_bulk*() APIs.
> > > >
> > > > Use:
> > > >   - devm_clk_bulk_get_all() API to acquire all the clocks
> > > >   - clk_bulk_prepare_enable() to prepare/enable clocks
> > > >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
> > >
> > > I assume this means the order in which we prepare/enable and
> > > disable/unprepare will now depend on the order the clocks appear in
> > > the device tree instead of the order in the code?  If so, please
> > > mention that here and verify that all upstream device trees have the
> > > correct order.
> > >
> > Following is the order in the device tree
> >
> >        clocks = <&crg HISTB_PCIE_AUX_CLK>,
> >                                  <&crg HISTB_PCIE_PIPE_CLK>,
> >                                  <&crg HISTB_PCIE_SYS_CLK>,
> >                                  <&crg HISTB_PCIE_BUS_CLK>;
> >                         clock-names = "aux", "pipe", "sys", "bus";
>
> The current order in the code is:
>
>   histb_pcie_host_enable
>     clk_prepare_enable(hipcie->bus_clk);
>     clk_prepare_enable(hipcie->sys_clk);
>     clk_prepare_enable(hipcie->pipe_clk);
>     clk_prepare_enable(hipcie->aux_clk);
>
>   histb_pcie_host_disable
>     clk_disable_unprepare(hipcie->aux_clk);
>     clk_disable_unprepare(hipcie->pipe_clk);
>     clk_disable_unprepare(hipcie->sys_clk);
>     clk_disable_unprepare(hipcie->bus_clk);
>
> After this patch, it looks like we'll have:
>
>   histb_pcie_host_enable
>     clk_bulk_prepare_enable
>       aux
>       pipe
>       sys
>       bus
>
>   histb_pcie_host_disable
>     clk_bulk_disable_unprepare
>       bus
>       sys
>       pipe
>       aux
>
> So it looks like this patch will reverse the ordering both for
> enabling and disabling, right?  I'm totally fine with this as long as
> it works.
>
Thank you for the input. Let's wait for additional feedback regarding
the changes.
> Bjorn
Thanks
-Anand

