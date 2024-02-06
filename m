Return-Path: <linux-pci+bounces-3170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64384BB4E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9CD1C2320B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29846AD;
	Tue,  6 Feb 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYMDHaqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A204A15;
	Tue,  6 Feb 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238017; cv=none; b=QDuJVBE2OYQF3uIOM8X8Nwz3tBqIeHKDHCNbUq9L+me5Mdda+5EnttMYIAFRAsnRQCtUsRciBgAV/oKujcjBVLvKzVeXz3nyr1oTNIdAdpNuFVQMLxr9nxITsecNU4kJdDo3qLB+H0GOCoGIKjjBYl9VrnMzAX9VewmNsKG36q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238017; c=relaxed/simple;
	bh=USPZtu7vxjk1ebvcOxNJKhO0fXx2MLMuxDfhFtm/z84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oci5wMc+Qgyy04Jv0l+PwmJ8ipmOL/rJzU6h1YRc/whNa2s/8kAYTDPlDbZi265j5KWohf1AwHrjRls/s0AAjZ9UZcGipqQcNZ8I8lhdRYfA9RM0qUjIbzCzbG9CusLpZXK+96nmugDdcTSlVPhE7tEaya1hOi9t9LYbGGZ8wZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYMDHaqh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707238016; x=1738774016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=USPZtu7vxjk1ebvcOxNJKhO0fXx2MLMuxDfhFtm/z84=;
  b=kYMDHaqhX6IoTu0VXfJSwq45DbvH6NRX6keJD1lrTVLOtDxWbnK14cRf
   VLt/g4glmaY3FFhOrSvUn9zeOxE8r77peqdylkeY7MokWDEFipVHmMwRX
   QKmDll+XRIxwNgkyc4XoD8nWo2t2mmF1vT/xd7CzGVelNGeXU07C56ikz
   1COvb2UwUFn/95nGRQB31mOevZW4gT54ZnA+bUqkaw8ELbZCH9M+SrGgU
   6yNS1r53pCBiP7OXVBSWK/ZlYCnLydlGq2HbJ3LfFuabBZJlFzCWLltgZ
   Q1pkCmNNRThiRSnIsavmhMSK2pg0l4j5OvAdvEhIkaYHOq4EaIi78w3SU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12146629"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="12146629"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1102749"
Received: from jingjing-mobl1.ccr.corp.intel.com (HELO localhost) ([10.254.215.110])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:46:48 -0800
Date: Wed, 7 Feb 2024 00:46:39 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-acpi@vger.kernel.org, chao.p.peng@linux.intel.com, erwin.tsaur@intel.com, 
	feiting.wanyan@intel.com, qingshun.wang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, 
	Adam Preble <adam.c.preble@intel.com>, Li Yang <leoyang.li@nxp.com>, Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI/AER: Handle Advisory Non-Fatal properly
Message-ID: <ay2cwgycgjfqz5jmteeijgjiuje2u62wozhnkr76ag4tny6vl4@upbmy22y3hcn>
References: <20240125062802.50819-3-qingshun.wang@linux.intel.com>
 <20240205232616.GA831017@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205232616.GA831017@bhelgaas>

On Mon, Feb 05, 2024 at 05:26:16PM -0600, Bjorn Helgaas wrote:
> In the subject, "properly" really doesn't convey information.  I think
> this patch does two things:
> 
>   - Prints error bits that might be ANFE 
>   - Clears UNCOR_STATUS bits that were previously not cleared
> 
> Maybe the subject line could say something about those (clearing
> UNCOR_STATUS might be more important, or maybe this could even be
> split into two patches so we could see both).
> 

Good idea, thanks. I think splitting it into two patches would be the
better approach.

