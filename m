Return-Path: <linux-pci+bounces-20783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C51A29EE9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 03:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B142F18891B3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 02:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7A13A88A;
	Thu,  6 Feb 2025 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nt/IXHmh"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1CDF60;
	Thu,  6 Feb 2025 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809773; cv=none; b=VMiiSTdWxgMdLY1H0eUsLEwMzT4IZna58gySutF2BQd+UayASdTDlwJ42rwo26iByJRMIWBUMW9ZR2sGtdKqT3yJ1cR/fjHrpPu+zjoctP6m9TydygHV2PI5pL0gagjnX/L92FaOAwkqJ8YdieqabyTfphnfe2F19IjGAv1pNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809773; c=relaxed/simple;
	bh=obPsUTG9l7hlhoWWnQW+m78FONuYS+mMfGdELNaNUaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S04f4BnG8N8AT3yZBhrfc7VYmihADWCtqxyxURFqBYhNWYOmX5rsXTozVU8g1rhE5E9WoWSRliDjBrYRyveuZSw+rcYHWDBSGDJsznmIFJdYs6jXuJzxN+srMkF6ZDoAqRVw2Een+uJkErhdGVRr/BFGthiar4sHbWnMVFPl9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nt/IXHmh; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738809766; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=tl7YeugdbGjrRop0ZKiaKnPCf8v2adSmHAleD7lAl1E=;
	b=Nt/IXHmhE4NpZhZn562IsLZsRVMHjxb58869sP0HfnnXUZPcz346vuQ/eBGmA4wpc5HfbSf5eGtADI3dqyNgiPOgdcbQDbhwZCgR08VlW7tfaZVmuSPPOlcWyp9e7cwYMh07aJA7J8NrW/85BjhwLWoRT6U25XtGGiCIUbisQ2A=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOu.C-h_1738809765 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 10:42:45 +0800
Date: Thu, 6 Feb 2025 10:42:43 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	rafael.j.wysocki@intel.com
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
Message-ID: <Z6Qho7k_zj7NcA37@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <b6f97a22-4b24-4ca1-b9e9-38a4b0e69f04@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6f97a22-4b24-4ca1-b9e9-38a4b0e69f04@web.de>

Hi Markus,

Thanks for the review and reminding!

On Wed, Feb 05, 2025 at 06:48:35PM +0100, Markus Elfring wrote:
> …
> > Add the necessary wait to comply with PCIe spec. The waiting logic refers
> > existing pcie_poll_cmd().
> 
> * How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
 
The code went through some refactor, and the related commit should be:

	commit 2bd50dd800b52245294cfceb56be62020cdc7515
	Author: Rafael J. Wysocki <rjw@rjwysocki.net>
	Date:   Sat Aug 21 01:57:39 2010 +0200

	    PCI: PCIe: Disable PCIe port services during port initialization
	    
	    In principle PCIe port services may be enabled by the BIOS, so it's
	    better to disable them during port initialization to avoid spurious
	    events from being generated.
	    
	    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
	    Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
	    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Add Rafael to cc.

> * Will cover letters be usually helpful for such patch series?

Initially I planned to send the 2 patches seprately as they handle
different issues, but as 2/2 will reuse the helper function added
by 1/2, I put them together. 

> * You would probably like to avoid a typo in an email address.

Could you be more specific? I got the mail addresses from get_maintainers.pl.
thanks!

- Feng

