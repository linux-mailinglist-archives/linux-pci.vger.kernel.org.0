Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F924C0579
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 00:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiBVXo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 18:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiBVXo5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 18:44:57 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F16343
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 15:44:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id j24so14215117oii.11
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 15:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2HiSrIrQ1FQn06c0OapcW9y56mOF/g4gtSbzfTG410w=;
        b=jk4Ug7dsiFNMwcv0iHUor6gWcK9nlcHXQMezySXYtupQYoteOPzSraSjWsSJShCBCx
         9RYxkIFF8YB/+rKvvn6Kv5zzg5Gw2Q5EszvE52/u+GZJNfZRxQIPErr8Qo2kvsjp6yPG
         ht+nyAp9/C/rOCnFoaCZqCaMPWzemmmNTKy6Kw9XOCZ+TOYgiq+pzOfhRv4kQkxV3oXj
         8ol0Q1/joLsPlccdxq/NY3bHtGhsznQDVluHHTolsT9uCkvYlSuN3nZFszk65P2xu8vb
         uDAWReg1FixkLmvUgcQfJcPdnfXnir7vsggnM7WjePDi9rxERYF1TUHYwWrv1Xeel/Pq
         9TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2HiSrIrQ1FQn06c0OapcW9y56mOF/g4gtSbzfTG410w=;
        b=rLqht8lB1Kks7aWkTBUZWutXkX6r8O9fLE2B7AG01y81SG4RQFHVRnftlmVNZqQZvV
         TXuStKY3IkTvSjPXeU6PlRY7Uixkj2dCL5BclHSmOV2tx42zwK12VDCMV62/OFaLAcQY
         eghRXwBVO/HPA4QqxdXeIWgdAcHoLUAjBGkpFafYyug5SQEtkGWUSU+DtP0pZUYIj+Hk
         4vVYmQFkNDZkaM0M5Mb21VZKTFsUg5T+XlQMOjnj5tNY6PUArawnQ2LhdgOTJP2QkocG
         AG3ZGtLzEsq7XQiULXBIJYj7iCeYlzvcmT4iSRcy5Piz9Kyr8yM/ODQcDtCbxm1aRAY4
         djnQ==
X-Gm-Message-State: AOAM530kcO43efr5NkVEKdzeAN5QWZ+4zZ2E9QZXpt1HwdZ+mUneKFyK
        bJ0zEO9WqMYP20M0uaGKwDUa4V+L+uCOOw==
X-Google-Smtp-Source: ABdhPJx1m+LL1F1f71SPcAhuEeWQJkXdbUvm0ew8/RmL5Jkyus0biW/zkBLUEXvsYbdYJZrEDLL7kA==
X-Received: by 2002:a05:6808:612:b0:2d5:1c6a:db4 with SMTP id y18-20020a056808061200b002d51c6a0db4mr3417179oih.199.1645573470217;
        Tue, 22 Feb 2022 15:44:30 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t17sm3820423ots.38.2022.02.22.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:44:29 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:46:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 4/5] PCI: qcom: Add interconnect support to
 2.7.0/1.9.0 ops
Message-ID: <YhV11gk/9+q0AVsb@ripper>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
 <Yfv7gh8YycxH2Wtm@ripper>
 <527f0365-1544-ad73-cf49-b839ae629340@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527f0365-1544-ad73-cf49-b839ae629340@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 04 Feb 06:38 PST 2022, Dmitry Baryshkov wrote:

> On 03/02/2022 18:57, Bjorn Andersson wrote:
> > On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:
> > 
> > > Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
> > > bandwidth according to the values from the downstream driver.
> > > 
> > 
> > What memory transactions will travel this path? I would expect there to
> > be two different paths involved, given the rather low bw numbers I
> > presume this is the config path?
> 
> I think so. Downstream votes on this path for most of the known SoCs. Two
> spotted omissions are ipq8074 and qcs404.
> 

