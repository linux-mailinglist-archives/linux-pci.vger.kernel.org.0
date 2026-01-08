Return-Path: <linux-pci+bounces-44287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30F6D047F9
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FFCA30D5FBA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AEE26C39E;
	Thu,  8 Jan 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTiQ4gyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A67DA66;
	Thu,  8 Jan 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888802; cv=none; b=uft25So7/FRtefa9nbYZfJcegH64+M5FwT9xOUr+JXT+Z2KPtgLnniAmJWMQ4IALdhV/mwhAWu4nXNQjJ1A6nwSePMuN/ajS+up+xYYCugmCtu59F/IPC2GEuh8WH2dmbDr4XplFQcItQAWLs1lSWn7NDVqh/TdlY1ehrx2qHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888802; c=relaxed/simple;
	bh=S72kyJ6OhWOaTjMtM11JCMPxODXaSQCVVNaJHWk9JJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdakTYtcT2bT+I28t3G6f041YgHhlLvZR5WDesiXhni3tFFLkPm1h+xtudEQMuo6NbE+HT4Hs1Qy8p5w8iJMguGsRI/JUMXJ3C1SfDHc31KyO0Qhe77IvrJsGwDNML6l/X3BZ5+VydvpN2KwU1WO0RdS7/2SjwPr/FPwJK7fSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTiQ4gyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0682C19422;
	Thu,  8 Jan 2026 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888801;
	bh=S72kyJ6OhWOaTjMtM11JCMPxODXaSQCVVNaJHWk9JJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTiQ4gykw+qZEp0IC5oOch0G+UQQMj+WxxSfjOYba3ju/faZXuP+5CggeYNv+KaTE
	 9kgDZOuFCQ1kQgU7hi08Rux3iXqUReWgB3AZyePUL5UNRWqNMHOR5JqNObSPKZhNIj
	 a5YQv1RJ6fa2j758A2Gx5QtX1rEbDvFCUQUy6nv6YR3U0oCM6dWLDYQEh1jB+5tIvQ
	 lpXU0aUUZWQWJjod/zZVFMdaRhd2J8lHMlPLj/RUV2KAhEKzof9wuogHiEdAR0DqM7
	 sClSS6fFSj9qqVOnyFws3SmfXHckf1trDEg44R5IZUl+hEGoJmxQChVzeqfBuODltL
	 Zq7IPPWskPVsw==
Date: Thu, 8 Jan 2026 17:13:16 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 6/7] irqchip/gic-v5: Add ACPI ITS probing
Message-ID: <aV/XnJg7CPBpbXnR@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-6-eec76cd1d40b@kernel.org>
 <20260105135545.00003a59@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105135545.00003a59@huawei.com>

On Mon, Jan 05, 2026 at 01:55:45PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 11:14:32 +0100
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > On ACPI ARM64 systems the GICv5 ITS configuration and translate frames
> > are described in the MADT table.
> > 
> > Refactor the current GICv5 ITS driver code to share common functions
> > between ACPI and OF and implement ACPI probing in the GICv5 ITS driver.
> > 
> > Add iort_msi_xlate() to map a device ID and retrieve an MSI controller
> > fwnode node for ACPI systems and update pci_msi_map_rid_ctlr_node() to
> > use it in its ACPI code path.
> > 
> > Add the required functions to IORT code for deviceID retrieval and IRQ
> > domain registration and look-up so that the GICv5 ITS driver in an
> > ACPI based system can be successfully probed.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> Hi Lorenzo,
> 
> Diff was in a rather unfriendly mood on this one and smashing the xlate
> on top of the wrong function (wrt to what was being replaced).
> 
> Ah well. Only one minor comment inline.  Not really my area of expertise
> beyond wanting this to move forwards quickly but none the less,
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  drivers/acpi/arm64/iort.c                |  95 +++++++++++++++++-----
> >  drivers/irqchip/irq-gic-its-msi-parent.c |  39 ++++-----
> >  drivers/irqchip/irq-gic-v5-irs.c         |   7 +-
> >  drivers/irqchip/irq-gic-v5-its.c         | 132 ++++++++++++++++++++++++++++++-
> >  drivers/pci/msi/irqdomain.c              |   2 +
> >  include/linux/acpi_iort.h                |  10 ++-
> >  include/linux/irqchip/arm-gic-v5.h       |   1 +
> >  7 files changed, 241 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 65f0f56ad753..17dbe66da804 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -595,45 +595,45 @@ u32 iort_msi_map_id(struct device *dev, u32 input_id)
> >  }
> >
> > +/**
> > + * iort_pmsi_get_msi_info() - Get the device id and translate frame PA for a device
> > + * @dev: The device for which the mapping is to be done.
> > + * @dev_id: The device ID found.
> > + * @pa: optional pointer to store translate frame address.
> > + *
> > + * Returns: 0 for successful devid and pa retrieval, -ENODEV on error
> > + */
> > +int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa)
> > +{
> > +	struct acpi_iort_node *node, *parent = NULL;
> > +	struct acpi_iort_its_group *its;
> > +	int i, index;
> > +
> > +	node = iort_find_dev_node(dev);
> > +	if (!node)
> > +		return -ENODEV;
> > +
> > +	index = iort_get_id_mapping_index(node);
> > +	/* if there is a valid index, go get the dev_id directly */
> > +	if (index >= 0) {
> > +		parent = iort_node_get_id(node, dev_id, index);
> > +	} else {
> > +		for (i = 0; i < node->mapping_count; i++) {
> > +			parent = iort_node_map_platform_id(node, dev_id,
> > +						      IORT_MSI_TYPE, i);
> > +			if (parent)
> > +				break;
> > +		}
> > +	}
> > +
> Another borderline comment on what I think is a small readabilty
> improvement.
> 
> I'd handle the only error case that would otherwise use the ternary below
> here
> 	if (!parent)
> 		return -ENODEV;
> 
> 	if (pa) {
> 		...
> 	}
> 	return 0;

Updated.

Thanks,
Lorenzo

> > +	if (parent && pa) {
> > +		int ret;
> > +
> > +		its = (struct acpi_iort_its_group *)node->node_data;
> > +		ret = iort_find_its_base(its->identifiers[0], pa);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return parent ? 0 : -ENODEV;
> > +}
> 
> 

