Return-Path: <linux-pci+bounces-2919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D888456A2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 12:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863BC285101
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063AE15DBAA;
	Thu,  1 Feb 2024 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMazQHzj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8C15D5DC;
	Thu,  1 Feb 2024 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788467; cv=none; b=eBZ/g377gnGHRn3RSEi/F1eaSuQjpx9FwZAnn+8J8j0RAEVjPj5ABge8kwdbtrsWsBZfXbs+Ij7sNYd6ZSIC69ScA0R4OAIDv0/fTChsbICEf6wPAaBexxRQfgZllwveOCSkH+Ow3NtqRqGLZYXjjPDA8oqZQuQOVhk5GU9C15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788467; c=relaxed/simple;
	bh=GB2DzGR8rSdaDGGViF7AyPEKEPBcMSXhHGw9fn/ScLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzp066SEesbns6FESlbv11ATSA3hzJrRJiB8/hnkdDwrOok1WI+p7eFphfQOQdfdD8CsCtQi5v7sn//r+awrbgAtO5mSg/d7ZlLT672+iTK/ZjJDlhyuQWOrOQi1mYv1CvmYWxtX4OXGss1JJL4FbSQ9QPVGHCt8YcBzI00PL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMazQHzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4917BC43394;
	Thu,  1 Feb 2024 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788467;
	bh=GB2DzGR8rSdaDGGViF7AyPEKEPBcMSXhHGw9fn/ScLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMazQHzjzyWYNjHB2ZMl8l/ZGjok5KbOXXkW3J1Mjx4FRVeHdVcKYUwXW9yqXeKw8
	 rlmHY2Xk4QIXWi/3nBb36aBoXClUtowoS04icFhxmFjfcV6TmV1PgJTt6GfqQlBHcL
	 TR8E8B7h54N6CF9l/4435X6VsyJwPruKxuDTvAHgzP55uJR8yR9ukVXcQFVgOeV9gb
	 /TBnZM9RyePfyAZCwfhOdeRqzseiuLEkdyVV/m8w7apGIiRNXa9oD2CvTSQg4unIXE
	 ibQRiMExJuh3IZmW4N1NJP7A2HtxJTXZbSrntEKIcBlv0nTNo1bZdKvD16iEB7Va1j
	 tLT1QQKmTcyIA==
Date: Thu, 1 Feb 2024 17:24:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240201115415.GA2934@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
 <CAA8EJpqwOfeS-QpLVvYGf0jmTVxiT02POwK+9tkN03Cr4DgL+g@mail.gmail.com>
 <da1945ce-7e34-6ad5-7b9b-478fcbd4a2c6@quicinc.com>
 <CAA8EJpoZakDcBXYE57bRPMFvGEXh1o82r7Znv8mwCK6mRf5xog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoZakDcBXYE57bRPMFvGEXh1o82r7Znv8mwCK6mRf5xog@mail.gmail.com>

On Tue, Jan 16, 2024 at 11:55:17AM +0200, Dmitry Baryshkov wrote:
> On Tue, 16 Jan 2024 at 07:17, Krishna Chaitanya Chundru
> <quic_krichai@quicinc.com> wrote:
> >
> >
> >
> > On 1/12/2024 9:03 PM, Dmitry Baryshkov wrote:
> > > On Fri, 12 Jan 2024 at 16:25, Krishna chaitanya chundru
> > > <quic_krichai@quicinc.com> wrote:
> > >>
> > >> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> > >> maintains hardware state of a regulator by performing max aggregation of
> > >> the requests made by all of the processors.
> > >>
> > >> PCIe controller can operate on different RPMh performance state of power
> > >> domain based up on the speed of the link. And this performance state varies
> > >> from target to target.
> > >>
> > >> It is manadate to scale the performance state based up on the PCIe speed
> > >> link operates so that SoC can run under optimum power conditions.
> > >>
> > >> Add Operating Performance Points(OPP) support to vote for RPMh state based
> > >> upon GEN speed link is operating.
> > >>
> > >> OPP can handle ICC bw voting also, so move icc bw voting through opp
> > >> framework if opp entries are present.
> > >>
> > >> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> > >> same icc bw and has frequency, so use frequency based search to reduce
> > >> number of entries in the opp table.
> > >>
> > >> Don't initialize icc if opp is supported.
> > >>
> > >> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > >> ---
> > >>   drivers/pci/controller/dwc/pcie-qcom.c | 83 ++++++++++++++++++++++++++++------
> > >>   1 file changed, 70 insertions(+), 13 deletions(-)
> > >>
> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > >> index 035953f0b6d8..31512dc9d6ff 100644
> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[...]

> > >>   static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> > >> @@ -1471,8 +1502,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > >>   static int qcom_pcie_probe(struct platform_device *pdev)
> > >>   {
> > >>          const struct qcom_pcie_cfg *pcie_cfg;
> > >> +       unsigned long max_freq = INT_MAX;
> > >>          struct device *dev = &pdev->dev;
> > >>          struct qcom_pcie *pcie;
> > >> +       struct dev_pm_opp *opp;
> > >>          struct dw_pcie_rp *pp;
> > >>          struct resource *res;
> > >>          struct dw_pcie *pci;
> > >> @@ -1539,9 +1572,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >>                  goto err_pm_runtime_put;
> > >>          }
> > >>
> > >> -       ret = qcom_pcie_icc_init(pcie);
> > >> -       if (ret)
> > >> +        /* OPP table is optional */
> > >> +       ret = devm_pm_opp_of_add_table(dev);
> > >> +       if (ret && ret != -ENODEV) {
> > >> +               dev_err_probe(dev, ret, "Failed to add OPP table\n");
> > >>                  goto err_pm_runtime_put;
> > >> +       }
> > >
> > > Can we initialise the table from the driver if it is not found? This
> > > will help us by having the common code later on.
> > >
> > we already icc voting if there is no opp table present in the dts.
> 
> Yes. So later we have two different code paths: one for the OPP table
> being present and another one for the absent OPP table. My suggestion
> is to initialise minimal OPP table by hand and then have a common code
> path in qcom_pcie_icc_update().
> 

Are you suggesting to duplicate DT in the driver?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

