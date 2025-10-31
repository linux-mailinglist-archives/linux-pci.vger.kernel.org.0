Return-Path: <linux-pci+bounces-39888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C76C234A1
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB1824E2410
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 05:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABF4190473;
	Fri, 31 Oct 2025 05:30:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C55C96;
	Fri, 31 Oct 2025 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888652; cv=none; b=FFOFqxu+5yeIlTDblpuY20h2RG6EBA2cG9IYoxAIRBvLe1UK+aQJrBE2l1qFingfCOP3unC2XGb/vcsqRs0OGtETo63CZ03NL35FEH6oyfybmNrn6tXFtwNsUCDOl7jvnJC7DHRX/BN4TTrcSZv1by/OH+597gSb1uKWhC90NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888652; c=relaxed/simple;
	bh=Om9LVoX/Cs0SCI3rhvTpRuU7NE415+dVCJaSGTQQcCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bedn4U/DQQOBxL9YXlLwupHh3ePXfQQ5Gh8zGDLSapiHmki7/oX1bHBsbEBBN0irjgwPOCA3kHE5ojwrXXfyTT9AvdBnMCiLT9cnF0XUTsgIxt1qXauemG4qnDzGmzwVmptr6I0RpT+1d8kzWcQHgIQpYrY7gzoiLF6K0OrW4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D11372C0009F;
	Fri, 31 Oct 2025 06:30:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B59605B97; Fri, 31 Oct 2025 06:30:38 +0100 (CET)
Date: Fri, 31 Oct 2025 06:30:38 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 10/25] CXL/AER: Update PCI class code check to use
 FIELD_GET()
Message-ID: <aQRJfp0ImrWb-7Ip@wunner.de>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-11-terry.bowman@amd.com>
 <20251001171216.00005fa0@huawei.com>
 <aN4sWxjrzxeCyGBO@wunner.de>
 <639cb124-4c92-4d10-a4ce-78d6d862060f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639cb124-4c92-4d10-a4ce-78d6d862060f@amd.com>

On Thu, Oct 30, 2025 at 12:16:06PM -0500, Bowman, Terry wrote:
> On 10/2/2025 2:40 AM, Lukas Wunner wrote:
> > On Wed, Oct 01, 2025 at 05:12:16PM +0100, Jonathan Cameron wrote:
> >> On Thu, 25 Sep 2025 17:34:25 -0500 Terry Bowman <terry.bowman@amd.com> wrote:
> >> The way that class code definitions work in pci_ids.h is somewhat odd
> >> in my opinion, so I'd like input from Bjorn, Lukas etc on whether a
> >> generic mask definition is a good idea or more likely to cause problems.
> >>
> >> See for example. 
> >> #define PCI_BASE_CLASS_STORAGE		0x01
> >> ...
> >>
> >> #define PCI_CLASS_STORAGE_SATA		0x0106
> >> #define PCI_CLASS_STORAGE_SATA_AHCI	0x010601
> >>
> >> This variability in what is called CLASS_* leads to fun
> >> situations like in drivers/ata/ahci.c where we have some
> >> PCI_CLASS_* shifted and some not...
> > Macros working with PCI class codes generally accept a "shift" parameter
> > to know by how many bits the class code needs to be shifted, see e.g.
> > DECLARE_PCI_FIXUP_CLASS_EARLY() and friends.
> >
> > A macro which shifts exactly by 8 is hence only of limited use.
> >
> >>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> >>> @@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
> >>>  		return false;
> >>>  
> >>>  	/*
> >>> -	 * CXL Memory Devices must have the 502h class code set (CXL
> >>> -	 * 3.0, 8.1.12.1).
> >>> +	 * CXL Memory Devices must have the 502h class code set
> >>> +	 * (CXL 3.2, 8.1.12.1).
> >>>  	 */
> >>> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> >>> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
> >>>  		return false;
> > Hm, this doesn't look more readable TBH.
> >
> > Refactoring changes like this one should be submitted separately from
> > this patch set.  If any of them are controversial, they delay upstreaming
> > of the actual change, i.e. the CXL AER plumbing.  They also increase the
> > size of the patch set, making it more difficult to review.
> >
> >>> +++ b/include/uapi/linux/pci_regs.h
> >>> @@ -73,6 +73,8 @@
> >>>  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
> >>>  #define PCI_CLASS_DEVICE	0x0a	/* Device class */
> >>>  
> >>> +#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
> >>> +
> >>>  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
> >>>  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
> >>>  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
> > Putting this in a uapi header means we'll have to support it
> > indefinitely.  Usually such macros are added to kernel-internal
> > headers first and moved to uapi headers if/when the need arises.
> 
> The PCI_CLASS_CODE_MASK definition move to include/uapi/linux/pci_regs.h
> was requested here:
> https://lore.kernel.org/linux-cxl/6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch/

Hm, I'm not seeing such a request in the linked message.

> Would you like this patch removed altogether?

"I wouldn't object to it being removed" would be a more pleasant way
of phrasing it. ;)

Thanks,

Lukas

