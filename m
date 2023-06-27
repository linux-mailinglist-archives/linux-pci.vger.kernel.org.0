Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05473FD1F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjF0NrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjF0NrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 09:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ABE2115;
        Tue, 27 Jun 2023 06:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6044B61195;
        Tue, 27 Jun 2023 13:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C56C433C8;
        Tue, 27 Jun 2023 13:46:57 +0000 (UTC)
Date:   Tue, 27 Jun 2023 19:16:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230627134648.GD5490@thinkpad>
References: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
 <1686752666-13426-4-git-send-email-quic_krichai@quicinc.com>
 <20230623053448.GA5611@thinkpad>
 <9495a254-a219-fdd8-2c6e-ac147075813e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9495a254-a219-fdd8-2c6e-ac147075813e@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 06:33:01AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 6/23/2023 11:04 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jun 14, 2023 at 07:54:26PM +0530, Krishna chaitanya chundru wrote:
> > > Add support to vote for ICC bandwidth based on the link
> > > speed and width.
> > > 
> > > This patch is inspired from pcie-qcom driver to add basic
> > > interconnect support.
> > > 
> > > Reference: commit c4860af88d0c ("PCI: qcom: Add basic interconnect
> > > support").
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom-ep.c | 73 +++++++++++++++++++++++++++++++
> > >   1 file changed, 73 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > index 19b3283..5d146ec 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c

[...]

> > > +	/*
> > > +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> > > +	 * to be set before enabling interconnect clocks.
> > > +	 *
> > > +	 * Set an initial average bandwidth corresponding to GEN1x1
> > Keep the comment same as the other driver.
> done
> > > +	 * for the pcie to mem path.
> > > +	 */
> > > +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> > > +	if (ret) {
> > > +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > > +			ret);
> > > +		goto err_phy_exit;
> > PHY should be powered off in the case of error.
> > 
> > Rest looks good.
> > 
> > - Mani
> 
> For platforms which need ICC it is must to vote for interconnect so better
> to power off in case of error.
> 

That's what I'm also suggesting. Currently used err_phy_exit path doesn't power
off the PHY.

- Mani

> -KC
> 
> > > +	}
> > > +
> > >   	return 0;
> > >   err_phy_exit:
> > > @@ -550,6 +618,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
> > >   	if (IS_ERR(pcie_ep->phy))
> > >   		ret = PTR_ERR(pcie_ep->phy);
> > > +	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> > > +	if (IS_ERR(pcie_ep->icc_mem))
> > > +		ret = PTR_ERR(pcie_ep->icc_mem);
> > > +
> > >   	return ret;
> > >   }
> > > @@ -572,6 +644,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
> > >   	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
> > >   		dev_dbg(dev, "Received BME event. Link is enabled!\n");
> > >   		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> > > +		qcom_pcie_ep_icc_update(pcie_ep);
> > >   	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
> > >   		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
> > >   		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> > > -- 
> > > 2.7.4
> > > 

-- 
மணிவண்ணன் சதாசிவம்
