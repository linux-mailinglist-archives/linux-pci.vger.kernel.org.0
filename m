Return-Path: <linux-pci+bounces-42470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23344C9B054
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12FDB34273B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F81A30C62A;
	Tue,  2 Dec 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7MXT2Ni"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53225785E
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669802; cv=none; b=A9FvjEgrlNlIRQoQWguX5RWR7r2Mlcqzw3jN2DJUumVHgV6/n4pMxUDiDjMnkhSwfKfU2PO/Z0AAvZx04GH9/sySbpUOxyJEd3Eyyhg6ljGVq8RwB2vS34qX6vQHeRxuC1q7hHEVILILBQzJnlJ3JWW1AEqdaFBXURs+GrSu0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669802; c=relaxed/simple;
	bh=slDn459xGIAqDEFTR+AjwfkF1R8D3PspK/nTzIs6OrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFLitZi4IUpJjtjsKHrCMzXqGCWBkeswpjnzL/z5m9EOPhmYaW2AVhGgQBg9261ghYObRwf+Y37Wjrz8ZVLTM3wUNA+pnqLiX0H9Tb3hOINuWz3v0l1AMpzDVRpcRetenwHk0wOnPPnt0E3K0FPBxXf3w7fSn/RvXn79z6TpL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7MXT2Ni; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2328579a12.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 02:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764669798; x=1765274598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slDn459xGIAqDEFTR+AjwfkF1R8D3PspK/nTzIs6OrY=;
        b=T7MXT2Ni0zgMmXGrbRZs6omdOidelpLdYINjL8dWka5xCXF60zUcygqEImUueSi4NE
         r0zImGEMLG5dE/s4n11AR8CD0FEWPe7ArzZIXU5kHjq7Eucoqej8XYevY92lBHcKy5xe
         UykBrFuAD8mXQbaBPJkoi7vE6QiVo3DMuY1ZZE2+oWuR+jbXSQ58N+K9U5tOzQxUQyZA
         YVuFDm3jTnl70eGPXGSKt55ICPSGeYCvB/mH1R0QrBQafCMGT4Jd7lYQUuJOewu7aiyJ
         6FdmA889LnoS5HGNyrY0rXhvxJ9jUG0yLwHfazvSfr2aqN61d2pw3XR3WYPTMTIVQA+F
         v3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669798; x=1765274598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slDn459xGIAqDEFTR+AjwfkF1R8D3PspK/nTzIs6OrY=;
        b=kh6CG5pt2oa67HNQOq2UrtieVqBC0hE3R+gIz+sZ4bfwYPR7nG5cNYoPYaUqETkzUQ
         QbtYFa7L4PO4xxVj7DyW7/hfNq8xuBqTT4TTYKLpR8WnQLHJz26PBSNxHeocqzvXdQMi
         1FPzMcK1B2gbzjJReeRgSwc08OIVIf6rtwKeoom8lKGxgzV4dY6DY0xuVtM4A195TVyO
         E5+5uSsxOMZSuWlE7b809FYU7IZqib77i3X53hx/I7Cys4ATDTTTWbEPJ4vY6Yky5F4j
         iP0olt74F5rMwA8SBewvub6Lpx43rYRimzPQ0UZEWBzqztDG4PeQLf7/WnMAAWYq3jo2
         FQVg==
X-Forwarded-Encrypted: i=1; AJvYcCWYVESeAdy8hnyCGuPNZij5fEt/tCIzDSQGzrrmKe+LhE43a1ByOu1YC7DSI2fH6KudBoKo4yK9f7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hTvqEP5qjRU++QUHF0eFbYZ8jqcXw7cF5+wRulxFDqc1H0yo
	fyfc9r7+BD/cDwpfqHangiiTqed4cbo39vQLCGX3H0TiIsbZMkAbfA9AGhqENVqpUkJcZUG9F64
	5uCtlIEnUwuJyDOSdSBv8r+UhwRPC7U/1NuJnbP1DCQ==
X-Gm-Gg: ASbGncvXYozlDq2SRiakt93Ef94CiWzLuE601+Pn6444tuCT3mnH4/ftK3kw4TfyJzC
	PbJ3/bJ6JNmEGI9/boECp+6GEYexHoEluLSGhsjEF2hYU9BQ75LNQwtbMzfaqVSAlJMFfJJyMXx
	PZ2dlmQb+Ll9xUJ8wB/2MT/9s/WTtYA6CrkYpyl1LI6bnFzmOuuN2edIYxUtye9d3WLNRXnxmXP
	J2lUWcf/vp5Yiw2kkTJuQtIcXloqxrWQKnnwDreSvOnCOuhzVUQiFuOFvcXDX648dBaX9hqCF6T
	t5aCHGKAeMuCLquTtN2SxWg=
X-Google-Smtp-Source: AGHT+IEzBZUvVe8v+NU3LgQcNDFZ1ywLGlvr4nq6P74LNME9ZQgiTo5FgVQnVsGl1RzS2H+nuAAtY4Diulatz7/9lxo=
X-Received: by 2002:a05:6402:1ed5:b0:641:3651:7107 with SMTP id
 4fb4d7f45d1cf-645eb23bc16mr27607615a12.12.1764669798505; Tue, 02 Dec 2025
 02:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128162928.36eec2d6@canb.auug.org.au> <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
 <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
 <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com> <vb6pcyaue6pqpx626ytfr2aif4luypopywqoazjsvy4crh6zic@gfv75ar7musy>
In-Reply-To: <vb6pcyaue6pqpx626ytfr2aif4luypopywqoazjsvy4crh6zic@gfv75ar7musy>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 2 Dec 2025 11:03:07 +0100
X-Gm-Features: AWmQ_bnvt_8myvimspzAlsv7ON2LSirITDuqDAMojw-oVlxKenWaOKPgLgNEaRI
Message-ID: <CAKfTPtCKmj_dHGU-2WPsEevf7CR-isRiyM0+oftCrMy5MswE4A@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 28 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Dec 2025 at 10:53, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Tue, Dec 02, 2025 at 09:54:24AM +0100, Vincent Guittot wrote:
> > On Tue, 2 Dec 2025 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
> > >
> > > + Vincent
> >
> > Thanks for looping me in.
> > >
> > > On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> > > >
> > > >
> > > > On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > >
> > > > > Changes since 20251127:
> > > > >
> > > >
> > > > on i386 (allmodconfig):
> > > >
> > > > WARNING: modpost: vmlinux: section mismatch in reference: s32g_init=
_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: =
.init.text)
> >
> > Are there details to reproduce the warning ? I don't have such warning
> > when compiling allmodconfig locally
> >
> > s32 pcie can only be built in but I may have to use
> > builtin_platform_driver_probe() instead of builtin_platform_driver()
> >
>
> The is due to calling a function belonging to the __init section from non=
-init
> function. Ideally, functions prefixed with __init like memblock_start_of_=
DRAM()
> should be called from the module init functions.
>
> One way to fix would be to call memblock_start_of_DRAM() in probe(), and
> annotate probe() with __init. Since there is no remove, you could use
> builtin_platform_driver_probe().
>
> This also makes me wonder if we really should be using memblock_start_of_=
DRAM()
> in the driver. I know that this was suggested to you during reviews, but =
I would
> prefer to avoid it, especially due to this being the __init function.

yeah, I suppose I can directly define the value in the driver has
there is only one memory config for now anyway

/* Boundary between peripheral space and physical memory space */
#define S32G_MEMORY_BOUNDARY_ADDR 0x80000000

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

