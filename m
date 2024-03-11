Return-Path: <linux-pci+bounces-4719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B6877D33
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F80B212FF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBC17577;
	Mon, 11 Mar 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTUloVOK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796C12B83;
	Mon, 11 Mar 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150479; cv=none; b=aY9Oi7YxktOYgZlud0sVrFaWyccT0yYBnTS+djpUCslJTk400If+5aj4aBeAA8k7vCPyxKPv7Hx8rUlB3KwwxtK7dZvyKwuvOnnR2h3CD6tO9oXGpo/sJZ4Z+n0phTwG36azGA6QElDSVo1yZRlYRl1Xz5uXCqdtzkW5Hl/BEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150479; c=relaxed/simple;
	bh=/M5HorfKRc1SIfbG7LnNy3nth3uReSi8QKtg2tI+UoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7/UzP+7qG2R4AV1Rhad1/36w/yFOGtYl1V9NIY40EBDJA9sa5RInGHCH7Tvn6QzeI85Fn9H7+HsJEZDg0EvX33lraB0bFBIw2b5AmBkQLrMXVpFdBUe5mav3zMawH7XWwXGgMoO3sqG0AK5UrHZWd/PSg/u7fCG5bWAGYNOPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTUloVOK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710150478; x=1741686478;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/M5HorfKRc1SIfbG7LnNy3nth3uReSi8QKtg2tI+UoM=;
  b=hTUloVOK9Nl5jVtYv0bh/bjTI5qfQ7JsEjrAQUERK7UaMeFdsCvCa4WI
   Qk+62lzj9P0x7lHf8v0zJlDZQv8skoQ4RSxIOsuhZu3+qu07AgQHDmLQ7
   WMKG16+SuO3D//x3Yn5OYX73reLn8wf1X55P984MttJsk20h5tIJoALB2
   Xtk2MC/j7ceFXf3S0YPpTlhK1b+HAHySpCDUsferRnH2EYLtSUZN+BSXg
   i4+YY+DZ04es8boFYqkCilCDAyys8DVZMmPs5kyN1b2GKrA5EC3RjU80d
   4axH93stlrxGzCeLB6IW+qbWk4H0MGDdYSE/SLANpZzmaSQ3LOg9PYw6X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4660415"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4660415"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15765345"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.237.142.118])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:47:56 -0700
Date: Mon, 11 Mar 2024 10:47:50 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org, Lukas Wunner
 <lukas@wunner.de>, Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240311104750.00000c24@linux.intel.com>
In-Reply-To: <20240306224008.GA554220@bhelgaas>
References: <20240215142345.6073-3-mariusz.tkaczyk@linux.intel.com>
 <20240306224008.GA554220@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 16:40:08 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:
 
> > +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> > +	if (pos == 0)
> > +		return;
> > +
> > +	if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> > +	    (cap & PCI_NPEM_CAPABLE) == 0)
> > +		return;
> > +
> > +	/*
> > +	 * OS should use the DSM for LED control if it is available
> > +	 * PCI Firmware Spec r3.3 sec 4.7.
> > +	 */
> > +	if (npem_has_dsm(dev))
> > +		return;  
> 
> Does Linux have support for this _DSM?  I don't see any, and I guess
> this check means that if we have a device that supports NPEM on a
> platform that supplies this _DSM, we can't use NPEM.

No, Linux doesn't support _DSM. It was proposed in previous iterations by Stuart
but I dropped it. We decided that it need to be strongly rebuild because
"pci/pcie" is not right place for ACPI code so we cannot register _DSM
driver instead of NPEM as it was proposed and I don't have _DSM capable
hardware to test it.

> 
> The stated intent of the _DSM (from the Feb 12, 2020 ECN at
> https://members.pcisig.com/wg/PCI-SIG/document/14025) is to provide
> NPEM-like functionality via an abstraction layer on top of NPEM, SES,
> or other implementations.
> 
> The _DSM also gives the platform a chance to intercept and change or
> reject indications requested by OSPM, although that isn't mentioned as
> part of the intent.
> 
> I'm interested in your thoughts about this.  One possibility would be
> to omit this check for now and add it back when the _DSM is supported,
> so we could use NPEM directly when advertised by a device.  Or we
> could keep this as-is and prohibit use of NPEM if the _DSM exists,
> even though we know how to operate it.

I decided to implement it 2nd way because I don't know if I can use NPEM if
_DSM is implemented, I mean that hardware may do not response on NPEM requests.
I choose safer approach, I have no opinion.

I will follow community voice.

Thanks,
Mariusz

