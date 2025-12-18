Return-Path: <linux-pci+bounces-43295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A92CCBDB4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4803013E8B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF6A334C05;
	Thu, 18 Dec 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDGiPt4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5C3346A6;
	Thu, 18 Dec 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062538; cv=none; b=PRnhIqJlFF3l8aUm5yOMCigZDIyxG8b40Lo4lQosgCII/tyDRdJk0bMhPkKYB+CKHnRCHEN2uVuuN9b5SDlLIuFQS0T6wFqjLNm5ZMLxZszMQG34MB2bshFd90LB/nSfuSneFNaEQCRFtRB6axjMjyCZKRFwChW34yvbiCgWEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062538; c=relaxed/simple;
	bh=KNPU4aTh9fHTCv6iEqCblnYbA5Anb7cYDMKBkFkL2pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu8tNsE7mxuS3NsNrwSWnoFZIYvCGwu/DcUF6zKokaKJBj38X3bOx4VP2wmtAGDbtXy21OHAHFkMJG0f4vpLnmVUDlEh8d6BYb2WNrqsS6N3ZP57lLFl/Gm4NZ/sBX70i0yKtueOoZcgNy7gEA/atqKlT8vNvGTUKV4QEG4m4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDGiPt4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CC4C4CEFB;
	Thu, 18 Dec 2025 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766062538;
	bh=KNPU4aTh9fHTCv6iEqCblnYbA5Anb7cYDMKBkFkL2pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDGiPt4Rg7CRST4wGdG5p0tiigBTJUVZ/hVEKE8dMaUnZq8sb/UVePrsWf/ZD1kdk
	 ROuxcWzirmnWnBY8F7tpUorkATTIp5MKLiqWfQ1/5RUCTuEOai7PfFF3qpwI72H493
	 R7om37J/WpTD3Tfbirr8cGHK3fWXG4pipy/W3MuU6T1RJ8qvULV2NMvqz3IsBBSyr9
	 f4SsD7HWEEqvxKuhEJVM+45025/tFVaFPDnxZv+b44wf3iT1wMC3MO5tRCU0VF7vWD
	 n88rfy1VhofPP/MQYhE0M29w61XTsGCLDWSW1d6/vSf8hef3BA7n0PT7ci1/9DObs2
	 M/sEhXpqnGbjQ==
Date: Thu, 18 Dec 2025 18:25:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
Message-ID: <h65q3cilodzw3htdpdu66cijokigz6grlw4eol4jbyiodrqy4m@jcvp6vigeo5s>
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
 <0871c353-91b8-404a-9ca2-e2f662c6d98d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0871c353-91b8-404a-9ca2-e2f662c6d98d@rock-chips.com>

On Thu, Dec 18, 2025 at 08:45:15PM +0800, Shawn Lin wrote:
> 在 2025/12/18 星期四 20:04, Manivannan Sadhasivam via B4 Relay 写道:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > dw_pcie_wait_for_link() API waits for the link to be up and returns failure
> > if the link is not up within the 1 second interval. But if there was no
> > device connected to the bus, then the link up failure would be expected.
> > In that case, the callers might want to skip the failure in a hope that the
> > link will be up later when a device gets connected.
> > 
> > One of the callers, dw_pcie_host_init() is currently skipping the failure
> > irrespective of the link state, in an assumption that the link may come up
> > later. But this assumption is wrong, since LTSSM states other than
> > Detect.Quiet and Detect.Active during link training phase are considered to
> > be fatal and the link needs to be retrained.
> > 
> > So to avoid callers making wrong assumptions, skip returning failure from
> > dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
> > Detect.Active states after timeout and also check the return value of the
> > API in dw_pcie_host_init().
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
> >   drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
> >   2 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 43d091128ef7..ef6d9ae6eddb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   	 * If there is no Link Up IRQ, we should not bypass the delay
> >   	 * because that would require users to manually rescan for devices.
> >   	 */
> > -	if (!pp->use_linkup_irq)
> > -		/* Ignore errors, the link may come up later */
> > -		dw_pcie_wait_for_link(pci);
> > +	if (!pp->use_linkup_irq) {
> > +		ret = dw_pcie_wait_for_link(pci);
> > +		if (ret)
> > +			goto err_stop_link;
> > +	}
> >   	ret = pci_host_probe(bridge);
> >   	if (ret)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 75fc8b767fcc..b58baf26ce58 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> >   int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   {
> > -	u32 offset, val;
> > +	u32 offset, val, ltssm;
> >   	int retries;
> >   	/* Check if the link is up or not */
> > @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   	}
> >   	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
> > +		/*
> > +		 * If the link is in Detect.Quiet or Detect.Active state, it
> > +		 * indicates that no device is detected. So return success to
> > +		 * allow the device to show up later.
> > +		 */
> > +		ltssm = dw_pcie_get_ltssm(pci);
> > +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
> > +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
> > +			return 0;
> 
> By looking more closely, this changes the behaviour of pcie-tegra194.c
> which relies on it in tegra_pcie_dw_start_link() to do some retries.
> 
> pcie-intel-gw.c/pci-imx6.c also continue to do some setups in this case,
> not sure if it's safe.
> 

Hmm, I agree. I did check the callers during v1, but fail to notice pci-imx6
which writes to LNKCAP and PCIE_LINK_WIDTH_SPEED_CONTROL registers after
success.

To be on the safe side, dw_pcie_wait_for_link() should return -ENODEV if the
device is not found and the callers can check for this errno and skip the
failure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

