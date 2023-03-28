Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530D96CB789
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjC1G4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 02:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1G4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 02:56:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654501BDC
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 23:56:45 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17aceccdcf6so11761918fac.9
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679986604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qh+JaNHAD8f25IDWuH+n7YY+r2NLLfs7rAFVNJ1skc=;
        b=Qidgo4mSaU+b2DK5q/FKLTDkJfwDkk2IcMQNzwN3QUuSsb5OgwugUvJ+yZZK95L6l+
         VohAxr2Yo7c2hkADUA8odadX6urSipoVf/rtU2HrkSl4u2HcDkBX475Y3jUIYIscPE9w
         +PANhhHjY+Nv2C9UH5us8rJdurGjtzit2EIZCJwrwQjorDFQWHJTFXk5q9HDs+e0FnoC
         9130mEwafXyg1Kj3LWIBUYy36ZCGh2FAgFj4CqJdS4BHshIIDMmVKhhipvfLkXJfPbi8
         TwyLwetKM16Qf0JWbWZ5+lOdBMXVKMkrW3/bEHXX9uHt+aLsM4Lg8WcmS4NbtubzOykh
         txMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679986604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qh+JaNHAD8f25IDWuH+n7YY+r2NLLfs7rAFVNJ1skc=;
        b=kHMUbOCDg9pyN+z1AQPSlaGBDQmhFglFwTIIizRLGvd+A7TAFEdDDvZKGP3DzrE0aN
         RdnpB43PVt1GhaCbyoMzHJZv84c6Ndy2nDPqipBjzqvDXn5K7jbzPgd1/2be94/eXs1P
         3FoNG8KYnQ+bYuICoyIBqvplKG535q/lPaNLE3XACSDFhZy24ROpK1/6SepV0/+7QAlr
         An+lVASyhBOkzyQyExp8hLuxf/ZEm/whPQmmP87N9yskb05TzrT1QYqXvIZcNOSp4dni
         Kx+uueW0uF71zHPtwtUjrYaznqaz3shlc/XS+StU7VaYO1XbPaaeEHBHaAXpYR6rOci/
         jSJw==
X-Gm-Message-State: AAQBX9ekVrEBToqIosqVqZKiKxTnjIrCT6Oj6xmGWi3JxZ2aCRPyOhKL
        rcP0+eY06zJ8HC3Zt3uSO64hCG+IaiSqLtgv0BU=
X-Google-Smtp-Source: AKy350a2VlaWZDsRSGtZaKITotDYUirqBWjlbW6S1GJimGi/3ru2Tszfu4uiCU3utNmxCTTJWA9jnhshcmVTFJyvbm8=
X-Received: by 2002:a05:6870:11d9:b0:17e:1aaf:eb9b with SMTP id
 25-20020a05687011d900b0017e1aafeb9bmr4964072oav.10.1679986604599; Mon, 27 Mar
 2023 23:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com> <20230325070226.511323-11-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230325070226.511323-11-damien.lemoal@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 28 Mar 2023 08:56:08 +0200
Message-ID: <CAAEEuhq_T9KGJoBcDNOC_+8ktAUr91xys0aRqQCXz3nN0W72Xg@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 25, 2023 at 8:02=E2=80=AFAM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> Command codes are never combined together as flags into a single value.
> Thus we can replace the series of "if" tests in
> pci_epf_test_cmd_handler() with a cleaner switch-case statement.
> This also allows checking that we got a valid command and print an error
> message if we did not.
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++----------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
> index fa48e9b3c393..c2a14f828bdf 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -676,41 +676,39 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
>                 goto reset_handler;
>         }
>
> -       if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
> -           (command & COMMAND_RAISE_MSI_IRQ) ||
> -           (command & COMMAND_RAISE_MSIX_IRQ)) {
> +       switch (command) {
> +       case COMMAND_RAISE_LEGACY_IRQ:
> +       case COMMAND_RAISE_MSI_IRQ:
> +       case COMMAND_RAISE_MSIX_IRQ:
>                 pci_epf_test_raise_irq(epf_test, reg);
> -               goto reset_handler;
> -       }
> -
> -       if (command & COMMAND_WRITE) {
> +               break;
> +       case COMMAND_WRITE:
>                 ret =3D pci_epf_test_write(epf_test, reg);
>                 if (ret)
>                         reg->status |=3D STATUS_WRITE_FAIL;
>                 else
>                         reg->status |=3D STATUS_WRITE_SUCCESS;
>                 pci_epf_test_raise_irq(epf_test, reg);
> -               goto reset_handler;
> -       }

As a minor improvement on this cleanup I would suggest either switching
the if / else condition above or the two below, the inverted logic makes it
confusing. (one test case is if (ret) and the two others are if (!ret) with
inverted results, all could share the same code (same logic)).

> -
> -       if (command & COMMAND_READ) {
> +               break;
> +       case COMMAND_READ:
>                 ret =3D pci_epf_test_read(epf_test, reg);
>                 if (!ret)
>                         reg->status |=3D STATUS_READ_SUCCESS;
>                 else
>                         reg->status |=3D STATUS_READ_FAIL;
>                 pci_epf_test_raise_irq(epf_test, reg);
> -               goto reset_handler;
> -       }
> -
> -       if (command & COMMAND_COPY) {
> +               break;
> +       case COMMAND_COPY:
>                 ret =3D pci_epf_test_copy(epf_test, reg);
>                 if (!ret)
>                         reg->status |=3D STATUS_COPY_SUCCESS;
>                 else
>                         reg->status |=3D STATUS_COPY_FAIL;
>                 pci_epf_test_raise_irq(epf_test, reg);
> -               goto reset_handler;
> +               break;
> +       default:
> +               dev_err(dev, "Invalid command\n");
> +               break;
>         }
>
>  reset_handler:
> --
> 2.39.2
>
