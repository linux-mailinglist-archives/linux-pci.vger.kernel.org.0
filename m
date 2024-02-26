Return-Path: <linux-pci+bounces-4019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FD867A24
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75262925F7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAF12BE82;
	Mon, 26 Feb 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5/VrA94"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5712B17B;
	Mon, 26 Feb 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961118; cv=none; b=OVXMo1BqPvDdy/Dnvp70etn8G9v0IKsJoS4s+p0kj0o44ds0XK+5grxoI1MVhjmWCcK/FQ9qoD/8hqbOc86V+Mu++FoRyikJKqPeiylXBypI1pTtYY/vIP1PtT6ERlhRQ+rGnM/onLYXX87CtuuZicK7lnmrOfdeijiwjhWSd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961118; c=relaxed/simple;
	bh=s9gx1o+QjyB553WhrB297l0j+CWUXlWb+nWk985SnPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P7QjbxZJPkwwyaV+eQ6cVQByWeVl7fwY8PGIIPLBYOPBfXVcfKXPQjW9vbwklv/+hLQgVlZb9AnvFDZ67hD+EAhnrC6Mldygh8GWgfPnlxGFlcZKjvkkq2g2GQyDZYkmzzm6c9WJKi//QhGLeY0S8Qq6vQ1iZj3/idUZKeJIWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5/VrA94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73858C433C7;
	Mon, 26 Feb 2024 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708961117;
	bh=s9gx1o+QjyB553WhrB297l0j+CWUXlWb+nWk985SnPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E5/VrA94F/JpdG4VGLPk5+BEDHREYe7aCVPn2mNFndnl7NLweX7tdXGFB2fb3vMKw
	 coYtZpjdUblewcYnqWwWiM3Z77BjLl16e5717ghdQAN3Eb5/VCbg9SzdwJQh8Halvz
	 jh8sZv9zpibV3ura+Ci6BbBt4VFsGDCk8ruIu6iKWn7re+PgC9y/VcKNfNSLhE5iTz
	 6/kfAx/rtuGjt60Co9F7EXzHXzZb4XJRScewGcrPkvjmXd1FfD28xWAMlPu+TSdA4Z
	 KjEp8VvUL9/SWPxIvbo9ug4GOsiNiVcgMG53NdSWdLU9QVmSphVvvV7PUqHYATVx/r
	 18xfIVM9/8RQQ==
Date: Mon, 26 Feb 2024 09:25:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
Message-ID: <20240226152516.GA200426@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572af7f6-2544-4708-a90d-e18c58eb2762@linux.intel.com>

On Sun, Feb 25, 2024 at 12:06:52PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > pci_acpi_add_edr_notifier() and pci_acpi_remove_edr_notifier() are only
> > referenced inside drivers/pci/.  Move their declarations from
> > include/linux/pci-acpi.h to drivers/pci/pci.h so they're not visible
> > outside drivers/pci/.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci.h        | 4 ++++
> >  include/linux/pci-acpi.h | 8 --------
> >  2 files changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2336a8d1edab..03bf2776d73b 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -432,11 +432,15 @@ void pci_dpc_init(struct pci_dev *pdev);
> >  void dpc_process_error(struct pci_dev *pdev);
> >  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> >  bool pci_dpc_recovered(struct pci_dev *pdev);
> > +void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> > +void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
> 
> Protect them with CONFIG_ACPI?

Good idea, thanks!  They're called only from pci-acpi.c, so I moved
them inside the #ifdef CONFIG_ACPI above:

  #ifdef CONFIG_ACPI
  int pci_acpi_program_hp_params(struct pci_dev *dev);
  ...
  #ifdef CONFIG_PCIE_DPC
  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
  void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
  #endif
  #else
  static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
  {
          return -ENODEV;
  }
  #ifdef CONFIG_PCIE_DPC
  static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
  static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
  #endif
  #endif

Bjorn

