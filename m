Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A08747028
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGDLub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGDLub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 07:50:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F62136;
        Tue,  4 Jul 2023 04:50:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66872dbc2efso1442307b3a.0;
        Tue, 04 Jul 2023 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688471427; x=1691063427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af8sNRpIaz9R15l2zCW6srh5J6ZqRdYTMdKHNQbuxSw=;
        b=srvYgennRg3nu0rxRFG6kwUozrm8jPGIM0Rarzt0aXTEau8B2dWO05A+pIYLBCW8eG
         N9hFlI2Dpabf47SIAqxN6hhVjnrQ0QwYhFXMaSbR5Sppbc9tVJnfu7IO6avQGEW/fjIO
         yTAcHQEfYJ61VCmslJAzbmWa0dL2IvgPrvIyNYyIy60E6EIeOS6919MGNOufaPkE63xx
         jTtda7KktHtBAF1eWZ27yoJ9fqWUfH5Zm0crvlQTRxRmqfpXUwaf23zyPQehtiXW3nVc
         HFA7O9zZfJDQYB13l1cWyWiZTVGWb9t+5ZsaXUdWGFcj3bENCekpK6Y1qDOinW092Pxv
         NxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688471427; x=1691063427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af8sNRpIaz9R15l2zCW6srh5J6ZqRdYTMdKHNQbuxSw=;
        b=EF7n6+oys/2kX2J1mhGTXQopKn88uld9sXg3wiP4yKdwjrgZCZwqSd/9joakCsrRS1
         +S/we7J/t1G1YceLksY9f0RF4tccojhirdEdc+m+5ULY2y+FZ1mTzYgF8HfqrvFXh/6d
         zcjmRwUiqq2ND+fJALsTlL4BSxFYbZLSxQRVVAkMnxSBrHXNZWk7UF38T5QWx3oXhZGr
         ypac4UHukLj+EBTrF2YsrZjsER/w1YvVyIjg7doPo4FJZoWxJ0TypdQ8myu37/DxUEoI
         aWeTetzf0jYyepLbKmqkT24wxv9p1Qas2DZTfWF1NpTUA57MfHOUiIYdR6yLuQp1+8m4
         NN5g==
X-Gm-Message-State: ABy/qLb0IAVCSgVPaVaSRKI1xL5w2RCPkrRws4WhJ03SCt5Vq8BMilvw
        bMrflqLBF2zbNaioTAYVE/ZI5qWEdFAcMd4te+c=
X-Google-Smtp-Source: APBJJlFJ1qy5fYrabH+2QtIs6cSUwZ1sKyZGOfXlB+EnruFwvSyOdAG9NJmelly7vwz8i+jUhhe78CMNebBuOmy5yew=
X-Received: by 2002:a62:524f:0:b0:668:834d:4bd with SMTP id
 g76-20020a62524f000000b00668834d04bdmr15333752pfb.0.1688471426836; Tue, 04
 Jul 2023 04:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org>
In-Reply-To: <20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 08:50:15 -0300
Message-ID: <CAOMZO5AghPUsVqMRdByR9hOatwHmgx90mq1HyZYFGkw1WaAY_Q@mail.gmail.com>
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
        linux-kernel@vger.kernel.org
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

Hi Mark,

On Mon, Jul 3, 2023 at 1:30=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> The i.MX integration for the DesignWare PCI controller has a _host_exit()
> operation which undoes everything that the _host_init() operation does bu=
t
> does not wire this up as the host_deinit callback for the core, or call i=
t
> in any path other than suspend. This means that if we ever unwind the
> initial probe of the device, for example because it fails, the regulator
> core complains that the regulators for the device were left enabled:
>
> imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16=
G
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie: probe of 33800000.pcie failed with error -110
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 46 at drivers/regulator/core.c:2396 _regulator_put+0=
x110/0x128

Your change looks good, but I have a more basic question.

I recall seeing this regulator warning before:
f81f095e8771 ("PCI: imx6: Allow to probe when dw_pcie_wait_for_link() fails=
")

I think the real issue is why does the probe fail when the link is not up?

It should not fail to probe. At least, this was the original intention
with Rob's commit:

886a9c134755 ("PCI: dwc: Move link handling into common code")

Should we do something like this?

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf61733bf78d..6bd6ffef900d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -509,6 +509,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)

 err_stop_link:
        dw_pcie_stop_link(pci);
+       return 0;

 err_remove_edma:
        dw_pcie_edma_remove(pci);
