Return-Path: <linux-pci+bounces-32360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BFB08703
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B471A67571
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AC25B1C7;
	Thu, 17 Jul 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY6/41s4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E224A076;
	Thu, 17 Jul 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737779; cv=none; b=KAJf49kgVWanDk9XRXPq4NoyjaPezuUVDZujEzr0t9VcgOp1HgyKgby0DfmFEsY6wfLK4UjwpJflwRPOpauw1rs0/CJ3pLYSQ5bLyQXDYHpv2EfH+zjESBBH+w00e8HTTr1pIEBplgrhe8nyhl9gC74bowvTPH1CQObxesRa7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737779; c=relaxed/simple;
	bh=hhhU4e4aqKE8PpZkiDXzguQPAKgEofaDpsLTegsHWz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVGtywtgVUPykX/gGDKhu47bJ2TgF2OWwA1p1hdHCn1Mk/lXpFYoIGAftUkuGhdBtBPwHp4KbAvi7nzfZNxaiKuTotox58HOFuovquSX5TtW50LglqL9APFDAuqilcDbcNExc/ytl+lU2EwFuYilDJiTd11jl1itybFTUyASvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY6/41s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5176C4CEE3;
	Thu, 17 Jul 2025 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752737777;
	bh=hhhU4e4aqKE8PpZkiDXzguQPAKgEofaDpsLTegsHWz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY6/41s4bMy5D4wwJjhvJZzgFBcooHC/UdvQVnxZHAwfUwdEjNWYkekFrsuR8xAb9
	 F3YhWBbgeP9ssrmp8DnS4maFzQ5Npt5gl9LFbvwkQF3YqHy+dbrKSLyxOJiejJmkol
	 FWy+Yaf3a/rialpN/MtQfwHiucFCVWo2BqdXGE3ZtTwOcjc8ptpWg9X3wI4ToSHEXW
	 pGaPbkxgv4T7L1Go7BuyB0MnqXPeR2H9L1vuppR6bNwg4goK+Ugx47k8pw2lbBNo4i
	 Jqedvh/Xon9tIqaDxtDBPsRsLxQECHWy+X3K6Ch5INn4tPAs1HO1Kal10ynNriUlMs
	 33amfuvbQ7hNA==
Date: Thu, 17 Jul 2025 13:06:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, ath12k@lists.infradead.org, 
	ath11k@lists.infradead.org, ath10k@lists.infradead.org, ilpo.jarvinen@linux.intel.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/6] PCI/ASPM: Transition the device to D0 (if required)
 inside pci_enable_link_state_locked() API
Message-ID: <7o23kvvetjcohrucjhgkonrkkunykybce7q6tlfycbb6pafg4y@lpxvbepupemp>
References: <20250716-ath-aspm-fix-v1-2-dd3e62c1b692@oss.qualcomm.com>
 <20250716205601.GA2555277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716205601.GA2555277@bhelgaas>

On Wed, Jul 16, 2025 at 03:56:01PM GMT, Bjorn Helgaas wrote:
> On Wed, Jul 16, 2025 at 06:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Both of the current callers of the pci_enable_link_state_locked() API
> > transition the device to D0 before calling. This aligns with the PCIe spec
> > r6.0, sec 5.5.4:
> > 
> > "If setting either or both of the enable bits for PCI-PM L1 PM Substates,
> > both ports must be configured as described in this section while in D0."
> > 
> > But it looks redundant to let the callers transition the device to D0. So
> > move the logic inside the API and perform D0 transition only if the PCI-PM
> > L1 Substates are getting enabled.
> 
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1474,13 +1474,20 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
> >   * Note that if the BIOS didn't grant ASPM control to the OS, this does
> >   * nothing because we can't touch the LNKCTL register.
> >   *
> > - * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> > - * PCIe r6.0, sec 5.5.4.
> > + * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
> > + * are getting enabled.
> >   *
> >   * Return: 0 on success, a negative errno otherwise.
> >   */
> >  int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  {
> > +	/*
> > +	 * Ensure the device is in D0 before enabling PCI-PM L1 PM Substates, per
> > +	 * PCIe r6.0, sec 5.5.4.
> > +	 */
> > +	if (FIELD_GET(PCIE_LINK_STATE_L1_SS_PCIPM, state))
> > +		pci_set_power_state(pdev, PCI_D0);
> 
> This is really just a move, not new code, but this niggles at me a
> little bit because my impression is that pci_set_power_state() doesn't
> guarantee that the device *stays* in the given state.
> 
> Rafael, is there a get/put interface we should be wrapping this with
> instead?
> 

I don't quite understand this statement. A device cannot transition itself to
any D-states without host software intervention. So only host software should
intiate the transition. So are you saying that this API could be used by other
entities to change the device state? So you want to use some lock to prevent
callers from racing aganist each other?

I believe the current users of this API doesn't use any locks and just go by the
fact that the device stays in the give state. It does look racy, but seems to be
working fine so far. Obviously, the client driver need to ensure that it doesn't
create any race within itself. But the race could exist between the PCI core and
the driver theoretically.

> I'm also not sure it's worth the FIELD_GET().  This should be a
> low-frequency operation and making the power state dependent on the
> exact "state" makes more paths to worry about.
> 

Are you worrying about the usage of FIELD_GET() to check the ASPM state or the
existence of the check itself?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

