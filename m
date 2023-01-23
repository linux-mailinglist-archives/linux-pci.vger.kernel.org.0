Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25006776D2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 09:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjAWIzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 03:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWIzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 03:55:36 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C4A5CE;
        Mon, 23 Jan 2023 00:55:33 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id p185so9776268oif.2;
        Mon, 23 Jan 2023 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz1b0tYnbdGuwNiYEgWVCe87UPcyrKr95U2drhDArGg=;
        b=Y8rs70rSL+WtVk2hD1RSSpcyDqEWAWkbVWwT5Eh8Wlm8FeSaq4vqLgstHNaFuFpHib
         /wM4h/lmAmVq2IjwBj/zOadpIzTuSRw3ickeLiGI2Ps3t1p4hkR19OTTBEu+SVYOMxCL
         xHqlZaIoehi/XkLGtWpz+eiKYSAKt7rE2aZsVlRVV3huuO4f8V0A/FEUxdESUveDaXN3
         FpqF0ihNTg9k/l2B0SayvkoTWeQAIAHeJyiDeEGakNdzzIPTZ39em97okplWwF3rHrwp
         SR/H6bLuqmu1aaPZ3zu2uZ2ro/0lIpgb8L2mqapNLZoFbsgIm7f97uPEnsw0jwdIJckm
         uJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nz1b0tYnbdGuwNiYEgWVCe87UPcyrKr95U2drhDArGg=;
        b=sSSqY2bmj/p958xIGzmlcRCQW21DQ03HY1QnJhqZBPqjo51EPtOaZxpo/0SMSkNrD2
         rYtx1gQJfbisgAN6QqSRkcYAcJmel3mpgZn8gK8gLNB1SVt4B1T93moVC3W4Gg8NpmrU
         IDL01pZk2HQ/e/ScObU7kdp6vtC+VpU2y1WRi1mVzyvJ17TaVXMl2axes/EhlIH21odq
         zisBAWu/pGrbiMvhxLBkUFCoLb0oKOEJ8dErNBmhvaJWEZiWyBEJqQlnr8uhyXEmkwqp
         725+UMaRvu7OITokGYXX9+aTPGJVzBMjD3kcLIH13n2iJjLCEkPvMYvuNsTSCa2ZaH94
         1NFQ==
X-Gm-Message-State: AFqh2kqXAo0zoHHUxgfEzGrVFNIpmRyfDZIL8PfMUVHyfPRLol/rF6qH
        1frCjGVlAt7e9haMDoLarGifp+RoEZhUNVM1Dt1sL8fR
X-Google-Smtp-Source: AMrXdXsFpkpf6JNCJC+UnVQ2GWxr+RKrSZfJN7kCMuajGyMtF11SY9Z9r46EdQFqCUuzJfmg5pA+x6uyJvLOk7tl92A=
X-Received: by 2002:a05:6808:428c:b0:35e:2720:ddb3 with SMTP id
 dq12-20020a056808428c00b0035e2720ddb3mr1503922oib.83.1674464132210; Mon, 23
 Jan 2023 00:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 23 Jan 2023 09:55:20 +0100
Message-ID: <CAMhs-H8sSvn5bfHde-RT0ejqpCujCWvgRFJLtbLXqPcnvGdgtQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

On Sat, Dec 31, 2022 at 8:40 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
> to sleep a bit after call to mt7621_pcie_init_port() driver function to get
> into reliable boots for both warm and hard resets. The needed time for these
> devices to always detect the ports seems to be from 75 to 100 milliseconds.
> There is no datasheet or something similar to really understand why this
> extra time is needed in these devices but not in most of the boards which
> use mt7621 SoC. This issue has been reported by openWRT community and the
> complete discussion is in [0]. The selected time of 100 milliseconds has
> been also tested in these devices ending up in an always working platform.
> Hence, properly add the extra 100 milliseconds msleep() function call to make
> also these devices work.
>
> [0]: https://github.com/openwrt/openwrt/pull/11220
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Hi Bjorn / Lorenzo,
>
> As per Lorenzo comments in v1[0] here it is the patch with changes in commit
> message and introducing a new definition for this needed extra delay time.
> I wish you the best new year for you both.
>
> Changes in v2:
> - Add a new define 'INIT_PORTS_DELAY_MS' avoiding to reuse 'PERST_DELAY_MS'.
> - Rewrite commit message and add a link to openWRT discussion.
>
> Previous patch lore link:
> [0]: https://lore.kernel.org/lkml/20221209071703.2891714-1-sergio.paracuellos@gmail.com/T/
>
> Thanks,
>     Sergio Paracuellos
>
>  drivers/pci/controller/pcie-mt7621.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index ee7aad09d627..63a5f4463a9f 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -60,6 +60,7 @@
>  #define PCIE_PORT_LINKUP               BIT(0)
>  #define PCIE_PORT_CNT                  3
>
> +#define INIT_PORTS_DELAY_MS            100
>  #define PERST_DELAY_MS                 100
>
>  /**
> @@ -369,6 +370,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
>                 }
>         }
>
> +       msleep(INIT_PORTS_DELAY_MS);
>         mt7621_pcie_reset_ep_deassert(pcie);
>
>         tmp = NULL;
> --
> 2.25.1
>

Gentle ping on this patch :-).

Thanks,
    Sergio Paracuellos
