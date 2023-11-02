Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28A07DF686
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjKBPep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjKBPeo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 11:34:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF3192
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 08:34:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7b91faf40so12872157b3.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Nov 2023 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698939275; x=1699544075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3chS4WFn6t5Osuo6EZKGIpuiS6r6Z9yZqIAr6Fa9kQ=;
        b=w0Uwig8boqWpKNGKZ6GiC7OEIfGZexyjAsA2QtWyupbB2Jrb5QCTqzxYpgIHpAERZH
         EINnjMxifjXdRUm0oxmFoWKl+dxqBXktwIH8DSWQ69StJzP0FnZO5rA0piZpzyz39isZ
         kRRQTcmD7nf+AJ5t/ec/eLLIVZEU7O9cXnMWww4s5tWPkgFNe1jnffZXfrVHiHTICpCW
         YKMA2wvdzvLMWh3elv0/DAjX8iUH0YUXJlh64u6lp8XoHUGShc/GUu5vE8VM187WWGi8
         EciqCTPAaPhA3lf9X7qErnYo2THmIJ3ngEQRMbg+wTPUvaQTSL3aY4k/9Rlbxd5a2JFj
         CIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939275; x=1699544075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3chS4WFn6t5Osuo6EZKGIpuiS6r6Z9yZqIAr6Fa9kQ=;
        b=dLrGzKjLKEcaiZt1YJRFH1KcT5aJaDQVDMQzkuHQPRuTU4fKqF2wVctqt1NWZLxxlx
         i4D3YYrz0RmMOjjhnS3nC6hbFlCckDZf/WnmA2JlPPHuxvHh762+oR2P2gJ/8ttzAahA
         Zy+8Zw9PwFqwXBwAlyYLWxPdqTPBP1rTvWAAF+9nRYnprjteoqO6mOBcOrDXPahCHj4/
         ysevW+/r9DzDehnJIHZgb3mWOYs39r++dubtSOrNpuG2Z8S7ispIX/LbstYAMYpGahm/
         /e0kKBAxb1NDc68vY5Jpf+ncB2nj8Q7InDpwwpiJkvI6w0jf0OZkMPybhezkk5YUKYhA
         VYEw==
X-Gm-Message-State: AOJu0YwnHBAp4fh6iQ5SiQcr7AkBk5hV35Y4xhepePVU+jlF2kccfYab
        o4hi5EuX+Y02jkosO9+6VrMtI4EiHm5xuwlkCbfYUw==
X-Google-Smtp-Source: AGHT+IESALVaI6Qz1FWKgn4RYXzJ/2hBAMuTHCluByrOIvvXU2zb8gdwX9gH93u33RiE+WEJNenhW4vreYCHFnVe6sk=
X-Received: by 2002:a81:a08a:0:b0:5b3:3109:36f6 with SMTP id
 x132-20020a81a08a000000b005b3310936f6mr47533ywg.44.1698939275131; Thu, 02 Nov
 2023 08:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com> <1698767186-5046-2-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1698767186-5046-2-git-send-email-quic_msarkar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Nov 2023 17:34:24 +0200
Message-ID: <CAA8EJpoMoUvF8R3PjgCNijS6-8Gs5FjvC6dYerNBVBuYW3FmPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 31 Oct 2023 at 17:46, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> This change will enable cache snooping logic to support
> cache coherency for SA8755P RC platform.
>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6902e97..6f240fc 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -51,6 +51,7 @@
>  #define PARF_SID_OFFSET                                0x234
>  #define PARF_BDF_TRANSLATE_CFG                 0x24c
>  #define PARF_SLV_ADDR_SPACE_SIZE               0x358
> +#define PCIE_PARF_NO_SNOOP_OVERIDE             0x3d4
>  #define PARF_DEVICE_TYPE                       0x1000
>  #define PARF_BDF_TO_SID_TABLE_N                        0x2000
>
> @@ -117,6 +118,9 @@
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN                               BIT(8)
>
> +/* PARF_NO_SNOOP_OVERIDE register value */
> +#define NO_SNOOP_OVERIDE_EN                    0xa
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define DEVICE_TYPE_RC                         0x4
>
> @@ -961,6 +965,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +       struct dw_pcie *pci = pcie->pci;
> +       struct device *dev = pci->dev;
> +
> +       /* Enable cache snooping for SA8775P */
> +       if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))

Obviously: please populate a flag in the data structures instead of
doing of_device_is_compatible(). Same applies to the patch 2.

> +               writel(NO_SNOOP_OVERIDE_EN, pcie->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
> +
>         qcom_pcie_clear_hpc(pcie->pci);
>
>         return 0;



-- 
With best wishes
Dmitry
