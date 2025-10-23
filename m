Return-Path: <linux-pci+bounces-39138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D27C00FC2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D64F3A2BC3
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110A265621;
	Thu, 23 Oct 2025 12:08:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5063093A5
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221294; cv=none; b=bZu6X7qyv3nvtPUb/EO+6qSWUh3BEkqDxb4T4Vg43PrHt6lERDFj8Nb33+b6tFeSEsYP6D76fJHIP3XNFXMjYlj4v1dn4jVLjj3ufbuSsKtBv89hKzJiCAkttYKv53mKz8cSdlEcTUItVaovWEgZteDaHYBGZSrpxFLnEtt0lFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221294; c=relaxed/simple;
	bh=56HF8yPKnyC6WmuLneXo5ZjXWAV4y8yWZT0QFT1/SuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdtFrZ4OCDWYMgAycwE8etSl8JvbRGBkxAS7g60EJAw4kPkF5HYh/msl7hOMml96PA+TgRWejdY2C/Q4gtHviXC4oREdVsGw8wk8YZlRYL4K4Huk9mLaM+41bwl34jif1RgUeBrBrlKrjIObXts71c1IqAunCFoFwPhSCV3Pxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59NC80MN038496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 20:08:00 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 23 Oct 2025 20:08:00 +0800
Date: Thu, 23 Oct 2025 20:07:53 +0800
From: Randolph Lin <randolph@andestech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alex@ghiti.fr>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <ben717@andestech.com>,
        <inochiama@gmail.com>, <thippeswamy.havalige@amd.com>,
        <namcao@linutronix.de>, <shradha.t@samsung.com>, <pjw@kernel.org>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>
Subject: Re: [PATCH v8 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <aPoamRtpsT-MK9v0@swlinux02>
References: <20251014120349.656553-5-randolph@andestech.com>
 <20251021170516.GA1193376@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021170516.GA1193376@bhelgaas>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59NC80MN038496

Hello Bjorn,
On Tue, Oct 21, 2025 at 12:05:16PM -0500, Bjorn Helgaas wrote:
> [EXTERNAL MAIL]
> 
> On Tue, Oct 14, 2025 at 08:03:48PM +0800, Randolph Lin wrote:
> > Add driver support for DesignWare based PCIe controller in Andes
> > QiLai SoC. The driver only supports the Root Complex mode.
> 
> > + * Setup the Qilai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
> > + * Write-Back, Read and Write Allocate mode.
> 
> s/Setup/Set up/
> s/Qilai/QiLai/
> 

ok

> > + * The QiLai SoC PCIe controller's outbound iATU region supports
> > + * a maximum size of SZ_4G - 1. To prevent programming failures,
> > + * only consider bridge->windows with sizes within this limit.
> > + *
> > + * To ensure compatibility with most endpoint devices, at least
> > + * one memory region must be mapped within the 32-bits address space.
> > + */
> > +static int qilai_pcie_host_fix_ob_iatu_count(struct dw_pcie_rp *pp)
> > +{
> > +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +     struct device *dev = pci->dev;
> > +     struct resource_entry *entry;
> > +     /* Reserved 1 ob iATU for config space */
> > +     int count = 1;
> > +     bool ranges_32bits = false;
> > +     u64 pci_addr;
> > +     u64 size;
> > +
> > +     resource_list_for_each_entry(entry, &pp->bridge->windows) {
> > +             if (resource_type(entry->res) != IORESOURCE_MEM)
> > +                     continue;
> > +
> > +             size = resource_size(entry->res);
> > +             if (size < SZ_4G)
> > +                     count++;
> > +
> > +             pci_addr = entry->res->start - entry->offset;
> > +             if (pci_addr < SZ_4G)
> > +                     ranges_32bits = true;
> > +     }
> > +
> > +     if (!ranges_32bits) {
> > +             dev_err(dev, "Bridge window must contain 32-bits address\n");
> > +             return -EINVAL;
> 
> Is this really a PCI host controller driver probe failure?  I assume
> there are devices that only have 64-bit BARs and could work fine
> without a 32-bit window?
> 
> If a device requires a 32-bit BAR, and the PCI core can't assign such
> an address, and gracefully decline to enable a device where we
> couldn't assign the BAR, I think that would be preferable and would
> identify the specific device that doesn't work.
>

I have a clear understanding of the meaning behind this.
However, based on reviewer Niklas's suggestion, I have decided to use patch [1].
As a result, the function that adjusts the number of ib/ob window is no longer needed.

[1]: https://lore.kernel.org/linux-pci/aPDObXsvMoz1OYso@ryzen/T/#m11c3d95215982411d0bbd36940e70122b70ae820

> > +     }
> > +
> > +     pci->num_ob_windows = count;
> > +
> > +     return 0;
> > +}
> 
Sincerely,
Randolph Lin

