Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669D5520EE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiFTP3c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbiFTP3b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 11:29:31 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4E9B8F
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 08:29:29 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i17so9697201qvo.13
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VndZVtq5GR8zAUTTPcriPZTsvb65boEMepiu1YlJlU=;
        b=e+aI3OnbMi7dROFiNyQpARD46xR1ZpoaOYC+mTGz52e4ier/93ErjJLvX1YuCh3P9G
         iay/akhVM++PXFIyheVi7JhXXMu66Qe4khLKYQ4Z/VZetL77bKQAanpNkA0oG8DHYw6X
         EjVX4iEZuxd6plQKxiQyRMXf619L0u5kAVr8lriKyWeFjQ4dPZIUqoCCcdIa/m83mze/
         2tnL8wqqT+Ja/UgO3+P6faR6Du5WXPX9DS/YXr0hzNV0oKhtnRHhhSPDhVKC1UkrULEQ
         Xj+BK3NmGfWK+DAcj+Gug244HkM3Lie1hYgXH8HQqsKG4KTdWV8l46aq1P6KoepSvr28
         q2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VndZVtq5GR8zAUTTPcriPZTsvb65boEMepiu1YlJlU=;
        b=ypn1uPxTwhGqIFxnKYRNCQL2/6uBXYjrxB/WZ7R+9K/uMO3FajnSiwsFYeHO1zj+6D
         GBtNDcRBJ4YkktmZunlHoEpw5MpUjmLUflyuLxmL0iOhMD07OBzclXU7UxxcmjZEH50l
         Erxuekos7y4iizxFqe11QCnbA+3q8DP0s2rl75S2zHIbFM6ZDkb/JaE0LPICFCj86w4H
         a8TRCI0SN5mb3PRtnVLoshugN3tKZRDUt+pS4OJR+HgbdZXUv9VDaHXWKy79PWiPi3DF
         rA0Q7uBbK1SAhpUfi3Kcy8528VwfWPanI2TBSzD5lhR50X+zHkmAOe2HKvEWNOEPqvux
         AdMA==
X-Gm-Message-State: AJIora/A8K3kTnUi4Ex5RBFh5k+1ERBXA2bQ1VkSF92p0HQkF+mdcUyr
        3GEd/CdQeLLwfZq3ecUBoVWk44eagObb1EM9lMtKUw==
X-Google-Smtp-Source: AGRyM1tdVpp7xvSw4FOS/ZCTUWJ61lnNFgxg2ZTAAv4XYtQW3PrOGtPyWsT2mwBT4mb4dNri1J2G990AtCSKCiKulGE=
X-Received: by 2002:ac8:598f:0:b0:305:8f8:2069 with SMTP id
 e15-20020ac8598f000000b0030508f82069mr20510425qte.370.1655738968648; Mon, 20
 Jun 2022 08:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150759.11507-1-johan+linaro@kernel.org>
In-Reply-To: <20220620150759.11507-1-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 20 Jun 2022 18:29:17 +0300
Message-ID: <CAA8EJpr02CGRLyafkVV6V=0mchbfQga2=YiE_MkhuLE9veUj3w@mail.gmail.com>
Subject: Re: [PATCH] PCI: qcom: Drop unused post-init callbacks
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 20 Jun 2022 at 18:19, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Drop the unused post_init and post_deinit callbacks that were added for
> the now removed pipe clock handling.

I think the IPQ60xx PCIe support is intended to use post_init
callback. See [1]. That is the reason why I left the post_init in
place, while reworking the pipe clocks handling.

[1] https://lore.kernel.org/linux-arm-msm/a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il/

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>
> Now that Bjorn has merged the pipe clock series:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/qcom
>
> the post_init and post_deinit callbacks can also be removed.
>
> Note that this one depends on the patch adding support for modular
> builds:
>
>         https://lore.kernel.org/all/20220519094646.23009-1-johan+linaro@kernel.org/
>
> which has been reviewed by Rob and should be ready to be picked up.
>
> Johan
>
>
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ff1b40f213c1..fe701da32119 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -180,9 +180,7 @@ struct qcom_pcie;
>  struct qcom_pcie_ops {
>         int (*get_resources)(struct qcom_pcie *pcie);
>         int (*init)(struct qcom_pcie *pcie);
> -       int (*post_init)(struct qcom_pcie *pcie);
>         void (*deinit)(struct qcom_pcie *pcie);
> -       void (*post_deinit)(struct qcom_pcie *pcie);
>         void (*ltssm_enable)(struct qcom_pcie *pcie);
>         int (*config_sid)(struct qcom_pcie *pcie);
>  };
> @@ -1331,27 +1329,18 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>         if (ret)
>                 goto err_deinit;
>
> -       if (pcie->cfg->ops->post_init) {
> -               ret = pcie->cfg->ops->post_init(pcie);
> -               if (ret)
> -                       goto err_disable_phy;
> -       }
> -
>         qcom_ep_reset_deassert(pcie);
>
>         if (pcie->cfg->ops->config_sid) {
>                 ret = pcie->cfg->ops->config_sid(pcie);
>                 if (ret)
> -                       goto err;
> +                       goto err_assert_reset;
>         }
>
>         return 0;
>
> -err:
> +err_assert_reset:
>         qcom_ep_reset_assert(pcie);
> -       if (pcie->cfg->ops->post_deinit)
> -               pcie->cfg->ops->post_deinit(pcie);
> -err_disable_phy:
>         phy_power_off(pcie->phy);
>  err_deinit:
>         pcie->cfg->ops->deinit(pcie);
> @@ -1362,8 +1351,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  static void qcom_pcie_host_deinit(struct qcom_pcie *pcie)
>  {
>         qcom_ep_reset_assert(pcie);
> -       if (pcie->cfg->ops->post_deinit)
> -               pcie->cfg->ops->post_deinit(pcie);
>         phy_power_off(pcie->phy);
>         pcie->cfg->ops->deinit(pcie);
>  }
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
