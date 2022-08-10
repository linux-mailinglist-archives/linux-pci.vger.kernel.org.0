Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927AC58EDC9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiHJOBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiHJOBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 10:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1416CF5B;
        Wed, 10 Aug 2022 07:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE3E6B81C96;
        Wed, 10 Aug 2022 14:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F179C433C1;
        Wed, 10 Aug 2022 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660140101;
        bh=vVk3smFP0yDqyAhoxqkKU2XVUV0vThugwov15K5VhNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nPfBIfBMAhOgPnfZsovb1vlKEvp0FTp52k+W4RElRxa8R5ObDjDbXGNK7iQymqWnb
         1mCOZjWGjnFxCicpK6eyRLotfLtrNuXt3XKW+jvDDFtPz0NhKi//N/DU9F/vVrsGRH
         swBS4VzJhc0cu0+eIGeIrGEa36AJYHX9BJW1PnDYXomN0ew9+L1UKQfpfZrJ9xUhS/
         ky/0yqVl1AoL9DtXQnEE8k5KQBvtG8LV0qcz5uSe9SnQqvp0lPiHKuEXy+mQa6yo7/
         nt6zfjDiEMQsOCrN0JAOR/mahpWQ5XQRnaO8WT1ki5NNzEmI+z+FjtpYIVQ+HbkPY+
         xz0Jfj4gNZhIw==
Received: by mail-ua1-f46.google.com with SMTP id c19so5825939uat.6;
        Wed, 10 Aug 2022 07:01:41 -0700 (PDT)
X-Gm-Message-State: ACgBeo2b35It26Xq2pN1uaWTy8UIGmeOlPAdPUeTiZIvM7VycEslFaW9
        BEfIcOmhrX3WbI0qQxgwDTfiuos8vuCV7afYtw==
X-Google-Smtp-Source: AA6agR5q3hDFDuGlmEq0UN3fTzwMJ+SVnwvkm2Pu+mSf5pciJB26bJjNIcUR+po4kBl8EYcd3Rp3BvU/1sAAwlh4oSw=
X-Received: by 2002:a05:6130:291:b0:383:3b9:7024 with SMTP id
 q17-20020a056130029100b0038303b97024mr12388093uac.43.1660140100430; Wed, 10
 Aug 2022 07:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220720213036.1738628-1-Frank.Li@nxp.com> <20220720213036.1738628-4-Frank.Li@nxp.com>
In-Reply-To: <20220720213036.1738628-4-Frank.Li@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Aug 2022 08:01:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_yAW=noPVe3LuG-ojG5ENe27to5OEzQSgGx6jHon43A@mail.gmail.com>
Message-ID: <CAL_JsqJ_yAW=noPVe3LuG-ojG5ENe27to5OEzQSgGx6jHon43A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi controller
To:     Frank Li <Frank.Li@nxp.com>, Marc Zyngier <maz@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 3:31 PM Frank Li <Frank.Li@nxp.com> wrote:
>
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

This is failing in linux-next now, but I'm wondering why it is there
given all the comments.

Error: Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dts:31.41-42
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:396:
Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb]
Error 1

Rob
