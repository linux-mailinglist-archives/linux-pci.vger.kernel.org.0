Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA17DD3A1
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjJaRAi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjJaRAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 13:00:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF17A9B
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 09:59:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so76443011fa.2
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698771584; x=1699376384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1msu0XLPfxYyrCyNfhD0Uq6UkNb/JK/LpR3MQT3fxE=;
        b=q1oAuEuApgPR7fMVnHt42uqMoUdRyNcn4uxlU+3EJMApnfUqpyeOuvrq9W7Npr04AK
         gjrGcWrIvAuHump9ATN8GayQ8o5IVydBkeI4ag46N0rlxHmo3D9Qgu73FJOKwtxV/+4Z
         u/fZCikY5JAA1JViRAnzXtzUA6SIm+Sa31cC7RxJAkMkOYk7/pFpJ1ZIuewaA2/pIyAx
         9o128pTGjtSZGw8dv/SAqv4mQF2e4qjmgcBgNFrmH8R9MNftiVIIr7+W8YN/omaTymmU
         7rVu0KHaeJSQeaMj3kSQBT3M/GS/HJ4VvcVrY1zRmwoPW/HLUD0AQNNypv7ey7VjcXte
         sPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771584; x=1699376384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1msu0XLPfxYyrCyNfhD0Uq6UkNb/JK/LpR3MQT3fxE=;
        b=pLnuh/yie8lJiXT4ioA3peCZZUKt7yh4P2UT0XWpEoQnl1HxqeMkyT4acNV4f5j6yN
         gSomIGpoA2s47H8YkDtoGjU7u38Ped4MtFjzoI3tusFHRFTVKOJi/mrcEbnFMgJTh7MV
         /0bhmMedTW6l0wZc8G6XxQlmilrdIfCdcbTc9gNsRW+982IAzERu13kgkavN8vHNK45D
         tfzpPs5ODj4vhiMGvbZsV8GOoiiFy9IRblCucywLD+4w9OQqMdnyye23AS8RolrW8/2W
         3p6b565phdLuMWkMRmVA6+EWXkdtSONvWTTIzz2Ycy4PxZ6ypIgl1TzrcFCxApFHjcTR
         59kg==
X-Gm-Message-State: AOJu0YzTDpnGpb2uN52Y1OtHbQdGq37+CjzU73e52zQHYtgmz+IDYS2x
        n4y9xoF5IHb6il4VRJqntx3pm9usFpcb6ORkosnMXg==
X-Google-Smtp-Source: AGHT+IHLIz0pr6WKKR+ZsxS8Jtz2q5ragSw8mJcMwBSONHmfqEdgVJkTVZPiOeuf1EKEJ3svVloqdmz8lejmf3V/0F0=
X-Received: by 2002:a2e:84d0:0:b0:2c5:6df:8b24 with SMTP id
 q16-20020a2e84d0000000b002c506df8b24mr11271542ljh.41.1698771584386; Tue, 31
 Oct 2023 09:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <202310282050.Y5D8ZPCw-lkp@intel.com> <20231031145600.GA9161@bhelgaas>
In-Reply-To: <20231031145600.GA9161@bhelgaas>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Oct 2023 09:59:29 -0700
Message-ID: <CAKwvOdmrFL4QQvttb8+xxV4hQp3fGovnFx222g+Q5aPpzV3Ahw@mail.gmail.com>
Subject: Re: [pci:controller/xilinx-xdma] BUILD REGRESSION 8d786149d78c7784144c7179e25134b6530b714b
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 7:56=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc powerpc, clang folks]
>
> On Sat, Oct 28, 2023 at 08:22:54PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.gi=
t controller/xilinx-xdma
> > branch HEAD: 8d786149d78c7784144c7179e25134b6530b714b  PCI: xilinx-xdma=
: Add Xilinx XDMA Root Port driver
> >
> > Error/Warning ids grouped by kconfigs:
> >
> > clang_recent_errors
> > `-- powerpc-pmac32_defconfig
> >     |-- arch-powerpc-sysdev-grackle.c:error:unused-function-grackle_set=
_stg-Werror-Wunused-function
> >     |-- arch-powerpc-xmon-xmon.c:error:unused-function-get_output_lock-=
Werror-Wunused-function
> >     `-- arch-powerpc-xmon-xmon.c:error:unused-function-release_output_l=
ock-Werror-Wunused-function
>
> This report is close to useless.  It doesn't show the complete error
> message, it doesn't show how to reproduce the issue, and the pci -next
> branch (including controller/xilinx-xdma) doesn't reference any of
> these functions:
>
>   $ git grep -E "grackle_set_stg|get_output_lock|release_output_lock" | c=
at
>   arch/powerpc/sysdev/grackle.c:static inline void grackle_set_stg(struct=
 pci_controller* bp, int enable)
>   arch/powerpc/sysdev/grackle.c:        grackle_set_stg(hose, 1);
>   arch/powerpc/xmon/xmon.c:static void get_output_lock(void)
>   arch/powerpc/xmon/xmon.c:static void release_output_lock(void)
>   arch/powerpc/xmon/xmon.c:static inline void get_output_lock(void) {}
>   arch/powerpc/xmon/xmon.c:static inline void release_output_lock(void) {=
}
>   arch/powerpc/xmon/xmon.c:             get_output_lock();
>   arch/powerpc/xmon/xmon.c:             release_output_lock();
>   arch/powerpc/xmon/xmon.c:                     get_output_lock();
>   arch/powerpc/xmon/xmon.c:                     release_output_lock();
>   arch/powerpc/xmon/xmon.c:             get_output_lock();
>   arch/powerpc/xmon/xmon.c:             release_output_lock();
>   arch/powerpc/xmon/xmon.c:             get_output_lock();
>   arch/powerpc/xmon/xmon.c:             release_output_lock();
>
> That said, the unused functions do look legit:
>
> grackle_set_stg() is a static function and the only call is under
> "#if 0".

Time to remove it then? Or is it a bug that it's not called?
Otherwise the definition should be behind the same preprocessor guards
as the caller.  Same for the below.

>
> Same with get_output_lock() and release_output_lock(): they're static
> and always defined in xmon.c, but only called if either CONFIG_SMP or
> CONFIG_DEBUG_FS.
>
> But they're certainly not related to controller/xilinx-xdma, so I'm
> going to ignore them.
>
> Bjorn
>
> P.S. Nathan & Nick, I cc'd you because of this earlier report that
> also mentioned grackle_set_stg():
> https://lore.kernel.org/lkml/202308121120.u2d3YPVt-lkp@intel.com/



--=20
Thanks,
~Nick Desaulniers