Sorry, missed your reply on this one.

> > 
> > Is there no vote for the data path?
> 
> CNSS devices can vote additionally on the MASTER_PCI to memory paths:
> For sm845 (45 = MASTER_PCIE):
>                 qcom,msm-bus,vectors-KBps =
>                         <45 512 0 0>,
>                         <45 512 600000 800000>; /* ~4.6Gbps (MCS12) */
> 
> On sm8150/sm8250 qca bindings do not contain a vote, but wil6210 does (100 =
> MASTER_PCIE_1):
>                 qcom,msm-bus,vectors-KBps =
>                         <100 512 0 0>,
>                         <100 512 600000 800000>; /* ~4.6Gbps (MCS12) */

This is PCIe -> DDR, so I think we should interconnect-names this path
"pci-ddr". I also see that on at least some platforms the value depends
on PCIe Gen. So perhaps we should start by just picking these values for
now and then follow up with something where we add the numbers in an
opp-table based on Gen?

> 
> For sm8450 there are two paths used by cnss:
> 		<&pcie_noc MASTER_PCIE_0 &pcie_noc SLAVE_ANOC_PCIE_GEM_NOC>,
> 		<&gem_noc MASTER_ANOC_PCIE_GEM_NOC &mc_virt SLAVE_EBI1>;
> 
> with multiple entries per each path.
> 
> So, I'm not sure about these values.
> 

That seems to be PCIe to master and then a separate segment for the
memory NoC to DDR. That's odd. I think we should attempt to just do:

 <&pcie_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>

As a single path for "pci-ddr"

> > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index d8d400423a0a..55ac3caa6d7d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -12,6 +12,7 @@
> > >   #include <linux/crc8.h>
> > >   #include <linux/delay.h>
> > >   #include <linux/gpio/consumer.h>
> > > +#include <linux/interconnect.h>
> > >   #include <linux/interrupt.h>
> > >   #include <linux/io.h>
> > >   #include <linux/iopoll.h>
> > > @@ -167,6 +168,7 @@ struct qcom_pcie_resources_2_7_0 {
> > >   	struct clk *pipe_clk_src;
> > >   	struct clk *phy_pipe_clk;
> > >   	struct clk *ref_clk_src;
> > > +	struct icc_path *path;
> > >   };
> > >   union qcom_pcie_resources {
> > > @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > >   	if (IS_ERR(res->pci_reset))
> > >   		return PTR_ERR(res->pci_reset);
> > > +	res->path = devm_of_icc_get(dev, "pci");
> > 
> > The paths are typically identified using a string of the form
> > <source>-<destination>.
> > 
> > 
> > I don't see the related update to the DT binding for the introduction of
> > the interconnect.
> > 
> > Regards,
> > Bjorn
> > 
> > > +	if (IS_ERR(res->path))
> > > +		return PTR_ERR(res->path);
> > > +
> > >   	res->supplies[0].supply = "vdda";
> > >   	res->supplies[1].supply = "vddpe-3v3";
> > >   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> > > @@ -1183,6 +1189,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > >   	if (pcie->cfg->pipe_clk_need_muxing)
> > >   		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> > > +	if (res->path)
> > > +		icc_set_bw(res->path, 500, 800);

But that said, these numbers doesn't resemble the numbers you show
above and they don't make sense for the "data path". So perhaps this is
a separate "pci-config" path?

Regards,
Bjorn

> > > +
> > >   	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> > >   	if (ret < 0)
> > >   		goto err_disable_regulators;
> > > @@ -1241,6 +1250,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> > >   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > >   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > +	if (res->path)
> > > +		icc_set_bw(res->path, 0, 0);
> > >   	/* Set TCXO as clock source for pcie_pipe_clk_src */
> > >   	if (pcie->cfg->pipe_clk_need_muxing)
> > > -- 
> > > 2.34.1
> > > 
> 
> 
> -- 
> With best wishes
> Dmitry
