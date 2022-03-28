Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97B4E99E2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiC1OlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiC1OlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 10:41:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A098010DE;
        Mon, 28 Mar 2022 07:39:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64A03D6E;
        Mon, 28 Mar 2022 07:39:26 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.8.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C22083F73B;
        Mon, 28 Mar 2022 07:39:24 -0700 (PDT)
Date:   Mon, 28 Mar 2022 15:39:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, bhelgaas@google.com,
        svarbanov@mm-sol.com, robh@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for handling MSIs from 8 endpoints
Message-ID: <YkHInU1dE7BtB0tX@lpieralisi>
References: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
 <20220223100145.GA26873@lpieralisi>
 <20220328142012.GB17663@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328142012.GB17663@thinkpad>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 07:50:12PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 23, 2022 at 10:01:45AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Dec 14, 2021 at 03:43:19PM +0530, Manivannan Sadhasivam wrote:
> > > The DWC controller used in the Qcom Platforms are capable of addressing the
> > > MSIs generated from 8 different endpoints each with 32 vectors (256 in
> > > total). Currently the driver is using the default value of addressing the
> > > MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
> > > num_vectors field of pcie_port structure.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Need an ACK from qcom maintainers.
> > 
> 
> Looks like this patch was not applied eventhough the Acks were received.
> Please let me know if I need to resubmit it for next cycle.

Sorry. I will merge it for the next cycle, nothing to do if it rebases
cleanly, otherwise I will ping you.

Thanks,
Lorenzo

> 
> Thanks,
> Mani
> 
> > Thanks,
> > Lorenzo
> > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 1c3d1116bb60..8a4c08d815a5 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1550,6 +1550,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >  	pci->dev = dev;
> > >  	pci->ops = &dw_pcie_ops;
> > >  	pp = &pci->pp;
> > > +	pp->num_vectors = MAX_MSI_IRQS;
> > >  
> > >  	pcie->pci = pci;
> > >  
> > > -- 
> > > 2.25.1
> > > 
