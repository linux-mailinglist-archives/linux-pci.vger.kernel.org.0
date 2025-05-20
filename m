Return-Path: <linux-pci+bounces-28109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB92ABDAB6
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E21BA51F3
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86024501D;
	Tue, 20 May 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffPB7CiV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590CEEDE;
	Tue, 20 May 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749627; cv=none; b=L/92UzOh9JNIaxFKulL4JakVw0CBumwNnbADkowWmrgd0lTadID3T1weIjw7RUTZK+CyDLd/xmMY0dCRNQHsMJMg47xmZajnL5gLiCXMEAx0KzDyq8y4Urs3eH7QlP1pZ3VXSOliDyn/0xMzLWZ1jDgW5XTv+md5n51OfXXqwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749627; c=relaxed/simple;
	bh=CPYEn7+xChTDmwQcUBPa5EjvOPTYgNzqRqlEyGR3lDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hMqAchcGMcvrOCFCiaIcQwuSo05+RJEy7gJUrtO+dDCUDsnCgTTL0PzWa/mhfg5zUVstsceMSg+odwivMzmrrfEl22bh3/LnuZYg9ki9g4za6l2WaHLyQwK2MKNVrh+TitFEIRXR3QPqSdkHEnT4CenffKPzWLOOz61PdHZg1PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffPB7CiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3487EC4CEE9;
	Tue, 20 May 2025 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749627;
	bh=CPYEn7+xChTDmwQcUBPa5EjvOPTYgNzqRqlEyGR3lDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ffPB7CiVwC4HtUFlXvhAIB/covrTJ6Us+dGTk69bT5m/HmOCpD8EgqkI0PkQ/ZLcv
	 NvepHGKYlC73SlNb941W2kXBNMa5M+xwm5xYZstiELC2NpJiP1CVRXtNCnJ/x4+LKj
	 KOl8ClYfjbmqCrB/mBnGMMFMCqGOMyc+Dp4348Us2duDz/vItGlTIqpg8OzKh1jERg
	 IcdBWsu/0OMZCdj3j7jPar/onFomqjy7eMFPvRsArwzLSlaC77I3XtBKFYaEOV7IBz
	 6VD7Zskq5FutS/JgPbVmdYdYnaePKFEOCqlbKxwZEsHhWuY5gPn4DRKxmtNEE4Np+c
	 ylk6UrsLTBMBQ==
Date: Tue, 20 May 2025 09:00:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 02/16] PCI/DPC: Log Error Source ID only when valid
Message-ID: <20250520140025.GA1291490@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37c5f7f-3460-4f58-892f-39faf88a8e9c@linux.intel.com>

On Mon, May 19, 2025 at 04:15:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > DPC Error Source ID is only valid when the DPC Trigger Reason indicates
> > that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
> > Message (PCIe r6.0, sec 7.9.14.5).
> > 
> > When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
> > or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
> > log the Error Source ID (decoded into domain/bus/device/function).  Don't
> > print the source otherwise, since it's not valid.
> > 
> > For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
> > logging changes:
> > 
> >    - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
> >    - pci 0000:00:01.0: DPC: ERR_FATAL detected
> >    + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0
> > 
> > and when DPC triggered for other reasons, where DPC Error Source ID is
> > undefined, e.g., unmasked uncorrectable error:
> > 
> >    - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
> >    - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
> >    + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected
> > 
> > Previously the "containment event" message was at KERN_INFO and the
> > "%s detected" message was at KERN_WARNING.  Now the single message is at
> > KERN_WARNING.
> 
> Since we are handling Uncorrectable errors, why not use pci_err?

Sounds reasonable to me.  I would do it in a separate patch because
the point of this one is to avoid logging junk when Error Source ID is
not valid.

> > +		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
> > +			 status,
> 
> I see the BDF extraction and format code in many places in the PCI
> drivers. May be a common macro will make it more readable.

Good idea.  Not sure how to implement it, so I put that on my TODO
list for now.

> > +			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> > +				"ERR_FATAL" : "ERR_NONFATAL",
> > +			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
> > +			 PCI_SLOT(source), PCI_FUNC(source));

