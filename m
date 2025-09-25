Return-Path: <linux-pci+bounces-36995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF40BA0916
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9855D3AEA6C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7992DEA67;
	Thu, 25 Sep 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzkHAeNY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC103596B;
	Thu, 25 Sep 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817171; cv=none; b=qoE9EWZ/e/kyuOpBRFymy7Hg8wcaW7Ijy3iDvyxdXI+wZZo/1/LQNr229WfYjjQ8Vml/gv6FxzU6hDiNCZxgTIRP/r2VFakAkLX4o1YK6sgbQTx+VMGNPwcjY5yESCehu6RKMLzeNa+imJq91IZQ3ym5S7GvFg0Zm2R/bihn3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817171; c=relaxed/simple;
	bh=7AVIF0kZTDey6ZhzfUZ3+wr+sPFo2gu91AUy+CefXhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkZuSzXgdwRzea6NJNHgueoeAWklUd0jdpn6dCKfxWz1hF8JwStJvGFr9eqyzFT/F2BwXNfX+W+hY5El/LBrrWEqynBTM0iEjvWnR+OzLtPAIpqc97YS4kJMg2wYBBtiKkXJbmtob8S6F0D8M1SVFx7ODg/CRStCap9ZSTanbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzkHAeNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F7C4CEF0;
	Thu, 25 Sep 2025 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758817171;
	bh=7AVIF0kZTDey6ZhzfUZ3+wr+sPFo2gu91AUy+CefXhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzkHAeNYo5rE0NLdPInOl3hThl6qLGz2kZnyIJDc6EeGnmbJvruBBlPhY7BeAxkVT
	 MEoDIdw1opJyCmSwj7oCaYEdBJeAnbj2sjy8FQvePRZWoWe+S4Wg42NHmrNkpxwN5s
	 pS00wtIxFfgXaDwvKOLchauboc8dNg/LM8+y46xtFylfHCtRLqpO6jKNdbgUP9RN1K
	 8J9lgZWVl9JOXq5rqwwDs1/nz40tWBCznax8SFnqRCAUfxUx6QV8+xrNdQhbM+8RvS
	 ZX8rcuWoimFqMOMQw2Onlh544FODNe4ukX4d8goFyHIgoCTSaxxW7KUlUSg8H1bzvr
	 AM+9voZqJoRFw==
Date: Thu, 25 Sep 2025 21:49:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chaitanya chundru <quic_krichai@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com, 
	amitk@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Message-ID: <yofmk5uyykyv4jxzem622dtuyzknk7ipd5xlkzdrfl5v7tgojy@5aarg5wj6bar>
References: <20250828-qps615_v4_1-v6-5-985f90a7dd03@oss.qualcomm.com>
 <20250925145416.GA2164008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925145416.GA2164008@bhelgaas>

On Thu, Sep 25, 2025 at 09:54:16AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 05:39:02PM +0530, Krishna Chaitanya Chundru wrote:
> > Implement stop_link() and  start_link() function op for dwc drivers.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
> >  
> > +static int dw_pcie_op_start_link(struct pci_bus *bus)
> > +{
> > +	struct dw_pcie_rp *pp = bus->sysdata;
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +	return dw_pcie_host_start_link(pci);
> 
> This takes a pci_bus *, which could be any PCI bus, but this only
> works for root buses because it affects the link from a Root Port.
> 
> I know the TC9563 is directly below the Root Port in the current
> topology, but it seems like the ability to configure a Switch with I2C
> or similar is potentially of general interest, even if the switch is
> deeper in the hierarchy.
> 
> Is there a generic way to inhibit link training, e.g., with the Link
> Disable bit in the Link Control register?  If so, this could
> potentially be done in a way that would work for any vendor and for
> any Downstream Port, including Root Ports and Switch Downstream Ports.
> 

FWIW, the link should not be stopped for a single device, since it could affect
other devices in the bus. Imagine if this switch is connected to one of the
downstream port of another switch. Then stopping and starting the link will
affect other devices connected to the upstream switch as well.

This driver is doing it right now just because, there is no other way to
control the switch state machine. Ideally, we would want the PERST# to be in
asserted stage to keep the device from starting the state machine, then program
the registers over I2C and deassert PERST#. This will work across all of the
host controller drivers (if they support pwrctrl framework).

But since we don't have PERST# support for the pwrctrl framework, we can have
this as an adhoc solution. I don't think we should try to generalize it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

