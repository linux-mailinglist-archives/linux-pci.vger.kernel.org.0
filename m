Return-Path: <linux-pci+bounces-15645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819829B6967
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BE31C2138D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165BB215005;
	Wed, 30 Oct 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a59x0CjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413B21443B;
	Wed, 30 Oct 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306519; cv=none; b=gdYGiQheugtyXGWafDuj1qtK6cnq9QGBfCES2UjhCQzXyCZKw95FpGTw6Ha0UK5XI/GWpv1sOUngL2EBCzbsu3qwtp63HGCH/wFDZoOyU0i8Hsk4AFl3bGjQd9tt06wrRMh17GpbGTE+QKNtzq3u2miVpDdCoYiLY28XG7aZsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306519; c=relaxed/simple;
	bh=B3Cv7vdNPxKLmEpv+ochTFb7si+5bh3/r5+EkHPjJJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUl1r0DIPQ8Gu7SjDttETOoibjCDychyBD/iwWT3sechUIE4bbUOPYY1Ebcz1dEEO+RnCTO906hK9qBtpGeqd3vqyDfU6D1kk63nyf/aFdo1UksKOteoWARawIsXIdVQZMvNpOtcLRzJT1sfINlgXd87WOKF7BaE9TSsNsvMPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a59x0CjD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730306517; x=1761842517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3Cv7vdNPxKLmEpv+ochTFb7si+5bh3/r5+EkHPjJJA=;
  b=a59x0CjD0a7I5KH/aNyegLaW6jIbfIYusLlTB6ukdWkTdq/s/cU95OwG
   bWj4CYLVum43gxQ0EW5kIxGH1gJTIhRuBQX0+X1eTJSgyZuo3oWKJsTm+
   E4Bu8tQamG3NDD2lfgeO0LoWGlwclbF7u/M3EixYaqtkyQdGQ71VNl0yf
   RGtu50hB+O8Pqa3GPclJASUN6GEWU22AkK6hmxBRCH1u5uTqcqtUy3eVs
   aOSwgusw0FERfOpPG1paNqJMoePMmu6BllTZz+M0WFxH/VS9d/VSs5OKC
   QMK0QC0VDDSfh8SeqrXs9Df7938CxvW4Fxam2sDvU0ov/KAWsPIN1sruK
   g==;
X-CSE-ConnectionGUID: y4w+HwI7QNWf5NrdsqTIbw==
X-CSE-MsgGUID: pdi/FOSMRtig4VqShafUaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="17663752"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="17663752"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:41:56 -0700
X-CSE-ConnectionGUID: eV3frLhsSNKUTK4lei1d3w==
X-CSE-MsgGUID: iA/9olc6TFSG9S0nYKlt2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="119825117"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 Oct 2024 09:41:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 54C4D1CF; Wed, 30 Oct 2024 18:41:52 +0200 (EET)
Date: Wed, 30 Oct 2024 18:41:52 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20241030164152.GU275077@black.fi.intel.com>
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
 <20241030001524.GA1180712@bhelgaas>
 <ZyIUZfFuUdAbVf25@wunner.de>
 <20241030113108.GT275077@black.fi.intel.com>
 <ZyIwg0nNb_eVzRaz@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyIwg0nNb_eVzRaz@wunner.de>

On Wed, Oct 30, 2024 at 02:11:31PM +0100, Lukas Wunner wrote:
> > IMHO this should be made generic enough that allows device tree based
> > systems to take advantage of this right from the get-go. Note also there
> > is already "external-facing" device tree property that matches the ACPI
> > one defined in Documentation/devicetree/bindings/pci/pci.txt.
> 
> The workaround implemented by Esther's patch (only) becomes necessary
> because OEMs followed Microsoft's spec blindly and put the property
> below the Root Port, instead of the Downstream Port.

Honestly I don't know how else that could be implemented otherwise
without changing that definition (which BTW came from Intel originally).
They did the exact correct thing. The only real problem is that Linux
interprets it in different way.

