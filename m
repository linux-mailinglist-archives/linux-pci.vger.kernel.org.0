Return-Path: <linux-pci+bounces-12066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672395C47C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 07:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32671284C57
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 05:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95055481C0;
	Fri, 23 Aug 2024 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VValkcjy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744447F5D;
	Fri, 23 Aug 2024 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724389286; cv=none; b=FHurxgsSbySbAOh+e+8kuuc/xHqxZUwrB00qpy9jPTKfeNz1Qu4L7LSinvGeLjSYipkQCXmbmX/wcAP/2nHq/DGNH1zJa+KDMv91AI3Dgj0RWo/Z4HTHon3oLaNVTi7x0gI/SFUlXcndpwffiLxgl1nJm77eTauqJvvkIxnW0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724389286; c=relaxed/simple;
	bh=TgpylnB7dE+Ek0K/JdrRCFCoeW6yHgDeVlfubP6ligw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr+KGLQa9mjRuVOqJWy2hEvhMgwSc1SXW6J1lynwHDfdSoZgE4BAkFL3ujWPc2jMEbL/E4WaWjR1rQm6+lU/OOOxO03qusXfABtWxFCN7aBj/78mgebTMgwZ5OG/FtrE9gLOS8KzfMIR4a8vZEzdR0kxyRjRpqLGZU5ca7P7jPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VValkcjy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724389284; x=1755925284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TgpylnB7dE+Ek0K/JdrRCFCoeW6yHgDeVlfubP6ligw=;
  b=VValkcjycWhF/gezoKNOW8B7nPRkRVhJqYn/j1X57/BFFF9Oi9haa8SX
   qtCgVvgfFkbq+p0tEpoyt2sW5ASOkdQDi7XJkgwiNuobUmSUOiOTrFWZD
   l/02sA7Q5XPeUF7R3JmYbfpxGr8Yb25CoI+AN1G/FgS/to6eYc9k9spNW
   pBhDyzrOXD2ADwsqjPk+rIIrtZ0KqZgvBaOl8Tk449dKvVHLfPYem+PJQ
   ZaIWW59dcp32sq3TXXDbr9aaSqTY1/UgdttYbnk+URnyb7IiwTjp+pG90
   hu4xkXA9hRq9XcWhRh7zkI5Ri42w+0sUYz0spVqW0Ogh/wR+zJMz5hKX5
   w==;
X-CSE-ConnectionGUID: vj6regw3T6KXXaW475Vfvg==
X-CSE-MsgGUID: CNKwSFEsQ8+k7IiHAaqBfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33465509"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="33465509"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 22:01:24 -0700
X-CSE-ConnectionGUID: HI+tAPE5RHi4xTB/mliSSA==
X-CSE-MsgGUID: kLdnFklWRWK7mnclvNoY3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="99199631"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 22 Aug 2024 22:01:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 9CDC12AA; Fri, 23 Aug 2024 08:01:20 +0300 (EEST)
Date: Fri, 23 Aug 2024 08:01:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240823050120.GJ1532424@black.fi.intel.com>
References: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
 <6da512d2-464d-40fa-9d05-02928246ddba@amd.com>
 <20240822155329.GI1532424@black.fi.intel.com>
 <54feb448-b8b9-49ca-bf29-02b9884c048c@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54feb448-b8b9-49ca-bf29-02b9884c048c@amd.com>

Hi,

On Thu, Aug 22, 2024 at 10:56:44AM -0500, Mario Limonciello wrote:
> > > Here's the snippet from the kernel log with the patch in place.  You can see
> > > it flagged 00:02.0 as untrusted and removable, but it definitely isn't.
> > 
> > Is it marked as ExternalFacingPort in the ACPI tables?
> 
> No; it doesn't have an ACPI companion device.

Hm, how can it pass this then?

static bool pcie_is_tunneled(struct pci_dev *pdev)
{
	...
	/* Internal PCIe devices are not tunneled. */
	if (!root->external_facing)
		return false;
	...

Would you mind adding some debug statements there so we can see
(hopefully) what goes wrong?

The intention is that pcie_switch_directly_under() is only called on
Intel pre-USB4 discrete controllers (well and Maple Ridge as that's
still using the Connection Manager firmware).

