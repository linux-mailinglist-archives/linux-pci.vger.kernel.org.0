Return-Path: <linux-pci+bounces-8355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360218FD5E0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 20:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9740B25C1F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD845482C3;
	Wed,  5 Jun 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHqvd14+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139813A3E8;
	Wed,  5 Jun 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612721; cv=none; b=T1SZvFGA0h2DSuRhsdfFDIuzOYA960Bh0pyUNdOYgFvJLTmUBL6pTERIsywfbjX23U9YUl9Onvn06n6aRxa6STBNeco7Q6Bb8K/zIKMFgPhOfryploH+/RCly7x3RJ4d3Rw4vgfBlQWg9KRuIo0ZxaeZ8RbXlc6lIgxXFWgOs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612721; c=relaxed/simple;
	bh=RTIMvfyzwpsoVkZWvb/Q4fpb7BhipiPVExizhw2Lj8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th26N0Hr6RAMO6aUQH52qSEMa8uWAITZSL0mdCJCYggkNfUj0N/sy4I4DUmPhP+b845hPqu2ff7b+j1A0RkDrShJosHSyW56fMjnxZHq5rdpGjM4fZ6IuJ5OnAJDqvczxQ8GE6Rh2cozbYYMYSaJBo5jhuHO2AWzaZZTCrvVeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHqvd14+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717612720; x=1749148720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RTIMvfyzwpsoVkZWvb/Q4fpb7BhipiPVExizhw2Lj8o=;
  b=IHqvd14+TEUzAfbt6TlpiyifGm3bBodFY8MWLasVv3f0ukHu2dBt4Y9A
   slmj4byqKLkcKrohleIJZ7anXz2gb0DJ56RHggEiq7gP42XmPQ0Trk3Kq
   jNsHM3Xov7725478YHrkAMybIryyNQawjfwL7BtUXPSlO62lwlsK+wIr1
   JM2ARI2wQ4Vs7PSEmNSdtVPlIRi6bzs5LI190PrdZf6O/WKIp5m7bSdnq
   pMuXOnOZxlrTq1DntmKZzVhiO58fMQQiU0buIf/5B8R++0ImjWgnt9wXp
   uGfA89K0HsAGov2QK43i6k/3L6aUqY4tekh+MTWDn1pZ8AKV/DNQM5eoP
   Q==;
X-CSE-ConnectionGUID: RPSLwnjBTaahJkiTrrbrzQ==
X-CSE-MsgGUID: pKnXfe9NTl6AlL6qIGmiEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14201520"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14201520"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 11:38:40 -0700
X-CSE-ConnectionGUID: 32+srnolSw+1eNkW+yVJjQ==
X-CSE-MsgGUID: hiugKIPsTLCfzwSkwyLw7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42643909"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.89])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 11:38:39 -0700
Date: Wed, 5 Jun 2024 11:38:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v3 0/2] cxl: Region bandwidth calculation for targets
 with shared upstream link
Message-ID: <ZmCwrk5MGnnHxmKV@aschofie-mobl2>
References: <20240529214357.1193417-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529214357.1193417-1-dave.jiang@intel.com>

On Wed, May 29, 2024 at 02:38:56PM -0700, Dave Jiang wrote:
> This series provides recalculation of the CXL region bandwidth when the targets have
> shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
> as the code trasverses up the tree. An example topology:
> 
>  An example topology from Jonathan:
> 
>                  CFMWS 0
>                    |
>           _________|_________
>          |                   |
>    GP0/HB0/ACPI0017-0  GP1/HB1/ACPI0017-1
>      |          |        |           |
>     RP0        RP1      RP2         RP3
>      |          |        |           |
>    SW 0       SW 1     SW 2        SW 3
>    |   |      |   |    |   |       |   |
>   EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7

Are the ACPI0017 labels a typo?
Expected host bridges to be labelled as ACPI0016's.

That's all, just did a drive-by on the art today.

-- Alison

