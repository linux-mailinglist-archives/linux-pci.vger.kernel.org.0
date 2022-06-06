Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A9853F1C0
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiFFVdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiFFVdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 17:33:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1641A3B55A;
        Mon,  6 Jun 2022 14:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE681B81BD4;
        Mon,  6 Jun 2022 21:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E7BC3411F;
        Mon,  6 Jun 2022 21:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654551176;
        bh=9wW78eqRW+8CIx9i+7pjI5Ws5cP7kXj2HXPttlOJSKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RMWpFeT9OKyPVlCjkLE8sQqVvrGS9lAvEGB5ykHS/u9A0m3KmmSLZItcDha4xJ1C+
         3hhrCaMy5J97Ljvx5P6VVtutPFC3nbeNQirTqlPLUJ/a6Vy/6APybG6ZyWJc1O4WGR
         noIYGahmi9bTrlusRMdgayYJVyizyAov/9JELVMG6Zg24UqnBNM0okdy5e1Ab7mP2t
         AZHrbEL5mSWbbg7ZANrKSmliJJx4SBrTc7P3TgJTxh5F72PCSSFjUIRz8+CdOlO6rL
         A8EW7zpRPz6H0EnTrIe6qyWK02jG8mfbcDefQeHZdq8xU+JiexAs62rs9aezZzdkbV
         kQtIQpSUTw/Hw==
Received: by mail-ua1-f51.google.com with SMTP id d18so387720uaw.2;
        Mon, 06 Jun 2022 14:32:56 -0700 (PDT)
X-Gm-Message-State: AOAM5313Noy2X3bppCZvgGuqJwGTKQsDn3iNzF8innqWqjj7LVSC/FIn
        9XJgrgm5WniqFVI49h+7MQ1QxelwuwOXzTmKSw==
X-Google-Smtp-Source: ABdhPJzU1/YbR6XZqlEg7jT+k0qWmDbk6RiFLeErl96iSR6CBrFqhe/OUYqf8vnTuncw0bdEQ1REX1ZFbtaL1/Kzw9U=
X-Received: by 2002:ab0:5a95:0:b0:369:1a3f:358c with SMTP id
 w21-20020ab05a95000000b003691a3f358cmr24079388uae.63.1654551175305; Mon, 06
 Jun 2022 14:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220605055123.59127-1-linmq006@gmail.com>
In-Reply-To: <20220605055123.59127-1-linmq006@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Jun 2022 16:32:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+x=vqaWTBa6gb+p0ZmKgzwQFdbmhgT0Phfye6rtmPnEQ@mail.gmail.com>
Message-ID: <CAL_Jsq+x=vqaWTBa6gb+p0ZmKgzwQFdbmhgT0Phfye6rtmPnEQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: microchip: Fix refcount leak in mc_pcie_init_irq_domains
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 5, 2022 at 12:51 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_get_next_child() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> This function only call of_node_put() in normal path,
> missing it in some error paths.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
