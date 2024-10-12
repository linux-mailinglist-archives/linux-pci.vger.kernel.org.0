Return-Path: <linux-pci+bounces-14379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC899B2CB
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855CFB22BD8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5E14F9CC;
	Sat, 12 Oct 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSNyUMPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C51422C7;
	Sat, 12 Oct 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727496; cv=none; b=UDDh4dhwpL5kvqmJ1krgInnTcUWSHs4CuDMJVIwDhkCqGbSTa88QfDNXGHFV835aif+V2Oek4S4erjM9MuXMe3N6yWSaiOUfgz2QdT6hZNyGNtrp8F3Aftgp0ZOME4EXYniNLOG0chaHH4M3pxR6k9b+RUwskKZp/oOZocHbn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727496; c=relaxed/simple;
	bh=gO4kjj+gL6Indly0NQhATno213Dzkmc07GqZgCf6Kto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBD3Z+Q11wIHvAVSFhyVNTFt/dCNB+cS1GyXu4ghJalGq++gsVaHNRzPap0l29J/FSFeLzd6Nx82KlnVr0YwSxPPShY+1gclpnf8DzFu/HxSdeZfgG26c7ZgHJ2tka7jo7bMwDb6pT+0XGvIq7d8sfdqnbRhYOhfB4sPQGRZGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSNyUMPh; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-260e6298635so1614105fac.1;
        Sat, 12 Oct 2024 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728727494; x=1729332294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO4kjj+gL6Indly0NQhATno213Dzkmc07GqZgCf6Kto=;
        b=SSNyUMPhc6YDCqyqNuZP3oRDcT7Lve9SN43e2/76lBmt5+kKPqu28IM2gfruoQOScD
         T6SjH3QJdyVFe91LPPnb03hanoWHf8z+GfiJPHGb/53KwssVSzeQQbb3ocnwNyW8tJgw
         qqQrmB+4ascNhWgTpJwS+kRcdtP00lXJ0bp6eHExLOBvh8t7kOHGmIngYY0hw+vzXpnF
         yba/SzRsLdXHwsnq0Hb3K3HNsmEp91B2Q7xSiGJXhxXb+dBZdU/6ooYvnS8hfwKQtIwq
         FSOMGpEBVK/zAphfeDTLAsqR2UUotU24WcFdp/jUlgx60cxwC0mZEIIwzZgKd5M89qgR
         l2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727494; x=1729332294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO4kjj+gL6Indly0NQhATno213Dzkmc07GqZgCf6Kto=;
        b=Z3Vji9ro4hooPvccm/RNQOPXu8d+dVegz3Ava3eBNYQ6dscFXkLHoVHd0z1ri+tUuj
         xJ8Nm3h0zDA3paD4bCjWcmRY/yvGlS7iltG5HrxqwI5Scfew0rj1UY+1Qek7FpcRE1az
         554uxej2NRmMiYKEoYrYay7eQ5mtCYTx9/6mxAZxWqecQTPcK9sVpcPhvp6p9JkJighm
         VC1u/K4TlIzfKoKFManby+LOsr45G+VSPtnLKKvPmVnWlRG4SRDRh0AsvFkP4UfZXc+b
         Krvaax5Jlrp3IjO9ZoCWjrn9eD8g+Kdb1izNn79WiSFbJgOjx5HVbmX/+tqKCG5bFVVG
         UeGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdnCnlZD9k1dE0hA/m9jwBPeujpEB1nYKlz+08Qj0wlK+ySK2FtJ7nhq3tDTr0oBlIcyuDgyz0BrrluR0=@vger.kernel.org, AJvYcCWk/MKKMvuL67qeVCMwDXqI7Fn54Cb/qClbzO/q5qN59/7AAW5zY2yLo1qx1EKtOCSmt/w5iIIFoTDq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8umtXhsowc7xYaK35tgLffVz32Bm/GNdjaaJz7mljJ/+a0Me
	/dmEFaJbDG0wwcV+CgEeUgpRKNnYYMgsKq+PtJNGXJi2tWQcCM0bOtcJsoKPyvN77QpmODm7MkU
	4nlqhVJJiELWxQDtxvXt3N7nRdc0=
X-Google-Smtp-Source: AGHT+IE7W0pbRF971bx8pW3JLSkhmzMUxOjnWJVV7TQD/4voz8E00YBsFMzM60SCIby1MmjtiQEG9O2RHkAv0Q1EHpg=
X-Received: by 2002:a05:6870:4154:b0:277:f713:c101 with SMTP id
 586e51a60fabf-2886d7f7e17mr3005473fac.15.1728727494118; Sat, 12 Oct 2024
 03:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012050611.1908-1-linux.amoon@gmail.com> <20241012050611.1908-4-linux.amoon@gmail.com>
 <20241012062033.2w7jbfiptvdlklzl@thinkpad> <CANAwSgS68sL2JE5wafq98gFV-jhWFx5594Ax6+aVW8mpiBgHnQ@mail.gmail.com>
 <20241012080213.rxllcpofy2at5vnz@thinkpad>
In-Reply-To: <20241012080213.rxllcpofy2at5vnz@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 12 Oct 2024 15:34:38 +0530
Message-ID: <CANAwSgTFXso_1vhWSmKdHq_vjithFuTK-3TKV2uBKbdT7QVbZw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks()
 function signature
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Sat, 12 Oct 2024 at 13:32, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Oct 12, 2024 at 12:55:38PM +0530, Anand Moon wrote:
> > Hi Manivannan,
> >
> > Thanks for your review comments.
> >
> > On Sat, 12 Oct 2024 at 11:50, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Sat, Oct 12, 2024 at 10:36:05AM +0530, Anand Moon wrote:
> > > > Refactor the rockchip_pcie_disable_clocks function to accept a
> > > > struct rockchip_pcie pointer instead of a void pointer. This change
> > > > improves type safety and code readability by explicitly specifying
> > > > the expected data type.
> > > >
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v7: None
> > > > v6: Fix the subject, add the missing () in the function name.
> > >
> > > Did you remove it in v7? Please don't do that, it just increases the =
burden on
> > > reviewers.
> > >
> > > - Mani
> > Earlier, it was reported that function () should be used in the functio=
n name.
>
> Hmm. Why can't you do the same for the description also?
>
Ok, I missed this point.
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks

-Anand

