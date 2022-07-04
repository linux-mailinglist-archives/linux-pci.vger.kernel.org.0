Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D5564CC9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 06:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiGDEse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 00:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGDEsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 00:48:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8F218A
        for <linux-pci@vger.kernel.org>; Sun,  3 Jul 2022 21:48:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id r6so3597309pfq.6
        for <linux-pci@vger.kernel.org>; Sun, 03 Jul 2022 21:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RgtyaFyEVwaxsZsz7pIZzw1ok/q2exPS8l4v9E6Z7IY=;
        b=NEvuyBg4TmcO5ULLPxWTEmw3a2drk5UV2n8oon7huoXSJZeh0jnHFkj+6thTTz5N3p
         pC/+qcZwNoOwXzP5v1nj/fjHBbBMRdykY/2PFaSFWlJBMdRFs5HCzpp3AED0T0VDpHXb
         0r7TrwsP0H5SsX0XOYLOvw3duWfaGkIuW8EJXFy3O5SXdqdJCkHYzz651u48bm9nLSvm
         B+rxXCMU+7pfQnzOu/Km4Q7Kg+iDBt8scZKdgwDBoXrf83lI4reY1sYUsN8dDeygcNU6
         rn/iJU++ZBikBYcnz2nUtuYpKv81rRGU3h7L9ahux9C/fQqIBInSXGVib1QdpXUNIGKX
         PQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RgtyaFyEVwaxsZsz7pIZzw1ok/q2exPS8l4v9E6Z7IY=;
        b=dC0uujJJNYDFUsNF6RXHCqi6czZ76+PusXj/pmEjRy9Xu+W8/et8Z1ei7yTRvJjLrN
         mFFPxy6/ULTsBtmXflOcBDeuGILqX9YfPh5TbZ4CyWl0hexuoOuGFjzPOsXljEDDgo4N
         Dp1KgMvSl5i5AWDhGMxMkzUbLF779pksYkmBOWxHLwFdHqWFeH+ekmOQB0x50ztDEeTk
         Q4kUO+g5ZJyfPbEwUzxFd2NZ1zVfiLEjd8YBPVMs7Xu+ror489Fi6Y8/EOdj1WxPEbSq
         8qmuGgxnl+0b9n5+L4onfbGMZuHC7NmyXUUGjU3JbbYIxVmzODrvt/vv2wKHWcU8e/yq
         qfgg==
X-Gm-Message-State: AJIora9odqCNflLfn2AFP0advs6sTGPCvpdgCPKrpHLaPwlC9zOCcbVC
        FcCHGudWPsD+nRkL6vwmrjEq
X-Google-Smtp-Source: AGRyM1sys5Guf0uobrJHSGN0DRnyWlD9ui1AJesJqUyeUufGcvXOLY0AAl7cWgVj/fMujeDpVXgy1A==
X-Received: by 2002:a05:6a00:15c1:b0:525:2db4:2a2c with SMTP id o1-20020a056a0015c100b005252db42a2cmr32669053pfu.30.1656910110736;
        Sun, 03 Jul 2022 21:48:30 -0700 (PDT)
Received: from thinkpad ([220.158.158.244])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b00168c52319c3sm20047700pln.149.2022.07.03.21.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:48:30 -0700 (PDT)
Date:   Mon, 4 Jul 2022 10:18:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add system PM support
Message-ID: <20220704044824.GB6560@thinkpad>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
 <20220630043415.GA5012@thinkpad>
 <4b1631f9-220f-c378-164c-f7eea9db22ef@quicinc.com>
 <20220704044406.GA6560@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220704044406.GA6560@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 10:14:06AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 30, 2022 at 03:29:33PM +0530, Krishna Chaitanya Chundru wrote:
