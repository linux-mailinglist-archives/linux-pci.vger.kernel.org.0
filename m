Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680D717781
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjEaHFF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 31 May 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjEaHFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 03:05:04 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF08F;
        Wed, 31 May 2023 00:05:02 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-565de553de1so9828417b3.0;
        Wed, 31 May 2023 00:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685516702; x=1688108702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSZ0pDbxO01uL9m24dxyZWTludUV0st1ROFCQOeFL7I=;
        b=VfRXYu2sxhR8osmcKqD+hSK4XHa4Zztg8XTcfKvwYJsRScWYTecz+fgytQii1A1pH7
         xAmMkMXVMPdCUgjfVNXe8pbxvzFmPPZvmYcdlAxvcrFjpQhc6NGQ6H5jJyoIIbbVe536
         suBsIalG8HNUVrDTWk3csbFGfTfD+IW2iBTG4oGNhaJ8lbR9C8rW7JYHMRORE8fJDE3X
         E2pFMB0b0ep1DPPHczv/v7KZUc61xxgo9ajnWC4MUXleG5y2fy81/tbI9b2ZrbINoDC1
         2kyuOWrjBiRlC1TAcrLbNxTn0/tfynTmHcrv2HUfv9KIta5mq9fHnG1rr3TpvvXX6HpG
         tduw==
X-Gm-Message-State: AC+VfDyMkRq4k68epAfGxBRlXMpEfU9SUqZ7AGgT2anAAoltw+xOkuou
        TU9IVVf8SUWUrPZOyXBEzfNdj/++2EtOoQ==
X-Google-Smtp-Source: ACHHUZ7jzudn+XdRuOR+mhQ9iHj3oVa/Lr3vRxvvteJ3ymB8KM+k59WTy3ay+DczGofLT8PUOhk2Cw==
X-Received: by 2002:a0d:d889:0:b0:54c:1716:b20 with SMTP id a131-20020a0dd889000000b0054c17160b20mr5655213ywe.17.1685516701856;
        Wed, 31 May 2023 00:05:01 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id m6-20020a0de306000000b0055a486140b6sm5166952ywe.36.2023.05.31.00.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:05:01 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-568928af8f5so9620367b3.1;
        Wed, 31 May 2023 00:05:01 -0700 (PDT)
X-Received: by 2002:a0d:d515:0:b0:568:ed48:21bb with SMTP id
 x21-20020a0dd515000000b00568ed4821bbmr1415156ywd.13.1685516700803; Wed, 31
 May 2023 00:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230530101655.2275731-1-suijingfeng@loongson.cn>
In-Reply-To: <20230530101655.2275731-1-suijingfeng@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 May 2023 09:04:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVU1qurBki6uf3UadK0Dted67pnhE7+2CDGYmK7QCNY0g@mail.gmail.com>
Message-ID: <CAMuHMdVU1qurBki6uf3UadK0Dted67pnhE7+2CDGYmK7QCNY0g@mail.gmail.com>
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
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

On Tue, May 30, 2023 at 12:21 PM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
> call pci_clear_master() without config_pci guard can not built.
>
>    drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
>    In function 'etnaviv_gpu_pci_fini':
> >> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
>    error: implicit declaration of function 'pci_clear_master';
>    did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
>       32 |         pci_clear_master(pdev);
>          |         ^~~~~~~~~~~~~~~~
>          |         pci_set_master
>    cc1: some warnings being treated as errors
>
> [1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks for your patch!

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
>  #define pci_dev_put(dev)       do { } while (0)
>
>  static inline void pci_set_master(struct pci_dev *dev) { }
> +static inline void pci_clear_master(struct pci_dev *dev) { }
>  static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>  static inline void pci_disable_device(struct pci_dev *dev) { }
>  static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }

Makes perfect sense, given there has been a dummy for pci_set_master()
since the git stone age. Apparently adding the dummy was forgotten
when pci_clear_master() was introduced.

Fixes: 6a479079c07211bf ("PCI: Add pci_clear_master() as opposite of
pci_set_master()")
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
