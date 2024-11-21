Return-Path: <linux-pci+bounces-17186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EADD9D5580
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FC11F242F6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 22:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084191917FE;
	Thu, 21 Nov 2024 22:32:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3E5695;
	Thu, 21 Nov 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228355; cv=none; b=COpUzA8AKQmk0OUYKLjeKlD4DPgB9A1zCSHGAO3RCqiPPvckabXqRCdlrpUTeRIzEh52sLRc+Y89cOWHIg7FcbOOqmcUkvFi4kviWYy5soNN6n1RgFGsiWf6bje10Wd21lZyy5m+Wfeag0GsC6YXVLUi0CBS2XJOksfxn74Sedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228355; c=relaxed/simple;
	bh=OSDP648lDt7Tf3SrrgCOs+h8R2qVThcd7JCYaUNoemU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVtK2y0tnNH4YDj+VspJ2sL5NUdKZsSfArhShsa4Kj/49BGZa4mDmL4HyPTaeuADUOU8Wgn7f0A28pCqU2J3OQUL0Z3hQNiuxl471TjnXXpkyYWPHhxGZUYQ9CSDRPW1iEibI6sKO3CSAC5OLSZBcLWxnPEtXEQL2VztAbFVJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A76A13000B9FB;
	Thu, 21 Nov 2024 23:32:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 80A2631BB07; Thu, 21 Nov 2024 23:32:29 +0100 (CET)
Date: Thu, 21 Nov 2024 23:32:29 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v3 15/15] PCI/AER: Enable internal errors for CXL
 upstream and downstream switch ports
Message-ID: <Zz-0_RJGI0rbPHZx@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-16-terry.bowman@amd.com>
 <Zzsq6-GN0GFKb3_S@wunner.de>
 <4529f2a2-e655-4906-8e21-8d5d90db4468@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4529f2a2-e655-4906-8e21-8d5d90db4468@amd.com>

On Thu, Nov 21, 2024 at 04:25:31PM -0600, Bowman, Terry wrote:
> On 11/18/2024 5:54 AM, Lukas Wunner wrote:
> > Hm, it seems the reason why you're moving pci_aer_unmask_internal_errors()
> > outside of "ifdef CONFIG_PCIEAER_CXL" is that drivers/cxl/core/pci.c
> > is conditional on CONFIG_CXL_BUS, whereas CONFIG_PCIEAER_CXL depends
> > on CONFIG_CXL_PCI.
> >
> > In other words, you need this to avoid build breakage if CONFIG_CXL_BUS
> > is enabled but CONFIG_CXL_PCI is not.
> >
> > I'm wondering (as a CXL ignoramus) why that can happen in the first
> > place, i.e. why is drivers/cxl/core/pci.c compiled at all if
> > CONFIG_CXL_PCI is disabled?
[...]
> The drivers/cxl/Makefile file shows CONFIG_CXL_PCI gates cxl_pci.c build with:
> obj-$(CONFIG_CXL_PCI) += cxl_pci.o

I wasn't referring to drivers/cxl/pci.c, but drivers/cxl/core/pci.c.
That's gated by CONFIG_CXL_BUS, not CONFIG_CXL_PCI, which seems weird.

Thanks,

Lukas

