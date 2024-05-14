Return-Path: <linux-pci+bounces-7441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D68C4ED1
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68336B21AA8
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13A12A14C;
	Tue, 14 May 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfYcL/Qk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2A8594C;
	Tue, 14 May 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678925; cv=none; b=nOqCnnIzzK1e3sFAc76Gbg8AoUks3lrBPSDi23rhkrOmGOlgTJI7hhTktH4Xk+Wk77B1CUPR1VvpD6eYZkqKN1KntzuK+rG1ALDKJZDckxCQ9GkwC4FE8A48bOPl9cKU9fD+t8KsDX5PpmXfsJqV9YiO7qV2nTvKnrC2XVR8NN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678925; c=relaxed/simple;
	bh=HwGGfmR6sqS6WP0aIbowQLShPEm7IIhjY9D4SqgUD2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Hhws9gttplsJT4eZ8ZAxhCa1BjXAkcrV/NRVOSFUeOZSs9pSORaOfisCWrlhllNPZyrYXZFGqSukPnGxeJNkak+wouoB0avvgAR1q2/LdFR42NLW2BzdOlx2OVJ9eT+d2G9jT6eRwaaNIuaAsAcrI7h0gFJKMw2t4quasm8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfYcL/Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E81C2BD10;
	Tue, 14 May 2024 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715678924;
	bh=HwGGfmR6sqS6WP0aIbowQLShPEm7IIhjY9D4SqgUD2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfYcL/QkIkE5PyQHM6b+a0gOfkH5yNZSZ3mxJt7ajzRnDnfnS0M3o0HiU1jhxfNCP
	 p4h2hiT8rutj76sSkfZxwJqSGaUHji8hFAeLtvvA0sTeWfmp3oWIh2IdjW/q4YDxEt
	 /3E7usTuEDyX3LJ6fPe+XTgnmGSiL9nQ4+Giz/zunWs03LJ+PvWkOr05qS+2h+Dpdu
	 0DN8P5XPHbJMQYgs2PccGG8Fa9T8BEY3W7tXZuyRI1f7KyXqp6vcFnTOlDboMJq8ay
	 F/7TjQuD97ExUfjAwCSkF8HBOTdB9IQ6X2m8oPBjBoTtBy2rtkEvKt5VlYpviFqqw1
	 XHpl48Quz2AZA==
Date: Tue, 14 May 2024 11:28:38 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v12 6/6] PCI: qcom: Add OPP support to scale performance
Message-ID: <20240514092838.GE2463@thinkpad>
References: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
 <20240427-opp_support-v12-6-f6beb0a1f2fc@quicinc.com>
 <20240430052613.GD3301@thinkpad>
 <8b213eba-7ab6-ae9c-7683-937a9d6aaf08@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b213eba-7ab6-ae9c-7683-937a9d6aaf08@quicinc.com>

On Thu, May 09, 2024 at 09:21:55PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/30/2024 10:56 AM, Manivannan Sadhasivam wrote:
> > On Sat, Apr 27, 2024 at 07:22:39AM +0530, Krishna chaitanya chundru wrote:
> > > QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> > > maintains hardware state of a regulator by performing max aggregation of
> > > the requests made by all of the clients.
> > > 
> > > PCIe controller can operate on different RPMh performance state of power
> > > domain based on the speed of the link. And this performance state varies
> > > from target to target, like some controllers support GEN3 in NOM (Nominal)
> > > voltage corner, while some other supports GEN3 in low SVS (static voltage
> > > scaling).
> > > 
> > > The SoC can be more power efficient if we scale the performance state
> > > based on the aggregate PCIe link bandwidth.
> > > 
> > > Add Operating Performance Points (OPP) support to vote for RPMh state based
> > > on the aggregate link bandwidth.
> > > 
> > > OPP can handle ICC bw voting also, so move ICC bw voting through OPP
> > > framework if OPP entries are present.
> > > 
> > > As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> > > is supported.
> > > 
> > > Before PCIe link is initialized vote for highest OPP in the OPP table,
> > > so that we are voting for maximum voltage corner for the link to come up
> > > in maximum supported speed.
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++------
> > >   1 file changed, 67 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 465d63b4be1c..40c875c518d8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > 
> > [...]
> > 
> > > @@ -1661,6 +1711,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> > >   		ret = icc_disable(pcie->icc_cpu);
> > >   		if (ret)
> > >   			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
> > > +
> > > +		if (!pcie->icc_mem)
> > > +			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
> > 
> > At the start of the suspend, there is a call to icc_set_bw() for PCIe-MEM path.
> > Don't you want to update it too?
> > 
> > - Mani
> > 
> if opp is supported we just need to call dev_pm_opp_set_opp() only once
> which will take care for both PCIe-MEM & CPU-PCIe path.
> so we are not adding explicitly there.

No, I was asking you why you are not adding a check for the existing
icc_set_bw() at the start like you were doing elsewhere.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

