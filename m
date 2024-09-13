Return-Path: <linux-pci+bounces-13143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52551977989
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 09:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95D51F21428
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612A1BB69C;
	Fri, 13 Sep 2024 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CElDnCGe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EEE77107;
	Fri, 13 Sep 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212243; cv=none; b=AD9kmmjHOkTv6RdCwlSw0JfC/gKDsP4e5ZvhV1le5R2yKJkuc4ewyj+Z/QJ42UmTH6jLUjrSxJS4SUuR1Ug+XOsJk32fBoTxyq9yMV0aogb7eOeBXGwB3dBJyginjZG1gETkPETiqN9AY18Mh1YgpvkyUOyvA+kZt3LiO+JgeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212243; c=relaxed/simple;
	bh=iPvd+9z6NuPIzam4+usKWHP3bX8Hx0aJk/Uu79HF2cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8A1gyKFn1ssX2IKgYOXgfF+6faZfDCtPTfjb8Q2w7ixBAQCvaxKoIAGSbTNKX6Zz0N+GN7YVVkJqZgEyvfcPYNkyKyk6pMF2oC1OcSNJV43ExcAswF0lbLt1zTrPXv7EBgimIgSK18DaM/j+gZ9+lXM4aGS3G2bsO3zYwBKHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CElDnCGe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726212242; x=1757748242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iPvd+9z6NuPIzam4+usKWHP3bX8Hx0aJk/Uu79HF2cQ=;
  b=CElDnCGeCEIJDuWLjrrSJT9s/4bj3VfPIsJSZ07npCeoIiAhNSMR3e+H
   cUEfcGAQv12dxckwnxa/IotHwdVLek7KvDt7UxqWVbbbPc5zXmR2xIxlJ
   khtb+AnCuGMz1QEW2ekpR4jICXtg3YI0JfD7caQ0uPCjLp8/K+nYzPpts
   Mi30Li6RQ5IBzjEUKo96EpwiCU0HfoBIj+nwRqV9Yu8nkjq2AlchGkK9j
   j/vgEWf36lWFYdGDlkSCjC7pNkYhidI49cpLjef6eWMIuL1eFSEgKuNSK
   gYQcW7Dg2VzAqvdJB1u8/bVDp78exnQqe3itMcV7mZGXcWC7b5JFV1lpf
   A==;
X-CSE-ConnectionGUID: lUUAcCy3T9ygMX7e+UBLEw==
X-CSE-MsgGUID: lse/c7hXSwyspobCD9AAcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="47618229"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="47618229"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 00:24:01 -0700
X-CSE-ConnectionGUID: oHG4PVODQ7GpA5DverliGg==
X-CSE-MsgGUID: LJV4th+PRpCy+8quuV7LfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105429499"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 13 Sep 2024 00:23:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id DCA0732A; Fri, 13 Sep 2024 10:23:56 +0300 (EEST)
Date: Fri, 13 Sep 2024 10:23:56 +0300
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
Message-ID: <20240913072356.GO275077@black.fi.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
 <20240905093325.GJ1532424@black.fi.intel.com>
 <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>
 <20240910091329.GI275077@black.fi.intel.com>
 <66019fa3-2f02-4b03-9eb7-7b0bed0fd044@amd.com>
 <20240913045807.GM275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913045807.GM275077@black.fi.intel.com>

Hi again,

On Fri, Sep 13, 2024 at 07:58:07AM +0300, Mika Westerberg wrote:
> Yeah, I agree now. It does not look like the methods are messing each
> other here. We don't see the GPE handler being run but I don't think it
> matters here. For some reason the device just is not yet ready when it
> is supposed to be in D0.
> 
> Sorry for wasting your time with these suspects.

One more suggestion though ;-) I realized that my hack patch to disable
I/O and MMIO did not actually do that because it looks like we don't
clear those bits ever. I wonder if you could still check if the below
changes anything? At least it should now "disable" the device to follow
the spec.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..79a566376301 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1332,6 +1332,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
 
 	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 		pci_finish_runtime_suspend(pci_dev);
 	}
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffaaca0978cb..91f4e7a03c94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2218,6 +2218,13 @@ static void do_pci_disable_device(struct pci_dev *dev)
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+	/*
+	 * PCI PM 1.2 sec 8.2.2 says that when a function is put into D3
+	 * the OS needs to disable I/O and MMIO space in addition to bus
+	 * mastering so do that here.
+	 */
+	pci_command &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+	pci_write_config_word(dev, PCI_COMMAND, pci_command);
 
 	pcibios_disable_device(dev);
 }

