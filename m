Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F278C952
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjH2QF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjH2QFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 12:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1565312F;
        Tue, 29 Aug 2023 09:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97AA8640E7;
        Tue, 29 Aug 2023 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081B6C433CA;
        Tue, 29 Aug 2023 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693325147;
        bh=1LSVrYHTGhcj65LbxMw7ku/Xs3cApviH4txKbEqM25c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LPfLluIVM9evpUF7SOSi2JSoFHEuxyXEaSHXTKSuE9BEQciKgiK8HnOFRGCJtmCeC
         eGbEL+Wy4+tU78yOZ1E/nbAtcsOgvAIi5uh+RAA3L0SedRkUZA7ZDLfBi8XHP30sjM
         CORh1Eaergb5SEXIl9ntF9fxLagZiQj8KQiM2gNMPBgipo46J4gT0s8Tc1ajevFhii
         Yx5PM47Gq47dGMx21KEQsHMAw7f5bb1VXj7X56FChG24A8A6jSJ+3f1SRpbFoVw6uS
         NGkZAMjooU+yV1+KWxuLjKvukkbs+UGz6Tmls4rJNJmuB6na1l6J13MegK8hvXA3wu
         9b0p6VpvhLqPA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so38258441fa.3;
        Tue, 29 Aug 2023 09:05:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFMyCkGlyQp4zGTuhTtPyQ3jjNX7XnqHmDdTng/qg9vLYiLb+E
        1jeHNvS4aj3RZXubfNhrDy/dMx/jPz37Q3zMrQ==
X-Google-Smtp-Source: AGHT+IERLJ82n4GivnTA9BfaU/9jckgs4trztHsxbFce0WwtP9O1SSR6MXQ4pJFSvItAE/+i7S3wz6XvVXei2FjLx4g=
X-Received: by 2002:a2e:9345:0:b0:2b9:3684:165 with SMTP id
 m5-20020a2e9345000000b002b936840165mr19552331ljh.8.1693325145031; Tue, 29 Aug
 2023 09:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com> <20230827133705.12991-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230827133705.12991-8-ilpo.jarvinen@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Aug 2023 11:05:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLELe91os89A1bOG+RPQpdFz0u_SyHx19zhkU19sPH7jg@mail.gmail.com>
Message-ID: <CAL_JsqLELe91os89A1bOG+RPQpdFz0u_SyHx19zhkU19sPH7jg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] PCI: xgene: Do PCI error check on own line
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 27, 2023 at 8:37=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Instead of a if condition with a line split, use the usual error
> handling pattern with a separate variable to improve readability.
>
> No functional changes intended.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/controller/pci-xgene.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/=
pci-xgene.c
> index 887b4941ff32..b7f338de160b 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -163,9 +163,10 @@ static int xgene_pcie_config_read32(struct pci_bus *=
bus, unsigned int devfn,
>                                     int where, int size, u32 *val)
>  {
>         struct xgene_pcie *port =3D pcie_bus_to_port(bus);
> +       int ret;
>
> -       if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
=3D
> -           PCIBIOS_SUCCESSFUL)
> +       ret =3D pci_generic_config_read32(bus, devfn, where & ~0x3, 4, va=
l);
> +       if (ret !=3D PCIBIOS_SUCCESSFUL)

Long term I think we want to replace these error codes with standard
linux ones. As PCIBIOS_SUCCESSFUL is 0, I would change this to just:

if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val))
    return PCIBIOS_DEVICE_NOT_FOUND;


>                 return PCIBIOS_DEVICE_NOT_FOUND;
>
>         /*
> --
> 2.30.2
>
