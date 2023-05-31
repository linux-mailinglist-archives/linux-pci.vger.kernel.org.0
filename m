Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A057189A5
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 20:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEaSwN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 31 May 2023 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaSwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 14:52:12 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE11101;
        Wed, 31 May 2023 11:52:10 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-568ba7abc11so37396017b3.3;
        Wed, 31 May 2023 11:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685559130; x=1688151130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JIO+6ewBG4mSCCvBnEBG6HW6H1zG6Bueptsr1w2opg=;
        b=EL4upUNRL419u8zViYkdAvN0HyOds+TXncZ4GsDIRQG4cTAOSwZKMJ289KukqvOHF8
         K8FA6C1Xr+Jsv3XzKruh/ojf7gEHv8VC/jQLIkVoZ8E1tj1F2mlCX3vAB9jf2pL9FAmJ
         pzs7FJYZWLY33XCWzieVXSpcC+ZxupKx/mElcjsZCBR0jiiVlnjmGV3n2c555465pPi3
         gWPbYfVszWCWuTrrqOa5iB/mBJAdmEVRaB7+W/+fI7bzPi5uiYpOc5g1U4YeAPxTg9LU
         oUir2dRs1+uOaWrN2jsggrEAbxp24qL8ppVvJOg/OkH/xEzG9QM8q5DpXJyTt2TIh5dG
         V1KQ==
X-Gm-Message-State: AC+VfDy6svYDQXgrTBfERBwKga9LHOT/G+eGnpvpusr2LJoal6uAITJ1
        DRNJGB86bCFe40VmFZ4FwwElUg+R8ueHXQ==
X-Google-Smtp-Source: ACHHUZ6MSuC33DtuccyiiLIzgWHAmIqHJqmMqzJ49iU0Q8NzyqWcTJW4rTTyETs0/+jfG/oUvzWExg==
X-Received: by 2002:a81:d250:0:b0:565:bf0d:e27a with SMTP id m16-20020a81d250000000b00565bf0de27amr8129881ywl.15.1685559129726;
        Wed, 31 May 2023 11:52:09 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v135-20020a81488d000000b005688deeefc2sm2768705ywa.20.2023.05.31.11.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:52:09 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b9a7e639656so10463548276.0;
        Wed, 31 May 2023 11:52:08 -0700 (PDT)
X-Received: by 2002:a25:dbcd:0:b0:bad:4de:f6d0 with SMTP id
 g196-20020a25dbcd000000b00bad04def6d0mr7553666ybf.64.1685559128663; Wed, 31
 May 2023 11:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <ZHeA6eB5FocARdwl@bhelgaas> <b0faa79d-21e2-fe5d-f9bc-3abbf488ec1c@loongson.cn>
In-Reply-To: <b0faa79d-21e2-fe5d-f9bc-3abbf488ec1c@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 May 2023 20:51:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSwwNnTMkTXjNsUoByq2qH=V+PEZPAUVsA4zZVoU-c5Q@mail.gmail.com>
Message-ID: <CAMuHMdWSwwNnTMkTXjNsUoByq2qH=V+PEZPAUVsA4zZVoU-c5Q@mail.gmail.com>
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>,
        Michael Auchter <michael.auchter@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sui,

On Wed, May 31, 2023 at 7:46 PM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> On 2023/6/1 01:16, Bjorn Helgaas wrote:
> > On Wed, May 31, 2023 at 12:25:10PM +0800, Sui Jingfeng wrote:
> >> On 2023/5/31 04:11, Bjorn Helgaas wrote:
> >>> On Tue, May 30, 2023 at 06:16:55PM +0800, Sui Jingfeng wrote:
> >>>> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
> >>>> call pci_clear_master() without config_pci guard can not built.
> >>>>
> >>>>      drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
> >>>>      In function 'etnaviv_gpu_pci_fini':
> >>>>>> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
> >>>>      error: implicit declaration of function 'pci_clear_master';
> >>>>      did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
> >>>>         32 |         pci_clear_master(pdev);
> >>>>            |         ^~~~~~~~~~~~~~~~
> >>>>            |         pci_set_master
> >>>>      cc1: some warnings being treated as errors
> >>>>
> >>>> [1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1
> >>> I don't mind adding a stub if it's needed, but I don't understand why
> >>> it's needed here.
> >> For a single driver that supports both platform devices and PCI devices,
> >>
> >> Sometimes there is no way to separate the PCI driver part and the platform
> >> driver part cleanly and clearly.
> >>
> >> For example, the module_init() and module_exit() functions,
> >>
> >> where we have to register PCI drivers and platform drivers there.
> >>
> >> We can't simply let the entire driver depend on PCI in Kconfig,
> >>
> >> This will make this driver unable to compile, which it's originally could.
> >>
> >> The PCI core could do such a thing for us, and
> >>
> >> There is no need to introduce a driver-specific guard then.
> >>
> >>
> >> There is already a dummy stub for pci_set_master().
> >>
> >> Therefore, pci_clear_master() should also have a counterpart.
> >>
> >> They should emerge in pairs.
> >>
> >> This could probably eliminate pain for PCI driver writers,
> >>
> >> This patch is still useful.
> >>
> >>
> >>>    The caller is in etnaviv_pci_drv.c, and if I
> >>> understand the patch at [1], etnaviv_pci_drv.c is only compiled when
> >>> CONFIG_PCI=y.
> >> Yes, you are right. This is the right thing to do for the driver, though.
> >>
> >> Pure PCI device driver does not need to worry about this.
> >>
> >> Like drm/ast, drm/amdgpu, drm/radeon, etc.
> >>
> >> But drm/etnaviv is special; it's a platform driver that could pass the
> >> compile test originally.
> >>
> >>
> >> When patching it (Etnaviv) with PCI device driver support,
> >>
> >> This forces the PCI driver writer to add another config option.
> >>
> >> (which depends on the PCI config option.) in the Kconfig.
> >>
> >> For my case, it's theDRM_ETNAVIV_PCI_DRIVER config option.
> > So if I understand correctly, you would prefer not to add the
> > DRM_ETNAVIV_PCI_DRIVER config option, and if we add this stub, you
> > won't need to add it?
> >
> > That's a good reason to add this patch.
>
> Yes, please add this patch.
>
> Otherwise, other people may suffer from the same issue someday.

People already have, several years ago, cfr.
https://lore.kernel.org/all/20160309003955.GA1589@tilquin.amer.corp.natinst.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
