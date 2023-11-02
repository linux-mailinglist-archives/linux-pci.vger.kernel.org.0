Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C57DEB70
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 04:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjKBDg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 23:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjKBDg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 23:36:57 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5179F
        for <linux-pci@vger.kernel.org>; Wed,  1 Nov 2023 20:36:54 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b625ed7208so188025241.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Nov 2023 20:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698896213; x=1699501013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYKJB/+lZzp8GfhPt8Uq7XpKXqFBQC8QL6NU+J08IeQ=;
        b=ZyBECywTS5Ew7tatbEJlJanEEOL6hsYDv4wgl+HkkKHM25KA/Qe9MG3nIRtOT5dE8e
         yNVry4GLhn5C/bO862QrF2QoFXw1cb6j1DPCgAFeUQwOXQjzwE/+sohkS+ii+KI6x/GZ
         k2/r0NyMB7B+ebYEPN9zo6HKwBWntCOpzDrNI7YGIQiSj7iIa/WarDQoWecbZEjBRq8d
         UpdR2MSkcy1tXj7Xo2nceIT5uRuKnICh/wJtnqFQYdusug+wVJtfX4JVX9yPdjgaDiIM
         +XdGOPXERm4i2X/eHa+oWvCAISuVuLMi5Iah6hSm6P+re5EGdeIuvr1ayT5uKPRpYUaB
         Wbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698896213; x=1699501013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYKJB/+lZzp8GfhPt8Uq7XpKXqFBQC8QL6NU+J08IeQ=;
        b=QgHx28mTHRDr0BMa1asLHwp66F6mx3trusbz7BNMdJnjcTDLfvlnAIyFC2A0rP6a0U
         bIU7++y7bua2hDu/q6lbNdN1YOZf0+hr0dphw7IAK/SKVOo/08tRlPqnS0SDCc41Uftd
         zDeeAgDiQlrxQPOITqSIHxxSfuy9dw04Ey9DNHUbc/xnIiZzIvJRjyuG8+X3+MZj1B8m
         lt2wW15dWVuNWaLku6fACNcxn2C17ioB51MQeCK8snsXKy0YMkNoVpSEyT5CL+4zgMsw
         NHNe1edYL/rLMKBGiQvQDMoAs5BzKr5OEMZGV5TavQv5gzUPjDo6ULK/3zUGFhB1EEw3
         4ijw==
X-Gm-Message-State: AOJu0YyBz+NZZB2dTZKDabhuWxDC8qjUZCSzKjjvTpokZ5AbrAFiJgYC
        CC37TBZgFTOBNPI3RuQpPcmI3q2TCdIMHZSAODLV1i+L/4E=
X-Google-Smtp-Source: AGHT+IG3oCxxd4aeLEgIz/OwUQb5xSuk52OS5+3k6c4GKfW8khWkiJTa9kvBx1u0wQdX2Z42CpQf8SrmZNuJPBOvGEw=
X-Received: by 2002:a05:6102:2003:b0:45a:b096:ec7d with SMTP id
 p3-20020a056102200300b0045ab096ec7dmr17152798vsr.26.1698896213543; Wed, 01
 Nov 2023 20:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <85ca95ae8e4d57ccf082c5c069b8b21eb141846e.1698668982.git.lukas@wunner.de>
 <fc30de5276e21d5a3ebcb7e58a8b43e399f7e6e6.1698668982.git.lukas@wunner.de>
In-Reply-To: <fc30de5276e21d5a3ebcb7e58a8b43e399f7e6e6.1698668982.git.lukas@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 2 Nov 2023 13:36:25 +1000
Message-ID: <CAKmqyKOGZihCMGeqHbkLmusZETJB3B5xH9WWH5DWeK_0go+7Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Remove obsolete pci_cleanup_rom() declaration
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Krzysztof Wilczynski <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 30, 2023 at 10:34=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> Commit d9c8bea179a6 ("PCI: Remove unused IORESOURCE_ROM_COPY and
> IORESOURCE_ROM_BIOS_COPY") removed pci_cleanup_rom(), but retained
> its declaration in pci.h.
>
> Remove it.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  drivers/pci/pci.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index aedaf4e51146..d865c4321e14 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -31,7 +31,6 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>
>  /* Functions internal to the PCI core code */
>
> -void pci_cleanup_rom(struct pci_dev *dev);
>  #ifdef CONFIG_DMI
>  extern const struct attribute_group pci_dev_smbios_attr_group;
>  #endif
> --
> 2.40.1
>
