Return-Path: <linux-pci+bounces-42472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3133C9B200
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 11:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E24E29BB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E530F93A;
	Tue,  2 Dec 2025 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGtwm/Og"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075E30F819
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671109; cv=none; b=PChnX1/ET0DU+rppdL6LvsU2iXnJmM9SDMho4yhLl2H05YeIZ7KjmPM8IeImOx1FSGopML+aFtqjInHLRAsJToAKY9LDTACY5QE9BWdeQvLOqoRgL+IJdI0KwP88Nk6ajH2bKrnrUAfLNp5DAHjZ5VxTSEd5YsJcx5MbgU6A0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671109; c=relaxed/simple;
	bh=pSvE4AT6OXFfClpNe9rSToN+KDDOheGQkgrzpcEFf7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx0kWW4FzLJ4zw2x5KVytgFTdMcqNpDFUPEtXj1mJcITLbF7z2B8SBFQeuf5XE1omJT9JYUOE2Z95g6FSBifQNNela12aimZRp3HkA0Sju3ABuDNO3kTLxByYhgFM5o3tAA0pVPhpNzq8kH0aAgZifR2KL6DWE6gE9Pmmq3bA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGtwm/Og; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72bf7e703fso888187566b.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764671105; x=1765275905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F+kG2WqkAYgELZzGbRFHTmjlUcifa4ki8f7o3ssRY8=;
        b=qGtwm/OgrkdvcIQOmHBHVt4VySZSJ5+sedIqP5+DUw/70d8Y2TY9/GEW9o1VRKJ3At
         pI0oOlMlYdDt4m52Zo1sUCSHPoBihyamvNzYNGTckQn2Z23m48mdnYe2izFZE1NJh9AX
         tMsJouGXKvckqu1w5byw+I8AJBnRGDL7M1Hn0wkQs+ZiECvDe+AZKXeiYPSKivAcLLRx
         7/3oJLmYjpNJLFskFxRWYuXSwO4NsZB0D3OhxjacioZGhnXTQKAJdlolg+ye6D1yLt47
         LQDiWkekeZtuEk0tJ4253Gb7PtvePYOIkmvOiaXtriWSqXT7faTdqnRIXfJh1FS5kQdv
         mEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764671105; x=1765275905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9F+kG2WqkAYgELZzGbRFHTmjlUcifa4ki8f7o3ssRY8=;
        b=PH9Sf7rPvQyzmBWsVzC8YyHu2cJEel1wPDp8Gi5BlB8JN06gSAXqKukc1YQc45d9gD
         4Bj88rmF/Ngs7yBV7PThTzYti0aoQ9/8zG2J7K9sI2SEch76tlFtsFKr7CmVCPOCodKd
         seoxr4/LUeRbJiSxIESE9UfjkkWXYKuI/Lw8E8acHqQWqmULEm7hH5i/t3ZZRUcMvcJc
         07A5g27NkC7gruCfNXYMRvTZ62/bya+2usRu7uCCnlNllKmeBndlJNt8l0SwTD7OaSMh
         zKgnLKEIZmsSjClwy5wSA1Rt7u2LomVeSHmz+rn/Mvb0xtHZZdtOAp09rWLGkOmrMN0e
         gJDw==
X-Forwarded-Encrypted: i=1; AJvYcCXqk03I1GMEmZwKDPjRWYv4uBolMwaIldp+MJrDhDN9ZLhvd8px5w/CAMsAIMyEfG6jZwkTxoPjAN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZYq1lfYM4Ak7ZmxKdNslz7dAm8nkRN9ChZx0CEFpC8fJEl/x
	DgrFacO5CtEeT+RjdlbvKU7cPsLAkVjNxSewh3S5pYB93D9xHtTEvMHRZsTxIm2Gf3RKnM9m5dn
	hJdbu3fIKI5z+9p0ExnLtiL3W7eGpvv1GqK1+t+JrYw==
X-Gm-Gg: ASbGncvpeORr8nAsH2w19OVnfmUG9xgrQRpXTwhR0rWS3vgarTU3lqPBFlIGHuZmncD
	N3bJL8zisEnXKcVKfU6DUy0VVvwJ9XL+7Wv4Fo9kbXk/fMNlqQlw/v4XXN9nqQIfg4u5qNiOmS3
	fwKuDO0U7G65GrUdgGxFawYqER0BE+G+H2ZGcOw/SE0y3g3I0qOfm4dM32PZ8yPGWPSeO/Pn+71
	P3YT3eNDpdUefD09/4VV6LKJL9mZ3ToOj8BpgB5kVT2o9OMMILM2rT32ipbN4oc+qXnBgtWyLbH
	CEla8wwClVYUvmIJlVhIq3RDTRLRVuGH/Q==
