Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3A49E592
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiA0PQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 10:16:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37272 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiA0PQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 10:16:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F15960C44;
        Thu, 27 Jan 2022 15:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4C8C340E4;
        Thu, 27 Jan 2022 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643296592;
        bh=6zdI64JO16o4OH7ihIB0tyhcoVY66C9Jpg96cHbKPds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hACrKDFLEvnRX2070s40MHT2rdBP6mAneFCTf5+sefDmyVuNOGFCIC+g+qN1028um
         /Ibeid44iPpekMbYboRKsakO/x6MVfzNQPdB8yJ8JzSZHsykf5XfI+XmzMPOip4Ju0
         INLL1ozY5XoDNN765dpagbrWTf0+RrXW5U/q+eEfv1zHAyHfbAD2zItMPuvBXue1T9
         q7ELjwNJJMEOe7G0mZ3FhoPBZbjGulwhA+2755cC+5ztRRFM22NZkifhGHTmP84frZ
         IDdxkI2cDy2xYx4dpEivf0rNZ975DUGdHd/fbKBcjeU8R//VHo6dQjRLWNeGX0XY9N
         9Slo4T7bqdY5g==
Date:   Thu, 27 Jan 2022 09:16:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI: qcom: add support for IPQ60xx PCIe controller
Message-ID: <20220127151630.GA100574@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735lc9r9d.fsf@tarshish>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 25, 2022 at 09:41:45AM +0200, Baruch Siach wrote:
> On Mon, Jan 24 2022, Bjorn Helgaas wrote:
> > On Mon, Jan 24, 2022 at 06:27:31PM +0200, Baruch Siach wrote:

> >> +static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >> +	struct device *dev = pcie->pci->dev;
> >> +	int ret;
> >> +
> >> +	ret = reset_control_assert(res->rst);
> >> +	if (ret) {
> >> +		dev_err(dev, "reset assert failed (%d)\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	usleep_range(2000, 2500);
> >
> > Where do these sleep durations come from?  If they're specified
> > somewhere by PCIe, can you include a citation, e.g., a section number
> > in the spec.
> 
> As I mentioned before, I have no access to hardware documentation. I'm
> only porting working code from downstream kernel.
> 
> In a comment on v4 Bjorn Andersson mentioned "datasheet stating the
> minimum timing of the operations to be performed to get the PCIe
> controller into a known (clean) state".

Sorry if I'm repeating questions.  We can help avoid that by adding a
brief comment here like "black magic copied from working code at X" or
whatever you *do* know.  Repeated questions are wasted effort for both
the author and reviewers.

Sleeps with unsourced durations are always suspect because nobody
wants to wait longer than necessary, and if all we have is a bare
number and nobody knows how it was derived, we can't be confident
about changing it.

>   https://lore.kernel.org/all/Ydd5Wh0KeADBQ%2Fh1@ripper/
> 
> I have no further details.
