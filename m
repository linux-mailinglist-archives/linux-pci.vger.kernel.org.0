Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5776C5F92
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 07:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCWGXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWGXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 02:23:40 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301B1B33E;
        Wed, 22 Mar 2023 23:23:39 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p11-20020a9d454b000000b0069d8eb419f9so11196392oti.4;
        Wed, 22 Mar 2023 23:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679552619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht5I7OIX/IrJ6V0jccO0TzKRfXwvIOrcze/Fv6KOhG0=;
        b=dljZfMgzRnrEjH6xjxk9nSZDm/ZDZFj4GDRIuvgxwuS/Qxsp3tHXJ+/FLf+k13dhhN
         WQxTj5ZQlS+3do9MBtCaXGXOPoWyoyVGNCuyqZkYFGcWpSj0+0AS5Sjh+9GLV0i8ET0a
         NZgmgsiOqAoskQxVGBsGOy4BOKstvPX0Uwg2byzerzqsv1/yXAL0TPpc/9BAtYTj77En
         EAcO90gnPTDeZHKSuiEnC336/FkXr4b8tYLEdHTJQgYUBxEw6DvznDVh8MLQcI4waxtF
         joC1rFEruYUCYNtuwEqz1/BIy1gfz4wIOPCqMuMKM5sY+Nt3ngID2OuS/XySBjX2BWTT
         T+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679552619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht5I7OIX/IrJ6V0jccO0TzKRfXwvIOrcze/Fv6KOhG0=;
        b=3bAdk3ayOYhQiLxqxI/CQVBMvfW2S0QaWOCmgUy6c0H4HUOFKO0EpwgL/O5Fmwlzow
         quKO8NWZPL6Vo9sQ80v5OWH6IJG6Pe/qXem/8At2G8kOQ5kCS/vs9upXXXPn2MgrF/rS
         R89RfUQ1cQ43MPCX1h39MMUv8U7rKZhDmqBCyLSY4JGdchH8hT5rrKcnR8LO047Defew
         Ajz1rxbHOvAezhuvEvzgZSj1dtopctB41kcjH67evJdRCaDkL6QQoQAaFMU5zRr8S740
         bMh2i7oyKiruqEPGlBel4m4uB0DZd4cxfqm+tZV6d7Ywpm21sgEdELfEXN8Mt89n9RvF
         YkiQ==
X-Gm-Message-State: AO0yUKXmlDcxfbqVdzURrZjftZEjxsJiLEd1Qs4llKEpwanaH/HQ2i09
        8RZrSLXwbnQayujm+EH5d6J3vEMvYyTMiHPPwWNSbYSnjBIFDw==
X-Google-Smtp-Source: AK7set/a3UdlvsYh0TlqcxTfXISjWC5Ygh/aCw/RURJS4SK3uhj3OzfAYD24wotJyRXS0LXuZMb2G+tzh0Gj2hn54cM=
X-Received: by 2002:a9d:7387:0:b0:69e:aa7:6b71 with SMTP id
 j7-20020a9d7387000000b0069e0aa76b71mr1892196otk.3.1679552619210; Wed, 22 Mar
 2023 23:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <202303231145121987818@zte.com.cn>
In-Reply-To: <202303231145121987818@zte.com.cn>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Mar 2023 07:23:26 +0100
Message-ID: <CAMhs-H_-kQ0FGP3L1xJ=ec_xJ59a2OztMLLjEQmQfYFOEa4DfA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
To:     ye.xingchen@zte.com.cn
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

Hi,

On Thu, Mar 23, 2023 at 4:45=E2=80=AFAM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with dev_err_probe() to simplify the code.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index 63a5f4463a9f..964de0e8c6a0 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -220,10 +220,9 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie=
 *pcie,
>         }
>
>         port->pcie_rst =3D of_reset_control_get_exclusive(node, NULL);
> -       if (PTR_ERR(port->pcie_rst) =3D=3D -EPROBE_DEFER) {
> -               dev_err(dev, "failed to get pcie%d reset control\n", slot=
);
> -               return PTR_ERR(port->pcie_rst);
> -       }
> +
> +       return dev_err_probe(dev, PTR_ERR(port->pcie_rst),
> +                            "failed to get pcie%d reset control\n", slot=
);
>
>         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>         port->phy =3D devm_of_phy_get(dev, node, name);

So this code is unreachable now. Please fix your tools.

> --
> 2.25.1

Also, this is not a probe(), so I don't see a point of using
dev_err_probe() here.

Thanks,
    Sergio Paracuellos
