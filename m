Return-Path: <linux-pci+bounces-4793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A466287B1B4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7771F24C06
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C054669;
	Wed, 13 Mar 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKDQifyU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2160EF3;
	Wed, 13 Mar 2024 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357419; cv=none; b=G2SWrqTg+xNMc/ln/ZhuoUTbFJg/VFRv/VTItB9P5kUF+/PyF5wh/6zs8LI/I8i08yAplbLk2SueGflstgXIu5Y/BVjBLVbfyas/+mXyD+1fIE1NmmZl/M7/w9BPxzj+XhvoI+xTF/snepBrbCNsYQNeVBWwrfSy4xgvRfrQHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357419; c=relaxed/simple;
	bh=XVu5bJH8nPuKS6s5/fX++LS0JurTPSr9pVBxYJqu/jo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vAdbiRnusEQZy4mTejmexFJ+NxaK+eqEA8zTECO3C0pe5PuAzSYL8aXIYTxIdxFjG33/sBiitB5YvInov0naoFQIN41RZyVYg3C/DHvLa4ZPwlbkUgxH0OTUcZQNdKSYJZ3XIVtaxvRJOhP++/KEq7V3DXW3pKJlgddYq6qbRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKDQifyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36909C433F1;
	Wed, 13 Mar 2024 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710357418;
	bh=XVu5bJH8nPuKS6s5/fX++LS0JurTPSr9pVBxYJqu/jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jKDQifyU0rvMEek2BTjl1rfmDHVhxbrZtxNt+R75OJbpwFngQosurN4NPqRe0ntre
	 Ppg020gSZ7kp9o/qmRxK0UU7oU/ApwdgPCzUZVCpPpIItrpfaX1d2TojxiijfCjB96
	 6olH/B/HSySQ+HMcm3t4//wY+N2CoAXpL+8GyyZ4DT8GkeLoAkjtclDTCxwlAh2FbS
	 hZU+Z6ageWFTo9+3VTOTu0l+4vwMAlf5l/zPkpJ3AdDCSpgX9HapgcVhIEzQaXFA/N
	 DM4f4HE99yWgsPdbKbxADncOypuYNjWzc544qiuZqw7EYGbhVP2TTo4uLYy7FhAskO
	 RG7RYWYcpA3Rg==
Date: Wed, 13 Mar 2024 14:16:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback to properly
 reset the endpoint devices
Message-ID: <20240313191656.GA921158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313150242.GA2656@thinkpad>

On Wed, Mar 13, 2024 at 08:32:42PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 09:36:14AM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 13, 2024 at 05:39:22PM +0530, Manivannan Sadhasivam wrote:
> > > PCIe host controller drivers are supposed to properly reset the endpoint
> > > devices during host shutdown/reboot.

Where does this requirement to reset endpoints during host shutdown
come from?  My working assumption is that .shutdown() needs to stop
DMA and interrupts, based on this old thread:
https://lore.kernel.org/all/61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org/

> > > Currently, Qcom driver doesn't do
> > > anything during host shutdown/reboot, resulting in both PERST# and refclk
> > > getting disabled at the same time. This prevents the endpoint device
> > > firmware to properly reset the state machine. Because, if the refclk is
> > > cutoff immediately along with PERST#, access to device specific registers
> > > within the endpoint will result in a firmware crash.

Does "PERST# getting disabled" mean PERST# is asserted or deasserted?

> > > To address this issue, let's call qcom_pcie_host_deinit() inside the
> > > shutdown callback, that asserts PERST# and then cuts off the refclk with a
> > > delay of 1ms, thus allowing the endpoint device firmware to properly
> > > cleanup the state machine.

This *adds* the qcom_pcie_shutdown() callback, right?

> > I guess this 1ms delay is the PERST_DELAY_US hidden inside
> > qcom_ep_reset_assert()?  I assume the refclk disable is done by
> > clk_bulk_disable_unprepare()?
> 
> Yes to both.
> 
> >   #define PERST_DELAY_US 1000
> > 
> >   qcom_pcie_shutdown
> >     qcom_pcie_host_deinit
> >       qcom_ep_reset_assert
> >         gpiod_set_value_cansleep(pcie->reset, 1);
> >         usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);  <--
> >       phy_power_off(pcie->phy)
> >       pcie->cfg->ops->deinit()
> >         qcom_pcie_deinit_...
> >           clk_bulk_disable_unprepare                         <--
> > 
> > Is there a spec citation for this delay requirement?  If not, how do
> > we know 1ms is enough for whatever the firmware needs to do?
> 
> Both PCIe base spec and Electromechanical spec only mentions Tperst,
> which is the minimum time PERST# should remain asserted. But there
> is no mention about the time, refclk should be active.

I see Tperst mentioned in PCIe r6.0, sec 6.6.1, but AFAICS the value
is only defined in PCIe CEM (r5.0, sec 2.9.2), which says 100us, and
maybe other form factor specs.

If PERST_DELAY_US is enforcing Tperst, why is it 1000us instead of
100us?

> So I used the existing delay post PERST# assert in the driver. I do
> not know if that is enough for all the endpoints out in the wild,
> but atleast satisfies the requirement of the endpoint I'm working on
> (which is another Qcom SoC in EP mode).
> 
> We can change the delay if someone reports any issue with the
> existing one.  Atleast, that's the best we could do in this
> situation.

I'm dubious about this.  If endpoints require a delay here to work
properly, the spec should specify a minimum delay.  We can't make a
reliable system based on "here's a guess and we'll update it if people
report issues."  That makes me think this endpoint mode Qcom SoC
dependency on a delay might itself be non spec-compliant.

> > Do other drivers require similar changes?
> 
> Most likely yes, but that also depends on when the drivers are
> cutting off the refclk. Not all drivers are implementing the
> shutdown callback, and even few of the ones implementing, do not
> assert PERST# since it is optional.

> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 2ce2a3bd932b..41434bc4761a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1618,6 +1618,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> > >  	return 0;
> > >  }
> > >  
> > > +static void qcom_pcie_shutdown(struct platform_device *pdev)
> > > +{
> > > +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> > > +
> > > +	qcom_pcie_host_deinit(&pcie->pci->pp);
> > > +}
> > > +
> > >  static const struct of_device_id qcom_pcie_match[] = {
> > >  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > >  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > @@ -1670,5 +1677,6 @@ static struct platform_driver qcom_pcie_driver = {
> > >  		.pm = &qcom_pcie_pm_ops,
> > >  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > >  	},
> > > +	.shutdown = qcom_pcie_shutdown,
> > >  };
> > >  builtin_platform_driver(qcom_pcie_driver);
> > > 
> > > ---
> > > base-commit: 51459eb30f88651d3688b9e95fed0f97767ececb
> > > change-id: 20240313-pci-qcom-shutdown-d86298186560
> > > 
> > > Best regards,
> > > -- 
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

