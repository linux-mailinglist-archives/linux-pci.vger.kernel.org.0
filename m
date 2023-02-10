Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF10B6923A5
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBJQuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 11:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBJQuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 11:50:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D713EB72;
        Fri, 10 Feb 2023 08:50:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2054B82542;
        Fri, 10 Feb 2023 16:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67270C4339E;
        Fri, 10 Feb 2023 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676047802;
        bh=U1IgPaH+cGqKlg2gmv0g/yz8rTWc3EVkAFuO8Klnp2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AyWttGpyCY+zywA9Za62badeUzRZ1mPoliPH6WXuQK7kOfg1fSR200FPIP3PGtK2v
         IWK294BwYvOaXNZE9ut2+q4iDKNZMoios5yeqQChsA5tuqaV4rPBCzQRbwch8awy0e
         cZ5A9ahGRdMNCb+QpEHV3d7mP1kQ3NDi9xJAZoNubzFweppykbpIm3wrvPaNKcEXCV
         i0bkQc3eCMbN3kpI2BU3EZaEUbWctziwq8PIfxNCtsVVIxhyqa3Av1yZ2TiDiozrWS
         w0oMJWVbN+tT7xmoKjxCZxKJLNZ1pK84lvLRghNZeAIwhgbfzxHIBwkp1z94S7BLwg
         RpE/7nClXxyeA==
Received: by mail-vs1-f45.google.com with SMTP id p24so5432642vsn.12;
        Fri, 10 Feb 2023 08:50:02 -0800 (PST)
X-Gm-Message-State: AO0yUKVp/CEis4BDpDAWSKu46vQzol/BfOUoH/u7T5kZMyP9lX7jArzs
        ZSsndHoqTCc1mtSlPDlgZEfWs2SeorqxsN2wiA==
X-Google-Smtp-Source: AK7set8UU46cxIsc9747dhB1PMctfl0S9HbaOmhjZOZcx7199k9vq8861CscvywMU6g5RMtule+m5o5KJ1lurqKYYmU=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr3321495vsc.53.1676047801285; Fri, 10 Feb
 2023 08:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20221117020935.32086-1-liupeibao@loongson.cn>
In-Reply-To: <20221117020935.32086-1-liupeibao@loongson.cn>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 Feb 2023 10:49:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKae+Rw162G199zeN09GX+hjUiUxB9h+SN_PPKoeEmrug@mail.gmail.com>
Message-ID: <CAL_JsqKae+Rw162G199zeN09GX+hjUiUxB9h+SN_PPKoeEmrug@mail.gmail.com>
Subject: Re: [PATCH V6] PCI: loongson: Skip scanning disabled child devices
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 8:09 PM Liu Peibao <liupeibao@loongson.cn> wrote:
>
> Add a mechanism to disable on chip PCI devices by DT. Typically, when there
> are pins shareable between the platform device and the on chip PCI device,
> if the PCI device is not preferred, add `status = "disabled"` property to
> this PCI device DT node.
>
> For example, on LS2K1000, GMAC1 (on chip PCI device) and GPIO (platform
> device, not PCI device) 14 share the same pin. If GMAC1 is not preferred,
> add `status = "disabled"` property in GMAC1 DT node.
>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
> V5 -> V6: 1. rewrite the commit log to make things clear.
>           2. replace "unavailable" as "disabled" in patch subject.
> V4 -> V5: clear the issue we are facing in commit log.
> V3 -> V4: 1. get rid of the masklist and search the status property
>           directly.
>           2. check the status property only when accessing the vendor ID.
> V2 -> V3: 1. use list_for_each_entry() for more clearly.
>           2. fix wrong use of sizeof().
> V1 -> V2: use existing property "status" instead of adding new property.
>
>  drivers/pci/controller/pci-loongson.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 05c50408f13b..efca0b3b5a29 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
>                         return NULL;
>         }
>
> +#ifdef CONFIG_OF
> +       /* Don't access disabled devices. */
> +       if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
> +               struct device_node *dn;
> +
> +               dn = of_pci_find_child_device(bus->dev.of_node, devfn);
> +               if (dn && !of_device_is_available(dn))
> +                       return NULL;
> +       }
> +#endif

This should not be controller specific as a disabled node should be
honored on any platform. It also makes assumptions about how the PCI
scanning code works that PCI_VENDOR_ID read failing is enough to stop
scanning. Can you please test this patch I just sent[1].

Rob

[1] https://lore.kernel.org/all/20230210164351.2687475-1-robh@kernel.org/
