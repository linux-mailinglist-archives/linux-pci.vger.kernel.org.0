Return-Path: <linux-pci+bounces-2199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F782EB01
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 09:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EE42853A6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2E11712;
	Tue, 16 Jan 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFIrlUGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854A11CB9
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705394545; x=1736930545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=21NklQ8HkW2qaNmTo3Xt9lMvrv+l4x/JM16sSMv+E6Y=;
  b=aFIrlUGQWQHe//wcehZ3cL3Xn3gssvtQEfdHLco8JYqzuJxCrxhDupnq
   qaN4vP0TBYGdM1esuLyb4BdCkrWnXnO7GjaXtD0/gACdZPttD9ToCJ8s2
   P9Mve2/ScEBi4PjXTAHst52QGvAgM63SCQVgFcqAQMUcNcWCBPnA6XC6g
   2PSXV4Qup45CA5RbkJ5ipRaey6Dr5PdSI7T8Qc5vSX59BtP7L4wyAGSIi
   eT+ebGCeIi4+W4+JuKo4WNeYg48dcyUhAbR5j6iuGvlIwPXwlGNs+XI10
   E22VVZx8L62suHJdgx/htnOUdMw6J6OavMm2UDufknlXbzFZc0Xp4aQxm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="485945208"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="485945208"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="787373006"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="787373006"
Received: from mindai-mobl2.ccr.corp.intel.com (HELO localhost) ([10.255.31.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:42:22 -0800
Date: Tue, 16 Jan 2024 16:42:14 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH 2/4] pci/aer: Handle Advisory Non-Fatal properly
Message-ID: <fydk3ovvpzpc5bp5yc63aibc7ysiw3a6cqwo7lagkdivsynnvc@f5rk67kv22xx>
References: <20240111073227.31488-3-qingshun.wang@linux.intel.com>
 <20240112163526.GA2271206@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112163526.GA2271206@bhelgaas>

On Fri, Jan 12, 2024 at 10:35:26AM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 11, 2024 at 03:32:17PM +0800, Wang, Qingshun wrote:
> > If we are processing an Advisory Non-Fatal Error, first check the Device
> > Status. If any of Fatal/Non-Fatal Error Detected bits is set, leave it
> > to uncorrectable error handler to clear the UE status bit, which should
> > be executed right after the CE handler in this case.
> > 
> > Otherwise, filter out uncorrectable errors that is not possible to
> > trigger an Advisory Non-Fatal Error, then clear all the rest status bits.
> 
> > +static int anfe_get_related_err(struct aer_err_info *info)
> > +{
> > +	/*
> > +	 * Take the most conservative route here. If there are
> > +	 * Non-Fatal/Fatal errors detected, do not assume any
> > +	 * bit in uncor_status is set by ANFE.
> > +	 */
> > +	if (info->device_status & (PCI_EXP_DEVSTA_NFED | PCI_EXP_DEVSTA_FED))
> > +		return 0;
> > +	/*
> > +	 * An UNCOR error may cause Advisory Non-Fatal error if:
> > +	 *	a. The severity of the error is Non-Fatal.
> > +	 *	b. The error is one of the following:
> > +	 *		1. Poisoned TLP
> > +	 *		2. Completion Timeout
> > +	 *		3. Completer Abort
> > +	 *		4. Unexpected Completion
> > +	 *		5. Unsupported Request
> 
> This could benefit from a reference to the spec that outlines these
> conditions.
Thanks for suggestion. Will add a reference to latest spec.
> 
> Bjorn

Best regards
Wang, Qingshun

