Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7A68BF95
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjBFOIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 09:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBFOHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 09:07:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252C2BED9
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 06:05:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10855709wmb.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2023 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1sBDHSdASz4ecLzalMdlfELS8RCcYMZ2sk1AegZ7C4=;
        b=gUDkn0Nk6osoDg6kBIqb4HgThjeRoU3B4yStY9UPgtkSB4y1icRX/nUz/3C0iAIpEm
         MEDJnt9vnKjADTSJTi/kI8xh0D1PAvXE7gH5tvVQcf8lgVPHzvsc5HnaQOH1XCzK8HqA
         iLF14vnXPg2R+rqK6qe3qmaCI98vVcpebABOShNnLKS3xsvXq448T7tqXjuyVVxuKx9g
         yMS5bniysbumzLDbyVXjr/7YPXLCHBoUeOW+P4N/JovSFBu+zje1qoxWataFiEkxgOE+
         ofZGWBbvJfP+qu1nMsNHPX/6rHYDCqnit3Br9d1aFXvJkdUEMDG8tGXoizjtkjstYorr
         zWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1sBDHSdASz4ecLzalMdlfELS8RCcYMZ2sk1AegZ7C4=;
        b=0my1/2DWh3HBmRctHkrAeffIfOwjVKCYxvYn61rhsPUpliWJN8DQ5apVNnTBdQ27OG
         YYyJMKL0raeq0LWpwycKoFWILy2Rkt1OKuiG47eeGQ/h8cbs3JA8azv3xSuA3rJJoLIe
         W7hV0Wy4y0cHez/5PHCRrgZvLrmptUXl8pvCHXbep0qEF+/Tvcev2O6rjJGKW4W4fVSV
         FR7P8zPpFULwODxbK3JRmPg3Qp34qe0sazcnSx2w3hbVA22w8Jcdtgb/+mJ2yoFssNL1
         nxwev8ZA2a2tiQAZDLZCXHOzHEKqSSfZ64aVWGz5OBpQU08J4q/LCgxmKKp0TO6IP90B
         Js/Q==
X-Gm-Message-State: AO0yUKUtRNYiKeiJb9WJhFGs7IQ5VYm26o9rZD2a01UJ65nT5Dy7HX0S
        D8E4KSos7s9AVrCDqbS32TVZmg==
X-Google-Smtp-Source: AK7set8CdDqbiahcj1npFpmbebayGsvVRXrv4P1LiTprnhax7cXuxebkMZ+iX0ubTVrxQMT9rjIupw==
X-Received: by 2002:a05:600c:3849:b0:3d5:365b:773e with SMTP id s9-20020a05600c384900b003d5365b773emr20826426wmr.39.1675692304690;
        Mon, 06 Feb 2023 06:05:04 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm15917337wmc.31.2023.02.06.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:05:04 -0800 (PST)
Date:   Mon, 6 Feb 2023 16:05:02 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v7 08/12] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y+EJDofgt6I/abyp@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-9-abel.vesa@linaro.org>
 <Y9zU2jBdSD72W28F@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zU2jBdSD72W28F@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23-02-03 10:33:14, Johan Hovold wrote:
> On Fri, Feb 03, 2023 at 10:18:03AM +0200, Abel Vesa wrote:
> > Add the SM8550 both g4 and g3 configurations. In addition, there is a
> > new "lane shared" table that needs to be configured for g4, along with
> > the No-CSR list of resets.
> 
> Could you add a comment about the new nocsr reset and how it is used
> here?
>  
> > Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > 
> > This patchset relies on the following patchset:
> > https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> > 
> > The v6 of this patch is:
> > https://lore.kernel.org/all/20230202123902.3831491-9-abel.vesa@linaro.org/
> > 
> > Changes since v6:
> >  * none
> > 
> > Changes since v5:
> >  * renmaed the no-CSR reset to "phy_nocsr" as discussed off-list with
> >    Bjorn and Johan
> > 
> > Changes since v4:
> >  * dropped _serdes infix from ln_shrd table name and from every ln_shrd
> >    variable name
> >  * added hyphen between "no CSR" in both places
> >  * dropped has_ln_shrd_serdes_tbl
> >  * reordered qmp_pcie_offsets_v6_20 by struct members
> >  * added rollback for no-CSR reset in qmp_pcie_init fail path
> >  * moved ln_shrd offset calculation after port_b
> > 
> > Changes since v3:
> >  * added Dmitry's R-b tag
> > 
> > Changes since v2:
> >  * none
> > 
> > Changes since v1:
> >  * split all the offsets into separate patches, like Vinod suggested
> > 
> > 
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 367 ++++++++++++++++++++++-
> >  1 file changed, 365 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 907f3f236f05..ff6c0b526fde 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
> >  	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
> >  };
> 
[...]
> 
> >  
> > @@ -2214,6 +2469,68 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
> >  	.phy_status		= PHYSTATUS_4_20,
> >  };
> >  
> > +static const struct qmp_phy_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
> > +	.lanes = 2,
> > +
> > +	.offsets		= &qmp_pcie_offsets_v5,
> 
> Did you really intend to use the v5 offsets here? It seems you use v6.20
> defines in the tables below. This may work but it looks a little strange
> and does not match how we name and use these resources for the other
> SoCs (e.g. reusing structures and defines from older IP revisions is
> fine, but not necessarily the other way round).

So here is what is happening here. The actual IP block version is 6 for
the g3x2. The offsets of the tables are the same as on v5, but the
actual offsets of some of the registers within those tables are
entirely different. Now, if you compare the PCS PCIe offsets (v5 vs v6)
you'll notice that all v6 registers currently added are the same as v5
(both names and values). With that in mind, we still need to keep the v6
offsets for the case when a new register, that might not be in v5, might
be added later on. As for the table offsets, since they look the same we
should probably not add a dedicated v6 one.
> 
> I assume this means that the gen3 PHY is really is really v5 and using
> a subset of the v6.20 defines happens to works as they are in fact
> identical with respect to that subset?
> 
> As you have dedicated gen3x2 tables, perhaps those should use the v5
> defines?
> 
> And at least add a comment about this in the commit message.
> 
> > +
> > +	.tbls = {
> > +		.serdes		= sm8550_qmp_gen3x2_pcie_serdes_tbl,
> > +		.serdes_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_serdes_tbl),
> > +		.tx		= sm8550_qmp_gen3x2_pcie_tx_tbl,
> > +		.tx_num		= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_tx_tbl),
> > +		.rx		= sm8550_qmp_gen3x2_pcie_rx_tbl,
> > +		.rx_num		= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_rx_tbl),
> > +		.pcs		= sm8550_qmp_gen3x2_pcie_pcs_tbl,
> > +		.pcs_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_pcs_tbl),
> > +		.pcs_misc	= sm8550_qmp_gen3x2_pcie_pcs_misc_tbl,
> > +		.pcs_misc_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_pcs_misc_tbl),
> > +	},
> > +	.clk_list		= sc8280xp_pciephy_clk_l,
> > +	.num_clks		= ARRAY_SIZE(sc8280xp_pciephy_clk_l),
> > +	.reset_list		= sdm845_pciephy_reset_l,
> > +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> > +	.vreg_list		= qmp_phy_vreg_l,
> > +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> > +	.regs			= pciephy_v5_regs_layout,
> > +
> > +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> > +	.phy_status		= PHYSTATUS,
> > +};
> > +

[...]
