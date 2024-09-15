Return-Path: <linux-pci+bounces-13221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 849039794F1
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 09:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D551F22E1A
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2024 07:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674E18E1F;
	Sun, 15 Sep 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdRRxYYS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC931B85D2;
	Sun, 15 Sep 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384060; cv=none; b=DjYQA//RQzdiCnStmDHtXhjWM6NjN275f4HAOJjz17/Q7opxd1Z1H/HhcJKP4iPVFrNP9xJfRa0Ssmnu7+wrQKLvzPzdZRe5AYpEtD+EDA3FmxfY3jaYPjSvIg0iV9d3bZj5mH8hHh9QwQ6i2YFJK6Gcg6eSNQn/uwvZM2ar+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384060; c=relaxed/simple;
	bh=OvaWSLmV9n/J8UD5CWPpidMx2yonWfDSmW1beCrCATM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsOf/znNsHRre6G9SkyrYAt6J5X4EcFcQHgss48xA93oRj2wFeuOkrPbMdjKo0UrzskGSqz2oz+wd/SAR7C3UaLChFAN/4ZLoppeymjj3taECDkorazHvhagIwcS4M8KQ5sV0PXUsFfLLa5XEWNJVa0Y8j7UE5EG3tgSeLJIe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdRRxYYS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726384059; x=1757920059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OvaWSLmV9n/J8UD5CWPpidMx2yonWfDSmW1beCrCATM=;
  b=JdRRxYYShabDfuiNJ5J+buxnDyDibVzUL9pB+tXqLsrrMxP/KqWS5uNT
   6RaoElUuCvynA1js/8NZx8L/xaU1+swOeoq3//NN1bXP14a1SVo166XVM
   RJReqOwLu3QWLVlc4zuNQ09/5IioukixJjYeI4z/AsOYhjqpkiFHRwIWn
   7IjnQFYnGMG5LySfXUeGVcZorSX1GzsfN9V/c7op1pdtehvYigamjplR7
   frbU0JpdzNBhqBGlWVYUF+30a70NyAVt3I5WH6FLGDAjdkIZawh25spYI
   Id98Cja06NH73kiKTsufnA9FnJesavs3MFv7inZWMkmwn/mqL4dfug1Fp
   A==;
X-CSE-ConnectionGUID: weuzQiowQLmul9vcv0f0pg==
X-CSE-MsgGUID: pnbW/2YTRDO9xgJFtxY3cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="24726511"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="24726511"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 00:07:38 -0700
X-CSE-ConnectionGUID: HQ7ym2p/QUaZLDUC0xhH+A==
X-CSE-MsgGUID: ftO/H9SWS/6Qw66ZfIF45w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="69061663"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 15 Sep 2024 00:07:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id AD7D818F; Sun, 15 Sep 2024 10:07:33 +0300 (EEST)
Date: Sun, 15 Sep 2024 10:07:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240915070733.GQ275077@black.fi.intel.com>
References: <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
 <20240905093325.GJ1532424@black.fi.intel.com>
 <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>
 <20240910091329.GI275077@black.fi.intel.com>
 <66019fa3-2f02-4b03-9eb7-7b0bed0fd044@amd.com>
 <20240913045807.GM275077@black.fi.intel.com>
 <20240913072356.GO275077@black.fi.intel.com>
 <dabbd8fa-f5ec-46fe-994b-695058195d47@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dabbd8fa-f5ec-46fe-994b-695058195d47@amd.com>

Hi,

On Fri, Sep 13, 2024 at 03:56:46PM -0500, Mario Limonciello wrote:
> > One more suggestion though ;-) I realized that my hack patch to disable
> > I/O and MMIO did not actually do that because it looks like we don't
> > clear those bits ever. I wonder if you could still check if the below
> > changes anything? At least it should now "disable" the device to follow
> > the spec.
> 
> This actually causes the system to fail to boot.  I guess some deadlock from
> other callers to pci_disable_device().
> 
> We also double checked putting the PCI_COMMAND writes just into the runtime
> suspend call backs instead (to narrow down if that is part of the issue
> here).  Putting it there fixed the boot hang, but no change to the actual
> issue behavior.

Okay, thanks again for checking!

