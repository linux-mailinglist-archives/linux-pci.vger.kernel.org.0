Return-Path: <linux-pci+bounces-18129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63D9ECD19
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B81882117
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA6229142;
	Wed, 11 Dec 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1WaVxbN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8122912A
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923378; cv=none; b=rBDRRFramVT5XuOU3FNQu7qD+x74PlQXDZq3+KPq6oQGbH6pY0NnVLHA3QAjPytFRZ08i+yQmxcjJWfYdek3nNR3h7gUEeD4u2/QpB+svXMduaMoo6UMGlPkT8VipWS0fWa2lOUjvZRcQclrFWKFkzmeZE3tcLPzcCRjgIbwHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923378; c=relaxed/simple;
	bh=3D6VB6xTviXfB4BvoMvdRH5nMb1zGiLBd7qVyqrrsYk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=emAe7SrOg4fBzJUfCG8Dcsy10u9fisAcrwUecrhBN9yngHB+QKsh1p8yDOfdONmioRYVnML1CYLUNf6OfgfbFvgIV+HD1dcqEY2J9Wn4jEdPGS50zwWd4jbDxA1sWVOnz1wQXZ+t9Mn5+Wm7vnq81bVsarMBg1urq787o1B2SLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1WaVxbN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733923377; x=1765459377;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3D6VB6xTviXfB4BvoMvdRH5nMb1zGiLBd7qVyqrrsYk=;
  b=O1WaVxbNE9IQmAsx49HIvRu3boRGpB/oT44GZPQ+Z+/lX4yfoK8A85tK
   wJRchgolbrpGng8vx/SNUJSFqYXaM6wcDRJo9fJQaHtRt4p5PE0BLC2hS
   Gs5uK8+e0ZHlLbsRrTjt02Odm4ySqC23gyKtVo186M3gi2jur+P8Q21zW
   ZDI8POy4YEgEjaUJrJ/ji40AW4mjauqxG7GVtq1Xy+cJOMHlsMdapiPTM
   PrqR+YB2j+W6KjrCFKrBRkiolnRP0/xsOZpGOBSdfg2LzPl3WZPNhjC+H
   3Up7bphPoMYiESvhy+V3Rf7fksBGFsR6Tk35mPkS62IHtNM9hl4G8ympz
   A==;
X-CSE-ConnectionGUID: geqMKnYYSDiWoxyTX0aX/Q==
X-CSE-MsgGUID: tLrGwZKNQ2OhzN+YAm6UWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34441795"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34441795"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:22:56 -0800
X-CSE-ConnectionGUID: XPYRTanZSD66miTaJ147PA==
X-CSE-MsgGUID: kXlnUi9SRims3IyYy6WMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100863333"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:22:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Dec 2024 15:22:50 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev, 
    Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, 
    Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
In-Reply-To: <20241210192140.GA3079633@bhelgaas>
Message-ID: <c7fce545-e369-0dba-fbbe-3d90b67e5cfb@linux.intel.com>
References: <20241210192140.GA3079633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Dec 2024, Bjorn Helgaas wrote:

> On Thu, Dec 05, 2024 at 02:23:56PM -0800, Dan Williams wrote:
> > PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> > enumerates new link capabilities and status added for Gen 6 devices. One
> > of the link details enumerated in that register block is the "Segment
> > Captured" status in the Device Status 3 register. That status is
> > relevant for enabling IDE (Integrity & Data Encryption) whereby
> > Selective IDE streams can be limited to a given requester id range
> > within a given segment.
> 
> s/requester id/Requester ID/ to match spec usage
> 
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -749,6 +749,7 @@
> >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
> 
> It doesn't look like lspci knows about this; is there something in
> progress to add that?
> 
> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/header.h?id=v3.13.0#n257

Hi,

I've two patches lying around that add a few Flit mode related fields 
and Dev3 into lspci, although the latter patch doesn't exactly have all 
the fields from Dev3 but at least it would be a good start for many 
things.

I think I'll just post them as is and see where it goes.

> >  #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE

-- 
 i.


