Return-Path: <linux-pci+bounces-4786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55EF87A75B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A7F1C22C4C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7D3FB04;
	Wed, 13 Mar 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5KbJ7PR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648623F9D5;
	Wed, 13 Mar 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331231; cv=none; b=HrXwvfzxf6sgRzSkGI2vuO5hSftOH+XPSGglHTD7jeHjh6dnjHSiqHnDAR75lwwTAWVEI3u6Kudnc4LjRmfYrvouoXVufo+jsqBDBaJeJDUs1U9jpp8y081iz9DGxxOWR8Ik+ZY1BBbKjY4sKFswyreC6K2cBbz1iearB/OrTYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331231; c=relaxed/simple;
	bh=oTmsZxsDwI243Hwkzpf2lxroCsnB9x2YChpMLaPvfP4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VwpajFPYW7rB2Yu8lyjDpredr9UdaIRzUgXeDqUYEFxklMceDIHdFyX57oueQDdE9x30nIwWNkGiFtOMuLE3dcHtSIGOwIcZh5r0thWbFuhgMwL6tia4269R33cr7nGnjUcqPsGNqnxDBWmDbj4VPweodJiixSOIpren9bAVwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5KbJ7PR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710331229; x=1741867229;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oTmsZxsDwI243Hwkzpf2lxroCsnB9x2YChpMLaPvfP4=;
  b=b5KbJ7PR4YhP7VjpgLL9jPxlb1F4zSCvuUy4jeoekSs8keTmG/YFWJyt
   czG+HFVLyFr6ZmkhoZ2Oom+G44IyU414S4tiVRZsHg2MvBaGVjoNa+HO6
   jhkaaBSOyz5BMyjRS+7Cbxru+ftMLDBYYiDKMCzLulpnLmdYRpKWdGnY1
   fCR6NE46O7UQNH7QCmnDjVKKdWvSxA10dSMp/KApqB3IhwyeiZXPCxC65
   owX+bA48w9MiDXpnKH4OO4aDdnTuYGBRwpXVOLTsxuH2U2CgB0Optu+20
   pf1Zqia0w6grQyJB/N0znBRHDYknqsgTBiCQnZt4CdJ+F1R25xCIdkHVS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4954283"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="4954283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 05:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11782605"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.7])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 05:00:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 Mar 2024 14:00:21 +0200 (EET)
To: Simon Guinot <simon.guinot@seagate.com>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: "Maciej W . Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: fix link retrain status in
 pcie_wait_for_link_delay()
In-Reply-To: <20240313094938.484113-1-simon.guinot@seagate.com>
Message-ID: <53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com>
References: <20240313094938.484113-1-simon.guinot@seagate.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2024, Simon Guinot wrote:

> The current code in pcie_wait_for_link_delay() handles the value
> returned by pcie_failed_link_retrain() as an integer, expecting 0
> when the link has been successfully retrained. The issue is that
> pcie_failed_link_retrain() returns a boolean: "true" if the link
> has been successfully retrained and "false" otherwise. This leads
> pcie_wait_for_link_delay() to return an incorrect "active link"
> status when pcie_failed_link_retrain() is called.
> 
> This patch fixes the check of the value returned by
> pcie_failed_link_retrain() in pcie_wait_for_link_delay().
> 
> Note that this bug induces abnormal timeout delays when a PCI device
> is unplugged (around 60 seconds per bridge / secondary bus removed).
> 
> Cc: stable@vger.kernel.org
> Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
> Signed-off-by: Simon Guinot <simon.guinot@seagate.com>

Hi Simon,

Thanks for your patch. There's, however, already a better series to fix 
this and other related issues. Bjorn just hasn't gotten into applying them 
yet:

https://patchwork.kernel.org/project/linux-pci/list/?series=824858

(I proposed a patch very similar to yours month ago, but Maciej came up 
a better way to fix all the issues.)

--
 i.

> ---
>  drivers/pci/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ccee56615f78..7ec91b4c5d03 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5101,9 +5101,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>  		msleep(20);
>  	rc = pcie_wait_for_link_status(pdev, false, active);
>  	if (active) {
> -		if (rc)
> -			rc = pcie_failed_link_retrain(pdev);
> -		if (rc)
> +		if (rc && !pcie_failed_link_retrain(pdev))
>  			return false;
>  
>  		msleep(delay);
> 

-- 
 i.


