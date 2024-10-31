Return-Path: <linux-pci+bounces-15696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE09B785F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE3D281DCE
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA681990BC;
	Thu, 31 Oct 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6vK9Blq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F7195FEC;
	Thu, 31 Oct 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369311; cv=none; b=dWwEJ0PsJmdwIe5ss27hzmJWBjVjwFNJBi1Ejk7lvU+zHEp83/EMxl9YfQy87b9Ah+cXAUSiR1dJYfzcw4a3ePawpd2Io7p0v1e9tMfY9PpQmr2aqN+U3JaisfZurO5fZekpED2PjhOlH1LVb0JAkCPmxMNTKoPw0DO/4qE58O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369311; c=relaxed/simple;
	bh=i+hteVqCnXc++rzyU2MY4vtu6c9jhIdsix/DJbeDlZE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=orR7RuFhQatmCps9fdNUkAk6OB/YmmoYlsfYEaDLVri7sNtPfaoIBPb9GtlCrDYUVOgXw7Bi9SuU3MEyATebw5TNQsxxLXK82Um2xBnLtDfvQhjTIYjjgyF3dPauSp/ARDOV0b2t81jRzDHZMGEgI3XVIs4ajZ6NHKnlwoEUD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6vK9Blq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730369309; x=1761905309;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i+hteVqCnXc++rzyU2MY4vtu6c9jhIdsix/DJbeDlZE=;
  b=e6vK9BlqsET8X8Rf5hpK1F5pLbmoB3bkfSDL8bCC/XNJqGwlcmGneWjd
   Tscmx/eQLYq5nzGNQeJbaIPMtFT8bMpsMP5eFiv7/kaumckvM/w0nfJea
   ud2rmmvepuIJWLkm3lJGtny6Qbjn5fNRWsYQGV8DrvEij7EfbPN+4M/sm
   sQPogrGXrdf3ClVecn8mpzeF1eXpsxXdlJOQaZJWw0aaUDWV2O6y+F5aF
   2FNrp2XnnKD7OlBdlQI5EDbRbiWsAcBGoHeeVQ5kmSzkFRUgC3AALBTs/
   G+lwXvQc/6dDyEmnTHuzoD68JQH7nDq2Psik7Z3EjDl7TuA0nrlD7WtIr
   Q==;
X-CSE-ConnectionGUID: tJnErQwRQMmaiEnPWko7ow==
X-CSE-MsgGUID: zFBxadd7TqquUNoPu9C1aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29955805"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29955805"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:08:29 -0700
X-CSE-ConnectionGUID: W6SPskMlQiyn/wK1TPI9qw==
X-CSE-MsgGUID: dWkMTl2ZTguOT55YPzXk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82742336"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:08:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 12:08:20 +0200 (EET)
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, 
    Yazen Ghannam <yazen.ghannam@amd.com>
cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
    "avadhut.naik@amd.com" <avadhut.naik@amd.com>, 
    "john.allen@amd.com" <john.allen@amd.com>, 
    "mario.limonciello@amd.com" <mario.limonciello@amd.com>, 
    "bhelgaas@google.com" <bhelgaas@google.com>, 
    "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>, 
    "richard.gong@amd.com" <richard.gong@amd.com>, 
    "jdelvare@suse.com" <jdelvare@suse.com>, 
    "linux@roeck-us.net" <linux@roeck-us.net>, 
    "clemens@ladisch.de" <clemens@ladisch.de>, 
    "hdegoede@redhat.com" <hdegoede@redhat.com>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    "naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>, 
    "carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: RE: [PATCH 06/16] x86/amd_nb: Simplify root device search
In-Reply-To: <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com>
Message-ID: <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com> <20241023172150.659002-7-yazen.ghannam@amd.com> <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 31 Oct 2024, Zhuo, Qiuxu wrote:

> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > +struct pci_dev *amd_node_get_root(u16 node) {
> > +	struct pci_dev *df_f0 __free(pci_dev_put) = NULL;
> 
> NULL pointer initialization is not necessary.

It is, because __free() is used...

> > +	struct pci_dev *root;
> > +	u16 cntl_off;
> > +	u8 bus;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_ZEN))
> > +		return NULL;

...This would try to free() whatever garbage df_f0 holds...

> > +	/*
> > +	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
> > +	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
> > +	 * this Data Fabric instance. The segment, device, and function will be
> > 0.
> > +	 */
> > +	df_f0 = amd_node_get_func(node, 0);

...However, the recommended practice when using __free() is this (as 
documented in include/linux/cleanup.h):

 * Given that the "__free(...) = NULL" pattern for variables defined at
 * the top of the function poses this potential interdependency problem
 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.

I know the outcome will look undesirable to some, me included, but 
there's little that can be done to that because there's no other way for 
the compiler to infer the order.

That being said, strictly speaking it isn't causing issue in this function 
as is but it's still a bad pattern to initialize to = NULL because in 
other instances it will cause problems. So better to steer away from the
pattern entirely rather than depend on reviewers noticing the a cleaup 
ordering problem gets introduced by some later change to the function.

> > +	if (!df_f0)
> > +		return NULL;


-- 
 i.


