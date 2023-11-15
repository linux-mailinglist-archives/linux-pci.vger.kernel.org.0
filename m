Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB017EC377
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 14:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjKONTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 08:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343883AbjKONTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 08:19:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB5121
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 05:19:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso7331173276.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054339; x=1700659139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+vRJLB0hwLsR22GJa22gbqqqBV/RS9yq52QAFcn89A4=;
        b=AT7Il+4/Vc9UMl7zKbOkhp9mIgRyNWa8lM5Pd5eDBpLTyIG6c5EWykCy4Jz2nDN2Xw
         rCugxvs0nwP9rwOXLpjShAHPOU4haXwozNKnkWAFpFEsUti1JGEx88MU1C1GB6s1+PRF
         595kxfXGWFFY6d1BVaXveIsYXGJggay8ln4KYO6r7OPa3XToPtnAX4YAmSGuUk3o0e7C
         b1014Z3DW40hvucUrn+pCcpLanshl0SpRsxfRqVKU43bEikI1VkmpAgqBWxmXDl52rFF
         k+0OFYt5ubo5I2MDjAYkdKWAAeGybDbZ6vCI6sZeSy1UOjzT4Qnf0GFYW9owr2skASW1
         VZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054339; x=1700659139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vRJLB0hwLsR22GJa22gbqqqBV/RS9yq52QAFcn89A4=;
        b=C2euCXUqnB4BIYAlGwpT42xlh0VD1dzpWhNlGm1YAH8+SaPutniHgSdyBUhDLoP1U4
         D5exz05/uw5ZsSVi8U1pLI3r/kY1/XMBBIWrsHWxOq1x26VA1ixn+j9UM+4/8MN0qYkK
         EpvEOJAX70HbzKve3WC9SCyh8pTWGiCU/BjeLbwTWbpCg2viGG476ZUpmw3w0yC57Nfw
         esxCs2LJYmHxvM4cf5lHPYTURU4NGKg2J+i/mJwwZynMjW1sLZwwzGd9TdTgK8/9gDUK
         pLo0zvDZBEnWbONJPdcRIilnmSnqN/uLkHssipXiRSMJyf7oh58B3enn5KZyfYy0hFY9
         SDoA==
X-Gm-Message-State: AOJu0YxNO0MFTpmgEpUmf9Exb9zviXkfOiLVoAd52wbGUvO2MTT1scyE
        dQfn1gGvYTBT35EWBL6yZWm2HLxqxfgO8BL2EK0EWQ==
X-Google-Smtp-Source: AGHT+IGOjBUPEL3sJdbPpkrzRws6EeLvSwt7JJzox80aXGm6pK08NYMtazbM3pQlXjKvCVPrQERzRicT0Vnoo5tx1rA=
X-Received: by 2002:a25:db90:0:b0:d7f:1749:9e59 with SMTP id
 g138-20020a25db90000000b00d7f17499e59mr13214940ybf.11.1700054339341; Wed, 15
 Nov 2023 05:18:59 -0800 (PST)
MIME-Version: 1.0
References: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com> <1700051821-1087-2-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1700051821-1087-2-git-send-email-quic_msarkar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 15:18:48 +0200
Message-ID: <CAA8EJprWP3ThYyPZDF7ddG9Awdk9D7ovxes--r0VS3Ma53VqxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Nov 2023 at 14:37, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> This change will enable cache snooping logic to support
> cache coherency for 8775 RC platform.
>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6902e97..b82ccd1 100644
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
> @@ -117,6 +118,10 @@
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN                               BIT(8)
>
> +/* PARF_NO_SNOOP_OVERIDE register fields */
> +#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
> +#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define DEVICE_TYPE_RC                         0x4
>
> @@ -961,6 +966,14 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +       struct dw_pcie *pci = pcie->pci;
> +       struct device *dev = pci->dev;
> +
> +       /* Enable cache snooping for SA8775P */
> +       if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))

Quoting my feedback from v1:

Obviously: please populate a flag in the data structures instead of
doing of_device_is_compatible(). Same applies to the patch 2.


> +               writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
> +                               pcie->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
> +
>         qcom_pcie_clear_hpc(pcie->pci);
>
>         return 0;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
