Return-Path: <linux-pci+bounces-42462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FDAC9AC2B
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 09:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C64B346B5F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1DF30748C;
	Tue,  2 Dec 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0jOyrLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB130648A
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665679; cv=none; b=cOTjzToFMfG8rPxytQnEqTiIoLtVtvr/Y74mS9oEy+4En9plOit82k8vGqJ9dsfpjo+ZoRAFFBIHaOu0GPXzGFo682oNwLQNjjr42W8slXpt1u3VFDPPBQTBUmkTra9IltB1Q2a4Z6W38KcmtxtJsUrWhWvoobFul5Z0anRsJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665679; c=relaxed/simple;
	bh=6M1ZL8AhCWhQ32NYFxLlrVbyh+vQ6L6egI6jqd0HlhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRlAbYMRVq12ST7ZDKuVAsr6UOZsxz+C+9tiCzjP8KQpTFVovEIhuVwJr/C2Kb+zEggHI7j4erlfnIrdPBf5sSxVjEsR9AYTMCQKqfy1ovFY6bABiKqIOk9kWYLqgeRzhqv3+CZZ90uKirFp1OACtXonVegTGmzhKjyDfsJZtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0jOyrLN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso8031863a12.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 00:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764665676; x=1765270476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M1ZL8AhCWhQ32NYFxLlrVbyh+vQ6L6egI6jqd0HlhA=;
        b=B0jOyrLNqaFHnNU4pS7oy47qxJx4+GyLQYGIV9448AJhc1FtLVZsPshvETCd0VlRun
         Z9uvYdJoPYK5RQ19YDwGbBm20hk5eyKmz/EcxMs9JXLEpPhe/wKynFppqSuAld2Yc16b
         7O/bF967a+ZFbSYCyisHh4JOyEM8XvVcR3q3McvUIcdrEJCMVAhdLwTeU3EI/Uh88HrS
         9BPuomae9omoccu08rvcOCsAMWpW+3RF7kAXGZ1mI6N//wU3SDgrpqDCQj90fhnnN4Gs
         L7+lGF0wDGMPK+0mzRRLaYo0FgwmHa5NUVEi//eJKrMvnagJUlBjuLZ/25+vpLpAXlty
         VH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764665676; x=1765270476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6M1ZL8AhCWhQ32NYFxLlrVbyh+vQ6L6egI6jqd0HlhA=;
        b=LK+UJeDvdRlSfsy+mer3qEvCg7JrHqh8PueuiuVWXCG21RZDId8GPYFNMsI8QjbyyR
         rAY+aOIBvngcic5DsS4CsxlmjNiR1ylmhGmxIDi1PnT3JrgGIxwSmFN30uvzQSK7Dsc5
         M5LUjoapAqx22gGruecLYdaZnOF+lg1ije3WZLh8mL6Tdc3nqfJZkvczh+ts+6YeVZDm
         h/P/YFZnCZxG9wTrxHPtFyeNk6yYhW4Y3O/2Gj0Si221E9tzGzxPuYTJ/UU8WMNe1dVZ
         WnlCtDO7Y6c2wMBeCK3k5fOtp22G6qBcBno6k0e3eUIWt1HlLepH3Aqo6CuVfGNheDOR
         D9GA==
X-Forwarded-Encrypted: i=1; AJvYcCVGSXy6n2QPo3J2YgeCawgCLXFopDuCrFcBxaTLYm/qmkRzmtpG8CRJQt8IsrVDLPxikXUmZuHRpRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrHKgjXmHFtJ3DgXLaxoyuQDt0ExwSLnlnu4DBJGf8y9upUc5
	DphhZisZb0pGAY57X80nWgWDIbr3qV7oUgPGbJqpBli3ETB322ScaHMLVPUlgLsrdAoVF9WOA+o
	IWlt1irCk7MBzcpuBxlf7vwTPnmX89rXjzjgGoh94kZmk5LhNKe1ip3M=
X-Gm-Gg: ASbGnctDXSAX5SAhdcm6RKg9mz1qbL+BOUlMvN7wXtslL6i6ms2RUjS2T8UStdB6bf0
	rpTTWVci+Ind3SRyEwBuc8LIEOeePvJsTCs58wAoGp/gfX9NkSIMR0lA+Dztn5/igmSoo6D8Ixc
	4kdT9ghmkeuAOekGFy+GQ70DcT0T8gknsKWQ7GsvJHFoIW+Ucgd8U+h1B1CiANTWc5gRoYCcEWh
	/iNVlznbHDcP2oC2rPLH24tqdtxxViq4EVopR6dWnWuRjzfd9hQgseaaNA5twYnmNK+5PNYFVsE
	NZNQG7kkzRlw1mKu1RihjkU=
X-Google-Smtp-Source: AGHT+IGWnwcbDjhWT0x9H7sIzIa+WZkvafF3BehhPLR1uxm6/AMNVV3pUklD/QKk8hx3Gw45sSksLu6R8c7rGcUXEQo=
X-Received: by 2002:a05:6402:5113:b0:640:980c:a952 with SMTP id
 4fb4d7f45d1cf-645eb228d07mr27645261a12.11.1764665675613; Tue, 02 Dec 2025
 00:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128162928.36eec2d6@canb.auug.org.au> <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
 <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
In-Reply-To: <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 2 Dec 2025 09:54:24 +0100
X-Gm-Features: AWmQ_bkF5XtGr8F9ahjDdeghwGPaVkXlZCwEv85iEB2fw7LzWAo9ryRojtgxNZU
Message-ID: <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 28 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
To: Manivannan Sadhasivam <mani@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Dec 2025 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> + Vincent

Thanks for looping me in.
>
> On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> >
> >
> > On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20251127:
> > >
> >
> > on i386 (allmodconfig):
> >
> > WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pci=
e_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .ini=
t.text)

Are there details to reproduce the warning ? I don't have such warning
when compiling allmodconfig locally

s32 pcie can only be built in but I may have to use
builtin_platform_driver_probe() instead of builtin_platform_driver()

> >
> >
> > --
> > ~Randy
> >
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

