Return-Path: <linux-pci+bounces-38333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B2BE3063
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015364F1F7D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73A30BB9A;
	Thu, 16 Oct 2025 11:12:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8230B538
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613179; cv=none; b=BPnBZf4TFSu2n0xvG2RkKs9KMWaEhINaQ5q5/tOjBPxvWvzF3uGH7ZrCgtE8ZNupYanOLAO4lSeaF5m1m+ELLTfG79/XyrblEqJI5abFr6kP1EeuibUfVZI18CaYY1rh6BujOZ2/VkVkaVJuI2Gti5hxG2Dw99jz8PH6sVAiiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613179; c=relaxed/simple;
	bh=MZYkKkorzjs2AyVDuXTTrCkl4SEuv4JZG9Dfc8N2vlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isAVA6CwguRDJRnBMJttJiOHOqlWayVxvoDsEVPr9yB9l7gVVrSOSd3JehGiZgMs+w1EnllQaFQSA6t3bEpLJVUMTRTHtq/tOkYRUeMe6lOVcv9rmhRZyBjnwcyYAMSEEqnFXwPZoVrBJYL5mb+xq7PeMfvx94t7uxmDum0ATSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59GBCfS4020808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 19:12:41 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Oct 2025 19:12:41 +0800
Date: Thu, 16 Oct 2025 19:12:36 +0800
From: Randolph Lin <randolph@andestech.com>
To: Niklas Cassel <cassel@kernel.org>
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
Subject: Re: [PATCH v6 1/5] PCI: dwc: Allow adjusting the number of ob/ib
 windows in glue driver
Message-ID: <aPDTJKwmpxolGEyj@swlinux02>
References: <20251003023527.3284787-1-randolph@andestech.com>
 <20251003023527.3284787-2-randolph@andestech.com>
 <aO4bWRqX_4rXud25@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aO4bWRqX_4rXud25@ryzen>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59GBCfS4020808

Hi Niklas,

On Tue, Oct 14, 2025 at 11:43:53AM +0200, Niklas Cassel wrote:
> [EXTERNAL MAIL]
> 
> On Fri, Oct 03, 2025 at 10:35:23AM +0800, Randolph Lin wrote:
> > The number of ob/ib windows is determined through write-read loops
> > on registers in the core driver. Some glue drivers need to adjust
> > the number of ob/ib windows to meet specific requirements,such as
> 
> Missing space after comma.
> 
> 

Thanks a lot. I will fix it in the next patch.

> > hardware limitations. This change allows the glue driver to adjust
> > the number of ob/ib windows to satisfy platform-specific constraints.
> > The glue driver may adjust the number of ob/ib windows, but the values
> > must stay within hardware limits.
> 
> Could we please get a better explaination than "satisfy platform-specific
> constraints" ?
> 

Due to this SoC design, only iATU regions with mapped addresses within the
32-bits address range need to be programmed. However, this SoC has a design
limitation in which the maximum region size supported by a single iATU
entry is restricted to 4 GB, as it is based on a 32-bits address region.

For most EP devices, we can only define one entry in the "ranges" property
of the devicetree that maps an address within the 32-bit range,
as shown below:
	ranges = <0x02000000 0x0 0x10000000 0x0 0x10000000 0x0 0xf0000000>;

For EP devices that require 64-bits address mapping (e.g., GPUs), BAR
resources cannot be assigned.
To support such devices, an additional entry for 64-bits address mapping is
required, as shown below:
	ranges = <0x02000000 0x0 0x10000000 0x0 0x10000000 0x0 0xf0000000>,
		 <0x43000000 0x1 0x00000000 0x1 0x00000000 0x7 0x00000000>;

In the current common implementation, all ranges entries are programmed to
the iATU. However, the size of entry for 64-bit address mapping exceeds the
maximum region size that a single iATU entry can support. As a result, an
error is reported during iATU programming, showing that the size of 64-bit
address entry exceeds the region limit.

In this SoC design, 64-bit addresses are hard-wired and can skip iATU
programming. Thus, the driver needs to recount the "ranges" entries whose
size fits within the 4GB platform limit.

There are four scenarios:
32-bits address, size < 4GB: program to iATU
64-bits address, size < 4GB: program to iATU
32-bits address, size > 4GB: assuming this condition does not exist
64-bits address, size > 4GB: skip case

We will recount how many outbound windows will be programmed to the iATU; 
this is why we need to adjust the number of entries programmed to the iATU.

> Your PCIe controller is synthesized with a certain number of {in,out}bound
> windows, and I assume that dw_pcie_iatu_detect() correctly detects the number
> of {in,out}bound windows, and initializes num_ob_windows/num_ib_windows
> accordingly.
> 
> So, is the problem that because of some errata, you cannot use all the
> {in,out}bound windows of the iATU?
>

Similar to the erratum, all inbound and outbound windows remain functional,
as long as each iATU entry complies with the 4 GB size constraint.

> Because it is hard to understand what kind of "hardware limit" that would
> cause your SoC to not be able to use all the available {in,out}bound windows.
> 
> Because it is simply a mapping in the iATU (internal Address Translation Unit).
> 
> In fact, in many cases, e.g. the NVMe EPF driver, then number of {in,out}bound
> windows is a major limiting factor of how many outstanding I/Os you can have,
> so usually, you really want to be able to use the maximum that the hardware
> supports.
> 
> 
> TL;DR: to modify this common code, I think your reasoning has to be more
> detailed.
> 

I will include additional explanations along with the application scenarios of
this SoC, and refactor the commit message.

> 
> 
> Kind regards,
> Niklas

Sincerely,
Randolph

