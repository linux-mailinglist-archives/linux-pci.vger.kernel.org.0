Return-Path: <linux-pci+bounces-38379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18CBE4B2B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08333A239C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E030C60B;
	Thu, 16 Oct 2025 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvWIxGUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4214AD0D;
	Thu, 16 Oct 2025 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633743; cv=none; b=lWbsk1Ep/WjuPLMXQPK2LhXGq+iQRcWReeYiDKKzQJzeKI5cSxe8ONgAK40BQtemSuVf/+eBMMvEJuESeIl4Ghg3nr9DDJbWCuMqoBOOekO1w16hPIA1fHFryGT7PIyz7K2x3rmovQWMBJYlQaH6xOEPBpAIUqKPDmSdoPaE7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633743; c=relaxed/simple;
	bh=0S1Czo2QYsg5/9slGpKUPXdakuPBU/Yht6fUQWKZCXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jClN20Rapa5ulolHfARrnGO8VzurkjiuZYuWq8OnmoAN8b3urUFLKUnit4sMNqHX4uqN4dOrA3SQev8M0uB+izhpl6p5/W9EeQlki/ovW8hnUw1BbEaoyCAoMmp8udwQdQ3vDpN1pJFVny0EOAxKbQCohn4bvD/k6pQ/peIpG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvWIxGUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205B5C4CEF1;
	Thu, 16 Oct 2025 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760633743;
	bh=0S1Czo2QYsg5/9slGpKUPXdakuPBU/Yht6fUQWKZCXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lvWIxGUkitV9YymOTji4K/wIQYoFIyLapsmHuOyW1OlwaTkyeNkG2Z7Am8A2bS6A3
	 5Z6ds9Mo1P+8HBW9/n9rzqUVmWB70SvIs5XmWnYngR6l99od4Tvh/RYc+d7TkfymJ7
	 if3UyJV7YiHeLHv1gcQIpL49nQz3Oy5ZCnTWjOY6xcA6lZlZ3cRp+3OkiWzUabMPjy
	 lJtAOfNDfL+qErCH+dG50vggya17nukUclPClntYC1uqx9nNrieigQEKxqtIJCuEG2
	 lWkagU28S78F276iKkJI1Otl5Imkqh8cJ+IjLIhDUrDH93wyXAYdxhOjXu2tT32jpn
	 VmZxvysRvZfuA==
Date: Thu, 16 Oct 2025 11:55:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kenneth Crudup <kenny@panix.com>, Genes Lists <lists@sapience.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
	Todd Brandt <todd.e.brandt@intel.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] PCI: vmd: override irq_startup()/irq_shutdown() in
 vmd_init_dev_msi_info()
Message-ID: <20251016165541.GA989894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014211824.GA908020@bhelgaas>

[+cc Gene, Todd, Oliver]

On Tue, Oct 14, 2025 at 04:18:24PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 14, 2025 at 09:46:07AM +0800, Inochi Amaoto wrote:
> > Since commit 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per
> > device domains") set callback irq_startup() and irq_shutdown() of
> > the struct pci_msi[x]_template, __irq_startup() will always invokes
> > irq_startup() callback instead of irq_enable() callback overridden
> > in vmd_init_dev_msi_info(). This will not start the irq correctly.
> > 
> > Also override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info(),
> > so the irq_startup() can invoke the real logic.
> > 
> > Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> > Reported-by: Kenneth Crudup <kenny@panix.com>
> > Closes: https://lore.kernel.org/all/8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com/
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Kenneth R. Crudup <kenny@panix.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thomas, I'm happy to take this via PCI you prefer.  I acked it
> because you merged 54f45a30c0d0.
> 
> If you take it, I wouldn't mind if you capitalized "Override" in the
> subject to match the history.
> 
> Obviously this is v6.18 material since 54f45a30c0d0 is a v6.18-rc1
> regression.

Not having heard anything, I put this on pci/for-linus and plan to
request a merge before -rc2.  Let me know if you plan to merge this
elsewhere and I can drop it from the PCI tree.

I added more reports to the commit log:

  PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()

  Since commit 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per
  device domains") set callback irq_startup() and irq_shutdown() of
  the struct pci_msi[x]_template, __irq_startup() will always invokes
  irq_startup() callback instead of irq_enable() callback overridden
  in vmd_init_dev_msi_info(). This will not start the IRQ correctly.

  Also override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info(),
  so the irq_startup() can invoke the real logic.

  Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
  Reported-by: Kenneth Crudup <kenny@panix.com>
  Closes: https://lore.kernel.org/r/8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com/
  Reported-by: Genes Lists <lists@sapience.com>
  Closes: https://lore.kernel.org/r/4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com
  Reported-by: Todd Brandt <todd.e.brandt@intel.com>
  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220658
  Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
  Closes: https://lore.kernel.org/r/8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net
  Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
  Tested-by: Kenneth R. Crudup <kenny@panix.com>
  Tested-by: Genes Lists <lists@sapience.com>
  Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
  Link: https://patch.msgid.link/20251014014607.612586-1-inochiama@gmail.com

> > ---
> >  drivers/pci/controller/vmd.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 1bd5bf4a6097..b4b62b9ccc45 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
> >  	data->chip->irq_unmask(data);
> >  }
> > 
> > +static unsigned int vmd_pci_msi_startup(struct irq_data *data)
> > +{
> > +	vmd_pci_msi_enable(data);
> > +	return 0;
> > +}
> > +
> >  static void vmd_irq_disable(struct irq_data *data)
> >  {
> >  	struct vmd_irq *vmdirq = data->chip_data;
> > @@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
> >  	vmd_irq_disable(data->parent_data);
> >  }
> > 
> > +static void vmd_pci_msi_shutdown(struct irq_data *data)
> > +{
> > +	vmd_pci_msi_disable(data);
> > +}
> > +
> >  static struct irq_chip vmd_msi_controller = {
> >  	.name			= "VMD-MSI",
> >  	.irq_compose_msi_msg	= vmd_compose_msi_msg,
> > @@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> >  	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> >  		return false;
> > 
> > +	info->chip->irq_startup		= vmd_pci_msi_startup;
> > +	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
> >  	info->chip->irq_enable		= vmd_pci_msi_enable;
> >  	info->chip->irq_disable		= vmd_pci_msi_disable;
> >  	return true;
> > --
> > 2.51.0
> > 

