Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAF74B1C5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjGGN3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGGN3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 09:29:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E424D2118
        for <linux-pci@vger.kernel.org>; Fri,  7 Jul 2023 06:29:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-656bc570a05so359402b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Jul 2023 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688736575; x=1691328575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DupNh7fnA3eo1sAlqzoBLQHM+Z+4Cc4oLL6Nx5C1EmY=;
        b=gZReAgklny50fFzmsC3EkeE+3qiZey+kcqm/533Y2CMWwVF5e0o55OhIxegfOLB76m
         PUvAXjezHUYkah8JH7/mam9gDznrRu/JWm/b8oE4+A5qE3dprAMTbO4L9yv61KV6S68F
         ZU3NyvnTcZyuj2WAoU8jiHeWhtIZ07U31zGLVeIt4lhfLfOBeNTHJpM5RZBxSOhF1a61
         zAejfhBIDOpWUOIahDvwTEqV2lbOprSR9WpdvcjR+DOU7aiUnIpMHlBFwGbIdK3KQKfa
         qIPXTZRuQKgX+Wr2VlvzBxqkN7oc3FG/+GGtYny8ssXuQnzfINx6BiMVgweO/ZMAnNwH
         v/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688736575; x=1691328575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DupNh7fnA3eo1sAlqzoBLQHM+Z+4Cc4oLL6Nx5C1EmY=;
        b=BLBa+JV/9vj47Ku7CN0HJsBWTVFA4KZrweJOz8EP7L/6P5NRjF6LDHVoDQn4XUcgHV
         mWk0zEhhhbL31EbJETH/h6AyeM80yBkM9LmPup90mISGq1O9fr4W30S2VtVUCCzT8BiC
         ws5DRat5K7ja7im2FjPSrSQD9pAJvRnJbC/zSlwZtiq7KdAWkUxfkuTSbBrPebU8FvjI
         8ffvikV47Y0JDXmkDL2s05+YmiJmIQgd4ctrBJElGZwz+D8PEWetQ6iQQsH8YZfwpc4Z
         orXTri9n0ImLbsu2rZ7ASPdroRxVRTYdpmWcw9yrNoF7iEsB8ARbofjL5l6b400rszaY
         rJCg==
X-Gm-Message-State: ABy/qLYkpI2afLtfg8+60nSLwhWGpQvmuUTuyrA1Ed4oQYj29H2lsI7h
        FxHq0VOekwDcDjxUoBZaTuqAn8a0zM/mAnb8zb8=
X-Google-Smtp-Source: APBJJlFIc35596BF7QhE/kwcjrni4Eb15XdhBhhdYN9aqYTU0XYHqqdYsbMUOPuuaKp7nD3rba1zgLFwlbQTK8DON00=
X-Received: by 2002:a05:6a20:7495:b0:12d:2abe:549a with SMTP id
 p21-20020a056a20749500b0012d2abe549amr5477507pzd.6.1688736575308; Fri, 07 Jul
 2023 06:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230704122635.1362156-1-festevam@gmail.com>
In-Reply-To: <20230704122635.1362156-1-festevam@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Jul 2023 10:29:24 -0300
Message-ID: <CAOMZO5DFBSde4ugR-H87t5igKrE6_MPMOa6kdGFppvo0Oab4mw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Do not fail to probe when link is down
To:     bhelgaas@google.com, johan+linaro@kernel.org
Cc:     ajayagarwal@google.com, robh@kernel.org, lpieralisi@kernel.org,
        hongxing.zhu@nxp.com, broonie@kernel.org,
        linux-pci@vger.kernel.org, kw@linux.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        sdalvi@google.com, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 4, 2023 at 9:26=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Since commit da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is
> started") the following probe error is observed when the PCI link is down=
:
>
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie: probe of 33800000.pcie failed with error -110
>
> The intention of commit 886a9c134755 ("PCI: dwc: Move link handling into
> common code") was to standardize the behavior of link down as explained
> in its commit log:
>
> "The behavior for a link down was inconsistent as some drivers would fail
> probe in that case while others succeed. Let's standardize this to
> succeed as there are usecases where devices (and the link) appear later
> even without hotplug. For example, a reconfigured FPGA device."
>
> Restore the original behavior by ignoring the error from
> dw_pcie_wait_for_link().
>
> Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started"=
)
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index cf61733bf78d..af6a7cd060b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -492,11 +492,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>                 if (ret)
>                         goto err_remove_edma;
>
> -               if (pci->ops && pci->ops->start_link) {
> -                       ret =3D dw_pcie_wait_for_link(pci);
> -                       if (ret)
> -                               goto err_stop_link;
> -               }
> +               if (pci->ops && pci->ops->start_link)
> +                       dw_pcie_wait_for_link(PCI);

We can discard this one as Johan sent a patch doing the full revert:
https://lkml.org/lkml/2023/7/6/204
