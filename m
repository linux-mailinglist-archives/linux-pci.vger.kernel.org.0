Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE42A5E9077
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 01:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiIXXyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 19:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIXXyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 19:54:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776AB6337;
        Sat, 24 Sep 2022 16:54:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so4610016edd.11;
        Sat, 24 Sep 2022 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0mXSnMfeVNjQFneHqdFGJj+6w+iiBhs9Bkdu6sDiEQU=;
        b=iANnP74LAxyQVethWZnfDgODX+5dE6fq6QMs8mGDI5l6cw1c9cQFOWc3JxxmP+Mc5s
         PdmhByIyW/v1Zk4B94dKTRkIN4dBBtB2YkqLUUepJbVjU+hYtQ8DnU2E8KNgLGjfHwTl
         Le6NS8A99xbFnxoCyPc8az5lKTtL3vzypaeV6eDDQbWnnDtnNsClk7dQPyoV69TdpR4o
         8hMDkM9/S4kuwBakYu1/1L6mxI5mCKMVv2nyS3ZJSThy/w8uDzWdu9kgINXYxyjbA6JV
         HUGW79vNM8AuRJiIQOZQX0gsA2ugpEv4DD+rZyPXkokaj+zwqx8MWUJv4Vw3t2ghKp1X
         XAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0mXSnMfeVNjQFneHqdFGJj+6w+iiBhs9Bkdu6sDiEQU=;
        b=ZsHrszWhcwVgLw3+n0GOmi+k+3z1eKdtsrZXFmaZTpSJkGf8z8tootK17/zjfFya7b
         nDUmsTDCFgdXU7cb3cG9z2AQPWXK3E07aEjmeXsEN/4nvVYc1xsuRBHAxSDYcsSt3NNU
         gmkcUIuzNavAn6W6IzhbZ70f37r05XRQHa935sETHFVxxtPdHxpJCkQrR19uihoba68a
         7EFzo6SFMDNxe0ud9Vly4zRhVrrCuAkjbb37+Hp1K/kaDBHpAR03fAlkMAV+OurGafYz
         3h/OqfEAs1mlohisokf8TJLGtasZWxqSXj9+mFI6RqRyfJ2CxlVR+8QcJHPtrla8tWih
         jJKg==
X-Gm-Message-State: ACrzQf2xik7HttERrBUZREUVrz8TAzfTWq63dMq08HfOzqzPXZxWiz4r
        8FMForEdXkKLoWtPdvVtmIIB3nOVye819wXhjyQ=
X-Google-Smtp-Source: AMsMyM6DcJJAMrnBKem6sLEoV26hkG+23rCJbpzoUviy2u5rEfnQA9dAQNQz90nzB4wrJjLnfjObxoZMJr7Y3S6fTW8=
X-Received: by 2002:a05:6402:1e8c:b0:44f:f70:e75e with SMTP id
 f12-20020a0564021e8c00b0044f0f70e75emr15227460edf.405.1664063674960; Sat, 24
 Sep 2022 16:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org> <20220924160302.285875-6-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220924160302.285875-6-dmitry.baryshkov@linaro.org>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Sat, 24 Sep 2022 16:54:23 -0700
Message-ID: <CAPOBaE548e669mbg5vM+ZoAgOz+g4eKRRODcRXRX-r+cdMf1yQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] PCI: qcom: Setup PHY to work in RC mode
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
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
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
> used in the RC mode.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han


> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 66886dc6e777..1027281bd6ff 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -1494,6 +1495,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>         if (ret)
>                 return ret;
>
> +       ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +       if (ret)
> +               goto err_deinit;
> +
>         ret = phy_power_on(pcie->phy);
>         if (ret)
>                 goto err_deinit;
> --
> 2.35.1
>
