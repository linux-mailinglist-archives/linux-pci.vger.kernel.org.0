Return-Path: <linux-pci+bounces-38734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABDBF0E25
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1469A4EB0A4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0C930148B;
	Mon, 20 Oct 2025 11:39:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821B2F693C;
	Mon, 20 Oct 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960376; cv=none; b=pcpT3M6y0k3vOkPGJ5UUWZf8OD0c11/I8892Q8/NKipmseNk2NmKKLwh0bZc+iokFAsemik5fDsRUWUf+VxKSbqugD9hwHOdluiTuX/7ZKwtL3s32ZrnvkZimpEE6nK+a2Hfyx08+AEobB3x2bjuHmq8qQ48RA1zYBg2sVbmoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960376; c=relaxed/simple;
	bh=tTkRyjMu+APc6t21uIUC4uhfOk90zU+A/TguluTuk+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt8Hw5BubELfA0zHgRf6/ysVXrBVt/bvkvAT5KZ13MlL4xYM8OiwNZVN21xDfXBvM2LfBAxX6NoyfswzUOOv8+UYFErNLHYMNfHyApNGSg6T15AEtpcEQQ36ERHeu8Q535ZO5DmSb8fWlTLoySF4fjHRKV8xmglkKX5PeOZ9pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59KBZr2h094400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 19:35:53 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Mon, 20 Oct 2025 19:35:52 +0800
Date: Mon, 20 Oct 2025 19:35:48 +0800
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
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v6 1/5] PCI: dwc: Allow adjusting the number of ob/ib
 windows in glue driver
Message-ID: <aPYehqSefwW_-pAI@swlinux02>
References: <20251003023527.3284787-1-randolph@andestech.com>
 <20251003023527.3284787-2-randolph@andestech.com>
 <aO4bWRqX_4rXud25@ryzen>
 <aPDTJKwmpxolGEyj@swlinux02>
 <aPDc-yclubiHbUcD@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPDc-yclubiHbUcD@ryzen>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 59KBZr2h094400

Hello Niklas,

On Thu, Oct 16, 2025 at 01:54:35PM +0200, Niklas Cassel wrote:
> [EXTERNAL MAIL]
> 
> Hello Randolph,
> 
> On Thu, Oct 16, 2025 at 07:12:36PM +0800, Randolph Lin wrote:
> > >
> > > Could we please get a better explaination than "satisfy platform-specific
> > > constraints" ?
> > >
> >
> > Due to this SoC design, only iATU regions with mapped addresses within the
> > 32-bits address range need to be programmed. However, this SoC has a design
> > limitation in which the maximum region size supported by a single iATU
> > entry is restricted to 4 GB, as it is based on a 32-bits address region.
> >
> > For most EP devices, we can only define one entry in the "ranges" property
> > of the devicetree that maps an address within the 32-bit range,
> > as shown below:
> >       ranges = <0x02000000 0x0 0x10000000 0x0 0x10000000 0x0 0xf0000000>;
> >
> > For EP devices that require 64-bits address mapping (e.g., GPUs), BAR
> > resources cannot be assigned.
> > To support such devices, an additional entry for 64-bits address mapping is
> > required, as shown below:
> >       ranges = <0x02000000 0x0 0x10000000 0x0 0x10000000 0x0 0xf0000000>,
> >                <0x43000000 0x1 0x00000000 0x1 0x00000000 0x7 0x00000000>;
> >
> > In the current common implementation, all ranges entries are programmed to
> > the iATU. However, the size of entry for 64-bit address mapping exceeds the
> > maximum region size that a single iATU entry can support. As a result, an
> > error is reported during iATU programming, showing that the size of 64-bit
> > address entry exceeds the region limit.
> 
> Note that each iATU can map up to IATU_LIMIT_ADDR_OFF_OUTBOUND_i +
> IATU_UPPR_LIMIT_ADDR_OFF_OUTBOUND_i.
> 
> Some DWC controllers have this at 4G, others have this at 8G.
> 
> Samuel has submitted a patch to use multiple iATUs to support
> a window size larger than the iATU limit of a single iATU:
> https://lore.kernel.org/linux-pci/aPDObXsvMoz1OYso@ryzen/T/#m11c3d95215982411d0bbd36940e70122b70ae820
> 
> Perhaps this patch could be of use for you too?
>

Thank you for the information.
After applying Samuel’s patch, the code passes the basic functionality
tests. Therefore, the common code patch is no longer needed.

> 
> Kind regards,
> Niklas

Sincerely,
Randolph Lin