> > 
> > On 6/30/2022 10:04 AM, Manivannan Sadhasivam wrote:
> > > On Wed, Jun 29, 2022 at 03:03:33PM +0530, Krishna chaitanya chundru wrote:
> > > > Add suspend and resume pm callbacks.
> > > > 
> > > > When system suspends, and if the link is in L1ss, disable the clocks
> > > > so that system enters into low power state to save the maximum power.
> > > > And when the system resumes, enable the clocks back if they are
> > > > disabled in the suspend path.
> > > > 
> > > Why only during L1ss and not L2/L3?
> > 
> > with aspm the link will automatically go to L1ss. for L2/L3 entry we need to
> > explicitly send
> > 
> > PME turn off which we are not doing now. So we are checking only for L1ss.
> > 
> 
> Okay, please mention this in the commit message.
> 
> > > 
> > > > Changes since v1:
> > > > 	- Fixed compilation errors.
> > > > 
> > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 81 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 6ab9089..8e9ef37 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -41,6 +41,9 @@
> > > >   #define L23_CLK_RMV_DIS				BIT(2)
> > > >   #define L1_CLK_RMV_DIS				BIT(1)
> > > > +#define PCIE20_PARF_PM_STTS                     0x24
> > > > +#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB    BIT(8)
> > > > +
> > > >   #define PCIE20_PARF_PHY_CTRL			0x40
> > > >   #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
> > > >   #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> > > > @@ -190,6 +193,8 @@ struct qcom_pcie_ops {
> > > >   	void (*post_deinit)(struct qcom_pcie *pcie);
> > > >   	void (*ltssm_enable)(struct qcom_pcie *pcie);
> > > >   	int (*config_sid)(struct qcom_pcie *pcie);
> > > > +	int (*enable_clks)(struct qcom_pcie *pcie);
> > > > +	int (*disable_clks)(struct qcom_pcie *pcie);
> > > I think these could vary between platforms. Like some other platform may try to
> > > disable regulators etc... So use names such as suspend and resume.
> > Sure will change in the next patch.
> > > >   };
> > > >   struct qcom_pcie_cfg {
> > > > @@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
> > > >   	unsigned int has_ddrss_sf_tbu_clk:1;
> > > >   	unsigned int has_aggre0_clk:1;
> > > >   	unsigned int has_aggre1_clk:1;
> > > > +	unsigned int support_pm_ops:1;
> > > >   };
> > > >   struct qcom_pcie {
> > > > @@ -209,6 +215,7 @@ struct qcom_pcie {
> > > >   	struct phy *phy;
> > > >   	struct gpio_desc *reset;
> > > >   	const struct qcom_pcie_cfg *cfg;
> > > > +	unsigned int is_suspended:1;
> > > Why do you need this flag? Is suspend going to happen multiple times in
> > > an out-of-order manner?
> > 
> > We are using this flag in the resume function to check whether we suspended
> > and disabled
> > 
> > the clocks in the suspend path. And we want to use this flag to control the
> > access to dbi etc
> > 
> > after suspend.
> > 
> 
> Okay. The DBI access patch is not included in this series, so you should
> mention it in the commit message.
> 

Ah, it is the patch 2/2. Still you can mention the reasoning.

Thanks,
Mani

> Thanks,
> Mani
> 
> > > >   };
> > > >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > > @@ -1308,6 +1315,23 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
> > > >   	clk_disable_unprepare(res->pipe_clk);
> > > >   }
> > > [...]
> > > 
> > > > +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> > > > +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
> > > Use the new macro: NOIRQ_SYSTEM_SLEEP_PM_OPS
> > Will update in the next patch.
> > > > +};
> > > > +
> > > >   static const struct of_device_id qcom_pcie_match[] = {
> > > >   	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
> > > >   	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> > > > @@ -1679,6 +1759,7 @@ static struct platform_driver qcom_pcie_driver = {
> > > >   	.probe = qcom_pcie_probe,
> > > >   	.driver = {
> > > >   		.name = "qcom-pcie",
> > > > +		.pm = &qcom_pcie_pm_ops,
> > > There will be warnings when CONFIG_PM_SLEEP is not set. So use below,
> > will update in the next patch.
> > > 
> > > 		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > >   		.suppress_bind_attrs = true,
> > > >   		.of_match_table = qcom_pcie_match,
> > > >   	},
> > > > -- 
> > > > 2.7.4
> > > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
