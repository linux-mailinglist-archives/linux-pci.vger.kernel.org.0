Return-Path: <linux-pci+bounces-2245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704D830035
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 07:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2B1C23A1A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1EA8821;
	Wed, 17 Jan 2024 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLa6qYMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5334685;
	Wed, 17 Jan 2024 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473607; cv=none; b=OPCvdZSfmYF6RFjtXWWiFk8fxBAWtDT8MIEKZJsx5K3XQBOpz9Bh8KYx55DsrvvFS4vmeiQ+UmTsFooCLuIVD1KuM826ja+/9bGZwiZ5nvIChPw7LHFDq1GRXGvN8/jelqhETDDl+Dgj4R4YC4eLHybXlUrfwwYcgMbI/mqMKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473607; c=relaxed/simple;
	bh=zCxriXr/T6GxyRjtTV+oey32YWyxeNIjJCrOraLjzTY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=ByADg3TLj3tXQZmvXCsnyCuF6H0amjWDODSotlka9r3d0P1Q9Nzh1fINi9/N4nvoYiumg3Tjr9Fns8OKUXwlqMOQrR2E0JvFs6n1Fl1kSZuKOmSWgGB60XZokfhjR/R6TE97fUYJBC6rfpZC0PeBvk5O2fru/1bMuNu9olRJVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLa6qYMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B95C433C7;
	Wed, 17 Jan 2024 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705473606;
	bh=zCxriXr/T6GxyRjtTV+oey32YWyxeNIjJCrOraLjzTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLa6qYMRljdBvuMPxaeiZchWO22a/CYZq/JKoBE4saA+gPDn+KtmCgvI8cVASCaOk
	 bNxJocm4YIvgOteU4sRCFXHIyRkJMlPRqg6MqdmYoNktfXHiwG2JlgM4aLB+i0+plt
	 rTk1wlhP7qrj37/kmF0p1y0igQS3c92SVvqrDe+lMduY4zb/kfpZlqozJDoS47wF99
	 pLSTisK2pwtbW2gFcB6Ai+/FGbcgwnQLgytj9b93yoXQmt04G9tUzPfbrHRW93Uz/F
	 SqrS9tGVe16hqwnLgRmEyUmn+lsmzHnDGVUXBNTb+Xem1wIRD8FdSJGyyra6p/doHp
	 o2/XE/tZKM3hw==
Date: Wed, 17 Jan 2024 12:09:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Message-ID: <20240117063938.GC8708@thinkpad>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <CAA8EJprq1s42hkbXXKtXTGnyYePQN98t+gmFoHDOGMWJH4Ot3g@mail.gmail.com>
 <2bc92420-b3b9-047d-e5e4-22a19b4d07d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bc92420-b3b9-047d-e5e4-22a19b4d07d3@quicinc.com>

On Tue, Jan 16, 2024 at 10:27:23AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/12/2024 9:00 PM, Dmitry Baryshkov wrote:
> > On Fri, 12 Jan 2024 at 16:24, Krishna chaitanya chundru
> > <quic_krichai@quicinc.com> wrote:
> > > 
> > > CPU-PCIe path consits for registers PCIe BAR space, config space.
> > > As there is less access on this path compared to pcie to mem path
> > > add minimum vote i.e GEN1x1 bandwidth always.
> > 
> > Is this BW amount a real requirement or just a random number? I mean,
> > the register space in my opinion consumes much less bandwidth compared
> > to Gen1 memory access.
> > 
> Not register space right the BAR space and config space access from CPU
> goes through this path only. There is no recommended value we need to
> vote for this path. Keeping BAR space and config space we tried to vote
> for GEN1x1.
> 
> Please suggest any recommended value, I will change that in the next
> series.
> 

You should ask the HW folks on the recommended value to keep the reg access
clocking. We cannot suggest a value here.

If they say, "there is no recommended value", then ask them what would the
minimum value and use it here.

- Mani

> - Krishna Chaitanya.
> > > 
> > > In suspend remove the cpu vote after register space access is done.
> > > 
> > > Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> > > cc: stable@vger.kernel.org
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++++++++++++++++++++--
> > >   1 file changed, 29 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 11c80555d975..035953f0b6d8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -240,6 +240,7 @@ struct qcom_pcie {
> > >          struct phy *phy;
> > >          struct gpio_desc *reset;
> > >          struct icc_path *icc_mem;
> > > +       struct icc_path *icc_cpu;
> > >          const struct qcom_pcie_cfg *cfg;
> > >          struct dentry *debugfs;
> > >          bool suspended;
> > > @@ -1372,6 +1373,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> > >          if (IS_ERR(pcie->icc_mem))
> > >                  return PTR_ERR(pcie->icc_mem);
> > > 
> > > +       pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
> > > +       if (IS_ERR(pcie->icc_cpu))
> > > +               return PTR_ERR(pcie->icc_cpu);
> > >          /*
> > >           * Some Qualcomm platforms require interconnect bandwidth constraints
> > >           * to be set before enabling interconnect clocks.
> > > @@ -1381,7 +1385,18 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> > >           */
> > >          ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> > >          if (ret) {
> > > -               dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > > +               dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
> > > +                       ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       /*
> > > +        * The config space, BAR space and registers goes through cpu-pcie path.
> > > +        * Set peak bandwidth to single-lane Gen1 for this path all the time.
> > > +        */
> > > +       ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> > > +       if (ret) {
> > > +               dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
> > >                          ret);
> > >                  return ret;
> > >          }
> > > @@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> > >           */
> > >          ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
> > >          if (ret) {
> > > -               dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> > > +               dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
> > >                  return ret;
> > >          }
> > > 
> > > @@ -1597,6 +1612,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
> > >                  pcie->suspended = true;
> > >          }
> > > 
> > > +       /* Remove cpu path vote after all the register access is done */
> > > +       ret = icc_set_bw(pcie->icc_cpu, 0, 0);
> > > +       if (ret) {
> > > +               dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
> > > +               return ret;
> > > +       }
> > >          return 0;
> > >   }
> > > 
> > > @@ -1605,6 +1626,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> > >          struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > >          int ret;
> > > 
> > > +       ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> > > +       if (ret) {
> > > +               dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > >          if (pcie->suspended) {
> > >                  ret = qcom_pcie_host_init(&pcie->pci->pp);
> > >                  if (ret)
> > > 
> > > --
> > > 2.42.0
> > > 
> > > 
> > 
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

