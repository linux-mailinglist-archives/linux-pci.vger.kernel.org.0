Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E66CDA82
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjC2NUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjC2NUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 09:20:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A549DC;
        Wed, 29 Mar 2023 06:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CC62B8232F;
        Wed, 29 Mar 2023 13:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427BDC433EF;
        Wed, 29 Mar 2023 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680095976;
        bh=O0z0dBr9m7/smzN1kDckMnCWvN9J4splqSi12REletk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+wMFHngnFWub/dc9SVaNkQTKfr9gt4dhGZo7AZrDyrHVxMHQQQSgggkSYGfSOhE7
         pZ1q67+irukhXZ3jCev+Nbb+dHm8ZODzTXPo5R9mwgQ2t+BAcpSUxIkpk/EiOW+9D2
         1IlaECETKcmzSpTE/ckLxTePJs7QE3wC+jjnIA8VdEK08ccRQ8xZatvUlY5ZYEC0W2
         AX0CFUPpeEZQa3c3pQy7u0q+NWjFtNzq5QyJiK+b6/6w2cKwL6dIZHk+qQjIzhPGGh
         jWVr9z/ibizjYbzYwTWPsAiTtadzDAh+DH34V5DAKpCgIqQHD58n0x+qrSUHGkGYzH
         k8MHoHIdx3giQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1phViR-0007c1-SU; Wed, 29 Mar 2023 15:19:51 +0200
Date:   Wed, 29 Mar 2023 15:19:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 1/1] PCI: qcom: Add support for system suspend and
 resume
Message-ID: <ZCQ69xyQ4mwTow1W@hovoldconsulting.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <ZCQLWzqKPrusMro+@hovoldconsulting.com>
 <20230329125232.GB5575@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329125232.GB5575@thinkpad>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 06:22:32PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 29, 2023 at 11:56:43AM +0200, Johan Hovold wrote:
> > On Mon, Mar 27, 2023 at 07:08:24PM +0530, Manivannan Sadhasivam wrote:
 
> > > +static int qcom_pcie_suspend_noirq(struct device *dev)
> > > +{
> > > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Set minimum bandwidth required to keep data path functional during
> > > +	 * suspend.
> > > +	 */
> > > +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> > 
> > This isn't really the minimum bandwidth you're setting here.
> > 
> > I think you said off list that you didn't see real impact reducing the
> > bandwidth, but have you tried requesting the real minimum which would be
> > kBps_to_icc(1)?
> > 
> > Doing so works fine here with both the CRD and X13s and may result in
> > some further power savings.
> > 
> 
> No, we shouldn't be setting random value as the bandwidth. Reason is, these
> values are computed by the bus team based on the requirement of the interconnect
> paths (clock, voltage etc...) with actual PCIe Gen speeds. I don't know about
> the potential implication even if it happens to work.

Why would you need PCIe gen1 speed during suspend?

These numbers are already somewhat random as, for example, the vendor
driver is requesting 500 kBps (800 peak) during runtime, while we are
now requesting five times that during suspend (the vendor driver gets a
away with 0).

Sure, this indicates that the interconnect driver is broken and we
should indeed be using values that at least makes some sense (and
eventually fix the interconnect driver).

Just not sure that you need to request that much bandwidth during
suspend (e.g. for just a couple of register accesses).

Johan
