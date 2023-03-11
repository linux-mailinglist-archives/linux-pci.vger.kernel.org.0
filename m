Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB56B5C9F
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 15:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCKOLY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 09:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCKOLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 09:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E50CB04A
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678543836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rI9UkkY/zqKs0y6gyqXwPg+4g7Xn+4IOJ0Nvb47KScw=;
        b=NWEXj03+h/I05cE3LMVhhpVLm2d4snNEIpf6xmncC71kjZOzEOQOjB9Cu2aCcweUlETUC3
        Aw7GdZ1+8dfPFv4Oukkezuw8kJVOmyl0lEO8LAK8Oujx15KzEPbawKiUzf7SM0B/JuCSk2
        mjAKaZdF9s/GGI9bj5iVd9/boOwFvxM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ZiDkTCfGOZmQggyYAYDe5Q-1; Sat, 11 Mar 2023 09:10:32 -0500
X-MC-Unique: ZiDkTCfGOZmQggyYAYDe5Q-1
Received: by mail-vs1-f72.google.com with SMTP id f18-20020a0561020c9200b004216d910ebeso2649584vst.2
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 06:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI9UkkY/zqKs0y6gyqXwPg+4g7Xn+4IOJ0Nvb47KScw=;
        b=3/qvrCORiQ6r4m6mpUVRrV1H+EwzpFpiP6KS+1D0VgobavGaY56oBrxpXuZMyp2Dan
         l/xD8KEzo0uDyXptZzJ1NdKu/uugpcB7Nen/57pV4b7TzdnKEwtarhiKTsAa17SAwo3p
         zQcTCqFVcltZbw8iLJvO5the6syvK1PhYJTd0+XdE7d/d5vUyhb+/y/8yuhBny6iDnOY
         DlCiXfcpGpBdhOsF1hphahb+6y25HDb74up2iu213/5iHXquVAvgpKIdWpli87TfQqTL
         tSTcukW/pluCKWOuZJdrNaSMB3S7ch0HQ9qTR+LKS3cIRy0pp0lLoI7KSrFYSoGSkytM
         m6/Q==
X-Gm-Message-State: AO0yUKX825mtwJdTJ8PGn1D76FKb9HShWUgIsbBgdUsXGyxsjCd76mOm
        XoL86ebXXp3Zh3FLacZhc30tUcY2/9ZPmbkPZP/xcKNYdXfgoRM0zJjUN/cAIVChvmx1RpMM9Ef
        q/sP8qi7ONe4uhnRq3zXRsBALFTeSbyDF+03S
X-Received: by 2002:a9f:3001:0:b0:68b:817b:eec8 with SMTP id h1-20020a9f3001000000b0068b817beec8mr18498521uab.0.1678543831518;
        Sat, 11 Mar 2023 06:10:31 -0800 (PST)
X-Google-Smtp-Source: AK7set8tL22Z64GFZQlBETeAIXfNC/NFYd/MWg33mB4oH3lVXRGgxR03Dz5LsWIgpcSED5a84XZH6Ovr3dXVwTdKMzQ=
X-Received: by 2002:a9f:3001:0:b0:68b:817b:eec8 with SMTP id
 h1-20020a9f3001000000b0068b817beec8mr18498509uab.0.1678543831274; Sat, 11 Mar
 2023 06:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230311133453.63246-1-sven@svenpeter.dev>
In-Reply-To: <20230311133453.63246-1-sven@svenpeter.dev>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sat, 11 Mar 2023 14:10:15 +0000
Message-ID: <CAOgh=FydD7Or4KBCHaQ-SyRFKx3rBeft1abVjMUMBxvuQbHMjg@mail.gmail.com>
Subject: Re: [PATCH] PCI: apple: Initialize pcie->nvecs before using it
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 11 Mar 2023 at 13:41, Sven Peter <sven@svenpeter.dev> wrote:
>
> apple_pcie_setup_port computes ilog2(pcie->nvecs) to setup the number of
> MSIs available for each port. It is however called before apple_msi_init
> which actually initializes pcie->nvecs.
> Luckily, pcie->nvecs is part of kzalloc-ed structure and thus
> initialized as zero. ilog2(0) happens to be 0xffffffff which then just
> configures more MSIs in hardware than we actually have. This doesn't
> break anything because we never hand out those vectors.
> Let's swap the order of the two calls so that we use the correctly
> initialized value.
>
> Fixes: 476c41ed4597 ("PCI: apple: Implement MSI support")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/pci/controller/pcie-apple.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 66f37e403a09..8b7b084cf287 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -783,6 +783,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>         cfg->priv = pcie;
>         INIT_LIST_HEAD(&pcie->ports);
>
> +       ret = apple_msi_init(pcie);
> +       if (ret)
> +               return ret;
> +
>         for_each_child_of_node(dev->of_node, of_port) {
>                 ret = apple_pcie_setup_port(pcie, of_port);
>                 if (ret) {
> @@ -792,7 +796,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>                 }
>         }
>
> -       return apple_msi_init(pcie);
> +       return 0;
>  }
>
>  static int apple_pcie_probe(struct platform_device *pdev)
> --
> 2.25.1
>
>

