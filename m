Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560A7C523B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjJKLhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjJKLhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:37:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83394
        for <linux-pci@vger.kernel.org>; Wed, 11 Oct 2023 04:37:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7ab31fb8bso29478787b3.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Oct 2023 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697024228; x=1697629028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADnQSRKfiE11Fw6NWJPg4jyr5BhP2bgI5UYJpaw9Vtc=;
        b=DSI5lwUwDGyERG61xBXpUKSy3GvB/kfAiO+etSzyzwvKW7xInaTSA5mMhXMj4UTCGj
         56ph2HQPIykn15aWXu4RdNCQ6i6VnEbzP9NZV6mqxkNXck8kJd7F8BQXN+Ug4RM3FeE2
         OkXA5YAVaHycYoGtI8kUGVIR42GEyf4RQzfTY3JTBW6a84+wuHiIV9Ju5ZIXmFdrvhnR
         +8pHhBHViQZNAWFR6NIwlC8sBhI1oDJaBRLkyV2T7rLbbHeCLKAKDsed9qIUkKfZ9vLG
         wJbHF5vecCFG0w4mzYWYIy6rFyUZl8fB+6goZHXEtnjFpS3LsAhbvojpFkW6pUduu4zg
         NCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024228; x=1697629028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADnQSRKfiE11Fw6NWJPg4jyr5BhP2bgI5UYJpaw9Vtc=;
        b=XOtqbRZVSN0g2/deRk8SYVXit806VahYpU+1Wk3LoQJ1WN36iqRHewv8DresdW1VjF
         DqEMPDrAIR4gPGIIfYMNMA4P4jPg6+223LcEkDtmYqj5VCMJaVnfi9nB18awz1nnBazg
         IUWliBL95B4aiNGn1UP93kBCvhj500pPSVI/NXUJ9rQ8p4BGyqxi3KmCeD3IJR+oIhxo
         aJAG7kapg7xeYg6O8HlGJ9NNIKOQPYtXaUDdZ5hiuQMf3HgcMlA9I1C/F2d8D2mECMz8
         AZoPY0uTqLiCX3y5aZL3Fi6N6FKFH2m5oF1FM4zMa337CinfUSD+SO05ftcdMSe+F01Y
         fjRw==
X-Gm-Message-State: AOJu0YwVAUw65t5+0GErINm23yTQNfIbVy8CSvZ/4H9Ayc/Vx32cw/jb
        g6+kAsR3UZTdyAZd9cFuYkmNpgV4PdfvCNUvqr0itg==
X-Google-Smtp-Source: AGHT+IFRpepGKSGvXbAwCvg5/0it467EZf0qhpiwowhNbkcbVmcXi8gnzAdqnBvYtzILhbVKUdAlRHR97OtZsiekmHc=
X-Received: by 2002:a5b:20d:0:b0:d15:7402:f7cd with SMTP id
 z13-20020a5b020d000000b00d157402f7cdmr19392771ybl.27.1697024228604; Wed, 11
 Oct 2023 04:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <1697023109-23671-1-git-send-email-quic_msarkar@quicinc.com> <1697023109-23671-3-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1697023109-23671-3-git-send-email-quic_msarkar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 14:36:55 +0300
Message-ID: <CAA8EJpoLxeSvxjcyq1BMR9XuAffrxLmO-eaBYJ+Fhnb4zYmxUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] phy: qcom-qmp-pcie: add endpoint support for sa8775p
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Oct 2023 at 14:19, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> Add support for dual lane end point mode PHY found on sa8755p platform.
>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 41 ++++++++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h |  2 ++
>  2 files changed, 43 insertions(+)

Two minor questions.

>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index a63ca74..962b4a1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2147,6 +2147,38 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl[]
>         QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
>  };
>
> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_BG_TIMER, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYS_CLK_CTRL, 0x07),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x27),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x17),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x19),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE0, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_CMN_MODE, 0x14),

I should check whether we miss QSERDES_V5_COM_CMN_MODE in
sm8450_qmp_gen4x2_pcie_ep_serdes_tbl, which is otherwise nearly
identical.
Also do you need to set QSERDES_V5_COM_CORE_CLK_EN here?

> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0xff),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x09),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x19),
> +       QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x28),
> +};
> +
> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
> +};

This is the same as sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl

> +
> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V5_PCS_INSIG_MX_CTRL7, 0x00),
> +       QMP_PHY_INIT_CFG(QPHY_V5_PCS_INSIG_SW_CTRL7, 0x00),
> +};

Could you please confirm that these registers belong to the V5
namespace rather than V5_20 one?

> +
>  struct qmp_pcie_offsets {
>         u16 serdes;
>         u16 pcs;
> @@ -3043,6 +3075,15 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
>                 .pcs_misc_num   = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
>         },
>
> +       .tbls_ep = &(const struct qmp_phy_cfg_tbls) {
> +               .serdes         = sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl,
> +               .serdes_num     = ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl),
> +               .pcs_misc       = sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl,
> +               .pcs_misc_num   = ARRAY_SIZE(sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl),
> +               .pcs            = sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl,
> +               .pcs_num        = ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl),
> +       },
> +
>         .reset_list             = sdm845_pciephy_reset_l,
>         .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> index 36cc80b..6ee1c33 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> @@ -11,6 +11,8 @@
>  #define QPHY_V5_PCS_PCS_STATUS1                                0x014
>  #define QPHY_V5_PCS_POWER_DOWN_CONTROL                 0x040
>  #define QPHY_V5_PCS_START_CONTROL                      0x044
> +#define QPHY_V5_PCS_INSIG_SW_CTRL7                     0x060
> +#define QPHY_V5_PCS_INSIG_MX_CTRL7                     0x07c
>  #define QPHY_V5_PCS_LOCK_DETECT_CONFIG1                        0x0c4
>  #define QPHY_V5_PCS_LOCK_DETECT_CONFIG2                        0x0c8
>  #define QPHY_V5_PCS_LOCK_DETECT_CONFIG3                        0x0cc
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
