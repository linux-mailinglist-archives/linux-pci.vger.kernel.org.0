Return-Path: <linux-pci+bounces-3406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25A8538BC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6204C1C26896
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B33A93C;
	Tue, 13 Feb 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo176lsj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A65F56B
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846014; cv=none; b=ea4m4qPrUtBJ8mEW8jTGlA4YExFSGpR/QcBnJWrIjdG9nNlsv/PfmtJBuwBlX1/JBVqrquGapThV90kmb+gmtxdpcuDwpw5gDKtX9ParAOYGiMowrGnvCqaIQA0HKq/QXtR72E4BELPRQxgPV6utZZTuQiVAirEx65wgNAK6SAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846014; c=relaxed/simple;
	bh=FDOPvEPKGiMsMpgbyFwDNn0uxWKm/spMxX/rgwFf6Jw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDtgY27oB5XIq/4nVBlbP8/YUu4g4tcJtheIiMkY6cKwh5q/5gPoWVWEMYKbQXQ2bMOFc7buXWip/bGqS7nOM02Z+9h37Y6cFFki9KMsOPgtqyJwRUuC4QXg1a5TtRzhZAotKTBz98+5x4mFUUv/ellBZCn09xI/M/Xi2MDwD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo176lsj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707846013; x=1739382013;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FDOPvEPKGiMsMpgbyFwDNn0uxWKm/spMxX/rgwFf6Jw=;
  b=Xo176lsjTgOm/JG+JNFV+jv80dMbEAbAKBBPOg5OYIqrm35eufQV6Elw
   0GtFf9la3svsM7J7hKTYJPWC96BwsbogLoTuLSH9xdjemXvrxaSeoE90W
   h6CEFXz8EJsxIvZGOtEXitfc6nEm4Jq7RBApKCtC5fStBpKGm6pLm51rN
   VHubHa6g2E/sT3qaKG7HhCac2cxIQEV4W4oT01imHhvXfzuxxlDBGQ3hv
   1yMCvZjWxQkhZoRIaTQquHJM/QsE3QhtztVFxpmWi4fR2mecDa/TWWMMI
   LaTyfVH3n1jHP+E6AihhHLuMF8hfF5G69/vl93MxKHUfotqyEH8Y87XeZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13261572"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="13261572"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7524694"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:39:59 -0800
Message-ID: <af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki"
	 <rjw@rjwysocki.net>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 13 Feb 2024 10:47:27 -0700
In-Reply-To: <20240207185549.GA910460@bhelgaas>
References: <20240207185549.GA910460@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-02-07 at 12:55 -0600, Bjorn Helgaas wrote:
> On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel wrote:
> > ...
> > Did you have a chance to look at my response on January 16th to
> > your
> > questions? I tried to summarize all of the potential problems and
> > issues with different fixes. Please let me know if it is easier if
> > I
> > resend the explanation. Thanks.
> 
> I did see your Jan 16 response, thanks.
> 
> I had more questions after reading it, but they're more about
> understanding the topology seen by the host and the guest:
>   Jan 16: https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
>   Feb  1: https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas
> 
> As I mentioned in my second Feb 1 response
> (https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas), the
> usual plan envisioned by the PCI Firmware spec is that an OS can use
> a
> PCIe feature if the platform has granted the OS ownership via _OSC
> and
> a device advertises the feature via a Capability in config space.
> 
> My main concern with the v2 patch
> (
> https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@linux.intel.com
> )
> is that it overrides _OSC for native_pcie_hotplug, but not for any of
> the other features (AER, PME, LTR, DPC, etc.)
> 
> I think it's hard to read the specs and conclude that PCIe hotplug is
> a special case, and I think we're likely to have similar issues with
> other features in the future.
> 
> But if you think this is the best solution, I'm OK with merging it.
I sincerely apologize for late responses. I just found out that my
evolution mail client is automatically sending linux-pci emails to junk
since January 2024.

At the moment Hotplug is an exception for us, but I do share your
concern about other flags. We have done lot of testing and so far patch
v2 is the best solution we have.

Thanks
nirmal
> 
> Bjorn


