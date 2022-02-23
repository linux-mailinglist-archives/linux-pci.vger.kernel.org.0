Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD88E4C0F41
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiBWJb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 04:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiBWJbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 04:31:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D0124BFB;
        Wed, 23 Feb 2022 01:31:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08A8F1042;
        Wed, 23 Feb 2022 01:31:27 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598CD3F5A1;
        Wed, 23 Feb 2022 01:31:25 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:31:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 4/5] PCI: qcom: Add interconnect support to
 2.7.0/1.9.0 ops
Message-ID: <20220223093119.GA26626@lpieralisi>
References: <20211218141024.500952-1-dmitry.baryshkov@linaro.org>
 <20211218141024.500952-5-dmitry.baryshkov@linaro.org>
 <Yfv7gh8YycxH2Wtm@ripper>
 <527f0365-1544-ad73-cf49-b839ae629340@linaro.org>
 <20220211161208.GB448@lpieralisi>
 <YhV2EhQvReObX/4J@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhV2EhQvReObX/4J@ripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 03:47:30PM -0800, Bjorn Andersson wrote:
> On Fri 11 Feb 08:12 PST 2022, Lorenzo Pieralisi wrote:
> 
> > On Fri, Feb 04, 2022 at 05:38:33PM +0300, Dmitry Baryshkov wrote:
> > > On 03/02/2022 18:57, Bjorn Andersson wrote:
> > > > On Sat 18 Dec 06:10 PST 2021, Dmitry Baryshkov wrote:
> > > > 
> > > > > Add optional interconnect support for the 2.7.0/1.9.0 hosts. Set the
> > > > > bandwidth according to the values from the downstream driver.
> > > > > 
> > > > 
> > > > What memory transactions will travel this path? I would expect there to
> > > > be two different paths involved, given the rather low bw numbers I
> > > > presume this is the config path?
> > > 
> > > I think so. Downstream votes on this path for most of the known SoCs. Two
> > > spotted omissions are ipq8074 and qcs404.
> > > 
> > > > 
> > > > Is there no vote for the data path?
> > > 
> > > CNSS devices can vote additionally on the MASTER_PCI to memory paths:
> > > For sm845 (45 = MASTER_PCIE):
> > >                 qcom,msm-bus,vectors-KBps =
> > >                         <45 512 0 0>,
> > >                         <45 512 600000 800000>; /* ~4.6Gbps (MCS12) */
> > > 
> > > On sm8150/sm8250 qca bindings do not contain a vote, but wil6210 does (100 =
> > > MASTER_PCIE_1):
> > >                 qcom,msm-bus,vectors-KBps =
> > >                         <100 512 0 0>,
> > >                         <100 512 600000 800000>; /* ~4.6Gbps (MCS12) */
> > > 
> > > For sm8450 there are two paths used by cnss:
> > > 		<&pcie_noc MASTER_PCIE_0 &pcie_noc SLAVE_ANOC_PCIE_GEM_NOC>,
> > > 		<&gem_noc MASTER_ANOC_PCIE_GEM_NOC &mc_virt SLAVE_EBI1>;
> > > 
> > > with multiple entries per each path.
> > > 
> > > So, I'm not sure about these values.
> > 
> > This discussion is gating the series, please let me know if you want me
> > to cherry-pick the other patches or you will resend the series.
> > 
> 
> Please pick the other patches and I'll work with Dmitry to conclude how
> this is actually connected to the busses inside the SoC.

Hi,

can you resend the series without this patch rebased on top of
v5.17-rc1 please ?

Thanks,
Lorenzo

> 
> Thanks,
> Bjorn
> 
> > Lorenzo
> > 
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> > > > >   1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index d8d400423a0a..55ac3caa6d7d 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -12,6 +12,7 @@
> > > > >   #include <linux/crc8.h>
> > > > >   #include <linux/delay.h>
> > > > >   #include <linux/gpio/consumer.h>
> > > > > +#include <linux/interconnect.h>
> > > > >   #include <linux/interrupt.h>
> > > > >   #include <linux/io.h>
> > > > >   #include <linux/iopoll.h>
> > > > > @@ -167,6 +168,7 @@ struct qcom_pcie_resources_2_7_0 {
> > > > >   	struct clk *pipe_clk_src;
> > > > >   	struct clk *phy_pipe_clk;
> > > > >   	struct clk *ref_clk_src;
> > > > > +	struct icc_path *path;
> > > > >   };
> > > > >   union qcom_pcie_resources {
> > > > > @@ -1121,6 +1123,10 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > > > >   	if (IS_ERR(res->pci_reset))
> > > > >   		return PTR_ERR(res->pci_reset);
> > > > > +	res->path = devm_of_icc_get(dev, "pci");
> > > > 
> > > > The paths are typically identified using a string of the form
> > > > <source>-<destination>.
> > > > 
> > > > 
> > > > I don't see the related update to the DT binding for the introduction of
> > > > the interconnect.
> > > > 
> > > > Regards,
> > > > Bjorn
> > > > 
> > > > > +	if (IS_ERR(res->path))
> > > > > +		return PTR_ERR(res->path);
> > > > > +
> > > > >   	res->supplies[0].supply = "vdda";
> > > > >   	res->supplies[1].supply = "vddpe-3v3";
> > > > >   	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> > > > > @@ -1183,6 +1189,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > > >   	if (pcie->cfg->pipe_clk_need_muxing)
> > > > >   		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> > > > > +	if (res->path)
> > > > > +		icc_set_bw(res->path, 500, 800);
> > > > > +
> > > > >   	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> > > > >   	if (ret < 0)
> > > > >   		goto err_disable_regulators;
> > > > > @@ -1241,6 +1250,8 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> > > > >   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > > >   	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > > > +	if (res->path)
> > > > > +		icc_set_bw(res->path, 0, 0);
> > > > >   	/* Set TCXO as clock source for pcie_pipe_clk_src */
> > > > >   	if (pcie->cfg->pipe_clk_need_muxing)
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > 
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
