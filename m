Return-Path: <linux-pci+bounces-23397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D0A5B59E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9E21893CBD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AED149C55;
	Tue, 11 Mar 2025 01:11:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0C1DE4CD;
	Tue, 11 Mar 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741655496; cv=none; b=U2h64pHSf6Txh09vCVYzF3m33/gJD1mzq/Gw7RtfWNdjKQ9hm762n28zoECSmPPZa/sb4Wexbh7ayKbaE61wJDu4C3cKGn7wP5cm8D0rjNcZpdlUO2kc+9rx7W86sXeW/v9j5RtO5/dMcmxlixEubyWs+lfm4vX0lj7ntQnrM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741655496; c=relaxed/simple;
	bh=57JqbP0QgPnQSB1yMtAl+y1UXG7/HiZ+JnktlUA8j9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwPliEzfd/Q27pVhu18DkIxZldgn83jHERP7c4P4qDqGG/7c/fRu+f7rwD0/+7eusjd8pKV5KcEvXZ8F+FnJneKUKdA+5rl9eiXhY+TYmL8SEE1hne//F0PPIstPrPSd1HCha8Lmisyi4LHZeijyfgZ1VJXCLsr00WMAcy1NA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD39VW4jc9nG9dxCA--.6446S2;
	Tue, 11 Mar 2025 09:11:20 +0800 (CST)
Received: from localhost (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwAXHYm0jc9npJdCAA--.9065S2;
	Tue, 11 Mar 2025 09:11:16 +0800 (CST)
Date: Tue, 11 Mar 2025 09:11:14 +0800
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com, cassel@kernel.org,
 christian.koenig@amd.com, kw@linux.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Update Resizable BAR Capability Register fields
Message-ID: <20250311091114.0000524b@phytium.com.cn>
In-Reply-To: <20250307173245.GA414123@bhelgaas>
References: <20250307053535.44918-1-daizhiyuan@phytium.com.cn>
	<20250307173245.GA414123@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAXHYm0jc9npJdCAA--.9065S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr1rXr18Jw4xZrWrCw45Wrg_yoWrAFyxpr
	WkAa95GrW8JFW7uwsFv3W8ZrWYgwsrXFyrCrWfG3s3uFn09F1SqF1UGFy5Ka4kJr4kAF4I
	qFnFvw15Zr98JaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Thank you very much for everyone's comments and guidance.

On Fri, 7 Mar 2025 11:32:45 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Mar 07, 2025 at 01:35:29PM +0800, Zhiyuan Dai wrote:
> > PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
> > but supporting anything bigger than 128TB requires changes to
> > pci_rebar_get_possible_sizes() to read the additional Capability
> > bits from the Control register.
> > 
> > If 8EB support is required, callers will need to be updated to
> > handle u64 instead of u32. For now, support is limited to 128TB,
> > and support for sizes greater than 128TB can be deferred to a later
> > time.
> > 
> > Expand the alignment array of `pbus_size_mem` to support up to
> > 128TB.
> > 
> > Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>  
> 
> Replaced the v3 patch that was already applied with this v4 patch,
> thanks.
> 
> Please:
> 
>   - Include a changelog below the "---" marker to tell me what changed
>     between v3 and v4.
> 
>   - Don't include Reviewed-by from people who haven't explicitly
>     replied with that tag.  In this case, arguably you could retain
>     those from Christian and Niklas, because they did give that tag
>     for v3, and you only added the pbus_size_mem() change.
> 
>     But Ilpo only gave you a comment on v3, and did *not* supply his
>     Reviewed-by.  You should never create a Reviewed-by tag in that
>     event.
> 
>     I dropped all the Reviewed-by tags for now; happy to add them
>     if/when the reviewers actually supply them.
> 
> > ---
> >  drivers/pci/pci.c             | 4 ++--
> >  drivers/pci/setup-bus.c       | 2 +-
> >  include/uapi/linux/pci_regs.h | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 661f98c6c63a..77b9ceefb4e1 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev
> > *pdev, int bar)
> >   * @bar: BAR to query
> >   *
> >   * Get the possible sizes of a resizable BAR as bitmask defined in
> > the spec
> > - * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
> > + * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
> >   */
> >  u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
> >  {
> > @@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev
> > *pdev, int bar)
> >   * pci_rebar_set_size - set a new size for a BAR
> >   * @pdev: PCI device
> >   * @bar: BAR to set size to
> > - * @size: new size as defined in the spec (0=1MB, 19=512GB)
> > + * @size: new size as defined in the spec (0=1MB, 31=128TB)
> >   *
> >   * Set the new size of a BAR as defined in the spec.
> >   * Returns zero if resizing was successful, error code otherwise.
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 5e00cecf1f1a..edb64a6b5585 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1059,7 +1059,7 @@ static int pbus_size_mem(struct pci_bus *bus,
> > unsigned long mask, {
> >  	struct pci_dev *dev;
> >  	resource_size_t min_align, win_align, align, size, size0,
> > size1;
> > -	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB
> > */
> > +	resource_size_t aligns[28]; /* Alignments from 1MB to
> > 128TB */ int order, max_order;
> >  	struct resource *b_res = find_bus_resource_of_type(bus,
> >  					mask |
> > IORESOURCE_PREFETCH, type); diff --git
> > a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 1601c7ed5fab..ce99d4f34ce5 100644 ---
> > a/include/uapi/linux/pci_regs.h +++ b/include/uapi/linux/pci_regs.h
> > @@ -1013,7 +1013,7 @@
> >  
> >  /* Resizable BARs */
> >  #define PCI_REBAR_CAP		4	/* capability
> > register */ -#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0
> >  /* supported BAR sizes */ +#define  PCI_REBAR_CAP_SIZES
> > 	0xFFFFFFF0  /* supported BAR sizes */ #define
> > PCI_REBAR_CTRL		8	/* control register */
> > #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR
> > index */ #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* #
> > of resizable BARs */ -- 2.43.0
> >   


