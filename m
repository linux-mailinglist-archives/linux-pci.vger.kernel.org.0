Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0E615DFE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKBIjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiKBIix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 04:38:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A124F1C;
        Wed,  2 Nov 2022 01:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CB8B82150;
        Wed,  2 Nov 2022 08:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED05C433C1;
        Wed,  2 Nov 2022 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667378327;
        bh=5tIOilhXJzbK3/vyyGeg8c8YvcxszLaehkHfuDnIWBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oes3hak5XcG2JoCfEKV/oqEhhdNxEL7VWmnvyy53smF+dOz9dMQ4AgkV2ookUlVZZ
         duka9et+fYPbSAQQ9cDB++VBGJDkDV2EXAA4lJMA2udhvSqOaMm3b5QKGB2eb2ab5l
         3t4GSgImcdNbi+CoAnBu4HR8OHiA/MsIa25dfVOuN0Wr+lY0eE/eDb+b1Xtql7K9s4
         TLX9cRJAGID+fdqpJeAHaBchWChttlIA290zBQtThRoWCsY9k1RTAYjAQJgHAiVH9l
         fOTzRQ+DodXhjOjUq29yaR6AzLtA7EAR64cR4EaKhiQKLAF8iYgitL3t/rqLSZtkPD
         L+UZ9kJN/udKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oq9GY-0002r2-MB; Wed, 02 Nov 2022 09:38:31 +0100
Date:   Wed, 2 Nov 2022 09:38:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add basic interconnect support
Message-ID: <Y2IshhNv6JlhCbkp@hovoldconsulting.com>
References: <20221021064616.6380-1-johan+linaro@kernel.org>
 <20221021064616.6380-3-johan+linaro@kernel.org>
 <20221101143529.GA244012@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101143529.GA244012@thinkpad>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 01, 2022 at 08:05:29PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 21, 2022 at 08:46:16AM +0200, Johan Hovold wrote:
> > On Qualcomm platforms like SC8280XP and SA8540P, interconnect bandwidth
> > must be requested before enabling interconnect clocks.
> > 
> > Add basic support for managing an optional "pcie-mem" interconnect path
> > by setting a low constraint before enabling clocks and updating it after
> > the link is up.
> > 
> > Note that it is not possible for a controller driver to set anything but
> > a maximum peak bandwidth as expected average bandwidth will vary with
> > use case and actual use (and power policy?). This very much remains an
> > unresolved problem with the interconnect framework.
> > 
> > Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
> > path for now as it is not clear what an appropriate constraint would be
> > (and the system does not crash when left unspecified).
 
> > +static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> > +{
> > +	struct dw_pcie *pci = pcie->pci;
> > +	int ret;
> > +
> > +	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> > +	if (IS_ERR(pcie->icc_mem)) {
> > +		ret = PTR_ERR(pcie->icc_mem);
> > +		return ret;
> 
> return PTR_ERR(pcie->icc_mem);

Sure.

> > +	}
> > +
> > +	/*
> > +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> > +	 * to be set before enabling interconnect clocks.
> > +	 *
> > +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> > +	 * for the pcie-mem path.
> > +	 */
> > +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> > +	if (ret) {
> > +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > +			ret);
> 
> Move "ret);" to prior line. No need to keep up within 80 columns.

80 chars is still a soft limit and in this case there's no real gain in
terms of readability from breaking it.

But sure, I can remove the line break.
 
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> > +{
> > +	struct dw_pcie *pci = pcie->pci;
> > +	u32 offset, status, bw;
> > +	int speed, width;
> > +	int ret;
> > +
> > +	if (!pcie->icc_mem)
> > +		return;
> > +
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> > +
> > +	/* Only update constraints if link is up. */
> > +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > +		return;
> 
> What if the link comes back later? I'd suggest to call this function from
> qcom_pcie_link_up(), whenever link is up.

I actually tried that initially but realised it doesn't work.

First, the link-up callback can be called in atomic context which
prevents using icc_set_bw() directly (this can be worked around of
course).

Second, the link-up callback isn't even called if the link comes up
later.

If anyone needs this to deal with FPGA-type use cases when the link
comes up later, then dwc3 core would need to be extended first. 
 
> > +
> > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> > +
> > +	switch (speed) {
> > +	case 1:
> > +		bw = MBps_to_icc(250);
> > +		break;
> > +	case 2:
> > +		bw = MBps_to_icc(500);
> > +		break;
> > +	default:
> > +	case 3:
> 
> Why do you need explicit "case 3" and not just default case?

Because it's the gen3 bandwidth which is set in case the controller
ever reports anything else but the supported gen1, gen2 or gen3 speed
here.

I first had a WARN_ON_ONCE() here as an aid to anyone ever extending the
driver with support for gen4, but then removed it in case there are any
misbehaving controllers out there. I guess I can add it back and see if
anyone complains.

> > +		bw = MBps_to_icc(985);
> > +		break;
> > +	}
> > +
> > +	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
> > +	if (ret) {
> > +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > +			ret);

Johan
