Return-Path: <linux-pci+bounces-8904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E810890C77B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 12:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77383B20394
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F91534E4;
	Tue, 18 Jun 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNwtrJ/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3FA153BFB
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701024; cv=none; b=V9P+FUELLu6u9tpQ8Qcaz39pSFe4bnofogE87UMptIJJXtQ1zth631K3HTTv9vF67/W20ZSiP0ZBuvuFafE2MNbLqC2iKEcZfsdE789ltsi2+udY3opVCZ33SRkFVhqlU+Q5qkuw3Bi4iHM4Cxitn8wEVvS4bXwAYXZdUn76xfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701024; c=relaxed/simple;
	bh=2le2VbkRqGJ0xcRUbHRRQNjN+hr3MieC5BZ3ant8a+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pP3kFjTEgp2JurobzYjOh7DuSta5YMe+DZjxfsI/mNzmIqVp1l7Kh1Jqyr88rk1t+6BJVY/utLb/0JA1b2bTInNphMmgrzok/zyjownd9etXG6CfxoAz6TBsLxFHykaRxB2UtiZig+RNApm8b+YKveHPuBgbBJtEJqRTBLUbiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNwtrJ/X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718701023; x=1750237023;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2le2VbkRqGJ0xcRUbHRRQNjN+hr3MieC5BZ3ant8a+E=;
  b=hNwtrJ/Xi4SoUY1neQz586M8peveNC2oBnH4chF75tkarOKRHeRiXIgB
   qqsuJciZAnuGLN16JY6IXlSLpKeW7JaltXFUfxv33zv/XaCQLFNwCRLWq
   oWHbFk+rRuJRE4S2qRZ25VA0Po196oQh5Po5NyJOymu78Xj03L+pASiJt
   JiDmgZj2Y2oAxapBk/rcM0pdVyk5l9zMwgvtcCVeEPgVxH15rjqRIOFql
   /bhBa7VaMB30JP2Toer+hbv5Zcv9Z5UmePfV69pR+3At9eBvVqH40DrZa
   8I5XBAiOlPw2x876qtQTWeLPc3+q4EKKNiRZsLitdidU/vrr/vL17psVQ
   w==;
X-CSE-ConnectionGUID: iQHYTwwUSXaUlpO7E54UzQ==
X-CSE-MsgGUID: OpKCTxqVSLep9jAHUDzuCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15687974"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15687974"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:57:02 -0700
X-CSE-ConnectionGUID: LbOAcPj4QK+Y57ZVsQRpvg==
X-CSE-MsgGUID: Gzzcp+YSTimkDECjiIkvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41592109"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.1.223])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:56:59 -0700
Date: Tue, 18 Jun 2024 10:56:53 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: stuart hayes <stuart.w.hayes@gmail.com>, linux-pci@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Marek
 Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240618105653.0000796d@linux.intel.com>
In-Reply-To: <Zm1uCa_l98yFXYqf@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
	<20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
	<05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
	<Zm1uCa_l98yFXYqf@wunner.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Jun 2024 12:33:45 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Fri, Jun 14, 2024 at 04:06:14PM -0500, stuart hayes wrote:
> > On 5/28/2024 8:19 AM, Mariusz Tkaczyk wrote:  
> > > +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
> > > +			 int pos, u32 caps)
> > > +{  
> [...]
> > > +	ret = ops->get_active_indications(npem, &active);
> > > +	if (ret) {
> > > +		npem_free(npem);
> > > +		return -EACCES;
> > > +	}  
> > 
> > Failing pci_npem_init() if this ops->get_active_indications() fails
> > will keep this from working on most (all?) Dell servers, because the
> > _DSM get/set functions use an IPMI operation region to get/set the
> > active LEDs, and this is getting run before the IPMI drivers and
> > acpi_ipmi module (which provides ACPI access to IPMI operation
> > regions) get loaded.  (GET_SUPPORTED_STATES works without IPMI.)  
> 
> CONFIG_ACPI_IPMI is tristate.  Even if it's built-in, the
> module_initcall() becomes a device_initcall().
> 
> PCI enumeration happens from a subsys_initcall(), way earlier
> than device_initcall().
> 
> If you set CONFIG_ACPI_IPMI=y and change the module_initcall() in
> drivers/acpi/acpi_ipmi.c to arch_initcall(), does the issue go away?

That seems to be the best option. Please test Lukas proposal and let me know.
Shouldn't I make a dependency to ACPI_IPMI in Kconfig (with optional comment
about initcall)?

+config PCI_NPEM
+	bool "Native PCIe Enclosure Management"
+	depends on LEDS_CLASS=y
+	depends on ACPI_IPMI=y

> 
> 
> > (2) providing a mechanism to trigger this driver to rescan a PCI
> >     device later from user space  
> 
> If this was a regular device driver and -EPROBE_DEFER was returned if
> IPMI drivers aren't loaded yet, then this would be easy to solve.
> But neither is the case here.
> 
> Of course it's possible to exercise the "remove" and "rescan" attributes
> in sysfs to re-enumerate the device but that's not a great solution.

We cannot expect from users to know and do that. If we cannot configure driver,
we should not register it. We have to guarantee that IMPI commands are
available at the point we are using them.

There is not better place to add _DSM device than its enumeration and I have a
feeling than sooner or later someone else will reach this problem so it would
be better for community to solve it now.

> 
> 
> > (3) don't cache the active LEDs--just get the active states using
> >     NPEM/DSM when brightness is read, and do a get/modify/set when
> >     setting the brightness... then get_active_indications() wouldn't
> >     need to be called during init.  
> 
> Not good.  The LEDs are published in sysfs from a subsys_initcall().
> Brightness changes through sysfs could in theory immediately happen
> once they're published.  If acpi_ipmi is a module and gets loaded way
> later, we'd still have to cope with Set State or Get State DSMs going
> nowhere.
> 

Agree. I can do it and it should be safe but it is not addressing the issue.
We would limit time race window but we will not close it.

Thanks,
Mariusz

