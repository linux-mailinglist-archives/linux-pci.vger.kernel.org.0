Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9556D463
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 07:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGKFu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKFu2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 01:50:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0615FE2
        for <linux-pci@vger.kernel.org>; Sun, 10 Jul 2022 22:50:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o12so2362435ljc.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Jul 2022 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gZzDKZH4l/zsGGLg21sfARYm6tZRtnVyVNYZn/4KXR4=;
        b=1hDk7+kuuy4xkNR/AJ47KK9L6gFkbe+P4ejAU8gm3Zqu2dw7Xt1E50de++3YyKQehQ
         mK2w4ujcycEdkMNnAjZmDO3qJI5Bs2kS0oDp9uiKLmyzFkBJTLW6BXBQyNWzvbbcF7Se
         9yvfErNl5BX3yceFj+nZELYw7Frs6tfAl+aU5CI8Cnk49TMLs7ozDJc/atmlHiATwY8p
         OIElJMElMCMItvrdPWO8N2vKI0yasyjqRy9LliXGUTKNdzoGKCavwA8hhi2G0nqEKv0N
         yEW2vxtGbJEXL/4KjInVv0A5qm1IgxQPdyMvbFWTEAMyNW7EBJXMrlpxCS8lmZOR6U3/
         mr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gZzDKZH4l/zsGGLg21sfARYm6tZRtnVyVNYZn/4KXR4=;
        b=mU21WhPlKm1dx3b8WQfZxmeRPfUAyo7UUlrUtAO9bzYWMpsAV3f1z2Nwx4vhZSt/Ee
         MhoG7l/oRtilDuqI00kggsLg0WYKmyHjpca9K5Lo0XhmfApgivQabaWhGiAlg97Jjlcu
         dOJkLVeCVjzkHZUCKh+staOgmcIJGIi21oJs02I6UgNd3IuY/yefR7cQsJHnL+F5UvX7
         E0Aflrc0cpRDC7nzzkjDyyz/D1RG9UVqiDpjaUvVEVLaPMilPstMpbgn5heyZnVPhiE8
         L0gCZitP8R8gXQS//9hxRdJbN4R9tV8w5j6rQJbN5L3/41UZI6j+T++hf7lwfRZgYkak
         lhFQ==
X-Gm-Message-State: AJIora/E6PDAZ7ZvG8rtKPo6bXIjQ37EreQMd9AruKJXwTuw3vMYr/xm
        7xnfgbGfTIeM2j2M4OJnwLiTRZHuEF0/IZwlESuhgw==
X-Google-Smtp-Source: AGRyM1ujJTpRlpUQbWJjcXD2sNPu0r92UkySH6kWufJZIc0hIlEnQAxHUS5q1rkeIrLqyrpDmVo7cvubpJ/rts8z07U=
X-Received: by 2002:a2e:6a0e:0:b0:25d:6930:d00f with SMTP id
 f14-20020a2e6a0e000000b0025d6930d00fmr2785666ljc.134.1657518625320; Sun, 10
 Jul 2022 22:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <YsftwaVowtU9/pgn@kili>
In-Reply-To: <YsftwaVowtU9/pgn@kili>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 11 Jul 2022 14:50:14 +0900
Message-ID: <CANXvt5rK98-cEMgpzopY9POOK8a5=VDib8uKPLgJakOG=hRfwQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: IS_ERR() vs NULL bug in pci_epf_test_init_dma_chan()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Li <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch changes for a tx dma channel. There is a similar problem for a
 rx one too. The code doesn't cause an error, but it is likely better to
change to just NULL checking.

2022=E5=B9=B47=E6=9C=888=E6=97=A5(=E9=87=91) 17:41 Dan Carpenter <dan.carpe=
nter@oracle.com>:

>
> The dma_request_channel() function doesn't return error pointers, it
> returns NULL.
>
> Fixes: fff86dfbbf82 ("PCI: endpoint: Enable DMA tests for endpoints with =
DMA capabilities")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> It's surprising and unfortunate that dma_request_channel() returns NULL
> while dma_request_chan_by_mask() returns error pointers.  These days
> static checkers will catch this so it's not as bad as it could be but
> still not ideal.
>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/=
endpoint/functions/pci-epf-test.c
> index 34aac220dd4c..eed6638ab71d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -221,7 +221,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_=
test *epf_test)
>         filter.dma_mask =3D BIT(DMA_MEM_TO_DEV);
>         dma_chan =3D dma_request_channel(mask, epf_dma_filter_fn, &filter=
);
>
> -       if (IS_ERR(dma_chan)) {
> +       if (!dma_chan) {
>                 dev_info(dev, "Failed to get private DMA tx channel. Fall=
ing back to generic one\n");
>                 goto fail_back_rx;
>         }
> --
> 2.35.1
>

Thanks,
Shunsuke.
