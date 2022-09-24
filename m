Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74D5E9075
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 01:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiIXXyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 19:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIXXyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 19:54:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60E3BC5C;
        Sat, 24 Sep 2022 16:54:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 30so4650979edw.5;
        Sat, 24 Sep 2022 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CBRSPkWO3j4tbi/g0ng0NFipbSw0aK/tx8sgTF9xYdU=;
        b=kaQ0umG/iyuJTdaE8gvYt91R+0HAZiBJew74tjADm0tF37tACwptqO0jBCxJauu6Fk
         BmPGUKAn5tlipHYxvfw0apIkZPhmReWFtY1ghEFzcXBrwclSYRBVcd7oGCxGUvwiHQgh
         oyu2UyLwE9iJLEsOJrTMjBzvoQuw0jEO/MPwvf6nk005b6R1dOYHrJM7EpSv0Cyd9OwO
         Eh1pEbLtImKAC5tFpVXy5eqi1fBCkYK2w6kF/yGH3XTRi7pS52fV/y2RVaSxYkUsryo1
         UFEFpAkgbxVRWKyja5ru8WKAdZvdVkAZKcA9Sk2UNYMUjBV8xHJzwC/piurDPtntD0r1
         yC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CBRSPkWO3j4tbi/g0ng0NFipbSw0aK/tx8sgTF9xYdU=;
        b=nBLXZhEvXDS4L9CdmcWhEgUgulnt0fDrm3mc7jc91YqPW9iVC+yA6FUaXmAL5Qe+M+
         u4GhWdlgQjbD/arh+O1KVej3H3Fl1k4TB1ExjsBaSkw/q/33vnlpSyNViVZBHzRCIAP5
         /+aSJL9SIC7YWzdFeWqjtWKQNSToX2yRtjQsXxxla5StCFDfYqsBPcepujCsXub0Ov3c
         6T5MG2KOH+GolYUmKqbwjE3Ia0NL7N61ff50J3wxXuXinFkhuFgtJUyrTLrF6flkVxak
         pFcegQsm3dLSICE7YAoW+h/IU48wuLchFKkqXL9s0VhaY1AQghjIQuWr0dOvRvh5Myig
         gyVQ==
X-Gm-Message-State: ACrzQf11RGluZlGry/fKc+Vy/ivEEHWxvvcSybHkDzVU8hTLvTPsJz6n
        aHwCh0ajwvfpz6OItRBfbBGjfgxXlw5Phld8N5I7rvbSdiu7hA==
X-Google-Smtp-Source: AMsMyM4WRG/u0/uSPvSkxdC92l4S/9EliQuDYaHsV7mW8jNluQmpGysYZyHdtYUMP03H9qDLXF3lJ1Tn6itP+pX4Hog=
X-Received: by 2002:a50:fa8c:0:b0:456:cf8e:40fd with SMTP id
 w12-20020a50fa8c000000b00456cf8e40fdmr9249955edr.365.1664063647851; Sat, 24
 Sep 2022 16:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org> <20220924160302.285875-7-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220924160302.285875-7-dmitry.baryshkov@linaro.org>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Sat, 24 Sep 2022 16:53:55 -0700
Message-ID: <CAPOBaE5Psf3NehAM+5nQe2=rEC-wdF=zSrLXAnagEnt1ft2f5Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] PCI: qcom-ep: Setup PHY to work in EP mode
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the EP mode.
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han



> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index ec99116ad05c..8dcfeed24424 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -240,6 +241,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>         if (ret)
>                 goto err_disable_clk;
>
> +       ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);
> +       if (ret)
> +               goto err_phy_exit;
> +
>         ret = phy_power_on(pcie_ep->phy);
>         if (ret)
>                 goto err_phy_exit;
> --
> 2.35.1
>
