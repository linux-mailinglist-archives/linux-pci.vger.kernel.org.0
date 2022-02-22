Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60D4C057D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 00:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiBVXp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 18:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiBVXp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 18:45:58 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8DDEA0
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 15:45:31 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so10763544oti.5
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cmsRrWwzrQv3gMJ4N18EGVNpjJmfIvBVGVuIwDsI4bg=;
        b=s20ySE/OqEIu+s9WQyxiUwpdqpGyYu4yNSpQ81BRyu365f16tbQI14hBPwvm0qVPjy
         r/QkTKVJMOOdweRBZvdBwVZx2WeNP88wBuYM7XR6JZGDAhS2WXV6gVUtr37zBC3ui+gB
         OsCAr9fiMYNUJ1l8GjemZcgHe5FPuaqAagLFLtWWdDeF1jMTE9bycqsK9eb/v0m/P/gX
         n/V/FUt7hpojpEQtp+pKV++pZktmgTbupsJarBc704kckybyYXvQt8eKlgcUGB8UXX74
         AhnbPkowAr02Es+JDRElEG0TluCZD/Dc9N87kHsZbiEJghYKWXUc55gUjXXj+urzDbR9
         0o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cmsRrWwzrQv3gMJ4N18EGVNpjJmfIvBVGVuIwDsI4bg=;
        b=7n+ch1Jw6CQZbfnlAGcp8a501tdQFi9lSqTnHfHKdXHyqQgpptXe/RDCSy/elhFE/o
         mrA9euWSbxjlGMIXS19mxv/DmUAddpTNTVpePrBsFudv+fts4yYSh/QBj3Y7A2YCKYdB
         QNNKXu0ZYFozscqGysNFplxQMYxA3L33g4GFskU9rGV7DlUXm4A6GymBUd0VbIxs/1g6
         isqJBSSRCfwJTxosrHZY03aghQEQYe5kPmS0wBSja1nptCY6EcW81R7VVNCTh1sT7ACZ
         SIUVF2l+g/V9JXqUo+Ub25zYQ0ECXipwKdM+lqQxavNy3Hx5+mozjufLQAEKMc0NYjxc
         KgIA==
X-Gm-Message-State: AOAM532FB4WZWNh12+3mt4WbbKz73LQVXDRNiltHD0zCONvtmByvD2uo
        kc9nffN0bvjn0X0UI6tHk1lWLA==
X-Google-Smtp-Source: ABdhPJzRrBj19AnSO5X3bi/rkXuZ6iZK1ftdF/7G6DTbKFm3oyrdzXI0PZ62x3IJREJRKf4txMEMcA==
X-Received: by 2002:a05:6830:342:b0:5af:186d:f947 with SMTP id h2-20020a056830034200b005af186df947mr4680326ote.94.1645573530157;
        Tue, 22 Feb 2022 15:45:30 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id m18sm6961150otq.31.2022.02.22.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:45:29 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:47:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 4/5] PCI: qcom: Add interconnect support to
 2.7.0/1.9.0 ops
Message-ID: <YhV2EhQvReObX/4J@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
 <Yfv7gh8YycxH2Wtm@ripper>
 <527f0365-1544-ad73-cf49-b839ae629340@linaro.org>
 <20220211161208.GB448@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211161208.GB448@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 11 Feb 08:12 PST 2022, Lorenzo Pieralisi wrote:

> On Fri, Feb 04, 2022 at 05:38:33PM +0300, Dmitry Baryshkov wrote:
> > On 03/02/2022 18:57, Bjorn Andersson wrote:
> > > On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:
> > > 
> > > > Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
> > > > bandwidth according to the values from the downstream driver.
> > > > 
> > > 
> > > What memory transactions will travel this path? I would expect there to
> > > be two different paths involved, given the rather low bw numbers I
> > > presume this is the config path?
> > 
> > I think so. Downstream votes on this path for most of the known SoCs. Two
> > spotted omissions are ipq8074 and qcs404.
> > 
> > > 
> > > Is there no vote for the data path?
> > 
> > CNSS devices can vote additionally on the MASTER_PCI to memory paths:
> > For sm845 (45 = MASTER_PCIE):
> >                 qcom,msm-bus,vectors-KBps =
> >                         <45 512 0 0>,
> >                         <45 512 600000 800000>; /* ~4.6Gbps (MCS12) */
> > 
> > On sm8150/sm8250 qca bindings do not contain a vote, but wil6210 does (100 =
> > MASTER_PCIE_1):
> >                 qcom,msm-bus,vectors-KBps =
> >                         <100 512 0 0>,
> >                         <100 512 600000 800000>; /* ~4.6Gbps (MCS12) */
> > 
> > For sm8450 there are two paths used by cnss:
> > 		<&pcie_noc MASTER_PCIE_0 &pcie_noc SLAVE_ANOC_PCIE_GEM_NOC>,
> > 		<&gem_noc MASTER_ANOC_PCIE_GEM_NOC &mc_virt SLAVE_EBI1>;
> > 
> > with multiple entries per each path.
> > 
> > So, I'm not sure about these values.
> 
> This discussion is gating the series, please let me know if you want me
> to cherry-pick the other patches or you will resend the series.
> 

Please pick the other patches and I'll work with Dmitry to conclude how
this is actually connected to the busses inside the SoC.

Thanks,
Bjorn

> Lorenzo
> 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> > > >   1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index d8d400423a0a..55ac3caa6d7d 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -12,6 +12,7 @@
> > > >   #include <linux/crc8.h>
> > > >   #include <linux/delay.h>
> > > >   #include <linux/gpio/consumer.h>
> > > > +#include <linux/interconnect.h>
> > > >   #include <linux/interrupt.h>
> > > >   #include <linux/io.h>
> > > >   #include <linux/iopoll.h>
> > > > @@ -167,6 +168,7 @@ struct qcom_pcie_resources_2_7_0 {
> > > >   	struct clk *pipe_clk_src;
> > > >   	struct clk *phy_pipe_clk;
> > > >   	struct clk *ref_clk_src;
> > > > +	struct icc_path *path;
> > > >   };
> > > >   union qcom_pcie_resources {
> > > > @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > > >   	if (IS_ERR(res->pci_reset))
> > > >   		return PTR_ERR(res->pci_reset);
> > > > +	res->path = devm_of_icc_get(dev, "pci");
> > > 
> > > The paths are typically identified using a string of the form
> > > <source>-<destination>.
> > > 
> > > 
> > > I don't see the related update to the DT binding for the introduction of
> > > the interconnect.
> > > 
> > > Regards,
> > > Bjorn
> > > 
> > > > +	if (IS_ERR(res->path))
> > > > +		return PTR_ERR(res->path);
> > > > +
> > > >   	res->supplies[0].supply = "vdda";
> > > >   	res->supplies[1].supply = "vddpe-3v3";
> > > >   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> > > > @@ -1183,6 +1189,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > >   	if (pcie->cfg->pipe_clk_need_muxing)
> > > >   		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> > > > +	if (res->path)
> > > > +		icc_set_bw(res->path, 500, 800);
> > > > +
> > > >   	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> > > >   	if (ret < 0)
> > > >   		goto err_disable_regulators;
> > > > @@ -1241,6 +1250,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> > > >   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > >   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > > +	if (res->path)
> > > > +		icc_set_bw(res->path, 0, 0);
> > > >   	/* Set TCXO as clock source for pcie_pipe_clk_src */
> > > >   	if (pcie->cfg->pipe_clk_need_muxing)
> > > > -- 
> > > > 2.34.1
> > > > 
> > 
> > 
> > -- 
> > With best wishes
> > Dmitry
