Return-Path: <linux-pci+bounces-17088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27079D2D7B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8751F262D2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF08C1D151B;
	Tue, 19 Nov 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4tTKun"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03C1D1514
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039357; cv=none; b=n1Mig6N/BK0JN67XXn2nB4pvSlCo2wWsEQ6PPg+ja2NgPKvtzQvfUuweiGb8f0B9y1NgTT0rff1SgVcFn5537d7nDPQo48WzLwuITDFbyhKmC8yBw/pwt1IrfAX+Rw50LXfi/dTfavPyZE196CMnF+5/+w/B8mG3ZeSVkqTr2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039357; c=relaxed/simple;
	bh=AcS2DjT5b4E2qqL5Cpl9pjaV5209SgOpe5GsmPg53aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm++iZuQJxJQUEY4AKmFGkzqSuNBagsotZS7Gbs2u/WwTpbwCJ1bl0zSe9BmDqvjPbOohOQVOrCK8m69OiGjkiwsQ+pgy6le+byIgw10XOxjkm+x/H3jvdDvPNYwfxJAJmJPFRW5iIehypbHfgdgdY5wX6Qb0juBitpMEk/Nt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4tTKun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21247C4CECF;
	Tue, 19 Nov 2024 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732039357;
	bh=AcS2DjT5b4E2qqL5Cpl9pjaV5209SgOpe5GsmPg53aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax4tTKuna60TmfW9ZAngH0WV/atZmoTkkjPoeu+ar1sPtKZ5MxHRKrU8OzbvrJUU1
	 9ZiyA0H88VBGj/NPJfwIxGJOg3mPnB5lgfiB12VfkNxPNHTROyIVyyfwy/lP5SbV2H
	 W1vjDeH4TL7j2MBk134/mWImflkOkrEQqB6ZVBv1jrSDK7LwlkfzcsPvCnIP+RNCYG
	 PsatnKOX8PqLDZae0goAkqtxSjtl3ax+NYg1utFHmPv7ksxqatrHC/8Ql7hBp3ZaHu
	 tL0FWwMfqcaApApaZCx67P4XoVSzWpzaxyteLFJZfLw22IJpWBrdV2+ynxUN5FeUzN
	 u4oAIJJwZ1Mgw==
Date: Wed, 20 Nov 2024 03:02:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [pci:controller/rockchip] BUILD SUCCESS
 592aac418ebdf451fe9b146bc2ca6dfc96921af0
Message-ID: <20241119180235.GA199102@rocinante>
References: <202411180006.ahFN8muC-lkp@intel.com>
 <20241119151925.GA2263235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241119151925.GA2263235@bhelgaas>

Hello,

[...]
> irq_set_irq_type() is declared in <linux/irq.h>.  On arm64, where this
> driver is used, <linux/irq.h> is included via this path:
>=20
>   linux/pci.h
>     linux/interrupt.h
>       linux/hardirq.h
> 	arch/arm64/include/asm/hardirq.h
> 	  asm-generic/hardirq.h
> 	    linux/irq.h
>=20
> but on x86, arch/x86/include/asm/hardirq.h does not include
> asm-generic/hardirq.h and therefore doesn't include <linux/irq.h>.
>=20
> I'm confused about why the robot reported a successful build with
> clang-19.  It seems like that should have the same problem I saw with
> gcc, so I'd like to try it manually.

I am not sure how the bot built this, too.  I can't seem to successfully
built it either locally using LLVM 19, per:

  drivers/pci/controller/pcie-rockchip-ep.o
  # CC      drivers/pci/controller/pcie-rockchip-ep.o - due to target missi=
ng
    clang-19 -Wp,-MMD,drivers/pci/controller/.pcie-rockchip-ep.o.d -nostdin=
c -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch=
/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./=
include/generated/uapi -include ./include/linux/compiler-version.h -include=
 ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KE=
