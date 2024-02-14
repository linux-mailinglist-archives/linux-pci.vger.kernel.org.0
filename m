Return-Path: <linux-pci+bounces-3465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9468553C8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 21:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D1629363F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DB13DBA8;
	Wed, 14 Feb 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0dTkQZS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72266A002;
	Wed, 14 Feb 2024 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941732; cv=none; b=VHotL0qo5VVhykxXfCo9uk16TPh/ukQ6QaWuW4AzweYQAfhH1jHLWWIZOKBZwhlnxAKMNkJl8LiqsgLuRGcysWivjwerDeXt2jr6f2xkDxs6kncjTvNbUpzzUfUlbPIHXWrP9fAhj/eyYaDv7RyeBvtatcMkkV8P1nFs0hJJ0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941732; c=relaxed/simple;
	bh=S7sJcFnlsbs0MGKDPZKtduFzZYfiU4c1U499OJDfDzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNEnAebrp4FMoo6w3g7XtgK0FaYXPdCoVOZ7UHzBl3Qb8/FNPMA/NxWdr3fQStXs856N/Ve/MobFSOlbPCmiIyyR9joJtN+gGYME20s9mzePmXuYut/wk3BqF7m34ODMHkSwdz7WpIAQhYW1I/1g9yDeCifhxUZUIVHFq7ijvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0dTkQZS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707941731; x=1739477731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7sJcFnlsbs0MGKDPZKtduFzZYfiU4c1U499OJDfDzo=;
  b=S0dTkQZSG2kJ7Yoy4rWBKYWdyBHHICdGJYoXY97HzjN+0LW43itXRWKj
   qcOS7YZTYJ6xoS/G1IoG/N5xx3k5dFG93prb/naV8NkowA8SfDERaZwlU
   ynrV9VwVk8j0HWvWfoNiyaUaojO33qcY3v4b5lsvDO4tAJMBALuCSGOP9
   olgJdx7W7Kr2v6lFt2q2VoH5jjv6k8Ag7iDjHQ3BRBLITFBpqxZJLnsOC
   Qpg9pqkh/YU2JhGmjLoo2s+z0pgqQr2yYoDij8VxUJ0oVLk7FHUo3E/O8
   JZKpqW5QBDoYYSQK315DaXm9lJoiz55Gpn/EpTr/0UdqD9Hg9aU0RNNrD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1881636"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1881636"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:15:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617834"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617834"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:15:26 -0800
Date: Wed, 14 Feb 2024 22:15:23 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de,
	rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <Zc0fW0ZIzfNOMj2w@black.fi.intel.com>
References: <93c77778-fbdc-4345-be8b-04959d1ce929@linux.intel.com>
 <20240214165800.GA1254628@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214165800.GA1254628@bhelgaas>

On Wed, Feb 14, 2024 at 10:58:00AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 14, 2024 at 08:58:48AM +0200, Jarkko Nikula wrote:
> > On 2/13/24 22:06, Bjorn Helgaas wrote:
> > > > Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > Sounds like this resolves a problem report?  Is there a URL we can
> > > cite?  If not, at least a mention of what the user-visible problem is?
> > > 
> > >  From the c5eb1190074c commit log, it sounds like maybe this allows
> > > devices to be autosuspended when they previously could not be?
> > > 
> > > Possibly this should have "Fixes: c5eb1190074c ("PCI / PM: Allow
> > > runtime PM without callback functions")" since it sounds like it goes
> > > with it?
> > > 
> > I don't think there's known regression but my above commit wasn't complete.
> > Autosuspending works without runtime PM callback as long as the driver has
> > the PM callbacks structure set.
> 
> I didn't suggest there was a regression, but if we mention that Mika
> debugged something, I want to know what the something was.

Considering it's not a bug to begin with, perhaps we can change it to
Suggested-by or Co-developed-by?

Raag

