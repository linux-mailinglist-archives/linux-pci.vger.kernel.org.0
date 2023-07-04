Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2267F7470A3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGDMOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGDMOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:14:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483B1701;
        Tue,  4 Jul 2023 05:13:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-676cc97ca74so1164160b3a.1;
        Tue, 04 Jul 2023 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688472801; x=1691064801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tMQT6XkMCHH4G47to1aaJBYf30IERRnH9fOkZF/SEM=;
        b=sWuFzv4k2V66h4NZniTwg7j3nJYCyWqYPbm6kr20LZdq1PSWNxPGu8IaBMCXkUsN4g
         y/h8Ixu0Hah96hiY3IfL2go4Eu0TAFvqxp2ZERcVyZtTvMcy6somarYlxS4IFa4q/axl
         Y0v7q5TL0rdJv8r+hfqa8cD4gujpeCsacqvsInR2JZm6B8gMaAvwpmVN6ykgzYcULNAd
         +PM/4sCKSpW9eIDMK5RlWS0i/TyvZdVdgbLjHcwlCtW+nweoU9nwUzfyxuZxMgZYUjIw
         f2BOnkfRc8yhJeznKHyEa1KYsfH27x89Aj945B1rlnFoNikwK82qMv0H70IRV8CqjoDV
         9JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688472801; x=1691064801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tMQT6XkMCHH4G47to1aaJBYf30IERRnH9fOkZF/SEM=;
        b=TyV+Z6YUMTh0XWo5DabGQZ5CZfZiFNnwh/CrIDEi8SYb2yarthXu9dyEUTUwt90kD+
         Knp59B38+DNM/9LAvMrgs6IDgNOs+pdLODDVUmsf2BA1XS0D+qHNCXXYY2p2ZxXL7TeG
         L6AsGKL7L86D1mE/PBafesNrlHvtFBWLkTSedu3xtjqfJkajWl/VbMggShB4W1T0B5O+
         QfKPHS1b6H/FDIcClUS03F1DP2TfxjyMeGgOQD6oC4m7w9TbJuXTC/jikAEN4td+E5lQ
         QK9KcCnCPZ7LWMWaHDSvB843aRLJPmQsMsgcNMW0phkwWQs2p5ugeNSWenzLstT5WPiN
         dJ5A==
X-Gm-Message-State: AC+VfDy57NYBr5QuDjmkqPlmXQ58S9dko8HrYqNdEOV6x8gywhvrOEWX
        lEscdzwy/vXhAf/nftyesEucIkT419CZ4yANTe0=
X-Google-Smtp-Source: ACHHUZ4G9q1r5xTvq9sDLx+l8/Sz3J2GeJQR3s4zdX65f8tyFD4XPzeS0lV/nSYkRNC++USIfMdeCH8HZjgMFzs6HgI=
X-Received: by 2002:a05:6a20:3d89:b0:125:6443:4eb8 with SMTP id
 s9-20020a056a203d8900b0012564434eb8mr20170329pzi.5.1688472801272; Tue, 04 Jul
 2023 05:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org>
 <CAOMZO5AghPUsVqMRdByR9hOatwHmgx90mq1HyZYFGkw1WaAY_Q@mail.gmail.com> <9e7d3961-4189-4141-a342-d15a34fefc9d@sirena.org.uk>
In-Reply-To: <9e7d3961-4189-4141-a342-d15a34fefc9d@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 09:13:09 -0300
Message-ID: <CAOMZO5AKYo+9FwNMc+s35ockjK2HET4NDAAMYdnZkBs6A1-Wnw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Provide deinit callback for i.MX
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ajayagarwal@google.com
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

On Tue, Jul 4, 2023 at 8:55=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:

> Well, they're both issues - if someone unloads or unbinds the driver we
> can still trigger this, even if the probe succeeded.

Yes, for your change:

Tested-by: Fabio Estevam <festevam@gmail.com>

> > It should not fail to probe. At least, this was the original intention
> > with Rob's commit:
>
> > 886a9c134755 ("PCI: dwc: Move link handling into common code")
>
> > +       return 0;
> >
> >  err_remove_edma:
> >         dw_pcie_edma_remove(pci);
>
> I have no idea about doing this, all the PCI on the board that I care
> about seems to work fine (and worked fine even with the failure, I'm not
> sure this is being generated by a link that's in use).

The probe failure when link is not up happens in linux-next due to commit:

da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")

Prior this commit the PCI driver probed successfully even when the
link was down.