RNEL__ --target=3Dx86_64-linux-gnu -fintegrated-as -Werror=3Dunknown-warnin=
g-option -Werror=3Dignored-optimization-argument -Werror=3Doption-ignored -=
Werror=3Dunused-command-line-argument -fmacro-prefix-map=3D./=3D -std=3Dgnu=
11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing =
-mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -fcf-protection=3Dbranch -f=
no-jump-tables -m64 -falign-loops=3D1 -mno-80387 -mno-fp-ret-in-387 -mstack=
-alignment=3D8 -mskip-rax-setup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dk=
ernel -Wno-sign-compare -fno-asynchronous-unwind-tables -mretpoline-externa=
l-thunk -mindirect-branch-cs-prefix -mfunction-return=3Dthunk-extern -fpatc=
hable-function-entry=3D16,16 -fno-delete-null-pointer-checks -O2 -fstack-pr=
otector-strong -fomit-frame-pointer -ftrivial-auto-var-init=3Dzero -fno-sta=
ck-clash-protection -falign-functions=3D16 -fstrict-flex-arrays=3D3 -fno-st=
rict-overflow -fno-stack-check -Wall -Wundef -Werror=3Dimplicit-function-de=
claration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Werror=3Dstrict-pro=
totypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-address=
-of-packed-member -Wmissing-declarations -Wmissing-prototypes -Wframe-large=
r-than=3D2048 -Wno-gnu -Wvla -Wno-pointer-sign -Wcast-function-type -Wimpli=
cit-fallthrough -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -W=
enum-conversion -Wextra -Wunused -Wno-unused-but-set-variable -Wno-unused-c=
onst-variable -Wno-format-overflow -Wno-format-overflow-non-kprintf -Wno-fo=
rmat-truncation-non-kprintf -Wno-override-init -Wno-pointer-to-enum-cast -W=
no-tautological-constant-out-of-range-compare -Wno-unaligned-access -Wno-en=
um-compare-conditional -Wno-enum-enum-conversion -Wno-missing-field-initial=
izers -Wno-type-limits -Wno-shift-negative-value -Wno-sign-compare -Wno-unu=
sed-parameter    -DKBUILD_MODFILE=3D'"drivers/pci/controller/pcie-rockchip-=
ep"' -DKBUILD_BASENAME=3D'"pcie_rockchip_ep"' -DKBUILD_MODNAME=3D'"pcie_roc=
kchip_ep"' -D__KBUILD_MODNAME=3Dkmod_pcie_rockchip_ep -c -o drivers/pci/con=
troller/pcie-rockchip-ep.o drivers/pci/controller/pcie-rockchip-ep.c =20
  drivers/pci/controller/pcie-rockchip-ep.c:640:2: error: call to undeclare=
d function 'irq_set_irq_type'; ISO C99 and later do not support implicit fu=
nction declarations [-Wimplicit-function-declaration]
    640 |         irq_set_irq_type(ep->perst_irq,
        |         ^
  drivers/pci/controller/pcie-rockchip-ep.c:640:2: note: did you mean 'irq_=
set_irq_wake'?
  ./include/linux/interrupt.h:489:12: note: 'irq_set_irq_wake' declared here
    489 | extern int irq_set_irq_wake(unsigned int irq, unsigned int on);
        |            ^
  drivers/pci/controller/pcie-rockchip-ep.c:672:2: error: call to undeclare=
d function 'irq_set_status_flags'; ISO C99 and later do not support implici=
t function declarations [-Wimplicit-function-declaration]
    672 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
        |         ^
  drivers/pci/controller/pcie-rockchip-ep.c:672:38: error: use of undeclare=
d identifier 'IRQ_NOAUTOEN'
    672 |         irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
        |                                             ^
  3 errors generated.
  make[5]: *** [scripts/Makefile.build:229: drivers/pci/controller/pcie-roc=
kchip-ep.o] Error 1
  make[4]: *** [scripts/Makefile.build:478: drivers/pci/controller] Error 2
  make[3]: *** [scripts/Makefile.build:478: drivers/pci] Error 2
  make[2]: *** [scripts/Makefile.build:478: drivers] Error 2
  make[1]: *** [/home/kwilczynski/Development/Pr

Of course, adding the missing header fixes the build issue.  This is how
I also fixed it on the branch itself, for reference.

	Krzysztof

