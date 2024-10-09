Return-Path: <linux-pci+bounces-14022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09560995EB2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 06:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EDAB21779
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D91487CD;
	Wed,  9 Oct 2024 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+rUptN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CE139D0A
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449088; cv=none; b=DCgWAhrD5wXMzyk0KpZmSOmAhOS4s0sqIj9cB+dbaRaCBZe9CHxrCfkH8n6Tll3mKZY3cQkeU+ThE5o7paRxQvJQ9Y3IKOCgmlAm0P1p9xlzipiNcDUqTQVqJPPRXAVKfUj5BP8NH2ddw6VXhNc3K0WQb+hsKEN3UZs0B5M0zZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449088; c=relaxed/simple;
	bh=x7d/3K1ZY3IqCRFgw220qm7YHh+vSX+s5zo+ThzTv58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlvUep2+DOmPRdXd/FUHuV1wqkSk1B3Kd/pifksl/BBExO7O2efWN/MtfKHlgv5lU8JJIQrIEJHnlki6pmA82+7XTUPjs7Lhg+AkG8W+WCySXzS1rj7YnP782Z8NIJ2I9p5N58EpBLE8M+FHIG3VivCosi30LfwDzvWi0Zx7eqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+rUptN9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728449086; x=1759985086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x7d/3K1ZY3IqCRFgw220qm7YHh+vSX+s5zo+ThzTv58=;
  b=l+rUptN9YYEVbZPu1Io7w2tdKc2/g2EUPDasqu48z2uyui7f8unJGOgj
   t9+9ziH2tZPNrM61AtvVmLvY44TlOB/boy4uV5Bh63eVNNuHRPXlZKj+E
   lC2A+SNLtYF4ijlEgB0QHtVM6mDoGd/mcUhMUV97MxeLaFVwIZzweP/iX
   ysbdJHnZq/pE7mXg597Tqe4bvOdbca1j0ERkapV2VC9B1jq9QWUVe5dyY
   PBMcu40+qXixNZ241IiSf1a4caHdr78h3HPYP/pnMUvEPIesG1BvPNen4
   0LK9gJCuG1mIGWzpkuZ/zKLeE/tIz2k19ueoZAQW6IzD0I5W9OSakdCbx
   Q==;
X-CSE-ConnectionGUID: +S0sMVdtT22fT8z2wOlrKg==
X-CSE-MsgGUID: fyW5mJclSjyEdfnaoLRIZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="50261420"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="50261420"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:44:46 -0700
X-CSE-ConnectionGUID: pKDNzHUpQoaF8HwveuYJQQ==
X-CSE-MsgGUID: yjf/l1AQRbqi+Pe3+u3qPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80702051"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 08 Oct 2024 21:44:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D32B328E; Wed, 09 Oct 2024 07:44:42 +0300 (EEST)
Date: Wed, 9 Oct 2024 07:44:42 +0300
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
Message-ID: <20241009044442.GV275077@black.fi.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
 <Zv-dIHDXNNYomG2Y@wunner.de>
 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
 <ZwU6ijD8I5hzMv9X@wunner.de>
 <20241008163732.GT275077@black.fi.intel.com>
 <ZwV4r8zAcFuJnzH8@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwV4r8zAcFuJnzH8@wunner.de>

On Tue, Oct 08, 2024 at 08:23:43PM +0200, Lukas Wunner wrote:
> On Tue, Oct 08, 2024 at 07:37:32PM +0300, mika.westerberg@linux.intel.com wrote:
> > On Tue, Oct 08, 2024 at 03:58:34PM +0200, Lukas Wunner wrote:
> > > Finally, I'd appreciate if you could send me dmesg output with the
> > > refcounting fix applied.  As said before, the MTL Thunderbolt controller
> > > claims that the link and slot presence bits are cleared, so it
> > > de-enumerates everything attached via Thunderbolt.  I'm wondering
> > > if it then re-enumerates the Thunderbolt-attached devices so they're
> > > actually usable?
> > > 
> > > I'm hoping Mika can clarify with Intel Thunderbolt CoE whether this
> > > is a hardware issue in MTL that can e.g. be fixed through a firmware
> > > or BIOS update.
> > 
> > I think here it happens because we reset the host router when the driver
> > probes so all the BIOS CM created tunnels will be torn down as well.
> 
> Okay this seems to have been introduced by 0fc70886569c ("thunderbolt:
> Reset USB4 v2 host router").

Correct, and there is similar commit for USB4 v1 routers.

> Is that a good idea though?  What if the machine was booted from a
> Thunderbolt-attached drive?  At least on Macs that has been supported
> since day 1.  I'd assume that it may cause issues if the connection to
> the drive on which the root partition resides is forcefully torn down
> and re-established?

For Macs we still "discover" the topology. This is only for software
connection manager USB4 hosts. This same "strategy" is being used in
Windows nowadays, it allows to re-configure sub-optimal setup that the
BIOS CM might have done and avoids some issues too on AMD. Placing
necessary drivers in initrd should allow root partition to be connected
over USB4 (and there is the chicken bit, thunderbolt.host_reset=0 if
user absolutely does not want this behavior).

