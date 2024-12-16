Return-Path: <linux-pci+bounces-18488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934F29F2B94
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8232D16710C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598D200121;
	Mon, 16 Dec 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIO4muEL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E91FF7DE;
	Mon, 16 Dec 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336653; cv=none; b=DCNQwjWaVpD4Eha3BYiNtddAoRfXgXuHPb13f+wWT+WB0PYRxD+EnNPAQwqDknc4i4IIgAcjRnAeehc+1+OjA5ZXmtrxo350YrKpj76TKXmcyfuzYWUCnLUFGPMFYEMr/8h200U0TxKE8KMllPQocL7FppzUtvPYFsCm+86a1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336653; c=relaxed/simple;
	bh=CHK4Jzr8rXjs+xGyAY8Y9E2r8SBWtp0syHd8/1DxAjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVX14gaLrQ2tZ4MBk/PsylQQ1f/zsUys2nShr7eclB+GYLYSObvo5/I4jnn0U0DvK6PcrI+TU3yD2YMxuQFxb0HyAR9GmreXwzpzZve0LUC+i6QIvAuSyBQ4yk3UZsHgfkB6omOhZuJGBiGiIXgSutLI/E9oXAd+Kdf8WY5MZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIO4muEL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734336651; x=1765872651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CHK4Jzr8rXjs+xGyAY8Y9E2r8SBWtp0syHd8/1DxAjQ=;
  b=KIO4muELKUPYs2sNx6Okn+iNhQwwct7jqh03cJ8yTGzDZFvLeLiI0PAp
   boZM85ZIBZzSAPXaVAjSrSlWaQPeEUClGrSFgy9t6gG4SQdFNUr/32UCk
   eFqDcjJVmlAyF5Db4v9UIR1cyVHksqVntkev3qif+tWupMlXKeOcSOHOL
   H2ZIkZu8wfaqbdV1Q9YYyOtGQIyCaEaudSQBM14fkffKXYaR1/kbwCVj7
   rm2OEwKzGuK/tfs108J1R4LYRZh+pWh5DeTnFcJPEjwpdj65o0b8yI83e
   rT4hX9WIPqAvM5ILQMnchuCsSi2zIs+sZ0t9P4X+GXInF+Oh7Wldeonca
   Q==;
X-CSE-ConnectionGUID: Jh1769amTiqHqJ5kiL2lfw==
X-CSE-MsgGUID: eZnknvmzRNyQrgaB/K02SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34745864"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34745864"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:10:51 -0800
X-CSE-ConnectionGUID: N6y2UMgMSkSQQH2f+ksrZw==
X-CSE-MsgGUID: 89JTuorXSwmv1qZw3EJY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102106790"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 16 Dec 2024 00:10:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 3ED311E0; Mon, 16 Dec 2024 10:10:48 +0200 (EET)
Date: Mon, 16 Dec 2024 10:10:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gowthami Thiagarajan <gthiagarajan@marvell.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] PCI : Fix pcie_flag_reg in set_pcie_port_type
Message-ID: <20241216081048.GE3713119@black.fi.intel.com>
References: <20241213070241.3334854-1-gthiagarajan@marvell.com>
 <20241213184700.GA3423791@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213184700.GA3423791@bhelgaas>

On Fri, Dec 13, 2024 at 12:47:00PM -0600, Bjorn Helgaas wrote:
> [+cc Mika, Andy]
> 
> On Fri, Dec 13, 2024 at 12:32:41PM +0530, Gowthami Thiagarajan wrote:
> > When an invalid PCIe topology is detected, the set_pcie_port_type function 
> > does not set the port type correctly. This issue can occur in 
> > configurations such as:
> > 
> > 	Root Port ---> Downstream Port ---> Root Port
> > 
> > In such cases, the topology is identified as invalid and due to the
> > incorrect port type setting, the extended configuration space of the
> > child device becomes inaccessible.
> 
> >From reading the code, it looks like the underlying problem is
> components that advertise the wrong PCIe Device/Port Type.
> 
> set_pcie_port_type() already detects that incorrect Port Type and
> tries to correct it, but it puts the corrected type in bits [3:0]
> instead of [7:4] where it belongs.
> 
> This looks like a bug from ca78410403dd ("PCI: Get rid of
> dev->has_secondary_link flag").  If so, we should add a Fixes: tag for
> that and possibly a stable tag.

Yeah agree, this is definitely a bug in that commit.

> This looks like a clear bug.  What system tripped over this?  It's
> useful to have bread crumbs like that in case we see other issues
> caused by hardware/firmware defects like this.
> 
> > Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> > ---
> > v1->v2:
> > 	Updated commit description
> > 
> >  drivers/pci/probe.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4f68414c3086..263ec21451d9 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1596,7 +1596,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  		if (pcie_downstream_port(parent)) {
> >  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
> >  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> > -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> > +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM << 4;
> >  		}
> >  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
> >  		/*
> > @@ -1607,7 +1607,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
> >  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> >  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
> >  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> > -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> > +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM << 4;
> >  		}
> >  	}
> >  }
> > -- 
> > 2.25.1
> > 

