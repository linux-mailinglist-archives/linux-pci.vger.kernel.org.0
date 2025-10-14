Return-Path: <linux-pci+bounces-38017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4B5BD7D6A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C1934F7F67
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E22E2D94AF;
	Tue, 14 Oct 2025 07:17:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012630DEBE
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426235; cv=none; b=AD6mP4qkUYEX8FqWa9neu1lbclnHsbUHEkgfpbwrwv8JCaH9UyF4/26xWB/7YuE5Jh7EeHhg6YoJk/NHK5C54sZKqIVW4CwwycZyogvFMgpA+/MZXCydECZ761PBm8x59bbQO7tBWPCDR0qyM5hug5WpnSWpoEaJUm6lZTFuRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426235; c=relaxed/simple;
	bh=qcHTUS0wo1f43VFStYszqJZcg60j4r28QkB5kGixAXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrXr2rgue7YtDfQM2N451YNW5VUCb7meBtCzmWG/kNoVApTSBEEMsLRZImxzB5qw5rxBZ54SiFrOP50aPa0LFjEfOE8e3p0jIgW8FtrjdQR6bbprAvsN1nRv2UZuP+nfsSMNycARfXQ6IHFp+p+F6lshokUiRBHUwCm7d5F2yXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5b62ab6687dso4989494137.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 00:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426231; x=1761031031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LJPJfcpv0pJD66G650kRDT3CGUnlnJtrjGpdse2lj8=;
        b=JIXbMzqyxmAeufELNbOAPbEQlz3lPqgDhTyYNt0G5D2aDSc8/59LzFj6T4zyfDrBbW
         aLoDfhTOJNeoiqOf/gch0soCa9zvUqmKtoxi7pJX2IacmVbJc7Aa1jdm0HSBLnDX7axX
         ioV+pbA+/YrlsUQ91mIyWNTGPZZ16LAjf88X8oSt0QNUTf7DS2lmUrtHoAsEiEfcieef
         qCErPoWjbAGOeAbGYvv89XylGic37ax4X2NF3upCKYOX4RjYb9+MuG44X2jLScvWsUT1
         C30qySXWFZQO5Gw/QZj/c/svY4o9r4Xxei+dq37CrQAwv59CN2n/SZdk8GVAOMjFO5nz
         YY1w==
X-Forwarded-Encrypted: i=1; AJvYcCXieLcBh6CXMRzleGDTcaetZtLP/8kL/QHGzpyd9K5lNbs3zv1NeClefjyNawlhAGjbwQch13SD/BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Fn91WaSCWxDiIgXNhij0yq3dPYTgKUCQ+k/YehvP1ny3F7cA
	SK9rMkT7nbSbQEyPspKTV82o8ZztmDGFKYOEfdlArrsRr6Oq3cWIQOsHsJzlliIh
X-Gm-Gg: ASbGncubLJiHPN4ea+ifm7SMRtJVmACy+likb2SRQ0qfZMAmUItHQaQL6YFe0zLN8m6
	0g4HWoX13L3XIPp5Qd3gU6xKmCygr3gLs/zLEHLPrnu1kzgq5yHhXqaHEqw16bMc2mEjez6AUSp
	JvXz/UbyOvhtJzpWSeuM/n4xoO/JZKvF2YDzZSFx8kgIaCdzXsgDnX8mFmQcbqjcQdV1cNeDERm
	hT0Dwd1s3FZKDSDwYf0M640BP3B8RKmjGbFNeML170cTHlIyQ4cNyO+aw3bIjrRamkIaWfmBvsy
	5R12mybczQzDUINhRt+U3r3hvuAbHN7Vb2GDWj7IOd3UXe3t2ce69cD9Yk7npIJJVlI00cT1OQp
	Qm6xpz2Dzc6ULQyqzesCouJJwobgztLIWkFG1/g1FnXW2peXLvbPVTecVtZugmPEwjoVRyQ0sZr
	M4eBZHkrJiCZ1MpA==
X-Google-Smtp-Source: AGHT+IHD/RqqIJr3zHOMfQjNcZTlet74xH/Q0VHCayUpC8FBx8q/fQMN4CNSUqhWMquNu189LBmtkg==
X-Received: by 2002:a05:6102:3e1f:b0:530:f657:c40 with SMTP id ada2fe7eead31-5d5e232269amr10884607137.22.1760426230853;
        Tue, 14 Oct 2025 00:17:10 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf6ce034sm3408362241.7.2025.10.14.00.17.09
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:17:10 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ce093debf6so4797748137.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 00:17:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9sIXCB3x+2Ao4uDFDMz7I5JQWi0i/ChhdMQxvC6Wv5PkFEGGqhhwNL1N9U1AdGKqMKCVDoACg3Rw=@vger.kernel.org
X-Received: by 2002:a05:6102:3c8e:b0:4fa:25a2:5804 with SMTP id
 ada2fe7eead31-5d5e220420bmr8840762137.10.1760426229660; Tue, 14 Oct 2025
 00:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
In-Reply-To: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 09:16:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
X-Gm-Features: AS18NWBECJtooFXj8wIhcLw2_n3BPi6xXTVAMYxpuf1MNXW6QPz_d-TTeadxeIw
Message-ID: <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-host: Avoid objtool no-cfi warning in rcar_pcie_probe()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Kees Cook <kees@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Mon, 13 Oct 2025 at 20:26, Nathan Chancellor <nathan@kernel.org> wrote:
> After commit 894af4a1cde6 ("objtool: Validate kCFI calls"), compile
> testing pcie-rcar-host.c with CONFIG_FINEIBT=y and CONFIG_OF=n results
> in a no-cfi objtool warning in rcar_pcie_probe():
>
>   $ cat allno.config
>   CONFIG_CFI=y
>   CONFIG_COMPILE_TEST=y
>   CONFIG_CPU_MITIGATIONS=y
>   CONFIG_GENERIC_PHY=y
>   CONFIG_MITIGATION_RETPOLINE=y
>   CONFIG_MODULES=y
>   CONFIG_PCI=y
>   CONFIG_PCI_MSI=y
>   CONFIG_PCIE_RCAR_HOST=y
>   CONFIG_X86_KERNEL_IBT=y
>
>   $ make -skj"$(nproc)" ARCH=x86_64 KCONFIG_ALLCONFIG=1 LLVM=1 clean allnoconfig vmlinux
>   vmlinux.o: warning: objtool: rcar_pcie_probe+0x191: no-cfi indirect call!
>
> When CONFIG_OF is unset, of_device_get_match_data() returns NULL, so
> LLVM knows this indirect call has no valid destination and drops the
> kCFI setup before the call, triggering the objtool check that makes sure
> all indirect calls have kCFI setup.
>
> Check that host->phy_init_fn is not NULL before calling it to avoid the
> warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
> Reviewed-by: Kees Cook <kees@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for your patch!

> ---
> Another alternative is to make this driver depend on CONFIG_OF since it
> clearly requires it but that would restrict compile testing so I went
> with this first.
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa5..15514c9c1927 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>                 goto err_clk_disable;
>
>         host->phy_init_fn = of_device_get_match_data(dev);
> -       err = host->phy_init_fn(host);
> +       err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
>         if (err) {
>                 dev_err(dev, "failed to init PCIe PHY\n");
>                 goto err_clk_disable;

I am afraid you're playing a big game of whack-a-mole, since we tend
to remove these checks, as they can never happen in practice (driver
is probed from DT only, and all entries in rcar_pcie_of_match[] have
a non-NULL .data member)...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

