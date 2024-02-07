Return-Path: <linux-pci+bounces-3182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C984C14C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 01:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37978B21CA0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88F38F;
	Wed,  7 Feb 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9mnLZdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F48BF1
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265201; cv=none; b=kUPbscQl55KyBCdbUdAvAq2q0ZV3l8z5kKN+6LAi/Kn6KnU0WUQh1yx8d7s4Iox065+sPGerkP2ALfSS+RwtyKMT+VE2yyzJB5kzFIaVZsq/JOl1rM55CbcdIJiCYUCKvMdfjdiMNDmtNCAXbSwrWwf3sqxk0SXlOI+8nCmMrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265201; c=relaxed/simple;
	bh=W/HwIZ2uLHba6IfIXez6859LcjmUw0Nx+fcbPzL0RGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwdkE7y2g744yfoN/vZO06LkmZuQXNpuo+SdAmS1KbcQ4hc4u84QlP4V4PKAX3ENVaLteI6rsgcM98KCgxzQ0deKBwXD1X8/dwKS+CFKGqifgGB+xOxkOoZ0SkIC8zEfXa/1KWLwWt0LxbcSASGcbR09oYmLmeBBs52Ie7Q90t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9mnLZdD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707265200; x=1738801200;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/HwIZ2uLHba6IfIXez6859LcjmUw0Nx+fcbPzL0RGQ=;
  b=U9mnLZdDl0PH8Y9x+Sqqsidko+MIGQvIgNmgTNzbnxu3C+tDFni0MG8V
   ViOOTvgr743DzDeFoohGxqCt3aVpCjnB6eGSfSWjZ9s4WyKPwL6fq6i1g
   HfDMG0K9Uwrtl+yZRvtAWE5vNXRq+crZtZhHMmLKap3QTEeU4InRInhU7
   Z8Qzp9K3B2JIM9fR45po2HAhC0RCQ5FstCuG8IbTcR6f6lAknmdYlbXFR
   RKnan8Cx5pj8lg/63zCOqCRfRNmxrRQ9+CcR4auVelMntruTK1jedjid+
   Wlk3MUFcU7SDQb/P4VCpTqPeWTIjF7CWShQb6CIt207zgsDjz13e3sKoZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="3841703"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="3841703"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 16:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1218105"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 16:19:59 -0800
Message-ID: <a296e02527c6465edcb051d2393e2e6e612a1b0d.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki"
	 <rjw@rjwysocki.net>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 06 Feb 2024 17:27:29 -0700
In-Reply-To: <20240201230004.GA654608@bhelgaas>
References: <20240201230004.GA654608@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-02-01 at 17:00 -0600, Bjorn Helgaas wrote:
> On Thu, Feb 01, 2024 at 11:38:47AM -0700, Nirmal Patel wrote:
> > Gentle ping. 
> 
> Thanks for the ping, I was waiting for you, so we were deadlocked ;)
Hi Bjorn,

Sorry I missed that.

Did you have a chance to look at my response on January 16th to your
questions? I tried to summarize all of the potential problems and
issues with different fixes. Please let me know if it is easier if I
resend the explanation. Thanks.

-nirmal


