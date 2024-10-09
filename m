Return-Path: <linux-pci+bounces-14091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA3D996B20
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 14:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90933287386
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE2184528;
	Wed,  9 Oct 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezaLMwf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4F192D78
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478513; cv=none; b=V/EFFx0xFtRbwvGFIcH5oSEECWtC2ZRnLzf7sGy3KSNrUEimTcnxr286w6H4PSyP7077j6vSHBVg0TEUMButOs+bq9j7RXJap1khO5g2GIF4h5DaRLElalb95OIa9Df9hMbb6MJ+w1pPezT+S3aIoYjdIw0CLUQLjiTADH8Vrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478513; c=relaxed/simple;
	bh=m0oAC3aXCGB9xEYS03iqP15p7w0uH4p+T5myyJYZVac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T97TI+XMqGune0ixU9huvVVO7DMFAICdJbf/eP/L0K0UsV1mnKJFn6O62KNpxqkInnw7q+hQDCYXz3VC5QkPBmR7jo+jQi9NwRjnwsVQpaEj29jYIFU85jpc4D6b0ETAF2MIB5E4vGg6YJBdN5iqoCJ3RrkMVvmtLob8Xz/OIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezaLMwf6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728478512; x=1760014512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m0oAC3aXCGB9xEYS03iqP15p7w0uH4p+T5myyJYZVac=;
  b=ezaLMwf6R3r+9cQFU2x5rve8YjQeX/pwEYe+urmwIwYTBHRStfSZub3S
   9wKNM0Co619g+xjRGp4vKUohNd6fMhpteW2eNcbu31TghmqQ/tOSZEjQ/
   PXjjEsKCKm+GXLHrhOPI8K8GgwlQbCtvZF1KWiVt/2rC9+nGyP0FfWMMf
   yyWAoI7ftKlLtN6OF+3MlBkJCK9mloobFi6oL32MkNvYP2a+gGhz70T6j
   NKrda2cDfj64+4R3IjS2pi7UmKavVsUiiv4SLKCXklynCLRTEOxCi/xmj
   NhTWFqAq0lAvmYqalVTCg1jJzP17luBfu75l18GMt3Bsh1uO0kFKN1H9Y
   Q==;
X-CSE-ConnectionGUID: fXWrKpkzTTa2i3HC7ecv8Q==
X-CSE-MsgGUID: zNgcR31DS4uR34nkBoAs/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38900975"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38900975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:55:11 -0700
X-CSE-ConnectionGUID: uCOaXl7QTfqVke/LMW9KYw==
X-CSE-MsgGUID: rbfYYbJxRlKCZZfaidMtQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="81077387"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 09 Oct 2024 05:55:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 25B7A825; Wed, 09 Oct 2024 15:55:08 +0300 (EEST)
Date: Wed, 9 Oct 2024 15:55:08 +0300
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <20241009125508.GC275077@black.fi.intel.com>
References: <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
 <Zv-dIHDXNNYomG2Y@wunner.de>
 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
 <ZwU6ijD8I5hzMv9X@wunner.de>
 <20241008163732.GT275077@black.fi.intel.com>
 <ZwV4r8zAcFuJnzH8@wunner.de>
 <20241009044442.GV275077@black.fi.intel.com>
 <ZwZtaHPizigdoCmP@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwZtaHPizigdoCmP@wunner.de>

On Wed, Oct 09, 2024 at 01:47:52PM +0200, Lukas Wunner wrote:
> On Wed, Oct 09, 2024 at 07:44:42AM +0300, mika.westerberg@linux.intel.com wrote:
> > On Tue, Oct 08, 2024 at 08:23:43PM +0200, Lukas Wunner wrote:
> > > Okay this seems to have been introduced by 0fc70886569c ("thunderbolt:
> > > Reset USB4 v2 host router").
> > 
> > Correct, and there is similar commit for USB4 v1 routers.
> > 
> > > Is that a good idea though?  What if the machine was booted from a
> > > Thunderbolt-attached drive?  At least on Macs that has been supported
> > > since day 1.  I'd assume that it may cause issues if the connection to
> > > the drive on which the root partition resides is forcefully torn down
> > > and re-established?
> > 
> > For Macs we still "discover" the topology. This is only for software
> > connection manager USB4 hosts. This same "strategy" is being used in
> > Windows nowadays, it allows to re-configure sub-optimal setup that the
> > BIOS CM might have done and avoids some issues too on AMD.
> 
> Hm, I'd assume recent Apple Silicon host routers are USB4 compliant,
> so we may have to exempt those from the reset once Thunderbolt is
> brought up on them...

Sure if this is really needed. For Apple their boot firmware provides
extra information about the configured paths so it is easier for OS side
to validate. There is no such thing in the BIOS <-> OS handoff.