X-Google-Smtp-Source: AGHT+IFeIg09WwzL5CLtleL+CNmHwhQV6vEuLIx5Fl2LU6DZGnHpNrCnyZsUrJae/DQnhwmUFLH/yStogQ2YhR3HkVY=
X-Received: by 2002:a17:906:b208:b0:b76:bb0e:5ac9 with SMTP id
 a640c23a62f3a-b76bb0e5b20mr2495117366b.40.1764671105183; Tue, 02 Dec 2025
 02:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128162928.36eec2d6@canb.auug.org.au> <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
 <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
 <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com>
 <vb6pcyaue6pqpx626ytfr2aif4luypopywqoazjsvy4crh6zic@gfv75ar7musy>
 <CAKfTPtCKmj_dHGU-2WPsEevf7CR-isRiyM0+oftCrMy5MswE4A@mail.gmail.com> <6ulzkdgd6j35ptu5mesgtgh2xa6fwalcmkgcxr2fdjwwfvzhrf@4dtcadsl2mvm>
In-Reply-To: <6ulzkdgd6j35ptu5mesgtgh2xa6fwalcmkgcxr2fdjwwfvzhrf@4dtcadsl2mvm>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 2 Dec 2025 11:24:53 +0100
X-Gm-Features: AWmQ_blE1MXJMGsP4HVSDepyDYEV9gPAzgGeXgYsjEilqSbt5qtjWWttwjyQjSI
Message-ID: <CAKfTPtABGj6Nys8J8x8Y-PvybORQUoVN0mGLS=qZ__zXqvCWPQ@mail.gmail.com>
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

On Tue, 2 Dec 2025 at 11:12, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Tue, Dec 02, 2025 at 11:03:07AM +0100, Vincent Guittot wrote:
> > On Tue, 2 Dec 2025 at 10:53, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
> > >
> > > On Tue, Dec 02, 2025 at 09:54:24AM +0100, Vincent Guittot wrote:
> > > > On Tue, 2 Dec 2025 at 05:24, Manivannan Sadhasivam <mani@kernel.org=
> wrote:
> > > > >
> > > > > + Vincent
> > > >
> > > > Thanks for looping me in.
> > > > >
> > > > > On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> > > > > >
> > > > > >
> > > > > > On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > Changes since 20251127:
> > > > > > >
> > > > > >
> > > > > > on i386 (allmodconfig):
> > > > > >
> > > > > > WARNING: modpost: vmlinux: section mismatch in reference: s32g_=
init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (secti=
on: .init.text)
> > > >
> > > > Are there details to reproduce the warning ? I don't have such warn=
ing
> > > > when compiling allmodconfig locally
> > > >
> > > > s32 pcie can only be built in but I may have to use
> > > > builtin_platform_driver_probe() instead of builtin_platform_driver(=
)
> > > >
> > >
> > > The is due to calling a function belonging to the __init section from=
 non-init
> > > function. Ideally, functions prefixed with __init like memblock_start=
_of_DRAM()
> > > should be called from the module init functions.
> > >
> > > One way to fix would be to call memblock_start_of_DRAM() in probe(), =
and
> > > annotate probe() with __init. Since there is no remove, you could use
> > > builtin_platform_driver_probe().
> > >
> > > This also makes me wonder if we really should be using memblock_start=
_of_DRAM()
> > > in the driver. I know that this was suggested to you during reviews, =
but I would
> > > prefer to avoid it, especially due to this being the __init function.
> >
> > yeah, I suppose I can directly define the value in the driver has
> > there is only one memory config for now anyway
> >
> > /* Boundary between peripheral space and physical memory space */
> > #define S32G_MEMORY_BOUNDARY_ADDR 0x80000000
> >
>
> Ok. I fixed it up myself with below diff:

Thanks !

The change looks good to me

>
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/con=
troller/dwc/pcie-nxp-s32g.c
> index eacf0229762c..70b1dc404bbe 100644
> --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -7,7 +7,6 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/memblock.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_address.h>
> @@ -35,6 +34,9 @@
>  #define PCIE_S32G_PE0_INT_STS                  0xE8
>  #define HP_INT_STS                             BIT(6)
>
> +/* Boundary between peripheral space and physical memory space */
> +#define S32G_MEMORY_BOUNDARY_ADDR              0x80000000
> +
>  struct s32g_pcie_port {
>         struct list_head list;
>         struct phy *phy;
> @@ -99,10 +101,10 @@ static struct dw_pcie_ops s32g_pcie_ops =3D {
>  };
>
>  /* Configure the AMBA AXI Coherency Extensions (ACE) interface */
> -static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_a=
ddr)
> +static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci)
>  {
> -       u32 ddr_base_low =3D lower_32_bits(ddr_base_addr);
> -       u32 ddr_base_high =3D upper_32_bits(ddr_base_addr);
> +       u32 ddr_base_low =3D lower_32_bits(S32G_MEMORY_BOUNDARY_ADDR);
> +       u32 ddr_base_high =3D upper_32_bits(S32G_MEMORY_BOUNDARY_ADDR);
>
>         dw_pcie_dbi_ro_wr_en(pci);
>         dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
> @@ -149,7 +151,7 @@ static int s32g_init_pcie_controller(struct dw_pcie_r=
p *pp)
>          * Make sure we use the coherency defaults (just in case the sett=
ings
>          * have been changed from their reset values)
>          */
> -       s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> +       s32g_pcie_reset_mstr_ace(pci);
>
>         dw_pcie_dbi_ro_wr_en(pci);
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

