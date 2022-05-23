Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D770C5312CE
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiEWOC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiEWOC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 10:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CF57B04;
        Mon, 23 May 2022 07:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C0561157;
        Mon, 23 May 2022 14:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335C5C385A9;
        Mon, 23 May 2022 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653314573;
        bh=RkSQAvT6iGaYqMCtUKQAEe+1+01nDpIt7OqDZcU8qY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2kcypZI41hTazZ6CAz411upsqV43DcV+23+7En2GCLoIbQ59eCkHZeRZfKNqIEOY
         819CX17eKNIAG8WGmctn/QonH3Rqb2CcjW9tXcLqeaCRNhcJcgEIKNIk+kj2vM3tFa
         LxzDiUdHrsPBvtK3KeEj6cjr5/GqjJAFePMGu21QSRkSnpybMBq2qw3Erpbj5+U13n
         2Gqp7XGgB8bKKNC2OiD471qd1pUbmI6yy4kyXozVooUIvMJ0gtCfZSzYrBl1nJpACX
         i2wGXHgc3ON1gwJ6Kq4JiNwf1yMLTQQxwi/AKyPIcym3eYOyRWSncMqEAlFu2E9aHR
         BC0KkeAG3pD9A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt8e2-0000sB-9O; Mon, 23 May 2022 16:02:50 +0200
Date:   Mon, 23 May 2022 16:02:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 3/7] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <YouUCuzjo5u+OEXS@hovoldconsulting.com>
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
 <20220520183114.1356599-4-dmitry.baryshkov@linaro.org>
 <Yos9fkgxAN1jJ4jO@hovoldconsulting.com>
 <8ce50a9f-241d-c37a-15e9-1a97d410f61e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce50a9f-241d-c37a-15e9-1a97d410f61e@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 04:39:56PM +0300, Dmitry Baryshkov wrote:
> On 23/05/2022 10:53, Johan Hovold wrote:
> > On Fri, May 20, 2022 at 09:31:10PM +0300, Dmitry Baryshkov wrote:

> >> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
> >> +{
> >> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >> +	struct device *dev = pci->dev;
> >> +	struct platform_device *pdev = to_platform_device(dev);
> >> +	int irq;
> >> +	u32 ctrl;
> >> +
> >> +	irq = platform_get_irq_byname_optional(pdev, split_msi_names[0]);
> >> +	if (irq == -ENXIO)
> >> +		return -ENXIO;
> > 
> > You still need to check for other errors and -EPROBE_DEFER here.
> 
> I think even the if (irq < 0) return irq; will work here.

No need to print errors unless -EPROBEDEFER as you do below?

> >> +
> >> +	pp->msi_irq[0] = irq;
> >> +
> >> +	/* Parse as many IRQs as described in the DTS. */
> > 
> > s/DTS/devicetree/
> > 
> >> +	for (ctrl = 1; ctrl < MAX_MSI_CTRLS; ctrl++) {
> >> +		irq = platform_get_irq_byname_optional(pdev, split_msi_names[ctrl]);
> >> +		if (irq == -ENXIO)
> >> +			break;
> >> +		if (irq < 0)
> >> +			return dev_err_probe(dev, irq,
> >> +					     "Failed to parse MSI IRQ '%s'\n",
> >> +					     split_msi_names[ctrl]);
> >> +
> >> +		pp->msi_irq[ctrl] = irq;
> >> +	}
> >> +
> >> +	pp->num_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
> >> +
> >> +	return 0;
> >> +}

Johan
