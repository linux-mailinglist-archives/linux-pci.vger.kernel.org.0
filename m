Return-Path: <linux-pci+bounces-28112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E7ABDCEC
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BEF3B9CE0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0F24679D;
	Tue, 20 May 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKWHBmle"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1D25CC6C;
	Tue, 20 May 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750849; cv=none; b=oIS1XAEr9W9Z5qBlpXsPW98rKJWoi7sE3m4iBBXhiBi6NpUBmPWJ+BJP+JV3MBqg0i0PuL13gdiGEH/KJ5dqg2Nt/GF3q5QaDC4KjUiV/NYK7S9CY353tDc0BH4YbOLh/VuQX84L/h2aAd1Vp0a7pRk2VLugIT0ASY/mKWRE1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750849; c=relaxed/simple;
	bh=Iwy8kTFA+CL3opqrAZmUfyGJXHiNgP8g4TkfU4hripA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bHhmca8l/B2oYuHqtlXLl7ZHaTHx0ZzmFW2rn80ectmXG0L00J5n0IdiZBZkWifeOyh62VhjGBSSVNyD2SwmzlpNADSJDNPZ2PJKkIhIYBfzLrDk+241xwwdM76BVBcKB+j3sHQ++Bx6br6881jNG+FBIyq1hseaNxdWu9CtraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKWHBmle; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747750848; x=1779286848;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Iwy8kTFA+CL3opqrAZmUfyGJXHiNgP8g4TkfU4hripA=;
  b=KKWHBmlekI2Y6B/ih1rIexB6J+U2LRhNjSssciRq6hjVfoFAg7vkxnZ8
   P2i2OVY4h14Lrv9r36WaRbrOAPfAFBJeXsIBYb4qACn83cY7shnW+YtXF
   7Z0kQE0A2MvbvLe7xA8tyIocQCN+zjvn9eJMjhatVkBA0QJ3RYP35KSSL
   Ev6/7Fv6td1RguhbuWWdzwVP0OStqYakv58Cy2BHmKOFZAx9hh5sVMXAw
   cr5JnpYv6ZJxLfP8WWSsibwkrNVbvv1swwhjo1G24qj4UgpRy1NkiecVV
   4SqP8kJAtl6cotAZkJ52flVy5nmQqaIP57htTEoD8mT+hYdQasIY3jaKY
   Q==;
X-CSE-ConnectionGUID: ndB1uPhvQK2X14t7ChlM4g==
X-CSE-MsgGUID: SsipaexVTd2/kuiZItiN2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60345935"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60345935"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 07:20:46 -0700
X-CSE-ConnectionGUID: Gyg/2X3wTZ+ThaqpK5G17Q==
X-CSE-MsgGUID: AC6vN28JQX+9Hj8h2W3gsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139606900"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 07:20:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 17:20:36 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 02/16] PCI/DPC: Log Error Source ID only when valid
In-Reply-To: <20250520140025.GA1291490@bhelgaas>
Message-ID: <57dc908d-c158-9019-b86e-3c051b951d17@linux.intel.com>
References: <20250520140025.GA1291490@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 May 2025, Bjorn Helgaas wrote:

> On Mon, May 19, 2025 at 04:15:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
> > On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > DPC Error Source ID is only valid when the DPC Trigger Reason indicates
> > > that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
> > > Message (PCIe r6.0, sec 7.9.14.5).
> > > 
> > > When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
> > > or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
> > > log the Error Source ID (decoded into domain/bus/device/function).  Don't
> > > print the source otherwise, since it's not valid.
> > > 
> > > For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
> > > logging changes:
> > > 
> > >    - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
> > >    - pci 0000:00:01.0: DPC: ERR_FATAL detected
> > >    + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0
> > > 
> > > and when DPC triggered for other reasons, where DPC Error Source ID is
> > > undefined, e.g., unmasked uncorrectable error:
> > > 
> > >    - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
> > >    - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
> > >    + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected
> > > 
> > > Previously the "containment event" message was at KERN_INFO and the
> > > "%s detected" message was at KERN_WARNING.  Now the single message is at
> > > KERN_WARNING.
> > 
> > Since we are handling Uncorrectable errors, why not use pci_err?
> 
> Sounds reasonable to me.  I would do it in a separate patch because
> the point of this one is to avoid logging junk when Error Source ID is
> not valid.
> 
> > > +		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
> > > +			 status,
> > 
> > I see the BDF extraction and format code in many places in the PCI
> > drivers. May be a common macro will make it more readable.
> 
> Good idea.  Not sure how to implement it, so I put that on my TODO
> list for now.

Instead of macros, it might be worth adding a printf specifier for this. 
Together with some flags, it should be possible to cover also the 
variations that print less than the full BDF format.

> > > +			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> > > +				"ERR_FATAL" : "ERR_NONFATAL",
> > > +			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
> > > +			 PCI_SLOT(source), PCI_FUNC(source));
> 

-- 
 i.


