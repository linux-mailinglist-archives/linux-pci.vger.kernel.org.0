Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5091672A024
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFIQ0g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbjFIQ0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 12:26:35 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288A3A91
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 09:26:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so1864707276.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Jun 2023 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686327992; x=1688919992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqmhgD0hzidkR7C4FG6ZaFcEzUFu8WFVvYV0gu30B4c=;
        b=TpWGhj1go0f01Ili2y+lD2+R5W+Ad0HWc0ntIU994go70wqgsYE0Nbjoy5+25gjpdJ
         HJWknYHWr5y/y7G73iIQZJ269NJ5e+84rcAcqX1VcSRYzXElE4lla3v4fDh90QKT5KL0
         RrQs/yyErk3CZk0hVzl5gQhjpIwcbhGkMHipsQD9Qv7u4s36a8Zia4FXm+2aT74BFrP2
         2V9mJrNVml0Kx+4g9wvMLhOjEJ+l9M2EGg/kgjmhGyFGZrPgCYYlxTODB/LfD1TRBVjp
         R7QBMcLmvwCTJKQ/n3nzOjV9xqAWK8W+/Z4AgCUrGslkw7rOK6gp2v8PR7N90DjzBUiq
         f3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327992; x=1688919992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqmhgD0hzidkR7C4FG6ZaFcEzUFu8WFVvYV0gu30B4c=;
        b=EbPT1GVr6bMXeL4A1CUA+ta/ZY2DyGMPNZBlqetnt/LRt8G5B4+LdFMgiB7mSqS/ye
         6Cub1WkLMZKPROWpe8zVQ7zNJu7pjnpRXl1V6O2wIr3kaTREMewt6Ezso1y0H14TtwVR
         HAdib5rM+Nn6udi4okcwrBDT5e1hNL9O2oh8WkmcuYWj5GPmH0TkxZCyAu9MZnqHS7Vm
         s+b1ds6qEMF3NsaAAZXdYASt2rdLbN2yYwksW+6ohwHAyAKSIcLJt+oQoKf48W+j3i15
         TA4NEFpk5WoCPWRD9ErvW5LvTLXE0aw6kPZoUHWVWdJThTHRio2ln+R6C4Icg7Ul2Icl
         WPGg==
X-Gm-Message-State: AC+VfDxz3SsFU+S4bQixBd48U76XFvMP8bs1mp9WPlqNAnIwP8FcBbuN
        ldsB3bfVETgJNU4/x/6gq5+J7HOYc7gIOK53upGNRg==
X-Google-Smtp-Source: ACHHUZ7lgaJdipRWewn4T/8Urmy4/1Lpe4YcOBI9261oG/aAVvlcVZ2sljI+94p6NxKfmsTVf8Wn8Euzot46J05NHs4=
X-Received: by 2002:a81:838c:0:b0:561:c9c1:ce with SMTP id t134-20020a81838c000000b00561c9c100cemr1775388ywf.8.1686327991956;
 Fri, 09 Jun 2023 09:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com> <1686311249-6857-4-git-send-email-quic_krichai@quicinc.com>
In-Reply-To: <1686311249-6857-4-git-send-email-quic_krichai@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 9 Jun 2023 19:26:21 +0300
Message-ID: <CAA8EJppPt8utWbF83dqMD4y2Of2ufwcpSPvdTyoDndkrbnZm3Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 9 Jun 2023 at 14:47, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Add support to vote for ICC bandwidth based on the link speed and width.
>
> This patch is inspired from pcie-qcom driver to add basic interconnect
> support.
>
> Link: https://lore.kernel.org/all/20221102090705.23634-1-johan+linaro@kernel.org/

This link should be a part of the cover letter, not the commit msg. If
you want to refer to the previous commits, please use the standard
reference: commit abcdefabc ("PCI: qcom: Make foo and bar").

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 68 +++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 19b3283..baf831f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -13,6 +13,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
> @@ -28,6 +29,7 @@
>  #define PARF_SYS_CTRL                          0x00
>  #define PARF_DB_CTRL                           0x10
>  #define PARF_PM_CTRL                           0x20
> +#define PARF_PM_STTS                           0x24
>  #define PARF_MHI_CLOCK_RESET_CTRL              0x174
>  #define PARF_MHI_BASE_ADDR_LOWER               0x178
>  #define PARF_MHI_BASE_ADDR_UPPER               0x17c
> @@ -128,6 +130,9 @@
>  /* DBI register fields */
>  #define DBI_CON_STATUS_POWER_STATE_MASK                GENMASK(1, 0)
>
> +#define DBI_LINKCTRLSTATUS                     0x80
> +#define DBI_LINKCTRLSTATUS_SHIFT               16
> +
>  #define XMLH_LINK_UP                           0x400
>  #define CORE_RESET_TIME_US_MIN                 1000
>  #define CORE_RESET_TIME_US_MAX                 1005
> @@ -178,6 +183,8 @@ struct qcom_pcie_ep {
>         struct phy *phy;
>         struct dentry *debugfs;
>
> +       struct icc_path *icc_mem;
> +
>         struct clk_bulk_data *clks;
>         int num_clks;
>
> @@ -253,9 +260,51 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>         disable_irq(pcie_ep->perst_irq);
>  }
>
> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> +{
> +       struct dw_pcie *pci = &pcie_ep->pci;
> +       u32 offset, status, bw;
> +       int speed, width;
> +       int ret;
> +
> +       if (!pcie_ep->icc_mem)
> +               return;
> +
> +       offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +       status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +       speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +       width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +       switch (speed) {
> +       case 1:
> +               bw = MBps_to_icc(250);  /* BW for GEN1 per lane: 250MBps */

Please extract these constants to the defines. This would save you
from duplicating 250 below.

> +               break;
> +       case 2:
> +               bw = MBps_to_icc(500);  /* BW for GEN2 per lane: 500MBps */
> +               break;
> +       case 3:
> +               bw = MBps_to_icc(985);  /* BW for GEN3 per lane: 985MBps */
> +               break;
> +       default:
> +               WARN_ON_ONCE(1);
> +               fallthrough;
> +       case 4:
> +               bw = MBps_to_icc(1969); /* BW for GEN4 per lane:1969MBps */
> +               break;
> +       }
> +
> +       ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
> +       if (ret) {
> +               dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +                       ret);
> +       }
> +}
> +
>  static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  {
>         int ret;
> +       struct dw_pcie *pci = &pcie_ep->pci;
>
>         ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>         if (ret)
> @@ -277,6 +326,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>         if (ret)
>                 goto err_phy_exit;
>
> +       /*
> +        * Some Qualcomm platforms require interconnect bandwidth constraints
> +        * to be set before enabling interconnect clocks.
> +        *
> +        * Set an initial average bandwidth corresponding to GEN1x1(250 MBps)
> +        * for the pcie to mem path.
> +        */
> +       ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(250));
> +       if (ret) {
> +               dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +                       ret);
> +               goto err_phy_exit;
> +       }
> +
>         return 0;
>
>  err_phy_exit:
> @@ -550,6 +613,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>         if (IS_ERR(pcie_ep->phy))
>                 ret = PTR_ERR(pcie_ep->phy);
>
> +       pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> +       if (IS_ERR(pcie_ep->icc_mem))
> +               ret = PTR_ERR(pcie_ep->icc_mem);
> +
>         return ret;
>  }
>
> @@ -572,6 +639,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>         } else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>                 dev_dbg(dev, "Received BME event. Link is enabled!\n");
>                 pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> +               qcom_pcie_ep_icc_update(pcie_ep);
>         } else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>                 dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
>                 val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
