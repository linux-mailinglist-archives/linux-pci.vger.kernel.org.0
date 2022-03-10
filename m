Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C287E4D5253
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiCJTHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCJTHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:07:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0B15AF17;
        Thu, 10 Mar 2022 11:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CA060F59;
        Thu, 10 Mar 2022 19:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1815C36AE3;
        Thu, 10 Mar 2022 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646939188;
        bh=DZWH3bwZ375xFmQ0OwIjh3CQzxRg1q4WJtf3n5K59+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUYS3GRPZyu3YowNax3qy3tUrF9gl1hqNJyL6hiyYGHyX+y9YxccY63b3wW94iUte
         6c4yXuAmbX9BIRaws+z+pElTpfVPlHH/bU1n6AgT4xSVnkGnEdGf8Uk4RYw2GyqJ4z
         rrZDvnQbgbnemz23jS2gTRcK67mheTwcWZCEZSQ0c9iVgplw44RIuKJ97GOhV6tIR3
         JP7j06V0TFYS2Qd6vn79s08YRKpHIfU64mPcPLvdnuCejO1X3pMZJtNJlOxI5WXK8t
         q/pqqkNkS8u6o9J/ps142V1BJV6savWZml0At9sjxeod2dXixw13pUM2mhxdG6wuBF
         h8LoZZf5DSJsQ==
Received: by mail-ed1-f52.google.com with SMTP id w4so8218355edc.7;
        Thu, 10 Mar 2022 11:06:28 -0800 (PST)
X-Gm-Message-State: AOAM5338YelDBcI44oHlVWttmdQk15sumpfywXr5R+gYllnTZ/z1R1oY
        OLRm8n2kBd9+PDLv2qZPue4awtZMpYSztBCoIA==
X-Google-Smtp-Source: ABdhPJxGVHRPqEZhL7PMUHhMt2Tffj/wF8PrGVgg0dXSJH+g2KbYq3NU8HU6vY44+Nqq0g+blMf+tpB8rKnB/lUjh1k=
X-Received: by 2002:a05:6402:5256:b0:416:97d1:a6a2 with SMTP id
 t22-20020a056402525600b0041697d1a6a2mr5777352edd.280.1646939187055; Thu, 10
 Mar 2022 11:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20220308022929.30002-1-linmq006@gmail.com>
In-Reply-To: <20220308022929.30002-1-linmq006@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Mar 2022 13:06:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpr9ksR2gse4fHPHbNfv9+TtSu99+Ofz1mZ16WNjswYA@mail.gmail.com>
Message-ID: <CAL_JsqKpr9ksR2gse4fHPHbNfv9+TtSu99+Ofz1mZ16WNjswYA@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Add missing of_node_put() in imx6_pcie_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 7, 2022 at 8:29 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
>
> Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6974bd5aa116..bcc338ab6c11 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1050,6 +1050,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>                 struct resource res;
>
>                 ret = of_address_to_resource(np, 0, &res);
> +               of_node_put(np);

So now you are using the phy within the driver, but not holding a
reference to its node? That is wrong. Though if a struct device was
created for the phy's node, it would hold a reference. There are a
bunch of error paths where the reference should be dropped. But
really, this driver is a big mess with the phy binding and framework
not used and your nodes probably aren't going to be disappearing on
you anyways.

Rob
