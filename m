Return-Path: <linux-pci+bounces-28501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B914AC668D
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 12:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E321BC689D
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0927817D;
	Wed, 28 May 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdILFMRo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A182798FD;
	Wed, 28 May 2025 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426450; cv=none; b=dahxTCX/QJJ3pcvlzXEFALfcq6xBquk1q7LxCiZ4NnvXmRtrm88YxRn5fl7LY6gW351QhLS+EWnB/qVnAgXfgQmPkgYHKhBNJ8g72CYSLSfSasvtkdkOMOzb8f4aFcKxhvu4MAYD95Ex9kUOLamT0FcD/XGQOSdFYLw4Xs8063Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426450; c=relaxed/simple;
	bh=Zhox0hjZ9k9Tt2WB921pjM7KHIySapcRetCIkbZvAm0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WkxRN43BXigGJkWr6cLFweqYJeXJUNP5l92vRM9pvUJcKi32rMhC3OxdNujJsDsnrf2GoQhIyZOBSW9iluV6VfGYdt/f+0YmuD7I2+ifQhmxuMqxVi+7YqGvOJhxdRv7gQ2AV6bdSTUmYpKAjU5nXifEA/rGx0wie6u1hjvMqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdILFMRo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748426448; x=1779962448;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Zhox0hjZ9k9Tt2WB921pjM7KHIySapcRetCIkbZvAm0=;
  b=cdILFMRoRwHC5vkOg9MFMgqAQ6XJncbvcurNOGnkjsk5oRe4Y2k1E7di
   30RkqndfCBLeEm8NRQR851dfWim+tR3nneLCXGxDESXvozG7Xl+XrTQRB
   CEz/5l90F7/J7aDTZWrPpTiSH01xZND8erRQy6UtzzRrUJfsYm3dkRw0U
   5q29gkRzCY4EuPgzmoxXbTWhVZBj4fZoc62DxjN2FEWGxCjbmLH3H6Bu2
   gd51b+23QeoGuxPdjDsMAamRvoXlsagXK/TJQ5tBobJmd2awvV6sZnyrp
   cp97JohdkzciOSBeXEIkZ5qpYCPShOt/HYDtSabVoEDJF0GBwoX2tZ89I
   w==;
X-CSE-ConnectionGUID: t7uIP5u1QjeXwn2n4s7ppw==
X-CSE-MsgGUID: FodMmgNPRiGYrm34C/N2TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50550866"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50550866"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 03:00:47 -0700
X-CSE-ConnectionGUID: H40m0oA3Tme67hHo37j6Hw==
X-CSE-MsgGUID: kCQj+gMSSgORFrdMdims+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="166372921"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 03:00:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 May 2025 13:00:34 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Weinan Liu <wnliu@google.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 13/20] PCI/ERR: Add printk level to
 pcie_print_tlp_log()
In-Reply-To: <aDave5XyXZoKWole@wunner.de>
Message-ID: <1565a7a9-bcf0-e8e4-0f75-de8859b47a8f@linux.intel.com>
References: <20250522232339.1525671-1-helgaas@kernel.org> <20250522232339.1525671-14-helgaas@kernel.org> <aDave5XyXZoKWole@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 May 2025, Lukas Wunner wrote:

> On Thu, May 22, 2025 at 06:21:19PM -0500, Bjorn Helgaas wrote:
> > @@ -130,6 +132,6 @@ void pcie_print_tlp_log(const struct pci_dev *dev,
> >  		}
> >  	}
> >  
> > -	pci_err(dev, "%sTLP Header%s: %s\n", pfx,
> > +	dev_printk(level, &dev->dev, "%sTLP Header%s: %s\n", pfx,
> >  		log->flit ? " (Flit)" : "", buf);
> >  }
> 
> Nit: pci_printk() ?
> 
> The definition in include/linux/pci.h was retained by fab874e12593.

If pci_printk() is taken into use once again, there's 56d305b24d64 ("PCI: 
Remove pci_printk()") queued already in pci/misc which should be dropped 
in that case.

-- 
 i.


