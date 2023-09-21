Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6527AA58A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIUXUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjIUXUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 19:20:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462083326;
        Thu, 21 Sep 2023 10:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D23C116CB;
        Thu, 21 Sep 2023 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695285550;
        bh=SRktlw97rAUxXvmGZYe3/jusIyIMFE7ZdMCiBS5jEGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crg4JG5LjedFtliw5QRvtI7SuUOmrrTBU+sHkBFQwYAKW8BwtVoP7z2ZeOOKtHjP7
         1tCR0qfp2JfJ1IqYaY7uOBsOiTPTFP0I6ptfLB1BtsOZ1RPvio2SzKn7ueQona0vTj
         WCcngKA0W+mDqjk30/xRyTNQFN80zqTumpd6YfSeEHlntqWw4CIipoM+j0dxDHPujl
         NUKxajPOP7KzwemqUufWx4FlS/JXCg8xABT5xtQRUBeHWc8fFYH+LV7fYfoh7XUbgD
         hW4/uMKVDOKp5KVyRlZouLkIZTcnEi99l4G3rR1Ryqa++3Lkls8uA5Ku3heJh5zPlb
         JcM0+hhDpddiQ==
Date:   Thu, 21 Sep 2023 10:39:01 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 3/5] phy: qcom-qmp-pcie: add endpoint support for
 sa8775p
Message-ID: <20230921083901.GC2891@thinkpad>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-4-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1695218113-31198-4-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 07:25:10PM +0530, Mrinmay Sarkar wrote:
> Add support for dual lane end point mode PHY found on sa8755p platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 41 ++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h         |  2 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h |  1 +
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index a63ca74..351047c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2147,6 +2147,38 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x4_pcie_rc_serdes_alt_tbl[]
>  	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CLK_SELECT, 0x34),
>  };
>  
> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BG_TIMER, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYS_CLK_CTRL, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x27),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x17),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE1, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CMN_MODE, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x28),
> +};
> +
> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_INSIG_MX_CTRL7, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_INSIG_SW_CTRL7, 0x00),
> +};
> +
>  struct qmp_pcie_offsets {
>  	u16 serdes;
>  	u16 pcs;
> @@ -3043,6 +3075,15 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x2_pciephy_cfg = {
>  		.pcs_misc_num	= ARRAY_SIZE(sa8775p_qmp_gen4_pcie_rc_pcs_misc_tbl),
>  	},
>  
> +	.tbls_ep = &(const struct qmp_phy_cfg_tbls) {
> +		.serdes		= sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl,
> +		.serdes_num	= ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_serdes_alt_tbl),
> +		.pcs_misc	= sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(sa8775p_qmp_gen4_pcie_ep_pcs_misc_tbl),
> +		.pcs		= sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl,
> +		.pcs_num	= ARRAY_SIZE(sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl),
> +	},
> +
>  	.reset_list		= sdm845_pciephy_reset_l,
>  	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> index 36cc80b..2b33dc7 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> @@ -30,5 +30,7 @@
>  #define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
>  #define QPHY_V5_PCS_EQ_CONFIG3				0x1e4
>  #define QPHY_V5_PCS_EQ_CONFIG5				0x1ec
> +#define QPHY_V5_PCS_INSIG_MX_CTRL7			0x07c
> +#define QPHY_V5_PCS_INSIG_SW_CTRL7			0x060

Sort the defines please, here and below.

- Mani

>  
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h
> index c8afdf7..ad587c8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h
> @@ -120,5 +120,6 @@
>  #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
>  #define QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
>  #define QSERDES_V5_COM_RESERVED_1			0x1c0
> +#define QSERDES_V5_COM_PLL_CMN_MODE			0x1a0
>  
>  #endif
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
